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
.datacontainer{
    height: 350px; 
    overflow:scroll; 
}

.sighting-detail {
     cursor:pointer;
     color:blue;
     text-decoration:underline;
}

.sighting-detail:hover {
     text-decoration:none;
     text-shadow: 1px 1px 1px #555;
}
canvas#pie-chart {
    height: 200px;
}
.inline-text {
    text-align: left;
    display: inline-block;
    margin: 12px 0 0;
}
canvas#bar-chart-by-zones, canvas#bar-chart, canvas#bar-chart-by-segments {
    width: 100% !important;
}
</style>
<cfparam name="startHereIndex1" default="1">
<cfparam name="startHereIndex2" default="1">
<cfparam name="startHereIndex3" default="1">
<cfparam name="startHereIndex4" default="1">
<cfset Application.record_per_page = 10>
<cfset ReportStartyear = 1990>
<cfset ReportEndyear = year(now())>
<cfset from = ReportEndyear-1>
<cfparam name="FORM.fromYear" default="#from#">
<cfparam name="FORM.toYear" default="#year(now())#">

<!------- Annual Census--------->
<!---When page loads--->
<cfif  FORM.toYear  LT  FORM.fromYear  >
  <cfset msg = 'Start Year must be less and equal to End Year'>
<cfelse>
  
  <cfset qgetAnnualCensus                    = Application.Reporting.getAnnualCensusFirstYearReport(argumentCollection="#Form#")>
  <cfset qgetAnnualCensusSecondYear          = Application.Reporting.getAnnualCensusSecondYearReport(argumentCollection="#Form#")>
  <cfset qgetAnnualCensusUnseen   		     = Application.Reporting.getAnnualCensusUnseenReport(argumentCollection="#Form#")>
  <cfset qgetAnnualCensusNewDolphins  		 = Application.Reporting.getAnnualCensusNewDolphinsReport(argumentCollection="#Form#")>
  
  <cfset qgetAnnualCensusPieChart  		     = Application.Reporting.getAnnualCensusReportGraph(argumentCollection="#Form#")>
  <cfset qgetAnnualCensusBarGraph  		     = Application.Reporting.getAnnualCensusReportByBodyOFWater(argumentCollection="#Form#")>
  <cfset qgetAnnualCensusBarGraphBySegment   = Application.Reporting.getAnnualCensusReportBySegment(argumentCollection="#Form#")>
  <cfset qgetAnnualCensusBarGraphByZone      = Application.Reporting.getAnnualCensusReportByZone(argumentCollection="#Form#")> 
  <cfif not isdefined('msg') >
  		<cfset all_Male            = 0>
        <cfset all_Female          = 0>
        <cfset all_Unknown         = 0>
        <cfset calves_sex_Male     = 0>
        <cfset calves_sex_Female   = 0>
        <cfset calves_sex_Unknown  = 0>
        <cfset juvenile_sex_Male   = 0>
        <cfset juvenile_sex_Female = 0>
        <cfset juvenile_sex_Unknown= 0>
        <cfset adult_sex_Male      = 0>
        <cfset adult_sex_Female    = 0>
        <cfset adult_sex_Unknown   = 0>
        <cfset unknown_sex_Male    = 0>
        <cfset unknown_sex_Female  = 0>
        <cfset unknown_sex_Unknown = 0>
		<cfset Calf                = 0>
        <cfset Juvenile_male       = 0>
        <cfset Juvenile_female     = 0>
        <cfset Adult_male          = 0>
        <cfset Adult_female        = 0>
        <cfset Unknown_sex         = 0>
        <cfset ArrCalf             = ArrayNew(1)>
        <cfset ArrJuvenile_male    = ArrayNew(1)>
        <cfset ArrJuvenile_female  = ArrayNew(1)>
        <cfset ArrAdult_male       = ArrayNew(1)>
        <cfset ArrAdult_female     = ArrayNew(1)>
        <cfset ArrUnknown_sex      = ArrayNew(1)>
        
        <cfset dolphinsCode        = ArrayNew(1)>
        <cfset dolphinsSeen        = ArrayNew(1)>
        <cfset dolphinsCodeBySegment= ArrayNew(1)>
        <cfset dolphinsSeenBySegment= ArrayNew(1)>
        <cfset dolphinsCodeByZone = ["ALT","BR","IR","ML","SLR"]>
        <cfset dolphinsSeenByZone = [0,0,0,0,0]>
        <cfset categories         = []>
        <cfset all_sex_categories = [] >
        <cfset calves_sex_categories = [] >
        <cfset juvenile_sex_categories = [] >
        <cfset adult_sex_categories = [] >
          
        <cfloop query="qgetAnnualCensusPieChart">
           <!---<cfset arrayappend(dolphinsCode,Code)>
           <cfset arrayappend(dolphinsSeen,SEEN_TIMES)>--->
           
           <cfif YEAROFBIRTH NEQ '' AND IsNumeric(YEAROFBIRTH)>
              <cfif IsDead	EQ 0 OR DeathYear EQ ''>
                  <cfset age = #FORM.fromYear# - YEAROFBIRTH >
              <cfelse>
                  <cfif IsNumeric(DeathYear)>
                    <cfset age = DeathYear - YEAROFBIRTH >
                  <cfelse>
                    <cfset age = '' >
                  </cfif>
              </cfif>
           <cfelse>
              <cfset age = '' >
           </cfif>  
           <cfif age NEQ ''>
                <cfif age LTE 4>
                    <cfset Calf++>
                    <cfif SEX NEQ ''>
						<cfif SEX EQ 'M'>
                            <cfset calves_sex_Male++>
                        <cfelseif SEX EQ 'F'>
                            <cfset calves_sex_Female++>
                        <cfelseif SEX EQ 'U'>
                            <cfset calves_sex_Unknown++>   
                        </cfif>
                   </cfif>
                <cfelseif age GT 4 and age LT 10>
                	<cfif SEX NEQ ''>
						<cfif age GTE 5 AND age LTE 9 AND SEX EQ 'M'>
                            <cfset juvenile_sex_Male++>
                        <cfelseif age GTE 5 AND age LTE 6 AND SEX EQ 'F'>
                            <cfset juvenile_sex_Female++>
                        <cfelseif SEX EQ 'U'>
                            <cfset juvenile_sex_Unknown++>   
                        </cfif>
                   </cfif>
                    <!---<cfset tr = StructNew() >
                    <cfset tr['ID']          = Dolphin_ID >
                    <cfset tr['Name']        = Name >
                    <cfset tr['Code']        = Code >
                    <cfset tr['Sex']         = Sex >
                    <cfset tr['Sighting_ID'] = Sighting_ID >
                    <cfset tr['pro_id']      = pro_id >
                    <cfset ArrayAppend(ArrCalf,tr)>--->
                </cfif>
                <cfif age GTE 10 and SEX EQ 'M'>
                	<cfset adult_sex_Male++>
                </cfif>
                <cfif age GTE 7 and SEX EQ 'F'>
                	<cfset adult_sex_Female++>
                </cfif>
                <cfif age GTE 10 and SEX EQ 'U'>
                	<cfset adult_sex_Unknown++>
                </cfif>    
                <cfif age GTE 5 and age LTE 9>
                    <cfset Juvenile_male++>
                    <!---<cfset tr = StructNew() >
                    <cfset tr['ID']          = Dolphin_ID >
                    <cfset tr['Name']        = Name >
                    <cfset tr['Code']        = Code >
                    <cfset tr['Sex']         = Sex >
                    <cfset tr['Sighting_ID'] = Sighting_ID >
                    <cfset tr['pro_id']      = pro_id >
                    <cfset ArrayAppend(ArrJuvenile_male,tr)>--->
                </cfif>
                <cfif age GTE 5 and age LTE 6>
                    <cfset Juvenile_female++>
                    <!---<cfset tr = StructNew() >
                    <cfset tr['ID']          = Dolphin_ID >
                    <cfset tr['Name']        = Name >
                    <cfset tr['Code']        = Code >
                    <cfset tr['Sex']         = Sex >
                    <cfset tr['Sighting_ID'] = Sighting_ID >
                    <cfset tr['pro_id']      = pro_id >
                    <cfset ArrayAppend(ArrJuvenile_female,tr)>--->
                </cfif>    
                <cfif age GT 10>
                    <cfset Adult_male++>
                    <!---<cfset tr = StructNew() >
                    <cfset tr['ID']          = Dolphin_ID >
                    <cfset tr['Name']        = Name >
                    <cfset tr['Code']        = Code >
                    <cfset tr['Sex']         = Sex >
                    <cfset tr['Sighting_ID'] = Sighting_ID >
                    <cfset tr['pro_id']      = pro_id >
                    <cfset ArrayAppend(ArrAdult_male,tr)>--->
                </cfif>
                <cfif age GT 7>
                    <cfset Adult_female++>
                    <!---<cfset tr = StructNew() >
                    <cfset tr['ID']          = Dolphin_ID >
                    <cfset tr['Name']        = Name >
                    <cfset tr['Code']        = Code >
                    <cfset tr['Sex']         = Sex >
                    <cfset tr['Sighting_ID'] = Sighting_ID >
                    <cfset tr['pro_id']      = pro_id >
                    <cfset ArrayAppend(ArrAdult_female,tr)>--->
                </cfif>
                <cfif age GTE 10>
                    <cfset Unknown_sex++>
                    <!---<cfset tr = StructNew() >
                    <cfset tr['ID']          = Dolphin_ID >
                    <cfset tr['Name']        = Name >
                    <cfset tr['Code']        = Code >
                    <cfset tr['Sex']         = Sex >
                    <cfset tr['Sighting_ID'] = Sighting_ID >
                    <cfset tr['pro_id']      = pro_id >
                    <cfset ArrayAppend(ArrUnknown_sex,tr)>--->
                </cfif>
           <cfelse>
           		<cfif SEX NEQ ''>
					<cfif SEX EQ 'M'>
                        <cfset unknown_sex_Male++>
                    <cfelseif SEX EQ 'F'>
                        <cfset unknown_sex_Female++>
                    <cfelseif SEX EQ 'U'>
                        <cfset unknown_sex_Unknown++>
                    </cfif>
           		</cfif>
           </cfif>
           
		   <cfif SEX NEQ ''>
           		<cfif SEX EQ 'M'>
                	<cfset all_Male++>
           		<cfelseif SEX EQ 'F'>
                	<cfset all_Female++>
                <cfelseif SEX EQ 'U'>
                	<cfset all_Unknown++>
                </cfif>
           </cfif>
                 
        </cfloop>
        <cfset all_sex_categories = [all_Male,all_Female,all_Unknown] >
        <cfset calves_sex_categories = [calves_sex_Male,calves_sex_Female,calves_sex_Unknown] >
        <cfset juvenile_sex_categories = [juvenile_sex_Male,juvenile_sex_Female,juvenile_sex_Unknown] >
        <cfset adult_sex_categories = [adult_sex_Male,adult_sex_Female,adult_sex_Unknown] >
        <cfset unknown_sex_categories = [unknown_sex_Male,unknown_sex_Female,unknown_sex_Unknown] >
        <cfset categories = [Calf,Juvenile_male,Juvenile_female,Adult_male,Adult_female,Unknown_sex]>
        <cfloop query="qgetAnnualCensusBarGraph">
        	<cfset arrayappend(dolphinsCode,SurveyArea)>
            <cfset arrayappend(dolphinsSeen,SEEN_TIMES)>
        </cfloop>
        <cfloop query="qgetAnnualCensusBarGraphBySegment">
        	<cfset arrayappend(dolphinsCodeBySegment,ZSEGMENT)>
            <cfset arrayappend(dolphinsSeenBySegment,SEEN_TIMES)>
        </cfloop>
		<cfloop query="qgetAnnualCensusBarGraphByZone">
          		<cfif ZONE contains "ALT">
                	<cfset dolphinsSeenByZone[1] += SEEN_TIMES >
                </cfif>
                <cfif ZONE contains "BR">
                	<cfset dolphinsSeenByZone[2] += SEEN_TIMES >
                </cfif>
				<cfif ZONE contains "IR">
                	<cfset dolphinsSeenByZone[3] += SEEN_TIMES >
                </cfif>
				<cfif ZONE contains "ML">
                	<cfset dolphinsSeenByZone[4] += SEEN_TIMES >
                </cfif>
				<cfif ZONE contains "SLR">
                	<cfset dolphinsSeenByZone[5] += SEEN_TIMES >
                </cfif>
          </cfloop>
  <cfelse>
    <cfset categories = [0,0,0,0,0,0]>
    <cfset all_sex_categories = [0,0,0] >
    <cfset calves_sex_categories = [0,0,0] >
    <cfset juvenile_sex_categories = [0,0,0] >
    <cfset adult_sex_categories = [0,0,0] >
    <cfset unknown_sex_categories = [0,0,0] >
  </cfif>
