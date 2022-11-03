<cftry>

<cfset qGetIncidentReports=Application.IncidentReport.getIncidentReports()>

<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">

<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<cfset  qGetIncidentReports = Application.IncidentReport.getIncidentReportsByword(form.searchword)>
</cfif>
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
   <div class="section-container  p-b-10">
   <!---
      <div class="row">
         <!-- begin col-6 -->
         <div class="col-lg-3 col-md-3col-sm-12 col-xs-12 container-title-box">
            <cfoutput>
               <form class="navbar-form form-input-flat" method="post" name="paginationform">
                  <div class="form-group">
                     <input type="text" name="searchword" class="form-control" 
                     value="<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
                     <cfoutput>#form.searchword#</cfoutput>
                     </cfif>" placeholder="search...">
                     <input type="hidden" name="startHereIndex" value="1" />
                     <button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
                  </div>
               </form>
            </cfoutput>
         </div>
      </div>
      --->
      <cfif qGetIncidentReports.recordcount NEQ 0>
         <table id="data-table" data-order='[[3,"desc"]]' class="table table-bordered table-hover panel">
            <thead>
               <tr class="inverse">
                  <th>Report Title</th>
                  <th>Type</th>
                  <th>County/Location</th>
                  <th>Date</th>
                  <th data-sorting="disabled">Action</th>
               </tr>
            </thead>
            <tbody>
               <cfoutput query="qGetIncidentReports" >
                  <tr class="gradeU" id="remov_#qGetIncidentReports.ID#">
                     <td>#qGetIncidentReports.IR_title#</td>
                     <td>#Application.IncidentReport.getIR_IR_TypeName(qGetIncidentReports.IR_Type)#</td>
                     <td> #Application.IncidentReport.getIR_CountyLocationName(qGetIncidentReports.IR_CountyLocation)#</td>
                     <td>#DateFormat(qGetIncidentReports.IR_Date,"YYYY-MM-DD")#</td>
                     <td>
                        <div class="col-md-3" style="display:inline-block">
                           <form action="#Application.superadmin#?Module=Incident&Page=IncidentReportEdit" method="post">
                              <input type="hidden" name="IR_ID" value="#qGetIncidentReports.ID#">
                              <button class="btn btn-xs btn-primary update" type="submit"><i class="fa fa-pencil-square-o"></i></button>
                           </form>
                        </div>
                        <div class="col-md-3" style="display:inline-block">
                           <button class="btn btn-xs btn-danger" onClick="deleteRecord(#qGetIncidentReports.ID#)"><i class="glyphicon glyphicon-trash"></i></button>
                        </div>
                     </td>
                  </tr>
               </cfoutput>
            </tbody>
         </table>
<!---          <cfset qpagination = qGetIncidentReports > --->
<!---           <cfinclude template="../pagination.cfm"> --->
         <cfelse>
         <div class="alert alert-danger">
            <strong>Alert!</strong> No record found.
         </div>
      </cfif>
   </div>
   <!-- end panel -->
</div>
<!-- end section-container -->

<cfcatch type="any">
  <cfdump  var="#cfcatch#"><cfabort>
</cfcatch>
</cftry>