<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <cfset variables.dsn = "wildfins_new">
    <cfset today = now()>
    <cfif  not isDefined('form.pge')>
        <cfset pg = 1>
    </cfif>
    <cfquery name="lesionRegion" datasource="#variables.dsn#">
        SELECT * from TLU_Regions
    </cfquery>
    <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')>
        <cfif isdefined("form.date") and form.date NEQ "">
        <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
        <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
        </cfif>
        <cfquery datasource="#variables.dsn#" name="allCount"  result="r">
            SELECT s.*,cs.Cetaceans_ID AS Cetaceans_I,c.code as cscode,c.name as csname,ss.ID AS sightingID
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
            AND ss.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
            AND s.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
        </cfquery>
        <!--- <cfdump var="#allCount#"> --->
        <!--- query to count maximum number of Lesion against a cetacean --->
    <cfquery datasource="#variables.dsn#" name="maximumLesions">
        SELECT Sighting_ID,Cetaceans_ID, COUNT(*) AS MaxLesion
        FROM Condition_Lesions b
        GROUP BY b.Sighting_ID,b.Cetaceans_ID
        HAVING count(*) > 1
        ORDER BY MaxLesion desc
    </cfquery>

    <cfset oo = 0>
    <cfloop index="index" from="1" to="#maximumLesions.MaxLesion#">
        <cfset oo = incrementValue(#oo#)> 
        <cfset lp =  "LesionPresent" & #oo#>
        <cfset lete =  "LesionType" & #oo#>
        <cfset re =  "Region" & #oo#>
        <cfset slr =  "Side_L_R" & #oo#>
        <cfset st =  "Status" & #oo#>
        <cfset lc =  "Comments" & #oo#>
        <cfset lpn =  "PhotoNumber" & #oo#>
        <cfset QueryAddColumn(allCount, "#lp#","varchar",[""])>
        <cfset QueryAddColumn(allCount, "#lete#","varchar",[""])>
        <cfset QueryAddColumn(allCount, "#re#","varchar",[""])>
        <cfset QueryAddColumn(allCount, "#slr#","varchar",[""])>
        <cfset QueryAddColumn(allCount, "#st#","varchar",[""])>
        <cfset QueryAddColumn(allCount, "#lc#","varchar",[""])>
        <cfset QueryAddColumn(allCount, "#lpn#","varchar",[""])>
    </cfloop>
        <cfloop query="allCount">
            <cfif #sightingID# neq "" and #Cetaceans_I# neq ""> 
                <!--- Query get lesion data against a cetacean and sighting ID --->
                <cfquery datasource="#variables.dsn#" name="cldd">
                    SELECT cl.*
                    FROM Condition_Lesions cl
                    where cl.Sighting_ID = #sightingID# and cl.Cetaceans_ID='#cscode#'
                </cfquery>
                <cfif cldd.RECORDCOUNT gte 1 >
                    <cfset cc = 0>
                    <!--- loop for seting columns data  working--->
                    <cfloop query="cldd" > 
                        <cfset cc = incrementValue(#cc#)> 
                        <cfset lp =  "LesionPresent" & #cc#>
                        <cfset lete =  "LesionType" & #cc#>
                        <!---<cfset re =  "Region" & #cc#> --->
                        <cfset slr =  "Side_L_R" & #cc#>
                        <cfset st =  "Status" & #cc#>
                        <cfset lc =  "Comments" & #cc#>
                        <cfset lpn =  "PhotoNumber" & #cc#>
                        <cfset QuerySetCell(allCount, "#lp#", #LesionPresent#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#lete#", #LesionType#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#slr#", #Side_L_R#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#st#", #Status#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#lc#", #Comments#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#lpn#", #PhotoNumber#, allCount.currentRow)>
                    </cfloop>
                </cfif>
            </cfif>
        </cfloop>
        <cfscript>
            if( isDefined('form.LesionType') and form.LesionType neq "")
            {    
                
                qFiltered=QueryFilter(allCount,function(obj){
                
                    return obj.LesionType1 eq #form.LesionType# OR obj.LesionType2 eq #form.LesionType# OR obj.LesionType3 eq #form.LesionType#;
                });
            }  
        </cfscript>
        <cfscript>
            rowsPerPage = 100;
            currentRecordCount = 100;
            totalCount = allCount.recordCount;
            if(totalCount == "")
            {
                totalCount=0;
            }
            if(isDefined('form.pge'))
            {
                pg = form.pge;
            }else
            {
                pg = 1;
            }
            maxPagesBefore = 3;
            maxPagesAfter = 3;
            urlString = '';
            pageVar = 'pg';
            local.paginationStruct = StructNew();
            local.multiUrlParamsReplace = "";
            if (listLen(urlString,"&") GT 1)
            {
                local.multiUrlParamsReplace = "&";
            }
            local.paginationStruct["numberOfPages"] = Ceiling(totalCount/rowsPerPage);
            if (totalCount == 0)
                local.paginationStruct["startCount"] = 1;
            else	
                local.paginationStruct["startCount"] = (((pg-1) * rowsPerPage)+1);
                local.paginationStruct["endCount"] = ((pg-1) * rowsPerPage)+currentRecordCount;

            if(pg == 1)
            {
                if(totalCount gte rowsPerPage)
                local.paginationStruct["nextCount"] = currentRecordCount;
                else
                local.paginationStruct["nextCount"] = totalCount;
            }
            else
            {
                if(totalCount lt local.paginationStruct["startCount"]+rowsPerPage )
                {
                    local.paginationStruct["nextCount"]=totalCount;
                }
                else
                {
                    local.paginationStruct["nextCount"] = ((((pg-1) * rowsPerPage))+rowsPerPage);
                }
            }
            local.paginationStruct["totalCount"] = totalCount;
            if (pg LT local.paginationStruct["numberOfPages"])
            {
                local.paginationStruct["nextLink"] = replace(urlString,"#local.multiUrlParamsReplace##pg#","")&pg+1;
            }
            if (pg LTE local.paginationStruct["numberOfPages"] AND pg GT 1)
            {
                local.paginationStruct["previousLink"] = replace(urlString,"#local.multiUrlParamsReplace##pg#","")&pg-1;
            }
            local.maxPages = maxPagesBefore + maxPagesAfter + 1 ;
            local.startIndex = 1;
            local.endIndex = local.paginationStruct["numberOfPages"] ;
            if(local.paginationStruct["numberOfPages"] GT local.maxPages)
            {
                local.startIndex = pg - maxPagesBefore ;
                local.endIndex = pg + maxPagesAfter ;
                if (local.startIndex LT 1){
                local.startIndex = 1 ;
                local.endIndex = (local.startIndex + local.maxPages) - 1 ;
                }
                if (local.endIndex GT local.paginationStruct["numberOfPages"])
                {
                    local.startIndex = local.paginationStruct["numberOfPages"] - local.maxPages ;
                    local.endIndex = local.paginationStruct["numberOfPages"] ;
                }
            }
            if (local.endIndex GT 1)
            {
                local.displayLinks = ArrayNew(1);
                for ( local.i=#local.startIndex#; local.i<=#local.endIndex#;local.i++)
                {
                    local.pageObj = StructNew();
                    local.pageObj["pageNumber"] = local.i ;
                    local.pageObj["pageLink"] = "&"&replace(urlString,"#local.multiUrlParamsReplace##pageVar#=#pg#","")&"#pageVar#="&local.i
                if (pg EQ local.i)
                    local.pageObj["isCurrentPage"] = true ;
                else
                    local.pageObj["isCurrentPage"] = false ;
                    ArrayAppend(local.displayLinks,local.pageObj);
                }			
                local.paginationStruct["displayLinks"] = local.displayLinks ;
            }
            paginate = local.paginationStruct;
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
            s.SurveyType,
            s.EngineOn,
            s.EngineOff,
            s.SurveyStart,
            s.SurveyEnd,
            s.ResearchTeam,
            ss.SightingNumber,
            ss.ID AS sightingID,
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
            w.[Desc] as Weather,
            wh.[Desc] as WaveHeight,
            g.[Desc] as Glare,
            gd.[Desc] as GlareDirection,
            st.[Desc] as Sightability,
            bt.[Desc] as Beaufort,
            ss.HabitatDepth,
            ht.HabitatName,
            ss.AirTemp,
            ss.WindSpeed,
            gdw.[Desc] as WindDirection,
            td.TideName,
            ss.Salinity,
            ih.HeadingName as InitialHeading,
            gh.GHeadingName as GeneralHeading,
            fh.FHeadingName as FinalHeading,
            ss.AssocBio,
            FE_TotalCetaceans_Max,
            FE_TotalCetaceans_Min,
            FE_TotalCetacean_Best,
            FE_TotalCetacean_takes,
            FE_TotalCalves_Max,
            FE_TotalCalves_Min,
            FE_TotalCalves_Best,
            FE_TotalCalves_takes,
            FE_YoungOfYear_Min,
            FE_YoungOfYear_Max,
            FE_YoungOfYear_Best,
            FE_YoungOfYear_takes,
            Act_Mill,
            Act_Feed,
            Act_Rest,
            Act_Other,
            Act_Social,
            Act_Travel,
            Act_Prob_Feed,
            Act_With_Boat,
            Act_Avoid_Boat,
            Act_Object_Play,
            PreySpecies,
            Feeding_Lat,
            Feeding_Long,
            Structure_Present,
            NoOfCetaceansWithIn100mOfActiveFisher,	
            NoOfFishers,
            CetaceanResponseToFisher,
            FisherResponseToCetacean,
            Depredation,
            NoOfCetaceansWithIn100mOfRecreationVessels,
            NumberOfVessels,
            No_of_Cetaceans_wHBOI_Vessel,
            FE_TotalAdults_Min,
            FE_TotalAdults_Max,
            FE_TotalAdults_Best,
            FE_TotalAdults_takes,
            pH,
            DO,
            Conductivity,
            BehavioralSpecifics1,
            BehavioralSpecificsN1,
            BehavioralSpecifics2,
            BehavioralSpecificsN2,
            BehavioralSpecifics3,
            BehavioralSpecificsN3,
            BehavioralSpecifics4,
            BehavioralSpecificsN4,
            CetaceanResponsetoFisher1,
            CetaceanResponsetoFisher2,
            CetaceanResponsetoFisher3,
            FisherResponsetoCetacean1,
            FisherResponsetoCetacean2,
            FisherResponsetoCetacean3,
            FisherResponsetoCetacean4,
            CetaceanResponsetoVessel1,
            CetaceanResponsetoVessel2,
            CetaceanResponsetoVessel3,
            VesselResponsetoCetacean1,
            VesselResponsetoCetacean2,
            VesselResponsetoCetacean3,
            VesselResponsetoCetacean4,
            ReactiontoHBOIVessel1,
            ReactiontoHBOIVessel2,
            ReactiontoHBOIVessel3,
            StratTimeDive1,
            StratTimeDive2,
            StratTimeDive3,
            StratTimeDive4,
            StratTimeDive5,
            EndTimeDive1,
            EndTimeDive2,
            EndTimeDive3,
            EndTimeDive4,
            EndTimeDive5,
            TotalTimeDive1,
            TotalTimeDive2,
            TotalTimeDive3,
            TotalTimeDive4,
            TotalTimeDive5,
            cm.Camera,
            lns.Lens,
            rtp.RT_MemberName as Photographer,
            rtd.RT_MemberName as Driver,
            ss.EnteredBy as CompletedBy,
            cs.SDR,
            cs.BestSighting,
            c.Code,
            tlu.CetaceanSpeciesName,
            c.Sex,
            c.code as cscode,
            c.name as csname,
            cs.Fetals,
            cs.Calf,
            cs.Yoy,
            c.DScore,
            c.FB_Number,
            cs.wMomDropDown,
            cs.Note,
            cs.pq_focus,
            cs.pq_Angle,
            cs.pq_Contrast,
            cs.pq_Proportion,
            cs.pq_Partial,
            cs.pqSum,
            cs.Qscore,
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
            ss.ID AS sightingID
            
        FROM
            Surveys s
            LEFT JOIN Survey_Sightings ss ON s.ID= ss.Project_ID
            LEFT JOIN Cetacean_Sightings cs ON ss.ID= cs.Sighting_ID
            LEFT JOIN Cetaceans c ON cs.Cetaceans_ID= c.ID
            LEFT JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
            LEFT JOIN TLU_Camera cm ON cm.ID = ss.Camera
            LEFT JOIN TLU_Lens lns ON lns.ID = ss.Lens
            LEFT JOIN TLU_Weather w ON w.ID = ss.Weather
            LEFT JOIN TLU_WaveHight wh ON wh.ID = ss.WaveHeight
            LEFT JOIN TLU_Glare g ON g.ID = ss.Glare
            LEFT JOIN TLU_GlareDirection gd ON gd.ID = ss.GlareDirection
            LEFT JOIN TLU_Sightability st ON st.ID = ss.Sightability
            LEFT JOIN TLU_Beaufort bt ON bt.ID = ss.Beaufort
            LEFT JOIN TLU_Habitat ht ON ht.HabitatID = ss.HabitatType
            LEFT JOIN TLU_GlareDirection gdw ON gdw.ID = ss.WindDirection
            LEFT JOIN TLU_Tide td ON td.TideID = ss.Tide
            LEFT JOIN TLU_Heading ih ON ih.ID = ss.InitialHeading
            LEFT JOIN TLU_GeneralHeading gh ON gh.ID = ss.GeneralHeading
            LEFT JOIN TLU_FinalHeading fh ON fh.ID = ss.FinalHeading
            LEFT JOIN TLU_ResearchTeamMembers rtp ON rtp.RT_ID = ss.Photographer
            LEFT JOIN TLU_ResearchTeamMembers rtd ON rtd.RT_ID = ss.Driver
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
            AND s.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
            AND ss.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
            ORDER BY s.ID 
            <cfif #form.LesionType# eq "">
                OFFSET #local.paginationStruct["startCount"]#-1 ROWS
                FETCH NEXT #rowsPerPage# ROWS ONLY
            </cfif>
    </cfquery>
    <cfset rr = 0>
    <!--- loop for adding columns in main query --->
    <cfloop index="index" from="1" to="#maximumLesions.MaxLesion#">
            <cfset rr = incrementValue(#rr#)> 
            <cfset lp =  "LesionPresent" & #rr#>
            <cfset lete =  "LesionType" & #rr#>
            <cfset slr =  "Side_L_R" & #rr#>
            <cfset st =  "Status" & #rr#>
            <cfset lc =  "Comments" & #rr#>
            <cfset lpn =  "PhotoNumber" & #rr#>
            <cfset QueryAddColumn(qFiltered, "#lp#","varchar",[""])>
            <cfset QueryAddColumn(qFiltered, "#lete#","varchar",[""])>
            <cfset QueryAddColumn(qFiltered, "#slr#","varchar",[""])>
            <cfset QueryAddColumn(qFiltered, "#st#","varchar",[""])>
            <cfset QueryAddColumn(qFiltered, "#lc#","varchar",[""])>
            <cfset QueryAddColumn(qFiltered, "#lpn#","varchar",[""])>
    </cfloop>
        <cfloop query="qFiltered">
            <cfif #sightingID# neq "" and #Cetaceans_I# neq ""> 
                <!--- Query get lesion data against a cetacean and sighting ID --->
                <cfquery datasource="#variables.dsn#" name="cldd">
                    SELECT cl.*
                    FROM Condition_Lesions cl
                    where cl.Sighting_ID = #sightingID# and cl.Cetaceans_ID='#cscode#'
                </cfquery>
                <cfif cldd.RECORDCOUNT gte 1 >
                    <cfset cne = 0>
                    <!--- loop for seting columns data  --->
                    <cfloop query="cldd" > 
                        <cfset cne = incrementValue(#cne#)> 
                        <cfset lp =  "LesionPresent" & #cne#>
                        <cfset lete =  "LesionType" & #cne#>
                        <!---<cfset re =  "Region" & #cn#> --->
                        <cfset slr =  "Side_L_R" & #cne#>
                        <cfset st =  "Status" & #cne#>
                        <cfset lc =  "Comments" & #cne#>
                        <cfset lpn =  "PhotoNumber" & #cne#>
                        <cfset QuerySetCell(qFiltered, "#lp#", #LesionPresent#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#lete#", #LesionType#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#slr#", #Side_L_R#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#st#", #Status#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#lc#", #Comments#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#lpn#", #PhotoNumber#, qFiltered.currentRow)>
                    </cfloop>
                </cfif>
            </cfif>
        </cfloop>
    <!--- Data set after filtering --->
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

    <cfquery name="cetaceans" datasource="#variables.dsn#">
        select ID,Code,Name from Cetaceans order by Code ASC
    </cfquery>
    <cfquery name="RTmembers" datasource="#variables.dsn#">
        SELECT * from TLU_ResearchTeamMembers
    </cfquery>
    <cfquery name="users" datasource="#variables.dsn#">
        SELECT * from users
    </cfquery>

    <div id="content" class="content">
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">All Forms Report</a></li>
        </ol>
        <h1 class="page-header">All Forms Report</h1>
        <div class="section-container section-with-top-border p-b-10">
            <div class="row">
                <div class="col-md-12">
                    <cfoutput>
                        <form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="searchAllReports" id="searchAllReports" method="post">
                            <div class="form-row">
                                <input type="hidden" name="pge" id="pge" value="#pg#">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Survey Route</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                    <select class="form-control" name="surveyRoute">
                                            <option value="">Select Survey Route</option>
                                            <cfloop query="#getSurveyRouteData#">
                                                <option value="#ID#" >#ROUTENAME#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Body Condition</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="BodyCondition" name="BodyCondition">
                                            <option value="">Select Body Condition</option>
                                            <option value="1">1-Emaciated</option>
                                            <option value="2">2-Underweight/Thin</option>
                                            <option value="3">3-Ideal</option>
                                            <option value="4">4-Overweight</option>
                                            <option value="5">5-Obese</option>
                                            <option value="6">6-CBD</option>
                                            
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
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
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Survey Type</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="surveyType">
                                            <option value="">Select Survey Type</option>
                                            <cfloop query="#getSurveyType#">
                                                <option value="#type#" >#type#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Lesions</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                            <select class="form-control customLesionSelect" id="LesionType" name="LesionType">
                                                <option value="">Select Lesion Type</option>
                                                <cfloop query="getLesionTypeData">
                                                    <option value="#LesionTypeName#">#LesionTypeName#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Species</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                    <select class="form-control" name="cetaceanSpecies">
                                            <option value="">Select Species</option>
                                            <cfloop query="#qgetCetaceanSpecies#">
                                                <option value="#CetaceanSpeciesName#" >#CetaceanSpeciesName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Code</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="code">
                                            <option value="">Select Code</option>
                                            <cfloop query="#cetaceans#">
                                                <option value="#Code#" >#Code#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Exclude SDR</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="SDR">
                                            <option value="">Select SDR Status</option>
                                            <option value="off" >Yes</option>
                                            <option value="on" >No</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Platform</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                    <select class="form-control" name="platform">
                                            <option value="">Select Platform</option>
                                            <cfloop query="#getPlateForm#">
                                                <option value="#NAME#" >#NAME#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">NOAA Stock</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="NOAAStock">
                                            <option value="">Select NOAA Stock</option>
                                            <cfloop query="#getStock#">
                                                <option value="#ID#" >#STOCKNAME#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Survey Effort</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="surveyEffort">
                                            <option value="">Select Survey Effort</option>
                                            <option value="on" >ON</option>
                                            <option value="off" >OFF</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Condition (from sighting)</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="ConditionFromSighting" id="ConditionFromSighting" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">At ICW Marker</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline  form-control" name="AtICWMarker" id="AtICWMarker" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Sighting Start / End</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="SightingStartEnd" id="SightingStartEnd" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Location</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="location" id="location" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Field Estimate</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="fieldEstimate" id="fieldEstimate" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Activity</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="activity" id="activity" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Behavioral Events</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="behavioralEvents" id="behavioralEvents" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Feeding Ecology</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="feedingEcology" id="feedingEcology" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">Fisheries Interactions</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="fisheriesInteractions" id="fisheriesInteractions" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label">HBOI Vessel Interactions</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="HBOIVesselInteractions" id="HBOIVesselInteractions" value="1" style="width: 25px; height: 25px;" >
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label"> Boating Interactions</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="boatingInteractions" id="boatingInteractions" value="1" style="width: 25px; height: 25px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-6 col-md-8 col-sm-8 col-xs-8 control-label"> Dive Times</label>
                                    <div class="form-group">
                                        <div class="label-checkbox">
                                            <input type="checkbox" class="checkbox-inline " name="divetimes" id="divetimes" value="1" style="width: 25px; height: 25px;">
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
        <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')>
        <cfscript>
            if( isDefined('form.LesionType') and form.LesionType neq "")
            {    
                
                qFiltered=QueryFilter(qFiltered,function(obj){
                
                    return obj.LesionType1 eq #form.LesionType# OR obj.LesionType2 eq #form.LesionType# OR obj.LesionType3 eq #form.LesionType#;
                });
            }  
        </cfscript>
            <div class="section-container section-with-top-border"> 
                <div class="">
                    <table id="allReport" data-order='[[0,"desc"]]' class="table table-bordered table-hover ">
                        <thead>
                        <tr class="inverse">
                            <th>Date</th> 
                            <th>Survey Number</th>
                            <th>Sighting Number</th>
                            <th>Survey Route</th>
                            <th>Survey Type</th> 
                            <th>ResearchTeam</th>
                            <th>Body of Water</th> 
                            <th>Platform</th> 
                            <th>NOAAStock</th> 
                            <th>SurveyEffort</th> 
                            <th>EngineOn</th>
                            <th>EngineOff</th>
                            <th>SurveyStart</th>
                            <th>SurveyEnd</th>
                            <th class="SightingStartEnd hidden">SightingStart</th>
                            <th class="SightingStartEnd hidden">SightingEnd</th>
                            <th class="AtICWMarker hidden">At ICW Marker</th>
                            <th class="location hidden">InitialLatitude</th>
                            <th class="location hidden">InitialLongitude</th>
                            <th class="location hidden">Location</th>
                            <th class="location hidden">AtLatitude</th>
                            <th class="location hidden">AtLongitude</th>
                            <th class="location hidden">EndLatitude</th>
                            <th class="location hidden">EndLongitude</th>
                            
                            <th class="ConditionFromSighting hidden">Weather</th>
                            <th class="ConditionFromSighting hidden">WaveHeight</th>
                            <th class="ConditionFromSighting hidden">Glare</th>
                            <th class="ConditionFromSighting hidden">GlareDirection</th>
                            <th class="ConditionFromSighting hidden">Sightability</th>
                            <th class="ConditionFromSighting hidden">Beaufort</th>
                            <th class="ConditionFromSighting hidden">HabitatDepth</th>
                            <th class="ConditionFromSighting hidden">HabitatName</th>
                            <th class="ConditionFromSighting hidden">WaterTemp</th>
                            <th class="ConditionFromSighting hidden">AirTemp</th>
                            <th class="ConditionFromSighting hidden">WindSpeed</th>
                            <th class="ConditionFromSighting hidden">WindDirection</th>
                            <th class="ConditionFromSighting hidden">TideName</th>
                            <th class="ConditionFromSighting hidden">Salinity</th>
                            <th class="ConditionFromSighting hidden">pH</th>
                            <th class="ConditionFromSighting hidden">DO</th>
                            <th class="ConditionFromSighting hidden">Conductivity</th>
                            <th class="ConditionFromSighting hidden">InitialHeading</th>
                            <th class="ConditionFromSighting hidden">GeneralHeading</th>
                            <th class="ConditionFromSighting hidden">FinalHeading</th>
                            <th class="ConditionFromSighting hidden">AssocBio</th>

                            <th class="fieldEstimate hidden">FE_TotalCetaceans_Max</th>
                            <th class="fieldEstimate hidden">FE_TotalCetaceans_Min</th>
                            <th class="fieldEstimate hidden">FE_TotalCetacean_Best</th>
                            <th class="fieldEstimate hidden">FE_TotalCetacean_takes</th>
                            <th class="fieldEstimate hidden">FE_TotalAdults_Min</th>
                            <th class="fieldEstimate hidden">FE_TotalAdults_Max</th>
                            <th class="fieldEstimate hidden">FE_TotalAdults_Best</th>
                            <th class="fieldEstimate hidden">FE_TotalAdults_takes</th>
                            <th class="fieldEstimate hidden">FE_TotalCalves_Max</th>
                            <th class="fieldEstimate hidden">FE_TotalCalves_Min</th>
                            <th class="fieldEstimate hidden">FE_TotalCalves_Best</th>
                            <th class="fieldEstimate hidden">FE_TotalCalves_takes</th>
                            <th class="fieldEstimate hidden">FE_YoungOfYear_Min</th>
                            <th class="fieldEstimate hidden">FE_YoungOfYear_Max</th>
                            <th class="fieldEstimate hidden">FE_YoungOfYear_Best</th>
                            <th class="fieldEstimate hidden">FE_YoungOfYear_takes</th>
                            <th class="activity hidden">Act_Mill</th>
                            <th class="activity hidden">Act_Feed</th>
                            <th class="activity hidden">Act_Rest</th>
                            <th class="activity hidden">Act_Other</th>
                            <th class="activity hidden">Act_Social</th>
                            <th class="activity hidden">Act_Travel</th>
                            <th class="activity hidden">Act_Prob_Feed</th>
                            <th class="activity hidden">Act_With_Boat</th>
                            <th class="activity hidden">Act_Avoid_Boat</th>
                            <th class="activity hidden">Act_Object_Play</th>
                            <th class="behavioralEvents hidden">BehavioralSpecifics1</th>
                            <th class="behavioralEvents hidden">BehavioralSpecificsN1</th>
                            <th class="behavioralEvents hidden">BehavioralSpecifics2</th>
                            <th class="behavioralEvents hidden">BehavioralSpecificsN2</th>
                            <th class="behavioralEvents hidden">BehavioralSpecifics3</th>
                            <th class="behavioralEvents hidden">BehavioralSpecificsN3</th>
                            <th class="behavioralEvents hidden">BehavioralSpecifics4</th>
                            <th class="behavioralEvents hidden">BehavioralSpecificsN4</th>
                            <th class="feedingEcology hidden">PreySpecies</th>
                            <th class="feedingEcology hidden">Feeding_Lat</th>
                            <th class="feedingEcology hidden">Feeding_Long</th>
                            <th class="feedingEcology hidden">Structure_Present</th>
                            <th class="fisheriesInteractions hidden">NoOfCetaceansWithIn100mOfActiveFisher</th>	
                            <th class="fisheriesInteractions hidden">NoOfFishers</th>
                            <th class="fisheriesInteractions hidden">CetaceanResponsetoFisher_Approach</th>
                            <th class="fisheriesInteractions hidden">CetaceanResponsetoFisher_Neutral</th>
                            <th class="fisheriesInteractions hidden">CetaceanResponsetoFisher_Relocate</th>
                            <th class="fisheriesInteractions hidden">FisherResponsetoCetacean_Approach</th>
                            <th class="fisheriesInteractions hidden">FisherResponsetoCetacean_No Response</th>
                            <th class="fisheriesInteractions hidden">FisherResponsetoCetacean_Pull in Line</th>
                            <th class="fisheriesInteractions hidden">FisherResponsetoCetacean_Relocate</th>
                            <th class="fisheriesInteractions hidden">Depredation</th>
                            <th class="boatingInteractions hidden">NoOfCetaceansWithIn100mOfRecreationVessels</th>
                            <th class="boatingInteractions hidden">NumberOfVessels</th>
                            <th class="boatingInteractions hidden">CetaceanResponseToVessel_Approach</th>
                            <th class="boatingInteractions hidden">CetaceanResponseToVessel_Neutral</th>
                            <th class="boatingInteractions hidden">CetaceanResponseToVessel_Relocate</th>
                            <th class="boatingInteractions hidden">VesselResponseToCetacean_Approach</th>
                            <th class="boatingInteractions hidden">VesselResponseToCetacean_No Response</th>
                            <th class="boatingInteractions hidden">VesselResponseToCetacean_Out Of Gear</th>
                            <th class="boatingInteractions hidden">VesselResponseToCetacean_Relocate</th>
                            <th class="HBOIVesselInteractions hidden">No_of_Cetaceans_wHBOI_Vessel</th>
                            <th class="HBOIVesselInteractions hidden">ReactiontoHBOIVessel_Approach</th>
                            <th class="HBOIVesselInteractions hidden">ReactiontoHBOIVessel_Neutral</th>
                            <th class="HBOIVesselInteractions hidden">ReactiontoHBOIVessel_Relocate</th>
                            <th class="divetimes hidden">StratTimeDive1</th>
                            <th class="divetimes hidden">EndTimeDive1</th>
                            <th class="divetimes hidden">TotalDiveTime1</th>
                            <th class="divetimes hidden">StratTimeDive2</th>
                            <th class="divetimes hidden">EndTimeDive2</th>
                            <th class="divetimes hidden">TotalDiveTime2</th>
                            <th class="divetimes hidden">StratTimeDive3</th>
                            <th class="divetimes hidden">EndTimeDive3</th>
                            <th class="divetimes hidden">TotalDiveTime3</th>
                            <th class="divetimes hidden">StratTimeDive4</th>
                            <th class="divetimes hidden">EndTimeDive4</th>
                            <th class="divetimes hidden">TotalDiveTime4</th>
                            <th class="divetimes hidden">StratTimeDive5</th>
                            <th class="divetimes hidden">EndTimeDive5</th>
                            <th class="divetimes hidden">TotalDiveTime5</th>
                            <th>Camera</th>
                            <th>Lens</th>
                            <th>Photographer</th>
                            <th>Driver</th>
                            <th>Comments</th>
                            <th>CompletedBy</th>
                            <th>BestSighting</th>
                            <th>SDR</th>
                            <th>Code</th>
                            <th>Associates</th> 
                            <th>Cetacean Species</th>
                            <th>Sex</th>
                            <th>Fetals</th>
                            <th>Calf</th>
                            <th>Yoy</th>
                            <th>DScore</th>
                            <th>FB_Number</th>
                            <th>wMom</th>
                            <th>BestShot</th>
                            <th>PhotoAnalysisInitial</th>
                            <th>PhotoAnalysisFinal</th>
                            <th>EnteredBy</th>
                            <th>Body Condition</th>
                            <th>Head_NuchalCrest</th>
                            <th>Head_LateralCervicalReg</th>
                            <th>Head_FacialBones</th>
                            <th>Head_EarOS</th>
                            <th>Head_ChinSkinFolds</th>
                            <th>Body_EpaxialMuscle</th>
                            <th>Body_DorsalRidgeScapula</th>
                            <th>Body_Ribs</th>
                            <th>Tail_TransversePro</th>
                            <cfoutput> 
                                <cfloop index="index" from="1" to="#maximumLesions.MaxLesion#">
                                        <th>LesionPresent#index#</th>
                                        <th>LesionType#index#</th>
                                        <th>Side_L_R#index#</th>
                                        <th>Status#index#</th>
                                        <th>Comments#index#</th>
                                        <th>PhotoNumber#index#</th>
                                </cfloop>
                            </cfoutput>
                        </tr>
                        </thead>
                        <tbody>
                            <cfoutput query="qFiltered" >
                                <tr>
                            
                                    <td>#dateformat(Date, "yyyy-mm-dd")#</td> 
                                    <td>#SurveyID#</td>
                                    <td>#SightingNumber#</td>
                                    <td>
                                        <cfset bd = listToArray(#SurveyRoute#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getSurveyRouteData">
                                            <cfif ArrayContains(bd,#ID#)>#trim(ROUTENAME)#
                                                <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>#SurveyType#</td> 
                                    <td>
                                        <cfset bd = listToArray(#ResearchTeam#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="RTmembers">
                                            <cfif ArrayContains(bd,#RT_ID#)>#trim(RT_MemberName)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#BodyOfWater#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getAreaName">
                                            <cfif ArrayContains(bd,#ID#)>#trim(AreaName)#
                                                <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>#Platform#</td> 
                                    <td>
                                        <cfset bd = listToArray(#NOAAStock#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getStock">
                                            <cfif ArrayContains(bd,#ID#)>#trim(STOCKNAME)#
                                                <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>#SurveyEffort#</td>
                                    <cfif #Platform# eq "Land " or #Platform# eq "Land Survey" or #SurveyType# eq "Trail Camera">
                                        <td></td>
                                        <td></td>
                                    <cfelse>
                                        <td>#DateTimeFormat(EngineOn, "yyyy-mm-dd HH:nn")#</td>
                                        <td>#DateTimeFormat(EngineOff, "yyyy-mm-dd HH:nn")#</td>
                                    </cfif>
                                    <td>#DateTimeFormat(SurveyStart, "HH:nn")#</td>
                                    <td>#DateTimeFormat(SurveyEnd, "HH:nn")#</td>
                                    <td class="SightingStartEnd hidden">#DateTimeFormat(SightingStart, "HH:nn")#</td>
                                    <td class="SightingStartEnd hidden">#DateTimeFormat(SightingEnd, "HH:nn")#</td>
                                    <td class="AtICWMarker hidden">#ICW_Start#</td>
                                    <td class="location hidden">#InitialLatitude#</td>
                                    <td class="location hidden">#InitialLongitude#</td>
                                    <td class="location hidden">#Location#</td>
                                    <td class="location hidden">#AtLatitude#</td>
                                    <td class="location hidden">#AtLongitude#</td>
                                    <td class="location hidden">#EndLatitude#</td>
                                    <td class="location hidden">#EndLongitude#</td>
                                    
                                        <td class="ConditionFromSighting hidden">#Weather#</td>
                                        <td class="ConditionFromSighting hidden">#WaveHeight#</td>
                                        <td class="ConditionFromSighting hidden">#Glare#</td>
                                        <td class="ConditionFromSighting hidden">#GlareDirection#</td>
                                        <td class="ConditionFromSighting hidden">#Sightability#</td>
                                        <td class="ConditionFromSighting hidden">#Beaufort#</td>
                                        <td class="ConditionFromSighting hidden">#HabitatDepth#</td>
                                        <td class="ConditionFromSighting hidden">#HabitatName#</td>
                                        <td class="ConditionFromSighting hidden">
                                            <cfif WaterTemp neq "">
                                                <cfset WaterT = #numberFormat(WaterTemp,'__.0')#>
                                            <cfelse>
                                                <cfset WaterT = #WaterTemp#> 
                                            </cfif>
                                            #WaterT#
                                        </td>
                                        <td class="ConditionFromSighting hidden">
                                            <cfif AirTemp neq "">
                                                <cfset AirT = #numberFormat(AirTemp,'__.0')#>
                                            <cfelse>
                                                <cfset AirT = #AirTemp#> 
                                            </cfif>
                                            #AirT#
                                        </td>
                                        <td class="ConditionFromSighting hidden">#WindSpeed#</td>
                                        <td class="ConditionFromSighting hidden">#WindDirection#</td>
                                        <td class="ConditionFromSighting hidden">#TideName#</td>
                                        <td class="ConditionFromSighting hidden">#Salinity#</td>
                                        <td class="ConditionFromSighting hidden">#pH#</td>
                                        <td class="ConditionFromSighting hidden">#DO#</td>
                                        <td class="ConditionFromSighting hidden">#Conductivity#</td>
                                        <td class="ConditionFromSighting hidden">#InitialHeading#</td>
                                        <td class="ConditionFromSighting hidden">#GeneralHeading#</td>
                                        <td class="ConditionFromSighting hidden">#FinalHeading#</td>
                                        <td class="ConditionFromSighting hidden">
                                            <cfset bd = listToArray(#AssocBio#, ",", false, true)> 
                                            <cfset d = 1>
                                            <cfloop query="qGetAssocBioData">
                                                <cfif ArrayContains(bd,#ASSOCBIOID#)>#trim(ASSOCBIONAME)#
                                                        <cfif arrayLen(bd) gt 1>/</cfif>
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td class="fieldEstimate hidden">#FE_TotalCetaceans_Max#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalCetaceans_Min#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalCetacean_Best#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalCetacean_takes#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalAdults_Min#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalAdults_Max#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalAdults_Best#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalAdults_takes#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalCalves_Max#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalCalves_Min#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalCalves_Best#</td>
                                        <td class="fieldEstimate hidden">#FE_TotalCalves_takes#</td>
                                        <td class="fieldEstimate hidden">#FE_YoungOfYear_Min#</td>
                                        <td class="fieldEstimate hidden">#FE_YoungOfYear_Max#</td>
                                        <td class="fieldEstimate hidden">#FE_YoungOfYear_Best#</td>
                                        <td class="fieldEstimate hidden">#FE_YoungOfYear_takes#</td>
                                        <td class="activity hidden">#Act_Mill#</td>
                                        <td class="activity hidden">#Act_Feed#</td>
                                        <td class="activity hidden">#Act_Rest#</td>
                                        <td class="activity hidden">#Act_Other#</td>
                                        <td class="activity hidden">#Act_Social#</td>
                                        <td class="activity hidden">#Act_Travel#</td>
                                        <td class="activity hidden">#Act_Prob_Feed#</td>
                                        <td class="activity hidden">#Act_With_Boat#</td>
                                        <td class="activity hidden">#Act_Avoid_Boat#</td>
                                        <td class="activity hidden">#Act_Object_Play#</td>
                                        <td class="behavioralEvents hidden">
                                            <cfloop query="getBehaviorsData">
                                                <cfif getBehaviorsData.ID eq #qFiltered.BehavioralSpecifics1#>
                                                        #getBehaviorsData.BehaviorName#
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td class="behavioralEvents hidden">
                                            #BehavioralSpecificsN1#
                                        </td>
                                        <td class="behavioralEvents hidden">
                                            <cfloop query="getBehaviorsData">
                                                <cfif getBehaviorsData.ID eq #qFiltered.BehavioralSpecifics2#>
                                                        #getBehaviorsData.BehaviorName#
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td class="behavioralEvents hidden">
                                            #BehavioralSpecificsN2#
                                        </td>
                                        <td class="behavioralEvents hidden">
                                            <cfloop query="getBehaviorsData">
                                                <cfif getBehaviorsData.ID eq #qFiltered.BehavioralSpecifics3#>
                                                        #getBehaviorsData.BehaviorName#
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td class="behavioralEvents hidden">
                                            #BehavioralSpecificsN3#
                                        </td>
                                        <td class="behavioralEvents hidden">
                                            <cfloop query="getBehaviorsData">
                                                <cfif getBehaviorsData.ID eq #qFiltered.BehavioralSpecifics4#>
                                                        #getBehaviorsData.BehaviorName#
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td class="behavioralEvents hidden">
                                            #BehavioralSpecificsN4#
                                        </td>
                                        <td class="feedingEcology hidden">
                                            <cfset bd = listToArray(#PreySpecies#, ",", false, true)> 
                                            <cfset d = 1>
                                            <cfloop query="getPreySpeciesData">
                                                <cfif ArrayContains(bd,#ID#)>#trim(PreySpeciesName)#
                                                        <cfif arrayLen(bd) gt 1>/</cfif>
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td class="feedingEcology hidden">#Feeding_Lat#</td>
                                        <td class="feedingEcology hidden">#Feeding_Long#</td>
                                        <td class="feedingEcology hidden">
                                            <cfset bd = listToArray(#Structure_Present#, ",", false, true)> 
                                            <cfset d = 1>
                                            <cfloop query="StructureList">
                                                <cfif ArrayContains(bd,#ID#)>#trim(Name)#
                                                        <cfif arrayLen(bd) gt 1>/</cfif>
                                                </cfif>
                                            </cfloop>
                                        </td>
                                        <td class="fisheriesInteractions hidden">#NoOfCetaceansWithIn100mOfActiveFisher#</td>	
                                        <td class="fisheriesInteractions hidden">#NoOfFishers#</td>
                                        <td class="fisheriesInteractions hidden">#CetaceanResponsetoFisher1#</td>
                                        <td class="fisheriesInteractions hidden">#CetaceanResponsetoFisher2#</td>
                                        <td class="fisheriesInteractions hidden">#CetaceanResponsetoFisher3#</td>
                                        <td class="fisheriesInteractions hidden">#FisherResponsetoCetacean1#</td>
                                        <td class="fisheriesInteractions hidden">#FisherResponsetoCetacean2#</td>
                                        <td class="fisheriesInteractions hidden">#FisherResponsetoCetacean3#</td>
                                        <td class="fisheriesInteractions hidden">#FisherResponsetoCetacean4#</td>
                                        <td class="fisheriesInteractions hidden">
                                            <cfif "#Depredation#" eq "High">
                                            Yes
                                            </cfif>
                                            <cfif "#Depredation#" eq "Low">
                                            No
                                            </cfif>
                                        </td>    
                                        <td class="boatingInteractions hidden">#NoOfCetaceansWithIn100mOfRecreationVessels#</td>
                                        <td class="boatingInteractions hidden">#NumberOfVessels#</td>
                                        <td class="boatingInteractions hidden">#CetaceanResponseToVessel1#</td>
                                        <td class="boatingInteractions hidden">#CetaceanResponseToVessel2#</td>
                                        <td class="boatingInteractions hidden">#CetaceanResponseToVessel3#</td>
                                        <td class="boatingInteractions hidden">#VesselResponseToCetacean1#</td>
                                        <td class="boatingInteractions hidden">#VesselResponseToCetacean2#</td>
                                        <td class="boatingInteractions hidden">#VesselResponseToCetacean3#</td>
                                        <td class="boatingInteractions hidden">#VesselResponseToCetacean4#</td>
                                        <td class="HBOIVesselInteractions hidden">#No_of_Cetaceans_wHBOI_Vessel#</td>
                                        <td class="HBOIVesselInteractions hidden">#ReactiontoHBOIVessel1#</td>
                                        <td class="HBOIVesselInteractions hidden">#ReactiontoHBOIVessel2#</td>
                                        <td class="HBOIVesselInteractions hidden">#ReactiontoHBOIVessel3#</td>
                                        <td class="divetimes hidden">#StratTimeDive1#</td>
                                        <td class="divetimes hidden">#EndTimeDive1#</td>
                                        <td class="divetimes hidden">#TotalTimeDive1#</td>
                                        <td class="divetimes hidden">#StratTimeDive2#</td>
                                        <td class="divetimes hidden">#EndTimeDive2#</td>
                                        <td class="divetimes hidden">#TotalTimeDive2#</td>
                                        <td class="divetimes hidden">#StratTimeDive3#</td>
                                        <td class="divetimes hidden">#EndTimeDive3#</td>
                                        <td class="divetimes hidden">#TotalTimeDive3#</td>
                                        <td class="divetimes hidden">#StratTimeDive4#</td>
                                        <td class="divetimes hidden">#EndTimeDive4#</td>
                                        <td class="divetimes hidden">#TotalTimeDive4#</td>
                                        <td class="divetimes hidden">#StratTimeDive5#</td>
                                        <td class="divetimes hidden">#EndTimeDive5#</td>
                                        <td class="divetimes hidden">#TotalTimeDive5#</td>

                                    
                                    <td>#Camera#</td>
                                    <td>#Lens#</td>
                                    <td>#Photographer#</td>
                                    <td>#Driver#</td>
                                    <td>
                                        <div style="width:250px; height:50px; overflow-y:scroll;">#Comments#</div>
                                    </td>
                                    <td>#CompletedBy#</td>
                                    <td>#BestSighting#</td>
                                    <td>#SDR#</td>
                                    <td>#Code#</td>
                                    <td>#Code# #csname#</td>
                                    <td>#CetaceanSpeciesName#</td>
                                    <td>#Sex#</td>
                                    <td>#Fetals#</td>
                                    <td>#Calf#</td>
                                    <td>#Yoy#</td>
                                    <td>#DScore#</td>
                                    <td>#FB_Number#</td>
                                    <td>
                                        <cfif #wMomDropDown# eq 1>
                                            Yes
                                        <cfelseif #wMomDropDown# eq 2>
                                            No
                                        <cfelseif #wMomDropDown# eq 3>
                                            Partial
                                        </cfif>
                                    </td>
                                    <td>#BestShot#</td>
                                    <td>
                                        <cfset bd = listToArray(#PhotoAnalysisInitial#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="users">
                                            <cfif ArrayContains(bd,#user_id#)>#trim(first_name)# #trim(last_name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#PhotoAnalysisFinal#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="users">
                                            <cfif ArrayContains(bd,#user_id#)>#trim(first_name)# #trim(last_name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#EnteredBy#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="users">
                                            <cfif ArrayContains(bd,#user_id#)>#trim(first_name)# #trim(last_name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
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
                                    <td>
                                        <cfset bd = listToArray(#Head_NuchalCrest#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getHeadNuchalCrest">
                                            <cfif ArrayContains(bd,#ID#)>#trim(HNC_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#Head_LateralCervicalReg#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getHeadLateralCervicalReg">
                                            <cfif ArrayContains(bd,#ID#)>#trim(HLCR_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#Head_FacialBones#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getHeadFacialBones">
                                            <cfif ArrayContains(bd,#ID#)>#trim(HFB_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#Head_EarOS#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getHeadEarOS">
                                            <cfif ArrayContains(bd,#ID#)>#trim(HEOS_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#Head_ChinSkinFolds#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getHeadChinSkinFolds">
                                            <cfif ArrayContains(bd,#ID#)>#trim(HCSF_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#Body_EpaxialMuscle#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getBodyEpaxialMuscle">
                                            <cfif ArrayContains(bd,#ID#)>#trim(BEM_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#Body_DorsalRidgeScapula#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getBodyDorsalRidgeScapula">
                                            <cfif ArrayContains(bd,#ID#)>#trim(BDRS_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#Body_Ribs#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getBodyRibs">
                                            <cfif ArrayContains(bd,#ID#)>#trim(BR_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <td>
                                        <cfset bd = listToArray(#Tail_TransversePro#, ",", false, true)> 
                                        <cfset d = 1>
                                        <cfloop query="getTailTransversePro">
                                            <cfif ArrayContains(bd,#ID#)>#trim(TTP_Name)#
                                                    <cfif arrayLen(bd) gt 1>/</cfif>
                                            </cfif>
                                        </cfloop>
                                    </td>
                                    <cfloop index="cn" from="1" to="#maximumLesions.MaxLesion#">
                                    
                                        <cfset a =  "LesionPresent">
                                        <cfset b =  "LesionType">
                                        <cfset c =  "Side_L_R">
                                        <cfset d =  "Status">
                                        <cfset e =  "Comments">
                                        <cfset f =  "PhotoNumber">
                                        <td>#Evaluate(a&cn)#</td>
                                        <td>#Evaluate(b&cn)#</td>
                                        <td>#Evaluate(c&cn)#</td>
                                        <td>#Evaluate(d&cn)#</td>
                                        <td>#Evaluate(e&cn)#</td>
                                        <td>#Evaluate(f&cn)#</td>
                                    </cfloop>
                                </tr>
                            </cfoutput>
                        </tbody>
                    </table>
                </div>
                <!--- <cfif qFiltered.recordCount neq 0>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 text-right">
                            <button type="button" name="excelExport" value ="Download as Excel" onclick='excel()' class="btn btn-success width-123 m-r-5  ml-auto">Export Excel</button>
                        </div>
                </div>
                </cfif>   --->
            </div>
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