</cfif>
<!---<cfdump var="#categories#">
<cfdump var="#all_sex_categories#">
<cfdump var="#calves_sex_categories#">
<cfdump var="#juvenile_sex_categories#">
<cfdump var="#adult_sex_categories#">
<cfdump var="#unknown_sex_categories#">--->
<script>
    <cfoutput>
	    var #toScript(dolphinsCode, "dolphinsCode")#;
		var #toScript(dolphinsSeen, "dolphinsSeen")#;
		var #toScript(dolphinsCodeBySegment, "dolphinsCodeBySegment")#;
		var #toScript(dolphinsSeenBySegment, "dolphinsSeenBySegment")#;
		var #toScript(dolphinsCodeByZone, "dolphinsCodeByZone")#;
		var #toScript(dolphinsSeenByZone, "dolphinsSeenByZone")#;
		var #toScript(categories, "categories")#;
		var #toScript(all_sex_categories, "all_sex_categories")#;
		var #toScript(calves_sex_categories, "calves_sex_categories")#;
		var #toScript(juvenile_sex_categories, "juvenile_sex_categories")#;
		var #toScript(adult_sex_categories, "adult_sex_categories")#;
		var #toScript(unknown_sex_categories, "unknown_sex_categories")#;
		
		function checkForm() {
			if($("##fromYear").val() >  $("##toYear").val() ) {
				bootbox.alert('Start Year must be less and equal to End Year');
				return false;
			}
		}
    </cfoutput>
</script>
<!---<CFIF isdefined('FORM.RollCall') and FORM.RollCall EQ  "Download as Excel">


