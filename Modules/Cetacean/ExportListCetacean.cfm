<cfif CGI.HTTP_REFERER eq '#Application.siteroot#?Module=Cetacean&Page=ListCetacean'>
    <!--- <cfdump var="#form.SEARCHWORD#" abort="true"> --->
    <cfquery name="query" datasource="wildfins_new">
        SELECT 
            -- Cetaceans.ID, 
            Cetaceans.Name as Cetacean_Name, 
            Cetaceans.Code, 
            Cetaceans.Sex, 
            TLU_SourceSex.Ssex,
            Cetaceans.Lineage, 
            Cetaceans.Mother, 
            Cetaceans.DateOfBirthEstimate, 
            Cetaceans.YearOfBirth, 
            TLU_YOB_Source.YOBSource,
            Cetaceans.DateDeath, 
            Cetaceans.FirstSightingDate, 
            TLU_CetaceanSpecies.CetaceanSpeciesName, 
            Cetaceans.DScore, 
            Cetaceans.PresumedDead, 
            Cetaceans.Dead, 
            Cetaceans.HUBBS_ID, 
            Cetaceans.Field_ID, 
            Cetaceans.FB_Number, 
            Cetaceans.HBOCI_CODE 
            -- Cetaceans.CetaceanSpecies 
        FROM 
            Cetaceans
        LEFT JOIN 
            TLU_YOB_Source ON Cetaceans.SourceYOB = TLU_YOB_Source.ID
        LEFT JOIN 
            TLU_CetaceanSpecies ON TLU_CetaceanSpecies.ID = Cetaceans.CetaceanSpecies
        LEFT JOIN 
            TLU_SourceSex ON TLU_SourceSex.ID = Cetaceans.SourceSexed
        <cfif isDefined('form.SEARCHWORD') AND len(trim(form.SEARCHWORD)) GT 0>
            where Cetaceans.Name LIKE '%#trim(form.SEARCHWORD)#%' OR Cetaceans.Code LIKE  '%#trim(form.SEARCHWORD)#%' OR TLU_CetaceanSpecies.CetaceanSpeciesName LIKE  '%#trim(form.SEARCHWORD)#%'
        </cfif>
        ORDER BY 
            Cetaceans.Code
    </cfquery>
    

    <!--- <cfdump var="#query#" abort="true"> --->
    <cfscript> 
        theSheet = SpreadsheetNew("List Cetacean");
        columnHeaders = query.getColumnList();
        SpreadsheetAddRow(theSheet, ArrayToList(columnHeaders));
        SpreadsheetFormatRow(theSheet, {bold=TRUE, alignment="left"}, 1);
    
        for (i = 1; i <= arrayLen(columnHeaders); i++) {
            // Calculate column width based on the length of the column header text (scaled)
            columnWidth = len(columnHeaders[i]) * 2; // Adjust multiplier if needed for better fit
            SpreadsheetSetColumnWidth(theSheet, i, columnWidth);
        }
    
        // Add the query data to the spreadsheet
        SpreadsheetAddRows(theSheet, query);
    </cfscript> 
    
    <!--- Write spreadsheet to file --->
    <cffile action="write" file="C:\home\wildfins.org\subdomains\test\Reports\ListCetacean.xls" 
            output="#SpreadsheetReadBinary(theSheet)#">
    
    <!--- Set headers for downloading the spreadsheet --->
    <cfheader name="Content-Disposition" value="attachment; filename=ListCetacean.xls"> 
    <cfcontent type="application/vnd.ms-excel" variable="#SpreadsheetReadBinary(theSheet)#">
    

<cfelse>
    <cflocation url="#Application.siteroot#" addtoken="no">
</cfif>
  