
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<cfset variables.dsn = "wildfins_new">
<!--- <cfset variables.dsn = "live_wildfins_test">/ --->
<cfset getAreaName =  Application.Sighting.getAreaName()>
<cfset getSurveyArea = Application.Sighting.getSurveyArea()>
<cfset getSurveyType = Application.Sighting.getType()>
<cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>
<cfset getSurveyRouteData = Application.StaticDataNew.getSurveyRoute()>
<cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>

<cfset qGetAssocBioData=Application.SightingNew.qGetAssocBioData()>
<cfset getBehaviorsData = Application.StaticDataNew.getBehavior()>

<cfset getPreySpeciesData = Application.StaticDataNew.getPreySpecies()>
<cfset StructureList = Application.SightingNew.getStructureList()>

<cfset qCetaceanResponseToFisher=Application.SightingNew.qCetaceanResponseToFisher()>
<cfset qFisherResponseToCetacean=Application.SightingNew.qFisherResponseToCetacean()>
<cfset qCetaceanResponseToVessel=Application.SightingNew.qCetaceanResponseToVessel()>
<cfset qVesselResponseToCetacean=Application.SightingNew.qVesselResponseToCetacean()>

<cfset getPlateForm=Application.StaticDataNew.getPlateForm()>
<cfset getStock = Application.StaticDataNew.getStock()>

<!---  Head Condition   --->
<cfset getHeadNuchalCrest = Application.ConditionLesions.getHeadNuchalCrest()>
<cfset getHeadLateralCervicalReg = Application.ConditionLesions.getHeadLateralCervicalReg()>
<cfset getHeadFacialBones = Application.ConditionLesions.getHeadFacialBones()>
<cfset getHeadEarOS = Application.ConditionLesions.getHeadEarOS()>
<cfset getHeadChinSkinFolds = Application.ConditionLesions.getHeadChinSkinFolds()>
<!---  Body Condition   --->
<cfset getBodyEpaxialMuscle = Application.ConditionLesions.getBodyEpaxialMuscle()>
<cfset getBodyDorsalRidgeScapula = Application.ConditionLesions.getBodyDorsalRidgeScapula()>
<cfset getBodyRibs = Application.ConditionLesions.getBodyRibs()>
<!---  Tail Condition   --->
<cfset getTailTransversePro = Application.ConditionLesions.getTailTransversePro()>

<cfquery name="cetaceans" datasource="#Application.dsn#">
    select ID,Code,Name from Cetaceans order by Code ASC
</cfquery>
<cfquery name="RTmembers" datasource="#Application.dsn#">
    SELECT * from TLU_ResearchTeamMembers
</cfquery>
<cfquery name="users" datasource="#Application.dsn#">
    SELECT * from users
</cfquery>
<cfquery name="lesionRegion" datasource="#Application.dsn#">
    SELECT * from TLU_Regions
</cfquery>

<cfoutput>
    <form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="exc" id="exc" method="post">
        <div class="form-row">
            <div class="col-lg-10 col-md-10 col-sm-10 text-right">
                <button type="submit" name="excelExport" value ="Download as Exce" class="btn btn-success width-100 m-r-5  ml-auto" id="add">Run</button>
            </div>
            <div class="col-lg-1 col-md-11 col-sm-11 text-right">
                <button type="reset" name="reset" value ="reset" class="btn btn-success width-100 m-r-5  ml-auto" >Clear</button>
            </div>
        </div>
    </form>
</cfoutput> 

