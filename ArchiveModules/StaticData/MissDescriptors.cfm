<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
<cfif isdefined('FORM.addHitLocation')>
    <cfset qMissDescriptorsInsert = Application.StaticData.MissDescriptorsInsert(argumentCollection="#Form#")>
    <cfif qMissDescriptorsInsert.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>

<cfif isdefined('FORM.editMissDescriptors')>
    <cfset qEditMissDescriptors = Application.StaticData.EditMissDescriptors(argumentCollection="#Form#")>
    <cfif qEditMissDescriptors.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>
 <cfset qgetMissDescriptors = Application.StaticData.getMissDescriptors()>
 
  <cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<cfset   qgetMissDescriptors=Application.StaticData.getMissDescriptorsByword(form.searchword)>
</cfif>

		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">Miss Descriptors</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Miss Descriptors</h1>
			<!-- end page-header -->
			
                <cfif isdefined('qEditMissDescriptors') and qEditMissDescriptors.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Updated!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif> 
				   <cfif isdefined('qMissDescriptorsInsert') and qMissDescriptorsInsert.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Added!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif>
                 <div class="form-group">
                <div class="alert alert-success message" style="display:none">
                  <strong>Success!</strong>  Miss Descriptors Deleted.
                </div>
                </div>
			
            <div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <h5 class="m-t-0">Create  Miss Descriptors</h5>
                     <cfoutput>
                        <form class="form-horizontal" action="" name="add-zone" method="post">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Miss Descriptors :</label>
                                <div class="col-md-7">
                      <input type="text" class="form-control" name="MissDescriptors" id="MissDescriptors" required/>
                                </div>
                            </div>
                            
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Status :</label>
                                <div class="col-md-7">
                                <select class="form-control" name="active" id="active">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>

                                </select>
							</div>
                            </div>
                            
                            <div class="col-md-7 col-md-offset-3">
                         <input type="hidden" value="" id="MissDescriptors_id" name="ID">
       <button type="submit" name="addHitLocation" value ="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
                 <button class="btn btn-default width-100" type="reset">Cancel</button>
			</div>
                        </form>
                    </cfoutput>
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->

                </div>
                <!-- end row -->
		</div>

            <!-- begin section-container -->
            <div class="section-container section-with-top-border">
            
               <div class="form-group m-b-10" style="overflow: hidden;">
               	<div class="row col-md-3">
                   <form class="navbar-form form-input-flat" method="post" name="paginationform">
                   <div class="form-group">
                   <input type="text" name="searchword" class="form-control" 
                  value="<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0><cfoutput>#form.searchword#</cfoutput></cfif>" placeholder="search...">
                   <input type="hidden" name="startHereIndex" value="1" />
                   <button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
                   </div>
                   </form>
                   </div>
                 </div>
                 
                <!-- begin panel -->
                <div class="panel pagination-inverse m-b-0 clearfix">
                    <table id="example" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                               <th>Sr#</th>
                                <th>Miss Descriptors</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                       <tbody>
                      
                       
                       <cfoutput query="qgetMissDescriptors" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                         	<tr class="inverse" id="remov_#ID#">
                                <td>#qgetMissDescriptors.currentRow#</td>
                                <td id='MissDescriptors-#ID#'>#MissDescriptors#</td>
                            	<td>
                                	<cfif active eq 1 >
	                                	Active
	                                <cfelse>
	                                	Inactive
                                	</cfif>
								</td>
                                <input type="hidden" name="seletecActiveValue-#id#" id="seletecActiveValue-#id#" value="#active#">
                                <td ><button class="btn btn-xs btn-primary update" onclick="updateRecord(#ID#)"><i class="fa fa-pencil-square-o"></i></button> &nbsp; &nbsp;&nbsp;&nbsp; <button class="btn btn-xs btn-primary" onclick="deleteRecord(#ID#)"><i class="glyphicon glyphicon-trash"></i></button></td>
                            </tr>
                         </cfoutput>
                       
                        </tbody>
                    </table>
        
     <cfset qpagination = qgetMissDescriptors >
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
                &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
            </div>
		</div>
		<!-- end #content -->