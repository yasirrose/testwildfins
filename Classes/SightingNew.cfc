<cfcomponent>
	<cfheader name="Access-Control-Allow-Origin" value="*" />
    <cfset variables.dsn = "wildfins_new">
	<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
		<cfargument name="dsn" type="string" required="true" hint="datasource">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
    <!---<cfset Application.dsn = "wildfins_access_db">--->
	<!--- get the dolphin --->
    <cffunction name="getdolphin" access="remote" returnformat="plain" output="true">
		<cfargument name="dolphin_ID" type="any" required="true" default="" >
		<cfquery name="getdolphin" datasource="#variables.dsn#">
         select top 1
         Dolphin_DScore.DolphinID ,  
         DOLPHINS.Name,
         DOLPHINS.[Distinct],
         DOLPHINS.DistinctDate,
         DOLPHINS.Sex,
         DOLPHINS.Lineage,
         DOLPHINS.FB_No,
         DOLPHINS.Code,
         DOLPHINS.ImageName,
         Dolphin_DScore.ID,
         Dolphin_DScore.DScore,
         Dolphin_DScore.DscoreDate
         from DOLPHINS inner 
         join Dolphin_DScore on DOLPHINS.ID=Dolphin_DScore.DolphinID 
         where DOLPHINS.ID=#dolphin_ID# order by Dolphin_DScore.DScoreDate desc
     	</cfquery>
     <cfquery name="getdolphinFin" datasource="#variables.dsn#">
	 SELECT
     DOLPHINS.Code,
	 Surveys.Date as DateSeen
	 FROM Surveys LEFT JOIN
     ((Survey_Sightings LEFT JOIN
     (DOLPHINS RIGHT JOIN
     DOLPHIN_SIGHTINGS ON DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
     ON
     Survey_Sightings.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
     Surveys.ID = Survey_Sightings.Project_ID
	 where DOLPHINS.ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#dolphin_ID#'>
	 order by dateseen desc
     </cfquery>
     <cfset  Fin  = '#Application.CloudRoot#no-image.jpg'>
    <cfif getdolphin.ImageName NEQ '' and FileExists('#Application.CloudRoot##getdolphin.ImageName#')>
		<cfset  Fin = '#Application.CloudRoot##getdolphin.ImageName#'>
	<cfelse>
        <cfloop query='getdolphinFin'>
            <cfif getdolphinFin.DATESEEN NEQ ''>
                <cfif DAY(DATESEEN) lt 10 >
                    <cfset dayy = '0#DAY(DATESEEN)#'>
                <cfelse>
                    <cfset dayy  = DAY(DATESEEN)>
                </cfif>
                <cfif MONTH(DATESEEN) lt 10 >
                    <cfset monthh = '0#MONTH(DATESEEN)#'>
                <cfelse>
                    <cfset monthh  = MONTH(DATESEEN)>
                </cfif>
                <cfset Fin_Left = '#getdolphinFin.Code#(L) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
                <cfset Fin_Right = '#getdolphinFin.Code#(R) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
                <cfif FileExists('#Application.CloudDirectory##Fin_Left#')>
                    <cfset  Fin = '#Application.CloudRoot##Fin_Left#'>
                    <cfbreak>
                    <cfelseif FileExists('#Application.CloudDirectory##Fin_Right#')>
                    <cfset  Fin  = '#Application.CloudRoot##Fin_Right#'>
                    <cfbreak>
                </cfif>
            </cfif>
        </cfloop>
    </cfif>
<!--- create array --->
		<cfset Arr = ArrayNew(1)>
<!--- loop through query --->
		<cfloop query="getdolphin">
			<cfset structofdolphin = StructNew() />
			<cfset structofdolphin["Fin"] = Fin>
			<cfset structofdolphin["DolphinID"] = getdolphin.DolphinID >
			<cfset structofdolphin["Sex"] = getdolphin.Sex>
			<cfset structofdolphin["DolphinID"] = getdolphin.DolphinID>
			<cfset structofdolphin["Lineage"] = getdolphin.Lineage>
			<cfset structofdolphin["DScoreDate"] = DateFormat(getdolphin.DScoreDate, "mm/dd/yyyy")>
			<cfset structofdolphin["DistinctDate"] = DateFormat(getdolphin.DistinctDate, "mm/dd/yyyy")>
			<cfset structofdolphin["Distinct"] = getdolphin.Distinct>
			<cfset structofdolphin["DScore"] = getdolphin.DScore>
			<cfset structofdolphin["FB_No"] = getdolphin.FB_No>
			<cfset structofdolphin["ID"] = getdolphin.ID+1>
			<cfset structofdolphin["Code"] = getdolphin.Code>
			<cfset structofdolphin["Name"] = getdolphin.Name>
            <!---<cfset structofdolphin["xeno"]  = getdolphin.xeno>
            <cfset structofdolphin["RDS"]  = getdolphin.RDS>
            <cfset structofdolphin["REM"]  = getdolphin.REM>
            <cfset structofdolphin["Freshwound"]  = getdolphin.Freshwound>
            <cfset structofdolphin["tiger"]  = getdolphin.Tiger>
            <cfset structofdolphin["Tiger_Description"]  = getdolphin.Tiger_Description>
            <cfset structofdolphin["shark"]  = getdolphin.shark>
            <cfset structofdolphin["shark_Description"]  = getdolphin.shark_Description>--->
            <cfset structofdolphin["xeno"]  = ''>
            <cfset structofdolphin["RDS"]  = ''>
            <cfset structofdolphin["REM"]  = ''>
            <cfset structofdolphin["Freshwound"]  = ''>
            <cfset structofdolphin["tiger"]  = ''>
            <cfset structofdolphin["Tiger_Description"]  = ''>
            <cfset structofdolphin["shark"]  = ''>
            <cfset structofdolphin["shark_Description"]  = ''>
            <cfset ArrayAppend(Arr,structofdolphin)>
		</cfloop>
<!---SerializeJSON --->
		<cfoutput>#SerializeJSON(Arr)#</cfoutput>
	</cffunction>
    <cffunction name="add_New_dolphin" access="remote" returnformat="plain" output="true">
		<cfoutput>
			<cfparam name="Form.Distinct" default="0">
            <cfquery name="insert_dolhpin" datasource="#variables.dsn#" result='get_res'>
               insert into DOLPHINS (Name,Code,sex,lineage,DistinctDate,[Distinct],DScore,FB_No)
					Values(
						<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Name#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Code#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sex#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.lineage#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp"  value='#Form.DistinctDate#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Distinct#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FB_No#'>
                        )
            </cfquery>
            <cfif get_res.RECORDCOUNT eq 1>
                <div class="alert alert-success">
                    <strong>Success!</strong> Dolphin Added.
                </div>
			<cfelse>
                <div class="alert alert-danger">
                    <strong>Error!</strong> Insertion Failed.
                </div>
			</cfif>
        </cfoutput>
	</cffunction>

      <!--- add Cetaceans--->
    <cffunction name="add_cetaceans" access="remote" returnformat="plain" output="true">
        <cfoutput>
			<cfparam name="Form.SDR" default="0">
            <cfparam name="bestSighting" default="0">
			<cfparam name="Fetals" default="0">
            <cfparam name="wMom" default="0">
            <cfparam name="wMomDropDown" default="">
	        <cfparam name="BestImage" default="">
	        <cfparam name="Note" default="">
            <cfparam name="Cetacean_code" default="">
            <cfparam name="FB_Number" default="">
            <cfparam name="EnteredBy" default="">
            <cfparam name="PhotoAnalysisInitial" default="">
            <cfparam name="PhotoAnalysisInitial" default=0>
            <cfparam name="Sex" default="">
            
            <cfset Sighting_ID = "#Form.Sighting_ID#">
            <cfset DSCOREDATE = Now()>

			<cfif len(trim(BestImage))>
				<cffile action="upload"
						fileField="BestImage"
						destination="#Application.CloudDirectory#"
						result="returnBestImage"
						nameconflict="overwrite">
				<cfset namee = "#Sighting_ID#(R) #DateFormat(DSCOREDATE,'yyyy mm dd')#.jpg">

				<cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#"
						destination = "#Application.CloudDirectory##namee#">
			</cfif>
            
            <cfquery name="insert_cetacean_Sight" datasource="#variables.dsn#" result='get_res'>
                insert into Cetacean_Sightings (
                 Sighting_ID,
                 Code,
                 pq_focus,pq_Angle,pq_Contrast,pq_Proportion,pq_Partial,pqSum,
                 SDR,bestSighting,
                 EnteredBy,PhotoAnalysisInitial,PhotoAnalysisFinal,
                 Note,Fetals,BestImageLeft,wMom,wMomDropDown,BestShot
                )
                values(
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Sighting_ID#' >,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Cetacean_code#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_focus#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Angle#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Contrast#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Proportion#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Partial#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pqSum#'>,
                <cfqueryparam  cfsqltype="CF_SQL_TINYINT" value='#SDR#' >,
                <cfqueryparam  cfsqltype="CF_SQL_TINYINT" value='#bestSighting#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#EnteredBy#' >,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#PhotoAnalysisInitial#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#PhotoAnalysisFinal#' >,
                <cfqueryparam cfsqltype="cf_sql_varchar"  value='#Note#' null="#IIF(Form.Note EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="CF_SQL_TINYINT" value='#Fetals#' >,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BestImage#' null="#IIF(BestImage EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#wMom#'  null="#IIF(Form.wMom EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#wMomDropDown#' >,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BestShot#'  null="#IIF(Form.BestShot EQ "", true, false)#">
            )
            </cfquery>

            <cfif get_res.RECORDCOUNT eq 1 >
                <div class='alert alert-success'>
                    <strong>Success!</strong> Cetacean Inserted.
                </div>
			</cfif>

        </cfoutput>
	</cffunction>
    <!--- add dolphin--->
    <cffunction name="add_dolphin" access="remote" returnformat="plain" output="true">
        <cfoutput>
            <cfparam name="Form.PQP" default="0">
			<cfparam name="Form.SDR" default="0">
			<cfparam name="Form.Fetals" default="0">
			<cfparam name="Form.BC" default="0">
			<cfparam name="Form.Xeno" default="0">
			<cfparam name="Form.RDS" default="0">
			<cfparam name="Form.REM" default="0">
			<cfparam name="Form.Freshwound" default="0">
			<cfparam name="Form.wMom" default="0">
			<cfparam name="Form.Echelon" default=" ">
			<cfparam name="Form.Verified" default=" ">
			<cfparam name="Form.Note" default=" ">
			<cfparam name="Form.REMPI" default=" ">
			<cfparam name="Form.BestImage"	 default="">
			<cfparam name="Form.Tiger" default="0">
            <cfparam name="Form.shark" default="0">
			<cfparam name="Form.DScoreDate" default="0">
			<cfparam name="FORM.Image" default="0">
            <cfparam name="SightingImageName"	 default="">
			<cfif len(trim(BestImage))>
				<cffile action="upload"
						fileField="BestImage"
						destination="#Application.CloudDirectory#"
						result="returnBestImage"
						nameconflict="overwrite">
				<cfset namee = "#Dolphin_ID#(R) #DateFormat(DSCOREDATE,'yyyy mm dd')#.jpg">
<!--------   Resize rename/extension changed------------->

<!--------   Resize rename/extension changed------------->
				<cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#"
						destination = "#Application.CloudDirectory##namee#">
<!---<cfdump var="#returnBestImage#"><cfabort>--->
			</cfif>
            <cfif len(trim(SightingImage))>
				<cffile action="upload"
						fileField="SightingImage"
						destination="#Application.CloudDirectory#"
						result="returnSightingImage"
						nameconflict="overwrite">
                        <cfset SightingImageName = '#returnSightingImage.serverfile#'>
				<!---<cfset SightingImageName = 'Sighting-img-#DateFormat(Now(), "YYYY-mm-dd")#-#TimeFormat(Now(), "hh:mm:ss")#.jpg'>

				<cffile action = "rename" source = "#Application.CloudDirectory##returnSightingImage.serverfile#" destination = "#Application.CloudDirectory##imageName#">--->
			</cfif>
            <cfquery name="insert_dolhpin_sight" datasource="#variables.dsn#" result='get_res'>
                insert into DOLPHIN_SIGHTINGS (Dolphin_ID,Sighting_ID,pq_focus,pq_Angle,pq_Contrast,pq_Proportion,pq_Partial,pqSum,PQP,SDR
                ,Note,Fetals,Echelon,Tiger,Xeno,SDO1,SDO2,SDO3,SDO4,RDS,REM,[W/mom],GCP,BIO_LOBO,BIO_POX,BIOSDO,Freshwound,BestImage,wMom,
                Fetals_Description<!---,Tiger_Description--->,BestShot<!---,shark_Description--->,shark,Dolphin_Sighting_Date,BodyCondition,Region,Side_L_R,Status,Area,SightingImage,entered_by,review,reviewed_by)
                values(<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.Dolphin_ID#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.Sighting_ID#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_focus#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Angle#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Contrast#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Proportion#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Partial#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pqSum#'>,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.PQP#' >,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDR#' >
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Note#' null="#IIF(Form.Note EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_bit"     value='#Form.Fetals#' >,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Echelon#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Tiger#'>,
                <!---<cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.BC#' null="#IIF(Form.BC EQ "", true, false)#">,--->
                <cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.Xeno#' null="#IIF(Form.Xeno EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDO1#' null="#IIF(Form.SDO1 EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDO2#' null="#IIF(Form.SDO2 EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDO3#' null="#IIF(Form.SDO3 EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDO4#' null="#IIF(Form.SDO4 EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.RDS#' null="#IIF(Form.RDS EQ "", true, false)#">,
                <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.REMPI#' null="#IIF(Form.REMPI EQ "", true, false)#">,--->
                        <cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.REM#' null="#IIF(Form.REM EQ "", true, false)#">,
                0,0,0,0,0,
                <cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.Freshwound#'  null="#IIF(Form.Freshwound EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BestImage#' null="#IIF(Form.BestImage EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.wMom#'  null="#IIF(Form.wMom EQ "", true, false)#">,

                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Fetals_Description#'  null="#IIF(Form.Fetals_Description EQ "", true, false)#">,
                <!---<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.BC_rate#'  null="#IIF(Form.BC_rate EQ "", true, false)#">,--->
               <!--- <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BC_Description#'  null="#IIF(Form.BC_Description EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Xeno_Description#'  null="#IIF(Form.Xeno_Description EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.RDS_Description#'  null="#IIF(Form.RDS_Description EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.REM_Description#'  null="#IIF(Form.REM_Description EQ "", true, false)#">,--->
                <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Freshwound_Description#'  null="#IIF(Form.Freshwound_Description EQ "", true, false)#">,--->
                <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Tiger_Description#'  null="#IIF(Form.Tiger_Description EQ "", true, false)#">,--->
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BestShot#'  null="#IIF(Form.BestShot EQ "", true, false)#">,
                <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.shark_Description#'  null="#IIF(Form.shark_Description EQ "", true, false)#">,--->
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Shark#' >,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Dolphin_Sighting_Date#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BodyCondition#'  null="#IIF(Form.BodyCondition EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Region#'  null="#IIF(Form.Region EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Side#'     null="#IIF(Form.Side EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Status#'   null="#IIF(Form.Status EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Area#'  null="#IIF(Form.Area EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SightingImageName#'>,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.entered_by#' null="#IIF(Form.entered_by EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.review#' null="#IIF(Form.review EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.reviewed_by#' null="#IIF(Form.reviewed_by EQ "", true, false)#">
            )
            </cfquery>
            <cfif get_res.RECORDCOUNT eq 1 >
                <div class='alert alert-success'>
                    <strong>Success!</strong> Dolphin Inserted.
                </div>
			</cfif>
        </cfoutput>
	</cffunction>
	<cffunction name="del_dolphinsight" access="remote" returnformat="plain" output="true">
        <cfargument name="SightingID" type="any" required="true" default="">
		<cfargument name="DolphinID" type="any" required="true" default="">
        <cfquery name="del_dolphin" datasource="#variables.dsn#">
             delete  from DOLPHIN_SIGHTINGS where Dolphin_ID=#DolphinID# and Sighting_ID=#SightingID#
		</cfquery>
		<cfoutput>
            Dolphin Removed successfully.
        </cfoutput>
	</cffunction>
<!--- update dolphin sighing --->
    <cffunction name="update_dolphinsight" access="remote" returnformat="plain" output="true">
        <cfoutput>
			<cfparam name="Form.PQP" default="0">
			<cfparam name="Form.SDR" default="0">
			<cfparam name="Form.Fetals" default="0">
			<cfparam name="Form.BC" default="0">
			<cfparam name="Form.Xeno" default="0">
			<cfparam name="Form.RDS" default="0">
			<cfparam name="Form.REM" default="0">
			<cfparam name="Form.SDO1" default="0">
            <cfparam name="Form.SDO2" default="0">
            <cfparam name="Form.SDO3" default="0">
            <cfparam name="Form.SDO4" default="0">
			<cfparam name="Form.Echelon" default=" ">
			<cfparam name="Form.Verified" default=" ">
			<cfparam name="Form.Note" default=" ">
			<cfparam name="Form.REMPI" default=" ">
			<cfparam name="Form.pqSum" default="0">
			<cfparam name="Form.pq_focus" default="0">
			<cfparam name="Form.pq_Angle" default="0">
			<cfparam name="Form.pq_Contrast" default="0">
			<cfparam name="Form.pq_Partial" default="0">
			<cfparam name="Form.pq_Proportion" default="0">
			<cfparam name="Form.SDR_Description" default="">
			<cfparam name="Form.Fetals_Description" default="">
			<cfparam name="Form.BC_rate" default="">
			<cfparam name="Form.BC_Description" default="">
			<cfparam name="Form.Xeno_Description" default="">
			<cfparam name="Form.RDS_Description" default="">
			<cfparam name="Form.REM_Description" default="">
			<cfparam name="Form.Freshwound_Description" default="">
			<cfparam name="Form.Tiger_Description" default="">
			<cfparam name="Form.BestShot" default="">
			<cfparam name="Form.BestImage"	 default="">
            <cfparam name="Form.FRESHWOUND"	 default="">
			<cfparam name="Form.imageName">
			<cfparam name="Form.imageNameDate">
            <cfparam name="Form.shark" default="0">
            <cfparam name="Form.tiger" default="0">
            <cfparam name="Form.hdnImageName" default="">
            <cfif len(trim(BestImage))>
				<cfif imageName EQ 'no-image'>
					<cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
					<cfset namee = "#Dolphin_ID#(R) #DateFormat('#FORM.imageNameDate#','yyyy mm dd')#.jpg">
					<cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#namee#">
				<cfelse>
					<cfset paTH = #Application.CloudDirectory#&#FORM.imageName# >
					<cffile action="delete" file="#paTH#">
					<cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
					<cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#FORM.imageName#">
                </cfif>
			</cfif>
            <cfif len(trim(SightingImage))>
				<cfif hdnImageName NEQ 'no-image.jpg'>
                	<cfset paTH = #Application.CloudDirectory#&#FORM.hdnImageName# >
					<cffile action="delete" file="#paTH#">
                </cfif>
                <cffile action="upload" fileField="SightingImage" destination="#Application.CloudDirectory#" result="returnSightingImage" nameconflict="overwrite">
                <!---<cfset SightingImageName = 'Sighting-img-#DateFormat(Now(), "YYYY-mm-dd")#-#TimeFormat(Now(), "hh:mm:ss")#.#returnSightingImage.serverFileExt#'>--->
                <cfset SightingImageName = '#returnSightingImage.serverfile#'>
                
					
			    <!---<cffile action = "rename" source = "#Application.CloudDirectory##returnSightingImage.serverfile#" destination = "#SightingImageName#">--->
            <cfelseif hdnImageName NEQ 'no-image.jpg'>
            	<cfset SightingImageName = hdnImageName>
            <cfelse>
            	<cfset SightingImageName = ''>
			</cfif>
            <cfquery name="update_dolhpin_sight" datasource="#variables.dsn#">
               UPDATE DOLPHIN_SIGHTINGS SET
               Verified = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Verified#' > ,
               pq_focus=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_focus#' >,
               pq_Angle=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Angle#' >,
               pq_Contrast=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Contrast#'>,
               pq_Proportion=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Proportion#'>,
               pq_Partial=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.pq_Partial#'>,
               pqSum=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.pqSum#'>,
               PQP=<cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.PQP#'>,
               SDR=<cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.SDR#'>,
                Note=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Note#'>,
                Fetals=<cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.Fetals#'>,
                Echelon=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Echelon#'>,
                Xeno=<cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.Xeno#'>,
                SDO1=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDO1#'>,
                SDO2=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDO2#'>,
                SDO3=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDO3#'>,
                SDO4=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.SDO4#'>,
                RDS=<cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.RDS#'>,
               <!----- REMPI=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.REMPI#'>,--->
                REM=<cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.REM#'>,
                <!-----body condition description------>
                Fetals_Description=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Fetals_Description#'
                        null="#IIF(Form.Fetals_Description EQ "", true, false)#">,
                BestImage =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BestImage#' null="#IIF(Form.BestImage EQ "", true, false)#">,
                <!---Tiger_Description =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Tiger_Description#'
                        null="#IIF(Form.Tiger_Description EQ "", true, false)#">,--->
                BestShot =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BestShot#'
                        null="#IIF(Form.BestShot EQ "", true, false)#">,
                Freshwound =<cfqueryparam  cfsqltype="cf_sql_bit" value='#Form.Freshwound#'
                        null="#IIF(Form.Freshwound EQ "", true, false)#">,
                <!---shark_Description =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.shark_Description#'
                        null="#IIF(Form.shark_Description EQ "", true, false)#">,
                shark =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.shark#'
                        null="#IIF(Form.shark EQ "", true, false)#">,
                tiger =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.tiger#'
                        null="#IIF(Form.tiger EQ "", true, false)#">,--->
                Dolphin_Sighting_Date =  <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Dolphin_Sighting_Date#'>,
                BodyCondition         =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BodyCondition#'  null="#IIF(Form.BodyCondition EQ "", true, false)#">,
                Region   =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Region#'  null="#IIF(Form.Region EQ "", true, false)#">,
                Side_L_R = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Side#'     null="#IIF(Form.Side EQ "", true, false)#">,
                Status   = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Status#'   null="#IIF(Form.Status EQ "", true, false)#">,
                Area     =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.Area#'  null="#IIF(Form.Area EQ "", true, false)#">,
                SightingImage = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SightingImageName#'>,      
                entered_by =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.entered_by#'
                        null="#IIF(Form.entered_by EQ "", true, false)#">,
                review =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.review#'
                        null="#IIF(Form.review EQ "", true, false)#">,
                reviewed_by =<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.reviewed_by#'
                        null="#IIF(Form.reviewed_by EQ "", true, false)#">                        
                where Dolphin_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.Dolphin_ID#'>
                and Sighting_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.Sighting_ID#'>
            </cfquery>
            <div class='alert alert-success'>
                <strong>Success!</strong> Dolphin record updated.
            </div>
		</cfoutput>
	</cffunction>
    <cffunction name="getlist_dolphinsight" access="remote" returnformat="plain" output="true">
		<cfargument name="Sightningid" type="any" required="true" default="">
        <cfoutput>
			<cfquery name="dolphine" datasource="#variables.dsn#" result ='get_dolphine_result'>
                select code,id,Name from DOLPHINS ;
            </cfquery>
            <cfquery name="singleSightingDolphins" datasource="#variables.dsn#" result='get_dolphine_result'>
                SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID=#Sightningid# order by DOLPHIN_SIGHTINGS.Sighting_ID;
            </cfquery>
            <cfquery name="TLU_SDO" datasource="#variables.dsn#" result ='get_sdo'>
                SELECT * FROM TLU_SDO
            </cfquery>
            <cfquery name="getProjectID" datasource="#variables.dsn#">
	            SELECT Project_ID FROM Survey_Sightings WHERE ID = #Sightningid#
			</cfquery>
<!---GET ALL SIGHTINGS_DOLPHINS OF PROJECT--->
			<cfquery name="dolphine_sight" datasource="#variables.dsn#" result ='get_dolphine_result'>
                SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID IN (SELECT ID FROM Survey_Sightings WHERE Project_ID = #getProjectID.PROJECT_ID#) order by DOLPHIN_SIGHTINGS.Sighting_ID;
            </cfquery>
            <cfparam name='d1total' default="0">
			<cfparam name='d2total' default="0">
			<cfparam name='d3total' default="0">
			<cfparam name='d4total' default="0">
			<cfparam name='d5total' default="0">
			<cfparam name='d6total' default="0">
			<cfparam name='total' default="0">
            <cfloop query="singleSightingDolphins">
				<cfquery name="dscore" datasource="#variables.dsn#">
                    select top 1 DScore from Dolphin_DScore where DolphinID=#singleSightingDolphins.Dolphin_ID# order by ID DESC
                </cfquery>
                <cfif dscore.DScore EQ 'D1'>
					<cfset d1total=d1total+1>
                    <cfelseif dscore.DScore EQ 'D2'>
					<cfset d2total=d2total+1>
                    <cfelseif dscore.DScore EQ 'D3'>
					<cfset d3total=d3total+1>
                    <cfelseif dscore.DScore EQ 'D4'>
					<cfset d4total=d4total+1>
                    <cfelseif dscore.DScore EQ 'D5'>
					<cfset d5total=d5total+1>
                    <cfelseif dscore.DScore EQ 'D6'>
					<cfset d6total=d6total+1>
				</cfif>
			</cfloop>
			<cfset total=d1total+d2total+d3total+d4total+d5total+d6total>
              <h2>List of Dolphins</h2>
              <div class="right-box-dolphin p-10 m-b-20 col-lg-12">
                <div class="row">
                  <div class="pull-right col-lg-2 m-b-10 p-0 m-r-10">
                    <label>D Total</label>
                    <input type="text" value="#total#" class="form-control d-total">
                  </div>
                </div>
             <div class="row">
                <div class="col-lg-2">
                  <label>D1</label>
                  <input type="text" value="#d1total#" class="form-control" />
                </div>
                <div class="col-lg-2">
                    <label>D2</label>
                        <input type="text" value="#d2total#" class="form-control" />
                </div>
                <div class="col-lg-2">
                    <label>D3</label>
                        <input type="text" class="form-control" value="#d3total#" />
                </div>
                <div class="col-lg-2">
                    <label>D4</label>
                        <input type="text" class="form-control" value="#d4total#" />
                </div>
                <div class="col-lg-2">
                    <label>D5</label>
                        <input type="text" class="form-control" value="#d5total#" />
                </div>
                <div class="col-lg-2">
                    <label>D6</label>
                        <input type="text" class="form-control" value="#d6total#" />
                </div>
             </div>
             </div>
            <div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff">
                <div class="col-md-2">Dophin Name</div>
                <div class="col-md-2">Dscore</div>
                <div class="col-md-2">DScore date</div>
                <div class="col-md-2">Sighting ID</div>
                <div class="col-md-2">Actions</div>
            </div>
			   <cfset i=0>
			     <cfloop query="dolphine_sight">
				 <cfset i=i+1>
                  <div class="row" id="dolphindetail_#i#">
<!----------
         ---
         --- Find Dscore
         ---
         ------------>
				<cfquery name="dscore" datasource="#variables.dsn#">
				select top 1 * from Dolphin_DScore where DolphinID=#dolphine_sight.Dolphin_ID# order by ID DESC
				</cfquery>
                    <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;">
                      <div class="col-md-2">#dolphine_sight.Name#</div>
                      <div class="col-md-2">#dscore.DScore#</div>
                      <div class="col-md-2">#DateFormat(dscore.DScoreDate, 'MM/DD/YYYY')#</div>
                      <div class="col-md-2">#dolphine_sight.Sighting_ID#</div>
                      <div class="col-md-2">
                         <button  href="##collapse#i#" class="btn btn-xs btn-primary" data-toggle="collapse" >
                         <i class="fa fa-pencil-square-o"></i></button>
                         <button type="button" id="delete_#i#" class="btn btn-xs btn-primary delete_dolphin"
                            Sighting_ID="#dolphine_sight.Sighting_ID#" Dolphin_ID="#dolphine_sight.Dolphin_ID#">
                        <i class="glyphicon glyphicon-trash"></i></button>
                      </div>
                    </div>
                      <div id="collapse#i#" class="col-md-12 panel-collapse collapse" style="border: solid 2px ##ccc;">
                        <div class="panel-body">
               <form role="form" id="update_dolhpin_#i#">
<!--------- Left Side-------------->
                    <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                     <div class="form-group selectwidth">
                       <label for="email">Dolphin Name/Code:</label>
                       <select class="form-control search-box" required id="dolphin_up_code" readonly name="Dolphin_ID">
                          <option value="#dolphine_sight.Dolphin_ID#" > <cfloop query="dolphine"><cfif dolphine_sight.Dolphin_ID eq dolphine.id > #dolphine.Name# | #dolphine.code# </cfif></cfloop></option>
                       </select>
                     </div>
                     <div class="form-group">
                        <label for="pwd">Sex:</label>
                            <input type="text" class="form-control"  value="#dolphine_sight.Sex#" id="update_sex" readonly >
                    </div>
                     <div class="form-group">
                        <label for="pwd">Lineage:</label>
                            <input type="text" class="form-control" id="update_Lineage" readonly  value="#dolphine_sight.Lineage#">
                    </div>
                     <div class="form-group">
                        <label for="pwd">Distict Date:</label>
                            <input type="text" class="form-control" id="update_distictdate" readonly value="#DateTimeFormat(dolphine_sight.DistinctDate, 'MM/DD/YYYY')#">
                     </div>
                     <div class="form-group">
                         <label for="pwd">Distict:</label>
                        <input type="checkbox" class="checkbox-inline"
							   <cfif dolphine_sight.Distinct eq 1>checked</cfif> id="update_distict"  value="1" disabled  readonly>
                     </div>
                     <div class="form-group">
                        <label for="pwd">Dscore:</label>
                            <input type="text" class="form-control" id="update_dscore" readonly value="#dscore.DScore#">
                      </div>
                     <div class="form-group">
                        <label for="pwd">FB_No:</label>
                        <input type="text" class="form-control" value="#dolphine_sight.FB_No#" id="add_FB_No" readonly>
                     </div>
                     <div class="form-group">
                        <label for="pwd">Note:</label>
                        <textarea class="form-control" name="Note">#dolphine_sight.Note#</textarea>
                    </div>
                     <div class="form-group">
                       <label for="pwd">Echelon:</label>
                        <input type="text"   class="form-control" name="Echelon" maxlength="5" value="#dolphine_sight.Echelon#">
                     </div>
                     <div class="form-group">
                        <label for="pwd">REMPI:</label>
                        <input type="text" class="form-control" value="#dolphine_sight.REMPI#" name="REMPI" maxlength="5">
                     </div>
                    <div class="form-group">
                        <label for="pwd">Body Condition:</label>
                            <input type="text" class="form-control" value="#dolphine_sight.BodyCondition#" name="BodyCondition">
                    </div>
                     <div class="form-group">
                    <label for="pwd">Best Image:</label>
                        <input type="text" class="form-control" value="#dolphine_sight.BestImage#" name="BestImage">
                   </div>
                    <div class="message">

                    </div>
                     <div class="form-group">
                        <button type="submit" class="btn btn-success update_dolphin" data_id="update_dolhpin_#i#">Update</button>
                    </div>
                     </div>

<!--------- Right Side-------------->
         <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
            <div class="form-group">
             <div class="input-group">
                <div class="input-group-btn">
                    <button class="btn btn-inverse" type="button">Verified</button>
                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                    <li><a val="P" class="get_val" id="update_varified#i#_1">P</a></li>
                    <li><a val="V" class="get_val" id="update_varified#i#_2">V</a></li>
                    </ul>
                </div>
                        <input type="text" id="update_varified#i#" class="form-control" value="#dolphine_sight.Verified#" maxlength="7"  name="Verified">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">PQ F:</button>
                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                        <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                        <li><a val="2" class="get_val sum_calculate_update" id="update_pqf#i#_1" index="#i#">2</a></li>
                        <li><a val="4" class="get_val sum_calculate_update" id="update_pqf#i#_2" index="#i#">4</a></li>
                        <li><a val="6" class="get_val sum_calculate_update" id="update_pqf#i#_3" index="#i#">6</a></li>
                        </ul>
                    </div>
                    <input type="number" class="form-control sum_calculate_update" index="#i#" id="update_pqf#i#" name="pq_focus" value="<cfif len(trim(dolphine_sight.pq_focus)) EQ 0>0<cfelse>#dolphine_sight.pq_focus#</cfif>">
                 </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                <div class="input-group-btn">
                    <button class="btn btn-inverse" type="button">PQ A:</button>
                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                    <li><a val="1" class="get_val sum_calculate_update" id="update_pqa#i#_1" index="#i#">1</a></li>
                    <li><a val="2" class="get_val sum_calculate_update" id="update_pqa#i#_2" index="#i#">2</a></li>
                    <li><a val="8" class="get_val sum_calculate_update" id="update_pqa#i#_3" index="#i#">8</a></li>
                    </ul>
                </div>
                    <input type="number" class="form-control sum_calculate_update" index="#i#" name="pq_Angle" id="update_pqa#i#" value="<cfif len(trim(dolphine_sight.pq_Angle)) EQ 0>0<cfelse>#dolphine_sight.pq_Angle#</cfif>">
                 </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">PQ C:</button>
                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                            <span class="caret"></span>
                        </button>
                    <ul class="dropdown-menu">
                    <li><a val="1" class="get_val sum_calculate_update" id="update_pqc#i#_1" index="#i#">1</a></li>
                    <li><a val="3" class="get_val sum_calculate_update" id="update_pqc#i#_2" index="#i#">3</a></li>
                    </ul>
                    </div>
                        <input type="number" class="form-control sum_calculate_update" index="#i#" name="pq_Contrast" id="update_pqc#i#" value="<cfif len(trim(dolphine_sight.pq_Contrast)) EQ 0>0<cfelse>#dolphine_sight.pq_Contrast#</cfif>">
                </div>
            </div>
            <div class="form-group">
                 <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">Pq Pro:</button>
                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                        <li><a val="1" class="get_val sum_calculate_update" id="update_pqpro#i#_1" index="#i#">1</a></li>
                        <li><a val="5" class="get_val sum_calculate_update" id="update_pqpro#i#_2" index="#i#">5</a></li>
                        </ul>
                    </div>
                        <input type="number" class="form-control sum_calculate_update" index="#i#" name="pq_Proportion" id="update_pqpro#i#" value="<cfif len(trim(dolphine_sight.pq_Proportion)) EQ 0>0<cfelse>#dolphine_sight.pq_Proportion#</cfif>">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">Pq Par:</button>
                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a val="1" class="get_val sum_calculate_update" id="update_pqpar#i#_1" index="#i#">1</a></li>
                            <li><a val="8" class="get_val sum_calculate_update" id="update_pqpar#i#_1" index="#i#">8</a></li>
                        </ul>
                    </div>
                        <input type="number" class="form-control sum_calculate_update" index="#i#" name="pq_Partial" id="update_pqpar#i#" value="<cfif len(trim(dolphine_sight.pq_Partial)) EQ 0>0<cfelse>#dolphine_sight.pq_Partial#</cfif>">
                </div>
            </div>
            <div class="form-group">
                <label for="pwd">Pq sum:</label>
                    <input type="number" class="form-control" id="update_pqsum_#i#" value="<cfif len(trim(dolphine_sight.pqSum)) EQ 0>0<cfelse>#dolphine_sight.pqSum#</cfif>" name="pqSum"  readonly>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">SDO1:</button>
                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                            <span class="caret"></span>
                        </button>
                    <ul class="dropdown-menu">
                        <cfset t=0>
                        <cfloop query="TLU_SDO">
                            <cfset t=t+1>
                                <li><a val="#TLU_SDO.SDO_ID#" class="getvals_update" id="update_SDO1_#t#_#i#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a>	</li>
                        </cfloop>
                        </ul>
                        </div>
                        <input type="text" class="form-control" id="update_SDO1_val_#i#" value="<cfloop query="TLU_SDO">
                    <cfif dolphine_sight.SDO1 eq TLU_SDO.SDO_ID>#TLU_SDO.SDO_ID# | #TLU_SDO.Name#</cfif></cfloop>" readonly>
                        <input type="hidden" class="form-control" id="update_SDO1_id_#i#" name="SDO1" value="<cfif len(trim(dolphine_sight.SDO1)) EQ 0>0<cfelse>#dolphine_sight.SDO1#</cfif>" readonly>
                </div>
            </div>
            <div class="form-group">
                <label for="pwd">Qscore:</label>
                <input type="text" class="form-control" name="Qscore"  id="add_qscoresum">
            </div>
            <div class="form-group">
                <label for="pwd">PQP:</label>
                <input type="checkbox" class="checkbox-inline" name="PQP" <cfif dolphine_sight.PQP eq 1>checked</cfif>  value="1">
            </div>
            <div class="form-group">
                <label for="pwd">SDR:</label>
                <input type="checkbox" class="checkbox-inline" name="SDR" <cfif dolphine_sight.SDR eq 1>checked</cfif>  value="1">
            </div>
            <div class="form-group">
                <label for="pwd">Fetals:</label>
                <input type="checkbox" class="checkbox-inline" name="Fetals" <cfif dolphine_sight.Fetals eq 1>checked</cfif>  value="1">
            </div>
            <div class="form-group">
                <label for="pwd">BC:</label>
                <input type="checkbox" class="checkbox-inline" name="BC" <cfif dolphine_sight.BC eq 1>checked</cfif>  value="1">
            </div>
            <div class="form-group">
                <label for="pwd">Xeno:</label>
                  <input type="checkbox" name="Xeno" <cfif dolphine_sight.Xeno eq 1>checked</cfif>  value="1">
            </div>
            <div class="form-group">
                <label for="pwd">RDS:</label>
                    <input type="checkbox" class="checkbox-inline" name="RDS" <cfif dolphine_sight.RDS eq 1>checked</cfif>  value="1">
            </div>
            <div class="form-group">
                <label for="pwd">REM:</label>
                    <input type="checkbox" class="checkbox-inline" name="REM" <cfif dolphine_sight.REM eq 1>checked</cfif>  value="1">				 </div>
            <div class="form-group">
                <label for="pwd">Fresh wound:</label>
                    <input type="checkbox" class="checkbox-inline" <cfif dolphine_sight.Freshwound eq 1>checked</cfif> name="Freshwound"  value="1">
            </div>
         </div>
         <div class="col-md-12">
            <input type="hidden" class="form-control" name="Sighting_ID" value="#Sightningid#">
         </div>
        </form>
       </div>
    </div>
   </div>
  </cfloop>
</div> <!--- end data div ----->
</cfoutput>
</cffunction>

<!---get dolphin ---->
	<cffunction name="getDolphins" returntype="any" output="true" access="remote" >
		<cfargument name="dolphin_ID" type="any" required="true" default="" >
		<cfquery name="qgetDolphins" datasource="#variables.dsn#">
         SELECT 	
         Dolphin_DScore.DolphinID ,  
         DOLPHINS.Name,
         DOLPHINS.[Distinct],
         DOLPHINS.DistinctDate,
         DOLPHINS.Sex,
         DOLPHINS.Lineage,
         DOLPHINS.FB_No,
         DOLPHINS.Code,
         Dolphin_DScore.ID,
         Dolphin_DScore.DScore,
         Dolphin_DScore.Description,
         Dolphin_DScore.DscoreDate
         FROM DOLPHINS inner join Dolphin_DScore on DOLPHINS.ID=Dolphin_DScore.DolphinID where DOLPHINS.ID=#dolphin_ID#
         ORDER BY Dolphin_DScore.DScoreDate DESC
		</cfquery>
        <cfset c=0>
		<cfloop query="qgetDolphins">
			<cfset c=c+1>
            <tr class="gradeU">
                <td>#qgetDolphins.DolphinID#</td>
                <td>#qgetDolphins.ID#</td>
                <td>#qgetDolphins.Code#</td>
                <td>#DateFormat(qgetDolphins.DScoreDate, "mm/dd/yyyy")#</td>
                <td>#qgetDolphins.DScore#</td>
                <td>#qgetDolphins.Description#</td>
            </tr>
		</cfloop>
    </cffunction>

      <!---get Cetaceans Code--->
	<cffunction name="getCetaceansCode" returntype="any" output="false" access="public" >
		<cfquery name="qgetCetaceansCode" datasource="#variables.dsn#">
            SELECT code,id,Name FROM Cetaceans where CetaceanSpecies = #
            # order by code asc
        </cfquery>
		<cfreturn qgetCetaceansCode>
    </cffunction>
    
	<cffunction name="getCetaceansCodeForTracking" returnformat="JSON" returntype="any" output="false" access="remote" >
		<cfquery name="qgetCetaceansCode" datasource="#variables.dsn#">
            SELECT code,id,Name FROM Cetaceans where CetaceanSpecies = #Cetacean_Species# order by code asc
        </cfquery>
		<cfreturn qgetCetaceansCode>
	</cffunction>
<!---get dolphins Code--->
	<cffunction name="getDolphinsCode" returntype="any" output="false" access="public" >
		<cfquery name="qgetDolphinsCode" datasource="#variables.dsn#"  >
        SELECT code,id,Name FROM DOLPHINS 
        </cfquery>
		<cfreturn qgetDolphinsCode>
	</cffunction>
    <!--- Insert Dolphin --->
	<cffunction name="insertDscoreDolphin" returntype="any" output="false" access="public" >
        <cfquery name="dolphin_insert" datasource="#variables.dsn#" result ='getresult'>
       insert into Dolphin_DScore 
       	(
       	 DolphinID,
       	 DScore,
       	 DScoreDate,
         Description
         )
        values(
       <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.DolphinID_fetch#">,
       	<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.DScore#">,
       <cfqueryparam cfsqltype="cf_sql_timestamp" value="#FORM.DScoreDate#">,
       <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Description#">
       )
    	</cfquery>
        <cfreturn getresult>
	</cffunction>
    <cffunction name="qUpdateAnalyzd_SIGHT" returntype="any" output="false" access="public" >
        <cfquery name="query" datasource="#variables.dsn#" result="return_data">
            UPDATE Survey_Sightings SET
            analyzed = <cfqueryparam cfsqltype="cf_sql_integer" value="#analyzed#"> WHERE Project_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.project_id#'> and
             ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.sight_id#'>

        </cfquery>
		<cfreturn return_data>
    </cffunction>
<!---- get qUpdate Project ---->
    <cffunction name="qUpdateProject" returntype="any" output="false" access="public" >
        <cfargument default="" name="BodyOfWater">
		<cfargument default="" name="NOAAStock">
        <cfargument default="" name="SurveyType">
        <cfargument default="" name="SurveyRoute">
        <cfargument default="" name="Platform">
        <cfargument default="" name="ResearchTeam">

		<cfif isdefined('Form.SurveyType')>
			<cfset  SurveyType=form.SurveyType>
		</cfif>
		<cfif len(trim(form.ProjectDate)) NEQ 0>
			<cfset ProjectDate=form.ProjectDate>
        <cfelse>
			<cfset ProjectDate=NOW()>
		</cfif>

		<cfset dummydate=DateFormat(ProjectDate,"yyyy-mm-dd ")>
		<cfif len(trim(form.SurveyStart)) NEQ 0>
			<cfset SurveyStart=dummydate & form.SurveyStart>
		</cfif>
		<cfif len(trim(form.SurveyEnd)) NEQ 0>
			<cfset SurveyEnd=dummydate & form.SurveyEnd>
		</cfif>
        <cfif form.Platform eq "Land Survey" or #SurveyType# eq "Trail Camera">
            <cfset EngineOn = "">
            <cfset EngineOff = "">
        </cfif>
        <cfif EngineOn NEQ "" OR EngineOff NEQ "">
			<cfset EngineOn=dummydate & form.EngineOn>
            <cfset EngineOff=dummydate & form.EngineOff>
		</cfif>

        <cfquery name="query" datasource="#variables.dsn#" result="return_data">
            UPDATE Surveys SET 
            Date =<cfqueryparam cfsqltype="cf_sql_timestamp" value='#ProjectDate#'>,
            SurveyStart=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#SurveyStart#' null="#IIF(SurveyStart EQ "", true, false)#">,
            SurveyEnd=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#SurveyEnd#'  null="#IIF(SurveyEnd EQ "", true, false)#">,
            EngineOn=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#EngineOn#' null="#IIF(EngineOn EQ "", true, false)#">,
            EngineOff=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#EngineOff#' null="#IIF(EngineOff EQ "", true, false)#">,
            SurveyRoute=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#SurveyRoute#' null="#IIF(SurveyRoute EQ "", true, false)#">,
            Platform=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Platform#' null="#IIF(Platform EQ "", true, false)#">,
            BodyOfWater=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#BodyOfWater#' null="#IIF(BodyOfWater EQ "", true, false)#">,
            SurveyType=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#SurveyType#' null="#IIF(SurveyType EQ "", true, false)#">,
            ResearchTeam=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#ResearchTeam#' null="#IIF(ResearchTeam EQ "", true, false)#">,            
            NOAAStock=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#NOAAStock#' null="#IIF(NOAAStock EQ "", true, false)#">
            WHERE id=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.project_id#' >
        </cfquery>
		<cfreturn return_data>
	</cffunction>

<!----  updatecameralens  ---->
    <cffunction name="updatecameralens" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#" result="return_data">
            UPDATE  PHOTO_ROLLS SET
            Camera=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Camera_value_id#' null="#IIF(Camera_value_id EQ "", true, false)#" >,
            Lens=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Lens_value_id#' null="#IIF(Lens_value_id EQ "", true, false)#">,
            Photographer=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Photographer#' null="#IIF(Photographer EQ "", true, false)#">,
            Driver=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Driver#' null="#IIF(Driver EQ "", true, false)#">
            where Sighting_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.sight_id#'>
		</cfquery>
		<cfreturn return_data>
	</cffunction>
<!---- get_project data  ---->
	<cffunction name="qSurveys" returntype="any" output="false" access="public" >
		<cfquery name="qProject" datasource="#variables.dsn#">
	        SELECT Surveys.* FROM Surveys where id =<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'> ORDER BY Surveys.Date;
	</cfquery>
		<cfreturn qProject>
	</cffunction>
<!---- get qProject_ten ---->
	<cffunction name="qProject_ten" returntype="any" output="false" access="public" >
		<cfquery name="qproject" datasource="#variables.dsn#">
		SELECT top 10 Surveys.* FROM Surveys ORDER BY Surveys.Date
    </cfquery>
		<cfreturn qproject>
	</cffunction>
<!---- get qSightningDetails ---->
	<cffunction name="qSightningDetails2" returntype="any" output="false" access="public" >
		<cfargument name="FORM" type="struct" required="true" default="0">
        <cfquery name="query" datasource="#variables.dsn#">
		 SELECT * from Survey_Sightings where Survey_Sightings.Project_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.PROJECT_ID#'> and Survey_Sightings.ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.sight_id#'>
		</cfquery>
		<cfreturn query>
	</cffunction>
<!---- get qSightningDetails ---->
	<cffunction name="qSightningDetails" returntype="any" output="false" access="public" >
		<cfargument name="sight_id" default="0">
        <cfquery name="query" datasource="#variables.dsn#">
		 SELECT * from Survey_Sightings  where Survey_Sightings.Project_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'> and Survey_Sightings.ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#sight_id#'>
         and Survey_Sightings.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
		</cfquery>
		<cfreturn query>
	</cffunction>
<!---- get List sighting ---->
	<cffunction name="getsightinglist" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
		 SELECT Survey_Sightings.ID,Survey_Sightings.SIGHTINGNUMBER
 		 from Survey_Sightings where Project_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'> 
          and Survey_Sightings.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
          and Survey_Sightings.SightingNumber != ''
          ORDER BY Survey_Sightings.ID
    </cfquery>
		<cfreturn query>
	</cffunction>
	<cffunction name="getsightingdolphins" returntype="any" output="false" access="public" >
		<cfquery name="qgetsightingdolphins" datasource="#variables.dsn#">
        SELECT
        Distinct(DOLPHINS.ID) as ID,
        DOLPHINS.Code,
        DOLPHINS.Name
        FROM
        DOLPHIN_SIGHTINGS
        INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
        where 
        DOLPHIN_SIGHTINGS.Dolphin_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Form.Sighting_ID#'>
		</cfquery>
		<cfreturn qgetsightingdolphins>
	</cffunction>
<!---- get getSelectedCamera ---->
	<cffunction name="getSelectedCamera" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT *
             FROM TLU_Camera f
                WHERE EXISTS (
                    SELECT Camera
                    FROM Survey_Sightings
                    WHERE CONCAT(',',Camera,',') LIKE CONCAT('%,',f.ID,',%')
                    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.sight_id#'>
                )
        </cfquery>
		<cfreturn query>
	</cffunction>
    <!---- get getSelectedLens ---->
	<cffunction name="getSelectedLens" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT *
             FROM TLU_Lens f
                WHERE EXISTS (
                    SELECT Lens
                    FROM Survey_Sightings
                    WHERE CONCAT(',',Lens,',') LIKE CONCAT('%,',f.ID,',%')
                    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.sight_id#'>
                )
        </cfquery>
		<cfreturn query>
	</cffunction>
    <!---- get getSelectedGrapher ---->
	<cffunction name="getSelectedGrapher" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT *
             FROM TLU_ResearchTeamMembers f
                WHERE EXISTS (
                    SELECT Photographer
                    FROM Survey_Sightings
                    WHERE CONCAT(',',Photographer,',') LIKE CONCAT('%,',f.RT_ID,',%')
                    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.sight_id#'>
                )
        </cfquery>
		<cfreturn query>
	</cffunction>

    <!---- get getSelectedDriver ---->
	<cffunction name="getSelectedDriver" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT *
             FROM TLU_ResearchTeamMembers f
                WHERE EXISTS (
                    SELECT Driver
                    FROM Survey_Sightings
                    WHERE CONCAT(',',Driver,',') LIKE CONCAT('%,',f.RT_ID,',%')
                    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.sight_id#'>
                )
        </cfquery>
		<cfreturn query>
	</cffunction>

<!---- get qGetWave ---->
	<cffunction name="qGetWave" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT DISTINCT TLU_WaveHight.[ID], TLU_WaveHight.[Desc]
            FROM TLU_WaveHight
        </cfquery>
		<cfreturn query>
	</cffunction>
<!---- get qGetWeather ---->
	<cffunction name="qGetWeather" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT DISTINCT TLU_Weather.[ID], TLU_Weather.[Desc]
            FROM TLU_Weather
        </cfquery>
		<cfreturn query>
	</cffunction>
<!---- get getSurveyArea ---->
	<cffunction name="getSurveyArea" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT a.*,s.StockName from TLU_SurveyArea a
            LEFT JOIN TLU_Stock s on a.StockID = s.ID
            <!---where a.Active=1---> order by a.AreaName asc
    </cfquery>
		<cfreturn query>
	</cffunction>
<!---- get getSubType ---->
	<cffunction name="getSubType" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
          SELECT s.*,t.Type from TLU_SubType s
          LEFT JOIN TLU_Type t on t.ID = s.SurveyTypeID
          <!---where s.Active=1---> order by s.SubType asc
        </cfquery>
		<cfreturn query>
	</cffunction>
<!---- get getType ---->
	<cffunction name="getType" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
      SELECT * from TLU_Type where Active=1 order by Type asc
    </cfquery>
		<cfreturn query>
	</cffunction>
<!---- get getSurvey ---->
	<cffunction name="getSurvey" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
        	SELECT * FROM TLU_Platform where active=1 order by Name asc
        </cfquery>
		<cfreturn query>
	</cffunction>
<!---- get getTeams ---->
	<cffunction name="getTeams" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
	SELECT * FROM TLU_ResearchTeamMembers <!---where active=1---> order by RT_MemberName asc
    </cfquery>
		<cfreturn query>
	</cffunction>
	<cffunction name="getprojectTeams" returntype="any" output="false" access="public" >
		<cfargument  name="PROJECT_ID" default="" type="any">
		<cfquery name="query" datasource="#variables.dsn#">
	  select RT_MemberName , RT_ID  from TLU_ResearchTeamMembers   inner join RESEARCHTEAMMEMBER_Surveys ON RESEARCHTEAMMEMBER_Surveys.RESEARCHTEAMMEMBER_ID = TLU_ResearchTeamMembers.RT_ID where RESEARCHTEAMMEMBER_Surveys.PROJECT_ID = #PROJECT_ID#
		</cfquery>
		<cfreturn query>
	</cffunction>
<!---- get qGetSightings ---->
	<cffunction name="qGetSightings" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT * FROM Survey_Sightings where Project_ID = #form.PROJECT_ID#
            ORDER BY Survey_Sightings.SightingNumber;
            </cfquery>
		<cfreturn query>
	</cffunction>
<!---- get qGetBeaufort ---->
	<cffunction name="qGetBeaufort" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
        	SELECT DISTINCT  TLU_Beaufort.[ID], TLU_Beaufort.[Desc], TLU_Beaufort.active FROM TLU_Beaufort <!---where active=1;--->
        </cfquery>
		<cfreturn query>
	</cffunction>
<!---- get qGetAssocBioData ---->
	<cffunction name="qGetAssocBioData" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
         SELECT * FROM TLU_AssocBioData <!---where active=1;--->
        </cfquery>
		<cfreturn query>
	</cffunction>

    <!---- get CetaceanResponseToFisher ---->
	<cffunction name="qCetaceanResponseToFisher" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
        	SELECT * FROM TLU_CetaceanResponseToFisher  where active=1 order by [Desc] asc
        </cfquery>
		<cfreturn query>
	</cffunction>

        <!---- get FisherResponseToCetacean ---->
	<cffunction name="qFisherResponseToCetacean" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
        	SELECT * FROM TLU_FisherResponseToCetacean  where active=1 order by [Desc] asc
        </cfquery>
		<cfreturn query>
	</cffunction>

    <!---- get CetaceanResponseToVessel ---->
	<cffunction name="qCetaceanResponseToVessel" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
        	SELECT * FROM TLU_CetaceanResponseToVessel  where active=1 order by [Desc] asc
        </cfquery>
		<cfreturn query>
	</cffunction>


    <!---- get VesselResponseToCetacean ---->
	<cffunction name="qVesselResponseToCetacean" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
        	SELECT * FROM TLU_VesselResponseToCetacean  where active=1 order by [Desc] asc
        </cfquery>
		<cfreturn query>
	</cffunction>


<!----Last Project ID ---->
	<cffunction name="qInsertid" returntype="any" output="false" access="public" >
		<cfquery name="qInsert" datasource="#variables.dsn#" >
		SELECT ISNULL(MAX(ID), 0) as id  from  Surveys 
	    </cfquery>
		<cfreturn qInsert>
	</cffunction>
<!---- Project Isnert----->
	<cffunction name="qInsertProject" returntype="any" output="true" access="public" >
        <cfargument default="" name="ResearchTeam">
        <cfargument default="" name="BodyOfWater">
		<cfargument default="" name="NOAAStock">
        <cfargument default="" name="SurveyType">
        <cfargument default="" name="SurveyRoute">
        <cfargument default="" name="Platform">
		<cfif isdefined('Form.SurveyType')>
			<cfset  SurveyType=form.SurveyType>
		</cfif>
		<cfif len(trim(form.ProjectDate)) NEQ 0>
			<cfset ProjectDate=form.ProjectDate>
        <cfelse>
			<cfset ProjectDate=NOW()>
		</cfif>
		<cfset dummydate=DateFormat(ProjectDate,"yyyy-mm-dd ")>
        
		<cfif len(trim(form.SurveyStart)) NEQ 0>
			<cfset SurveyStart=dummydate & form.SurveyStart>
		</cfif>
        
		<cfif len(trim(form.SurveyEnd)) NEQ 0>
			<cfset SurveyEnd=dummydate & form.SurveyEnd>
		</cfif>

       <cfif form.Platform eq "Land Survey" or #SurveyType# eq "Trail Camera">
            <cfset EngineOn = "">
            <cfset EngineOff = "">
        </cfif>
        <cfif EngineOn NEQ "" OR EngineOff NEQ "">
			<cfset EngineOn=dummydate & form.EngineOn>
            <cfset EngineOff=dummydate & form.EngineOff>
		</cfif>
		
		<cfquery name="qInsert" datasource="#variables.dsn#" result="return_data" >
            INSERT INTO Surveys (
            Date,
            SurveyStart,
            SurveyEnd,
            EngineOn,
            EngineOff,
            SurveyRoute,
            Platform,
            BodyOfWater,
            SurveyType,
            ResearchTeam,
            NOAAStock
            ) VALUES
           (
           <cfqueryparam cfsqltype="cf_sql_timestamp" value='#ProjectDate#'>,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SurveyStart#" null="#IIF(SurveyStart EQ "", true, false)#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SurveyEnd#" null="#IIF(SurveyEnd EQ "", true, false)#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#EngineOn#" null="#IIF(EngineOn EQ "", true, false)#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#EngineOff#" null="#IIF(EngineOff EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SurveyRoute#' null="#IIF(SurveyRoute EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Platform#' null="#IIF(Platform EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BodyOfWater#' null="#IIF(BodyOfWater EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SurveyType#' null="#IIF(SurveyType EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#ResearchTeam#' null="#IIF(ResearchTeam EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#NOAAStock#' null="#IIF(NOAAStock EQ "", true, false)#">
           )
        </cfquery>
		<cfreturn return_data>
	</cffunction>
<!---- Sight Isnert----->
	<cffunction name="InsertSight" returntype="any" output="false" access="public">
        <cfargument default="" name="Survey">
        <cfargument default="" name="PreySpeciesName">
        <cfargument default="" name="BehaviorName">
        <cfargument default="" name="AssocBio">
        <cfargument  name="project_id" default="0">
        <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
        <cfset fname = userinfo.first_name>
        <cfset lname = userinfo.last_name>
        <cfset name = "#fname# #lname#">
		<cfquery name="qgetSurvey" datasource="#variables.dsn#"  >
	        SELECT ID, [DATE] as pro_date from Surveys where id = #project_id#
		</cfquery>

		<cfset dummydate = DateFormat(qgetSurvey.pro_date,"yyyy-mm-dd ") >

		<cfif len(trim(form.SightingStart)) NEQ 0>
			<cfset SightingStart=dummydate & form.SightingStart >
		</cfif>

		<cfif len(trim(form.SightingEnd)) NEQ 0>
			<cfset SightingEnd=dummydate & form.SightingEnd >
		</cfif>

		<cfif  project_id GT 0>
			<cfset project_id = form.project_id >
		<cfelse>
			<cfset project_id = qgetSurvey.id>
		</cfif>
        <!---getting time for all Divetime fields and caculating total time --->
        <cfset dd= "2021-8-9">
        <cfset totaltimes = []>
        <cfset StratTimeDive = "StratTimeDive">
        <cfset EndTimeDive = "EndTimeDive">
        <cfloop index="index" from="1" to="5">
            <cfif #Evaluate(StratTimeDive&index)# neq '' and #Evaluate(EndTimeDive&index)# neq ''>
                <cfset start = '#dd# #Evaluate(StratTimeDive&index)#'>
                <cfset end = '#dd# #Evaluate(EndTimeDive&index)#'>
                <cfset totalSeconds = DateDiff("s",#start#,#end#)>
                <cfset days = int(totalSeconds /(24 * 60 * 60))>
                <cfset totalMinutes = int(totalSeconds /60)>
                <cfset minutesRemaining = totalMinutes - (days * 24 * 60)>
                <cfset secondsRemaining = totalSeconds - (days * 24 * 60 * 60)>
                <cfset hours = int(minutesRemaining / 60)>
                <cfset minutes = minutesRemaining mod 60>
                <cfset seconds = secondsRemaining mod 60>
                <cfif len(hours) eq 1>
                    <cfset hours = "0"&#hours#>
                </cfif>
                <cfif len(minutes) eq 1>
                    <cfset minutes = "0"&#minutes#>
                </cfif>
                <cfif len(seconds) eq 1>
                    <cfset seconds = "0"&#seconds#>
                </cfif>
                <cfset data = hours &":"& minutes &":" & seconds>
                <!---append array to store all five total times. --->
                <cfset arrayAppend(totaltimes, #data#)>
            <cfelse>
                <cfset arrayAppend(totaltimes, '')>
            </cfif>
        </cfloop>   
        <cfquery name="qInsert" datasource="#variables.dsn#" result="return_data" >
            INSERT INTO Survey_Sightings (
            Project_ID,
            SightingNumber,SightingStart,SightingEnd,Survey,Location,ICW_Start,
            InitialLatitude,InitialLongitude,AtLatitude,AtLongitude,EndLatitude,EndLongitude,
            WaveHeight,Weather,Glare,GlareDirection,Sightability,Beaufort,HabitatDepth,HabitatType,AirTemp,WaterTemp,WindSpeed,WindDirection,Tide,Salinity,
            InitialHeading,GeneralHeading,FinalHeading,AssocBio,
            FE_Species,FE_TotalCetaceans_Min,FE_TotalCetaceans_Max,FE_TotalCetacean_Best,FE_TotalCalves_Min,FE_TotalCalves_Max,FE_TotalCalves_Best,
            FE_YoungOfYear_Min,FE_YoungOfYear_Max,FE_YoungOfYear_Best,
            FE_TotalCetacean_takes,FE_TotalCalves_takes,FE_YoungOfYear_takes,
            Act_Mill,Act_Feed,Act_Prob_Feed,Act_Travel,Act_Object_Play,Act_Rest,Act_Social,Act_With_Boat,Act_Avoid_Boat,Act_Other,
            Behaviors,
            PreySpecies,Feeding_Lat,Feeding_Long,Structure_Present,
            NoOfFishers,NoOfCetaceansWithIn100mOfActiveFisher,Depredation,
            NoOfCetaceansWithIn100mOfRecreationVessels,NumberOfVessels,
            No_of_Cetaceans_wHBOI_Vessel,
            Camera,Lens,Photographer,Driver,
            Comments,
            EnteredBy,
            FE_TotalAdults_Min,
            FE_TotalAdults_Max,
            FE_TotalAdults_Best,
            FE_TotalAdults_takes,
            pH,
            DO,
            Conductivity,
            BehavioralSpecifics1,
            BehavioralSpecificsN1,
            BehavioralSpecifics2,
            BehavioralSpecificsN2,
            BehavioralSpecifics3,
            BehavioralSpecificsN3,
            BehavioralSpecifics4,
            BehavioralSpecificsN4,
            CetaceanResponsetoFisher1,
            CetaceanResponsetoFisher2,
            CetaceanResponsetoFisher3,
            FisherResponsetoCetacean1,
            FisherResponsetoCetacean2,
            FisherResponsetoCetacean3,
            FisherResponsetoCetacean4,
            CetaceanResponsetoVessel1,
            CetaceanResponsetoVessel2,
            CetaceanResponsetoVessel3,
            VesselResponsetoCetacean1,
            VesselResponsetoCetacean2,
            VesselResponsetoCetacean3,
            VesselResponsetoCetacean4,
            ReactiontoHBOIVessel1,
            ReactiontoHBOIVessel2,
            ReactiontoHBOIVessel3,
            StratTimeDive1,
            StratTimeDive2,
            StratTimeDive3,
            StratTimeDive4,
            StratTimeDive5,
            EndTimeDive1,
            EndTimeDive2,
            EndTimeDive3,
            EndTimeDive4,
            EndTimeDive5,
            TotalTimeDive1,
            TotalTimeDive2,
            TotalTimeDive3,
            TotalTimeDive4,
            TotalTimeDive5,
            groupeSelect1,
            groupeSelect2,
            groupeSelect3,
            groupeSelect4,
            distanceSelect1,
            distanceSelect2,
            distanceSelect3,
            distanceSelect4
            )
            VALUES (
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#project_id#'>,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SightingNumber#' null="#IIF(SightingNumber EQ "", true, false)#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SightingStart#" null="#IIF(SightingStart EQ "", true, false)#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SightingEnd#" null="#IIF(SightingEnd EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Survey#' null="#IIF(Survey EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Location#' null="#IIF(Location EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#ICW_Start#' null="#IIF(ICW_Start EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#InitialLatitude#' null="#IIF(InitialLatitude EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#InitialLongitude#' null="#IIF(InitialLongitude EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#AtLatitude#' null="#IIF(AtLatitude EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#AtLongitude#' null="#IIF(AtLongitude EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndLatitude#' null="#IIF(EndLatitude EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndLongitude#' null="#IIF(EndLongitude EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#WaveHeight#' null="#IIF(WaveHeight EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Weather#' null="#IIF(Weather EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Glare#' null="#IIF(Glare EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#GlareDirection#' null="#IIF(GlareDirection EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Sightability#' null="#IIF(Sightability EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Beaufort#' null="#IIF(Beaufort EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#HabitatDepth#' null="#IIF(HabitatDepth EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#HabitatType#' null="#IIF(HabitatType EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#AirTemp#' null="#IIF(AirTemp EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#WaterTemp#' null="#IIF(WaterTemp EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#WindSpeed#' null="#IIF(WindSpeed EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#WindDirection#' null="#IIF(WindDirection EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Tide#' null="#IIF(Tide EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Salinity#' null="#IIF(Salinity EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#InitialHeading#' null="#IIF(InitialHeading EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#GeneralHeading#' null="#IIF(GeneralHeading EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FinalHeading#' null="#IIF(FinalHeading EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#AssocBio#' null="#IIF(AssocBio EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_Species#' null="#IIF(FE_Species EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCetaceans_Min#' null="#IIF(FE_TotalCetaceans_Min EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCetaceans_Max#' null="#IIF(FE_TotalCetaceans_Max EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCetacean_Best#' null="#IIF(FE_TotalCetacean_Best EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCalves_Min#' null="#IIF(FE_TotalCalves_Min EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCalves_Max#' null="#IIF(FE_TotalCalves_Max EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCalves_Best#' null="#IIF(FE_TotalCalves_Best EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_YoungOfYear_Min#' null="#IIF(FE_YoungOfYear_Min EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_YoungOfYear_Max#' null="#IIF(FE_YoungOfYear_Max EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_YoungOfYear_Best#' null="#IIF(FE_YoungOfYear_Best EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCetacean_takes#' null="#IIF(FE_TotalCetacean_takes EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCalves_takes#' null="#IIF(FE_TotalCalves_takes EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_YoungOfYear_takes#' null="#IIF(FE_YoungOfYear_takes EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Mill#' null="#IIF(Act_Mill EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Feed#' null="#IIF(Act_Feed EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Prob_Feed#' null="#IIF(Act_Prob_Feed EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Travel#' null="#IIF(Act_Travel EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Object_Play#' null="#IIF(Act_Object_Play EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Rest#' null="#IIF(Act_Rest EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Social#' null="#IIF(Act_Social EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_With_Boat#' null="#IIF(Act_With_Boat EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Avoid_Boat#' null="#IIF(Act_Avoid_Boat EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Other#' null="#IIF(Act_Other EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BehaviorName#' null="#IIF(BehaviorName EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#PreySpeciesName#' null="#IIF(PreySpeciesName EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Feeding_Lat#' null="#IIF(Feeding_Lat EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Feeding_Long#' null="#IIF(Feeding_Long EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Structure_Present#' null="#IIF(Structure_Present EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#NoOfFishers#' null="#IIF(NoOfFishers EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#NoOfCetaceansWithIn100mOfActiveFisher#' null="#IIF(NoOfCetaceansWithIn100mOfActiveFisher EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Depredation#' null="#IIF(Depredation EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#NoOfCetaceansWithIn100mOfRecreationVessels#' null="#IIF(NoOfCetaceansWithIn100mOfRecreationVessels EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#NumberOfVessels#' null="#IIF(NumberOfVessels EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#No_of_Cetaceans_wHBOI_Vessel#' null="#IIF(No_of_Cetaceans_wHBOI_Vessel EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Camera#' null="#IIF(Camera EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Lens#' null="#IIF(Lens EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Photographer#' null="#IIF(Photographer EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Driver#' null="#IIF(Driver EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Comments#' null="#IIF(Comments EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#name#' null="#IIF(name EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalAdults_Min#' null="#IIF(FE_TotalAdults_Min EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalAdults_Max#' null="#IIF(FE_TotalAdults_Max EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalAdults_Best#' null="#IIF(FE_TotalAdults_Best EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalAdults_takes#' null="#IIF(FE_TotalAdults_takes EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#pH#' null="#IIF(pH EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#DO#' null="#IIF(DO EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Conductivity#' null="#IIF(Conductivity EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BehavioralSpecifics1#' null="#IIF(BehavioralSpecifics1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecificsN1#' null="#IIF(BehavioralSpecificsN1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BehavioralSpecifics2#' null="#IIF(BehavioralSpecifics2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecificsN2#' null="#IIF(BehavioralSpecificsN2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BehavioralSpecifics3#' null="#IIF(BehavioralSpecifics3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecificsN3#' null="#IIF(BehavioralSpecificsN3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecifics4#' null="#IIF(BehavioralSpecifics4 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecificsN4#' null="#IIF(BehavioralSpecificsN4 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoFisher1#' null="#IIF(CetaceanResponsetoFisher1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoFisher2#' null="#IIF(CetaceanResponsetoFisher2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoFisher3#' null="#IIF(CetaceanResponsetoFisher3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FisherResponsetoCetacean1#' null="#IIF(FisherResponsetoCetacean1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FisherResponsetoCetacean2#' null="#IIF(FisherResponsetoCetacean2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FisherResponsetoCetacean3#' null="#IIF(FisherResponsetoCetacean3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FisherResponsetoCetacean4#' null="#IIF(FisherResponsetoCetacean4 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoVessel1#' null="#IIF(CetaceanResponsetoVessel1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoVessel2#' null="#IIF(CetaceanResponsetoVessel2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoVessel3#' null="#IIF(CetaceanResponsetoVessel3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#VesselResponsetoCetacean1#' null="#IIF(VesselResponsetoCetacean1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#VesselResponsetoCetacean2#' null="#IIF(VesselResponsetoCetacean2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#VesselResponsetoCetacean3#' null="#IIF(VesselResponsetoCetacean3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#VesselResponsetoCetacean4#' null="#IIF(VesselResponsetoCetacean4 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#ReactiontoHBOIVessel1#' null="#IIF(ReactiontoHBOIVessel1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#ReactiontoHBOIVessel2#' null="#IIF(ReactiontoHBOIVessel2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#ReactiontoHBOIVessel3#' null="#IIF(ReactiontoHBOIVessel3 EQ "", true, false)#">,
          
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive1#' null="#IIF(StratTimeDive1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive2#' null="#IIF(StratTimeDive2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive3#' null="#IIF(StratTimeDive3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive4#' null="#IIF(StratTimeDive4 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive5#' null="#IIF(StratTimeDive5 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive1#' null="#IIF(EndTimeDive1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive2#' null="#IIF(EndTimeDive2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive3#' null="#IIF(EndTimeDive3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive4#' null="#IIF(EndTimeDive4 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive5#' null="#IIF(EndTimeDive5 EQ "", true, false)#">,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[1]#' null="#IIF(totaltimes[1] EQ "", true, false)#">,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[2]#' null="#IIF(totaltimes[2] EQ "", true, false)#">,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[3]#' null="#IIF(totaltimes[3] EQ "", true, false)#">,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[4]#' null="#IIF(totaltimes[4] EQ "", true, false)#">,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[5]#' null="#IIF(totaltimes[5] EQ "", true, false)#">,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.groupeSelect1#'>,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.groupeSelect2#'>,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.groupeSelect3#'>,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.groupeSelect4#'>,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.distanceSelect1#'>,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.distanceSelect2#'>,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.distanceSelect3#'>,
            <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.distanceSelect4#'>
           
           )
        </cfquery>
		<cfreturn return_data>
    
	</cffunction>
    
   <!---- get qUpdate sight ---->
    <cffunction name="qUpdateProject_SIGHT" returntype="any" output="false" access="public" >
        <cfquery name="qgetdate" datasource="#variables.dsn#"  >
	        SELECT [DATE] as pro_date from Surveys where id = #form.project_id#
		</cfquery>
		<cfset dummydate = DateFormat(qgetdate.pro_date,"yyyy-mm-dd ") >
		<cfif len(trim(form.SightingStart)) NEQ 0>
			<cfset SightingStart=dummydate & form.SightingStart >
		</cfif>
		<cfif len(trim(form.SightingEnd)) NEQ 0>
			<cfset SightingEnd=dummydate & form.SightingEnd >
		</cfif>
		<cfif isdefined('form.Survey')>
			<cfset Survey=form.Survey >
		<cfelse>
			<cfset Survey=''>
		</cfif>
         <cfif isdefined('form.PreySpeciesName')>
			<cfset PreySpeciesName=form.PreySpeciesName >
		<cfelse>
			<cfset PreySpeciesName=''>
		</cfif>
         <cfif isdefined('form.BehaviorName')>
			<cfset BehaviorName=form.BehaviorName >
		<cfelse>
			<cfset BehaviorName=''>
		</cfif>
        <cfif isdefined('form.AssocBio')>
			<cfset AssocBio=form.AssocBio >
		<cfelse>
			<cfset AssocBio=''>
		</cfif>
        <cfset dd= "2021-8-9">
        <cfset totaltimes = []>
        <cfset StratTimeDive = "StratTimeDive">
        <cfset EndTimeDive = "EndTimeDive">
        <cfloop index="index" from="1" to="5">
            <cfif #Evaluate(StratTimeDive&index)# neq '' and #Evaluate(EndTimeDive&index)# neq ''>
                <cfset start = '#dd# #Evaluate(StratTimeDive&index)#'>
                <cfset end = '#dd# #Evaluate(EndTimeDive&index)#'>
                <cfset totalSeconds = DateDiff("s",#start#,#end#)>
                <cfset days = int(totalSeconds /(24 * 60 * 60))>
                <cfset totalMinutes = int(totalSeconds /60)>
                <cfset minutesRemaining = totalMinutes - (days * 24 * 60)>
                <cfset secondsRemaining = totalSeconds - (days * 24 * 60 * 60)>
                <cfset hours = int(minutesRemaining / 60)>
                <cfset minutes = minutesRemaining mod 60>
                <cfset seconds = secondsRemaining mod 60>
                <cfif len(hours) eq 1>
                    <cfset hours = "0"&#hours#>
                </cfif>
                <cfif len(minutes) eq 1>
                    <cfset minutes = "0"&#minutes#>
                </cfif>
                <cfif len(seconds) eq 1>
                    <cfset seconds = "0"&#seconds#>
                </cfif>
                <cfset data = hours &":"& minutes &":" & seconds>
                <!---append array to store all five total times. --->
                <cfset arrayAppend(totaltimes, #data#)>
            <cfelse>
                <cfset arrayAppend(totaltimes, '')>
            </cfif>
        </cfloop>       
        <cfquery name="query" datasource="#variables.dsn#" result="return_data">
            UPDATE Survey_Sightings SET
             SightingNumber =<cfqueryparam cfsqltype="cf_sql_varchar" value="#SightingNumber#" null="#IIF(SightingNumber EQ "", true, false)#">,
             SightingStart = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SightingStart#" null="#IIF(SightingStart EQ "", true, false)#">,
             SightingEnd = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SightingEnd#" null="#IIF(SightingEnd EQ "", true, false)#">,
             Survey = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Survey#' null="#IIF(Survey EQ "", true, false)#">,
             Location = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Location#' null="#IIF(Location EQ "", true, false)#">,
             ICW_Start = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#ICW_Start#' null="#IIF(ICW_Start EQ "", true, false)#">,
             InitialLatitude = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#InitialLatitude#' null="#IIF(InitialLatitude EQ "", true, false)#">,
             InitialLongitude = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#InitialLongitude#' null="#IIF(InitialLongitude EQ "", true, false)#">,
             AtLatitude =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#AtLatitude#' null="#IIF(AtLatitude EQ "", true, false)#">,
             AtLongitude =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#AtLongitude#' null="#IIF(AtLongitude EQ "", true, false)#">,
             EndLatitude = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndLatitude#' null="#IIF(EndLatitude EQ "", true, false)#">,
             EndLongitude = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndLongitude#' null="#IIF(EndLongitude EQ "", true, false)#">,
             WaveHeight = <cfqueryparam  cfsqltype="cf_sql_integer" value='#WaveHeight#' null="#IIF(WaveHeight EQ "", true, false)#">,
             Weather = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Weather#' null="#IIF(Weather EQ "", true, false)#">,
             Glare = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Glare#' null="#IIF(Glare EQ "", true, false)#">,
             GlareDirection = <cfqueryparam  cfsqltype="cf_sql_integer" value='#GlareDirection#' null="#IIF(GlareDirection EQ "", true, false)#">,
             Sightability = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Sightability#' null="#IIF(Sightability EQ "", true, false)#">,
             Beaufort =  <cfqueryparam  cfsqltype="cf_sql_integer" value='#Beaufort#' null="#IIF(Beaufort EQ "", true, false)#">,
             HabitatDepth = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#HabitatDepth#' null="#IIF(HabitatDepth EQ "", true, false)#">,
             HabitatType =   <cfqueryparam  cfsqltype="cf_sql_integer" value='#HabitatType#' null="#IIF(HabitatType EQ "", true, false)#">,
             AirTemp = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#AirTemp#' null="#IIF(AirTemp EQ "", true, false)#">,
             WaterTemp =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#WaterTemp#' null="#IIF(WaterTemp EQ "", true, false)#">,
             WindSpeed =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#WindSpeed#' null="#IIF(WindSpeed EQ "", true, false)#">,
             WindDirection = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#WindDirection#' null="#IIF(WindDirection EQ "", true, false)#">,
             Tide = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Tide#' null="#IIF(Tide EQ "", true, false)#">,
             Salinity = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Salinity#' null="#IIF(Salinity EQ "", true, false)#">,
             InitialHeading =  <cfqueryparam  cfsqltype="cf_sql_integer" value='#InitialHeading#' null="#IIF(InitialHeading EQ "", true, false)#">,
             GeneralHeading = <cfqueryparam  cfsqltype="cf_sql_integer" value='#GeneralHeading#' null="#IIF(GeneralHeading EQ "", true, false)#">,
             FinalHeading =  <cfqueryparam  cfsqltype="cf_sql_integer" value='#FinalHeading#' null="#IIF(FinalHeading EQ "", true, false)#">,
             AssocBio =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#AssocBio#' null="#IIF(AssocBio EQ "", true, false)#">,
             FE_Species = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_Species#' null="#IIF(FE_Species EQ "", true, false)#">,
             FE_TotalCetaceans_Min = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCetaceans_Min#' null="#IIF(FE_TotalCetaceans_Min EQ "", true, false)#">,
             FE_TotalCetaceans_Max = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCetaceans_Max#' null="#IIF(FE_TotalCetaceans_Max EQ "", true, false)#">,
             FE_TotalCetacean_Best = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCetacean_Best#' null="#IIF(FE_TotalCetacean_Best EQ "", true, false)#">,
             FE_TotalCalves_Min =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCalves_Min#' null="#IIF(FE_TotalCalves_Min EQ "", true, false)#">,
             FE_TotalCalves_Max =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCalves_Max#' null="#IIF(FE_TotalCalves_Max EQ "", true, false)#">,
             FE_TotalCalves_Best = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCalves_Best#' null="#IIF(FE_TotalCalves_Best EQ "", true, false)#">,
             FE_YoungOfYear_Min =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_YoungOfYear_Min#' null="#IIF(FE_YoungOfYear_Min EQ "", true, false)#">,
             FE_YoungOfYear_Max = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_YoungOfYear_Max#' null="#IIF(FE_YoungOfYear_Max EQ "", true, false)#">,
             FE_YoungOfYear_Best = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_YoungOfYear_Best#' null="#IIF(FE_YoungOfYear_Best EQ "", true, false)#">,
             FE_TotalCetacean_takes = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCetacean_takes#' null="#IIF(FE_TotalCetacean_takes EQ "", true, false)#">,
             FE_TotalCalves_takes = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalCalves_takes#' null="#IIF(FE_TotalCalves_takes EQ "", true, false)#">,
             FE_YoungOfYear_takes = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_YoungOfYear_takes#' null="#IIF(FE_YoungOfYear_takes EQ "", true, false)#">,
             Act_Mill = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Mill#' null="#IIF(Act_Mill EQ "", true, false)#">,
             Act_Feed = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Feed#' null="#IIF(Act_Feed EQ "", true, false)#">,
             Act_Prob_Feed = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Prob_Feed#' null="#IIF(Act_Prob_Feed EQ "", true, false)#">,
             Act_Travel =  <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Travel#' null="#IIF(Act_Travel EQ "", true, false)#">,
             Act_Object_Play = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Object_Play#' null="#IIF(Act_Object_Play EQ "", true, false)#">,
             Act_Rest = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Rest#' null="#IIF(Act_Rest EQ "", true, false)#">,
             Act_Social =  <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Social#' null="#IIF(Act_Social EQ "", true, false)#">,
             Act_With_Boat =  <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_With_Boat#' null="#IIF(Act_With_Boat EQ "", true, false)#">,
             Act_Avoid_Boat = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Avoid_Boat#' null="#IIF(Act_Avoid_Boat EQ "", true, false)#">,
             Act_Other = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Act_Other#' null="#IIF(Act_Other EQ "", true, false)#">,
             Behaviors =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BehaviorName#' null="#IIF(BehaviorName EQ "", true, false)#">,
             PreySpecies = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#PreySpeciesName#' null="#IIF(PreySpeciesName EQ "", true, false)#">,
             Feeding_Lat =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Feeding_Lat#' null="#IIF(Feeding_Lat EQ "", true, false)#">,
             Feeding_Long = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Feeding_Long#' null="#IIF(Feeding_Long EQ "", true, false)#">,
             Structure_Present =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Structure_Present#' null="#IIF(Structure_Present EQ "", true, false)#">,
             NoOfCetaceansWithIn100mOfActiveFisher = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#NoOfCetaceansWithIn100mOfActiveFisher#' null="#IIF(NoOfCetaceansWithIn100mOfActiveFisher EQ "", true, false)#">,
             Depredation =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Depredation#' null="#IIF(Depredation EQ "", true, false)#">,
             NoOfFishers =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#NoOfFishers#' null="#IIF(NoOfFishers EQ "", true, false)#">,
             NoOfCetaceansWithIn100mOfRecreationVessels =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#NoOfCetaceansWithIn100mOfRecreationVessels#' null="#IIF(NoOfCetaceansWithIn100mOfRecreationVessels EQ "", true, false)#">,
             NumberOfVessels = <cfqueryparam  cfsqltype="cf_sql_integer" value='#NumberOfVessels#' null="#IIF(NumberOfVessels EQ "", true, false)#">,
             No_of_Cetaceans_wHBOI_Vessel = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#No_of_Cetaceans_wHBOI_Vessel#' null="#IIF(No_of_Cetaceans_wHBOI_Vessel EQ "", true, false)#">,
             Camera =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Camera#' null="#IIF(Camera EQ "", true, false)#">,
             Lens =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Lens#' null="#IIF(Lens EQ "", true, false)#">,
             Photographer = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Photographer#' null="#IIF(Photographer EQ "", true, false)#">,
             Driver =  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Driver#' null="#IIF(Driver EQ "", true, false)#">,
             Comments = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Comments#' null="#IIF(Comments EQ "", true, false)#">,
             FE_TotalAdults_Min = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalAdults_Min#' null="#IIF(FE_TotalAdults_Min EQ "", true, false)#">,
             FE_TotalAdults_Max = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalAdults_Max#' null="#IIF(FE_TotalAdults_Max EQ "", true, false)#">,
             FE_TotalAdults_Best = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalAdults_Best#' null="#IIF(FE_TotalAdults_Best EQ "", true, false)#">,
             FE_TotalAdults_takes = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FE_TotalAdults_takes#' null="#IIF(FE_TotalAdults_takes EQ "", true, false)#">,
             pH = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#pH#' null="#IIF(pH EQ "", true, false)#">,
             DO = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#DO#' null="#IIF(DO EQ "", true, false)#">,
             Conductivity = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Conductivity#' null="#IIF(Conductivity EQ "", true, false)#">,
            BehavioralSpecifics1 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BehavioralSpecifics1#' null="#IIF(BehavioralSpecifics1 EQ "", true, false)#">,
            BehavioralSpecificsN1 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecificsN1#' null="#IIF(BehavioralSpecificsN1 EQ "", true, false)#">,
            BehavioralSpecifics2 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BehavioralSpecifics2#' null="#IIF(BehavioralSpecifics2 EQ "", true, false)#">,
            BehavioralSpecificsN2 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecificsN2#' null="#IIF(BehavioralSpecificsN2 EQ "", true, false)#">,
            BehavioralSpecifics3 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BehavioralSpecifics3#' null="#IIF(BehavioralSpecifics3 EQ "", true, false)#">,
            BehavioralSpecificsN3 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecificsN3#' null="#IIF(BehavioralSpecificsN3 EQ "", true, false)#">,
            BehavioralSpecifics4 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecifics4#' null="#IIF(BehavioralSpecifics4 EQ "", true, false)#">,
            BehavioralSpecificsN4 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#BehavioralSpecificsN4#' null="#IIF(BehavioralSpecificsN4 EQ "", true, false)#">,
            CetaceanResponsetoFisher1 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoFisher1#' null="#IIF(CetaceanResponsetoFisher1 EQ "", true, false)#">,
            CetaceanResponsetoFisher2 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoFisher2#' null="#IIF(CetaceanResponsetoFisher2 EQ "", true, false)#">,
            CetaceanResponsetoFisher3 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoFisher3#' null="#IIF(CetaceanResponsetoFisher3 EQ "", true, false)#">,
            FisherResponsetoCetacean1 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FisherResponsetoCetacean1#' null="#IIF(FisherResponsetoCetacean1 EQ "", true, false)#">,
            FisherResponsetoCetacean2 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FisherResponsetoCetacean2#' null="#IIF(FisherResponsetoCetacean2 EQ "", true, false)#">,
            FisherResponsetoCetacean3 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FisherResponsetoCetacean3#' null="#IIF(FisherResponsetoCetacean3 EQ "", true, false)#">,
            FisherResponsetoCetacean4 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FisherResponsetoCetacean4#' null="#IIF(FisherResponsetoCetacean4 EQ "", true, false)#">,
            CetaceanResponsetoVessel1 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoVessel1#' null="#IIF(CetaceanResponsetoVessel1 EQ "", true, false)#">,
            CetaceanResponsetoVessel2 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoVessel2#' null="#IIF(CetaceanResponsetoVessel2 EQ "", true, false)#">,
            CetaceanResponsetoVessel3 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#CetaceanResponsetoVessel3#' null="#IIF(CetaceanResponsetoVessel3 EQ "", true, false)#">,
            VesselResponsetoCetacean1 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#VesselResponsetoCetacean1#' null="#IIF(VesselResponsetoCetacean1 EQ "", true, false)#">,
            VesselResponsetoCetacean2 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#VesselResponsetoCetacean2#' null="#IIF(VesselResponsetoCetacean2 EQ "", true, false)#">,
            VesselResponsetoCetacean3 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#VesselResponsetoCetacean3#' null="#IIF(VesselResponsetoCetacean3 EQ "", true, false)#">,
            VesselResponsetoCetacean4 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#VesselResponsetoCetacean4#' null="#IIF(VesselResponsetoCetacean4 EQ "", true, false)#">,
            ReactiontoHBOIVessel1 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#ReactiontoHBOIVessel1#' null="#IIF(ReactiontoHBOIVessel1 EQ "", true, false)#">,
            ReactiontoHBOIVessel2 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#ReactiontoHBOIVessel2#' null="#IIF(ReactiontoHBOIVessel2 EQ "", true, false)#">,
            ReactiontoHBOIVessel3 = <cfqueryparam  cfsqltype="cf_sql_integer" value='#ReactiontoHBOIVessel3#' null="#IIF(ReactiontoHBOIVessel3 EQ "", true, false)#">,
            StratTimeDive1 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive1#' null="#IIF(StratTimeDive1 EQ "", true, false)#">,
            StratTimeDive2 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive2#' null="#IIF(StratTimeDive2 EQ "", true, false)#">,
            StratTimeDive3 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive3#' null="#IIF(StratTimeDive3 EQ "", true, false)#">,
            StratTimeDive4 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive4#' null="#IIF(StratTimeDive4 EQ "", true, false)#">,
            StratTimeDive5 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#StratTimeDive5#' null="#IIF(StratTimeDive5 EQ "", true, false)#">,
            EndTimeDive1 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive1#' null="#IIF(EndTimeDive1 EQ "", true, false)#">,
            EndTimeDive2 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive2#' null="#IIF(EndTimeDive2 EQ "", true, false)#">,
            EndTimeDive3 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive3#' null="#IIF(EndTimeDive3 EQ "", true, false)#">,
            EndTimeDive4 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive4#' null="#IIF(EndTimeDive4 EQ "", true, false)#">,
            EndTimeDive5 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#EndTimeDive5#' null="#IIF(EndTimeDive5 EQ "", true, false)#">,
            TotalTimeDive1 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[1]#' null="#IIF(totaltimes[1] EQ "", true, false)#">,
            TotalTimeDive2 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[2]#' null="#IIF(totaltimes[2] EQ "", true, false)#">,
            TotalTimeDive3 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[3]#' null="#IIF(totaltimes[3] EQ "", true, false)#">,
            TotalTimeDive4 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[4]#' null="#IIF(totaltimes[4] EQ "", true, false)#">,
            TotalTimeDive5 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#totaltimes[5]#' null="#IIF(totaltimes[5] EQ "", true, false)#">,
            groupeSelect1 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.groupeSelect1#'>,
            groupeSelect2 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.groupeSelect2#'>,
            groupeSelect3 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.groupeSelect3#'>,
            groupeSelect4 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.groupeSelect4#'>,
            distanceSelect1 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.distanceSelect1#'>,
            distanceSelect2 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.distanceSelect2#'>,
            distanceSelect3 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.distanceSelect3#'>,
            distanceSelect4 = <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.distanceSelect4#'>
           

             WHERE Project_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.project_id#'> and
             ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.sight_id#'>
        </cfquery>
		<cfreturn return_data>
	</cffunction>

    <cffunction name="IncidentSighting" returntype="any" output="false" access="public">
        <cfdump var=#form#>
        <cfabort>
    </cffunction>
<!----Last sight ID ---->
	<cffunction name="qInsertids" returntype="any" output="false" access="public" >
		<cfquery name="qInsertid" datasource="#variables.dsn#" >
		SELECT ISNULL(MAX(ID), 0) as ids  from  Survey_Sightings 
	</cfquery>
		<cfreturn qInsertid>
	</cffunction>
<!----Get Camera Roll ---->
	<cffunction name="qPHOTO_ROLLS" returntype="any" output="false" access="public" >
		<cfquery name="photorolls" datasource="#variables.dsn#" >
		    SELECT ISNULL(MAX(ID), 0) as ids  from  PHOTO_ROLLS
	    </cfquery>
		<cfreturn photorolls>
	</cffunction>
<!----Inset Camera/lens  ---->
	<cffunction name="camera_lensinsert" returntype="any" output="false" access="public" >
		<cfset qPHOTO_ROLLS = Application.Sighting.qPHOTO_ROLLS()>
		<cfset qInsertids = Application.Sighting.qInsertids()>
		<cfset id = qInsertids.ids>
		<cfquery name="qcamera" datasource="#variables.dsn#" result="data_res" >
            insert into  PHOTO_ROLLS (Sighting_ID,Camera,Lens,Photographer,Driver)
            values( <cfqueryparam  cfsqltype="cf_sql_integer" value='#id#'>,
                 <cfqueryparam  cfsqltype="cf_sql_integer" value='#Camera_value_id#' null="#IIF(Camera_value_id EQ "", true, false)#">,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Lens_value_id#' null="#IIF(Lens_value_id EQ "", true, false)#">,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Photographer#' null="#IIF(Photographer EQ "", true, false)#">,
                     <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Driver#' null="#IIF(Driver EQ "", true, false)#">
                  );
	    </cfquery>
		<cfreturn data_res>
	</cffunction>
<!--- Camera list --->
	<cffunction name="getCamera" returntype="any" output="false" access="public" >
		<cfquery name="qgetCamera" datasource="#variables.dsn#"  >
          SELECT * from TLU_Camera where active=1 order by Camera asc
        </cfquery>
		<cfreturn qgetCamera>
	</cffunction>
    <cffunction name="getTide" returntype="any" output="false" access="public" >
		<cfquery name="qgetTide" datasource="#variables.dsn#"  >
            SELECT * from TLU_Tide <!---where active=1--->
        </cfquery>
		<cfreturn qgetTide>
	</cffunction>
    <cffunction name="getHabitat" returntype="any" output="false" access="public" >
		<cfquery name="qgetHabitat" datasource="#variables.dsn#"  >
            SELECT * from TLU_Habitat <!---where active=1--->
        </cfquery>
		<cfreturn qgetHabitat>
	</cffunction>
    <cffunction name="getStructureList" returntype="any" output="false" access="public" >
		<cfquery name="qgetStructureList" datasource="#variables.dsn#"  >
            SELECT * from TLU_Structures <!---where active=1--->
        </cfquery>
		<cfreturn qgetStructureList>
	</cffunction>
<!---- Lens List ---->
	<cffunction name="getLens" returntype="any" output="false" access="public" >
		<cfquery name="qgetLens" datasource="#variables.dsn#"  >
            SELECT * from TLU_Lens where active=1 order by Lens asc
        </cfquery>
		<cfreturn qgetLens>
	</cffunction>
<!-----Zone List---->
	<cffunction name="zonelistall" returntype="any" output="false" access="public" >
		<cfquery name="zonelist_q" datasource="#variables.dsn#">
            SELECT * FROM TLU_Zones
 	    </cfquery>
		<cfreturn zonelist_q>
	</cffunction>
    <cffunction name="zonelist" returntype="any" output="false" access="public" >
		<cfquery name="zonelist_q" datasource="#variables.dsn#">
            SELECT dbo.TLU_Zones.[ZONE], Max (dbo.TLU_Zones.ID) as id FROM dbo.TLU_Zones GROUP BY dbo.TLU_Zones.[ZONE] order by dbo.TLU_Zones.[ZONE]
 	    </cfquery>
		<cfreturn zonelist_q>
	</cffunction>
<!--- Get lsit of project --->
	<cffunction name="qSurveysId" returntype="any" output="false" access="public" >
		<cfquery name="qprojectID" datasource="#variables.dsn#"  >
     	SELECT id,Date FROM Surveys 
        where Surveys.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
        order by id DESC 
    </cfquery>
		<cfreturn qprojectID>
	</cffunction>
    <cffunction name="qSurveysdate" returntype="any" output="false" access="public" >
		<cfquery name="qSurveysDate" datasource="#variables.dsn#"  >
     	SELECT id,Date FROM Surveys 
        where Surveys.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
        order by DATE DESC 
    </cfquery>
		<cfreturn qSurveysDate>
	</cffunction>
<!--- Get lsit of Sight Dolphin --->
	<cffunction name="dolphine_sight" returntype="any" output="false" access="public" >
		<cfargument name="Sighting_ID" default="" required>
		<cfquery name="dolphine_sight_query" datasource="#variables.dsn#" >
             SELECT  ,DOLPHINS.*,FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE 	DOLPHIN_SIGHTINGS.Sighting_ID=#Sighting_ID# order by DOLPHIN_SIGHTINGS.Sighting_ID;
	    </cfquery>
		<cfreturn dolphine_sight_query>
	</cffunction>
    <!---get stock--->
	<cffunction name="getStock" returntype="any" output="false" access="public" >
		<cfquery name="qgetStock" datasource="#variables.dsn#"  >
        SELECT * from TLU_Stock where active = 1 order by StockName asc
    </cfquery>
		<cfreturn qgetStock>
	</cffunction>
    <cffunction name="getWaveHeight" returntype="any" output="false" access="public" >
		<cfquery name="qgetWaveHeight" datasource="#variables.dsn#"  >
        SELECT TLU_WaveHight.ID, TLU_WaveHight.[Desc], TLU_WaveHight.active FROM TLU_WaveHight <!---where active=1--->
    </cfquery>
		<cfreturn qgetWaveHeight>
	</cffunction>
    <cffunction name="getWeather" returntype="any" output="false" access="public" >
		<cfquery name="qgetWeather" datasource="#variables.dsn#"  >
           SELECT TLU_Weather.ID, TLU_Weather.[Desc], TLU_Weather.active FROM TLU_Weather <!---where active=1--->
        </cfquery>
		<cfreturn qgetWeather>
	</cffunction>
    <cffunction name="getGlare" returntype="any" output="false" access="public" >
		<cfquery name="qgetGlare" datasource="#variables.dsn#"  >
          SELECT  TLU_Glare.ID, TLU_Glare.[Desc], TLU_Glare.active
          FROM TLU_Glare <!---where active=1--->
        </cfquery>
		<cfreturn qgetGlare>
	</cffunction>
    <cffunction name="getSightability" returntype="any" output="false" access="public" >
		<cfquery name="qgetSightability" datasource="#variables.dsn#"  >
            SELECT  TLU_Sightability.ID, TLU_Sightability.[Desc], TLU_Sightability.active
            FROM TLU_Sightability <!---where active=1--->
        </cfquery>
		<cfreturn qgetSightability>
	</cffunction>
    <cffunction name="qGetZone" returnformat="plain" output="true" access="remote">
		<cfargument name="Easting" default="" required="yes">
		<cfargument name="Northing" default="" required="yes">
		<cfquery name="query" datasource="#variables.dsn#">
		SELECT id, zone FROM TLU_Zones where EASTING = #Easting# AND NORTHING = #Northing#
		</cfquery>
		<cfoutput>#SerializeJSON(query)#</cfoutput>
	</cffunction>
	<cffunction name="get_NCSG" returntype="any" output="false" access="public" >
		<cfargument name="Sighting_ID" required="yes">
		<cfquery name="qncsg" datasource="#variables.dsn#" result="data_res" >
        select * from TLU_NCSG where sighting_ID= <cfqueryparam cfsqltype="cf_sql_integer" value='#Sighting_ID#' >
		</cfquery>
		<cfreturn qncsg>
	</cffunction>
<!---Insert Sub Sighting NCSG Form --->
	<cffunction name="save_NCSG" returntype="any" output="false" access="remote" >
        <cfquery name="qncsg" datasource="#variables.dsn#" result="data_res" >
            select count(*) as row from TLU_NCSG where sighting_ID= <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Sighting_ID#' >
		</cfquery>
        <cfparam name="form.ChopHeight" default="">
		<cfparam name="form.Tide" default="">
		<cfparam name="form.Dolphin_activeFisher" default="">
		<cfparam name="form.Fisher_TT_respons" default="">
		<cfparam name="form.Fisher_respons" default="">
		<cfparam name="form.DolphinRecreantial_vessal" default="">
		<cfparam name="form.Vissel_TT_respons" default="">
		<cfparam name="form.Vissel_respons" default="">
		<cfparam name="form.FB_Sighted" default="">
		<cfparam name="form.XENOPresent" default="">
<!---- if NCSG already than update else insert------>
        <cfif qncsg.row EQ 1>
			<cfquery name="Qupdate" datasource="#variables.dsn#" result="data_res">
             Update TLU_NCSG SET
             Tide=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Tide#' null="#IIF(form.Tide EQ "", true, false)#">,
             Habitat=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Habitat#' null="#IIF(form.Habitat EQ "", true, false)#">,
             initail_WPT1=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.initail_WPT1#' null="#IIF(form.initail_WPT1 EQ "", true, false)#">,
             initail_WPT2=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.initail_WPT2#' null="#IIF(form.initail_WPT2 EQ "", true, false)#">,
             End_WPT1=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.End_WPT1#' null="#IIF(form.End_WPT1 EQ "", true, false)#">,
             End_WPT2=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.End_WPT2#' null="#IIF(form.End_WPT2 EQ "", true, false)#">,
             atanimal1=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.atanimal1#' null="#IIF(form.atanimal1 EQ "", true, false)#">,
             atanimal2=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.atanimal2#' null="#IIF(form.atanimal2 EQ "", true, false)#">,
             salinity=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.salinity#' null="#IIF(form.salinity EQ "", true, false)#">,
             H20_temp=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.H20_temp#' null="#IIF(form.H20_temp EQ "", true, false)#">,
             Air_temp=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Air_temp#' null="#IIF(form.Air_temp EQ "", true, false)#">,
             Conductivity=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Conductivity#' null="#IIF(form.Conductivity EQ "", true, false)#">,
             InitailDepth=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.InitailDepth#' null="#IIF(form.InitailDepth EQ "", true, false)#">,
             BSeaState=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.BSeaState#' null="#IIF(form.BSeaState EQ "", true, false)#">,
             ChopHeight=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.ChopHeight#' null="#IIF(form.ChopHeight EQ "", true, false)#">,
             Winds=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Winds#' null="#IIF(form.Winds EQ "", true, false)#">,
             Waterbody=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Waterbody#' null="#IIF(form.Waterbody EQ "", true, false)#">,
             Rating=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Rating#' null="#IIF(form.Rating EQ "", true, false)#">,
             FE_TotalDolphin_Min=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalDolphin_Min#' null="#IIF(form.FE_TotalDolphin_Min EQ "", true, false)#">,
             FE_TotalDolphin_Max=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalDolphin_Max#' null="#IIF(form.FE_TotalDolphin_Max EQ "", true, false)#">,
             FE_TotalDolphin_Best=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalDolphin_Best#' null="#IIF(form.FE_TotalDolphin_Best EQ "", true, false)#">,
             FE_TotalCalves_Min=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalCalves_Min#' null="#IIF(form.FE_TotalCalves_Min EQ "", true, false)#">,
             FE_TotalCalves_Max=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalCalves_Max#' null="#IIF(form.FE_TotalCalves_Max EQ "", true, false)#">,
             FE_TotalCalves_Best=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalCalves_Best#' null="#IIF(form.FE_TotalCalves_Best EQ "", true, false)#">,
             FE_Adults_Min=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_Adults_Min#' null="#IIF(form.FE_Adults_Min EQ "", true, false)#">,
             FE_Adults_Max=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_Adults_Max#' null="#IIF(form.FE_Adults_Max EQ "", true, false)#">,
             FE_Adults_Best=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_Adults_Best#' null="#IIF(form.FE_Adults_Best EQ "", true, false)#">,
             FE_YOYPresent_Min=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_YOYPresent_Min#' null="#IIF(form.FE_YOYPresent_Min EQ "", true, false)#">,
             FE_YOYPresent_Max=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_YOYPresent_Max#' null="#IIF(form.FE_YOYPresent_Max EQ "", true, false)#">,
             FE_YOYPresent_Best=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_YOYPresent_Best#' null="#IIF(form.FE_YOYPresent_Best EQ "", true, false)#">,
             Comments=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Comments#' null="#IIF(form.Comments EQ "", true, false)#">,
             Dolphin_activeFisher=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.Dolphin_activeFisher#' null="#IIF(form.Dolphin_activeFisher EQ "", true, false)#">,
             ActiveFisher_Number=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ActiveFisher_Number#' null="#IIF(form.ActiveFisher_Number EQ "", true, false)#">,
             Fisher_TT_respons=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Fisher_TT_respons#' null="#IIF(form.Fisher_TT_respons EQ "", true, false)#">,
             Fisher_respons=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Fisher_respons#' null="#IIF(form.Fisher_respons EQ "", true, false)#">,
             DolphinRecreantial_vessal=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.DolphinRecreantial_vessal#' null="#IIF(form.DolphinRecreantial_vessal EQ "", true, false)#">,
             Vissel_Number=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Vissel_Number#' null="#IIF(form.Vissel_Number EQ "", true, false)#">,
             Vissel_respons=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Vissel_respons#' null="#IIF(form.Vissel_respons EQ "", true, false)#">,
             Vissel_TT_respons=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Vissel_TT_respons#' null="#IIF(form.Vissel_TT_respons EQ "", true, false)#">,
             FB_Sighted=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.FB_Sighted#' null="#IIF(form.FB_Sighted EQ "", true, false)#">,
             XENOPresent=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.XENOPresent#' null="#IIF(form.XENOPresent EQ "", true, false)#">,
             photo_posids1=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_posids1#' null="#IIF(form.photo_posids1 EQ "", true, false)#">,
             photo_posids2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_posids2#' null="#IIF(form.photo_posids2 EQ "", true, false)#">,
             photo_posids3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_posids3#' null="#IIF(form.photo_posids3 EQ "", true, false)#">,
             photo_Minnotids1=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Minnotids1#' null="#IIF(form.photo_Minnotids1 EQ "", true, false)#">,
             photo_Minnotids2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Minnotids2#' null="#IIF(form.photo_Minnotids2 EQ "", true, false)#">,
             photo_Minnotids3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Minnotids3#' null="#IIF(form.photo_Minnotids3 EQ "", true, false)#">,
             photo_Maxnotids1=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Maxnotids1#' null="#IIF(form.photo_Maxnotids1 EQ "", true, false)#">,
             photo_Maxnotids2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Maxnotids2#' null="#IIF(form.photo_Maxnotids2 EQ "", true, false)#">,
             photo_Maxnotids3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Maxnotids3#' null="#IIF(form.photo_Maxnotids3 EQ "", true, false)#">,
             photo_RevisedMin1=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMin1#' null="#IIF(form.photo_RevisedMin1 EQ "", true, false)#">,
             photo_RevisedMin2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMin2#' null="#IIF(form.photo_RevisedMin2 EQ "", true, false)#">,
             photo_RevisedMin3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMin3#' null="#IIF(form.photo_RevisedMin3 EQ "", true, false)#">,
             photo_RevisedMax1=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMax1#' null="#IIF(form.photo_RevisedMax1 EQ "", true, false)#">,
             photo_RevisedMax2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMax2#' null="#IIF(form.photo_RevisedMax2 EQ "", true, false)#">,
             photo_RevisedMax3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMax3#' null="#IIF(form.photo_RevisedMax3 EQ "", true, false)#">,
             photo_RevisedBest1=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedBest1#' null="#IIF(form.photo_RevisedBest1 EQ "", true, false)#">,
             photo_RevisedBest2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedBest2#' null="#IIF(form.photo_RevisedBest2 EQ "", true, false)#">,
             photo_RevisedBest3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedBest3#' null="#IIF(form.photo_RevisedBest3 EQ "", true, false)#">,
             Unusual_marking=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Unusual_marking#' null="#IIF(form.Unusual_marking EQ "", true, false)#">
             where sighting_ID= <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Sighting_ID#' >
			</cfquery>
            <cfreturn 1>
		<cfelse>
			<cfquery name="qncsg" datasource="#variables.dsn#" result="data_res" >
        insert into TLU_NCSG (
             sighting_ID,
             Date_Entered,
             Habitat,
             Tide,
             initail_WPT1,
             initail_WPT2,
             End_WPT1,
             End_WPT2,
             atanimal1,
             atanimal2,
             salinity,
             H20_temp,
             Air_temp,
             Conductivity,
             InitailDepth,
             BSeaState,
             ChopHeight,
             Winds,
             Waterbody,
             Rating,
             FE_TotalDolphin_Min,
             FE_TotalDolphin_Max,
             FE_TotalDolphin_Best,
             FE_TotalCalves_Min,
             FE_TotalCalves_Max,
             FE_TotalCalves_Best,
             FE_Adults_Min,
             FE_Adults_Max,
             FE_Adults_Best,
             FE_YOYPresent_Min,
             FE_YOYPresent_Max,
             FE_YOYPresent_Best,
             Comments,
             Dolphin_activeFisher,
             ActiveFisher_Number,
             Fisher_TT_respons,
             Fisher_respons,
             DolphinRecreantial_vessal,
             Vissel_Number,
             Vissel_respons,
             Vissel_TT_respons,
             FB_Sighted,
             XENOPresent,
             photo_posids1,
             photo_posids2,
             photo_posids3,
             photo_Minnotids1,
             photo_Minnotids2,
             photo_Minnotids3,
             photo_Maxnotids1,
             photo_Maxnotids2,
             photo_Maxnotids3,
             photo_RevisedMin1,
             photo_RevisedMin2,
             photo_RevisedMin3,
             photo_RevisedMax1,
             photo_RevisedMax2,
             photo_RevisedMax3,
             photo_RevisedBest1,
             photo_RevisedBest2,
             photo_RevisedBest3,
             Unusual_marking
             )
             values
             (
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Sighting_ID#'>,
             <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Now()#' >,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Habitat#' null="#IIF(form.Habitat EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Tide#' null="#IIF(form.Tide EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.initail_WPT1#' null="#IIF(form.initail_WPT1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.initail_WPT2#' null="#IIF(form.initail_WPT2 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.End_WPT1#' null="#IIF(form.End_WPT1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.End_WPT2#' null="#IIF(form.End_WPT2 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.atanimal1#' null="#IIF(form.atanimal1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.atanimal2#' null="#IIF(form.atanimal2 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.salinity#' null="#IIF(form.salinity EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.H20_temp#' null="#IIF(form.H20_temp EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Air_temp#' null="#IIF(form.Air_temp EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Conductivity#' null="#IIF(form.Conductivity EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.InitailDepth#' null="#IIF(form.InitailDepth EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.BSeaState#' null="#IIF(form.BSeaState EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.ChopHeight#' null="#IIF(form.ChopHeight EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Winds#' null="#IIF(form.Winds EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Waterbody#' null="#IIF(form.Waterbody EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Rating#' null="#IIF(form.Rating EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalDolphin_Min#' null="#IIF(form.FE_TotalDolphin_Min EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalDolphin_Max#' null="#IIF(form.FE_TotalDolphin_Max EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalDolphin_Best#' null="#IIF(form.FE_TotalDolphin_Best EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalCalves_Min#' null="#IIF(form.FE_TotalCalves_Min EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalCalves_Max#' null="#IIF(form.FE_TotalCalves_Max EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_TotalCalves_Best#' null="#IIF(form.FE_TotalCalves_Best EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_Adults_Min#' null="#IIF(form.FE_Adults_Min EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_Adults_Max#' null="#IIF(form.FE_Adults_Max EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_Adults_Best#' null="#IIF(form.FE_Adults_Best EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_YOYPresent_Min#' null="#IIF(form.FE_YOYPresent_Min EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_YOYPresent_Max#' null="#IIF(form.FE_YOYPresent_Max EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FE_YOYPresent_Best#' null="#IIF(form.FE_YOYPresent_Best EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Comments#' null="#IIF(form.Comments EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Dolphin_activeFisher#' null="#IIF(form.Dolphin_activeFisher EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ActiveFisher_Number#' null="#IIF(form.ActiveFisher_Number EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Fisher_TT_respons#' null="#IIF(form.Fisher_TT_respons EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Fisher_respons#' null="#IIF(form.Fisher_respons EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.DolphinRecreantial_vessal#' null="#IIF(form.DolphinRecreantial_vessal EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Vissel_Number#' null="#IIF(form.Vissel_Number EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Vissel_respons#' null="#IIF(form.Vissel_respons EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Vissel_TT_respons#' null="#IIF(form.Vissel_TT_respons EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.FB_Sighted#' null="#IIF(form.FB_Sighted EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.XENOPresent#' null="#IIF(form.XENOPresent EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_posids1#' null="#IIF(form.photo_posids1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_posids2#' null="#IIF(form.photo_posids2 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_posids3#' null="#IIF(form.photo_posids3 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Minnotids1#' null="#IIF(form.photo_Minnotids1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Minnotids2#' null="#IIF(form.photo_Minnotids2 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Minnotids3#' null="#IIF(form.photo_Minnotids3 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Maxnotids1#' null="#IIF(form.photo_Maxnotids1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Maxnotids2#' null="#IIF(form.Rating EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_Maxnotids3#' null="#IIF(form.Rating EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMin1#' null="#IIF(form.photo_RevisedMin1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMin2#' null="#IIF(form.photo_RevisedMin2 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMin3#' null="#IIF(form.photo_RevisedMin3 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMax1#' null="#IIF(form.photo_RevisedMax1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMax2#' null="#IIF(form.photo_RevisedMax2 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedMax3#' null="#IIF(form.photo_RevisedMax3 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedBest1#' null="#IIF(form.photo_RevisedBest1 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedBest2#' null="#IIF(form.photo_RevisedBest2 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_integer" value='#form.photo_RevisedBest3#' null="#IIF(form.photo_RevisedBest3 EQ "", true, false)#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Unusual_marking#' null="#IIF(form.Unusual_marking EQ "", true, false)#">
              )
    </cfquery>
			<cfreturn 1>
		</cfif>
    </cffunction>
    <cffunction name="addBiopsy" returntype="any" output="false" access="public" >
        <cfparam name="form.Hit" default="0">
		<cfparam name="form.Miss" default="0">
        <cfquery name="qaddBiopsy" datasource="#variables.dsn#" result="data">
        INSERT INTO BIOPSY_SHOTS(Sighting_ID,Dolphin_ID,ShotNumber,Hit,Miss,Sample,SampleNumber)
       	 VALUES 
        (<cfqueryparam cfsqltype="cf_sql_integer" value='#form.Sighting_ID#'>,
        <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Dolphin_ID#'>,
        <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#form.ShotNumber#'>,
        <cfqueryparam   cfsqltype="cf_sql_bit" value='#form.Hit#'>,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#form.Miss#'>,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#form.Sample#'>,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#form.SampleNumber#'> 
        )
        </cfquery>
		<cfreturn data>
	</cffunction>
	<cffunction name="getBiopsyByID" returntype="any" output="false" access="public" >
		<cfargument name="Biopsy_ID">
		<cfquery name="qgetBiopsy" datasource="#variables.dsn#" >
        SELECT BIOPSY_SHOTS.*,DOLPHINS.Code,DOLPHINS.Name,DOLPHINS.ID From BIOPSY_SHOTS inner join DOLPHINS on (DOLPHINS.ID=BIOPSY_SHOTS.Dolphin_ID)
        WHERE
        Biopsy_ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Biopsy_ID#'>
		</cfquery>
		<cfreturn qgetBiopsy>
	</cffunction>
    <cffunction name="EditBiopsy" returntype="any" output="false" access="public" >
        <cfparam name="form.TargetLevel" default="">
		<cfparam name="form.Outcome" default="">
		<cfparam name="form.SkinDMSO" default="">
		<cfparam name="form.SkinRNAlater" default="">
		<cfparam name="form.SkinDCryovial" default="">
		<cfparam name="form.SampleTaken" default="">
		<cfparam name="form.Samplehead" default="">
		<cfparam name="form.SampleCollected" default="">
		<cfparam name="form.BlubberTeflonVial" default="">
		<cfparam name="form.BlubberCryovialRed" default="">
		<cfparam name="form.BlubberCryovialBlue" default="">
		<cfset TargetPre_Behavior1 = "">
		<cfset TargetPre_Behavior2 = "">
		<cfset TargetPre_Behavior3 = "">
<!--- TargetPre_Behavior1  --->
		<cfif form.TABPre_Activity_Mill neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Mill",",")></cfif>
		<cfif form.TABPre_Activity_Feed neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Feed",",")></cfif>
		<cfif form.TABPre_Activity_ProbFeed neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"ProbFeed",",")></cfif>
		<cfif form.TABPre_Activity_Travel neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Travel",",")></cfif>
		<cfif form.TABPre_Activity_Play neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Play",",")></cfif>
		<cfif form.TABPre_ACTIVITY_REST neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"REST",",")></cfif>
		<cfif form.TABPre_Activity_Leap_tailslap_chuff neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.TABPre_Activity_Social neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Social",",")></cfif>
		<cfif form.TABPre_ACTIVITY_WITHBOAT neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"WITHBOAT",",")></cfif>
		<cfif form.TABPre_Activity_Avoid_Boat neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Avoid_Boat",",")></cfif>
		<cfif form.TABPre_Depredation neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Depredation",",")></cfif>
		<cfif form.TABPre_Herding neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Herding",",")></cfif>
		<cfif form.TABPre_Activity_Other neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Other",",")></cfif>
<!--- TargetPre_Behavior2  --->
		<cfif form.TABPre_Activity_Mill2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Mill",",")></cfif>
		<cfif form.TABPre_Activity_Feed2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Feed",",")></cfif>
		<cfif form.TABPre_Activity_ProbFeed2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"ProbFeed",",")></cfif>
		<cfif form.TABPre_Activity_Travel2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Travel",",")></cfif>
		<cfif form.TABPre_Activity_Play2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Play",",")></cfif>
		<cfif form.TABPre_ACTIVITY_REST2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"REST",",")></cfif>
		<cfif form.TABPre_Activity_Leap_tailslap_chuff2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.TABPre_Activity_Social2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Social",",")></cfif>
		<cfif form.TABPre_ACTIVITY_WITHBOAT2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"WITHBOAT",",")></cfif>
		<cfif form.TABPre_Activity_Avoid_Boat2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Avoid_Boat",",")></cfif>
		<cfif form.TABPre_Depredation2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Depredation",",")></cfif>
		<cfif form.TABPre_Herding2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Herding",",")></cfif>
		<cfif form.TABPre_Activity_Other2 neq 0><cfset TargetPre_Behavior2 = listAppend(TargetPre_Behavior2,"Other",",")></cfif>
<!--- TargetPre_Behavior3  --->
		<cfif form.TABPre_Activity_Mill3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Mill",",")></cfif>
		<cfif form.TABPre_Activity_Feed3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Feed",",")></cfif>
		<cfif form.TABPre_Activity_ProbFeed3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"ProbFeed",",")></cfif>
		<cfif form.TABPre_Activity_Travel3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Travel",",")></cfif>
		<cfif form.TABPre_Activity_Play3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Play",",")></cfif>
		<cfif form.TABPre_ACTIVITY_REST3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"REST",",")></cfif>
		<cfif form.TABPre_Activity_Leap_tailslap_chuff3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.TABPre_Activity_Social3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Social",",")></cfif>
		<cfif form.TABPre_ACTIVITY_WITHBOAT3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"WITHBOAT",",")></cfif>
		<cfif form.TABPre_Activity_Avoid_Boat3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Avoid_Boat",",")></cfif>
		<cfif form.TABPre_Depredation3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Depredation",",")></cfif>
		<cfif form.TABPre_Herding3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Herding",",")></cfif>
		<cfif form.TABPre_Activity_Other3 neq 0><cfset TargetPre_Behavior3 = listAppend(TargetPre_Behavior3,"Other",",")></cfif>

		<cfset TargetPost_Behavior1 = "">
		<cfset TargetPost_Behavior2 = "">
		<cfset TargetPost_Behavior3 = "">