<cfif isdefined('FORM.excelExport')>
    
    <cfquery datasource="#variables.dsn#" name="qFiltered">
    SELECT
	s.ID AS SurveyID,
	s.DATE,
	s.SurveyRoute,
	s.BodyOfWater,
	s.Platform,
	s.NOAAStock,
	s.SurveyType,
	ss.Survey AS SurveyEffort,
	s.SurveyType,
	s.EngineOn,
	s.EngineOff,
	s.SurveyStart,
	s.SurveyEnd,
	s.ResearchTeam,
	ss.SightingNumber,
	ss.ID AS sightingID,
	ss.SightingStart,
	ss.SightingEnd,
	ss.ICW_Start,
	ss.Location,
	ss.InitialLatitude,
	ss.InitialLongitude,
	ss.AtLatitude,
	ss.AtLongitude,
	ss.EndLatitude,
	ss.EndLongitude,
	ss.WaterTemp,
	ss.Comments,
	w.[Desc] AS Weather,
	wh.[Desc] AS WaveHeight,
	g.[Desc] AS Glare,
	gd.[Desc] AS GlareDirection,
	st.[Desc] AS Sightability,
	bt.[Desc] AS Beaufort,
	ss.HabitatDepth,
	ht.HabitatName,
	ss.AirTemp,
	ss.WindSpeed,
	gdw.[Desc] AS WindDirection,
	td.TideName,
	ss.Salinity,
	ih.HeadingName AS InitialHeading,
	gh.GHeadingName AS GeneralHeading,
	fh.FHeadingName AS FinalHeading,
	ss.AssocBio,
	FE_TotalCetaceans_Max,
	FE_TotalCetaceans_Min,
	FE_TotalCetacean_Best,
	FE_TotalCetacean_takes,
	FE_TotalCalves_Max,
	FE_TotalCalves_Min,
	FE_TotalCalves_Best,
	FE_TotalCalves_takes,
	FE_YoungOfYear_Min,
	FE_YoungOfYear_Max,
	FE_YoungOfYear_Best,
	FE_YoungOfYear_takes,
	Act_Mill,
	Act_Feed,
	Act_Rest,
	Act_Other,
	Act_Social,
	Act_Travel,
	Act_Prob_Feed,
	Act_With_Boat,
	Act_Avoid_Boat,
	Act_Object_Play,
	Behaviors,
	PreySpecies,
	Feeding_Lat,
	Feeding_Long,
	srts.Name as Structure_Present,
	NoOfCetaceansWithIn100mOfActiveFisher,
	NoOfFishers,
	crtf.[Desc] as CetaceanResponseToFisher,
	
	frtc.[Desc] as FisherResponseToCetacean,
	Depredation,
	NoOfCetaceansWithIn100mOfRecreationVessels,
	NumberOfVessels,
	crtv.[Desc] as CetaceanResponseToVessel,
	
	vrtc.[Desc] as VesselResponseToCetacean,
	No_of_Cetaceans_wHBOI_Vessel,
	Reaction_to_HBOI_Vessel,
	cm.Camera,
	lns.Lens,
	rtp.RT_MemberName AS Photographer,
	rtd.RT_MemberName AS Driver,
	ss.EnteredBy AS CompletedBy,
	cs.SDR,
	cs.BestSighting,
	c.Code,
	tlu.CetaceanSpeciesName,
	c.Sex,
	cs.Fetals,
	c.DScore,
	c.FB_Number,
	cs.wMom,
	cs.Note,
	cs.pq_focus,
	cs.pq_Angle,
	cs.pq_Contrast,
	cs.pq_Proportion,
	cs.pq_Partial,
	cs.pqSum,
	cs.Qscore,
	cs.BestShoot,
	concat(enby.first_name,enby.last_name) as EnteredBy,
	concat(ianaly.first_name,ianaly.last_name) as PhotoAnalysisInitial,
	concat(fanaly.first_name,fanaly.last_name) as PhotoAnalysisFinal,
	cs.bodyCondition,
	hncr.HNC_Name as Head_NuchalCrest,
	hlcr.HLCR_Name as Head_LateralCervicalReg,
	hfb.HFB_Name as Head_FacialBones,
	heos.HEOS_Name as Head_EarOS,
	hcsf.HCSF_Name as Head_ChinSkinFolds,
	bem.BEM_Name as Body_EpaxialMuscle,
	bdrs.BDRS_Name as Body_DorsalRidgeScapula,
	br.BR_Name as Body_Ribs,
	ttp.TTP_Name as Tail_TransversePro,
	cl.LesionPresent,
	cl.LesionType,
	cl.Region,
	cl.Side_L_R,
	cl.Status
