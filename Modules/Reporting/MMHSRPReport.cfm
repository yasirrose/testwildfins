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
<cfset today = now()>
<cfparam name="filterStartYear" default="2004">
<cfparam name="filterEndYear" default="#year(now())#">
<cfparam name="filterMonthlyYear" default="2012">
<cfparam name="deadConditionStartYear" default="2012">
<cfparam name="deadConditionEndYear" default="#year(now())#">
<cfparam name="cohortStartYear" default="2012">
<cfparam name="cohortEndYear" default="#year(Now())#">
<cfparam name="ageAtDeathStartYear" default="2010">
<cfparam name="ageAtDeathEndYear" default="#year(now())#">
<cfparam name="deathBySegmentStartYear" default="2010">
<cfparam name="deathBySegmentEndYear" default="#year(now())#">


<cfparam name="cohortSex" default="-">
<!---<cfparam name="filterRecoveredYear" default="2012">--->
<cfset ReportStartyear = 1990>
<cfset ReportEndYear = year(now())>
<!------- Stock list--------->
<cfset getStock = Application.Sighting.getStock()>
<!------- Survey Type list--------->
<cfset getType=Application.Sighting.getType()>
<!------- Sub Survey Type list--------->
<cfset getSubType=Application.Sighting.getSubType()>
<!---  Survey area --->
<cfset getSurveyArea=Application.Sighting.getSurveyArea()>
<cfset totalyears =  filterEndYear - filterStartYear>
<cfset yeared_total_died_ = ''>
<cfset structLabel = ArrayNew(1)>
<cfset structData = ArrayNew(1)>
<cfset loopupto = filterEndYear-1>
<cfset appendyear = filterStartYear>

<cfif isdefined('dolphinCode')>
<cfset code = Form.dolphinCode>
<cfelse>
<cfset code = 0>
</cfif>
<cfset qGetDeadDolphins = Application.Reporting.DeadDolphins(appendyear,code)>
<cfset arrayappend(structLabel, appendyear)>
<cfset arrayappend(structData, qGetDeadDolphins.RecordCount)>
<cfloop from="#filterStartYear#" to="#loopupto#" index="i">
  <cfset appendyear++>
  <cfset arrayappend(structLabel, appendyear)>
  <cfset qGetDeadDolphins = Application.Reporting.DeadDolphins(appendyear,code)>
  <cfset arrayappend(structData, qGetDeadDolphins.RecordCount)>
</cfloop>
<!----------------- Recovered By Augencies ---------------->
<cfset EAI = 0>
<cfset HBOI = 0 >
<cfset Hubbs = 0 >
<cfset summary2 = [0,0,0] >
<cfset qGetRecoveredAgencyEAI = Application.Reporting.RecoveredAgencyEAI()>
<cfset qGetRecoveredAgencyHBOI = Application.Reporting.RecoveredAgencyHBOI()>
<cfset qGetRecoveredAgencyHubbs = Application.Reporting.RecoveredAgencyHubbs()>
<cfset EAI = qGetRecoveredAgencyEAI.RecordCount>
<cfset HBOI = qGetRecoveredAgencyHBOI.RecordCount >
<cfset Hubbs = qGetRecoveredAgencyHubbs.RecordCount >
<cfset summary2 = [EAI, HBOI, Hubbs]>
<!--- Body Condition of Dead Dolphins --->
<cfif isDefined("FORM.deadConditionStartYear")>
	<cfset conditionCode = Form.conditionCode>
    <cfset deadConditionStartYear = FORM.deadConditionStartYear>
	<cfset deadConditionEndYear = FORM.deadConditionEndYear>
<cfelse>
	<cfset conditionCode = 0>
</cfif>
<cfset qgetBodyConditionGrapgh = Application.Reporting.deadBodyConditions(deadConditionStartYear, deadConditionEndYear,conditionCode)>
<cfset summary3 		   = [0,0,0,0,0,0] >
<cfset aFetals 			   = ArrayNew(1) >
<cfset aBC 				   = ArrayNew(1) >
<cfset aXeno 			   = ArrayNew(1) >
<cfset aRDS 			   = ArrayNew(1) >
<cfset aREM 			   = ArrayNew(1) >
<cfset aFreshwound 		   = ArrayNew(1) >
<cfset dolphinsCode        = ArrayNew(1)>
<cfset dolphinsAge         = ArrayNew(1)>
<cfif qgetBodyConditionGrapgh.recordcount GT 0 >
  <cfquery name="qFetals" dbtype="query">
    SELECT * FROM qgetBodyConditionGrapgh where Fetals = 1
  </cfquery>
  <cfif qFetals.recordcount GT 0>
    <cfoutput query="qFetals">
      <cfset tt = StructNew() >
      <cfset tt['ID'] = qFetals.Dolphin_ID >
      <cfset tt['Name'] = qFetals.Name >
      <cfset tt['Code'] = qFetals.Code >
      <cfset tt['Sex'] = qFetals.Sex >
      <cfset tt['Sighting_ID'] = qFetals.Sighting_ID >
      <cfset tt['pro_id'] = qFetals.pro_id >
      <cfset ArrayAppend(aFetals,tt)>
    </cfoutput>
  </cfif>
  <cfquery name="qBC" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where BC = 1
                </cfquery>
  <cfif qBC.recordcount GT 0>
    <cfoutput query="qBC">
      <cfset s1 = StructNew() >
      <cfset s1['ID'] = qBC.Dolphin_ID >
      <cfset s1['Name'] = qBC.Name >
      <cfset s1['Code'] = qBC.Code >
      <cfset s1['Sex'] = qBC.Sex >
      <cfset s1['Sighting_ID'] = qBC.Sighting_ID >
      <cfset s1['pro_id'] = qBC.pro_id >
      <cfset  ArrayAppend(aBC,s1)>
    </cfoutput>
  </cfif>
  <cfquery name="qXeno" dbtype="query">
    SELECT * FROM qgetBodyConditionGrapgh where Xeno = 1
  </cfquery>
  <cfif qXeno.recordcount GT 0>
    <cfoutput query="qXeno">
      <cfset s2 = StructNew() >
      <cfset s2['ID'] = qXeno.Dolphin_ID >
      <cfset s2['Name'] = qXeno.Name >
      <cfset s2['Code'] = qXeno.Code >
      <cfset s2['Sex'] = qXeno.Sex >
      <cfset s2['Sighting_ID'] = qXeno.Sighting_ID >
      <cfset s2['pro_id'] = qXeno.pro_id >
      <cfset ArrayAppend(aXeno,s2)>
    </cfoutput>
  </cfif>
  <cfquery name="qRDS" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where RDS = 1
                </cfquery>
  <cfif qRDS.recordcount GT 0>
    <cfoutput query="qRDS">
      <cfset s3 = StructNew() >
      <cfset s3['ID'] = qRDS.Dolphin_ID >
      <cfset s3['Name'] = qRDS.Name >
      <cfset s3['Code'] = qRDS.Code >
      <cfset s3['Sex'] = qRDS.Sex >
      <cfset s3['Sighting_ID'] = qRDS.Sighting_ID >
      <cfset s3['pro_id'] = qRDS.pro_id >
      <cfset  ArrayAppend(aRDS,s3)>
    </cfoutput>
  </cfif>
  <cfquery name="qREM" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where REM = 1
                </cfquery>
  <cfif qREM.recordcount GT 0>
    <cfoutput query="qREM">
      <cfset s4 = StructNew() >
      <cfset s4['ID'] = qREM.Dolphin_ID >
      <cfset s4['Name'] = qREM.Name >
      <cfset s4['Code'] = qREM.Code >
      <cfset s4['Sex'] = qREM.Sex >
      <cfset s4['Sighting_ID'] = qREM.Sighting_ID >
      <cfset s4['pro_id'] = qREM.pro_id >
      <cfset  ArrayAppend(aREM,s4)>
    </cfoutput>
  </cfif>
  <cfquery name="qFreshwound" dbtype="query">
    SELECT * FROM qgetBodyConditionGrapgh where Freshwound = 1
  </cfquery>
  <cfif qFreshwound.recordcount GT 0>
    <cfoutput query="qFreshwound">
      <cfset s5 = StructNew() >
      <cfset s5['ID'] = qFreshwound.Dolphin_ID >
      <cfset s5['Name'] = qFreshwound.Name >
      <cfset s5['Code'] = qFreshwound.Code >
      <cfset s5['Sex'] = qFreshwound.Sex >
      <cfset s5['Sighting_ID'] = qFreshwound.Sighting_ID >
      <cfset s5['pro_id'] = qFreshwound.pro_id >
      <cfset ArrayAppend(aFreshwound,s5)>
    </cfoutput>
  </cfif>
  <cfset summary3 = [qFetals.recordcount,qBC.recordcount,qXeno.recordcount,qRDS.recordcount,qREM.recordcount,qFreshwound.recordcount] >