<!--- TargetPre_Behavior3  --->
		<cfif form.TABpost_Activity_Mill neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Mill",",")></cfif>
		<cfif form.TABPost_Activity_Feed neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Feed",",")></cfif>
		<cfif form.TABPost_Activity_ProbFeed neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"ProbFeed",",")></cfif>
		<cfif form.TABPost_Activity_Travel neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Travel",",")></cfif>
		<cfif form.TABPost_Activity_Play neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Play",",")></cfif>
		<cfif form.TABPost_ACTIVITY_REST neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"REST",",")></cfif>
		<cfif form.TABPost_Activity_Leap_tailslap_chuff neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.TABPost_Activity_Social neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Social",",")></cfif>
		<cfif form.TABPost_ACTIVITY_WITHBOAT neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"WITHBOAT",",")></cfif>
		<cfif form.TABPost_Activity_Avoid_Boat neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Avoid_Boat",",")></cfif>
		<cfif form.TABPost_Depredation neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Depredation",",")></cfif>
		<cfif form.TABPost_Herding neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Herding",",")></cfif>
		<cfif form.TABPost_Activity_Other neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Other",",")></cfif>
<!--- TargetPre_Behavior3  --->
		<cfif form.TABPost_Activity_Mill2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Mill",",")></cfif>
		<cfif form.TABPost_Activity_Feed2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Feed",",")></cfif>
		<cfif form.TABPost_Activity_ProbFeed2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"ProbFeed",",")></cfif>
		<cfif form.TABPost_Activity_Travel2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Travel",",")></cfif>
		<cfif form.TABPost_Activity_Play2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Play",",")></cfif>
		<cfif form.TABPost_ACTIVITY_REST2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"REST",",")></cfif>
		<cfif form.TABPost_Activity_Leap_tailslap_chuff2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.TABPost_Activity_Social2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Social",",")></cfif>
		<cfif form.TABPost_ACTIVITY_WITHBOAT2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"WITHBOAT",",")></cfif>
		<cfif form.TABPost_Activity_Avoid_Boat2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Avoid_Boat",",")></cfif>
		<cfif form.TABPost_Depredation2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Depredation",",")></cfif>
		<cfif form.TABPost_Herding2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Herding",",")></cfif>
		<cfif form.TABPost_Activity_Other2 neq 0><cfset TargetPost_Behavior2 = listAppend(TargetPost_Behavior2,"Other",",")></cfif>
