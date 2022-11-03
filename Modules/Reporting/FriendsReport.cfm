<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <cfset variables.dsn = "wildfins_new">
    <cfif structKeyExists(session, 'exportData')>
        <cfset  structDelete(session, 'exportData')>
    </cfif>
    <cfset today = now()>

    <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>

    <cfif isdefined('form.cetaceanSpecies') and form.cetaceanSpecies neq ''>
        <cfquery name="cetaceans" datasource="#variables.dsn#">
             SELECT Cetaceans.ID,Cetaceans.Code,TLU_CetaceanSpecies.CetaceanSpeciesName
            FROM Cetaceans
            LEFT JOIN TLU_CetaceanSpecies
            ON Cetaceans.CetaceanSpecies = TLU_CetaceanSpecies.ID
            WHERE TLU_CetaceanSpecies.ID = '#form.cetaceanSpecies#'
            order by code Asc
        </cfquery>
    </cfif>
   
    <cfif (isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')) and isdefined('form.CetaceanId') and  form.CetaceanId neq '0'>
        <cfset qGetCetacean = Application.Cetaceans.getCetacean(argumentCollection="#Form#")>
        <cfset Sighting_ID = ValueList(qGetCetacean.Sighting_ID,",")>
        <cfset code = qGetCetacean.Code>
        <cfif Sighting_ID NEQ ''>
            <cfquery datasource="#variables.dsn#" name="allCount"  result="r">
                SELECT CONCAT(Cetaceans.Code, ' - ', Cetaceans.Name) as CetaceanCodeName, Cetaceans.Sex,COUNT(*) as timesseen
                FROM Cetacean_Sightings
                inner join Cetaceans
                on
                Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID
                where Cetacean_Sightings.Sighting_ID IN (#Sighting_ID#)
                AND Cetaceans.CODE != '#code#'
                GROUP BY
                Cetaceans.Name,Cetaceans.Code,Cetaceans.Sex,Cetaceans.ID

            </cfquery>
        </cfif>
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
    </cfif>
    <cfif  not isDefined('form.pge')>
        <cfset pg = 1>
    </cfif>
    <div id="content" class="content">
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">Friend Report</a></li>
        </ol>
        <h1 class="page-header">Friend Report</h1>
        <div class="section-container section-with-top-border p-b-10">
            <div class="row">
                <div class="col-md-12">
                    <cfoutput>
                        <form action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="searchAllReports" id="searchAllReports" method="post">
                            <div class="form-row">
                                
                                <input type="hidden" name="pge" id="pge" value="<cfif isdefined('form.CetaceanId') and  form.CetaceanId neq '0'>#pg#<cfelse>1</cfif>">
                                
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Species</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                    <select class="form-control" name="cetaceanSpecies" onchange="getcode()"required>
                                            <option value="0">Select Species</option>
                                            <cfloop query="#qgetCetaceanSpecies#">
                                                <option class="species-option" value="#id#" <cfif isDefined('form.cetaceanSpecies') and form.cetaceanSpecies eq #id#>selected</cfif>>#CetaceanSpeciesName#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-4 col-md-6 col-sm-12">
                                    <label class="col-lg-4 col-md-4 col-sm-12 control-label">Code</label>
                                    <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                        <select class="form-control" name="CetaceanId"required>
                                            <option id="first" value="0">Select Code</option>
                                        <cfif isdefined('form.cetaceanSpecies') and form.cetaceanSpecies neq ''>
                                            <cfloop query="#cetaceans#">
                                                <option value="#ID#" <cfif isDefined('form.CetaceanId') and form.CetaceanId eq #ID#>selected</cfif>>#Code#</option>
                                            </cfloop>
                                        </cfif>
                                        </select>
                                    </div>
                                </div>
                            </div>  
                            <div class="form-row friend-btn-flex">
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
        <cfif (isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')) and isdefined('form.CetaceanId') and  form.CetaceanId neq '0'>
            <div class="section-container section-with-top-border"> 
                <div class="">
                    <table id="allReport"  class="table table-bordered table-hover Ftable" style="width: 374px;margin-left: inherit;">
                        <thead>
                        <tr class="inverse">
                            <th>Friends(Code-Name)</th>
                            <th>Sex</th>
                            <th>Times Seen</th>
                        </tr>
                        </thead>
                        <tbody>
                            <cfoutput query="allCount" startRow="#local.paginationStruct['startCount']#" maxRows ="#rowsPerPage#">
                                <tr>
                                    <td>#allCount.CetaceanCodeName#</td>
                                    <td>#allCount.Sex#</td>
                                    <td>#allCount.timesseen#</td>
                                </tr>
                            </cfoutput>
                        </tbody>
                    </table>
                </div>
                <cfif allCount.recordCount neq 0>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 text-right">
                            <button type="button" onclick="excel()" class="btn btn-success width-123 m-r-5  ml-auto">Export Excel</button>
                        </div>
                    </div>
                </cfif>   
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
            <cfset  session.exportData = allCount>
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
            <li><a href="javascript:;">Friend Report</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>


<style>
    .friend-btn-flex {
        flex-wrap: nowrap !important;
    }

    .text-left {
        text-align: left !important;
    }
</style>