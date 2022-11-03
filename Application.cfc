<cfcomponent displayname="Application" output="false" hint="Primary application event handler.">
  <!--- Set application settings. --->
  <cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 59, 0 ) />
  <cfset THIS.SessionManagement = true />
  <cfset THIS.sessiontimeout=CreateTimeSpan(0,1,0,0)>
  <cfset THIS.name= "GoalTrackingSystemTest">

  <!--- on application start  --->
  <cffunction
      name="OnApplicationStart"
      access="public"
      returntype="boolean"
      output="false"
      hint="Fires when the application is first created.">
    <!---- datasource --->		
    <!--- Old DATABASE wildfins_access_db --->
    <cfset Application.dsn = "wildfins_new">
    <cfif structKeyExists(url, 'Archive')>
      <cfset Application.dsn = "wildfins">
    </cfif>

    <!--- define port --->
    <cfif SERVER_PORT eq '80' >
      
      <!--- application root ---->
      <cfset Application.siteroot = 'http://#SERVER_NAME#/' >
      <cfelse>
      <cfset Application.siteroot = 'http://#SERVER_NAME#:#SERVER_PORT#/' >
    </cfif>
    
    <!--- application super admin modules directory --->
    <cfset Application.moduleDirectory = 'Modules' >
    <cfset this.rootDir = getDirectoryFromPath(getCurrentTemplatePath())/>
    
    <cfset this.mappings[ "/WildfinsModules" ] = "#this.rootDir##Application.moduleDirectory#/" />
    <cfset this.mappings[ "/WildfinsTemplates" ] = "#this.rootDir#Templates/" />
    <cfset Application.DirectoryRoot = ExpandPath('.\') >
    
    <!--- application super admin ---->
    <cfset Application.superadmin = '#Application.siteroot#' >
    <cfset Application.CloudRoot= 'http://cloud.wildfins.org/' >
    
    <cfset Application.CloudDirectory = 'C:\home\wildfins.org\subdomains\cloud\'>
    
    <!--- application super admin resources --->
    <cfset Application.superadminResources = '#Application.superadmin#resources/' >
    <cfset Application.record_per_page = 10000>
      
    <!--- application tempaltes includes directory ---->
    <cfset Application.superadminTemplateIncludes = '#Application.superadminResources#assets/' >
    
    <!--- application Script includes directory 
     <cfset Application.script = '#Application.siteroot#scripts/' >
    <cfset Application.Common = createObject("component","Classes.Common").init(Application.dsn)>
    <cfset Application.SuperAdminApp = createObject("component","Classes.SuperAdminApp").init(Application.dsn)>
    <cfset Application.SuperAdminAppNew = createObject("component","Classes.SuperAdminAppNew").init(Application.dsn)>
    <cfset Application.StaticData = createObject("component","Classes.StaticData").init(Application.dsn)>
    <cfset Application.StaticDataNew = createObject("component","Classes.StaticDataNew").init(Application.dsn)>
    <cfset Application.Accounts = createObject("component","Classes.Accounts").init(Application.dsn)> 
    <cfset Application.Group = createObject("component","Classes.Group").init(Application.dsn)>
    <cfset Application.Sighting = createObject("component","Classes.Sighting").init(Application.dsn)>
    <cfset Application.SightingNew = createObject("component","Classes.SightingNew").init(Application.dsn)>
    <cfset Application.Dolphin = createObject("component","Classes.Dolphin").init(Application.dsn)>
    <cfset Application.Reporting = createObject("component","Classes.Reporting").init(Application.dsn)> 
    ---->
    <cfreturn true>
  </cffunction>
  
  <cffunction
      name="OnRequestStart"
      access="public"
      returntype="boolean"
      output="false"
      hint="Hanldes pre-page processing for each request.">
      
          <cfset Application.dsn = "wildfins_new">
          <cfif structKeyExists(url, 'Archive')>
            <cfset Application.dsn = "wildfins">
          </cfif>

        <!--- application Script includes directory ---->
      <cfset Application.script = '#Application.siteroot#scripts/' >
      <cfset Application.Common = createObject("component","Classes.Common").init(Application.dsn)>
      <cfset Application.SuperAdminApp = createObject("component","Classes.SuperAdminApp").init(Application.dsn)>
      <cfset Application.SuperAdminAppNew = createObject("component","Classes.SuperAdminAppNew").init(Application.dsn)>
      <cfset Application.StaticData = createObject("component","Classes.StaticData").init(Application.dsn)>
      <cfset Application.StaticDataNew = createObject("component","Classes.StaticDataNew").init(Application.dsn)>
      <cfset Application.Accounts = createObject("component","Classes.Accounts").init(Application.dsn)>
      <cfset Application.Group = createObject("component","Classes.Group").init(Application.dsn)>
      <cfset Application.Sighting = createObject("component","Classes.Sighting").init(Application.dsn)>
      <cfset Application.SightingNew = createObject("component","Classes.SightingNew").init(Application.dsn)>
      <cfset Application.Dolphin = createObject("component","Classes.Dolphin").init(Application.dsn)>
      <cfset Application.Cetaceans = createObject("component","Classes.Cetaceans").init(Application.dsn)>
      <cfset Application.Reporting = createObject("component","Classes.Reporting").init(Application.dsn)>
      <cfset Application.ConditionLesions = createObject("component","Classes.ConditionLesions").init(Application.dsn)>
      <cfset Application.IncidentReport = createObject("component","Classes.IncidentReport").init(Application.dsn)>
      <cfset Application.AccountsNew = createObject("component","Classes.AccountsNew").init(Application.dsn)>
      <cfset Application.Stranding = createObject("component","Classes.Stranding").init(Application.dsn)>
      <cfset Application.test = createObject("component","Classes.test").init(Application.dsn)>
      
      <cfif isdefined('URL.reset') >
        <cfset OnApplicationStart() />
      </cfif>
      <cfif isdefined('URL.destroy') >
        <cfset StructClear(Session)>
        <cflocation url="http://test.wildfins.org/">
      </cfif>
      <cfreturn true />
  </cffunction>

  <cffunction name="onError" returnType="void" output="TRUE">
    <cfargument name="Exception" required="true">
    <cfargument name="EventName" type="string" required="true">
    <cfset session.ErrorException = Exception >
    <cfset session.EventName = EventName >
    <cfdump  var="#Exception#"><cfabort>
<!---     	<cfmail to="techleadz.cfm@gmail.com" from="support@wildfins.org"  subject="WILDFINS-BugID-#CreateUUID()#" type="html" > 
          <cfdump var="#Exception#" label="Exception" >
          <cfdump var="#EventName#" label="EventName" >
          <cfdump var="#CGI#" label="CGI" >
          <cfdump var="#FORM#" label="FORM" >
          <cfdump var="#URL#" label="URL" >
        </cfmail> --->
        <cflocation url="error.cfm" addtoken="no" >
  </cffunction> 
</cfcomponent>