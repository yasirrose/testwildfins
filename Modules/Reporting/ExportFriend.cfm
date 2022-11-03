<cfif CGI.HTTP_REFERER eq '#Application.siteroot#index.cfm?Module=Reporting&Page=FriendsReport'>
    <cfscript> 
        qFiltered1 = session.exportData;
        theSheet = SpreadsheetNew("FriendsReport");
        SpreadsheetAddRow(theSheet,ArrayToList(qFiltered1.getColumnList()));
        SpreadsheetFormatRow(theSheet, {bold=TRUE, alignment="center"}, 1 );
        SpreadSheetSetColumnWidth(theSheet,"1",30);
        SpreadSheetSetColumnWidth(theSheet,"3",20);
        SpreadSheetAddAutoFilter(theSheet,"A1:c1");
        SpreadsheetAddRows(theSheet,qFiltered1);
    </cfscript>
    <cffile  action="write" file = "C:\home\wildfins.org\subdomains\test\Reports\FriendReport\FriendReport.xls" output="theSheet">
    <cfheader name="Content-Disposition" value="attachment; filename=FriendsReport.xls"> 
    <cfcontent type="application/vnd.ms-excel" variable="#SpreadsheetReadBinary(theSheet)#">
</cfif>
        