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
</style>
<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
<cfset Application.record_per_page = 10>
<cfset ReportStartyear = 1990>
<cfset ReportEndyear = year(now())>
<cfset from = ReportEndyear-1>
<cfparam name="FORM.fromYear" default="#from#">
<cfparam name="FORM.toYear" default="#year(now())#">
<cfparam name="FORM.seentimes" default="1">
<cfparam name="code" default="">
<cfparam name="getSeentimes" default="">
<cfset res_fromYear = [0,0,0,0,0,0,0,0,0,0,0,0] >
<cfset res_linefromYear = [0,0,0,0,0,0,0,0,0,0,0,0] >
<cfset res_toYear = [0,0,0,0,0,0,0,0,0,0,0,0] >
<cfset res_linetoYear = [0,0,0,0,0,0,0,0,0,0,0,0] >
<cfset summary2_fromYear = [0,0,0] >
<!------- Roll Call--------->
<!---When page loads--->
<cfif  FORM.toYear  LT  FORM.fromYear  >
  <cfset msg = 'Start Year must be less and equal to End Year'>
  <cfelse>
  <cfset qgetRollCall = Application.Reporting.getRollCallMain(argumentCollection="#Form#")>
  <cfset qgetRollCallGrapghFromYear = Application.Reporting.getRollCallGrapghFromYear(argumentCollection="#Form#")>
  <cfset qgetRollCallGrapghEndYear = Application.Reporting.getRollCallGrapghEndYear(argumentCollection="#Form#")>
  <cfset qgetRollCallGrapghCombineLineFromYear = Application.Reporting.combineChartLinefromYear(argumentCollection="#Form#")>
  <cfset qgetRollCallGrapghCombineLineEndYear = Application.Reporting.combineChartLinetoYear(argumentCollection="#Form#")>
  <cfif not isdefined('msg') >
    <cfset res_fromYear = [] >
    <cfset res_toYear = [] >
    <cfset summary2_fromYear = [] >
    <!---<cfset Seasonal_fromYear = ArrayNew(1)>
    <cfset Resident_fromYear = ArrayNew(1) >
    <cfset Transient_fromYear = ArrayNew(1) >--->
    <cfloop from="1" to="12" index="i">
      <cfquery name="getSeentimes" dbtype="query" >
            SELECT count(Dolphin_ID) as times from qgetRollCallGrapghFromYear where  SurveryMONTH = #i#
       </cfquery>
      <cfif getSeentimes.recordcount NEQ 0 >
        <cfset res_fromYear[i] = getSeentimes.times>
        <cfelse>
        <cfset res_fromYear[i] = 0>
      </cfif>
      <cfquery name="getSeentimes" dbtype="query" >
            SELECT count(Dolphin_ID) as times from qgetRollCallGrapghEndYear where  SurveryMONTH = #i#
       </cfquery>
      <cfif getSeentimes.recordcount NEQ 0 >
        <cfset res_toYear[i] = getSeentimes.times>
        <cfelse>
        <cfset res_toYear[i] = 0>
      </cfif>
    </cfloop>
    <cfelse>
    <cfset res_fromYear = [0,0,0,0,0,0,0,0,0,0,0,0] >
    <cfset res_toYear = [0,0,0,0,0,0,0,0,0,0,0,0] >
  </cfif>
  <cfif not isdefined('msg') >
    <cfset summary2_fromYear = [] >
    <cfset summary2_toYear = [] >
    
    <cfset resident_count_fromYear =  0>
    <cfset seasonal_count_fromYear =  0>
    <cfset transients_count_fromYear =  0>
    <cfset resident_count_toYear =  0>
    <cfset seasonal_count_toYear =  0>
    <cfset transients_count_toYear =  0>
    
    <cfloop query="qgetRollCallGrapghFromYear" >
      
   
	   <!---<cfset count =  0>
       <cfquery name="q1" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghFromYear where Dolphin_ID = #qgetRollCallGrapghFromYear.Dolphin_ID# AND SurveryMONTH IN (1,2,3)
            
       </cfquery>

       <cfif q1.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       

       <cfquery name="q2" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghFromYear where Dolphin_ID = #qgetRollCallGrapghFromYear.Dolphin_ID# AND SurveryMONTH IN (4,5,6)
       </cfquery>
       
       <cfif q2.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>

       <cfquery name="q3" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghFromYear where Dolphin_ID = #qgetRollCallGrapghFromYear.Dolphin_ID# AND SurveryMONTH IN (7,8,9)
       </cfquery>
       
       <cfif q3.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       
       
       <cfquery name="q4" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghFromYear where Dolphin_ID = #qgetRollCallGrapghFromYear.Dolphin_ID# AND SurveryMONTH IN (10,11,12)
       </cfquery>
       
       <cfif q4.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>---> 

       
       <cfif qgetRollCallGrapghFromYear.count EQ 1 >
       		<cfset transients_count_fromYear = transients_count_fromYear + 1 >
            <!---<cfset tr = StructNew() >
            <cfset tr['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
            <cfset tr['Name'] = qgetRollCallGrapghFromYear.Name >
            <cfset tr['Code'] = qgetRollCallGrapghFromYear.Code >
            <cfset tr['Sex'] = qgetRollCallGrapghFromYear.Sex >
            <cfset tr['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
            <cfset tr['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
            <cfset ArrayAppend(Transient,tr)>--->
       <cfelseif qgetRollCallGrapghFromYear.count EQ 3 OR qgetRollCallGrapghFromYear.count EQ 2 >
       		<cfset seasonal_count_fromYear = seasonal_count_fromYear + 1 >
            <!---<cfset tt = StructNew() >
            <cfset tt['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
            <cfset tt['Name'] = qgetRollCallGrapghFromYear.Name >
            <cfset tt['Code'] = qgetRollCallGrapghFromYear.Code >
            <cfset tt['Sex'] = qgetRollCallGrapghFromYear.Sex >
            <cfset tt['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
            <cfset tt['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
            <cfset ArrayAppend(Seasonal,tt)>--->
       <cfelseif qgetRollCallGrapghFromYear.count  EQ 4 >
       	    <cfset resident_count_fromYear = resident_count_fromYear + 1 >
             <!---<cfset rr = StructNew() >
            <cfset rr['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
            <cfset rr['Name'] = qgetRollCallGrapghFromYear.Name >
            <cfset rr['Code'] = qgetRollCallGrapghFromYear.Code >
            <cfset rr['Sex'] = qgetRollCallGrapghFromYear.Sex >
            <cfset rr['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
            <cfset rr['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
            <cfset ArrayAppend(Resident,rr)> --->   
       </cfif>

    </cfloop>
    
    <cfset summary2_fromYear = [resident_count_fromYear,seasonal_count_fromYear,transients_count_fromYear] >
    
    <cfloop query="qgetRollCallGrapghEndYear" >
      
	   <!---<cfset count =  0>
       <cfquery name="q1" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghEndYear where Dolphin_ID = #qgetRollCallGrapghEndYear.Dolphin_ID# AND SurveryMONTH IN (1,2,3)
            
       </cfquery>

       <cfif q1.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       

       <cfquery name="q2" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghEndYear where Dolphin_ID = #qgetRollCallGrapghEndYear.Dolphin_ID# AND SurveryMONTH IN (4,5,6)
       </cfquery>
       
       <cfif q2.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>

       <cfquery name="q3" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghEndYear where Dolphin_ID = #qgetRollCallGrapghEndYear.Dolphin_ID# AND SurveryMONTH IN (7,8,9)
       </cfquery>
       
       <cfif q3.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       
       
       <cfquery name="q4" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghEndYear where Dolphin_ID = #qgetRollCallGrapghEndYear.Dolphin_ID# AND SurveryMONTH IN (10,11,12)
       </cfquery>
       
       <cfif q4.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>---> 

       
       <cfif qgetRollCallGrapghEndYear.count EQ 1 >
       		<cfset transients_count_toYear = transients_count_toYear + 1 >
            <!---<cfset tr = StructNew() >
            <cfset tr['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
            <cfset tr['Name'] = qgetRollCallGrapghFromYear.Name >
            <cfset tr['Code'] = qgetRollCallGrapghFromYear.Code >
            <cfset tr['Sex'] = qgetRollCallGrapghFromYear.Sex >
            <cfset tr['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
            <cfset tr['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
            <cfset ArrayAppend(Transient,tr)>--->
       <cfelseif qgetRollCallGrapghEndYear.count EQ 3 OR qgetRollCallGrapghEndYear.count EQ 2 >
       		<cfset seasonal_count_toYear = seasonal_count_toYear + 1 >
            <!---<cfset tt = StructNew() >
            <cfset tt['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
            <cfset tt['Name'] = qgetRollCallGrapghFromYear.Name >
            <cfset tt['Code'] = qgetRollCallGrapghFromYear.Code >
            <cfset tt['Sex'] = qgetRollCallGrapghFromYear.Sex >
            <cfset tt['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
            <cfset tt['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
            <cfset ArrayAppend(Seasonal,tt)>--->
       <cfelseif qgetRollCallGrapghEndYear.count  EQ 4 >
       	    <cfset resident_count_toYear = resident_count_toYear + 1 >
             <!---<cfset rr = StructNew() >
            <cfset rr['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
            <cfset rr['Name'] = qgetRollCallGrapghFromYear.Name >
            <cfset rr['Code'] = qgetRollCallGrapghFromYear.Code >
            <cfset rr['Sex'] = qgetRollCallGrapghFromYear.Sex >
            <cfset rr['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
            <cfset rr['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
            <cfset ArrayAppend(Resident,rr)> --->   
       </cfif>

    </cfloop>
    
    <cfset summary2_toYear = [resident_count_toYear,seasonal_count_toYear,transients_count_toYear] >
    	
    <cfelse>
    <cfset summary2_fromYear = [0,0,0] >
    <cfset summary2_toYear = [0,0,0] >
  </cfif>
  
</cfif>
<script>
    
    <cfoutput>
		
	    var #toScript(summary2_fromYear, "summary2_fromYear")#;
		var #toScript(summary2_toYear, "summary2_toYear")#; 
        var #toScript(res_fromYear, "res_fromYear")#;
		var #toScript(res_toYear, "res_toYear")#;
		var #toScript(qgetRollCallGrapghCombineLineFromYear, "qgetRollCallGrapghCombineLineFromYear")#;
		var #toScript(qgetRollCallGrapghCombineLineEndYear, "qgetRollCallGrapghCombineLineEndYear")#;
		
		function checkForm() {
			if($("#fromYear#").val() >  $("#toYear#").val() ) {
				bootbox.alert('Start Year must be less and equal to End Year');
				return false;
				}
			}

    </cfoutput>
    
    </script>
<CFIF isdefined('FORM.RollCall') and FORM.RollCall EQ  "Download as Excel">


<cfset qgetRollExcel = Application.Reporting.getRollCallMain(argumentCollection="#Form#")>

  <cfspreadsheet 
    	action="write" 
        filename="#Application.DirectoryRoot#Reports\RollCall\RollCall.xls" 
        overwrite="true"
        query="qgetRollExcel"
    >
  <cflocation url="/Reports/RollCall/RollCall.xls" addtoken="no">
</CFIF>

<CFIF isdefined('FORM.Chart')>
    
<cfif FORM.Chart EQ "Download_pie_chart_pdf_fromYear">
<cfdocument name="hreport" format="PDF">
<cfchart yaxistitle="% over artemis" format="png" chartwidth="700" chartheight="700">             
    <cfchartseries type="pie"> 
    	<cfchartdata item="Resident" value="#resident_count_fromYear#"> 
        <cfchartdata item="Seasonal" value="#seasonal_count_fromYear#"> 
        <cfchartdata item="Transients" value="#transients_count_fromYear#"> 
    </cfchartseries>
</cfchart>
</cfdocument>
<cfpdf action="write"
       source="hreport"
       destination="#Application.DirectoryRoot#PDF\RollCall\ResidentSummary.pdf" overwrite="yes"/>
<cfhttp url="#Application.DirectoryRoot#PDF\RollCall\ResidentSummary.pdf" 
        method="get" 
        getAsBinary="yes"
        file="ResidentSummary.pdf"/>

<cfheader name="Content-Disposition" value="attachment; filename=ResidentSummary.pdf" />
<cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\RollCall\ResidentSummary.pdf" />
<!---<cfpdf name="pdf" action="read" source="createreportPDF.pdf"/>--->
<cflocation url="/PDF/RollCall/ResidentSummary.pdf" addtoken="no"> 

<cfelseif FORM.Chart EQ "Download_pie_chart_jpg_fromYear">
	<cfchart name="myChart" format="jpg" chartwidth="700" chartheight="700">             
    <cfchartseries type="pie"> 
    	<cfchartdata item="Resident" value="#resident_count_fromYear#"> 
        <cfchartdata item="Seasonal" value="#seasonal_count_fromYear#"> 
        <cfchartdata item="Transients" value="#transients_count_fromYear#"> 
    </cfchartseries>
</cfchart>
<cffile  
    action="WRITE"  
    file="#Application.DirectoryRoot#Charts\RollCall\ResidentSummary.jpg"  
    output="#myChart#"> 
<cflocation url="/Charts/RollCall/ResidentSummary.jpg" addtoken="no"> 
</cfif>
</CFIF>




<CFIF isdefined('FORM.Chart')>
    
<cfif FORM.Chart EQ "Download_pie_chart_pdf_toYear">
<cfdocument name="hreport" format="PDF">
<cfchart yaxistitle="% over artemis" format="png" chartwidth="700" chartheight="700">             
    <cfchartseries type="pie"> 
    	<cfchartdata item="Resident" value="#resident_count_toYear#"> 
        <cfchartdata item="Seasonal" value="#seasonal_count_toYear#"> 
        <cfchartdata item="Transients" value="#transients_count_toYear#"> 
    </cfchartseries>
</cfchart>
</cfdocument>
<cfpdf action="write"
       source="hreport"
       destination="#Application.DirectoryRoot#PDF\RollCall\ResidentSummary.pdf" overwrite="yes"/>
<cfhttp url="#Application.DirectoryRoot#PDF\RollCall\ResidentSummary.pdf" 
        method="get" 
        getAsBinary="yes"
        file="ResidentSummary.pdf"/>

<cfheader name="Content-Disposition" value="attachment; filename=ResidentSummary.pdf" />
<cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\RollCall\ResidentSummary.pdf" />
<!---<cfpdf name="pdf" action="read" source="createreportPDF.pdf"/>--->
<cflocation url="/PDF/RollCall/ResidentSummary.pdf" addtoken="no"> 

<cfelseif FORM.Chart EQ "Download_pie_chart_jpg_toYear">
	<cfchart name="myChart" format="jpg" chartwidth="700" chartheight="700">             
    <cfchartseries type="pie"> 
    	<cfchartdata item="Resident" value="#resident_count_toYear#"> 
        <cfchartdata item="Seasonal" value="#seasonal_count_toYear#"> 
        <cfchartdata item="Transients" value="#transients_count_toYear#"> 
    </cfchartseries>
</cfchart>
<cffile  
    action="WRITE"  
    file="#Application.DirectoryRoot#Charts\RollCall\ResidentSummary.jpg"  
    output="#myChart#"> 
<cflocation url="/Charts/RollCall/ResidentSummary.jpg" addtoken="no"> 
</cfif>
</CFIF>


<CFIF isdefined('FORM.Graph')> 
<cfif FORM.Graph EQ "Download_graph_pdf_fromYear">

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
<cfchartdata item="Jan" value="#res_fromYear[1]#">
<cfchartdata item="Feb" value="#res_fromYear[2]#">
<cfchartdata item="Mar" value="#res_fromYear[3]#">
<cfchartdata item="Apr" value="#res_fromYear[4]#">
<cfchartdata item="May" value="#res_fromYear[5]#">
<cfchartdata item="Jun" value="#res_fromYear[6]#">
<cfchartdata item="Jul" value="#res_fromYear[7]#">
<cfchartdata item="Aug" value="#res_fromYear[8]#">
<cfchartdata item="Sep" value="#res_fromYear[9]#">
<cfchartdata item="Oct" value="#res_fromYear[10]#">
<cfchartdata item="Nov" value="#res_fromYear[11]#">
<cfchartdata item="Dec" value="#res_fromYear[12]#">
</cfchartseries>

</cfchart>
</cfdocument>

<cfpdf action="write"
       source="hreport"
       destination="#Application.DirectoryRoot#PDF\RollCall\SightingsSummary.pdf" overwrite="yes"/>
<cfhttp url="#Application.DirectoryRoot#PDF\RollCall\SightingsSummary.pdf" 
        method="get" 
        getAsBinary="yes"
        file="SightingsSummary.pdf"/>

<cfheader name="Content-Disposition" value="attachment; filename=SightingsSummary.pdf" />
<cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\RollCall\SightingsSummary.pdf" />


<cfelseif FORM.Graph EQ "Download_graph_jpg_fromYear">
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
<cfchartdata item="Jan" value="#res_fromYear[1]#">
<cfchartdata item="Feb" value="#res_fromYear[2]#">
<cfchartdata item="Mar" value="#res_fromYear[3]#">
<cfchartdata item="Apr" value="#res_fromYear[4]#">
<cfchartdata item="May" value="#res_fromYear[5]#">
<cfchartdata item="Jun" value="#res_fromYear[6]#">
<cfchartdata item="Jul" value="#res_fromYear[7]#">
<cfchartdata item="Aug" value="#res_fromYear[8]#">
<cfchartdata item="Sep" value="#res_fromYear[9]#">
<cfchartdata item="Oct" value="#res_fromYear[10]#">
<cfchartdata item="Nov" value="#res_fromYear[11]#">
<cfchartdata item="Dec" value="#res_fromYear[12]#">
</cfchartseries>
</cfchart>
<cffile  
    action="WRITE"  
    file="#Application.DirectoryRoot#Graphs\RollCall\SightingsSummary.jpg"  
    output="#MyGraph#"> 
<cflocation url="/Graphs/RollCall/SightingsSummary.jpg" addtoken="no"> 

</cfif>
</CFIF>
<!-- begin ##content -->

<div id="content" class="content">
  <!-- begin breadcrumb -->
  <ol class="breadcrumb pull-right">
    <li><a href="javascript:;">Reporting</a></li>
    <li><a href="javascript:;">Roll Call Report</a></li>
  </ol>
  <!-- end breadcrumb -->
  <!-- begin page-header -->
  <h1 class="page-header">Roll Call Report</h1>
  <!-- end page-header -->
  <!-- begin row -->
    <cfif isdefined('msg') and msg NEQ ''>
      <div class="alert alert-danger"> <strong>Alert!</strong> <cfoutput>#msg#</cfoutput> </div>
    </cfif>
    <!-- begin row col-6-->
      <!-- begin panel -->
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
          <h4 class="panel-title">Filters </h4>
        </div>
        <div class="panel-body">
        
          <!-- start col-md-6 -->
          <cfoutput>
            <form action="" name="paginationform" method="POST" onsubmit="return checkForm()">
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
                  <input type="hidden" name="seentimes" value="#seentimes#" />
                  <input type="hidden" name="startHereIndex" value="1" />
                  <input type="submit" value="Submit" name="RollCall" class="btn btn-primary m-t-25" />
                </div>
                
                <div class="col-md-3" style="margin-bottom:-35px;margin-top:-27px">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Dolphins Sighted in #FORM.fromYear#</div>
                                <div class="widget-stat-number">#qgetRollCallGrapghFromYear.recordcount#</div>
                            </div>
                        </div>
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Dolphins Sighted in #FORM.toYear#</div>
                                <div class="widget-stat-number">#qgetRollCallGrapghEndYear.recordcount#</div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                
              </div>
              </div>
            </form>
            
      
    
         <div class="row">   
          <!-- begin  col-6-->
          <div class="col-lg-6"> <br>
            <br>
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> 
                <!---<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Graph" value="Download_graph_jpg_fromYear">
                <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                <input type="hidden" name="toYear" value="#FORM.toYear#" />
                <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                </form>
                <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Graph" value="Download_graph_pdf_fromYear">
                <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                <input type="hidden" name="toYear" value="#FORM.toYear#" />
                <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                </form>
--->                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Dolphin Sightings Summary of #FORM.fromYear#</h4>
              </div>
             
              <div class="panel-body">
                <div>
                  <canvas id="bar-chart_fromYear"></canvas>
                </div>
              </div>
            </div>
            <!-- end panel -->
                      
            </div>
          <!-- end  col-6 -->
          <!-- begin  col-6-->
          <div class="col-lg-6"> <br>
            <br>
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> 
                <!---<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Graph" value="Download_graph_jpg">
                <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                <input type="hidden" name="toYear" value="#FORM.toYear#" />
                <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                </form>
                <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Graph" value="Download_graph_pdf">
                <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                <input type="hidden" name="toYear" value="#FORM.toYear#" />
                <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                </form>--->
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Dolphin Sightings Summary of #FORM.toYear#</h4>
              </div>
             
              <div class="panel-body">
                <div>
                  <canvas id="bar-chart_toYear"></canvas>
                </div>
              </div>
            </div>
            <!-- end panel -->
                      
            </div>
          <!-- end  col-6 -->
		</div>
        <div class="row">
          <!-- begin  col-6-->
          <div class="col-lg-6"> <br>
            <br>
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> 
                <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Chart" value="Download_pie_chart_jpg_fromYear">
                <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                <input type="hidden" name="toYear" value="#FORM.toYear#" />
                <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                </form>
                <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Chart" value="Download_pie_chart_pdf_fromYear">
                <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                <input type="hidden" name="toYear" value="#FORM.toYear#" />
                <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                </form>
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Resident Summary for #fromYear#</h4>
              </div>
              <div class="panel-body">
                <div>
                 <canvas id="pie-chart-fromYear"></canvas>
                 <div id="legend-fromYear"></div>
                  
                </div>
              </div>
            </div>
           
            <!-- end panel -->
          </div>
          <!-- end  col-6 -->
          
          <!-- begin  col-6-->
          <div class="col-lg-6"> <br>
            <br>
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> 
                <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Chart" value="Download_pie_chart_jpg_toYear">
                <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                <input type="hidden" name="toYear" value="#FORM.toYear#" />
                <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                </form>
                <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Chart" value="Download_pie_chart_pdf_toYear">
                <input type="hidden" name="fromYear" value="#FORM.fromYear#" />
                <input type="hidden" name="toYear" value="#FORM.toYear#" />
                <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                </form>
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Resident Summary for #toYear#</h4>
              </div>
              <div class="panel-body">
                <div>
                 <canvas id="pie-chart-toYear"></canvas>
                 <div id="legend-toYear"></div>
                  
                </div>
              </div>
            </div>
           
            <!-- end panel -->
          </div>
          <!-- end  col-6 -->
          
           </div>
            
            <div class="row"> 
                <form action="" method="POST">
                    <div class="col-md-3 m-l-20"> <br>
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
                    </div>
                    <div class="col-md-3 pull-right m-t-15">
                        <input type="submit" value="Download as Excel" name="RollCall" class="btn btn-sucess m-t-25" />
                    </div> 
                </form>
            </div>
          </cfoutput>
          <!-- end col-md-6 -->
           <div class="row"> 
          <div class="col-md-12"> <br>
          <canvas id="myChart"></canvas>
            <br>
            <div class="panel pagination-inverse m-b-0 clearfix">
              <table data-order='[[1,"asc"]]' class="table table-bordered table-hover home_range_sec">
                <thead>
                  <tr class="inverse">
                    <th>Name</th>
                    <th>Code</th>
                    <th>Sex</th>
                    <th>Age</th>
                    <th>Seen Times</th>
                    <th>Home Range</th>
                  </tr>
                </thead>
                <tbody>
                  <cfif isdefined('QGETROLLCALL') AND isdefined('qgetRollCall.recordcount') AND qgetRollCall.recordcount NEQ 0 >
                    <cfoutput query="qgetRollCall" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                      <cfif YEAROFBIRTH NEQ '' AND IsNumeric(YEAROFBIRTH)>
                        <cfif IsDead	EQ 0 OR DeathYear EQ ''>
                          <cfset age = ReportEndyear - YEAROFBIRTH >
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
                      
                      <!---Calculate Home Range--->
					  <cfif SEEN_TIMES GT 0>
                      	 <cfset segments   = ["1A","1B","1C","2","3","4"]>
						 <cfset segmentVal = ArrayNew(1)>
                         <cfset segment_1A = 0>
                         <cfset segment_1B = 0>
                         <cfset segment_1C = 0>
                         <cfset segment_2  = 0>
                         <cfset segment_3  = 0>
                         <cfset segment_4  = 0>
                         <cfset home_range = 0>
                         <cfloop array="#segments#" index="i">
                            <cfset "segments_#i#" = NumberFormat((evaluate('segment_#i#')/SEEN_TIMES)*100,'0')>
                            <cfset ArrayAppend(segmentVal,evaluate('segments_#i#'))>
                            <cfif evaluate('segments_#i#') GT 50>
                                <cfset home_range = '<span class="segment_#i#">#i#</span>'>
                            </cfif>
                         </cfloop>
                         <cfif home_range eq 0>
                            <cfset isbreak = false >
                            <cfloop from="1" to="#arrayLen(segmentVal)#" index="i">
                                <cfloop from="1" to="5" index="j">
                                    <cfset currentSegment  = segmentVal[i]>
                                    <cfif ArrayIsDefined(segmentVal,i+j)>
                                        <cfset k = i+j>
                                    <cfelse>
                                        <cfset k = (i+j)-6>
                                    </cfif>
                                    <cfset comparedSegment = segmentVal[k]>
                                    <cfif (currentSegment + comparedSegment) GT 75>
                                        <cfset home_range = '<span class="segment_#segments[i]#">#segments[i]#</span><span class="seperator"> - </span><span class="segment_#segments[k]# right_segment">#segments[k]#</span>'>
                                        <cfset isbreak = true >
                                        <cfbreak>
                                    </cfif>
                                    <cfif isbreak>
                                        <cfbreak>
                                    </cfif>                
                                </cfloop>
                            </cfloop>
                         </cfif>
                      </cfif>
                      <!---Calculate Home Range---> 
                      
                      <cfset qdolphindetail = Application.Reporting.getRollCallSub(FORM.fromYear=FORM.fromYear,FORM.toYear=FORM.toYear,code=qgetRollCall.CODE)>
                      
                      <tr class="gradeU">
                        <td id="group_name"><a href="##collapse#qgetRollCall.currentrow#" data-toggle="collapse" class="dataToggle" id="#qgetRollCall.currentrow#">#qgetRollCall.NAME#</a></td>
                        <td id="group_name">#qgetRollCall.CODE#</td>
                        <td id="group_status">#qgetRollCall.SEX#</td>
                        <td id="group_status">#age#</td>
                        <td id="group_status">#qgetRollCall.SEEN_TIMES#</td>
                        <td class="home_range"><cfif home_range NEQ 0>#home_range#<cfelse>N/A</cfif></td>
                      </tr>
                      <tr id="collapse#qgetRollCall.currentrow#" class="panel-collapse collapse" >
                        <td colspan="8"><div class="table-responsive">
                            <table class="table table-sm">
                              <thead>
                                <tr>
                                  <th>##</th>
                                  <th>Sighting ID</th>
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
                                        <a href="javascript:void(0)" style="color:white" class="sighting-detail">#qdolphindetail.SIGHTING_ID#</a>
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
                          </div></td>
                      </tr>
                    </cfoutput>
                  </cfif>
                </tbody>
              </table>
              <form action="" method="post" name="paginationformmm">
                <input type="hidden" name="startHereIndex" value="1" />
              </form>
              <cfif isdefined('QGETROLLCALL') AND isdefined('qgetRollCall.recordcount') AND qgetRollCall.recordcount NEQ 0 >
                <cfset qpagination = qgetRollCall >
                <cfinclude template="../pagination.cfm">
              </cfif>
            </div>
          </div>
			</div>
          
        </div>
      </div>
      <!-- end panel -->
    <!-- end row col-6 -->
  <!-- end row -->
  <!-- begin ##footer -->
  <div id="footer" class="footer"> <span class="pull-right"> <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top"> <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span> </a> </span> &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved </div>
  <!-- end ##footer -->
</div>
<!-- end ##content -->








<div class="modal fade" id="seasonal">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body" id = 'pieslice'>
        
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- Seasonal modal -->

















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
</div><!--  Transients modal -->--->


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
</div><!--  Transients modal -->

<style>
.datacontainer{
    height: 350px; 
    overflow:auto; 
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


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>

<script>
var ctx = document.getElementById('bar-chart_fromYear').getContext('2d');
			var barChartData = {
			  labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
			  datasets: [{
			    type: 'bar',
			    label: 'Dolphin Sighted',
			    yAxisID: "y-axis-0",
			    backgroundColor: "rgba(217,83,79,0.75)",
			    data: res_fromYear
			  }, {
			    type: 'line',
			    label: 'Zones Survied',
			    yAxisID: "y-axis-1",
			    backgroundColor: "rgba(51,51,51,0.5)",
			    data: qgetRollCallGrapghCombineLineFromYear
			  }]
			};
			// allocate and initialize a chart
			var chart1 = new Chart(ctx, {
			  type: 'bar',
			  data: barChartData,
			  options: {
			    title: {
			      display: true
			    },
			    tooltips: {
			      mode: 'label'
			    },
			    responsive: true,
			    scales: {
			      xAxes: [{
			        stacked: true
			      }],
			      yAxes: [{
			        stacked: true,
			        position: "left",
			        id: "y-axis-0",
			      }, {
			        stacked: false,
			        position: "right",
			        id: "y-axis-1",
			      }]
			    }
			  }
			});;
    </script>
    <script>
var ctx = document.getElementById('bar-chart_toYear').getContext('2d');
			var barChartData = {
			  labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
			  datasets: [{
			    type: 'bar',
			    label: 'Dolphin Sighted',
			    yAxisID: "y-axis-0",
			    backgroundColor: "rgba(217,83,79,0.75)",
			    data: res_toYear
			  }, {
			    type: 'line',
			    label: 'Zones Survied',
			    yAxisID: "y-axis-1",
			    backgroundColor: "rgba(51,51,51,0.5)",
			    data: qgetRollCallGrapghCombineLineEndYear
			  }]
			};
			// allocate and initialize a chart
			var chart2 = new Chart(ctx, {
			  type: 'bar',
			  data: barChartData,
			  options: {
			    title: {
			      display: true
			    },
			    tooltips: {
			      mode: 'label'
			    },
			    responsive: true,
			    scales: {
			      xAxes: [{
			        stacked: true
			      }],
			      yAxes: [{
			        stacked: true,
			        position: "left",
			        id: "y-axis-0",
			      }, {
			        stacked: false,
			        position: "right",
			        id: "y-axis-1",
			      }]
			    }
			  }
			});;
    </script>


