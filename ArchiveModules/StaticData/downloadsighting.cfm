<cfquery name="ArtOrders" datasource="#application.dsn#">
    SELECT * FROM SIGHTINGS
    </cfquery>

    <cfset  colList =  ArrayToList(ArtOrders.getColumnList())>

<cfset xlssRegistrant = SpreadsheetNew("Registrant",true) >
    <cfset SpreadsheetAddRow(xlssRegistrant,#colList#)>
<cfset c1 = structnew()>
<cfset SpreadsheetAddRows(xlssRegistrant, ArtOrders)>
<cfset c1.val = {dataformat = "mm/dd/yyyy hh:mm:ss AM/PM"}>
<cfset SpreadsheetFormatColumn(xlssRegistrant, c1, "7-8") />



<!--- Download spreadsheet in memory --->
<cfheader name="Content-Disposition" value="attachment;filename=SIGHTINGS.xlsx">
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#spreadSheetReadBinary(xlssRegistrant)#">