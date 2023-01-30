<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <cfset variables.dsn = "wildfins_new">
    <cfif structKeyExists(session, 'exportData')>
        <cfset  structDelete(session, 'exportData')>
    </cfif>
    <cfset today = now()>
    <cfif  not isDefined('form.pge')>
        <cfset pg = 1>
    </cfif>
    <cfset getSurveyRouteData = Application.StaticDataNew.getSurveyRoute()>
    
    <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')>
        <cfif isdefined("form.date") and form.date NEQ "">
        <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
        <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
        </cfif>
        <cfif NOT isDefined('form.LesionType')>
            <cfset LType = ''>
        <cfelse>
            <cfset LType = listFirst(form.LesionType)>
        </cfif>
        <cfquery datasource="#variables.dsn#" name="allCount"  result="r">
            SELECT s.*,
            cs.Cetaceans_ID AS Cetaceans_I,
            FE_TotalCetacean_takes,
            c.code as cscode,
            ss.ID AS sightingID, 
            hncr.HNC_Name as Head_NuchalCrest,
            hlcr.HLCR_Name as Head_LateralCervicalReg,
            hfb.HFB_Name as Head_FacialBones,
            heos.HEOS_Name as Head_EarOS,
            hcsf.HCSF_Name as Head_ChinSkinFolds,
            bem.BEM_Name as Body_EpaxialMuscle,
            bdrs.BDRS_Name as Body_DorsalRidgeScapula,
            br.BR_Name as Body_Ribs,
            ttp.TTP_Name as Tail_TransversePro
            FROM Surveys s
            LEFT JOIN Survey_Sightings ss ON s.ID= ss.Project_ID
            LEFT JOIN Cetacean_Sightings cs ON ss.ID= cs.Sighting_ID
            LEFT JOIN Cetaceans c ON cs.Cetaceans_ID= c.ID
            LEFT JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
            left join TLU_HeadNuchalCrest hncr on hncr.ID = cs.Head_NuchalCrest
            left join TLU_HeadLateralCervicalReg hlcr on hlcr.ID= cs.Head_LateralCervicalReg
            left join TLU_HeadFacialBones hfb on hfb.ID=cs.Head_FacialBones
            left join TLU_HeadEarOS heos on heos.ID=cs.Head_EarOS
            left join TLU_HeadChinSkinFolds hcsf on hcsf.ID=cs.Head_ChinSkinFolds
            left join TLU_BodyEpaxialMuscle bem on bem.ID = cs.Body_EpaxialMuscle
            left join TLU_BodyDorsalRidgeScapula bdrs on bdrs.ID = cs.Body_DorsalRidgeScapula
            left join TLU_BodyRibs br on br.ID=cs.Body_Ribs
            left join TLU_TailTransversePro ttp on ttp.ID= cs.Tail_TransversePro
            where 1=1
            <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), s.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
            <cfif isdefined("form.surveyRoute") and form.surveyRoute neq ""> and CONCAT(',', s.SurveyRoute, ',') LIKE '%,#form.surveyRoute#,%'</cfif>
            <cfif isdefined("form.bodycondition") and form.bodycondition neq ""> and cs.BodyCondition = '#form.bodycondition#'</cfif>
            <cfif isdefined("form.Head_NuchalCrest") and form.Head_NuchalCrest neq ""> and cs.Head_NuchalCrest = '#form.Head_NuchalCrest#'</cfif>
            <cfif isdefined("form.Head_LateralCervicalReg") and form.Head_LateralCervicalReg neq ""> and cs.Head_LateralCervicalReg = '#form.Head_LateralCervicalReg#'</cfif>
            <cfif isdefined("form.Head_FacialBones") and form.Head_FacialBones neq ""> and cs.Head_FacialBones = '#form.Head_FacialBones#'</cfif>
            <cfif isdefined("form.Head_EarOS") and form.Head_EarOS neq ""> and cs.Head_EarOS = '#form.Head_EarOS#'</cfif>
            <cfif isdefined("form.Head_ChinSkinFolds") and form.Head_ChinSkinFolds neq ""> and cs.Head_ChinSkinFolds = '#form.Head_ChinSkinFolds#'</cfif>
            <cfif isdefined("form.Body_EpaxialMuscle") and form.Body_EpaxialMuscle neq ""> and cs.Body_EpaxialMuscle = '#form.Body_EpaxialMuscle#'</cfif>
            <cfif isdefined("form.Body_DorsalRidgeScapula") and form.Body_DorsalRidgeScapula neq ""> and cs.Body_DorsalRidgeScapula = '#form.Body_DorsalRidgeScapula#'</cfif>
            <cfif isdefined("form.Body_Ribs") and form.Body_Ribs neq ""> and cs.Body_Ribs = '#form.Body_Ribs#'</cfif>
            <cfif isdefined("form.Tail_TransversePro") and form.Tail_TransversePro neq ""> and cs.Tail_TransversePro = '#form.Tail_TransversePro#'</cfif>
            <cfif isdefined("form.code")  and form.code neq ""> and c.Code = '#form.code#'</cfif>
            <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies neq ""> and tlu.CetaceanSpeciesName = '#form.cetaceanSpecies#'</cfif>
            AND ss.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
            AND s.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
        </cfquery>
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
            <cfset pn =  "Lesion_Photo" & #oo#>
            <cfset cn =  "Lesion_Comments" & #oo#>
            <cfset QueryAddColumn(allCount, "#lp#","varchar",[""])>
            <cfset QueryAddColumn(allCount, "#lete#","varchar",[""])>
            <cfset QueryAddColumn(allCount, "#re#","varchar",[""])>
            <cfset QueryAddColumn(allCount, "#slr#","varchar",[""])>
            <cfset QueryAddColumn(allCount, "#st#","varchar",[""])>
            <cfset QueryAddColumn(allCount, "#pn#","varchar",[""])>
            <cfset QueryAddColumn(allCount, "#cn#","varchar",[""])>
        </cfloop>
        <cfloop query="allCount">
            <cfif #sightingID# neq "" and #Cetaceans_I# neq ""> 
                <!--- Query get lesion data against a cetacean and sighting ID --->
                <cfquery datasource="#variables.dsn#" name="cldd">
                    SELECT SurveyID,SightingNumber,Sighting_ID,Cetaceans_ID,LesionPresent,LesionType,Region,Side_L_R,Status,PhotoNumber as Lesion_Photo,Comments as Lesion_Comments,ID
                    FROM Condition_Lesions cl
                    where cl.Sighting_ID = #sightingID# and cl.Cetaceans_ID='#cscode#'
                </cfquery>
                <cfif cldd.RECORDCOUNT gte 1 >
                    <cfset cc = 0>
                    <!--- loop for seting columns data  --->
                    <cfloop query="cldd" > 
                        <cfset cc = incrementValue(#cc#)> 
                        <cfset lp =  "LesionPresent" & #cc#>
                        <cfset lete =  "LesionType" & #cc#>
                        <cfset re =  "Region" & #cc#>
                        <cfset slr =  "Side_L_R" & #cc#>
                        <cfset st =  "Status" & #cc#>
                        <cfset pn =  "Lesion_Photo" & #cc#>
                        <cfset cn =  "Lesion_Comments" & #cc#>
                        <cfset QuerySetCell(allCount, "#lp#", #LesionPresent#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#lete#", #LesionType#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#slr#", #Side_L_R#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#st#", #Status#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#pn#", #Lesion_Photo#, allCount.currentRow)>
                        <cfset QuerySetCell(allCount, "#cn#", #Lesion_Comments#, allCount.currentRow)>
                        <cfif #Region# NEQ "">
                            <cfset regionN = Application.Cetaceans.getRegionNamebyId(Region)>
                            <cfset QuerySetCell(allCount, "#re#", #regionN#, allCount.currentRow)>
                        </cfif>
                    </cfloop>
                </cfif>
            </cfif>
        </cfloop>
        <cfscript>
            if(LType neq "")
            {    
                allCount=QueryFilter(allCount,function(obj){
                
                    return obj.LesionType1 eq #LType# OR obj.LesionType2 eq #LType# OR obj.LesionType3 eq #LType#;
                });
            }else{
                allCount=QueryFilter(allCount,function(obj){
                    return obj.LesionType1 neq "" OR obj.LesionType2 neq "" OR obj.LesionType3 neq "";
                });
            }
            if( isDefined('form.Region') and form.Region neq "")
            {    
                allCount=QueryFilter(allCount,function(obj){
                
                    return obj.Region1 eq #form.Region# OR obj.Region2 eq #form.Region# OR obj.Region3 eq #form.Region#;
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
            s.DATE,
            s.id as SurveyID,
            s.SurveyRoute,
            ss.SightingNumber,
            FE_TotalCetacean_takes,
            FE_TotalAdults_takes,
            FE_TotalCalves_takes,
            FE_YoungOfYear_takes,
            c.code as Code,
            c.code as Associates,
            tlu.CetaceanSpeciesName,
            cs.bodyCondition,
            hncr.HNC_Name as Head_NuchalCrest,
            hlcr.HLCR_Name as Head_LateralCervicalReg,
            hfb.HFB_Name as Head_FacialBones,
            heos.HEOS_Name as Head_EarOS,
            hcsf.HCSF_Name as Head_ChinSkinFolds,
            bem.BEM_Name as Body_EpaxialMuscle,
            bdrs.BDRS_Name as Body_DorsalRidgeScapula,
            br.BR_Name as Body_Ribs,
            ttp.TTP_Name as Tail_TransversePro,
            ss.ID AS sightingID
            FROM
            Surveys s
            LEFT JOIN Survey_Sightings ss ON s.ID= ss.Project_ID
            LEFT JOIN Cetacean_Sightings cs ON ss.ID= cs.Sighting_ID
            LEFT JOIN Cetaceans c ON cs.Cetaceans_ID= c.ID
            LEFT JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
            left join TLU_HeadNuchalCrest hncr on hncr.ID = cs.Head_NuchalCrest
            left join TLU_HeadLateralCervicalReg hlcr on hlcr.ID= cs.Head_LateralCervicalReg
            left join TLU_HeadFacialBones hfb on hfb.ID=cs.Head_FacialBones
            left join TLU_HeadEarOS heos on heos.ID=cs.Head_EarOS
            left join TLU_HeadChinSkinFolds hcsf on hcsf.ID=cs.Head_ChinSkinFolds
            left join TLU_BodyEpaxialMuscle bem on bem.ID = cs.Body_EpaxialMuscle
            left join TLU_BodyDorsalRidgeScapula bdrs on bdrs.ID = cs.Body_DorsalRidgeScapula
            left join TLU_BodyRibs br on br.ID=cs.Body_Ribs
            left join TLU_TailTransversePro ttp on ttp.ID= cs.Tail_TransversePro
            where 1=1
            <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), s.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
            <cfif isdefined("form.surveyRoute") and form.surveyRoute neq ""> and CONCAT(',', s.SurveyRoute, ',') LIKE '%,#form.surveyRoute#,%'</cfif>
            <cfif isdefined("form.BodyCondition") and form.BodyCondition neq ""> and cs.BodyCondition = '#form.BodyCondition#'</cfif>
            <cfif isdefined("form.Head_NuchalCrest") and form.Head_NuchalCrest neq ""> and cs.Head_NuchalCrest = '#form.Head_NuchalCrest#'</cfif>
            <cfif isdefined("form.Head_LateralCervicalReg") and form.Head_LateralCervicalReg neq ""> and cs.Head_LateralCervicalReg = '#form.Head_LateralCervicalReg#'</cfif>
            <cfif isdefined("form.Head_FacialBones") and form.Head_FacialBones neq ""> and cs.Head_FacialBones = '#form.Head_FacialBones#'</cfif>
            <cfif isdefined("form.Head_EarOS") and form.Head_EarOS neq ""> and cs.Head_EarOS = '#form.Head_EarOS#'</cfif>
            <cfif isdefined("form.Head_ChinSkinFolds") and form.Head_ChinSkinFolds neq ""> and cs.Head_ChinSkinFolds = '#form.Head_ChinSkinFolds#'</cfif>
            <cfif isdefined("form.Body_EpaxialMuscle") and form.Body_EpaxialMuscle neq ""> and cs.Body_EpaxialMuscle = '#form.Body_EpaxialMuscle#'</cfif>
            <cfif isdefined("form.Body_DorsalRidgeScapula") and form.Body_DorsalRidgeScapula neq ""> and cs.Body_DorsalRidgeScapula = '#form.Body_DorsalRidgeScapula#'</cfif>
            <cfif isdefined("form.Body_Ribs") and form.Body_Ribs neq ""> and cs.Body_Ribs = '#form.Body_Ribs#'</cfif>
            <cfif isdefined("form.Tail_TransversePro") and form.Tail_TransversePro neq ""> and cs.Tail_TransversePro = '#form.Tail_TransversePro#'</cfif>
            <cfif isdefined("form.surveyType")  and form.surveyType  neq ""> and s.SurveyType = '#form.surveyType#'</cfif>
            <cfif isdefined("form.code")  and form.code neq ""> and c.Code = '#form.code#'</cfif>
            <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies neq ""> and tlu.CetaceanSpeciesName = '#form.cetaceanSpecies#'</cfif>
            AND s.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
            AND ss.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
            ORDER BY s.ID 
        </cfquery>
        <cfset rr = 0>
        <!--- loop for adding columns in main query --->
        <cfloop index="index" from="1" to="#maximumLesions.MaxLesion#">
                <cfset rr = incrementValue(#rr#)> 
                <cfset lp =  "LesionPresent" & #rr#>
                <cfset lete =  "LesionType" & #rr#>
                <cfset re =  "Region" & #rr#>
                <cfset slr =  "Side_L_R" & #rr#>
                <cfset st =  "Status" & #rr#>
                <cfset cn =  "Lesion_Comments" & #rr#>
                <cfset pn =  "Lesion_Photo" & #rr#>
                <cfset QueryAddColumn(qFiltered, "#lp#","varchar",[""])>
                <cfset QueryAddColumn(qFiltered, "#lete#","varchar",[""])>
                <cfset QueryAddColumn(qFiltered, "#re#","varchar",[""])>
                <cfset QueryAddColumn(qFiltered, "#slr#","varchar",[""])>
                <cfset QueryAddColumn(qFiltered, "#st#","varchar",[""])>
                <cfset QueryAddColumn(qFiltered, "#cn#","varchar",[""])>
                <cfset QueryAddColumn(qFiltered, "#pn#","varchar",[""])>
        </cfloop>
        <cfloop query="qFiltered">
            <cfif #sightingID# neq "" and #Code# neq ""> 
                <!--- Query get lesion data against a cetacean and sighting ID --->
                <cfquery datasource="#variables.dsn#" name="cldd">
                    SELECT SurveyID,SightingNumber,Sighting_ID,Cetaceans_ID,LesionPresent,LesionType,Region,Side_L_R,Status,PhotoNumber as Lesion_Photo,Comments as Lesion_Comments,ID
                    FROM Condition_Lesions cl
                    where cl.Sighting_ID = #sightingID# and cl.Cetaceans_ID='#Code#'
                </cfquery>
                <cfif cldd.RECORDCOUNT gte 1 >
                    <cfset cne = 0>
                    <!--- loop for seting columns data  --->
                    <cfloop query="cldd"> 
                        <cfset cne = incrementValue(#cne#)> 
                        <cfset lp =  "LesionPresent" & #cne#>
                        <cfset lete =  "LesionType" & #cne#>
                        <cfset re =  "Region" & #cne#>
                        <cfset slr =  "Side_L_R" & #cne#>
                        <cfset st =  "Status" & #cne#>
                        <cfset pn =  "Lesion_Photo" & #oo#>
                        <cfset cn =  "Lesion_Comments" & #oo#>
                        <cfset QuerySetCell(qFiltered, "#lp#", #LesionPresent#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#lete#", #LesionType#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#slr#", #Side_L_R#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#st#", #Status#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#pn#", #Lesion_Photo#, qFiltered.currentRow)>
                        <cfset QuerySetCell(qFiltered, "#cn#", #Lesion_Comments#, qFiltered.currentRow)>
                        <cfif #Region# NEQ "">
                            <cfset regionN = Application.Cetaceans.getRegionNamebyId(Region)>
                            <cfset QuerySetCell(qFiltered, "#re#", #regionN#, qFiltered.currentRow)>
                        </cfif>
                    </cfloop>
                </cfif>
            </cfif>
            <cfset bd = listToArray(#SurveyRoute#, ",", false, true)>
            <cfset SurveyRouteA = arrayNew(1,false)> 
            <cfloop query="getSurveyRouteData">
                <cfif ArrayContains(bd,#ID#)>
                    <cfset arn = ArrayAppend(SurveyRouteA,#ROUTENAME#,"true")>
                </cfif>
            </cfloop>
            
            <cfset AssociateValue=[]>
            <cfquery name="qgetAssociate" datasource="#Application.dsn#"  >
                SELECT cs.Sighting_ID,ss.id,cs.Cetaceans_ID from Cetacean_Sightings cs
                JOIN Survey_Sightings ss ON cs.Sighting_ID = ss.id
                JOIN Surveys s ON s.ID = ss.Project_ID
                where cs.Sighting_ID = #sightingID#
            </cfquery>
            <cfloop query="qgetAssociate" >
                <cfquery name="qgetAssociateValue" datasource="#Application.dsn#"  >
                SELECT * from Cetaceans                                        
                where id = '#qgetAssociate.CETACEANS_ID#'
            </cfquery> 
            <cfset ArrayAppend(AssociateValue,qgetAssociateValue.Code,"true") >                                                                      
            </cfloop>
            <!--- <cfdump var="#Replace(AssociateValue.toList(), ",", ", ", "ALL")#" abort="true"> --->
        
            <cfset Associatess = '#Replace(AssociateValue.toList(), ",", " ", "ALL")#'>
            <cfset QuerySetCell(qFiltered, "Associates", #Associatess#, qFiltered.currentRow)>     
           


            <cfset df = arrayToList(SurveyRouteA,"\")>
            <cfset QuerySetCell(qFiltered, "SurveyRoute", #df#, qFiltered.currentRow)>
            <cfif "#bodyCondition#" eq 1>
                <cfset QuerySetCell(qFiltered, "bodyCondition","Emaciated", qFiltered.currentRow)>                           
            </cfif>
            <cfif "#bodyCondition#" eq 2>
                <cfset QuerySetCell(qFiltered, "bodyCondition","Underweight/Thin", qFiltered.currentRow)>
            </cfif>
            <cfif "#bodyCondition#" eq 3>
                <cfset QuerySetCell(qFiltered, "bodyCondition","Ideal", qFiltered.currentRow)>
            </cfif>
            <cfif "#bodyCondition#" eq 4>
                <cfset QuerySetCell(qFiltered, "bodyCondition","Overweight", qFiltered.currentRow)>
            </cfif>
            <cfif "#bodyCondition#" eq 5>
                <cfset QuerySetCell(qFiltered, "bodyCondition","Obese", qFiltered.currentRow)>
            </cfif>
            <cfif "#bodyCondition#" eq 6>
                <cfset QuerySetCell(qFiltered, "bodyCondition","CBD", qFiltered.currentRow)>
            </cfif>
        </cfloop>
        <!--- Data set after filtering --->
    </cfif>

    <cfset getAreaName =  Application.Sighting.getAreaName()>
    <cfset getSurveyArea = Application.Sighting.getSurveyArea()>
    <cfset getSurveyType = Application.Sighting.getType()>
    <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>
    <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>
    <cfset bodyConditions = ['Emaciated','Underweight/Thin','Ideal','Overweight','Obese','CBD']>
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


    <cfif isdefined('form.cetaceanSpecies') and form.cetaceanSpecies neq ''>
        <cfquery name="cetaceans" datasource="#variables.dsn#">
             SELECT Cetaceans.ID,Cetaceans.Code,TLU_CetaceanSpecies.CetaceanSpeciesName
            FROM Cetaceans
            LEFT JOIN TLU_CetaceanSpecies
            ON Cetaceans.CetaceanSpecies = TLU_CetaceanSpecies.ID
            WHERE TLU_CetaceanSpecies.CetaceanSpeciesName = '#form.cetaceanSpecies#'
            order by code Asc
        </cfquery>
    </cfif>
    
    <cfquery name="users" datasource="#variables.dsn#">
        SELECT * from users
    </cfquery>
    <cfquery name="lesionRegion" datasource="#variables.dsn#">
        SELECT * from TLU_Regions
    </cfquery>

    <div id="content" class="content">
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">Lesion Report</a></li>
        </ol>
        <h1 class="page-header">Lesion Report</h1>
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
                                            <input type="text"  class="form-control" name="date" id="date" placeholder="Select Date Range" value="<cfif isDefined('form.date') and form.date neq ''>#form.date#</cfif>">
                                            <span class="input-group-btn">
                                                <button type="button" id="dateButton" onclick="showdate()" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Species</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                    <select class="form-control" name="cetaceanSpecies" onchange="getcode()">
                                            <option value="">Select Species</option>
                                            <cfloop query="#qgetCetaceanSpecies#">
                                                <option value="#CetaceanSpeciesName#" <cfif isDefined('form.cetaceanSpecies') and form.cetaceanSpecies eq #CetaceanSpeciesName#>selected</cfif>>#CetaceanSpeciesName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Survey Route</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                    <select class="form-control" name="surveyRoute">
                                            <option value="">Select Survey Route</option>
                                            <cfloop query="#getSurveyRouteData#">
                                                <option value="#ID#" <cfif isDefined('form.surveyRoute') and form.surveyRoute eq #ID#>selected</cfif>>#ROUTENAME#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Code</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="code">
                                            <option id="first" value="">Select Code</option>
                                        <cfif isdefined('form.cetaceanSpecies') and form.cetaceanSpecies neq ''>
                                            <cfloop query="#cetaceans#">
                                                <option value="#Code#" <cfif isDefined('form.code') and form.code eq #Code#>selected</cfif>>#Code#</option>
                                            </cfloop>
                                        </cfif>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Lesion Type</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control search-box customLesionSelect" id="LesionType" name="LesionType" multiple>
                                            <cfloop query="getLesionTypeData">
                                                <option value="#LesionTypeName#" <cfif isDefined('form.LesionType') and ListFind(form.LesionType,getLesionTypeData.LesionTypeName)>selected</cfif>>#LesionTypeName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Region</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                    <select class="form-control" name="Region">
                                            <option value="">Select Region</option>
                                            <cfloop query="lesionRegion">
                                                <option value="#regionname#" <cfif isDefined('form.Region') and form.Region eq #regionname#>selected</cfif>>#regionname#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Body Condition</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="bodycondition">
                                            <option value="">Select Body Condition</option>
                                            <cfloop from="1" to="#ArrayLen(bodyConditions)#" index="j">
                                                <option value="#j#" <cfif isDefined('form.bodycondition') and form.bodycondition eq #j#>selected</cfif>>#j&' - '&bodyConditions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                  
                                </div>
                            
                                <!---  <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Nuchal Crest</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Head_NuchalCrest" name="Head_NuchalCrest">
                                            <option value="">Select Nuchal Crest</option>
                                            <cfloop query="getHeadNuchalCrest">
                                               <option value="#getHeadNuchalCrest.ID#"<cfif isDefined('form.Head_NuchalCrest') and form.Head_NuchalCrest eq #getHeadNuchalCrest.ID#>selected</cfif>>#getHeadNuchalCrest.HNC_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                            
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Lateral Cervical Region</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Head_LateralCervicalReg" name="Head_LateralCervicalReg">
                                            <option value="">Select Lateral Cervical Region</option>
                                            <cfloop query="getHeadLateralCervicalReg">
                                               <option value="#getHeadLateralCervicalReg.ID#"<cfif isDefined('form.Head_LateralCervicalReg') and form.Head_LateralCervicalReg eq #getHeadLateralCervicalReg.ID#>selected</cfif>>#getHeadLateralCervicalReg.HLCR_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Facial Bones</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Head_FacialBones" name="Head_FacialBones">
                                            <option value="">Select Facial Bones</option>
                                            <cfloop query="getHeadFacialBones">
                                               <option value="#getHeadFacialBones.ID#"<cfif isDefined('form.Head_FacialBones') and form.Head_FacialBones eq #getHeadFacialBones.ID#>selected</cfif>>#getHeadFacialBones.HFB_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Ear OS</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Head_EarOS" name="Head_EarOS">
                                            <option value="">Select Ear OS</option>
                                            <cfloop query="getHeadEarOS">
                                               <option value="#getHeadEarOS.ID#"<cfif isDefined('form.Head_EarOS') and form.Head_EarOS eq #getHeadEarOS.ID#>selected</cfif>>#getHeadEarOS.HEOS_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Chin Skin Folds</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Head_ChinSkinFolds" name="Head_ChinSkinFolds">
                                            <option value="">Select Chin Skin Folds</option>
                                            <cfloop query="getHeadChinSkinFolds">
                                               <option value="#getHeadChinSkinFolds.ID#"<cfif isDefined('form.Head_ChinSkinFolds') and form.Head_ChinSkinFolds eq #getHeadChinSkinFolds.ID#>selected</cfif>>#getHeadChinSkinFolds.HCSF_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Epaxial Muscle</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Body_EpaxialMuscle" name="Body_EpaxialMuscle">
                                            <option value="">Select Epaxial Muscle</option>
                                            <cfloop query="getBodyEpaxialMuscle">
                                               <option value="#getBodyEpaxialMuscle.ID#"<cfif isDefined('form.Body_EpaxialMuscle') and form.Body_EpaxialMuscle eq #getBodyEpaxialMuscle.ID#>selected</cfif>>#getBodyEpaxialMuscle.BEM_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Dorsal Ridge of Scapula</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Body_DorsalRidgeScapula" name="Body_DorsalRidgeScapula">
                                            <option value="">Select Dorsal Ridge of Scapula</option>
                                            <cfloop query="getBodyDorsalRidgeScapula">
                                               <option value="#getBodyDorsalRidgeScapula.ID#"<cfif isDefined('form.Body_DorsalRidgeScapula') and form.Body_DorsalRidgeScapula eq #getBodyDorsalRidgeScapula.ID#>selected</cfif>>#getBodyDorsalRidgeScapula.BDRS_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Ribs</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Body_Ribs" name="Body_Ribs">
                                            <option value="">Select Ribs</option>
                                            <cfloop query="getBodyRibs">
                                               <option value="#getBodyRibs.ID#"<cfif isDefined('form.Body_Ribs') and form.Body_Ribs eq #getBodyRibs.ID#>selected</cfif>>#getBodyRibs.BR_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Transverse Processes</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" id="Tail_TransversePro" name="Tail_TransversePro">
                                            <option value="">Select Transverse Processes</option>
                                            <cfloop query="getTailTransversePro">
                                               <option value="#getTailTransversePro.ID#"<cfif isDefined('form.Tail_TransversePro') and form.Tail_TransversePro eq #getTailTransversePro.ID#>selected</cfif>>#getTailTransversePro.TTP_Name#</option>
                                            </cfloop>
                                         </select>
                                    </div>
                                </div>
                            </div>--->
                            <div class="form-row btn-flex">
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
            </div>
        </div>
        <cfif isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')>
            <cfscript>
                if(LType neq "")
                {    
                    qFiltered=QueryFilter(qFiltered,function(obj){
                    
                        return obj.LesionType1 eq #LType# OR obj.LesionType2 eq #LType# OR obj.LesionType3 eq #LType#;
                    });
                }else{
                    qFiltered=QueryFilter(qFiltered,function(obj){
                        return obj.LesionType1 neq "" OR obj.LesionType2 neq "" OR obj.LesionType3 neq "";
                    });
                } 
                if( isDefined('form.Region') and form.Region neq "")
                {    
                    qFiltered=QueryFilter(qFiltered,function(obj){
                        return obj.Region1 eq #form.Region# OR obj.Region2 eq #form.Region# OR obj.Region3 eq #form.Region#;
                    });
                }
            </cfscript>
            
            <div class="section-container section-with-top-border"> 
                <div class="">
                    <cfif qFiltered.recordCount neq 0>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-right" style="position: absolute;
                            right: 12px; width: 10%; z-index: 2;">
                                <button type="button" onclick="excel()" class="btn btn-success width-123 m-r-5  ml-auto">Export All</button>
                            </div>
                        </div>
                    </cfif>   
                    <table id="allReport" data-order='[[0,"desc"]]' class="table table-bordered table-hover ">
                        <thead>
                        <tr class="inverse">
                            <th>Date</th> 
                            <th>SurveyID</th> 
                            <th>Survey Route</th>
                            <th>Sighting Number</th>
                            <th>FE_TOTALCETACEAN_TAKES</th>
                            <th>FE_TOTALADULTS_TAKES</th>
                            <th>FE_TOTALCALVES_TAKES</th>
                            <th>FE_YOUNGOFYEAR_TAKES</th>
                            <th>Code</th>
                            <th>Associates</th>
                            <th>CetaceanSpeciesName</th>
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
                                        <th>Region#index#</th>
                                        <th>Side_L_R#index#</th>
                                        <th>Status#index#</th>
                                        <th>Lesion_Comments#index#</th>
                                        <th>Lesion_Photo#index#</th>
                                </cfloop>
                            </cfoutput>
                        </tr>
                        </thead>
                        <tbody>
                            <cfoutput query="qFiltered" startRow="#local.paginationStruct['startCount']#" maxRows ="#rowsPerPage#">
                                <tr>
                            
                                    <td>#dateformat(Date, "yyyy-mm-dd")#</td> 
                                    <td>#SurveyID#</td>
                                    <td>
                                        #SurveyRoute#
                                    </td>
                                    <td>#SightingNumber#</td>
                                    <td>#FE_TotalCetacean_takes#</td>
                                    <td>#FE_TotalAdults_takes#</td>
                                    <td>#FE_TotalCalves_takes#</td>
                                    <td>#FE_YoungOfYear_takes#</td>

                                    <td>#Code#</td>
                                    <!--- <td>#Code#</td> --->
                                    <cfset AssociateValue=[]>
                                    <cfquery name="qgetAssociate" datasource="#Application.dsn#"  >
                                        SELECT cs.Sighting_ID,ss.id,cs.Cetaceans_ID from Cetacean_Sightings cs
                                        JOIN Survey_Sightings ss ON cs.Sighting_ID = ss.id
                                        JOIN Surveys s ON s.ID = ss.Project_ID
                                        where cs.Sighting_ID = #sightingID#
                                    </cfquery>
                                    <cfloop query="qgetAssociate" >
                                        <cfquery name="qgetAssociateValue" datasource="#Application.dsn#"  >
                                        SELECT * from Cetaceans                                        
                                        where id = '#qgetAssociate.CETACEANS_ID#'
                                    </cfquery> 
                                    <cfset ArrayAppend(AssociateValue,qgetAssociateValue.Code,"true") >                                                                      
                                    </cfloop>
                               
                                    <td>#Replace(AssociateValue.toList(), ",", " ", "ALL")#</td>
                                    <td>#CetaceanSpeciesName#</td>
                                    <td>
                                        #bodyCondition#
                                    </td>
                                    <td>
                                        #Head_NuchalCrest#
                                    </td>
                                    <td>
                                        #Head_LateralCervicalReg#
                                    </td>
                                    <td>
                                        #Head_FacialBones#
                                    </td>
                                    <td>
                                        #Head_EarOS#
                                    </td>
                                    <td>
                                        #Head_ChinSkinFolds#
                                    </td>
                                    <td>
                                        #Body_EpaxialMuscle#
                                    </td>
                                    <td>
                                        #Body_DorsalRidgeScapula#
                                    </td>
                                    <td>
                                        #Body_Ribs#
                                    </td>
                                    <td>
                                        #Tail_TransversePro#
                                    </td>
                                    <cfloop index="cn" from="1" to="#maximumLesions.MaxLesion#">
                                        <cfset a =  "LesionPresent">
                                        <cfset b =  "LesionType">
                                        <cfset r =  "Region">
                                        <cfset c =  "Side_L_R">
                                        <cfset d =  "Status">
                                        <cfset c =  "Lesion_Comments" >
                                        <cfset p =  "Lesion_Photo" >
                                        <td>#Evaluate(a&cn)#</td>
                                        <td>#Evaluate(b&cn)#</td>
                                        <td>#Evaluate(r&cn)#</td>
                                        <td>#Evaluate(c&cn)#</td>
                                        <td>#Evaluate(d&cn)#</td>
                                        <td>#Evaluate(c&cn)#</td>
                                        <td>#Evaluate(p&cn)#</td>
                                    </cfloop>
                                </tr>
                            </cfoutput>
                        </tbody>
                    </table>
                </div>
                <!--- <cfif qFiltered.recordCount neq 0>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 text-right">
                            <button type="button" onclick="excel()" class="btn btn-success width-123 m-r-5  ml-auto">Export Excel</button>
                        </div>
                    </div>
                </cfif>    --->
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
            <cfset QueryDeleteColumn(qFiltered, "SIGHTINGID")>
            <cfset  session.exportData = qFiltered>
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
    .select2.select2-container.select2-container--default {
        width: 100% !important;
    }

    .btn-flex {
        flex-wrap: nowrap !important;
    }

    .text-left {
        text-align: left !important;
    }
</style>