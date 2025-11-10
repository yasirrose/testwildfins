<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
   
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <cfset variables.dsn = "wildfins_new">
    <cfif structKeyExists(session, 'exportData')>
        <cfset  structDelete(session, 'exportData')>
    </cfif>
    <cfset today = now()>

    <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>

   
    <cfif (isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')) >

        <cfif StructKeyExists(Form, "cetaceanSpecies") AND Form.cetaceanSpecies NEQ "">
            <cfset cetaceanSpeciesList = Form.cetaceanSpecies>
        <cfelse>
            <cfset cetaceanSpeciesList = "''">  
        </cfif>

        <cfif isdefined("form.date") and form.date NEQ "">
            <cfset form.startDate = dateformat(ListGetAt(form.date, 1, '-'), 'YYYY-MM-DD')>
            <cfset form.endDate   = dateformat(ListGetAt(form.date, 2, '-'), 'YYYY-MM-DD')>
        </cfif>

        <!--- <cfquery datasource="#variables.dsn#" name="allCount" result="r">
            SELECT DISTINCT
                Survey_Sightings.SightingNumber,
                Cetaceans.CetaceanSpecies,
                Cetaceans.Code,
                Cetaceans.Name,
                Cetaceans.Sex,
                Cetaceans.SourceSexed,
                Cetaceans.FB_Number,
                Cetaceans.YearOfBirth,
                Cetaceans.FirstSightingDate as First_Sighting_Date,
                Cetaceans.ImageName,
                Cetaceans.SecondaryImage,
                Cetaceans.DateDeath as DOD,
                Cetaceans.DateOfBirthEstimate as DOB,
                Cetaceans.DScore,
                Surveys.Date as DateSeen,
                Surveys.ID as Survey_ID,
                Surveys.SurveyRoute as Survey_Route,
                Survey_Sightings.ID as Sighting_ID,
                Survey_Sightings.SightingNumber as SightingNo,
                Survey_Sightings.Project_ID,
                Survey_Sightings.SightingStart,
                Survey_Sightings.FE_Species,
                Surveys.BodyOfWater,
                Surveys.SurveyType,
                Cetacean_Sightings.bodyCondition,
                Cetacean_Sightings.Fetals, 
                Cetacean_Sightings.Calf, 
                Cetacean_Sightings.Yoy,
                CONCAT(Cetaceans.Code, ' - ', Cetaceans.Name) as CetaceanCodeName,
                COUNT(Cetacean_Sightings.Sighting_ID) as timesseen
            FROM Surveys
            LEFT JOIN Survey_Sightings
                ON Surveys.ID = Survey_Sightings.Project_ID
            LEFT JOIN Cetacean_Sightings
                ON Survey_Sightings.ID = Cetacean_Sightings.Sighting_ID
            LEFT JOIN Cetaceans
                ON Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID
            WHERE Survey_Sightings.FE_Species IN (<cfqueryparam value="#cetaceanSpeciesList#" cfsqltype="cf_sql_varchar" list="true">)
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND form.endDate NEQ "">
                AND CONVERT(char(10), Survey_Sightings.SightingStart, 126) BETWEEN <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            AND Surveys.IsDeleted != <cfqueryparam cfsqltype="cf_sql_bit" value="1">
            AND Survey_Sightings.IsDeleted != <cfqueryparam cfsqltype="cf_sql_bit" value="1">
            AND Cetaceans.Code != ''
            GROUP BY
                Survey_Sightings.SightingNumber,
                Cetaceans.CetaceanSpecies,
                Cetaceans.Code,
                Cetaceans.Name,
                Cetaceans.Sex,
                Cetaceans.SourceSexed,
                Cetaceans.FB_Number,
                Cetaceans.YearOfBirth,
                Cetaceans.FirstSightingDate,
                Cetaceans.ImageName,
                Cetaceans.SecondaryImage,
                Cetaceans.DateDeath,
                Cetaceans.DateOfBirthEstimate,
                Cetaceans.DScore,
                Surveys.Date,
                Surveys.ID,
                Surveys.SurveyRoute,
                Survey_Sightings.ID,
                Survey_Sightings.Project_ID,
                Survey_Sightings.SightingStart,
                Survey_Sightings.FE_Species,
                Surveys.BodyOfWater,
                Surveys.SurveyType,
                Cetacean_Sightings.bodyCondition,
                Cetacean_Sightings.Fetals, 
                Cetacean_Sightings.Calf, 
                Cetacean_Sightings.Yoy
            ORDER BY DateSeen DESC
        </cfquery> --->

        <cfquery datasource="#variables.dsn#" name="allCount" result="r">
            SELECT DISTINCT
                Surveys.ID as Survey_ID,
                Survey_Sightings.ID as Sighting_ID,
                Surveys.Date as DateSeen,
                Surveys.SurveyRoute as Survey_Route,
                Surveys.BodyOfWater,
                Surveys.SurveyType,
                Survey_Sightings.SightingNumber as SightingNo,
                Survey_Sightings.Project_ID,
                Survey_Sightings.SightingStart,                
                STRING_AGG(Cetaceans.Code, ' ') AS CetaceanCodes
            FROM Surveys
            LEFT JOIN Survey_Sightings
                ON Surveys.ID = Survey_Sightings.Project_ID
            LEFT JOIN Cetacean_Sightings
                ON Survey_Sightings.ID = Cetacean_Sightings.Sighting_ID
            LEFT JOIN Cetaceans
                ON Cetaceans.ID = Cetacean_Sightings.Cetaceans_ID
            WHERE Survey_Sightings.FE_Species IN (<cfqueryparam value="#cetaceanSpeciesList#" cfsqltype="cf_sql_varchar" list="true">)
            <cfif isdefined("form.startDate") AND form.startDate NEQ "" AND form.endDate NEQ "">
                AND CONVERT(char(10), Survey_Sightings.SightingStart, 126) BETWEEN <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
            </cfif>
            AND Surveys.IsDeleted != <cfqueryparam cfsqltype="cf_sql_bit" value="1">
            AND Survey_Sightings.IsDeleted != <cfqueryparam cfsqltype="cf_sql_bit" value="1">
            AND Cetaceans.Code != ''
            GROUP BY 
                Surveys.ID,
                Survey_Sightings.ID,
                Surveys.Date,
                Surveys.SurveyRoute,
                Survey_Sightings.SightingNumber,
                Survey_Sightings.Project_ID,
                Survey_Sightings.SightingStart,
                Survey_Sightings.FE_Species,
                Surveys.BodyOfWater,
                Surveys.SurveyType
            ORDER BY DateSeen DESC
        </cfquery>
        
        <!--- <cfdump var="#allCount#" abort="true"> --->

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

                                <div class="form-group col-lg-5 col-md-6 col-sm-12">
                                    <label class="col-lg-3 col-md-3 col-sm-12 control-label">Species</label>
                                    <div class="input-wrap col-lg-9 col-md-9 col-sm-12">
                                        <select class="form-control search-box customLesionSelect" id="cetaceanSpecies" name="cetaceanSpecies" multiple required>
                                            <cfloop query="qgetCetaceanSpecies">
                                                <!--- <cfif Active eq 1>
                                                </cfif> --->
                                                    <option class="species-option" value="#id#" 
                                                    <cfif isDefined('form.cetaceanSpecies') and ListFind(form.cetaceanSpecies, id)>selected</cfif>>
                                                    #CetaceanSpeciesName#
                                                </option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>

                         
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
        <cfif (isdefined('FORM.btnSearchSightings') or isdefined('FORM.pge')) >
            <div class="section-container section-with-top-border"> 
                <div class="">
                    <table id="data-table"  class="table table-bordered table-hover Ftable" style="margin-left: inherit;">
                        <thead>
                        <tr class="inverse">
                            <th>Survey ID</th>
                            <th>Sighting ID</th>
                            <th>Sighting Date</th>
                            <th>Friends(Code)</th>
                            <!--- <th>Sex</th>                             
                            <th>Times Seen</th> --->
                        </tr>
                        </thead>
                        <tbody>
                            <cfif isDefined('allCount')>
                                <cfoutput query="allCount" >
                                    <tr>
                                        <td>#SURVEY_ID#</td>
                                        <td>#Sighting_ID#</td>
                                        <td>#DateFormat(SightingStart, "MM-DD-YYYY")#</td>
                                        <td>#CetaceanCodes#</td>
                                        <!--- <td>#allCount.Sex#</td>
                                        <td>#allCount.timesseen#</td> --->
                                    </tr>
                                </cfoutput>
                            </cfif>
                        </tbody>
                    </table>
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
    span.select2.select2-container.select2-container--default.select2-container--below {
        width: 100% !important;
    }
</style>