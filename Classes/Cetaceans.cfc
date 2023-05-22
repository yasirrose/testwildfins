<cfcomponent>
    <cfheader name="Access-Control-Allow-Origin" value="*" />
    <cfset variables.dsn = "wildfins_new">
    <cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
      <cfargument name="dsn" type="string" required="true" hint="datasource">
      <cfset variables.dsn = arguments.dsn>
      <cfreturn this>
    </cffunction>
<!--- Get YOB Source --->
    <cffunction name="get_YOB_Source" returntype="any" output="false" access="public" >
        <cfquery name="getYOBSource" datasource="#variables.dsn#"  >
        SELECT * FROM TLU_YOB_Source
        </cfquery>
        <cfreturn getYOBSource>
    </cffunction>
    
<!--- Get get_CetaceanList--->
    <cffunction name="get_CetaceanList" returntype="any" output="false" access="public" >
            <cfquery name="getCetacean" datasource="#variables.dsn#"  >
                <cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
                    SELECT
                    Cetaceans.ID,
                    Cetaceans.Code,
                    Cetaceans.Name,
                    Cetaceans.Sex,
                    Cetaceans.CetaceanSpecies,
                    TLU_CetaceanSpecies.CetaceanSpeciesName
                    FROM Cetaceans
                    left join TLU_CetaceanSpecies on TLU_CetaceanSpecies.ID=Cetaceans.CetaceanSpecies
                    where Cetaceans.Name LIKE '%#form.searchword#%' OR Cetaceans.Code LIKE  '%#form.searchword#%' OR TLU_CetaceanSpecies.CetaceanSpeciesName LIKE  '%#form.searchword#%'
                    order by Cetaceans.Code
                <cfelse>
                    SELECT 
                    Cetaceans.ID,
                    Cetaceans.Code,
                    Cetaceans.Name,
                    Cetaceans.Sex,
                    Cetaceans.CetaceanSpecies,
                    TLU_CetaceanSpecies.CetaceanSpeciesName
                    FROM Cetaceans
                    left join TLU_CetaceanSpecies on TLU_CetaceanSpecies.ID=Cetaceans.CetaceanSpecies
                    order by Cetaceans.Code
                </cfif>
            </cfquery>
            <cfreturn getCetacean>
    </cffunction>

    <cffunction name="getDscoreDropdown" output="TRUE" returntype="any" access="public">
        <cfquery name="getDscoreDropdown" datasource="#variables.dsn#" result="get_dscore_value">
	    SELECT * FROM TLU_Dscore
        </cfquery>
        <cfreturn getDscoreDropdown>
    </cffunction>

     <cffunction name="add_cetaceans" access="remote" returnformat="plain" output="true">
		<cfoutput>
            <cfparam name="Form.BestImage" default="">
            <cfparam name="Form.SecondaryImage" default="">
            <cfquery name="insert_cetaceans" datasource="#variables.dsn#" result='get_res'>
               insert into Cetaceans (
                    Name,Code,Sex,SourceSexed,
                    DateOfBirthEstimate,YearOfBirth,SourceYOB,FirstSightingDate,DateDeath,
                    PresumedDead,Dead,CetaceanSpecies,Dscore,
                    FB_Number,HUBBS_ID,Field_ID,Lineage,Mother,HBOCI_CODE
                    )
					Values(
						<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Name#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Code#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Sex#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.SourceSexed#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Date_of_Birth_EST#' null="#IIF(Form.Date_of_Birth_EST EQ "", true, false)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.YearOfBirth#'>,
                        <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.Source_YOB#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.First_Sighting_Date#' null="#IIF(Form.First_Sighting_Date EQ "", true, false)#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Date_of_Death#' null="#IIF(Form.Date_of_Death EQ "", true, false)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.PresumedDead#'>,
                        <cfqueryparam cfsqltype="CF_SQL_TINYINT" value='#Form.Dead#'>,
                        <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.CetaceanSpecies#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FB_Number#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HUBBS_ID#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Field_ID#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Lineage#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Mother#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Previous_HBOCI_CODE#'>
                        )
            </cfquery>
            
             <cfquery name="getEnterdID" datasource="#variables.dsn#">
                SELECT ID, Code , FirstSightingDate AS DDATE FROM Cetaceans WHERE Code = '#Form.Code#' order by ID DESC
            </cfquery>

            <!---    Upload and save images  --->
            <cfif len(trim(BestImage))>
                <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
                <cfset reName = #getEnterdID.ID#&"_"&#replaceNoCase(replaceNoCase(getEnterdID.Code,"/","_","all"),"\","_","all")#&"_"&#returnBestImage.serverfile#>
                <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##reName#">
                <cfquery name="update_cetaceans_image"datasource="#variables.dsn#">
                    UPDATE Cetaceans
                    SET ImageName = '#reName#'
                    WHERE ID = #getEnterdID.ID#
                </cfquery>
            </cfif>
            <cfif len(trim(SecondaryImage))>
                <cffile action="upload" fileField="SecondaryImage" destination="#Application.CloudDirectory#" result="returnSecondaryImage" nameconflict="overwrite">
                <cfset reName = #getEnterdID.ID#&"_"&#replaceNoCase(replaceNoCase(getEnterdID.Code,"/","_","all"),"\","_","all")#&"_"&#returnSecondaryImage.serverfile#>
                <cffile action = "rename" source = "#Application.CloudDirectory##returnSecondaryImage.serverfile#" destination = "#Application.CloudDirectory##reName#">
                <cfquery name="update_cetaceans_image"datasource="#variables.dsn#">
                    UPDATE Cetaceans
                    SET SecondaryImage = '#reName#'
                    WHERE ID = #getEnterdID.ID#
                </cfquery>
            </cfif>

            <cfif get_res.RECORDCOUNT eq 1>
                <div class="alert alert-success">
                    <strong>Success!</strong> Cetaceans Added.
                </div>
			<cfelse>
                <div class="alert alert-danger">
                    <strong>Error!</strong> Insertion Failed.
                </div>
			</cfif>
        </cfoutput>
	</cffunction>

    <!--- delete_cetacean_image--->
    <cffunction name="delete_cetacean_image" access="remote" returnformat="plain" output="true">
            <cfargument name="ID" type="any" />
            <cfargument name="isPrimaryImage" type="any" />
            <cfargument name="bestImageName" type="any" />

            <cfquery name="deleteImage" datasource="#variables.dsn#" result='get_res'>
                UPDATE Cetaceans
                    <cfif #isPrimaryImage# EQ "1">
                        SET ImageName = ''
                    <cfelse>
                        SET SecondaryImage = ''
                    </cfif>
                    WHERE ID = #ID#
            </cfquery>
             <cfif get_res.RECORDCOUNT eq 1>
                <cfif FileExists("#Application.CloudDirectory#/#bestImageName#")>
                    <cffile action="delete" file="#Application.CloudDirectory#/#bestImageName#">
                 </cfif>
                <div class="alert alert-success">
                    <strong>Success!</strong> Cetaceans Image Delete.
                </div>
			<cfelse>
                <div class="alert alert-danger">
                    <strong>Error!</strong> Cetaceans Image Delete Failed.
                </div>
			</cfif>
	</cffunction>

    
 <!--- add cetaceans sighting--->
    <cffunction name="add_cetaceans_sighting" access="remote" returnformat="plain" output="true">
     <cftry>
        <cfoutput>
            <cfparam name="update_cs_Id" default="0">
			<cfparam name="SDR" default="off">
            <cfparam name="bestSighting" default="off">
            <cfparam name="wMom" default="off">
            <cfparam name="Fetals" default="off">
            <cfparam name="Calf" default="off">
            <cfparam name="Yoy" default="off">
            <cfparam name="wMomDropDown" default="">
	        <cfparam name="BestImage" default="">
            <cfparam name="primaryOldImage" default="">
            <cfparam name="SecondaryImage" default="">
            <cfparam name="SecondaryOldImage" default="">
	        <cfparam name="Note" default="">
            <cfparam name="species" default="">
            <cfparam name="set_cetacean_code" default="">
            <cfparam name="FB_Number" default="">
            <cfparam name="EnteredBy" default="">
            <cfparam name="PhotoAnalysisInitial" default="0">
            <cfparam name="PhotoAnalysisFinal" default="0">
            <cfparam name="Sex" default="">
            <cfparam name="Sighting_ID" default="0">
            <cfparam name="SightingNumber" default="">
            <cfparam name="Qscore" default="">
            <cfparam name="pq_focus" default="0">
            <cfparam name="pq_Angle" default="0">
            <cfparam name="pq_Contrast" default="0">
            <cfparam name="pq_Proportion" default="0">
            <cfparam name="pq_Partial" default="0">
            <cfparam name="pqSum" default="0">
            
            <cfset DSCOREDATE = Now()>
            <cfset setImagePrimary = "">
            <cfset setImageSecondary = "">


            <cfif #update_cs_Id# EQ 0>
                <!---    Upload and save images  --->
                <cfif len(trim(BestImage))>
                    <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
                    <cfset reNamePrimary = "#Sighting_ID#(CS)_#DateFormat(DSCOREDATE,'yyyy_mm_dd_HH_ss')#_#returnBestImage.SERVERFILE#">
                    <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##reNamePrimary#">
                    <cfset setImagePrimary = reNamePrimary>
                </cfif>

                <cfif len(trim(SecondaryImage))>
                    <cffile action="upload" fileField="SecondaryImage" destination="#Application.CloudDirectory#" result="returnSecondaryImage" nameconflict="overwrite">
                    <cfset reNameSecondary = "#Sighting_ID#(CS)_#DateFormat(DSCOREDATE,'yyyy_mm_dd_HH_ss')#_#returnSecondaryImage.SERVERFILE#">
                    <cffile action = "rename" source = "#Application.CloudDirectory##returnSecondaryImage.serverfile#" destination = "#Application.CloudDirectory##reNameSecondary#">
                    <cfset setImageSecondary = reNameSecondary>
                </cfif>

                <cfquery name="insert_cetacean_Sight" datasource="#variables.dsn#" result='get_res'>
                    insert into Cetacean_Sightings (
                    Sighting_ID,
                    Cetaceans_ID,
                    pq_focus,
                    pq_Angle,
                    pq_Contrast,
                    pq_Proportion,
                    pq_Partial,
                    pqSum,
                    SDR,
                    Species,
                    bestSighting,
                    EnteredBy,
                    PhotoAnalysisInitial,
                    PhotoAnalysisFinal,
                    Note,
                    Fetals,
                    Calf,
                    Yoy,
                    BestImageLeft,
                    BestImageRight,
                    wMom,
                    wMomDropDown,
                    BestShot,
                    SightingNumber,
                    Qscore,
                    bodyCondition,
                    Head_NuchalCrest,
                    Head_LateralCervicalReg,
                    Head_FacialBones,
                    Head_EarOS,
                    Head_ChinSkinFolds,
                    Body_EpaxialMuscle,
                    Body_DorsalRidgeScapula,
                    Body_Ribs,
                    Tail_TransversePro
                    )
                    values(
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Sighting_ID#' >,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#set_cetacean_code#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_focus#' >,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_Angle#' >,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_Contrast#' >,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_Proportion#' >,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_Partial#' >,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#pqSum#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SDR#' >,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#species#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#bestSighting#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#EnteredBy#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#PhotoAnalysisInitial#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#PhotoAnalysisFinal#'>,
                    <cfqueryparam cfsqltype="cf_sql_varchar"  value='#Note#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Fetals#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Calf#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Yoy#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#setImagePrimary#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#setImageSecondary#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#wMom#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#wMomDropDown#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BestShot#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SightingNumber#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Qscore#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BodyCondition#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_NuchalCrest#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_LateralCervicalReg#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_FacialBones#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_EarOS#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_ChinSkinFolds#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Body_EpaxialMuscle#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Body_DorsalRidgeScapula#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Body_Ribs#'>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Tail_TransversePro#'>
                )
                </cfquery>

                <cfif get_res.RECORDCOUNT eq 1 >
                    <div class='alert alert-success'>
                        <strong>Success!</strong> Cetacean Sighting Inserted.
                    </div>
                    <cfelse>
                    <div class="alert alert-danger">
                        <strong>Error!</strong> Insertion Failed.
                    </div>
                </cfif>

            <cfelse>
                
                <cfset setOldImage = "">
                <cfset setSecOldImage = "">

                 <cfif len(trim(primaryOldImage))>
                    <cfset setOldImage = ReReplaceNoCase(primaryOldImage,'#Application.CloudRoot#','','ALL')>
                    <cfset setImagePrimary = setOldImage>
                </cfif>
                <cfif len(trim(SecondaryOldImage))>
                    <cfset setSecOldImage = ReReplaceNoCase(SecondaryOldImage,'#Application.CloudRoot#','','ALL')>
                    <cfset setImageSecondary = setSecOldImage>
                </cfif>

                <cfif len(trim(BestImage)) AND BestImage NEQ "">
                    <cfif len(trim(primaryOldImage)) AND setOldImage NEQ 'no-image.jpg'>
                        <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&setOldImage#">
                        </cfif>
                    </cfif>

                    <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
                    <cfset reNamePrimary = "#Sighting_ID#(CS)_#DateFormat(DSCOREDATE,'yyyy_mm_dd_HH_ss')#_#returnBestImage.SERVERFILE#">
                    <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##reNamePrimary#">
                    <cfset setImagePrimary = reNamePrimary>
                </cfif>

                <cfif len(trim(SecondaryImage)) AND SecondaryImage NEQ "">
                    <cfif len(trim(SecondaryOldImage)) AND setSecOldImage NEQ 'no-image.jpg'>
                        <cfif FileExists("#Application.CloudDirectory&setSecOldImage#")>
                            <cffile action = "delete" file = "#Application.CloudDirectory&setSecOldImage#">
                        </cfif>
                    </cfif>

                    <cffile action="upload" fileField="SecondaryImage" destination="#Application.CloudDirectory#" result="returnSecondaryImage" nameconflict="overwrite">
                    <cfset reNameSecondary = "#Sighting_ID#(CS)_#DateFormat(DSCOREDATE,'yyyy_mm_dd_HH_ss')#_#returnSecondaryImage.SERVERFILE#">
                    <cffile action = "rename" source = "#Application.CloudDirectory##returnSecondaryImage.serverfile#" destination = "#Application.CloudDirectory##reNameSecondary#">
                    <cfset setImageSecondary = reNameSecondary>
                </cfif>

                <cfquery name="update_cetacean_Sight" datasource="#variables.dsn#" result='get_res'>
                    UPDATE Cetacean_Sightings SET
                    Cetaceans_ID= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#set_cetacean_code#'>,
                    pq_focus= <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_focus#' >,
                    pq_Angle= <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_Angle#' >,
                    pq_Contrast= <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_Contrast#' >,
                    pq_Proportion= <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_Proportion#' >,
                    pq_Partial= <cfqueryparam  cfsqltype="cf_sql_integer" value='#pq_Partial#' >,
                    pqSum= <cfqueryparam  cfsqltype="cf_sql_integer" value='#pqSum#'>,
                    SDR= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SDR#' >,
                    Species= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#species#'>,
                    bestSighting= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#bestSighting#'>,
                    EnteredBy= <cfqueryparam  cfsqltype="cf_sql_integer" value='#EnteredBy#' >,
                    PhotoAnalysisInitial=  <cfqueryparam  cfsqltype="cf_sql_integer" value='#PhotoAnalysisInitial#' >,
                    PhotoAnalysisFinal= <cfqueryparam  cfsqltype="cf_sql_integer" value='#PhotoAnalysisFinal#' >,
                    Note=<cfqueryparam cfsqltype="cf_sql_varchar"  value='#Note#'>,
                    Fetals= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Fetals#'>,
                    Calf= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Calf#'>,
                    Yoy= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Yoy#'>,
                    BestImageLeft= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#setImagePrimary#'>,
                    BestImageRight= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#setImageSecondary#'>,
                    wMom=  <cfqueryparam  cfsqltype="cf_sql_varchar" value='#wMom#'>,
                    wMomDropDown=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#wMomDropDown#' >,
                    BestShot=<cfqueryparam  cfsqltype="cf_sql_varchar" value='#BestShot#'>,
                    SightingNumber= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#SightingNumber#'>,
                    Qscore= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#Qscore#'>,
                    bodyCondition= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#BodyCondition#'>,
                    Head_NuchalCrest= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_NuchalCrest#'>,
                    Head_LateralCervicalReg= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_LateralCervicalReg#'>,
                    Head_FacialBones= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_FacialBones#'>,
                    Head_EarOS= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_EarOS#'>,
                    Head_ChinSkinFolds= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Head_ChinSkinFolds#'>,
                    Body_EpaxialMuscle= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Body_EpaxialMuscle#'>,
                    Body_DorsalRidgeScapula= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Body_DorsalRidgeScapula#'>,
                    Body_Ribs= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Body_Ribs#'>,
                    Tail_TransversePro= <cfqueryparam  cfsqltype="cf_sql_integer" value='#Tail_TransversePro#'>
                    WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#update_cs_Id#'>   
                </cfquery>
                <cfif get_res.RECORDCOUNT eq 1 >
                    <div class='alert alert-success'>
                        <strong>Success!</strong> Cetacean Sighting Updated.
                    </div>
                    <cfelse>
                    <div class="alert alert-danger">
                        <strong>Error!</strong> Updation Failed.
                    </div>
                </cfif>
            </cfif>
        </cfoutput>

         <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
	</cffunction>
    <!--- delete cetaceans sighting--->
    <cffunction name="deleteCetaceanSightingImage" access="remote" returnformat="plain" output="true">
            <cfargument name="isPrimaryImage" type="any" />
            <cfargument name="ID" type="any" />
            <cfargument name="bestImageName" type="any" />
            <cfquery name="deleteImage" datasource="#variables.dsn#" result='get_res'>
                UPDATE Cetacean_Sightings
                    <cfif #isPrimaryImage# EQ "1">
                        SET BestImageLeft = ''
                    <cfelse>
                        SET BestImageRight = ''
                    </cfif>
                    WHERE ID = #ID#
            </cfquery>
             <cfif get_res.RECORDCOUNT eq 1>
                <cfif FileExists("#Application.CloudDirectory&bestImageName#")>
                    <cffile action="delete" file="#Application.CloudDirectory&bestImageName#">

                </cfif>
                <div class="alert alert-success">
                    <strong>Success!</strong> Cetacean Sightings Image Delete.
                </div>
			<cfelse>
                <div class="alert alert-danger">
                    <strong>Error!</strong> Cetacean Sightings Image Delete Failed.
                </div>
			</cfif>
    </cffunction>

    <cffunction name="deleteCS_Record" access="remote" returnformat="plain" output="true">
        <cfargument name="cs_ID" type="any" required="true" default="0">
        
        <cfquery name="get" datasource="#variables.dsn#">
            delete from Condition_Lesions where Cetacean_SightingsID = #cs_ID#
        </cfquery>
        <cfquery name="delete" datasource="#variables.dsn#">
            delete from Cetacean_Sightings where ID = #cs_ID#
        </cfquery>
        <cfoutput>
            Cetacean Sightings Removed successfully.
        </cfoutput>
    </cffunction>

    <cffunction name="getCSById" access="remote" output="true" returnFormat="JSON">
        <cfargument name="cs_ID" type="any" required="true" default="0">
        <cfquery name="getCS" datasource="#variables.dsn#">
            SELECT Cetacean_Sightings.*,Cetaceans.Sex,Cetaceans.FB_Number,Cetaceans.DScore FROM  Cetacean_Sightings 
            INNER JOIN Cetaceans on Cetacean_Sightings.Cetaceans_ID = Cetaceans.ID 
            WHERE Cetacean_Sightings.ID = #cs_ID#
        </cfquery>
        <cfset response = StructNew()>
        <cfset response["ID"] = #getCS.ID#>
        <cfset response["Cetaceans_ID"] = #getCS.Cetaceans_ID#>
        <cfset response["Sex"] = #getCS.Sex#> 
        <cfset response["Fetals"] = #getCS.Fetals#>
        <cfset response["Calf"] = #getCS.Calf#>
        <cfset response["Yoy"] = #getCS.Yoy#>
        <cfset response["FB_Number"] = #getCS.FB_Number#> 
        <cfset response["DScore"] = #getCS.DScore#>
        <cfset response["PhotoAnalysisInitial"] = #getCS.PhotoAnalysisInitial#>
        <cfset response["PhotoAnalysisFinal"] = #getCS.PhotoAnalysisFinal#>
        <cfset response["pq_focus"] = #getCS.pq_focus#> 
        <cfset response["pq_Angle"] = #getCS.pq_Angle#> 
        <cfset response["pq_Contrast"] = #getCS.pq_Contrast#> 
        <cfset response["pq_Proportion"] = #getCS.pq_Proportion#>
        <cfset response["pq_Partial"] = #getCS.pq_Partial#> 
        <cfset response["pqSum"] = #getCS.pqSum#>  
        <cfset response["SDR"] = #getCS.SDR#> 
        <cfset response["Species"] = #getCS.Species#> 
        <cfset response["bestSighting"] = #getCS.bestSighting#> 
        <cfset response["EnteredBy"] = #getCS.EnteredBy#> 
        <cfset response["Note"] = #getCS.Note#> 
        <cfset response["BestShot"] = #getCS.BestShot#>  
        <cfset response["BestImage"] = #getCS.BestImageLeft#>
        <cfset response["SecondaryImage"] = #getCS.BestImageRight#>
        <cfset response["Qscore"] = #getCS.Qscore#>
        <cfset response["wMom"] = #getCS.wMom#>
        <cfset response["wMomDropDown"] = #getCS.wMomDropDown#>
        <cfset response["Head_NuchalCrest"] = #getCS.Head_NuchalCrest#>
        <cfset response["Head_LateralCervicalReg"] = #getCS.Head_LateralCervicalReg#>
        <cfset response["Head_FacialBones"] = #getCS.Head_FacialBones#>
        <cfset response["BodyCondition"] = #getCS.bodyCondition#>
        <cfset response["Head_EarOS"] = #getCS.Head_EarOS#>
        <cfset response["Head_ChinSkinFolds"] = #getCS.Head_ChinSkinFolds#>
        <cfset response["Body_EpaxialMuscle"] = #getCS.Body_EpaxialMuscle#>
        <cfset response["Body_DorsalRidgeScapula"] = #getCS.Body_DorsalRidgeScapula#>
        <cfset response["Body_Ribs"] = #getCS.Body_Ribs#>
        <cfset response["Tail_TransversePro"] = #getCS.Tail_TransversePro#>
        <cfreturn response>
    </cffunction>

    <cffunction name="deleteCetacean" access="remote" returnformat="plain" output="true">
        <cfquery name="del_cetacean" datasource="#variables.dsn#">
            delete from Cetaceans where ID=#url.id#
        </cfquery>
        <cfquery name="del_cetaceanst" datasource="#variables.dsn#">
             delete  from Cetacean_Sightings where Cetaceans_ID=#url.id#
        </cfquery>
    </cffunction>

    <cffunction name="del_cetaceansight" access="remote" returnformat="plain" output="true">
        <cfargument name="SightingID" type="any" required="true" default="">
		<cfargument name="CetaceanID" type="any" required="true" default="">
        <cfquery name="del_cetaceanst" datasource="#variables.dsn#">
             delete  from Cetacean_Sightings where Cetaceans_ID=#CetaceanID# and Sighting_ID=#SightingID#
		</cfquery>
		<cfoutput>
            Cetacean Sighting Removed successfully.
        </cfoutput>
	</cffunction>

    <cffunction name="getlist_cetaceansight" access="remote" returnformat="plain" output="true">
		<cfargument name="Sightningid" type="any" required="true" default="">
        <cfoutput>
        <cftry>
            <cfset sight_id = #form.Sightningid#>
            <cfquery name="cetaceans_sight" datasource="#variables.dsn#" result ='get_dolphine_result'>
                SELECT  Cetacean_Sightings.*,Cetacean_Sightings.ID,Cetaceans.* FROM Cetacean_Sightings INNER JOIN Cetaceans on Cetacean_Sightings.Cetaceans_ID=Cetaceans.ID  WHERE Cetacean_Sightings.Sighting_ID = #sight_id#  order by Cetacean_Sightings.Sighting_ID;
            </cfquery>
            <div id="CS_history" class="modal fade" role="dialog">
             <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close closeCSHistoryModal">&times;</button>
                     <h4 class="modal-title">Cetacean Sighting History </h4>
                     <div class="del_CS" style="display:none"></div>
                  </div>
                  <div class="modal-body" style="overflow:hidden">
                     <cfif cetaceans_sight.recordcount gt 0>
                     <cfset lastRow = cetaceans_sight.recordcount>
                        <div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff">
                           <div class="col-md-1">Code</div>
                           <div class="col-md-1">Species</div>
                           <div class="col-md-1">SDR</div>
                           <div class="col-md-1">Best</div>
                           <div class="col-md-1">Sex</div>
                           <div class="col-md-1">Fetals </div>
                           <div class="col-md-1">Dscore</div>
                           <div class="col-md-1">FB NO</div>
                           <div class="col-md-1">With Mom</div>
                           <div class="col-md-1">Notes </div>
                           <div class="col-md-1">Qscore </div>
                           <div class="col-md-1">Actions</div>
                        </div>
                        <cfset i=0>
                        <div class="history_section">
                           <cfloop query="cetaceans_sight">
                              <cfset i=i+1>
                              <div class="row" id="CSHistory_#i#">
                                 <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;">
                                    <div class="col-md-1 CL Code_#cetaceans_sight.ID#">#cetaceans_sight.Code#</div> 
                                    <div class="col-md-1 CL Species_#cetaceans_sight.ID#">#cetaceans_sight.Species#</div> 
                                    <div class="col-md-1 CL SDR_#cetaceans_sight.ID#">
                                        <cfif cetaceans_sight.SDR eq 'on'>
                                          yes
                                       <cfelse>
                                          #cetaceans_sight.SDR#
                                       </cfif>
                                    </div>
                                    <div class="col-md-1 CL BestSighting_#cetaceans_sight.ID#">
                                        
                                         <cfif cetaceans_sight.BestSighting eq 'on'>
                                          yes
                                       <cfelse>
                                          #cetaceans_sight.BestSighting#
                                       </cfif>

                                    </div>
                                    <div class="col-md-1 CL Sex_#cetaceans_sight.ID#">#cetaceans_sight.Sex#</div>
                                    <div class="col-md-1 CL Fetals_#cetaceans_sight.ID#">
                                        
                                        <cfif cetaceans_sight.Fetals eq 'on'>
                                          yes
                                       <cfelse>
                                          #cetaceans_sight.Fetals#
                                       </cfif>
                                   </div>
                                    <div class="col-md-1 CL Dscore_#cetaceans_sight.ID#">#cetaceans_sight.Dscore#</div> 
                                    <div class="col-md-1 CL FB_Number_#cetaceans_sight.ID#">#cetaceans_sight.FB_Number#</div> 
                                    <div class="col-md-1 CL wMom_#cetaceans_sight.ID#">
                                        <cfif cetaceans_sight.wMomDropDown eq 1>
                                          Yes
                                       <cfelseif cetaceans_sight.wMomDropDown eq 2>
                                          No
                                       <cfelseif cetaceans_sight.wMomDropDown eq 3>
                                          Partial
                                       </cfif>
                                    </div>
                                    <div class="col-md-1 CL Note_#cetaceans_sight.ID#">#cetaceans_sight.Note#</div> 
                                    <div class="col-md-1 CL Qscore_#cetaceans_sight.ID#">#cetaceans_sight.Qscore#</div>
                                    <div class="col-md-1 CL">
                                       <div class="col-mad-6" style="display:inline-block">
                                          <button class="btn btn-xs btn-primary" type="button" onclick="getSingleCS_Record(#cetaceans_sight.ID#)"><i class="fa fa-pencil-square-o"></i></button>
                                       </div>
                                       <div class="col-mad-6" style="display:inline-block">
                                          <button class="btn btn-xs btn-primary" onclick="deleteCS_Record(#cetaceans_sight.ID#,#i#)"><i class="glyphicon glyphicon-trash"></i></button>
                                       </div>
                                    </div>
                              </div>
                           </div>
                           </cfloop>
                     </div>
                     <cfelse>
                        <h2 style="text-align:center;color:red">There is no Cetacean Sighting added yet!</h2>
                     </cfif>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default closeCSHistoryModal">Close</button>
                  </div>
               </div>
            </div>
         </div>
        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>
