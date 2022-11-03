<cfset counter = 0>
<cftry>
<cfquery name="deletebiopsy" datasource="#Application.dsn#" result="deltsight">
        delete from SIGHTINGS
    </cfquery>

<cfif #deltsight.recordcount# eq 1>
<cfset counter =1 >
    </cfif>
 <cfif counter eq 1>
 <cflocation url="http://test.wildfins.org/?ArchiveModule=StaticData&Page=sightingimport&Archive">
</cfif>
<cfcatch>
</cfcatch>
</cftry>
    <cfif counter eq 0>
   <h1 style="text-align: center">Data is empty</h1>
</cfif>
