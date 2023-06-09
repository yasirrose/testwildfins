<cfcomponent displayName="Static Data" output="false">
    <cfset variables.dsn = "wildfins_new">
    <cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
      <cfargument name="dsn" type="string" required="true" hint="datasource">
      <cfset variables.dsn = arguments.dsn>
      <cfreturn this>
    </cffunction>
<!--- Camera --->
    <cffunction name="CameraInsert" returntype="any" output="false" access="public" >
        <cfquery name="qCameraInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Camera (Camera,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Camera#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getWatchedEmails" returntype="any" output="false" access="public" >
        <cfquery name="getWatchedEmails" datasource="#variables.dsn#">
             select Id,email from Dolphin_Observer where email <> ''
        </cfquery>
        <cfreturn getWatchedEmails>
    </cffunction>
    <cffunction name="addAdminEmail" returntype="any" output="false" access="public" >
        <cfif isValid("email", #FORM.email#)>
            <cfset validEmail = #FORM.email# />
            <cfquery name="addAdminEmail" datasource="#variables.dsn#" result="addAdminEmail">
            INSERT INTO Tlu_Admin_Emails
             (
             Email,
             active
             )values(
              <cfqueryparam cfsqltype="cf_sql_varchar" value="#validEmail#">,
              <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.active#">
             )
        </cfquery>
            <cfreturn addAdminEmail.recordcount>
            <cfelse>
            <cfreturn 0>
        </cfif>
    </cffunction>
    <cffunction name="getAdminEmail" returntype="any" output="false" access="public" >
        <cfquery name="getAdminEmail" datasource="#variables.dsn#">
             select * from Tlu_Admin_Emails where email <> ''
        </cfquery>
        <cfreturn getAdminEmail>
    </cffunction>
    <cffunction name="updateAdminEmail" returntype="any" output="false" access="public" >
        <cfquery name="updateAdminEmail" datasource="#variables.dsn#">
             update Tlu_Admin_Emails
             SET Email = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.email#'>,
             active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#'>
             WHERE id = #form.id#
        </cfquery>

    </cffunction>
    <cffunction name="deleteAdminEmail" returntype="any" output="false"  access="remote">
        <cfquery name="deleteAdminEmail" datasource="#variables.dsn#" result="deleteAdminEmail">
        DELETE FROM Tlu_Admin_Emails  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <cffunction name="getCamera" returntype="any" output="false" access="public" >
        <cfquery name="qgetCamera" datasource="#variables.dsn#"  >
            SELECT * from TLU_Camera
        </cfquery>
	    <cfreturn qgetCamera>
    </cffunction>
    <cffunction name="getCameraByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetCamera" datasource="#variables.dsn#"  >
            SELECT * from TLU_Camera where [Camera] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetCamera>
    </cffunction>
    <cffunction name="EditCamera" returntype="any" output="false" access="public" >
         <cfquery name="qEditCamera" datasource="#variables.dsn#" result="CameraUpdate">
            UPDATE TLU_Camera SET Camera = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Camera#' >,
            active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
          </cfquery>
	<cfreturn CameraUpdate>
    </cffunction>
    <cffunction name="DeleteCamera" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteCamera" datasource="#variables.dsn#" result="CameraDelete">
            DELETE FROM TLU_Camera  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
<!--- Wave Height --->
    <cffunction name="WaveHeightInsert" returntype="any" output="false" access="public" >
        <cfquery name="qWaveHeightInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_WaveHight ([Desc],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.WaveHeight#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getWaveHeight" returntype="any" output="false" access="public" >
        <cfquery name="qgetWaveHeight" datasource="#variables.dsn#"  >
            SELECT * from TLU_WaveHight
        </cfquery>
        <cfreturn qgetWaveHeight>
    </cffunction>
    <cffunction name="getWaveHeightByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetWaveHeight" datasource="#variables.dsn#"  >
            SELECT * from TLU_WaveHight  where [Desc] like '%#form.searchword#%'
        </cfquery>
	<cfreturn qgetWaveHeight>
    </cffunction>
    <cffunction name="EditWaveHeight" returntype="any" output="false" access="public" >
     <cfquery name="qEditWaveHeight" datasource="#variables.dsn#" result="WaveHeightUpdate">
        UPDATE TLU_WaveHight SET [Desc] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.WaveHeight#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
     </cfquery>
     <cfreturn WaveHeightUpdate>
    </cffunction>
    <cffunction name="DeleteWaveHeight" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteWaveHeight" datasource="#variables.dsn#" result="WaveHeightDelete">
        DELETE FROM TLU_WaveHight  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
    <cffunction name="getpasswordfield" returnformat="plain" output="true"  access="remote" >
        <cfargument name ='pass' required="yes">
        <cfif pass EQ "12345">
            <cfreturn true>
            <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
<!--- weather--->
    <cffunction name="WeatherInsert" returntype="any" output="false" access="public" >
        <cfquery name="qWeatherInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Weather ([Desc],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Weather#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
	    <cfreturn return_data>
    </cffunction>
    <cffunction name="getWeather" returntype="any" output="false" access="public" >
        <cfquery name="qgetWeather" datasource="#variables.dsn#"  >
            SELECT * from TLU_Weather
        </cfquery>
	<cfreturn qgetWeather>
    </cffunction>
    <cffunction name="getWeatherByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetWeather" datasource="#variables.dsn#"  >
            SELECT * from TLU_Weather where [Desc] like '%#form.searchword#%'
        </cfquery>
	    <cfreturn qgetWeather>
        </cffunction>
    <cffunction name="EditWeather" returntype="any" output="false" access="public" >
         <cfquery name="qEditWeather" datasource="#variables.dsn#" result="WeatherUpdate">
            UPDATE TLU_Weather SET [Desc] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Weather#' >,
            active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
        <cfreturn WeatherUpdate>
        </cffunction>
    <cffunction name="DeleteWeather" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteWeather" datasource="#variables.dsn#" result="WeatherDelete">
        DELETE FROM TLU_Weather  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- Sightability--->
    <cffunction name="SightabilityInsert" returntype="any" output="false" access="public" >
        <cfquery name="qSightabilityInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Sightability ([Desc],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sightability#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getSightability" returntype="any" output="false" access="public" >
        <cfquery name="qgetSightability" datasource="#variables.dsn#"  >
            SELECT * from TLU_Sightability
        </cfquery>
        <cfreturn qgetSightability>
    </cffunction>
    <cffunction name="getSightabilityByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetSightability" datasource="#variables.dsn#"  >
            SELECT * from TLU_Sightability where [Desc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetSightability>
    </cffunction>
    <cffunction name="EditSightability" returntype="any" output="false" access="public" >
     <cfquery name="qEditSightability" datasource="#variables.dsn#" result="SightabilityUpdate">
        UPDATE TLU_Sightability SET [Desc] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sightability#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
     </cfquery>
     <cfreturn SightabilityUpdate>
    </cffunction>
    <cffunction name="DeleteSightability" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteSightability" datasource="#variables.dsn#" result="SightabilityDelete">
            DELETE FROM TLU_Sightability  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
<!--- Beaufort--->
    <cffunction name="BeaufortInsert" returntype="any" output="false" access="public" >
        <cfquery name="qBeaufortInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Beaufort ([Desc],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beaufort#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getBeaufort" returntype="any" output="false" access="public" >
        <cfquery name="qgetBeaufort" datasource="#variables.dsn#"  >
            SELECT * from TLU_Beaufort order by ID desc
        </cfquery>
        <cfreturn qgetBeaufort>
    </cffunction>
    <cffunction name="getBeaufortByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetBeaufort" datasource="#variables.dsn#"  >
            SELECT * from TLU_Beaufort where [Desc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetBeaufort>
    </cffunction>
    <cffunction name="EditBeaufort" returntype="any" output="false" access="public" >
     <cfquery name="qEditBeaufort" datasource="#variables.dsn#" result="BeaufortUpdate">
        UPDATE TLU_Beaufort SET [Desc] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Beaufort#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
     </cfquery>
     <cfreturn BeaufortUpdate>
    </cffunction>
    <cffunction name="DeleteBeaufort" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteBeaufort" datasource="#variables.dsn#" result="BeaufortDelete">
        DELETE FROM TLU_Beaufort  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>

<!--- SubType--->
    <cffunction name="SubTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qSubTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_SubType (SubType,SurveyTypeID,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SubType#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.surveyType#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="addDscoreInsert" returntype="any" output="false" access="public">
        <cfquery name="addDscoreInsert" datasource="#variables.dsn#" result="return_data">
        INSERT INTO TLU_Dscore (Dscore,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.addscore#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
       </cfquery>
    </cffunction>
    <cffunction name="addSourceSex" returntype="any" output="false" access="public">
        <cfquery name="addSourceSex" datasource="#variables.dsn#" result="return_data">
        INSERT INTO TLU_SourceSex(Ssex,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sourcesex#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
       </cfquery>
    </cffunction>
    <cffunction name="getSubType" returntype="any" output="false" access="public" >
        <cfquery name="qgetSubType" datasource="#variables.dsn#"  >
            SELECT s.*,t.Type from TLU_SubType s
            LEFT JOIN TLU_Type t on t.ID = s.SurveyTypeID 
        </cfquery>
        <cfreturn qgetSubType>
    </cffunction>
    <cffunction name="getDscore" returntype="any" output="false" access="public" >
        <cfquery name="getDscore" datasource="#variables.dsn#" >
        SELECT * from TLU_Dscore
        </cfquery>
        <cfreturn getDscore>
    </cffunction>
    <cffunction name="getsourceSex" returntype="any" output="false" access="public" >
        <cfquery name="getsourceSex" datasource="#variables.dsn#" >
        SELECT * from TLU_SourceSex
        </cfquery>
        <cfreturn getsourceSex>
    </cffunction>
    <cffunction name="EditDscore" returntype="any" output="false" access="public" >
        <cfquery name="EditDscore" datasource="#variables.dsn#" result="DscoreUpdate">
            UPDATE TLU_Dscore SET Dscore = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.addscore#' >,
            active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
        </cfquery>
        <cfreturn EditDscore>
    </cffunction>
    <cffunction name="editSourceSex" returntype="any" output="false" access="public" >
        <cfquery name="editSourceSex" datasource="#variables.dsn#" result="DscoreUpdate">
        UPDATE TLU_SourceSex SET Ssex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.sourcesex#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
        </cfquery>
        <cfreturn editSourceSex>
    </cffunction>
    <cffunction name="getSubTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetSubType" datasource="#variables.dsn#"  >
            SELECT * from TLU_SubType where [SubType] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetSubType>
    </cffunction>
    <cffunction name="EditSubType" returntype="any" output="false" access="public" >
         <cfquery name="qEditSubType" datasource="#variables.dsn#" result="SubTypeUpdate">
            UPDATE TLU_SubType SET SubType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.SubType#' >,
            SurveyTypeID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.surveyType#' >,
            active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
        <cfreturn SubTypeUpdate>
    </cffunction>
    <cffunction name="DeleteSubType" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteSubType" datasource="#variables.dsn#" result="SubTypeDelete">
            DELETE FROM TLU_SubType  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
    <cffunction name="DeleteDscore" returntype="any" output="false"  access="remote" >
        <cfquery name="DeleteDscore" datasource="#variables.dsn#" result="DeleteDscore">
        DELETE FROM TLU_Dscore  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <cffunction name="DeleteSourceSex" returntype="any" output="false"  access="remote" >
        <cfquery name="DeleteSourceSex" datasource="#variables.dsn#" result="DeleteDscore">
        DELETE FROM TLU_SourceSex  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
<!--- Type--->
    <cffunction name="TypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Type (Type,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Type#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getType" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Type
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="getTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Type where [Type] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="EditType" returntype="any" output="false" access="public" >
         <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
            UPDATE TLU_Type SET Type = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Type#' >,
            active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
        <cfreturn TypeUpdate>
    </cffunction>
    <cffunction name="DeleteType" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteType" datasource="#variables.dsn#" result="TypeDelete">
            DELETE FROM TLU_Type  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
<!--- Descriptor--->
    <cffunction name="DescriptorInsert" returntype="any" output="false" access="public" >
        <cfquery name="qDescriptorInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Descriptors (Descriptor) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Descriptor#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getDescriptor" returntype="any" output="false" access="public" >
        <cfquery name="qgetDescriptor" datasource="#variables.dsn#"  >
            SELECT * from TLU_Descriptors
        </cfquery>
        <cfreturn qgetDescriptor>
    </cffunction>
    <cffunction name="getDescriptorByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetDescriptor" datasource="#variables.dsn#"  >
            SELECT * from TLU_Descriptors where [Descriptor] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetDescriptor>
    </cffunction>
    <cffunction name="EditDescriptor" returntype="any" output="false" access="public" >
         <cfquery name="qEditDescriptor" datasource="#variables.dsn#" result="DescriptorUpdate">
            UPDATE TLU_Descriptors SET Descriptor = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Descriptor#' >
            WHERE DescriptorID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
          </cfquery>
	<cfreturn DescriptorUpdate>
    </cffunction>
    <cffunction name="DeleteDescriptor" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteDescriptor" datasource="#variables.dsn#" >
        DELETE FROM TLU_Descriptors   WHERE DescriptorID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- Dolphin Condition--->
    <cffunction name="DolphinConditionInsert" returntype="any" output="false" access="public" >
        <cfquery name="qDolphinConditionInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_ConditionOfDolphin (ConditionDesc) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ConditionDesc#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getDolphinCondition" returntype="any" output="false" access="public" >
        <cfquery name="qgetDolphinCondition" datasource="#variables.dsn#"  >
            SELECT * from TLU_ConditionOfDolphin
        </cfquery>
	    <cfreturn qgetDolphinCondition>
    </cffunction>
    <cffunction name="getDolphinConditionByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetDolphinCondition" datasource="#variables.dsn#"  >
            SELECT * from TLU_ConditionOfDolphin where [ConditionDesc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetDolphinCondition>
    </cffunction>
    <cffunction name="EditDolphinCondition" returntype="any" output="false" access="public" >
        <cfquery name="qEditDolphinCondition" datasource="#variables.dsn#" result="DolphinConditionUpdate">
        UPDATE TLU_ConditionOfDolphin SET ConditionDesc = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ConditionDesc#' >
        WHERE CONID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.CONID#' >
      </cfquery>
        <cfreturn DolphinConditionUpdate>
    </cffunction>
    <cffunction name="DeleteDolphinCondition" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteDolphinCondition" datasource="#variables.dsn#" >
            DELETE FROM TLU_ConditionOfDolphin   WHERE CONID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
<!--- Estimated Score--->
    <cffunction name="EstimatedScoreInsert" returntype="any" output="false" access="public" >
        <cfquery name="qgetID" datasource="#variables.dsn#"  >
                SELECT MAX(ES_ID) as E_ID from TLU_EmaciatedScore
            </cfquery>
            <cfset E_ID = val(qgetID.E_ID) + 1 >
            <cfquery name="qEstimatedScoreInsert" datasource="#variables.dsn#"  result="return_data" >
                INSERT INTO TLU_EmaciatedScore (ES_ID,EmaciatedScore) VALUES(<cfqueryparam  cfsqltype="cf_sql_integer" value="#E_ID#" >,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.EmaciatedScore#' >)
            </cfquery>
            <cfreturn return_data>
    </cffunction>
    <cffunction name="getEstimatedScore" returntype="any" output="false" access="public" >
        <cfquery name="qgetEstimatedScore" datasource="#variables.dsn#"  >
            SELECT * from TLU_EmaciatedScore
        </cfquery>
        <cfreturn qgetEstimatedScore>
    </cffunction>
    <cffunction name="getEstimatedScoreByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetEstimatedScore" datasource="#variables.dsn#"  >
            SELECT * from TLU_EmaciatedScore where [EmaciatedScore] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetEstimatedScore>
    </cffunction>
    <cffunction name="EditEstimatedScore" returntype="any" output="false" access="public" >
         <cfquery name="qEditEstimatedScore" datasource="#variables.dsn#" result="EstimatedScoreUpdate">
            UPDATE TLU_EmaciatedScore SET EmaciatedScore = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.EmaciatedScore#'>
            WHERE ES_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value="#FORM.ES_ID#" >
          </cfquery>
            <cfreturn EstimatedScoreUpdate>
    </cffunction>
    <cffunction name="DeleteEstimatedScore" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteEstimatedScore" datasource="#variables.dsn#" >
            DELETE FROM TLU_EmaciatedScore   WHERE ES_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
<!--- Team Members--->
    <cffunction name="TeamMembersInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTeamMembersInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_GET_TEAMMEMBERLIST_FROM_HERE (RT_MemberName) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RT_MemberName#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getTeamMembers" returntype="any" output="false" access="public" >
        <cfquery name="qgetTeamMembers" datasource="#variables.dsn#"  >
            SELECT * from TLU_GET_TEAMMEMBERLIST_FROM_HERE
        </cfquery>
        <cfreturn qgetTeamMembers>
    </cffunction>
    <cffunction name="getTeamMembersByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetTeamMembers" datasource="#variables.dsn#"  >
            SELECT * from TLU_GET_TEAMMEMBERLIST_FROM_HERE where [RT_MemberName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetTeamMembers>
    </cffunction>
    <cffunction name="EditTeamMembers" returntype="any" output="false" access="public" >
         <cfquery name="qEditTeamMembers" datasource="#variables.dsn#" result="TeamMembersUpdate">
            UPDATE TLU_GET_TEAMMEMBERLIST_FROM_HERE SET RT_MemberName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RT_MemberName#'>
            WHERE RT_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value="#FORM.RT_ID#" >
          </cfquery>
          <cfreturn TeamMembersUpdate>
     </cffunction>
    <cffunction name="DeleteTeamMembers" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteTeamMembers" datasource="#variables.dsn#" >
            DELETE FROM TLU_GET_TEAMMEMBERLIST_FROM_HERE   WHERE RT_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


        <!--- Survey Route--->
    <cffunction name="SurveyRouteInsert" returntype="any" output="false" access="public" >
        <cfquery name="qSurveyRouteInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_SurveyRoute ([RouteName],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RouteName#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getSurveyRoute" returntype="any" output="false" access="public" >
        <cfquery name="qgetSurveyRoute" datasource="#variables.dsn#" >
            SELECT * from TLU_SurveyRoute
        </cfquery>
        <cfreturn qgetSurveyRoute>
    </cffunction>
    <cffunction name="getSurveyRouteByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetSurveyRoute" datasource="#variables.dsn#"  >
            SELECT * from TLU_SurveyRoute where [RouteName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetSurveyRoute>
    </cffunction>
    <cffunction name="EditSurveyRoute" returntype="any" output="false" access="public" >
     <cfquery name="qEditSurveyRoute" datasource="#variables.dsn#" result="SurveyRouteUpdate">
        UPDATE TLU_SurveyRoute SET [RouteName] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RouteName#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn SurveyRouteUpdate>
     </cffunction>
    <cffunction name="DeleteSurveyRoute" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteSurveyRoute" datasource="#variables.dsn#" >
            DELETE FROM TLU_SurveyRoute   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


    <!--- Event Tracking List--->

    <cffunction name="TrackinInsert" returntype="any" output="false" access="public" >
     
        <cfquery name="qTrackinInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_TrackingList (species,code,code1,code2,cetaceanName,trackingDate,categories,comments,status) VALUES(
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.speciesee#' >
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.codee#' >
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.codee1#' >
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.codee2#' >
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cetaceanName#' >
                ,<cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.trackingDate#' >
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.categories#' >
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.comments#' >
                ,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
            )
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="editTrackingList" returntype="any" output="false" access="public" >
     <cfquery name="qeditTrackingList" datasource="#variables.dsn#" result="TrackingUpdate">
        UPDATE TLU_TrackingList SET 
                species = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.speciesee#' >
                ,code = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.codee#' >
                ,code1 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.codee1#' >
                ,code2 = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.codee2#' >
               , cetaceanName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.cetaceanName#' >
               ,trackingDate = <cfqueryparam cfsqltype="CF_SQL_DATE" value='#FORM.trackingDate#' >
                ,categories= <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.categories#' >
               ,comments = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.comments#' >
                ,status = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#'>
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.Track_id#' >
      </cfquery>
      <cfreturn TrackingUpdate>
    </cffunction>

    <cffunction name="getTrackingList" returntype="any" output="false" access="public" >
        <cfquery name="qgetTrackingList" datasource="#variables.dsn#" >
            SELECT * from TLU_TrackingList
        </cfquery>
        <cfreturn qgetTrackingList>
    </cffunction>
    <cffunction name="getTrackingListByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetTrackingList" datasource="#variables.dsn#"  >
            SELECT * from TLU_TrackingList where 
            species like '%#form.searchword#%'
            OR 
            code like '%#form.searchword#%'
            OR 
            cetaceanName like '%#form.searchword#%'
            OR 
            categories like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetTrackingList>
    </cffunction>
    
    <cffunction name="DeleteTrackingList" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteTrackingList" datasource="#variables.dsn#" >
            DELETE FROM TLU_TrackingList   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Behaviors--->

    <cffunction name="BehaviorInsert" returntype="any" output="false" access="public" >
        <cfquery name="qBehaviorInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Behaviors ([BehaviorName],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BehaviorName#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getBehavior" returntype="any" output="false" access="public" >
        <cfquery name="qgetBehavior" datasource="#variables.dsn#" >
            SELECT * from TLU_Behaviors
        </cfquery>
        <cfreturn qgetBehavior>
    </cffunction>
    <cffunction name="getBehaviorByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetBehavior" datasource="#variables.dsn#"  >
            SELECT * from TLU_Behaviors where [BehaviorName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetBehavior>
    </cffunction>
    <cffunction name="EditBehavior" returntype="any" output="false" access="public" >
     <cfquery name="qEditBehavior" datasource="#variables.dsn#" result="BehaviorUpdate">
        UPDATE TLU_Behaviors SET [BehaviorName] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.BehaviorName#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn BehaviorUpdate>
     </cffunction>

    

    <cffunction name="DeleteBehavior" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteBehavior" datasource="#variables.dsn#" >
            DELETE FROM TLU_Behaviors   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


    <!--- LesionType --->
    <cffunction name="LesionTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qLesionTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_LesionType ([LesionTypeName],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LesionTypeName#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getLesionType" returntype="any" output="false" access="public" >
        <cfquery name="qgetLesionType" datasource="#variables.dsn#" >
            SELECT * from TLU_LesionType
        </cfquery>
        <cfreturn qgetLesionType>
    </cffunction>
    <cffunction name="getLesionTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetLesionType" datasource="#variables.dsn#"  >
            SELECT * from TLU_LesionType where [LesionTypeName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetLesionType>
    </cffunction>

    <!---start scar  --->
    <cffunction name="getScarType" returntype="any" output="false" access="public" >
        <cfquery name="qgetScarType" datasource="#variables.dsn#" >
            SELECT * from TLU_ScarType
        </cfquery>
        <cfreturn qgetScarType>
    </cffunction>
    <cffunction name="getScarTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetScarType" datasource="#variables.dsn#"  >
            SELECT * from TLU_ScarType where [ScarTypeName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetScarType>
    </cffunction>

    <cffunction name="ScarTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qLesionTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_ScarType ([ScarTypeName],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ScarTypeName#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="EditScarType" returntype="any" output="false" access="public" >
        <cfquery name="qEditLesionType" datasource="#variables.dsn#" result="ScarTypeName">
           UPDATE TLU_ScarType SET [ScarTypeName] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ScarTypeName#' >,
           active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn ScarTypeName>
    </cffunction>
    <cffunction name="DeleteScarType" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteScarType" datasource="#variables.dsn#" >
           DELETE FROM TLU_ScarType  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
         </cfquery>
   </cffunction>

   <cffunction name="getActiveScarType" returntype="any" output="false" access="public" >
        
    <cfquery name="qgetActiveDescription" datasource="#variables.dsn#"  result="return_data" >
        SELECT * from TLU_ScarType WHERE active = 1
    </cfquery>
    <cfreturn qgetActiveDescription>
</cffunction>
     <!---end scar  --->

    <cffunction name="EditLesionType" returntype="any" output="false" access="public" >
     <cfquery name="qEditLesionType" datasource="#variables.dsn#" result="LesionTypeUpdate">
        UPDATE TLU_LesionType SET [LesionTypeName] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LesionTypeName#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn LesionTypeUpdate>
     </cffunction>
    <cffunction name="DeleteLesionType" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteLesionType" datasource="#variables.dsn#" >
            DELETE FROM TLU_LesionType  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


     <!--- Prey Species --->
    <cffunction name="PreySpeciesInsert" returntype="any" output="false" access="public" >
        <cfquery name="qPreySpeciesInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_PreySpecies ([PreySpeciesName],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PreySpeciesName#'>,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getPreySpecies" returntype="any" output="false" access="public" >
        <cfquery name="qgetPreySpecies" datasource="#variables.dsn#" >
            SELECT * from TLU_PreySpecies
        </cfquery>
        <cfreturn qgetPreySpecies>
    </cffunction>
    <cffunction name="getPreySpeciesByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetPreySpecies" datasource="#variables.dsn#"  >
            SELECT * from TLU_PreySpecies where [PreySpeciesName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetPreySpecies>
    </cffunction>
    <cffunction name="EditPreySpecies" returntype="any" output="false" access="public" >
     <cfquery name="qEditPreySpecies" datasource="#variables.dsn#" result="PreySpeciesUpdate">
        UPDATE TLU_PreySpecies SET [PreySpeciesName] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.PreySpeciesName#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn PreySpeciesUpdate>
     </cffunction>
    <cffunction name="DeletePreySpecies" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeletePreySpecies" datasource="#variables.dsn#" >
            DELETE FROM TLU_PreySpecies   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


     <!--- Cetacean Response To Fisher  --->
    <cffunction name="CetaceanResponseToFisherInsert" returntype="any" output="false" access="public" >
        <cfquery name="qCetaceanResponseToFisherInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_CetaceanResponseToFisher ([Desc],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Desc#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getCetaceanResponseToFisher" returntype="any" output="false" access="public" >
        <cfquery name="qgetCetaceanResponseToFisher" datasource="#variables.dsn#"  >
            SELECT * from TLU_CetaceanResponseToFisher
        </cfquery>
        <cfreturn qgetCetaceanResponseToFisher>
    </cffunction>
    <cffunction name="getCetaceanResponseToFisherByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetCetaceanResponseToFisher" datasource="#variables.dsn#"  >
            SELECT * from TLU_CetaceanResponseToFisher where [Desc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetCetaceanResponseToFisher>
    </cffunction>
    <cffunction name="EditCetaceanResponseToFisher" returntype="any" output="false" access="public" >
     <cfquery name="qEditCetaceanResponseToFisher" datasource="#variables.dsn#" result="CetaceanResponseToFisherUpdate">
        UPDATE TLU_CetaceanResponseToFisher SET [Desc] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Desc#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn CetaceanResponseToFisherUpdate>
     </cffunction>
    <cffunction name="DeleteCetaceanResponseToFisher" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteCetaceanResponseToFisher" datasource="#variables.dsn#" >
            DELETE FROM TLU_CetaceanResponseToFisher WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


     <!--- Fisher Response To Cetacean --->
    <cffunction name="FisherResponseToCetaceanInsert" returntype="any" output="false" access="public" >
        <cfquery name="qFisherResponseToCetaceanInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_FisherResponseToCetacean ([Desc],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Desc#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getFisherResponseToCetacean" returntype="any" output="false" access="public" >
        <cfquery name="qgetFisherResponseToCetacean" datasource="#variables.dsn#"  >
            SELECT * from TLU_FisherResponseToCetacean
        </cfquery>
        <cfreturn qgetFisherResponseToCetacean>
    </cffunction>
    <cffunction name="getFisherResponseToCetaceanByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetFisherResponseToCetacean" datasource="#variables.dsn#"  >
            SELECT * from TLU_FisherResponseToCetacean where [Desc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetFisherResponseToCetacean>
    </cffunction>
    <cffunction name="EditFisherResponseToCetacean" returntype="any" output="false" access="public" >
     <cfquery name="qEditFisherResponseToCetacean" datasource="#variables.dsn#" result="FisherResponseToCetaceanUpdate">
        UPDATE TLU_FisherResponseToCetacean SET [Desc] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Desc#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn FisherResponseToCetaceanUpdate>
     </cffunction>
    <cffunction name="DeleteFisherResponseToCetacean" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteFisherResponseToCetacean" datasource="#variables.dsn#">
            DELETE FROM TLU_FisherResponseToCetacean WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>

     <!--- Cetacean Response to Vessel --->
    <cffunction name="CetaceanResponseToVesselInsert" returntype="any" output="false" access="public" >
        <cfquery name="qCetaceanResponseToVesselInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_CetaceanResponseToVessel ([Desc],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Desc#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getCetaceanResponseToVessel" returntype="any" output="false" access="public" >
        <cfquery name="qgetCetaceanResponseToVessel" datasource="#variables.dsn#"  >
            SELECT * from TLU_CetaceanResponseToVessel
        </cfquery>
        <cfreturn qgetCetaceanResponseToVessel>
    </cffunction>
    <cffunction name="getCetaceanResponseToVesselByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetCetaceanResponseToVessel" datasource="#variables.dsn#"  >
            SELECT * from TLU_CetaceanResponseToVessel where [Desc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetCetaceanResponseToVessel>
    </cffunction>
    <cffunction name="EditCetaceanResponseToVessel" returntype="any" output="false" access="public" >
     <cfquery name="qEditCetaceanResponseToVessel" datasource="#variables.dsn#" result="CetaceanResponseToVesselUpdate">
        UPDATE TLU_CetaceanResponseToVessel SET [Desc] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Desc#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn CetaceanResponseToVesselUpdate>
     </cffunction>
    <cffunction name="DeleteCetaceanResponseToVessel" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteCetaceanResponseToVessel" datasource="#variables.dsn#" >
            DELETE FROM TLU_CetaceanResponseToVessel WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


         <!--- Vessel Response to Cetacean --->
    <cffunction name="VesselResponseToCetaceanInsert" returntype="any" output="false" access="public" >
        <cfquery name="qVesselResponseToCetaceanInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_VesselResponseToCetacean ([Desc],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Desc#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getVesselResponseToCetacean" returntype="any" output="false" access="public" >
        <cfquery name="qgetVesselResponseToCetacean" datasource="#variables.dsn#"  >
            SELECT * from TLU_VesselResponseToCetacean
        </cfquery>
        <cfreturn qgetVesselResponseToCetacean>
    </cffunction>
    <cffunction name="getVesselResponseToCetaceanByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetVesselResponseToCetacean" datasource="#variables.dsn#"  >
            SELECT * from TLU_VesselResponseToCetacean where [Desc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetVesselResponseToCetacean>
    </cffunction>
    <cffunction name="EditVesselResponseToCetacean" returntype="any" output="false" access="public" >
     <cfquery name="qEditVesselResponseToCetacean" datasource="#variables.dsn#" result="VesselResponseToCetaceanUpdate">
        UPDATE TLU_VesselResponseToCetacean SET [Desc] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Desc#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn VesselResponseToCetaceanUpdate>
     </cffunction>
    <cffunction name="DeleteVesselResponseToCetacean" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteVesselResponseToCetacean" datasource="#variables.dsn#" >
            DELETE FROM TLU_VesselResponseToCetacean WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


    <!--- CetaceanSpecies --->
    <cffunction name="CetaceanSpeciesInsert" returntype="any" output="false" access="public" >
        <cfquery name="qCetaceanSpeciesInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_CetaceanSpecies (CetaceanSpeciesName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CetaceanSpeciesName#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getCetaceanSpecies" returntype="any" output="false" access="public" >
        <cfquery name="qgetCetaceanSpecies" datasource="#variables.dsn#"  >
            SELECT * from TLU_CetaceanSpecies ORDER BY CetaceanSpeciesName
        </cfquery>
        <cfreturn qgetCetaceanSpecies>
    </cffunction>
    <cffunction name="getCetaceancode" returntype="any" output="false" access="remote" returnformat="json">
        <cfquery name="qcetaceans" datasource="#variables.dsn#">
           
            SELECT Cetaceans.ID,Cetaceans.Code,TLU_CetaceanSpecies.CetaceanSpeciesName
            FROM Cetaceans
            LEFT JOIN TLU_CetaceanSpecies
            ON Cetaceans.CetaceanSpecies = TLU_CetaceanSpecies.ID

            WHERE TLU_CetaceanSpecies.CetaceanSpeciesName = '#codes#'
            order by code Asc
        </cfquery>
        <cfreturn qcetaceans>
    </cffunction>
    <!--- get code according id --->
    <cffunction name="getCetaceancodebyID" returntype="any" output="false" access="remote" returnformat="json">
        <cfquery name="qcetaceansbyid" datasource="#variables.dsn#">
           
            SELECT Cetaceans.ID,Cetaceans.Code,TLU_CetaceanSpecies.CetaceanSpeciesName
            FROM Cetaceans
            LEFT JOIN TLU_CetaceanSpecies
            ON Cetaceans.CetaceanSpecies = TLU_CetaceanSpecies.ID

            WHERE TLU_CetaceanSpecies.id = '#codes#'
            order by code Asc
        </cfquery>
        <cfreturn qcetaceansbyid>
    </cffunction>
    <cffunction name="getCetaceanSpeciesByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetCetaceanSpecies" datasource="#variables.dsn#"  >
            SELECT * from TLU_CetaceanSpecies where CetaceanSpeciesName like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetCetaceanSpecies>
    </cffunction>
    <cffunction name="EditCetaceanSpecies" returntype="any" output="false" access="public" >
     <cfquery name="qEditCetaceanSpecies" datasource="#variables.dsn#" result="CetaceanSpeciesUpdate">
        UPDATE TLU_CetaceanSpecies SET CetaceanSpeciesName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CetaceanSpeciesName#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn CetaceanSpeciesUpdate>
     </cffunction>
    <cffunction name="DeleteCetaceanSpecies" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteCetaceanSpecies" datasource="#variables.dsn#" >
            DELETE FROM TLU_CetaceanSpecies   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


    <!--- IR County Location --->
    <cffunction name="IR_CountyLocationInsert" returntype="any" output="false" access="public" >
        <cfquery name="qIR_CountyLocationInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_IR_CountyLocation (IR_CountyLocation,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.IR_CountyLocation#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getIR_CountyLocation" returntype="any" output="false" access="public" >
        <cfquery name="qgetIR_CountyLocation" datasource="#variables.dsn#"  >
            SELECT * from TLU_IR_CountyLocation
        </cfquery>
        <cfreturn qgetIR_CountyLocation>
    </cffunction>
    <cffunction name="getIR_CountyLocationByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetIR_CountyLocation" datasource="#variables.dsn#"  >
            SELECT * from TLU_IR_CountyLocation where IR_CountyLocation like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetIR_CountyLocation>
    </cffunction>
    <cffunction name="EditIR_CountyLocation" returntype="any" output="false" access="public" >
     <cfquery name="qEditIR_CountyLocation" datasource="#variables.dsn#" result="IR_CountyLocationUpdate">
        UPDATE TLU_IR_CountyLocation SET IR_CountyLocation = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.IR_CountyLocation#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn IR_CountyLocationUpdate>
     </cffunction>
    <cffunction name="DeleteIR_CountyLocation" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteIR_CountyLocation" datasource="#variables.dsn#">
            DELETE FROM TLU_IR_CountyLocation WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>


<!--- Glare--->
    <cffunction name="GlareInsert" returntype="any" output="false" access="public" >
        <cfquery name="qgetID" datasource="#variables.dsn#"  >
            SELECT MAX(id) as glare_id from TLU_Glare
        </cfquery>
        <cfset glare_id = val(qgetID.glare_id) + 1 >
        <cfquery name="qGlareInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Glare ([DESC],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.DESC#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getGlare" returntype="any" output="false" access="public" >
        <cfquery name="qgetGlare" datasource="#variables.dsn#"  >
            SELECT * from TLU_Glare
        </cfquery>
        <cfreturn qgetGlare>
    </cffunction>
    <cffunction name="getGlareByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetGlare" datasource="#variables.dsn#"  >
            SELECT * from TLU_Glare where [Desc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetGlare>
    </cffunction>
    <cffunction name="EditGlare" returntype="any" output="false" access="public" >
     <cfquery name="qEditGlare" datasource="#variables.dsn#" result="GlareUpdate">
        UPDATE TLU_Glare SET [DESC] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.DESC#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn GlareUpdate>
     </cffunction>
    <cffunction name="DeleteGlare" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteGlare" datasource="#variables.dsn#" >
            DELETE FROM TLU_Glare   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>

   <!--- Glare Direction--->
    <cffunction name="GlareDirectionInsert" returntype="any" output="false" access="public" >
        <cfquery name="qgetID" datasource="#variables.dsn#"  >
            SELECT MAX(id) as glareDirection_id from TLU_GlareDirection
        </cfquery>
        <cfset glareDirection_id = val(qgetID.glareDirection_id) + 1 >
        <cfquery name="qGlareDirectionInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_GlareDirection ([DESC],active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.DESC#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getGlareDirection" returntype="any" output="false" access="public" >
        <cfquery name="qgetGlareDirection" datasource="#variables.dsn#"  >
            SELECT * from TLU_GlareDirection
        </cfquery>
        <cfreturn qgetGlareDirection>
    </cffunction>
    <cffunction name="getGlareDirectionByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetGlareDirection" datasource="#variables.dsn#"  >
            SELECT * from TLU_GlareDirection where [Desc] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetGlareDirection>
    </cffunction>
     <cffunction name="EditGlareDirection" returntype="any" output="false" access="public" >
         <cfquery name="qEditGlareDirection" datasource="#variables.dsn#" result="GlareDirectionUpdate">
            UPDATE TLU_GlareDirection SET [DESC] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.DESC#' >,
            active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
        </cfquery>
        <cfreturn GlareDirectionUpdate>
     </cffunction>
     <cffunction name="DeleteGlareDirection" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteGlareDirection" datasource="#variables.dsn#" >
            DELETE FROM TLU_GlareDirection   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>

    <!--- Initial  Heading--->
    <cffunction name="HeadingInsert" returntype="any" output="false" access="public" >
        <cfquery name="qHeadingInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Heading (HeadingName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Heading#' >,<cfqueryparam  cfsqltype="cf_sql_integer" value='#active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getHeading" returntype="any" output="false" access="public" >
        <cfquery name="qgetHeading" datasource="#variables.dsn#"  >
            SELECT * from TLU_Heading
        </cfquery>
        <cfreturn qgetHeading>
    </cffunction>
    <cffunction name="getHeadingByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetHeading" datasource="#variables.dsn#"  >
            SELECT * from TLU_Heading where [HeadingName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetHeading>
    </cffunction>
    <cffunction name="EditHeading" returntype="any" output="false" access="public" >
         <cfquery name="qEditHeading" datasource="#variables.dsn#" result="HeadingUpdate">
            UPDATE TLU_Heading SET HeadingName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Heading#' >,
            active = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
          </cfquery>
            <cfreturn HeadingUpdate>
    </cffunction>
    <cffunction name="DeleteHeading" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteHeading" datasource="#variables.dsn#" >
        DELETE FROM TLU_Heading   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>


     <!---General Heading--->
    <cffunction name="GHeadingInsert" returntype="any" output="false" access="public" >
        <cfquery name="qGHeadingInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_GeneralHeading (GHeadingName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GHeading#' >,<cfqueryparam  cfsqltype="cf_sql_integer" value='#active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getGHeading" returntype="any" output="false" access="public" >
        <cfquery name="qgetGHeading" datasource="#variables.dsn#"  >
            SELECT * from TLU_GeneralHeading
        </cfquery>
        <cfreturn qgetGHeading>
    </cffunction>
    <cffunction name="getGHeadingByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetGHeading" datasource="#variables.dsn#"  >
            SELECT * from TLU_GeneralHeading where [GHeadingName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetGHeading>
    </cffunction>
    <cffunction name="EditGHeading" returntype="any" output="false" access="public" >
         <cfquery name="qEditGHeading" datasource="#variables.dsn#" result="HeadingGUpdate">
            UPDATE TLU_GeneralHeading SET GHeadingName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GHeading#' >,
            active = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
          </cfquery>
            <cfreturn HeadingGUpdate>
    </cffunction>
    <cffunction name="DeleteGHeading" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteGHeading" datasource="#variables.dsn#" >
        DELETE FROM TLU_GeneralHeading   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>


      <!---Final  Heading--->
    <cffunction name="FHeadingInsert" returntype="any" output="false" access="public" >
        <cfquery name="qFHeadingInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_FinalHeading (FHeadingName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FHeading#' >,<cfqueryparam  cfsqltype="cf_sql_integer" value='#active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getFHeading" returntype="any" output="false" access="public" >
        <cfquery name="qgetFHeading" datasource="#variables.dsn#"  >
            SELECT * from TLU_FinalHeading
        </cfquery>
        <cfreturn qgetFHeading>
    </cffunction>
    <cffunction name="getFHeadingByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetFHeading" datasource="#variables.dsn#"  >
            SELECT * from TLU_FinalHeading where [FHeadingName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetFHeading>
    </cffunction>
    <cffunction name="EditFHeading" returntype="any" output="false" access="public" >
         <cfquery name="qEditFHeading" datasource="#variables.dsn#" result="HeadingFUpdate">
            UPDATE TLU_FinalHeading SET FHeadingName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.FHeading#' >,
            active = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
          </cfquery>
            <cfreturn HeadingFUpdate>
    </cffunction>
    <cffunction name="DeleteFHeading" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteFHeading" datasource="#variables.dsn#" >
        DELETE FROM TLU_FinalHeading   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>

<!--- AssocBio--->
    <cffunction name="AssocBioInsert" returntype="any" output="false" access="public" >
        <cfquery name="qAssocBioInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_AssocBioData (AssocBioName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AssocBio#' >,<cfqueryparam  cfsqltype="cf_sql_integer" value='#active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getAssocBio" returntype="any" output="false" access="public" >
        <cfquery name="qgetAssocBio" datasource="#variables.dsn#"  >
            SELECT * from TLU_AssocBioData
        </cfquery>
        <cfreturn qgetAssocBio>
    </cffunction>
    <cffunction name="getAssocBioByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetAssocBio" datasource="#variables.dsn#"  >
            SELECT * from TLU_AssocBioData where [AssocBioName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetAssocBio>
    </cffunction>
    <cffunction name="EditAssocBio" returntype="any" output="false" access="public" >
         <cfquery name="qEditAssocBio" datasource="#variables.dsn#" result="AssocBioUpdate">
            UPDATE TLU_AssocBioData SET AssocBioName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AssocBio#' >,
            active = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.active#' >
            WHERE ASSOCBIOID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
          </cfquery>
            <cfreturn AssocBioUpdate>
    </cffunction>
    <cffunction name="DeleteAssocBio" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteAssocBio" datasource="#variables.dsn#" >
        DELETE FROM TLU_AssocBioData   WHERE ASSOCBIOID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>

<!--- Tide --->
    <cffunction name="getTide" returntype="any" output="false" access="public" >
        <cfquery name="qgetTide" datasource="#variables.dsn#"  >
            SELECT * from TLU_Tide <!---where active = 1--->
        </cfquery>
        <cfreturn qgetTide>
    </cffunction>
    <cffunction name="TideInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTideInsert" datasource="#variables.dsn#"  result="return_data" >
     	    INSERT INTO TLU_Tide (TideName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TideName#' >,<cfqueryparam  cfsqltype="cf_sql_integer" value='#active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="EditTide" returntype="any" output="false" access="public" >
        <cfquery name="qEditTide" datasource="#variables.dsn#" result="TideUpdate">
            UPDATE TLU_Tide SET TideName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TideName#' >,
            active = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.active#' >
            WHERE TideID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
        </cfquery>
        <cfreturn TideUpdate>
    </cffunction>
    <cffunction name="DeleteTide" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteTide" datasource="#variables.dsn#" >
            DELETE FROM TLU_Tide   WHERE TideID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <cffunction name="getTideByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetTide" datasource="#variables.dsn#"  >
            SELECT * from TLU_Tide where [TideName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetTide>
    </cffunction>
<!---Habitat--->
    <cffunction name="HabitatInsert" returntype="any" output="false" access="public" >
        <cfquery name="qHabitatInsert" datasource="#variables.dsn#"  result="return_data" >
     	    INSERT INTO TLU_Habitat (HabitatName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Habitat#' >,<cfqueryparam  cfsqltype="cf_sql_integer" value='#active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="DeleteHabitat" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteTide" datasource="#variables.dsn#" >
            DELETE FROM TLU_Habitat   WHERE HabitatID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <cffunction name="EditHabitat" returntype="any" output="false" access="public" >
        <cfquery name="qEditHabitat" datasource="#variables.dsn#" result="HabitatUpdate">
    UPDATE TLU_Habitat SET HabitatName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Habitat#' >,
    active = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.active#' >
    WHERE HabitatID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
        </cfquery>
        <cfreturn HabitatUpdate>
    </cffunction>
    <cffunction name="getHabitat" returntype="any" output="false" access="public" >
        <cfquery name="qgethabitat" datasource="#variables.dsn#"  >
        SELECT * from TLU_Habitat
    </cfquery>
        <cfreturn qgethabitat>
    </cffunction>
    <cffunction name="getHabitatBioByword" returntype="any" output="false" access="public" >
        <cfquery name="qgethabitat" datasource="#variables.dsn#"  >
        SELECT * from TLU_Habitat where [HabitatName] like '%#form.searchword#%'
    </cfquery>
        <cfreturn qgethabitat>
    </cffunction>
<!--- structure --->
    <cffunction name="structureInsert" returntype="any" output="false" access="public" >
        <cfquery name="qstructureInsert" datasource="#variables.dsn#"  result="return_data" >
     	INSERT INTO TLU_Structures (Name,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sname#' >,<cfqueryparam  cfsqltype="cf_sql_integer" value='#active#' >)
    </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getStructure" returntype="any" output="false" access="public" >
        <cfquery name="qgetStructure" datasource="#variables.dsn#"  >
        SELECT * from TLU_Structures
    </cfquery>
        <cfreturn qgetStructure>
    </cffunction>
    <cffunction name="EditStructure" returntype="any" output="false" access="public" >
        <cfquery name="qEditStructure" datasource="#variables.dsn#" result="stryctureUpdate">
            UPDATE TLU_Structures SET Name = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Sname#' >,
            active = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
        </cfquery>
        <cfreturn stryctureUpdate>
    </cffunction>
    <cffunction name="DeleteStructure" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteStructure" datasource="#variables.dsn#" >
            DELETE FROM TLU_Structures   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <cffunction name="getStructureByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetword" datasource="#variables.dsn#"  >
            SELECT * from TLU_Structures where [Name] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetword>
    </cffunction>
<!--- IlOC--->
    <cffunction name="IlocInsert" returntype="any" output="false" access="public" >
        <cfquery name="qIlocInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_ILoc (name) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.name#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getIloc" returntype="any" output="false" access="public" >
        <cfquery name="qgetIloc" datasource="#variables.dsn#"  >
            SELECT * from TLU_ILoc
        </cfquery>
        <cfreturn qgetIloc>
    </cffunction>
    <cffunction name="getIlocByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetIloc" datasource="#variables.dsn#"  >
            SELECT * from TLU_ILoc where [name] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetIloc>
    </cffunction>
    <cffunction name="EditIloc" returntype="any" output="false" access="public" >
         <cfquery name="qEditIloc" datasource="#variables.dsn#" result="AssocBioUpdate">
            UPDATE TLU_ILoc SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.name#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
          </cfquery>
        <cfreturn AssocBioUpdate>
    </cffunction>
    <cffunction name="DeleteIloc" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteIloc" datasource="#variables.dsn#" >
        DELETE FROM TLU_ILoc   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- Interaction--->
    <cffunction name="InteractionInsert" returntype="any" output="false" access="public" >
        <cfquery name="qInteractionInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Interaction (Description) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Description#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getInteraction" returntype="any" output="false" access="public" >
        <cfquery name="qgetInteraction" datasource="#variables.dsn#"  >
            SELECT * from TLU_Interaction
        </cfquery>
        <cfreturn qgetInteraction>
    </cffunction>
    <cffunction name="getInteractionByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetInteraction" datasource="#variables.dsn#"  >
            SELECT * from TLU_Interaction where [Description] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetInteraction>
    </cffunction>
    <cffunction name="EditInteraction" returntype="any" output="false" access="public" >
     <cfquery name="qEditInteraction" datasource="#variables.dsn#" result="InteractionUpdate">
        UPDATE TLU_Interaction SET Description = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Description#' >
        WHERE INT_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.INT_ID#' >
      </cfquery>
        <cfreturn InteractionUpdate>
    </cffunction>
    <cffunction name="DeleteInteraction" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteInteraction" datasource="#variables.dsn#" >
        DELETE FROM TLU_Interaction   WHERE INT_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- Lens--->
    <cffunction name="LensInsert" returntype="any" output="false" access="public" >
        <cfquery name="qLensInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Lens (Lens,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lens#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getLens" returntype="any" output="false" access="public" >
        <cfquery name="qgetLens" datasource="#variables.dsn#"  >
            SELECT * from TLU_Lens
        </cfquery>
        <cfreturn qgetLens>
    </cffunction>
    <cffunction name="getLensByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetLens" datasource="#variables.dsn#"  >
            SELECT * from TLU_Lens where [Lens] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetLens>
    </cffunction>
    <cffunction name="EditLens" returntype="any" output="false" access="public" >
     <cfquery name="qEditLens" datasource="#variables.dsn#" result="LensUpdate">
        UPDATE TLU_Lens SET Lens = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Lens#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn LensUpdate>
     </cffunction>
    <cffunction name="DeleteLens" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteLens" datasource="#variables.dsn#" >
        DELETE FROM TLU_Lens   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- Stock--->
    <cffunction name="StockInsert" returntype="any" output="false" access="public" >
        <cfquery name="qStockInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Stock (StockName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Stock#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getStock" returntype="any" output="false" access="public" >
        <cfquery name="qgetStock" datasource="#variables.dsn#"  >
            SELECT * from TLU_Stock
        </cfquery>
        <cfreturn qgetStock>
    </cffunction>
    <cffunction name="getStockByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetStock" datasource="#variables.dsn#"  >
            SELECT * from TLU_Stock where [StockName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetStock>
    </cffunction>
    <cffunction name="EditStock" returntype="any" output="false" access="public" >
     <cfquery name="qEditStock" datasource="#variables.dsn#" result="StockUpdate">
        UPDATE TLU_Stock SET StockName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Stock#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn StockUpdate>
     </cffunction>
    <cffunction name="DeleteStock" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteStock" datasource="#variables.dsn#" >
        DELETE FROM TLU_Stock   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- Plate Form--->
    <cffunction name="PlateFormInsert" returntype="any" output="false" access="public" >
        <cfquery name="qPlateFormInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Platform (Name,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Name#" >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getPlateForm" returntype="any" output="false" access="public" >
        <cfquery name="qgetPlateForm" datasource="#variables.dsn#"  >
            SELECT * from TLU_Platform
        </cfquery>
        <cfreturn qgetPlateForm>
    </cffunction>
    <cffunction name="getPlateFormByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetPlateForm" datasource="#variables.dsn#"  >
            SELECT * from TLU_Platform where [Name] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetPlateForm>
    </cffunction>
    <cffunction name="EditPlateForm" returntype="any" output="false" access="public" >
     <cfquery name="qEditPlateForm" datasource="#variables.dsn#" result="PlateFormUpdate">
        UPDATE TLU_Platform SET Name = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Name#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn PlateFormUpdate>
    </cffunction>
    <cffunction name="DeletePlateForm" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeletePlateForm" datasource="#variables.dsn#" >
            DELETE FROM TLU_Platform   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
<!--- Research Team Members--->
    <cffunction name="ResearchTeamMembersInsert" returntype="any" output="false" access="public" >
        <cfquery name="qResearchTeamMembersInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_ResearchTeamMembers (RT_MemberName,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RT_MemberName#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getResearchTeamMembers" returntype="any" output="false" access="public" >
        <cfquery name="qgetResearchTeamMembers" datasource="#variables.dsn#"  >
            SELECT * from TLU_ResearchTeamMembers <!---where active = 1--->
        </cfquery>
        <cfreturn qgetResearchTeamMembers>
    </cffunction>
    <cffunction name="getResearchTeamMembersByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetResearchTeamMembers" datasource="#variables.dsn#"  >
            SELECT * from TLU_ResearchTeamMembers where [RT_MemberName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetResearchTeamMembers>
    </cffunction>
    <cffunction name="EditResearchTeamMembers" returntype="any" output="false" access="public" >
         <cfquery name="qEditResearchTeamMembers" datasource="#variables.dsn#" result="ResearchTeamMembersUpdate">
            UPDATE TLU_ResearchTeamMembers SET RT_MemberName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.RT_MemberName#' >,
            active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE RT_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.RT_ID#' >
          </cfquery>
            <cfreturn ResearchTeamMembersUpdate>
    </cffunction>
    <cffunction name="DeleteResearchTeamMembers" returntype="any" output="true"  access="remote" >
     <cfquery name="qDeleteResearchTeamMembers" datasource="#variables.dsn#" >
        DELETE FROM TLU_ResearchTeamMembers   WHERE RT_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- SDO--->
    <cffunction name="SDOInsert" returntype="any" output="false" access="public" >
        <cfquery name="qSDOInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_SDO (Name) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Name#" >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getSDO" returntype="any" output="false" access="public" >
        <cfquery name="qgetSDO" datasource="#variables.dsn#"  >
            SELECT * from TLU_SDO
        </cfquery>
        <cfreturn qgetSDO>
    </cffunction>
    <cffunction name="getSDOByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetSDO" datasource="#variables.dsn#"  >
            SELECT * from TLU_SDO where [Name] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetSDO>
    </cffunction>
    <cffunction name="EditSDO" returntype="any" output="false" access="public" >
     <cfquery name="qEditSDO" datasource="#variables.dsn#" result="SDOUpdate">
        UPDATE TLU_SDO SET Name = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Name#' >
        WHERE SDO_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.SDO_ID#' >
      </cfquery>
        <cfreturn SDOUpdate>
    </cffunction>
    <cffunction name="DeleteSDO" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteSDO" datasource="#variables.dsn#" >
        DELETE FROM TLU_SDO   WHERE SDO_ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- Survey Area--->
    <cffunction name="SurveyAreaInsert" returntype="any" output="false" access="public" >
        <cfquery name="qSurveyAreaInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_SurveyArea (AreaName,StockID,Active) VALUES(
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.AreaName#" >,
                                        <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.stock#' >,
                                        <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getSurveyArea" returntype="any" output="false" access="public" >
        <cfquery name="qgetSurveyArea" datasource="#variables.dsn#"  >
            SELECT a.*,s.StockName from TLU_SurveyArea a
            LEFT JOIN TLU_Stock s on a.StockID = s.ID
        </cfquery>
	    <cfreturn qgetSurveyArea>
    </cffunction>
    <cffunction name="getSurveyAreaByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetSurveyArea" datasource="#variables.dsn#"  >
            SELECT * from TLU_SurveyArea  where [AreaName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetSurveyArea>
    </cffunction>
    <cffunction name="EditSurveyArea" returntype="any" output="false" access="public" >
         <cfquery name="qEditSurveyArea" datasource="#variables.dsn#" result="SurveyAreaUpdate">
            UPDATE TLU_SurveyArea SET
            AreaName = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.AreaName#' >,
            StockID  = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.stock#' >,
            Active   = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >

            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value="#FORM.ID#" >
          </cfquery>
        <cfreturn SurveyAreaUpdate>
    </cffunction>
    <cffunction name="DeleteSurveyArea" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteSurveyArea" datasource="#variables.dsn#" >
            DELETE FROM TLU_SurveyArea   WHERE ID = #URL.ID#
          </cfquery>
    </cffunction>
<!--- YOBSource--->
    <cffunction name="YOBSourceInsert" returntype="any" output="false" access="public" >
        <cfquery name="qYOBSourceInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_YOB_Source (YOBSource) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.YOBSource#" >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getYOBSource" returntype="any" output="false" access="public" >
        <cfquery name="qgetYOBSource" datasource="#variables.dsn#"  >
            SELECT * from TLU_YOB_Source
        </cfquery>
        <cfreturn qgetYOBSource>
    </cffunction>
    <cffunction name="getYOBSourceByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetYOBSource" datasource="#variables.dsn#"  >
            SELECT * from TLU_YOB_Source where [YOBSource] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetYOBSource>
    </cffunction>
     <cffunction name="EditYOBSource" returntype="any" output="false" access="public" >
     <cfquery name="qEditYOBSource" datasource="#variables.dsn#" result="YOBSourceUpdate">
        UPDATE TLU_YOB_Source SET YOBSource = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.YOBSource#'>
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
     </cfquery>
        <cfreturn YOBSourceUpdate>
    </cffunction>
    <cffunction name="DeleteYOBSource" returntype="any" output="true"  access="remote" >
     <cfquery name="qDeleteYOBSource" datasource="#variables.dsn#" >
        DELETE FROM TLU_YOB_Source   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- Zones--->
    <cffunction name="ZonesInsert" returntype="any" output="false" access="public" >
        <cfquery name="qZonesInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Zones (ZONE,GRIDNUM,LAT_DD,LONG_DD,EASTING,NORTHING,ZSEGMENT)
            VALUES
            (<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.ZONE#" >,
                    <cfqueryparam  value="#FORM.GRIDNUM#" cfsqltype="cf_sql_float">,
                    <cfqueryparam  value="#FORM.LAT_DD#" cfsqltype="cf_sql_float">,
                    <cfqueryparam  value="#FORM.LONG_DD#" cfsqltype="cf_sql_float">,
                    <cfqueryparam  value="#FORM.EASTING#" cfsqltype="cf_sql_float">,
                    <cfqueryparam  value="#FORM.NORTHING#" cfsqltype="cf_sql_float">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.ZSEGMENT#" >
            )
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getZones" returntype="any" output="false" access="public" >
        <cfquery name="qgetZones" datasource="#variables.dsn#"  >
            SELECT * from TLU_Zones
        </cfquery>
        <cfreturn qgetZones>
    </cffunction>
    <cffunction name="getZonesByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetZones" datasource="#variables.dsn#"  >
            SELECT * from TLU_Zones  where [ZONE] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetZones>
    </cffunction>
    <cffunction name="EditZones" returntype="any" output="false" access="public" >
         <cfquery name="qEditZones" datasource="#variables.dsn#" result="ZonesUpdate">
            UPDATE TLU_Zones SET
            ZONE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.ZONE#" >,
            GRIDNUM = <cfqueryparam  value="#FORM.GRIDNUM#" cfsqltype="cf_sql_float">,
            LAT_DD  = <cfqueryparam  value="#FORM.LAT_DD#" cfsqltype="cf_sql_float">,
            LONG_DD = <cfqueryparam  value="#FORM.LONG_DD#" cfsqltype="cf_sql_float">,
            EASTING = <cfqueryparam  value="#FORM.EASTING#" cfsqltype="cf_sql_float">,
            NORTHING = <cfqueryparam  value="#FORM.NORTHING#" cfsqltype="cf_sql_float">,
            ZSEGMENT = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.ZSEGMENT#" >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value="#FORM.ID#" >
         </cfquery>
        <cfreturn ZonesUpdate>
    </cffunction>
    <cffunction name="DeleteZones" returntype="any" output="true"  access="remote" >
     <cfquery name="qDeleteZones" datasource="#variables.dsn#" >
        DELETE FROM TLU_Zones   WHERE ID = #URL.ID#
      </cfquery>
    </cffunction>
<!--- Catalog--->
    <cffunction name="CatalogInsert" returntype="any" output="false" access="public" >
        <cfquery name="qCatalogInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Catalog (Catalog,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Catalog#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getCatalog" returntype="any" output="false" access="public" >
        <cfquery name="qgetCatalog" datasource="#variables.dsn#"  >
            SELECT * from TLU_Catalog
        </cfquery>
        <cfreturn qgetCatalog>
    </cffunction>
    <cffunction name="getCatalogByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetCatalog" datasource="#variables.dsn#"  >
            SELECT * from TLU_Catalog where [Catalog] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetCatalog>
    </cffunction>
    <cffunction name="EditCatalog" returntype="any" output="false" access="public" >
     <cfquery name="qEditCatalog" datasource="#variables.dsn#" result="CatalogUpdate">
        UPDATE TLU_Catalog SET Catalog = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Catalog#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn CatalogUpdate>
    </cffunction>
    <cffunction name="DeleteCatalog" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteCatalog" datasource="#variables.dsn#" >
        DELETE FROM TLU_Catalog   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- BiopsyBehavior--->
    <cffunction name="BiopsyBehaviorInsert" returntype="any" output="false" access="public" >
        <cfquery name="qBiopsyBehaviorInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_BiopsyBehavior (ObservedResponse,LevelofResponse,Code,active) VALUES(
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ObservedResponse#' >,
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LevelofResponse#' >,
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Code#' >,
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            )
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getBiopsyBehavior" returntype="any" output="false" access="public" >
        <cfquery name="qgetBiopsyBehavior" datasource="#variables.dsn#"  >
            SELECT * from TLU_BiopsyBehavior
        </cfquery>
        <cfreturn qgetBiopsyBehavior>
    </cffunction>
    <cffunction name="getBiopsyBehaviorByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetBiopsyBehavior" datasource="#variables.dsn#"  >
            SELECT * from TLU_BiopsyBehavior where [ObservedResponse] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetBiopsyBehavior>
    </cffunction>
    <cffunction name="EditBiopsyBehavior" returntype="any" output="false" access="public" >
     <cfquery name="qEditBiopsyBehavior" datasource="#variables.dsn#" result="BiopsyBehaviorUpdate">
        UPDATE TLU_BiopsyBehavior SET
        ObservedResponse = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.ObservedResponse#' >,
        LevelofResponse = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LevelofResponse#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn BiopsyBehaviorUpdate>
     </cffunction>
    <cffunction name="DeleteBiopsyBehavior" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteBiopsyBehavior" datasource="#variables.dsn#" >
            DELETE FROM TLU_BiopsyBehavior  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
<!--- HitDescriptors & MissDescriptors--->
    <cffunction name="HitDescriptorsInsert" returntype="any" output="false" access="public" >
        <cfquery name="qHitDescriptorsInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_HitDescriptors (HitDescriptors,active) VALUES(
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HitDescriptors#' >,
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="EditHitDescriptors" returntype="any" output="false" access="public" >
         <cfquery name="qEditHitDescriptors" datasource="#variables.dsn#" result="HitDescriptorsUpdate">
            UPDATE TLU_HitDescriptors SET
            HitDescriptors = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HitDescriptors#' >,
            active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
          </cfquery>
    	<cfreturn HitDescriptorsUpdate>
    </cffunction>
    <cffunction name="getHitDescriptors" returntype="any" output="false" access="public" >
        <cfquery name="qgetHitDescriptors" datasource="#variables.dsn#"  >
            SELECT * from TLU_HitDescriptors
        </cfquery>
        <cfreturn qgetHitDescriptors>
    </cffunction>
    <cffunction name="getHitDescriptorsByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetHitDescriptors" datasource="#variables.dsn#"  >
            SELECT * from TLU_HitDescriptors where [HitDescriptors] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetHitDescriptors>
    </cffunction>
    <cffunction name="DeleteHitDescriptors" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteHitDescriptors" datasource="#variables.dsn#" >
        DELETE FROM TLU_HitDescriptors  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
    <cffunction name="MissDescriptorsInsert" returntype="any" output="false" access="public" >
        <cfquery name="qMissDescriptorsInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_MissDescriptors (MissDescriptors,active) VALUES(
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MissDescriptors#' >,
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="EditMissDescriptors" returntype="any" output="false" access="public" >
      <cfquery name="qEditMissDescriptors" datasource="#variables.dsn#" result="MissDescriptorsUpdate">
        UPDATE TLU_MissDescriptors SET
        MissDescriptors = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.MissDescriptors#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
        <cfreturn MissDescriptorsUpdate>
    </cffunction>
    <cffunction name="getMissDescriptors" returntype="any" output="false" access="public" >
        <cfquery name="qgetMissDescriptors" datasource="#variables.dsn#"  >
            SELECT * from TLU_MissDescriptors
        </cfquery>
        <cfreturn qgetMissDescriptors>
    </cffunction>
    <cffunction name="getMissDescriptorsByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetMissDescriptors" datasource="#variables.dsn#"  >
            SELECT * from TLU_MissDescriptors where [MissDescriptors] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetHitDescriptors>
    </cffunction>
    <cffunction name="DeleteMissDescriptors" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteMissDescriptors" datasource="#variables.dsn#" >
        DELETE FROM TLU_MissDescriptors  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
<!--- HitLocation--->
    <cffunction name="HitLocationInsert" returntype="any" output="false" access="public" >
        <cfquery name="qHitLocationInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_HitLocation (HitLocationAbbreviation,Description,active) VALUES(
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HitLocationAbbreviation#' >,
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Description#' >,
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getHitLocation" returntype="any" output="false" access="public" >
        <cfquery name="qgetHitLocation" datasource="#variables.dsn#"  >
            SELECT * from TLU_HitLocation
        </cfquery>
        <cfreturn qgetHitLocation>
    </cffunction>
    <cffunction name="getHitLocationByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetHitLocation" datasource="#variables.dsn#"  >
            SELECT * from TLU_HitLocation where [HitLocationAbbreviation] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetHitLocation>
    </cffunction>
    <cffunction name="EditHitLocation" returntype="any" output="false" access="public" >
     <cfquery name="qEditHitLocation" datasource="#variables.dsn#" result="HitLocationUpdate">
        UPDATE TLU_HitLocation SET
        HitLocationAbbreviation = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.HitLocationAbbreviation#' >,
        Description = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Description#' >,
        active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
    	<cfreturn HitLocationUpdate>
    </cffunction>
    <cffunction name="DeleteHitLocation" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteHitLocation" datasource="#variables.dsn#" >
            DELETE FROM TLU_HitLocation  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>
<!--- SubSampleType--->
    <cffunction name="SubSampleTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qSubSampleTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_SubSampleType (TissueType,IntendedAnalysis,Disposition,active) VALUES(
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TissueType#' >,
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.IntendedAnalysis#' >,
            <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Disposition#' >,
            <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
    <cffunction name="getSubSampleType" returntype="any" output="false" access="public" >
        <cfquery name="qgetSubSampleType" datasource="#variables.dsn#"  >
            SELECT * from TLU_SubSampleType
        </cfquery>
        <cfreturn qgetSubSampleType>
    </cffunction>
    <cffunction name="getSubSampleTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetSubSampleType" datasource="#variables.dsn#"  >
            SELECT * from TLU_SubSampleType where [TissueType] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetSubSampleType>
    </cffunction>
    <cffunction name="EditSubSampleType" returntype="any" output="false" access="public" >
       <cfquery name="qEditSubSampleType" datasource="#variables.dsn#" result="SubSampleTypeUpdate">
            UPDATE TLU_SubSampleType SET
            TissueType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.TissueType#' >,
            IntendedAnalysis = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.IntendedAnalysis#' >,
            Disposition = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Disposition#' >,
            active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
            WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
        </cfquery>
        <cfreturn SubSampleTypeUpdate>
    </cffunction>
    <cffunction name="DeleteSubSampleType" returntype="any" output="false"  access="remote" >
     <cfquery name="qDeleteSubSampleType" datasource="#variables.dsn#" >
        DELETE FROM TLU_SubSampleType  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
      </cfquery>
    </cffunction>
	<!---Data Source--->
	<cffunction name="addFundingSource" returntype="any" output="false" access="public" >
        <cfquery name="qaddFundingSource" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_FundingSource (Name,active) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Name#" >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>
	<cffunction name="updateFundingSource" returntype="any" output="false" access="public" >
		<cfquery name="qUpdateFundingSource" datasource="#variables.dsn#">
			 update TLU_FundingSource
			 SET Name = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.name#'>,
			 active = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#'>
			 WHERE id = #form.id#
		</cfquery>
	</cffunction>
    <cffunction name="getFundingSource" returntype="any" output="false" access="public" >
        <cfquery name="qgetFundingSource" datasource="#variables.dsn#"  >
            SELECT * from TLU_FundingSource
        </cfquery>
        <cfreturn qgetFundingSource>
    </cffunction>
	<cffunction name="deleteFundingSource" returntype="any" output="false"  access="remote">
        <cfquery name="deleteFundingSource" datasource="#variables.dsn#" result="deleteFundingSource">
        	DELETE FROM TLU_FundingSource  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
	<cffunction name="getFundingSourceByword" returntype="any" output="false" access="public" >
        <cfquery name="qGetFundingSourceByword" datasource="#variables.dsn#"  >
            SELECT * from TLU_FundingSource where [Name] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qGetFundingSourceByword>
    </cffunction>
    
    
    <cffunction name="getZoneByName" returntype="any" output="false" access="public" >
        <cfargument name="ZoneName" default="" required="yes">
        <cfquery name="qgetZoneByName" datasource="#variables.dsn#"  >
            SELECT Max(TLU_Zones.ID) as ID from TLU_Zones where zone = '#ZoneName#'
        </cfquery>
    <cfreturn qgetZoneByName.ID>
    </cffunction>
    <cffunction name="getAssocBioByName" returntype="any" output="false" access="public" >
    	<cfargument name="AssocBioName" default="" required="yes">
        <cfquery name="getAssocBioByName" datasource="#variables.dsn#"  >
            SELECT top 1 ASSOCBIOID from TLU_AssocBioData where [AssocBioName] = '#AssocBioName#'
        </cfquery>
        <cfreturn getAssocBioByName.ASSOCBIOID>
    </cffunction>

    <!--- Description --->
    <cffunction name="UpdateDescriptionInsert" returntype="any" output="false" access="public" >
        <cfquery name="qDescriptionInsert" datasource="#variables.dsn#">
             INSERT FIN_Description
             SET description = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.description#'>,
             status = <cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#'>
       </cfquery>
    </cffunction>

    <cffunction name="DescriptionInsert" returntype="any" output="false" access="public" >

        <cfquery name="qDescriptionInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO NFIN_Description (Description,active) VALUES('#FORM.Description#','#FORM.active#')
        </cfquery>
        <cfreturn return_data>
    </cffunction>

     <cffunction name="getActiveDescription" returntype="any" output="false" access="public" >
        
        <cfquery name="qgetActiveDescription" datasource="#variables.dsn#"  result="return_data" >
            SELECT * from NFIN_Description WHERE active = 1
        </cfquery>
        <cfreturn qgetActiveDescription>
    </cffunction>

    <cffunction name="getDescription" returntype="any" output="false" access="public" >
        
        <cfquery name="qgetDescription" datasource="#variables.dsn#"  result="return_data" >
            SELECT * from NFIN_Description
        </cfquery>
        <cfreturn qgetDescription>
    </cffunction>

    <cffunction name="DeleteDescription" returntype="any" output="false"  access="remote" >
         <cfquery name="qDeleteDescription" datasource="#variables.dsn#" >
            DELETE FROM NFIN_Description  WHERE id = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>
    </cffunction>

    <cffunction name="EditDescription" returntype="any" output="false" access="public" >
     <cfquery name="qEditDescription" datasource="#variables.dsn#" result="rEditDescription">
        UPDATE NFIN_Description SET  Description = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Description#' >,
        active=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.active#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn rEditDescription>
     </cffunction>

    <cffunction name="getDescriptionByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetDescription" datasource="#variables.dsn#"  >
            SELECT * from NFIN_Description where Description like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetDescription>
    </cffunction>

      <!---   <cffunction name="getLesionType" returntype="any" output="false" access="public" >
        <cfquery name="qgetLesionType" datasource="#variables.dsn#" >
            SELECT * from TLU_LesionType
        </cfquery>
        <cfreturn qgetLesionType>
    </cffunction> --->

    <!--- Event Tracking List Caytegory--->

    <cffunction name="CategoryInsert" returntype="any" output="false" access="public" >
        <cfquery name="qCategoryInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Tracking_Categories (CategoryName,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CategoryName#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getCategory" returntype="any" output="false" access="public" >
        <cfquery name="qgetCategory" datasource="#variables.dsn#" >
            SELECT * from TLU_Tracking_Categories
        </cfquery>
        <cfreturn qgetCategory>
    </cffunction>
    <cffunction name="getCategoryByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetCategory" datasource="#variables.dsn#"  >
            SELECT * from TLU_Tracking_Categories where [CategoryName] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetCategory>
    </cffunction>
    <cffunction name="EditCategory" returntype="any" output="false" access="public" >
     <cfquery name="qEditCategory" datasource="#variables.dsn#" result="CategoryUpdate">
        UPDATE TLU_Tracking_Categories SET [CategoryName] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.CategoryName#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn CategoryUpdate>
     </cffunction>

    

    <cffunction name="DeleteCategory" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteCategory" datasource="#variables.dsn#" >
            DELETE FROM TLU_Tracking_Categories   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!--- Event Stranding Type--->

    <cffunction name="StrandingTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Stranding_Type (Type,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getStrandingType" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Stranding_Type
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="getStrandingTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Stranding_Type where [Type] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="EditStrandingType" returntype="any" output="false" access="public" >

     <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
        UPDATE TLU_Stranding_Type SET [Type] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn TypeUpdate>
    </cffunction>

    

    <cffunction name="DeleteStrandingType" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Stranding_Type   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>


    <!--- Event Drug Type--->

    <cffunction name="DrugTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Drug_Type (Type,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getDrugType" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Drug_Type
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="getDrugTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Drug_Type where [Type] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="EditDrugType" returntype="any" output="false" access="public" >

     <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
        UPDATE TLU_Drug_Type SET [Type] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn TypeUpdate>
    </cffunction>

    <cffunction name="DeleteDrugType" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Drug_Type   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>


    <!--- Event Drug Method--->

    <cffunction name="DrugMethodInsert" returntype="any" output="false" access="public" >
        <cfquery name="qMethodInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Drug_Method (Method,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Method#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getDrugMethod" returntype="any" output="false" access="public" >
        <cfquery name="qgetMethod" datasource="#variables.dsn#" >
            SELECT * from TLU_Drug_Method
        </cfquery>
        <cfreturn qgetMethod>
    </cffunction>
    
    <cffunction name="EditDrugMethod" returntype="any" output="false" access="public" >

     <cfquery name="qEditMethod" datasource="#variables.dsn#" result="MethodUpdate">
        UPDATE TLU_Drug_Method SET [Method] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Method#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn MethodUpdate>
    </cffunction>

    <cffunction name="DeleteDrugMethod" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteMethod" datasource="#variables.dsn#" >
            DELETE FROM TLU_Drug_Method   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Biopsy Type--->

    <cffunction name="BiopsyTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Biopsy_Type (Type,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getBiopsyType" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Biopsy_Type
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
  
    <cffunction name="EditBiopsyType" returntype="any" output="false" access="public" >

     <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
        UPDATE TLU_Biopsy_Type SET [Type] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn TypeUpdate>
    </cffunction>

    <cffunction name="DeleteBiopsyType" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Biopsy_Type   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Biopsy Location--->

    <cffunction name="BiopsyLocationInsert" returntype="any" output="false" access="public" >
        <cfquery name="qLocationInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Biopsy_Location (Location,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getBiopsyLocation" returntype="any" output="false" access="public" >
        <cfquery name="qgetBiopsyLocation" datasource="#variables.dsn#" >
            SELECT * from TLU_Biopsy_Location
        </cfquery>
        <cfreturn qgetBiopsyLocation>
    </cffunction>
  
    <cffunction name="EditBiopsyLocation" returntype="any" output="false" access="public" >

     <cfquery name="qEditLocation" datasource="#variables.dsn#" result="LocationUpdate">
        UPDATE TLU_Biopsy_Location SET [Location] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Location#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn LocationUpdate>
    </cffunction>

    <cffunction name="DeleteBiopsyLocation" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteLocation" datasource="#variables.dsn#" >
            DELETE FROM TLU_Biopsy_Location   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Veterinarians--->

    <cffunction name="VeterinariansInsert" returntype="any" output="false" access="public" >
        <cfquery name="qVeterinariansInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Veterinarians (Veterinarians,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarians#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getVeterinarians" returntype="any" output="false" access="public" >
        <cfquery name="qgetVeterinarians" datasource="#variables.dsn#" >
            SELECT * from TLU_Veterinarians
        </cfquery>
        <cfreturn qgetVeterinarians>
    </cffunction>

    <cffunction name="getVeterinarianss" returntype="any" output="false" access="public" >
        <cfquery name="qgetVeterinarianss" datasource="#variables.dsn#" >
            SELECT * from TLU_Veterinarians WHERE status = 1
        </cfquery>
        <cfreturn qgetVeterinarianss>
    </cffunction>
  
    <cffunction name="EditVeterinarians" returntype="any" output="false" access="public" >

     <cfquery name="qEditVeterinarians" datasource="#variables.dsn#" result="VeterinariansUpdate">
        UPDATE TLU_Veterinarians SET [Veterinarians] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.Veterinarians#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn VeterinariansUpdate>
    </cffunction>

    <cffunction name="DeleteVeterinarians" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteVeterinarians" datasource="#variables.dsn#" >
            DELETE FROM TLU_Veterinarians   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!---   New Dashboard Section   --->
    <cffunction name="getTrackingListByFilter" returnformat="JSON" returntype="any" output="false" access="remote" >
		<cfargument  name="species" default="" required="no">
		<cfargument  name="categories" default="" required="no">
		<cfargument  name="status" default="" required="no">
        <cfquery name="qgetTrackingListByFilter" datasource="#variables.dsn#">
            SELECT * from TLU_TrackingList 
            where 1=1
            <cfif species neq "Species">
                AND species = '#species#'
            </cfif>    
            <cfif categories neq "Category">
                AND categories = '#categories#'
            </cfif>    
            <cfif status neq "">
                AND status = #status#
            </cfif>    
        </cfquery>
		<cfreturn qgetTrackingListByFilter>
	</cffunction>

    <cffunction name="getTotalTakesData" returntype="any" output="false" access="public">
        <cfquery name="qgetTotalTakesData" datasource="#variables.dsn#">
            select sum(cast(replace(FE_TotalAdults_takes, ',', '.') as decimal(29, 0))) as TotalAdults,
            sum(cast(replace(FE_TotalCalves_takes, ',', '.') as decimal(29, 0))) as TotalCalves,
            sum(cast(replace(FE_YoungOfYear_takes, ',', '.') as decimal(29, 0))) as TotalYoy
            from Survey_Sightings
        </cfquery>
		<cfreturn qgetTotalTakesData>
	</cffunction>
    <cffunction name="getTotalTakesByFilters" returnformat="JSON" returntype="any" output="false" access="remote">
		<cfargument  name="species" default="" required="no">
		<cfargument  name="date" default="" required="no">
		<cfargument  name="surveyRoute" default="" required="no">
        <cfif  date NEQ "">
            <cfset startDate = dateformat(date.split('-')[1],'YYYY-mm-dd')>
            <cfset endDate   = dateformat(date.split('-')[2],'YYYY-mm-dd')>
        </cfif>

        <cfquery name="qgetTotalTakesByFilters" datasource="#variables.dsn#">
            select
            sum(cast(replace(ss.FE_TotalAdults_takes, ',', '.') as decimal(29, 0))) as TotalAdults,
            sum(cast(replace(ss.FE_TotalCalves_takes, ',', '.') as decimal(29, 0))) as TotalCalves,
            sum(cast(replace(ss.FE_YoungOfYear_takes, ',', '.') as decimal(29, 0))) as TotalYoy,
            sum(cast(replace(ss.FE_TotalCetacean_takes, ',', '.') as decimal(29, 0))) as TotalCetacean
            from Survey_Sightings ss
            left join Surveys s on s.ID = ss.Project_ID
            where
            ss.IsDeleted != <cfqueryparam  cfsqltype="CF_SQL_BIT" value='1'>
            and s.IsDeleted != <cfqueryparam  cfsqltype="CF_SQL_BIT" value='1'>
            <cfif isdefined("startDate") and startDate neq "" and endDate NEQ ""> 
                and CONVERT(char(10), s.Date,126) BETWEEN '#startDate#' AND '#endDate#'
            </cfif>
            <cfif species neq "">
                AND ss.FE_Species = '#species#'
            </cfif>
            <cfif surveyRoute neq "">
                AND 
                CONCAT(',', SurveyRoute, ',') LIKE '%,#surveyRoute#,%'
            </cfif>
        </cfquery>
		<cfreturn qgetTotalTakesByFilters>
	</cffunction>
    <cffunction name="getAnimalsByFilters" returnformat="JSON" returntype="any" output="false" access="remote">
		<cfargument  name="species" default="" required="no">
		<cfargument  name="date" default="" required="no">
		<cfargument  name="surveyRoute" default="" required="no">
        <cfif  date NEQ "">
            <cfset startDate = dateformat(date.split('-')[1],'YYYY-mm-dd')>
            <cfset endDate   = dateformat(date.split('-')[2],'YYYY-mm-dd')>
        </cfif>
        <cfset response = StructNew()>
        <cfquery name="qgetAnimalsTotal" datasource="#variables.dsn#">
           SELECT distinct Cetaceans.Code 
            FROM Surveys LEFT JOIN
            (
                Survey_Sightings LEFT JOIN
                (
                    Cetaceans RIGHT JOIN
                    Cetacean_Sightings ON Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID
                )
                ON
                Survey_Sightings.ID = Cetacean_Sightings.Sighting_ID                    
            )
            ON
            Surveys.ID = Survey_Sightings.Project_ID 
            where 
            Surveys.IsDeleted = 0
            and 
            Survey_Sightings.IsDeleted = 0
            and
            Cetaceans.Code NOT Like 'UNK%' AND Cetaceans.Code NOT Like 'cUNK%'
            <cfif isdefined("startDate") and startDate neq "" and endDate NEQ ""> 
                and CONVERT(char(10), Surveys.Date,126) BETWEEN '#startDate#' AND '#endDate#'
            </cfif>
            <cfif species neq "">
                AND Cetaceans.CetaceanSpecies = '#species#'
            </cfif>
            <cfif surveyRoute neq "">
                AND 
                CONCAT(',', Surveys.SurveyRoute, ',') LIKE '%,#surveyRoute#,%'
            </cfif>
        </cfquery>
        <cfquery name="qgetAnimalsAdults" datasource="#variables.dsn#">
           SELECT distinct Cetaceans.Code 
            FROM Surveys LEFT JOIN
            (
                Survey_Sightings LEFT JOIN
                (
                    Cetaceans RIGHT JOIN
                    Cetacean_Sightings ON Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID
                )
                ON
                Survey_Sightings.ID = Cetacean_Sightings.Sighting_ID                    
            )
            ON
            Surveys.ID = Survey_Sightings.Project_ID 
            where 
            Surveys.IsDeleted = 0
            and 
            Survey_Sightings.IsDeleted = 0
            and
            Cetaceans.Code NOT Like 'UNK%' AND Cetaceans.Code NOT Like 'cUNK%' AND Cetaceans.Code NOT Like 'cX%' COLLATE SQL_Latin1_General_CP1_CS_AS and Cetaceans.Code NOT Like 'c%' COLLATE SQL_Latin1_General_CP1_CS_AS
            <cfif isdefined("startDate") and startDate neq "" and endDate NEQ ""> 
                and CONVERT(char(10), Surveys.Date,126) BETWEEN '#startDate#' AND '#endDate#'
            </cfif>
            <cfif species neq "">
                AND Cetaceans.CetaceanSpecies = '#species#'
            </cfif>
            <cfif surveyRoute neq "">
                AND 
                CONCAT(',', Surveys.SurveyRoute, ',') LIKE '%,#surveyRoute#,%'
            </cfif>
        </cfquery>
        <cfquery name="qgetAnimalsCalfs" datasource="#variables.dsn#">
           SELECT distinct Cetaceans.Code 
            FROM Surveys LEFT JOIN
            (
                Survey_Sightings LEFT JOIN
                (
                    Cetaceans RIGHT JOIN
                    Cetacean_Sightings ON Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID
                )
                ON
                Survey_Sightings.ID = Cetacean_Sightings.Sighting_ID                    
            )
            ON
            Surveys.ID = Survey_Sightings.Project_ID 
            where 
            Surveys.IsDeleted = 0
            and 
            Survey_Sightings.IsDeleted = 0
            and
            Cetaceans.Code NOT Like 'UNK%' AND Cetaceans.Code NOT Like 'cUNK%' AND Cetaceans.Code NOT Like 'cX%'  COLLATE SQL_Latin1_General_CP1_CS_AS AND Cetaceans.Code Like 'c%'  COLLATE SQL_Latin1_General_CP1_CS_AS
            <cfif isdefined("startDate") and startDate neq "" and endDate NEQ ""> 
                and CONVERT(char(10), Surveys.Date,126) BETWEEN '#startDate#' AND '#endDate#'
            </cfif>
            <cfif species neq "">
                AND Cetaceans.CetaceanSpecies = '#species#'
            </cfif>
            <cfif surveyRoute neq "">
                AND 
                CONCAT(',', Surveys.SurveyRoute, ',') LIKE '%,#surveyRoute#,%'
            </cfif>
        </cfquery>
        <cfquery name="qgetAnimalsWithDOD" datasource="#variables.dsn#">
           SELECT distinct Cetaceans.Code,ISNULL(CONVERT(varchar,Cetaceans.DateDeath,101),'') AS DOD
            FROM Surveys LEFT JOIN
            (
                Survey_Sightings LEFT JOIN
                (
                    Cetaceans RIGHT JOIN
                    Cetacean_Sightings ON Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID
                )
                ON
                Survey_Sightings.ID = Cetacean_Sightings.Sighting_ID                    
            )
            ON
            Surveys.ID = Survey_Sightings.Project_ID 
            where 
            Surveys.IsDeleted = 0
            and 
            Survey_Sightings.IsDeleted = 0
            and
            Cetaceans.Code NOT Like 'UNK%' AND Cetaceans.Code NOT Like 'cUNK%'
            <cfif isdefined("startDate") and startDate neq "" and endDate NEQ ""> 
                and CONVERT(char(10), Surveys.Date,126) BETWEEN '#startDate#' AND '#endDate#'
            </cfif>
            <cfif species neq "">
                AND Cetaceans.CetaceanSpecies = '#species#'
            </cfif>
            <cfif surveyRoute neq "">
                AND 
                CONCAT(',', Surveys.SurveyRoute, ',') LIKE '%,#surveyRoute#,%'
            </cfif>
        </cfquery>
        <cfset response["TotalDOD"] = #qgetAnimalsWithDOD#>
        <cfset response["Total"] = #qgetAnimalsTotal.recordcount#>
        <cfset response["Adults"] = #qgetAnimalsAdults.recordcount#>
        <cfset response["Calfs"] = #qgetAnimalsCalfs.recordcount#>
        <cfreturn response>
	</cffunction>
    <cffunction name="getIncidentReports" returnformat="JSON" returntype="any" output="false" access="remote">
		<cfargument  name="date" default="" required="no">
        <cfif  date NEQ "">
            <cfset startDate = dateformat(date.split('-')[1],'YYYY-mm-dd')>
            <cfset endDate   = dateformat(date.split('-')[2],'YYYY-mm-dd')>
        </cfif>
        <cfquery name="qgetIncidentReports" datasource="#variables.dsn#">
            SELECT IRT.IR_Type ,Count (Ir.IR_Type) as number FROM TLU_IncidentReport Ir 
            left join  TLU_IncidentReportType IRT on Ir.IR_Type = IRT.ID
            where 1=1
            <cfif isdefined("startDate") and startDate neq "" and endDate NEQ ""> 
                and CONVERT(char(10), Ir.IR_Date,126) BETWEEN '#startDate#' AND '#endDate#'
            </cfif>
            GROUP BY IRT.IR_Type,Ir.IR_Type
        </cfquery>
		<cfreturn qgetIncidentReports>
    </cffunction>
    <!--- Event Bin Number Type--->

    <cffunction name="BinNumberInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Bin_Number (Bin_Number,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditBinNumber" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Bin_Number SET [Bin_Number] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getBinNumber" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Bin_Number
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getBinNumberByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Bin_Number where [Bin_Number] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="DeleteBinNumber" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Bin_Number   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Diagnostic Test --->

    <cffunction name="DiagnosticTestInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Diagnostic_Test (Diagnostic,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditDiagnosticTest" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Diagnostic_Test SET [Diagnostic] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getDiagnosticTest" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Diagnostic_Test
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getDiagnosticTestByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Diagnostic_Test where [Diagnostic] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="DeleteDiagnosticTest" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Diagnostic_Test   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

     <!--- Event Diagnostic Lab --->

     <cffunction name="DiagnosticLabInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Diagnostic_Lab (Diagnostic,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditDiagnosticLab" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Diagnostic_Lab SET [Diagnostic] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getDiagnosticLab" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Diagnostic_Lab where Diagnostic != ''
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getDiagnosticLabByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Diagnostic_Lab where [Diagnostic] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="DeleteDiagnosticLab" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Diagnostic_Lab   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Preservation Method --->

    <cffunction name="PreservationMethodInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Preservation_Method (Method,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditPreservationMethod" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Preservation_Method SET [Method] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getPreservationMethod" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Preservation_Method
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getPreservationMethodByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Preservation_Method where [Method] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="DeletePreservationMethod" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Preservation_Method   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Sample Type --->

    <cffunction name="SampleTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Sample_Type (Type,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditSampleType" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Sample_Type SET [Type] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getSampleType" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Sample_Type where type != '' order by Type asc
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getSampleTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Sample_Type where [Type] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="DeleteSampleType" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Sample_Type   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Sample Location --->

    <cffunction name="SampleLocationInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Sample_Location (Location,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditSampleLocation" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Sample_Location SET [Location] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getSampleLocation" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Sample_Location
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getSampleLocationByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Sample_Location where [Location] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="DeleteSampleLocation" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Sample_Location   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Sample Tracking --->

    <cffunction name="SampleTrackingInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Sample_Tracking (Current_Location,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditSampleTracking" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Sample_Tracking SET [Current_Location] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getSampleTracking" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Sample_Tracking
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getSampleTrackingByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Sample_Tracking where [Current_Location] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="DeleteSampleTracking" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Sample_Tracking   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Tissue Type --->

    <cffunction name="TissueTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Tissue_Type (Type,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditTissueType" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Tissue_Type SET [Type] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getTissueType" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Sample_Type where type != '' order by Type asc
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getTissueTypeByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Tissue_Type where [Type] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="DeleteTissueType" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Tissue_Type   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Unit of sample --->

    <cffunction name="UnitofsampleInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_Unit_Of_Sample (Unit,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="EditUnitofsample" returntype="any" output="false" access="public" >

        <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
           UPDATE TLU_Unit_Of_Sample SET [Unit] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
           status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
           WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
         </cfquery>
         <cfreturn TypeUpdate>
       </cffunction>

       <cffunction name="getUnitofsample" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_Unit_Of_Sample
        </cfquery>
        <cfreturn qgetType>
    </cffunction>

    <cffunction name="getUnitofsampleByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_Unit_Of_Sample where [Unit] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="DeleteUnitofsample" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_Unit_Of_Sample   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event RBC Morphology--->

    <cffunction name="RbcMorphologyInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_RbcMorphology (RBC,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getRbcMorphology" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_RbcMorphology
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="getRbcMorphologyByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_RbcMorphology where [RBC] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="EditRbcMorphology" returntype="any" output="false" access="public" >

     <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
        UPDATE TLU_RbcMorphology SET [RBC] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn TypeUpdate>
    </cffunction>

    <cffunction name="DeleteRbcMorphology" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_RbcMorphology   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Platelet Morphology--->

    <cffunction name="PlateletMorphologyInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_PlateletMorphology (Platelet,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getPlateletMorphology" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_PlateletMorphology
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="getPlateletMorphologyByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_PlateletMorphology where [Platelet] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="EditPlateletMorphology" returntype="any" output="false" access="public" >

     <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
        UPDATE TLU_PlateletMorphology SET [Platelet] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn TypeUpdate>
    </cffunction>

    <cffunction name="DeletePlateletMorphology" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_PlateletMorphology   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event WBC Morphology--->

    <cffunction name="WbcMorphologyInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_WbcMorphology (WBC,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getWbcMorphology" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_WbcMorphology
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="getWbcMorphologyByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_WbcMorphology where [WBC] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="EditWbcMorphology" returntype="any" output="false" access="public" >

     <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
        UPDATE TLU_WbcMorphology SET [WBC] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn TypeUpdate>
    </cffunction>

    <cffunction name="DeleteWbcMorphology" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_WbcMorphology   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!--- Event Liver Funding--->

    <cffunction name="LiverFindingInsert" returntype="any" output="false" access="public" >
        <cfquery name="qLiverFindingInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_LiverFinding (finding,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.finding#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>


    <cffunction name="getLiverFinding" returntype="any" output="false" access="public" >
        <cfquery name="qgetLiverFinding" datasource="#variables.dsn#" >
            SELECT * from TLU_LiverFinding
        </cfquery>
        <cfreturn qgetLiverFinding>
    </cffunction>
    <cffunction name="EditLiverFinding" returntype="any" output="false" access="public" >

     <cfquery name="qEditLiverFinding" datasource="#variables.dsn#" result="FindinUpdate">
        UPDATE TLU_LiverFinding SET finding = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.finding#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn FindinUpdate>
    </cffunction>

    <cffunction name="DeleteLiverFinding" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteLiverFinding" datasource="#variables.dsn#" >
            DELETE FROM TLU_LiverFinding   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!--- Event Lung Funding--->

    <cffunction name="LungFindingInsert" returntype="any" output="false" access="public" >
        <cfquery name="qLungFindingInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_LungFinding (finding,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.finding#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getLungFinding" returntype="any" output="false" access="public" >
        <cfquery name="qgetLungFinding" datasource="#variables.dsn#" >
            SELECT * from TLU_LungFinding
        </cfquery>
        <cfreturn qgetLungFinding>
    </cffunction>
    <cffunction name="EditLungFinding" returntype="any" output="false" access="public" >

     <cfquery name="qEditLungFinding" datasource="#variables.dsn#" result="FindingUpdate">
        UPDATE TLU_LungFinding SET finding = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.finding#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn FindingUpdate>
    </cffunction>

    <cffunction name="DeleteLungFinding" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteLungFinding" datasource="#variables.dsn#" >
            DELETE FROM TLU_LungFinding   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!--- Event Parasite Location--->

    <cffunction name="ParasiteLocationInsert" returntype="any" output="false" access="public" >
        <cfquery name="qParasiteLocationInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_ParasiteLocation (location,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.location#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getParasiteLocation" returntype="any" output="false" access="public" >
        <cfquery name="qgetParasiteLocation" datasource="#variables.dsn#" >
            SELECT * from TLU_ParasiteLocation
        </cfquery>
        <cfreturn qgetParasiteLocation>
    </cffunction>
    <cffunction name="EditParasiteLocation" returntype="any" output="false" access="public" >

     <cfquery name="qEditParasiteLocation" datasource="#variables.dsn#" result="locationUpdate">
        UPDATE TLU_ParasiteLocation SET location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.location#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn locationUpdate>
    </cffunction>

    <cffunction name="DeleteParasiteLocation" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteParasiteLocation" datasource="#variables.dsn#" >
            DELETE FROM TLU_ParasiteLocation   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!--- Event Parasite Location--->

    <cffunction name="ParasiteTypeInsert" returntype="any" output="false" access="public" >
        <cfquery name="qParasiteTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_ParasiteType (type,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getParasiteType" returntype="any" output="false" access="public" >
        <cfquery name="qgetParasiteType" datasource="#variables.dsn#" >
            SELECT * from TLU_ParasiteType
        </cfquery>
        <cfreturn qgetParasiteType>
    </cffunction>
    <cffunction name="EditParasiteType" returntype="any" output="false" access="public" >

     <cfquery name="qEditParasiteType" datasource="#variables.dsn#" result="typeUpdate">
        UPDATE TLU_ParasiteType SET type = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn typeUpdate>
    </cffunction>

    <cffunction name="DeleteParasiteType" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteParasiteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_ParasiteType   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!--- Event Nx Location --->
    <cffunction name="NxLocationInsert" returntype="any" output="false" access="public" >
        <cfquery name="qNxLocationInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_NxLocation (location,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.location#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getNxLocation" returntype="any" output="false" access="public" >
        <cfquery name="qgetNxLocation" datasource="#variables.dsn#" >
            SELECT * from TLU_NxLocation
        </cfquery>
        <cfreturn qgetNxLocation>
    </cffunction>
    <cffunction name="EditNxLocation" returntype="any" output="false" access="public" >

     <cfquery name="qEditNxLocation" datasource="#variables.dsn#" result="typeUpdate">
        UPDATE TLU_NxLocation SET location = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.location#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn typeUpdate>
    </cffunction>

    <cffunction name="DeleteNxLocation" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteNxLocation" datasource="#variables.dsn#" >
            DELETE FROM TLU_NxLocation   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
     <!--- Event GI Foreign Material--->

    <cffunction name="GIForeignMaterialInsert" returntype="any" output="false" access="public" >
        <cfquery name="qGIForeignMaterialInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_GIForeignMaterial (GIForeignMaterial,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GIForeignMaterial#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getGIForeignMaterial" returntype="any" output="false" access="public" >
        <cfquery name="qgetGIForeignMaterial" datasource="#variables.dsn#" >
            SELECT * from TLU_GIForeignMaterial
        </cfquery>
        <cfreturn qgetGIForeignMaterial>
    </cffunction>
    <cffunction name="EditGIForeignMaterial" returntype="any" output="false" access="public" >

     <cfquery name="qEditGIForeignMaterial" datasource="#variables.dsn#" result="typeUpdate">
        UPDATE TLU_GIForeignMaterial SET GIForeignMaterial = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.GIForeignMaterial#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn typeUpdate>
    </cffunction>

    <cffunction name="DeleteGIForeignMaterial" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteGIForeignMaterial" datasource="#variables.dsn#" >
            DELETE FROM TLU_GIForeignMaterial   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!--- Event Lymph Node Present  --->
    <cffunction name="LymphNodePresentInsert" returntype="any" output="false" access="public" >
        <cfquery name="qLymphNodePresentInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_LymphNodePresent (LymphNodePresent,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LymphNodePresent#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getLymphNodePresent" returntype="any" output="false" access="public" >
        <cfquery name="qgetLymphNodePresent" datasource="#variables.dsn#" >
            SELECT * from TLU_LymphNodePresent
        </cfquery>
        <cfreturn qgetLymphNodePresent>
    </cffunction>
    <cffunction name="EditLymphNodePresent" returntype="any" output="false" access="public" >

     <cfquery name="qEditLymphNodePresent" datasource="#variables.dsn#" result="typeUpdate">
        UPDATE TLU_LymphNodePresent SET LymphNodePresent = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.LymphNodePresent#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn typeUpdate>
    </cffunction>

    <cffunction name="DeleteLymphNodePresent" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteLymphNodePresent" datasource="#variables.dsn#" >
            DELETE FROM TLU_LymphNodePresent   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>
    <!--- Event Hemolysis Index--->

    <cffunction name="HemolysisIndexInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_HemolysisIndex (Hemolysis,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getHemolysisIndex" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_HemolysisIndex
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="getHemolysisIndexByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_HemolysisIndex where [Hemolysis] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="EditHemolysisIndex" returntype="any" output="false" access="public" >

     <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
        UPDATE TLU_HemolysisIndex SET [Hemolysis] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn TypeUpdate>
    </cffunction>

    <cffunction name="DeleteHemolysisIndex" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_HemolysisIndex   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

    <!--- Event Lipemia Index--->

    <cffunction name="LipemiaIndexInsert" returntype="any" output="false" access="public" >
        <cfquery name="qTypeInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO TLU_LipemiaIndex (Lipemia,status) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getLipemiaIndex" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#" >
            SELECT * from TLU_LipemiaIndex
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="getLipemiaIndexByword" returntype="any" output="false" access="public" >
        <cfquery name="qgetType" datasource="#variables.dsn#"  >
            SELECT * from TLU_LipemiaIndex where [Lipemia] like '%#form.searchword#%'
        </cfquery>
        <cfreturn qgetType>
    </cffunction>
    <cffunction name="EditLipemiaIndex" returntype="any" output="false" access="public" >

     <cfquery name="qEditType" datasource="#variables.dsn#" result="TypeUpdate">
        UPDATE TLU_LipemiaIndex SET [Lipemia] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.type#' >,
        status=<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.status#' >
        WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
      </cfquery>
      <cfreturn TypeUpdate>
    </cffunction>

    <cffunction name="DeleteLipemiaIndex" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteType" datasource="#variables.dsn#" >
            DELETE FROM TLU_LipemiaIndex   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
        </cfquery>
    </cffunction>

     <!--- Sighting Map--->
     <cffunction name="SightingMapInsert" returntype="any" output="false" access="public" >
        <cfquery name="qMapInfoInsert" datasource="#variables.dsn#"  result="return_data" >
            INSERT INTO SightingMap (lat,lng,mapZoom) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.latitude#' >,<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.longitude#' >,<cfqueryparam cfsqltype="cf_sql_integer" value='#FORM.mapZoom#' >)
        </cfquery>
        <cfreturn return_data>
    </cffunction>

    <cffunction name="getSightingMapData" returntype="any" output="false" access="public" >
        <cfquery name="qgetSightingMap" datasource="#variables.dsn#"  >
            SELECT * from SightingMap
        </cfquery>
        <cfreturn qgetSightingMap>
    </cffunction>

    <cffunction name="DeleteSightingMap" returntype="any" output="false"  access="remote" >
        <cfquery name="qDeleteDescription" datasource="#variables.dsn#" >
           DELETE FROM SightingMap  WHERE id = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
         </cfquery>
   </cffunction>

   <cffunction name="EditSightingMap" returntype="any" output="false" access="public" >
    <cfquery name="qEditDescription" datasource="#variables.dsn#" result="rEditDescription">
       UPDATE SightingMap SET  lat = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.latitude#' >,
       lng=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.longitude#' >,mapZoom=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.mapZoom#'>,mapStyle=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.mapStyle#'>
       WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='1' >
     </cfquery>
     <cfreturn rEditDescription>
    </cffunction>

</cfcomponent>