<cfset qgetRollExcel = Application.Reporting.getRollCallMain(argumentCollection="#Form#")>

  <cfspreadsheet 
    	action="write" 
        filename="#Application.DirectoryRoot#Reports\RollCall\RollCall.xls" 
        overwrite="true"
        query="qgetRollExcel"
    >
  <cflocation url="/Reports/RollCall/RollCall.xls" addtoken="no">
</CFIF>--->
<CFIF isdefined('FORM.Chart')>
	<cfif FORM.Chart EQ "Download_chart_pdf">
        <cfdocument name="hreport" format="PDF">
            <cfchart yaxistitle="% over artemis" format="png" chartwidth="700" chartheight="700">             
                <cfchartseries type="pie"> 
                    <cfchartdata item="Calf" value="#Calf#"> 
                    <cfchartdata item="Juvenile Male" value="#Juvenile_male#"> 
                    <cfchartdata item="Juvenile Female" value="#Juvenile_female#">
                    <cfchartdata item="Adult Male" value="#Adult_male#"> 
                    <cfchartdata item="Adult Female" value="#Adult_female#"> 
                    <cfchartdata item="Unknown Sex" value="#Unknown_sex#"> 
                </cfchartseries>
            </cfchart>
        </cfdocument>
        <cfpdf action="write"
           source="hreport"
           destination="#Application.DirectoryRoot#PDF\AnnualCensus\CategorySummary.pdf" overwrite="yes"/>
        <cfhttp url="#Application.DirectoryRoot#PDF\AnnualCensus\CategorySummary.pdf" 
            method="get" 
            getAsBinary="yes"
            file="CategorySummary.pdf"/>
    
        <cfheader name="Content-Disposition" value="attachment; filename=CategorySummary.pdf" />
        <cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\AnnualCensus\CategorySummary.pdf" />
        <!---<cfpdf name="pdf" action="read" source="createreportPDF.pdf"/>--->
        <cflocation url="/PDF/AnnualCensus/CategorySummary.pdf" addtoken="no"> 
    
    <cfelseif FORM.Chart EQ "Download_chart_jpg">
        <cfchart name="myChart" format="jpg" chartwidth="700" chartheight="700">             
            <cfchartseries type="pie"> 
                <cfchartdata item="Calf" value="#Calf#"> 
                <cfchartdata item="Juvenile Male" value="#Juvenile_male#"> 
                <cfchartdata item="Juvenile Female" value="#Juvenile_female#">
                <cfchartdata item="Adult Male" value="#Adult_male#"> 
                <cfchartdata item="Adult Female" value="#Adult_female#"> 
                <cfchartdata item="Unknown Sex" value="#Unknown_sex#"> 
            </cfchartseries>
        </cfchart>
        <cffile  
            action="WRITE"  
            file="#Application.DirectoryRoot#Charts\AnnualCensus\CategorySummary.jpg"  
            output="#myChart#"> 
        <cflocation url="/Charts/AnnualCensus/CategorySummary.jpg" addtoken="no"> 
    </cfif>
</CFIF>
<CFIF isdefined('FORM.Graph')> 
<cfif FORM.Graph EQ "Download_graph_pdf">

<cfdocument name="hreport" format="PDF">
<cfset plot = {"styles":[
{
"background-color":"##008000"
},
{
"background-color":"##FFA500"
},
{
"background-color":"##FF0000"
},
{
"background-color":"##FFFF00"
},
{
"background-color":"##69D2E7"
},
{
"background-color":"##A7DBDB"
},
{
"background-color":"##28ABE3"
},
{
"background-color":"##1FDA9A"
},
{
"background-color":"##FF4C65"
},
{
"background-color":"##6E9ECF"
},
{
"background-color":"##75EB00"
},
{
"background-color":"##9B539C"
}]}>
<cfchart yaxistitle="% over artemis" format="png" chartwidth="700" chartheight="700" scalefrom="0" scaleto="900" plot="#plot#"> 
<cfchartseries
  type="bar"
  >
<cfloop query="qgetAnnualCensusBarGraph">
	<cfchartdata item="#SurveyArea#" value="#SEEN_TIMES#">
</cfloop>
</cfchartseries>

</cfchart>
</cfdocument>

<cfpdf action="write"
       source="hreport"
       destination="#Application.DirectoryRoot#PDF\AnnualCensus\BodyOfWaterSummary.pdf" overwrite="yes"/>
<cfhttp url="#Application.DirectoryRoot#PDF\AnnualCensus\BodyOfWaterSummary.pdf" 
        method="get" 
        getAsBinary="yes"
        file="BodyOfWaterSummary.pdf"/>

<cfheader name="Content-Disposition" value="attachment; filename=BodyOfWaterSummary.pdf" />
<cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\AnnualCensus\BodyOfWaterSummary.pdf" />


<cfelseif FORM.Graph EQ "Download_graph_jpg">
<cfset plot = {"styles":[
{
"background-color":"##008000"
},
{
"background-color":"##FFA500"
},
{
"background-color":"##FF0000"
},
{
"background-color":"##FFFF00"
},
{
"background-color":"##69D2E7"
},
{
"background-color":"##A7DBDB"
},
{
"background-color":"##28ABE3"
},
{
"background-color":"##1FDA9A"
},
{
"background-color":"##FF4C65"
},
{
"background-color":"##6E9ECF"
},
{
"background-color":"##75EB00"
},
{
"background-color":"##9B539C"
}]}>
<cfchart name="MyGraph" format="jpg" scalefrom="0" scaleto="900" chartwidth="700" chartheight="700" plot="#plot#" showBorder="yes">
<cfchartseries
  type="bar"
  >
<cfloop query="qgetAnnualCensusBarGraph">
	<cfchartdata item="#SurveyArea#" value="#SEEN_TIMES#">
</cfloop>
</cfchartseries>
</cfchart>
<cffile  
    action="WRITE"  
    file="#Application.DirectoryRoot#Graphs\AnnualCensus\BodyOfWaterSummary.jpg"  
    output="#MyGraph#"> 
<cflocation url="/Graphs/AnnualCensus/BodyOfWaterSummary.jpg" addtoken="no"> 
</cfif>
</CFIF>
<cfif isdefined('FORM.qgetAnnualCensus') and FORM.qgetAnnualCensus EQ  "qgetAnnualCensus">
<cfspreadsheet 
    	action="WRITE" 
        filename="#Application.DirectoryRoot#\Reports\AnnualCensus.xls" 
        overwrite="true"
        query="qgetAnnualCensus"
    >
  <cflocation url="Reports/AnnualCensus.xls" addtoken="no">

</cfif>
<cfif isdefined('FORM.qgetAnnualCensusSecondYear') and FORM.qgetAnnualCensusSecondYear EQ  "qgetAnnualCensusSecondYear">
<cfspreadsheet 
    	action="WRITE" 
        filename="#Application.DirectoryRoot#\Reports\AnnualCensusSecondYear.xls" 
        overwrite="true"
        query="qgetAnnualCensusSecondYear"
    >
  <cflocation url="Reports/AnnualCensusSecondYear.xls" addtoken="no">

</cfif>
<cfif isdefined('FORM.qgetAnnualCensusUnseen') and FORM.qgetAnnualCensusUnseen EQ  "qgetAnnualCensusUnseen">
<cfspreadsheet 
    	action="WRITE" 
        filename="#Application.DirectoryRoot#\Reports\DolphinsMissing.xls" 
        overwrite="true"
        query="qgetAnnualCensusUnseen"
    >
  <cflocation url="Reports/DolphinsMissing.xls" addtoken="no">

