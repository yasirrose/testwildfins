<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
 <cfif isdefined('FORM.addSurveyArea')>
    <cfset qInsertSurveyArea = Application.StaticData.SurveyAreaInsert(argumentCollection="#Form#")>
    <cfif qInsertSurveyArea.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>

<cfif isdefined('FORM.editSurveyArea')>
    <cfset qEditSurveyArea = Application.StaticData.EditSurveyArea(argumentCollection="#Form#")>
    <cfif qEditSurveyArea.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>
 <cfset qgetSurveyArea = Application.StaticData.getSurveyArea()>
 <cfset qgetStock = Application.StaticData.getStock()>
 
  <cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<cfset   qgetSurveyArea=Application.StaticData.getSurveyAreaByword(form.searchword)>
</cfif>

		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">SurveyArea</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Survey Areas</h1>
			<!-- end page-header -->
                <cfif isdefined('qEditZones') and qEditZones.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Updated!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif> 
                   
              <div class="form-group">
                <div class="alert alert-success message" style="display:none">
                  <strong>Success! </strong>Survey Area Deleted.
                </div>
                </div>
                
            <div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <h5 class="m-t-0">Create Survey Entry</h5>
                     <cfoutput>
                        <form class="form-horizontal" action="#Application.siteroot#?Module=StaticData&Page=SurveyArea" name="add-area" method="post">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Area Name</label>
                                <div class="col-md-7">
                      				<input type="text" class="form-control" name="AreaName" id="AreaName" placeholder="please input sdo entry" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">NOAA Stock</label>
                                <div class="col-md-7">
                                    <select class="form-control" name="stock" placeholder="Select NOAA Stock">
                                        <option value="">Select NOAA Stock</option>
                                        <cfloop query="#qgetStock#">
                                            <option value="#ID#">#StockName#</option>
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
                            <input type="hidden" value="" id="Area_id" name="ID">
       <button type="submit" name="addSurveyArea" value ="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
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
                                <th>Area Name</th>
                                <th>NOAA Stock</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                       <tbody>
                       
                       <cfoutput query="qgetSurveyArea" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                         	<tr class="inverse" id="remov_#ID#">
                                <td>#qgetSurveyArea.currentRow#</td>
                                <td id='AreaName-#ID#'>#AreaName#</td>
                                <td id='StockID-#ID#' data-id="#StockID#"><center><cfif StockName NEQ ''>#StockName#<cfelse>N/A</cfif></center></td>
                                <td ><cfif Active eq 1 >Active<cfelse>Inactive</cfif></td>
                                <td >
                                <input type="hidden" name="seletecActiveValue-#ID#" id="seletecActiveValue-#ID#" value="#Active#">
                                <button class="btn btn-xs btn-primary update" onclick="updateRecord(#ID#)"><i class="fa fa-pencil-square-o"></i></button> &nbsp; &nbsp;&nbsp;&nbsp; <button class="btn btn-xs btn-primary" onclick="deleteRecord(#ID#)"><i class="glyphicon glyphicon-trash"></i></button></td>
                            </tr>
                         </cfoutput>
                        </tbody>
                    </table>
 
	<cfset qpagination = qgetSurveyArea >
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

