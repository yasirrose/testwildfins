<cfif CGI.HTTP_REFERER eq '#Application.siteroot#index.cfm?Module=Reporting&Page=LesionsReport'>
    <cfscript> 
        qFiltered1 = session.exportData;
        
        theSheet = SpreadsheetNew("LesionsReport");
        SpreadsheetAddRow(theSheet,ArrayToList(qFiltered1.getColumnList()));
        SpreadsheetFormatRow(theSheet, {bold=TRUE, alignment="center"}, 1 );
        SpreadSheetSetColumnWidth(theSheet,"1",20);
        SpreadSheetAddAutoFilter(theSheet,"A1:P1");
        SpreadsheetAddRows(theSheet,qFiltered1);
    </cfscript>
    <cffile  action="write" file = "C:\home\wildfins.org\subdomains\test\Reports\LesionReport\LesionReport.xls" output="theSheet">
    <cfheader name="Content-Disposition" value="attachment; filename=LesionsReport.xls"> 
    <cfcontent type="application/vnd.ms-excel" variable="#SpreadsheetReadBinary(theSheet)#">
</cfif>
        