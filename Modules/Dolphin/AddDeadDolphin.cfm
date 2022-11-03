<!--- Update user--->
<cfif isdefined("form.add_dead_dolphin")>
	 <cfset addDeadDolphin = Application.Dolphin.addDeadDolphin(argumentCollection="#Form#")>    
</cfif>
<cfset getYOBSource=Application.Dolphin.get_YOB_Source()>
<cfset getcatalog=Application.Dolphin.getCatalog()>

		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">Add Dead Dolphin </li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Add Dead Dolphin </h1>
			<!-- end page-header -->
			<div class="section-container section-with-top-border p-b-10">
			<div class="row p-t-10">
                    <!-- begin col-6 -->
            <div class="col-md-12">
            
			<cfoutput>
               <form role="form" action="" method="post" id="add_dolphinto_dolhpin">	 
				  <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                  <div class="form-group">
					<label for="email">Water Body:</label>
					<input type="text" class="form-control" name="waterBody" placeholder="year" required>
                  </div>
                  <div class="form-group">
					<label for="email">Field Id:</label>
				 <input type="text" class="form-control" name="Field_ID" required>
				  </div>
                
                  <div class="form-group">
					<label for="email">Month:</label>
					<input type="text" class="form-control" name="Month"  required>
				  </div>
                  <div class="form-group">
					<label for="email">Day:</label>
					<input type="text" class="form-control" name="Day" required>
				  </div>
                 
				  <div class="form-group">
					<label for="email">Year:</label>
					<input type="text" class="form-control" name="Year" required>
				  </div>
                  
				  <div class="form-group">
					<label for="email">Body condition Code:</label>
					<input type="text" class="form-control" name="bodyConditionCode"  required>
				  </div>
                  <div class="form-group">
					<label for="email">Code:</label>
					<input type="text" class="form-control" name="Code"  required>
				  </div>
                   <div class="form-group">
					<label for="email">FB No:</label>
					<input type="text" class="form-control" name="FB_No"  required>
				  </div>
                  
               	  <div class="form-group">
					<label for="email">Dscore:</label>
					<input type="text" class="form-control" name="Dscore" maxlength="2"  required>
				  </div>
                  
                  <div class="form-group">
					<label for="email">Year Of Birth:</label>
					<input type="text" class="form-control" name="YearOfBirth" placeholder="year" required>
                  </div>
                  
                   
               <div class="form-group">
               <label for="email">Source YOB:</label>
                <div class="input-group">
                  <div class="input-group-btn">
                    <button class="btn btn-inverse" type="button">Source YOB</button>
                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false"> 
                    <span class="caret"></span> </button>
                    <ul class="dropdown-menu">
                   
                      <cfloop query="getYOBSource">
                        <li><a  class="Source_YOB" value="#getYOBSource.ID#">#getYOBSource.YOBSource#</a></li>
                      </cfloop>
                    </ul>
                  </div>
                  <input type="text" id="Source_YOB" class="form-control"  name="Source_YOB" required>
                  <input type="hidden" id="Source_YOB_ID" class="form-control"  name="Source_YOB_ID" >
                </div>
              </div>
               
                          <!-------left end------->
                 </div>
                 
              <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                  <!-------Middel strt------->
                
                <div class="form-group">
					<label for="email">Age at death:</label>
					<input type="text" class="form-control" name="ageAtDeath" required>
            	</div>
                
                <div class="form-group">
					<label for="email">In Catalogue:</label>
					<input type="text" class="form-control" name="inCataloque" maxlength="6" required>
            	</div>
            	
                <div class="form-group">
					<label for="email">Not in Catalogue:</label>
					<input type="text" class="form-control" name="notInCataloque" required>
				  </div>
                  
                <div class="form-group">
					<label for="email">One thingers In Catalogue:</label>
					<input type="text" class="form-control"  name="oneThingsInCateloque" required>
            	</div>
                
                <div class="form-group">
					<label for="email">clean calf of known mom:</label>
					<input type="text" class="form-control" name="cleanCalfOfKnownMom" required>
            	</div>
                <div class="form-group">
					<label for="email">Unmarked:</label>
					<input type="text" class="form-control" name="Unmarked" required>
            	</div>
                <div class="form-group">
					<label for="email">Dorsal decomposed or scavenged:</label>
					<input type="text" class="form-control" name="dorsalDecomposed" required>
            	</div>
                <div class="form-group">
					<label for="email">Poor quality photo or No photo:</label>
					<input type="text" class="form-control" name="poorQualityPhoto" required>
            	</div>
                <div class="form-group">
					<label for="email">Unrecoveredo:</label>
					<input type="text" class="form-control" name="Unrecoveredo" required>
            	</div>
                 <div class="form-group">
					<label for="email">Mom pushing dead calf:</label>
					<input type="text" class="form-control" name="momPushingDeadCalf" required>
            	</div>
               
              	<!-------- middl end----------------->
                 
                 </div>
                 
                 
                 <!-------- Right Side----------------->
               <div class="col-md-4">
                  
                 <div class="form-group">
                <label for="email">Dead dorsal photo on file:</label>
                <input type="text" class="form-control " name="deadDorsalPhoto" required>
                </div>
                
                <div class="form-group">
                <label for="email">Sex:</label>
					<select class="form-control" name="sex" required>
                    <option value="">Select sex</option>
                    <option value="F">F</option>
                    <option value="M">M</option>
                    </select>
                </div>
                
                <div class="form-group">
                <label for="email">Body length (cm):</label>
                <input type="text" class="form-control " name="bodyLenght"  required>
                </div>
                
                <div class="form-group">
                <label for="email">Age cohort (Adult, Juvenile, Calf):</label>
                <input type="text" class="form-control " name="ageCohort" required>
                </div>
                
                <div class="form-group">
                <label for="email">Details:</label>
                <textarea class="form-control" name="Details" required></textarea>
                </div>
                <div class="form-group">
                <label for="email">Other accession numbers:</label>
                <input type="text" class="form-control " name="otherAccessionNumbers" required>
                </div>
               
               
                <div class="form-group">
                <label for="email">Photo type:</label>
                <input type="text" class="form-control " name="photoType" required>
                </div>
                <div class="form-group">
                <label for="email">IRL segment -AUTOMATED WITH GPS:</label>
                <input type="text" class="form-control " name="irlSegment" required>
                </div>
                <div class="form-group">
                <label for="email">UTM Easting (X) coordinates:</label>
                <input type="text" class="form-control " name="utmEsting" required>
                </div>
                <div class="form-group">
                <label for="email">UTM Northing (Y) coordinates:</label>
                <input type="text" class="form-control " name="utmNorting" required>
                </div>
                
               
            <!-------- newdolhpin right side end------>
            </div>
                 
                 
            <div class="col-md-12"> 
                 <div class="message">
				 </div>
                <div class="form-group">
					<button type="submit" class="btn btn-success" name="add_dead_dolphin" >Add Dolphin</button>
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
