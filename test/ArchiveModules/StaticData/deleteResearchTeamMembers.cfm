<cfquery name="deleteResearchTeamMembers" datasource="#Application.dsn#" result="deleteRecords">
    delete from RESEARCHTEAMMEMBER_PROJECTS
</cfquery>

<cfif #deleteRecords.recordcount# gte 1>
    <h1 style="text-align:center">Data is empty</h1>
<cfelse>
    <h1 style="text-align:center">Table empty ! Data is not deleted</h1>
</cfif>
