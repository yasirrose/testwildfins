<cfsetting requesttimeout="3600">
<cfset showForm = true>
<cfset counter = 0>
<cfset missing =''>
<cfif structKeyExists(form, "xlsfile") and len(form.xlsfile)>

<!--- Destination outside of web root --->

    <cffile action="upload" destination="#Application.CloudDirectory#" filefield="xlsfile" result="upload" nameconflict="makeunique">
    <cfif upload.fileWasSaved>
        <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
        <cfif right(theFile,3) eq 'xls' or right(theFile,4) eq 'xlsx'>
            <cfspreadsheet action="read" src="#theFile#" query="exceldata" headerrow="1">
            <cfset showForm = false>
        <cfelse>
            <cfset errors = "The file was not an Excel file.">
            <cffile action="delete" file="#theFile#">
        </cfif>
    <cfelse>
        <cfset errors="the file was not uploaded successfully">
    </cfif>
</cfif>
<cfif showForm>
    <cfif <!---structKeyExists(variables, "errors")--->isdefined("errors") and errors NEQ "">
        <cfoutput>
            <p>
            <b style="text-align: center;">Error: #errors#</b>
        </p>
        </cfoutput>
    </cfif>
    <form action="" enctype="multipart/form-data" method="post" style="margin-left: 300px">
        <div class="form-group">
            <label for=""> Upload Utility </label>
            <input id="upload-utility-4" class="file-loading" type="file"  name="xlsfile"  required>
        </div>
        <br>
        <div class="form-group">
            <input type="submit" class="btn btn-success" value="Upload XLS File">
        </div>
    </form>

    <br>
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-8">
                <div class="download-butns-custom">
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal" id="excelval">Export to Excel</button>
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" id="exceltmp" data-target="#myModal">Download Template</button>
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" id="exceldel" data-target="#myModal">Delete Data</button>
                </div>
            </div>

            <div class="col-md-4">
            </div>
            <div class="col-md-4">

            </div>
        </div>
    </div>

    <br>
