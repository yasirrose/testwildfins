<cfcomponent displayName="Common" output="false">
<cfset variables.dsn = "wildfins">
<cffunction name="init" access="public" returnType="Common" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
  <cfargument name="dsn" type="string" required="true" hint="datasource">
  <cfset variables.dsn = arguments.dsn>
  <cfreturn this>
</cffunction>

<!--- web category --->
<cffunction name="getWebCategory" returntype="any" output="false" access="public" >
<cfquery name="q" datasource="#variables.dsn#"  >
SELECT WebCategory.ID, WebCategory.WebCategory
FROM WebCategory
ORDER BY WebCategory.[WebCategory];
</cfquery>
<cfreturn q>
</cffunction>
<!--- DateFormat --->
<cffunction name="FormatDate" returntype="any" output="false" access="public" >
<cfargument name="date" type="any" required="true" default="">
<cfset FormatedDate = DateFormat(date , 'mm/dd/yyyy') >
<cfreturn FormatedDate>
</cffunction>
</cfcomponent>