<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <cfset variables.dsn = "wildfins_new">
    <cfset today = now()>
 
    <cfquery name="lesionRegion" datasource="#variables.dsn#">
        SELECT * from TLU_Regions
    </cfquery>
    <cfset pg = 1>
    <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge') or (isdefined('FORM.exportAll') and FORM.exportAll eq "1")>
        <cfscript>
            function buildStrandingReportPagination(totalRows, rowsPerPage, currentRecordCount, requestedPage) {
                var paginationStruct = StructNew();
                var totalCount = val(arguments.totalRows);
                var pageNumber = 1;
                var maxPagesBefore = 3;
                var maxPagesAfter = 3;
                var maxPages = maxPagesBefore + maxPagesAfter + 1;
                var startIndex = 1;
                var endIndex = 0;
                var displayLinks = ArrayNew(1);
                var pageObj = StructNew();
                var i = 1;

                if(isNumeric(arguments.requestedPage) AND val(arguments.requestedPage) GT 0)
                {
                    pageNumber = val(arguments.requestedPage);
                }

                paginationStruct["numberOfPages"] = Ceiling(totalCount / arguments.rowsPerPage);
                if(paginationStruct["numberOfPages"] GT 0 AND pageNumber GT paginationStruct["numberOfPages"])
                {
                    pageNumber = paginationStruct["numberOfPages"];
                }
                if(pageNumber LT 1)
                {
                    pageNumber = 1;
                }

                if(totalCount == 0)
                {
                    paginationStruct["startCount"] = 1;
                }
                else
                {
                    paginationStruct["startCount"] = (((pageNumber - 1) * arguments.rowsPerPage) + 1);
                }
                paginationStruct["endCount"] = ((pageNumber - 1) * arguments.rowsPerPage) + arguments.currentRecordCount;

                if(pageNumber == 1)
                {
                    if(totalCount GTE arguments.rowsPerPage)
                    {
                        paginationStruct["nextCount"] = arguments.currentRecordCount;
                    }
                    else
                    {
                        paginationStruct["nextCount"] = totalCount;
                    }
                }
                else
                {
                    if(totalCount LT paginationStruct["startCount"] + arguments.rowsPerPage)
                    {
                        paginationStruct["nextCount"] = totalCount;
                    }
                    else
                    {
                        paginationStruct["nextCount"] = (((pageNumber - 1) * arguments.rowsPerPage) + arguments.rowsPerPage);
                    }
                }

                paginationStruct["totalCount"] = totalCount;
                paginationStruct["pageNumber"] = pageNumber;
                if(pageNumber LT paginationStruct["numberOfPages"])
                {
                    paginationStruct["nextLink"] = pageNumber + 1;
                }
                if(pageNumber LTE paginationStruct["numberOfPages"] AND pageNumber GT 1)
                {
                    paginationStruct["previousLink"] = pageNumber - 1;
                }

                endIndex = paginationStruct["numberOfPages"];
                if(paginationStruct["numberOfPages"] GT maxPages)
                {
                    startIndex = pageNumber - maxPagesBefore;
                    endIndex = pageNumber + maxPagesAfter;
                    if(startIndex LT 1)
                    {
                        startIndex = 1;
                        endIndex = (startIndex + maxPages) - 1;
                    }
                    if(endIndex GT paginationStruct["numberOfPages"])
                    {
                        startIndex = paginationStruct["numberOfPages"] - maxPages;
                        endIndex = paginationStruct["numberOfPages"];
                    }
                }

                if(endIndex GT 1)
                {
                    for(i = startIndex; i <= endIndex; i++)
                    {
                        pageObj = StructNew();
                        pageObj["pageNumber"] = i;
                        pageObj["pageLink"] = i;
                        pageObj["isCurrentPage"] = (pageNumber EQ i);
                        ArrayAppend(displayLinks, pageObj);
                    }
                    paginationStruct["displayLinks"] = displayLinks;
                }

                return paginationStruct;
            }

            rowsPerPage = 100;
            currentRecordCount = 100;
            if(isDefined('form.btnSearchSightings'))
            {
                requestedPage = 1;
            }
            else if(isDefined('form.pge') AND isNumeric(form.pge) AND val(form.pge) GT 0)
            {
                requestedPage = val(form.pge);
            }
            else
            {
                requestedPage = 1;
            }
            pg = requestedPage;
        </cfscript>
        
        <cfset blueBoxColumns = ""> 

        <cfif structKeyExists(form, "blueBox") AND form.blueBox eq "1">
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
        
        <cfif structKeyExists(form, "PhysicalExamNotes") AND form.PhysicalExamNotes eq "1">
            
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

        <cfset necmopsyThoracicCavityColumnList = "">
        <cfset necmopsyThoracicCavityColumnList_Other = "">

        <cfif structKeyExists(form, "necmopsyThoracicCavity") AND form.necmopsyThoracicCavity eq "1">

            <cfset necmopsyThoracicCavityColumnList = "
                , CAST(THORACIC AS NVARCHAR(1024)) AS THORACIC
                , CAST(fluidVolume AS NVARCHAR(1024)) AS fluidVolume
                , CAST(ml AS NVARCHAR(1024)) AS ml
                , CAST(THORACIC_Fluid AS NVARCHAR(1024)) AS THORACIC_Fluid
                , CAST(THORACIC_Lining AS NVARCHAR(1024)) AS THORACIC_Lining
                , CAST(thoratic_comments AS NVARCHAR(1024)) AS thoratic_comments
                
            ">
        
            <cfset necmopsyThoracicCavityColumnList_Other = "
                , NULL AS THORACIC
                , NULL AS fluidVolume
                , NULL AS ml
                , NULL AS THORACIC_Fluid
                , NULL AS THORACIC_Lining
                , NULL AS thoratic_comments
                
            ">
        
        </cfif>


        <cfset nutntionalConditonExternasColumnList = "">
        <cfset nutntionalConditonExternasColumnList_Other = "">

        <cfif structKeyExists(form, "nutntionalConditonExternas") AND form.nutntionalConditonExternas eq "1">

            <cfset nutntionalConditonExternasColumnList = "
                , CAST(Fat_Blubber AS NVARCHAR(1024)) AS Fat_Blubber
                , CAST(heart AS NVARCHAR(1024)) AS heart
                , CAST(mesentery AS NVARCHAR(1024)) AS mesentery
                , CAST(kidney AS NVARCHAR(1024)) AS kidney
                , CAST(internal_comments AS NVARCHAR(1024)) AS internal_comments                
                
            ">
        
            <cfset nutntionalConditonExternasColumnList_Other = "
                , NULL AS Fat_Blubber
                , NULL AS heart
                , NULL AS mesentery
                , NULL AS kidney
                , NULL AS internal_comments
                
            ">
        
        </cfif>


        <cfset neenpsyAbdaminalCavityColumnList = "">
        <cfset neenpsyAbdaminalCavityColumnList_Other = "">

        <cfif structKeyExists(form, "neenpsyAbdaminalCavity") AND form.neenpsyAbdaminalCavity eq "1">

            <cfset neenpsyAbdaminalCavityColumnList = "
                , CAST(ABDOMINAL AS NVARCHAR(1024)) AS ABDOMINAL
                , CAST(abdominal_fluidVolume AS NVARCHAR(1024)) AS abdominal_fluidVolume
                , CAST(ABDOMINAL_ml AS NVARCHAR(1024)) AS ABDOMINAL_ml
                , CAST(ABDOMINAL_Fluid AS NVARCHAR(1024)) AS ABDOMINAL_Fluid
                , CAST(ABDOMINAL_Lining AS NVARCHAR(1024)) AS ABDOMINAL_Lining                
                , CAST(abdominal_comments AS NVARCHAR(1024)) AS abdominal_comments                
                
            ">
        
            <cfset neenpsyAbdaminalCavityColumnList_Other = "
                , NULL AS ABDOMINAL
                , NULL AS abdominal_fluidVolume
                , NULL AS ABDOMINAL_ml
                , NULL AS ABDOMINAL_Fluid
                , NULL AS ABDOMINAL_Lining
                , NULL AS abdominal_comments
                
            ">
        
        </cfif>

        <cfset necropsyHepatobilianyColumnList = "">
        <cfset necropsyHepatobilianyColumnList_Other = "">

        <cfif structKeyExists(form, "necropsyHepatobiliany") AND form.necropsyHepatobiliany eq "1">

            <cfset necropsyHepatobilianyColumnList = "
                , CAST(HEPATOBILIARY AS NVARCHAR(1024)) AS HEPATOBILIARY
                , CAST(Liver_Findings AS NVARCHAR(1024)) AS Liver_Findings
                , CAST(Biliary_Findings AS NVARCHAR(1024)) AS Biliary_Findings
                , CAST(hepatobiliary_comments AS NVARCHAR(1024)) AS hepatobiliary_comments                               
                
            ">
        
            <cfset necropsyHepatobilianyColumnList_Other = "
                , NULL AS HEPATOBILIARY
                , NULL AS Liver_Findings
                , NULL AS Biliary_Findings
                , NULL AS hepatobiliary_comments
                
            ">
        
        </cfif>

        <cfset necropsyCordiovasculorColumnList = "">
        <cfset necropsyCordiovasculorColumnList_Other = "">

        <cfif structKeyExists(form, "necropsyCordiovasculor") AND form.necropsyCordiovasculor eq "1">

            <cfset necropsyCordiovasculorColumnList = "
                , CAST(CARDIOVASCULAR AS NVARCHAR(1024)) AS CARDIOVASCULAR
                , CAST(Chambers AS NVARCHAR(1024)) AS Chambers
                , CAST(cardio_describe AS NVARCHAR(1024)) AS cardio_describe
                , CAST(Pericardial_Fluid AS NVARCHAR(1024)) AS Pericardial_Fluid                               
                , CAST(Overall_Findings AS NVARCHAR(1024)) AS Overall_Findings                               
                , CAST(cardio_comments AS NVARCHAR(1024)) AS cardio_comments                               
                
            ">
        
            <cfset necropsyCordiovasculorColumnList_Other = "
                , NULL AS CARDIOVASCULAR
                , NULL AS Chambers
                , NULL AS cardio_describe
                , NULL AS Pericardial_Fluid
                , NULL AS Overall_Findings
                , NULL AS cardio_comments
                
            ">
        
        </cfif>

        <cfset necnopsyPulmonaryColumnList = "">
        <cfset necnopsyPulmonaryColumnList_Other = "">

        <cfif structKeyExists(form, "necnopsyPulmonary") AND form.necnopsyPulmonary eq "1">

            <cfset necnopsyPulmonaryColumnList = "
                , CAST(PULMONARY AS NVARCHAR(1024)) AS PULMONARY
                , CAST(Froth_in_Airway AS NVARCHAR(1024)) AS Froth_in_Airway
                , CAST(If_Present AS NVARCHAR(1024)) AS If_Present
                , CAST(Foam_Amount AS NVARCHAR(1024)) AS Foam_Amount                               
                , CAST(Color_of_Foam AS NVARCHAR(1024)) AS Color_of_Foam                               
                , CAST(Sand_Sediment AS NVARCHAR(1024)) AS Sand_Sediment
                , CAST(Trachea_Bronchi AS NVARCHAR(1024)) AS Trachea_Bronchi                               
                , CAST(Lungs_Findings AS NVARCHAR(1024)) AS Lungs_Findings                               
                , CAST(Lungs_Float AS NVARCHAR(1024)) AS Lungs_Float                               
                , CAST(pulmonary_comments AS NVARCHAR(1024)) AS pulmonary_comments                               
                
            ">
        
            <cfset necnopsyPulmonaryColumnList_Other = "
                , NULL AS PULMONARY
                , NULL AS Froth_in_Airway
                , NULL AS If_Present
                , NULL AS Foam_Amount
                , NULL AS Color_of_Foam
                , NULL AS Sand_Sediment
                , NULL AS Trachea_Bronchi
                , NULL AS Lungs_Findings
                , NULL AS Lungs_Float
                , NULL AS pulmonary_comments
                
            ">
        
        </cfif>
        

        <cfset neenpsylymphoreticulorColumnList = "">
        <cfset neenpsylymphoreticulorColumnList_Other = "">

        <cfif structKeyExists(form, "neenpsylymphoreticulor") AND form.neenpsylymphoreticulor eq "1">

            <cfset neenpsylymphoreticulorColumnList = "
                , CAST(ST_CetaceanNecropsyReport.LYMPHORETICULAR AS NVARCHAR(1024)) AS LYMPHORETICULAR
                , CAST(ST_CetaceanNecropsyReport.Spleen AS NVARCHAR(1024)) AS Spleen
                , CAST(ST_CetaceanNecropsyReport.Spleen_Findings AS NVARCHAR(1024)) AS Spleen_Findings
                , CAST(ST_CetaceanNecropsyReport.lympho_other AS NVARCHAR(1024)) AS lympho_other                               
                , CAST(ST_DynamicLymphoreticular.lymphnode AS NVARCHAR(1024)) AS lymphnode                               
                , CAST(ST_DynamicLymphoreticular.nodelength AS NVARCHAR(1024)) AS nodelength
                , CAST(ST_DynamicLymphoreticular.nodewidth AS NVARCHAR(1024)) AS nodewidth                               
                , CAST(ST_CetaceanNecropsyReport.lympho_comments AS NVARCHAR(1024)) AS lympho_comments                
            ">
        
            <cfset neenpsylymphoreticulorColumnList_Other = "
                , NULL AS LYMPHORETICULAR
                , NULL AS Spleen
                , NULL AS Spleen_Findings
                , NULL AS lympho_other
                , NULL AS lymphnode
                , NULL AS nodelength
                , NULL AS nodewidth
                , NULL AS lympho_comments
                
            ">
        
        </cfif>

        <cfset necropsyEndocnineColumnList = "">
        <cfset necropsyEndocnineColumnList_Other = "">

        <cfif structKeyExists(form, "necropsyEndocrine") AND form.necropsyEndocrine eq "1">

            <cfset necropsyEndocnineColumnList = "
                , CAST(ENDOCRINE AS NVARCHAR(1024)) AS ENDOCRINE
                , CAST(Adrenal_Glands AS NVARCHAR(1024)) AS Adrenal_Glands
                , CAST(adrenal_leftLength AS NVARCHAR(1024)) AS adrenal_leftLength
                , CAST(adrenal_rightLength AS NVARCHAR(1024)) AS adrenal_rightLength                               
                , CAST(adrenal_leftwidth AS NVARCHAR(1024)) AS adrenal_leftwidth                               
                , CAST(adrenal_rightwidth AS NVARCHAR(1024)) AS adrenal_rightwidth
                , CAST(Thyroid AS NVARCHAR(1024)) AS Thyroid                               
                , CAST(thyroid_length AS NVARCHAR(1024)) AS thyroid_length                               
                , CAST(thyroid_width AS NVARCHAR(1024)) AS thyroid_width                               
                , CAST(Pituitary_Gland AS NVARCHAR(1024)) AS Pituitary_Gland                               
                , CAST(Pituitary_length AS NVARCHAR(1024)) AS Pituitary_length                               
                , CAST(Pituitary_width AS NVARCHAR(1024)) AS Pituitary_width                               
                , CAST(endocrine_comments AS NVARCHAR(1024)) AS endocrine_comments                               
                
            ">
        
            <cfset necropsyEndocnineColumnList_Other = "
                , NULL AS ENDOCRINE
                , NULL AS Adrenal_Glands
                , NULL AS adrenal_leftLength
                , NULL AS adrenal_rightLength
                , NULL AS adrenal_leftwidth
                , NULL AS adrenal_rightwidth
                , NULL AS Thyroid
                , NULL AS thyroid_length
                , NULL AS thyroid_width
                , NULL AS Pituitary_Gland
                , NULL AS Pituitary_length
                , NULL AS Pituitary_width
                , NULL AS endocrine_comments
                
            ">
        
        </cfif>

        <cfset neonpsyCentraeNenvusSysemColumnList = "">
        <cfset neonpsyCentraeNenvusSysemColumnList_Other = "">

        <cfif structKeyExists(form, "neonpsyCentraeNenvusSysem") AND form.neonpsyCentraeNenvusSysem eq "1">

            <cfset neonpsyCentraeNenvusSysemColumnList = "
                , CAST(CENTRALbrain AS NVARCHAR(1024)) AS CENTRALbrain
                , CAST(CENTRALBrainFindings AS NVARCHAR(1024)) AS CENTRALBrainFindings
                , CAST(brainother AS NVARCHAR(1024)) AS brainother
                , CAST(CENTRALSpinalCord AS NVARCHAR(1024)) AS CENTRALSpinalCord                               
                , CAST(CENTRALSpinalCordfinding AS NVARCHAR(1024)) AS CENTRALSpinalCordfinding                               
                , CAST(spinalother AS NVARCHAR(1024)) AS spinalother
                , CAST(nervoussystemcomments  AS NVARCHAR(1024)) AS nervoussystemcomments                
            ">
        
            <cfset neonpsyCentraeNenvusSysemColumnList_Other = "
                , NULL AS CENTRALbrain
                , NULL AS CENTRALBrainFindings
                , NULL AS brainother
                , NULL AS CENTRALSpinalCord
                , NULL AS CENTRALSpinalCordfinding
                , NULL AS spinalother
                , NULL AS nervoussystemcomments
                
            ">
        
        </cfif>

        <cfset necropsyUrogenitalColumnList = "">
        <cfset necropsyUrogenitalColumnList_Other = "">
        <cfif structKeyExists(form, "necropsyUrogenital") AND form.necropsyUrogenital eq "1">

            <cfset necropsyUrogenitalColumnList = "
                , CAST(UROGENITAL AS NVARCHAR(1024)) AS UROGENITAL
                , CAST(Kidney_left AS NVARCHAR(1024)) AS Kidney_left
                , CAST(Kidney_right AS NVARCHAR(1024)) AS Kidney_right
                , CAST(Urinary_Bladder AS NVARCHAR(1024)) AS Urinary_Bladder                               
                , CAST(urin_volume AS NVARCHAR(1024)) AS urin_volume                               
                , CAST(UROGENITAL_color AS NVARCHAR(1024)) AS UROGENITAL_color
                , CAST(Consistancy  AS NVARCHAR(1024)) AS Consistancy                
                , CAST(Abnormalities  AS NVARCHAR(1024)) AS Abnormalities                
                , CAST(Abnormalities_describe  AS NVARCHAR(1024)) AS Abnormalities_describe                
                , CAST(Reproductive_Organs  AS NVARCHAR(1024)) AS Reproductive_Organs                
                , CAST(Identified_As  AS NVARCHAR(1024)) AS Identified_As                
                , CAST(Lesions  AS NVARCHAR(1024)) AS Lesions                
                , CAST(Gonads_Identified  AS NVARCHAR(1024)) AS Gonads_Identified                
                , CAST(Testes_Length_LEFT  AS NVARCHAR(1024)) AS Testes_Length_LEFT                
                , CAST(Testes_Length_width  AS NVARCHAR(1024)) AS Testes_Length_width                
                , CAST(Glands_LEFT  AS NVARCHAR(1024)) AS Glands_LEFT                
                , CAST(Testes_Length_right  AS NVARCHAR(1024)) AS Testes_Length_right                
                , CAST(Testes_width_right  AS NVARCHAR(1024)) AS Testes_width_right                
                , CAST(Glands_RIGHT  AS NVARCHAR(1024)) AS Glands_RIGHT                
                , CAST(Ovary_Length_LEFT  AS NVARCHAR(1024)) AS Ovary_Length_LEFT                
                , CAST(Ovary_Width_LEFT  AS NVARCHAR(1024)) AS Ovary_Width_LEFT                
                , CAST(Follicles_Present_Left  AS NVARCHAR(1024)) AS Follicles_Present_Left                
                , CAST(Ovary_Length_right  AS NVARCHAR(1024)) AS Ovary_Length_right                
                , CAST(Ovary_width_right  AS NVARCHAR(1024)) AS Ovary_width_right                
                , CAST(Follicles_Present_right  AS NVARCHAR(1024)) AS Follicles_Present_right                
                , CAST(UROGENITAL_Comments  AS NVARCHAR(1024)) AS UROGENITAL_Comments    
            ">
        
            <cfset necropsyUrogenitalColumnList_Other = "
                , NULL AS UROGENITAL
                , NULL AS Kidney_left
                , NULL AS Kidney_right
                , NULL AS Urinary_Bladder
                , NULL AS urin_volume
                , NULL AS UROGENITAL_color
                , NULL AS Consistancy
                , NULL AS Abnormalities
                , NULL AS Abnormalities_describe
                , NULL AS Reproductive_Organs
                , NULL AS Identified_As
                , NULL AS Lesions
                , NULL AS Gonads_Identified
                , NULL AS Testes_Length_LEFT
                , NULL AS Testes_Length_width
                , NULL AS Glands_LEFT
                , NULL AS Testes_Length_right
                , NULL AS Testes_width_right
                , NULL AS Glands_RIGHT
                , NULL AS Ovary_Length_LEFT
                , NULL AS Ovary_Width_LEFT
                , NULL AS Follicles_Present_Left
                , NULL AS Ovary_Length_right
                , NULL AS Ovary_width_right
                , NULL AS Follicles_Present_right
                , NULL AS UROGENITAL_Comments
            ">
        
        </cfif>
        
        <cfset necropsyAlimentaryColumnList = "">
        <cfset necropsyAlimentaryColumnList_Other = "">
        <cfif structKeyExists(form, "necropsyAlimentary") AND form.necropsyAlimentary eq "1">

            <cfset necropsyAlimentaryColumnList = "
                , CAST(ALIMENTARYSYSTEM AS NVARCHAR(1024)) AS ALIMENTARYSYSTEM
                , CAST(Esophagus AS NVARCHAR(1024)) AS Esophagus
                , CAST(Forestomach AS NVARCHAR(1024)) AS Forestomach                               
                , CAST(glandularStomach AS NVARCHAR(1024)) AS glandularStomach                               
                , CAST(Pylorus AS NVARCHAR(1024)) AS Pylorus                               
                , CAST(smallIntestine AS NVARCHAR(1024)) AS smallIntestine                               
                , CAST(Colon AS NVARCHAR(1024)) AS Colon                                   
                , CAST(AlimentarySystemComments AS NVARCHAR(1024)) AS AlimentarySystemComments                               
                
            ">
        
            <cfset necropsyAlimentaryColumnList_Other = "
                , NULL AS ALIMENTARYSYSTEM
                , NULL AS Esophagus
                , NULL AS Forestomach
                , NULL AS glandularStomach
                , NULL AS Pylorus
                , NULL AS smallIntestine
                , NULL AS Colon
                , NULL AS AlimentarySystemComments
                
            ">
        </cfif>

        <cfset G1ForeignMaterialColumnList = "">
        <cfset G1ForeignMaterialColumnList_Other = "">
        <cfif structKeyExists(form, "G1ForeignMaterial") AND form.G1ForeignMaterial eq "1">

            <cfset G1ForeignMaterialColumnList = "
                , CAST(GIForeignMaterialType AS NVARCHAR(1024)) AS GIForeignMaterialType
                , CAST(MaterialLesionLocation AS NVARCHAR(1024)) AS MaterialLesionLocation
                , CAST(MaterialCollected AS NVARCHAR(1024)) AS MaterialCollected                               
                , CAST(DispositionofMaterialCollected AS NVARCHAR(1024)) AS DispositionofMaterialCollected                               
                , CAST(Parasitecomments AS NVARCHAR(1024)) AS Parasitecomments                               
                                         
                
            ">
        
            <cfset G1ForeignMaterialColumnList_Other = "
                , NULL AS GIForeignMaterialType
                , NULL AS MaterialLesionLocation
                , NULL AS MaterialCollected
                , NULL AS DispositionofMaterialCollected
                , NULL AS Parasitecomments
                
            ">
        </cfif>


        <cftry>
        <cfif isdefined("form.date") and form.date NEQ "">
            <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
            <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
        </cfif>

        
        <cfset BodyOfWaterList = "">
        <cfif StructKeyExists(Form, "BodyOfWater") AND Len(Trim(Form.BodyOfWater))>
            <cfloop list="#Form.BodyOfWater#" index="bodyOfWaterFormId">
                <cfset bodyOfWaterFormId = Trim(bodyOfWaterFormId)>
                <cfif Len(bodyOfWaterFormId)>
                    <cfset BodyOfWaterList = ListAppend(BodyOfWaterList, bodyOfWaterFormId)>
                </cfif>
            </cfloop>
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
        <cfif StructKeyExists(Form, "Tissue_type") AND Form.Tissue_type NEQ "">
            <cfset TissueTypeList = Form.Tissue_type>
        <cfelse>
            <cfset TissueTypeList = "">
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
        <cfif StructKeyExists(Form, "hisSampleType") AND Form.hisSampleType NEQ "">
            <cfset HistoSampleTypeList = Form.hisSampleType>
        <cfelse>
            <cfset HistoSampleTypeList = "">
        </cfif>

       
        <!--- <cfdump var="#BodyOfWaterList#" abort="true"> --->
        <cfquery datasource="#variables.dsn#" name="allCountt" result="r">
            SELECT 'Cetacean Exam' AS SourceTable, ST_LiveCetaceanExam.ID AS cetacenID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_CE# #drugColumnList_CE# #biopsyColumnList_CE# #PhysicalColumnList_CE# #entangledRelbateColumnList_CE# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
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
            <cfif structKeyExists(form, "DrigAdminBox") AND form.DrigAdminBox eq "1">
                LEFT JOIN ST_DrugsAdministered 
                    ON ST_LiveCetaceanExam.ID = ST_DrugsAdministered.LCE_ID
            </cfif>
            <cfif structKeyExists(form, "bopsyTyp") AND form.bopsyTyp eq "1">
                LEFT JOIN ST_Biopsy 
                    ON ST_LiveCetaceanExam.ID = ST_Biopsy.LCE_ID
            </cfif>
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
        
            SELECT 'HI Form' AS SourceTable, ST_HIForm.ID AS HI_ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_CE# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
            FROM ST_HIForm
            <cfif structKeyExists(form, "hIForm") AND form.hIForm eq "1">
                LEFT JOIN ST_DynamicHI 
                    ON ST_HIForm.ID = ST_DynamicHI.HI_ID
            </cfif>
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
        
            SELECT 'Level A Form' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_CE# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
            FROM ST_LevelAForm
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
        
            SELECT 'Histo Form' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_CE# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
            FROM ST_HistoForm
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
            <cfif isdefined("HistoSampleTypeList") AND HistoSampleTypeList NEQ "">
                AND EXISTS (
                    SELECT 1
                    FROM ST_HistoSampleData
                    WHERE ST_HistoSampleData.HI_ID = ST_HistoForm.ID
                        AND (
                            ST_HistoSampleData.SampleType IN (
                                <cfqueryparam value="#HistoSampleTypeList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                            )
                            OR ST_HistoSampleData.SampleType IN (
                                SELECT CAST(TLU_Sample_Type.ID AS VARCHAR(50))
                                FROM TLU_Sample_Type
                                WHERE TLU_Sample_Type.[Type] IN (
                                    <cfqueryparam value="#HistoSampleTypeList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                                )
                            )
                        )
                )
            </cfif>
      
        
            UNION ALL
        
            SELECT 'Blood Values' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
            FROM ST_Blood_Values
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
            SELECT 'Toxicology' AS SourceTable, ST_Toxicology.ID AS toxicologyID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
            FROM ST_Toxicology
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
            <cfif isdefined("TissueTypeList") AND TissueTypeList NEQ "">
                AND EXISTS (
                    SELECT 1
                    FROM ST_ToxiType
                    WHERE ST_ToxiType.Toxi_ID = ST_Toxicology.ID
                        AND ST_ToxiType.Tissue_type IN (
                            <cfqueryparam value="#TissueTypeList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                        )
                )
            </cfif>
      
        
            UNION ALL
        
            SELECT 'Ancillary Diagnostics' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
            FROM ST_Ancillary_Diagnostics 
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
            <cfif isdefined("DiagnosticTestList") AND DiagnosticTestList NEQ "">
                AND EXISTS (
                    SELECT 1
                    FROM ST_Ancillary_Report
                    WHERE ST_Ancillary_Report.AD_ID = ST_Ancillary_Diagnostics.ID
                        AND ST_Ancillary_Report.DiagnosticTest IN (
                            <cfqueryparam value="#DiagnosticTestList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                        )
                )
            </cfif>
         
        
            UNION ALL
         
            SELECT 'Sample Archive' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
            FROM ST_SampleArchive
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
            <cfif isdefined("SampleTypeList") AND SampleTypeList NEQ "">
                AND EXISTS (
                    SELECT 1
                    FROM ST_SampleType
                    WHERE ST_SampleType.SA_ID = ST_SampleArchive.ID
                        AND ST_SampleType.SampleType IN (
                            <cfqueryparam value="#SampleTypeList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                        )
                )
            </cfif>
    
        
            UNION ALL
        
            SELECT 'Morphometrics' AS SourceTable, ID, Fnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_CE# #necropsyColumnList_Other# #histopathologySectionColumnList_Other# #externalExamSectionColumnList_Other# #necnpsyIntegumentColumnList_Other# #necropsyMusculoskeletalColumnList_Other# #necmopsyThoracicCavityColumnList_Other# #nutntionalConditonExternasColumnList_Other# #neenpsyAbdaminalCavityColumnList_Other# #necropsyHepatobilianyColumnList_Other# #necropsyCordiovasculorColumnList_Other# #necnopsyPulmonaryColumnList_Other# #necropsyEndocnineColumnList_Other# #neonpsyCentraeNenvusSysemColumnList_Other# #neenpsylymphoreticulorColumnList_Other# #necropsyUrogenitalColumnList_Other# #necropsyAlimentaryColumnList_Other# #G1ForeignMaterialColumnList_Other#
            FROM ST_Morphometrics
            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
            SELECT 'Cetacean Necropsy Report' AS SourceTable, ST_CetaceanNecropsyReport.ID AS nID, ST_CetaceanNecropsyReport.Fnumber as Nfnumber, Date #blueBoxColumns# #heartRespColumnList_Other# #drugColumnList_Other# #biopsyColumnList_Other# #PhysicalColumnList_Other# #entangledRelbateColumnList_Other# #hIFormColumnList_Other# #histoRemarksColumnList_Other# #levelAFormColumnList_Other# #morphometricsColumnList_Other# #necropsyColumnList_CE# #histopathologySectionColumnList# #externalExamSectionColumnList# #necnpsyIntegumentColumnList# #necropsyMusculoskeletalColumnList# #necmopsyThoracicCavityColumnList# #nutntionalConditonExternasColumnList# #neenpsyAbdaminalCavityColumnList# #necropsyHepatobilianyColumnList# #necropsyCordiovasculorColumnList# #necnopsyPulmonaryColumnList# #necropsyEndocnineColumnList# #neonpsyCentraeNenvusSysemColumnList# #neenpsylymphoreticulorColumnList# #necropsyUrogenitalColumnList# #necropsyAlimentaryColumnList# #G1ForeignMaterialColumnList#
            FROM ST_CetaceanNecropsyReport
            <cfif structKeyExists(form, "neenpsylymphoreticulor") AND form.neenpsylymphoreticulor eq "1">
                LEFT JOIN ST_DynamicLymphoreticular 
                ON ST_CetaceanNecropsyReport.fnumber = ST_DynamicLymphoreticular.fnumber
            </cfif>

            WHERE 1=1
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND isdefined("form.endDate") AND form.endDate NEQ "">
                AND Date >= <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
                AND Date < DATEADD(day, 1, <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">)
            </cfif>
            <cfif isdefined("BodyOfWaterList") and BodyOfWaterList neq "">
                AND (
                    <cfset bodyOfWaterFilterIndex = 0>
                    <cfloop list="#BodyOfWaterList#" index="bodyOfWaterId">
                        <cfset bodyOfWaterId = Trim(bodyOfWaterId)>
                        <cfif Len(bodyOfWaterId)>
                            <cfset bodyOfWaterFilterIndex = bodyOfWaterFilterIndex + 1>
                            <cfif bodyOfWaterFilterIndex GT 1> OR </cfif>
                            (',' + REPLACE(COALESCE(CAST(BodyOfWater AS VARCHAR(8000)), ''), ' ', '') + ',') LIKE <cfqueryparam value="%,#bodyOfWaterId#,%" cfsqltype="CF_SQL_VARCHAR">
                        </cfif>
                    </cfloop>
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
             <cfif isdefined("ParasiteTypeList") AND ParasiteTypeList NEQ "">
                AND EXISTS (
                    SELECT 1
                    FROM ST_DynamicParasites
                    WHERE ST_DynamicParasites.fnumber = ST_CetaceanNecropsyReport.fnumber
                        AND ST_DynamicParasites.ParasiteType IN (
                            <cfqueryparam value="#ParasiteTypeList#" list="true" cfsqltype="CF_SQL_VARCHAR">
                        )
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
    <cfset qgetStrandingType=Application.StaticDataNew.getStrandingType()>
    <cfset getStock=Application.StaticDataNew.getStock()>
    <cfset qgetVeterinarians=Application.StaticDataNew.getVeterinarians()>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Moderately Decomposed' ,'Advanced Composition','Mummified']>
    <cfset ConditionsValue = ['1', '2', '3' ,'4','5']>
    <cfset qgetSampleType=Application.StaticDataNew.getSampleType()>
    <cfset qgetIR_CountyLocation=Application.StaticDataNew.getIR_CountyLocation()>
    <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>
    <cfset bodyConditions = ['Emaciated','Underweight/Thin','Ideal','Overweight','Obese']>
    <cfset blueBoxLookupMap = StructNew()>
    <cfset blueBoxLookupMap["species"] = StructNew()>
    <cfloop query="qgetCetaceanSpecies">
        <cfset blueBoxLookupMap["species"][Trim(qgetCetaceanSpecies.ID)] = qgetCetaceanSpecies.CetaceanSpeciesName>
    </cfloop>
    <cfset blueBoxLookupMap["researchteam"] = StructNew()>
    <cfloop query="RTmembers">
        <cfset blueBoxLookupMap["researchteam"][Trim(RTmembers.RT_ID)] = RTmembers.RT_MemberName>
    </cfloop>
    <cfset blueBoxLookupMap["veterinarian"] = StructNew()>
    <cfloop query="qgetVeterinarians">
        <cfset blueBoxLookupMap["veterinarian"][Trim(qgetVeterinarians.ID)] = qgetVeterinarians.Veterinarians>
    </cfloop>
    <cfset blueBoxLookupMap["bodyofwater"] = StructNew()>
    <cfloop query="getSurveyAreaData">
        <cfset blueBoxLookupMap["bodyofwater"][Trim(getSurveyAreaData.ID)] = getSurveyAreaData.AreaName>
    </cfloop>
    <cfset blueBoxLookupMap["sttpye"] = StructNew()>
    <cfloop query="qgetStrandingType">
        <cfset blueBoxLookupMap["sttpye"][Trim(qgetStrandingType.ID)] = qgetStrandingType.Type>
    </cfloop>
    <cfset blueBoxLookupMap["noaastock"] = StructNew()>
    <cfloop query="getStock">
        <cfset blueBoxLookupMap["noaastock"][Trim(getStock.ID)] = getStock.StockName>
    </cfloop>

    <cfset Kidneys_Findings= ['No Findings','Trauma','Enlarged','Masses','Parasites','Other']>
    <cfset Alimentary_SystemArray=['Ulcers/exudate','Trauma','Masses','Impaction','Obstruction','lntussusception','Parasites']>
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
                        <form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="searchAllReports" id="searchAllReports" method="post">
                            <input type="hidden" name="pge" id="pge" value="<cfif isDefined('pg')>#pg#<cfelseif isDefined('form.pge')>#form.pge#<cfelse>1</cfif>">
                            <input type="hidden" name="is_pagination_click" id="is_pagination_click" value="0">
                            <input type="hidden" name="exportAll" id="exportAll" value="0">
                            <input type="hidden" name="exportFormat" id="exportFormat" value="">
                            <input type="hidden" name="sort_col" id="sort_col" value="<cfif isDefined('form.sort_col') and isNumeric(form.sort_col)>#val(form.sort_col)#<cfelse>0</cfif>">
                            <input type="hidden" name="sort_dir" id="sort_dir" value="<cfif isDefined('form.sort_dir') and LCase(Trim(form.sort_dir)) eq 'desc'>desc<cfelse>asc</cfif>">
                            <input type="hidden" name="sort_name" id="sort_name" value="<cfif isDefined('form.sort_name') and len(trim(form.sort_name))>#trim(form.sort_name)#<cfelse>Fnumber</cfif>">
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
                                            <!--- <option value="">Select Diagnostic Test</option> --->
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
                                                <!--- <option value="">Select Initial Condition</option> --->
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
                                                    <!--- <option value="">Select IParasite Type</option> --->
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
                                                <!--- <option value="">Select Final Condition</option> --->
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
                                            <select class="form-control search-box" multiple id="SampleType" name="SampleType">
                                                <!--- <option value="">Select Sample</option> --->
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
                                                <!--- <option value="">Select County</option> --->
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
                                                <!--- <option value="">Select Sample</option> --->
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
                                                <!--- <option value="">Select Body Condition</option> --->
                                                <cfloop from="1" to="#ArrayLen(bodyConditions)#" index="j">
                                                    <option value="#j#">#j&' - '&bodyConditions[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>                                    

                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label class="col-lg-4 col-md-4 col-sm-12 control-label">Lesion Type</label>
                                        <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control customLesionSelect search-box" multiple id="LesionType" name="LesionType" >
                                                <!--- <option value="">Select Lesion Type</option> --->
                                                <cfloop query="getLesionTypeData">
                                                    <cfif Active eq 1>
                                                    <option value="#getLesionTypeData.LesionTypeName#">#getLesionTypeData.LesionTypeName#</option>
                                                        </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
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
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Integument)</label>
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
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Thoracic Cavity)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necmopsyThoracicCavity" id="necmopsyThoracicCavity" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Abdaminal Cavity)</label>
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
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label"> Necropsy (Pulmonary)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necnopsyPulmonary" id="necnopsyPulmonary" <cfif isDefined('form.necnopsyPulmonary') and form.necnopsyPulmonary eq "1">checked="checked"</cfif> value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (lymphoreticular)*</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neenpsylymphoreticulor" id="neenpsylymphoreticulor" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Endocrine)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necropsyEndocrine" id="necropsyEndocrine" <cfif isDefined('form.necropsyEndocrine') and form.necropsyEndocrine eq "1">checked="checked"</cfif> value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label"> Necropsy (Urogenital)</label> 
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necropsyUrogenital" id="necropsyUrogenital" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (Alimentary)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="necropsyAlimentary" id="necropsyAlimentary" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (GI Foreign Material)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="G1ForeignMaterial" id="G1ForeignMaterial" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Necropsy (CENTRAL NERVOUS SYSTEM)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="neonpsyCentraeNenvusSysem" id="neonpsyCentraeNenvusSysem" <cfif isDefined('form.neonpsyCentraeNenvusSysem') and form.neonpsyCentraeNenvusSysem eq "1">checked="checked"</cfif> value="1" style="width: 25px; height: 25px;">
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
        <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge') or (isdefined('FORM.exportAll') and FORM.exportAll eq "1")>
            <!--- <cfdump var="test123" abort="true"> --->
        
        
        <!--- <cfif #qFiltered.CetaceanSpeciesName# neq '' > --->

            <div id="report-results" class="section-container section-with-top-border"> 
                <div class="">
                    <cfif allCountt.recordCount neq 0>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-right" style="position: absolute;
                            right: 12px; width: 10%; z-index: 2;">
                                <button type="button" name="excelExport" value ="Download as Excel" onclick="excel()" class="btn btn-success width-123 m-r-5  ml-auto">Export All</button>
                            </div>
                        </div>
                    </cfif> 

                    <!--- Group results by Fnumber so output shows one row per animal --->
                    <cfif structKeyExists(allCountt, 'recordCount') AND allCountt.recordCount GT 0>
                        <cfset grouped = {}>
                        <cfset groupedNorm = {}>
                        <cfset colList = allCountt.columnList>
                        <cfset allCounttGrouped = QueryNew(colList)>
                        <cfset orderFnumbers = []>
                        <cfloop query="allCountt">
                            <cfset fnum = Trim(Fnumber)>
                            <cfif NOT StructKeyExists(grouped, fnum)>
                                <cfset grouped[fnum] = {}>
                                <cfset groupedNorm[fnum] = {}>
                                <cfloop list="#colList#" index="c">
                                    <cfset grouped[fnum][c] = []>
                                    <cfset groupedNorm[fnum][c] = []>
                                </cfloop>
                                <cfset ArrayAppend(orderFnumbers, fnum)>
                            </cfif>
                            <cfloop list="#colList#" index="c">
                                <cfset curVal = "">
                                <cftry>
                                    <cfset curVal = Trim(Evaluate(c))>
                                <cfcatch>
                                    <cfset curVal = "">
                                </cfcatch>
                                </cftry>
                                <cfif Len(curVal)>
                                    <cfset lcCol = LCase(c)>
                                    <cfset cleanVal = curVal>
                                    <cfif FindNoCase('brief', lcCol) GT 0>
                                       
                                        <cfset cleanVal = reReplaceNoCase(cleanVal, "please\s+send\s+me\s+your[\s\S]*?credentials[\.\s]*", "", "all")>
                                        <cfset cleanVal = reReplaceNoCase(cleanVal, "facebook", "", "all")>
                                        <cfset cleanVal = reReplaceNoCase(cleanVal, "gmail", "", "all")>
                                        <cfset cleanVal = reReplaceNoCase(cleanVal, "social\s*login", "", "all")>
                                        <cfset cleanVal = reReplaceNoCase(cleanVal, "please", "", "all")>
                                        <cfset cleanVal = reReplaceNoCase(cleanVal, "\s{2,}", " ", "all")>
                                        <cfset cleanVal = Trim(cleanVal)>
                                        <cfif Len(cleanVal) EQ 0>
                                            <cfset cleanVal = "[redacted request removed]">
                                        </cfif>
                                    </cfif>
                                    <cfset norm = LCase(Trim(reReplace(cleanVal, "\s+", " ", "all")))>
                                    <cfif NOT ArrayFind(groupedNorm[fnum][c], norm)>
                                        <cfset ArrayAppend(grouped[fnum][c], cleanVal)>
                                        <cfset ArrayAppend(groupedNorm[fnum][c], norm)>
                                    </cfif>
                                </cfif>
                            </cfloop>
                        </cfloop>
                        <cfloop from="1" to="#ArrayLen(orderFnumbers)#" index="ri">
                            <cfset f = orderFnumbers[ri]>
                            <cfset QueryAddRow(allCounttGrouped, 1)>
                            <cfloop list="#colList#" index="c">
                                <cfset cellVal = "">
                                <cfif IsArray(grouped[f][c]) AND ArrayLen(grouped[f][c]) GT 0>
                                    <cfset cellVal = ArrayToList(grouped[f][c], ", ")>
                                </cfif>
                                <cfset QuerySetCell(allCounttGrouped, c, cellVal, allCounttGrouped.recordCount)>
                            </cfloop>
                        </cfloop>
                    <cfelse>
                        <cfset allCounttGrouped = allCountt>
                    </cfif>

                    <cfif allCounttGrouped.recordCount NEQ 0>
                        <cfset activeSortCol = 0>
                        <cfset activeSortDir = "asc">
                        <cfset activeSortName = "Fnumber">

                        <cfif isDefined("form.sort_dir") AND LCase(Trim(form.sort_dir)) EQ "desc">
                            <cfset activeSortDir = "desc">
                        </cfif>
                        <cfif isDefined("form.sort_col") AND isNumeric(form.sort_col)>
                            <cfset activeSortCol = val(form.sort_col)>
                        </cfif>
                        <cfif isDefined("form.sort_name") AND Len(Trim(form.sort_name))>
                            <cfset activeSortName = Trim(form.sort_name)>
                        </cfif>

                        <cfset targetSortCol = "Fnumber">
                        <cfif activeSortCol EQ 1 OR LCase(activeSortName) EQ "date">
                            <cfset targetSortCol = "Date">
                        <cfelseif activeSortCol EQ 2 OR LCase(activeSortName) EQ "sourcetable" OR LCase(activeSortName) EQ "tab name">
                            <cfset targetSortCol = "SourceTable">
                        <cfelse>
                            <cfloop list="#allCounttGrouped.columnList#" index="chkCol">
                                <cfif LCase(chkCol) EQ LCase(activeSortName)>
                                    <cfset targetSortCol = chkCol>
                                    <cfbreak>
                                </cfif>
                            </cfloop>
                        </cfif>
                        <cfset targetSortDir = UCase(activeSortDir)>

                        <cfif allCounttGrouped.recordCount GT 1>
                            <cftry>
                                <cfquery dbtype="query" name="allCounttGroupedSorted">
                                    SELECT *
                                    FROM allCounttGrouped
                                    ORDER BY #targetSortCol# #targetSortDir#
                                </cfquery>
                                <cfset allCounttGrouped = allCounttGroupedSorted>
                                <cfcatch type="any">
                                </cfcatch>
                            </cftry>
                        </cfif>

                        <cfscript>
                            paginate = buildStrandingReportPagination(allCounttGrouped.recordCount, rowsPerPage, currentRecordCount, requestedPage);
                            pg = paginate.pageNumber;
                        </cfscript>
                        <cfset isExport = structKeyExists(form, "exportAll") AND form.exportAll eq "1">
                        <cfset isRawTableExport = isExport AND structKeyExists(form, "exportFormat") AND form.exportFormat eq "raw_table">
                        <cfif isExport>
                            <cfcontent reset="true">
                            <cfif isRawTableExport>
                                <cfcontent type="text/html; charset=utf-8">
                            <cfelse>
                                <cfheader name="Content-Disposition" value="attachment; filename=StrandingNecropsyReport_#DateFormat(Now(), 'yyyy-mm-dd')#.xls">
                                <cfcontent type="application/vnd.ms-excel">
                                <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
                                <head>
                                    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
                                    <!--[if gte mso 9]>
                                    <xml>
                                        <x:ExcelWorkbook>
                                            <x:ExcelWorksheets>
                                                <x:ExcelWorksheet>
                                                    <x:Name>Stranding & Necropsy</x:Name>
                                                    <x:WorksheetOptions>
                                                        <x:DisplayGridlines/>
                                                    </x:WorksheetOptions>
                                                </x:ExcelWorksheet>
                                            </x:ExcelWorksheets>
                                        </x:ExcelWorkbook>
                                    </xml>
                                    <![endif]-->
                                    <style>
                                        br { mso-data-placement: same-cell; }
                                        table { border-collapse: collapse; }
                                        th {
                                            background-color: ##2b3643;
                                            color: ##ffffff;
                                            font-weight: bold;
                                            border: 0.5pt solid ##000000;
                                            text-align: left;
                                            font-family: Calibri, Arial, sans-serif;
                                            font-size: 11pt;
                                            padding: 4px 8px;
                                        }
                                        td {
                                            border: 0.5pt solid ##d3d3d3;
                                            mso-number-format: "\@";
                                            text-align: left;
                                            vertical-align: top;
                                            font-family: Calibri, Arial, sans-serif;
                                            font-size: 11pt;
                                            padding: 4px 8px;
                                        }
                                    </style>
                                </head>
                                <body>
                            </cfif>
                        </cfif>
                        <cfif isExport>
                            <cfset exportStartRow = 1>
                            <cfset exportMaxRows = allCounttGrouped.recordCount>
                        <cfelse>
                            <cfset exportStartRow = paginate.startCount>
                            <cfset exportMaxRows = rowsPerPage>
                        </cfif>
                    <table <cfif NOT isExport>id="allReport" class="table table-bordered table-hover" style="margin-left: initial;"<cfelse>border="1"</cfif>>
                        <thead>
                            <tr class="inverse">
                                <th>Fnumber</th> 
                                <th>Date</th> 
                                <th>Tab Name</th> 
                                <cfif structKeyExists(form, "blueBox") AND form.blueBox eq "1">
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
                                <cfif structKeyExists(form, "PhysicalExamNotes") AND form.PhysicalExamNotes eq "1">
                                    <th>General</th>
                                    <th>SNM</th>
                                    <th>Mentation</th>
                                    <th>Palpation</th>
                                    <th>Proprioception</th>
                                    <th>Reflexes</th>
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
                                <cfif structKeyExists(form, "necmopsyThoracicCavity") AND form.necmopsyThoracicCavity eq "1">
                                    <th>THORACIC CAVITY</th>
                                    <th>Fluid Volume</th>
                                    <th>ml</th>
                                    <th>Fluid</th>
                                    <th>Lining</th>
                                    <th>Comments</th>
                                </cfif>
                                 <cfif structKeyExists(form, "nutntionalConditonExternas") AND form.nutntionalConditonExternas eq "1">
                                    <th>Fat/Blubber Status</th>
                                    <th>Heart</th>
                                    <th>Mesentery</th>
                                    <th>Kidneys</th>
                                    <th>Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "neenpsyAbdaminalCavity") AND form.neenpsyAbdaminalCavity eq "1">
                                    <th>ABDOMINAL CAVITY</th>
                                    <th>Fluid Volume</th>
                                    <th>ml</th>
                                    <th>Fluid</th>
                                    <th>Lining</th>
                                    <th>Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "necropsyHepatobiliany") AND form.necropsyHepatobiliany eq "1">
                                    <th>HEPATOBILIARY SYSTEM</th>
                                    <th>Liver Findings</th>
                                    <th>Biliary Findings</th>
                                    <th>Comments</th>
                                </cfif>
                                 <cfif structKeyExists(form, "necropsyCordiovasculor") AND form.necropsyCordiovasculor eq "1">
                                    <th>CARDIOVASCULAR SYSTEM</th>
                                    <th>Blood in Heart Chambers</th>
                                    <th>Describe</th>
                                    <th>Pericardial Fluid</th>
                                    <th>Overall Findings</th>
                                    <th>Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "necnopsyPulmonary") AND form.necnopsyPulmonary eq "1">
                                    <th>PULMONARY SYSTEM</th>
                                    <th>Foam - Froth in Airway</th>
                                    <th>If Present</th>
                                    <th>Foam Amount</th>
                                    <th>Color of Foam</th>
                                    <th>Sand/Sediment in Airway</th>
                                    <th>Trachea/Bronchi</th>
                                    <th>Lungs Findings</th>
                                    <th>Lungs Float in Formalin</th>
                                    <th>Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "neenpsylymphoreticulor") AND form.neenpsylymphoreticulor eq "1">
                                    <th>LYMPHORETICULAR SYSTEM</th>
                                    <th>Spleen</th>
                                    <th>Spleen Finding</th>
                                    <th>Other</th>
                                    <th>Lymph Node Present</th>
                                    <th>Size Length</th>
                                    <th>Width</th>
                                    <th>Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "necropsyEndocrine") AND form.necropsyEndocrine eq "1">
                                    <th>ENDOCRINE SYSTEM</th>
                                    <th>Adrenal Glands</th>
                                    <th>Left Length</th>
                                    <th>Width</th>
                                    <th>Right Length</th>
                                    <th>Width</th>
                                    <th>Thyroid</th>
                                    <th>Length</th>
                                    <th>Width</th>
                                    <th>Pituitary Gland</th>
                                    <th>Length</th>
                                    <th>Width</th>
                                    <th>Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "neonpsyCentraeNenvusSysem") AND form.neonpsyCentraeNenvusSysem eq "1">
                                    <th>Brain</th>
                                    <th>Brain Findings</th>                                    
                                    <th>Other</th>
                                    <th>Spinal Cord</th>
                                    <th>Spinal Cord Findings</th>
                                    <th>Other</th>
                                    <th>Comments</th>
                                </cfif>

                                <cfif structKeyExists(form, "necropsyUrogenital") AND form.necropsyUrogenital eq "1">
                                    <th>Urogenital</th>
                                    <th>Kidney Left</th>
                                    <th>Kidney Right</th>
                                    <th>Urinary Bladder</th>
                                    <th>Urine Volume</th>
                                    <th>Urogenital Color</th>
                                    <th>Consistency</th>
                                    <th>Abnormalities</th>
                                    <th>Abnormalities Describe</th>
                                    <th>Reproductive Organs</th>
                                    <th>Identified As</th>
                                    <th>Lesions</th>
                                    <th>Gonads Identified</th>
                                    <th>Testes Length LEFT</th>
                                    <th>Testes Length Width</th>
                                    <th>Glands LEFT</th>
                                    <th>Testes Length Right</th>
                                    <th>Testes Width Right</th>
                                    <th>Glands RIGHT</th>
                                    <th>Ovary Length LEFT</th>
                                    <th>Ovary Width LEFT</th>
                                    <th>Follicles Present Left</th>
                                    <th>Ovary Length Right</th>
                                    <th>Ovary Width Right</th>
                                    <th>Follicles Present Right</th>
                                    <th>Urogenital Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "necropsyAlimentary") AND form.necropsyAlimentary eq "1">
                                    <th>Alimentary System</th>
                                    <th>Esophagus</th>
                                    <th>Forestomach</th>
                                    <th>Glandular Stomach</th>
                                    <th>Pylorus</th>
                                    <th>Small Intestine</th>
                                    <th>Colon</th>
                                    <th>Alimentary Comments</th>
                                </cfif>
                                <cfif structKeyExists(form, "G1ForeignMaterial") AND form.G1ForeignMaterial eq "1">
                                    <th>GI Foreign Material Type</th>
                                    <th>Material Lesion Location</th>
                                    <th>Material Collected</th>
                                    <th>Disposition of Material Collected</th>
                                    <th>ParasiteComments</th>
                                </cfif>
                                                
                                
                            </tr>
                        </thead>
                        <tbody>
                            <!--- <cfdump var="#allCountt#" abort="true"> --->
                            <cfoutput query="allCounttGrouped" startRow="#exportStartRow#" maxRows="#exportMaxRows#">
                                <tr>                            
                                    <td>#Fnumber#</td> 
                                    <td>#Date#</td> 
                                    <td>#SourceTable#</td> 
                                    <cfif structKeyExists(form, "blueBox") AND form.blueBox eq "1">
                                        <cfloop list="#blueBoxColumnList#" index="col">
                                            <cfset blueBoxDisplayValue = Evaluate(col)>
                                            <cfset blueBoxLookupKey = LCase(col)>
                                            <cfif StructKeyExists(blueBoxLookupMap, blueBoxLookupKey) AND Len(Trim(blueBoxDisplayValue))>
                                                <cfset blueBoxDisplayItems = []>
                                                <cfloop list="#blueBoxDisplayValue#" index="blueBoxLookupId">
                                                    <cfset blueBoxLookupId = Trim(blueBoxLookupId)>
                                                    <cfif Len(blueBoxLookupId)>
                                                        <cfif StructKeyExists(blueBoxLookupMap[blueBoxLookupKey], blueBoxLookupId)>
                                                            <cfset blueBoxMappedValue = blueBoxLookupMap[blueBoxLookupKey][blueBoxLookupId]>
                                                        <cfelse>
                                                            <cfset blueBoxMappedValue = blueBoxLookupId>
                                                        </cfif>
                                                        <cfif NOT ArrayFind(blueBoxDisplayItems, blueBoxMappedValue)>
                                                            <cfset ArrayAppend(blueBoxDisplayItems, blueBoxMappedValue)>
                                                        </cfif>
                                                    </cfif>
                                                </cfloop>
                                                <cfset blueBoxDisplayValue = ArrayToList(blueBoxDisplayItems, ", ")>
                                            </cfif>
                                            <td>#blueBoxDisplayValue#</td>
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
                                    <cfif structKeyExists(form, "PhysicalExamNotes") AND form.PhysicalExamNotes eq "1">
                                        <td>#General#</td>
                                        <td>#SNM#</td>
                                        <td>#Mentation#</td>
                                        <td>#Palpation#</td>
                                        <td>#Proprioception#</td>
                                        <td>#Reflexes#</td>
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
                                        <td>
                                            <cfif Len(Trim(NxLocation))>
                                               <cfquery name="getlocationName" datasource="#variables.dsn#">
                                                    SELECT * FROM TLU_NxLocation
                                                    WHERE id IN (
                                                        <cfqueryparam value="#NxLocation#" list="true" cfsqltype="cf_sql_integer">
                                                    )
                                                </cfquery>
                                                <cfloop query="getlocationName">
                                                    #Location#<cfif getlocationName.currentRow neq getlocationName.recordCount>, </cfif>
                                                </cfloop>
                                            <cfelse>
                                                &nbsp;
                                            </cfif>
                                        </td>
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
                                     <cfif structKeyExists(form, "necmopsyThoracicCavity") AND form.necmopsyThoracicCavity eq "1">
                                        <td>#THORACIC#</td>
                                        <td>#fluidVolume#</td>
                                        <td>#ml#</td>
                                        <td>#THORACIC_Fluid#</td>
                                        <td>#THORACIC_Lining#</td>                                        
                                        <td>#thoratic_comments#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "nutntionalConditonExternas") AND form.nutntionalConditonExternas eq "1">
                                        <td>#Fat_Blubber#</td>
                                        <td>#heart#</td>
                                        <td>#mesentery#</td>
                                        <td>#kidney#</td>                                        
                                        <td>#internal_comments#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "neenpsyAbdaminalCavity") AND form.neenpsyAbdaminalCavity eq "1">
                                        <td>#ABDOMINAL#</td>
                                        <td>#abdominal_fluidVolume#</td>
                                        <td>#ABDOMINAL_ml#</td>
                                        <td>#ABDOMINAL_Fluid#</td>
                                        <td>#ABDOMINAL_Lining#</td>                                        
                                        <td>#abdominal_comments#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "necropsyHepatobiliany") AND form.necropsyHepatobiliany eq "1">
                                        <td>#HEPATOBILIARY#</td>
                                        <td>
                                            <cfif Len(Trim(Liver_Findings))>
                                                <cfquery name="getliverName" datasource="#variables.dsn#">
                                                    SELECT * FROM TLU_LiverFinding
                                                    WHERE id IN (
                                                        <cfqueryparam value="#Liver_Findings#" list="true" cfsqltype="cf_sql_integer">
                                                    )
                                                </cfquery>
                                                <cfloop query="getliverName">
                                                    #finding#<cfif getliverName.currentRow neq getliverName.recordCount>, </cfif>
                                                </cfloop>
                                            <cfelse>
                                                &nbsp;
                                            </cfif>
                                            <!--- #Liver_Findings# --->
                                        </td>
                                        <td>#Biliary_Findings#</td>                                        
                                        <td>#hepatobiliary_comments#</td>
                                    </cfif>
                                     <cfif structKeyExists(form, "necropsyCordiovasculor") AND form.necropsyCordiovasculor eq "1">
                                        <td>#CARDIOVASCULAR#</td>
                                        <td>#Chambers#</td>
                                        <td>#cardio_describe#</td>
                                        <td>#Pericardial_Fluid#</td>
                                        <td>#Overall_Findings#</td>                                        
                                        <td>#cardio_comments#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "necnopsyPulmonary") AND form.necnopsyPulmonary eq "1">
                                        <td>#PULMONARY#</td>
                                        <td>#Froth_in_Airway#</td>
                                        <td>#If_Present#</td>
                                        <td>#Foam_Amount#</td>
                                        <td>#Color_of_Foam#</td>                                        
                                        <td>#Sand_Sediment#</td>
                                        <td>#Trachea_Bronchi#</td>
                                        <td>
                                            <cfif Len(Trim(Lungs_Findings))>
                                                <cfquery name="getLungsName" datasource="#variables.dsn#">
                                                    SELECT * FROM TLU_LungFinding
                                                    WHERE id IN (
                                                        <cfqueryparam value="#Lungs_Findings#" list="true" cfsqltype="cf_sql_integer">
                                                    )
                                                </cfquery>
                                                <cfloop query="getLungsName">
                                                    #finding#<cfif getLungsName.currentRow neq getLungsName.recordCount>, </cfif>
                                                </cfloop>
                                            <cfelse>
                                                &nbsp;
                                            </cfif>
                                            <!--- #Lungs_Findings# --->
                                        </td>
                                        <td>#Lungs_Float#</td>
                                        <td>#pulmonary_comments#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "neenpsylymphoreticulor") AND form.neenpsylymphoreticulor eq "1">
                                        <td>#LYMPHORETICULAR#</td>
                                        <td>#Spleen#</td>
                                        <td>#Spleen_Findings#</td>
                                        <td>#lympho_other#</td>
                                        <td>#lymphnode#</td>                                        
                                        <td>#nodelength#</td>
                                        <td>#nodewidth#</td>
                                        <td>#lympho_comments#</td>
                                    </cfif>

                                    <cfif structKeyExists(form, "necropsyEndocrine") AND form.necropsyEndocrine eq "1">
                                        <td>#ENDOCRINE#</td>
                                        <td>#Adrenal_Glands#</td>
                                        <td>#adrenal_leftLength#</td>
                                        <td>#adrenal_leftwidth#</td>
                                        <td>#adrenal_rightLength#</td>                                        
                                        <td>#adrenal_rightwidth#</td>
                                        <td>#Thyroid#</td>
                                        <td>#thyroid_length#</td>
                                        <td>#thyroid_width#</td>
                                        <td>#Pituitary_Gland#</td>
                                        <td>#Pituitary_length#</td>
                                        <td>#Pituitary_width#</td>
                                        <td>#endocrine_comments#</td>
                                    </cfif>
                                    <cfif structKeyExists(form, "neonpsyCentraeNenvusSysem") AND form.neonpsyCentraeNenvusSysem eq "1">
                                        <td>#CENTRALbrain#</td>
                                        <td>#CENTRALBrainFindings#</td>
                                        <td>#brainother#</td>
                                        <td>#CENTRALSpinalCord#</td>
                                        <td>#CENTRALSpinalCordfinding#</td>                                        
                                        <td>#spinalother#</td>
                                        <td>#nervoussystemcomments#</td>
                                    </cfif>

                                      <cfif structKeyExists(form, "necropsyUrogenital") AND form.necropsyUrogenital eq "1">
                                        <td>#UROGENITAL#</td>
                                        <td>
                                            <cfif Len(Trim(Kidney_left)) AND ListFind(ArrayToList(Kidneys_Findings,','), Kidney_left) GT 0>
                                                #HTMLEditFormat(Kidney_left)#
                                            <cfelse>
                                                &nbsp;
                                            </cfif>
                                        </td>
                                        <!--- <td>#Kidney_left#</td> --->
                                        <td>
                                            <cfif Len(Trim(Kidney_right)) AND ListFind(ArrayToList(Kidneys_Findings,','), Kidney_right) GT 0>
                                                #HTMLEditFormat(Kidney_right)#
                                            <cfelse>
                                                &nbsp;
                                            </cfif>
                                        </td>
                                        <!--- <td>#Kidney_right#</td> --->
                                        <td>#Urinary_Bladder#</td>
                                        <td>#urin_volume#</td>
                                        <td>#UROGENITAL_color#</td>
                                        <td>#Consistancy#</td>
                                        <td>#Abnormalities#</td>
                                        <td>#Abnormalities_describe#</td>
                                        <td>#Reproductive_Organs#</td>
                                        <td>#Identified_As#</td>
                                        <td>#Lesions#</td>
                                        <td>#Gonads_Identified#</td>
                                        <td>#Testes_Length_LEFT#</td>
                                        <td>#Testes_Length_width#</td>
                                        <td>#Glands_LEFT#</td>
                                        <td>#Testes_Length_right#</td>
                                        <td>#Testes_width_right#</td>
                                        <td>#Glands_RIGHT#</td>
                                        <td>#Ovary_Length_LEFT#</td>
                                        <td>#Ovary_Width_LEFT#</td>
                                        <td>#Follicles_Present_Left#</td>
                                        <td>#Ovary_Length_right#</td>
                                        <td>#Ovary_width_right#</td>
                                        <td>#Follicles_Present_right#</td>
                                        <td>#UROGENITAL_Comments#</td>
                                  </cfif>
                                        <cfif structKeyExists(form, "necropsyAlimentary") AND form.necropsyAlimentary eq "1">
                                            <td>#ALIMENTARYSYSTEM#</td>
                                            <!--- <td>#Esophagus#</td> --->
                                            <td>
                                                <cfset matchedEsophagus = "">
                                                <cfloop from="1" to="#ArrayLen(Alimentary_SystemArray)#" index="j">
                                                    <cfif Len(Trim(Esophagus)) AND ListFind(Esophagus, Alimentary_SystemArray[j])>
                                                        <cfif Len(Trim(matchedEsophagus))>
                                                            <cfset matchedEsophagus = matchedEsophagus & ", " & Alimentary_SystemArray[j]>
                                                        <cfelse>
                                                            <cfset matchedEsophagus = Alimentary_SystemArray[j]>
                                                        </cfif>
                                                    </cfif>
                                                </cfloop>
                                                <cfif Len(Trim(matchedEsophagus))>#HTMLEditFormat(matchedEsophagus)#<cfelse>&nbsp;</cfif>
                                            </td>
                                            <td>
                                                <cfset matchedForestomach = "">
                                                <cfloop from="1" to="#ArrayLen(Alimentary_SystemArray)#" index="j">
                                                    <cfif Len(Trim(Forestomach)) AND ListFind(Forestomach, Alimentary_SystemArray[j])>
                                                        <cfif Len(Trim(matchedForestomach))>
                                                            <cfset matchedForestomach = matchedForestomach & ", " & Alimentary_SystemArray[j]>
                                                        <cfelse>
                                                            <cfset matchedForestomach = Alimentary_SystemArray[j]>
                                                        </cfif>
                                                    </cfif>
                                                </cfloop>
                                                <cfif Len(Trim(matchedForestomach))>#HTMLEditFormat(matchedForestomach)#<cfelse>&nbsp;</cfif>
                                            </td>
                                            <td>
                                                <cfset matchedGlandular = "">
                                                <cfloop from="1" to="#ArrayLen(Alimentary_SystemArray)#" index="j">
                                                    <cfif Len(Trim(glandularStomach)) AND ListFind(glandularStomach, Alimentary_SystemArray[j])>
                                                        <cfif Len(Trim(matchedGlandular))>
                                                            <cfset matchedGlandular = matchedGlandular & ", " & Alimentary_SystemArray[j]>
                                                        <cfelse>
                                                            <cfset matchedGlandular = Alimentary_SystemArray[j]>
                                                        </cfif>
                                                    </cfif>
                                                </cfloop>
                                                <cfif Len(Trim(matchedGlandular))>#HTMLEditFormat(matchedGlandular)#<cfelse>&nbsp;</cfif>
                                            </td>
                                            <td>
                                                <cfset matchedPylorus = "">
                                                <cfloop from="1" to="#ArrayLen(Alimentary_SystemArray)#" index="j">
                                                    <cfif Len(Trim(Pylorus)) AND ListFind(Pylorus, Alimentary_SystemArray[j])>
                                                        <cfif Len(Trim(matchedPylorus))>
                                                            <cfset matchedPylorus = matchedPylorus & ", " & Alimentary_SystemArray[j]>
                                                        <cfelse>
                                                            <cfset matchedPylorus = Alimentary_SystemArray[j]>
                                                        </cfif>
                                                    </cfif>
                                                </cfloop>
                                                <cfif Len(Trim(matchedPylorus))>#HTMLEditFormat(matchedPylorus)#<cfelse>&nbsp;</cfif>
                                            </td>
                                            <td>
                                                <cfset matchedSmallIntestine = "">
                                                <cfloop from="1" to="#ArrayLen(Alimentary_SystemArray)#" index="j">
                                                    <cfif Len(Trim(smallIntestine)) AND ListFind(smallIntestine, Alimentary_SystemArray[j])>
                                                        <cfif Len(Trim(matchedSmallIntestine))>
                                                            <cfset matchedSmallIntestine = matchedSmallIntestine & ", " & Alimentary_SystemArray[j]>
                                                        <cfelse>
                                                            <cfset matchedSmallIntestine = Alimentary_SystemArray[j]>
                                                        </cfif>
                                                    </cfif>
                                                </cfloop>
                                                <cfif Len(Trim(matchedSmallIntestine))>#HTMLEditFormat(matchedSmallIntestine)#<cfelse>&nbsp;</cfif>
                                            </td>
                                            <td>
                                                <cfset matchedColon = "">
                                                <cfloop from="1" to="#ArrayLen(Alimentary_SystemArray)#" index="j">
                                                    <cfif Len(Trim(Colon)) AND ListFind(Colon, Alimentary_SystemArray[j])>
                                                        <cfif Len(Trim(matchedColon))>
                                                            <cfset matchedColon = matchedColon & ", " & Alimentary_SystemArray[j]>
                                                        <cfelse>
                                                            <cfset matchedColon = Alimentary_SystemArray[j]>
                                                        </cfif>
                                                    </cfif>
                                                </cfloop>
                                                <cfif Len(Trim(matchedColon))>#HTMLEditFormat(matchedColon)#<cfelse>&nbsp;</cfif>
                                            </td>
                                            <td>#AlimentarySystemComments#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "G1ForeignMaterial") AND form.G1ForeignMaterial eq "1">
                                            <td>#GIForeignMaterialType#</td>
                                            <td>#MaterialLesionLocation#</td>
                                            <td>#MaterialCollected#</td>
                                            <td>#DispositionofMaterialCollected#</td>
                                            <td>#Parasitecomments#</td>
                                        </cfif>
                                
                                    
                                    
                                </tr>
                            </cfoutput>
                        </tbody>
                    </table>
                    <cfif structKeyExists(form, "exportAll") AND form.exportAll eq "1">
                        <cfif NOT isRawTableExport>
                            </body>
                            </html>
                        </cfif>
                        <cfabort>
                    </cfif>
                    
                    <div class="row">
                        <cfscript>
                            if(not StructIsEmpty(paginate)){
                                writeOutput('<nav aria-label="Page" style="text-align: right;"><ul class="pagination">');
                                if (StructKeyExists(paginate,"previousLink")){
                                    writeOutput('<li class="page-item"><a href="javascript:void(0);" onclick="paginate(#paginate.previousLink#); return false;" data-report-page="#paginate.previousLink#" class="left stranding-report-page-link" style="cursor: pointer;">&laquo; Previous</a></li>');
                                }
                                if (StructKeyExists(paginate,"displayLinks")){
                                    for ( i=1; i<=#ArrayLen(paginate.displayLinks)#;i++){
                                        thePage = paginate.displayLinks[i] ;
                                        if(thePage.isCurrentPage)
                                            writeOutput('<li class="page-item active"><a href="javascript:void(0);" class="pagingNumber" >#thePage.pageNumber# </a></li>');
                                        else
                                            writeOutput('<li class="page-item"><a href="javascript:void(0);" onclick="paginate(#thePage.pageNumber#); return false;" data-report-page="#thePage.pageNumber#" class="pagingNumber stranding-report-page-link" style="cursor: pointer;" title="Go to page #thePage.pageNumber#" value="#thePage.pageNumber#" >#thePage.pageNumber#</a></li>');
                                    }
                                }
                                if(StructKeyExists(paginate,"nextLink")){
                                    writeOutput('<li class="page-item"><a href="javascript:void(0);" onclick="paginate(#paginate.nextLink#); return false;" data-report-page="#paginate.nextLink#" class="left stranding-report-page-link" style="cursor: pointer;">Next &raquo;</a></li>');
                                }
                                writeOutput('</ul></nav>');
                                writeOutput('<p>Displaying #paginate.startCount# - #paginate.nextCount# records from #paginate.totalCount#</p>');
                            }
                        </cfscript>
                    </div>
                <cfelse>
                    <cfif structKeyExists(form, "exportAll") AND form.exportAll eq "1">
                        <cfcontent reset="true">
                        <cfif structKeyExists(form, "exportFormat") AND form.exportFormat eq "raw_table">
                            <cfcontent type="text/html; charset=utf-8">
                            <p>No records found.</p>
                        <cfelse>
                            <cfheader name="Content-Disposition" value="attachment; filename=StrandingNecropsyReport_#DateFormat(Now(), 'yyyy-mm-dd')#.xls">
                            <cfcontent type="application/vnd.ms-excel">
                            <p>No records found.</p>
                        </cfif>
                        <cfabort>
                    </cfif>
                    <div class="alert alert-danger">
                        <strong>Alert!</strong> No record found.
                    </div>
                </cfif>
                </div>
      
            </div>

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

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script>
    try { localStorage.removeItem('stranding_necropsy_report_in_pge'); } catch(e) {}

    function scrollToReportResults(smooth) {
        var $target = $('#report-results');
        if (!$target.length) {
            $target = $('#allReport');
        }
        if (!$target.length) return;

        var headerHeight = $('#header').outerHeight() || 60;
        var targetTop = $target.offset().top - headerHeight - 15;
        if (targetTop < 0) targetTop = 0;

        if (smooth) {
            $('html, body').stop().animate({
                scrollTop: targetTop
            }, 300);
        } else {
            window.scrollTo(0, targetTop);
        }
    }

    function paginate(value){
        var pageNumber = parseInt(value, 10);
        var form = document.getElementById('searchAllReports');
        var pageInput = document.getElementById('pge');

        if (isNaN(pageNumber) || pageNumber < 1 || !form || !pageInput) {
            return false;
        }

        updateSortInputs();
        pageInput.value = pageNumber;
        var isPaginationInput = document.getElementById('is_pagination_click');
        if (isPaginationInput) {
            isPaginationInput.value = '1';
        }

        try {
            sessionStorage.setItem('stranding_report_scroll_to_results', '1');
        } catch(e) {}

        if (typeof saveFormState === 'function') {
            try { saveFormState(); } catch(e) {}
        }

        if (form.action) {
            form.action = form.action.split('#')[0] + '#report-results';
        }

        form.submit();
        return false;
    }

    function updateSortInputs() {
        if (!window.jQuery) return;
        var $ = window.jQuery;
        var $table = $('#allReport');
        if (!$table.length || !$.fn.DataTable || !$.fn.DataTable.isDataTable('#allReport')) return;

        var dt = $table.DataTable();
        var order = dt.order();
        if (order && order.length && order[0].length >= 2) {
            var colIdx = parseInt(order[0][0], 10) || 0;
            var colDir = order[0][1] === 'desc' ? 'desc' : 'asc';
            var $th = $table.find('thead th').eq(colIdx);
            var headerText = $th.text().trim();
            var colName = headerText;
            if (headerText === 'Tab Name') {
                colName = 'SourceTable';
            } else if (headerText === 'Fnumber') {
                colName = 'Fnumber';
            } else if (headerText === 'Date') {
                colName = 'Date';
            }

            $('#sort_col').val(colIdx);
            $('#sort_dir').val(colDir);
            $('#sort_name').val(colName);
        }
    }

    function excel(){
        var $ = window.jQuery;
        var form = document.getElementById('searchAllReports');
        if (!form) return;

        updateSortInputs();

        var $btn = $('button[name="excelExport"]');
        var originalBtnHtml = $btn.length ? $btn.html() : '';
        if ($btn.length) {
            $btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Exporting...');
        }

        function restoreButton() {
            if ($btn.length) {
                $btn.prop('disabled', false).html(originalBtnHtml);
            }
        }

        function doXlsxExport() {
            var $form = $(form);
            var formData = $form.serializeArray();
            formData.push({ name: 'exportAll', value: '1' });
            formData.push({ name: 'exportFormat', value: 'raw_table' });

            var url = form.action ? form.action.split('#')[0] : window.location.href.split('#')[0];

            $.ajax({
                url: url,
                type: 'POST',
                data: $.param(formData),
                dataType: 'html',
                success: function(responseHtml) {
                    try {
                        if (!responseHtml || responseHtml.indexOf('<table') === -1) {
                            alert('No records found to export.');
                            restoreButton();
                            return;
                        }

                        var wb = XLSX.read(responseHtml, { type: 'string', raw: true });
                        if (!wb || !wb.SheetNames || !wb.SheetNames.length) {
                            alert('No records found to export.');
                            restoreButton();
                            return;
                        }

                        var firstSheetName = wb.SheetNames[0];
                        var ws = wb.Sheets[firstSheetName];
                        wb.Sheets['Stranding & Necropsy'] = ws;
                        if (firstSheetName !== 'Stranding & Necropsy') {
                            delete wb.Sheets[firstSheetName];
                        }
                        wb.SheetNames[0] = 'Stranding & Necropsy';

                        if (ws && ws['!ref']) {
                            var range = XLSX.utils.decode_range(ws['!ref']);
                            var colWidths = [];
                            for (var C = range.s.c; C <= range.e.c; ++C) {
                                var maxLen = 10;
                                for (var R = range.s.r; R <= range.e.r; ++R) {
                                    var cell = ws[XLSX.utils.encode_cell({ r: R, c: C })];
                                    if (cell && cell.v !== undefined && cell.v !== null) {
                                        var len = String(cell.v).length;
                                        if (len > maxLen) maxLen = Math.min(len, 50);
                                    }
                                }
                                colWidths.push({ wch: maxLen + 2 });
                            }
                            ws['!cols'] = colWidths;
                        }

                        var today = new Date();
                        var yyyy = today.getFullYear();
                        var mm = String(today.getMonth() + 1);
                        if (mm.length < 2) mm = '0' + mm;
                        var dd = String(today.getDate());
                        if (dd.length < 2) dd = '0' + dd;
                        var fileName = 'StrandingNecropsyReport_' + yyyy + '-' + mm + '-' + dd + '.xlsx';

                        XLSX.writeFile(wb, fileName);
                    } catch(err) {
                        console.error('XLSX export error:', err);
                        fallbackIframeExport();
                    } finally {
                        restoreButton();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Export request failed:', error);
                    fallbackIframeExport();
                    restoreButton();
                }
            });
        }

        if (typeof XLSX !== 'undefined') {
            doXlsxExport();
        } else {
            var script = document.createElement('script');
            script.src = 'https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js';
            script.onload = function() {
                doXlsxExport();
            };
            script.onerror = function() {
                fallbackIframeExport();
                restoreButton();
            };
            document.head.appendChild(script);
        }
    }

    function fallbackIframeExport() {
        var form = document.getElementById('searchAllReports');
        if (!form) return;

        var exportInput = document.getElementById('exportAll');
        if (!exportInput) {
            exportInput = document.createElement('input');
            exportInput.type = 'hidden';
            exportInput.name = 'exportAll';
            exportInput.id = 'exportAll';
            form.appendChild(exportInput);
        }

        var iframe = document.getElementById('export_iframe');
        if (!iframe) {
            iframe = document.createElement('iframe');
            iframe.id = 'export_iframe';
            iframe.name = 'export_iframe';
            iframe.style.display = 'none';
            document.body.appendChild(iframe);
        }

        var originalTarget = form.target || '';
        var originalAction = form.action || '';

        exportInput.value = '1';
        form.target = 'export_iframe';
        form.action = form.action.split('#')[0];

        form.submit();

        setTimeout(function() {
            form.target = originalTarget;
            form.action = originalAction;
            exportInput.value = '0';
        }, 1000);
    }

    function initStrandingInlineScript() {
        var $ = window.jQuery;
        if (!$ || !$.fn) {
            setTimeout(initStrandingInlineScript, 50);
            return;
        }
        $(function() {
            if ($.fn.DataTable && $.fn.DataTable.isDataTable('#allReport')) {
                var dt = $('#allReport').DataTable();
                var initSortCol = parseInt($('#sort_col').val(), 10) || 0;
                var initSortDir = ($('#sort_dir').val() === 'desc') ? 'desc' : 'asc';
                dt.order([[initSortCol, initSortDir]]).draw(false);
                $('#allReport').off('order.dt.exportSync').on('order.dt.exportSync', function() {
                    updateSortInputs();
                });
            }

            var shouldScroll = false;
            try {
                if (sessionStorage.getItem('stranding_report_scroll_to_results') === '1') {
                    shouldScroll = true;
                    sessionStorage.removeItem('stranding_report_scroll_to_results');
                }
            } catch(e) {}

            <cfif isDefined('FORM.pge') AND NOT isDefined('FORM.btnSearchSightings')>
                shouldScroll = true;
            </cfif>
            <cfif isDefined('FORM.is_pagination_click') AND FORM.is_pagination_click EQ "1">
                shouldScroll = true;
            </cfif>

            if (shouldScroll) {
                if ('scrollRestoration' in history) {
                    try { history.scrollRestoration = 'manual'; } catch(e) {}
                }
                scrollToReportResults(false);
                setTimeout(function() {
                    scrollToReportResults(true);
                }, 150);
                setTimeout(function() {
                    scrollToReportResults(false);
                }, 400);
            }
        });
    }

    if (document.readyState === 'complete' || document.readyState === 'interactive') {
        initStrandingInlineScript();
    } else {
        document.addEventListener('DOMContentLoaded', initStrandingInlineScript);
    }
</script>