</cfoutput>
</cffunction>


     <cffunction name="getsingl_Cetacean" access="public"  output="false">
        <cfquery name="query" datasource="#variables.dsn#">
            select Cetaceans.*,      
            TLU_YOB_Source.* from Cetaceans left join TLU_YOB_Source on Cetaceans.SourceYOB=TLU_YOB_Source.ID where Cetaceans.ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
        </cfquery>
        <cfreturn  query>
    </cffunction>

    <cffunction name="update_new_cetacean" access="remote" returnformat="plain" output="true">
        <cfoutput>
        <cftry>
            <cfparam name="BestImage" default="">
            <cfparam name="oldImage" default="">

            <cfparam name="SecondaryImage" default="">
            <cfparam name="SecOldImage" default="">

            <cfparam name="setPrimaryImage" default="">
            <cfparam name="setSecondaryImage" default="">

            <cfset setOldImage = "">
            <cfset setSecOldImage = "">
            <cfif len(trim(oldImage))>
                <cfset setOldImage = ReReplaceNoCase(oldImage,'#Application.CloudRoot#','','ALL')>
            </cfif>
             <cfif len(trim(SecOldImage))>
                <cfset setSecOldImage = ReReplaceNoCase(SecOldImage,'#Application.CloudRoot#','','ALL')>
            </cfif>


            <cfif len(trim(BestImage))>
                <cfif len(trim(oldImage)) AND setOldImage NEQ 'no-image.jpg'>
                    <cfif FileExists("#Application.CloudDirectory&setOldImage#")>
                       <cffile action = "delete" file = "#Application.CloudDirectory&setOldImage#">
                    </cfif>
                </cfif>

                <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
                <cfset setPrimaryImage =#Form.ID#&"_"&#replaceNoCase(replaceNoCase(Form.Code,"/","_","all"),"\","_","all")#&"_"&#returnBestImage.serverfile#>
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
                <cfset setSecondaryImage =#Form.ID#&"_"&#replaceNoCase(replaceNoCase(Form.Code,"/","_","all"),"\","_","all")#&"_"&#returnSecondaryImage.serverfile#>
                <cffile action = "rename" source = "#Application.CloudDirectory##returnSecondaryImage.serverfile#" destination = "#Application.CloudDirectory##setSecondaryImage#">
            <cfelse> 
               <cfset setSecondaryImage = setSecOldImage>
            </cfif>



            
            <cfquery name="update_cetacean" datasource="#variables.dsn#" result='get_res'>
                    update Cetaceans set
                    Name=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Name#'>,
                    Code=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Code#'>,
                    Sex=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Sex#'>,
                    SourceSexed=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.SourceSexed#'>,
                    DateOfBirthEstimate=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Date_of_Birth_EST#' null="#IIF(Form.Date_of_Birth_EST EQ "", true, false)#">,
                    YearOfBirth=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.YearOfBirth#'>,
                    SourceYOB=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Source_YOB#'>,
                    FirstSightingDate=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.First_Sighting_Date#' null="#IIF(Form.First_Sighting_Date EQ "", true, false)#">,
                    DateDeath=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Date_of_Death#' null="#IIF(Form.Date_of_Death EQ "", true, false)#">,
                    PresumedDead=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.PresumedDead#'>,
                    Dead=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dead#'>,
                    CetaceanSpecies=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.CetaceanSpecies#'>,
                    Dscore=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#'>,
                    FB_Number=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FB_Number#'>,
                    HUBBS_ID=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HUBBS_ID#'>,
                    Field_ID=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Field_ID#'>,
                    Mother=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Mother#'>,
                    Lineage=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Lineage#'>,
                    HBOCI_CODE=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Previous_HBOCI_CODE#'>,
                    ImageName='#setPrimaryImage#',
                    SecondaryImage='#setSecondaryImage#'
                    where ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.ID#'>
            </cfquery>

            <cfif get_res.RECORDCOUNT eq 1>
                <div class="alert alert-success">
                    <strong>Success!</strong> Cetacean record Updated.
                </div>
            <cfelse>
                <div class="alert alert-danger">
                    <strong>Error!</strong> Updation Failed.
                </div>
            </cfif>

        <cfcatch type="any">
        <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>

        </cfoutput>
    </cffunction>

    <cffunction name="getCetaceanById" access="remote" output="true" returnFormat="JSON">
      <cfargument name="cetacean_ID" type="any" required="true" default="0">
      <cfoutput>
        <cfquery name="getCetacean" datasource="#variables.dsn#">
          SELECT CetaceanSpecies,CetaceanSpeciesName,Name,Sex,FB_Number,DScore,ImageName from Cetaceans
		  inner join TLU_CetaceanSpecies on TLU_CetaceanSpecies.ID=Cetaceans.CetaceanSpecies
		  where Cetaceans.ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#cetacean_ID#'>
        </cfquery>

        <cfset response = StructNew()>
        <cfset response["DScore"] = #getCetacean.DScore#>
        <cfset response["CetaceanSpecies"] = #getCetacean.CetaceanSpecies#> 
        <cfset response["CetaceanSpeciesName"] = #getCetacean.CetaceanSpeciesName#> 
        <cfset response["Name"] = #getCetacean.Name#>
        <cfset response["Sex"] = #getCetacean.Sex#>
        <cfset response["FB_Number"] = #getCetacean.FB_Number#>
        <cfset response["ImageName"] = #getCetacean.ImageName#>
        <cfreturn response>
    </cfoutput>
    </cffunction>

    <cffunction name="getCalfs" access="public" returnformat="plain" output="true">
        <cfargument name="code" default="" required="yes">
        <cfquery name="qgetCalfs" datasource="#variables.dsn#">
        SELECT Cetaceans.Code, Cetaceans.Lineage,
        Cetaceans.[DOB EST] AS Expr1, Cetaceans.YearOfBirth,
        Cetaceans.[Date of Death]
        FROM Cetaceans
        WHERE ((Cetaceans.Lineage) Is Not Null)
        AND Cetaceans.Mothers = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
        </cfquery>
        <cfreturn qgetCalfs>
    </cffunction>
    <cffunction name="getRegionNamebyId" access="remote" returnformat="plain" output="true">
        <cfargument name="RegionID" type="any" required="true" default=""> 
        <cfset selectedRegions = "">
        <cfif #RegionID# NEQ "">
            <cfquery name="getRegionNames" datasource="#variables.dsn#">
                SELECT RegionName from TLU_Regions WHERE ID in (#RegionID#)
            </cfquery>
            <cfset selectedRegions = ValueList(getRegionNames.RegionName,", ")>
        </cfif>
        <cfreturn selectedRegions> 
    </cffunction> 

    <cffunction name="getCetacean_Lesions" access="remote" returnformat="JSON" output="true">
        <!--- <cfdump var="#Cetacean_Survey#" abort='true'> --->
        <!--- <cfparam name="Form.Cetacean_Survey" default="0"> --->
        <cfif isDefined('form.Cetacean_Survey') and form.Cetacean_Survey neq ''>
            <cfquery name="qgetCetacean_Lesions" datasource="#variables.dsn#">
                select Surveys.id as surveyid, Survey_Sightings.SightingNumber,Survey_Sightings.id as sightid,Surveys.date as DateSeen,Condition_Lesions.LesionType,Condition_Lesions.Region,Condition_Lesions.Side_L_R,Condition_Lesions.Status,Condition_Lesions.id from Condition_Lesions
                 INNER JOIN Survey_Sightings on Condition_Lesions.Sighting_ID = Survey_Sightings.ID
                 INNER JOIN Surveys on Surveys.id  = Survey_Sightings.Project_ID 
                 where Surveys.id = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Cetacean_Survey#'>           
                 AND Surveys.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
                 AND Survey_Sightings.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
                 order by DateSeen desc
             </cfquery>        
        <cfelse>

            <cfquery name="qgetCetacean_Lesions" datasource="#variables.dsn#">
            select Survey_Sightings.SightingNumber,Survey_Sightings.id as sightid,Surveys.date as DateSeen,Condition_Lesions.LesionType,Condition_Lesions.Region,Condition_Lesions.Side_L_R,Condition_Lesions.Status,Condition_Lesions.id from Condition_Lesions
                INNER JOIN Survey_Sightings on Condition_Lesions.Sighting_ID = Survey_Sightings.ID
                INNER JOIN Surveys on Surveys.id  = Survey_Sightings.Project_ID 
                where Condition_Lesions.Cetaceans_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#cetacean_Code#'>           
                AND Surveys.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
                AND Survey_Sightings.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
                order by DateSeen desc
            </cfquery>
            
        </cfif>
        
        <cfloop query="qgetCetacean_Lesions">
            <cfif #qgetCetacean_Lesions.Region# NEQ "">
                <cfset regionN = getRegionNamebyId(qgetCetacean_Lesions.Region)>
                <cfset querySetCell(qgetCetacean_Lesions, "Region", "#regionN#",qgetCetacean_Lesions.currentRow)>
            </cfif>
        </cfloop>
        <cfreturn qgetCetacean_Lesions>
    </cffunction>
    
    <cffunction name="getCetacean_Lesions_unique" access="remote" returnformat="JSON" output="true">
        <cfquery name="qgetCetacean_Lesions_unique" datasource="#variables.dsn#">
            select  Distinct Condition_Lesions.LesionType,Condition_Lesions.Region,Condition_Lesions.Side_L_R from Condition_Lesions
            INNER JOIN Survey_Sightings on Condition_Lesions.Sighting_ID = Survey_Sightings.ID
			INNER JOIN Surveys on Surveys.id  = Survey_Sightings.Project_ID  
            where Condition_Lesions.Cetaceans_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#cetacean_Code#'>
        </cfquery>
        <cfset  queryAddColumn(qgetCetacean_Lesions_unique, 'RegionNames',[''])>
        <cfloop query="qgetCetacean_Lesions_unique">
            <cfif #qgetCetacean_Lesions_unique.Region# NEQ "">
                <cfset regionN = getRegionNamebyId(qgetCetacean_Lesions_unique.Region)>
                <cfset querySetCell(qgetCetacean_Lesions_unique, "RegionNames", "#regionN#",qgetCetacean_Lesions_unique.currentRow)>
            <cfelse>
                <cfset querySetCell(qgetCetacean_Lesions_unique, "RegionNames", "",qgetCetacean_Lesions_unique.currentRow)>
            </cfif>
        </cfloop>
        <cfreturn qgetCetacean_Lesions_unique>
    </cffunction>
    <cffunction name="save_existingLesion" access="remote" returnformat="JSON" output="true" result="res">
        
        

        <cfquery name="qgetCetacean_code" datasource="#variables.dsn#">
            select ID from  Cetacean_Sightings 
            where 
            Sighting_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sight#">
            and
            Cetaceans_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Cetacean_code#">
       </cfquery> 
        <cfif isDefined('qgetCetacean_code.ID') and qgetCetacean_code.ID neq ''>
            <cfset Cetacean_SightingID = '#qgetCetacean_code.ID#'>
        <cfelse>
            <cfset Cetacean_SightingID = '0'>
        </cfif>
        <!---<cfdump var="#qgetCetacean_code#" abort="true"> --->


        <cfquery name="qchecklesion" datasource="#variables.dsn#">
            select ID from  Condition_Lesions 
            where 
            Sighting_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sight#">
            and
            Cetaceans_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cl_cs_code#">
            and
            LesionType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lesion#">
            and
            Region = <cfqueryparam cfsqltype="cf_sql_varchar" value="#region#">
            and
            Side_L_R = <cfqueryparam cfsqltype="cf_sql_varchar" value="#side#">
       </cfquery> 
       <cfif qchecklesion.recordCount neq 0>
            <cfquery name="qsave_existingLesion" datasource="#variables.dsn#">
                update  Condition_Lesions set 
                LesionPresent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sel#">,
                Cetacean_SightingsID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Cetacean_SightingID#">
                where 
                ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#qchecklesion.ID#">
            </cfquery> 
       <cfelse>
            <cfquery name="qsave_existingLesion" datasource="#variables.dsn#">
                 insert into Condition_Lesions (
                    Cetaceans_ID,
                    Sighting_ID,
                    LesionPresent,
                    LesionType,
                    Region,
                    Side_L_R,
                    Status,
                    PhotoNumber,
                    Comments,
                    Cetacean_SightingsID
                    )
                    values(
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#cl_cs_code#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#sight#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#sel#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#lesion#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#region#' null="#IIF(region EQ "" AND region EQ " ", true, false)#">,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#side#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value='#status#'>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value=''>,
                    <cfqueryparam  cfsqltype="cf_sql_varchar" value=''>,
                    <cfqueryparam  cfsqltype="cf_sql_integer" value='#Cetacean_SightingID#'>
                )
            </cfquery>
        </cfif>
        <cfreturn TRUE>
    </cffunction>
    <cffunction name="getCetacean" access="public" returnformat="plain" output="true">
        
    <cfquery name="getCetacean" datasource="#variables.dsn#">
     SELECT
        DISTINCT (Survey_Sightings.SightingNumber),
        Cetaceans.CetaceanSpecies,
        Cetaceans.Code,
        Cetaceans.Name,
        Cetaceans.Sex,
        Cetaceans.SourceSexed,
		Cetaceans.FB_Number,
        Cetaceans.YearOfBirth,
        Cetaceans.FirstSightingDate as First_Sighting_Date,
        Cetaceans.ImageName,
		Cetaceans.SecondaryImage,
		Cetaceans.DateDeath as DOD,
        Cetaceans.DateOfBirthEstimate as DOB,
		Cetaceans.DScore,
        Surveys.Date as DateSeen,
        Surveys.ID as Survey_ID,
		Survey_Sightings.ID as Sighting_ID,
        Survey_Sightings.SightingNumber as SightingNo,
		Survey_Sightings.Project_ID,
		Survey_Sightings.InitialLatitude,
        Survey_Sightings.InitialLongitude,
        Survey_Sightings.AtLatitude,
        Survey_Sightings.AtLongitude,
        Survey_Sightings.EndLatitude, 
        Survey_Sightings.EndLongitude,
        Surveys.BodyOfWater,
        Surveys.SurveyType,
        Cetacean_Sightings.bodyCondition,
        Cetacean_Sightings.Fetals, 
         Cetacean_Sightings.Calf, 
         Cetacean_Sightings.Yoy
        FROM Surveys LEFT JOIN
        ((Survey_Sightings LEFT JOIN
        (Cetaceans RIGHT JOIN
        Cetacean_Sightings ON Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID)
        ON
          Survey_Sightings.ID = Cetacean_Sightings.Sighting_ID)
         )
         ON
         Surveys.ID = Survey_Sightings.Project_ID
        where Cetaceans.ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.CetaceanId#'>
        AND Surveys.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
        AND Survey_Sightings.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
        order by dateseen desc
        </cfquery>
        <cfquery name="getfinflok" datasource="#variables.dsn#">
            select *
            from Fin_Fluke
            where CetaceanId =<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.CetaceanId#'>
            and Species =<cfqueryparam cfsqltype="cf_sql_integer" value='#getCetacean.CetaceanSpecies#'>
            order by Date asc
        </cfquery>
        <cfloop query="getCetacean">
           <cfloop query="getfinflok">
                <cfif getCetacean.DateSeen gte getfinflok.Date>
                    <cfset querySetCell(getCetacean,"DScore" ,#getfinflok.DScore# )>
                </cfif>
           </cfloop>
        </cfloop>
        <cfreturn getCetacean>
    </cffunction>

    <cffunction name="getCetaceanFriends" access="public" returnformat="plain" output="true">
        <cfargument name='SightingNo' default=''>
        <cfargument name='code' default=''>

        <cfquery name="qgetCetaceanFriends" datasource="#variables.dsn#">
        SELECT Cetaceans.Sex,CONCAT(Cetaceans.Code, ' - ', Cetaceans.Name) as CetaceanCodeName ,Cetaceans.ID , COUNT(*) as times
        FROM Cetacean_Sightings
        inner join Cetaceans
        on
		Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID
		where Cetacean_Sightings.Sighting_ID IN (#SightingNo#)
		AND Cetaceans.CODE != '#code#'
		GROUP BY
		Cetaceans.Name,Cetaceans.Code,Cetaceans.Sex,Cetaceans.ID
        order by code Asc
        </cfquery>
        
        <cfreturn qgetCetaceanFriends>
    </cffunction>
    <cffunction name="getCatalog" returntype="any" output="false" access="public" >
        <cfquery name="qgetCatalog" datasource="#variables.dsn#"  >
            SELECT * from TLU_Catalog where active = 1
        </cfquery>
        <cfreturn qgetCatalog>
    </cffunction>
    <cffunction name="getSourceSex" returntype="any" output="false" access="public" >
        <cfquery name="getSourceSex" datasource="#variables.dsn#"  >
            SELECT * from TLU_SourceSex where active = 1
        </cfquery>
        <cfreturn getSourceSex>
    </cffunction>
    <cffunction name="InsertMMHSRP" returntype="any" output="false" access="public" >
        <cfquery name="qinsert" datasource="#variables.dsn#" result="returndata">
        Insert into Dolphin_MMHSRP 
        (Dolphin_ID,MMHSRP_ID,Description,Date) 
        values
        (
        <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.id#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.MMHSRP_ID#">,
        <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.Description#">,
        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Form.Date_MMHSRP#">
        )
        </cfquery>
	    <cfreturn returndata>
    </cffunction>
    <cffunction name="getMMHSRP_Dophin" returntype="any" output="false" access="public" >
        <cfquery name="qget" datasource="#variables.dsn#" result="returndata">
            select * from Dolphin_MMHSRP where Dolphin_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
        </cfquery>
        <cfreturn qget>
    </cffunction>
    <cffunction name="DeleteMMHSRP" access="remote" returnformat="plain" output="true" method="postadd_cetaceans">
        <cfquery name="delete" datasource="#variables.dsn#">
        delete from Dolphin_MMHSRP where ID=#url.id#
        </cfquery>
    </cffunction>
    <cffunction name="add_SDOdolphin" access="public"  output="false">
        <cfparam name="Form.Dead" default="0">
        <cfparam name="Form.Distinct" default="0">
        <cfparam name="Form.PRES_LOBO" default="0">
        <cfparam name="Form.HERARescueFinChange1" default="0">
        <cfparam name="Form.HERARescueFinChange2" default="0">
        <cfparam name="Form.HERARescueFinChange3" default="0">
        <cfparam name="Form.HERARescue" default="0">
        <cfquery name="insert_sdo" datasource="#variables.dsn#" result='get_res'>
            insert into TLU_Dolphin_SDO
						(
                        Dolphin_ID,
                        PRES_LOBO_DATE,
                        Lobo_Confirmed,
                        Recapture_Date_1,
                        Recapture_Date_2,
                        Recapture_Date_3,
                        HERAError,
                        FinChange1,
                        FinChange2,
                        FinChange3,
                        FinChange4,
                        FB_on_Date,
                        FB_Side,
                        Dead,
                        [Distinct],
                        PRES_LOBO,
                        HERARescueFinChange1,
                        HERARescueFinChange2,
                        HERARescueFinChange3,
                        HERARescue
                        )
				Values(
						<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.CetaceanId#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.PRES_LOBO_DATE#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Lobo_Confirmed#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_1#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_2#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_3#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HERAError#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange1#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange2#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange3#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FinChange4#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FB_on_Date#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FB_Side#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Dead#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Distinct#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.PRES_LOBO#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange1#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange2#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange3#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescue#'>
                       )
        </cfquery>
        <cfreturn get_res>
    </cffunction>
    <cffunction name="Update_SDOdolphin" access="public"  output="false">
        <cfparam name="Form.Dead" default="0">
        <cfparam name="Form.Distinct" default="0">
        <cfparam name="Form.PRES_LOBO" default="0">
        <cfparam name="Form.HERARescueFinChange1" default="0">
        <cfparam name="Form.HERARescueFinChange2" default="0">
        <cfparam name="Form.HERARescueFinChange3" default="0">
        <cfparam name="Form.HERARescue" default="0">
        <cfquery name="update_sdo" datasource="#variables.dsn#" result='get_res'>
        update  TLU_Dolphin_SDO  set
  						Dolphin_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.Dolphin_ID#'>,
                        PRES_LOBO_DATE=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.PRES_LOBO_DATE#'>,
                        Lobo_Confirmed=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Lobo_Confirmed#'>,
                        Recapture_Date_1= <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_1#'>,
                        Recapture_Date_2=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_2#'>,
                        Recapture_Date_3=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_3#'>,
                        HERAError=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HERAError#'>,
                        FinChange1=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange1#'>,
                        FinChange2=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange2#'>,
                        FinChange3=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange3#'>,
                        FinChange4=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FinChange4#'>,
                        FB_on_Date=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FB_on_Date#'>,
                        FB_Side=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FB_Side#'>,
                        Dead=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Dead#'>,
                        [Distinct]=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Distinct#'>,
                        PRES_LOBO=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.PRES_LOBO#'>,
                        HERARescueFinChange1=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange1#'>,
                        HERARescueFinChange2=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange2#'>,
                        HERARescueFinChange3=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange3#'>,
                        HERARescue=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescue#'>
                        where ID =<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.ID#'>
        </cfquery>
        <cfreturn get_res>
    </cffunction>
    <cffunction name="getSDODolphin" returntype="any" output="false" access="public" >
        <cfquery name="qget" datasource="#variables.dsn#" result="returndata">
            select
            TLU_Dolphin_SDO.Dolphin_ID,
            TLU_Dolphin_SDO.PRES_LOBO_DATE,
            TLU_Dolphin_SDO.Lobo_Confirmed,
            TLU_Dolphin_SDO.Recapture_Date_1,
            TLU_Dolphin_SDO.Recapture_Date_2,
            TLU_Dolphin_SDO.Recapture_Date_3,
            TLU_Dolphin_SDO.HERAError,
            TLU_Dolphin_SDO.FinChange1,
            TLU_Dolphin_SDO.FinChange2,
            TLU_Dolphin_SDO.FinChange3,
             TLU_Dolphin_SDO.FB_on_Date,
             TLU_Dolphin_SDO.FB_Side,
             TLU_Dolphin_SDO.Dead,
             TLU_Dolphin_SDO.[Distinct],
             TLU_Dolphin_SDO.PRES_LOBO,
             TLU_Dolphin_SDO.HERARescueFinChange1,
             TLU_Dolphin_SDO.HERARescueFinChange2,
             TLU_Dolphin_SDO.HERARescueFinChange3,
             TLU_Dolphin_SDO.HERARescue,
             TLU_Dolphin_SDO.FinChange4,
             TLU_Dolphin_SDO.ID,

            Cetaceans.Name from TLU_Dolphin_SDO inner join Cetaceans on Cetaceans.ID=TLU_Dolphin_SDO.Dolphin_ID  where Dolphin_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.Dolphin_ID#">
        </cfquery>
        <cfreturn qget>
    </cffunction>
    <cffunction name="getSDODolphin_single" returntype="any" output="false" access="public" >
        <cfquery name="qget" datasource="#variables.dsn#" result="returndata">
        select 
        TLU_Dolphin_SDO.Dolphin_ID,
        TLU_Dolphin_SDO.PRES_LOBO_DATE,
        TLU_Dolphin_SDO.Lobo_Confirmed,
        TLU_Dolphin_SDO.Recapture_Date_1,
        TLU_Dolphin_SDO.Recapture_Date_2,
        TLU_Dolphin_SDO.Recapture_Date_3,
        TLU_Dolphin_SDO.HERAError,
        TLU_Dolphin_SDO.FinChange1,
        TLU_Dolphin_SDO.FinChange2,
        TLU_Dolphin_SDO.FinChange3,
         TLU_Dolphin_SDO.FB_on_Date,
         TLU_Dolphin_SDO.FB_Side,
         TLU_Dolphin_SDO.Dead,
         TLU_Dolphin_SDO.[Distinct],
         TLU_Dolphin_SDO.PRES_LOBO,
         TLU_Dolphin_SDO.HERARescueFinChange1,
         TLU_Dolphin_SDO.HERARescueFinChange2,
         TLU_Dolphin_SDO.HERARescueFinChange3,
         TLU_Dolphin_SDO.HERARescue,
         TLU_Dolphin_SDO.FinChange4,
         TLU_Dolphin_SDO.ID,
         Cetaceans.Name from TLU_Dolphin_SDO inner join Cetaceans on Cetaceans.ID=TLU_Dolphin_SDO.Dolphin_ID  where TLU_Dolphin_SDO.ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ID#">
    </cfquery>
	<cfreturn qget>
    </cffunction>
    <cffunction name="DeleteSdodolphin" access="remote" returnformat="plain" output="true">
        <cfquery name="delete" datasource="#variables.dsn#">
            delete from TLU_Dolphin_SDO where ID=#url.id#
        </cfquery>
    </cffunction>
    <cffunction name="getsightingByDolphin" access="public" returnformat="plain" output="true">
        <cfquery name="getdata" datasource="#variables.dsn#">
            SELECT DOLPHIN_SIGHTINGS.Dolphin_ID,
            DOLPHIN_SIGHTINGS.Sighting_ID
            FROM
            DOLPHIN_SIGHTINGS
            WHERE  DOLPHIN_SIGHTINGS.Dolphin_ID=<cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer"> order by  DOLPHIN_SIGHTINGS.Sighting_ID desc
        </cfquery>
        <cfreturn getdata>
    </cffunction>
    <cffunction name="getshotData" access="public" returnformat="plain" output="true">
        <cfargument name="sight_id" type="any" default="">
        <cfquery name="getshotData" datasource="#variables.dsn#">
            select  BIOPSY_SHOTS.* ,Cetaceans.Name , TLU_ResearchTeamMembers.* , Cetaceans.Code , Cetaceans.ID from BIOPSY_SHOTS
            INNER JOIN Cetaceans ON BIOPSY_SHOTS.Dolphin_ID = Cetaceans.ID
             FULL OUTER JOIN TLU_ResearchTeamMembers on TLU_ResearchTeamMembers.RT_ID = BIOPSY_SHOTS.Arbalester
            where BIOPSY_SHOTS.Sighting_ID = #sight_id# AND BIOPSY_SHOTS.ShotNumber = 1  order by BIOPSY_SHOTS.Biopsy_ID DESC
       </cfquery>
        <cfreturn getshotData>
    </cffunction>
    <cffunction name="firstShotData" access="remote" returnformat="plain" output="true">
        <cfargument name="sight_id" default="">
        <cfargument name="shotNumber" default="">
        <cfargument name="dolphin_id" default="">
        <cfquery name="firstShotData" datasource="#variables.dsn#">
             SELECT  BIOPSY_SHOTS.*,TLU_ResearchTeamMembers.* ,Cetaceans.Name , Cetaceans.Code , Cetaceans.ID from BIOPSY_SHOTS
             INNER JOIN Cetaceans ON BIOPSY_SHOTS.Dolphin_ID = Cetaceans.ID
             FULL OUTER JOIN TLU_ResearchTeamMembers on TLU_ResearchTeamMembers.RT_ID = BIOPSY_SHOTS.Arbalester
             WHERE BIOPSY_SHOTS.Sighting_ID = #sight_id# AND BIOPSY_SHOTS.ShotNumber = #shotNumber# AND BIOPSY_SHOTS.Dolphin_ID = #dolphin_id#  order by BIOPSY_SHOTS.Enter_Date DESC
       </cfquery>
        <cfset Arrayofshot = ArrayNew(1)>
        <cfset structOfshot = StructNew() />
        <cfset StructInsert(structOfshot,"Biopsy_ID",firstShotData.Biopsy_ID)>
        <cfset StructInsert(structOfshot,"probable_dolphin",firstShotData.probable_dolphin)>
        <cfset StructInsert(structOfshot,"DolphinID",firstShotData.Dolphin_ID)>
        <cfset StructInsert(structOfshot,"ShotTime", #TimeFormat(firstShotData.ShotTime, "hh:nn")#)>
        <cfset StructInsert(structOfshot,"DolphinCode",firstShotData.Code)>
        <cfset StructInsert(structOfshot,"DolphinName",firstShotData.Name)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior1",firstShotData.TargetResponseBehavior1)>
        <cfset StructInsert(structOfshot,"TargetLevel",firstShotData.TargetLevel)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior2",firstShotData.TargetResponseBehavior2)>
        <cfset StructInsert(structOfshot,"TargetLevel2",firstShotData.TargetLevel2)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior3",firstShotData.TargetResponseBehavior3)>
        <cfset StructInsert(structOfshot,"TargetLevel3",firstShotData.TargetLevel3)>
        <cfset StructInsert(structOfshot,"Arbalester",firstShotData.Arbalester)>
        <cfset StructInsert(structOfshot,"GroupResponseBehavior",firstShotData.GroupResponseBehavior)>
        <cfset StructInsert(structOfshot,"GroupLevel1",firstShotData.GroupLevel1)>
        <cfset StructInsert(structOfshot,"HitLocation",firstShotData.HitLocation)>
        <cfset StructInsert(structOfshot,"ShotDistance",firstShotData.ShotDistance)>
        <cfset StructInsert(structOfshot,"SampleNumber",firstShotData.SampleNumber)>
        <cfset StructInsert(structOfshot,"Outcome",firstShotData.Outcome)>
        <cfset StructInsert(structOfshot,"Processor",firstShotData.Processor)>
        <cfset StructInsert(structOfshot,"HitDescriptor",firstShotData.HitDescriptor)>
        <cfset StructInsert(structOfshot,"GroupSize",firstShotData.GroupSize)>
        <cfset StructInsert(structOfshot,"SampleLength",firstShotData.SampleLength)>
        <cfset StructInsert(structOfshot,"SampleTaken",firstShotData.SampleTaken)>
        <cfset StructInsert(structOfshot,"Samplehead",firstShotData.Samplehead)>
        <cfset StructInsert(structOfshot,"SampleCollected",firstShotData.SampleCollected)>
        <cfset StructInsert(structOfshot,"BlubberTeflonVial",firstShotData.BlubberTeflonVial)>
        <cfset StructInsert(structOfshot,"BlubberCryovialRed",firstShotData.BlubberCryovialRed)>
        <cfset StructInsert(structOfshot,"BlubberCryovialBlue",firstShotData.BlubberCryovialBlue)>
        <cfset StructInsert(structOfshot,"SkinDCryovial",firstShotData.SkinDCryovial)>
        <cfset StructInsert(structOfshot,"SkinDMSO",firstShotData.SkinDMSO)>
        <cfset StructInsert(structOfshot,"SkinRNAlater",firstShotData.SkinRNAlater)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Mill",firstShotData.TABPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Feed",firstShotData.TABPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_ProbFeed",firstShotData.TABPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Travel",firstShotData.TABPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Play",firstShotData.TABPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_REST",firstShotData.TABPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Leap_tailslap_chuff",firstShotData.TABPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_WITHBOAT",firstShotData.TABPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Avoid_Boat",firstShotData.TABPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPre_Depredation",firstShotData.TABPre_Depredation)>
        <cfset StructInsert(structOfshot,"TABPre_Herding",firstShotData.TABPre_Herding)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Mill",firstShotData.GBPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Feed",firstShotData.GBPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_ProbFeed",firstShotData.GBPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Travel",firstShotData.GBPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Play",firstShotData.GBPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_REST",firstShotData.GBPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Leap_tailslap_chuff",firstShotData.GBPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Social",firstShotData.GBPre_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_WITHBOAT",firstShotData.GBPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Other",firstShotData.GBPre_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Avoid_Boat",firstShotData.GBPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPre_Depredation",firstShotData.GBPre_Depredation)>
        <cfset StructInsert(structOfshot,"GBPre_Herding",firstShotData.GBPre_Herding)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Mill",firstShotData.TABPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Feed",firstShotData.TABPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_ProbFeed",firstShotData.TABPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Travel",firstShotData.TABPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Play",firstShotData.TABPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_REST",firstShotData.TABPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Leap_tailslap_chuff",firstShotData.TABPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Social",firstShotData.TABPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_WITHBOAT",firstShotData.TABPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Other",firstShotData.TABPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Avoid_Boat",firstShotData.TABPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPost_Depredation",firstShotData.TABPost_Depredation)>
        <cfset StructInsert(structOfshot,"TABPost_Herding",firstShotData.TABPost_Herding)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Mill",firstShotData.GBPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Feed",firstShotData.GBPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_ProbFeed",firstShotData.GBPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Travel",firstShotData.GBPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Play",firstShotData.GBPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_REST",firstShotData.GBPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Leap_tailslap_chuff",firstShotData.GBPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Social",firstShotData.GBPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_WITHBOAT",firstShotData.GBPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Other",firstShotData.GBPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Avoid_Boat",firstShotData.GBPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPost_Depredation",firstShotData.GBPost_Depredation)>
        <cfset StructInsert(structOfshot,"GBPost_Herding",firstShotData.GBPost_Herding)>
        <cfset StructInsert(structOfshot,"ShotCount",firstShotData.ShotCount)>
        <cfset ArrayAppend(Arrayofshot,structOfshot)>
        <cfoutput>#SerializeJSON(Arrayofshot)#</cfoutput>
    </cffunction>
    <cffunction name="countdailyshot" access="remote" returnformat="plain" output="true">
        <cfquery name="countdailyshot" datasource="#variables.dsn#" result="r">
            select  count(BIOPSY_SHOTS.ShotNumber) as biopsycount FROM BIOPSY_SHOTS WHERE
            cast(BIOPSY_SHOTS.Enter_Date as Date) = '#DATEFORMAT(now(),"yyyy/mm/dd")#'
        </cfquery>
        <cfoutput>#countdailyshot.biopsycount#</cfoutput>
    </cffunction>
    <cffunction name="secondShotData" access="remote" returnformat="plain" output="true">
        <cfargument name="sight_id" default="">
        <cfargument name="shotNumber" default="">
        <cfargument name="dolphin_id" default="">
        <cfquery name="firstShotData" datasource="#variables.dsn#">
           SELECT  BIOPSY_SHOTS.*  ,TLU_ResearchTeamMembers.* ,Cetaceans.Name , Cetaceans.Code , Cetaceans.ID from BIOPSY_SHOTS
           INNER JOIN Cetaceans ON BIOPSY_SHOTS.Dolphin_ID = Cetaceans.ID
           FULL OUTER JOIN TLU_ResearchTeamMembers on TLU_ResearchTeamMembers.RT_ID = BIOPSY_SHOTS.Arbalester
           WHERE BIOPSY_SHOTS.Sighting_ID = #sight_id# AND BIOPSY_SHOTS.ShotNumber = #shotNumber# AND BIOPSY_SHOTS.Dolphin_ID = #dolphin_id#   order by BIOPSY_SHOTS.Enter_Date DESC
        </cfquery>
        <cfset Arrayofshot = ArrayNew(1)>
        <cfset structOfshot = StructNew() />
        <cfset StructInsert(structOfshot,"Biopsy_ID",firstShotData.Biopsy_ID)>
        <cfset StructInsert(structOfshot,"probable_dolphin",firstShotData.probable_dolphin)>
        <cfset StructInsert(structOfshot,"ShotTime", #TimeFormat(firstShotData.ShotTime, "hh:nn")#)>
        <cfset StructInsert(structOfshot,"DolphinID",firstShotData.Dolphin_ID)>
        <cfset StructInsert(structOfshot,"DolphinCode",firstShotData.Code)>
        <cfset StructInsert(structOfshot,"DolphinName",firstShotData.Name)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior1",firstShotData.TargetResponseBehavior1)>
        <cfset StructInsert(structOfshot,"TargetLevel",firstShotData.TargetLevel)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior2",firstShotData.TargetResponseBehavior2)>
        <cfset StructInsert(structOfshot,"TargetLevel2",firstShotData.TargetLevel2)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior3",firstShotData.TargetResponseBehavior3)>
        <cfset StructInsert(structOfshot,"TargetLevel3",firstShotData.TargetLevel3)>
        <cfset StructInsert(structOfshot,"Arbalester",firstShotData.Arbalester)>
        <cfset StructInsert(structOfshot,"GroupResponseBehavior",firstShotData.GroupResponseBehavior)>
        <cfset StructInsert(structOfshot,"GroupLevel1",firstShotData.GroupLevel1)>
        <cfset StructInsert(structOfshot,"HitLocation",firstShotData.HitLocation)>
        <cfset StructInsert(structOfshot,"ShotDistance",firstShotData.ShotDistance)>
        <cfset StructInsert(structOfshot,"SampleNumber",firstShotData.SampleNumber)>
        <cfset StructInsert(structOfshot,"Outcome",firstShotData.Outcome)>
        <cfset StructInsert(structOfshot,"Processor",firstShotData.Processor)>
        <cfset StructInsert(structOfshot,"HitDescriptor",firstShotData.HitDescriptor)>
        <cfset StructInsert(structOfshot,"GroupSize",firstShotData.GroupSize)>
        <cfset StructInsert(structOfshot,"SampleLength",firstShotData.SampleLength)>
        <cfset StructInsert(structOfshot,"SampleTaken",firstShotData.SampleTaken)>
        <cfset StructInsert(structOfshot,"Samplehead",firstShotData.Samplehead)>
        <cfset StructInsert(structOfshot,"SampleCollected",firstShotData.SampleCollected)>
        <cfset StructInsert(structOfshot,"BlubberTeflonVial",firstShotData.BlubberTeflonVial)>
        <cfset StructInsert(structOfshot,"BlubberCryovialBlue",firstShotData.BlubberCryovialBlue)>
        <cfset StructInsert(structOfshot,"SkinDCryovial",firstShotData.SkinDCryovial)>
        <cfset StructInsert(structOfshot,"SkinDMSO",firstShotData.SkinDMSO)>
        <cfset StructInsert(structOfshot,"SkinRNAlater",firstShotData.SkinRNAlater)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Mill",firstShotData.TABPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Feed",firstShotData.TABPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_ProbFeed",firstShotData.TABPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Travel",firstShotData.TABPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Play",firstShotData.TABPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_REST",firstShotData.TABPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Leap_tailslap_chuff",firstShotData.TABPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_WITHBOAT",firstShotData.TABPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Avoid_Boat",firstShotData.TABPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPre_Depredation",firstShotData.TABPre_Depredation)>
        <cfset StructInsert(structOfshot,"TABPre_Herding",firstShotData.TABPre_Herding)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Mill",firstShotData.GBPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Feed",firstShotData.GBPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_ProbFeed",firstShotData.GBPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Travel",firstShotData.GBPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Play",firstShotData.GBPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_REST",firstShotData.GBPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Leap_tailslap_chuff",firstShotData.GBPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Social",firstShotData.GBPre_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_WITHBOAT",firstShotData.GBPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Other",firstShotData.GBPre_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Avoid_Boat",firstShotData.GBPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPre_Depredation",firstShotData.GBPre_Depredation)>
        <cfset StructInsert(structOfshot,"GBPre_Herding",firstShotData.GBPre_Herding)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Mill",firstShotData.TABPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Feed",firstShotData.TABPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_ProbFeed",firstShotData.TABPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Travel",firstShotData.TABPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Play",firstShotData.TABPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_REST",firstShotData.TABPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Leap_tailslap_chuff",firstShotData.TABPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Social",firstShotData.TABPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_WITHBOAT",firstShotData.TABPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Other",firstShotData.TABPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Avoid_Boat",firstShotData.TABPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPost_Depredation",firstShotData.TABPost_Depredation)>
        <cfset StructInsert(structOfshot,"TABPost_Herding",firstShotData.TABPost_Herding)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Mill",firstShotData.GBPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Feed",firstShotData.GBPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_ProbFeed",firstShotData.GBPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Travel",firstShotData.GBPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Play",firstShotData.GBPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_REST",firstShotData.GBPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Leap_tailslap_chuff",firstShotData.GBPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Social",firstShotData.GBPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_WITHBOAT",firstShotData.GBPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Other",firstShotData.GBPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Avoid_Boat",firstShotData.GBPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPost_Depredation",firstShotData.GBPost_Depredation)>
        <cfset StructInsert(structOfshot,"GBPost_Herding",firstShotData.GBPost_Herding)>
        <cfset StructInsert(structOfshot,"ShotCount",firstShotData.ShotCount)>
        <cfset ArrayAppend(Arrayofshot,structOfshot)>
        <cfoutput>#SerializeJSON(Arrayofshot)#</cfoutput>
    </cffunction>
    <cffunction name="thirdShotData" access="remote" returnformat="plain" output="true">
        <cfargument name="sight_id" default="">
        <cfargument name="shotNumber" default="">
        <cfargument name="dolphin_id" default="">
        <cfquery name="thirdShotData" datasource="#variables.dsn#">
        SELECT  BIOPSY_SHOTS.*,TLU_ResearchTeamMembers.* ,Cetaceans.Name , Cetaceans.Code , Cetaceans.ID from BIOPSY_SHOTS
         INNER JOIN Cetaceans ON BIOPSY_SHOTS.Dolphin_ID = Cetaceans.ID
         FULL OUTER JOIN TLU_ResearchTeamMembers on TLU_ResearchTeamMembers.RT_ID = BIOPSY_SHOTS.Arbalester
         WHERE BIOPSY_SHOTS.Sighting_ID = #sight_id# AND BIOPSY_SHOTS.ShotNumber = #shotNumber# AND BIOPSY_SHOTS.Dolphin_ID = #dolphin_id#  order by BIOPSY_SHOTS.Enter_Date DESC
        </cfquery>
        <cfset Arrayofshot = ArrayNew(1)>
        <cfset structOfshot = StructNew() />
        <cfset StructInsert(structOfshot,"DolphinID",thirdShotData.Dolphin_ID)>
        <cfset StructInsert(structOfshot,"probable_dolphin",thirdShotData.probable_dolphin)>
        <cfset StructInsert(structOfshot,"ShotTime", #TimeFormat(thirdShotData.ShotTime, "hh:nn")#)>
        <cfset StructInsert(structOfshot,"DolphinCode",thirdShotData.Code)>
        <cfset StructInsert(structOfshot,"DolphinName",thirdShotData.Name)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior1",thirdShotData.TargetResponseBehavior1)>
        <cfset StructInsert(structOfshot,"TargetLevel",thirdShotData.TargetLevel)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior2",thirdShotData.TargetResponseBehavior2)>
        <cfset StructInsert(structOfshot,"TargetLevel2",thirdShotData.TargetLevel2)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior3",thirdShotData.TargetResponseBehavior3)>
        <cfset StructInsert(structOfshot,"TargetLevel3",thirdShotData.TargetLevel3)>
        <cfset StructInsert(structOfshot,"Arbalester",thirdShotData.Arbalester)>
        <cfset StructInsert(structOfshot,"GroupResponseBehavior",thirdShotData.GroupResponseBehavior)>
        <cfset StructInsert(structOfshot,"GroupLevel1",thirdShotData.GroupLevel1)>
        <cfset StructInsert(structOfshot,"HitLocation",thirdShotData.HitLocation)>
        <cfset StructInsert(structOfshot,"ShotDistance",thirdShotData.ShotDistance)>
        <cfset StructInsert(structOfshot,"SampleNumber",thirdShotData.SampleNumber)>
        <cfset StructInsert(structOfshot,"Outcome",thirdShotData.Outcome)>
        <cfset StructInsert(structOfshot,"Processor",thirdShotData.Processor)>
        <cfset StructInsert(structOfshot,"HitDescriptor",thirdShotData.HitDescriptor)>
        <cfset StructInsert(structOfshot,"GroupSize",thirdShotData.GroupSize)>
        <cfset StructInsert(structOfshot,"SampleLength",thirdShotData.SampleLength)>
        <cfset StructInsert(structOfshot,"SampleTaken",thirdShotData.SampleTaken)>
        <cfset StructInsert(structOfshot,"Samplehead",thirdShotData.Samplehead)>
        <cfset StructInsert(structOfshot,"SampleCollected",thirdShotData.SampleCollected)>
        <cfset StructInsert(structOfshot,"BlubberTeflonVial",thirdShotData.BlubberTeflonVial)>
        <cfset StructInsert(structOfshot,"BlubberCryovialBlue",thirdShotData.BlubberCryovialBlue)>
        <cfset StructInsert(structOfshot,"SkinDCryovial",thirdShotData.SkinDCryovial)>
        <cfset StructInsert(structOfshot,"SkinDMSO",thirdShotData.SkinDMSO)>
        <cfset StructInsert(structOfshot,"SkinRNAlater",thirdShotData.SkinRNAlater)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Mill",thirdShotData.TABPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Feed",thirdShotData.TABPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_ProbFeed",thirdShotData.TABPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Travel",thirdShotData.TABPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Play",thirdShotData.TABPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_REST",thirdShotData.TABPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Leap_tailslap_chuff",thirdShotData.TABPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_WITHBOAT",thirdShotData.TABPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Avoid_Boat",thirdShotData.TABPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPre_Depredation",thirdShotData.TABPre_Depredation)>
        <cfset StructInsert(structOfshot,"TABPre_Herding",thirdShotData.TABPre_Herding)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Mill",thirdShotData.GBPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Feed",thirdShotData.GBPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_ProbFeed",thirdShotData.GBPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Travel",thirdShotData.GBPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Play",thirdShotData.GBPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_REST",thirdShotData.GBPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Leap_tailslap_chuff",thirdShotData.GBPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Social",thirdShotData.GBPre_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_WITHBOAT",thirdShotData.GBPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Other",thirdShotData.GBPre_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Avoid_Boat",thirdShotData.GBPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPre_Depredation",thirdShotData.GBPre_Depredation)>
        <cfset StructInsert(structOfshot,"GBPre_Herding",thirdShotData.GBPre_Herding)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Mill",thirdShotData.TABPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Feed",thirdShotData.TABPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_ProbFeed",thirdShotData.TABPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Travel",thirdShotData.TABPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Play",thirdShotData.TABPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_REST",thirdShotData.TABPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Leap_tailslap_chuff",thirdShotData.TABPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Social",thirdShotData.TABPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_WITHBOAT",thirdShotData.TABPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Other",thirdShotData.TABPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Avoid_Boat",thirdShotData.TABPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPost_Depredation",thirdShotData.TABPost_Depredation)>
        <cfset StructInsert(structOfshot,"TABPost_Herding",thirdShotData.TABPost_Herding)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Mill",thirdShotData.GBPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Feed",thirdShotData.GBPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_ProbFeed",thirdShotData.GBPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Travel",thirdShotData.GBPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Play",thirdShotData.GBPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_REST",thirdShotData.GBPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Leap_tailslap_chuff",thirdShotData.GBPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Social",thirdShotData.GBPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_WITHBOAT",thirdShotData.GBPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Other",thirdShotData.GBPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Avoid_Boat",thirdShotData.GBPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPost_Depredation",thirdShotData.GBPost_Depredation)>
        <cfset StructInsert(structOfshot,"ShotCount",thirdShotData.ShotCount)>
        <cfset StructInsert(structOfshot,"GBPost_Herding",thirdShotData.GBPost_Herding)>
        <cfset ArrayAppend(Arrayofshot,structOfshot)>
        <cfoutput>#SerializeJSON(Arrayofshot)#</cfoutput>
    </cffunction>
    <cffunction name="Add_Biopsy" access="remote" returnformat="plain" output="true">
        <cfargument name="BiopsyTeam" default=" ">
        <cfparam name="form.TargetLevel1" default="">
        <cfparam name="form.TargetLevel2" default="">
        <cfparam name="form.TargetLevel3" default="">
        <cfparam name="form.Outcome" default="">
        <cfparam name="form.SkinDMSO" default="">
        <cfparam name="form.probable_dolphin " default="">
        <cfparam name="form.SkinRNAlater" default="">
        <cfparam name="form.SkinDCryovial" default="">
        <cfparam name="form.SampleTaken" default="">
        <cfparam name="form.Samplehead" default="">
        <cfparam name="form.SampleCollected" default="">
        <cfparam name="form.BlubberTeflonVial" default="">
        <cfparam name="form.BlubberCryovialRed" default="">
        <cfparam name="form.BlubberCryovialBlue" default="">
        <cfparam name="form.GroupLevel1" default="">
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
        <cfif #form.ShotNumber# gt 0  and #form.ShotNumber# lt 4>
            <cfquery name="insertdata" datasource="#variables.dsn#" result="result">
            INSERT INTO BIOPSY_SHOTS
    		(Enter_Date,
             Dolphin_ID,
             Sighting_ID,
             ShotTime,
             Arbalester,
             ShotNumber,
             ShotDistance,
             Outcome,
             ShotCount,
       		 TargetLevel,
       		 TargetLevel2,
       		 TargetLevel3,
       		 TABPre_Activity_Mill,
             TABPre_Activity_Feed,
             TABPre_Activity_ProbFeed,
             TABPre_Activity_Travel,
             TABPre_Activity_Play,
             TABPre_ACTIVITY_REST,
             TABPre_Activity_Leap_tailslap_chuff,
             TABPre_Activity_Social,
             TABPre_ACTIVITY_WITHBOAT,
             TABPre_Activity_Other,
             TABPre_Activity_Avoid_Boat,
             TABPre_Depredation,
             TABPre_Herding,
             TABPost_Activity_Mill,
             TABPost_Activity_Feed,
             TABPost_Activity_ProbFeed,
             TABPost_Activity_Travel,
             TABPost_Activity_Play,
             TABPost_ACTIVITY_REST,
             TABPost_Activity_Leap_tailslap_chuff,
             TABPost_Activity_Social,
             TABPost_ACTIVITY_WITHBOAT,
             TABPost_Activity_Other,
             TABPost_Activity_Avoid_Boat,
             TABPost_Depredation,
             TABPost_Herding,
             GBPre_Activity_Mill,
             GBPre_Activity_Feed,
             GBPre_Activity_ProbFeed,
             GBPre_Activity_Travel,
             GBPre_Activity_Play,
             GBPre_ACTIVITY_REST,
             GBPre_Activity_Leap_tailslap_chuff,
             GBPre_Activity_Social,
             GBPre_ACTIVITY_WITHBOAT,
             GBPre_Activity_Other,
             GBPre_Activity_Avoid_Boat,
             GBPre_Depredation,
             GBPre_Herding,
             GBPost_Activity_Mill,
             GBPost_Activity_Feed,
             GBPost_Activity_ProbFeed,
             GBPost_Activity_Travel,
             GBPost_Activity_Play,
             GBPost_ACTIVITY_REST,
             GBPost_Activity_Leap_tailslap_chuff,
             GBPost_Activity_Social,
             GBPost_ACTIVITY_WITHBOAT,
             GBPost_Activity_Other,
             GBPost_Activity_Avoid_Boat,
             GBPost_Depredation,
             GBPost_Herding,
        	 HitLocation,
             Processor,
             SampleLength,
             SkinDMSO,
             SkinRNAlater,
             SkinDCryovial,
             SampleNumber,
             SampleTaken,
             Samplehead,
             SampleCollected,
             BlubberTeflonVial,
             BlubberCryovialRed,
             BlubberCryovialBlue,
             TargetResponseBehavior1,
             TargetResponseBehavior2,
             TargetResponseBehavior3,
             GroupResponseBehavior,
             GroupSize,
             HitDescriptor,
             MissDescriptor,
             TargetPre_Behavior1,
             TargetPre_Behavior2,
             TargetPre_Behavior3,
             TargetPost_Behavior1,
             TargetPost_Behavior2,
             TargetPost_Behavior3,
             GroupPre_Behavior1,
             GroupPre_Behavior2,
             GroupPre_Behavior3,
             GroupPost_Behavior1,
             GroupPost_Behavior2,
             GroupPost_Behavior3,
             GroupLevel1,
             probable_dolphin
            )Values(
             	<cfqueryparam cfsqltype="cf_sql_timestamp" value='#NOW()#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Dolphin_ID#' null="#IIF(form.Dolphin_ID EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Sighting_ID#'>,
                <cfqueryparam cfsqltype="cf_sql_time" value='#form.ShotTime#' null="#IIF(form.ShotTime EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Arbalester#' null="#IIF(form.Arbalester EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ShotNumber#' null="#IIF(form.ShotNumber EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ShotDistance#' null="#IIF(form.ShotDistance EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Outcome#' null="#IIF(form.Outcome EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.ShotCount#' null="#IIF(form.ShotCount EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetLevel1#' null="#IIF(form.TargetLevel1 EQ "", true, false)#">,
             	<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetLevel2#' null="#IIF(form.TargetLevel2 EQ "", true, false)#">,
             	<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetLevel3#' null="#IIF(form.TargetLevel3 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Mill#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Feed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_ProbFeed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Travel#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Play#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_REST#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Leap_tailslap_chuff#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Social#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_WITHBOAT#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Other#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Avoid_Boat#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Depredation#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Herding#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Mill#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Feed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_ProbFeed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Travel#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Play#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_REST#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Leap_tailslap_chuff#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Social#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_WITHBOAT#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Other#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Avoid_Boat#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Depredation#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Herding#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Mill#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Feed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_ProbFeed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Travel#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Play#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_REST#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Leap_tailslap_chuff#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Social#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_WITHBOAT#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Other#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Avoid_Boat#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Depredation#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Herding#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Mill#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Feed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_ProbFeed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Travel#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Play#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_REST#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Leap_tailslap_chuff#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Social#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_WITHBOAT#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Other#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Avoid_Boat#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Depredation#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Herding#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.HitLocation#' null="#IIF(form.HitLocation EQ "", true, false)#">,
                <!---<cfqueryparam cfsqltype="cf_sql_integer" value='#form.SubSample#' null="#IIF(form.SubSample EQ "", true, false)#">,--->
                <!------>
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Processor#' null="#IIF(form.Processor EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.SampleLength#' null="#IIF(form.SampleLength EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinDMSO#' null="#IIF(form.SkinDMSO EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinRNAlater#' null="#IIF(form.SkinRNAlater EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinDCryovial#' null="#IIF(form.SkinDCryovial EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.SampleNumber#' null="#IIF(form.SampleNumber EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SampleTaken#' null="#IIF(form.SampleTaken EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Samplehead#' null="#IIF(form.Samplehead EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SampleCollected#' null="#IIF(form.SampleCollected EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberTeflonVial#' null="#IIF(form.BlubberTeflonVial EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberCryovialRed#' null="#IIF(form.BlubberCryovialRed EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberCryovialBlue#' null="#IIF(form.BlubberCryovialBlue EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior1#' null="#IIF(form.TargetResponseBehavior1 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior2#' null="#IIF(form.TargetResponseBehavior2 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior3#' null="#IIF(form.TargetResponseBehavior3 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.GroupResponseBehavior1#' null="#IIF(form.GroupResponseBehavior1 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.groupSize#' null="#IIF(form.groupSize EQ "", true, false)#">,
                <!---<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missDistance#' null="#IIF(form.missDistance EQ "", true, false)#">,--->
                <!---<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missHeight#' null="#IIF(form.missHeight EQ "", true, false)#">,--->
                <!---<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missWidth#' null="#IIF(form.missWidth EQ "", true, false)#">,--->
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.hitDescriptor#' null="#IIF(form.hitDescriptor EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missDescriptor#' null="#IIF(form.missDescriptor EQ "", true, false)#">,
             	<cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior1#' null="#IIF(TargetPre_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior2#' null="#IIF(TargetPre_Behavior2 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior3#' null="#IIF(TargetPre_Behavior3 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior1#' null="#IIF(TargetPost_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior2#' null="#IIF(TargetPost_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior3#' null="#IIF(TargetPost_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior1#' null="#IIF(GroupPre_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior2#' null="#IIF(GroupPre_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior3#' null="#IIF(GroupPre_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior1#' null="#IIF(GroupPost_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior2#' null="#IIF(GroupPost_Behavior2 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior3#' null="#IIF(GroupPost_Behavior3 EQ "", true, false)#">,
           	   <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.GroupLevel1#' null="#IIF(form.GroupLevel1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_integer" value='#form.probable_dolphin#' null="#IIF(form.probable_dolphin  EQ "", true, false)#">
           	 )
	        </cfquery>
            <cfif BiopsyTeam NEQ '' >
                <cfloop index = "ListElement" list ="#BiopsyTeam#">
                    <cfquery name="update" datasource="#variables.dsn#" result="updating" >
                    insert into TEAMMEMBER_Biopsy (Biopsy_ID,TeamMemberID) values
                    (<cfqueryparam cfsqltype="cf_sql_integer" value='#result.identitycol#'>,
                    <cfqueryparam cfsqltype="cf_sql_integer" value='#VAL(ListElement)#'>
                    )
                    </cfquery>
                </cfloop>
            </cfif>
            <cfreturn result>
        <cfelse>
        <cfreturn "error">
        </cfif>
    </cffunction>
    <cffunction name="getBiopsy" access="remote" returntype="any" output="true">
        <cfquery name="query" datasource="#variables.dsn#">
            SELECT Biopsy_ID,Sighting_ID,SampleNumber,ShotNumber,Outcome FROM
            BIOPSY_SHOTS
            WHERE  Dolphin_ID=<cfqueryparam value='#url.id#' cfsqltype="cf_sql_integer"> order by  Biopsy_ID desc
        </cfquery>
    <cfoutput>#SerializeJSON(query)#</cfoutput>
    </cffunction>
    <cffunction name="DeleteBiopsy" access="remote" returntype="any" output="true">
            <cfquery name="query" datasource="#variables.dsn#">
            Delete FROM BIOPSY_SHOTS
                WHERE  Biopsy_ID=<cfqueryparam value='#url.id#' cfsqltype="cf_sql_integer">
            </cfquery>
    </cffunction>
    <cffunction name="getBiopsyBehavior" returntype="any" output="false" access="public" >
        <cfquery name="qgetBiopsyBehavior" datasource="#variables.dsn#"  >
            SELECT * from TLU_BiopsyBehavior where active=1
        </cfquery>
        <cfreturn qgetBiopsyBehavior>
    </cffunction>
    <cffunction name="getHitLocation" returntype="any" output="false" access="public" >
        <cfquery name="qgetHitLocation" datasource="#variables.dsn#"  >
            SELECT * from TLU_HitLocation where active=1
        </cfquery>
        <cfreturn qgetHitLocation>
    </cffunction>
    <cffunction name="getHitDescriptors" returntype="any" output="false" access="public" >
        <cfquery name="qgetHitDescriptors" datasource="#variables.dsn#"  >
            SELECT * from TLU_HitDescriptors where active=1
        </cfquery>
        <cfreturn qgetHitDescriptors>
    </cffunction>
    <cffunction name="getMissDescriptors" returntype="any" output="false" access="public" >
        <cfquery name="qgetMissDescriptors" datasource="#variables.dsn#"  >
        SELECT * from TLU_MissDescriptors where active=1
        </cfquery>
	    <cfreturn qgetMissDescriptors>
    </cffunction>
    <cffunction name="getSubSampleType" returntype="any" output="false" access="public" >
        <cfquery name="qgetSubSampleType" datasource="#variables.dsn#"  >
        SELECT * from TLU_SubSampleType where active=1
        </cfquery>
	    <cfreturn qgetSubSampleType>
    </cffunction>
