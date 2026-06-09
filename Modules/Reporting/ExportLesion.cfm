<!--- <cfdump var="#Application.siteroot#" abort="true"> --->
<cfif CGI.HTTP_REFERER eq '#Application.siteroot#index.cfm?Module=Reporting&Page=LesionsReport' OR CGI.HTTP_REFERER eq 'https://test.wildfins.org/index.cfm?Module=Reporting&Page=LesionsReport'>
    
    <!--- CONFIGURATION: Chunk settings to prevent memory issues --->
    <cfset CHUNK_SIZE = 1000>
    <cfset MAX_RECORDS = 50000>
    
    <!--- Get data from session --->
    <cfset qFiltered1 = session.exportData>
    
    <!--- Check record count and validate --->
    <cfset recordCount = 0>
    <cftry>
        <cfif isDefined("qFiltered1") AND isQuery(qFiltered1)>
            <cfset recordCount = qFiltered1.recordCount>
            
            <!--- Check if record count exceeds limit --->
            <cfif recordCount GT MAX_RECORDS>
                <div class="alert alert-danger">
                    <cfoutput>
                        <strong>Export Limit Exceeded!</strong><br>
                        Your data contains #numberFormat(recordCount)# records.<br>
                        Maximum allowed per export is #numberFormat(MAX_RECORDS)# records.<br>
                        <br>
                        <strong>Please apply more filters to reduce the number of records.</strong>
                    </cfoutput>                    
                </div>
                <cfabort>
            </cfif>
            
            <!--- Warning for large exports --->
            <cfif recordCount GT 10000>
                <cfoutput>
                    <script>
                        if(!confirm('Your export contains #numberFormat(recordCount)# records. This may take several minutes and could temporarily slow down the server. Continue?')) {
                            window.location.href = 'index.cfm?Module=Reporting&Page=LesionsReport';
                        }
                    </script>
                </cfoutput>                
            </cfif>
        </cfif>
        
        <cfcatch>
            <cfset CHUNK_SIZE = 500>
        </cfcatch>
    </cftry>
    
    <cfscript> 
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
        
        // CHUNKED PROCESSING: Add rows in batches to prevent memory issues
        try {
            totalRows = qFiltered1.getRowCount();
            
            if(totalRows GT 0) {
                if(totalRows GT CHUNK_SIZE) {
                    // Process chunk by chunk
                    for(start = 1; start <= totalRows; start = start + CHUNK_SIZE) {
                        end = start + CHUNK_SIZE - 1;
                        if(end GT totalRows) end = totalRows;
                        
                        chunkData = qFiltered1.getRows(start, end);
                        SpreadsheetAddRows(theSheet, chunkData);
                    }
                } else {
                    // Small dataset - add all at once
                    SpreadsheetAddRows(theSheet,qFiltered1);
                }
            }
        } catch(any e) {
            // Fallback: Try adding all rows if chunking fails
            SpreadsheetAddRows(theSheet,qFiltered1);
        }
    </cfscript>
    <cffile  action="write" file = "C:\home\wildfins.org\subdomains\test\Reports\LesionReport\LesionReport.xls" output="theSheet">
    <cfheader name="Content-Disposition" value="attachment; filename=LesionsReport.xls"> 
    <cfcontent type="application/vnd.ms-excel" variable="#SpreadsheetReadBinary(theSheet)#">
</cfif>
        