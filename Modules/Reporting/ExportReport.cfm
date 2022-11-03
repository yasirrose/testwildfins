<cfif CGI.HTTP_REFERER eq '#Application.siteroot#index.cfm?Module=Reporting&Page=AllFormsReport'>
    <cfset allFormExcel = Application.Reporting.allFormExcel("#FORM#")>
    <cfscript> 
        theSheet = SpreadsheetNew("AllDataReport");
        SpreadsheetAddRow(theSheet,ArrayToList(allFormExcel.getColumnList()));
        SpreadsheetFormatRow( theSheet, {bold=TRUE, alignment="center"}, 1 );
        SpreadSheetAddAutoFilter(theSheet,"A1:CP4");
        SpreadSheetSetColumnWidth(theSheet,"2",20);
        SpreadSheetSetColumnWidth(theSheet,"10",20);
        SpreadSheetSetColumnWidth(theSheet,"11",20);
        SpreadSheetSetColumnWidth(theSheet,"12",20);
        SpreadSheetSetColumnWidth(theSheet,"13",20);
        SpreadSheetSetColumnWidth(theSheet,"17",20);
        SpreadSheetSetColumnWidth(theSheet,"18",20);
        SpreadsheetFormatColumns(theSheet,{textwrap="true"},"1-123");
        SpreadsheetAddRows(theSheet,allFormExcel);
    </cfscript> 
    <cffile  action="write" file = "C:\home\wildfins.org\subdomains\dev-wildfins\Reports\AllDataReport.xls" output="theSheet">
    <cfheader name="Content-Disposition" value="attachment; filename=AllDataReport.xls"> 
    <cfcontent type="application/vnd.ms-excel" variable="#SpreadsheetReadBinary(theSheet)#">
    <script>
        localStorage.clear();
        $('#ConditionFromSighting').attr('checked', false);
        $('#AtICWMarker').attr('checked', false);
        $('#SightingStartEnd').attr('checked', false);
        $('#location').attr('checked', false);
        $('#fieldEstimate').attr('checked', false);
        $('#activity').attr('checked', false);
        $('#behavioralEvents').attr('checked', false);
        $('#feedingEcology').attr('checked', false);
        $('#fisheriesInteractions').attr('checked', false);
        $('#HBOIVesselInteractions').attr('checked', false);
        $('#boatingInteractions').attr('checked', false);
        $('#divetimes').attr('checked', false);
    </script>
<cfelse>
    <cflocation  url="#Application.siteroot#" addtoken="no">
</cfif>    