<cfif isdefined('form.loginForm')>
    <cfset qGetSuperAdmin = Application.SuperAdminApp.getSuperAdmin(argumentCollection="#Form#")>
    <cfif qGetSuperAdmin.recordcount eq 1>
		    <cfset SESSION["UserDetails"]["Id"] = qGetSuperAdmin.user_id>
            <cfset SESSION["UserDetails"]["name"] = qGetSuperAdmin.user_name>
            <cfset SESSION["UserDetails"]["email"] = qGetSuperAdmin.user_email>
            <cfset SESSION["UserDetails"]["userType"] = qGetSuperAdmin.user_type>
            <cfset SESSION["UserDetails"]["firstName"] = qGetSuperAdmin.first_name>
            <cfset SESSION["UserDetails"]["lastName"] = qGetSuperAdmin.last_name>
            <cfset SESSION["UserDetails"]["groupId"] = qGetSuperAdmin.group_id>
            <cfset SESSION["UserDetails"]["permissions"] = qGetSuperAdmin.permissions>
            <cfset SESSION["UserDetails"]["member"] = qGetSuperAdmin.group_member>
            <cfset SESSION["UserDetails"]["loggedin"] = true />
        <cflocation addtoken="no" url="#Application.siteroot#?Module=Home&Page=Dashboard" >
    <cfelse>
	<cfset message = "Invalid Credentials" >
    </cfif>
</cfif>
<cfparam name="FORM.Email" default="">
<cfparam name="FORM.Password" default="">
<cfparam name="emailsent" default="0">
<cfparam name="emailnotfoun" default="0">
<cfif isdefined("form.forgetForm")>
<cfset emailcheck = Application.SuperAdminApp.emailexist(argumentCollection="#Form#")>
<!---- if email exist------>
<cfif emailcheck.RecordCount eq 1>

<cfset random = now() />
<cfset pass=random.getTime()>
<cfset userPassword =  Hash(pass, "md5")>


<cfset updatepass = Application.SuperAdminApp.updatepassby_emial(Form,userPassword)>



<cfif updatepass.RecordCount eq 1>
<cfset emailsent=1>


<cfmail from="Noreply@domain.com" to="#form.Email#"   subject="Reset Password"  type="html">
   Hello,
   <p>
   Your New login Passowrd is #pass# on <a href="http://test.wildfins.org">Harbor Branch</a>
</p>
</cfmail>
</cfif>
<cfelse>
<cfset emailnotfoun=1>
</cfif>


</cfif>

<cfoutput>
<div class="login">
		    <!-- begin login-brand -->
            <div class="login-brand bg-inverse text-white">
                <img src="#Application.superadminTemplateIncludes#/img/logo-white.png" height="36" class="pull-right" alt="" /> Harbor Branch
            </div>
		    <!-- end login-brand -->
		    <!-- begin login-content -->
            <div class="login-content">
                <form action="#Application.siteroot#?Module=Home&Page=login" method="POST" name="login_form" id="login_form" class="form-input-flat">
                <h4 class="text-center m-t-0 m-b-20"><cfif isDefined('message') and message neq '' >
                 <div class="alert alert-danger">
               	#message#
               	</div>
                <cfelse> Great to have you back!</cfif></h4>
              <cfif isdefined('emailsent') and emailsent eq 1>
              <div class="alert alert-success">
                <strong>Success!</strong> Your Password changed Successfully.Check your email.
                </div>
              </cfif>
              <cfif isdefined('emailnotfoun') and emailnotfoun eq 1>
              <div class="alert alert-danger">
               This Email Does Not Exist.
            	</div>
              </cfif>


                    <div class="form-group">
                        <input type="email" class="form-control" placeholder="Email Address" name="Email" required />
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="Password" name="Password" required />
                    </div>
                    <div class="row m-b-20">
                        <div class="col-md-12">
                            <input type="submit" name="loginForm" value ="Sign in to your account" class="btn btn-lime btn-block">
                        </div>
                    </div>

                </form>
                 <form  method="POST" name="login_form" id="forget_form" class="form-input-flat" style="display:none">
                 <h6 class="text-center m-t-0 m-b-20">
              	 Forgot your password? No worries, enter your email address below and we will hook you up.
                 </h6>
                    <div class="form-group">
                        <button type="button" class="btn btn-primary" id="back">Go to Login</button>
                    </div>
                    <div class="form-group">
                        <input type="email" class="form-control" placeholder="Email Address" name="Email" required />
                    </div>
                    <div class="row m-b-20">
                        <div class="col-md-12">
                            <input type="submit" name="forgetForm" value ="Reset Password" class="btn btn-lime btn-block">
                        </div>
                    </div>

                </form>
                    <div class="text-center">New here? <a href="##" class="text-muted"> Create a new account</a> |<a href="##" id="go_forget">Forget Password</a>
                    </div>

            </div>
		    <!-- end login-content -->
		</div>
		</cfoutput>