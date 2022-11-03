<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
    <cftry>
    
    <cfset qgetIncidentReportType = Application.SightingNew.getIncidentReportType()>
<!---     <cfset qgetIncidentReports = Application.IncidentReport.getIncidentReports()> --->
    <cfset qgetIR_CountyLocation = Application.SightingNew.getIR_CountyLocation()>
    <cfparam name="startHereIndex" default="1">
    <cfparam name="form.searchword" default="">
    
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">Incident Report List</a></li>
        </ol>
        <!-- end breadcrumb -->
        <!-- begin page-header -->
        <h1 class="page-header">Incident Report List </h1>
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
                        <div class="form-group col-lg-4 col-md-6 col-sm-12">
                            <label class="col-lg-4 col-md-4 col-sm-12 control-label top-fld">Date Range</label>
                            <div class="input-wrap col-lg-8 col-md-8 col-sm-12">
                                <div id="Date-range" class="input-group">
                                    <input type="text"  class="form-control" value="<cfif  isDefined('form.date')>#form.date#</cfif>" name="date" id="date" placeholder="Select Date Range">
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-primary"onclick="showdate()"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-lg-4 col-md-6 col-sm-12">
                            <label class="control-label col-sm-3 top-fld" >Type:</label>
                            <div class="col-sm-9">
                                <select class="form-control" name="IR_Type" id="IR_Type">
                                    <option value="">Select Type</option>
                                    <cfloop query="qgetIncidentReportType">
                                        <option value="#qgetIncidentReportType.ID#" <cfif  isDefined('form.IR_Type') and form.IR_Type eq #qgetIncidentReportType.ID#>selected</cfif>>
                                        #qgetIncidentReportType.IR_Type#
                                        </option>
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-lg-4 col-md-6 col-sm-12">
                            <label class="control-label col-sm-4 top-fld">County/Location:</label>
                            <div class="col-sm-8">
                                <select class="form-control" name="IR_CountyLocation" id="IR_CountyLocation">
                                    <option value="">Select County/Location</option>
                                    <cfloop query="qgetIR_CountyLocation">
                                        <option value="#qgetIR_CountyLocation.ID#" <cfif isDefined('form.IR_CountyLocation') and form.IR_CountyLocation eq #qgetIR_CountyLocation.ID#>selected</cfif>>
                                        #qgetIR_CountyLocation.IR_CountyLocation#
                                        </option>
                                    </cfloop>
                                </select>
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
            <cfset  qGetIncidentReports = Application.IncidentReport.getIncidentReportsWithFilters(form)>
        
            <div class="section-container  p-b-10">
                <cfif qGetIncidentReports.recordcount NEQ 0>
                    <table id="data-table" data-order='[[3,"desc"]]' class="table table-bordered table-hover panel">
                        <thead>
                        <tr class="inverse">
                            <th>Report Title</th>
                            <th>Type</th>
                            <th>County/Location</th>
                            <th>Date</th>
                        </tr>
                        </thead>
                        <tbody>
                        <cfoutput query="qGetIncidentReports" >
                            <tr class="gradeU" id="remov_#qGetIncidentReports.ID#">
                                <td>#qGetIncidentReports.IR_title#</td>
                                <td>#Application.IncidentReport.getIR_IR_TypeName(qGetIncidentReports.IR_Type)#</td>
                                <td> #Application.IncidentReport.getIR_CountyLocationName(qGetIncidentReports.IR_CountyLocation)#</td>
                                <td>#DateFormat(qGetIncidentReports.IR_Date,"YYYY-MM-DD")#</td>
                            </tr>
                        </cfoutput>
                        </tbody>
                    </table>
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