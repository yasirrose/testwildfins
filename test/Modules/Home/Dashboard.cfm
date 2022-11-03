<cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>
<cfset getSurveyRouteData = Application.StaticDataNew.getSurveyRoute()>
<cfset qgetTrackingList= Application.StaticDataNew.getTrackingList()>
<cfset qgetCategory= Application.StaticDataNew.getCategory()>
<cfoutput>
    <div id="content" class="content">
        <form id="myform" action="" method="post">
            <div class="form-wrapper">
                <div class="form-holder row">
                    <div class="form-group col-lg-12">
                        <h3 class="m-0">Total Takes</h3>
                    </div>
                    <div class="form-group col-lg-3">
                        <div class="input-wrap">
                            <select class="form-control" name="species" id="species_takes" onchange="getTotalTakesByFilters()">
                                <option value="">Species</option>
                                <cfloop query="qgetCetaceanSpecies">
                                    <cfif active eq 1>
                                        <option value="#qgetCetaceanSpecies.id#">
                                            #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                                    </cfif>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-lg-3">
                        <div class="input-wrap">
                            <div id="Date-range-takes" class="input-group">
                                <input type="text" class="form-control" name="date" id="date_takes" placeholder="Date Range" onchange="getTotalTakesByFilters()">
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary"onclick="takesdate()"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-lg-3">
                        <div class="input-wrap">
                            <select class="form-control" name="surveyRoute" id="surveyRoute_takes" onchange="getTotalTakesByFilters()">
                                <option value="">Survey Route</option>
                                <cfloop query="#getSurveyRouteData#">
                                    <option value="#ID#" >#ROUTENAME#</option>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-wrapper">
                <div class="form-holder values-wrapper row">
                    <div class="col-lg-3">
                        <h3 class="m-0">Total</h3>
                        <div class="values-wrap">
                            <h2 id="Total"></h2>
                        </div>
                    </div>
                     <div class="col-lg-3">
                        <h3 class="m-0">Adults</h3>
                        <div class="values-wrap">
                            <h2 id="Adults"></h2>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <h3 class="m-0">Calves</h3>
                        <div class="values-wrap">
                            <h2 id="Calves"></h2>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <h3 class="m-0">YoY</h3>
                        <div class="values-wrap">
                            <h2 id="YoY"></h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-wrapper">
                <div class="form-holder row">
                    <div class="form-group col-lg-12">
                        <h3 class="m-0">Known Animals</h3>
                    </div>
                    <div class="form-group col-lg-3">
                        <div class="input-wrap">
                            <select class="form-control" name="species" id="species_animals" onchange="getAnimalsByFilters()">
                                <option value="">Species</option>
                                <cfloop query="qgetCetaceanSpecies">
                                    <cfif active eq 1>
                                        <option value="#qgetCetaceanSpecies.id#">
                                            #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                                    </cfif>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-lg-3">
                        <div class="input-wrap">
                            <div id="Date-range-animals" class="input-group">
                                <input type="text" class="form-control" name="Animaldate" id="date_animals" placeholder="Date Range" onchange="getAnimalsByFilters()">
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary"onclick="dateshow()"><i class="fa fa-calendar"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-lg-3">
                        <div class="input-wrap">
                            <select class="form-control" name="surveyRoute" id="surveyRoute_animals" onchange="getAnimalsByFilters()">
                                <option value="">Survey Route</option>
                                <cfloop query="#getSurveyRouteData#">
                                    <option value="#ID#" >#ROUTENAME#</option>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-wrapper">
                <div class="form-holder values-wrapper row">
                    <div class="col-lg-3">
                        <h3 class="m-0">Total Animals</h3>
                        <div class="values-wrap">
                            <h2 id="Total_animals"></h2>
                        </div>
                    </div>
                     <div class="col-lg-3">
                        <h3 class="m-0">Adults</h3>
                        <div class="values-wrap">
                            <h2 id="Adults_animals"></h2>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <h3 class="m-0">Calves</h3>
                        <div class="values-wrap">
                            <h2 id="Calves_animals"></h2>
                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/gh/linways/table-to-excel@v1.0.4/dist/tableToExcel.js"></script>
                <div class="form-holder values-wrapper row">
                    <div class="col-lg-3 tracking-lists">
                            <h3 class="m-0 tr-tl">Code List</h3>
                        <div class="exp-btn">
                            <button class="btn btn-success " type="button" onclick="exportExcel(this)">Export</button>
                        </div>
                        <div class="code-list-sec">
                        <div class="code-list-rwo">
                        <table id="CodesDOD" class="table table-bordered table-hover" data-cols-width="10,20">
                            <thead>
                                <tr class="inverse">
                                    <th>Code</th>
                                    <th>
                                        Date of Death
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="tracking-lists">
                            <div class="row tracking-l-ro">
                                <div class="form-group col-lg-3">
                                    <h3 class="m-0">Tracking Lists</h3>
                                </div>
                                <div class="form-group col-lg-3">
                                    <div class="input-wrap">
                                        <select class="form-control" name="species" id="species" onchange="getDataByFilter()">
                                            <option value="">Species</option>
                                            
                                                    <option value="5">
                                                        Tursiops truncatus </option>
                                                
                                                    <option value="6">
                                                        Megaptera novaeangliae </option>
                                                
                                                    <option value="7">
                                                        Kogia breviceps </option>
                                                
                                                    <option value="8">
                                                        Stenella frontalis </option>
                                                
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-3">
                                    <div class="input">
                                        <select class="form-control" name="categories" id="categories" onchange="getDataByFilter()">
                                            <option value="">Category</option>
                                            
                                                    <option value="Possible Dead">Possible Dead</option>
                                                
                                                    <option value="Possible Mom with Calf">Possible Mom with Calf</option>
                                                
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-lg-3">
                                    <div class="input">
                                        <select class="form-control" name="status" id="status" onchange="getDataByFilter()">
                                            <option value="1">Active</option>
                                            <option value="0">Inactive</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <table id="trackingHistory" class="table table-bordered table-hover">
                                <thead>
                                    <tr class="inverse">
                                        <th>Species</th>
                                        <th>Code</th>
                                        <th>Name</th>
                                        <th>Category</th>
                                    </tr>
                                </thead>
                                <tbody><tr><td>Tursiops truncatus</td><td>HAPP</td><td>Happy</td><td>Possible Mom with Calf</td></tr><tr><td>Tursiops truncatus</td><td>707</td><td>DecTest04 </td><td>Possible Mom with Calf</td></tr><tr><td>Tursiops truncatus</td><td>aug</td><td>august</td><td>Possible Mom with Calf</td></tr><tr><td>Tursiops truncatus</td><td>aug</td><td>august</td><td>Possible Mom with Calf</td></tr><tr><td>Tursiops truncatus</td><td>NOV18T</td><td>Nov18Test</td><td>Possible Mom with Calf</td></tr><tr><td>Tursiops truncatus</td><td>aug</td><td>august</td><td>Possible Mom with Calf</td></tr><tr><td>Megaptera novaeangliae</td><td>CC1</td><td>test C1</td><td>Possible Mom with Calf</td></tr><tr><td>Tursiops truncatus</td><td>aug</td><td>august</td><td>Possible Mom with Calf</td></tr><tr><td>Stenella frontalis</td><td>UNKTEST</td><td>Unkown Test</td><td>Possible Dead</td></tr><tr><td>Tursiops truncatus</td><td>HAPP</td><td>Happy</td><td>Possible Dead</td></tr></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-holder">
                <div class="row">
                <div class="col-lg-6"></div>
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                             <div class="row re-ro">
                                <div class="form-group col-lg-6">
                                    <h3 class="m-0">Incident Reports</h3>
                                </div>
                                <div class="form-group col-lg-6">
                                    <div class="input-wrap">
                                        <div id="Date-range-incident" class="input-group">
                                            <input type="text"  class="form-control" name="Incident_date" id="Incident_date" placeholder="Select Date Range" onchange="getIncidentReports()">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-primary"onclick="incidentdate()"><i class="fa fa-calendar"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="incident-reports">
                            <table id="incidentReports" class="table table-bordered" style="background: white;">
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                 </div>
            </div>
        </form>    
    </div>
