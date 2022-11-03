<!--- Update user--->
<cfif isdefined("form.updateuser")>
    <cfset form.group_name =  "0">
    <cfset form.permission =  "">
    <cfset updated=Application.Accounts.UpdateUser(argumentCollection="#Form#")>
</cfif>
 
<!--- get user Detail--->
<cfif isdefined("form.userId") and form.userId NEQ 0>
    <cfset getuserdetail=Application.Accounts.getuserdetail(argumentCollection="#Form#")>
</cfif>

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
                        <label class="col-md-3 control-label">Category</label>
                        <div class="col-md-7">
                        <select name="user_category" class="form-control">
                        <option value="administrators" <cfif #getuserdetail.user_type# eq "administrators">selected</cfif> >Administrators</option>
                        <option value="team_members" <cfif #getuserdetail.user_type# eq "team_members">selected</cfif> >Team Members</option>
                        <option value="vet_assistant" <cfif #getuserdetail.user_type# eq "vet_assistant">selected</cfif> >Vet Assistant</option>
                        <option value="volunteers" <cfif #getuserdetail.user_type# eq "volunteers">selected</cfif> >Volunteer</option>
                        </select>
                            
                        </div>
                    </div>
                    <div class="form-group m-b-10">
                        <label class="col-md-3 control-label">Status</label>
                        <div class="col-md-7">
                        <select name="group_status" class="form-control">
                        <option value="Enable" <cfif #getuserdetail.status# eq "Enable">selected</cfif>>Enable</option>
                        <option value="Disable" <cfif #getuserdetail.status# eq "Disable">selected</cfif>>Disable</option>
                        
                        </select>
                            
                        </div>
                    </div>
                    <input type="hidden" name="userId" value="#form.userId#">
                    <div class="col-lg-4 col-lg-offset-3">
                        <button type="submit" name="updateuser" value ="submit" class="btn btn-success width-100">Edit</button>
                    <a href="<cfoutput>#Application.superadmin#?Module=Accounts&Page=UsersList</cfoutput>" class="btn btn-default width-100">Back</a>
                    </div>
                    
                </form>
            </cfoutput>  
            </div>
        </div>
</div>
         