<!--- TargetPost_Behavior3  --->
		<cfif form.TABPost_Activity_Mill3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Mill",",")></cfif>
		<cfif form.TABPost_Activity_Feed3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Feed",",")></cfif>
		<cfif form.TABPost_Activity_ProbFeed3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"ProbFeed",",")></cfif>
		<cfif form.TABPost_Activity_Travel3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Travel",",")></cfif>
		<cfif form.TABPost_Activity_Play3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Play",",")></cfif>
		<cfif form.TABPost_ACTIVITY_REST3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"REST",",")></cfif>
		<cfif form.TABPost_Activity_Leap_tailslap_chuff3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.TABPost_Activity_Social3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Social",",")></cfif>
		<cfif form.TABPost_ACTIVITY_WITHBOAT3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"WITHBOAT",",")></cfif>
		<cfif form.TABPost_Activity_Avoid_Boat3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Avoid_Boat",",")></cfif>
		<cfif form.TABPost_Depredation3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Depredation",",")></cfif>
		<cfif form.TABPost_Herding3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Herding",",")></cfif>
		<cfif form.TABPost_Activity_Other3 neq 0><cfset TargetPost_Behavior3 = listAppend(TargetPost_Behavior3,"Other",",")></cfif>
        <cfset GroupPre_Behavior1 = "">
		<cfset GroupPre_Behavior2 = "">
		<cfset GroupPre_Behavior3 = "">
		<cfset GroupPost_Behavior1 = "">
		<cfset GroupPost_Behavior2 = "">
		<cfset GroupPost_Behavior3 = "">
        <cfif form.GBPre_Activity_Mill neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Mill",",")></cfif>
		<cfif form.GBPre_Activity_Feed neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Feed",",")></cfif>
		<cfif form.GBPre_Activity_ProbFeed neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"ProbFeed",",")></cfif>
		<cfif form.GBPre_Activity_Travel neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Travel",",")></cfif>
		<cfif form.GBPre_Activity_Play neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Play",",")></cfif>
		<cfif form.GBPre_ACTIVITY_REST neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"REST",",")></cfif>
		<cfif form.GBPre_Activity_Leap_tailslap_chuff neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.GBPre_Activity_Social neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Social",",")></cfif>
		<cfif form.GBPre_ACTIVITY_WITHBOAT neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"WITHBOAT",",")></cfif>
		<cfif form.GBPre_Activity_Other neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Other",",")></cfif>
		<cfif form.GBPre_Activity_Avoid_Boat neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"AvoidBoat",",")></cfif>
		<cfif form.GBPre_Depredation neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Depredation",",")></cfif>
		<cfif form.GBPre_Herding neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Herding",",")></cfif>
