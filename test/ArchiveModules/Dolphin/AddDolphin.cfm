<!--- Update user--->
<cfif isdefined("form.editProfile")>
	 <cfset qEditProfile=Application.SuperAdminApp.EditProfile(argumentCollection="#Form#")>    
</cfif>
<cfset getSourceSex = Application.Dolphin.getSourceSex()>
<cfset getYOBSource=Application.Dolphin.get_YOB_Source()>
<cfset getcatalog=Application.Dolphin.getCatalog()>
<cfset getDscoreCode = Application.Dolphin.getDscoreDropdown()>

		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">Add Dolhpin </li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Add Dolhpin </h1>
			<!-- end page-header -->
			<div class="section-container section-with-top-border p-b-10">
			<div class="row p-t-10">
                    <!-- begin col-6 -->
            <div class="col-md-12">
			<cfoutput>
               <form role="form" id="add_dolphinto_dolhpin" enctype="multipart/form-data">	 
				  <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                  <div class="form-group">
					<label for="email">Dolphin Name:</label>
				 <input type="text" class="form-control" name="Name" required >
				  </div>
                 <div class="form-group">
					<label for="email">Dolphin Code:</label>
				<input type="text" class="form-control" name="Code" required >
				  </div>

                 
				  <div class="form-group">
					<label for="email">Sex:</label>
					<select class="form-control" id="changesex"  name="sex" required>
                    <option value="">Select sex</option>
                    <option value="F">F</option>
                    <option value="M">M</option>
                    </select>
				  </div>
                   <div class="form-group" id="sourcedsex" style="display: none">
                  <label for="email">Source Sex:</label>
                    <select class="form-control" name="sourcesex" >
                        <cfloop query="getSourceSex" >
                       		<option value="#getSourceSex.Ssex#" <cfif getSourceSex.Ssex EQ "Select Source"> selected </cfif> > #getSourceSex.Ssex#</option>
                        </cfloop>
                    </select>
                    </div>
                  
				  <div class="form-group">
					<label for="email">Distict Date:</label>
					<input type="text" class="form-control datepicker_addDol" name="DistinctDate" placeholder="YYYY-MM-DD" required >
				  </div>

               	  <!---<div class="form-group">--->
					<!---<label for="email">Dscore:</label>--->
					<!---<input type="text" class="form-control" name="Dscore" maxlength="2" required >--->
				  <!---</div>--->
                    <div class="form-group">
                        <label for="email">Dscore:</label>
                    <select class="form-control"  name="Dscore"  >
                    <cfloop query="getDscoreCode">
                            <option value="#getDscoreCode.id#"> #getDscoreCode.Dscore#</option>
                    </cfloop>
                    </select>
                    </div>


                  <div class="form-group">
					<label for="email">Date of Death:</label>
					<input type="text" class="form-control datepicker_addDol" name="Date_of_Death" placeholder="YYYY-MM-DD" required >
                  </div>
                  
                  <div class="form-group">
					<label for="email">Year Of Birth:</label>
					<input type="text" class="form-control" name="YearOfBirth" placeholder="year" required >
                  </div>
               <div class="form-group">
               <label for="email">Source YOB:</label>
                <div class="input-group">
                  <div class="input-group-btn">
                    <button class="btn btn-inverse" type="button">Source YOB</button>
                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false"> <span class="caret"></span> </button>
                    <ul class="dropdown-menu">
                   
                      <cfloop query="getYOBSource">
                        <li><a  class="Source_YOB" value="#getYOBSource.ID#">#getYOBSource.YOBSource#</a></li>
                      </cfloop>
                    </ul>
                  </div>
                  <input type="text" id="Source_YOB" class="form-control"  name="Source_YOB" required>
                  <input type="hidden" id="Source_YOB_ID" class="form-control"  name="Source_YOB_ID" required>
                </div>
              </div>
                <div class="form-group">
					<label for="pwd">Best Image:</label>
          			 </div>
                      <div class="form-group">
                          <label for="image">Select Dolphin Photo</label>
                          <img src="" id="alt_img" alt="" width="50" >
                          <input class="input-5" name="BestImage" type="file" class="file-loading">
                      </div>
                          <!-------left end------->
                 </div>
                 
              <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                  <!-------Middel strt------->
                
                <div class="form-group">
					<label for="email">Mothers:</label>
					<input type="text" class="form-control" name="Mothers"  required >
            	</div>
                
                <div class="form-group">
					<label for="email">Grandmother:</label>
					<input type="text" class="form-control" name="Grandmother" maxlength="6"  required >
            	</div>
            	
                <div class="form-group">
					<label for="email">Great Grandmother:</label>
					<input type="text" class="form-control" name="GreatGrandmother" required>
				  </div>
                  
                <div class="form-group">
					<label for="email">Date of Birth EST:</label>
					<input type="text" class="form-control datepicker_addDol"  name="Date_of_Birth_EST" placeholder="YYYY-MM-DD"  required >
            	</div>
                
                <div class="form-group">
					<label for="email">Dispersal Date:</label>
					<input type="text" class="form-control datepicker_addDol" name="Dispersal_Date" placeholder="YYYY-MM-DD"  required >
            	</div>
                
                
                <div class="form-group">
                <label for="email">Catalog:</label>
                <select name="Catalog" class="form-control" required>
                <option value="">Select Catalog</option>
                <cfloop query="getCatalog">
                <option value="#getCatalog.Catalog#">#getCatalog.Catalog#</option>
				</cfloop>
                </select>
                </div>
                
                <div class="form-group">
                <label for="email">Biopsy No:</label>
                        <input type="text" class="form-control" name="Biopsy_No"  required >
                </div>
                

                
                <div class="form-group">
                        <label for="email">First Sighting Date:</label>
                        <input type="text" class="form-control datepicker_addDol" name="First_Sighting_Date" placeholder="YYYY-MM-DD" required >
                 </div>
                 
              	<!-------- middl end----------------->
                 
                 </div>
                 
                 
                 <!-------- Right Side----------------->
               <div class="col-md-4">
                  
                 <div class="form-group">
                <label for="email">CFS ID:</label>
                <input type="text" class="form-control " name="CFSID" required >
                </div>
                
                <div class="form-group">
                <label for="email">Hubbs ID:</label>
                <input type="text" class="form-control " name="HubbsID" required >
                </div>
                
                <div class="form-group">
                <label for="email">MJ ID:</label>
                <input type="text" class="form-control " name="MJID" required >
                </div>
                
                <div class="form-group">
                <label for="email">JU ID:</label>
                <input type="text" class="form-control " name="JUID" required >
                </div>
                
                <div class="form-group">
                <label for="email">FIT ID:</label>
                <input type="text" class="form-control" name="FITID" required >
                </div>
                
                <div class="form-group">
                <label for="email">UNF ID:</label>
                <input type="text" class="form-control" name="UNFID" required >
                </div>
                
                <div class="form-group">
                <label for="email">SAET ID:</label>
                <input type="text" class="form-control" name="SAETID" required >
                </div>
                    
   
               <!---  <div class="form-group">
                 
                     <label for="email">Verified</label>
                     
                     <select class="form-control" name="Verify" required>
                     <option value="">Select</option>
                     <option value="1">Verified</option>
                     <option value="2">Unable To Verify</option>
                     <option value="3">Never Sighted</option>
                     </select>
                     
                    </div>--->
                
              
            <!-------- newdolhpin right side end------>
            </div>
                 
                 
            <div class="col-md-12"> 
                 <div class="message">
				 </div>
                <div class="form-group">
					<button type="submit" class="btn btn-success" name="addnew_dolphin" >Add Dolphin</button>
                     <input type="reset" class="btn btn-defualt reset" />
 				</div>
                 </div>
                  
                 </form>
                
                    </cfoutput>  
                  
                    <!-- end col-6 -->
                    <!-- begin col-6 -->
                   
                </div>
                <!-- end row -->
		</div>
         </div>
         </div>