FROM
	Surveys s
	LEFT JOIN Survey_Sightings ss ON s.ID= ss.Project_ID
	LEFT JOIN Cetacean_Sightings cs ON ss.SightingNumber= cs.SightingNumber
	LEFT JOIN Cetaceans c ON cs.Cetaceans_ID= c.ID
	LEFT JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
	LEFT JOIN Condition_Lesions cl ON ( cs.Cetaceans_ID= cl.Cetaceans_ID AND cs.Sighting_ID= cl.Sighting_ID )
	LEFT JOIN TLU_Camera cm ON cm.ID = ss.Camera
	LEFT JOIN TLU_Lens lns ON lns.ID = ss.Lens
	LEFT JOIN TLU_Regions rg ON rg.ID = cl.Region
	LEFT JOIN TLU_Weather w ON w.ID = ss.Weather
	LEFT JOIN TLU_WaveHight wh ON wh.ID = ss.WaveHeight
	LEFT JOIN TLU_Glare g ON g.ID = ss.Glare
	LEFT JOIN TLU_GlareDirection gd ON gd.ID = ss.GlareDirection
	LEFT JOIN TLU_Sightability st ON st.ID = ss.Sightability
	LEFT JOIN TLU_Beaufort bt ON bt.ID = ss.Beaufort
	LEFT JOIN TLU_Habitat ht ON ht.HabitatID = ss.HabitatType
	LEFT JOIN TLU_GlareDirection gdw ON gdw.ID = ss.WindDirection
	LEFT JOIN TLU_Tide td ON td.TideID = ss.Tide
	LEFT JOIN TLU_Heading ih ON ih.ID = ss.InitialHeading
	LEFT JOIN TLU_GeneralHeading gh ON gh.ID = ss.GeneralHeading
	LEFT JOIN TLU_FinalHeading fh ON fh.ID = ss.FinalHeading
	LEFT JOIN TLU_ResearchTeamMembers rtp ON rtp.RT_ID = ss.Photographer
	LEFT JOIN TLU_ResearchTeamMembers rtd ON rtd.RT_ID = ss.Driver 
	left join TLU_CetaceanResponseToFisher crtf on crtf.ID=ss.CetaceanResponseToFisher
	left join TLU_FisherResponseToCetacean frtc on frtc.id=ss.FisherResponseToCetacean
	left join TLU_CetaceanResponseToVessel crtv on crtv.id=ss.CetaceanResponseToVessel
	left join TLU_VesselResponseToCetacean vrtc on vrtc.id=ss.VesselResponseToCetacean
	left join users enby on enby.user_id = cs.EnteredBy
	left join users ianaly on ianaly.user_id = cs.PhotoAnalysisInitial
	left join users fanaly on fanaly.user_id = cs.PhotoAnalysisFinal
	left join TLU_HeadNuchalCrest hncr on hncr.ID = cs.Head_NuchalCrest
	left join TLU_HeadLateralCervicalReg hlcr on hlcr.ID= cs.Head_LateralCervicalReg
	left join TLU_HeadFacialBones hfb on hfb.ID=cs.Head_FacialBones
	left join TLU_HeadEarOS heos on heos.ID=cl.Head_EarOS
	left join TLU_HeadChinSkinFolds hcsf on hcsf.ID=cs.Head_ChinSkinFolds
	left join TLU_BodyEpaxialMuscle bem on bem.ID = cs.Body_EpaxialMuscle
	left join TLU_BodyDorsalRidgeScapula bdrs on bdrs.ID = cs.Body_DorsalRidgeScapula
	left join TLU_BodyRibs br on br.ID=cs.Body_Ribs
	left join TLU_TailTransversePro ttp on ttp.ID= cs.Tail_TransversePro
	left join TLU_Structures srts on srts.ID = ss.Structure_Present
	ORDER BY
	s.ID DESC
  </cfquery>
    <cfloop query="qFiltered">
        <cfset Date = #dateformat(DATE, "yyyy-mm-dd")#>
        <cfset QuerySetCell(qFiltered, "DATE", #Date#, qFiltered.currentRow)>

        <cfset bd = listToArray(#BodyOfWater#, ",", false, true)>
        <cfset AreaNameA = arrayNew(1,false)>
        <cfloop query="getAreaName">
            <cfif ArrayContains(bd,#ID#)>
               <cfset arn = ArrayAppend(AreaNameA,#AreaName#,"true")> 
            </cfif>
        </cfloop>
        <cfset df = arrayToList(AreaNameA,"\")>
        <cfset QuerySetCell(qFiltered, "BodyOfWater", #df#, qFiltered.currentRow)>

        <cfset bd = listToArray(#SurveyRoute#, ",", false, true)>
        <cfset SurveyRouteA = arrayNew(1,false)> 
        <cfloop query="getSurveyRouteData">
            <cfif ArrayContains(bd,#ID#)>
                <cfset arn = ArrayAppend(SurveyRouteA,#ROUTENAME#,"true")>
            </cfif>
        </cfloop>
         <cfset df = arrayToList(SurveyRouteA,"\")>
        <cfset QuerySetCell(qFiltered, "SurveyRoute", #df#, qFiltered.currentRow)>

        <cfset bd = listToArray(#ResearchTeam#, ",", false, true)>
        <cfset ResearchTeamA = arrayNew(1,false)> 
        <cfloop query="RTmembers">
            <cfif ArrayContains(bd,#RT_ID#)>
                <cfset arn = ArrayAppend(ResearchTeamA,#RT_MemberName#,"true")>
            </cfif>
        </cfloop>
         <cfset df = arrayToList(ResearchTeamA,"\")>
        <cfset QuerySetCell(qFiltered, "ResearchTeam", #df#, qFiltered.currentRow)>

        <cfset bd = listToArray(#AssocBio#, ",", false, true)>
        <cfset AssocBioA = arrayNew(1,false)> 
        <cfloop query="qGetAssocBioData">
            <cfif ArrayContains(bd,#ASSOCBIOID#)>
                <cfset arn = ArrayAppend(AssocBioA,#ASSOCBIONAME#,"true")>
            </cfif>
        </cfloop>
         <cfset df = arrayToList(AssocBioA,"\")>
        <cfset QuerySetCell(qFiltered, "AssocBio", #df#, qFiltered.currentRow)>

        <cfset bd = listToArray(#Behaviors#, ",", false, true)>
        <cfset BehaviorsA = arrayNew(1,false)> 
        <cfloop query="getBehaviorsData">
            <cfif ArrayContains(bd,#ID#)>
                <cfset arn = ArrayAppend(BehaviorsA,#BehaviorName#,"true")>
            </cfif>
        </cfloop>
         <cfset df = arrayToList(BehaviorsA,"\")>
        <cfset QuerySetCell(qFiltered, "Behaviors", #df#, qFiltered.currentRow)>

        <cfset bd = listToArray(#PreySpecies#, ",", false, true)>
        <cfset PreySpeciesA = arrayNew(1,false)> 
        <cfloop query="getPreySpeciesData">
            <cfif ArrayContains(bd,#ID#)>
                <cfset arn = ArrayAppend(PreySpeciesA,#PreySpeciesName#,"true")>
            </cfif>
        </cfloop>
         <cfset df = arrayToList(PreySpeciesA,"\")>
        <cfset QuerySetCell(qFiltered, "PreySpecies", #df#, qFiltered.currentRow)>

        <cfset bd = listToArray(#Structure_Present#, ",", false, true)>
        <cfset Structure_PresentA = arrayNew(1,false)> 
        <cfloop query="StructureList">
            <cfif ArrayContains(bd,#ID#)>
                <cfset arn = ArrayAppend(Structure_PresentA,#Name#,"true")>
            </cfif>
        </cfloop>
         <cfset df = arrayToList(Structure_PresentA,"\")>
        <cfset QuerySetCell(qFiltered, "Structure_Present", #df#, qFiltered.currentRow)>


        <cfif "#bodyCondition#" eq 1>
            <cfset QuerySetCell(qFiltered, "bodyCondition","Emaciated", qFiltered.currentRow)>                           Emaciated
        </cfif>
        <cfif "#bodyCondition#" eq 2>
            <cfset QuerySetCell(qFiltered, "bodyCondition","Underweight/Thin", qFiltered.currentRow)>
        </cfif>
        <cfif "#bodyCondition#" eq 3>
            <cfset QuerySetCell(qFiltered, "bodyCondition","Ideal", qFiltered.currentRow)>
        </cfif>
        <cfif "#bodyCondition#" eq 4>
            <cfset QuerySetCell(qFiltered, "bodyCondition","Overweight", qFiltered.currentRow)>
        </cfif>
        <cfif "#bodyCondition#" eq 5>
            <cfset QuerySetCell(qFiltered, "bodyCondition","Obese", qFiltered.currentRow)>
        </cfif>
        <cfif "#bodyCondition#" eq 6>
            <cfset QuerySetCell(qFiltered, "bodyCondition","CBD", qFiltered.currentRow)>
        </cfif>

        <cfset bd = listToArray(#Region#, ",", false, true)>
        <cfset RegionA = arrayNew(1,false)> 
        <cfloop query="lesionRegion">
            <cfif ArrayContains(bd,#ID#)>
                <cfset arn = ArrayAppend(RegionA,#RegionName#,"true")>
            </cfif>
        </cfloop>
         <cfset df = arrayToList(RegionA,"\")>
        <cfset QuerySetCell(qFiltered, "Region", #df#, qFiltered.currentRow)>
    </cfloop>
    
</cfif>

<div class="footer" id="footer">
    <span class="pull-right">
        <a data-click="scroll-top" class="btn-scroll-to-top" href="javascript:;">
            <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
        </a>
    </span>
    &copy;
    <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
</div>

<CFIF isdefined('FORM.excelExport')>  


  <cfscript>
      theSheet = SpreadsheetNew("AllDataReport");
      SpreadsheetAddRow(theSheet,ArrayToList(qFiltered.getColumnList()));
      SpreadsheetFormatRow( theSheet, {bold=TRUE, alignment="center"}, 1 );
      SpreadSheetAddAutoFilter(theSheet,"A1:F1");
      
      SpreadSheetSetColumnWidth(theSheet,"2",35);
      SpreadsheetAddRows(theSheet,qFiltered);
    </cfscript> 
    <cffile  action="write" file = "C:\home\wildfins.org\subdomains\dev-wildfins\Reports\AllDataReport.xls" output="theSheet">
    <cfheader name="Content-Disposition" value="attachment; filename=AllDataReport.xls"> 
    <cfcontent type="application/vnd.ms-excel" variable="#SpreadsheetReadBinary( theSheet )#"> 
</CFIF>
