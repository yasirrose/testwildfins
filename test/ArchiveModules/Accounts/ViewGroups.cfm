<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
<cfif isdefined('FORM.editGroup')>
    <cfset qEditGroup = Application.Group.EditGroup(argumentCollection="#Form#")>  
</cfif>

<cfset qgetGroup = Application.Group.getGroup()>

<cfif isdefined("form.searchword") and len(trim(form.searchword)) NEQ 0>
<cfset   qgetGroup=Application.Group.getGroupByword(argumentCollection="#Form#")>
</cfif>

		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;"><cfoutput>#URL.ArchiveModule#</cfoutput></a></li>
				<li><a href="javascript:;"><cfoutput>#URL.page#</cfoutput></a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Group Lists</h1>
			<!-- end page-header -->
                <cfif isdefined('qEditGroup') and qEditGroup.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Updated!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif> 
              
            <div class="row" id="group-edit" style="display:none">
                    <!-- begin col-6 -->
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 main-cotainer">
                     
                        <form method="post" name="add-group" action="" class="form-horizontal" id="ViewGroup">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Group Name</label>
                                <div class="col-md-7">
                                    <input type="text" required="" placeholder="please input group name" name="group_name" id="group_name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Group Status</label>
                                <div class="col-md-7">
                                <select class="form-control" name="group_status" id="group_status">
                                <option value="Enable">Enable</option>
                                <option value="Disable">Disable</option>

                                </select>

                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Group Discription</label>
                                <div class="col-md-7">
                                    <textarea placeholder="Description about group" name="group_description" id="group_description" rows="3" class="form-control"></textarea>
                                </div>

                            </div>
                            <input type="hidden" value="" id="group_id" name="id">
              				<div class="col-lg-3 col-lg-offset-3">
								<button class="btn btn-success width-100 m-r-5" value="submit" name="EditGroup" type="submit">Edit</button>
								<button class="btn btn-default width-100" type="reset">Cancel</button>
                            </div>

                        </form>
                    
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->

                </div>
			
            <!-- begin section-container -->
            <div class="section-container ">
                
                   <div class="form-group m-b-10" style="overflow: hidden;">
               	<div class="col-md-12">
               	<div class="col-md-3">
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
                 </div>
                
                <div class="panel pagination-inverse m-b-0 clearfix">
                    <table id="data-table" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                                <th>Group Name</th>
                                <th>Group Description</th>
                                <th>Group Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                         <cfoutput QUERY="qgetGroup" startrow="#startHereIndex#" maxrows="500">
                            	<tr class="gradeU">
                                <td id="group_name-#id#">#qgetGroup.group_name#</td>
                                <td id="group_description-#id#">#qgetGroup.group_description#</td>
                                <td id="group_status-#id#">#qgetGroup.group_status#</td>
                                 <td><button class="btn btn-xs btn-primary update" onclick="updateRecord(#id#)"><i class="fa fa-pencil-square-o"></i></button> 
                                &nbsp;  <button class="btn btn-xs btn-primary" 
                                onclick="deleteRecord(#id#)"><i class="glyphicon glyphicon-trash"></i></button></td>
                            </tr>
                            
                         </cfoutput>
                        </tbody>
                    </table>
           
    <cfoutput>
   <div class="mypagination">
   <!--- Checks on Displaying Recrod number--->
 <cfif qgetGroup.recordcount LT 500>
   		Displaying <cfoutput>#qgetGroup.recordcount#</cfoutput> Records.
  <cfelse>
   		<cfif (startHereIndex+500) GT qgetGroup.recordcount>
				Displaying <cfoutput>#startHereIndex# - #qgetGroup.recordcount# of #qgetGroup.recordcount#</cfoutput> Records
		<cfelse>
				Displaying <cfoutput>#startHereIndex# - #(startHereIndex+9)# of #qgetGroup.recordcount#</cfoutput> Records
		</cfif>
   <!--- Check on Showing Previous Or Next Button --->
   <cfif startHereIndex LT 500>
   		<cfelse>
              <a class="prev" href="##" onclick="ApplyPagination(#evaluate(startHereIndex - 500)#); return false;">Previous</a>
   </cfif>
   <a >|</a>
   <cfif (startHereIndex+500) GT qgetGroup.recordcount>
        <cfelse>
              <a class="next" href="##" onclick="ApplyPagination(#evaluate(startHereIndex + 500)#); return false;">Next</a>
   </cfif>
  </cfif>
  </div>
  </cfoutput>
                 
                    
                    
                </div>
                <!-- end panel -->
            </div>
            <!-- end section-container -->
		</div>
		<!-- end #content -->
