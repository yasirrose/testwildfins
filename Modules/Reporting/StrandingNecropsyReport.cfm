<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <cfset variables.dsn = "wildfins_new">
    <cfset today = now()>
 
    <cfquery name="lesionRegion" datasource="#variables.dsn#">
        SELECT * from TLU_Regions
    </cfquery>
    <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')>
        
        <cfset blueBoxColumns = ""> 

        <!--- Check if the checkbox is selected and set extra columns --->
        <cfif structKeyExists(form, "BLUEBOX") AND form.BLUEBOX eq "1">
            <!--- Example: add columns "Column1, Column2, Column3" --->
            <cfset collation = "SQL_Latin1_General_CP1_CI_AS">

            <cfset blueBoxColumns = "
            , CAST(Location AS NVARCHAR(255)) COLLATE #collation# AS Location
            , CAST(NAA AS NVARCHAR(255)) COLLATE #collation# AS NAA
            , CAST(NMFS AS NVARCHAR(255)) COLLATE #collation# AS NMFS
            , CAST(NDB AS NVARCHAR(255)) COLLATE #collation# AS NDB
            , CAST(species AS NVARCHAR(255)) COLLATE #collation# AS species
            , CAST(affiliatedID AS NVARCHAR(255)) COLLATE #collation# AS affiliatedID
            , CAST(hera AS NVARCHAR(255)) COLLATE #collation# AS hera
            , CAST(sex AS NVARCHAR(255)) COLLATE #collation# AS sex
            , CAST(ageClass AS NVARCHAR(255)) COLLATE #collation# AS ageClass
            , CAST(actualClass AS NVARCHAR(255)) COLLATE #collation# AS actualClass
            , CAST(InitialCondition AS NVARCHAR(255)) COLLATE #collation# AS InitialCondition
            , CAST(FinalCondition AS NVARCHAR(255)) COLLATE #collation# AS FinalCondition
            , CAST(lat AS NVARCHAR(255)) COLLATE #collation# AS lat
            , CAST(lon AS NVARCHAR(255)) COLLATE #collation# AS lon
            , CAST(county AS NVARCHAR(255)) COLLATE #collation# AS county
            , CAST(euthanizedCB AS NVARCHAR(255)) COLLATE #collation# AS euthanizedCB
            , CAST(ResearchTeam AS NVARCHAR(255)) COLLATE #collation# AS ResearchTeam
            , CAST(Veterinarian AS NVARCHAR(255)) COLLATE #collation# AS Veterinarian
            , CAST(BodyOfWater AS NVARCHAR(255)) COLLATE #collation# AS BodyOfWater
            , CAST(StTpye AS NVARCHAR(255)) COLLATE #collation# AS StTpye
            , CAST(NOAAStock AS NVARCHAR(255)) COLLATE #collation# AS NOAAStock
            , CAST(BriefHistory AS NVARCHAR(255)) COLLATE #collation# AS BriefHistory
            , CAST(headerImages AS NVARCHAR(255)) COLLATE #collation# AS headerImages
            ">
            
        </cfif>


        <cftry>
        <cfif isdefined("form.date") and form.date NEQ "">
            <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
            <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
        </cfif>

        
        <cfif StructKeyExists(Form, "BodyOfWater") AND Form.BodyOfWater NEQ "">
            <cfset BodyOfWaterList = Form.BodyOfWater>
        <cfelse>
            <cfset BodyOfWaterList = "">  
        </cfif>
        <cfif StructKeyExists(Form, "cetaceanSpecies") AND Form.cetaceanSpecies NEQ "">
            <cfset cetaceanSpeciesList = Form.cetaceanSpecies>
        <cfelse>
            <cfset cetaceanSpeciesList = "">  
        </cfif>
        <cfif StructKeyExists(Form, "InitialCondition") AND Form.InitialCondition NEQ "">
            <cfset InitialConditionList = Form.InitialCondition>
        <cfelse>
            <cfset InitialConditionList = "">  
        </cfif>
        <cfif StructKeyExists(Form, "finalCondition") AND Form.finalCondition NEQ "">
            <cfset finalConditionList = Form.finalCondition>
        <cfelse>
            <cfset finalConditionList = "">  
        </cfif>
        <cfif StructKeyExists(Form, "county") AND Form.county NEQ "">
            <cfset countyList = Form.county>
        <cfelse>
            <cfset countyList = "">  
        </cfif>
        <cfif StructKeyExists(Form, "BodyCondition") AND Form.BodyCondition NEQ "">
            <cfset BodyConditionList = Form.BodyCondition>
        <cfelse>
            <cfset BodyConditionList = "">  
        </cfif>
        <cfif StructKeyExists(Form, "LesionType") AND Form.LesionType NEQ "">
            <cfset LesionTypeList = Form.LesionType>
        <cfelse>
            <cfset LesionTypeList = "">  
        </cfif>
        <cfif StructKeyExists(Form, "DiagnosticTest") AND Form.DiagnosticTest NEQ "">
            <cfset DiagnosticTestList = Form.DiagnosticTest>
        <cfelse>
            <cfset DiagnosticTestList = "">  
        </cfif>
        <cfif StructKeyExists(Form, "ParasiteType") AND Form.ParasiteType NEQ "">
            <cfset ParasiteTypeList = Form.ParasiteType>
        <cfelse>
            <cfset ParasiteTypeList = "">  
        </cfif>
        
        <cfif StructKeyExists(Form, "SampleType") AND Form.SampleType NEQ "">
            <cfset SampleTypeList = Form.SampleType>
        <cfelse>
            <cfset SampleTypeList = "">  
        </cfif>

       
        <!--- <cfdump var="#BodyOfWaterList#" abort="true"> --->
        <cfquery datasource="#variables.dsn#" name="allCountt" result="r">
            SELECT 'Cetacean Exam' AS SourceTable, ST_LiveCetaceanExam.ID AS cetacenID, Fnumber, Date #blueBoxColumns#
            FROM ST_LiveCetaceanExam
            <!--- Conditionally join ST_Lesion if LesionTypeList is provided --->
            <cfif isdefined("LesionTypeList") AND LesionTypeList NEQ "">
                LEFT JOIN ST_Lesion 
                    ON ST_LiveCetaceanExam.ID = ST_Lesion.LCE_ID
            </cfif>
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("BodyConditionList") and BodyConditionList neq "">
                AND BodyCondition IN (
                    <cfqueryparam value="#BodyConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <!--- Only filter by LesionType if list exists --->
            <cfif isdefined("LesionTypeList") AND LesionTypeList NEQ "">
                AND ST_Lesion.LesionType IN (
                    <cfqueryparam value="#LesionTypeList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
        
            UNION ALL
        
            SELECT 'HI Form' AS SourceTable, ID, Fnumber, Date #blueBoxColumns#
            FROM ST_HIForm
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
          
        
            UNION ALL
        
            SELECT 'Level A Form' AS SourceTable, ID, Fnumber, Date #blueBoxColumns#
            FROM ST_LevelAForm
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
       
        
            UNION ALL
        
            SELECT 'Histo Form' AS SourceTable, ID, Fnumber, Date #blueBoxColumns#
            FROM ST_HistoForm
            <cfif isdefined("SampleTypeList") AND SampleTypeList NEQ "">
                LEFT JOIN ST_HistoSampleData 
                    ON ST_HistoForm.ID = ST_HistoSampleData.HI_ID
            </cfif>
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
      
        
            UNION ALL
        
            SELECT 'Blood Values' AS SourceTable, ID, Fnumber, Date #blueBoxColumns#
            FROM ST_Blood_Values
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
         
        
            UNION ALL
            SELECT 'Toxicology' AS SourceTable, ST_Toxicology.ID AS toxicologyID, Fnumber, Date #blueBoxColumns#
            FROM ST_Toxicology
            <cfif isdefined("DiagnosticTestList") AND DiagnosticTestList NEQ "">
                LEFT JOIN ST_Ancillary_Report 
                    ON ST_Toxicology.ID = ST_Ancillary_Report.AD_ID
            </cfif>
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
             <!--- Only filter by DiagnosticTest if list exists --->
             <cfif isdefined("DiagnosticTest") AND DiagnosticTest NEQ "">
                AND ST_Ancillary_Report.AD_ID IN (
                    <cfqueryparam value="#DiagnosticTest#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
      
        
            UNION ALL
        
            SELECT 'Ancillary Diagnostics' AS SourceTable, ID, Fnumber, Date #blueBoxColumns#
            FROM ST_Ancillary_Diagnostics
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
         
        
            UNION ALL
         
            SELECT 'Sample Archive' AS SourceTable, ID, Fnumber, Date #blueBoxColumns#
            FROM ST_SampleArchive
            <cfif isdefined("SampleTypeList") AND SampleTypeList NEQ "">
                LEFT JOIN ST_SampleType 
                    ON ST_SampleArchive.ID = ST_SampleType.SA_ID
            </cfif>
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
    
        
            UNION ALL
        
            SELECT 'Morphometrics' AS SourceTable, ID, Fnumber, Date #blueBoxColumns#
            FROM ST_Morphometrics
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            
        
            UNION ALL
            SELECT 'Cetacean Necropsy Report' AS SourceTable, ST_CetaceanNecropsyReport.ID AS nID, ST_CetaceanNecropsyReport.Fnumber as Nfnumber, Date #blueBoxColumns#
            FROM ST_CetaceanNecropsyReport
            <!--- Conditionally join ParasiteTypeList if LesionTypeList is provided --->
            <cfif isdefined("ParasiteTypeList") AND ParasiteTypeList NEQ "">
                LEFT JOIN ST_DynamicParasites 
                ON ST_CetaceanNecropsyReport.fnumber = ST_DynamicParasites.fnumber
            </cfif>

            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND CONVERT(char(10), Date, 126) BETWEEN 
                    <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                    AND 
                    <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND BodyOfWater IN (
                    <cfqueryparam value="#BodyOfWaterList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("cetaceanSpeciesList") and cetaceanSpeciesList neq "">
                AND species IN (
                    <cfqueryparam value="#cetaceanSpeciesList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("InitialConditionList") and InitialConditionList neq "">
                AND InitialCondition IN (
                    <cfqueryparam value="#InitialConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("finalConditionList") and finalConditionList neq "">
                AND FinalCondition IN (
                    <cfqueryparam value="#finalConditionList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
            <cfif isdefined("countyList") and countyList neq "">
                AND county IN (
                    <cfqueryparam value="#countyList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
             <!--- Only filter by LesionType if list exists --->
             <cfif isdefined("ParasiteTypeList") AND ParasiteTypeList NEQ "">
                AND ST_DynamicParasites.fnumber IN (
                    <cfqueryparam value="#ParasiteTypeList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                )
            </cfif>
               
            ORDER BY Date DESC
        </cfquery>
        
        <!--- today working --->
        <!--- <cfdump var="#allCountt#" abort="true"> --->














        
 

    <!--- Data set after filtering --->
    
    <cfcatch>
        <cfdump var="#cfcatch#" abort="true">
    </cfcatch>
</cftry>
    </cfif>
    <cfset getAreaName =  Application.Sighting.getAreaName()>
    <cfset getSurveyArea = Application.Sighting.getSurveyArea()>
    <cfset getSurveyType = Application.Sighting.getType()>
    <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>
    <cfset getSurveyRouteData = Application.StaticDataNew.getSurveyRoute()>
    <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>

    <cfset qGetAssocBioData=Application.SightingNew.qGetAssocBioData()>
    <cfset getBehaviorsData = Application.StaticDataNew.getBehavior()>

    <cfset getPreySpeciesData = Application.StaticDataNew.getPreySpecies()>
    <cfset StructureList = Application.SightingNew.getStructureList()>

    <cfset qCetaceanResponseToFisher=Application.SightingNew.qCetaceanResponseToFisher()>
    <cfset qFisherResponseToCetacean=Application.SightingNew.qFisherResponseToCetacean()>
    <cfset qCetaceanResponseToVessel=Application.SightingNew.qCetaceanResponseToVessel()>
    <cfset qVesselResponseToCetacean=Application.SightingNew.qVesselResponseToCetacean()>

    <cfset getPlateForm=Application.StaticDataNew.getPlateForm()>
    <cfset getStock = Application.StaticDataNew.getStock()>

    <!---  Head Condition   --->
    <cfset getHeadNuchalCrest = Application.ConditionLesions.getHeadNuchalCrest()>
    <cfset getHeadLateralCervicalReg = Application.ConditionLesions.getHeadLateralCervicalReg()>
    <cfset getHeadFacialBones = Application.ConditionLesions.getHeadFacialBones()>
    <cfset getHeadEarOS = Application.ConditionLesions.getHeadEarOS()>
    <cfset getHeadChinSkinFolds = Application.ConditionLesions.getHeadChinSkinFolds()>
    <!---  Body Condition   --->
    <cfset getBodyEpaxialMuscle = Application.ConditionLesions.getBodyEpaxialMuscle()>
    <cfset getBodyDorsalRidgeScapula = Application.ConditionLesions.getBodyDorsalRidgeScapula()>
    <cfset getBodyRibs = Application.ConditionLesions.getBodyRibs()>
    <!---  Tail Condition   --->
    <cfset getTailTransversePro = Application.ConditionLesions.getTailTransversePro()>

    <cfset qgetLesionScarType = Application.StaticDataNew.getLesionScarType()>

        <cfset lesionTypeData = []>
        <cfset scarTypeData = []>

        <cfloop query="qgetLesionScarType">
            <cfif Type EQ "Lesion">
                <cfset ArrayAppend(lesionTypeData, {
                    ID = qgetLesionScarType.ID,
                    Name = qgetLesionScarType.Name,
                    Active = qgetLesionScarType.Active,
                    Type = qgetLesionScarType.Type
                })>
            <cfelseif Type EQ "Scar">
                <cfset ArrayAppend(scarTypeData, {
                    ID = qgetLesionScarType.ID,
                    Name = qgetLesionScarType.Name,
                    Active = qgetLesionScarType.Active,
                    Type = qgetLesionScarType.Type
                })>
            </cfif>
        </cfloop>

    <cfquery name="cetaceans" datasource="#variables.dsn#">
        select ID,Code,Name from Cetaceans order by Code ASC
    </cfquery>
    <cfquery name="RTmembers" datasource="#variables.dsn#">
        SELECT * from TLU_ResearchTeamMembers
    </cfquery>
    <cfquery name="users" datasource="#variables.dsn#">
        SELECT * from users
    </cfquery>

    <!---start today working --->
    <cfset qgetTissueType=Application.StaticDataNew.getTissueType()>      
    <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>  
    <cfset qgetDiagnosticTest=Application.StaticDataNew.getDiagnosticTest()>
    <!--- <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()> --->
    <cfset qgetParasiteType= Application.StaticDataNew.getParasiteType()>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Moderately Decomposed' ,'Advanced Composition','Mummified']>
    <cfset ConditionsValue = ['1', '2', '3' ,'4','5']>
    <cfset qgetSampleType=Application.StaticDataNew.getSampleType()>
    <cfset qgetIR_CountyLocation=Application.StaticDataNew.getIR_CountyLocation()>
    <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>
    <cfset bodyConditions = ['Emaciated','Underweight/Thin','Ideal','Overweight','Obese']>
    <!---end today working --->

    <div id="content" class="content">
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">Stranding Necropsy Data Report</a></li>
        </ol>
        <h1 class="page-header">Stranding Necropsy Data Report</h1>
        <div class="section-container section-with-top-border p-b-10">
            <div class="row">
                <div class="col-md-12">
                    <cfoutput>
                        <form action="" name="searchAllReports" id="searchAllReports" method="post">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Date Range</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <div id="Date-range" class="input-group">
                                            <input type="text"  class="form-control" name="date" id="date" placeholder="Select Date Range">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-primary"onclick="showdate()"><i class="fa fa-calendar"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!--- Workig here --->

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Body of Water</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="combobox form-control search-box" multiple="multiple" name="BodyOfWater" id="BodyOfWater">
                                            <cfloop query="getSurveyAreaData">
                                                <!--- <cfif active eq 1> --->
                                                    <option value="#getSurveyAreaData.ID#">#getSurveyAreaData.AreaName#</option>
                                                <!--- </cfif> --->
                                            </cfloop>                                                               
                                    
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Toxicology Tissue Type</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="combobox form-control search-box" multiple="multiple" name="Tissue_type" id="Tissue_type">
                                            <cfloop query="qgetTissueType">
                                                    <option value="#qgetTissueType.ID#">#qgetTissueType.Type#</option>
                                            </cfloop> 
                                        </select>
                                    </div>
                                </div>   
                           
                            </div>


                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Species</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">                                        <select class="combobox form-control search-box" multiple="multiple" name="cetaceanSpecies" id="cetaceanSpecies">
                                        <cfloop query="qgetCetaceanSpecies">
                                            <option value="#qgetCetaceanSpecies.id#">#qgetCetaceanSpecies.CetaceanSpeciesName#</option>
                                        </cfloop> 
                                    </select>
                                        
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Diagnostic Test</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control search-box" multiple="multiple" id="DiagnosticTest" name="DiagnosticTest">
                                            <option value="">Select Diagnostic Test</option>
                                            <cfloop query="qgetDiagnosticTest">
                                                <option value="#qgetDiagnosticTest.Diagnostic#">#qgetDiagnosticTest.Diagnostic#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>

                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label"> Initial Condition</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control search-box"  multiple="multiple" name="InitialCondition" id="InitialCondition" onChange="headerDataSave()">
                                                <option value="">Select Initial Condition</option>
                                                <cfloop array="#Conditions#" index="j" item="item">
                                                    <cfset optionValue = ConditionsValue[j] & '-' & item>
                                                    <option value="#item#">
                                                        #optionValue#
                                                    </option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
    
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Parasite Type</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control search-box" multiple="multiple" name="ParasiteType" id="ParasiteType" >
                                                <cfloop query="qgetParasiteType">
                                                    <option value="">Select IParasite Type</option>
                                                    <cfif status eq 1>
                                                        <option value="#qgetParasiteType.type#">#qgetParasiteType.type#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label"> Final Condition</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control search-box"  multiple="multiple" name="finalCondition" id="finalCondition" onChange="headerDataSave()">
                                                <option value="">Select Final Condition</option>
                                                <cfloop array="#Conditions#" index="j" item="item">
                                                    <cfset optionValue = ConditionsValue[j] & '-' & item>
                                                    <option value="#item#">
                                                        #optionValue#
                                                    </option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
    
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Sample Type (Sample Archive)</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control search-box" multiple name="" id="SampleType" name="SampleType">
                                                <option value="">Select Sample</option>
                                                <cfloop query="qgetSampleType">
                                                    <cfif status  neq 0>
                                                        <option value="#qgetSampleType.Type#">#qgetSampleType.Type#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">County</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control search-box"  multiple="multiple" name="county" id="county" >
                                                <option value="">Select County</option>
                                                <cfloop query="qgetIR_CountyLocation">
                                                    <cfif active  neq 0>
                                                        <option value="#qgetIR_CountyLocation.IR_CountyLocation#">#qgetIR_CountyLocation.IR_CountyLocation#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
    
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Sample Type (Histopathology)</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control search-box" multiple name="hisSampleType" id="hisSampleType">
                                                <option value="">Select Sample</option>
                                                <cfloop query="qgetSampleType">
                                                    <cfif status  neq 0>
                                                        <option value="#qgetSampleType.Type#">#qgetSampleType.Type#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Body Conditions</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control customLesionSelect search-box" multiple id="BodyCondition" name="BodyCondition">
                                                <option value="">Select Body Condition</option>
                                                <cfloop from="1" to="#ArrayLen(bodyConditions)#" index="j">
                                                    <option value="#j#">#j&' - '&bodyConditions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>                                    

                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Date Range</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <div id="Date-range" class="input-group">
                                                <input type="text"  class="form-control" name="bloodValueDate" id="bloodValueDate" placeholder="Select Date Range">
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-primary"onclick="showdatee()"><i class="fa fa-calendar"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Lesion Type</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control customLesionSelect search-box" multiple id="LesionType" name="LesionType" >
                                                <option value="">Select Lesion Type</option>
                                                <cfloop query="getLesionTypeData">
                                                    <cfif Active eq 1>
                                                    <option value="#getLesionTypeData.LesionTypeName#">#getLesionTypeData.LesionTypeName#</option>
                                                        </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>

                                    <!--- <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Date Range</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <div id="Date-range" class="input-group">
                                                <input type="text"  class="form-control" name="bloodValueDate" id="bloodValueDate" placeholder="Select Date Range">
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-primary"onclick="showdatee()"><i class="fa fa-calendar"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div> --->
                                </div>

                                <div class="form-row">

                                </div>

                            <!--- <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Body of Water</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="bodyOfWater">
                                            <option value="">Select Body of Water</option>
                                            <cfloop query="#getSurveyArea#">
                                                <option value="#ID#" >#AreaName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div> --->
                            <hr>

                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Blue Box</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="blueBox" id="blueBox" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetacean Exam - HRato/ Resp Box</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="hRatoRespBox" id="hRatoRespBox" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetacean Exam -Drig Admin Box</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="DrigAdminBox" id="DrigAdminBox" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetaceon Exam- Bopsy Typе</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="bopsyTypе" id="bopsyTypе" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetacean Exam- Physicae Exam Notes</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="physicaeExamNotes" id="physicaeExamNotes" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetacean Sxam- Entangled & Relbate</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="entangledRelbate" id="entangledRelbate" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">HI Form</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="hIForm" id="hIForm" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Htistology Remarkes (Histopatnology)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="htistologyRemarkes" id="htistologyRemarkes" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Level A Form</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="levelAForm" id="levelAForm" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Morphometrics</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="morphometrics" id="morphometrics" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Neeropsy (top section)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neeropsyTopSection" id="neeropsyTopSection" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Hishopathology Section)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="hishopathologySection" id="hishopathologySection" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Neeropsy (External Exam Section)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="externalExamSection" id="externalExamSection" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necnpsy (Integument)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necnpsyIntegument" id="necnpsyIntegument" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Nerropsy (Nutntional Conditon-Externas)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="nutntionalConditonExternas" id="nutntionalConditonExternas" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Musculoskeletal)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necropsyMusculoskeletal" id="necropsyMusculoskeletal" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necmopsy (Thoracic Cavity)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necmopsyThoracicCavity" id="necmopsyThoracicCavity" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Neenpsy (Abdaminal Cavity)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neenpsyAbdaminalCavity" id="neenpsyAbdaminalCavity" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Hepatobiliany)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necropsyHepatobiliany" id="necropsyHepatobiliany" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Cordiovasculor)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necropsyCordiovasculor" id="necropsyCordiovasculor" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label"> Necnopsy (Pulmonary)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necnopsyPulmonary" id="necnopsyPulmonary" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Neenpsy (lymphoreticulor)*</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neenpsylymphoreticulor" id="neenpsylymphoreticulor" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Endocnine)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necropsyEndocnine" id="necropsyEndocnine" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label"> Neeropsy (Urog nital)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neeropsyUrognital" id="neeropsyUrognital" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Neempsy (Aumentany)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neempsyAumentany" id="neempsyAumentany" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Neempsy (G1 Furcign Matina)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neempsyG1FurcignMatina" id="neempsyG1FurcignMatina" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Neonpsy (Centrae Nenvus
                                        Sysem)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neonpsyCentraeNenvusSysem" id="neonpsyCentraeNenvusSysem" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            

                            <div class="form-row all_btn_form">
                                <div class="col-lg-10 col-md-10 col-sm-9 text-right">
                                    <button type="submit" name="btnSearchSightings" value ="submit"  class="btn btn-success width-100 m-r-5  ml-auto" id="add">Run</button>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-3 text-left">
                                    <button type="reset" name="reset" value ="reset" onclick='clearAll()' class="btn btn-success width-100 m-r-5  ml-auto" >Clear</button>
                                </div>
                            </div>
                        </form>
                    </cfoutput>
                </div>
            </div>
        </div>
        <hr>
        <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')>
            <!--- <cfdump var="test123" abort="true"> --->
        
        
        <!--- <cfif #qFiltered.CetaceanSpeciesName# neq '' > --->

            <div class="section-container section-with-top-border"> 
                <div class="">
                    <cfif allCountt.recordCount neq 0>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-right" style="position: absolute;
                            right: 12px; width: 10%; z-index: 2;">
                                <button type="button" name="excelExport" value ="Download as Excel" onclick="excel()" class="btn btn-success width-123 m-r-5  ml-auto">Export All</button>
                            </div>
                        </div>
                    </cfif> 

                    <table id="allReport" class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                                <th>Fnumber</th> 
                                <th>Date</th> 
                                <cfif structKeyExists(form, "BLUEBOX") AND form.BLUEBOX eq "1">

                                </cfif>
                            </tr>
                        </thead>
                        <tbody>
                            <cfoutput query="allCountt">
                                <tr>                            
                                    <td>#Fnumber#</td> 
                                    <td>#Date#</td> 
                                    <cfif structKeyExists(form, "BLUEBOX") AND form.BLUEBOX eq "1">
                                    
                                    </cfif>
                                </tr>
                            </cfoutput>
                        </tbody>
                    </table>
                    
                   
                </div>
      
            </div>


            <!--- <cfelse>
                <div class="alert alert-danger">
                    <strong>Alert!</strong> No record found.
                </div>
            </cfif> --->

        </cfif>
        <div class="footer" id="footer">
            <span class="pull-right">
                <a data-click="scroll-top" class="btn-scroll-to-top" href="javascript:;">
                    <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
                </a>
            </span>
            &copy;
            <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
        </div>
    </div>
<cfelse>
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">All Forms Report</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>

<style>
    .all_btn_form {
        flex-wrap: nowrap !important;
    }
</style>