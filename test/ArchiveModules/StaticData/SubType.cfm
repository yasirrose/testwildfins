<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
<cfif isdefined('FORM.addSubType')>
    <cfset qInsertSubType = Application.StaticData.SubTypeInsert(argumentCollection="#Form#")>
    <cfif qInsertSubType.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>

<cfif isdefined('FORM.editSubType')>
    <cfset qEditSubType = Application.StaticData.EditSubType(argumentCollection="#Form#")>
    <cfif qEditSubType.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>
<cfset qgetSubType = Application.StaticData.getSubType()>
<cfset qgetType    = Application.StaticData.getType()>
<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
	<cfset   qgetSubType=Application.StaticData.getSubTypeByword(form.searchword)>
</cfif>

		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">SubType</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">SubType</h1>
			<!-- end page-header -->
			<cfif isdefined('qEditSubType') and qEditSubType.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Updated!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif> 
				   <cfif isdefined('qInsertSubType') and qInsertSubType.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Added!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif>
                 
 				
                <div class="form-group">
                <div class="alert alert-success message" style="display:none">
                  <strong>Success!</strong> Sub Type Deleted.
                </div>
                </div>
                
            <div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <h5 class="m-t-0">Create SubType Record</h5>
                  
                     <cfoutput>
                        <form class="form-horizontal" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="add-camara" method="post">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">SubType</label>
                                <div class="col-md-7">
                                	 <input type="hidden" name="ID" value='' id="SubType_id" />
                      				 <input type="text" class="form-control" name="SubType" id="SubTypeName" placeholder="please input SubType" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Survey Type</label>
                                <div class="col-md-7">
                                    <select class="form-control" name="surveyType" placeholder="Select Survey Type">
                                        <option value="">Select Survey Type</option>
                                        <cfloop query="#qgetType#">
                                            <option value="#ID#">#Type#</option>
                                        </cfloop>
                                    </select>
								</div>
                            </div>
							<div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Status</label>
                                <div class="col-md-7">
                                <select class="form-control" name="active" id="active">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>

                                </select>
							</div>
                            </div>
							<div class="col-md-7 col-md-offset-3">
       <button type="submit" name="addSubType" value ="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
                 <button class="btn btn-default width-100" type='reset'>Cancel</button>
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
                                <th>SubType</th>
                                <th>SurveyType</th>
								<th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                      	 <tbody>
                         <cfoutput query="qgetSubType" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                         	<tr class="inverse" id="remov_#ID#">
                                <td>#qgetSubType.currentRow#</td>
                                <td id='cam-#id#'>#SubType#</td>
                                <td id='SurveyTypeID-#ID#' data-id="#SurveyTypeID#"><center><cfif Type NEQ ''>#Type#<cfelse>N/A</cfif></center></td>
								<td><cfif active eq 1 >Active<cfelse>Inactive</cfif></td>
								<input type="hidden" name="seletecActiveValue-#id#" id="seletecActiveValue-#id#" value="#active#">
                                <td >
                                <button class="btn btn-xs btn-primary update" onclick="updateRecord(#id#)"><i class="fa fa-pencil-square-o"></i></button> &nbsp; &nbsp;&nbsp;&nbsp; <button class="btn btn-xs btn-primary" onclick="return deleteRecord(#id#)"><i class="glyphicon glyphicon-trash"></i></button></td>
                            </tr>
                         </cfoutput>
                        </tbody>
                    </table>
                    
     <cfset qpagination = qgetSubType >
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