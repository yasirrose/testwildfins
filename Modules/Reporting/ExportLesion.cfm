<cfif CGI.HTTP_REFERER eq '#Application.siteroot#index.cfm?Module=Reporting&Page=LesionsReport'>
    <cfscript> 
        qFiltered1 = session.exportData;
        
        theSheet = SpreadsheetNew("LesionsReport");
        SpreadsheetAddRow(theSheet,ArrayToList(qFiltered1.getColumnList()));
        SpreadsheetFormatRow(theSheet, {bold=TRUE, alignment="left"}, 1 );
        for (idx = 1; idx lte 50; idx = idx +1) {
            if(idx == '5' || idx == '6' || idx == '7' || idx == '8' || idx == '11' || idx == '13' || idx == '14' || idx == '15' || idx == '17' || idx == '18' || idx == '19' || idx == '21'){
                SpreadSheetSetColumnWidth(theSheet,"#idx#",30);
            }else{
                SpreadSheetSetColumnWidth(theSheet,"#idx#",20);
            }
        }
        // SpreadSheetAddAutoFilter(theSheet,"A1:P1");
        SpreadsheetAddRows(theSheet,qFiltered1);
    </cfscript>
    <cffile  action="write" file = "C:\home\wildfins.org\subdomains\test\Reports\LesionReport\LesionReport.xls" output="theSheet">
    <cfheader name="Content-Disposition" value="attachment; filename=LesionsReport.xls"> 
    <cfcontent type="application/vnd.ms-excel" variable="#SpreadsheetReadBinary(theSheet)#">
</cfif>
        