<!--- function to add dead dolphins-------->
    <cffunction name="updateDeadDolphin" returntype="any" output="false" access="public" >
        <cfquery name="updateDeadDolphin" datasource="#variables.dsn#" result="result">
                UPDATE Cetaceans SET
                waterBody =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.waterBody#'>,
                <cfif isdefined('form.dead')>
                <cfif form.dead EQ "on">
                <cfset dead = 1>
                     [Dead?] = '#dead#',
                </cfif>
                </cfif>
                 [Field ID] =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Field_ID#'>,
                 [Date of Death] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Year#'>,
                 [Source Sexed]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sourcesex#'  null="#IIF(Form.sourcesex EQ "", true, false)#">,
                 bodyConditionCode =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bodyConditionCode#'>,
                 Code =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Code#'>,
                 FB_No =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.FB_No#' null="#IIF(form.FB_No EQ "", true, false)#">,
                 Dscore =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Dscore#'>,
                 YearOfBirth = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.YearOfBirth#'>,
                 [Source YOB] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Source_YOB_ID#'>,
                 ageAtDeath = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ageAtDeath#'>,
                 dorsalDecomposed = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.dorsalDecomposed#'>,
                 poorQualityPhoto =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.poorQualityPhoto#'>,
                 Unrecoveredo = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Unrecoveredo#'>,
                 momPushingDeadCalf = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.deadDorsalPhoto#'>,
                 deadDorsalPhoto = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.deadDorsalPhoto#'>,
                 sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.sex#'>,
                 bodyLenght = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bodyLenght#'>,
                 ageCohort = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ageCohort#'>,
                 Details = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Details#'>,
                 otherAccessionNumbers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.otherAccessionNumbers#'>,
                 photoType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.photoType#'>,
                 irlSegment =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.irlSegment#'>,
                 utmEsting = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.utmEsting#'>,
                 utmNorting = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.utmNorting#'>
                 WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.ID#'>
                 </cfquery>
        <cfreturn result>
    </cffunction>
