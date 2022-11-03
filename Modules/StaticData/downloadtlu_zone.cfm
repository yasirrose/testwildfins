<cfquery name="ArtOrders" datasource="#application.dsn#">
    SELECT [ZONE],[GRIDNUM],[LAT_DD],[LONG_DD],[EASTING],[NORTHING],[ZSEGMENT],[SSMA_TimeStamp],[ID] 
    from TLU_Zones
</cfquery>
<cfset  colList =  ArrayToList(ArtOrders.getColumnList())>
<cfset xlssRegistrant = SpreadsheetNew("Registrant",true) >
<cfset SpreadsheetAddRow(xlssRegistrant,#colList#)>
<cfset SpreadsheetAddRows(xlssRegistrant, ArtOrders)>
    <!--- Download spreadsheet in memory --->
<cfheader name="Content-Disposition" value="attachment;filename=tlu_zone.xlsx">
<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" variable="#spreadSheetReadBinary(xlssRegistrant)#">