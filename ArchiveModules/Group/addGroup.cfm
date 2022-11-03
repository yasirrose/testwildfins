<cfif isdefined('FORM.addGroup')>
    <cfset qGroupInsert = Application.Group.GroupInsert(argumentCollection="#Form#")>
</cfif>


		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;"><cfoutput>#url.ArchiveModule#</cfoutput></a></li>
				<li><a href="javascript:;"><cfoutput>#url.page#</cfoutput></a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Add Group </h1>
			<!-- end page-header -->
				   <cfif isdefined('qGroupInsert') and qGroupInsert.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Added!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif>
			<div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 main-cotainer">
                        <h5 class="m-t-0">Create Group</h5>
                     <cfoutput>
                        <form class="form-horizontal" action="" name="add-group" method="post">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Group Name</label>
                                <div class="col-md-7">
                                    <input type="text" class="form-control" name="group_name" placeholder="please input group name" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Group Status</label>
                                <div class="col-md-7">
                                <select name="group_status" class="form-control">
                                <option value="Enable">Enable</option>
                                <option value="Disable">Disable</option>

                                </select>

                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Group Discription</label>
                                <div class="col-md-7">
                                    <textarea class="form-control" rows="3" name="group_description" placeholder="Description about group"></textarea>
                                </div>

                            </div>
              				<div class="col-lg-3 col-lg-offset-3">
								<button type="submit" name="AddGroup" value ="submit" class="btn btn-success width-100 m-r-5">Submit</button>
								<button class="btn btn-default width-100">Cancel</button>
                            </div>

                        </form>
                    </cfoutput>
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->

                </div>
                <!-- end row -->
		</div>
            <!-- begin #footer -->
            <!-- end #footer -->
		</div>
		<!-- end #content -->