<!---GroupPre_Behavior2 --->
		<cfif form.GBPre_Activity_Mill2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Mill",",")></cfif>
		<cfif form.GBPre_Activity_Feed2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Feed",",")></cfif>
		<cfif form.GBPre_Activity_ProbFeed2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"ProbFeed",",")></cfif>
		<cfif form.GBPre_Activity_Travel2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Travel",",")></cfif>
		<cfif form.GBPre_Activity_Play2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Play",",")></cfif>
		<cfif form.GBPre_ACTIVITY_REST2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"REST",",")></cfif>
		<cfif form.GBPre_Activity_Leap_tailslap_chuff2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.GBPre_Activity_Social2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Social",",")></cfif>
		<cfif form.GBPre_ACTIVITY_WITHBOAT2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"WITHBOAT",",")></cfif>
		<cfif form.GBPre_Activity_Other2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Other",",")></cfif>
		<cfif form.GBPre_Activity_Avoid_Boat2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"AvoidBoat",",")></cfif>
		<cfif form.GBPre_Depredation2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Depredation",",")></cfif>
		<cfif form.GBPre_Herding2 neq 0><cfset GroupPre_Behavior2 = listAppend(GroupPre_Behavior2,"Herding",",")></cfif>
<!--- GroupPre_Behavior3 --->
		<cfif form.GBPre_Activity_Mill3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"Mill",",")></cfif>
		<cfif form.GBPre_Activity_Feed3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"Feed",",")></cfif>
		<cfif form.GBPre_Activity_ProbFeed3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"ProbFeed",",")></cfif>
		<cfif form.GBPre_Activity_Travel3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"Travel",",")></cfif>
		<cfif form.GBPre_Activity_Play3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"Play",",")></cfif>
		<cfif form.GBPre_ACTIVITY_REST3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"REST",",")></cfif>
		<cfif form.GBPre_Activity_Leap_tailslap_chuff3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.GBPre_Activity_Social3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"Social",",")></cfif>
		<cfif form.GBPre_ACTIVITY_WITHBOAT3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"WITHBOAT",",")></cfif>
		<cfif form.GBPre_Activity_Other3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"Other",",")></cfif>
		<cfif form.GBPre_Activity_Avoid_Boat3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"AvoidBoat",",")></cfif>
		<cfif form.GBPre_Depredation3 neq 0><cfset GroupPre_Behavior13 = listAppend(GroupPre_Behavior3,"Depredation",",")></cfif>
		<cfif form.GBPre_Herding3 neq 0><cfset GroupPre_Behavior3 = listAppend(GroupPre_Behavior3,"Herding",",")></cfif>
