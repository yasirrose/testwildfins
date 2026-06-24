<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
    <cftry>

        <cfset variables.dsn = "wildfins_new">
    
        <cfset qgetIncidentReportType = Application.SightingNew.getIncidentReportType()>
        <!--- <cfset qgetIncidentReports = Application.IncidentReport.getIncidentReports()> --->
        <cfset qgetIR_CountyLocation = Application.SightingNew.getIR_CountyLocation()>
        <cfparam name="startHereIndex" default="1">
        <cfparam name="form.searchword" default="">
        <cfparam name="form.date" default="">

        <cfset getSurveyRouteData = Application.StaticDataNew.getSurveyRoute()>
        <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>
        <cfset getPlateForm=Application.StaticDataNew.getPlateForm()>
        <cfset getType=Application.StaticDataNew.getType()>
        <cfset getStock = Application.StaticDataNew.getStock()>
        <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>
        <cfif isdefined('FORM.Cetacean_Species')>
            <cfset getCetaceansCode = Application.SightingNew.getCetaceansCode(#FORM.Cetacean_Species#)>
        </cfif>

        <cfset getBehaviorsData = Application.StaticDataNew.getBehavior()>
        <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>
        <cfset getAreaName =  Application.Sighting.getAreaName()>

        <cfset getWaveHeight = Application.SightingNew.getWaveHeight()>
        <cfset getWeather = Application.SightingNew.getWeather()>
        <cfset getGlare = Application.SightingNew.getGlare()>
        <cfset qGetBeaufort=Application.SightingNew.qGetBeaufort()>
        
        <cfset qGetHeadingData=Application.StaticDataNew.getHeading()>
        <cfset qGetGHeadingData=Application.StaticDataNew.getGHeading()>
        <cfset qGetFHeadingData=Application.StaticDataNew.getFHeading()>

        <cfset getGlareDirection = Application.StaticDataNew.getGlareDirection()>
        <cfset getSightability = Application.SightingNew.getSightability()>
        <cfset getHabitatList = Application.SightingNew.getHabitat()>
        <cfset TideList = Application.SightingNew.getTide()>
        <cfset getPreySpeciesData = Application.StaticDataNew.getPreySpecies()>
        <cfset StructureList = Application.SightingNew.getStructureList()>
        <cfset getTeams=Application.SightingNew.getTeams()>
        <cfset getuserlist=Application.Accounts.getuserlist()>
        <cfset getDscoreCode = Application.Sighting.getDscoreDropdown()>
        <cfset qGetAssocBioData=Application.SightingNew.qGetAssocBioData()>
        <cfset cameralist = Application.SightingNew.getCamera()>
        <cfset lenslist = Application.SightingNew.getLens()>
        
        <cfset getHeadNuchalCrest = Application.ConditionLesions.getHeadNuchalCrest()>
        <cfset getHeadLateralCervicalReg = Application.ConditionLesions.getHeadLateralCervicalReg()>
        <cfset getHeadFacialBones = Application.ConditionLesions.getHeadFacialBones()>
        <cfset getHeadEarOS = Application.ConditionLesions.getHeadEarOS()>
        <cfset getHeadChinSkinFolds = Application.ConditionLesions.getHeadChinSkinFolds()>
        <cfset getBodyEpaxialMuscle = Application.ConditionLesions.getBodyEpaxialMuscle()>
        <cfset getBodyDorsalRidgeScapula = Application.ConditionLesions.getBodyDorsalRidgeScapula()>
        <cfset getBodyRibs = Application.ConditionLesions.getBodyRibs()>
        <cfset getTailTransversePro = Application.ConditionLesions.getTailTransversePro()>
        <cfset getSourceSex = Application.Dolphin.getSourceSex()>
        <cfset getYOBSource=Application.Dolphin.get_YOB_Source()>

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

        <cfquery name="RTmembers" datasource="#variables.dsn#">
            SELECT * from TLU_ResearchTeamMembers
        </cfquery>

        <cfquery name="cetaceans" datasource="#variables.dsn#">
            select ID,Code,Name from Cetaceans order by Code ASC
        </cfquery>

        <cfquery name="users" datasource="#variables.dsn#">
            SELECT * from users
        </cfquery>

        <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')>

            <cftry>
                <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
                <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
                <cfcatch>
                    <cfset form.startDate = "">
                    <cfset form.endDate = "">
                </cfcatch>
            </cftry>

            <cfif NOT isDefined('form.LesionType')>
                <cfset LType = ''>
            <cfelse>
                <cfset LType = listFirst(form.LesionType)>
            </cfif>

            <cfquery datasource="#variables.dsn#" name="allCount"  result="r">
                SELECT COUNT(1) AS TotalRows
                FROM Surveys s
                LEFT JOIN Survey_Sightings ss ON s.ID= ss.Project_ID
                LEFT JOIN Cetacean_Sightings cs ON ss.ID= cs.Sighting_ID
                LEFT JOIN Cetaceans c ON cs.Cetaceans_ID= c.ID
                LEFT JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
                where 1=1
                <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), s.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
                <cfif isdefined("form.surveyRoute") and form.surveyRoute neq ""> and CONCAT(',', s.SurveyRoute, ',') LIKE '%,#form.surveyRoute#,%'</cfif>                
                <cfif isdefined("form.BodyCondition") and form.BodyCondition neq ""> and cs.BodyCondition IN (<cfqueryparam value="#form.BodyCondition#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.bodyOfWater") and form.bodyOfWater neq ""> and s.BodyOfWater IN (<cfqueryparam value="#form.bodyOfWater#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.surveyType")  and form.surveyType  neq ""> and s.SurveyType IN (<cfqueryparam value="#form.surveyType#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.platform") and form.platform neq ""> and s.platform IN (<cfqueryparam value="#form.platform#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.NOAAStock") and form.NOAAStock neq ""> and s.NOAAStock IN (<cfqueryparam value="#form.NOAAStock#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                
                <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies neq ""> and tlu.CetaceanSpeciesName = '#form.cetaceanSpecies#'</cfif>
                <cfif isdefined("form.code")  and form.code neq ""> and c.Code = '#form.code#'</cfif>
                <cfif isdefined("form.surveyEffort") and form.surveyEffort neq ""> and ss.Survey = '#form.surveyEffort#'</cfif>
                <cfif isdefined("form.Dscore") and form.Dscore neq ""> and c.Dscore IN (<cfqueryparam value="#form.Dscore#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Qscore") and form.Qscore neq ""> and cs.Qscore IN (<cfqueryparam value="#form.Qscore#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.SDR")  and form.SDR neq ""> and cs.SDR = '#form.SDR#'</cfif>

                <cfif isdefined("form.pq_focus") and form.pq_focus neq ""> and cs.pq_focus IN (<cfqueryparam value="#form.pq_focus#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.pq_Angle") and form.pq_Angle neq ""> and cs.pq_Angle IN (<cfqueryparam value="#form.pq_Angle#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.pq_Contrast") and form.pq_Contrast neq ""> and cs.pq_Contrast IN (<cfqueryparam value="#form.pq_Contrast#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.pq_Proportion") and form.pq_Proportion neq ""> and cs.pq_Proportion IN (<cfqueryparam value="#form.pq_Proportion#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.pq_Partial") and form.pq_Partial neq ""> and cs.pq_Partial IN (<cfqueryparam value="#form.pq_Partial#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_NuchalCrest") and form.Head_NuchalCrest neq ""> and cs.Head_NuchalCrest IN (<cfqueryparam value="#form.Head_NuchalCrest#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_LateralCervicalReg") and form.Head_LateralCervicalReg neq ""> and cs.Head_LateralCervicalReg IN (<cfqueryparam value="#form.Head_LateralCervicalReg#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_FacialBones") and form.Head_FacialBones neq ""> and cs.Head_FacialBones IN (<cfqueryparam value="#form.Head_FacialBones#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_EarOS") and form.Head_EarOS neq ""> and cs.Head_EarOS IN (<cfqueryparam value="#form.Head_EarOS#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_ChinSkinFolds") and form.Head_ChinSkinFolds neq ""> and cs.Head_ChinSkinFolds IN (<cfqueryparam value="#form.Head_ChinSkinFolds#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Body_EpaxialMuscle") and form.Body_EpaxialMuscle neq ""> and cs.Body_EpaxialMuscle IN (<cfqueryparam value="#form.Body_EpaxialMuscle#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Body_DorsalRidgeScapula") and form.Body_DorsalRidgeScapula neq ""> and cs.Body_DorsalRidgeScapula IN (<cfqueryparam value="#form.Body_DorsalRidgeScapula#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Body_Ribs") and form.Body_Ribs neq ""> and cs.Body_Ribs IN (<cfqueryparam value="#form.Body_Ribs#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Tail_TransversePro") and form.Tail_TransversePro neq ""> and cs.Tail_TransversePro IN (<cfqueryparam value="#form.Tail_TransversePro#" list="true" cfsqltype="cf_sql_varchar">)</cfif>


                AND ss.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
                AND s.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
            </cfquery>

            <cfquery datasource="#variables.dsn#" name="maximumLesions">
                SELECT Sighting_ID,Cetaceans_ID, COUNT(*) AS MaxLesion
                FROM Condition_Lesions b
                GROUP BY b.Sighting_ID,b.Cetaceans_ID
                HAVING count(*) > 1
                ORDER BY MaxLesion desc
            </cfquery>

            <cfscript>
                function buildSightingReportPagination(totalRows, rowsPerPage, currentRecordCount, requestedPage) {
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
                    pg = 1;
                }
                else if(isDefined('form.pge') AND isNumeric(form.pge) AND val(form.pge) GT 0)
                {
                    pg = val(form.pge);
                }
                else
                {
                    pg = 1;
                }
                paginate = buildSightingReportPagination(allCount.TotalRows, rowsPerPage, currentRecordCount, pg);
                pg = paginate.pageNumber;
            </cfscript>




            <cfquery datasource="#variables.dsn#" name="qFiltered">

        
                SELECT
                s.ID AS SurveyID,
                s.DATE,
                s.SurveyRoute,
                s.BodyOfWater,
                s.Platform,
                s.NOAAStock,
                s.SurveyType,
                ss.Survey as SurveyEffort,
                s.EngineOn,
                s.EngineOff,
                s.SurveyStart,
                s.SurveyEnd,
                s.ResearchTeam,
                ss.ID AS sightingID,
                ss.SightingNumber AS sighting_No,
                ss.SightingStart,
                ss.SightingEnd,
                ss.ICW_Start,
                ss.Location,
                ss.InitialLatitude,
                ss.InitialLongitude,
                ss.AtLatitude,
                ss.AtLongitude,
                ss.EndLatitude,
                ss.EndLongitude,
                ss.WaterTemp,
                ss.Comments,
                ss.Weather,
                ss.WaveHeight,
                ss.Glare,
                ss.GlareDirection,
                ss.Sightability,
                ss.Beaufort,
                ss.HabitatDepth,
                ss.AirTemp,
                ss.WindSpeed,
                ss.WindDirection,
                ss.Tide,
                ss.Salinity,
                ss.pH,
                ss.DO,
                ss.EndDepth,
                ss.dissolvedOxygen,
                ss.Conductivity,
                ss.HabitatType,
                ss.BehavioralSpecifics1,
                ss.BehavioralSpecifics2,
                ss.BehavioralSpecifics3,
                ss.BehavioralSpecifics4,
                ss.BehavioralSpecificsN1,
                ss.BehavioralSpecificsN2,
                ss.BehavioralSpecificsN3,
                ss.BehavioralSpecificsN4,
                -- ss.Act_Mill,
                -- ss.Act_Feed,
                -- ss.Act_Prob_Feed,
                -- ss.Act_Travel,
                -- ss.Act_Object_Play,
                -- ss.Act_Rest,
                -- ss.Act_Social,
                -- ss.Act_With_Boat,
                -- ss.Act_Avoid_Boat,
                -- ss.Act_Other,
                ss.FE_TotalCetaceans_Max,
                ss.FE_TotalCetaceans_Min,
                ss.FE_TotalCetacean_Best,
                ss.FE_TotalCetacean_takes,
                ss.FE_TotalCalves_Max,
                ss.FE_TotalCalves_Min,
                ss.FE_TotalCalves_Best,
                ss.FE_TotalCalves_takes,
                ss.FE_YoungOfYear_Min,
                ss.FE_YoungOfYear_Max,
                ss.FE_YoungOfYear_Best,
                ss.FE_YoungOfYear_takes,
                ss.FE_TotalAdults_Min,
                ss.FE_TotalAdults_Max,
                ss.FE_TotalAdults_Best,
                ss.FE_TotalAdults_takes,
                ss.groupeSelect1,
                ss.distanceSelect1,
                ss.groupeSelect2,
                ss.distanceSelect2,
                ss.groupeSelect3,
                ss.distanceSelect3,
                ss.groupeSelect4,
                ss.distanceSelect4,
                ss.PreySpecies,
                ss.Feeding_Lat,
                ss.Feeding_Long,
                ss.Structure_Present,
                ss.Driver,
                ss.Photographer,
                ss.NoOfCetaceansWithIn100mOfActiveFisher,	
                ss.NoOfFishers,
                ss.CetaceanResponsetoFisher1,
                ss.CetaceanResponsetoFisher2,
                ss.CetaceanResponsetoFisher3,
                ss.FisherResponsetoCetacean1,
                ss.FisherResponsetoCetacean2,
                ss.FisherResponsetoCetacean3,
                ss.FisherResponsetoCetacean4,
                ss.CetaceanResponsetoVessel1,
                ss.CetaceanResponsetoVessel2,
                ss.CetaceanResponsetoVessel3,
                ss.VesselResponsetoCetacean1,
                ss.VesselResponsetoCetacean2,
                ss.VesselResponsetoCetacean3,
                ss.VesselResponsetoCetacean4,
                ss.ReactiontoHBOIVessel1,
                ss.ReactiontoHBOIVessel2,
                ss.ReactiontoHBOIVessel3,
                ss.Depredation,
                ss.NoOfCetaceansWithIn100mOfRecreationVessels,
                ss.NumberOfVessels,
                ss.No_of_Cetaceans_wHBOI_Vessel,
                ss.EnteredBy as CompletedBy,
                ss.AssocBio,
                ss.InitialHeading,
                ss.GeneralHeading,
                ss.FinalHeading,
                ss.camera,
                ss.lens,
                ss.StratTimeDive1,
                ss.StratTimeDive2,
                ss.StratTimeDive3,
                ss.StratTimeDive4,
                ss.StratTimeDive5,
                ss.EndTimeDive1,
                ss.EndTimeDive2,
                ss.EndTimeDive3,
                ss.EndTimeDive4,
                ss.EndTimeDive5,
                ss.TotalTimeDive1,
                ss.TotalTimeDive2,
                ss.TotalTimeDive3,
                ss.TotalTimeDive4,
                ss.TotalTimeDive5,
                c.Sex,
                c.code as Code,
                c.name as csname,
                c.DScore,
                c.FB_Number,
                c.SourceSexed,
                c.Lineage,
                c.Mother,
                c.DateOfBirthEstimate,
                c.YearOfBirth,
                c.SourceYOB,
                c.DateDeath,
                c.FirstSightingDate,
                c.PresumedDead,
                c.Dead,
                c.HUBBS_ID,
                c.Field_ID,
                c.HBOCI_CODE,
                cs.Fetals,
                cs.Calf,
                cs.Yoy,                
                cs.wMomDropDown,
                cs.Note,
                cs.pq_focus,
                cs.pq_Angle,
                cs.pq_Contrast,
                cs.pq_Proportion,
                cs.pq_Partial,
                cs.pqSum,
                cs.Qscore,
                cs.bestSighting,
                cs.BestShot,
                cs.EnteredBy,
                cs.PhotoAnalysisInitial,
                cs.PhotoAnalysisFinal,
                cs.bodyCondition,
                cs.Head_NuchalCrest,
                cs.Head_LateralCervicalReg,
                cs.Head_FacialBones,
                cs.Head_EarOS,
                cs.Head_ChinSkinFolds,
                cs.Body_EpaxialMuscle,
                cs.Body_DorsalRidgeScapula,
                cs.Body_Ribs,
                cs.Tail_TransversePro,
                cs.Cetaceans_ID AS Cetaceans_I,
                tlu.CetaceanSpeciesName 
              

                  
                
             FROM
                Surveys s
                LEFT JOIN Survey_Sightings ss ON s.ID= ss.Project_ID
                LEFT JOIN Cetacean_Sightings cs ON ss.ID= cs.Sighting_ID
                LEFT JOIN Cetaceans c ON cs.Cetaceans_ID= c.ID
                LEFT JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies

               
                            
                where 1=1
                <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), s.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
                <cfif isdefined("form.surveyRoute") and form.surveyRoute neq "">
                    and (
                        <cfloop list="#form.surveyRoute#" index="route">
                            CONCAT(',', s.SurveyRoute, ',') LIKE <cfqueryparam value="%,#route#,%" cfsqltype="cf_sql_varchar"> OR
                        </cfloop>
                        1=0
                    )
                </cfif>
                <cfif isdefined("form.BodyCondition") and form.BodyCondition neq ""> and cs.BodyCondition IN (<cfqueryparam value="#form.BodyCondition#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.bodyOfWater") and form.bodyOfWater neq ""> and s.BodyOfWater IN (<cfqueryparam value="#form.bodyOfWater#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.surveyType")  and form.surveyType  neq ""> and s.SurveyType IN (<cfqueryparam value="#form.surveyType#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.platform") and form.platform neq ""> and s.platform IN (<cfqueryparam value="#form.platform#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.NOAAStock") and form.NOAAStock neq ""> and s.NOAAStock IN (<cfqueryparam value="#form.NOAAStock#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.BehavioralSpecifics") and form.BehavioralSpecifics neq "">
                    and (
                            ss.BehavioralSpecifics1 IN (<cfqueryparam value="#form.BehavioralSpecifics#" list="true" cfsqltype="cf_sql_integer">)
                            OR ss.BehavioralSpecifics2 IN (<cfqueryparam value="#form.BehavioralSpecifics#" list="true" cfsqltype="cf_sql_integer">)
                            OR ss.BehavioralSpecifics3 IN (<cfqueryparam value="#form.BehavioralSpecifics#" list="true" cfsqltype="cf_sql_integer">)
                            OR ss.BehavioralSpecifics4 IN (<cfqueryparam value="#form.BehavioralSpecifics#" list="true" cfsqltype="cf_sql_integer">)
                        )
                </cfif>
                <cfif isdefined("form.BehavioralSpecificsNumber") and form.BehavioralSpecificsNumber neq "">
                    and (
                            ss.BehavioralSpecificsN1 = '#form.BehavioralSpecificsNumber#'
                           OR ss.BehavioralSpecificsN2 = '#form.BehavioralSpecificsNumber#'
                           OR ss.BehavioralSpecificsN3 = '#form.BehavioralSpecificsNumber#'
                           OR ss.BehavioralSpecificsN4 = '#form.BehavioralSpecificsNumber#'
                        )
                </cfif>

                <cfif isdefined("form.searchActivity") and form.searchActivity neq "" and isdefined("form.searchActivityNumber") and form.searchActivityNumber neq "">
                    and (
                        <cfloop list="#form.searchActivity#" index="activity">
                            ss.#activity# IN (<cfqueryparam value="#form.searchActivityNumber#" list="true" cfsqltype="cf_sql_integer">) OR
                        </cfloop>
                        1=0
                    )
                </cfif>
                <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies neq ""> and tlu.CetaceanSpeciesName = '#form.cetaceanSpecies#'</cfif>
                <cfif isdefined("form.code")  and form.code neq ""> and c.Code = '#form.code#'</cfif>
                <cfif isdefined("form.surveyEffort") and form.surveyEffort neq ""> and ss.Survey = '#form.surveyEffort#'</cfif>
                <cfif isdefined("form.Dscore") and form.Dscore neq ""> and c.Dscore IN (<cfqueryparam value="#form.Dscore#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Qscore") and form.Qscore neq ""> and cs.Qscore IN (<cfqueryparam value="#form.Qscore#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.SDR")  and form.SDR neq ""> and cs.SDR = '#form.SDR#'</cfif>

                <cfif isdefined("form.pq_focus") and form.pq_focus neq ""> and cs.pq_focus IN (<cfqueryparam value="#form.pq_focus#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.pq_Angle") and form.pq_Angle neq ""> and cs.pq_Angle IN (<cfqueryparam value="#form.pq_Angle#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.pq_Contrast") and form.pq_Contrast neq ""> and cs.pq_Contrast IN (<cfqueryparam value="#form.pq_Contrast#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.pq_Proportion") and form.pq_Proportion neq ""> and cs.pq_Proportion IN (<cfqueryparam value="#form.pq_Proportion#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.pq_Partial") and form.pq_Partial neq ""> and cs.pq_Partial IN (<cfqueryparam value="#form.pq_Partial#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_NuchalCrest") and form.Head_NuchalCrest neq ""> and cs.Head_NuchalCrest IN (<cfqueryparam value="#form.Head_NuchalCrest#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_LateralCervicalReg") and form.Head_LateralCervicalReg neq ""> and cs.Head_LateralCervicalReg IN (<cfqueryparam value="#form.Head_LateralCervicalReg#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_FacialBones") and form.Head_FacialBones neq ""> and cs.Head_FacialBones IN (<cfqueryparam value="#form.Head_FacialBones#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_EarOS") and form.Head_EarOS neq ""> and cs.Head_EarOS IN (<cfqueryparam value="#form.Head_EarOS#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Head_ChinSkinFolds") and form.Head_ChinSkinFolds neq ""> and cs.Head_ChinSkinFolds IN (<cfqueryparam value="#form.Head_ChinSkinFolds#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Body_EpaxialMuscle") and form.Body_EpaxialMuscle neq ""> and cs.Body_EpaxialMuscle IN (<cfqueryparam value="#form.Body_EpaxialMuscle#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Body_DorsalRidgeScapula") and form.Body_DorsalRidgeScapula neq ""> and cs.Body_DorsalRidgeScapula IN (<cfqueryparam value="#form.Body_DorsalRidgeScapula#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Body_Ribs") and form.Body_Ribs neq ""> and cs.Body_Ribs IN (<cfqueryparam value="#form.Body_Ribs#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.Tail_TransversePro") and form.Tail_TransversePro neq ""> and cs.Tail_TransversePro IN (<cfqueryparam value="#form.Tail_TransversePro#" list="true" cfsqltype="cf_sql_varchar">)</cfif>



                AND s.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value="1">
                
                
                
                ORDER BY s.Date DESC, s.ID DESC, ss.ID DESC
                
                
            </cfquery>

            

            <cfset rr = 0>
            <!--- loop for adding columns in main query --->
            <cfif qFiltered.recordCount NEQ 0>
                <cfloop index="index" from="1" to="#maximumLesions.MaxLesion#">
                    <cfset rr = incrementValue(#rr#)> 
                    <cfset lp =  "LesionPresent" & #rr#>
                    <cfset tn =  "TypeName" & #rr#>
                    <cfset lete =  "LesionType" & #rr#>
                    <cfset re =  "Region" & #rr#>
                    <cfset slr =  "Side_L_R" & #rr#>
                    <cfset st =  "Status" & #rr#>
                    <cfset lc =  "Comments" & #rr#>
                    <cfset lpn =  "PhotoNumber" & #rr#>
                    <cfset QueryAddColumn(qFiltered, "#lp#","varchar",[""])>
                    <cfset QueryAddColumn(qFiltered, "#tn#","varchar",[""])>
                    <cfset QueryAddColumn(qFiltered, "#lete#","varchar",[""])>
                    <cfset QueryAddColumn(qFiltered, "#re#","varchar",[""])>
                    <cfset QueryAddColumn(qFiltered, "#slr#","varchar",[""])>
                    <cfset QueryAddColumn(qFiltered, "#st#","varchar",[""])>
                    <cfset QueryAddColumn(qFiltered, "#lc#","varchar",[""])>
                    <cfset QueryAddColumn(qFiltered, "#lpn#","varchar",[""])>
                </cfloop>
            </cfif>
            

            <cfif qFiltered.recordCount NEQ 0 AND maximumLesions.recordCount NEQ 0>
                <cfset lesionReportRows = structNew()>
                <cfset lesionSightingIdMap = structNew()>
                <cfset lesionCetaceanCodeMap = structNew()>
                <cfset lesionSightingIds = "">
                <cfset lesionCetaceanCodes = "">

                <cfloop query="qFiltered">
                    <cfif sightingID neq "" and Code neq "">
                        <cfset lesionRowKey = "#sightingID#|#Code#">
                        <cfif NOT structKeyExists(lesionReportRows, lesionRowKey)>
                            <cfset lesionReportRows[lesionRowKey] = []>
                        </cfif>
                        <cfset ArrayAppend(lesionReportRows[lesionRowKey], qFiltered.currentRow)>

                        <cfif NOT structKeyExists(lesionSightingIdMap, "#sightingID#")>
                            <cfset lesionSightingIdMap["#sightingID#"] = true>
                            <cfset lesionSightingIds = listAppend(lesionSightingIds, sightingID)>
                        </cfif>

                        <cfif NOT structKeyExists(lesionCetaceanCodeMap, "#Code#")>
                            <cfset lesionCetaceanCodeMap["#Code#"] = true>
                            <cfset lesionCetaceanCodes = listAppend(lesionCetaceanCodes, Code)>
                        </cfif>
                    </cfif>
                </cfloop>

                <cfset lesionParamCount = listLen(lesionSightingIds) + listLen(lesionCetaceanCodes)>
                <cfset regionNameCache = structNew()>

                <cfif len(lesionSightingIds) AND len(lesionCetaceanCodes) AND lesionParamCount LTE 1900>
                    <cfquery datasource="#variables.dsn#" name="qReportLesions">
                        SELECT
                            SurveyID,
                            SightingNumber,
                            Sighting_ID,
                            Cetaceans_ID,
                            LesionPresent,
                            LesionType,
                            Region,
                            Side_L_R,
                            Status,
                            PhotoNumber,
                            ID,
                            Comments,
                            TypeName
                        FROM Condition_Lesions cl
                        WHERE cl.Sighting_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#lesionSightingIds#">)
                            AND cl.Cetaceans_ID IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#lesionCetaceanCodes#">)
                            <cfif isDefined('form.typeName') and form.TypeName NEQ ''>
                                AND cl.TypeName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TypeName#">
                            </cfif>
                        ORDER BY cl.Sighting_ID, cl.Cetaceans_ID, cl.ID
                    </cfquery>

                    <cfset lesionIndexByRow = structNew()>

                    <cfloop query="qReportLesions">
                        <cfset lesionRowKey = "#Sighting_ID#|#Cetaceans_ID#">
                        <cfif structKeyExists(lesionReportRows, lesionRowKey)>
                            <cfif NOT structKeyExists(lesionIndexByRow, lesionRowKey)>
                                <cfset lesionIndexByRow[lesionRowKey] = 1>
                            <cfelse>
                                <cfset lesionIndexByRow[lesionRowKey] = lesionIndexByRow[lesionRowKey] + 1>
                            </cfif>

                            <cfset cne = lesionIndexByRow[lesionRowKey]>
                            <cfset lp =  "LesionPresent" & #cne#>
                            <cfset tn =  "TypeName" & #cne#>
                            <cfset lete =  "LesionType" & #cne#>
                            <cfset re =  "Region" & #cne#>
                            <cfset slr =  "Side_L_R" & #cne#>
                            <cfset st =  "Status" & #cne#>
                            <cfset pn =  "PhotoNumber" & #cne#>
                            <cfset cn =  "Comments" & #cne#>

                            <cfif listFindNoCase(qFiltered.columnList, lp)>
                                <cfset regionN = "">
                                <cfif Region NEQ "">
                                    <cfset regionCacheKey = trim(Region)>
                                    <cfif NOT structKeyExists(regionNameCache, regionCacheKey)>
                                        <cfset regionNameCache[regionCacheKey] = Application.Cetaceans.getRegionNamebyId(regionCacheKey)>
                                    </cfif>
                                    <cfset regionN = regionNameCache[regionCacheKey]>
                                </cfif>

                                <cfloop array="#lesionReportRows[lesionRowKey]#" index="lesionReportRow">
                                    <cfset QuerySetCell(qFiltered, "#lp#", #LesionPresent#, lesionReportRow)>
                                    <cfset QuerySetCell(qFiltered, "#tn#", #TypeName#, lesionReportRow)>
                                    <cfset QuerySetCell(qFiltered, "#lete#", #LesionType#, lesionReportRow)>
                                    <cfset QuerySetCell(qFiltered, "#slr#", #Side_L_R#, lesionReportRow)>
                                    <cfset QuerySetCell(qFiltered, "#st#", #Status#, lesionReportRow)>
                                    <cfset QuerySetCell(qFiltered, "#pn#", #PhotoNumber#, lesionReportRow)>
                                    <cfset QuerySetCell(qFiltered, "#cn#", #Comments#, lesionReportRow)>
                                    <cfif regionN NEQ "">
                                        <cfset QuerySetCell(qFiltered, "#re#", #regionN#, lesionReportRow)>
                                    </cfif>
                                </cfloop>
                            </cfif>
                        </cfif>
                    </cfloop>
                <cfelseif len(lesionSightingIds) AND len(lesionCetaceanCodes)>
                    <cfloop query="qFiltered" >
                        <cfif sightingID neq "" and Code neq ""  >
                            <cfquery datasource="#variables.dsn#" name="cldd">
                                SELECT
                                    SurveyID,
                                    SightingNumber,
                                    Sighting_ID,
                                    Cetaceans_ID,
                                    LesionPresent,
                                    LesionType,
                                    Region,
                                    Side_L_R,
                                    Status,
                                    PhotoNumber,
                                    ID,
                                    Comments,
                                    TypeName
                                FROM Condition_Lesions cl
                                WHERE cl.Sighting_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#sightingID#">
                                    AND cl.Cetaceans_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Code#">
                                    <cfif isDefined('form.typeName') and form.TypeName NEQ ''>
                                        AND cl.TypeName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TypeName#">
                                    </cfif>
                            </cfquery>

                            <cfif cldd.RECORDCOUNT gte 1>
                                <cfset cne = 0>

                                <cfloop query="cldd">
                                    <cfset cne = incrementValue(#cne#)>
                                    <cfset lp =  "LesionPresent" & #cne#>
                                    <cfset tn =  "TypeName" & #cne#>
                                    <cfset lete =  "LesionType" & #cne#>
                                    <cfset re =  "Region" & #cne#>
                                    <cfset slr =  "Side_L_R" & #cne#>
                                    <cfset st =  "Status" & #cne#>
                                    <cfset pn =  "PhotoNumber" & #cne#>
                                    <cfset cn =  "Comments" & #cne#>
                                    <cfset QuerySetCell(qFiltered, "#lp#", #LesionPresent#, qFiltered.currentRow)>
                                    <cfset QuerySetCell(qFiltered, "#tn#", #TypeName#, qFiltered.currentRow)>
                                    <cfset QuerySetCell(qFiltered, "#lete#", #LesionType#, qFiltered.currentRow)>
                                    <cfset QuerySetCell(qFiltered, "#slr#", #Side_L_R#, qFiltered.currentRow)>
                                    <cfset QuerySetCell(qFiltered, "#st#", #Status#, qFiltered.currentRow)>
                                    <cfset QuerySetCell(qFiltered, "#pn#", #PhotoNumber#, qFiltered.currentRow)>
                                    <cfset QuerySetCell(qFiltered, "#cn#", #Comments#, qFiltered.currentRow)>
                                    <cfif Region NEQ "">
                                        <cfset regionCacheKey = trim(Region)>
                                        <cfif NOT structKeyExists(regionNameCache, regionCacheKey)>
                                            <cfset regionNameCache[regionCacheKey] = Application.Cetaceans.getRegionNamebyId(regionCacheKey)>
                                        </cfif>
                                        <cfset QuerySetCell(qFiltered, "#re#", #regionNameCache[regionCacheKey]#, qFiltered.currentRow)>
                                    </cfif>
                                </cfloop>
                            </cfif>
                        </cfif>
                    </cfloop>
                </cfif>
            </cfif>



        </cfif>

        
        <!--- <cfdump var="#qFiltered#" abort="true"> --->

       
    
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Home</a></li>
                <li><a href="javascript:;">Sighting Report List</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Sighting Report List </h1>
            <div class="form-group">
                <div class="alert message" style="display:none"></div>
            </div>
            <!-- end page-header -->
            <!-- begin section-container -->
            <div class="section-container section-with-top-border">
            <!-- begin panel -->
                <div class="row">
                    <cfoutput>
                        <form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="searchAllReports" id="searchAllReports" method="post">
                            <input type="hidden" name="pge" id="pge" value="<cfif isDefined('pg')>#pg#<cfelseif isDefined('form.pge')>#form.pge#<cfelse>1</cfif>">
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label top-fld">Date Range</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <div id="Date-range" class="input-group">
                                            <input type="text"  class="form-control" value="<cfif  isDefined('form.date')>#form.date#</cfif>" name="date" id="date" placeholder="Select Date Range" >
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-primary"onclick="showdate()"><i class="fa fa-calendar"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld" >Body of Water</label>
                                    <div class="col-sm-8">
                                       <select class="combobox form-control search-box" multiple="multiple" name="BodyOfWater" id="BodyOfWater">
                                            <cfloop query="getSurveyAreaData">
                                                <!--- <cfif active eq 1> --->
                                                    <option value="#getSurveyAreaData.ID#" <cfif isdefined("form.BodyOfWater") and listFind(form.BodyOfWater, getSurveyAreaData.ID)>selected</cfif>>#getSurveyAreaData.AreaName#</option>
                                                <!--- </cfif> --->
                                            </cfloop>

                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Survey Route:</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="SurveyRoute">
                                            <cfloop query="getSurveyRouteData">
                                                <option value="#getSurveyRouteData.ID#" <cfif isdefined("form.SurveyRoute") and listFind(form.SurveyRoute, getSurveyRouteData.ID)>selected</cfif>>#getSurveyRouteData.RouteName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>                                
                            </div>
                          
                            <div class="form-row">

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Plateform :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Platform" id="plateform_value">
                                            <option value="">Select Platform</option>
                                            <cfloop query="getPlateForm">
                                                <option class="plateform_value" value="#getPlateForm.Name#" <cfif isdefined("form.Platform") and listFind(form.Platform, getPlateForm.Name)>selected</cfif>>#getPlateForm.Name#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Survey Type :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="SurveyType" id="Type" >
                                            <option value="">Select Survey Type</option>
                                            <cfloop query="getType">
                                                <option class="area_value" value="#getType.Type#" <cfif isdefined("form.SurveyType") and listFind(form.SurveyType, getType.Type)>selected</cfif>>#getType.Type#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">NOAAStock :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" name="NOAAStock" id="stock_value" multiple="multiple">
                                            <cfloop query="getStock">
                                                <option class="stock_value" value="#getStock.ID#" <cfif isdefined("form.NOAAStock") and listFind(form.NOAAStock, getStock.ID)>selected</cfif>>#getStock.StockName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Species :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="cetaceanSpecies"  onchange="getcode()" >
                                            <option value="">Select Species</option>
                                            <cfloop query="#qgetCetaceanSpecies#">
                                                <option value="#CetaceanSpeciesName#"  <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies eq qgetCetaceanSpecies.CetaceanSpeciesName>selected</cfif> >#CetaceanSpeciesName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Code :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="code" >
                                            <option value="">Select Code</option>
                                            <cfif isdefined('form.cetaceanSpecies') and form.cetaceanSpecies neq ''>
                                                <cfloop query="#cetaceans#">
                                                    <option value="#Code#" <cfif isdefined("form.code") and form.code eq cetaceans.code>selected</cfif> >#Code#</option>
                                                </cfloop>
                                            </cfif>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Activity :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="searchActivity" id="searchActivity" >
                                            <option value="">Select Survey Type</option>
                                            <option value="Act_Mill" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Mill")>selected</cfif>>Mill</option>
                                            <option value="Act_Feed" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Feed")>selected</cfif>>Feed</option>
                                            <option value="Act_Prob_Feed" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Prob_Feed")>selected</cfif>>Prob Feed</option>
                                            <option value="Act_Travel" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Travel")>selected</cfif>>Travel</option>
                                            <option value="Act_Object_Play" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Object_Play")>selected</cfif>>Object Play</option>
                                            <option value="Act_Rest" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Rest")>selected</cfif>>Rest</option>
                                            <option value="Act_Social" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Social")>selected</cfif>>Social</option>
                                            <option value="Act_With_Boat" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_With_Boat")>selected</cfif>>w/boat</option>
                                            <option value="Act_Avoid_Boat" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Avoid_Boat")>selected</cfif>>Avoid Boat</option>
                                            <option value="Act_Other" <cfif isdefined("form.searchActivity") and listFind(form.searchActivity, "Act_Other")>selected</cfif>>Other</option>

                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Activity number :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="searchActivityNumber" id="searchActivityNumber" >
                                            <option value="">Select Survey Type</option>
                                            <option value="0" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "0")>selected</cfif>>0</option>
                                            <option value="1" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "1")>selected</cfif>>1</option>
                                            <option value="2" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "2")>selected</cfif>>2</option>
                                            <option value="3" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "3")>selected</cfif>>3</option>
                                            <option value="4" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "4")>selected</cfif>>4</option>
                                            <option value="5" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "5")>selected</cfif>>5</option>
                                            <option value="6" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "6")>selected</cfif>>6</option>
                                            <option value="7" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "7")>selected</cfif>>7</option>
                                            <option value="8" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "8")>selected</cfif>>8</option>
                                            <option value="9" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "9")>selected</cfif>>9</option>
                                            <option value="10" <cfif isdefined("form.searchActivityNumber") and listFind(form.searchActivityNumber, "10")>selected</cfif>>10</option>

                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Behavioral Event :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" id="value" name="BehavioralSpecifics" multiple="multiple">
                                            <option value="0">Select </option>
                                            <cfloop query="getBehaviorsData">
                                                <option value="#getBehaviorsData.ID#" <cfif isdefined("form.BehavioralSpecifics") and listFind(form.BehavioralSpecifics, getBehaviorsData.ID)>selected</cfif>>#getBehaviorsData.BehaviorName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Behavioral Event Number :</label>
                                    <div class="col-sm-8">
                                        <input type="number" min="0" id="BehavioralSpecificsNumber"  name="BehavioralSpecificsNumber" class="form-control">
                                    </div>
                                </div>
                            </div>    
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Body Condition :</label>
                                    <div class="col-sm-8">
                                         <select class="form-control search-box" id="BodyCondition" name="BodyCondition" multiple="multiple">
                                            <option value="">Select Body Condition</option>
                                            <option value="1" <cfif isdefined("form.BodyCondition") and listFind(form.BodyCondition, "1")>selected</cfif>>1-Emaciated</option>
                                            <option value="2" <cfif isdefined("form.BodyCondition") and listFind(form.BodyCondition, "2")>selected</cfif>>2-Underweight/Thin</option>
                                            <option value="3" <cfif isdefined("form.BodyCondition") and listFind(form.BodyCondition, "3")>selected</cfif>>3-Ideal</option>
                                            <option value="4" <cfif isdefined("form.BodyCondition") and listFind(form.BodyCondition, "4")>selected</cfif>>4-Overweight</option>
                                            <option value="5" <cfif isdefined("form.BodyCondition") and listFind(form.BodyCondition, "5")>selected</cfif>>5-Obese</option>
                                            <option value="6" <cfif isdefined("form.BodyCondition") and listFind(form.BodyCondition, "6")>selected</cfif>>6-CBD</option>

                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Survey Effort :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="surveyEffort" id="surveyEffort">
                                            <option value="">Select Survey Effort</option>
                                            <option value="on" <cfif isdefined("form.surveyEffort") and form.surveyEffort eq 'on'>selected</cfif> >ON</option>
                                            <option value="off" <cfif isdefined("form.surveyEffort") and form.surveyEffort eq 'off'>selected</cfif> >OFF</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Dscore :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="DScore" id="DScore">
                                            <option value="">Select Lesion</option>
                                            <cfloop query="getDscoreCode">
                                                <option  value="#getDscoreCode.Dscore#" <cfif isdefined("form.DScore") and listFind(form.DScore, getDscoreCode.DScore)>selected</cfif> >#getDscoreCode.Dscore#</option>       
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>    

                            <div class="form-row">

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Qscore :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Qscore" id="Qscore">
                                            <option value="Q-1" <cfif isDefined("form.Qscore") and listFind(form.Qscore, "Q-1")>selected</cfif>>Q-1</option>
                                            <option value="Q-2" <cfif isDefined("form.Qscore") and listFind(form.Qscore, "Q-2")>selected</cfif>>Q-2</option>
                                            <option value="Q-3" <cfif isDefined("form.Qscore") and listFind(form.Qscore, "Q-3")>selected</cfif>>Q-3</option>
                                            
                                        </select>
                                    </div>
                                </div>

                                <!--- <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Lesion :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="LesionType" id="LesionType">
                                            <option value="">Select Lesion</option>
                                            <cfloop query="getLesionTypeData">
                                                <option  value="#getLesionTypeData.LesionTypeName#" <cfif isdefined("form.LesionType") and listFind(form.LesionType, getLesionTypeData.LesionTypeName)>selected</cfif> >#getLesionTypeData.LesionTypeName#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div> --->

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Type Name:</label>
                                    <div class="col-sm-8">
                                        <select class="form-control  " id="TypeName" name="TypeName" onchange="updateLesionScarValues()">
                                            <option value="" >Select Type</option>
                                            <option value="Lesion_Type" <cfif isDefined('form.typeName') and form.TypeName EQ 'Lesion_Type' >selected</cfif> >Lesion Type</option>
                                            <option value="Scar_Type" <cfif isDefined('form.typeName') and form.TypeName EQ 'Scar_Type' >selected</cfif>>Scar Type</option>
                                        </select>                                        
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Select Lesion :</label>
                                    <div class="col-sm-8">

                                        <cfif not structKeyExists(FORM, 'LesionType')>
                                            <cfset FORM.LesionType = "">
                                        </cfif>
                                        
                                        <select class="form-control search-box customLesionSelect" id="LesionType" name="LesionType" multiple>
                                            
                                            <cfif isDefined('FORM.TypeName') and FORM.TypeName EQ 'Lesion_Type'>
                                                <cfloop array="#lesionTypeData#" index="lesion">
                                                    <option value="#lesion.Name#" <cfif structKeyExists(FORM, 'LesionType') and listFindNoCase(FORM.LesionType, lesion.Name)>selected</cfif>>#lesion.Name#</option>
                                                </cfloop>
                                            </cfif>
                                            
                                            <cfif isDefined('FORM.TypeName') and FORM.TypeName EQ 'Scar_Type'>
                                                <cfloop array="#scarTypeData#" index="scar">
                                                    <option value="#scar.Name#" <cfif structKeyExists(FORM, 'LesionType') and listFindNoCase(FORM.LesionType, scar.Name)>selected</cfif>>#scar.Name#</option>
                                                </cfloop>
                                            </cfif>
                                            
                                        </select>
                                        
                                    </div>
                                </div>

                                <script>
                                    // Preload data as JavaScript objects
                                    const lesionTypeData = [
                                        <cfloop array="#lesionTypeData#" index="lesion">
                                            { id: "#lesion.ID#", name: "#lesion.Name#", active: #lesion.Active# },
                                        </cfloop>
                                    ];

                                    const scarTypeData = [
                                        <cfloop array="#scarTypeData#" index="scar">
                                            { id: "#scar.ID#", name: "#scar.Name#", active: #scar.Active# },
                                        </cfloop>
                                    ];

                                    // Function to update the second dropdown
                                    function updateLesionScarValues() {
                                        const selectedType = document.getElementById("TypeName").value;
                                        const secondDropdown = document.getElementById("LesionType");

                                        // Clear existing options
                                        secondDropdown.innerHTML = '';


                                        let data = [];
                                        if (selectedType === "Lesion_Type") {
                                            data = lesionTypeData.filter(item => item.active === 1);
                                        } else if (selectedType === "Scar_Type") {
                                            data = scarTypeData.filter(item => item.active === 1);
                                        }

                                        // Populate new options
                                        data.forEach(item => {
                                            const option = document.createElement("option");
                                            option.value = item.name;
                                            option.textContent = item.name;

                                            // Set selected if the value matches form values
                                            if (formSelectedValues.includes(item.name)) {
                                                option.selected = true;
                                            }

                                            secondDropdown.appendChild(option);
                                        });

                                        if (window.jQuery) {
                                            jQuery(secondDropdown).trigger('change.select2');
                                        }
                                    }

                                    // Set selected values on page load (after submission)
                                    document.addEventListener('DOMContentLoaded', function () {
                                        const selectedType = document.getElementById("TypeName").value;

                                        if (selectedType) {
                                            updateLesionScarValues();
                                        }
                                    });

                                    // Pre-fill selected values
                                    const formSelectedValues = <cfoutput>#serializeJSON(listToArray(form.LesionType))#</cfoutput>;
                                </script>                                
                                                                
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">PQ F :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="pq_focus"         id="pq_focus">
                                            <option value="2" <cfif isDefined("form.pq_focus") and listFind(form.pq_focus, "2")>selected</cfif>>2</option>
                                            <option value="4" <cfif isDefined("form.pq_focus") and listFind(form.pq_focus, "4")>selected</cfif>>4</option>
                                            <option value="9" <cfif isDefined("form.pq_focus") and listFind(form.pq_focus, "9")>selected</cfif>>9</option>
                                            
                                        </select>
                                        
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">PQ A :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="pq_Angle" id="pq_Angle">
                                            <option value="1" <cfif isDefined("form.pq_Angle") and listFind(form.pq_Angle, "1")>selected</cfif>>1</option>
                                            <option value="2" <cfif isDefined("form.pq_Angle") and listFind(form.pq_Angle, "2")>selected</cfif>>2</option>
                                            <option value="8" <cfif isDefined("form.pq_Angle") and listFind(form.pq_Angle, "8")>selected</cfif>>8</option>
                                            
                                        </select>
                                        
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">PQ C :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="pq_Contrast" id="pq_Contrast">
                                            <option value="1" <cfif isDefined("form.pq_Contrast") and listFind(form.pq_Contrast, "1")>selected</cfif>>1</option>
                                            <option value="3" <cfif isDefined("form.pq_Contrast") and listFind(form.pq_Contrast, "3")>selected</cfif>>3</option>                                            
                                        </select>
                                        
                                    </div>
                                </div>
                                                                
                            </div>
                            <div class="form-row">
                                
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">PQ Pro :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="pq_Proportion" id="pq_Proportion">
                                            <option value="1" <cfif isDefined("form.pq_Proportion") and listFind(form.pq_Proportion, "1")>selected</cfif>>1</option>
                                            <option value="5" <cfif isDefined("form.pq_Proportion") and listFind(form.pq_Proportion, "5")>selected</cfif>>5</option>                                            
                                        </select>
                                        
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">PQ Par :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="pq_Partial" id="pq_Partial">
                                            <option value="1" <cfif isDefined("form.pq_Partial") and listFind(form.pq_Partial, "1")>selected</cfif>>1</option>
                                            <option value="8" <cfif isDefined("form.pq_Partial") and listFind(form.pq_Partial, "8")>selected</cfif>>8</option>                                            
                                        </select>
                                        
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Nuchal Crest :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Head_NuchalCrest" id="Head_NuchalCrest">
                                            <option value="">Select Nuchal Crest</option>
                                            <cfloop query="getHeadNuchalCrest">
                                                <option  value="#getHeadNuchalCrest.ID#" <cfif isdefined("form.Head_NuchalCrest") and listFind(form.Head_NuchalCrest, getHeadNuchalCrest.ID)>selected</cfif> >#getHeadNuchalCrest.HNC_Name#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>
                                                                
                            </div>
                            <div class="form-row">

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Lateral Cervical Region :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Head_LateralCervicalReg" id="Head_LateralCervicalReg">
                                            <option value="">Select Lateral Cervical Region</option>
                                            <cfloop query="getHeadLateralCervicalReg">
                                                <option  value="#getHeadLateralCervicalReg.ID#" <cfif isdefined("form.Head_LateralCervicalReg") and listFind(form.Head_LateralCervicalReg, getHeadLateralCervicalReg.ID)>selected</cfif> >#getHeadLateralCervicalReg.HLCR_Name#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Facial Bones :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Head_FacialBones" id="Head_FacialBones">
                                            <option value="">Select Facial Bones</option>
                                            <cfloop query="getHeadFacialBones">
                                                <option  value="#getHeadFacialBones.ID#" <cfif isdefined("form.Head_FacialBones") and listFind(form.Head_FacialBones, getHeadFacialBones.ID)>selected</cfif> >#getHeadFacialBones.HFB_Name#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Ear OS :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Head_EarOS" id="Head_EarOS">
                                            <option value="">Select Facial Bones</option>
                                            <cfloop query="getHeadEarOS">
                                                <option  value="#getHeadEarOS.ID#" <cfif isdefined("form.Head_EarOS") and listFind(form.Head_EarOS, getHeadEarOS.ID)>selected</cfif> >#getHeadEarOS.HEOS_Name#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>

                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Chin Skin Folds :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Head_ChinSkinFolds" id="Head_ChinSkinFolds">
                                            <option value="">Select Chin Skin Folds</option>
                                            <cfloop query="getHeadChinSkinFolds">
                                                <option  value="#getHeadChinSkinFolds.ID#" <cfif isdefined("form.Head_ChinSkinFolds") and listFind(form.Head_ChinSkinFolds, getHeadChinSkinFolds.ID)>selected</cfif> >#getHeadChinSkinFolds.HCSF_Name#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Epaxial Muscle :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Body_EpaxialMuscle" id="Body_EpaxialMuscle">
                                            <option value="">Select Epaxial Muscle</option>
                                            <cfloop query="getBodyEpaxialMuscle">
                                                <option  value="#getBodyEpaxialMuscle.ID#" <cfif isdefined("form.Body_EpaxialMuscle") and listFind(form.Body_EpaxialMuscle, getBodyEpaxialMuscle.ID)>selected</cfif> >#getBodyEpaxialMuscle.BEM_Name#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Dorsal Ridge of Scapula :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Body_DorsalRidgeScapula" id="Body_DorsalRidgeScapula">
                                            <option value="">Select Dorsal Ridge of Scapula</option>
                                            <cfloop query="getBodyDorsalRidgeScapula">
                                                <option  value="#getBodyDorsalRidgeScapula.ID#" <cfif isdefined("form.Body_DorsalRidgeScapula") and listFind(form.Body_DorsalRidgeScapula, getBodyDorsalRidgeScapula.ID)>selected</cfif> >#getBodyDorsalRidgeScapula.BDRS_Name#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>


                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Ribs :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Body_Ribs" id="Body_Ribs">
                                            <option value="">Select Ribs</option>
                                            <cfloop query="getBodyRibs">
                                                <option  value="#getBodyRibs.ID#" <cfif isdefined("form.Body_Ribs") and listFind(form.Body_Ribs, getBodyRibs.ID)>selected</cfif> >#getBodyRibs.BR_Name#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Transverse Processes :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Tail_TransversePro" id="Tail_TransversePro">
                                            <option value="">Select Transverse Processes</option>
                                            <cfloop query="getTailTransversePro">
                                                <option  value="#getTailTransversePro.ID#" <cfif isdefined("form.Tail_TransversePro") and listFind(form.Tail_TransversePro, getTailTransversePro.ID)>selected</cfif> >#getTailTransversePro.TTP_Name#</option>       
                                            </cfloop>
                                        </select>                                        
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">SDR :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="SDR">
                                            <option value="">Select SDR Status</option>
                                            <option value="on" <cfif isdefined("form.SDR") and form.SDR eq 'on'>selected</cfif> >Yes</option>
                                            <option value="off" <cfif isdefined("form.SDR") and form.SDR eq 'off'>selected</cfif> >No</option>
                                        </select>
                                        
                                    </div>
                                </div>

                            </div>

                            <!------------------------------------------  Check Box area  ------------------------------------------->
                            <!------------------------------------------  Check Box area  ------------------------------------------->
                            <!------------------------------------------  Check Box area  ------------------------------------------->


                            <div class="form-row">
                                
                            </div>
                            <hr>

                            <div class="form-row">
                                    <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Survey Information</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="surveyinfo" id="surveyinfo" value="1" <cfif isdefined("form.surveyinfo") and form.surveyinfo eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Sighting Information</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="sightingInfo" id="sightingInfo" value="1" <cfif isdefined("form.sightingInfo") and form.sightingInfo eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Location Description</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="locationDesc" id="locationDesc" value="1" <cfif isdefined("form.locationDesc") and form.locationDesc eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                    <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Lat Long</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="latlong" id="latlong" value="1" <cfif isdefined("form.latlong") and form.latlong eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Weather Conditions</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="weatherCondition" id="weatherCondition" value="1" <cfif isdefined("form.weatherCondition") and form.weatherCondition eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Water Parameters</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="waterParameters" id="waterParameters" value="1" <cfif isdefined("form.waterParameters") and form.waterParameters eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetacean Takes</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="CetaceanTakes" id="CetaceanTakes" value="1" <cfif isdefined("form.CetaceanTakes") and form.CetaceanTakes eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cohesiveness</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="cohesiveness" id="cohesiveness" value="1" <cfif isdefined("form.cohesiveness") and form.cohesiveness eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Feeding Ecology</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="feedingEcology" id="feedingEcology" value="1" <cfif isdefined("form.feedingEcology") and form.feedingEcology eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Fisheries Interactions</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="FisheriesInteractions" id="FisheriesInteractions" value="1" <cfif isdefined("form.FisheriesInteractions") and form.FisheriesInteractions eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Boating Interactions</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="BoatingInteractions" id="BoatingInteractions" value="1" <cfif isdefined("form.BoatingInteractions") and form.BoatingInteractions eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                                </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">HBOI vessel interactions</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="HBOIvesselinteractions" id="HBOIvesselinteractions" value="1" <cfif isdefined("form.HBOIvesselinteractions") and form.HBOIvesselinteractions eq "1">checked</cfif> style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                               
                            <div class="form-row">
                                    <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Staff Roles</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="StaffRoles" id="StaffRoles" <cfif isdefined("form.StaffRoles") and form.StaffRoles eq "1">checked</cfif> value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetacean Sighting Form</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="CetaceanSightingForm" id="CetaceanSightingForm" <cfif isdefined("form.CetaceanSightingForm") and form.CetaceanSightingForm eq "1">checked</cfif> value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Reviewer Information</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="ReviewerInformation" id="ReviewerInformation" <cfif isdefined("form.ReviewerInformation") and form.ReviewerInformation eq "1">checked</cfif> value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Cetacean Life History Info</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="CetaceanLifeHistoryInfo" id="CetaceanLifeHistoryInfo" <cfif isdefined("form.CetaceanLifeHistoryInfo") and form.CetaceanLifeHistoryInfo eq "1">checked</cfif> value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Associate Info</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="AssociateInfo" id="AssociateInfo"  value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Misc</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="Misc" id="Misc" <cfif isdefined("form.Misc") and form.Misc eq "1">checked</cfif> value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                            </div>


                            
                            <div class="form-row incident-btn-row">
                                <div class="col-lg-10 col-md-10 col-sm-9 text-right">
                                    <button type="submit" name="btnSearchSightings" value ="submit"  class="btn btn-success width-100 m-r-5  ml-auto" id="add">Run</button>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-3 text-left">
                                    <button type="button" name="reset" value ="reset" onclick='clearAll()' class="btn btn-success width-100 m-r-5  ml-auto" >Clear</button>
                                </div>
                            </div>
                        </form>
                    </cfoutput>
                </div>
            <cfif isdefined("form.btnSearchSightings") or isdefined("form.pge")>
                <!--- <cfset  qGetIncidentReports = Application.IncidentReport.getIncidentReportsWithFilters(form)> --->

                <cfscript>
                     if( isDefined('form.LesionType') and form.LesionType neq "")
                        {    
                            
                            qFiltered=QueryFilter(qFiltered,function(obj){
                            
                                return obj.LesionType1 eq #form.LesionType# OR obj.LesionType2 eq #form.LesionType# OR obj.LesionType3 eq #form.LesionType#;
                            });
                        } 
                        
                        if( isDefined('form.Typename') and form.Typename neq "")
                        {    
                            
                            qFiltered=QueryFilter(qFiltered,function(obj){
                            
                                return obj.Typename1 eq #form.Typename# OR obj.Typename2 eq #form.Typename# OR obj.Typename3 eq #form.Typename#;
                            });
                        } 


                        totalCount = qFiltered.recordCount;
                        paginate = buildSightingReportPagination(totalCount, rowsPerPage, currentRecordCount, pg);
                        pg = paginate.pageNumber;
                </cfscript>
                <cfset qFisherResponseToCetacean = Application.SightingNew.qFisherResponseToCetacean()>
                <cfset qVesselResponseToCetacean = Application.SightingNew.qVesselResponseToCetacean()>
                <cfset fisherResponseHeaders = []>
                <cfset vesselResponseHeaders = []>
                <cfset fisherResponseHeaderIndex = structNew()>
                <cfset vesselResponseHeaderIndex = structNew()>
                <cfset fisherResponseCountMap = structNew()>
                <cfset vesselResponseCountMap = structNew()>
                <cfset reportSightingIds = ValueList(qFiltered.sightingID)>
                <cfset qReportFisherResponseToCetacean = queryNew("SightingID,ResponseLabel,ResponseCount,SortOrder")>
                <cfset qReportVesselResponseToCetacean = queryNew("SightingID,ResponseLabel,ResponseCount,SortOrder")>

                <cfloop query="qFisherResponseToCetacean">
                    <cfset fisherHeaderKey = lcase(rereplace(trim(Desc), "\s+", " ", "all"))>
                    <cfif NOT structKeyExists(fisherResponseHeaderIndex, fisherHeaderKey)>
                        <cfset ArrayAppend(fisherResponseHeaders, {Label = trim(Desc), Key = fisherHeaderKey})>
                        <cfset fisherResponseHeaderIndex[fisherHeaderKey] = arrayLen(fisherResponseHeaders)>
                    </cfif>
                </cfloop>

                <cfloop query="qVesselResponseToCetacean">
                    <cfset vesselHeaderKey = lcase(rereplace(trim(Desc), "\s+", " ", "all"))>
                    <cfif NOT structKeyExists(vesselResponseHeaderIndex, vesselHeaderKey)>
                        <cfset ArrayAppend(vesselResponseHeaders, {Label = trim(Desc), Key = vesselHeaderKey})>
                        <cfset vesselResponseHeaderIndex[vesselHeaderKey] = arrayLen(vesselResponseHeaders)>
                    </cfif>
                </cfloop>

                <cfif len(reportSightingIds)>
                    <cftry>
                        <cfquery name="qReportFisherResponseToCetacean" datasource="#variables.dsn#">
                            SELECT
                                SightingID,
                                ResponseLabel,
                                ResponseCount,
                                SortOrder
                            FROM Survey_Sighting_FisherResponseToCetacean
                            WHERE SightingID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#reportSightingIds#">)
                            ORDER BY ISNULL(SortOrder, 9999), ResponseLabel
                        </cfquery>
                        <cfquery name="qReportVesselResponseToCetacean" datasource="#variables.dsn#">
                            SELECT
                                SightingID,
                                ResponseLabel,
                                ResponseCount,
                                SortOrder
                            FROM Survey_Sighting_VesselResponseToCetacean
                            WHERE SightingID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#reportSightingIds#">)
                            ORDER BY ISNULL(SortOrder, 9999), ResponseLabel
                        </cfquery>
                        <cfcatch type="any">
                            <cfset qReportFisherResponseToCetacean = queryNew("SightingID,ResponseLabel,ResponseCount,SortOrder")>
                            <cfset qReportVesselResponseToCetacean = queryNew("SightingID,ResponseLabel,ResponseCount,SortOrder")>
                        </cfcatch>
                    </cftry>
                </cfif>

                <cfloop query="qReportFisherResponseToCetacean">
                    <cfset fisherHeaderKey = lcase(rereplace(trim(ResponseLabel), "\s+", " ", "all"))>
                    <cfif len(fisherHeaderKey) GT 0>
                        <cfif NOT structKeyExists(fisherResponseHeaderIndex, fisherHeaderKey)>
                            <cfset ArrayAppend(fisherResponseHeaders, {Label = trim(ResponseLabel), Key = fisherHeaderKey})>
                            <cfset fisherResponseHeaderIndex[fisherHeaderKey] = arrayLen(fisherResponseHeaders)>
                        </cfif>
                        <cfset fisherResponseCountMap["#SightingID#|#fisherHeaderKey#"] = ResponseCount>
                    </cfif>
                </cfloop>

                <cfloop query="qReportVesselResponseToCetacean">
                    <cfset vesselHeaderKey = lcase(rereplace(trim(ResponseLabel), "\s+", " ", "all"))>
                    <cfif len(vesselHeaderKey) GT 0>
                        <cfif NOT structKeyExists(vesselResponseHeaderIndex, vesselHeaderKey)>
                            <cfset ArrayAppend(vesselResponseHeaders, {Label = trim(ResponseLabel), Key = vesselHeaderKey})>
                            <cfset vesselResponseHeaderIndex[vesselHeaderKey] = arrayLen(vesselResponseHeaders)>
                        </cfif>
                        <cfset vesselResponseCountMap["#SightingID#|#vesselHeaderKey#"] = ResponseCount>
                    </cfif>
                </cfloop>
            
                <div class="section-container  p-b-10">
                    <cfif qFiltered.recordcount NEQ 0>
                        
                        <table id="allReport" class="table table-bordered table-hover" style="margin-left: initial;">
                            <thead>
                                <tr class="inverse">
                                    <th>Date</th>                                    
                                    <th>Survey ID</th>
                                    <th>Sighting ID</th>
                                                                      
                                    <cfif structKeyExists(form, "surveyinfo") AND form.surveyinfo EQ "1">
                                        <th>Engine On</th>
                                        <th>Engine Off</th>
                                        <th>Survey Start</th>
                                        <th>Survey End</th>
                                        <th>Research Team</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "sightingInfo") AND form.sightingInfo EQ "1">
                                        <th>Sighting No</th>
                                        <th>Sighting Start</th>
                                        <th>Sighting End</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "locationDesc") AND form.locationDesc EQ "1">
                                        <th>ICW Marker</th>
                                        <th>Location</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "latlong") AND form.latlong EQ "1">
                                        <th>Initial Lat</th>
                                        <th>Initial Long</th>
                                        <th>At Lat</th>
                                        <th>At Long</th>
                                        <th>End Lat</th>
                                        <th>End Long</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "weatherCondition") AND form.weatherCondition EQ "1">
                                        <th>Wave Height</th>
                                        <th>Weather</th>
                                        <th>Glare</th>
                                        <th>Glare Direction</th>
                                        <th>Sightability</th>
                                        <th>BSS</th>
                                        <th>Air Temperature</th>
                                        <th>Wind Speed</th>
                                        <th>Wind Direction</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "waterParameters") AND form.waterParameters EQ "1">
                                        <th>Water Temp</th>
                                        <th>At Depth</th>
                                        <th>End Depth</th>
                                        <th>Habitat Type</th>
                                        <th>Tide</th>
                                        <th>Salinity</th>
                                        <th>pH</th>
                                        <th>Dissolved Oxygen (%)</th>
                                        <th>Dissolved Oxygen mg/l</th>
                                        <th>Conductivity</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "CetaceanTakes") AND form.CetaceanTakes EQ "1">
                                        <th>Total Min estimates</th>
                                        <th>Total Max estimates</th>
                                        <th>Total Best estimates</th>
                                        <th>Total Take estimates</th>
                                        <th>Adult Min estimates</th>
                                        <th>Adult Max estimates</th>
                                        <th>Adult Best estimates</th>
                                        <th>Adult Take estimates</th>
                                        <th>Calves Min estimates</th>
                                        <th>Calves Max estimates</th>
                                        <th>Calves Best estimates</th>
                                        <th>Calves Take estimates</th>
                                        <th>Young  Min estimates</th>
                                        <th>Young  Max estimates</th>
                                        <th>Young  Best estimates</th>
                                        <th>Young  Take estimates</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "cohesiveness") AND form.cohesiveness EQ "1">
                                        <th>Main</th>
                                        <th>Main Dist</th>
                                        <th>Sub 1</th>
                                        <th>Sub 1 Dist</th>
                                        <th>Sub 2</th>
                                        <th>Sub 2 Dist</th>
                                        <th>Sub 3 </th>
                                        <th>Sub 3 Dist</th>                                        
                                    </cfif>
                                    <cfif structKeyExists(form, "feedingEcology") AND form.feedingEcology EQ "1">
                                        <th>Prey species</th>
                                        <th>Feeding lat</th>
                                        <th>Feeding lont</th>
                                        <th>Structure Present</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "FisheriesInteractions") AND form.FisheriesInteractions EQ "1">
                                        <th>no of cetaceans w'in 100 m of active fisher</th>
                                        <th>no. of fishers/platforms</th>
                                        <th>Cetacean Response to Fisher (Approach)</th>
                                        <th>Cetacean Response to Fisher (Neutral)</th>
                                        <th>Cetacean Response to Fisher (Relocate)</th>
                                        <cfloop array="#fisherResponseHeaders#" index="fisherResponseHeader">
                                            <th>Fisher response to cetacean (#fisherResponseHeader.Label#)</th>
                                        </cfloop>
                                        <th>Depredation</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "BoatingInteractions") AND form.BoatingInteractions EQ "1">
                                        <th>No of cetaceans w'in 100 m of recreational vessels</th>
                                        <th>No of Vessels</th>
                                        <th>Cetacean Response to Vessel (Approach)</th>
                                        <th>Cetacean Response to Vessel (Neutral)</th>
                                        <th>Cetacean Response to Vessel (Relocate)</th>
                                        <cfloop array="#vesselResponseHeaders#" index="vesselResponseHeader">
                                            <th>Vessel Response to Cetaceans (#vesselResponseHeader.Label#)</th>
                                        </cfloop>
                                    </cfif>
                                    <cfif structKeyExists(form, "HBOIvesselinteractions") AND form.HBOIvesselinteractions EQ "1">
                                        <th>no of Cetaceans</th>
                                        <th>Reaction to HBOI Vessel (Approach)</th>
                                        <th>Reaction to HBOI Vessel (Neutral)</th>
                                        <th>Reaction to HBOI Vessel (Relocate)</th>
                                        
                                    </cfif>
                                    <cfif structKeyExists(form, "ReviewerInformation") AND form.ReviewerInformation EQ "1">
                                        <th>Completed By</th>
                                        <th>Entered By</th>
                                        <th>Initial Review</th>
                                        <th>Final Review</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "StaffRoles") AND form.StaffRoles EQ "1">
                                        <th>Photographer</th>
                                        <th>Driver</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "CetaceanSightingForm") AND form.CetaceanSightingForm EQ "1">
                                        <th>Best</th>
                                        <th>Fetals</th>
                                        <th>Calf</th>
                                        <th>Yoy</th>
                                        <th>With mom</th>
                                        <th>Note</th>                                        
                                        <th>Best shot</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "CetaceanLifeHistoryInfo") AND form.CetaceanLifeHistoryInfo EQ "1">
                                        <th>Cetacean Name</th>
                                        <th>Sex</th>
                                        <th>Source Sexed</th>
                                        <th>Lineage</th>
                                        <th>Mother</th>
                                        <th>Date of Birth Est</th>
                                        <th>Year of birth</th>
                                        <th>Source YOB</th>
                                        <th>Date of Death</th>
                                        <th>First Sighting Date</th>
                                        <th>Presumed Dead</th>
                                        <th>Dead</th>
                                        <th>Hubbs ID</th>
                                        <th>Field ID</th>
                                        <th>FB Number</th>
                                        <th>Previous HBOI Code</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Misc") AND form.Misc EQ "1">
                                        <th>Assocaited Bio</th>
                                        <th>Initial Heading</th>
                                        <th>Genral Heading</th>
                                        <th>Final Heading</th>
                                        <th>Comments</th>
                                        <th>Camera</th>
                                        <th>Lens</th>

                                        <th>Start Time Dive 1</th>
                                        <th>End Time Dive 1</th>
                                        <th>Total Time Dive 1</th>

                                        <th>Start Time Dive 2</th>
                                        <th>End Time Dive 2</th>
                                        <th>Total Time Dive 2</th>

                                        <th>Start Time Dive 3</th>
                                        <th>End Time Dive 3</th>
                                        <th>Total Time Dive 3</th>

                                        <th>Start Time Dive 4</th>
                                        <th>End Time Dive 4</th>
                                        <th>Total Time Dive 4</th>

                                        <th>Start Time Dive 5</th>
                                        <th>End Time Dive 5</th>
                                        <th>Total Time Dive 5</th>
                                    </cfif>

                                    <cfif structKeyExists(form, "BodyOfWater") AND form.BodyOfWater NEQ "">
                                        <th>Body of Water</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "SurveyRoute") AND form.SurveyRoute NEQ "">
                                        <th>Survey Route</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Platform") AND form.Platform NEQ "">
                                        <th>Platform</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "NOAAStock") AND form.NOAAStock NEQ "">
                                        <th>NOAAStock</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "SurveyType") AND form.SurveyType NEQ "">
                                        <th>Survey Type</th>
                                    </cfif>
                                    
                                    <cfif structKeyExists(form, "BodyCondition") AND form.BodyCondition NEQ "">
                                        <th>Body Condition</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "surveyEffort") AND form.surveyEffort NEQ "">
                                        <th>Survey Effort</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Dscore") AND form.Dscore NEQ "">
                                        <th>Dscore</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Qscore") AND form.Qscore NEQ "">
                                        <th>Qscore</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "SDR") AND form.SDR NEQ "">
                                        <th>SDR</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "pq_focus") AND form.pq_focus NEQ "">
                                        <th>PQ F</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "pq_Angle") AND form.pq_Angle NEQ "">
                                        <th>PQ A</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "pq_Contrast") AND form.pq_Contrast NEQ "">
                                        <th>PQ C</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "pq_Proportion") AND form.pq_Proportion NEQ "">
                                        <th>PQ Pro</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "pq_Partial") AND form.pq_Partial NEQ "">
                                        <th>PQ Par</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Head_NuchalCrest") AND form.Head_NuchalCrest NEQ "">
                                        <th>Head NuchalCrest</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Head_LateralCervicalReg") AND form.Head_LateralCervicalReg NEQ "">
                                        <th>Lateral Cervical Region</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Head_FacialBones") AND form.Head_FacialBones NEQ "">
                                        <th>Facial Bones</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Head_EarOS") AND form.Head_EarOS NEQ "">
                                        <th>Ear OS</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Head_ChinSkinFolds") AND form.Head_ChinSkinFolds NEQ "">
                                        <th>Chin Skin Folds</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Body_EpaxialMuscle") AND form.Body_EpaxialMuscle NEQ "">
                                        <th>Epaxial Muscle</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Body_DorsalRidgeScapula") AND form.Body_DorsalRidgeScapula NEQ "">
                                        <th>Dorsal Ridge of Scapula</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Body_Ribs") AND form.Body_Ribs NEQ "">
                                        <th>Ribs</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "Tail_TransversePro") AND form.Tail_TransversePro NEQ "">
                                        <th>Transverse Processes:</th>
                                    </cfif>

                                    
                                    
                                    
                                    
                                    <th>CetaceanSpeciesName</th>
                                    <th>Code</th>
                                    

                                    <cfoutput> 
                                        <cfloop index="index" from="1" to="#maximumLesions.MaxLesion#">
                                            <th>LesionPresent#index#</th>
                                            <th>TypeName#index#</th>
                                            <th>LesionType#index#</th>
                                            <th>Region#index#</th>
                                            <th>Side_L_R#index#</th>
                                            <th>Status#index#</th>
                                            <th>Lesion Comments#index#</th>
                                            <th>Lesion Photo#index#</th>
                                        </cfloop>
                                    </cfoutput>

                                    <!--- <th>BehavioralSpecifics1</th>
                                    <th>BehavioralSpecifics2</th>
                                    <th>BehavioralSpecifics3</th>
                                    <th>BehavioralSpecifics4</th>

                                    <th>Act_Mill</th>
                                    <th>Act_Feed</th>
                                    <th>Act_Prob_Feed</th>
                                    <th>Act_Travel</th>
                                    <th>Act_Object_Play</th>
                                    <th>Act_Rest</th>
                                    <th>Act_Social</th>
                                    <th>Act_With_Boat</th>
                                    <th>Act_Avoid_Boat</th>
                                    <th>Act_Other</th>  --->
                                </tr>
                            </thead>
                            <tbody>
                                <cfoutput query="qFiltered" startRow="#paginate.startCount#" maxRows="#rowsPerPage#">
                                    <tr>
                                        <td>#dateformat(Date, "yyyy-mm-dd")#</td>
                                        <td>#SurveyID#</td>
                                        <td>#SightingID#</td>
                                        
                                        <cfif structKeyExists(form, "surveyinfo") AND form.surveyinfo EQ "1">
                                            <td>#EngineOn#</td>
                                            <td>#EngineOff#</td>
                                            <td>#SurveyStart#</td>
                                            <td>#SurveyEnd#</td>
                                            <td>
                                                <cfset bd = listToArray(ResearchTeam, ",", false, true)>
                                                <cfloop query="RTmembers">
                                                    <cfif ArrayContains(bd, RT_ID)>
                                                        #trim(RT_MemberName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif> 
                                        <cfif structKeyExists(form, "sightingInfo") AND form.sightingInfo EQ "1">
                                            <td>#Sighting_No#</td>
                                            <td>#SightingStart#</td>
                                            <td>#SightingEnd#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "locationDesc") AND form.locationDesc EQ "1">
                                            <td>#ICW_Start#</td>
                                            <td>#Location#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "latlong") AND form.latlong EQ "1">
                                            <td>#InitialLatitude#</td>
                                            <td>#InitialLongitude#</td>
                                            <td>#AtLatitude#</td>
                                            <td>#AtLongitude#</td>
                                            <td>#EndLatitude#</td>
                                            <td>#EndLongitude#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "weatherCondition") AND form.weatherCondition EQ "1">
                                            <td>
                                                <!--- #WaveHeight# --->
                                                <cfset bd = listToArray(WaveHeight, ",", false, true)>
                                                <cfloop query="getWaveHeight">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Desc)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #Weather# --->
                                                <cfset bd = listToArray(Weather, ",", false, true)>
                                                <cfloop query="getWeather">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Desc)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #Glare# --->
                                                <cfset bd = listToArray(Glare, ",", false, true)>
                                                <cfloop query="getGlare">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Desc)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #GlareDirection# --->
                                                <cfset bd = listToArray(GlareDirection, ",", false, true)>
                                                <cfloop query="getGlareDirection">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Desc)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #Sightability# --->
                                                <cfset bd = listToArray(Sightability, ",", false, true)>
                                                <cfloop query="getSightability">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Desc)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #Beaufort# --->
                                                <cfset bd = listToArray(Beaufort, ",", false, true)>
                                                <cfloop query="qGetBeaufort">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Desc)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>#AirTemp#</td>
                                            <td>#WindSpeed#</td>
                                            <td>
                                                <!--- #WindDirection# --->
                                                <cfset bd = listToArray(WindDirection, ",", false, true)>
                                                <cfloop query="getGlareDirection">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Desc)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>

                                        </cfif>
                                        <cfif structKeyExists(form, "waterParameters") AND form.waterParameters EQ "1">
                                            <td>#WaterTemp#</td>
                                            <td>#HabitatDepth#</td>
                                            <td>#EndDepth#</td>
                                            <td>
                                                <!--- #HabitatType# --->
                                                <cfset bd = listToArray(HabitatType, ",", false, true)>
                                                <cfloop query="getHabitatList">
                                                    <cfif ArrayContains(bd, HabitatID)>
                                                        #trim(HabitatName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #Tide# --->
                                                <cfset bd = listToArray(Tide, ",", false, true)>
                                                <cfloop query="TideList">
                                                    <cfif ArrayContains(bd, TideID)>
                                                        #trim(TideName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>#Salinity#</td>
                                            <td>#pH#</td>
                                            <td>#DO#</td>
                                            <td>#dissolvedOxygen#</td>
                                            <td>#Conductivity#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "CetaceanTakes") AND form.CetaceanTakes EQ "1">
                                            <td>#FE_TotalCetaceans_Min#</td>
                                            <td>#FE_TotalCetaceans_Max#</td>
                                            <td>#FE_TotalCetacean_Best#</td>
                                            <td>#FE_TotalCetacean_takes#</td>
                                            <td>#FE_TotalAdults_Min#</td>
                                            <td>#FE_TotalAdults_Max#</td>
                                            <td>#FE_TotalAdults_Best#</td>
                                            <td>#FE_TotalAdults_takes#</td>
                                            <td>#FE_TotalCalves_Min#</td>
                                            <td>#FE_TotalCalves_Max#</td>
                                            <td>#FE_TotalCalves_Best#</td>
                                            <td>#FE_TotalCalves_takes#</td>
                                            <td>#FE_YoungOfYear_Min#</td>
                                            <td>#FE_YoungOfYear_Max#</td>
                                            <td>#FE_YoungOfYear_Best#</td>
                                            <td>#FE_YoungOfYear_takes#</td>
                                            
                                        </cfif>
                                        <cfif structKeyExists(form, "cohesiveness") AND form.cohesiveness EQ "1">
                                            <td>#groupeSelect1#</td>
                                            <td>#distanceSelect1#</td>
                                            <td>#groupeSelect2#</td>
                                            <td>#distanceSelect2#</td>
                                            <td>#groupeSelect3#</td>
                                            <td>#distanceSelect3#</td>
                                            <td>#groupeSelect4#</td>
                                            <td>#distanceSelect4#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "feedingEcology") AND form.feedingEcology EQ "1">
                                            <td>
                                                <!--- #PreySpeciesName# --->
                                                <cfset bd = listToArray(PreySpecies, ",", false, true)>
                                                <cfloop query="getPreySpeciesData">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(PreySpeciesName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>#Feeding_Lat#</td>
                                            <td>#Feeding_Long#</td>
                                            <td>
                                                <!--- #Structure_Present# --->
                                                <cfset bd = listToArray(Structure_Present, ",", false, true)>
                                                <cfloop query="StructureList">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Name)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            
                                        </cfif>
                                        <cfif structKeyExists(form, "FisheriesInteractions") AND form.FisheriesInteractions EQ "1">
                                            <td>#NoOfCetaceansWithIn100mOfActiveFisher#</td>
                                            <td>#NoOfFishers#</td>
                                            <td>#CetaceanResponsetoFisher1#</td>
                                            <td>#CetaceanResponsetoFisher2#</td>
                                            <td>#CetaceanResponsetoFisher3#</td>
                                            <cfloop array="#fisherResponseHeaders#" index="fisherResponseHeader">
                                                <cfset fisherResponseValue = "">
                                                <cfset fisherResponseMapKey = "#sightingID#|#fisherResponseHeader.Key#">
                                                <cfif structKeyExists(fisherResponseCountMap, fisherResponseMapKey)>
                                                    <cfset fisherResponseValue = fisherResponseCountMap[fisherResponseMapKey]>
                                                <cfelseif fisherResponseHeader.Key EQ "approach">
                                                    <cfset fisherResponseValue = FisherResponsetoCetacean1>
                                                <cfelseif fisherResponseHeader.Key EQ "no response">
                                                    <cfset fisherResponseValue = FisherResponsetoCetacean2>
                                                <cfelseif fisherResponseHeader.Key EQ "pull in line">
                                                    <cfset fisherResponseValue = FisherResponsetoCetacean3>
                                                <cfelseif fisherResponseHeader.Key EQ "relocate">
                                                    <cfset fisherResponseValue = FisherResponsetoCetacean4>
                                                </cfif>
                                                <td>#fisherResponseValue#</td>
                                            </cfloop>
                                            <td>#Depredation#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "BoatingInteractions") AND form.BoatingInteractions EQ "1">
                                            <td>#NoOfCetaceansWithIn100mOfRecreationVessels#</td>
                                            <td>#NumberOfVessels#</td>
                                            <td>#CetaceanResponsetoVessel1#</td>
                                            <td>#CetaceanResponsetoVessel2#</td>
                                            <td>#CetaceanResponsetoVessel3#</td>
                                            <cfloop array="#vesselResponseHeaders#" index="vesselResponseHeader">
                                                <cfset vesselResponseValue = "">
                                                <cfset vesselResponseMapKey = "#sightingID#|#vesselResponseHeader.Key#">
                                                <cfif structKeyExists(vesselResponseCountMap, vesselResponseMapKey)>
                                                    <cfset vesselResponseValue = vesselResponseCountMap[vesselResponseMapKey]>
                                                <cfelseif vesselResponseHeader.Key EQ "approach">
                                                    <cfset vesselResponseValue = VesselResponsetoCetacean1>
                                                <cfelseif vesselResponseHeader.Key EQ "no response">
                                                    <cfset vesselResponseValue = VesselResponsetoCetacean2>
                                                <cfelseif vesselResponseHeader.Key EQ "out of gear">
                                                    <cfset vesselResponseValue = VesselResponsetoCetacean3>
                                                <cfelseif vesselResponseHeader.Key EQ "relocate">
                                                    <cfset vesselResponseValue = VesselResponsetoCetacean4>
                                                </cfif>
                                                <td>#vesselResponseValue#</td>
                                            </cfloop>
                                        </cfif>
                                        <cfif structKeyExists(form, "HBOIvesselinteractions") AND form.HBOIvesselinteractions EQ "1">
                                            <td>#No_of_Cetaceans_wHBOI_Vessel#</td>
                                            <td>#ReactiontoHBOIVessel1#</td>
                                            <td>#ReactiontoHBOIVessel2#</td>
                                            <td>#ReactiontoHBOIVessel3#</td>                                            
                                        </cfif>
                                        <cfif structKeyExists(form, "ReviewerInformation") AND form.ReviewerInformation EQ "1">
                                            <td>#CompletedBy#</td>
                                            <td>
                                                <!--- #EnteredBy# --->
                                                <cfset bd = listToArray(#EnteredBy#, ",", false, true)> 
                                                <cfset d = 1>
                                                <cfloop query="users">
                                                    <cfif ArrayContains(bd,#user_id#)>#trim(first_name)# #trim(last_name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #PhotoAnalysisInitial# --->
                                                <cfset bd = listToArray(#PhotoAnalysisInitial#, ",", false, true)> 
                                                <cfset d = 1>
                                                <cfloop query="users">
                                                    <cfif ArrayContains(bd,#user_id#)>#trim(first_name)# #trim(last_name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #PhotoAnalysisFinal# --->
                                                <cfset bd = listToArray(#PhotoAnalysisFinal#, ",", false, true)> 
                                                <cfset d = 1>
                                                <cfloop query="users">
                                                    <cfif ArrayContains(bd,#user_id#)>#trim(first_name)# #trim(last_name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>                                            
                                        </cfif>
                                        <cfif structKeyExists(form, "StaffRoles") AND form.StaffRoles EQ "1">
                                            <td>
                                                <!--- #Photographer# --->
                                                <cfset bd = listToArray(Photographer, ",", false, true)>
                                                <cfloop query="getTeams">
                                                    <cfif ArrayContains(bd, RT_ID)>
                                                        #trim(RT_MemberName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #Driver# --->
                                                <cfset bd = listToArray(Driver, ",", false, true)>
                                                <cfloop query="getTeams">
                                                    <cfif ArrayContains(bd, RT_ID)>
                                                        #trim(RT_MemberName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "CetaceanSightingForm") AND form.CetaceanSightingForm EQ "1">
                                            <td>#bestSighting#</td>
                                            <td>#Fetals#</td>
                                            <td>#Calf#</td>
                                            <td>#Yoy#</td>
                                            <td>
                                                <!--- #Yoy# --->
                                                <cfif #wMomDropDown# eq 1>
                                                    Yes
                                                <cfelseif #wMomDropDown# eq 2>
                                                    No
                                                <cfelseif #wMomDropDown# eq 3>
                                                    Partial
                                                <cfelseif #wMomDropDown# eq 4>
                                                    Mom Not Present
                                                <cfelseif #wMomDropDown# eq 5>
                                                    CBD
                                                </cfif>
                                            </td>
                                            <td>#Note#</td>
                                            <td>#BestShot#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "CetaceanLifeHistoryInfo") AND form.CetaceanLifeHistoryInfo EQ "1">
                                            <td>#csname#</td>
                                            <td>#Sex#</td>
                                            <td>
                                                <!--- #SourceSexed# --->
                                                <cfset bd = listToArray(SourceSexed, ",", false, true)>
                                                <cfloop query="getSourceSex">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Ssex)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>#Lineage#</td>
                                            <td>#Mother#</td>
                                            <td>#DateOfBirthEstimate#</td>
                                            <td>#YearOfBirth#</td>
                                            <td>
                                                <!--- #SourceYOB# --->
                                                <cfset bd = listToArray(SourceYOB, ",", false, true)>
                                                <cfloop query="getYOBSource">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(YOBSource)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>#DateDeath#</td>
                                            <td>#FirstSightingDate#</td>
                                            <td>#PresumedDead#</td>
                                            <td>#Dead#</td>
                                            <td>#HUBBS_ID#</td>
                                            <td>#Field_ID#</td>
                                            <td>#FB_Number#</td>
                                            <td>#HBOCI_CODE#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Misc") AND form.Misc EQ "1">
                                            <td>
                                                <!--- #AssocBio# --->
                                                <cfset bd = listToArray(AssocBio, ",", false, true)>
                                                <cfloop query="qGetAssocBioData">
                                                    <cfif ArrayContains(bd, ASSOCBIOID)>
                                                        #trim(ASSOCBIONAME)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #InitialHeading# --->
                                                <cfset bd = listToArray(InitialHeading, ",", false, true)>
                                                <cfloop query="qGetHeadingData">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(HeadingName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #GeneralHeading# --->
                                                <cfset bd = listToArray(GeneralHeading, ",", false, true)>
                                                <cfloop query="qGetGHeadingData">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(GHeadingName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #FinalHeading# --->
                                                <cfset bd = listToArray(FinalHeading, ",", false, true)>
                                                <cfloop query="qGetFHeadingData">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(FHeadingName)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>#Comments#</td>
                                            <td>
                                                <!--- #Camera# --->
                                                <cfset bd = listToArray(Camera, ",", false, true)>
                                                <cfloop query="cameralist">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Camera)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                            <td>
                                                <!--- #Lens# --->
                                                <cfset bd = listToArray(Lens, ",", false, true)>
                                                <cfloop query="lenslist">
                                                    <cfif ArrayContains(bd, ID)>
                                                        #trim(Lens)#
                                                        <cfif arrayLen(bd) GT 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>

                                            <td>#StratTimeDive1#</td>
                                            <td>#EndTimeDive1#</td>
                                            <td>#TotalTimeDive1#</td>

                                            <td>#StratTimeDive2#</td>
                                            <td>#EndTimeDive2#</td>
                                            <td>#TotalTimeDive2#</td>

                                            <td>#StratTimeDive3#</td>
                                            <td>#EndTimeDive3#</td>
                                            <td>#TotalTimeDive3#</td>

                                            <td>#StratTimeDive4#</td>
                                            <td>#EndTimeDive4#</td>
                                            <td>#TotalTimeDive4#</td>

                                            <td>#StratTimeDive5#</td>
                                            <td>#EndTimeDive5#</td>
                                            <td>#TotalTimeDive5#</td>

                                        </cfif>

                                        <cfif structKeyExists(form, "BodyOfWater") AND form.BodyOfWater NEQ "">
                                            <td>
                                                <!--- #BodyOfWater# --->
                                                <cfset bd = listToArray(#BodyOfWater#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getAreaName">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(AreaName)#
                                                        <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "SurveyRoute") AND form.SurveyRoute NEQ "">
                                            <td>
                                                <!--- #SurveyRoute# --->
                                                <cfset bd = listToArray(#SurveyRoute#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getSurveyRouteData">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(ROUTENAME)#
                                                        <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Platform") AND form.Platform NEQ "">
                                            <td>#Platform#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "NOAAStock") AND form.NOAAStock NEQ "">
                                            <td>
                                                <!--- #NOAAStock# --->
                                                <cfset bd = listToArray(#NOAAStock#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getStock">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(STOCKNAME)#
                                                        <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "SurveyType") AND form.SurveyType NEQ "">
                                            <td>#SurveyType#</td>
                                        </cfif>
                                        
                                        
                                        <cfif structKeyExists(form, "BodyCondition") AND form.BodyCondition NEQ "">
                                            <td>
                                                <!--- #BodyCondition# --->
                                                <cfif "#bodyCondition#" eq 1>
                                                    Emaciated
                                                </cfif>
                                                <cfif "#bodyCondition#" eq 2>
                                                    Underweight/Thin
                                                </cfif>
                                                <cfif "#bodyCondition#" eq 3>
                                                    Ideal
                                                </cfif>
                                                <cfif "#bodyCondition#" eq 4>
                                                    Overweight
                                                </cfif>
                                                <cfif "#bodyCondition#" eq 5>
                                                    Obese
                                                </cfif>
                                                <cfif "#bodyCondition#" eq 6>
                                                    CBD
                                                </cfif>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "surveyEffort") AND form.surveyEffort NEQ "">
                                            <td>#surveyEffort#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Dscore") AND form.Dscore NEQ "">
                                            <td>#Dscore#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Qscore") AND form.Qscore NEQ "">
                                            <td>#Qscore#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "SDR") AND form.SDR NEQ "">
                                            <td>#SDR#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "pq_focus") AND form.pq_focus NEQ "">
                                            <td>#pq_focus#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "pq_Angle") AND form.pq_Angle NEQ "">
                                            <td>#pq_Angle#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "pq_Contrast") AND form.pq_Contrast NEQ "">
                                            <td>#pq_Contrast#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "pq_Proportion") AND form.pq_Proportion NEQ "">
                                            <td>#pq_Proportion#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "pq_Partial") AND form.pq_Partial NEQ "">
                                            <td>#pq_Partial#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Head_NuchalCrest") AND form.Head_NuchalCrest NEQ "">
                                            <td>
                                                <!--- #Head_NuchalCrest# --->
                                                <cfset bd = listToArray(#Head_NuchalCrest#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getHeadNuchalCrest">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(HNC_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Head_LateralCervicalReg") AND form.Head_LateralCervicalReg NEQ "">
                                            <td>
                                                <!--- #Head_LateralCervicalReg# --->
                                                <cfset bd = listToArray(#Head_LateralCervicalReg#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getHeadLateralCervicalReg">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(HLCR_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Head_FacialBones") AND form.Head_FacialBones NEQ "">
                                            <td>
                                                <!--- #Head_FacialBones# --->
                                                <cfset bd = listToArray(#Head_FacialBones#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getHeadFacialBones">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(HFB_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Head_EarOS") AND form.Head_EarOS NEQ "">
                                            <td>
                                                <!--- #Head_EarOS# --->
                                                <cfset bd = listToArray(#Head_EarOS#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getHeadEarOS">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(HEOS_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Head_ChinSkinFolds") AND form.Head_ChinSkinFolds NEQ "">
                                            <td>
                                                <!--- #Head_ChinSkinFolds# --->
                                                <cfset bd = listToArray(#Head_ChinSkinFolds#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getHeadChinSkinFolds">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(HCSF_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Body_EpaxialMuscle") AND form.Body_EpaxialMuscle NEQ "">
                                            <td>
                                                <!--- #Body_EpaxialMuscle# --->
                                                <cfset bd = listToArray(#Body_EpaxialMuscle#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getBodyEpaxialMuscle">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(BEM_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Body_DorsalRidgeScapula") AND form.Body_DorsalRidgeScapula NEQ "">
                                            <td>
                                                <!--- #Body_DorsalRidgeScapula# --->
                                                <cfset bd = listToArray(#Body_DorsalRidgeScapula#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getBodyDorsalRidgeScapula">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(BDRS_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Body_Ribs") AND form.Body_Ribs NEQ "">
                                            <td>
                                                <!--- #Body_Ribs# --->
                                                <cfset bd = listToArray(#Body_Ribs#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getBodyRibs">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(BR_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        <cfif structKeyExists(form, "Tail_TransversePro") AND form.Tail_TransversePro NEQ "">
                                            <td>
                                                <!--- #Tail_TransversePro# --->
                                                <cfset bd = listToArray(#Tail_TransversePro#, ",", false, true)>
                                                <cfset d = 1>
                                                <cfloop query="getTailTransversePro">
                                                    <cfif ArrayContains(bd,#ID#)>#trim(TTP_Name)#
                                                            <cfif arrayLen(bd) gt 1>/</cfif>
                                                    </cfif>
                                                </cfloop>
                                            </td>
                                        </cfif>
                                        
                                                                                
                                        <td>#CetaceanSpeciesName#</td>
                                        <td>#Code#</td>
                                                                                
                                        <cfloop index="cn" from="1" to="#maximumLesions.MaxLesion#">                                    
                                            <cfset a =  "LesionPresent">
                                            <cfset t =  "TypeName">
                                            <cfset b =  "LesionType">
                                            <cfset g =  "Region">
                                            <cfset c =  "Side_L_R">
                                            <cfset d =  "Status">
                                            <cfset e =  "Comments">
                                            <cfset f =  "PhotoNumber">
                                            <td>#Evaluate(a&cn)#</td>
                                            <td>#Evaluate(t&cn)#</td>
                                            <td>#Evaluate(b&cn)#</td>
                                            <td>#Evaluate(g&cn)#</td>
                                            <td>#Evaluate(c&cn)#</td>
                                            <td>#Evaluate(d&cn)#</td>
                                            <td>#Evaluate(e&cn)#</td>
                                            <td>#Evaluate(f&cn)#</td>
                                        </cfloop>

                                        <!--- <td>
                                            <!--- #BehavioralSpecifics1# --->
                                            <cfset bd = listToArray(#BehavioralSpecifics1#, ",", false, true)>
                                            <cfset d = 1>
                                            <cfloop query="getBehaviorsData">
                                                <cfif ArrayContains(bd,#ID#)>#trim(BehaviorName)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td>
                                            <!--- #BehavioralSpecifics2# --->
                                            <cfset bd = listToArray(#BehavioralSpecifics2#, ",", false, true)>
                                            <cfset d = 1>
                                            <cfloop query="getBehaviorsData">
                                                <cfif ArrayContains(bd,#ID#)>#trim(BehaviorName)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td>
                                            <!--- #BehavioralSpecifics3# --->
                                            <cfset bd = listToArray(#BehavioralSpecifics3#, ",", false, true)>
                                            <cfset d = 1>
                                            <cfloop query="getBehaviorsData">
                                                <cfif ArrayContains(bd,#ID#)>#trim(BehaviorName)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td>
                                            <!--- #BehavioralSpecifics4# --->
                                            <cfset bd = listToArray(#BehavioralSpecifics4#, ",", false, true)>
                                            <cfset d = 1>
                                            <cfloop query="getBehaviorsData">
                                                <cfif ArrayContains(bd,#ID#)>#trim(BehaviorName)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                                </cfif>
                                            </cfloop>
                                        </td>

                                        <td>#Act_Mill#</td>
                                        <td>#Act_Feed#</td>
                                        <td>#Act_Prob_Feed#</td>
                                        <td>#Act_Travel#</td>
                                        <td>#Act_Object_Play#</td>
                                        <td>#Act_Rest#</td>
                                        <td>#Act_Social#</td>
                                        <td>#Act_With_Boat#</td>
                                        <td>#Act_Avoid_Boat#</td>
                                        <td>#Act_Other#</td> --->
                                        
                                    </tr>
                                </cfoutput>
                            </tbody>
                        </table>

                         <div class="row">
                            <cfscript>
                                if(not StructIsEmpty(paginate)){
                                    writeOutput('<nav aria-label="Page" style="text-align: right;"><ul class="pagination">');
                                    if (StructKeyExists(paginate,"previousLink")){
                                        writeOutput('<li class="page-item"><a onclick="paginate(#paginate.previousLink#)" class="left" style="cursor: pointer;">&laquo; Previous</a></li>');
                                    }
                                    if (StructKeyExists(paginate,"displayLinks")){
                                        for ( i=1; i<=#ArrayLen(paginate.displayLinks)#;i++){
                                    
                                            thePage = paginate.displayLinks[i] ;
                                            if(thePage.isCurrentPage)
                                                writeOutput('<li class="page-item active"><a href="##" class="pagingNumber" >#thePage.pageNumber# </a></li>');
                                            else
                                            writeOutput('<li class="page-item"><a onclick="paginate(#thePage.pageNumber#)" class="pagingNumber" style="cursor: pointer;" title="Go to page #thePage.pageNumber#" value="#thePage.pageNumber#" >#thePage.pageNumber#</a></li>');
                                        }
                                    }
                                    if(StructKeyExists(paginate,"nextLink")){
                                        writeOutput('<li class="page-item"><a onclick="paginate(#paginate.nextLink#)" class="left" style="cursor: pointer;">Next &raquo;</a></li>');
                                    }
                                    writeOutput('</ul></nav>');
                                    writeOutput('<p>Displaying #paginate.startCount# - #paginate.nextCount# records from #paginate.totalCount#</p>');
                                }
                            </cfscript>
                        </div>

                     <cfelse>
                        <div class="alert alert-danger">
                            <strong>Alert!</strong> No record found.
                        </div>
                    </cfif>
                </div>
            </cfif>
            <!-- end panel -->
        </div>
        <!-- end section-container -->

        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
    </cftry>
    <style>
        .top-fld {
            padding-top: 9px;
        }
        @media (max-width: 1300px){
                .top-fld {
                font-size: 12px;
            }
        }
    </style>
 <cfelse>
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">Friend Report</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>




<style>
    .incident-btn-row {
        flex-wrap: nowrap !important;
    }

    .text-left {
        text-align: left !important;
    }
</style>

<script>
    function clearAll() {
        window.location.href = 'SightingReport.cfm';
    }
</script>
