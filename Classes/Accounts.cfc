<cfcomponent displayName="Accounts" output="false">
<cfset variables.dsn = "#Application.dsn#">
<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
  <cfargument name="dsn" type="string" required="true" hint="datasource">
  <cfset variables.dsn = arguments.dsn>
  <cfreturn this>
</cffunction>


<!-------Get alll User list ---------->
<cffunction name="getAlluserlist" returntype="any" output="false" access="public" >
    <cfquery name="query" datasource="#variables.dsn#"  >
        select * from users
    </cfquery>
	<cfreturn query>
</cffunction>


<!------- User list ---------->
<cffunction name="getuserlist" returntype="any" output="false" access="public" >
    <cfquery name="query" datasource="#variables.dsn#"  >
        select * from users where user_type != 'Super Admin'
    </cfquery>
	<cfreturn query>
</cffunction>
<!------- User list for testing page ---------->
<cffunction name="getuserlistt" returntype="any" output="false" access="public" >
    <cfquery name="query" datasource="#variables.dsn#"  >
        select * from users where user_type != 'Super Admin' AND status !='enable'
    </cfquery>
	<cfreturn query>
</cffunction>

<!------- Group list ---------->
<cffunction name="getgrouplist" returntype="any" output="false" access="public" >
    <cfquery name="query" datasource="#variables.dsn#"  >
         select * from groups
    </cfquery>
	<cfreturn query>
</cffunction>

<!------- Group list ---------->
<cffunction name="getuserbygroup" returntype="any" output="false" access="public" >
    <cfquery name="query" datasource="#variables.dsn#"  >
         select * from users where group_member = 'Y' and group_id = '#form.groupId#'
    </cfquery>
	<cfreturn query>
</cffunction>

<!------- Delete User ---------->
<cffunction name="DeleteUser" returntype="any" output="false" access="remote" >
    <cfquery name="query" datasource="#variables.dsn#">
     Delete from users where user_id ='#URL.id#'
    </cfquery>
</cffunction>


<!------- Insert User ---------->
<cffunction name="InsertUser" returntype="any" output="false" access="public" >
    <cfquery name="getuser" datasource="#variables.dsn#" result="allusers">
        select * from users
        where user_email = '#form.user_email#'
    </cfquery>
    <cfif getuser.recordCount gt 0>
        <cfreturn allusers>
    </cfif>    
    <cfset firstName = form.first_name>
  <cfset lastName =  form.last_name>
  <cfset userPassword =  Hash(form.user_password, "md5")>
  <cfset username = form.username>
  <cfset userEmail =  form.user_email>
  <cfset userTypeForm =  form.user_category>
  <cfset userStatus =  form.group_status>
  <cfset groupID =  form.group_name>
  <cfset permissions =  form.permission>
  
    <cfquery name="query" datasource="#variables.dsn#" result="userinsert">
        INSERT INTO users (first_name, last_name,user_name,user_password,permissions,user_email,user_type,status,group_id,group_member) VALUES('#firstName#','#lastName#','#username#','#userPassword#','#permissions#','#userEmail#','#userTypeForm#','#userStatus#','#groupID#','Y')
    </cfquery>
    <cfreturn  userinsert>
</cffunction>



<!------- Update User ---------->
<cffunction name="UpdateUser" returntype="any" output="false" access="public" >

  <cfset firstName   =  form.first_name>
  <cfset lastName    =  form.last_name>
  <cfset username    =  form.username>
  <cfset userEmail   =  form.user_email>
  <cfset userTypForm =  form.user_category>
  <cfset userStatus  =  form.group_status>
  <cfset groupID 	 =  form.group_name>
  <cfset permissions =  isdefined("form.permission") ? form.permission : "">
   <cfquery name="query" datasource="#variables.dsn#" result="userupdated">
    UPDATE users SET first_name = '#firstName#', last_name = '#lastName#' , user_name = '#username#',permissions = '#permissions#' , user_email = '#userEmail#' , user_type = '#userTypForm#' ,status ='#userStatus#' ,group_id = '#groupID#' , group_member = 'Y'
 where user_id = '#form.userId#' 
     </cfquery>
</cffunction>

<!------- User getroles ---------->
<cffunction name="getroles" returntype="any" output="false" access="public" >
   
   <cfquery name="query" datasource="#variables.dsn#">
   	select * from user_roles where role_name != 'Super Admin'
   </cfquery>
   <cfreturn query>
</cffunction>


<!------- User getuserdetail ---------->
<cffunction name="getuserdetail" returntype="any" output="false" access="public" >
   <cfquery name="query" datasource="#variables.dsn#">
   select * from users where user_id = '#form.userId#'
   </cfquery>
   <cfreturn query>
</cffunction>


<!------- getUser Activity ---------->
<cffunction name="getUserActivity" returntype="any" output="false" access="public" >
<cfargument  name="userId" default="0" required="yes">
   <cfquery name="query" datasource="#variables.dsn#">
   select * from users  inner join users_activity on  users.user_id=users_activity.UserID 
     where users.user_id = '#userId#'
   </cfquery>
   <cfreturn query>
</cffunction>




    
</cfcomponent>