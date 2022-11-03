<!--- query to get group details --->
<!---  <cfquery name="getadminGroup" datasource="wildfins">
       select *  from groups where id = '#groupId#'
    </cfquery>
    
    

--->
 <!---<!--- query to get all roles name --->
  <cfquery name="getroles" datasource="wildfins" result="roles">
       select * from user_roles where role_name != 'Super Admin'
    </cfquery>
  --->
    <!--- Get Rolle---> 
<cfset getroles=Application.Accounts.getroles()>
  
<!---   <cfquery name="getgroups" datasource="wildfins" result="groups">
       select * from groups
   </cfquery>--->

<!--- get Group list--->    
<cfset getgroups=Application.Accounts.getgrouplist()>

<cfif isdefined("form.adduser")>
    <cfset InsertUser=Application.Accounts.InsertUser(argumentCollection="#Form#")>
<!---  <cfset firstName = form.first_name>
  <cfset lastName =  form.last_name>
  <cfset userPassword =  Hash(form.user_password, "md5")>
  <cfset username = form.username>
  <cfset userEmail =  form.user_email>
  <cfset userTypeForm =  form.user_category>
  <cfset userStatus =  form.group_status>
  <cfset groupID =  form.group_name>
  <cfset permissions =  form.permission>
  
<cfquery name="qUserInsert" datasource="wildfins" result="UsersInsert">
    INSERT INTO users (first_name, last_name,user_name,user_password,permissions,user_email,user_type,status,group_id,group_member) VALUES('#firstName#','#lastName#','#username#','#userPassword#','#permissions#','#userEmail#','#userTypeForm#','#userStatus#','#groupID#','Y')
  </cfquery>--->
  
  <cfif InsertUser.RECORDCOUNT eq 1 >
      
  <cflocation url="#Application.superadmin#?ArchiveModule=Accounts&Page=UsersList&Archive" addtoken="no">
  <cfelse>
    <cfset errMSG="User Insertion failed. Try Again">
      </cfif>
      
 </cfif>

		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">Add User</li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Add User </h1>
			<!-- end page-header -->
			<div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 main-cotainer">
                        <h5 class="m-t-0">Create User
                        	<cfif isDefined("errMSG")>
                            <cfoutput>#errMSG#</cfoutput>
                             </cfif>
                    	</h5>
                     <cfoutput>
                        <form class="form-horizontal" action="" name="add-user" method="post">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">First Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="first_name" placeholder="please input group name" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Last Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="last_name" placeholder="please input login name" required/>
                                </div>
                            </div>
                              <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">User Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="username" placeholder="please input login name" required/>
                                </div>
                            </div>
                             <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">User Email</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="user_email" placeholder="please input login name" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Password</label>
                                <div class="col-md-7">
                                    <input type="password" class="form-control" name="user_password" placeholder="please input login password" required/>
                                </div>
                            </div>
                           
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Group Name</label>
                                <div class="col-md-7">
                                   <select name="group_name" class="form-control">
                                    <CFLOOP QUERY="getgroups">
                                       <OPTION value="#getgroups.id#">#getgroups.group_name#</OPTION>
                                   </CFLOOP>
                                   </select>
                                </div>
                            </div>
                            
                            
                            
                              <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Permissions</label>

                              <div class="clearfix m-b-10 col-md-7">
                                 <label class="checkbox-inline">
                                   <input type="checkbox" name ="permission" value="Create"> Create
                                </label>
                                 <label class="checkbox-inline">
                                  <input type="checkbox" name="permission" value="Update"> Update
                                 </label>
                                <label class="checkbox-inline">
                                  <input type="checkbox" name="permission" value="Read"> Read
                                </label>
                                <label class="checkbox-inline">
                                  <input type="checkbox" name="permission" value="Delete"> Delete
                                </label>
                            </div>

                                <!---<div class="col-md-7">
                                   <select name="role_name" class="form-control" id="role_name">
                                   <option value="no access">Please Assing Access</option>
                                    <CFLOOP QUERY="getroles">
                                       <OPTION value="#getroles.id#">#getroles.role_name#</OPTION>
                                   </CFLOOP>
                                   </select>
                                </div>--->
                            </div>

                             <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Category</label>
                                <div class="col-md-7">
                                <select name="user_category" class="form-control" id="user_category">
                                <option value="admin">Group Admin</option>
                                <option value="std-user">Standard Users</option>
                                <option value="intern">Intern</option>
                                <option value="volunter">Volunteer</option>

                                </select>

                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Status</label>
                                <div class="col-md-7">
                                <select name="group_status" class="form-control">
                                <option value="Enable">Enable</option>
                                <option value="Disable">Disable</option>

                                </select>

                                </div>
                            </div>
							<div class="col-lg-3 col-lg-offset-3">
                               <button type="submit" name="adduser" value ="submit" class="btn btn-success width-100 m-r-5">Submit</button>
                            	<button type="reset" class="btn btn-default width-100">Cancel</button>
							</div>

                        </form>
                    </cfoutput>
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->

                </div>
                <!-- end row -->
		</div>
            

