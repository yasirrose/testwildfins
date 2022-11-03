<cfquery name="ArtOrders" datasource="#application.dsn#">
    SELECT * from PROJECTS
    </cfquery>

    <cfset  colList =  ArrayToList(ArtOrders.getColumnList())>

<cfset xlssRegistrant = SpreadsheetNew("Registrant",true) >
<cfloop>
    <cfset SpreadsheetAddRow(xlssRegistrant,#colList#)>
</cfloop>
<cfset SpreadsheetAddRows(xlssRegistrant, ArtOrders)>
<cfset col1 = {dataformat = "YYYY-MM-DD hh:mm:ss AM/PM"}>
<cfset SpreadsheetFormatColumns(xlssRegistrant, col1, "2-6")>

<!--- Download spreadsheet in memory --->
<cfheader name="Content-Disposition" value="attachment;filename=Survey.xlsx">
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#spreadSheetReadBinary(xlssRegistrant)#">