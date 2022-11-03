<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page=500>
<cfparam name="form.searchword" default=" ">
<cfset getCetacean = Application.Cetaceans.get_CetaceanList(form.searchword)>
<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<!--- <cfdump  var="#form.searchword#"><cfabort> --->
<cfset  getCetacean=Application.Cetaceans.get_CetaceanList(form.searchword)>
</cfif>
<!-- begin #content -->
<div id="content" class="content">
   <!-- begin breadcrumb -->
   <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Home</a></li>
      <li><a href="javascript:;">Cetacean List</a></li>
   </ol>
   <!-- end breadcrumb -->
   <!-- begin page-header -->
   <h1 class="page-header">Cetacean List</h1>
   <!-- begin section-container -->
   <div class="section-container section-with-top-border">
      <!-- begin panel -->
      <div class="form-group m-b-10" style="overflow: hidden;">
         <div class="col-md-12">
            <div class="col-md-4">
               <form class="navbar-form form-input-flat listcetacen_form" method="post" name="searchfrom">
                  <div class="form-group">
                     <input type="text" style="width: 140%;" name="searchword" class="form-control" id="searchword"
                     value="<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
                     <cfoutput>#form.searchword#</cfoutput>
                     </cfif>" placeholder="Enter Name/code/Cetacean Species...">
                     <input type="hidden" name="startHereIndex" value="1" />
                     <button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
                  </div>
               </form>
            </div>
         </div>
      </div>
      <div class="form-group">
         <div class="alert alert-success message" style="display:none">
            <strong>Success!</strong> Cetacean Deleted.
         </div>
      </div>
      <div class="panel pagination-inverse m-b-0 clearfix">
         <table id="example" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
            <thead>
               <tr class="inverse">
                  <th>Code</th>
                  <th>Name</th>
                  <th>Sex</th>
                  <th>Cetacean Species</th>
                  <th>Actions</th>
               </tr>
            </thead>
            <tbody>
               <cfoutput query="getCetacean" startrow="#startHereIndex#"  maxrows="#Application.record_per_page#">
                  <tr class="inverse" id="remov_#ID#">
                     <td>#Code#</td>
                     <td>#Name#</td>
                     <td>#Sex#</td>
                     <td>#CetaceanSpeciesName#</td>
                     <td>
                        <div class="col-mad-6" style="display:inline-block">
                           <form action="#Application.superadmin#?Module=Cetacean&Page=EditCetacean" method="post">
                              <input type="hidden" value="#ID#" name="id" />
                              <button class="btn btn-xs btn-primary update" type="submit"><i class="fa fa-pencil-square-o"></i></button>
                           </form>
                        </div>
                        <div class="col-mad-6" style="display:inline-block">
                           <button class="btn btn-xs btn-primary" onclick="deleteRecord(#ID#)"><i class="glyphicon glyphicon-trash"></i></button>
                     </td>
                     </div>
                  </tr>
               </cfoutput>
            </tbody>
         </table>
         <cfset qpagination = getCetacean >
         <cfinclude template="../pagination.cfm">
      </div>
      <!-- end panel -->
   </div>
   <!-- end section-container -->
   <div class="footer" id="footer">
      <span class="pull-right">
      <a data-click="scroll-top" class="btn-scroll-to-top" href="javascript:;">
      <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
      </a>	
      </span>
      &copy; 
      <cfoutput>#YEAR(NOW())#</cfoutput>
      <b>WildFins Admin</b> All Right Reserved
   </div>
</div>
<!-- end #content -->