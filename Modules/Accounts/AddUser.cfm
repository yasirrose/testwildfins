<cfif session.userdetails.userType eq "team_members">
    <cflocation addtoken="no" url="#Application.siteroot#?Module=Security&Page=index" >
</cfif>

<cfif isdefined("form.adduser")>
    <cfset form.group_name =  "0">
    <cfset form.permission =  "">
    <cfset InsertUser=Application.Accounts.InsertUser(argumentCollection="#Form#")>

  <!--- <cfdump var="#InsertUser#">
  <cfabort> --->
  <cfif InsertUser.RECORDCOUNT eq 1 >
      
  <cflocation url="#Application.superadmin#?Module=Accounts&Page=UsersList" addtoken="no">
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
                                <label class="col-md-3 control-label">Category</label>
                                <div class="col-md-7">
                                <select name="user_category" class="form-control" id="user_category">
                                <option value="administrators">Administrators</option>
                                <option value="team_members">Team Members</option>
                                <option value="vet_assistant">Vet Assistant</option>
                                <option value="volunteers">Volunteer</option>
                                <option value="photoIDAdministrator">Photo ID Administrator</option>

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

                </div>
		</div>
            

