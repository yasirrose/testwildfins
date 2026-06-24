<!--- Update user--->
<cfif isdefined("form.editProfile")>
	 <cfset qEditProfile=Application.SuperAdminApp.EditProfile(argumentCollection="#Form#")>

 <!--------  image upload rename/extention changing .direcrtory create.image delete ----------------->
    <cfif len(trim(form.user_image))>
     <cfset strPath=ExpandPath("./")>
    <cfif not DirectoryExists("#ExpandPath('.')#/assets/user_images/#FORM.userId#")>
      <cfdirectory action = "create" directory="#ExpandPath('.')#/assets/user_images/#FORM.userId#" />
    </cfif>
    
     <cffile action="upload"
     fileField="user_image"
     destination="#strPath#assets\user_images\#FORM.userId#\"
     result="image_info"
     nameconflict="overwrite">
      <!------- Resize rename/extension changed------------->
      <cfimage
                action = "resize"
                source = "#strPath#assets\user_images\#FORM.userId#\#image_info.serverfile#"
                width = "100%" 
                height = "100%"
                destination = "#strPath#assets\user_images\#FORM.userId#\#FORM.userId#.png" 
                name = "#FORM.userId#"
                overwrite = "yes">
    </cfif>
    
</cfif>
 


<cfset userinfo=Application.SuperAdminApp.getUserinfo()>

		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">Edit Profile</li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Edit Profile </h1>
			<!-- end page-header -->
            <cfif isdefined('qEditProfile') and qEditProfile.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Profile Updated Successfully!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
             </cfif> 
			<div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <h5 class="m-t-0">Edit Profile </h5>
                     <cfoutput>
                        <form class="form-horizontal" action="" name="update-user" method="post" enctype="multipart/form-data">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">First Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="first_name" value='#userinfo.first_name#' placeholder="" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Last Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="last_name" value='#userinfo.last_name#' placeholder="" required/>
                                </div>
                            </div>
                              <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">User Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="username" value='#userinfo.user_name#' placeholder="please input login name" required/>
                                </div>
                            </div>
                             <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">User Email</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" value='#userinfo.user_email#' name="user_email" placeholder="please input login name" required/>
                                </div>
                            </div>
                          <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Change Password</label>
                                <div class="col-md-7">
                                    <input type="password" class="form-control" value='' name="user_password" placeholder="" />
                                </div>
                            </div>
                            
                           <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Change Profile image</label>
                                <div class="col-md-7">
                                
                                <label class="btn btn-default btn-file">
                               	 Browse <input type="file" value='' name="user_image" placeholder="" style="display: none;">
                                </label>
                                
                                </div>
                            </div>
                            
                      
                  
                            
                       
						
                        <div class="col-lg-3 col-lg-offset-3">
                        <input type="hidden" name="userId" value='#SESSION["UserDetails"]["Id"]#'>
              			<button type="submit" name="editProfile" value ="Edit" class="btn btn-success width-100 m-r-5">Submit</button>
						</div>
                            
                        </form>
                    </cfoutput>  
                  
                    <!-- end col-6 -->
                    <!-- begin col-6 -->
                   
                </div>
                <!-- end row -->
		</div>
         