<!--- GroupPost_Behavior1 --->
		<cfif form.GBPost_Activity_Mill neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Mill",",")></cfif>
		<cfif form.GBPost_Activity_Feed neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Feed",",")></cfif>
		<cfif form.GBPost_Activity_ProbFeed neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"ProbFeed",",")></cfif>
		<cfif form.GBPost_Activity_Travel neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Travel",",")></cfif>
		<cfif form.GBPost_Activity_Play neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Play",",")></cfif>
		<cfif form.GBPost_ACTIVITY_REST neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"REST",",")></cfif>
		<cfif form.GBPost_Activity_Leap_tailslap_chuff neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.GBPost_Activity_Social neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Social",",")></cfif>
		<cfif form.GBPost_ACTIVITY_WITHBOAT neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"WITHBOAT",",")></cfif>
		<cfif form.GBPost_Activity_Other neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Other",",")></cfif>
		<cfif form.GBPost_Activity_Avoid_Boat neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"AvoidBoat",",")></cfif>
		<cfif form.GBPost_Depredation neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Depredation",",")></cfif>
		<cfif form.GBPost_Herding neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Herding",",")></cfif>
<!--- GroupPost_Behavior2 --->
		<cfif form.GBPost_Activity_Mill2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Mill",",")></cfif>
		<cfif form.GBPost_Activity_Feed2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Feed",",")></cfif>
		<cfif form.GBPost_Activity_ProbFeed2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"ProbFeed",",")></cfif>
		<cfif form.GBPost_Activity_Travel2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Travel",",")></cfif>
		<cfif form.GBPost_Activity_Play2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Play",",")></cfif>
		<cfif form.GBPost_ACTIVITY_REST2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"REST",",")></cfif>
		<cfif form.GBPost_Activity_Leap_tailslap_chuff2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.GBPost_Activity_Social2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Social",",")></cfif>
		<cfif form.GBPost_ACTIVITY_WITHBOAT2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"WITHBOAT",",")></cfif>
		<cfif form.GBPost_Activity_Other2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Other",",")></cfif>
		<cfif form.GBPost_Activity_Avoid_Boat2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"AvoidBoat",",")></cfif>
		<cfif form.GBPost_Depredation2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Depredation",",")></cfif>
		<cfif form.GBPost_Herding2 neq 0><cfset GroupPost_Behavior2 = listAppend(GroupPost_Behavior2,"Herding",",")></cfif>