<!---End function to update dead dolphins-------->
<!---Function for List dead dolphins-------->
    <cffunction name="getDeadDolphinList" returntype="any" output="false" access="public" >
            <cfquery name="getDeadDolphins" datasource="#variables.dsn#"  >
                  SELECT Code,name,ID from Cetaceans where [Dead?] = 1
                  UNION All
                  SELECT Code,name,ID from Cetaceans WHERE Code LIKE 'UNK%'
            </cfquery>
            <cfreturn getDeadDolphins>
    </cffunction>
<!---End Function for List dead dolphins-------->
<!---Function for get dead dolphins-------->
    <cffunction name="getDeadDolphinDetail" returntype="any" output="false" access="public" >
            <cfquery name="getDeadDolphinDetail" datasource="#variables.dsn#"  result="r">
                SELECT top 1 Cetaceans.*,Dolphins.[Source Sexed] as ssexed, SIGHTINGS.* , DOLPHIN_SIGHTINGS.* ,Surveys.*, Dolphin_DScore.DScore as score , Cetaceans.[Field ID] as FiledID, Cetaceans.[Source YOB] as SourceYOB,
                Cetaceans.[Date of Death] as deathDeate, Cetaceans.[Dead?] as dead, <!----04-august-2017---->SIGHTINGS.[Date_Entered] as Last_Sighting_date FROM Cetaceans
                INNER JOIN DOLPHIN_SIGHTINGS ON DOLPHIN_SIGHTINGS.Dolphin_ID = Cetaceans.ID
                INNER JOIN Dolphin_DScore on Dolphin_DScore.DolphinID = Cetaceans.ID
                INNER JOIN SIGHTINGS ON DOLPHIN_SIGHTINGS.Sighting_ID = SIGHTINGS.ID
                INNER JOIN Surveys ON Surveys.ID = SIGHTINGS.Project_ID
                WHERE Cetaceans.ID = #form.ID#
                ORDER BY DOLPHIN_SIGHTINGS.Sighting_ID DESC
        </cfquery>
    <cfreturn getDeadDolphinDetail>
    </cffunction>
    <cffunction name="geteditedDeadDolphinDetail" returntype="any" output="false" access="public" >
            <cfquery name="getDeadDolphinDetail" datasource="#variables.dsn#"  result="deadlist">
                SELECT top 1 Cetaceans.*,Dolphins.[Source Sexed] as ssexed, SIGHTINGS.* , DOLPHIN_SIGHTINGS.* ,Surveys.*, Dolphin_DScore.DScore as score , Cetaceans.[Field ID] as FiledID, Cetaceans.[Source YOB] as SourceYOB,
                Cetaceans.[Date of Death] as deathDeate, Cetaceans.[Dead?] as dead, <!----04-august-2017---->SIGHTINGS.[Date_Entered] as Last_Sighting_date FROM Cetaceans
                INNER JOIN DOLPHIN_SIGHTINGS ON DOLPHIN_SIGHTINGS.Dolphin_ID = Cetaceans.ID
                INNER JOIN Dolphin_DScore on Dolphin_DScore.DolphinID = Cetaceans.ID
                INNER JOIN SIGHTINGS ON DOLPHIN_SIGHTINGS.Sighting_ID = SIGHTINGS.ID
                INNER JOIN Surveys ON Surveys.ID = SIGHTINGS.Project_ID
                WHERE Cetaceans.ID = #form.dead_id#
                ORDER BY DOLPHIN_SIGHTINGS.Sighting_ID DESC
            </cfquery>
            <cfreturn getDeadDolphinDetail>
    </cffunction>
    <cffunction name="change_dolphindeath" returntype="any" output="false"  access="remote">
            <cfquery name="changedeath" datasource="#variables.dsn#"  result="death">
                update Cetaceans set [Dead?] = 0 WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#'>
            </cfquery>
    </cffunction>
    <cffunction name="getDeadDolphins" returntype="any" output="false" access="public">
            <cfquery name="getDeadDolphins" datasource="#variables.dsn#"  result="dead">
                select * from Dolphins WHERE [Dead?] = 1
            </cfquery>
            <cfreturn getDeadDolphins>
    </cffunction>
