<cfset counter = 0>

    <cfquery name="deletebiopsy" datasource="#Application.dsn#" result="deltproject">
        delete from TLU_Zones
    </cfquery>

    <cfif #deltproject.recordcount# gte 1>
        <h1 style="text-align:center">Data is empty</h1>
    <cfelse>
        <h1 style="text-align:center">Table empty ! Data is not deleted</h1>
    </cfif>
