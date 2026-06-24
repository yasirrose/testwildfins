<!--- ending session scope --->

<cfset exists= structdelete(session, 'UserDetails', true)/>  

 <cflocation addtoken="no" url="#Application.siteroot#" >