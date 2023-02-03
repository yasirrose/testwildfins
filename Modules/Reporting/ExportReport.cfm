<cfif CGI.HTTP_REFERER eq '#Application.siteroot#index.cfm?Module=Reporting&Page=AllFormsReport'>
    <cfset allFormExcel = Application.Reporting.allFormExcel("#FORM#")>
    <!--- <cfdump var="#allFormExcel#" abort="true"> --->
    <cfscript> 
        theSheet = SpreadsheetNew("AllDataReport");
        SpreadsheetAddRow(theSheet,ArrayToList(allFormExcel.getColumnList()));
        SpreadsheetFormatRow( theSheet, {bold=TRUE, alignment="left"}, 1 );
        // SpreadSheetAddAutoFilter(theSheet,"A1:CP4");

        for (idx = 1; idx lte 230; idx = idx +1) {
            if(idx  == '51' || idx  == '47' || idx  == '48' || idx  == '49' || idx  == '50' || idx  == '52' || idx  == '53' || idx  == '54' || idx  == '55' || idx  == '56' || idx  == '57' || idx  == '58' || idx  == '59' || idx  == '60' || idx  == '61' || idx  == '62' || idx  == '84' || idx  == '80' || idx  == '79' || idx  == '73' || idx  == '74' || idx  == '75' || idx  == '76' || idx  == '77' || idx  == '78' || idx  == '141' || idx  == '159' || idx  == '160' || idx  == '161' || idx  == '162' || idx  == '163' || idx  == '166' || idx  == '167' || idx  == '168' || idx  == '169' || idx  == '170' || idx  == '171')
            {
                SpreadSheetSetColumnWidth(theSheet,"#idx#",30);
            }else if(idx  == '85' || idx  == '87' || idx  == '88' || idx  == '89' || idx  == '90' || idx  == '91' || idx  == '92' || idx  == '93' || idx  == '94' || idx  == '96' || idx  == '97' || idx  == '98' || idx  == '99' || idx  == '100' || idx  == '101' || idx  == '102' || idx  == '103' || idx  == '104' || idx  == '105' || idx  == '106' || idx  == '107' || idx  == '108' || idx  == '109' || idx  == '110' || idx  == '111' || idx  == '112' || idx  == '113' || idx  == '114' || idx  == '115')
            {
                SpreadSheetSetColumnWidth(theSheet,"#idx#",47);
            }else if(idx  == '95'){
                SpreadSheetSetColumnWidth(theSheet,"#idx#",55);
            }
            else{
                SpreadSheetSetColumnWidth(theSheet,"#idx#",20);
            }
         }
        // SpreadSheetSetColumnWidth(theSheet,"10",20);
        // SpreadSheetSetColumnWidth(theSheet,"11",20);
        // SpreadSheetSetColumnWidth(theSheet,"12",20);
        // SpreadSheetSetColumnWidth(theSheet,"13",20);
        // SpreadSheetSetColumnWidth(theSheet,"17",20);
        // SpreadSheetSetColumnWidth(theSheet,"18",20);
        // SpreadsheetFormatColumns(theSheet,{textwrap="true"},"1-200");
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