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
                
                <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies neq ""> and tlu.CetaceanSpeciesName = '#form.cetaceanSpecies#'</cfif>
                <cfif isdefined("form.platform") and form.platform neq ""> and s.platform = '#form.platform#'</cfif>
                <cfif isdefined("form.NOAAStock") and form.NOAAStock neq ""> and s.NOAAStock like '%#form.NOAAStock#%'</cfif>
                <cfif isdefined("form.surveyEffort") and form.surveyEffort neq ""> and ss.Survey = '#form.surveyEffort#'</cfif>
                <cfif isdefined("form.Dscore") and form.Dscore neq ""> and c.Dscore = '#form.Dscore#'</cfif>
                <cfif isdefined("form.Qscore") and form.Qscore neq ""> and cs.Qscore IN (<cfqueryparam value="#form.Qscore#" list="true" cfsqltype="cf_sql_varchar">)</cfif>
                <cfif isdefined("form.SDR")  and form.SDR neq ""> and cs.SDR = '#form.SDR#'</cfif>
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

            <cfset oo = 0>
            <cfloop index="index" from="1" to="#maximumLesions.MaxLesion#">
                <cfset oo = incrementValue(#oo#)> 
                <cfset lp =  "LesionPresent" & #oo#>
                <cfset tn =  "TypeName" & #oo#>
                <cfset lete =  "LesionType" & #oo#>
                <cfset re =  "Region" & #oo#>
                <cfset slr =  "Side_L_R" & #oo#>
                <cfset st =  "Status" & #oo#>
                <cfset lc =  "Comments" & #oo#>
                <cfset lpn =  "PhotoNumber" & #oo#>
                <cfset QueryAddColumn(allCount, "#lp#","varchar",[""])>
                <cfset QueryAddColumn(allCount, "#tn#","varchar",[""])>
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
                        SELECT SurveyID,SightingNumber,Sighting_ID,Cetaceans_ID,LesionPresent,LesionType,Region,Side_L_R,Status,PhotoNumber,ID, Comments,TypeName
                        FROM Condition_Lesions cl
                        where cl.Sighting_ID = #sightingID# and cl.Cetaceans_ID='#cscode#' 
                       
                    </cfquery>
                
                    <cfif cldd.RECORDCOUNT gte 1 >
                        <cfset cc = 0>
                        <!--- loop for seting columns data  --->
                        <cfloop query="cldd" > 
                            <cfset cc = incrementValue(#cc#)> 
                            <cfset lp =  "LesionPresent" & #cc#>
                            <cfset tn =  "TypeName" & #cc#>
                            <cfset lete =  "LesionType" & #cc#>
                            <cfset re =  "Region" & #cc#>
                            <cfset slr =  "Side_L_R" & #cc#>
                            <cfset st =  "Status" & #cc#>
                            <cfset lc =  "Comments" & #cc#>
                            <cfset lpn =  "PhotoNumber" & #cc#>
                            <cfset QuerySetCell(allCount, "#lp#", #LesionPresent#, allCount.currentRow)>
                            <cfset QuerySetCell(allCount, "#tn#", #TypeName#, allCount.currentRow)>
                            <cfset QuerySetCell(allCount, "#lete#", #LesionType#, allCount.currentRow)>
                            <cfset QuerySetCell(allCount, "#re#", #Region#, allCount.currentRow)>
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
                if( isDefined('form.Typename') and form.Typename neq "")
                {    
                    
                    qFiltered=QueryFilter(allCount,function(obj){
                    
                        return obj.Typename1 eq #form.Typename# OR obj.Typename2 eq #form.Typename# OR obj.Typename3 eq #form.Typename#;
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
                ss. WaveHeight,
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
                ss.Act_Mill,
                ss.Act_Feed,
                ss.Act_Prob_Feed,
                ss.Act_Travel,
                ss.Act_Object_Play,
                ss.Act_Rest,
                ss.Act_Social,
                ss.Act_With_Boat,
                ss.Act_Avoid_Boat,
                ss.Act_Other,
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
                c.Sex,
                c.code as Code,
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
                cs.PhotoAnalysisInitial,
                cs.PhotoAnalysisFinal,
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



                AND s.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value="1">
                
                
                
                ORDER BY s.ID 
                
                
            </cfquery>

            

            <cfset rr = 0>
            <!--- loop for adding columns in main query --->
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

            <cfloop query="qFiltered" >
                
                <cfif #sightingID# neq "" and #Code# neq ""  >
                    <cfquery datasource="#variables.dsn#" name="cldd">
                        SELECT 
                        SurveyID, 
                        SightingNumber, 
                        Sighting_ID, 
                        Cetaceans_ID, 
                        LesionPresent, 
                        LesionType, Region, 
                        Side_L_R,
                        Status,
                        PhotoNumber,
                        ID,
                        Comments, 
                        TypeName
                        FROM Condition_Lesions cl
                        where cl.Sighting_ID = #sightingID# and cl.Cetaceans_ID='#Code#' 
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
                            <cfif #Region# NEQ "">
                                <cfset regionN = Application.Cetaceans.getRegionNamebyId(Region)>
                                <cfset QuerySetCell(qFiltered, "#re#", #regionN#, qFiltered.currentRow)>
                            </cfif>
                        </cfloop>
                    </cfif>
                </cfif>
            </cfloop>



        </cfif>

        

       
    
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
                            <div class="form-row">
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Survey Route:</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="SurveyRoute">
                                            <cfloop query="getSurveyRouteData">
                                                <option value="#getSurveyRouteData.ID#" <cfif isdefined("form.SurveyRoute") and listFind(form.SurveyRoute, getSurveyRouteData.ID)>selected</cfif>>#getSurveyRouteData.RouteName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Behavioral Event Number :</label>
                                    <div class="col-sm-8">
                                        <input type="number" min="0" id="BehavioralSpecificsNumber"  name="BehavioralSpecificsNumber" class="form-control">
                                    </div>
                                </div>
                            </div>    
                            <div class="form-row">
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Survey Effort :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" name="surveyEffort" id="surveyEffort">
                                            <option value="">Select Survey Effort</option>
                                            <option value="on" <cfif isdefined("form.surveyEffort") and form.surveyEffort eq 'on'>selected</cfif> >ON</option>
                                            <option value="off" <cfif isdefined("form.surveyEffort") and form.surveyEffort eq 'off'>selected</cfif> >OFF</option>
                                        </select>
                                    </div>
                                </div>
                            </div>    
                            <div class="form-row">
                                
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Qscore :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="Qscore" id="Qscore">
                                            <option value="Q-1" <cfif isDefined("form.Qscore") and listFind(form.Qscore, "Q-1")>selected</cfif>>Q-1</option>
                                            <option value="Q-2" <cfif isDefined("form.Qscore") and listFind(form.Qscore, "Q-2")>selected</cfif>>Q-2</option>
                                            <option value="Q-3" <cfif isDefined("form.Qscore") and listFind(form.Qscore, "Q-3")>selected</cfif>>Q-3</option>
                                            
                                        </select>
                                    </div>
                                </div>
                                
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label col-sm-4 top-fld">Lesion :</label>
                                    <div class="col-sm-8">
                                        <select class="form-control search-box" multiple="multiple" name="LesionType" id="LesionType">
                                            <option value="">Select Lesion</option>
                                            <cfloop query="getLesionTypeData">
                                                <option  value="#getLesionTypeData.LesionTypeName#" <cfif isdefined("form.LesionType") and listFind(form.LesionType, getLesionTypeData.LesionTypeName)>selected</cfif> >#getLesionTypeData.LesionTypeName#</option>       
                                            </cfloop>
                                        </select>
                                        
                                    </div>
                                </div>
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
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
                                            <input type="checkbox" class="checkbox-inline  form-control" name="CetaceanLifeHistoryInfo" id="CetaceanLifeHistoryInfo" value="1" style="width: 25px; height: 25px;">
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
            <cfif isdefined("form.btnSearchSightings")>
                <!--- <cfset  qGetIncidentReports = Application.IncidentReport.getIncidentReportsWithFilters(form)> --->

                <cfscript>
                    if( isDefined('form.LesionType') and form.LesionType neq "")
                    {    
                        
                        qFiltered=QueryFilter(qFiltered,function(obj){
                        
                            return obj.LesionType1 eq #form.LesionType# OR obj.LesionType2 eq #form.LesionType# OR obj.LesionType3 eq #form.LesionType#;
                        });
                    } 


                </cfscript>
            
                <div class="section-container  p-b-10">
                    <cfif qFiltered.recordcount NEQ 0>
                        <table id="allReport" class="table table-bordered table-hover" style="margin-left: initial;">
                            <thead>
                                <tr class="inverse">
                                    <th>Date</th>                                    
                                    <cfif structKeyExists(form, "surveyinfo") AND form.surveyinfo EQ "1">
                                        <th>Survey ID</th>
                                        <th>Engine On</th>
                                        <th>Engine Off</th>
                                        <th>Survey Start</th>
                                        <th>Survey End</th>
                                        <th>Research Team</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "sightingInfo") AND form.sightingInfo EQ "1">
                                        <th>Sighting ID</th>
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
                                        <th>Fisher response to cetacean (Approach)</th>
                                        <th>Fisher response to cetacean (No Response)</th>
                                        <th>Fisher response to cetacean (Pull in Line)</th>
                                        <th>Fisher response to cetacean (Relocate)</th>
                                        <th>Depredation</th>
                                    </cfif>
                                    <cfif structKeyExists(form, "BoatingInteractions") AND form.BoatingInteractions EQ "1">
                                        <th>No of cetaceans w'in 100 m of recreational vessels</th>
                                        <th>No of Vessels</th>
                                        <th>Cetacean Response to Vessel (Approach)</th>
                                        <th>Cetacean Response to Vessel (Neutral)</th>
                                        <th>Cetacean Response to Vessel (Relocate)</th>
                                        <th>Vessel Response to Cetaceans (Approach)</th>
                                        <th>Vessel Response to Cetaceans (No Response)</th>
                                        <th>Vessel Response to Cetaceans (Pull in Line)</th>
                                        <th>Vessel Response to Cetaceans (Relocate)</th>
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
                                    <cfif structKeyExists(form, "Misc") AND form.Misc EQ "1">
                                        <th>Assocaited Bio</th>
                                        <th>Initial Heading</th>
                                        <th>Genral Heading</th>
                                        <th>Final Heading</th>
                                        <th>Comments</th>
                                        <th>Camera</th>
                                        <th>Lens</th>
                                    </cfif>

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
                                    
                                    
                                    <th>Survey Route</th>
                                    <th>Body of Water</th>
                                    <th>Platform</th>
                                    <th>NOAAStock</th>
                                    <th>Survey Type</th>
                                    <th>CetaceanSpeciesName</th>
                                    <th>Code</th>
                                    <th>Research Team</th>

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
                                    <th>Act_Other</th>                                     --->
                                </tr>
                            </thead>
                            <tbody>
                                <cfoutput query="qFiltered" >
                                    <tr>
                                        <td>#dateformat(Date, "yyyy-mm-dd")#</td>
                                        <cfif structKeyExists(form, "surveyinfo") AND form.surveyinfo EQ "1">
                                            <td>#SurveyID#</td>
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
                                            <td>#SightingID#</td>
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
                                            <td>#FisherResponsetoCetacean1#</td>
                                            <td>#FisherResponsetoCetacean2#</td>
                                            <td>#FisherResponsetoCetacean3#</td>
                                            <td>#FisherResponsetoCetacean4#</td>
                                            <td>#Depredation#</td>
                                        </cfif>
                                        <cfif structKeyExists(form, "BoatingInteractions") AND form.BoatingInteractions EQ "1">
                                            <td>#NoOfCetaceansWithIn100mOfRecreationVessels#</td>
                                            <td>#NumberOfVessels#</td>
                                            <td>#CetaceanResponsetoVessel1#</td>
                                            <td>#CetaceanResponsetoVessel2#</td>
                                            <td>#CetaceanResponsetoVessel3#</td>
                                            <td>#VesselResponsetoCetacean1#</td>
                                            <td>#VesselResponseToCetacean2#</td>
                                            <td>#VesselResponsetoCetacean3#</td>
                                            <td>#VesselResponsetoCetacean4#</td>
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
                                        </cfif>

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
                                        <td>#Platform#</td>
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
                                        <td>#SurveyType#</td>
                                        <td>#CetaceanSpeciesName#</td>
                                        <td>#Code#</td>
                                        
                                        <td>
                                            <!--- #ResearchTeam# --->
                                            <cfset bd = listToArray(#ResearchTeam#, ",", false, true)>
                                            <cfset d = 1>
                                            <cfloop query="RTmembers">
                                                <cfif ArrayContains(bd,#RT_ID#)>#trim(RT_MemberName)#
                                                        <cfif arrayLen(bd) gt 1>/</cfif>
                                                </cfif>
                                            </cfloop>
                                        </td>
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
