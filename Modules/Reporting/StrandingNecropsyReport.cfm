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

        <cfif structKeyExists(form, "BLUEBOX") AND form.BLUEBOX eq "1">
            <cfset collation = "SQL_Latin1_General_CP1_CI_AS">
        
            <!--- Define the blue box column list as a comma-separated list --->
            <cfset blueBoxColumnList = "Location,NAA,NMFS,NDB,species,affiliatedID,hera,sex,ageClass,actualClass,InitialCondition,FinalCondition,lat,lon,county,euthanizedCB,ResearchTeam,Veterinarian,BodyOfWater,StTpye,NOAAStock,BriefHistory,headerImages">
        
            <!--- Build the SQL SELECT part dynamically --->
            <cfset blueBoxColumns = "">
            <cfloop list="#blueBoxColumnList#" index="col">
                <cfset blueBoxColumns &= ", CAST(" & col & " AS NVARCHAR(255)) COLLATE " & collation & " AS " & col>
            </cfloop>
        </cfif>
 
        
        <cfset heartRespColumnList_CE = "">
        <cfset heartRespColumnList_Other = "">
        
        <cfif structKeyExists(form, "hRatoRespBox") AND form.hRatoRespBox eq "1">
            <!--- For Cetacean Exam: cast all four columns --->
            <cfset heartRespColumnList_CE = "
                , CAST(ST_HeartRate.heartRate AS NVARCHAR(255)) AS heartRate
                , CAST(ST_HeartRate.heartRateTime AS NVARCHAR(255)) AS heartRateTime
                , CAST(ST_RespRate.respRate AS NVARCHAR(255)) AS respRate
                , CAST(ST_RespRate.respRateTime AS NVARCHAR(255)) AS respRateTime
            ">
            
            <!--- For other tables in UNION ALL: use NULL placeholders --->
            <cfset heartRespColumnList_Other = "
                , NULL AS heartRate
                , NULL AS heartRateTime
                , NULL AS respRate
                , NULL AS respRateTime
            ">
        </cfif>

        <!--- Initialize variables --->
        <cfset drugColumnList_CE = "">
        <cfset drugColumnList_Other = "">

        <cfif structKeyExists(form, "DrigAdminBox") AND form.DrigAdminBox eq "1">
            <cfset drugColumnList_CE = "
                , CAST(DrugType AS NVARCHAR(255)) AS DrugType
                , CAST(DrugMethod AS NVARCHAR(255)) AS DrugMethod
                , CAST(DrugTime AS NVARCHAR(255)) AS DrugTime
                , CAST(DrugDosage AS NVARCHAR(255)) AS DrugDosage
                , CAST(DrugVolume AS NVARCHAR(255)) AS DrugVolume
            ">

            <cfset drugColumnList_Other = "
                , NULL AS DrugType
                , NULL AS DrugMethod
                , NULL AS DrugTime
                , NULL AS DrugDosage
                , NULL AS DrugVolume
            ">
        </cfif>

        <cfset biopsyColumnList_CE = "">
        <cfset biopsyColumnList_Other = "">
        
        <cfif structKeyExists(form, "bopsyTyp") AND form.bopsyTyp eq "1">
            <cfset biopsyColumnList_CE = "
                , CAST(BiopsyType AS NVARCHAR(255)) AS BiopsyType
                , CAST(BiopsyLocation AS NVARCHAR(255)) AS BiopsyLocation
                , CAST(BiopsySize AS NVARCHAR(255)) AS BiopsySize
            ">
        
            <cfset biopsyColumnList_Other = "
                , NULL AS BiopsyType
                , NULL AS BiopsyLocation
                , NULL AS BiopsySize
            ">
        </cfif>

        <cfset PhysicalColumnList_CE = "">
        <cfset PhysicalColumnList_Other = "">
        
        <cfif structKeyExists(form, "PhysicalBox") AND form.PhysicalBox eq "1">
            
            <cfset PhysicalColumnList_CE = "
                , CAST(General AS NVARCHAR(1024)) AS General
                , CAST(SNM AS NVARCHAR(1024)) AS SNM
                , CAST(Mentation AS NVARCHAR(512)) AS Mentation
                , CAST(Palpation AS NVARCHAR(512)) AS Palpation
                , CAST(Proprioception AS NVARCHAR(512)) AS Proprioception
                , CAST(Reflexes AS NVARCHAR(512)) AS Reflexes
            ">
        
            <cfset PhysicalColumnList_Other = "
                , NULL AS General
                , NULL AS SNM
                , NULL AS Mentation
                , NULL AS Palpation
                , NULL AS Proprioception
                , NULL AS Reflexes
            ">
        </cfif>

        <cfset entangledRelbateColumnList_CE = "">
        <cfset entangledRelbateColumnList_Other = "">
        
        <cfif structKeyExists(form, "entangledRelbate") AND form.entangledRelbate eq "1">
            
            <cfset entangledRelbateColumnList_CE = "
                , CAST(Entangled AS NVARCHAR(1024)) AS Entangled
                , CAST(Released AS NVARCHAR(1024)) AS Released
            ">
            
            <cfset entangledRelbateColumnList_Other = "
                , NULL AS Entangled
                , NULL AS Released
            ">
        </cfif>
        
        <!--- For HiForm --->
        <cfset hIFormColumnList_CE = "">
        <cfset hIFormColumnList_Other = "">
        
        <cfif structKeyExists(form, "hIForm") AND form.hIForm eq "1">
            <cfset hIFormColumnList_CE = "
                , CAST(ST_DynamicHI.TYPEOFHI AS NVARCHAR(1024)) AS TYPEOFHI
                , CAST(ST_DynamicHI.LocationofHI AS NVARCHAR(1024)) AS LocationofHI
                , CAST(ST_DynamicHI.GearCollected AS NVARCHAR(1024)) AS GearCollected
                , CAST(ST_DynamicHI.TypeofGearCollected AS NVARCHAR(1024)) AS TypeofGearCollected
                , CAST(ST_DynamicHI.GearDeposition AS NVARCHAR(1024)) AS GearDeposition
            ">
        
            <cfset hIFormColumnList_Other = "
                , NULL AS TYPEOFHI
                , NULL AS LocationofHI
                , NULL AS GearCollected
                , NULL AS TypeofGearCollected
                , NULL AS GearDeposition
            ">
        </cfif>

        <cfset histoRemarksColumnList_CE = "">
        <cfset histoRemarksColumnList_Other = "">

        <cfif structKeyExists(form, "htistologyRemarkes") AND form.htistologyRemarkes eq "1">
            <cfset histoRemarksColumnList_CE = ", CAST(ST_HistoForm.SampleComments AS NVARCHAR(1024)) AS SampleComments">
            <cfset histoRemarksColumnList_Other = ", NULL AS SampleComments">
        </cfif>

        <cfset levelAFormColumnList_CE = "">
        <cfset levelAFormColumnList_Other = "">

        <cfif structKeyExists(form, "levelAForm") AND form.levelAForm eq "1">
            <cfset levelAFormColumnList_CE = "
                , CAST(ID AS NVARCHAR(255)) AS LevelA_ID
                , CAST(ILAD AS NVARCHAR(255)) AS ILAD
                , CAST(ILADComment AS NVARCHAR(1024)) AS ILADComment
                , CAST(CarcassStatus AS NVARCHAR(255)) AS CarcassStatus
                , CAST(CarcassStatusLat AS NVARCHAR(255)) AS CarcassStatusLat
                , CAST(CarcassStatusLon AS NVARCHAR(255)) AS CarcassStatusLon
                , CAST(GroupEvent AS BIT) AS GroupEvent
                , CAST(GroupEventType AS NVARCHAR(255)) AS GroupEventType
                , CAST(noOfAnimals AS NVARCHAR(255)) AS noOfAnimals
                , CAST(TagsWere AS NVARCHAR(255)) AS TagsWere
                , CAST(Restrand AS BIT) AS Restrand
            ">

            <cfset levelAFormColumnList_Other = "
                , NULL AS LevelA_ID
                , NULL AS ILAD
                , NULL AS ILADComment
                , NULL AS CarcassStatus
                , NULL AS CarcassStatusLat
                , NULL AS CarcassStatusLon
                , NULL AS GroupEvent
                , NULL AS GroupEventType
                , NULL AS noOfAnimals
                , NULL AS TagsWere
                , NULL AS Restrand
            ">
        </cfif>

        <cfset morphometricsColumnList_CE = "">
        <cfset morphometricsColumnList_Other = "">

        <cfif structKeyExists(form, "morphometrics") AND form.morphometrics eq "1">

            <cfset morphometricsColumnList_CE = "
                , CAST(EstimatedWeight AS NVARCHAR(255)) AS EstimatedWeight
                , CAST(EstimatedWeightUnit AS NVARCHAR(50)) AS EstimatedWeightUnit
                , CAST(weight_values AS NVARCHAR(50)) AS weight_values
                , CAST(totalLength AS NVARCHAR(255)) AS totalLength
                , CAST(lengthWeight_values AS NVARCHAR(50)) AS lengthWeight_values
                , CAST(rostrum AS NVARCHAR(255)) AS rostrum
                , CAST(blowhole AS NVARCHAR(255)) AS blowhole
                , CAST(fluke AS NVARCHAR(255)) AS fluke
                , CAST(girth AS NVARCHAR(255)) AS girth
                , CAST(axillary AS NVARCHAR(255)) AS axillary
                , CAST(maxium AS NVARCHAR(255)) AS maxium
                , CAST(DorsalFinHeight AS NVARCHAR(255)) AS DorsalFinHeight
                , CAST(RostrumtoBlowhole AS NVARCHAR(255)) AS RostrumtoBlowhole
                , CAST(blubber AS NVARCHAR(255)) AS blubber
                , CAST(midlateral AS NVARCHAR(255)) AS midlateral
                , CAST(Lateralupperleft AS NVARCHAR(255)) AS Lateralupperleft
                , CAST(Laterallowerleft AS NVARCHAR(255)) AS Laterallowerleft
                , CAST(midVentral AS NVARCHAR(255)) AS midVentral
                , CAST(Ventralupperleft AS NVARCHAR(255)) AS Ventralupperleft
                , CAST(Ventrallowerright AS NVARCHAR(255)) AS Ventrallowerright
            ">

            <cfset morphometricsColumnList_Other = "
                , NULL AS EstimatedWeight
                , NULL AS EstimatedWeightUnit
                , NULL AS weight_values
                , NULL AS totalLength
                , NULL AS lengthWeight_values
                , NULL AS rostrum
                , NULL AS blowhole
                , NULL AS fluke
                , NULL AS girth
                , NULL AS axillary
                , NULL AS maxium
                , NULL AS DorsalFinHeight
                , NULL AS RostrumtoBlowhole
                , NULL AS blubber
                , NULL AS midlateral
                , NULL AS Lateralupperleft
                , NULL AS Laterallowerleft
                , NULL AS midVentral
                , NULL AS Ventralupperleft
                , NULL AS Ventrallowerright
            ">
        </cfif>

        <cfset necropsyColumnList_CE = "">
        <cfset necropsyColumnList_Other = "">
        <cfif structKeyExists(form, "neeropsyTopSection") AND form.neeropsyTopSection eq "1">

            <cfset necropsyColumnList_CE = "
                , CAST(attendingVeterinarian AS NVARCHAR(1024)) AS attendingVeterinarian
                , CAST(Prosectors AS NVARCHAR(1024)) AS Prosectors
                , CAST(Tentative AS NVARCHAR(1024)) AS Tentative
                , CAST(deathcause AS NVARCHAR(1024)) AS deathcause
             
            ">
        
            <cfset necropsyColumnList_Other = "
                , NULL AS attendingVeterinarian
                , NULL AS Prosectors
                , NULL AS Tentative
                , NULL AS deathcause
               
            ">
        
        </cfif>
        
        <cfset histopathologySectionColumnList = "">
        <cfset histopathologySectionColumnList_Other = "">
        <cfif structKeyExists(form, "histopathologySection") AND form.histopathologySection eq "1">

            <cfset histopathologySectionColumnList = "
                , CAST(HistopathologyReport AS NVARCHAR(1024)) AS HistopathologyReport
                , CAST(NRDiagnosisCategory AS NVARCHAR(1024)) AS NRDiagnosisCategory
                , CAST(historemark AS NVARCHAR(1024)) AS historemark
                , CAST(NRHistopathologyDiagnosis AS NVARCHAR(1024)) AS NRHistopathologyDiagnosis
            ">
        
            <cfset histopathologySectionColumnList_Other = "
                , NULL AS HistopathologyReport
                , NULL AS NRDiagnosisCategory
                , NULL AS historemark
                , NULL AS NRHistopathologyDiagnosis
            ">
        
        </cfif>

        <cfset externalExamSectionColumnList = "">
        <cfset externalExamSectionColumnList_Other = "">

        <cfif structKeyExists(form, "externalExamSection") AND form.externalExamSection eq "1">

            <cfset externalExamSectionColumnList = "
                , CAST(Necropsycondition AS NVARCHAR(1024)) AS Necropsycondition
                , CAST(Euthanized AS NVARCHAR(1024)) AS Euthanized
                , CAST(Bodycondition AS NVARCHAR(1024)) AS Bodycondition
                , CAST(LevelADate AS NVARCHAR(1024)) AS LevelADate
                , CAST(AnimalRenderings AS NVARCHAR(1024)) AS AnimalRenderings
                , CAST(NxLocation AS NVARCHAR(1024)) AS NxLocation
            ">
        
            <cfset externalExamSectionColumnList_Other = "
                , NULL AS Necropsycondition
                , NULL AS Euthanized
                , NULL AS Bodycondition
                , NULL AS LevelADate
                , NULL AS AnimalRenderings
                , NULL AS NxLocation
            ">
        
        </cfif>

        <cfset necnpsyIntegumentColumnList = "">
        <cfset necnpsyIntegumentColumnList_Other = "">

        <cfif structKeyExists(form, "necnpsyIntegument") AND form.necnpsyIntegument eq "1">

            <cfset necnpsyIntegumentColumnList = "
                , CAST(Lesionform AS NVARCHAR(1024)) AS Lesionform
                , CAST(HIForm AS NVARCHAR(1024)) AS HIForm
                , CAST(cutterwounds AS NVARCHAR(1024)) AS cutterwounds
                , CAST(cutterscars AS NVARCHAR(1024)) AS cutterscars
                , CAST(eyeleft AS NVARCHAR(1024)) AS eyeleft
                , CAST(eyeright AS NVARCHAR(1024)) AS eyeright
                , CAST(lessioncomments AS NVARCHAR(1024)) AS lessioncomments
            ">
        
            <cfset necnpsyIntegumentColumnList_Other = "
                , NULL AS Lesionform
                , NULL AS HIForm
                , NULL AS cutterwounds
                , NULL AS cutterscars
                , NULL AS eyeleft
                , NULL AS eyeright
                , NULL AS lessioncomments
            ">
        
        </cfif>

        <cfset necropsyMusculoskeletalColumnList = "">
        <cfset necropsyMusculoskeletalColumnList_Other = "">

        <cfif structKeyExists(form, "necropsyMusculoskeletal") AND form.necropsyMusculoskeletal eq "1">

            <cfset necropsyMusculoskeletalColumnList = "
                , CAST(MUSCULOSKELETAL AS NVARCHAR(1024)) AS MUSCULOSKELETAL
                , CAST(Joint_Fluid AS NVARCHAR(1024)) AS Joint_Fluid
                , CAST(Skeletal_Findings AS NVARCHAR(1024)) AS Skeletal_Findings
                , CAST(Muscle_Status AS NVARCHAR(1024)) AS Muscle_Status
                , CAST(Musculature_Findings AS NVARCHAR(1024)) AS Musculature_Findings
                , CAST(muscular_comments AS NVARCHAR(1024)) AS muscular_comments
                
            ">
        
            <cfset necropsyMusculoskeletalColumnList_Other = "
                , NULL AS MUSCULOSKELETAL
                , NULL AS Joint_Fluid
                , NULL AS Skeletal_Findings
                , NULL AS Muscle_Status
                , NULL AS Musculature_Findings
                , NULL AS muscular_comments
                
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
            SELECT 'Cetacean Exam' AS SourceTable, ST_LiveCetaceanExam.ID AS cetacenID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_CE# #drugColumnList_CE# #biopsyColumnList_CE# #PhysicalColumnList_CE# #entangledRelbateColumnList_CE# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
            FROM ST_LiveCetaceanExam
            <!--- Conditionally join ST_Lesion if LesionTypeList is provided --->
            <cfif isdefined("LesionTypeList") AND LesionTypeList NEQ "">
                LEFT JOIN ST_Lesion 
                    ON ST_LiveCetaceanExam.ID = ST_Lesion.LCE_ID
            </cfif>
            <cfif structKeyExists(form, "hRatoRespBox") AND form.hRatoRespBox eq "1">
                LEFT JOIN ST_HeartRate 
                    ON ST_LiveCetaceanExam.ID = ST_HeartRate.LCE_ID
                LEFT JOIN ST_RespRate 
                    ON ST_LiveCetaceanExam.ID = ST_RespRate.LCE_ID
            </cfif>
            <cfif isdefined("DrigAdminBox") AND DrigAdminBox NEQ "">
                LEFT JOIN ST_DrugsAdministered 
                    ON ST_LiveCetaceanExam.ID = ST_DrugsAdministered.LCE_ID
            </cfif>
            <cfif isdefined("bopsyTyp") AND bopsyTyp NEQ "">
                LEFT JOIN ST_Biopsy 
                    ON ST_LiveCetaceanExam.ID = ST_Biopsy.LCE_ID
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
        
            SELECT 'HI Form' AS SourceTable, ST_HIForm.ID AS HI_ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_CE# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
            FROM ST_HIForm
            <cfif structKeyExists(form, "hIForm") AND form.hIForm eq "1">
                LEFT JOIN ST_DynamicHI 
                    ON ST_HIForm.ID = ST_DynamicHI.HI_ID
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
        
            SELECT 'Level A Form' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_CE# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
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
        
            SELECT 'Histo Form' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_CE# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
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
        
            SELECT 'Blood Values' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
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
            SELECT 'Toxicology' AS SourceTable, ST_Toxicology.ID AS toxicologyID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
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
        
            SELECT 'Ancillary Diagnostics' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
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
         
            SELECT 'Sample Archive' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
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
        
            SELECT 'Morphometrics' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_CE# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other#
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
            SELECT 'Cetacean Necropsy Report' AS SourceTable, ST_CetaceanNecropsyReport.ID AS nID, ST_CetaceanNecropsyReport.Fnumber as Nfnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_CE# #histopathologySectionColumnList# #externalExamSectionColumnList# #necnpsyIntegumentColumnList# #necropsyMusculoskeletalColumnList#
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
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">                                        
                                        <select class="combobox form-control search-box" multiple="multiple" name="cetaceanSpecies" id="cetaceanSpecies">
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
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetaceon Exam- Bopsy Type </label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="bopsyTyp" id="bopsyTyp" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetacean Exam- Physical Exam Notes</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="PhysicalExamNotes" id="PhysicalExamNotes" value="1" style="width: 25px; height: 25px;" >
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
                                            <input type="checkbox" class="checkbox-inline " name="histopathologySection" id="histopathologySection" value="1" style="width: 25px; height: 25px;">
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

                    <table id="allReport" class="table table-bordered table-hover" style="margin-left: initial;">
                        <thead>
                            <tr class="inverse">
                                <th>Fnumber</th> 
                                <th>Date</th> 
                                <th>Tab Name</th> 
                                <cfif structKeyExists(form, "BLUEBOX") AND form.BLUEBOX eq "1">
                                    <cfloop list="#blueBoxColumnList#" index="col">
                                        <cfoutput><th>#ucase(left(col,1))##lcase(mid(col,2,len(col)))#</th></cfoutput>
                                    </cfloop>
                                </cfif>
                                <!--- Heart/Resp Columns --->
                                <cfif structKeyExists(form, "hRatoRespBox") AND form.hRatoRespBox eq "1">
                                    <th>Heart Rate</th>
                                    <th>Heart Rate Time</th>
                                    <th>Resp Rate</th>
                                    <th>Resp Rate Time</th>
                                </cfif>
                                <cfif structKeyExists(form, "DrigAdminBox") AND form.DrigAdminBox eq "1">
                                    <th>Drug Type</th>
                                    <th>Drug Method</th>
                                    <th>Drug Time</th>
                                    <th>Drug Dosage</th>
                                    <th>Drug Volume</th>
                                </cfif>
                                <cfif structKeyExists(form, "bopsyTyp") AND form.bopsyTyp eq "1">
                                    <th>Biopsy Type</th>
                                    <th>Biopsy Location</th>
                                    <th>Biopsy Size</th>
                                </cfif>
                                <cfif structKeyExists(form, "entangledRelbate") AND form.entangledRelbate eq "1">
                                    <th>Entangled</th>
                                    <th>Released</th>
                                </cfif>
                                <cfif structKeyExists(form, "hIForm") AND form.hIForm eq "1">
                                    <th>Type of H.I.</th>
                                    <th>Location of H.I.</th>
                                    <th>Gear Collected</th>
                                    <th>Type of Gear Collected</th>
                                    <th>Gear Deposition</th>
                                </cfif>
                                <cfif structKeyExists(form, "htistologyRemarkes") AND form.htistologyRemarkes eq "1">
                                    <th>Sample Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "levelAForm") AND form.levelAForm eq "1">
                                    <th>Level A ID</th>
                                    <th>ILAD</th>
                                    <th>ILAD Comment</th>
                                    <th>Carcass Status</th>
                                    <th>Carcass Lat</th>
                                    <th>Carcass Lon</th>
                                    <th>Group Event</th>
                                    <th>Group Event Type</th>
                                    <th>No. of Animals</th>
                                    <th>Tags Were</th>
                                    <th>Restrand</th>
                                </cfif>
                                <cfif structKeyExists(form, "morphometrics") AND form.morphometrics eq "1">
                                    <cfset morphoColumns = "EstimatedWeight,EstimatedWeightUnit,weight_values,totalLength,lengthWeight_values,rostrum,blowhole,fluke,girth,axillary,maxium,DorsalFinHeight,RostrumtoBlowhole,blubber,midlateral,Lateralupperleft,Laterallowerleft,midVentral,Ventralupperleft,Ventrallowerright">
                                    <cfloop list="#morphoColumns#" index="col">
                                        <cfoutput><th>#ucase(left(col,1))##lcase(mid(col,2,len(col)))#</th></cfoutput>
                                    </cfloop>
                                </cfif>
                                <cfif structKeyExists(form, "neeropsyTopSection") AND form.neeropsyTopSection eq "1">
                                    <th>Attending Veterinarian</th>
                                    <th>Prosectors</th>
                                    <th>Tentative</th>
                                    <th>Cause of Death</th>
                                </cfif>
                                <cfif structKeyExists(form, "histopathologySection") AND form.histopathologySection eq "1">
                                    <th>Histopathology Report</th>
                                    <th>Diagnosis Category</th>
                                    <th>Histo Remarks</th>
                                    <th>Histopathology Diagnosis</th>
                                </cfif>
                                <cfif structKeyExists(form, "externalExamSection") AND form.externalExamSection eq "1">
                                    <th>Condition at Necropsy</th>
                                    <th>Euthanized</th>
                                    <th>General Body Condition</th>
                                    <th>Level A Date</th>
                                    <th>Animal Renderings</th>
                                    <th>Nx Location</th>
                                </cfif>
                                <cfif structKeyExists(form, "necnpsyIntegument") AND form.necnpsyIntegument eq "1">
                                    <th>Skin Lesion Formy</th>
                                    <th>Human Interaction Form</th>
                                    <th>Number of Cookie Cutter Wounds</th>
                                    <th>Number of Cookie Cutter Scars</th>
                                    <th>Eye Findings LEFT</th>
                                    <th>Eye Findings RIGHT</th>
                                    <th>Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "necropsyMusculoskeletal") AND form.necropsyMusculoskeletal eq "1">
                                    <th>MUSCULOSKELETAL SYSTEM</th>
                                    <th>Joint Fluid</th>
                                    <th>Skeletal Findings</th>
                                    <th>Muscle Status</th>
                                    <th>Musculature Findings</th>
                                    <th>Comments</th>
                                </cfif>
                                
                                
                            </tr>
                        </thead>
                        <tbody>
                            <!--- <cfdump var="#allCountt#" abort="true"> --->
                            <cfoutput query="allCountt">
                                <tr>                            
                                    <td>#Fnumber#</td> 
                                    <td>#Date#</td> 
                                    <td>#SourceTable#</td> 
                                    <cfif structKeyExists(form, "BLUEBOX") AND form.BLUEBOX eq "1">
                                        <cfloop list="#blueBoxColumnList#" index="col">
                                            <td>#Evaluate(col)#</td>
                                        </cfloop>
                                    </cfif>
                                    <!--- Heart/Resp Data --->
                                    <cfif structKeyExists(form, "hRatoRespBox") AND form.hRatoRespBox eq "1">
                                        <td>#heartRate#</td>
                                        <td>#heartRateTime#</td>
                                        <td>#respRate#</td>
                                        <td>#respRateTime#</td>
                                    </cfif>
                                    <!--- Drug Admin Data --->
                                    <cfif structKeyExists(form, "DrigAdminBox") AND form.DrigAdminBox eq "1">
                                        <td id="DrugType">#DrugType#</td>
                                        <td id="DrugMethod"><cfif DrugMethod NEQ 0>#DrugMethod#</cfif></td>
                                        <td id="DrugTime"><cfif DrugTime NEQ 0>#DrugTime#</cfif></td>
                                        <td id="DrugDosage"><cfif DrugDosage NEQ 0>#DrugDosage#</cfif></td>
                                        <td id="DrugVolume"><cfif DrugVolume NEQ 0>#DrugVolume#</cfif></td>
                                    </cfif>
                                    <!--- Biopsy Data --->
                                    <cfif structKeyExists(form, "bopsyTyp") AND form.bopsyTyp eq "1">
                                        <td>#BiopsyType#</td>
                                        <td>#BiopsyLocation#</td>
                                        <td>#BiopsySize#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "entangledRelbate") AND form.entangledRelbate eq "1">
                                        <td>#Entangled#</td>
                                        <td>#Released#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "hIForm") AND form.hIForm eq "1">
                                        <td >
                                            <cfif TYPEOFHI eq 0>
                                            <cfelse>
                                                #replace(TYPEOFHI,"-",",","all")#
                                            </cfif>
                                        </td>
                                        <td id="LocationofHI_">#replace(LocationofHI,"-",",","all")#</td>
                                        <td id="GearCollected_">#GearCollected#</td>
                                        <td id="TypeofGearCollected_">#replace(TypeofGearCollected,"-",",","all")#</td>
                                        <td id="GearDeposition_">#GearDeposition#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "htistologyRemarkes") AND form.htistologyRemarkes eq "1">
                                        <td>#SampleComments#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "levelAForm") AND form.levelAForm eq "1">
                                        <td>#LevelA_ID#</td>
                                        <td>#ILAD#</td>
                                        <td>#ILADComment#</td>
                                        <td>#CarcassStatus#</td>
                                        <td>#CarcassStatusLat#</td>
                                        <td>#CarcassStatusLon#</td>
                                        <td><cfif GroupEvent EQ 1>Checked</cfif></td>
                                        <td>#GroupEventType#</td>
                                        <td>#noOfAnimals#</td>
                                        <td>#TagsWere#</td>
                                        <td><cfif Restrand EQ 1>Checked</cfif></td>
                                    </cfif>
                                    <cfif structKeyExists(form, "morphometrics") AND form.morphometrics eq "1">
                                        <cfloop list="#morphoColumns#" index="col">
                                            <td>#Evaluate(col)#</td>
                                        </cfloop>
                                    </cfif>
                                    <cfif structKeyExists(form, "neeropsyTopSection") AND form.neeropsyTopSection eq "1">
                                        <td>#attendingVeterinarian#</td>
                                        <td>#Prosectors#</td>
                                        <td>#Tentative#</td>
                                        <td>#deathcause#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "histopathologySection") AND form.histopathologySection eq "1">
                                        <td>#HistopathologyReport#</td>
                                        <td>#NRDiagnosisCategory#</td>
                                        <td>#historemark#</td>
                                        <td>#NRHistopathologyDiagnosis#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "externalExamSection") AND form.externalExamSection eq "1">
                                        <td>#Necropsycondition#</td>
                                        <td>#Euthanized#</td>
                                        <td>#Bodycondition#</td>
                                        <td>#LevelADate#</td>
                                        <td>#AnimalRenderings#</td>
                                        <td>#NxLocation#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "necnpsyIntegument") AND form.necnpsyIntegument eq "1">
                                        <td>#Lesionform#</td>
                                        <td>#HIForm#</td>
                                        <td>#cutterwounds#</td>
                                        <td>#cutterscars#</td>
                                        <td>#eyeleft#</td>
                                        <td>#eyeright#</td>
                                        <td>#lessioncomments#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "necropsyMusculoskeletal") AND form.necropsyMusculoskeletal eq "1">
                                        <td>#MUSCULOSKELETAL#</td>
                                        <td>#Joint_Fluid#</td>
                                        <td>#Skeletal_Findings#</td>
                                        <td>#Muscle_Status#</td>
                                        <td>#Musculature_Findings#</td>
                                        
                                        <td>#muscular_comments#</td>
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