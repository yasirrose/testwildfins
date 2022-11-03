<style>
    .pie-legend li span {
        width: 1em;
        height: 1em;
        display: inline-block;
        margin-right: 5px;
    }
    .pie-legend {
        list-style: none;
    }
    .table {
        display: block;
        overflow-x: auto;
    }

    .table >tbody > tr > td{
        width:300px !important;}
    .pagination-inverse{
        margin-bottom:20px !important;}
    table.getReports tr td, table.getReports tr th {
        white-space: nowrap;
        vertical-align: middle;
    }
</style>
<cfparam name="FORM.Arbalester" default="1">
<cfparam name="FORM.DEFAULT_DATERANGE" default="">
<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page = 10>
<cfset today = now()>
<cfset arb = "">
<cfset selectedDate = "">
<cfif isdefined('FORM.Arbalester')>
    <cfoutput>hega a</cfoutput>
  <cfset arb = FORM.Arbalester>
</cfif>
<cfif isdefined("form.DEFAULT_DATERANGE")>
    <cfset selectedDate = form.DEFAULT_DATERANGE >
</cfif>
<!------- Get  all Arbalesters-------->

<cfset qgetResearchTeamMembers = Application.StaticData.getResearchTeamMembers()>
<cfset getArbalester = Application.Sighting.getArbalesters()>
<!----- get data on page load in tabuler view------>
<cfset getBiopsyData = Application.Reporting.getBiopsyData(FORM.Arbalester,form.DEFAULT_DATERANGE)>

<cfif isdefined('form.biopsyExcel')>
    <cfset getExcelReport = Application.Reporting.getBiopsyExcel()>
    <cfspreadsheet
            action="write"
            filename="#Application.DirectoryRoot#Reports\Biopsy\Biopsy-Report.xls"
            overwrite="true"
            query="getExcelReport">
    <cflocation url="/Reports/Biopsy/Biopsy-Report.xls" addtoken="no">
</cfif>



<cfset ReportStartyear = 1990>
<cfset ReportEndyear = year(now())>
<cfset from = ReportEndyear-1>
<cfparam name="FORM.fromYear" default="#from#">
<cfparam name="FORM.toYear" default="#year(now())#">

<!---Hits vs Misses--->
<cfif  FORM.toYear  LT  FORM.fromYear >
    <cfset msg = 'Start Year must be less and equal to End Year'>
<cfelse>
    <cfif not isdefined('msg') >
        <cfset summary2 = [] >
        <cfset Hit = ArrayNew(1)>
        <cfset Miss = ArrayNew(1) >
        <cfif not isdefined('msg') >
            <cfset summary2 = [] >
            <cfset Hit_count =  0>
            <cfset Miss_count =  0>
            <cfset getHits = Application.Reporting.getHitsRate(FORM.Arbalester,form.DEFAULT_DATERANGE)>
            <cfif getHits.recordcount NEQ 0 >
                <cfset Hit_count = getHits.recordcount>
            </cfif>
            <cfset getMiss = Application.Reporting.getMissRate(FORM.Arbalester,form.DEFAULT_DATERANGE)>
            <cfif getMiss.recordcount NEQ 0 >
                <cfset Miss_count = getMiss.recordcount>
            </cfif>
            <cfset summary2 = [Hit_count,Miss_count]>
        <cfelse>
            <cfset summary2 = [0,0] >
        </cfif>
    </cfif>
</cfif>

<cfset getTotal = Application.Reporting.getTotalHitMiss(FORM.Arbalester,form.DEFAULT_DATERANGE)>

<cfset Total = getTotal.recordcount>
<cfif Total gt 0>
    <cfset Hit = (summary2[1]/Total)*100>
    <cfset Miss = (summary2[2]/Total)*100>
    <cfelse>
    <cfset Hit =0>
    <cfset Miss = 0>
</cfif>
<!---End Hits vs Misses--->