</cfif>
<cfif isdefined('FORM.qgetAnnualCensusNewDolphins') and FORM.qgetAnnualCensusNewDolphins EQ  "qgetAnnualCensusNewDolphins">
<cfspreadsheet 
    	action="WRITE" 
        filename="#Application.DirectoryRoot#\Reports\NewDolphins.xls" 
        overwrite="true"
        query="qgetAnnualCensusNewDolphins"
    >
  <cflocation url="Reports/NewDolphins.xls" addtoken="no">

</cfif>
<!-- begin ##content -->

<style>
.content table th{
	cursor:pointer;
	}
.row.center-row {
    position: absolute;
    top: 50px;
    bottom: 0;
    margin: auto;
    left: 0;
    right: 0;
    display: table;
    width: 50%;
}
.space-bottom {
    margin-bottom: 40px;
}
@media (max-width:767px) {
.row.center-row {
    position: static;
    display: inline-block;
    width: 100%;
}
.space-bottom {
    margin-bottom: 10px;
}
	}
</style>

<div id="content" class="content">
  <!-- begin breadcrumb -->
  <ol class="breadcrumb pull-right">
    <li><a href="javascript:;">Reporting</a></li>
    <li><a href="javascript:;">Annual Census Report</a></li>
  </ol>
  <!-- end breadcrumb -->
  <!-- begin page-header -->
  <h1 class="page-header">Annual Census Report</h1>
  <!-- end page-header -->
  <!-- begin row -->
    <cfif isdefined('msg') and msg NEQ ''>
      <div class="alert alert-danger"> <strong>Alert!</strong> <cfoutput>#msg#</cfoutput> </div>
    </cfif>
    <!-- begin row col-6-->
      <!-- begin panel -->
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn"> 
          	<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> 
            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> 
          </div>
          <h4 class="panel-title">Filters </h4>
        </div>
        <div class="panel-body">
          <!-- start col-md-6 -->
          <cfoutput>
            <form action="" method="POST" onsubmit="return checkForm()">
                <div class="row">
                  <div class="col-md-12">
                    <h5>Date Range</h5>
                    <div class="col-md-3">
                      <label>Start</label>
                      <select class="form-control" name="fromYear" id="fromYear">
                        <cfloop to='#ReportStartyear#' from="#ReportEndyear#" index="i" step='-1'>
                          <option value="#i#" <cfif FORM.fromYear EQ i>selected</cfif> >#i#</option>
                        </cfloop>
                      </select>
                    </div>
                    <div class="col-md-3">
                      <label>End</label>
                      <select class="form-control" name="toYear" id="toYear">
                        <cfloop to='#ReportStartyear#' from="#ReportEndyear#" index="i" step='-1'>
                          <option value="#i#" <cfif FORM.toYear EQ i>selected</cfif>>#i#</option>
                        </cfloop>
                      </select>
                    </div>
                    <div class="col-md-3">
                      <input type="submit" value="Submit" name="RollCall" class="btn btn-primary m-t-25" />
                    </div>
                  </div>
                </div>
            </form>
            <div class="row"><br/><br/>
                <div class="col-md-3">
                    <div class="widget widget-stat bg-success text-white">
                        <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin.png" height="60" width="60"></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Dolphins in Start Year</div>
                            <div class="widget-stat-number">#qgetAnnualCensus.recordcount#</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="widget widget-stat bg-info text-white">
                        <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin.png" height="60" width="60"></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Dolphins in End Year</div>
                            <div class="widget-stat-number">#qgetAnnualCensusSecondYear.recordcount#</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="widget widget-stat bg-danger text-white">
                        <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin.png" height="60" width="60"></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Missing Dolphins</div>
                            <div class="widget-stat-number">#qgetAnnualCensusUnseen.recordcount#</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="widget widget-stat bg-warning text-white">
                        <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin.png" height="60" width="60"></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">New Dolphins</div>
                            <div class="widget-stat-number">#qgetAnnualCensusNewDolphins.recordcount#</div>
                        </div>
                    </div>
                </div>                        
            </div>
          </cfoutput>
          			<!---Graph Section--->
                   <div class="row">   
                      <!-- begin  col-6-->
                          
                      <!-- end  col-6 -->
                      <!-- begin  col-6-->
                          <div class="col-lg-12"> 
                            <br>
                            <br>
                            <!-- begin panel -->
                            <div class="panel panel-inverse">
                              <div class="panel-heading">
                                <div class="panel-heading-btn"> 
                                    <!---<form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Chart" value="Download_chart_jpg">
                                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                                    </form>
                                    <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Chart" value="Download_chart_pdf">
                                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                                    </form>--->
                                
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> 
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> 
                                </div>
                                <h4 class="panel-title">All Sex Chart</h4>
                              </div>
                              <div class="panel-body">
                                <!---<div>
                                     <canvas id="pie-chart"></canvas>
                                     <div id="legend"></div>
                                </div>--->
                                <div class="row space-bottom">
                                	<div class="col-lg-3 col-sm-3 col-xs-12 text-left">
                                    	 <div>
                                         	<canvas id="calves-sex-pie-chart"></canvas>
                                             <div id="calves-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-sm-6 col-xs-12 text-center"></div>
                                    <div class="col-lg-3 col-sm-3 col-xs-12 text-right">
                                    	<div>
                                              <canvas id="adult-sex-pie-chart"></canvas>
                                             <div id="adult-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row center-row">
                                	<div class="col-lg-12 col-xs-12  text-center">
                                    	<div>
                                             <canvas id="all-sex-pie-chart"></canvas>
                                             <div id="all-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row space-bottom">
                                	<div class="col-lg-3 col-sm-3 col-xs-12  text-left">
                                    	<div>
                                             <canvas id="juvenile-sex-pie-chart"></canvas>
                                             <div id="juvenile-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-sm-6 col-xs-12 text-center"></div>
                                    <div class="col-lg-3 col-sm-3 col-xs-12 text-right">
                                    	<div>
                                            
                                             <canvas id="unknown-sex-pie-chart"></canvas>
                                             <div id="unknown-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                </div>
                               
                                
                                
                              </div>
                            </div>
                            <!-- end panel -->
                          </div>
                          <div class="col-lg-6"> 
                            <br>
                            <br>
                            <!-- begin panel -->
                            <div class="panel panel-inverse">
                              <div class="panel-heading">
                                <div class="panel-heading-btn"> 
                                    <!---<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Graph" value="Download_graph_jpg">
                                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                                    </form>
                                    <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Graph" value="Download_graph_pdf">
                                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                                    </form>--->
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                                    
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> 
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> 
                                </div>
                                <h4 class="panel-title">Dolphin sightings by Body of water</h4>
                              </div>
                              <div class="panel-body">
                                 <canvas id="bar-chart"></canvas>
                              </div>
                            </div>
                            <!-- end panel -->
                                      
                          </div>
                          
                          
                          
                          <div class="col-lg-6"> 
                            <br>
                            <br>
                            <!-- begin panel -->
                            <div class="panel panel-inverse">
                              <div class="panel-heading">
                                <div class="panel-heading-btn"> 
                                    <!---<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Graph" value="Download_graph_jpg">
                                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                                    </form>
                                    <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Graph" value="Download_graph_pdf">
                                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                                    </form>--->
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                                    
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> 
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> 
                                </div>
                                <h4 class="panel-title">Dolphin sighting by Segment</h4>
                              </div>
                              <div class="panel-body">
                                 <canvas id="bar-chart-by-segments"></canvas>
                              </div>
                            </div>
                            <!-- end panel -->
                                      
                          </div>
                          
						                          
                              <div class="col-lg-8 col-lg-offset-2"> 
                                <br>
                                <br>
                                <!-- begin panel -->
                                <div class="panel panel-inverse">
                                  <div class="panel-heading">
                                    <div class="panel-heading-btn"> 
                                        <!---<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                            <input type="hidden" name="Graph" value="Download_graph_jpg">
                                            <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                                        </form>
                                        <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                            <input type="hidden" name="Graph" value="Download_graph_pdf">
                                            <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                                        </form>--->
                                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                                        
                                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> 
                                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> 
                                    </div>
                                    <h4 class="panel-title">Dolphin sightings by Zones</h4>
                                  </div>
                                  <div class="panel-body">
                                     <canvas id="bar-chart-by-zones"></canvas>
                                  </div>
                                </div>
                                <!-- end panel -->
                                          
                              </div>
                      <!-- end  col-6 -->
                   </div>
            <!---Graph Section--->  
            
            
            <div class="row"> 
              	<div class="col-md-12"> 
                	<br><br>
                    <div class="panel-heading">
                      <form name="" method="post" action="">
                            <div class="row"> 
                              <div class="col-md-3 m-l-20">  <h4 class="panel-title">Dolphins Sighted in <cfoutput>#FORM.fromYear#</cfoutput></h4>
                              </div>
                               <div class="col-md-3 pull-right">
                                  <input type="submit" value="Download as Excel" name="" class="btn btn-sucess pull-right" style="color:black"/>
                                  <input type="hidden" value="qgetAnnualCensus" name="qgetAnnualCensus" />
                                  <cfoutput>
                                      <input type="hidden" value="#FORM.fromYear#" name="fromYear" />
                                      <input type="hidden" value="#FORM.toYear#" name="toYear" />
                                  </cfoutput>
                                </div> 
                            </div>
                      </form>
                     
                    </div>
                    <div class="panel pagination-inverse m-b-0 clearfix">
                      <table data-order='[[1,"asc"]]' class="table table-bordered table-hover sort-table">
                        <thead>
                          <tr class="inverse">
                            <th>Code</th>
                            <th>Name</th>
                            <th>Sex</th>
                            <th>Age</th>
                            <th>Seen Times</th>
                          </tr>
                        </thead>
                        <tbody>
                          <cfif isdefined('qgetAnnualCensus') AND isdefined('qgetAnnualCensus.recordcount') AND qgetAnnualCensus.recordcount NEQ 0 >
                            <cfoutput query="qgetAnnualCensus" startrow="#startHereIndex1#" maxrows="#Application.record_per_page#">
                              <cfif YEAROFBIRTH NEQ '' AND IsNumeric(YEAROFBIRTH)>
                                  <cfif IsDead	EQ 0 OR DeathYear EQ ''>
                                      <cfset age = #FORM.fromYear# - YEAROFBIRTH >
                                  <cfelse>
                                      <cfif IsNumeric(DeathYear)>
                                        <cfset age = DeathYear - YEAROFBIRTH >
                                      <cfelse>
                                        <cfset age = 'N/A' >
                                      </cfif>
                                  </cfif>
                              <cfelse>
                                  <cfset age = 'N/A' >
                              </cfif>
                               <cfset qdolphindetail = Application.Reporting.getAnnualCensusSub(years=FORM.fromYear,code=qgetAnnualCensus.CODE)>
                              
                              <tr class="gradeU">
                                <td id="group_name">#qgetAnnualCensus.CODE#</td>
                                <td id="group_name"><a href="##collapse1_#qgetAnnualCensus.currentrow#" data-toggle="collapse" class="dataToggle1" id="#qgetAnnualCensus.currentrow#">#qgetAnnualCensus.NAME#</a></td>
                                <td id="group_status">#qgetAnnualCensus.SEX#</td>
                                <td id="group_status">#age#</td>
                                <td id="group_status">#qgetAnnualCensus.SEEN_TIMES#</td>
                              </tr>
                              <tr id="collapse1_#qgetAnnualCensus.currentrow#" class="panel-collapse collapse" >
                                <td colspan="8">
                                    <div class="table-responsive">
                                        <table class="table table-sm">
                                          <thead>
                                            <tr>
                                              <th>##</th>
                                              <th>Survey ID-Sighting ID</th>
                                              <th>Date Seen</th>
                                            </tr>
                                          </thead>
                                          <tbody style="background-color: ##636A71;color: ##eceeef;">
                                            <cfif qdolphindetail.recordcount NEQ 0 >
                                                <cfloop query="qdolphindetail">
                                                  <tr>
                                                    <th scope="row">#qdolphindetail.currentrow#</th>
                                                    <td>
                                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                                        <input type="hidden" name="project_id" value="#qdolphindetail.pro_id#">
                                                        <input type="hidden" name="sight_id" value="#qdolphindetail.SIGHTING_ID#">
                                                        <a href="javascript:void(0)" style="color:white" class="sighting-detail">#qdolphindetail.pro_id#-#qdolphindetail.SIGHTING_ID#</a>
                                                     </form>
                                                    </td>
                                                    <!---#qdolphindetail.SIGHTING_ID#--->
                                                    
                                                    <td>#qdolphindetail.SURVERYMONTH# / #qdolphindetail.SURVERYYEAR#</td>
                                                  </tr>
                                                </cfloop>
                                            <cfelse>
                                                  <tr>
                                                    <td colspan="5">No Record Found.</td>
                                                  </tr>
                                            </cfif>
                                          </tbody>
                                        </table>
                                    </div>
                                </td>
                              </tr>
                            </cfoutput>
                          <cfelse>
                            <tr class="gradeU"><td colspan="5" align="center">No Record Found.</td></tr>  
                          </cfif>
                        </tbody>
                      </table>
                      <cfoutput>
                          <form action="" method="post" name="paginationform1">
                            <input type="hidden" name="startHereIndex1" value="1" />
                            <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                            <input type="hidden" name="toYear" value="#FORM.toYear#" />
                          </form>
                      </cfoutput>
                      <cfif isdefined('qgetAnnualCensus') AND qgetAnnualCensus.recordcount NEQ 0 >
                        <cfset qpagination    = qgetAnnualCensus >
                        <cfset startHereTable = 1>
                        <cfinclude template="../pagination.cfm">
                      </cfif>
                    </div>
              	</div>
            </div>
            
            
            <div class="row"> 
              	<div class="col-md-12"> 
                	<br><br>
                    <div class="panel-heading">
                      <form name="" method="post" action="">
                            <div class="row"> 
                              <div class="col-md-3 m-l-20"> <h4 class="panel-title">Dolphins Sighted in <cfoutput>#FORM.toYear#</cfoutput> </h4>
                              </div>
                               <div class="col-md-3 pull-right">
                                  <input type="submit" value="Download as Excel" name="" class="btn btn-sucess pull-right"  style="color:black"/>
                                  <input type="hidden" value="qgetAnnualCensusSecondYear" name="qgetAnnualCensusSecondYear" />
                                  <cfoutput>
                                      <input type="hidden" value="#FORM.fromYear#" name="fromYear" />
                                      <input type="hidden" value="#FORM.toYear#" name="toYear" />
                                  </cfoutput>
                                </div> 
                            </div>
                      </form>
                      
                    </div>
                    <div class="panel pagination-inverse m-b-0 clearfix">
                      <table data-order='[[1,"asc"]]' class="table table-bordered table-hover sort-table">
                        <thead>
                          <tr class="inverse">
                            <th>Code</th>
                            <th>Name</th>
                            <th>Sex</th>
                            <th>Age</th>
                            <th>Seen Times</th>
                          </tr>
                        </thead>
                        <tbody>
                          <cfif isdefined('qgetAnnualCensusSecondYear') AND qgetAnnualCensusSecondYear.recordcount NEQ 0 >
                            <cfoutput query="qgetAnnualCensusSecondYear" startrow="#startHereIndex2#" maxrows="#Application.record_per_page#">
                              <cfif YEAROFBIRTH NEQ '' AND IsNumeric(YEAROFBIRTH)>
                                  <cfif IsDead	EQ 0 OR DeathYear EQ ''>
                                      <cfset age = #FORM.fromYear# - YEAROFBIRTH >
                                  <cfelse>
                                      <cfif IsNumeric(DeathYear)>
                                        <cfset age = DeathYear - YEAROFBIRTH >
                                      <cfelse>
                                        <cfset age = 'N/A' >
                                      </cfif>
                                  </cfif>
                              <cfelse>
                                  <cfset age = 'N/A' >
                              </cfif>
                               <cfset qdolphindetail = Application.Reporting.getAnnualCensusSub(years=FORM.toYear,code=qgetAnnualCensusSecondYear.CODE)>
                              
                              <tr class="gradeU">
                                <td id="group_name">#CODE#</td>
                                <td id="group_name"><a href="##collapse2_#currentrow#" data-toggle="collapse" class="dataToggle2" id="#currentrow#">#NAME#</a></td>
                                <td id="group_status">#SEX#</td>
                                <td id="group_status">#age#</td>
                                <td id="group_status">#SEEN_TIMES#</td>
                              </tr>
                              <tr id="collapse2_#currentrow#" class="panel-collapse collapse" >
                                <td colspan="8">
                                    <div class="table-responsive">
                                        <table class="table table-sm">
                                          <thead>
                                            <tr>
                                              <th>##</th>
                                              <th>Survey ID-Sighting ID</th>
                                              <th>Date Seen</th>
                                            </tr>
                                          </thead>
                                          <tbody style="background-color: ##636A71;color: ##eceeef;">
                                            <cfif qdolphindetail.recordcount NEQ 0 >
                                                <cfloop query="qdolphindetail">
                                                  <tr>
                                                    <th scope="row">#qdolphindetail.currentrow#</th>
                                                    <td>
                                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                                        <input type="hidden" name="project_id" value="#qdolphindetail.pro_id#">
                                                        <input type="hidden" name="sight_id" value="#qdolphindetail.SIGHTING_ID#">
                                                        <a href="javascript:void(0)" style="color:white" class="sighting-detail">#qdolphindetail.pro_id#-#qdolphindetail.SIGHTING_ID#</a>
                                                     </form>
                                                    </td>
                                                    <!---#qdolphindetail.SIGHTING_ID#--->
                                                    
                                                    <td>#qdolphindetail.SURVERYMONTH# / #qdolphindetail.SURVERYYEAR#</td>
                                                  </tr>
                                                </cfloop>
                                            <cfelse>
                                                  <tr>
                                                    <td colspan="5">No Record Found.</td>
                                                  </tr>
                                            </cfif>
                                          </tbody>
                                        </table>
                                    </div>
                                </td>
                              </tr>
                            </cfoutput>
                          <cfelse>
                            <tr class="gradeU"><td colspan="5" align="center">No Record Found.</td></tr>  
                          </cfif>
                        </tbody>
                      </table>
                      <cfoutput>
                          <form action="" method="post" name="paginationform2">
                            <input type="hidden" name="startHereIndex2" value="1" />
                            <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                            <input type="hidden" name="toYear" value="#FORM.toYear#" />
                          </form>
                      </cfoutput>
                      <cfif isdefined('qgetAnnualCensus') AND qgetAnnualCensus.recordcount NEQ 0 >
                        <cfset qpagination = qgetAnnualCensusSecondYear >
                        <cfset startHereTable = 2>
                        <cfinclude template="../pagination.cfm">
                      </cfif>
                    </div>
              	</div>
            </div>
            
            
            <div class="row"> 
                <div class="col-md-12"> 
                    <br><br>
                    <div class="panel-heading">
                    <form name="" method="post" action="">
                            <div class="row"> 
                              <div class="col-md-3 m-l-20"> <h4 class="panel-title">Dolphins Missing in <cfoutput>#FORM.toYear#</cfoutput></h4>
                              </div>
                               <div class="col-md-3 pull-right">
                                  <input type="submit" value="Download as Excel" name="" class="btn btn-sucess pull-right"  style="color:black"/>
                                  <input type="hidden" value="qgetAnnualCensusUnseen" name="qgetAnnualCensusUnseen" />
                                  <cfoutput>
                                      <input type="hidden" value="#FORM.fromYear#" name="fromYear" />
                                      <input type="hidden" value="#FORM.toYear#" name="toYear" />
                                  </cfoutput>
                                </div> 
                            </div>
                      </form>
                      
                    </div>
                    <div class="panel pagination-inverse m-b-0 clearfix">
                      <table data-order='[[1,"asc"]]' class="table table-bordered table-hover sort-table">
                        <thead>
                          <tr class="inverse">
                            <th>Code</th>
                            <th>Name</th>
                            <th>Sex</th>
                            <th>Age</th>
                            <!---<th>Seen Times</th>--->
                          </tr>
                        </thead>
                        <tbody>
                          <cfif isdefined('qgetAnnualCensusUnseen') AND qgetAnnualCensusUnseen.recordcount NEQ 0 >
                            <cfoutput query="qgetAnnualCensusUnseen" startrow="#startHereIndex3#" maxrows="#Application.record_per_page#">
                              <cfif YEAROFBIRTH NEQ '' AND IsNumeric(YEAROFBIRTH)>
                                  <cfif IsDead	EQ 0 OR DeathYear EQ ''>
                                      <cfset age = #FORM.fromYear# - YEAROFBIRTH >
                                  <cfelse>
                                      <cfif IsNumeric(DeathYear)>
                                        <cfset age = DeathYear - YEAROFBIRTH >
                                      <cfelse>
                                        <cfset age = 'N/A' >
                                      </cfif>
                                  </cfif>
                              <cfelse>
                                  <cfset age = 'N/A' >
                              </cfif>
                               <!---<cfset qdolphindetail = Application.Reporting.getAnnualCensusSub(years=FORM.toYear,code=qgetAnnualCensusUnseen.CODE)>--->
                              
                              <tr class="gradeU">
                                <td id="group_name">#qgetAnnualCensusUnseen.CODE#</td>
                                <td id="group_name"><a href="##collapse3_#qgetAnnualCensusUnseen.currentrow#" data-toggle="collapse" class="dataToggle3" id="#qgetAnnualCensusUnseen.currentrow#">#qgetAnnualCensusUnseen.NAME#</a></td>
                                <td id="group_status">#qgetAnnualCensusUnseen.SEX#</td>
                                <td id="group_status">#age#</td>
                                <!---<td id="group_status">#qgetAnnualCensusUnseen.SEEN_TIMES#</td>--->
                              </tr>
                              <tr id="collapse3_#qgetAnnualCensusUnseen.currentrow#" class="panel-collapse collapse" >
                                <td colspan="8">
                                    <div class="table-responsive">
                                        <table class="table table-sm">
                                          <thead>
                                            <tr>
                                              <th>##</th>
                                              <th>Survey ID-Sighting ID</th>
                                              <th>Date Seen</th>
                                            </tr>
                                          </thead>
                                          <tbody style="background-color: ##636A71;color: ##eceeef;">
                                            <cfif qdolphindetail.recordcount NEQ 0 >
                                                <cfloop query="qdolphindetail">
                                                  <tr>
                                                    <th scope="row">#qdolphindetail.currentrow#</th>
                                                    <td>
                                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                                        <input type="hidden" name="project_id" value="#qdolphindetail.pro_id#">
                                                        <input type="hidden" name="sight_id" value="#qdolphindetail.SIGHTING_ID#">
                                                        <a href="javascript:void(0)" style="color:white" class="sighting-detail">#qdolphindetail.pro_id#-#qdolphindetail.SIGHTING_ID#</a>
                                                     </form>
                                                    </td>
                                                    <!---#qdolphindetail.SIGHTING_ID#--->
                                                    
                                                    <td>#qdolphindetail.SURVERYMONTH# / #qdolphindetail.SURVERYYEAR#</td>
                                                  </tr>
                                                </cfloop>
                                            <cfelse>
                                                  <tr>
                                                    <td colspan="5">No Record Found.</td>
                                                  </tr>
                                            </cfif>
                                          </tbody>
                                        </table>
                                    </div>
                                </td>
                              </tr>
                            </cfoutput>
                          <cfelse>
                            <tr class="gradeU"><td colspan="5" align="center">No Record Found.</td></tr>  
                          </cfif>
                        </tbody>
                      </table>
                      <cfoutput>
                          <form action="" method="post" name="paginationform3">
                            <input type="hidden" name="startHereIndex3" value="1" />
                            <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                            <input type="hidden" name="toYear" value="#FORM.toYear#" />
                          </form>
                      </cfoutput>
                      <cfif isdefined('qgetAnnualCensusUnseen') AND isdefined('qgetAnnualCensusUnseen.recordcount') AND qgetAnnualCensusUnseen.recordcount NEQ 0 >
                        <cfset qpagination = qgetAnnualCensusUnseen >
                        <cfset startHereTable = 3>
                        <cfinclude template="../pagination.cfm">
                        <!---<cfoutput>
                            <div class="mypagination">
                               <!--- Checks on Displaying Recrod number--->
                                <cfif qpagination.recordcount LT Application.record_per_page>
                                    Displaying <cfoutput>#qpagination.recordcount#</cfoutput> Records.
                                <cfelse>
                                    <cfif (startHereIndex1+Application.record_per_page) GT qpagination.recordcount>
                                            Displaying <cfoutput>#startHereIndex1# - #qpagination.recordcount# of #qpagination.recordcount#</cfoutput> Records
                                    <cfelse>
                                            Displaying <cfoutput>#startHereIndex1# - #(startHereIndex1+Application.record_per_page-1)# of #qpagination.recordcount#</cfoutput> Records
                                    </cfif>
                                <!--- Check on Showing Previous Or Next Button --->
                                   <cfif startHereIndex1 LT Application.record_per_page>
                                        <cfelse>
                                              <a class="prev" href="javascript:void(0);" onClick="ApplyPaginations('startHereIndex1',#evaluate(startHereIndex1 - Application.record_per_page)#); return false;">Previous</a>
                                   </cfif>
                                   <a >|</a>
                                   <cfif (startHereIndex1+Application.record_per_page) GT qpagination.recordcount>
                                        <cfelse>
                                              <a class="next" href="javascript:void(0);" onClick="ApplyPaginations('startHereIndex1',#evaluate(startHereIndex1 + Application.record_per_page)#); return false;">Next</a>
                                   </cfif>
                                </cfif>
                            </div>
                        </cfoutput>--->
                      </cfif>
                    </div>
                </div>
            </div>
            <div class="row"> 
              	<div class="col-md-12"> 
                	<br><br>
                    <div class="panel-heading">
                      <form name="" method="post" action="">
                            <div class="row"> 
                              <div class="col-md-3 m-l-20"> <h4 class="panel-title">New Dolphins in <cfoutput>#FORM.toYear#</cfoutput></h4>
                              </div>
                               <div class="col-md-3 pull-right">
                                  <input type="submit" value="Download as Excel" name="" class="btn btn-sucess pull-right"  style="color:black"/>
                                  <input type="hidden" value="qgetAnnualCensusNewDolphins" name="qgetAnnualCensusNewDolphins" />
                                  <cfoutput>
                                      <input type="hidden" value="#FORM.fromYear#" name="fromYear" />
                                      <input type="hidden" value="#FORM.toYear#" name="toYear" />
                                  </cfoutput>
                                </div> 
                            </div>
                      </form>
                      
                    </div>
                    <div class="panel pagination-inverse m-b-0 clearfix">
                      <table data-order='[[1,"asc"]]' class="table table-bordered table-hover sort-table">
                        <thead>
                          <tr class="inverse">
                            <th>Code</th>
                            <th>Name</th>
                            <th>Sex</th>
                            <th>Age</th>
                            <th>Seen Times</th>
                          </tr>
                        </thead>
                        <tbody>
                          <cfif isdefined('qgetAnnualCensusNewDolphins') AND qgetAnnualCensusNewDolphins.recordcount NEQ 0 >
                            <cfoutput query="qgetAnnualCensusNewDolphins" startrow="#startHereIndex4#" maxrows="#Application.record_per_page#">
                              <cfif YEAROFBIRTH NEQ '' AND IsNumeric(YEAROFBIRTH)>
                                  <cfif IsDead	EQ 0 OR DeathYear EQ ''>
                                      <cfset age = #FORM.fromYear# - YEAROFBIRTH >
                                  <cfelse>
                                      <cfif IsNumeric(DeathYear)>
                                        <cfset age = DeathYear - YEAROFBIRTH >
                                      <cfelse>
                                        <cfset age = 'N/A' >
                                      </cfif>
                                  </cfif>
                              <cfelse>
                                  <cfset age = 'N/A' >
                              </cfif>
                               <cfset qdolphindetail = Application.Reporting.getAnnualCensusSub(years=FORM.fromYear,code=qgetAnnualCensusNewDolphins.CODE)>
                              
                              <tr class="gradeU">
                                <td id="group_name">#CODE#</td>
                                <td id="group_name"><a href="##collapse4_#currentrow#" data-toggle="collapse" class="dataToggle4" id="#currentrow#">#NAME#</a></td>
                                <td id="group_status">#SEX#</td>
                                <td id="group_status">#age#</td>
                                <td id="group_status">#SEEN_TIMES#</td>
                              </tr>
                              <tr id="collapse4_#currentrow#" class="panel-collapse collapse" >
                                <td colspan="8">
                                    <div class="table-responsive">
                                        <table class="table table-sm">
                                          <thead>
                                            <tr>
                                              <th>##</th>
                                              <th>Survey ID-Sighting ID</th>
                                              <th>Date Seen</th>
                                            </tr>
                                          </thead>
                                          <tbody style="background-color: ##636A71;color: ##eceeef;">
                                            <cfif qdolphindetail.recordcount NEQ 0 >
                                                <cfloop query="qdolphindetail">
                                                  <tr>
                                                    <th scope="row">#qdolphindetail.currentrow#</th>
                                                    <td>
                                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                                        <input type="hidden" name="project_id" value="#qdolphindetail.pro_id#">
                                                        <input type="hidden" name="sight_id" value="#qdolphindetail.SIGHTING_ID#">
                                                        <a href="javascript:void(0)" style="color:white" class="sighting-detail">#qdolphindetail.pro_id#-#qdolphindetail.SIGHTING_ID#</a>
                                                     </form>
                                                    </td>
                                                    <!---#qdolphindetail.SIGHTING_ID#--->
                                                    
                                                    <td>#qdolphindetail.SURVERYMONTH# / #qdolphindetail.SURVERYYEAR#</td>
                                                  </tr>
                                                </cfloop>
                                            <cfelse>
                                                  <tr>
                                                    <td colspan="5">No Record Found.</td>
                                                  </tr>
                                            </cfif>
                                          </tbody>
                                        </table>
                                    </div>
                                </td>
                              </tr>
                            </cfoutput>
                          <cfelse>
                            <tr class="gradeU"><td colspan="5" align="center">No Record Found.</td></tr>  
                          </cfif>
                        </tbody>
                      </table>
                      <cfoutput>
                          <form action="" method="post" name="paginationform4">
                            <input type="hidden" name="startHereIndex4" value="1" />
                            <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                            <input type="hidden" name="toYear" value="#FORM.toYear#" />
                          </form>
                      </cfoutput>
                      <cfif isdefined('qgetAnnualCensusNewDolphins') AND  qgetAnnualCensusNewDolphins.recordcount NEQ 0 >
                        <cfset qpagination    = qgetAnnualCensusNewDolphins >
                        <cfset startHereTable = 4>
                        <cfinclude template="../pagination.cfm">
                      </cfif>
                    </div>
              	</div>
            </div>

            <!---<div class="row"> 
                <form action="" method="POST">
                    <!---<div class="col-md-3 m-l-20"><br>
                        <label>Filter</label>
                        <select class="form-control" name="seentimes"  onchange="this.form.submit()">
                          <cfloop from='1' to="30" index="i" >
                            <cfoutput>
                              <option value="#i#" <cfif FORM.seentimes EQ i>selected</cfif>>Seen #i# or more times</option>
                            </cfoutput>
                          </cfloop>
                        </select>
                        <cfoutput>
                          <input type="hidden" name="fromYear" value="#FORM.fromYear#">
                          <input type="hidden" name="toYear" value="#FORM.toYear#">
                        </cfoutput> 
                   </div>--->
                    <div class="col-md-3 pull-right m-t-15">
                      <input type="submit" value="Download as Excel" name="RollCall" class="btn btn-sucess m-t-25" />
                    </div> 
                </form>
            </div>--->
          
          <!-- end col-md-6 -->
        </div>
      </div>
      <!-- end panel -->
    <!-- end row col-6 -->
    
  <!-- begin ##footer -->
      <div id="footer" class="footer"> 
        <span class="pull-right"> 
            <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top"> <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span> </a> 
        </span> &copy; 
        <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved 
      </div>
  <!-- end ##footer -->
