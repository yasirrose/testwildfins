<cfset counter =0>
<cftry>
    <cfquery name="deltInteractions" datasource="#Application.dsn#" result="deltInteractions">
        delete from DOLPHIN_INTERACTIONS
    </cfquery>
    <cfif #deltInteractions.recordcount# eq 1>
        <cfset counter =1>
    </cfif>
    <cfif counter eq 1>
        <cflocation url="http://test.wildfins.org/?ArchiveModule=StaticData&Page=Interactionimport&Archive">
    </cfif>
    <cfcatch  type="any">
    </cfcatch>
</cftry>

<cfif counter eq 0>
    <h1 style="text-align:center">Data is empty</h1>
</cfif>