<!---Hit Descriptor------->
<cfset Discriptors = [] >
<cfset Total_Discrpt =  0>
<cfset Hit_Discrpt =  0>
<cfset summary3 = [] >


<cfset Good = 0>
<cfset Hit_water = 0>
<cfset Angled = 0>
<cfset DriverJuke = 0>


<cfset totalHitDiscriptor = Application.Reporting.gettotalHitDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset totalHit = totalHitDiscriptor.total>
<cfset getGoodDiscriptor = Application.Reporting.getGoodDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset Good = getGoodDiscriptor.total>
<cfif totalHit gt 0>
    <cfset GoodPercentage = (Good/totalHit)*100>
    <cfelse>
    <cfset GoodPercentage = 0 >
</cfif>

<cfset getHit_waterDiscriptor = Application.Reporting.getHit_waterDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset Hit_water = getHit_waterDiscriptor.total>
<cfif totalHit gt 0>
    <cfset Hit_waterPercentage = (Hit_water/totalHit)*100>
    <cfelse>
    <cfset Hit_waterPercentage =0>
</cfif>
<cfset getAngledDiscriptor = Application.Reporting.getAngledDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset Angled = getAngledDiscriptor.total>
<cfif totalHit gt 0>
    <cfset AngledPercentage = (Angled/totalHit)*100>
    <cfelse>
    <cfset AngledPercentage =0>
</cfif>
<cfset getDriverJukeDiscriptor = Application.Reporting.getDriverJukeDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset DriverJuke = getDriverJukeDiscriptor.total>
<cfif totalHit gt 0>
    <cfset DriverJukePercentage = (DriverJuke/totalHit)*100>
    <cfelse>
    <cfset DriverJukePercentage = 0>
</cfif>


<!---End Hit Descriptor--->

<cfset GoodHeight = 0>
<cfset Low = 0>
<cfset High = 0>
<cfset wind_effected = 0>
<cfset totalMissDiscriptor = Application.Reporting.gettotalMissDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset totalMiss = totalMissDiscriptor.total>
<cfset getGoodHeightDiscriptor = Application.Reporting.getGoodHeightDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset GoodHeight = getGoodHeightDiscriptor.total>
<cfif totalMiss gt 0>
    <cfset GoodHeightPercentage = (GoodHeight/totalMiss)*100>
    <cfelse>
    <cfset GoodHeightPercentage = 0>
</cfif>

<cfset getLowDiscriptor = Application.Reporting.getLowDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset low = getLowDiscriptor.total>
<cfif totalMiss gt 0>
    <cfset lowPercentage = (low/totalMiss)*100>
    <cfelse>
    <cfset lowpercentage =0>
</cfif>
<cfset getHighDiscriptor = Application.Reporting.getHighDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset High = getHighDiscriptor.total>
<cfif totalMiss gt 0>
    <cfset HighPercentage = (High/totalMiss)*100>
<cfelse>
    <cfset HighPercentage = 0>
