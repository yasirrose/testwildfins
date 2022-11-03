<cfset   getAlluserlist=Application.Accounts.getAlluserlist()>
<cfparam default="0" name="FORM.user">

<cfif isdefined('form') and form.user GT 0>
<cfset   getUserActivity=Application.Accounts.getUserActivity(userId='#form.user#')>
</cfif>

<!-- begin ##content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Reporting</a></li>
				<li><a href="javascript:;">User Activity Report</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">User Activity Report </h1>
			<!-- end page-header -->

			<!-- begin row -->
			<div class="row">
            
                
               <!-- begin row col-6-->
			    <div class="row col-lg-12">
			        <!-- begin panel -->
			        <div class="panel panel-inverse">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
			                <h4 class="panel-title">Filters</h4>
			            </div>
			            <div class="panel-body">
                       
                        <!-- start col-md-6 -->
                            <div class="col-md-6">
                             <h5>Select User</h5>
                             <form method="POST">
                             <div class="row col-md-8">
                              <select class="form-control" name="user">
                               <option value="0">Select User</option>
                              
                               <cfoutput query="getAlluserlist" >
                                  <option value="#user_id#" <cfif FORM.user EQ user_id>selected</cfif> >#user_email#</option>
                                </cfoutput> 
                              </select>
                              </div>
                             <div class="row col-md-4">
                             <input type="submit" class="btn btn-success" value="Submit">
                             </div> 
                              </form>
                            </div>
			               <!-- end col-md-6 -->
                           
                            <!-- start col-md-12 -->
                            <div class="col-md-12 m-t-30">
                            <cfif isdefined('form') and form.user GT 0>
                              <div class="table-responsive">
                              	<cfoutput>
                                <p>
                                <strong>Name: </strong> <a> #getUserActivity.FIRST_NAME# #getUserActivity.LAST_NAME# </a><br/>
                                <strong>Email: </strong> <a> #getUserActivity.USER_EMAIL#</a> <br/>
                                <strong>Last Login: </strong><a>#DateTimeFormat(getUserActivity.LOGINTIME, "YYYY-MM-DD HH:nn:ss a")# </a> <br/>
                                </p>
                                </cfoutput>
                                <h2>Visited Page:</h2>
                                <table id="data-table" data-order='[[1,"asc"]]' class="table table-bordered table-hover panel">
                                   <thead>
                          			  <tr class="inverse">
                                            <th>Sr#</th>
                                            <th >Module</th>
                                            <th >Page</th>
                                            <th >Count Hits</th>
                                            <th >Date/time</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <cfset i=0>
                                    <cfoutput query="getUserActivity" group="aid">
                                    <cfset i=i+1>
                                        <tr class="gradeU">
                                            <td>#i#</td>
                                            <td>#ModuleName#</td>
                                            <td>#PageName#</td>
                                            <td>#Count#</td>
                                            <td>#DateTimeFormat(DateTime, "YYYY-MM-DD HH:nn:ss a")#</td>
                                        </tr>
                                        </cfoutput>
                                    </tbody>
                                </table>
                            </div>
                            
                             </cfif>
                            </div>
			               <!-- end col-md-12-->
                           
			        </div>
			        <!-- end panel -->
			    </div>
                <!-- end row col-6 -->
            
            </div>
            <!-- end row -->
            
     <!-- begin ##footer -->
            <div id="footer" class="footer">
                <span class="pull-right">
                    <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top">
                        <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
                    </a>
                </span>
                &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
            </div>
            <!-- end ##footer -->
		</div>
		<!-- end ##content -->