</cfif>
<!----------------- Monthly Based Query ----------------->
<cfset dateSelect = "1/1/#filterMonthlyYear#">
<cfset structMonthdata = ArrayNew(1)>
<cfif isdefined('byMonthCode')>
<cfset byMonthCode = Form.byMonthCode>
<cfelse>
<cfset byMonthCode = 0>
</cfif>

<cfloop from="1" to="12" index="i">
  <cfset qGetDeadDolphinsByMonth = Application.Reporting.DeadDolphinsByMonth(i, filterMonthlyYear,byMonthCode)>
  <cfset arrayappend(structMonthdata, qGetDeadDolphinsByMonth.RecordCount)>
</cfloop>
<!--- Death Dolphins Cohort ---->
<cfif isdefined('form.cohortName')>
<cfset cohortName = form.cohortName>
<cfelse>
<cfset cohortName = 'BOTH'>
</cfif>
<cfif cohortSex neq '-'>
  <cfset SearchingAge = Form.cohortEndYear-Form.cohortStartYear>
  <cfset qGetAgeSexCohort = Application.Reporting.AgeSexCohort(cohortSex, SearchingAge, cohortName)>
  <cfelse>
  <cfset qGetAgeSexCohort.RecordCount = 0>
</cfif>
<!--- Freez-Brand Recovered Dead --->
<cfif isdefined('form.freez')>

<cfset SearchingAge = Form.cohortEndYear-Form.cohortStartYear>
<cfset qGetfreezbrandRecovered = Application.Reporting.freezbrandRecovered(SearchingAge = SearchingAge, cName = cohortName,all = 0)>

<cfelse>
<cfset filterDate = cohortEndYear-cohortStartYear>
<cfset qGetfreezbrandRecovered = Application.Reporting.freezbrandRecovered(all = 1,freezDate = filterDate)>

</cfif>

<!---Dolphins Death Additional Section--->
<cfset qGetDolphinDeathBySex 	 = Application.Reporting.DolphinDeathBySex(cohortSex,cohortStartYear,cohortEndYear, cohortName)>
<cfset qGetDolphinAgeAtDeath 	 = Application.Reporting.DolphinAgeAtDeath(ageAtDeathStartYear,ageAtDeathEndYear)>
<cfset qGetDolphinDeathBySegment = Application.Reporting.DolphinDeathBySegment(deathBySegmentStartYear,deathBySegmentEndYear)>

<cfset Male_Sex    	 		  = 0>
<cfset Female_Sex  	 		  = 0>
<cfset unKnown_Sex 	 		  = 0>
<cfset dolphinsCode  		  = ArrayNew(1)>
<cfset dolphinsAge   		  = ArrayNew(1)>
<cfset dolphinsCodeBySegment  = ["1A","1B","1C","2","3","4"]>
<cfset dolphinsDeathBySegment = [0,0,0,0,0,0]>
<cfif qGetDolphinDeathBySex.recordcount gt 0>
    <cfloop query="qGetDolphinDeathBySex">
        <cfif sex EQ 'M'>
            <cfset Male_Sex++>
        <cfelseif sex EQ 'F'>
            <cfset Female_Sex++>
        <cfelseif sex EQ 'U'>
            <cfset unKnown_Sex++>
        </cfif>           
    </cfloop>
</cfif>
<cfloop query="qGetDolphinAgeAtDeath">
	<cfset arrayappend(dolphinsCode,Code)>
    <cfset arrayappend(dolphinsAge,AgeAtDeath)>
</cfloop>

