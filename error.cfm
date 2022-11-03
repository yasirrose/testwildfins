<cfdump var="#session.ErrorException#" >
<cfdump var="#session.EventName#" >
<cfset exists= structdelete(session, 'ErrorException', true)/> 
 <cfset exists= structdelete(session, 'EventName', true)/> 