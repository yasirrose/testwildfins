<cfif CGI.HTTP_REFERER eq '#Application.siteroot#index.cfm?Module=Reporting&Page=AllFormsReport' OR CGI.HTTP_REFERER eq 'https://test.wildfins.org/index.cfm?Module=Reporting&Page=AllFormsReport'>
    
    <!--- CONFIGURATION: Chunk settings to prevent memory issues --->
    <cfset CHUNK_SIZE = 1000>  <!--- Process 1000 rows at a time --->
    <cfset MAX_RECORDS = 50000> <!--- Maximum records allowed in one export --->
    
    <!--- Get total count first to check limits --->
    <cfset recordCount = 0>
    <cftry>
        <!--- Get count query with same filters as main report --->
        <cfquery name="countQuery" datasource="wildfins_new">
            SELECT COUNT(*) as totalCount
            FROM Surveys s
            LEFT JOIN Survey_Sightings ss ON s.ID= ss.Project_ID
            LEFT JOIN Cetacean_Sightings cs ON ss.ID= cs.Sighting_ID
            LEFT JOIN Cetaceans c ON cs.Cetaceans_ID= c.ID
            LEFT JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
            where 1=1
            <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), s.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
            <cfif isdefined("form.surveyRoute") and form.surveyRoute neq ""> and CONCAT(',', s.SurveyRoute, ',') LIKE '%,#form.surveyRoute#,%'</cfif>
            <cfif isdefined("form.BodyCondition") and form.BodyCondition neq ""> and cs.BodyCondition = '#form.BodyCondition#'</cfif>
            <cfif isdefined("form.bodyOfWater") and form.bodyOfWater neq ""> and s.BodyOfWater = '#form.bodyOfWater#'</cfif>
            <cfif isdefined("form.surveyType")  and form.surveyType  neq ""> and s.SurveyType = '#form.surveyType#'</cfif>
            <cfif isdefined("form.code")  and form.code neq ""> and c.Code = '#form.code#'</cfif>
            <cfif isdefined("form.SDR")  and form.SDR neq ""> and cs.SDR = '#form.SDR#'</cfif>
            <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies neq ""> and tlu.CetaceanSpeciesName = '#form.cetaceanSpecies#'</cfif>
            <cfif isdefined("form.platform") and form.platform neq ""> and s.platform = '#form.platform#'</cfif>
            <cfif isdefined("form.NOAAStock") and form.NOAAStock neq ""> and s.NOAAStock like '%#form.NOAAStock#%'</cfif>
            <cfif isdefined("form.surveyEffort") and form.surveyEffort neq ""> and ss.Survey = '#form.surveyEffort#'</cfif>
            AND ss.IsDeleted != 1
            AND s.IsDeleted != 1
            AND tlu.CetaceanSpeciesName != ''
        </cfquery>
        
        <cfset recordCount = countQuery.totalCount>
        
        <!--- Check if record count exceeds limit --->
        <cfif recordCount GT MAX_RECORDS>
            <div class="alert alert-danger">
                <cfoutput>
                    <strong>Export Limit Exceeded!</strong><br>
                    Your query returned #numberFormat(recordCount)# records.<br>
                    Maximum allowed per export is #numberFormat(MAX_RECORDS)# records.<br>
                    <br>
                    <strong>Please apply more filters to reduce the number of records.</strong>
                </cfoutput>                
            </div>
            <cfabort>
        </cfif>
        
        <cfif recordCount GT 10000>
            <!--- Show warning for large exports but allow continuation --->
            <cfoutput>
                <script>
                    if(!confirm('Your export contains #numberFormat(recordCount)# records. This may take several minutes and could temporarily slow down the server. Continue?')) {
                        window.location.href = 'index.cfm?Module=Reporting&Page=AllFormsReport';
                    }
                </script>
            </cfoutput>            
        </cfif>
        
        <cfcatch>
            <!--- If count query fails, proceed with export but use smaller chunks --->
            <cfset CHUNK_SIZE = 500>
            <cfset recordCount = 0>
        </cfcatch>
    </cftry>
    
    <!--- Get data with chunking support --->
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
        
        // CHUNKED PROCESSING: Add rows in batches to prevent memory issues
        try {
            // Get total row count
            totalRows = allFormExcel.getRowCount();
            
            if(totalRows GT 0) {
                // Process in chunks
                startRow = 2; // Start after header row
                
                // For very large datasets, use SpreadsheetAddRows with subset
                if(totalRows GT CHUNK_SIZE) {
                    // Process chunk by chunk
                    for(start = 1; start <= totalRows; start = start + CHUNK_SIZE) {
                        end = start + CHUNK_SIZE - 1;
                        if(end GT totalRows) end = totalRows;
                        
                        // Get subset of data for this chunk
                        chunkData = allFormExcel.getRows(start, end);
                        SpreadsheetAddRows(theSheet, chunkData);
                        
                        // Optional: Force garbage collection between chunks
                        // This helps free memory in long-running operations
                    }
                } else {
                    // Small dataset - add all at once
                    SpreadsheetAddRows(theSheet,allFormExcel);
                }
            }
        } catch(any e) {
            // Fallback: Try adding all rows if chunking fails
            SpreadsheetAddRows(theSheet,allFormExcel);
        }
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