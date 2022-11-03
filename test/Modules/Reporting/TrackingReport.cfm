<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("Run Report S-S-C", permissions) neq 0>
    <cftry>
    
    <cfset qgetIncidentReportType = Application.SightingNew.getIncidentReportType()>
<!---     <cfset qgetIncidentReports = Application.IncidentReport.getIncidentReports()> --->
    <cfset qgetIR_CountyLocation = Application.SightingNew.getIR_CountyLocation()>
    <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>
    <cfset qgetSampleFBNumber=Application.Stranding.getSampleArchiveFBNumber()>
    <cfset qgetSampleType=Application.StaticDataNew.getSampleType()>
    <cfset qgetPreservationMethod=Application.StaticDataNew.getPreservationMethod()>
    <cfset StorageTypeArray = ['Room Temperature','-80 C','-20 C','-20 F','Refrigerated']>
    <cfparam name="startHereIndex" default="1">
    <cfparam name="form.searchword" default="">
    
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">Sample Archive Report List</a></li>
        </ol>
        <!-- end breadcrumb -->
        <!-- begin page-header -->
        <h1 class="page-header">Sample Archive List </h1>
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
                            <label class="control-label col-sm-3 top-fld" >Field Number</label>
                            <div class="col-sm-9">
                                <select class="form-control" name="sampleFN" id="sampleFN">
                                    <option value="">Select Field Number</option>                               
                                    <cfloop query="qgetSampleFBNumber">
                                        <option value="#qgetSampleFBNumber.Fnumber#" >#qgetSampleFBNumber.Fnumber#</option>
                                        <!--- <cfif isDefined('form.SEID') and form.SEID eq #qgetSampleFBNumber.ID#>selected</cfif> --->
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-lg-4 col-md-6 col-sm-12">
                            <label class="control-label col-sm-4 top-fld">Species</label>
                            <div class="col-sm-8">
                                <select class="form-control" name="Species" id="Species">
                                    <option value="">Select Species</option>
                                    <!--- <cfloop query="qgetIR_CountyLocation"> --->
                                        <cfloop query="#qgetCetaceanSpecies#">
                                            <option value="#qgetCetaceanSpecies.ID#" >#qgetCetaceanSpecies.CetaceanSpeciesName#</option>
                                            <!--- <cfif isDefined('form.cetaceanSpecies') and form.cetaceanSpecies eq #CetaceanSpeciesName#>selected</cfif> --->
                                        </cfloop>
                                    <!--- </cfloop> --->
                                </select>
                            </div>
                        </div>
                        </div>
                        <div class="form-row">
                        <div class="form-group col-lg-4 col-md-6 col-sm-12">
                            <label class="control-label col-sm-3 top-fld" >Sample Type</label>
                            <div class="col-sm-9">
                                <select class="form-control" name="SampleType" id="SampleType">
                                    <option value="">Select Sample Type</option>
                                    <cfloop query="qgetSampleType">
                                        <!--- <cfif status  neq 0> --->
                                            <option value="#qgetSampleType.Type#" >#qgetSampleType.Type#</option>
                                            <!--- <cfif #qgetSampleType.Type# eq #qgetSampleTypeDataSingle.SampleType#>selected</cfif> --->
                                        <!--- </cfif> --->
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-lg-4 col-md-6 col-sm-12">
                            <label class="control-label col-sm-3 top-fld" >Storage Type</label>
                            <div class="col-sm-9">
                                <select class="form-control" name="StorageType" id="StorageType">
                                    <option value="">Select Storage Type</option>
                                        <cfloop from="1" to="#ArrayLen(StorageTypeArray)#" index="j">
                                             <option value="#StorageTypeArray[j]#" >#StorageTypeArray[j]#</option>
                                             <!--- <cfif #StorageTypeArray[j]# eq #qgetSampleTypeDataSingle.StorageType#>selected</cfif> --->
                                     </cfloop>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-lg-4 col-md-6 col-sm-12">
                            <label class="control-label col-sm-4 top-fld">Preservation Method</label>
                            <div class="col-sm-8">
                                <select class="form-control" name="PreservationMethod" id="PreservationMethod">
                                    <option value="">Select Preservation Method</option>
                                        <cfloop query="qgetPreservationMethod">
                                            <!--- <cfif status  neq 0> --->
                                                <option value="#qgetPreservationMethod.Method#" >#qgetPreservationMethod.Method#</option>
                                                <!--- <cfif #qgetPreservationMethod.Method# eq #qgetSampleTypeDataSingle.PreservationMethod#>selected</cfif> --->
                                            <!--- </cfif> --->
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
            <!--- <cfset  qGetSampleReports = Application.IncidentReport.getSampleReportsWithFilters(form)> --->
            <cfif isdefined("form.date") and form.date NEQ "">
                <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
                <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
            </cfif>
            <!--- <cfdump var="#form.startDate#" > --->
            <cfif isdefined("form.date") and form.date EQ "">
                <cfset form.startDate = '2000-01-01'>
                <cfset form.endDate = dateformat(Now(),'YYYY-mm-dd')>
                <!--- <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')> --->
            </cfif>
            <!--- <cfdump var="#form.startDate#" > 
            <cfdump var="#form.endDate#" abort="true"> --->
            <!--- query1 --->
             <cfquery name="qgetSampleReportsWithFilters" datasource="#Application.dsn#">
                SELECT Fnumber,species,ID,StTpye,date FROM ST_SampleArchive 
                Where 1=1
                <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">
                    and CONVERT(char(10), date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'
                </cfif>
                <cfif isdefined("form.sampleFN") and form.sampleFN neq "">
                    and Fnumber = '#form.sampleFN#'
                </cfif>
                <cfif isdefined("form.Species") and form.Species neq "">
                    and Species = '#form.Species#'
                </cfif>
                ORDER BY ID DESC
            </cfquery>

            <div class="section-container  p-b-10">
                <cfif qgetSampleReportsWithFilters.recordcount NEQ 0>
                    <table id="data-table" data-order='[[3,"desc"]]' class="table table-bordered table-hover panel">
                        <thead>
                        <tr class="inverse">
                            <th>Fnumber</th>
                            <th>SampleType</th>
                            <th>StorageType</th>
                            <th>PreservationMethod</th>
                        </tr>
                        </thead>
                        <tbody>

                            <cfoutput>
                                <cfloop query="qgetSampleReportsWithFilters" >
                                    <cfquery name="qgetSampleTypeReportsWithFilters" datasource="#Application.dsn#">
                                        SELECT SampleType,StorageType,ID,PreservationMethod,SA_ID,date FROM ST_SampleType 
                                        Where 1=1
                                        <cfif isdefined("qgetSampleReportsWithFilters.ID") and qgetSampleReportsWithFilters.ID neq "">
                                            and SA_ID = '#qgetSampleReportsWithFilters.ID#'
                                        </cfif>
                                        <cfif isdefined("form.SampleType") and form.SampleType neq "">
                                            and SampleType = '#form.SampleType#'
                                        </cfif>
                                        <cfif isdefined("form.StorageType") and form.StorageType neq "">
                                            and StorageType = '#form.StorageType#'
                                        </cfif>
                                        <cfif isdefined("form.PreservationMethod") and form.PreservationMethod neq "">
                                            and PreservationMethod = '#form.PreservationMethod#'
                                        </cfif>
                                        ORDER BY ID DESC
                                    </cfquery> 
                                <cfloop query="qgetSampleTypeReportsWithFilters" >
                                    <tr class="gradeU" id="remov_#qgetSampleReportsWithFilters.ID#">
                                        <td><cfif isdefined("qgetSampleReportsWithFilters.Fnumber") and qgetSampleReportsWithFilters.Fnumber neq "">#qgetSampleReportsWithFilters.Fnumber#</cfif></td>
                                        <td><cfif isdefined("qgetSampleTypeReportsWithFilters.SampleType") and qgetSampleTypeReportsWithFilters.SampleType neq "">#qgetSampleTypeReportsWithFilters.SampleType#</cfif></td>
                                        <td><cfif isdefined("qgetSampleTypeReportsWithFilters.StorageType") and qgetSampleTypeReportsWithFilters.StorageType neq "">#qgetSampleTypeReportsWithFilters.StorageType#</cfif></td>
                                        <td><cfif isdefined("qgetSampleTypeReportsWithFilters.PreservationMethod") and qgetSampleTypeReportsWithFilters.PreservationMethod neq "">#qgetSampleTypeReportsWithFilters.PreservationMethod#</cfif></td>
                                        <!--- <td>#Application.SampleReport.getIR_IR_TypeName(qGetSampleReports.IR_Type)#</td>
                                        <td> #Application.SampleReport.getIR_CountyLocationName(qGetSampleReports.IR_CountyLocation)#</td>
                                        <td>#DateFormat(qGetSampleReports.IR_Date,"YYYY-MM-DD")#</td> --->
                                    </tr>
                                </cfloop>
                                </cfloop>
                                <!--- </cfoutput> --->
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