</div>
<!-- end ##content -->

<div class="modal fade" id="all-sex-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="all-sex-modal-title"></h4>
      </div>
      <div class="modal-body" id="all-sex-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="calf-sex-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="calf-sex-modal-title"></h4>
      </div>
      <div class="modal-body" id="calf-sex-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="adult-sex-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="adult-sex-modal-title"></h4>
      </div>
      <div class="modal-body" id="adult-sex-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="juvenile-sex-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="juvenile-sex-modal-title"></h4>
      </div>
      <div class="modal-body" id="juvenile-sex-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="unknown-sex-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="unknown-sex-modal-title"></h4>
      </div>
      <div class="modal-body" id="unknown-sex-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="bodyofwater-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="bodyofwater-modal-title"></h4>
      </div>
      <div class="modal-body" id="bodyofwater-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="zone-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="zone-modal-title"></h4>
      </div>
      <div class="modal-body" id="zone-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>



<div class="modal fade" id="segments-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="segments-modal-title"></h4>
      </div>
      <div class="modal-body" id="segments-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>



<!---<div class="modal fade" id="seasonal">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Seasonal Resident Dolphins</h4>
      </div>
      <div class="modal-body">
        <table  class="table table-striped table-bordered" >
                <tr>
                <td width="80"><b>ID</b></td>
                <td width="100"><b>Code</b></td>
                <td width="120"><b>Sighting ID</b></td>
                <td width="250"><b>Name</b></td>
                <td width="50"><b>Sex</b></td>
            </tr>
         </table>
         <div class="datacontainer"> 
         <table class="table table-striped table-bordered">  
            <cfif ArrayLen(Seasonal) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(Seasonal)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#Seasonal[i].code#</td>
                    <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#Seasonal[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#Seasonal[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#Seasonal[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                   
                   
                    <td width="250">#Seasonal[i].name#</td>
                   <td width="50">#Seasonal[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- Seasonal modal -->
