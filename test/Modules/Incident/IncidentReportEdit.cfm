<cftry>

<cfoutput>
    <style>
    .mammalIncidentReport .form-wrap{
        padding-top: 30px;
    }
    .mammalIncidentReport label {
        font-size: 12px;
color: ##444444;
    text-align: left !important;
    font-weight: normal;
}
.mammalIncidentReport .box .form-group{
    display: inline-block;
    width: 100%;
}
.mammalIncidentReport .box .heading{
    padding-bottom: 8px;
}
.mammalIncidentReport .longlat{
    width: 90%;
    display: inline-block;
}
.mammalIncidentReport .form-group{
    margin-bottom: 10px;
}
.mammalIncidentReport .form-control {
    height: 30px;
    border-radius: 0;
    box-shadow: none;
    font-size: 12px;
}
.mammalIncidentReport .sm-heading{
    font-size: 13px;
    padding-top: 5px;
}

.mammalIncidentReport .box-imgWrap2 {
    height: 250px;
    padding: 10px;
border: 1px solid ##bdbbbb;
    display: table;
    width: 100%;
}
.file-input.file-input-new{
    display: table-cell;
    vertical-align: middle;
}
.mammalIncidentReport .box-imgWrap2 label{
    display: table-cell;
    vertical-align: middle;
    font-weight: bold;
    font-size: 14px;
    text-align: center !important;
}
.mammalIncidentReport .photobox{
    padding-bottom: 20px;
}
.mammalIncidentReport .photoorvisual .form-control{
    width: 80%;
    display: inline-block;
}
.mammalIncidentReport .detrmination .form-control.accession{
    width: 45%;
    display: inline-block;
}
.mammalIncidentReport .form-control.accession{
    width: 10%;
    display: inline-block;
}
.main-form-section .form-control {
    border-color: ##bec3c6;
    border-width: 1px;
    box-shadow: none;
    color: ##30373f;
    height: 33px;
    padding: 2px 4px;
    border-radius: 0;
    font-size: 12px;
}
</style>

  <cfif isdefined('form.IR_ID')> 
        <cfset qgetSingleIncidentReport = Application.IncidentReport.getSingleIncidentReport("#Form.IR_ID#")>
  <cfelse>
        <cflocation url="#Application.superadmin#?Module=Incident&Page=IncidentReportList">
 </cfif>

<cfset qgetIncidentReportType = Application.SightingNew.getIncidentReportType()>

<cfset qgetIncidentReports = Application.IncidentReport.getIncidentReports()>

<cfset qgetIR_CountyLocation = Application.SightingNew.getIR_CountyLocation()>


  <cfif isdefined('form.saveReportOnly')> 
        <cfset qInsertIncidentReport = Application.IncidentReport.insertIncidentReport(argumentCollection="#Form#")>
        <cfif qInsertIncidentReport.RECORDCOUNT eq 1 >
          <cfset message ="Incident Report Updated">
         <cfelse> 
            <cfset error ="Try Again, Incident Report Not Added">
        </cfif>
 </cfif>

 <div id="content" class="content">
    <div class="mammalIncidentReport">
        <div class="row">
            <div class="col-md-12 text-center">
                <h2>Harbor Branch Oceanographic Institute @ FAU <br> Marine Mammal Stranding and Population AssessmentIncident Report</h2>
            </div>
        </div>
        <hr/>

        <cfif isdefined('message')>
            <div class="alert alert-success"> <strong>Success! </strong> #message# </div>
        </cfif>
        <cfif isdefined('error')>
            <div class="alert alert-danger"> <strong>Alert! </strong> #error# </div>
        </cfif>


        <form  action="" method="post">
        <div class="main-form-section">
        <div class="row">
             <div class="col-sm-6 box">
                <div class="row">
                    <div class="row">
                        <div class="heading">
                            <h4 class="text-uppercase"> &nbsp; Update Incident Report</h4>
                        </div>
                        <div class="col-sm-12">
                            
                             <div class="form-group">
                                <label class="control-label col-sm-3">Date:</label>
                                <div class="col-sm-9">
                                    <div id="datetimepickerIR" class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12">
                                        <input type="text" name="IR_Date" value=' <cfif isdefined('form.IR_ID')> #DateTimeFormat(qgetSingleIncidentReport.IR_Date, "YYYY-MM-DD")# </cfif>' placeholder="YYYY-MM-DD" class="form-control">
                                        <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3">Type:</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="IR_Type" id="IR_Type">
                                        <option value="0">Select Type</option>
                                        <cfloop query="qgetIncidentReportType">
                                            <option value="#qgetIncidentReportType.ID#" 
                                            <cfif isdefined('form.IR_ID') AND #qgetIncidentReportType.ID# EQ #qgetSingleIncidentReport.IR_Type#> selected </cfif> >
                                            #qgetIncidentReportType.IR_Type#
                                            </option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3" >County/Location:</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="IR_CountyLocation" id="IR_CountyLocation">
                                        <option value="0">Select County/Location</option>
                                        <cfloop query="qgetIR_CountyLocation">
                                            <option value="#qgetIR_CountyLocation.ID#"
                                            <cfif isdefined('form.IR_ID') AND  #qgetIR_CountyLocation.ID# EQ #qgetSingleIncidentReport.IR_CountyLocation#> selected </cfif> >
                                            #qgetIR_CountyLocation.IR_CountyLocation#
                                            </option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3" >Report Title:</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="IR_title" id="IR_title" placeholder="Report Title" maxlength="100" value="<cfif isdefined('form.IR_ID')>#qgetSingleIncidentReport.IR_title# </cfif>">
                                    <span class="">*Max 100 characters</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <input class="btn btn-success" value="Update" name="saveReportOnly" type="submit">
                                  <input type="hidden" name="IR_ID" value="<cfif isdefined('form.IR_ID')> #qgetSingleIncidentReport.ID# </cfif>">
                                <a class="btn btn-success" href="#Application.superadmin#?Module=Incident&Page=IncidentReportList">Incident Report List</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
     </form>
    </div>
</div>
</cfoutput>

<cfcatch type="any">
    <cfdump  var="#cfcatch#"><cfabort>
</cfcatch>
</cftry>


