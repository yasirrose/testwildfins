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
            DELETE FROM TLU_Type  WHERE ID = '#trim(Form.id)#'
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
    <cffunction name="updatesampleDetail" access="remote" >
   
        <!--- <cfargument name="samplDate" type="any" required="yes">
        <cfdump var="#form.samplDate#">
        <cfdump var="#form.locat#">
        <cfdump var="#form.track#">
        <cfdump var="#form.sent#">
        <cfdump var="#form.ID#">
        <cfexit> --->
        <cfquery name="qupdateSampleData" datasource="#Application.dsn#" >
            update ST_SampleDetail set
            SADate=<cfqueryparam cfsqltype="cf_sql_varchar" value='#samplDate#' >
            ,SampleLocation=<cfqueryparam cfsqltype="cf_sql_varchar" value='#locat#'>
            ,LabSentto=<cfqueryparam cfsqltype="cf_sql_varchar" value='#sent#'>
            ,SampleNote=<cfqueryparam cfsqltype="cf_sql_varchar" value='#note#'>
            ,SampleTracking=<cfqueryparam cfsqltype="cf_sql_varchar" value='#track#'>
            ,Sample_available=<cfqueryparam cfsqltype="cf_sql_varchar" value='#subsample#'>
            ,subsampleDate=<cfqueryparam cfsqltype="cf_sql_varchar" value='#subsampleDate#'>
            ,Thawed=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Thawed#'>
            
            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>
        <!--- <cfdump var="#qupdateSampleData#"> --->
		<cfreturn True>
	</cffunction>
    <cffunction name="updateLesions" access="remote" >
        <!--- <cfdump var="#ID#" abort="true"> --->
        <!--- <cfargument name="samplDate" type="any" required="yes"> --->
        <!--- <cfdump var="#form.LesionPresent#">
        <cfdump var="#form.LesionType#">
        <cfdump var="#form.Region#">
        <cfdump var="#form.Side#">
        <cfdump var="#form.ID#">
        <cfabort> --->
        <!--- <cfexit> --->
        <cfquery name="qupdateLesions" datasource="#Application.dsn#" >
            update ST_Lesion set
            LesionPresent=<cfqueryparam cfsqltype="cf_sql_varchar" value='#LesionPresent#' >
            ,LesionType=<cfqueryparam cfsqltype="cf_sql_varchar" value='#LesionType#'>
            ,Region=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Region#'>
            ,Side=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Side#'>
            ,Status=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Status#'>
           
            
            where
            ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#ID#'>
            
        </cfquery>
        <!--- <cfdump var="#qupdateLesions#"> --->
		<cfreturn True>
	</cffunction>
</cfcomponent>