<div class="modal fade" id="resident">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Resident Dolphins</h4>
      </div>
      <div class="modal-body">
        <table  class="table table-striped table-bordered" >
                <tr>
                 <td width="80"><b>ID</b></td>
                <td width="100"><b>Code</b></td>
                <td width="120"><b>Sighting ID</b></td>
                <td width="250"><b>Name</b></td>
                <td width="50"><b>Sex</b></td>
            </tr>
         </table>
         <div class="datacontainer"> 
         <table class="table table-striped table-bordered">  
            <cfif ArrayLen(Resident) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(Resident)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#Resident[i].code#</td>
                   <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                        <input type="hidden" name="project_id" value="#Resident[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#Resident[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#Resident[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#Resident[i].name#</td>
                   <td width="50">#Resident[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Resident modal -->
<div class="modal fade" id="transient">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Transients Resident Dolphins</h4>
      </div>
      <div class="modal-body">
        <table  class="table table-striped table-bordered" >
                <tr>
                <td width="80"><b>ID</b></td>
                <td width="100"><b>Code</b></td>
                <td width="120"><b>Sighting ID</b></td>
                <td width="250"><b>Name</b></td>
                <td width="50"><b>Sex</b></td>
            </tr>
         </table>
         <div class="datacontainer"> 
         <table class="table table-striped table-bordered">  
            <cfif ArrayLen(Transient) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(Transient)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#Transient[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#Transient[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#Transient[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#Transient[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#Transient[i].name#</td>
                   <td width="50">#Transient[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Transients modal -->
<div class="modal fade" id="summary1">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id='month_title'></h4>
      </div>
      <div class="modal-body">
        <table  class="table table-striped table-bordered" >
                <tr>
                <td width="80"><b>ID</b></td>
                <td width="100"><b>Code</b></td>
                <td width="120"><b>Sighting ID</b></td>
                <td width="250"><b>Name</b></td>
                <td width="50"><b>Sex</b></td>
            </tr>
         </table>
         <div class="datacontainer"> 
         <cfoutput>
         <table class="table table-striped table-bordered" id='tbl_row'>  

            
        		
            
  
        </table>
        </cfoutput>  
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Transients modal -->--->