<cfloop query="qGetDolphinDeathBySegment">
	<cfif ZSEGMENT EQ "1A">
        <cfset dolphinsDeathBySegment[1] = deathCount >
    </cfif>
    <cfif ZSEGMENT EQ "1B">
        <cfset dolphinsDeathBySegment[2] = deathCount >
    </cfif>
    <cfif ZSEGMENT EQ "1C">
        <cfset dolphinsDeathBySegment[3] = deathCount >
    </cfif>
    <cfif ZSEGMENT EQ "2">
        <cfset dolphinsDeathBySegment[4] = deathCount >
    </cfif>
    <cfif ZSEGMENT EQ "3">
        <cfset dolphinsDeathBySegment[5] = deathCount >
    </cfif>
    <cfif ZSEGMENT EQ "4">
        <cfset dolphinsDeathBySegment[6] = deathCount >
    </cfif>
</cfloop>
<!---<cfif cgi.REMOTE_ADDR eq '202.141.226.196'><cfdump var="#dolphinsCode#"><cfdump var="#dolphinsAge#"></cfif>--->

<!---Dolphins Death Additional Section--->

<script>
    <cfoutput>
	    var #toScript(structLabel, "structLabel")#; 
		var #toScript(structData, "structData")#;
		var #toScript(structMonthdata, "structMonthdata")#;
		var #toScript(summary2, "summary2")#;
		var #toScript(summary3, "summary3")#;
		var #toScript(dolphinsCode, "dolphinsCode")#;
		var #toScript(dolphinsAge, "dolphinsAge")#;
		var #toScript(dolphinsCodeBySegment, "dolphinsCodeBySegment")#;
		var #toScript(dolphinsDeathBySegment, "dolphinsDeathBySegment")#;
    </cfoutput>    
</script>
<CFIF isdefined('FORM.Graph1')>
  <cfif FORM.Graph1 EQ "Download_graph_pdf">
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
    <cfset in = 1>
    <cfchart yaxistitle="% over artemis" format="png" chartwidth="700" chartheight="700" scalefrom="0" scaleto="#structMonthdata[12]#" plot="#plot#">
    <cfchartseries
  type="bar"
  >
    <cfloop array="#structLabel#" index="lab">
      <cfchartdata item="#lab#" value="#structData[in]#">
      <cfset in += 1>
    </cfloop>
    </cfchartseries>
    </cfchart>
    </cfdocument>
    <cfpdf action="write"
       source="hreport"
       destination="#Application.DirectoryRoot#PDF\MMHSRP\DeathYearlySummary.pdf" overwrite="yes"/>
    <cfhttp url="#Application.DirectoryRoot#PDF\MMHSRP\DeathYearlySummary.pdf" 
        method="get" 
        getAsBinary="yes"
        file="DeathYearlySummary.pdf"/>
        <cfheader name="Content-Disposition" value="attachment; filename=DeathYearlySummary.pdf" />
    <cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\MMHSRP\DeathYearlySummary.pdf" />
    <cfelseif FORM.Graph1 EQ "Download_graph_jpg">
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
    <cfset in = 1>
    <cfchart name="MyGraph" format="jpg" scalefrom="0" scaleto="#structMonthdata[12]#" chartwidth="700" chartheight="700" plot="#plot#" showBorder="yes">
    <cfchartseries
  type="bar"
  >
    <cfloop array="#structLabel#" index="lab">
      <cfchartdata item="#lab#" value="#structData[in]#">
      <cfset in += 1>
    </cfloop>
    </cfchartseries>
    </cfchart>
    <cffile  
    action="WRITE"  
    file="#Application.DirectoryRoot#Graphs\MMHSRP\DeathYearlySummary.jpg"  
    output="#MyGraph#">
    <cflocation url="/Graphs/MMHSRP/DeathYearlySummary.jpg" addtoken="no">
  </cfif>
</CFIF>
<CFIF isdefined('FORM.Graph2')>
  <cfif FORM.Graph2 EQ "Download_graph_pdf">
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
    <cfchart yaxistitle="% over artemis" format="png" chartwidth="700" chartheight="700" scalefrom="0" scaleto="#structMonthdata[12]#" plot="#plot#">
    <cfchartseries
  type="bar"
  >
    <cfchartdata item="Jan" value="#structMonthdata[1]#">
    <cfchartdata item="Feb" value="#structMonthdata[2]#">
    <cfchartdata item="Mar" value="#structMonthdata[3]#">
    <cfchartdata item="Apr" value="#structMonthdata[4]#">
    <cfchartdata item="May" value="#structMonthdata[5]#">
    <cfchartdata item="Jun" value="#structMonthdata[6]#">
    <cfchartdata item="Jul" value="#structMonthdata[7]#">
    <cfchartdata item="Aug" value="#structMonthdata[8]#">
    <cfchartdata item="Sep" value="#structMonthdata[9]#">
    <cfchartdata item="Oct" value="#structMonthdata[10]#">
    <cfchartdata item="Nov" value="#structMonthdata[11]#">
    <cfchartdata item="Dec" value="#structMonthdata[12]#">
    </cfchartseries>
    </cfchart>
    </cfdocument>
    <cfpdf action="write"
       source="hreport"
       destination="#Application.DirectoryRoot#PDF\MMHSRP\DeathSummary.pdf" overwrite="yes"/>
    <cfhttp url="#Application.DirectoryRoot#PDF\MMHSRP\DeathSummary.pdf" 
        method="get" 
        getAsBinary="yes"
        file="DeathSummary.pdf"/>
        <cfheader name="Content-Disposition" value="attachment; filename=DeathSummary.pdf" />
    <cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\MMHSRP\DeathSummary.pdf" />
    <cfelseif FORM.Graph2 EQ "Download_graph_jpg">
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
    <cfchart name="MyGraph" format="jpg" scalefrom="0" scaleto="#structMonthdata[12]#" chartwidth="700" chartheight="700" plot="#plot#" showBorder="yes">
    <cfchartseries
  type="bar"
  >
    <cfchartdata item="Jan" value="#structMonthdata[1]#">
    <cfchartdata item="Feb" value="#structMonthdata[2]#">
    <cfchartdata item="Mar" value="#structMonthdata[3]#">
    <cfchartdata item="Apr" value="#structMonthdata[4]#">
    <cfchartdata item="May" value="#structMonthdata[5]#">
    <cfchartdata item="Jun" value="#structMonthdata[6]#">
    <cfchartdata item="Jul" value="#structMonthdata[7]#">
    <cfchartdata item="Aug" value="#structMonthdata[8]#">
    <cfchartdata item="Sep" value="#structMonthdata[9]#">
    <cfchartdata item="Oct" value="#structMonthdata[10]#">
    <cfchartdata item="Nov" value="#structMonthdata[11]#">
    <cfchartdata item="Dec" value="#structMonthdata[12]#">
    </cfchartseries>
    </cfchart>
    <cffile  
    action="WRITE"  
    file="#Application.DirectoryRoot#Graphs\MMHSRP\DeathSummary.jpg"  
    output="#MyGraph#">
    <cflocation url="/Graphs/MMHSRP/DeathSummary.jpg" addtoken="no">
  </cfif>
