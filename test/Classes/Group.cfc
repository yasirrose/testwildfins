<cfcomponent displayName="Group" output="false">
<cfset variables.dsn = "wildfins">
<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
  <cfargument name="dsn" type="string" required="true" hint="datasource">
  <cfset variables.dsn = arguments.dsn>
  <cfreturn this>
</cffunction>

<!--- Group Mangement --->
<cffunction name="GroupInsert" returntype="any" output="false" access="public" >
    <cfquery name="qGroupInsert" datasource="#variables.dsn#"  result="return_data" >
     	INSERT INTO groups (group_name, group_description, group_status) VALUES(
        <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.group_name#' >,
        <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.group_description#' >,
        <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.group_status#' >
        )
    </cfquery>
	<cfreturn return_data>
</cffunction>

<cffunction name="getGroup" returntype="any" output="false" access="public" >
    <cfquery name="qgetGroup" datasource="#variables.dsn#"  >
        SELECT * from groups
    </cfquery>
	<cfreturn qgetGroup>
</cffunction>

<cffunction name="getGroupByword" returntype="any" output="false" access="public" >
    <cfquery name="qGroup" datasource="#variables.dsn#"  >
        SELECT * from groups WHERE group_name LIKE '%#form.searchword#%';
    </cfquery>
	<cfreturn qGroup>
</cffunction>


 <cffunction name="EditGroup" returntype="any" output="false" access="public" >
 <cfquery name="qEditGroup" datasource="#variables.dsn#" result="GroupUpdate">
    UPDATE groups SET
    group_name	=<cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.group_name#' >,
    group_description = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.group_description#' >,
    group_status = <cfqueryparam cfsqltype="cf_sql_varchar" value='#FORM.group_status#' >
    WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#FORM.ID#' >
  </cfquery>
	<cfreturn GroupUpdate>
</cffunction>

<cffunction name="DeleteGroup" returntype="any" output="false"  access="remote" >
 <cfquery name="qDeleteGroup" datasource="#variables.dsn#" result="GroupDelete">
    DELETE FROM groups   WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
  </cfquery>
</cffunction>




</cfcomponent>