</cfoutput>


<style>
.row.re-ro>[class*=col-] {
    padding: 0px;
}
.code-list-rwo {
    max-height: 434px;
    height: 100%;
    background: #d5d8da;
    overflow-y: scroll;
    margin-bottom: 20px;
    width: 223px;}
.code-list-rwo table {
    margin-bottom: 0;
}
.tr-tl {
    padding-bottom: 15px;
}
.exp-btn {
    padding-bottom: 5px;
}
.row.tracking-l-ro {
    padding-bottom: 30px;
}
    .export{
        margin-left: 76%;
        margin-bottom: -57px;
    }
    .values-wrapper {
        margin-bottom: 30px;
        padding-top: 10px;
    }
    .values-wrap {
        background: #FFF;
        padding: 20px 30px;
        border: 2px solid #c3c1c1;
        border-radius: 5px;
        margin-top: 0px;
        text-align: right;
    }
    .values-wrap h2 {
        margin: 0;
        font-size: 40px;
    }
    .tracking-lists table{
        background: #fff;
    }
    .table thead tr.inverse th {
        color: #333;
        background-color: #e1e7f3 !important;
        border: 1px solid #bec3c6 !important;
    }
    .incident-reports table{
        border-radius: 0px;
        border: 2px solid #ebeced !important;
    }
    @media (max-width: 1199px){
        .row.tracking-l-ro {
    padding-bottom: 0px;
}
.code-list-rwo {
    width: 100%;
}
    }
</style>