<cfelse>
    <cfif exceldata.recordCount is 1>
        <p>no recrod</p>
    <cfelse>

         <cftry>
         	 <cfquery name="qTurnOnInsert" datasource="#Application.dsn#">
                SET IDENTITY_INSERT SIGHTINGS ON
             </cfquery>
             <cfloop query="exceldata" startrow="2">
                
				<cfset Photo_Coverage_Grade     = exceldata['Photo Coverage Grade'][currentRow]>
                <cfset Data_Initial     		= exceldata['Data Initial'][currentRow]>
                <cfset Data_Final               = exceldata['Data Final'][currentRow]>
                <cfset Zone_IDD 			    = Application.StaticData.getZoneByName(exceldata.Zone_id)>
				<cfset AssocBioData11 			= Application.StaticData.getAssocBioByName(exceldata.AssocBioData1)>
                <cfset AssocBioData22 			= Application.StaticData.getAssocBioByName(exceldata.AssocBioData2)>
                <cfset AssocBioData33 		    = Application.StaticData.getAssocBioByName(exceldata.AssocBioData3)>
                <cfquery datasource="#Application.dsn#" name="insertsighting" result="insert">
                   insert into SIGHTINGS
                    (
                     ID,SightingNumber,Zone_id,Survey,Project_ID,StartTime,EndTime,Location,[Photo Coverage Grade],NumberOfBoats,
                     DistanceToClosestBoat,Easting_X,Northing_Y,Begin_LAT_H,Begin_LAT_M,Begin_LAT_S,Begin_LAT_Dec,End_LAT_H,End_LAT_M,
                     End_LAT_S,End_LAT_Dec,Begin_LON_H,Begin_LON_M,Begin_LON_S,Begin_LON_Dec,End_LON_H,End_LON_M,End_LON_S,End_LON_Dec,
                     ICW_Begin,ICW_End,FE_TotalDolphin_Min,FE_TotalDolphin_Max,FE_TotalDolphin_Best,FE_TotalCalves_Min,FE_TotalCalves_Max,
                     FE_TotalCalves_Best,FE_YoungOfYear_Min,FE_YoungOfYear_Max,FE_YoungOfYear_Best,Photo_TotalDolphins_PosID,Photo_TotalCalves_PosID,
                     Photo_YoungOfYear_PosID,Photo_TotalDolphins_MinNotIDed,Photo_TotalCalves_MinNotIDed,Photo_YoungOfYear_MinNotIDed,Photo_TotalDolphins_MaxNotIDed,
                     Photo_TotalCalves_MaxNotIDed,Photo_YoungOfYear_MaxNotIDed,Photo_TotalDolphins_RevisedMin,Photo_TotalCalves_RevisedMin,Photo_YoungOfYear_RevisedMin,
                     Photo_TotalDolphins_RevisedMax,Photo_TotalCalves_RevisedMax,Photo_YoungOfYear_RevisedMax,Photo_TotalDolphins_FinalBest,
                     Photo_TotalCalves_FinalBest,Photo_YoungOfYear_FinalBest,Depth,WaterTemp,Salinity,Heading,AssociateOrg,AssocBioData1,AssocBioData2,
                     AssocBioData3,WaveHeight,Beaufort,Glare,Sightability,Weather,Fisheries_None,Fisheries_RecTrolling,Fisheries_RecAnchored,
                     Fisheries_CrabTraps,Fisheries_CrabWork,Activity_Avoid_Boat,Activity_Mill,Activity_Feed,Activity_ProbFeed,Activity_Travel,
                     Activity_Play,Activity_Rest,Activity_Leap_tailslap_chuff,Activity_Social,Activity_WithBoat,Activity_Other,Photo_Grade,
                     Photo_Analysis,Photo_Analysis_Final,Date_Entered,SDO_Initial,SDO_Final,[Data Initial],[Data Final],Body_Condition_Initial,
                     Body_Condition_Final,ARCVIEW_Initial,Notes,Total_Takes_A,Total_Takes_B,Zone,Takes,Herding,Depredation,Driver,Photographer,
                     analyzed,EastingInit_X,NorthingInit_Y,EastingEnd_X,NorthingEnd_Y,InitDDLAT_X,InitDDLONG_Y,EndDDLAT_X,EndDDLONG_Y,HeadingGen,
                     HeadingInit,HeadingFinal,GlareDirection,SalinityPPT,AirTemp,Conductivity,DepthFT,WindsSpeed,TideDirection,TideHeight,WindDirection,
                     Habitat,Activity_Herding,Activity_Depre,EnteredBy
                     )
                   values(
                   <cfqueryparam value='#ID#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.ID   EQ "", true, false)#'>,
                   <cfqueryparam value='#SightingNumber#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.SightingNumber EQ "", true, false)#' >,
                   <cfqueryparam value='#Zone_IDD#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Zone_id EQ "", true, false)#'>,
                   <cfqueryparam value='#Survey#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Survey EQ "", true, false)#'>,
                   <cfqueryparam value='#Project_ID#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Project_ID EQ "", true, false)#'>,
                   <cfqueryparam value='#StartTime#' cfsqltype="cf_sql_timestamp" null='#IIF(exceldata.StartTime EQ "", true, false)#'>,
                   <cfqueryparam value='#EndTime#' cfsqltype="cf_sql_timestamp" null='#IIF(exceldata.EndTime EQ "", true, false)#'>,
                   <cfqueryparam value='#Location#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Location EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_Coverage_Grade#' cfsqltype="cf_sql_smallint" null='#IIF(Photo_Coverage_Grade EQ "", true, false)#'>,
                   <cfqueryparam value='#NumberOfBoats#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.NumberOfBoats EQ "", true, false)#'>,
                   <cfqueryparam value='#DistanceToClosestBoat#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.DistanceToClosestBoat EQ "", true, false)#'>,
                   <cfqueryparam value='#Easting_X#' cfsqltype="cf_sql_float" null='#IIF(exceldata.Easting_X EQ "", true, false)#'>,
                   <cfqueryparam value='#Northing_Y#' cfsqltype="cf_sql_float" null='#IIF(exceldata.Northing_Y EQ "", true, false)#'>,
                   <cfqueryparam value='#Begin_LAT_H#' cfsqltype="cf_sql_float" null='#IIF(exceldata.Begin_LAT_H EQ "", true, false)#'>,
                   <cfqueryparam value='#Begin_LAT_M#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.Begin_LAT_M EQ "", true, false)#'>,
                   <cfqueryparam value='#Begin_LAT_S#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.Begin_LAT_S EQ "", true, false)#'>,
                   <cfqueryparam value='#Begin_LAT_Dec#' cfsqltype="cf_sql_float" null='#IIF(exceldata.Begin_LAT_Dec EQ "", true, false)#'>,
                   <cfqueryparam value='#End_LAT_H#' cfsqltype="cf_sql_float" null='#IIF(exceldata.End_LAT_H EQ "", true, false)#'>,
                   <cfqueryparam value='#End_LAT_M#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.End_LAT_M EQ "", true, false)#'>,
                   <cfqueryparam value='#End_LAT_S#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.End_LAT_S EQ "", true, false)#'>,
                   <cfqueryparam value='#End_LAT_Dec#' cfsqltype="cf_sql_float" null='#IIF(exceldata.End_LAT_Dec EQ "", true, false)#'>,
                   <cfqueryparam value='#Begin_LON_H#' cfsqltype="cf_sql_float" null='#IIF(exceldata.Begin_LON_H EQ "", true, false)#'>,
                   <cfqueryparam value='#Begin_LON_M#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.Begin_LON_M EQ "", true, false)#'>,
                   <cfqueryparam value='#Begin_LON_S#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.Begin_LON_S EQ "", true, false)#'>,
                   <cfqueryparam value='#Begin_LON_Dec#' cfsqltype="cf_sql_float" null='#IIF(exceldata.Begin_LON_Dec EQ "", true, false)#'>,
                   <cfqueryparam value='#End_LON_H#' cfsqltype="cf_sql_float" null='#IIF(exceldata.End_LON_H EQ "", true, false)#'>,
                   <cfqueryparam value='#End_LON_M#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.End_LON_M EQ "", true, false)#'>,
                   <cfqueryparam value='#End_LON_S#' cfsqltype="cf_sql_smallint" null='#IIF(exceldata.End_LON_S EQ "", true, false)#'>,
                   <cfqueryparam value='#End_LON_Dec#' cfsqltype="cf_sql_float" null='#IIF(exceldata.End_LON_Dec EQ "", true, false)#'>,
                   <cfqueryparam value='#ICW_Begin#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.ICW_Begin EQ "", true, false)#'>,
                   <cfqueryparam value='#ICW_End#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.ICW_End EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_TotalDolphin_Min#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_TotalDolphin_Min EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_TotalDolphin_Max#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_TotalDolphin_Max EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_TotalDolphin_Best#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_TotalDolphin_Best EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_TotalCalves_Min#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_TotalCalves_Min EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_TotalCalves_Max#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_TotalCalves_Max EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_TotalCalves_Best#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_TotalCalves_Best EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_YoungOfYear_Min#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_YoungOfYear_Min EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_YoungOfYear_Max#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_YoungOfYear_Max EQ "", true, false)#'>,
                   <cfqueryparam value='#FE_YoungOfYear_Best#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.FE_YoungOfYear_Best EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalDolphins_PosID#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalDolphins_PosID EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalCalves_PosID#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalCalves_PosID EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_YoungOfYear_PosID#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_YoungOfYear_PosID EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalDolphins_MinNotIDed#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalDolphins_MinNotIDed EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalCalves_MinNotIDed#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalCalves_MinNotIDed EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_YoungOfYear_MinNotIDed#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_YoungOfYear_MinNotIDed EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalDolphins_MaxNotIDed#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalDolphins_MaxNotIDed EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalCalves_MaxNotIDed#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalCalves_MaxNotIDed EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_YoungOfYear_MaxNotIDed#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_YoungOfYear_MaxNotIDed EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalDolphins_RevisedMin#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalDolphins_RevisedMin EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalCalves_RevisedMin#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalCalves_RevisedMin EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_YoungOfYear_RevisedMin#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_YoungOfYear_RevisedMin EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalDolphins_RevisedMax#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalDolphins_RevisedMax EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalCalves_RevisedMax#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalCalves_RevisedMax EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_YoungOfYear_RevisedMax#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_YoungOfYear_RevisedMax EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalDolphins_FinalBest#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalDolphins_FinalBest EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_TotalCalves_FinalBest#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_TotalCalves_FinalBest EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_YoungOfYear_FinalBest#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_YoungOfYear_FinalBest EQ "", true, false)#'>,
                   <cfqueryparam value='#Depth#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Depth EQ "", true, false)#'>,
                   <cfqueryparam value='#WaterTemp#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.WaterTemp EQ "", true, false)#'>,
                   <cfqueryparam value='#Salinity#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Salinity EQ "", true, false)#'>,
                   <cfqueryparam value='#Heading#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Heading EQ "", true, false)#'>,
                   <cfqueryparam value='#AssociateOrg#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.AssociateOrg EQ "", true, false)#'>,
                   <cfqueryparam value='#AssocBioData11#' cfsqltype="cf_sql_integer" null='#IIF(AssocBioData11 EQ "", true, false)#'>,
                   <cfqueryparam value='#AssocBioData22#' cfsqltype="cf_sql_integer" null='#IIF(AssocBioData22 EQ "", true, false)#'>,
                   <cfqueryparam value='#AssocBioData33#' cfsqltype="cf_sql_integer" null='#IIF(AssocBioData33 EQ "", true, false)#'>,
                   <cfqueryparam value='#WaveHeight#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.WaveHeight EQ "", true, false)#'>,
                   <cfqueryparam value='#Beaufort#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Beaufort EQ "", true, false)#'>,
                   <cfqueryparam value='#Glare#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Glare EQ "", true, false)#'>,
                   <cfqueryparam value='#Sightability#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Sightability EQ "", true, false)#'>,
                   <cfqueryparam value='#Weather#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Weather EQ "", true, false)#'>,
                   <cfqueryparam value='#Fisheries_None#' cfsqltype="cf_sql_bit" null='#IIF(exceldata.Fisheries_None EQ "", true, false)#'>,
                   <cfqueryparam value='#Fisheries_RecTrolling#' cfsqltype="cf_sql_bit" null='#IIF(exceldata.Fisheries_RecTrolling EQ "", true, false)#'>,
                   <cfqueryparam value='#Fisheries_RecAnchored#' cfsqltype="cf_sql_bit" null='#IIF(exceldata.Fisheries_RecAnchored EQ "", true, false)#'>,
                   <cfqueryparam value='#Fisheries_CrabTraps#' cfsqltype="cf_sql_bit" null='#IIF(exceldata.Fisheries_CrabTraps EQ "", true, false)#'>,
                   <cfqueryparam value='#Fisheries_CrabWork#' cfsqltype="cf_sql_bit" null='#IIF(exceldata.Fisheries_CrabWork EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Avoid_Boat#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Avoid_Boat EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Mill#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Mill EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Feed#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Feed EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_ProbFeed#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Activity_ProbFeed EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Travel#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Travel  EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Play#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Play  EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Rest#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Rest  EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Leap_tailslap_chuff#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Leap_tailslap_chuff  EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Social#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Social  EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_WithBoat#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_WithBoat  EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Other#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Other  EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_Grade#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Photo_Grade  EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_Analysis#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Photo_Analysis  EQ "", true, false)#'>,
                   <cfqueryparam value='#Photo_Analysis_Final#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Photo_Analysis_Final  EQ "", true, false)#'>,
                   <cfqueryparam value='#Date_Entered#' cfsqltype="cf_sql_timestamp" null='#IIF(exceldata.Date_Entered  EQ "", true, false)#'>,
                   <cfqueryparam value='#SDO_Initial#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.SDO_Initial  EQ "", true, false)#'>,
                   <cfqueryparam value='#SDO_Final#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.SDO_Final  EQ "", true, false)#'>,
                   <cfqueryparam value='#Data_Initial#' cfsqltype="cf_sql_varchar" <!---null='#IIF(exceldata.Data_Initial  EQ "", true, false)#'--->>,
                   <cfqueryparam value='#Data_Final#' cfsqltype="cf_sql_varchar" <!---null='#IIF(exceldata.Data_Final  EQ "", true, false)#'--->>,
                   <cfqueryparam value='#Body_Condition_Initial#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Body_Condition_Initial  EQ "", true, false)#'>,
                   <cfqueryparam value='#Body_Condition_Final#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Body_Condition_Final   EQ "", true, false)#'>,
                   <cfqueryparam value='#ARCVIEW_Initial#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.ARCVIEW_Initial   EQ "", true, false)#'>,
                   <cfqueryparam value='#Notes#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Notes   EQ "", true, false)#'>,
                   <cfqueryparam value='#Total_Takes_A#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Total_Takes_A   EQ "", true, false)#'>,
                   <cfqueryparam value='#Total_Takes_B#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Total_Takes_B   EQ "", true, false)#'>,
                   <cfqueryparam value='#Zone#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Zone   EQ "", true, false)#'>,
                   <cfqueryparam value='#Takes#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Takes   EQ "", true, false)#'>,
                   <cfqueryparam value='#Herding#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Herding   EQ "", true, false)#'>,
                   <cfqueryparam value='#Depredation#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Depredation   EQ "", true, false)#'>,
                   <cfqueryparam value='#Driver#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Driver   EQ "", true, false)#'>,
                   <cfqueryparam value='#Photographer#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Photographer   EQ "", true, false)#'>,
                   <cfqueryparam value='#analyzed#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.analyzed   EQ "", true, false)#'>,
                   <cfqueryparam value='#EastingInit_X#' cfsqltype="cf_sql_float" null='#IIF(exceldata.EastingInit_X   EQ "", true, false)#'>,
                   <cfqueryparam value='#NorthingInit_Y#' cfsqltype="cf_sql_float" null='#IIF(exceldata.NorthingInit_Y   EQ "", true, false)#'>,
                   <cfqueryparam value='#EastingEnd_X#' cfsqltype="cf_sql_float" null='#IIF(exceldata.EastingEnd_X   EQ "", true, false)#'>,
                   <cfqueryparam value='#NorthingEnd_Y#' cfsqltype="cf_sql_float" null='#IIF(exceldata.NorthingEnd_Y   EQ "", true, false)#'>,
                   <cfqueryparam value='#InitDDLAT_X#' cfsqltype="cf_sql_float" null='#IIF(exceldata.InitDDLAT_X   EQ "", true, false)#'>,
                   <cfqueryparam value='#InitDDLONG_Y#' cfsqltype="cf_sql_float" null='#IIF(exceldata.InitDDLONG_Y   EQ "", true, false)#'>,
                   <cfqueryparam value='#EndDDLAT_X#' cfsqltype="cf_sql_float" null='#IIF(exceldata.EndDDLAT_X   EQ "", true, false)#'>,
                   <cfqueryparam value='#EndDDLONG_Y#' cfsqltype="cf_sql_float" null='#IIF(exceldata.EndDDLONG_Y   EQ "", true, false)#'>,
                   <cfqueryparam value='#HeadingGen#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.HeadingGen   EQ "", true, false)#'>,
                   <cfqueryparam value='#HeadingInit#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.HeadingInit   EQ "", true, false)#'>,
                   <cfqueryparam value='#HeadingFinal#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.HeadingFinal   EQ "", true, false)#'>,
                   <cfqueryparam value='#GlareDirection#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.GlareDirection   EQ "", true, false)#'>,
                   <cfqueryparam value='#SalinityPPT#' cfsqltype="cf_sql_float" null='#IIF(exceldata.SalinityPPT   EQ "", true, false)#'>,
                   <cfqueryparam value='#AirTemp#' cfsqltype="cf_sql_float" null='#IIF(exceldata.AirTemp   EQ "", true, false)#'>,
                   <cfqueryparam value='#Conductivity#' cfsqltype="cf_sql_float" null='#IIF(exceldata.Conductivity   EQ "", true, false)#'>,
                   <cfqueryparam value='#DepthFT#' cfsqltype="cf_sql_float" null='#IIF(exceldata.DepthFT   EQ "", true, false)#'>,
                   <cfqueryparam value='#WindsSpeed#' cfsqltype="cf_sql_float" null='#IIF(exceldata.WindsSpeed   EQ "", true, false)#'>,
                   <cfqueryparam value='#TideDirection#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.TideDirection   EQ "", true, false)#'>,
                   <cfqueryparam value='#TideHeight#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.TideHeight   EQ "", true, false)#'>,
                   <cfqueryparam value='#WindDirection#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.WindDirection   EQ "", true, false)#'>,
                   <cfqueryparam value='#Habitat#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Habitat   EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Herding#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Herding   EQ "", true, false)#'>,
                   <cfqueryparam value='#Activity_Depre#' cfsqltype="cf_sql_tinyint" null='#IIF(exceldata.Activity_Depre   EQ "", true, false)#'>,
                   <cfqueryparam value='#EnteredBy#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.EnteredBy   EQ "", true, false)#'>
                  )
                   </cfquery>
				<cfif #insert.recordcount# eq 1>
                    <cfset counter= 1>
                </cfif>
        	 </cfloop>
             <cfquery name="qTurnOffInsert" datasource="#Application.dsn#">
                SET IDENTITY_INSERT SIGHTINGS OFF
             </cfquery>
             <cfcatch type="any"><cfdump var="#cfcatch#">
                <form action="" enctype="multipart/form-data" method="post" style="margin-left: 300px">
                    <div class="form-group">
                        <label for=""> Upload Utility </label>
                        <input id="upload-utility-4" class="file-loading" type="file"  name="xlsfile"  required>
                    </div>
                    <br>
                    <div class="form-group">
                        <input type="submit" class="btn btn-success" value="Upload XLS File">
                    </div>
                </form>
                <h3 style="text-align: center">Error ! Data is incomplete or Please Select the correct file.</h3>
             </cfcatch>
    </cftry>
    </cfif>
</cfif>
<cfif counter eq 1>
    <cfoutput><h3 style="text-align: center"> data inserted Successfully into Sightings Table !</h3></cfoutput>
    <cfelseif counter eq 2>
    <cfoutput><h3 style="text-align: center"> Complete data is not inserted, missing <cfloop> #missing# </cfloop> !</h3></cfoutput>
</cfif>
<div class="container">
    <div class="modal fade project-model-custom-main" id="myModal" role="dialog">
        <div class="modal-dialog project-model-custom modal-sm">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Enter Password to Continue</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input type="password" class="form-control" name="pas" id="passss">
                    </div>
                    <ul>
                        <li style="display: none" id="listerror">Please give correct password !</li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="subsight">Submit</button>
                </div>
            </div>

        </div>
    </div>
</div>


