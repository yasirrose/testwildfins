<cfquery name="ArtOrders" datasource="#application.dsn#">
    SELECT * from BIOPSY_SHOTS
    </cfquery>

    <cfset  colList =  ArrayToList(ArtOrders.getColumnList())>

<cfset xlssRegistrant = SpreadsheetNew("Registrant",true) >
<cfloop>
    <cfset SpreadsheetAddRow(xlssRegistrant,#colList#)>
</cfloop>

<!--- Download spreadsheet in memory --->
<cfheader name="Content-Disposition" value="attachment;filename=BIOPSY_SHOTS.xlsx">
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#spreadSheetReadBinary(xlssRegistrant)#">