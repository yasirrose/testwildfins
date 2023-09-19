<cfcomponent>
	<cfheader name="Access-Control-Allow-Origin" value="*" />
    <cfset variables.dsn = "wildfins_new">
	<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
		<cfargument name="dsn" type="string" required="true" hint="datasource">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
    

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
	 PROJECTS.Date as DateSeen
	 FROM PROJECTS LEFT JOIN
     ((SIGHTINGS LEFT JOIN
     (DOLPHINS RIGHT JOIN
     DOLPHIN_SIGHTINGS ON DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
     ON
     SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
     LEFT JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID)
     ON
     PROJECTS.ID = SIGHTINGS.Project_ID
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
	            SELECT Project_ID FROM SIGHTINGS WHERE ID = #Sightningid#
			</cfquery>
<!---GET ALL SIGHTINGS_DOLPHINS OF PROJECT--->
			<cfquery name="dolphine_sight" datasource="#variables.dsn#" result ='get_dolphine_result'>
                SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID IN (SELECT ID FROM SIGHTINGS WHERE Project_ID = #getProjectID.PROJECT_ID#) order by DOLPHIN_SIGHTINGS.Sighting_ID;
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
            UPDATE SIGHTINGS SET
            analyzed = <cfqueryparam cfsqltype="cf_sql_integer" value="#analyzed#"> WHERE project_id=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.project_id#'> and
             ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.sight_id#'>

        </cfquery>
		<cfreturn return_data>
    </cffunction>
<!---- get qUpdate sight ---->
    <cffunction name="qUpdateProject_SIGHT" returntype="any" output="false" access="public" >
        <cfquery name="qgetdate" datasource="#variables.dsn#"  >
	        SELECT [DATE] as pro_date from PROJECTS where id = #form.project_id#
		</cfquery>
		<cfset dummydate = DateFormat(qgetdate.pro_date,"yyyy-mm-dd") >
        <cfif len(trim(form.Sightingstart)) NEQ 0>
			<cfset Sightingstart=dummydate & form.Sightingstart >
		<cfelse>
			<cfset Sightingstart=NOW()>
		</cfif>
        <cfif len(trim(form.Sightingend)) NEQ 0>
			<cfset Sightingend=dummydate & form.Sightingend >
		<cfelse>
			<cfset Sightingend=NOW()>
		</cfif>
        <cfif isdefined('form.Survey')>
			<cfset Survey=form.Survey>
		<cfelse>
			<cfset Survey=''>
		</cfif>
        <cfif isdefined('form.chase_feed')>
			<cfset chase_feed = 1>
		<cfelse>
			<cfset chase_feed=0>
		</cfif><cfif isdefined('form.Pinwheel')>
			<cfset Pinwheel = 1>
		<cfelse>
			<cfset Pinwheel=0>
		</cfif>
        <cfif isdefined('form.feed_Herding')>
			<cfset feed_Herding = 1>
		<cfelse>
			<cfset feed_Herding=0>
		</cfif>
        <cfif isdefined('form.Headstand')>
			<cfset Headstand = 1>
		<cfelse>
			<cfset Headstand=0>
		</cfif>
        <cfif isdefined('form.Repetitive_Diving')>
			<cfset Repetitive_Diving = 1>
		<cfelse>
			<cfset Repetitive_Diving=0>
		</cfif>
        <cfif isdefined('form.Commercial_Interaction')>
			<cfset Commercial_Interaction = 1>
		<cfelse>
			<cfset Commercial_Interaction=0>
		</cfif>
        <cfif isdefined('form.Crab_Pot')>
			<cfset Crab_Pot = 1>
		<cfelse>
			<cfset Crab_Pot=0>
		</cfif>
        <cfif isdefined('form.Boat_Escort')>
			<cfset Boat_Escort = 1>
		<cfelse>
			<cfset Boat_Escort=0>
		</cfif>

        <cfif isdefined('form.Catch_Release')>
			<cfset Catch_Release = 1>
		<cfelse>
			<cfset Catch_Release=0>
		</cfif>
        <cfif isdefined('form.Bycatch_Scavenge')>
			<cfset Bycatch_Scavenge = 1>
		<cfelse>
			<cfset Bycatch_Scavenge=0>
		</cfif>
        <cfif isdefined('form.Head_Out_Begging')>
			<cfset Head_Out_Begging = 1>
		<cfelse>
			<cfset Head_Out_Begging=0>
		</cfif>
        <cfif isdefined('form.Human_Feed')>
			<cfset Human_Feed = 1>
		<cfelse>
			<cfset Human_Feed=0>
		</cfif>
        <cfif isdefined('form.Recreational_Interaction')>
			<cfset Recreational_Interaction = 1>
		<cfelse>
			<cfset Recreational_Interaction=0>
		</cfif>
        <cfquery name="query" datasource="#variables.dsn#" result="return_data">
            UPDATE SIGHTINGS SET
            SightingNumber = <cfqueryparam cfsqltype="cf_sql_integer" value="#SightingNumber#" null="#IIF(SightingNumber EQ "", true, false)#">,
            StartTime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Sightingstart#">,
            EndTime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Sightingend#">,
            Beaufort = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Beaufort#' null="#IIF(Beaufort EQ "", true, false)#"> ,
            WaterTemp = <cfqueryparam  cfsqltype="cf_sql_integer" value='#WaterTemp#' null="#IIF(WaterTemp EQ "", true, false)#">,
            zone_id=<cfqueryparam  cfsqltype="cf_sql_integer" value="#zone_id#" null="#IIF(zone_id EQ "", true, false)#">,
            Survey=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Survey#' null="#IIF(Survey EQ "", true, false)#">,
            Location=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Location#' null="#IIF(Location EQ "", true, false)#">,
            ICW_Begin=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#ICW_Begin#' null="#IIF(ICW_Begin EQ "", true, false)#">,
            Begin_LAT_Dec=<cfqueryparam  cfsqltype="cf_sql_float" value='#Begin_LAT_Dec#' null="#IIF(Begin_LAT_Dec EQ "", true, false)#">,
            heading=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#heading#' null="#IIF(heading EQ "", true, false)#">,
            NumberOfBoats=<cfqueryparam  cfsqltype="cf_sql_integer" value='#NumberOfBoats#' null="#IIF(NumberOfBoats EQ "", true, false)#">,
            AssocBioData1=<cfqueryparam  cfsqltype="cf_sql_integer" value='#AssocBioData1#' null="#IIF(AssocBioData1 EQ "", true, false)#">,
            AssocBioData2=<cfqueryparam  cfsqltype="cf_sql_integer" value='#AssocBioData2#' null="#IIF(AssocBioData2 EQ "", true, false)#">,
            AssocBioData3=<cfqueryparam  cfsqltype="cf_sql_integer" value='#AssocBioData3#' null="#IIF(AssocBioData3 EQ "", true, false)#">,
            FE_TotalDolphin_Min=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalDolphin_Min#' null="#IIF(FE_TotalDolphin_Min EQ "", true, false)#">,
            FE_TotalDolphin_Max=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalDolphin_Max#' null="#IIF(FE_TotalDolphin_Max EQ "", true, false)#">,
            FE_TotalDolphin_Best=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalDolphin_Best#' null="#IIF(FE_TotalDolphin_Best EQ "", true, false)#">,
            FE_TotalCalves_Min=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalCalves_Min#' null="#IIF(FE_TotalCalves_Min EQ "", true, false)#">,
            FE_TotalCalves_Max=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalCalves_Max#' null="#IIF(FE_TotalCalves_Max EQ "", true, false)#">,
            FE_TotalCalves_Best=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalCalves_Best#' null="#IIF(FE_TotalCalves_Best EQ "", true, false)#">,
            FE_YoungOfYear_Min=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_YoungOfYear_Min#' null="#IIF(FE_YoungOfYear_Min EQ "", true, false)#">,
            FE_YoungOfYear_Max=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_YoungOfYear_Max#' null="#IIF(FE_YoungOfYear_Max EQ "", true, false)#">,
            FE_YoungOfYear_Best=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_YoungOfYear_Best#' null="#IIF(FE_YoungOfYear_Best EQ "", true, false)#">,
            Activity_Mill=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Mill#' null="#IIF(Activity_Mill EQ "", true, false)#">,
            Activity_Feed=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Feed#' null="#IIF(Activity_Feed EQ "", true, false)#">,
            Activity_ProbFeed=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Activity_ProbFeed#' null="#IIF(Activity_ProbFeed EQ "", true, false)#">,
            Activity_Travel=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Travel#' null="#IIF(Activity_Travel EQ "", true, false)#">,
             Activity_Play=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Play#' null="#IIF(Activity_Play EQ "", true, false)#">,
             Activity_Rest=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Rest#' null="#IIF(Activity_Rest EQ "", true, false)#">,
             Activity_Leap_tailslap_chuff=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Leap_tailslap_chuff#' null="#IIF(Activity_Leap_tailslap_chuff EQ "", true, false)#">,
             Activity_Social=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Social#' null="#IIF(Activity_Social EQ "", true, false)#">,
             Activity_WithBoat=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_WithBoat#' null="#IIF(Activity_WithBoat EQ "", true, false)#">,
             Activity_Other=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Other#' null="#IIF(Activity_Other EQ "", true, false)#">,
             Activity_Avoid_Boat=<cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Avoid_Boat#' null="#IIF(Activity_Avoid_Boat EQ "", true, false)#">,
             Northing_Y=<cfqueryparam  cfsqltype="cf_sql_float" value='#Northing_Y#' null="#IIF(Northing_Y EQ "", true, false)#">,
             Easting_X=<cfqueryparam  cfsqltype="cf_sql_float" value='#Easting_X#' null="#IIF(Easting_X EQ "", true, false)#">,
             Fisheries_None=1,
             Fisheries_RecTrolling=1,
             Fisheries_RecAnchored=1,
             Fisheries_CrabTraps=1,
             Fisheries_CrabWork=1,
             Notes=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#notes#' null="#IIF(notes EQ "", true, false)#"> ,
             Weather =  <cfqueryparam  cfsqltype="cf_sql_integer" value='#Weather#' null="#IIF(Weather EQ "", true, false)#">,
             WaveHeight = <cfqueryparam  cfsqltype="cf_sql_integer" value='#WaveHeight#' null="#IIF(WaveHeight EQ "", true, false)#">,
             Glare = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Glare#' null="#IIF(Glare EQ "", true, false)#">,
             Sightability = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Sightability#' null="#IIF(Sightability EQ "", true, false)#">,
             <!---Takes=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Takes#' null="#IIF(Takes EQ "", true, false)#">,     --->
             Depredation=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Depredation#' null="#IIF(Depredation EQ "", true, false)#">,
             Herding=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Herding#' null="#IIF(Depredation EQ "", true, false)#">,
             chase_feed=<cfqueryparam  cfsqltype="cf_sql_integer" value='#chase_feed#'>,
             Pinwheel=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Pinwheel#' >,
             feed_Herding=<cfqueryparam  cfsqltype="cf_sql_integer" value='#feed_Herding#'>,
             Headstand=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Headstand#'>,
             Repetitive_Diving=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Repetitive_Diving#'>,
             Commercial_Interaction=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Commercial_Interaction#' >,
             Crab_Pot=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Crab_Pot#'>,
             Boat_Escort=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Boat_Escort#'>,
             Catch_Release=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Catch_Release#'>,
             Bycatch_Scavenge=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Bycatch_Scavenge#'>,
             Head_Out_Begging=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_Out_Begging#'>,
             Human_Feed=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Human_Feed#'>,
             Recreational_Interaction=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Recreational_Interaction#' >,
             feed_latitude=<cfqueryparam  cfsqltype="cf_sql_integer" value='#feed_latitude#' null="#IIF(feed_latitude EQ "", true, false)#">,
             feed_longitude=<cfqueryparam  cfsqltype="cf_sql_integer" value='#feed_longitude#' null="#IIF(feed_longitude EQ "", true, false)#">,
             Tide=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Tide#' null="#IIF(Tide EQ "", true, false)#">,
             Structure_Present=<cfqueryparam  cfsqltype="cf_sql_integer" value='#Structure_Present#' null="#IIF(Structure_Present EQ "", true, false)#">,
             feed_Habitat=<cfqueryparam  cfsqltype="cf_sql_integer" value='#feed_Habitat#' null="#IIF(feed_Habitat EQ "", true, false)#">
             WHERE project_id=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.project_id#'> and
             ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.sight_id#'>
        </cfquery>
		<cfreturn return_data>
	</cffunction>
<!---- get qUpdate Project ---->
    <cffunction name="qUpdateProject" returntype="any" output="false" access="public" >
        <cfargument default="" name="SurveyArea" >
		<cfargument default="" name="Stock" >
		<!---<cfargument default="" name="Summary" >--->
		<cfargument default="" name="FundingSource" >
        <cfif isdefined('Form.SurveyType')>
			<cfset  SurveyType=form.SurveyType>
		<cfelse>
			<cfset  SurveyType=0>
		</cfif>
        <cfif len(trim(form.Date_p)) NEQ 0>
			<cfset Date_p=form.Date_p>
		<cfelse>
			<cfset Date_p=NOW()>
		</cfif>
        <cfset dummydate=DateFormat(Date_p,"yyyy-mm-dd")>
        <cfif len(trim(form.StartTime)) NEQ 0>
			<cfset StartTime=dummydate & form.StartTime>
		<cfelse>
			<cfset StartTime=NOW()>
		</cfif>
        <cfif len(trim(form.EndTime)) NEQ 0>
			<cfset EndTime=dummydate & form.EndTime >
		<cfelse>
			<cfset EndTime=NOW()>
		</cfif>
        <cfif len(trim(form.SurveyStartTime)) NEQ 0>
			<cfset SurveyStartTime=dummydate & form.SurveyStartTime>
		<cfelse>
			<cfset SurveyStartTime=NOW()>
		</cfif>
        <cfif len(trim(form.SurveyEndTime)) NEQ 0>
			<cfset SurveyEndTime=dummydate & form.SurveyEndTime>
		<cfelse>
			<cfset SurveyEndTime=NOW()>
		</cfif>
        <cfif len(trim(form.EngineStart)) NEQ 0>
			<cfset EngineStart=dummydate & form.EngineStart>
		<cfelse>
			<cfset EngineStart=NOW()>
		</cfif>
		<cfif len(trim(form.EngineOff)) NEQ 0>
			<cfset EngineOff=dummydate & form.EngineOff>
		<cfelse>
			<cfset EngineOff=NOW()>
		</cfif>
        <cfif len(trim(form.Date_p)) NEQ 0>
			<cfset Date_p=form.Date_p>
		<cfelse>
			<cfset Date_p=NOW()>
		</cfif>
        <cfquery name="query" datasource="#variables.dsn#" result="return_data">
            UPDATE PROJECTS SET Date =<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Date_p#'>,
            StartTime=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#StartTime#'>,
            EndTime=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#EndTime#'>,
            SurveyStartTime=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#SurveyStartTime#'>,
            SurveyEndTime=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#SurveyEndTime#'>,
            EngineStart=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#EngineStart#'>,
            EngineOff=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#EngineOff#'>,
            <!---SurveyArea=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form["SurveyArea[]"]#' null="#IIF(Form['SurveyArea[]'] EQ "", true, false)#">,--->
            Type=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Type#' null="#IIF(Type EQ "", true, false)#">,
            SubType=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#SubType#' null="#IIF(SubType EQ "", true, false)#">,
            SurveyType=<cfqueryparam  cfsqltype="cf_sql_integer" value='#SurveyType#' null="#IIF(SurveyType EQ "", true, false)#">,
            [Historical Survey Time]=1,
           <!--- BeginZoneID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#BeginZoneID#' null="#IIF(BeginZoneID EQ "", true, false)#">,
            EndZoneID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#EndZoneID#' null="#IIF(EndZoneID EQ "", true, false)#">,--->
            Stock=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Stock#' null="#IIF(Stock EQ "", true, false)#">,
            <!---Summary=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Summary#' null="#IIF(Summary EQ "", true, false)#">,--->
			FundingSource=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#FundingSource#' null="#IIF(FundingSource EQ "", true, false)#">
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
	<cffunction name="qProjects" returntype="any" output="false" access="public" >
		<cfquery name="qProject" datasource="#variables.dsn#">
	        SELECT PROJECTS.* FROM PROJECTS where id =<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'> ORDER BY PROJECTS.Date;
	</cfquery>
		<cfreturn qProject>
	</cffunction>
<!---- get qProjectszone ---->
	<cffunction name="qProjectszone" returntype="any" output="false" access="public" >
		<cfquery name="qzone" datasource="#variables.dsn#">
            SELECT Project_Zones.*,TLU_Zones.* FROM TLU_Zones RIGHT JOIN Project_Zones ON TLU_Zones.ID = Project_Zones.TZ_Zone_ID where TZ_Project_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'> ORDER BY TLU_Zones.ZONE;
    </cfquery>
		<cfreturn qzone>
	</cffunction>
<!---- get qProject_ten ---->
	<cffunction name="qProject_ten" returntype="any" output="false" access="public" >
		<cfquery name="qproject" datasource="#variables.dsn#">
		SELECT top 10 PROJECTS.* FROM PROJECTS ORDER BY PROJECTS.Date
    </cfquery>
		<cfreturn qproject>
	</cffunction>
<!---- get qSightningDetails ---->
	<cffunction name="qSightningDetails2" returntype="any" output="false" access="public" >
		<cfargument name="FORM" type="struct" required="true" default="0">
        <cfquery name="query" datasource="#variables.dsn#">
		 SELECT SIGHTINGS.*,TLU_Zones.zone FROM SIGHTINGS LEFT JOIN TLU_Zones ON 
         SIGHTINGS.Zone_id = TLU_Zones.ID where SIGHTINGS.project_id = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.PROJECT_ID#'> and SIGHTINGS.ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.sight_id#'>
		</cfquery>
		<cfreturn query>
	</cffunction>
<!---- get qSightningDetails ---->
	<cffunction name="qSightningDetails" returntype="any" output="false" access="public" >
		<cfargument name="sight_id" default="0">
        <cfquery name="query" datasource="#variables.dsn#">
		 SELECT SIGHTINGS.*,TLU_Zones.zone FROM SIGHTINGS LEFT JOIN TLU_Zones ON 
         SIGHTINGS.Zone_id = TLU_Zones.ID where SIGHTINGS.project_id = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'> and SIGHTINGS.ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#sight_id#'>
		</cfquery>
		<cfreturn query>
	</cffunction>
<!---- get List sighting ---->
	<cffunction name="getsightinglist" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
		 SELECT SIGHTINGS.ID,SIGHTINGS.SIGHTINGNUMBER
 		 FROM SIGHTINGS where project_id = <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'> ORDER BY SIGHTINGS.ID <!---desc--->;
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
<!---- get qGetCameralens ---->
	<cffunction name="qGetCameralens" returntype="any" output="false" access="public" >
		<cfset qSightningDetails=Application.Sighting.qSightningDetails(argumentCollection="#Form#")>
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT
            PHOTO_ROLLS.ID,
            PHOTO_ROLLS.Sighting_ID,
             PHOTO_ROLLS.Camera AS Camera,
             PHOTO_ROLLS.Photographer,
             PHOTO_ROLLS.Driver,
             TLU_Camera.Camera AS Camera_Name,
             TLU_Camera.ID as camera_ID,
             PHOTO_ROLLS.Lens AS Lens_id, TLU_Lens.Lens AS Lens_Name
             FROM
            (PHOTO_ROLLS LEFT JOIN TLU_Camera ON PHOTO_ROLLS.Camera = TLU_Camera.ID)
            LEFT JOIN TLU_Lens ON PHOTO_ROLLS.Lens = TLU_Lens.ID
            where Sighting_ID = '#qSightningDetails.id#'
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
	  select RT_MemberName , RT_ID  from TLU_ResearchTeamMembers   inner join RESEARCHTEAMMEMBER_PROJECTS ON RESEARCHTEAMMEMBER_PROJECTS.RESEARCHTEAMMEMBER_ID = TLU_ResearchTeamMembers.RT_ID where RESEARCHTEAMMEMBER_PROJECTS.PROJECT_ID = #PROJECT_ID#
		</cfquery>
		<cfreturn query>
	</cffunction>
<!---- get qGetSightings ---->
	<cffunction name="qGetSightings" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
	SELECT SIGHTINGS.*
    FROM SIGHTINGS LEFT JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID where project_id = #form.PROJECT_ID#
    ORDER BY SIGHTINGS.SightingNumber, TLU_Zones.ZONE;
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
<!---- get qGetProjectZones ---->
	<cffunction name="qGetProjectZones" returntype="any" output="false" access="public" >
		<cfquery name="query" datasource="#variables.dsn#">
            SELECT Project_Zones.*
            FROM TLU_Zones RIGHT JOIN Project_Zones ON TLU_Zones.ID = Project_Zones.TZ_Zone_ID
            where TZ_Project_ID = #form.PROJECT_ID#
            ORDER BY TLU_Zones.ZONE;
        </cfquery>
		<cfreturn query>
	</cffunction>
<!----Last Project ID ---->
	<cffunction name="qInsertid" returntype="any" output="false" access="public" >
		<cfquery name="qInsert" datasource="#variables.dsn#" >
		SELECT ISNULL(MAX(ID), 0) as id  from  PROJECTS 
	    </cfquery>
		<cfreturn qInsert>
	</cffunction>
<!---- Project Isnert----->
	<cffunction name="qInsertProject" returntype="any" output="true" access="public" >
		<cfargument default="" name="SurveyArea" >
		<cfargument default="" name="Stock" >
		<!---<cfargument default="" name="Summary" >--->
		<cfargument default="" name="FundingSource" >
		<cfif isdefined('Form.SurveyType')>
			<cfset  SurveyType=form.SurveyType>
		<cfelse>
			<cfset  SurveyType=0>
		</cfif>
		<cfif len(trim(form.Date_p)) NEQ 0>
			<cfset Date_p=form.Date_p>
		<cfelse>
			<cfset Date_p=NOW()>
		</cfif>
		<cfset dummydate=DateFormat(Date_p,"yyyy-mm-dd")>
		<cfif len(trim(form.StartTime)) NEQ 0>
			<cfset StartTime=dummydate & form.StartTime>
		<cfelse>
			<cfset StartTime=NOW()>
		</cfif>
		<cfif len(trim(form.EndTime)) NEQ 0>
			<cfset EndTime=dummydate & form.EndTime >
		<cfelse>
			<cfset EndTime=NOW()>
		</cfif>
		<cfif len(trim(form.SurveyStartTime)) NEQ 0>
			<cfset SurveyStartTime=dummydate & form.SurveyStartTime>
		<cfelse>
			<cfset SurveyStartTime=NOW()>
		</cfif>
		<cfif len(trim(form.SurveyEndTime)) NEQ 0>
			<cfset SurveyEndTime=dummydate & form.SurveyEndTime>
		<cfelse>
			<cfset SurveyEndTime=NOW()>
		</cfif>
        <cfif len(trim(form.EngineStart)) NEQ 0>
			<cfset EngineStart=dummydate & form.EngineStart>
		<cfelse>
			<cfset EngineStart=NOW()>
		</cfif>
		<cfif len(trim(form.EngineOff)) NEQ 0>
			<cfset EngineOff=dummydate & form.EngineOff>
		<cfelse>
			<cfset EngineOff=NOW()>
		</cfif>
		<cfset qInsertid=Application.Sighting.qInsertid()>
		<cfset project_id = qInsertid.id + 1>
		<cfquery name="qInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO PROJECTS (
            <!---BeginZoneID,EndZoneID,--->
            Date,
            StartTime,
            EndTime,
            SurveyStartTime,
            SurveyEndTime,
            EngineStart,
            EngineOff,
            <!---SurveyArea,--->
            Type,
            SubType,
            SurveyType,[Historical Survey Time],Stock<!---,Summary--->,FundingSource) VALUES
           (
           <!---<cfqueryparam  cfsqltype="cf_sql_integer" value='#BeginZoneID#' null="#IIF(BeginZoneID EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#EndZoneID#' null="#IIF(EndZoneID EQ "", true, false)#">,--->
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Date_p#'>,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#StartTime#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#EndTime#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SurveyStartTime#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SurveyEndTime#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#EngineStart#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#EngineOff#">,
           <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form["SurveyArea[]"]#' null="#IIF(Form['SurveyArea[]'] EQ "", true, false)#">,--->
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Type#' null="#IIF(Type EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SubType#' null="#IIF(SubType EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#SurveyType#' null="#IIF(SurveyType EQ "", true, false)#">,
            1,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Stock#' null="#IIF(Stock EQ "", true, false)#">,
           <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Summary#' null="#IIF(Summary EQ "", true, false)#">,--->
		   <cfqueryparam  cfsqltype="cf_sql_varchar" value='#FundingSource#' null="#IIF(FundingSource EQ "", true, false)#">
           )
        </cfquery>
		<cfreturn return_data>
	</cffunction>
<!---- Sight Isnert----->
	<cffunction name="InsertSight" returntype="any" output="false" access="public" >
        <cfargument  name="project_id" default="0">
		<cfquery name="qgetdate" datasource="#variables.dsn#"  >
	        SELECT [DATE] as pro_date from PROJECTS where id = #project_id#
		</cfquery>
		<cfset dummydate = DateFormat(qgetdate.pro_date,"yyyy-mm-dd") >
		<cfif len(trim(form.Sightingstart)) NEQ 0>
			<cfset Sightingstart=dummydate & form.Sightingstart >
		<cfelse>
			<cfset Sightingstart=NOW()>
		</cfif>
		<cfif len(trim(form.Sightingend)) NEQ 0>
			<cfset Sightingend=dummydate & form.Sightingend >
		<cfelse>
			<cfset Sightingend=NOW()>
		</cfif>
		<cfif isdefined('form.Survey')>
			<cfset Survey=form.Survey >
		<cfelse>
			<cfset Survey=''>
		</cfif>
		<cfif  project_id GT 0>
			<cfset project_id = form.project_id >
		<cfelse>
			<cfset qInsertid=Application.Sighting.qInsertid()>
			<cfset project_id = qInsertid.id>
		</cfif>
        <cfif isdefined('form.chase_feed')>
            <cfset chase_feed = 1>
        <cfelse>
            <cfset chase_feed=0>
        </cfif>
        <cfif isdefined('form.Pinwheel')>
        <cfset Pinwheel = 1>
        <cfelse>
        <cfset Pinwheel=0>
        </cfif>
        <cfif isdefined('form.feed_Herding')>
            <cfset feed_Herding = 1>
        <cfelse>
            <cfset feed_Herding=0>
        </cfif>
        <cfif isdefined('form.Headstand')>
            <cfset Headstand = 1>
        <cfelse>
            <cfset Headstand=0>
        </cfif>
        <cfif isdefined('form.Repetitive_Diving')>
            <cfset Repetitive_Diving = 1>
        <cfelse>
            <cfset Repetitive_Diving=0>
        </cfif>
        <cfif isdefined('form.Commercial_Interaction')>
            <cfset Commercial_Interaction = 1>
        <cfelse>
            <cfset Commercial_Interaction=0>
        </cfif>
        <cfif isdefined('form.Crab_Pot')>
            <cfset Crab_Pot = 1>
        <cfelse>
            <cfset Crab_Pot=0>
        </cfif>
        <cfif isdefined('form.Boat_Escort')>
            <cfset Boat_Escort = 1>
        <cfelse>
            <cfset Boat_Escort=0>
        </cfif>

        <cfif isdefined('form.Catch_Release')>
            <cfset Catch_Release = 1>
        <cfelse>
            <cfset Catch_Release=0>
        </cfif>
        <cfif isdefined('form.Bycatch_Scavenge')>
            <cfset Bycatch_Scavenge = 1>
        <cfelse>
            <cfset Bycatch_Scavenge=0>
        </cfif>
        <cfif isdefined('form.Head_Out_Begging')>
            <cfset Head_Out_Begging = 1>
        <cfelse>
            <cfset Head_Out_Begging=0>
        </cfif>
        <cfif isdefined('form.Human_Feed')>
            <cfset Human_Feed = 1>
        <cfelse>
            <cfset Human_Feed=0>
        </cfif>
        <cfif isdefined('form.Recreational_Interaction')>
            <cfset Recreational_Interaction = 1>
        <cfelse>
            <cfset Recreational_Interaction=0>
        </cfif>
        <cfset qInsertids = Application.Sighting.qInsertids()>
		<cfset id = qInsertids.ids + 1>
        <cfquery name="qInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO SIGHTINGS
            (project_id,
            SightingNumber,
            StartTime,
            EndTime,
            zone_id,
            Survey,Location,
            ICW_Begin,
            Begin_LAT_Dec,Begin_LON_Dec,
            heading,NumberOfBoats,
            AssocBioData1,AssocBioData2,
            AssocBioData3,FE_TotalDolphin_Min,
            FE_TotalDolphin_Max,FE_TotalDolphin_Best,
            FE_TotalCalves_Min,FE_TotalCalves_Max,
            FE_TotalCalves_Best,FE_YoungOfYear_Min,
            FE_YoungOfYear_Max,FE_YoungOfYear_Best,
            Activity_Mill,Activity_Feed,Activity_ProbFeed,
            Activity_Travel,Activity_Play,Activity_Rest,
            Activity_Leap_tailslap_chuff,Activity_Social,
            Activity_WithBoat,Activity_Other,
            Activity_Avoid_Boat,Fisheries_None,
            Fisheries_RecTrolling, Fisheries_RecAnchored,
            Fisheries_CrabTraps,Fisheries_CrabWork,
            Beaufort,WaterTemp,Easting_X,Northing_Y,
            WaveHeight,Weather,
            Glare,Sightability,
            Herding,
            Depredation,
            Notes,
            chase_feed,
            Pinwheel,
            feed_Herding,
            Headstand,
            Repetitive_Diving,
            Commercial_Interaction,
            Crab_Pot,
            Boat_Escort,
            Catch_Release,
            Bycatch_Scavenge,
            Head_Out_Begging,
            Human_Feed,
            Tide,
            Structure_Present,
            feed_Habitat,
            Recreational_Interaction,
            feed_latitude,
            feed_longitude,
            SurveyArea
            )
            VALUES
           (<cfqueryparam  cfsqltype="cf_sql_integer" value='#project_id#'>,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#SightingNumber#' null="#IIF(SightingNumber EQ "", true, false)#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Sightingstart#">,
           <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Sightingend#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#zone_id#' null="#IIF(zone_id EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Survey#' null="#IIF(Survey EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Location#' null="#IIF(Location EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varcahr" value='#ICW_Begin#' null="#IIF(ICW_Begin EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_float" value='#Begin_LAT_Dec#' null="#IIF(Begin_LAT_Dec EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_float" value='#Begin_LON_Dec#' null="#IIF(Begin_LON_Dec EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#heading#' null="#IIF(heading EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_smallint" value='#NumberOfBoats#' null="#IIF(NumberOfBoats EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#AssocBioData1#' null="#IIF(AssocBioData1 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#AssocBioData2#' null="#IIF(AssocBioData2 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#AssocBioData3#' null="#IIF(AssocBioData3 EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalDolphin_Min#' null="#IIF(FE_TotalDolphin_Min EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalDolphin_Max#' null="#IIF(FE_TotalDolphin_Max EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalDolphin_Best#' null="#IIF(FE_TotalDolphin_Best EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalCalves_Min#' null="#IIF(FE_TotalCalves_Min EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalCalves_Max#' null="#IIF(FE_TotalCalves_Max EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_TotalCalves_Best#' null="#IIF(FE_TotalCalves_Best EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_YoungOfYear_Min#' null="#IIF(FE_YoungOfYear_Min EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_YoungOfYear_Max#' null="#IIF(FE_YoungOfYear_Max EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#FE_YoungOfYear_Best#' null="#IIF(FE_YoungOfYear_Best EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Mill#' null="#IIF(Activity_Mill EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Feed#' null="#IIF(Activity_Feed EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Activity_ProbFeed#' null="#IIF(Activity_ProbFeed EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#form.Activity_Travel#' null="#IIF(Activity_Travel EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Play#' null="#IIF(Activity_Play EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Rest#' null="#IIF(Activity_Rest EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Leap_tailslap_chuff#' null="#IIF(Activity_Leap_tailslap_chuff EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Social#' null="#IIF(Activity_Social EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_WithBoat#' null="#IIF(Activity_WithBoat EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Other#' null="#IIF(Activity_Other EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_tinyint" value='#Activity_Avoid_Boat#' null="#IIF(Activity_Avoid_Boat EQ "", true, false)#">
           ,1,1,1,1,1,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Beaufort#' null="#IIF(Beaufort EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#WaterTemp#' null="#IIF(WaterTemp EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_float" value='#Easting_X#' null="#IIF(Easting_X EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_float" value='#Northing_Y#' null="#IIF(Northing_Y EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#WaveHeight#' null="#IIF(WaveHeight EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Weather#' null="#IIF(Weather EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Glare#' null="#IIF(Glare EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Sightability#' null="#IIF(Sightability EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Herding#' null="#IIF(Herding EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Depredation#' null="#IIF(Depredation EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_varchar" value='#notes#' null="#IIF(notes EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#chase_feed#' null="#IIF(chase_feed EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Pinwheel#' null="#IIF(Pinwheel EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#feed_Herding#' null="#IIF(feed_Herding EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Headstand#' null="#IIF(Headstand EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Repetitive_Diving#' null="#IIF(Repetitive_Diving EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Commercial_Interaction#' null="#IIF(Commercial_Interaction EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Crab_Pot#' null="#IIF(Crab_Pot EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Boat_Escort#' null="#IIF(Boat_Escort EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Catch_Release#' null="#IIF(Catch_Release EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Bycatch_Scavenge#' null="#IIF(Bycatch_Scavenge EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_Out_Begging#' null="#IIF(Head_Out_Begging EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Human_Feed#' null="#IIF(Human_Feed EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Tide#' null="#IIF(Tide EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Structure_Present#' null="#IIF(Structure_Present EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#feed_Habitat#' null="#IIF(feed_Habitat EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#Recreational_Interaction#' null="#IIF(Recreational_Interaction EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#feed_latitude#' null="#IIF(feed_latitude EQ "", true, false)#">,
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#feed_longitude#' null="#IIF(feed_longitude EQ "", true, false)#">,
		   <cfqueryparam  cfsqltype="cf_sql_integer" value='#SurveyArea#' null="#IIF(SurveyArea EQ "", true, false)#">
           )
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
		SELECT ISNULL(MAX(ID), 0) as ids  from  SIGHTINGS 
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
	<cffunction name="qProjectsId" returntype="any" output="false" access="public" >
		<cfquery name="qprojectID" datasource="#variables.dsn#"  >
     	SELECT id,Date FROM PROJECTS order by Date DESC 
    </cfquery>
		<cfreturn qprojectID>
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
	<cffunction name="getZoneForSurvey"  output="true" access="remote" returnformat='JSON'>
		<cfif isdefined('SESSION.zone')>
			<cfreturn  SESSION.zone>
		<cfelse>
			<cfreturn 1>
		</cfif>
	</cffunction>
	<cffunction name="InsetZonesData"  output="true" access="public"  returntype="any">
		<cfif isdefined("SESSION.zone")>
			<cfset qInsertid = Application.Sighting.qInsertid()>
			<cfset projectid = qInsertid.id>
			<cfloop index="i" from="1" to="#arrayLen(session.zone)#">
				<cfquery name="insert" datasource="#variables.dsn#">
           INSERT into Project_Zones (TZ_Project_ID,TZ_Zone_ID)values(
           <cfqueryparam  cfsqltype="cf_sql_integer" value='#projectid#'>,
           <cfqueryparam  cfsqltype="cf_sql_integer" value="#session.zone[i].ID#">)
           </cfquery>
			</cfloop>
			<cfset exists= structdelete(session, 'session.zone', true)/>
		</cfif>
	</cffunction>
	<cffunction name="PRojectzonelist" output="true" access="public" returntype="any">
		<cfquery name="insert" datasource="#variables.dsn#" result="result">
	        select * from TLU_Zones where  ID not in (select TZ_ZONE_ID from Project_Zones where TZ_PROJECT_ID =<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.PROJECT_ID#'>)
	    </cfquery>
		<cfreturn insert>
	</cffunction>
    <cffunction name="InsertZonesProjectBefore"  output="true" access="remote" returnformat='JSON'>
		<cfargument name="BeginZone" required="yes">
		<cfargument name="EndZone" required="yes">
        <cfquery name="zonelist_q" datasource="#variables.dsn#">
            SELECT TLU_Zones.[ZONE], Max (TLU_Zones.ID) as id FROM TLU_Zones 
            WHERE TLU_Zones.[ZONE] BETWEEN '#BeginZone#' AND '#EndZone#'
            GROUP BY TLU_Zones.[ZONE] order by TLU_Zones.[ZONE]
            </cfquery>
<!--- create array --->
		<cfset Arr = ArrayNew(1)>
<!---- if session already zonelsit--->
		<cfif isdefined("session.zone")>
			<cfloop from="1" to="#ArrayLen(session.zone)#" index="i">
				<cfset structofzone = StructNew() >
				<cfset structofzone["ID"] = session.zone[i].ID>
				<cfset structofzone["zone"] = session.zone[i].zone>
				<cfset ArrayAppend(Arr,structofzone)>
			</cfloop>
		</cfif>
<!--- loop through query --->
		<cfloop query="zonelist_q">
			<cfset structofzone = StructNew() >
			<cfset structofzone["ID"] = zonelist_q.ID>
			<cfset structofzone["zone"] = zonelist_q.ZONE>
			<cfset ArrayAppend(Arr,structofzone)>
		</cfloop>
		<cfset SESSION.zone = Arr >
		<cfreturn SESSION.zone>
	</cffunction>
    <cffunction name="InsertZonesProject"  output="true" access="remote"  returntype="any">
        <cfquery name="zonelist_q" datasource="#variables.dsn#">
            SELECT TLU_Zones.[ZONE], Max (TLU_Zones.ID) as id FROM TLU_Zones 
            WHERE TLU_Zones.[ZONE] BETWEEN '#form.BeginZone#' AND '#form.EndZone#'
            GROUP BY TLU_Zones.[ZONE] order by TLU_Zones.[ZONE]
            </cfquery>
        <cfloop query="zonelist_q">
<!------ checking zone already exist-------->
			<cfquery name="get" datasource="#variables.dsn#" result="result">
            select count(*) as COUNT from Project_Zones where  TZ_Project_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_ID#'> and TZ_Zone_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#zonelist_q.ID#'>
			</cfquery>
<!------ If not exist Enterd-------->
			<cfif get.COUNT EQ 0>
				<cfquery name="insert" datasource="#variables.dsn#" result="result">
                insert into Project_Zones (TZ_Project_ID,TZ_Zone_ID)values(
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#form.project_ID#'>,
                <cfqueryparam  cfsqltype="cf_sql_integer" value="#zonelist_q.ID#">);
      	     </cfquery>
			</cfif>
        </cfloop>
        <cfquery name="zonelist_show" datasource="#variables.dsn#">
            SELECT TLU_Zones.[ZONE],TLU_Zones.ID from TLU_Zones inner join Project_Zones on (Project_Zones.TZ_Zone_ID=TLU_Zones.ID) where Project_Zones.TZ_Project_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#form.project_ID#'>
		</cfquery>
		<cfoutput>#SerializeJSON(zonelist_show)#</cfoutput>
    </cffunction>
    <cffunction name="DeleteZoneBeforePro"  output="true" access="remote" returnFormat='JSON'>
		<cfargument name="zoneID" required="yes">
<!--- create array --->
		<cfset Arr = ArrayNew(1)>
        <cfloop from="1" to="#ArrayLen(session.zone)#" index="i">
			<cfif session.zone[i].ID NEQ zoneID>
				<cfset structofzone = StructNew() />
				<cfset structofzone["ID"] = session.zone[i].ID>
				<cfset structofzone["zone"] = session.zone[i].zone>
				<cfset ArrayAppend(Arr,structofzone)>
			</cfif>
		</cfloop>
		<cfset SESSION.zone = Arr >
		<cfreturn  SESSION.zone>
    </cffunction>
    <cffunction name="DeleteZoneproject"  output="true" access="remote"  returntype="any">
        <cfquery name="delete" datasource="#variables.dsn#">
            delete from Project_Zones where TZ_Project_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#url.id#'> and TZ_Zone_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value="#url.zoneID#">;
        </cfquery>
		<cfreturn true>
	</cffunction>
    <cffunction name="ZonesData"  output="true" access="remote"  returntype="any">
		<cfquery name="zonelist_q" datasource="#variables.dsn#">
            SELECT TLU_Zones.[ZONE],TLU_Zones.ID from TLU_Zones inner join Project_Zones on (Project_Zones.TZ_Zone_ID=TLU_Zones.ID) where 						            Project_Zones.TZ_Project_ID=<cfqueryparam  cfsqltype="cf_sql_integer" value='#url.id#'>
		</cfquery>
		<cfoutput>#SerializeJSON(zonelist_q)#</cfoutput>
    </cffunction>
    <cffunction name="sight_delete" access="public" returnformat="plain" output="true">
		<cfquery name="delete" datasource="#variables.dsn#">
            delete from SIGHTINGS where ID=#form.sighting_id# and Project_ID=#form.project_id#
		</cfquery>
	</cffunction>
    <cffunction name="getselectmember" returntype="any" output="false" access="public" >
		<cfquery name="qget" datasource="#variables.dsn#" >
            SELECT
            TLU_ResearchTeamMembers.RT_MemberName,
            TLU_ResearchTeamMembers.RT_ID,
            RESEARCHTEAMMEMBER_PROJECTS.PROJECT_ID,
            RESEARCHTEAMMEMBER_PROJECTS.PLATFORM_ID
            FROM
            TLU_ResearchTeamMembers
            INNER JOIN RESEARCHTEAMMEMBER_PROJECTS ON TLU_ResearchTeamMembers.RT_ID =RESEARCHTEAMMEMBER_PROJECTS.RESEARCHTEAMMEMBER_ID
            WHERE RESEARCHTEAMMEMBER_PROJECTS.PROJECT_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
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
              delete from RESEARCHTEAMMEMBER_PROJECTS where PROJECT_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#form.project_id#'>
		</cfquery>
		<cfparam name="FORM.ResearchTeam" default="">
		<cfif FORM.ResearchTeam NEQ '' >
			<cfloop index = "ListElement" list = "#ResearchTeam#">
				<cfquery name="update" datasource="#variables.dsn#" result="updating" >
                    insert into RESEARCHTEAMMEMBER_PROJECTS (PROJECT_ID,RESEARCHTEAMMEMBER_ID,PLATFORM_ID) values
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
                insert into RESEARCHTEAMMEMBER_PROJECTS (PROJECT_ID,RESEARCHTEAMMEMBER_ID,PLATFORM_ID) values
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
    <cffunction name="getdolphinBYSight" returntype="any" output="true" access="public">
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
              select SIGHTINGS.Begin_LAT_Dec, SIGHTINGS.Begin_LON_Dec ,year(SIGHTINGS.Date_Entered) as year, month(SIGHTINGS.Date_Entered) as month,DAY(SIGHTINGS.Date_Entered) as day,
              ct=(SELECT COUNT(SIGHTINGS.Project_ID)from SIGHTINGS where Project_ID = #project_id# )from SIGHTINGS where SIGHTINGS.ID = #sight_id#

          </cfquery>
          <cfquery name="showDolphinData" datasource="#variables.dsn#" result="showdol">
               select  DOLPHINS.Sex , year(DOLPHINS.YearOfBirth) as birth, year(DOLPHINS.[First Sighting Date]) as firstsight from DOLPHINS where ID = #dol_id#
          </cfquery>
          <cfquery name="lastsight" datasource="#variables.dsn#" result="showlast">
               select CONVERT(date, Date_Entered) as lastdate ,PROJECTS.Stock from SIGHTINGS INNER JOIN PROJECTS ON SIGHTINGS.Project_ID=PROJECTS.ID where SIGHTINGS.ID = #sight_id#
               order BY SIGHTINGS.ID  desc
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
		<!---Get FundingSource--->
		<cffunction name="getFundingSource" returntype="any" output="false" access="public" >
			<cfquery name="qgetFundingSource" datasource="#variables.dsn#"  >
				SELECT * from TLU_FundingSource <!---Where active = 1---> Order by name asc
			</cfquery>
			<cfreturn qgetFundingSource>
		</cffunction>
        
        <cffunction name="getDolphinsWithNoSightingsNoFilter" returntype="any" output="false" access="public" >
            <cfquery name="qgetDolphinsWithNoSightings" datasource="#variables.dsn#"  >
                SELECT DISTINCT
                    cs.SightingNumber,
                    cs.Sighting_ID,
                    cs.Species,
                    sr.SurveyType,
                    sr.Date,
                    sr.BodyOfWater,
                    ss.Project_ID ,
                    tlu.CetaceanSpeciesName
                FROM
                    Cetacean_Sightings cs
                    LEFT JOIN Survey_Sightings ss ON cs.Sighting_ID = ss.ID
                    LEFT JOIN Surveys sr ON ss.Project_ID = sr.ID
                    left join Cetaceans c ON cs.Cetaceans_ID= c.ID
                    left JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
                    where cs.EnteredBy = 0 or cs.PhotoAnalysisInitial = 0 or cs.PhotoAnalysisFinal = 0
                order by sr.Date DESC
            </cfquery>
			<cfreturn qgetDolphinsWithNoSightings>
		</cffunction>
        <cffunction name="getDolphinsWithNoSightings" returntype="any" output="false" access="public" >
            <cfif isdefined("Form.btnSearchSightings")>
            	<cfif isdefined("form.date") and form.date NEQ "">
					<cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
                    <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
                </cfif>
            </cfif>
			<cfif isdefined("form.photoReviewStatus")  and form.photoReviewStatus  eq "Sightings with NO Cetacean Sightings">
                <cfquery name="qgetDolphinsWithNoSightings" datasource="#variables.dsn#">
                    SELECT DISTINCT ss.ID,ss.SightingNumber,sr.SurveyType,sr.Date,sr.BodyOfWater,ss.Project_ID  
                    from Survey_Sightings ss
                    left JOIN Cetacean_Sightings cs ON cs.Sighting_ID = ss.ID
                    LEFT JOIN Surveys sr ON ss.Project_ID = sr.ID
                    WHERE cs.SightingNumber IS NULL
                    <cfif isdefined("form.bodyOfWater") and form.bodyOfWater neq ""> and sr.BodyOfWater like '%#trim(form.bodyOfWater)#%'</cfif>
                    <cfif isdefined("form.surveyType")  and form.surveyType  neq ""> and sr.SurveyType like '%#form.surveyType#%'</cfif>
                    <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), sr.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
                    order by sr.Date DESC
                </cfquery>
            <cfelse>
                <cfquery name="qgetDolphinsWithNoSightings" datasource="#variables.dsn#"  >

                    SELECT DISTINCT
                        cs.SightingNumber,
                        cs.Sighting_ID,
                        cs.Species,
                        sr.SurveyType,
                        sr.Date,
                        sr.BodyOfWater,
                        ss.Project_ID ,
                        tlu.CetaceanSpeciesName
                    FROM
                        Cetacean_Sightings cs
                        LEFT JOIN Survey_Sightings ss ON cs.Sighting_ID = ss.ID
                        LEFT JOIN Surveys sr ON ss.Project_ID = sr.ID
                        left join Cetaceans c ON cs.Cetaceans_ID= c.ID
                        left JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
                    <cfif form.photoReviewStatus eq "" and form.cetaceanSpecies eq "" and form.bodyOfWater eq "" and form.surveyType eq ""
                    and form.date eq "" >
                       where cs.EnteredBy = 0 or cs.PhotoAnalysisInitial = 0 or cs.PhotoAnalysisFinal = 0
                    <cfelse> 
                        WHERE 1=1
                        <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies neq ""> and tlu.CetaceanSpeciesName like '%#trim(form.cetaceanSpecies)#%'</cfif>
                        <cfif isdefined("form.bodyOfWater") and form.bodyOfWater neq ""> and sr.BodyOfWater like '%#trim(form.bodyOfWater)#%'</cfif>
                        <cfif isdefined("form.surveyType")  and form.surveyType  neq ""> and sr.SurveyType like '%#form.surveyType#%'</cfif>
                        <cfif isdefined("form.photoReviewStatus")  and form.photoReviewStatus  eq "To be Entered"> and cs.EnteredBy = 0</cfif>
                        <cfif isdefined("form.photoReviewStatus")  and form.photoReviewStatus  eq "To be Initial Reviewed"> and cs.PhotoAnalysisInitial = 0</cfif>
                        <cfif isdefined("form.photoReviewStatus")  and form.photoReviewStatus  eq "To be Final Reviewed"> and cs.PhotoAnalysisFinal = 0</cfif>
                        <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), sr.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
                     
                    </cfif>
                    order by sr.Date DESC
			    </cfquery>
            </cfif>
			<cfreturn qgetDolphinsWithNoSightings>
		</cffunction>
        <cffunction  name="getAreaName" returntype="any" output="false" access="public">
            <cfquery name="qgetAreaName" datasource="#variables.dsn#">
                    SELECT * 
                    from TLU_SurveyArea
                </cfquery>
                <cfreturn qgetAreaName>
        </cffunction>
        <cffunction name="insertFinFluke" returntype="any" output="false" access="public" >
           
           <cfparam name="BestImage" default="">
            <cfparam name="oldImage" default="">

            <cfparam name="SecondaryImage" default="">
            <cfparam name="SecOldImage" default="">

            <cfparam name="setPrimaryImage" default="">
            <cfparam name="setSecondaryImage" default="">

            <cfset setOldImage = "">
            <cfset setSecOldImage = "">
            <cfif isDefined('CetaceanCode') and CetaceanCode neq ''>

            <cfquery name="qcode" datasource="#variables.dsn#">
                SELECT Code FROM Cetaceans WHERE ID = #FORM.CetaceanId#
            </cfquery>

            <cfif len(trim(BestImage))>
                <cfif len(trim(oldImage)) AND setOldImage NEQ 'no-image.jpg'>
                     <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                       <cffile action = "delete" file = "#Application.CloudDirectory&setOldImage#">
                    </cfif>
                </cfif>

                <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
                <cfset setPrimaryImage =#FORM.CetaceanId#&"_"&#qcode.Code#&"_"&#returnBestImage.serverfile#>
                <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##setPrimaryImage#">
            <cfelse> 
               <cfset setPrimaryImage = setOldImage>
            </cfif>

            <cfif len(trim(SecondaryImage))>
                <cfif len(trim(SecOldImage)) AND setSecOldImage NEQ 'no-image.jpg'>
                    <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                        <cffile action = "delete" file = "#Application.CloudDirectory&setSecOldImage#">
                    </cfif>
                </cfif>

                <cffile action="upload" fileField="SecondaryImage" destination="#Application.CloudDirectory#" result="returnSecondaryImage" nameconflict="overwrite">
                <cfset setSecondaryImage =#Form.CetaceanId#&"_"&#qcode.Code#&"_"&#returnSecondaryImage.serverfile#>
                <cffile action = "rename" source = "#Application.CloudDirectory##returnSecondaryImage.serverfile#" destination = "#Application.CloudDirectory##setSecondaryImage#">
            <cfelse> 
               <cfset setSecondaryImage = setSecOldImage>
            </cfif>

           <cfquery name="qinsertFinFluke" datasource="#variables.dsn#" result ='getresult'>

           insert into Fin_Fluke 
            (
             Species,
             CetaceanId,
             DScore,
             Description,
             Date
             )
            values(
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Species#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.CetaceanId#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.DScore#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Description#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.DScoreDate#">
           )
            </cfquery>
            <cfquery name="update_cetacean" datasource="#variables.dsn#" result='get_res'>
                    update Cetaceans set
                     Dscore=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#'>
                     <cfif setPrimaryImage neq ''>
                     ,ImageName='#setPrimaryImage#'
                     </cfif>
                      <cfif setSecondaryImage neq ''>
                      ,SecondaryImage='#setSecondaryImage#'
                     </cfif>
                     
                    where ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.CetaceanId#'>
            </cfquery>
            <cfreturn '1'>
        <cfelse>
            <cfreturn '0'>
        </cfif>


        </cffunction>

        <cffunction name="getFin_Fluke" returntype="any" output="true" access="remote" >
           
            <cfargument name="species_ID" type="any" required="true" default="" >
             <cfargument name="cetacean_ID" type="any" required="true" default="empty">
          <!---     <cfdump var="#cetacean_ID#">
            <cfabort> --->
            <cfquery name="qgetFin_Fluke" datasource="#variables.dsn#">
                SELECT
                Fin_Fluke.ID,
                Fin_Fluke.Date,
                Fin_Fluke.Species,
                Fin_Fluke.DScore,
                Fin_Fluke.description,
                Fin_Fluke.CetaceanId,
                Cetaceans.Code,
                Cetaceans.Name
                FROM
                Fin_Fluke
                INNER JOIN Cetaceans ON Fin_Fluke.CetaceanId = Cetaceans.ID 
                WHERE
                Species = #species_ID# 
                <cfif cetacean_ID neq ''>
                <cfif cetacean_ID neq 'empty'>
                    AND  CetaceanId = #cetacean_ID#
                </cfif>
                </cfif>
            </cfquery>
          <!---   <cfdump var="#qgetFin_Fluke#"> --->
            <cfset c=0>
            <cfoutput><cfset  permissions ="#session['userdetails']['permissions']#"></cfoutput>
            <cfloop query="qgetFin_Fluke">
                <cfquery name="qgetDescription" datasource="#variables.dsn#">
                 SELECT * From NFIN_Description where id = #qgetFin_Fluke.description#
                </cfquery>
                 <cfset c=c+1>
                <tr class="gradeU_#qgetFin_Fluke.ID#">
                    <td>#qgetFin_Fluke.CetaceanId#</td>
                    <td>#qgetFin_Fluke.ID#</td>
                    <td>#qgetFin_Fluke.Code#</td>
                    <td>#DateFormat(qgetFin_Fluke.Date, "mm/dd/yyyy")#</td>
                    <td>#qgetFin_Fluke.DScore#</td>
                    <td>#qgetDescription.Description#</td>
                    <td> <button class="btn btn-xs btn-primary update" <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0 > onclick="updateRecord(#qgetFin_Fluke.ID#)"</cfif>><i class="fa fa-pencil-square-o"></i></button> &nbsp; &nbsp;&nbsp;&nbsp; <button class="btn btn-xs btn-primary" <cfif permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0 > onclick="deleteRecord(#qgetFin_Fluke.ID#)"</cfif>><i class="glyphicon glyphicon-trash"></i></button></td>
                </tr>
            </cfloop>
        </cffunction>

        <cffunction name="getFin_Fluke_Cetacean_Codes" returntype="any" output="true" access="remote" >
           
            <cfargument name="species_ID" type="any" required="true" default="" >
            <cfargument name="cetacean_ID" type="any" required="true" default="empty">
         
            <cfquery name="qgetFin_Fluke" datasource="#variables.dsn#">
                SELECT
                    Cetaceans.ID,
                    Cetaceans.Code,
                    Cetaceans.Name,
                    Cetaceans.Sex,
                    Cetaceans.CetaceanSpecies,
                    TLU_CetaceanSpecies.CetaceanSpeciesName
                FROM
                    Cetaceans
                INNER JOIN TLU_CetaceanSpecies ON TLU_CetaceanSpecies.ID = Cetaceans.CetaceanSpecies
                where Cetaceans.CetaceanSpecies = #species_ID#
                ORDER BY Cetaceans.Code
            </cfquery>
           
            <option value="">Select Cetaceans</option>
            <cfloop query="qgetFin_Fluke">
                <option value="#trim(qgetFin_Fluke.ID)# #trim(qgetFin_Fluke.Name)#">  #qgetFin_Fluke.Code#</option>
            </cfloop>
        
        </cffunction>

        <cffunction name="deleteFin_Fluke" returntype="any" output="false" access="remote" >
            <cfargument name="fin_flukeId" type="any" required="true" default="">
            <cfquery name="qdeleteFin_Fluke" datasource="#variables.dsn#">
                DELETE FROM Fin_Fluke  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#fin_flukeId#' >
            </cfquery>
        </cffunction>

        <cffunction name="updateFin_Fluke" returntype="any" output="false" access="remote" >
            <cfargument name="fin_flukeId" type="any" required="true" default="">
            <cfargument name="description" type="any" required="true" default="">
            <cfquery name="qupdateFin_Fluke" datasource="#variables.dsn#">
                UPDATE Fin_Fluke SET  description = <cfqueryparam cfsqltype="cf_sql_integer" value='#description#' >
                WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#fin_flukeId#' >
            </cfquery>
        </cffunction>

        <cffunction name="getFin_Fluke_Dscore" returntype="any" output="true" access="public" >
           
            <cfargument name="date_cs" type="any" required="true" default="">
            <cfargument name="CetaceanId" type="any" required="true" default="">
            <cfargument name="Cetacean_Species_id" type="any" required="true" default="">
            <!--- <cfdump var="#date_cs#">
            <cfabort> --->
            <cfquery name="qgetFin_Fluke_Dscore" datasource="#variables.dsn#">
                SELECT top 1
                Fin_Fluke.DScore
                FROM
                Fin_Fluke
                WHERE date = '#date_cs#' and  CetaceanId= #CetaceanId# and Species= #Cetacean_Species_id# order by ID DESC
                
            </cfquery>
            <cfreturn qgetFin_Fluke_Dscore>
        </cffunction>


        <cffunction name="getCetaceanImage" access="remote"  output="false" returnformat="JSON">
            <cfargument name="cetacean_id" type="any" required="true" default="" >
            <cfquery name="getCetacean" datasource="#variables.dsn#">
                select ImageName,SecondaryImage from Cetaceans
                where ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#cetacean_id#">
            </cfquery>

            <cfset setPrimaryImage  = '#Application.CloudRoot#no-image.jpg'>
            <cfset setSecondaryImage  = '#Application.CloudRoot#no-image.jpg'>

            <cfset PrimaryImage = "#getCetacean.ImageName#">
            <cfset SecondaryImage = "#getCetacean.SecondaryImage#">


            <cfif FileExists('#Application.CloudDirectory##PrimaryImage#')>
                <cfset  setPrimaryImage = '#Application.CloudRoot##PrimaryImage#'>
            </cfif> 

            <cfif FileExists('#Application.CloudDirectory##SecondaryImage#')>
                <cfset  setSecondaryImage  = '#Application.CloudRoot##SecondaryImage#'>
            </cfif>


            <cfset output={'setPrimaryImage':setPrimaryImage,'SecondaryImage':setSecondaryImage}>

            <cfreturn  output>
        </cffunction>

         <cffunction name="getSecuritySetting" returntype="any" output="true" access="public" >
           
           <!---  <cfargument name="ID" type="any" required="true" default="0"> --->
            <!--- <cfdump var="#date_cs#">
                 WHERE ID= #ID# order by ID asc
            <cfabort> --->
            <cfquery name="qgetSecuritySetting" datasource="#variables.dsn#">
                SELECT *
                FROM
                Security_Settings
            </cfquery>
            <cfreturn qgetSecuritySetting>
        </cffunction>

        <cffunction name="getUserTypeSecuritySetting" returntype="any" output="true" access="public" >
            <cfargument name="userType" type="any" required="true" default="0">
            <cfset securityStruct = structNew()>
            <cfif #userType# neq "Super Admin">
                <cftry>
                    <cfquery name="qgetUserTypeSecuritySetting" datasource="#variables.dsn#">
                        SELECT
                            ID,
                            permission_name
                        FROM
                            Security_Settings
                        WHERE
                            #userType# LIKE '%#userType#%'
                    </cfquery>
                    <cfcatch>
                        <cfdump var="#cfcatch#">
                        <cfabort>
                    </cfcatch>
                </cftry>
                
<!---                 <cfloop query="qgetUserTypeSecuritySetting"> 
                    <cfif permission_name eq "Add Entry Data">
                        <cfset securityStruct.dataEntry = "#permission_name#">
                    <cfelseif permission_name eq "Delete S-S-C" >
                        <cfset securityStruct.delete_SSC = "#permission_name#">
                    <cfelseif permission_name eq "Add/Update M-D">
                        <cfset securityStruct.add_update_MD = "#permission_name#">
                    <cfelseif  permission_name eq "Add/Update S-S-C">
                        <cfset securityStruct.add_update_SSC = "#permission_name#">
                    <cfelseif permission_name eq "Add/Update/Delete U-G">
                        <cfset securityStruct.add_update_delete_UG = "#permission_name#">
                    </cfif>
                </cfloop>--->
                <cfset securityStruct.permissions = valueList(qgetUserTypeSecuritySetting.permission_name)>
                <cfreturn securityStruct>
            <cfelse>
                <cfset securityStruct.permissions = "full_access">
                <cfreturn securityStruct>
            </cfif>
        </cffunction>

         <cffunction name="getSettinginfo" returntype="any" output="true" access="public" >
           
            <cfargument name="ID" type="any" required="true" default="0">
            <!--- <cfdump var="#date_cs#">
                 WHERE ID= #ID# order by ID asc
            <cfabort> --->
            <cfquery name="qgetSettinginfo" datasource="#variables.dsn#">
                SELECT *
                FROM
                Security_Settings where ID = #ID#
            </cfquery>
            <cfreturn qgetSettinginfo>
        </cffunction>


         <cffunction name="UpdateSecuritySetting" returntype="any" output="true" access="public" >
           
           <cfset administrators=0>
           <cfset team_members=0>
           <cfset volunteers_inter=0>
           <cfset collaborator_guest=0>
           <cfset vet_assistant=0>
           <cfset photoIDAdministrator=0>
            <cfoutput>
            <cfloop index="i" from="1" to="11">
                
                <cfif isDefined('form.administrators')>
                    <cfif listFind('#form.administrators#',i)>
                        <cfset administrators='administrators'>
                    <cfelse>
                        <cfset administrators=0>
                    </cfif>    
                </cfif>    
                
                <cfif isDefined('form.team_members')>
                    <cfif listFind('#form.team_members#',i)>
                        <cfset team_members='team_members'>
                    <cfelse>
                        <cfset team_members=0>
                    </cfif>    
                </cfif>
                <cfif isDefined('form.vet_assistant')>
                    <cfif listFind('#form.vet_assistant#',i)>
                        <cfset vet_assistant='vet_assistant'>
                    <cfelse>
                        <cfset vet_assistant=0>
                    </cfif>    
                </cfif>

                <cfif isDefined('form.volunteers')>
                    <cfif listFind('#form.volunteers#',i)>
                        <cfset volunteers='volunteers'>
                    <cfelse>
                        <cfset volunteers=0>
                    </cfif>    
                </cfif>   
                <cfif isDefined('form.photoIDAdministrator')>
                    <cfif listFind('#form.photoIDAdministrator#',i)>
                        <cfset photoIDAdministrator='photoIDAdministrator'>
                    <cfelse>
                        <cfset photoIDAdministrator=0>
                    </cfif>    
                </cfif>   

                <cfif isDefined('form.collaborator_guest')>
                    <cfif listFind('#form.collaborator_guest#',i)>
                        <cfset collaborator_guest='collaborator_guest'>
                    <cfelse>
                        <cfset collaborator_guest=0>
                    </cfif>    
                </cfif>

                <cfquery name="query" datasource="#variables.dsn#" result="return_data">
                    UPDATE Security_Settings SET administrators = '#administrators#', team_members = '#team_members#',vet_assistant = '#vet_assistant#', volunteers = '#volunteers#',photoIDAdministrator = '#photoIDAdministrator#', collaborator_guest = '#collaborator_guest#' where ID = #i#
                </cfquery>
            </cfloop>
            </cfoutput>
       
        </cffunction>

        <cffunction name="insertPermanentScar" returntype="any" output="false" access="public" >
           
            <cfparam name="BestImage" default="">
             <cfparam name="oldImage" default="">
 
             <cfparam name="SecondaryImage" default="">
             <cfparam name="SecOldImage" default="">
 
             <cfparam name="setPrimaryImage" default="">
             <cfparam name="setSecondaryImage" default="">
 
             <cfset setOldImage = "">
             <cfset setSecOldImage = "">
            <cfif isDefined('CetaceanCode') and CetaceanCode neq ''>
                <cfif len(trim(BestImage))>
                    <cfif len(trim(oldImage)) AND setOldImage NEQ 'no-image.jpg'>
                        <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                        <cffile action = "delete" file = "#Application.CloudDirectory&setOldImage#">
                        </cfif>
                    </cfif>

                    <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
                    <cfset setPrimaryImage =#returnBestImage.serverfile#>
                    <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##setPrimaryImage#">
                <cfelse> 
                <cfset setPrimaryImage = setOldImage>
                </cfif>

                <cfif len(trim(SecondaryImage))>
                    <cfif len(trim(SecOldImage)) AND setSecOldImage NEQ 'no-image.jpg'>
                        <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&setSecOldImage#">
                        </cfif>
                    </cfif>

                    <cffile action="upload" fileField="SecondaryImage" destination="#Application.CloudDirectory#" result="returnSecondaryImage" nameconflict="overwrite">
                    <cfset setSecondaryImage =#returnSecondaryImage.serverfile#>
                    <cffile action = "rename" source = "#Application.CloudDirectory##returnSecondaryImage.serverfile#" destination = "#Application.CloudDirectory##setSecondaryImage#">
                <cfelse> 
                <cfset setSecondaryImage = setSecOldImage>
                </cfif>

                <cfif NOT isDefined('FORM.ScarType')>
                    <cfset FORM.ScarType = "">
                </cfif>
                <cfif NOT isDefined('FORM.BodyRegion')>
                    <cfset FORM.BodyRegion = "">
                </cfif>
                
                <cfquery name="qinsertPermanentScar" datasource="#variables.dsn#" result ='getresult'>
    
                    insert into PermanentScar 
                    (
                    Species,
                    CetaceanCode,
                    CetaceanName,
                    CetaceanId,
                    ScarDate,
                    ScarType,
                    BodyRegion,
                    SideOfBody,
                    PrimaryImage,
                    SecondryImage  

                    )
                    values(
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Species#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(Form.CetaceanCodeValue)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.CetaceanName#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.CetaceanId#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#FORM.ScarDate#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.ScarType#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.BodyRegion#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.SideOfBody#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#setPrimaryImage#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#setSecondaryImage#">

                    )
                </cfquery>
                <cfreturn true>
            </cfif>
             <!--- <cfdump var="test" abort="true"> --->
             <!--- <cfif isDefined('CetaceanCode') and CetaceanCode neq ''>
 
             <cfquery name="qcode" datasource="#variables.dsn#">
                 SELECT Code FROM Cetaceans WHERE ID = #FORM.CetaceanId#
             </cfquery>
 
             <cfif len(trim(BestImage))>
                 <cfif len(trim(oldImage)) AND setOldImage NEQ 'no-image.jpg'>
                      <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                        <cffile action = "delete" file = "#Application.CloudDirectory&setOldImage#">
                     </cfif>
                 </cfif>
 
                 <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
                 <cfset setPrimaryImage =#FORM.CetaceanId#&"_"&#qcode.Code#&"_"&#returnBestImage.serverfile#>
                 <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##setPrimaryImage#">
             <cfelse> 
                <cfset setPrimaryImage = setOldImage>
             </cfif>
 
             <cfif len(trim(SecondaryImage))>
                 <cfif len(trim(SecOldImage)) AND setSecOldImage NEQ 'no-image.jpg'>
                     <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                         <cffile action = "delete" file = "#Application.CloudDirectory&setSecOldImage#">
                     </cfif>
                 </cfif>
 
                 <cffile action="upload" fileField="SecondaryImage" destination="#Application.CloudDirectory#" result="returnSecondaryImage" nameconflict="overwrite">
                 <cfset setSecondaryImage =#Form.CetaceanId#&"_"&#qcode.Code#&"_"&#returnSecondaryImage.serverfile#>
                 <cffile action = "rename" source = "#Application.CloudDirectory##returnSecondaryImage.serverfile#" destination = "#Application.CloudDirectory##setSecondaryImage#">
             <cfelse> 
                <cfset setSecondaryImage = setSecOldImage>
             </cfif>
 
            <cfquery name="qinsertFinFluke" datasource="#variables.dsn#" result ='getresult'>
 
            insert into Fin_Fluke 
             (
              Species,
              CetaceanId,
              DScore,
              Description,
              Date
              )
             values(
             <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Species#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.CetaceanId#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.DScore#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Description#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.DScoreDate#">
            )
             </cfquery>
             <cfquery name="update_cetacean" datasource="#variables.dsn#" result='get_res'>
                     update Cetaceans set
                      Dscore=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#'>
                      <cfif setPrimaryImage neq ''>
                      ,ImageName='#setPrimaryImage#'
                      </cfif>
                       <cfif setSecondaryImage neq ''>
                       ,SecondaryImage='#setSecondaryImage#'
                      </cfif>                      
                     where ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.CetaceanId#'>
             </cfquery>
             <cfreturn '1'>
         <cfelse>
             <cfreturn '0'>
         </cfif> --->
 
 
         </cffunction>
         <cffunction name="UpdatePermanentScar" returntype="any" output="false" access="public" >
           

            <!--- <cfdump var="#form.updateFormID#" abort="true"> --->
            <cfparam name="BestImage" default="">
             <cfparam name="oldImage" default="">
 
             <cfparam name="SecondaryImage" default="">
             <cfparam name="SecOldImage" default="">
 
             <cfparam name="setPrimaryImage" default="">
             <cfparam name="setSecondaryImage" default="">
 
             <cfset setOldImage = "">
             <cfset setSecOldImage = "">

             <cfif len(trim(BestImage))>
                <cfif len(trim(oldImage)) AND setOldImage NEQ 'no-image.jpg'>
                     <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                       <cffile action = "delete" file = "#Application.CloudDirectory&setOldImage#">
                    </cfif>
                </cfif>

                <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
                <cfset setPrimaryImage =#returnBestImage.serverfile#>
                <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##setPrimaryImage#">
            <cfelse> 
               <cfset setPrimaryImage = setOldImage>
            </cfif>

            <cfif len(trim(SecondaryImage))>
                <cfif len(trim(SecOldImage)) AND setSecOldImage NEQ 'no-image.jpg'>
                    <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                        <cffile action = "delete" file = "#Application.CloudDirectory&setSecOldImage#">
                    </cfif>
                </cfif>

                <cffile action="upload" fileField="SecondaryImage" destination="#Application.CloudDirectory#" result="returnSecondaryImage" nameconflict="overwrite">
                <cfset setSecondaryImage =#returnSecondaryImage.serverfile#>
                <cffile action = "rename" source = "#Application.CloudDirectory##returnSecondaryImage.serverfile#" destination = "#Application.CloudDirectory##setSecondaryImage#">
            <cfelse> 
               <cfset setSecondaryImage = setSecOldImage>
            </cfif>
            <cfif NOT isDefined('FORM.ScarType')>
                <cfset FORM.ScarType = "">
            </cfif>
            <cfif NOT isDefined('FORM.BodyRegion')>
                <cfset FORM.BodyRegion = "">
            </cfif>
            <cfquery name="qinsertPermanentScar" datasource="#variables.dsn#" result ='getresult'>    
               UPDATE PermanentScar SET
               CetaceanCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(Form.CetaceanCodeValue)#" >,
               CetaceanName=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.CetaceanName#' >,
               CetaceanId=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.CetaceanId#' >,
               ScarDate=<cfqueryparam  cfsqltype="cf_sql_date" value='#Form.ScarDate#' >,
               ScarType=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.ScarType#' >,
               BodyRegion=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.BodyRegion#' >,
               <cfif len(trim(BestImage))>
               PrimaryImage=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#setPrimaryImage#' >,
               </cfif>
               <cfif len(trim(SecondaryImage))>
               SecondryImage=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#setSecondaryImage#' >,
               </cfif>
               SideOfBody=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#Form.SideOfBody#' >

                WHERE id = '#form.updateFormID#'
   
            </cfquery>
            <cfreturn true>
    
         </cffunction>

         <cffunction name="getPermanentScar" returntype="any" output="true" access="remote" >
           
            <cfargument name="species_ID" type="any" required="true" default="" >
             <cfargument name="cetacean_ID" type="any" required="true" default="empty">
          <!---     <cfdump var="#cetacean_ID#">
            <cfabort> --->
            <cfquery name="qgetPermanentScar" datasource="#variables.dsn#">
                SELECT PermanentScar.*, 
                       (SELECT STRING_AGG(TLU_ScarType.ScarTypeName, ', ') 
                        FROM TLU_ScarType 
                        WHERE CHARINDEX(',' + CAST(TLU_ScarType.ID AS VARCHAR) + ',', ',' + PermanentScar.ScarType + ',') > 0) AS ScarTypeNames
                FROM PermanentScar
                WHERE PermanentScar.Species = <cfqueryparam value="#species_ID#" cfsqltype="CF_SQL_INTEGER">
                <cfif isDefined('cetacean_ID') AND trim(cetacean_ID) neq '' AND trim(cetacean_ID) neq 'empty'>
                    AND PermanentScar.CetaceanId = <cfqueryparam value="#cetacean_ID#" cfsqltype="CF_SQL_INTEGER">
                </cfif>
            </cfquery>
                       <!--- <cfdump var="#qgetPermanentScar#" abort="true"> --->
            <cfset c=0>
            <cfoutput><cfset  permissions ="#session['userdetails']['permissions']#"></cfoutput>
            <cfloop query="qgetPermanentScar">
                <cfset c=c+1>
                <tr class="gradeU_#qgetPermanentScar.ID#">
                    <td id="CI_#qgetPermanentScar.ID#">#qgetPermanentScar.CetaceanId#</td>
                    <td id="CetaceanCode_#qgetPermanentScar.ID#">#qgetPermanentScar.CetaceanCode#</td>
                    <td id="ScarDate_#qgetPermanentScar.ID#">#DateFormat(qgetPermanentScar.ScarDate, "mm/dd/yyyy")#</td>
                    <td id="ScarType_#qgetPermanentScar.ID#">#qgetPermanentScar.ScarTypeNames#</td>
                    <td id="BodyRegion_#qgetPermanentScar.ID#">#qgetPermanentScar.BodyRegion#</td>
                    <td id="SideOfBody_#qgetPermanentScar.ID#">#qgetPermanentScar.SideOfBody#</td>
                    <td>
                        <cfif qgetPermanentScar.PrimaryImage neq ''>
                            <cfset setPrimaryImage=qgetPermanentScar.PrimaryImage>
                        <cfelse>
                            <cfset setPrimaryImage='no-image.jpg'>
                        </cfif>
                        <cfif qgetPermanentScar.SecondryImage neq ''>
                            <cfset setSecondaryImage=qgetPermanentScar.SecondryImage>
                        <cfelse>
                            <cfset setSecondaryImage='no-image.jpg'>
                        </cfif>
                        <img id="PrimaryImage_#qgetPermanentScar.ID#" src="#Application.CloudRoot##setPrimaryImage#"  style="max-width: 25%;">
                        <img id="SecondryImage_#qgetPermanentScar.ID#" src="#Application.CloudRoot##setSecondaryImage#"  style="max-width: 25%;">
                    </td>
                    <!--- <td>#qgetPermanentScar.PrimaryImage#,#qgetPermanentScar.SecondryImage#</td> --->
                    <td> <button class="btn btn-xs btn-primary update" <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0 > onclick="updateRecord(#qgetPermanentScar.ID#)"</cfif>><i class="fa fa-pencil-square-o"></i></button> &nbsp; &nbsp;&nbsp;&nbsp; <button class="btn btn-xs btn-primary" <cfif permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0 > onclick="deleteRecord(#qgetPermanentScar.ID#)"</cfif>><i class="glyphicon glyphicon-trash"></i></button></td>
                </tr>
            </cfloop>
        </cffunction>
        <!--- <cfset setPrimaryImage  = '#Application.CloudRoot#no-image.jpg'>
        <cfset setSecondaryImage  = '#Application.CloudRoot#no-image.jpg'>

        <cfset PrimaryImage = "#getCetacean.ImageName#">
        <cfset SecondaryImage = "#getCetacean.SecondaryImage#">


        <cfif FileExists('#Application.CloudDirectory##PrimaryImage#')>
            <cfset  setPrimaryImage = '#Application.CloudRoot##PrimaryImage#'>
        </cfif> 

        <cfif FileExists('#Application.CloudDirectory##SecondaryImage#')>
            <cfset  setSecondaryImage  = '#Application.CloudRoot##SecondaryImage#'>
        </cfif>


        <cfset output={'setPrimaryImage':setPrimaryImage,'SecondaryImage':setSecondaryImage}>

        <cfreturn  output> --->
        <cffunction name="deletePermanentScar" returntype="any" output="false" access="remote" >
            <cfargument name="Id" type="any" required="true" default="">
            <cfquery name="qdeleteFin_Fluke" datasource="#variables.dsn#">
                DELETE FROM PermanentScar  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#Id#' >
            </cfquery>
        </cffunction>

</cfcomponent>