<!---End Function for get dead dolphins-------->

	<cffunction name="getCetaceanCatalog" returntype="any" output="false" access="public" >
        <cfparam name="Form.catalog"     default="">
        <cfparam name="Form.dscore"      default="">
        <cfparam name="Form.bodyOfWater" default="">
        <cfquery name="getCetaceanDetails" datasource="#variables.dsn#"  >
            SELECT  Distinct Cetaceans.ID,
                    Cetaceans.Code,
                    Cetaceans.Name,
                    Cetaceans.Catalog,
                    Cetaceans.Sex,
                    Cetaceans.ImageName
                    FROM Cetaceans 
            <cfif form.dscore NEQ "">                   
            inner join Dolphin_DScore ON Dolphin_DScore.DolphinID = Cetaceans.ID
            </cfif>
            <cfif form.bodyofwater NEQ "">
            inner join DOLPHIN_SIGHTINGS on DOLPHIN_SIGHTINGS.Dolphin_ID = Cetaceans.ID
            inner join SIGHTINGS on SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
            inner join Surveys on Surveys.ID = SIGHTINGS.Project_ID
            </cfif>
            <cfif form.catalog NEQ "">
                where Catalog = '#form.catalog#'
            </cfif>
            <cfif form.dscore NEQ "">                   
            	<cfif form.catalog NEQ ""> and<cfelse> where</cfif> Dolphin_DScore.DScore = '#form.dscore#'
            </cfif>
            <cfif form.bodyOfWater NEQ "">
                <cfif form.catalog EQ "" and form.dscore EQ "" and form.bodyOfWater EQ ""> where<cfelse> and</cfif> Surveys.surveyarea like '%#trim(form.bodyOfWater)#%'
            </cfif>
        </cfquery>
        <cfreturn getCetaceanDetails>
    </cffunction>
    <cffunction name="getCetaceanSightings" access="public" returnformat="plain" output="true">
        <cfargument name="dolphin_id" default="">
        <cfquery name="getCetaceanSighting" datasource="#variables.dsn#">
            SELECT
            Surveys.Date as DateSeen,
            SIGHTINGS.ID as SightingNo,
            SIGHTINGS.Project_ID
            
            FROM Surveys LEFT JOIN
            ((SIGHTINGS LEFT JOIN
            (Cetaceans RIGHT JOIN
            DOLPHIN_SIGHTINGS ON Cetaceans.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
            ON
              SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
             LEFT JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID)
             ON
             Surveys.ID = SIGHTINGS.Project_ID
            where Cetaceans.ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#dolphin_id#'>
            order by dateseen desc
        </cfquery>
        <cfreturn getCetaceanSighting>
    </cffunction>
    
    <cffunction name="getSightingHistory" access="public" returnformat="plain" output="true">
        <cfquery name="getSightingHistory" datasource="#variables.dsn#">
        SELECT DS.Sighting_ID,DS.Dolphin_Sighting_Date,DS.BodyCondition,DS.Region,DS.Area
        FROM Surveys LEFT JOIN
        ((SIGHTINGS LEFT JOIN
        (Cetaceans RIGHT JOIN
        DOLPHIN_SIGHTINGS DS ON Cetaceans.ID = DS.Dolphin_ID)
        ON
          SIGHTINGS.ID = DS.Sighting_ID)
         LEFT JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID)
         ON
         Surveys.ID = SIGHTINGS.Project_ID
        where Cetaceans.ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.CetaceanId#'> AND DS.Dolphin_Sighting_Date != ''
        GROUP BY DS.Sighting_ID,DS.Dolphin_Sighting_Date,DS.BodyCondition,DS.Region,DS.Area
        order by Sighting_ID desc
        </cfquery>
        <cfreturn getSightingHistory>
    </cffunction>

    <cffunction name="getSourceSexName" returntype="any" output="false" access="public" >
        <cfargument name="SourceSexed" default="0">
        <cfquery name="getSourceSex" datasource="#variables.dsn#">
            SELECT Ssex from TLU_SourceSex where ID = #SourceSexed#
        </cfquery>
        <cfreturn getSourceSex.Ssex>
    </cffunction>

    <cffunction name="getBodyOfWaterName" returntype="any" output="false" access="public" >
        <cfargument name="BodyOfWater" default="0">
        <cfquery name="getBodyOfWater" datasource="#variables.dsn#">
            SELECT AreaName from TLU_SurveyArea where ID in (#BodyOfWater#)
        </cfquery>
        <cfset setBodyOfWater = ValueList(getBodyOfWater.AreaName,", ")>
        <cfreturn setBodyOfWater>
    </cffunction>

    <cffunction name="replaceCetaceanSighting" returntype="any" output="false" access="remote" >
        <cfquery name="qupdateConditionLesion" datasource="#variables.dsn#" result="result">
            UPDATE Condition_Lesions
            SET Cetaceans_ID = '#form.new_cetacean_ID#'
            WHERE
                Cetaceans_ID = '#form.old_cetacean_ID#'
            AND Sighting_ID = '#form.sighting_ID#'
        </cfquery>
       <cfreturn "true">
    </cffunction>
</cfcomponent>