</CFIF>
<!--- Recovered Chart Agencies --->
<cfif isdefined("FORM.Chart1")>
  <cfif Form.Chart1 EQ "Download_chart_jpg">
    <cfchart name="myChart" format="jpg" chartwidth="700" chartheight="700">
    <cfchartseries type="pie">
    <cfchartdata item="EAI" value="#summary2[1]#">
    <cfchartdata item="HBOI" value="#summary2[2]#">
    <cfchartdata item="Hubbs" value="#summary2[3]#">
    </cfchartseries>
    </cfchart>
    <cffile action="WRITE" file="#Application.DirectoryRoot#Charts\MMHSRP\RecoveredDolphins.jpg"
	output="#myChart#">
    <cflocation url="/Charts/MMHSRP/RecoveredDolphins.jpg" addtoken="no">
    <cfelseif Form.Chart1 EQ "Download_chart_pdf">
    <cfdocument name="hreport" format="PDF">
    <cfchart yaxistitle="% over artemis" format="png" chartheight="700" chartwidth="700">
    <cfchartseries type="pie">
    <cfchartdata item="EAI" value="#summary2[1]#">
    <cfchartdata item="HBOI" value="#summary2[2]#">
    <cfchartdata item="Hubbs" value="#summary2[3]#">
    </cfchartseries>
    </cfchart>
    </cfdocument>
    <cfpdf action="write" source="hreport" destination="#Application.DirectoryRoot#PDF\MMHSRP\RecoveredDolphins.pdf" overwrite="yes"/>
    <cfhttp url="#Application.DirectoryRoot#PDF\MMHSRP\RecoveredDolphins.pdf" method="get" getasbinary="yes" file="RecoveredDolphins.pdf"/>
        <cfheader name="Content-Disposition" value="attachment; filename=RecoveredDolphins.pdf"/>
    <cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\MMHSRP\RecoveredDolphins.pdf"/>
    <cflocation url="/PDF/MMHSRP/RecoveredDolphins.pdf" addtoken="no">
  </cfif>
</cfif>
<!--- Dead Body Condition --->
<cfif isDefined("FORM.Chart2")>
  <cfif FORM.Chart2 EQ "Download_chart_jpg">
    <cfchart name="myChart" chartheight="700" chartwidth="700" format="jpg">
    <cfchartseries type="pie">
    <cfchartdata item="Fetals" value="#summary3[1]#">
    <cfchartdata item="BC" value="#summary3[2]#">
    <cfchartdata item="Xeno" value="#summary3[3]#">
    <cfchartdata item="RDS" value="#summary3[4]#">
    <cfchartdata item="REM" value="#summary3[5]#">
    <cfchartdata item="Fresh wound" value="#summary3[6]#">
    </cfchartseries>
    </cfchart>
    <cffile action="WRITE" file="#Application.DirectoryRoot#\Charts\MMHSRP\DeadBodyCondition.jpg" output="#myChart#">
    <cflocation url="/Charts/MMHSRP/DeadBodyCondition.jpg" addtoken="no">
    <cfelseif FORM.Chart2 EQ "Download_chart_pdf">
    <cfdocument name="hreport2" format="PDF">
    <cfchart yaxistitle="% over artemis" format="png" chartheight="700" chartwidth="700">
    <cfchartseries type="pie">
    <cfchartdata item="Fetals" value="#summary3[1]#">
    <cfchartdata item="BC" value="#summary3[2]#">
    <cfchartdata item="Xeno" value="#summary3[3]#">
    <cfchartdata item="RDS" value="#summary3[4]#">
    <cfchartdata item="REM" value="#summary3[5]#">
    </cfchartseries>
    </cfchart>
    </cfdocument>
    <cfpdf action="write" source="hreport2" destination="#Application.DirectoryRoot#PDF\MMHSRP\DeadBodyCondition.pdf" overwrite="yes"/>
    <cfhttp url="#Application.DirectoryRoot#PDF\MMHSRP\DeadBodyCondition.pdf" method="get" getasbinary="yes" file="DeadBodyCondition.pdf"/>
        <cfheader name="Content-Disposition" value="attachment; filename=DeadBodyCondition.pdf"/>
    <cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\MMHSRP\DeadBodyCondition.pdf"/>
    <cflocation url="/PDF/MMHSRP/DeadBodyCondition.pdf" addtoken="no">
  </cfif>
</cfif>

