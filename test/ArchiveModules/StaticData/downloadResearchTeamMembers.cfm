<cfquery name="ArtOrders" datasource="#application.dsn#">
    SELECT *
    from RESEARCHTEAMMEMBER_PROJECTS
</cfquery>
<cfset  colList =  ArrayToList(ArtOrders.getColumnList())>
<cfset xlssRegistrant = SpreadsheetNew("Registrant",true) >
<cfset SpreadsheetAddRow(xlssRegistrant,#colList#)>
<cfset SpreadsheetAddRows(xlssRegistrant, ArtOrders)>
    <!--- Download spreadsheet in memory --->
<cfheader name="Content-Disposition" value="attachment;filename=researchTeamMemberProjects.xlsx">
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#spreadSheetReadBinary(xlssRegistrant)#">