<!--- GroupPost_Behavior1 --->
		<cfif form.GBPost_Activity_Mill3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Mill",",")></cfif>
		<cfif form.GBPost_Activity_Feed3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Feed",",")></cfif>
		<cfif form.GBPost_Activity_ProbFeed3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"ProbFeed",",")></cfif>
		<cfif form.GBPost_Activity_Travel3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Travel",",")></cfif>
		<cfif form.GBPost_Activity_Play3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Play",",")></cfif>
		<cfif form.GBPost_ACTIVITY_REST3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"REST",",")></cfif>
		<cfif form.GBPost_Activity_Leap_tailslap_chuff3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Leap_tailslap_chuff",",")></cfif>
		<cfif form.GBPost_Activity_Social3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Social",",")></cfif>
		<cfif form.GBPost_ACTIVITY_WITHBOAT3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"WITHBOAT",",")></cfif>
		<cfif form.GBPost_Activity_Other3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Other",",")></cfif>
		<cfif form.GBPost_Activity_Avoid_Boat3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"AvoidBoat",",")></cfif>
		<cfif form.GBPost_Depredation3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Depredation",",")></cfif>
		<cfif form.GBPost_Herding3 neq 0><cfset GroupPost_Behavior3 = listAppend(GroupPost_Behavior3,"Herding",",")></cfif>

		<cfquery name="qEditBiopsy" datasource="#variables.dsn#"  result="data">
             UPDATE BIOPSY_SHOTS
             SET
            DOLPHIN_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.DOLPHIN_ID#' null="#IIF(form.DOLPHIN_ID EQ "", true, false)#">,
            ShotTime=<cfqueryparam cfsqltype="cf_sql_time" value='#form.ShotTime#' null="#IIF(form.ShotTime EQ "", true, false)#">,
            Arbalester=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Arbalester#' null="#IIF(form.Arbalester EQ "", true, false)#">,
            ShotNumber=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ShotNumber#' null="#IIF(form.ShotNumber EQ "", true, false)#">,
            ShotDistance=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ShotDistance#' null="#IIF(form.ShotDistance EQ "", true, false)#">,
            Outcome=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.Outcome#' null="#IIF(form.Outcome EQ "", true, false)#">,
            TargetLevel=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetLevel#' null="#IIF(form.TargetLevel EQ "", true, false)#">,
            TABPre_Activity_Mill=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Mill#'>,
            TABPre_Activity_Feed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Feed#'>,
            TABPre_Activity_ProbFeed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_ProbFeed#'>,
            TABPre_Activity_Travel=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Travel#'>,
            TABPre_Activity_Play=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Play#'>,
            TABPre_ACTIVITY_REST=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_REST#'>,
            TABPre_Activity_Leap_tailslap_chuff=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Leap_tailslap_chuff#'>,
            TABPre_Activity_Social=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Social#'>,
            TABPre_ACTIVITY_WITHBOAT=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_WITHBOAT#'>,
            TABPre_Activity_Other=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Other#'>,
            TABPre_Activity_Avoid_Boat=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Avoid_Boat#'>,
            TABPre_Depredation=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Depredation#'>,
            TABPre_Herding=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Herding#'>,
            TABPost_Activity_Mill=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Mill#'>,
            TABPost_Activity_Feed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Feed#'>,
            TABPost_Activity_ProbFeed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_ProbFeed#'>,
            TABPost_Activity_Travel=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Travel#'>,
            TABPost_Activity_Play=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Play#'>,
            TABPost_ACTIVITY_REST=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_REST#'>,
            TABPost_Activity_Leap_tailslap_chuff=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Leap_tailslap_chuff#'>,
            TABPost_Activity_Social=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Social#'>,
            TABPost_ACTIVITY_WITHBOAT=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_WITHBOAT#'>,
            TABPost_Activity_Other=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Other#'>,
            TABPost_Activity_Avoid_Boat=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Avoid_Boat#'>,
            TABPost_Depredation=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Depredation#'>,
            TABPost_Herding=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Herding#'>,
            GBPre_Activity_Mill=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Mill#'>,
            GBPre_Activity_Feed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Feed#'>,
            GBPre_Activity_ProbFeed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_ProbFeed#'>,
            GBPre_Activity_Travel=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Travel#'>,
            GBPre_Activity_Play=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Play#'>,
            GBPre_ACTIVITY_REST=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_REST#'>,
            GBPre_Activity_Leap_tailslap_chuff=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Leap_tailslap_chuff#'>,
            GBPre_Activity_Social=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Social#'>,
            GBPre_ACTIVITY_WITHBOAT=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_WITHBOAT#'>,
            GBPre_Activity_Other=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Other#'>,
            GBPre_Activity_Avoid_Boat=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Avoid_Boat#'>,
            GBPre_Depredation=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Depredation#'>,
            GBPre_Herding=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Herding#'>,
            GBPost_Activity_Mill=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Mill#'>,
            GBPost_Activity_Feed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Feed#'>,
            GBPost_Activity_ProbFeed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_ProbFeed#'>,
            GBPost_Activity_Travel=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Travel#'>,
            GBPost_Activity_Play=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Play#'>,
            GBPost_ACTIVITY_REST=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_REST#'>,
            GBPost_Activity_Leap_tailslap_chuff=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Leap_tailslap_chuff#'>,
            GBPost_Activity_Social=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Social#'>,
            GBPost_ACTIVITY_WITHBOAT=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_WITHBOAT#'>,
            GBPost_Activity_Other=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Other#'>,
            GBPost_Activity_Avoid_Boat=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Avoid_Boat#'>,
            GBPost_Depredation=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Depredation#'>,
            GBPost_Herding=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Herding#'>,
            HitLocation=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.HitLocation#' null="#IIF(form.HitLocation EQ "", true, false)#">,
            SubSample=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.SubSample#' null="#IIF(form.SubSample EQ "", true, false)#">,
            Processor=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Processor#' null="#IIF(form.Processor EQ "", true, false)#">,
            SampleLength=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.SampleLength#' null="#IIF(form.SampleLength EQ "", true, false)#">,
            SkinDMSO=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinDMSO#' null="#IIF(form.SkinDMSO EQ "", true, false)#">,
            SkinRNAlater=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinRNAlater#' null="#IIF(form.SkinRNAlater EQ "", true, false)#">,
            SkinDCryovial=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinDCryovial#' null="#IIF(form.SkinDCryovial EQ "", true, false)#">,
            SampleNumber=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.SampleNumber#' null="#IIF(form.SampleNumber EQ "", true, false)#">,
            SampleTaken=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.SampleTaken#' null="#IIF(form.SampleTaken EQ "", true, false)#">,
            Samplehead=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.Samplehead#' null="#IIF(form.Samplehead EQ "", true, false)#">,
            SampleCollected=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.SampleCollected#' null="#IIF(form.SampleCollected EQ "", true, false)#">,
            BlubberTeflonVial=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberTeflonVial#' null="#IIF(form.BlubberTeflonVial EQ "", true, false)#">,
            BlubberCryovialRed=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberCryovialRed#' null="#IIF(form.BlubberCryovialRed EQ "", true, false)#">,
           BlubberCryovialBlue=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberCryovialBlue#' null="#IIF(form.BlubberCryovialBlue EQ "", true, false)#">,
           TargetResponseBehavior1=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior1#' null="#IIF(form.TargetResponseBehavior1 EQ "", true, false)#">,
           TargetResponseBehavior2=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior2#' null="#IIF(form.TargetResponseBehavior2 EQ "", true, false)#">,
           TargetResponseBehavior3=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior3#' null="#IIF(form.TargetResponseBehavior3 EQ "", true, false)#">,
           GroupResponseBehavior=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.GroupResponseBehavior#' null="#IIF(form.GroupResponseBehavior EQ "", true, false)#">,
           GroupSize=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.groupSize#' null="#IIF(form.groupSize EQ "", true, false)#">,
           MissDistance=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missDistance#' null="#IIF(form.missDistance EQ "", true, false)#">,
           MissHeight=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missHeight#' null="#IIF(form.missHeight EQ "", true, false)#">,
           MissWidth=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missWidth#' null="#IIF(form.missWidth EQ "", true, false)#">,
           <cfif form.Outcome eq 1>
                HitDescriptor=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.hitDescriptor#' null="#IIF(form.hitDescriptor EQ "", true, false)#">,
           MissDescriptor=<cfqueryparam cfsqltype="cf_sql_varchar" value='' null="#IIF(form.missDescriptor EQ "", true, false)#">
            <cfelse>
                HitDescriptor=<cfqueryparam cfsqltype="cf_sql_varchar" value='' null="#IIF(form.hitDescriptor EQ "", true, false)#">,
           MissDescriptor=<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missDescriptor#' null="#IIF(form.missDescriptor EQ "", true, false)#">,
            TABPre_Activity_Mill2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Mill2#'>,
            TABPre_Activity_Feed2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Feed2#'>,
            TABPre_Activity_ProbFeed2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_ProbFeed2#'>,
            TABPre_Activity_Travel2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Travel2#'>,
            TABPre_Activity_Play2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Play2#'>,
            TABPre_ACTIVITY_REST2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_REST2#'>,
            TABPre_Activity_Leap_tailslap_chuff2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Leap_tailslap_chuff2#'>,
            TABPre_Activity_Social2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Social2#'>,
            TABPre_ACTIVITY_WITHBOAT2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_WITHBOAT2#'>,
            TABPre_Activity_Other2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Other2#'>,
            TABPre_Activity_Avoid_Boat2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Avoid_Boat2#'>,
            TABPre_Depredation2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Depredation2#'>,
            TABPre_Herding2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Herding2#'>,
            TABPre_Activity_Mill3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Mill3#'>,
            TABPre_Activity_Feed3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Feed3#'>,
            TABPre_Activity_ProbFeed3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_ProbFeed3#'>,
            TABPre_Activity_Travel3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Travel3#'>,
            TABPre_Activity_Play3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Play3#'>,
            TABPre_ACTIVITY_REST3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_REST3#'>,
            TABPre_Activity_Leap_tailslap_chuff3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Leap_tailslap_chuff3#'>,
            TABPre_Activity_Social3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Social3#'>,
            TABPre_ACTIVITY_WITHBOAT3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_WITHBOAT3#'>,
            TABPre_Activity_Other3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Other3#'>,
            TABPre_Activity_Avoid_Boat3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Avoid_Boat3#'>,
            TABPre_Depredation3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Depredation3#'>,
            TABPre_Herding3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Herding3#'>,
            TABPost_Activity_Mill2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Mill2#'>,
            TABPost_Activity_Feed2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Feed2#'>,
            TABPost_Activity_ProbFeed2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_ProbFeed2#'>,
            TABPost_Activity_Travel2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Travel2#'>,
            TABPost_Activity_Play2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Play2#'>,
            TABPost_ACTIVITY_REST2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_REST2#'>,
            TABPost_Activity_Leap_tailslap_chuff2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Leap_tailslap_chuff2#'>,
            TABPost_Activity_Social2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Social2#'>,
            TABPost_ACTIVITY_WITHBOAT2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_WITHBOAT2#'>,
            TABPost_Activity_Other2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Other2#'>,
            TABPost_Activity_Avoid_Boat2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Avoid_Boat2#'>,
            TABPost_Depredation2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Depredation2#'>,
            TABPost_Herding2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Herding2#'>,
            TABPost_Activity_Mill3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Mill3#'>,
            TABPost_Activity_Feed3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Feed3#'>,
            TABPost_Activity_ProbFeed3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_ProbFeed3#'>,
            TABPost_Activity_Travel3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Travel3#'>,
            TABPost_Activity_Play3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Play3#'>,
            TABPost_ACTIVITY_REST3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_REST3#'>,
            TABPost_Activity_Leap_tailslap_chuff3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Leap_tailslap_chuff3#'>,
            TABPost_Activity_Social3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Social3#'>,
            TABPost_ACTIVITY_WITHBOAT3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_WITHBOAT3#'>,
            TABPost_Activity_Other3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Other3#'>,
            TABPost_Activity_Avoid_Boat3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Avoid_Boat3#'>,
            TABPost_Depredation3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Depredation3#'>,
            TABPost_Herding3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Herding3#'>,
            GBPre_Activity_Mill2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Mill2#'>,
            GBPre_Activity_Feed2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Feed2#'>,
            GBPre_Activity_ProbFeed2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_ProbFeed2#'>,
            GBPre_Activity_Travel2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Travel2#'>,
            GBPre_Activity_Play2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Play2#'>,
            GBPre_ACTIVITY_REST2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_REST2#'>,
            GBPre_Activity_Leap_tailslap_chuff2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Leap_tailslap_chuff2#'>,
            GBPre_Activity_Social2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Social2#'>,
            GBPre_ACTIVITY_WITHBOAT2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_WITHBOAT2#'>,
            GBPre_Activity_Other2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Other2#'>,
            GBPre_Activity_Avoid_Boat2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Avoid_Boat2#'>,
            GBPre_Depredation2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Depredation2#'>,
            GBPre_Herding2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Herding2#'>,
            GBPost_Activity_Mill2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Mill2#'>,
            GBPost_Activity_Feed2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Feed2#'>,
            GBPost_Activity_ProbFeed2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_ProbFeed2#'>,
            GBPost_Activity_Travel2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Travel2#'>,
            GBPost_Activity_Play2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Play2#'>,
            GBPost_ACTIVITY_REST2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_REST2#'>,
            GBPost_Activity_Leap_tailslap_chuff2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Leap_tailslap_chuff2#'>,
            GBPost_Activity_Social2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Social2#'>,
            GBPost_ACTIVITY_WITHBOAT2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_WITHBOAT#'>,
            GBPost_Activity_Other2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Other2#'>,
            GBPost_Activity_Avoid_Boat2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Avoid_Boat2#'>,
            GBPost_Depredation2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Depredation2#'>,
            GBPost_Herding2=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Herding2#'>,
            GBPre_Activity_Mill3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Mill3#'>,
            GBPre_Activity_Feed3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Feed3#'>,
            GBPre_Activity_ProbFeed3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_ProbFeed3#'>,
            GBPre_Activity_Travel3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Travel3#'>,
            GBPre_Activity_Play3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Play3#'>,
            GBPre_ACTIVITY_REST3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_REST3#'>,
            GBPre_Activity_Leap_tailslap_chuff3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Leap_tailslap_chuff3#'>,
            GBPre_Activity_Social3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Social3#'>,
            GBPre_ACTIVITY_WITHBOAT3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_WITHBOAT3#'>,
            GBPre_Activity_Other3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Other3#'>,
            GBPre_Activity_Avoid_Boat3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Avoid_Boat3#'>,
            GBPre_Depredation3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Depredation3#'>,
            GBPre_Herding3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Herding3#'>,
            GBPost_Activity_Mill3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Mill3#'>,
            GBPost_Activity_Feed3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Feed3#'>,
            GBPost_Activity_ProbFeed3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_ProbFeed3#'>,
            GBPost_Activity_Travel3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Travel3#'>,
            GBPost_Activity_Play3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Play3#'>,
            GBPost_ACTIVITY_REST3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_REST3#'>,
            GBPost_Activity_Leap_tailslap_chuff3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Leap_tailslap_chuff3#'>,
            GBPost_Activity_Social3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Social3#'>,
            GBPost_ACTIVITY_WITHBOAT3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_WITHBOAT3#'>,
            GBPost_Activity_Other3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Other3#'>,
            GBPost_Activity_Avoid_Boat3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Avoid_Boat3#'>,
            GBPost_Depredation3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Depredation3#'>,
            GBPost_Herding3=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Herding3#'>,
            TargetPre_Behavior1=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior1#' null="#IIF(TargetPre_Behavior1 EQ "", true, false)#">,
            TargetPre_Behavior2=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior2#' null="#IIF(TargetPre_Behavior2 EQ "", true, false)#">,
            TargetPre_Behavior3=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior3#' null="#IIF(TargetPre_Behavior3 EQ "", true, false)#">,
            TargetPost_Behavior1=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior1#' null="#IIF(TargetPost_Behavior1 EQ "", true, false)#">,
            TargetPost_Behavior2=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior2#' null="#IIF(TargetPost_Behavior2 EQ "", true, false)#">,
            TargetPost_Behavior3=<cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior3#' null="#IIF(TargetPost_Behavior3 EQ "", true, false)#">,
            GroupPre_Behavior1=<cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior1#' null="#IIF(GroupPre_Behavior1 EQ "", true, false)#">,
            GroupPre_Behavior2=<cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior2#' null="#IIF(GroupPre_Behavior2 EQ "", true, false)#">,
            GroupPre_Behavior3=<cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior3#' null="#IIF(GroupPre_Behavior3 EQ "", true, false)#">,
            GroupPost_Behavior1=<cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior1#' null="#IIF(GroupPost_Behavior1 EQ "", true, false)#">,
            GroupPost_Behavior2=<cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior2#' null="#IIF(GroupPost_Behavior2 EQ "", true, false)#">,
            GroupPost_Behavior3=<cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior3#' null="#IIF(GroupPost_Behavior3 EQ "", true, false)#">
		</cfif>
            WHERE
            Biopsy_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.Biopsy_ID#'>
		</cfquery>
		<cfreturn data>
	</cffunction>
    <cffunction name="getBiopsylist" returntype="any" output="false" access="public" >
		<cfquery name="qBiopsy" datasource="#variables.dsn#" result="data">
            SELECT BIOPSY_SHOTS.*,DOLPHINS.Name,DOLPHINS.Code FROM BIOPSY_SHOTS inner join DOLPHINS on
            (DOLPHINS.ID = BIOPSY_SHOTS.DOLPHIN_ID) where Dolphin_ID =<cfqueryparam cfsqltype="cf_sql_integer" value='#form.DOLPHIN_ID#'>
		</cfquery>
		<cfreturn qBiopsy>
	</cffunction>

    <cffunction name="getselectmember" returntype="any" output="false" access="public" >
		<cfquery name="qget" datasource="#variables.dsn#" >
         SELECT *
             FROM TLU_ResearchTeamMembers f
                WHERE EXISTS (
                    SELECT ResearchTeam
                    FROM Surveys
                    WHERE CONCAT(',',ResearchTeam,',') LIKE CONCAT('%,',f.RT_ID,',%')
                    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
                )
        </cfquery>
		<cfreturn qget>
	</cffunction>

    <cffunction name="getSelectedAssocBio" returntype="any" output="false" access="public" >
		<cfquery name="qget" datasource="#variables.dsn#" >
            SELECT *
             FROM TLU_AssocBioData f
                WHERE EXISTS (
                    SELECT AssocBio
                    FROM Survey_Sightings
                    WHERE CONCAT(',',AssocBio,',') LIKE CONCAT('%,',f.ASSOCBIOID,',%')
                    AND project_id = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
                    AND ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.sight_id#'>
                )
        </cfquery>
		<cfreturn qget>
	</cffunction>

    <cffunction name="getSelectedPreySpecies" returntype="any" output="false" access="public" >
		<cfquery name="qget" datasource="#variables.dsn#" >
            SELECT *
             FROM TLU_PreySpecies f
                WHERE EXISTS (
                    SELECT PreySpecies
                    FROM Survey_Sightings
                    WHERE CONCAT(',',PreySpecies,',') LIKE CONCAT('%,',f.ID,',%')
                    AND project_id = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
                    AND ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.sight_id#'>
                )
        </cfquery>
		<cfreturn qget>
	</cffunction>

     <cffunction name="getSelectedSurveyRoute" returntype="any" output="false" access="public" >
		<cfquery name="qget" datasource="#variables.dsn#" >
             SELECT *
             FROM TLU_SurveyRoute f
                WHERE EXISTS (
                    SELECT SurveyRoute
                    FROM Surveys
                    WHERE CONCAT(',',SurveyRoute,',') LIKE CONCAT('%,',f.ID,',%')
                    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
                )
        </cfquery>
		<cfreturn qget>
	</cffunction>

     <cffunction name="getSelectedSurveyArea" returntype="any" output="false" access="public" >
		<cfquery name="qget" datasource="#variables.dsn#" >
             SELECT *
             FROM TLU_SurveyArea f
                WHERE EXISTS (
                    SELECT BodyOfWater
                    FROM Surveys
                    WHERE CONCAT(',',BodyOfWater,',') LIKE CONCAT('%,',f.ID,',%')
                    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
                )
        </cfquery>
		<cfreturn qget>
	</cffunction>

    <cffunction name="getSelectedNOAAStock" returntype="any" output="false" access="public" >
		<cfquery name="qget" datasource="#variables.dsn#" >
             SELECT *
             FROM TLU_Stock f
                WHERE EXISTS (
                    SELECT NOAAStock
                    FROM Surveys
                    WHERE CONCAT(',',NOAAStock,',') LIKE CONCAT('%,',f.ID,',%')
                    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
                )
        </cfquery>
		<cfreturn qget>
	</cffunction>

     <cffunction name="getSelectedBehavior" returntype="any" output="false" access="public" >
		<cfquery name="qget" datasource="#variables.dsn#" >
            SELECT *
             FROM TLU_Behaviors f
                WHERE EXISTS (
                    SELECT Behaviors
                    FROM Survey_Sightings
                    WHERE CONCAT(',',Behaviors,',') LIKE CONCAT('%,',f.ID,',%')
                    AND project_id = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
                    AND ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.sight_id#'>
                )
        </cfquery>
		<cfreturn qget>
	</cffunction>

    <cffunction name="getBiopsyTeammember" returntype="any" output="false" access="public" >
		<cfargument name="Biopsy_ID">
		<cfquery name="qget" datasource="#variables.dsn#" >
            SELECT *
            FROM
            TEAMMEMBER_Biopsy
            WHERE Biopsy_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#Biopsy_ID#'>
        </cfquery>
		<cfreturn qget>
	</cffunction>
    <cffunction name="updateBiopsyteammember" returntype="any" output="false" access="public" >
		<cfargument name="BiopsyTeam" default=" ">
		<cfquery name="delete" datasource="#variables.dsn#">
            delete from TEAMMEMBER_Biopsy where Biopsy_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.Biopsy_ID#'>
		</cfquery>
        <cfif len(trim(BiopsyTeam)) GT 0 >
			<cfloop index = "ListElement" list = "#BiopsyTeam#">
				<cfquery name="update" datasource="#variables.dsn#" result="updating" >
                insert into TEAMMEMBER_Biopsy (Biopsy_ID,TeamMemberID) values
                (<cfqueryparam cfsqltype="cf_sql_integer" value='#form.Biopsy_ID#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#VAL(ListElement)#'>
                )
                </cfquery>
			</cfloop>
			<cfreturn updating>
		</cfif>
    </cffunction>

    <cffunction name="updateteammember" returntype="any" output="false" access="public" >
		<cfargument name="ResearchTeam" default=" ">
		<cfquery name="delete" datasource="#variables.dsn#">
              delete from RESEARCHTEAMMEMBER_Surveys where PROJECT_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
		</cfquery>
		<cfparam name="FORM.ResearchTeam" default="">
		<cfif FORM.ResearchTeam NEQ '' >
			<cfloop index = "ListElement" list = "#ResearchTeam#">
				<cfquery name="update" datasource="#variables.dsn#" result="updating" >
                    insert into RESEARCHTEAMMEMBER_Surveys (PROJECT_ID,RESEARCHTEAMMEMBER_ID,PLATFORM_ID) values
                    (<cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>,
                    <cfqueryparam cfsqltype="cf_sql_integer" value='#VAL(ListElement)#'>,
                    <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Platform#' null="#IIF(form.Platform EQ "", true, false)#">
                    )
                </cfquery>
			</cfloop>
			<cfreturn updating>
		</cfif>
    </cffunction>
    
    <cffunction name="Insertteammember" returntype="any" output="false" access="public" >
		<cfargument name="ResearchTeam" default=" ">
		<cfset qInsertids = Application.Sighting.qInsertid()>
		<cfset id = qInsertids.id>
        <cfif ResearchTeam NEQ '' >
			<cfloop index = "ListElement" list = "#ResearchTeam#">
				<cfquery name="update" datasource="#variables.dsn#" result="updating" >
                insert into RESEARCHTEAMMEMBER_Surveys (PROJECT_ID,RESEARCHTEAMMEMBER_ID,PLATFORM_ID) values
                (<cfqueryparam cfsqltype="cf_sql_integer" value='#id#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#VAL(ListElement)#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Platform#' null="#IIF(form.Platform EQ "", true, false)#">
                )
                </cfquery>
			</cfloop>
			<cfreturn updating>
		</cfif>
    </cffunction>
    <cffunction name="getZoneByType" returntype="any" output="true" access="remote">
		<cfargument name="zonetype" default="" required="yes">
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT Max (dbo.TLU_Zones.ID) as id ,dbo.TLU_Zones.[ZONE] FROM dbo.TLU_Zones where zone like '%#zonetype#%' GROUP BY dbo.TLU_Zones.[ZONE] order by dbo.TLU_Zones.[ZONE]
        </cfquery>
		<cfoutput>#SerializeJSON(query)#</cfoutput>
	</cffunction>
    <cffunction name="getCetaceanBySight" returntype="any" output="true" access="public">
		<cfquery name="dolphine_sight" datasource="#variables.dsn#" result='get_dolphine_result'>
            SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID=#sight_id# order by DOLPHIN_SIGHTINGS.Sighting_ID;
        </cfquery>
		<cfreturn dolphine_sight>
	</cffunction>
    <cffunction name="getdolphinBYShot" access="remote" returnformat="plain" output="true">
        <cfargument name="sight_id" default="">
		<cfquery name="getdolphinBYShot" datasource="#variables.dsn#" >
	     select  BIOPSY_SHOTS.* ,  DOLPHINS.* from BIOPSY_SHOTS INNER JOIN DOLPHINS on BIOPSY_SHOTS.dolphin_ID= DOLPHINS.ID
	     where BIOPSY_SHOTS.Sighting_ID = #sight_id#
		</cfquery>
        <cfset Arrayofshot = ArrayNew(1)>
        <cfloop query="getdolphinBYShot" >
       <cfset  structOfshot = StructNew() />
        <cfset structOfshot["DolName"] = Name>
        <cfset structOfshot["DolCod"] = Code>
        <cfset structOfshot["Dolshot"] = ShotNumber>
        <cfset structOfshot["DolSex"]= Sex>
        <cfset ArrayAppend(Arrayofshot,structOfshot)>
        </cfloop>
        <cfoutput>#SerializeJSON(Arrayofshot)#</cfoutput>
    </cffunction>