<cfoutput>
  <!-- begin ##content -->
  
  <div id="content" class="content"> 
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">MMHSRP</a></li>
      <li><a href="javascript:;">MMHSRP Report</a></li>
    </ol>
    <!-- end breadcrumb --> 
    <!-- begin page-header -->
    <h1 class="page-header">MMHSRP Report </h1>
    <!-- end page-header --> 
    
    <!-- begin row -->
    <div class="row"> 
      
      <!-- begin row col-6-->
      <div class="row col-lg-12"> 
        <!-- begin panel -->
        <div class="panel panel-inverse">
          <div class="panel-heading">
            <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
            <h4 class="panel-title">Filters </h4>
          </div>
          <div class="panel-body">
            <div class="row"> 
              
              <!-- begin col-6 --->
              <div class="col-lg-6 m-t-30">
                    <form name="Deathcohort" id="Deathcohort" action="" method="POST">
                      <div class="row">
                        <div class="col-md-4">
                          <label>Sex</label>
                          <select class="form-control" name="cohortSex" id="cohortSex" style="width: 100%;">
                            <option value="-" <cfif cohortSex eq '-'>selected</cfif>>-</option>
                            <option value="F" <cfif cohortSex eq 'F'>selected</cfif>>F</option>
                            <option value="M" <cfif cohortSex eq 'M'>selected</cfif>>M</option>
                          </select>
                        </div>
                        <!---<div class="col-md-4">
                          <label>Birth Year</label>
                          <select class="form-control" name="cohortStartYear" id="cohortStartYear" style="width: 120%;">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif cohortStartYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>--->
                        <div class="col-md-4">
                          <label>Death Year</label>
                          <select class="form-control" name="cohortStartYear" id="cohortStartYear" style="width: 100%;">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif cohortStartYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>Death Year</label>
                          <select class="form-control" name="cohortEndYear" id="cohortEndYear" style="width: 100%;">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif cohortEndYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>Name</label>
                          <select class="form-control" name="cohortName" id="cohortName" style="width: 100%;">
                          <option value="BOTH" <cfif cohortName eq 'BOTH'>selected</cfif>>BOTH</option>
                            <option value="UNK" <cfif cohortName eq 'UNK'>selected</cfif>>UNKNOWN</option>
                            <option value="NK" <cfif cohortName eq 'NK'>selected</cfif>>KNOWN</option>
                            
                          </select>
                        </div>
                        <div class="col-md-4">
                          <input type="submit" value="Submit" name="MMHSRP" id="MMHSRP" class="btn btn-primary m-t-25" />
                        </div>
                      </div>
                    </form>
                    <div class="col-md-8 col-md-offset-2 m-t-30"> 
                      <!-- begin widget -->
                      <div class="widget widget-stat bg-success text-white">
                        <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                        <div class="widget-stat-info count-by-sex">
						  <!---<div class="widget-stat-title">Dolphin Death Cohort</div>
                          <div class="widget-stat-number">#qGetAgeSexCohort.RecordCount#</div>--->
                            <div class="dis-table">
                                <div class="dis-cell">
                                  <div class="widget-stat-title">Male</div>
                                  <div class="widget-stat-number">#Male_Sex#</div>
                                </div>
                                <div class="dis-cell">
                                  <div class="widget-stat-title">Female</div>
                                  <div class="widget-stat-number">#Female_Sex#</div>
                                </div>
                                <div class="dis-cell">
                                  <div class="widget-stat-title">Unknown</div>
                                  <div class="widget-stat-number">#unKnown_Sex#</div>
                                </div>
                            </div>
                         </div>
                      </div>
                      <!-- end widget --> 
                    </div>
                    <!---<div>
                          <canvas id="bar-chart2"></canvas>
                          
                        </div>---> 
              </div>
              <!-- End col-6---> 
              <!-- begin col-6 --->
              
              <div class="col-lg-6 m-t-30">
                    <form name="Deathcohort" id="Deathcohort" action="" method="POST">
                      <div class="row"> 
                        <!---<div class="col-md-4">
                                	<label>Sex</label>
                                    <select class="form-control" name="cohortSex" id="cohortSex">
                                    	<option value="-" <cfif cohortSex eq '-'>selected</cfif>>-</option>
                                        <option value="F" <cfif cohortSex eq 'F'>selected</cfif>>F</option>
                                        <option value="M" <cfif cohortSex eq 'M'>selected</cfif>>M</option>
                                    </select>
                                </div>--->
                        <input type="hidden" value="freez" name="freez" />
                        <!---<div class="col-md-4">
                          <label>Birth Year</label>
                          <select class="form-control" name="cohortStartYear" id="cohortStartYear" style="width: 120%;">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif cohortStartYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>--->
                        <div class="col-md-4">
                          <label>Death Year</label>
                          <select class="form-control" name="cohortStartYear" id="cohortStartYear" style="width: 100%;">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif cohortStartYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>Death Year</label>
                          <select class="form-control" name="cohortEndYear" id="cohortEndYear" style="width: 100%;">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif cohortEndYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                       <div class="col-md-4">
                          <label>Name</label>
                          <select class="form-control" name="cohortName" id="cohortName" style="width: 100%;">
                          <option value="BOTH" <cfif cohortName eq 'BOTH'>selected</cfif>>BOTH</option>
                            <option value="UNK" <cfif cohortName eq 'UNK'>selected</cfif>>UNKNOWN</option>
                            <option value="NK" <cfif cohortName eq 'NK'>selected</cfif>>KNOWN</option>
                            
                          </select>
                        </div>
                        <div class="col-md-4">
                          <input type="submit" value="Submit" name="MMHSRP" id="MMHSRP" class="btn btn-primary m-t-25" />
                        </div>
                      </div>
                    </form>
                    <div class="col-md-8 col-md-offset-2 m-t-30"> 
                      <!-- begin widget -->
                      <div class="widget widget-stat bg-success text-white">
                        <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                        <div class="widget-stat-info">
                          <div class="widget-stat-title">Freeze-Brands Recovered Dead</div>
                          <div class="widget-stat-number">#qGetfreezbrandRecovered.RecordCount#</div>
                        </div>
                      </div>
                      <!-- end widget --> 
                    </div>
                    <!---<div>
                          <canvas id="bar-chart2"></canvas>
                          
                        </div>---> 
              </div>
              
              <!-- end col-6 --> 
              
              <!---Age At Death Graph--->
              
              <!-- begin  col-6-->
              <div class="col-lg-12 m-t-30">
                <div class="panel panel-inverse">
                  <div class="panel-heading">
                    <div class="panel-heading-btn">
                      <!---<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Graph1" value="Download_graph_jpg">
                        <input type="hidden" name="filterStartYear" value="#filterStartYear#" />
                        <input type="hidden" name="filterEndYear" value="#filterEndYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                      </form>
                      <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Graph1" value="Download_graph_pdf">
                        <input type="hidden" name="filterStartYear" value="#filterStartYear#" />
                        <input type="hidden" name="filterEndYear" value="#filterEndYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                      </form>--->
                      <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                    <h4 class="panel-title">Dolphin Age At Death</h4>
                  </div>
                  <div class="panel-body">
                    <form name="DeathRateByYear" id="" action="" method="POST">
                      <div class="col-md-12">
                        <div class="col-md-4">
                          <label>Start Year</label>
                          <select class="form-control" name="ageAtDeathStartYear" id="ageAtDeathStartYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif ageAtDeathStartYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>End year</label>
                          <select class="form-control" name="ageAtDeathEndYear" id="ageAtDeathEndYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif ageAtDeathEndYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <input type="submit" value="Submit" name="btnAgeAtDeath" id="btnAgeAtDeath" class="btn btn-primary m-t-25" />
                        </div>
                      </div>
                    </form>
                    <div>
                      <canvas id="barChartDeathAge"></canvas>
                    </div>
                  </div>
                </div>
                <!-- End  col-6--> 
              </div>
              <!-- begin  col-6-->
              
              <!---Age At Death Graph--->
              
              <!---Death Per Segment Graph--->
              
              <!-- begin  col-6-->
              <div class="col-lg-12 m-t-30">
                <div class="panel panel-inverse">
                  <div class="panel-heading">
                    <div class="panel-heading-btn">
                      <!---<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Graph1" value="Download_graph_jpg">
                        <input type="hidden" name="filterStartYear" value="#filterStartYear#" />
                        <input type="hidden" name="filterEndYear" value="#filterEndYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                      </form>
                      <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Graph1" value="Download_graph_pdf">
                        <input type="hidden" name="filterStartYear" value="#filterStartYear#" />
                        <input type="hidden" name="filterEndYear" value="#filterEndYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                      </form>--->
                      <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                    <h4 class="panel-title">Dolphin Death By Segment</h4>
                  </div>
                  <div class="panel-body">
                    <form name="DeathRateByYear" id="" action="" method="POST">
                      <div class="col-md-12">
                        <div class="col-md-4">
                          <label>Start Year</label>
                          <select class="form-control" name="deathBySegmentStartYear" id="deathBySegmentStartYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif deathBySegmentStartYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>End year</label>
                          <select class="form-control" name="deathBySegmentEndYear" id="deathBySegmentEndYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif deathBySegmentEndYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <input type="submit" value="Submit" name="btnDeathBySegment" id="btnDeathBySegment" class="btn btn-primary m-t-25" />
                        </div>
                      </div>
                    </form>
                    <div>
                      <canvas id="barChartDeathBySegment"></canvas>
                    </div>
                  </div>
                </div>
                <!-- End  col-6--> 
              </div>
              <!-- begin  col-6-->
              
              <!---Death Per Segment Graph--->
              
              <!-- begin col-6--->
              <div class="col-lg-6 m-t-30">
                <div class="panel panel-inverse">
                  <div class="panel-heading">
                    <div class="panel-heading-btn">
                      <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Chart1" value="Download_chart_jpg">
                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                      </form>
                      <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Chart1" value="Download_chart_pdf">
                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                      </form>
                      <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                    <h4 class="panel-title">Dolphins Recovered By Agencies</h4>
                  </div>
                  
                  <!---<div class="panel-body">
                           <div class="col-md-12">
                           <form name="RecoveredByYear" id="" action="" method="POST">
                                <div class="col-md-4">
                                  <label>Select Year</label>
              
                                  <select class="form-control" name="filterRecoveredYear" id="filterRecoveredYear">
                                    <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                                    	<cfif filterRecoveredYear eq i>
                                      		<option value="#i#" selected="selected">#i#</option>
                                        <cfelse>
                                        	<option value="#i#">#i#</option>
                                        </cfif>
                                    </cfloop>
                                  </select>
                                </div>
                                <div class="col-md-4">
                                  <input type="submit" value="Submit" name="MMHSRP" class="btn btn-primary m-t-25" />
                                </div>
                                </form>
                                </div>
                        <div>--->
                  <canvas id="pie-chart" style="margin-top:2%;"></canvas>
                  <br />
                  <div id="legend"></div>
                </div>
              </div>
              <!-- End col-6 --> 
              <!-- begin  col-6-->
              <div class="col-lg-6 m-t-30">
                <div class="panel panel-inverse">
                  <div class="panel-heading">
                    <div class="panel-heading-btn">
                      <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Graph1" value="Download_graph_jpg">
                        <input type="hidden" name="filterStartYear" value="#filterStartYear#" />
                        <input type="hidden" name="filterEndYear" value="#filterEndYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                      </form>
                      <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Graph1" value="Download_graph_pdf">
                        <input type="hidden" name="filterStartYear" value="#filterStartYear#" />
                        <input type="hidden" name="filterEndYear" value="#filterEndYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                      </form>
                      <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                    <h4 class="panel-title">Dolphin Death rate by Year</h4>
                  </div>
                  <div class="panel-body">
                    <form name="DeathRateByYear" id="" action="" method="POST">
                      <div class="col-md-12">
                        <div class="col-md-4">
                          <label>Start Year</label>
                          <select class="form-control" name="filterStartYear" id="filterStartYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif filterStartYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>End year</label>
                          <select class="form-control" name="filterEndYear" id="filterEndYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif filterEndYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>Name</label>
                          <select class="form-control" name="dolphinCode" id="dolphinCode" style="width: 100%;">
                          <option value="BOTH" <cfif code eq 'BOTH'>selected</cfif>>BOTH</option>
                            <option value="UNK" <cfif code eq 'UNK'>selected</cfif>>UNKNOWN</option>
                            <option value="NK" <cfif code eq 'NK'>selected</cfif>>KNOWN</option>
                            
                          </select>
                        </div>
                        <div class="col-md-4">
                          <input type="submit" value="Submit" name="MMHSRP" id="MMHSRP" class="btn btn-primary m-t-25" />
                        </div>
                      </div>
                    </form>
                    <div>
                      <canvas id="bar-chart"></canvas>
                    </div>
                  </div>
                </div>
                <!-- End  col-6--> 
              </div>
              <!-- begin  col-6-->
              <div class="col-lg-6 m-t-30">
                <div class="panel panel-inverse">
                  <div class="panel-heading">
                    <div class="panel-heading-btn">
                      <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Graph2" value="Download_graph_jpg">
                        <input type="hidden" name="filterMonthlyYear" value="#filterMonthlyYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                      </form>
                      <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Graph2" value="Download_graph_pdf">
                        <input type="hidden" name="filterMonthlyYear" value="#filterMonthlyYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                      </form>
                      <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                    <h4 class="panel-title">Dolphin Death rate by Month</h4>
                  </div>
                  <div class="panel-body">
                    <div class="col-md-12">
                      <form name="DeathRateByYear" id="" action="" method="POST">
                        <div class="col-md-4">
                          <label>Select Year</label>
                          <select class="form-control" name="filterMonthlyYear" id="filterMonthlyYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif filterMonthlyYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>Name</label>
                          <select class="form-control" name="byMonthCode" id="byMonthCode">
                          <option value="BOTH" <cfif byMonthCode eq 'BOTH'>selected</cfif>>BOTH</option>
                            <option value="UNK" <cfif byMonthCode eq 'UNK'>selected</cfif>>UNKNOWN</option>
                            <option value="NK" <cfif byMonthCode eq 'NK'>selected</cfif>>KNOWN</option>
                            
                          </select>
                        </div>
                        <div class="col-md-4">
                          <input type="submit" value="Submit" name="RollCall" class="btn btn-primary m-t-25" />
                        </div>
                      </form>
                    </div>
                    <div>
                      <canvas id="bar-chart1"></canvas>
                    </div>
                  </div>
                </div>
                <!-- End  col-6--> 
              </div>
              <!-- End --> 
              <!-- begin col-6 -->
              
              <div class="col-lg-6 m-t-30">
                <div class="panel panel-inverse">
                  <div class="panel-heading">
                    <div class="panel-heading-btn">
                      <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Chart2" value="Download_chart_jpg">
                        <input type="hidden" name="deadConditionStartYear" value="#deadConditionStartYear#" />
                        <input type="hidden" name="deadConditionEndYear" value="#deadConditionEndYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                      </form>
                      <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                        <input type="hidden" name="Chart2" value="Download_chart_pdf">
                        <input type="hidden" name="deadConditionStartYear" value="#deadConditionStartYear#" />
                        <input type="hidden" name="deadConditionEndYear" value="#deadConditionEndYear#" />
                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                      </form>
                      <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                    <h4 class="panel-title">Dolphin Death Body Condition</h4>
                  </div>
                  <div class="panel-body">
                    <form name="DeathBodyConditions" id="DeathBodyConditions" action="" method="POST">
                      <div class="col-md-12">
                        <div class="col-md-4">
                          <label>Start Year</label>
                          <select class="form-control" name="deadConditionStartYear" id="deadConditionStartYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif deadConditionStartYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        
                        <div class="col-md-4">
                          <label>End year</label>
                          <select class="form-control" name="deadConditionEndYear" id="deadConditionEndYear">
                            <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                              <cfif deadConditionEndYear eq i>
                                <option value="#i#" selected="selected">#i#</option>
                                <cfelse>
                                <option value="#i#">#i#</option>
                              </cfif>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4">
                          <label>Name</label>
                          <select class="form-control" name="conditionCode" id="conditionCode">
                          <option value="BOTH" <cfif conditionCode eq 'BOTH'>selected</cfif>>BOTH</option>
                            <option value="UNK" <cfif conditionCode eq 'UNK'>selected</cfif>>UNKNOWN</option>
                            <option value="NK" <cfif conditionCode eq 'NK'>selected</cfif>>KNOWN</option>
                            
                          </select>
                        </div>
                        <div class="col-md-4">
                          <input type="submit" value="Submit" name="MMHSRP2" id="MMHSRP2" class="btn btn-primary m-t-25" />
                        </div>
                      </div>
                    </form>
                    <div>
                      <canvas id="pie-chart2" style="margin-top:2%;"></canvas>
                      <br />
                      <div id="legend2"></div>
                    </div>
                  </div>
                </div>
                <!-- End  col-6--> 
              </div>
              
              <!-- End col-6--> 
            </div>
            <!-- End  col-6--> 
          </div>
        </div>
        <!-- end row-----> 
      </div>
    </div>
    <!-- end row --> 
    <!-- begin ##footer -->
    <div id="footer" class="footer"> <span class="pull-right"> <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top"> <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span> </a> </span> &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved </div>
    <!-- end ##footer --> 
    <!-- end ##content --> 
  </div>
  <!--- EAI --->
  <div class="modal fade" id="EAI">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">Dolphins Recovered By Agencies</h4>
        </div>
        <div class="modal-body">
          <table  class="table table-striped table-bordered" >
            <tr>
              <td width="80"><b>Code</b></td>
              <td width="100"><b>Name</b></td>
              <td width="120"><b>Date of Death</b></td>
              <td width="250"><b>Field ID</b></td>
              <td width="50"><b>Sex</b></td>
            </tr>
          </table>
          <div class="datacontainer">
            <table class="table table-striped table-bordered">
              <cfoutput>
                <cfloop query="qGetRecoveredAgencyEAI">
                  <tr>
                    <td width="80">#qGetRecoveredAgencyEAI.Code#</td>
                    <td width="100">#qGetRecoveredAgencyEAI.Name#</td>
                    <td width="120">#qGetRecoveredAgencyEAI.deathdate#</td>
                    <td width="250">#qGetRecoveredAgencyEAI.FieldID#</td>
                    <td width="50">#qGetRecoveredAgencyEAI.Sex#</td>
                  </tr>
                </cfloop>
              </cfoutput>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!--- HBOI --->
  <div class="modal fade" id="HBOI">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">Dolphins Recovered By Agencies</h4>
        </div>
        <div class="modal-body">
          <table  class="table table-striped table-bordered" >
            <tr>
              <td width="80"><b>Code</b></td>
              <td width="100"><b>Name</b></td>
              <td width="120"><b>Date of Death</b></td>
              <td width="250"><b>Field ID</b></td>
              <td width="50"><b>Sex</b></td>
            </tr>
          </table>
          <div class="datacontainer">
            <table class="table table-striped table-bordered">
              <cfoutput>
                <cfloop query="qGetRecoveredAgencyHBOI">
                  <tr>
                    <td width="80">#qGetRecoveredAgencyHBOI.Code#</td>
                    <td width="100">#qGetRecoveredAgencyHBOI.Name#</td>
                    <td width="120">#qGetRecoveredAgencyHBOI.deathdate#</td>
                    <td width="250">#qGetRecoveredAgencyHBOI.FieldID#</td>
                    <td width="50">#qGetRecoveredAgencyHBOI.Sex#</td>
                  </tr>
                </cfloop>
              </cfoutput>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!--- Hubbs --->
  <div class="modal fade" id="Hubbs">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">Dolphins Recovered By Agencies</h4>
        </div>
        <div class="modal-body">
          <table  class="table table-striped table-bordered" >
            <tr>
              <td width="80"><b>Code</b></td>
              <td width="100"><b>Name</b></td>
              <td width="120"><b>Date of Death</b></td>
              <td width="250"><b>Field ID</b></td>
              <td width="50"><b>Sex</b></td>
            </tr>
          </table>
          <div class="datacontainer">
            <table class="table table-striped table-bordered">
              <cfoutput>
                <cfloop query="qGetRecoveredAgencyHubbs">
                  <tr>
                    <td width="80">#qGetRecoveredAgencyHubbs.Code#</td>
                    <td width="100">#qGetRecoveredAgencyHubbs.Name#</td>
                    <td width="120">#qGetRecoveredAgencyHubbs.deathdate#</td>
                    <td width="250">#qGetRecoveredAgencyHubbs.FieldID#</td>
                    <td width="50">#qGetRecoveredAgencyHubbs.Sex#</td>
                  </tr>
                </cfloop>
              </cfoutput>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!---- Dead dolphins Conitions---->
  <div class="modal fade" id="fetal">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">Fetal Dolphins</h4>
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
              <cfif ArrayLen(aFetals) NEQ 0 >
                <cfloop from="1" to="#ArrayLen(aFetals)#" index="i">
                  <cfoutput>
                    <tr>
                      <td width="80">#i#</td>
                      <td width="100">#aFetals[i].code#</td>
                      <td width="120"><form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                          <input type="hidden" name="project_id" value="#aFetals[i].pro_id#">
                          <input type="hidden" name="sight_id" value="#aFetals[i].Sighting_ID#">
                          <a href="javascript:void(0)" class="sighting-detail">#aFetals[i].Sighting_ID#</a>
                        </form></td>
                      <td width="250">#aFetals[i].name#</td>
                      <td width="50">#aFetals[i].sex#</td>
                    </tr>
                  </cfoutput>
                </cfloop>
              </cfif>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!--  Fetals modal -->
  
  <div class="modal fade" id="bc">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">BC Dolphins</h4>
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
              <cfif ArrayLen(aBC) NEQ 0 >
                <cfloop from="1" to="#ArrayLen(aBC)#" index="i">
                  <cfoutput>
                    <tr>
                      <td width="80">#i#</td>
                      <td width="100">#aBC[i].code#</td>
                      <td width="120"><form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                          <input type="hidden" name="project_id" value="#aBC[i].pro_id#">
                          <input type="hidden" name="sight_id" value="#aBC[i].Sighting_ID#">
                          <a href="javascript:void(0)" class="sighting-detail">#aBC[i].Sighting_ID#</a>
                        </form></td>
                      <td width="250">#aBC[i].name#</td>
                      <td width="50">#aBC[i].sex#</td>
                    </tr>
                  </cfoutput>
                </cfloop>
              </cfif>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!--  BC modal -->
  
  <div class="modal fade" id="xeno">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">Xeno Dolphins</h4>
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
              <cfif ArrayLen(aXeno) NEQ 0 >
                <cfloop from="1" to="#ArrayLen(aXeno)#" index="i">
                  <cfoutput>
                    <tr>
                      <td width="80">#i#</td>
                      <td width="100">#aXeno[i].code#</td>
                      <td width="120"><form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                          <input type="hidden" name="project_id" value="#aXeno[i].pro_id#">
                          <input type="hidden" name="sight_id" value="#aXeno[i].Sighting_ID#">
                          <a href="javascript:void(0)" class="sighting-detail">#aXeno[i].Sighting_ID#</a>
                        </form></td>
                      <td width="250">#aXeno[i].name#</td>
                      <td width="50">#aXeno[i].sex#</td>
                    </tr>
                  </cfoutput>
                </cfloop>
              </cfif>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!--  Xeno modal -->
  
  <div class="modal fade" id="rds">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">RDS Dolphins</h4>
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
              <cfif ArrayLen(aRDS) NEQ 0 >
                <cfloop from="1" to="#ArrayLen(aRDS)#" index="i">
                  <cfoutput>
                    <tr>
                      <td width="80">#i#</td>
                      <td width="100">#aRDS[i].code#</td>
                      <td width="120"><form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                          <input type="hidden" name="project_id" value="#aRDS[i].pro_id#">
                          <input type="hidden" name="sight_id" value="#aRDS[i].Sighting_ID#">
                          <a href="javascript:void(0)" class="sighting-detail">#aRDS[i].Sighting_ID#</a>
                        </form></td>
                      <td width="250">#aRDS[i].name#</td>
                      <td width="50">#aRDS[i].sex#</td>
                    </tr>
                  </cfoutput>
                </cfloop>
              </cfif>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!--  RDS modal -->
  
  <div class="modal fade" id="rem">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">REM Dolphins</h4>
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
              <cfif ArrayLen(aREM) NEQ 0 >
                <cfloop from="1" to="#ArrayLen(aREM)#" index="i">
                  <cfoutput>
                    <tr>
                      <td width="80">#i#</td>
                      <td width="100">#aREM[i].code#</td>
                      <td width="120"><form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                          <input type="hidden" name="project_id" value="#aREM[i].pro_id#">
                          <input type="hidden" name="sight_id" value="#aREM[i].Sighting_ID#">
                          <a href="javascript:void(0)" class="sighting-detail">#aREM[i].Sighting_ID#</a>
                        </form></td>
                      <td width="250">#aREM[i].name#</td>
                      <td width="50">#aREM[i].sex#</td>
                    </tr>
                  </cfoutput>
                </cfloop>
              </cfif>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!--  REM modal -->
  
  <div class="modal fade" id="freshwound">
    <div class="modal-dialog" role="document" style="width:55%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
          <h4 class="modal-title">Freshwound Dolphins</h4>
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
              <cfif ArrayLen(aFreshwound) NEQ 0 >
                <cfloop from="1" to="#ArrayLen(aFreshwound)#" index="i">
                  <cfoutput>
                    <tr>
                      <td width="80">#i#</td>
                      <td width="100">#aFreshwound[i].code#</td>
                      <td width="120"><form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                          <input type="hidden" name="project_id" value="#aFreshwound[i].pro_id#">
                          <input type="hidden" name="sight_id" value="#aFreshwound[i].Sighting_ID#">
                          <a href="javascript:void(0)" class="sighting-detail">#aFreshwound[i].Sighting_ID#</a>
                        </form></td>
                      <td width="250">#aFreshwound[i].name#</td>
                      <td width="50">#aFreshwound[i].sex#</td>
                    </tr>
                  </cfoutput>
                </cfloop>
              </cfif>
            </table>
          </div>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <!--  Fresh wound modal --> 
  <!--Death By Segments Model-->
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
  <!--Death By Segments Model-->
  
</cfoutput>