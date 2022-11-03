<cfquery name="ArtOrders" datasource="#application.dsn#">
    SELECT * FROM DOLPHIN_INTERACTIONS
    </cfquery>

<cfset  colList =  ArrayToList(ArtOrders.getColumnList())>

<cfset xlssRegistrant = SpreadsheetNew("Registrant",true) >
<cfloop>
    <cfset SpreadsheetAddRow(xlssRegistrant,#colList#)>
</cfloop>
<cfset SpreadsheetAddRows(xlssRegistrant, ArtOrders)>
<!--- Download spreadsheet in memory --->
<cfheader name="Content-Disposition" value="attachment;filename=DOLPHIN_INTERACTIONS.xlsx">
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#spreadSheetReadBinary(xlssRegistrant)#">