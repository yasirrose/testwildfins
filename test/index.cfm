<!DOCTYPE html>
<html lang="en">
<!--- all parameters --->
<cfparam name="page" default="" >
<cfparam name="module" default="" >
<cfparam name="ArchiveModule" default="" >


<cfsetting requesttimeout="3600">


<!--- including  header ---->
<cfinclude template="Templates/headincludes.cfm" >
<body>
<cfoutput>
<cfif #cgi.REMOTE_ADDR# neq "110.39.156.90">
    <!-- begin ##page-loader -->
    <div id="page-loader" class="page-loader fade in"><span class="spinner">Loading...</span></div>
    <!-- end ##page-loader -->
</cfif>

<!-- begin ##page-container -->
<div id="page-container" class="<cfif #cgi.REMOTE_ADDR# neq "110.39.156.90">fade </cfif>page-container page-header-fixed page-sidebar-fixed page-with-two-sidebar page-with-footer">
  <!---- including module pages ---->


<cfif isdefined('SESSION.UserDetails') AND NOT StructIsEmpty(SESSION.UserDetails)>
    <cfset  permissions ="#session['userdetails']['permissions']#">
    <cfif page eq '' and module eq '' >
        <cflocation addtoken="no" url="#Application.siteroot#?Module=Home&Page=Dashboard" >
    <cfelseif permissions neq "full_access" and (findNoCase("M-D", permissions) eq 0 and module eq 'StaticData')> 
        <cflocation addtoken="no" url="#Application.siteroot#?Module=Security&Page=index" > 
    <cfelseif permissions neq "full_access" and (findNoCase("U-G", permissions) eq 0 and module eq 'Accounts')> 
        <cflocation addtoken="no" url="#Application.siteroot#?Module=Security&Page=index" >   
    <cfelse>
    	<cfinclude template="Templates/header.cfm">
        <cfinclude template="Templates/sidebar.cfm">

        <cfif ArchiveModule eq '' >
            <cfinclude template="Modules/#module#/#page#.cfm">
        <cfelse>
            <cfinclude template="ArchiveModules/#ArchiveModule#/#page#.cfm">
        </cfif>
    </cfif>
<cfelse>
	<cfinclude template="Modules/Home/login.cfm">
</cfif>



</div>
<!-- end page container -->

<cfinclude template="Templates/footerincludes.cfm">
<!--- application level script --->
<script src="#Application.script#app.js?v=23" ></script>
<!--- Module level script --->
<cfif page neq '' and module neq '' and isdefined('SESSION.UserDetails') AND NOT StructIsEmpty(SESSION.UserDetails) >
<script src="#Application.script##module#.js?v=23" ></script>
<!--- Page level script --->
<script src="#Application.script##module#/#page#.js?v=23" ></script>
</cfif>

<cfif page neq '' and ArchiveModule neq '' and isdefined('SESSION.UserDetails') AND NOT StructIsEmpty(SESSION.UserDetails) >
<script src="#Application.script##ArchiveModule#.js?v=23" ></script>
<!--- Page level script --->
<script src="#Application.script##ArchiveModule#/#page#.js?v=23" ></script>
</cfif>

<cfinclude template="Templates/footer.cfm">
</cfoutput>
   
	
</body>
</html>
