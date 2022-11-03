<cfparam name="form.searchword" default="">
<cfif isdefined('FORM.addMethod')>
    <cfset qInsertMethod = Application.StaticDataNew.DrugMethodInsert(argumentCollection="#Form#")>
    <cfif qInsertMethod.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>

<cfif isdefined('FORM.editMethod')>
    <cfset qEditMethod = Application.StaticDataNew.EditDrugMethod(argumentCollection="#Form#")>
    <cfif qEditMethod.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>
 <cfset qgetMethod= Application.StaticDataNew.getDrugMethod()>

<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<cfset   qgetMethod=Application.StaticDataNew.getDrugMethodByword(form.searchword)>
</cfif>
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">Drug Method</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Drug Method</h1>
			<!-- end page-header -->
			<cfif isdefined('qEditMethod') and qEditMethod.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Updated!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif> 
				   <cfif isdefined('qInsertMethod') and qInsertMethod.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Added!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif>

            <div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <h5 class="m-t-0">Create Drug Method Record</h5>
                  
                     <cfoutput>
                        <form class="form-horizontal" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="add-Method" method="post">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Drug</label>
                                <div class="col-md-7">
                                    <input type="hidden" name="ID" value='' id="Method_id" />
                                    <input type="text" class="form-control" name="Method" id="Method" placeholder="Please Input Method Name" required/>
                                </div>
                            </div>
							<div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Status</label>
                                <div class="col-md-7">
                                <select class="form-control" name="status" id="status">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>

                                </select>
							</div>
                            </div>
							<div class="col-md-7 col-md-offset-3">
                                <button type="submit" name="addMethod" value ="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
                                <button class="btn btn-default width-100" type='reset'>Reset</button>
                            </div>
                        </form>
                    </cfoutput>
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->

                </div>
                <!-- end row -->
		</div>
        
            <div class="form-group">
                <div class="alert alert-success message" style="display:none">
                  <strong>Success!</strong> Drug Method Deleted.
                </div>
                </div>
                

            <!-- begin section-container -->
            <div class="section-container section-with-top-border">
            
                <!-- begin panel -->
                <div class="panel pagination-inverse m-b-0 clearfix">
                    <table id="example" class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                                <th>Sr#</th>
                                <th>Drug Method</th>
                                <th>Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                      	 <tbody>
                         <cfoutput query="qgetMethod">
                         	<tr class="inverse" id="remov_#ID#">
                                <td>#qgetMethod.currentRow#</td>
                                <td id='Method-#id#'>#Method#</td>
								<td>
									<cfif status eq 1 >
                                    Active
                                    <cfelse>
                                    Inactive
                                    </cfif>
								    <input type="hidden" name="seletecActiveValue-#id#" id="seletecActiveValue-#id#" value="#status#">
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-xs btn-primary update" onclick="updateRecord(#ID#)"><i class="fa fa-pencil-square-o"></i></button> 
                                    &nbsp; &nbsp;&nbsp;&nbsp; 
                                    <button class="btn btn-xs btn-primary" onclick="return deleteRecord(#ID#)"><i class="glyphicon glyphicon-trash"></i></button>
                                </td>
                            </tr>
                         </cfoutput>
                        </tbody>
                    </table>
                                              
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