<!------- get Arbasters ---->
	<cffunction name="getArbalesters" returntype="any" output="true" access="public">
		<cfquery name="getArbalester" datasource="#variables.dsn#" result='get_dolphine_result'>
            SELECT Arbalester FROM BIOPSY_SHOTS WHERE Arbalester != '' group by Arbalester
        </cfquery>
		<cfreturn getArbalester>
	</cffunction>
	<cffunction name="getDscoreDropdown" output="TRUE" returntype="any" access="public">
		<cfquery name="getDscoreDropdown" datasource="#variables.dsn#" result="get_dscore_value">
	        SELECT * FROM TLU_Dscore where active = 1
        </cfquery>
		<cfreturn getDscoreDropdown>
	</cffunction>
    <cffunction name="getDscoreJson" access="remote" output="true" returnformat="plain" >
		<cfquery name="getJson" datasource="#variables.dsn#" result="abc">
	        SELECT * FROM TLU_Dscore where active = 1
        </cfquery>
		<cfset Array = ArrayNew(1)>
		<cfloop query="getJson">
            <cfset dolphinDscore = StructNew() />
			<cfset dolphinDscore["Dscore"] = Dscore>
			<cfset ArrayAppend(Array,dolphinDscore)>
		</cfloop>
		<cfoutput>#SerializeJSON(Array)#</cfoutput>
	</cffunction>
    <cffunction name="showIncidentData" access="remote" output="true" returnformat="plain">
        <cfargument name="date_inserted" default="">
            <cfquery name="showIncidentData" datasource="#variables.dsn#" result="abc">
              SELECT * FROM Tlu_IncidentSighting where  Dateinserted = '#date_inserted#'
            </cfquery>
              <Cfif #abc.RECORDCOUNT# eq 0>
                  <cfreturn false>
              <cfelseif #abc.RECORDCOUNT# gt 0>
                  <cfset Arrayofshot = ArrayNew(1)>
                  <cfset structOfshot = StructNew() />
                  <cfset StructInsert(structOfshot,"MMIR_Num",showIncidentData.MMIR_Num)>
                  <cfset StructInsert(structOfshot,"name",showIncidentData.name)>
                  <cfset StructInsert(structOfshot,"Genus",showIncidentData.Genus)>
                  <cfset StructInsert(structOfshot,"Species",showIncidentData.Species)>
                  <cfset StructInsert(structOfshot,"examinar_name",showIncidentData.examinar_name)>
                  <cfset StructInsert(structOfshot,"affiliation",showIncidentData.affiliation)>
                  <cfset StructInsert(structOfshot,"address",showIncidentData.address)>
                  <cfset StructInsert(structOfshot,"phone",showIncidentData.phone)>
                  <cfset StructInsert(structOfshot,"research_authornumber",showIncidentData.research_authornumber)>
                  <cfset StructInsert(structOfshot,"locality_details",showIncidentData.locality_details)>
                  <cfset StructInsert(structOfshot,"research_survey",showIncidentData.research_survey)>
                  <cfset StructInsert(structOfshot,"location_other",showIncidentData.location_other)>
                  <cfset StructInsert(structOfshot,"observedplace",showIncidentData.observedplace)>
                  <cfset StructInsert(structOfshot,"lefts",showIncidentData.lefts)>
                  <cfset StructInsert(structOfshot,"leftdes",showIncidentData.leftdes)>
                  <cfset StructInsert(structOfshot,"pendu",showIncidentData.pendu)>
                  <cfset StructInsert(structOfshot,"pendescription",showIncidentData.pendescription)>
                  <cfset StructInsert(structOfshot,"fluku",showIncidentData.fluku)>
                  <cfset StructInsert(structOfshot,"flukdescription",showIncidentData.flukdescription)>
                  <cfset StructInsert(structOfshot,"videscription",showIncidentData.videscription)>
                  <cfset StructInsert(structOfshot,"vido",showIncidentData.vido)>
                  <cfset StructInsert(structOfshot,"RDS",showIncidentData.RDS)>
                  <cfset StructInsert(structOfshot,"Emaciation",showIncidentData.Emaciation)>
                  <cfset StructInsert(structOfshot,"image1",showIncidentData.image1)>
                  <cfset StructInsert(structOfshot,"image2",showIncidentData.image2)>
                  <cfset ArrayAppend(Arrayofshot,structOfshot)>
                  <cfoutput>#SerializeJSON(Arrayofshot)#</cfoutput>
              </Cfif>
    </cffunction>
    <cffunction name="showSightData" access="remote" output="true" returnformat="plain">
          <cfargument name="dol_id" default="">
          <cfargument name="sight_id" default="">
          <cfargument name="project_id" default="">
          <cfquery name="showSightData" datasource="#variables.dsn#" result="showsight">
              select Survey_Sightings.Begin_LAT_Dec, Survey_Sightings.Begin_LON_Dec ,year(Survey_Sightings.Date_Entered) as year, month(Survey_Sightings.Date_Entered) as month,DAY(Survey_Sightings.Date_Entered) as day,
              ct=(SELECT COUNT(Survey_Sightings.Project_ID)from Survey_Sightings where Project_ID = #project_id# )from Survey_Sightings where Survey_Sightings.ID = #sight_id#

          </cfquery>
          <cfquery name="showDolphinData" datasource="#variables.dsn#" result="showdol">
               select  DOLPHINS.Sex , year(DOLPHINS.YearOfBirth) as birth, year(DOLPHINS.[First Sighting Date]) as firstsight from DOLPHINS where ID = #dol_id#
          </cfquery>
          <cfquery name="lastsight" datasource="#variables.dsn#" result="showlast">
               select CONVERT(date, Date_Entered) as lastdate ,Surveys.NOAAStock from Survey_Sightings INNER JOIN Surveys ON Survey_Sightings.Project_ID=Surveys.ID where Survey_Sightings.ID = #sight_id#
               order BY Survey_Sightings.ID  desc
           </cfquery>
          <cfset Arrayofsight = ArrayNew(1)>
          <cfset structOfsight = StructNew() />
          <cfset StructInsert(structOfsight,"Latitude",showSightData.Begin_LAT_Dec)>
          <cfset StructInsert(structOfsight,"Longitude",showSightData.Begin_LON_Dec)>
          <cfset StructInsert(structOfsight,"Year",showSightData.year)>
          <cfset StructInsert(structOfsight,"Month",showSightData.month)>
          <cfset StructInsert(structOfsight,"Day",showSightData.day)>
          <cfset StructInsert(structOfsight,"total",showSightData.ct)>
          <cfset StructInsert(structOfsight,"Sex",showDolphinData.Sex)>
          <cfset StructInsert(structOfsight,"lastdate",lastsight.lastdate)>
          <cfset StructInsert(structOfsight,"stock",lastsight.stock)>
          <cfset ArrayAppend(Arrayofsight,structOfsight)>
          <cfoutput>#SerializeJSON(Arrayofsight)#</cfoutput>
      </cffunction>
        <cffunction name="getavaiableincidents" returntype="any" output="true" access="public">
          <cfquery name="getavaiableincidents" datasource="#variables.dsn#">
            select Dateinserted from Tlu_IncidentSighting
          </cfquery>
          <cfreturn getavaiableincidents>
        </cffunction>

         <cffunction name="getIncidentReportType" returntype="any" output="true" access="public">
          <cfquery name="getIncidentReportType" datasource="#variables.dsn#">
            SELECT ID,IR_type FROM TLU_IncidentReportType where Active = 1
          </cfquery>
          <cfreturn getIncidentReportType>
        </cffunction>

         <cffunction name="getIR_CountyLocation" returntype="any" output="true" access="public">
          <cfquery name="getIR_CountyLocation" datasource="#variables.dsn#">
            SELECT ID,IR_CountyLocation FROM TLU_IR_CountyLocation where Active = 1
          </cfquery>
          <cfreturn getIR_CountyLocation>
        </cffunction>

		<!---Get FundingSource--->
		<cffunction name="getFundingSource" returntype="any" output="false" access="public" >
			<cfquery name="qgetFundingSource" datasource="#variables.dsn#"  >
				SELECT * from TLU_FundingSource <!---Where active = 1---> Order by name asc
			</cfquery>
			<cfreturn qgetFundingSource>
		</cffunction>
        
        <cffunction name="getDolphinsWithNoSightings" returntype="any" output="false" access="public" >
            <cfif isdefined("Form.btnSearchSightings")>
            	<cfif isdefined("form.date") and form.date NEQ "">
					<cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
                    <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
                </cfif>
            </cfif>
			<cfquery name="qgetDolphinsWithNoSightings" datasource="#variables.dsn#"  >
				select s.ID,s.SightingNumber,s.Project_ID,p.BodyOfWater,p.Type,p.Date,concat(u.first_name,' ',u.last_name) as entered_by
                from Survey_Sightings s 
                left join dolphin_sightings ds on s.ID = ds.Sighting_ID
                left join Surveys p on s.Project_ID   = p.ID
                left join users    u on ds.entered_by  = u.user_id
                where <cfif not isdefined("toBeReviewed")>ds.Sighting_ID is null and</cfif> s.Project_ID is not null and p.ID is not null
                <cfif isdefined("form.bodyOfWater") and form.bodyOfWater neq ""> and p.BodyOfWater like '%#trim(form.bodyOfWater)#%'</cfif>
                <cfif isdefined("form.surveyType")  and form.surveyType  neq ""> and p.type like '%#form.surveyType#%'</cfif>
                <cfif isdefined("toBeReviewed")> and ds.review = 'To be Reviewed'</cfif>
                <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), p.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
                order by p.Date
			</cfquery>
			<cfreturn qgetDolphinsWithNoSightings>
		</cffunction>
        
        <cffunction name="sight_delete" returntype="any" output="false" access="public" >
			<cfquery name="sighting_delete" datasource="#variables.dsn#">
				update Survey_Sightings set IsDeleted  = <cfqueryparam cfsqltype="CF_SQL_BIT" value='1'>
                where Survey_Sightings.PROJECT_ID = #form.PROJECT_ID# and Survey_Sightings.ID  = #form.SIGHTING_ID#
			</cfquery>
		</cffunction>
        <cffunction name="survey_delete" returntype="any" output="false" access="public" >
			<cfquery name="surveys_delete" datasource="#variables.dsn#">
				update Surveys set IsDeleted  = <cfqueryparam cfsqltype="CF_SQL_BIT" value='1'>
                where ID = #form.PROJECT_ID#
			</cfquery>
		</cffunction>


</cfcomponent>