</cfif>
<cfset getwind_effectedDiscriptor = Application.Reporting.getwind_effectedDiscriptor(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset wind_effected = getwind_effectedDiscriptor.total>
<cfif totalMiss gt 0>
    <cfset wind_effectedPercentage = (wind_effected/totalMiss)*100>
    <cfelse>
    <cfset wind_effectedPercentage =0>

</cfif>

<!---Start Hit Location--->

<cfset Location = [] >
<cfset Total_Location =  0>
<cfset Hit_Location =  0>

<!---<cfset hitLocations = Application.Reporting.hitLocationTotal()>
<cfif hitLocations.recordcount NEQ 0>
	<cfset Total_Location = hitLocations.total>
</cfif>

<cfset hitLocationTotal = Application.Reporting.hitLocation()>
<cfif hitLocationTotal.recordcount NEQ 0>
	<cfset Hit_Location = hitLocationTotal.total>
</cfif>--->


<cfset hitLocation = Application.Reporting.hitLocationName(FORM.Arbalester,form.DEFAULT_DATERANGE)>
<cfset location = arraynew(1)>
<cfset locationhit = arraynew(1)>
<cfset sum = 0>
<cfloop from="1" to="#hitLocation.recordcount#" index="i">
    <cfset location[i] = #hitLocation.Name[i]#>
    <cfset totalVal = Val(hitLocation.total[i])>
    <cfif Total gt 0 >
    <cfset locationhitper = (totalVal/Total)*100>
    <cfset locationhit[i] = #locationhitper#>
    </cfif>
</cfloop>
<script>
    <cfoutput>
    var #toScript(hitLocation.recordcount, "totalvar")#
        var #toScript(location, "LocationName")#;
    var #toScript(locationhit, "locationHit")#;
    </cfoutput>
</script>


<cfset i = 1>
<cfloop query="hitLocation">

    <cfif i eq 1>
        <cfset LocationHead = hitLocation.Name>
        <cfset hitHead = hitLocation.total>
    </cfif>


    <cfif i eq 2>
        <cfset LocationPac = hitLocation.Name>
        <cfset hitother = hitLocation.total>
    </cfif>
    <cfset i = i+1>
</cfloop>



<cfset totalhitLocation = hitother + hitHead>
<cfif totalhitLocation gt 0>
<cfset hitHeadLocation = hitHead/totalhitLocation * 100>
<cfset hitOtherLocation = hitother/totalhitLocation * 100>

<cfelse>
  <cfset  hitHeadLocation = 0>
    <cfset hitOtherLocation = 0>
</cfif>
<cfset HeadLocations = hitHeadLocation>
<cfset	OtherLocations = hitOtherLocation >


<!---End Hit Location--->

<script type="text/javascript">

    <cfoutput>
    var #toScript(Hit, "Hit")#;
    var #toScript(Miss, "Miss")#;
    var #toScript(GoodPercentage, "GoodPercentage")#;
    var #toScript(Hit_waterPercentage, "Hit_waterPercentage")#;
    var #toScript(AngledPercentage, "AngledPercentage")#;
    var #toScript(DriverJukePercentage, "DriverJukePercentage")#;
    var #toScript(GoodHeightPercentage, "GoodHeightPercentage")#;
    var #toScript(lowPercentage, "lowPercentage")#;
    var #toScript(HighPercentage, "HighPercentage")#;
    var #toScript(wind_effectedPercentage, "wind_effectedPercentage")#;
    var #toScript(HeadLocations, "HeadLocations")#;
    var #toScript(OtherLocations, "OtherLocations")#;

    function formCall() {
    $("##frm1").submit();
    }




    </cfoutput>

</script>


<cfoutput>
    <!-- begin ##content -->
<div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">Reporting</a></li>
        <li><a href="javascript:;">Biopsy Report</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Biopsy Report </h1>
    <!-- end page-header -->

    <!-- begin row -->
<div class="row">


    <!-- begin row col-6-->
<div class="row col-lg-12">
    <!-- begin panel -->
<div class="panel panel-inverse">
    <div class="panel-heading">
        <div class="panel-heading-btn">
            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
        </div>
        <h4 class="panel-title">Arbalester Report </h4>
    </div>

<div class="panel-body">
<form action="" method="post" id="frm1">
    <!-- start col-md-6 -->
<div class="col-md-6">
<div class="panel-option m-2">
    <h5>Date Range</h5>
<div id="Date-range" class="input-group">

        <input type="text" <cfif selectedDate eq ""> value="#DateFormat(CreateDate(year(today),1, 1), "mmmm d, yyyy")# - #DateFormat(CreateDate(year(today),month(today), 30), "mmmm d, yyyy")#"<cfelse> value="#selectedDate#"</cfif> class="form-control" name="default_daterange">
    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
</div>
</div>
</div>
    <!-- end col-md-6 -->

    <!-- start col-md-6 -->
<div class="col-md-6 ">
<div class="panel-option m-2">
    <h5>Arbalester</h5>
<div class="form-group">
<select class="search-box form-control" name="Arbalester" onchange="formCall()" >
<!---<option value="">Select Arbalester</option>--->
    <cfloop query="qgetResearchTeamMembers">
            <option value="#qgetResearchTeamMembers.RT_ID#" <cfif arb eq qgetResearchTeamMembers.RT_ID> selected </cfif> >#qgetResearchTeamMembers.RT_MemberName#</option>
    </cfloop>
    </select>
    </div>
    </div>
    </div>
        <!-- end col-md-6 -->


        <div class="col-md-3 pull-right m-t-15">
            <input type="submit" value="Download as Excel" name="biopsyExcel" class="btn btn-sucess m-t-25" />
        </div>

    </div>

    </div>
        <!-- end panel -->

    </div>
        <!-- end row col-6 -->
        </form>
    <div class="panel pagination-inverse m-b-0 clearfix BiopsyReports">
    <table data-order='[[1,"asc"]]' class="table table-bordered table-hover getReports">
    <thead>
    <tr class="inverse">
        <th>Date</th>
        <th>Stock</th>
        <th>Takes</th>
        <th>Segment</th>
        <th>Vessel</th>
        <th>Device</th>
    <th>S##</th>
<th>Shot##</th>
    <th>Time</th>
    <th>Distance</th>
    <th>Arbalester</th>
    <th>Hit(1)/Miss(0)</th>
    <th nowrap>Miss Height</th>
    <th nowrap>Miss Width</th>
    <th nowrap>Miss Distance</th>
    <th nowrap>Hit Descriptor</th>
    <th>HitLocation</th>
    <th>Location</th>
    <th>Lat-X</th>
    <th>Long-Y</th>
    <th>Code</th>
    <th>Sex</th>
    <th>Sample</th>
    <th nowrap>sample Size</th>
    <th nowrap>Sampleing Head</th>
    <th nowrap>Full Sample</th>
    <th nowrap>Comments</th>
    <th nowrap>Blubber-Teflon</th>
    <th>Blubber-cryo1</th>
    <th>Blubber-cryo2</th>
    <th>Skin-DMSO</th>
    <th nowrap>Skin-cryo2</th>
    <th nowrap>Skin-RNAlater</th>
    <th nowrap>Target Level</th>
    <th nowrap>Target Response Behavior 1</th>
    <th nowrap>Target Response Behavior 2</th>
    <th nowrap>Target Response Behavior 3</th>
    <th nowrap>Target Pre- Behavior 1</th>
    <th nowrap>Target Pre- Behavior 2</th>
    <th nowrap>Target Pre- Behavior 3</th>
    <th nowrap>Target Post- Behavior 1</th>
    <th nowrap>Target Post- Behavior 2</th>
    <th nowrap>Target Post- Behavior 3</th>
    <th nowrap>Group Response Behavior</th>
    <th nowrap>Group Size</th>
    <th nowrap>Group Pre- Behavior 1</th>
    <th nowrap>Group Pre- Behavior 2</th>
    <th nowrap>Group Pre- Behavior 3</th>
    <th nowrap>Group Post- Behavior 1</th>
    <th nowrap>Group Post- Behavior 2</th>
    <th nowrap>Group Post- Behavior 3</th>
    <th nowrap>Disposition-Archive</th>
</tr>
</thead>
<tbody>
</cfoutput>
<cfif getBiopsyData.recordcount GT 0 >
    <cfset count = 1>
    <cfoutput query="getBiopsyData" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">


        <tr class="gradeU">
        <td id="group_name">
        <cfset newDate = DateFormat(getBiopsyData.Date, "yyyy-mm-dd")>
        <a href="javascript:void(0)" data-toggle="collapse" class="dataToggle" id="#count#">#newDate#</a>
    </td>
        <cfif getBiopsyData.Stock neq ''>
                <td id="group_name">#getBiopsyData.Stock#</td>
        <cfelse>
                <td id="group_name">N/A</td>
        </cfif>

        <cfif getBiopsyData.Takes neq "">
                <td id="group_status">#getBiopsyData.Takes#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.ZSEGMENT neq "">
                <td id="group_status">#getBiopsyData.ZSEGMENT#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.Vessel neq "">
                <td id="group_status">#getBiopsyData.Vessel#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.Device neq "">
                <td id="group_status">#getBiopsyData.Device#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.ID neq "">
                <td id="group_status">#getBiopsyData.ID#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.ShotNumber neq "">
                <td id="group_status">#getBiopsyData.ShotNumber#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.time neq "">
            <cfset newTime = TimeFormat(getBiopsyData.time, "hh:mm:ss")>
                <td id="group_status">#newTime#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.Distance neq "">
                <td id="group_status">#getBiopsyData.Distance#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.RT_MemberName neq "">
                <td id="group_status">#getBiopsyData.RT_MemberName#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.Outcome neq "">
                <td id="group_status">#getBiopsyData.Outcome#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.MissHeight neq "">
                <td id="group_status">#getBiopsyData.MissHeight#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.MissWidth neq "">
                <td id="group_status">#getBiopsyData.MissWidth#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.MissDistance neq "">
                <td id="group_status">#getBiopsyData.MissDistance#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.HitDescriptors neq "">
                <td id="group_status">#getBiopsyData.HitDescriptors#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.HitLocation neq "">
                <td id="group_status">#getBiopsyData.HitLocation#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.Location neq "">
                <td id="group_status">#getBiopsyData.Location#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.Easting_X neq "">
                <td id="group_status">#getBiopsyData.Easting_X#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.Northing_Y neq "">
                <td id="group_status">#getBiopsyData.Northing_Y#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.Code neq "">
                <td id="group_status">#getBiopsyData.Code#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.Sex neq "">
                <td id="group_status">#getBiopsyData.Sex#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.Sample neq "">
                <td id="group_status">#getBiopsyData.Sample#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.sampleSize neq "">
                <td id="group_status">#getBiopsyData.sampleSize#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.Samplehead eq "1">
                <td id="group_status">M8</td>
            <cfelseif getBiopsyData.Samplehead eq "2">
                <td id="group_status">M11</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.SampleCollected eq "1">
                <td id="group_status">Full</td>
            <cfelseif getBiopsyData.SampleCollected eq "2">
                <td id="group_status">Partial</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.Description neq "">
                <td id="group_status">#getBiopsyData.Description#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.BlubberTeflonVial neq "">
                <td id="group_status">#getBiopsyData.BlubberTeflonVial#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.BlubberCryovialRed neq "">
                <td id="group_status">#getBiopsyData.BlubberCryovialRed#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.BlubberCryovialBlue neq "">
                <td id="group_status">#getBiopsyData.BlubberCryovialBlue#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.SkinDMSO neq "">
                <td id="group_status">#getBiopsyData.SkinDMSO#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.SkinRNAlater neq "">
                <td id="group_status">#getBiopsyData.SkinRNAlater#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        <cfif getBiopsyData.SkinDCryovial neq "">
                <td id="group_status">#getBiopsyData.SkinDCryovial#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetLevel neq "">
                <td id="group_status">#getBiopsyData.TargetLevel#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetResponseBehavior1 neq "">
                <td id="group_status">#getBiopsyData.TargetResponseBehavior1#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetResponseBehavior2 neq "">
                <td id="group_status">#getBiopsyData.TargetResponseBehavior2#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetResponseBehavior3 neq "">
                <td id="group_status">#getBiopsyData.TargetResponseBehavior3#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.TargetPre_Behavior1 neq "">
                <td id="group_status">#getBiopsyData.TargetPre_Behavior1#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetPre_Behavior2 neq "">
                <td id="group_status">#getBiopsyData.TargetPre_Behavior2#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetPre_Behavior3 neq "">
                <td id="group_status">#getBiopsyData.TargetPre_Behavior3#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetPost_Behavior1 neq "">
                <td id="group_status">#getBiopsyData.TargetPost_Behavior1#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetPost_Behavior2 neq "">
                <td id="group_status">#getBiopsyData.TargetPost_Behavior2#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.TargetPost_Behavior3 neq "">
                <td id="group_status">#getBiopsyData.TargetPost_Behavior3#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.GroupResponseBehavior neq "">
                <td id="group_status">#getBiopsyData.GroupResponseBehavior#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.GroupSize neq "">
                <td id="group_status">#getBiopsyData.GroupSize#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.GroupPre_Behavior1 neq "">
                <td id="group_status">#getBiopsyData.GroupPre_Behavior1#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.GroupPre_Behavior2 neq "">
                <td id="group_status">#getBiopsyData.GroupPre_Behavior2#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.GroupPre_Behavior3 neq "">
                <td id="group_status">#getBiopsyData.GroupPre_Behavior3#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>


        <cfif getBiopsyData.GroupPost_Behavior1 neq "">
                <td id="group_status">#getBiopsyData.GroupPost_Behavior1#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.GroupPost_Behavior2 neq "">
                <td id="group_status">#getBiopsyData.GroupPost_Behavior2#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.GroupPost_Behavior3 neq "">
                <td id="group_status">#getBiopsyData.GroupPost_Behavior3#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>
        <cfif getBiopsyData.notes neq "">
                <td id="group_status">#getBiopsyData.notes#</td>
        <cfelse>
                <td id="group_status">N/A</td>
        </cfif>

        </tr>

        <cfset count++>

    </cfoutput>
</cfif>
</tbody>
</table>
</div>
<cfoutput>
        <div class="row">
            <!-- begin  col-6-->
            <div class="col-lg-6">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">Hits vs Misses</h4>
                    </div>

                    <div class="panel-body">

                        <div>
                            <canvas id="pie-chart"></canvas>
                            <div id="legend"></div>

                        </div>

                    </div>
                </div>
                <!-- end panel -->
            </div>
            <!-- end  col-6 -->

            <!-- begin  col-6-->
            <div class="col-lg-6">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">Hits Location</h4>
                    </div>
                    <div class="panel-body">
                        <div>
                            <canvas id="pie-chart-loc"></canvas>
                            <div id="legend-loc"></div>

                        </div>

                    </div>
                </div>
                <!-- end panel -->
            </div>

            <!-- end  col-6 -->
        </div>
        <div class="row">
            <!-- begin  col-6-->
            <div class="col-lg-6">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">Miss Descriptors</h4>
                    </div>
                    <div class="panel-body">
                        <div>
                            <canvas id="pie-chart-missdes"></canvas>
                            <div id="legend-missdesc"></div>

                        </div>

                    </div>
                </div>
                <!-- end panel -->
            </div>
            <!-- end  col-6 -->
            <!-- begin  col-6-->
            <div class="col-lg-6">
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">Hits Descriptors</h4>
                    </div>
                    <div class="panel-body">
                        <div>
                            <canvas id="pie-chart-des"></canvas>
                            <div id="legend-des"></div>

                        </div>

                    </div>
                </div>
                <!-- end panel -->
            </div>
            <!-- end  col-6 -->
        </div>

    </div>
        <!-- end row -->

            <!-- begin ##footer -->
<div id="footer" class="footer">
    <span class="pull-right">
                    <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top">
                        <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
                    </a>
                </span>
    &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
</div>
        <!-- end ##footer -->
</div>
        <!-- end ##content -->
</cfoutput>