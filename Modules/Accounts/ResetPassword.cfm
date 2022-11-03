<cfif isdefined("form.updateuser")>
    <cfif #Form.user_password# EQ #Form.user_conf_password#>
        <cfset qUpdateUserPwd = Application.AccountsNew.UpdateUserPwd(argumentCollection="#Form#")>
        <cfif qUpdateUserPwd.RECORDCOUNT eq 1 >
            <cfset message ="Password Updated">
            <cfelse>
            <cfset error ="Password Updation Failed">
        </cfif>
    <cfelse>
        <cfset error ="Confirm Password must be match with Password">
    </cfif>
    
</cfif>
 
<!--- get user Detail--->
<cfif isdefined("form.userId") and form.userId NEQ 0>
    <cfset getuserdetail=Application.AccountsNew.getuserdetail(argumentCollection="#Form#")>
</cfif>

<!--- Get Rolle---> 
<cfset getroles=Application.AccountsNew.getroles()>
<!--- get Group list--->    
<cfset getgroups=Application.AccountsNew.getgrouplist()>
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">Reset Password</li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Reset Password </h1>
			<!-- end page-header -->

            <cfif isdefined('message')>
                <div class="alert alert-success"> <strong>Success! </strong><cfoutput>#message#</cfoutput></div>
            </cfif>
            <cfif isdefined('error')>
                <div class="alert alert-danger"> <strong>Alert! </strong><cfoutput>#error#</cfoutput></div>
            </cfif>

			<div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <h5 class="m-t-0">Reset Password</h5>
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
                                <label class="col-md-3 control-label">Password</label>
                                <div class="col-md-7">
                                    <input type="password" id="user_password" class="form-control" value="" name="user_password" placeholder="Please input Password" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Confirm Password</label>
                                <div class="col-md-7">
                                    <input type="password" id="user_conf_password" name="user_conf_password" class="form-control" value="" placeholder="Please input Confirm Password" required/>
                                </div>
                            </div>
            
                            <input type="hidden" name="userId" value="#form.userId#">
                            <div class="col-lg-6 col-lg-offset-3">
                               <button type="submit" name="updateuser" value ="submit" class="btn btn-success width-150">Reset Password</button>
                            <a href="<cfoutput>#Application.superadmin#?Module=Accounts&Page=UsersList</cfoutput>" class="btn btn-default width-100">Back</a>
                            </div>
                            
                        </form>
                    </cfoutput>  
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->
                   
                </div>
                <!-- end row -->
		</div>
         
