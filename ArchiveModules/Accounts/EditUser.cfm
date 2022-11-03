<!--- Update user--->
<cfif isdefined("form.updateuser")>
 <cfset updated=Application.Accounts.UpdateUser(argumentCollection="#Form#")>
 </cfif>
 
<!--- get user Detail--->
<cfif isdefined("form.userId") and form.userId NEQ 0>
    <cfset getuserdetail=Application.Accounts.getuserdetail(argumentCollection="#Form#")>
</cfif>

<!--- Get Rolle---> 
<cfset getroles=Application.Accounts.getroles()>
<!--- get Group list--->    
<cfset getgroups=Application.Accounts.getgrouplist()>
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">Edit User</li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Edit User </h1>
			<!-- end page-header -->
			<div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <h5 class="m-t-0">Edit User</h5>
                     <cfoutput>
                        <form class="form-horizontal" action="" name="update-user" method="post">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">First Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="first_name" value="#getuserdetail.first_name#"placeholder="please input group name" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Last Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="last_name" value="#getuserdetail.last_name#"placeholder="please input login name" required/>
                                </div>
                            </div>
                              <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">User Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="username" value="#getuserdetail.user_name#"placeholder="please input login name" required/>
                                </div>
                            </div>
                             <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">User Email</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" value="#getuserdetail.user_email#" name="user_email" placeholder="please input login name" required/>
                                </div>
                            </div>
                            
                            
                         
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Group Name</label>
                                <div class="col-md-7">
                                   <select name="group_name" class="form-control">
                                   <CFLOOP QUERY="getgroups">
                                       <cfif #getuserdetail.group_id# EQ #getgroups.id# >
                                        <OPTION value="#getgroups.id#" selected>#getgroups.group_name#</OPTION>
                                       <cfelse>
                                        <OPTION value="#getgroups.id#">#getgroups.group_name#</OPTION>
                                       </cfif>
                                   </CFLOOP> 
                                   </select>
                                </div>
                            </div>
                 
                       
								   <div class="form-group m-b-10">
                              <label class="col-md-3 control-label">Permissions </label>
                                
                              <div class="clearfix m-b-10 col-md-7">
                              
                              <cfif getuserdetail.permissions EQ "All">
								                                 <label class="checkbox-inline">
                                   <input type="checkbox" name ="permission" checked value="Create"> Create
                                </label>
                                 <label class="checkbox-inline">
                                  <input type="checkbox" name="permission" checked value="Update"> Update
                                 </label>
                                <label class="checkbox-inline">
                                  <input type="checkbox" name="permission"  checked value="Read"> Read
                                </label>
                                <label class="checkbox-inline">
                                  <input type="checkbox" name="permission" checked value="Delete"> Delete
                                </label>
                                		
                                        
                                <cfelse>                              
                                 <label class="checkbox-inline">
                                   <input type="checkbox" name ="permission" <cfif ListContains(getuserdetail.permissions, "Create")>Checked</cfif> value="Create"> Create
                                </label>
                                 <label class="checkbox-inline">
                                  <input type="checkbox" name="permission"  <cfif ListContains(getuserdetail.permissions, "Update")>Checked</cfif> value="Update"> Update
                                 </label>
                                <label class="checkbox-inline">
                                  <input type="checkbox" name="permission" <cfif ListContains(getuserdetail.permissions, "Read")>Checked</cfif> value="Read"> Read
                                </label>
                                <label class="checkbox-inline">
                                  <input type="checkbox" name="permission" value="Delete" <cfif ListContains(getuserdetail.permissions, "Delete")>Checked</cfif>> Delete
                                </label>
                                					  
							  </cfif>
                            </div>
                           

                             <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Category</label>
                                <div class="col-md-7">
                                <select name="user_category" class="form-control">
                                <option value="admin" <cfif #getuserdetail.user_type# eq "admin">selected</cfif> >Admin</option>
                                <option value="std-user" <cfif #getuserdetail.user_type# eq "std-user">selected</cfif> >Standard Users</option>
                                <option value="intern" <cfif #getuserdetail.user_type# eq "intern">selected</cfif> >Intern</option>
                                <option value="volunter" <cfif #getuserdetail.user_type# eq "volunter">selected</cfif> >Volunteer</option>
                                
                                </select>
                                 
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Status</label>
                                <div class="col-md-7">
                                <select name="group_status" class="form-control">
                                <option value="Enale" <cfif #getuserdetail.status# eq "Enable">selected</cfif>>Enable</option>
                                <option value="Disable" <cfif #getuserdetail.status# eq "Disable">selected</cfif>>Disable</option>
                                
                                </select>
                                 
                                </div>
                            </div>
                            <input type="hidden" name="userId" value="#form.userId#">
                            <div class="col-lg-4 col-lg-offset-3">
                               <button type="submit" name="updateuser" value ="submit" class="btn btn-success width-100">Edit</button>
                            <a href="<cfoutput>#Application.superadmin#?ArchiveModule=Accounts&Page=users_list&Archive</cfoutput>" class="btn btn-default width-100">Back</a>
                            </div>
                            
                        </form>
                    </cfoutput>  
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->
                   
                </div>
                <!-- end row -->
		</div>
         
