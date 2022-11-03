
<cfoutput>
<cfif isdefined('form.PROJECT_ID') and form.project_id gt 0 and form.sight_id GT 0>

<!-------------  Dolphine ---------------------------------->
<cfparam name="form.PROJECT_ID" default="0">
<cfquery name="dolphine" datasource="#Application.dsn#" result ='get_dolphine_result'>
	select ID,Code,Name   from DOLPHINS order by id ASC
</cfquery>

<cfparam name="qGetSightings.id" default="0">

<!---<cfquery name="project_sightins" datasource="#Application.dsn#">
	SELECT ID FROM SIGHTINGS WHERE Project_ID = #form.PROJECT_ID#
</cfquery>--->
<!---GET ALL SIGHTINGS_DOLPHINS OF PROJECT--->

<cfquery name="project_detail" datasource="#Application.dsn#">
    SELECT DATE FROM PROJECTS WHERE ID = #form.PROJECT_ID#
</cfquery>
<cfquery name="dolphine_sight" datasource="#Application.dsn#" result ='get_dolphine_result'>
    SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID  = #form.sight_id#   order by DOLPHIN_SIGHTINGS.Sighting_ID;
</cfquery>

<cfquery name="singleSightingDolphins" datasource="#Application.dsn#" result ='get_dolphine_result'>
    SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID=#qGetSightings.id# order by DOLPHIN_SIGHTINGS.Sighting_ID;
</cfquery>

<cfquery name="TLU_SDO" datasource="#Application.dsn#" result ='get_sdo'>
	SELECT * FROM TLU_SDO
</cfquery>

<cfquery name="getYOBSource" datasource="#Application.dsn#" result ='get_YOB_Source'>
	SELECT * FROM TLU_YOB_Source
</cfquery>
<cfset getcatalog=Application.Dolphin.getCatalog()>
<cfset getuserlist=Application.Accounts.getuserlist()>
<div id="dolphin" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" id="dolphin_modal_close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Dolphin</h4>
      </div>

	  <div class="col-md-12 panel-heading pull-right" id="dscore_assign">
      <a class="btn btn-success pull-right" >Add New</a>
      </div>
      
      <div class="col-md-12 panel-heading" id="goback-block" style="display:none">
      <a class="btn btn-primary pull-right" id="goback" style="display:none">Go Back</a> 
      <!---<a class="btn btn-primary pull-right" id="dolhphinadd" style="display:none;margin-right: 5px">Add Dolphin</a> --->
      <a class="btn btn-primary pull-right" id="dolhphinassign" style="display:none;margin-right: 5px">Sighting</a>
      </div>
     
	 <div class="modal-body" style="overflow:hidden">
      
      <div class="col-md-12 add_new_dolphin_form" style="display:none">
       <h2>Add New  Dolphin</h2>
	  
      <div class="panel-body">
      
      
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
					<select class="form-control" name="sex" required>
                    <option value="">Select sex</option>
                    <option value="F">F</option>
                    <option value="M">M</option>
                    </select>
				  </div>
                  
				  <div class="form-group">
					<label for="email">Distict Date:</label>
					<input type="text" class="form-control datetimepicker" name="DistinctDate" placeholder="YYYY-MM-DD" required >
				  </div>

               	  <div class="form-group">
					<label for="email">Dscore:</label>
					<input type="text" class="form-control" name="Dscore" maxlength="2" required >
				  </div>
                  
                  <div class="form-group">
					<label for="email">Date of Death:</label>
					<input type="text" class="form-control datetimepicker" name="Date_of_Death" placeholder="YYYY-MM-DD" required >
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
               
             <div class="message">
				 </div>
                <div class="form-group">
					<button type="submit" class="btn btn-success" name="addnew_dolphin" >Add Dolphin</button> 
                    <input type="reset" class="btn btn-defualt reset" />
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
					<input type="text" class="form-control" id="datetimepickerEST" name="Date_of_Birth_EST"  required >
            	</div>
                
                <div class="form-group">
					<label for="email">Dispersal Date:</label>
					<input type="text" class="form-control datetimepicker" name="Dispersal_Date"  required >
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
                        <input type="text" class="form-control datetimepicker" name="First_Sighting_Date" placeholder="YYYY-MM-DD" required >
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
                 
                     <label for="email">Verified</label>
                     
                     <select class="form-control" name="Verify" required>
                     <option value="">Select</option>
                     <option value="1">Verified</option>
                     <option value="2">Unable To Verify</option>
                     <option value="3">Never Sighted</option>
                     </select>
                     
                    </div>
                
              
            <!-------- newdolhpin right side end------>
            </div>
                 
                 
            <div class="col-md-12"> 
               
                
                 </div>
                  
                 </form>
               
                
      </div>
      </div>
      
      
	   <div class="col-md-12 add_new" style="display:none">
	   <h2>Assign Dolphin to Sighting</h2>
	   
		<div class="panel-body ">
            <form role="form" id="add_dolphin_form" <!---onsubmit="return submitForm();"---> enctype="multipart/form-data">	 
                     
                     <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                     <div class="form-group">
                         <div class="label-wrap inline-box SDR_layout">
                             <label for="pwd">Same Day Resight:</label>
                             <div class="form-inline">
                                <input type="checkbox" class="checkbox-inline" name="SDR" value="1">
                             </div>
                         </div>
                     </div>
                     <div class="form-group selectwidth">
                        <label for="email">Dolphin Name/Code:</label>
    
                        <select class="form-control multiple-select2" required id="dolphin_code" name="Dolphin_ID">
                        <option value="">Select Code</option>
                        <cfloop query="dolphine">
                        <option value="#dolphine.ID#"> #dolphine.Name# | #dolphine.Code# </option>
                        </cfloop>
                        </select>
    
                          </div>
                            <input type="hidden" name="dolphnname" id="dolphnname">
                     
                      <div class="form-group">
                        <input type="hidden" name="Sighting_ID" id="getsight_ID" value="#qGetSightings.id#">
                      
                        <label for="pwd">Sex:</label>
                        <input type="text" class="form-control" id="add_sex" readonly >
                      </div>
                    
                      <div class="form-group">
                        <label for="pwd">Lineage:</label>
                        <input type="text" class="form-control" id="add_Lineage" readonly>
                      </div>
                      
                      <div class="form-group">
                        <label for="pwd">Distict Date:</label>
                        <input type="text" class="form-control" id="add_distictdate" readonly>
                      </div>
                         
                       <div class="form-group">
                        <label for="pwd">Distict:</label>
                        <input type="checkbox" class="checkbox-inline" id="add_distict"  value="1" disabled  readonly>
                      </div>
                    <div class="form-group">
                        <div class="label-wrap">
                            <label for="pwd">Fetals:</label>
                            <input type="checkbox" class="checkbox-inline" name="Fetals" value="1">
                        </div>
                        <div class="input-wrap">
                            <input type="text" class="form-control body-condition" name="Fetals_Description" id="Fetals_Description" value="">
                        </div>
                    </div>
    
                     <div class="form-group">
                        <label for="pwd">Dscore:</label>
                        <input type="text" class="form-control" id="add_dscore" readonly>
                      </div>
                     <div class="form-group">
                        <label for="pwd">FB_No:</label>
                        <input type="text" class="form-control" id="add_FB_No" readonly>
                     </div>
                     
                      <div class="form-group">
                        <label for="pwd">Note:</label>
                        <textarea class="form-control" name="Note"></textarea>
                      </div>
            
                     
                      <!---<div class="form-group">--->
                        <!---<label for="pwd">Echelonsssss:</label>--->
                        <!---<input type="text"   class="form-control" name="Echelon" maxlength="5">--->
                      <!---</div>--->
            
                   <input type="hidden" id="dscore_date" name="dscoredate">
                        <div class="form-group">
                            <label for="email">Echelon:</label>
    
                        <select class="form-control"  name="Echelon" >
                            <option value="1">Yes</option>
                            <option value="0">No</option>
                        </select>
                        </div>
    
                 <!---<div class="form-group">--->
                        <!---<label for="pwd">REMPI:</label>--->
                        <!---<input type="text" class="form-control" name="REMPI" maxlength="5">--->
                    <!---</div>--->
                    <!------>
                    <!---<div class="form-group">--->
                        <!---<label for="pwd">Body Condition:</label>--->
                        <!---<input type="text" class="form-control" name="BodyCondition">--->
                      <!---</div>--->
    
                    <div class="form-group">
                        <label class="control-label">Select Dolphin Photo</label>
                        <img src="" id="alt_img" alt="" width="50" > 
                        <input id="input-4" name="BestImage" type="file"  class="file-loading">
                    </div>
                    <div class="form-group">
                        <label for="pwd">Best Shot </label>
                        <input type="text" class="form-control" id="BestShot" name="BestShot">
                    </div>
                    <!---<div class="form-group">--->
                    <!---<label for="pwd">Best Image:</label>--->
                    <!---<input type="text" class="form-control" name="BestImage">--->
                    <!---</div>--->
                    
                    <div class="form-group">
                        <div class="label-wrap">
                        	<label for="pwd">Entered By:</label>
                        </div>
                        <div class="input-wrap">
                            <select class="form-control" id="entered_by" name="entered_by">
                                <option value="">Select Entered By</option>
                                <cfloop query="getuserlist"><option value="#user_id#" <cfif SESSION['UserDetails']['Id'] eq user_id>selected</cfif>>#first_name# #last_name#</option></cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label-wrap">
                        	<label for="pwd">Review:</label>
                        </div>
                        <div class="input-wrap">
                            <select class="form-control" id="review" name="review">
                                <option value="">Select Review</option>
                                <option value="Review Complete">Review Complete</option>
                                <option value="To be Reviewed">To be Reviewed</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="label-wrap">
                        	<label for="pwd">Reviewed By:</label>
                        </div>
                        <div class="input-wrap">
                            <select class="form-control" id="reviewed_by" name="reviewed_by">
                                <option value="">Select Reviewed By</option>
                                <cfloop query="getuserlist">
                                    <option value="#user_id#">#first_name# #last_name#</option>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                      	<div class="message"></div>
                     	<button type="submit" class="btn btn-success" id="add_new_dolphin">Submit</button>
                     	<button type="reset" class="btn btn-default reset">Reset</button>
                    </div> 
                    
                     </div>
                     
                     <!--------- Right Side-------------->
                     <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                     
                    <!---<div class="form-group">--->
                            <!---<div class="input-group">--->
                            <!---<div class="input-group-btn">--->
                                <!---<button class="btn btn-inverse" type="button">Verified</button>--->
                                <!---<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">--->
                                    <!---<span class="caret"></span>--->
                                <!---</button>--->
                                <!---<ul class="dropdown-menu">--->
                                    <!---<li><a val="P" class="get_val" id="add_varified_1">P</a></li>--->
                                    <!---<li><a val="V" class="get_val" id="add_varified_2">V</a></li>--->
                                    <!---</ul>--->
                            <!---</div>--->
                            <!---<input type="text" id="add_varified" class="form-control" value="p" maxlength="7"  name="Verified">--->
                         <!---</div>--->
                        <!---</div>--->
                            
            
                    <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">PQ F:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a val="2" class="get_val sum_calculate" id="add_pqf_1">2</a></li>
                                <li><a val="4" class="get_val sum_calculate" id="add_pqf_2">4</a></li>
                                <li><a val="6" class="get_val sum_calculate" id="add_pqf_3">6</a></li>
                                </ul>
                        </div>
                        <input type="number" class="form-control sum_calculate" min="0" id="add_pqf" name="pq_focus" value="0">
                     </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">PQ A:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a val="1" class="get_val sum_calculate" id="add_pqa_1">1</a></li>
                                <li><a val="2" class="get_val sum_calculate" id="add_pqa_2">2</a></li>
                                <li><a val="8" class="get_val sum_calculate" id="add_pqa_3">8</a></li>
                                </ul>
                        </div>
                        <input type="number" class="form-control sum_calculate" min="0" name="pq_Angle" id="add_pqa" value="0">
                     </div>
                    </div>
                    
                    
                    <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">PQ C:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a val="1" class="get_val sum_calculate" id="add_pqc_1">1</a></li>
                                <li><a val="3" class="get_val sum_calculate" id="add_pqc_2">3</a></li>
                                </ul>
                        </div>
                        <input type="number" class="form-control sum_calculate" name="pq_Contrast" min="0" id="add_pqc" value="0">
                     </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">Pq Pro:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a val="1" class="get_val sum_calculate" id="add_pqpro_1">1</a></li>
                                <li><a val="5" class="get_val sum_calculate" id="add_pqpro_2">5</a></li>
                                </ul>
                        </div>
                        <input type="number" class="form-control sum_calculate" name="pq_Proportion" min="0" id="add_pqpro" value="0">
                     </div>
                    </div>
                    
                <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">Pq Par:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a val="1" class="get_val sum_calculate" id="add_pqpar_1">1</a></li>
                                <li><a val="8" class="get_val sum_calculate" id="add_pqpar_1">8</a></li>
                                </ul>
                        </div>
                        <input type="number" class="form-control sum_calculate" name="pq_Partial" min="0" id="add_pqpar" value="0">
                     </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="pwd">Pq sum:</label>
                        <input type="number" class="form-control" id="add_pqsum" value="0" name="pqSum"  readonly>
                      </div>
                <div class="form-group">
                    <label for="pwd">Qscore:</label>
                    <input type="text" class="form-control" name="Qscore" id="add_qscoresum">
                </div>
                    
                    <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">SDO1:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                            <cfset t=0>
                            <cfloop query="TLU_SDO">
                            <cfset t=t+1>
                                <li><a val="#TLU_SDO.SDO_ID#" class="getvals" id="add_SDO1_#t#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a></li>
                            </cfloop>
                            </ul>
                        </div>
                        <input type="text" class="form-control" id="add_SDO1" value="0" readonly>
                        <input type="hidden" class="form-control" id="add_SDO1_ID" name="SDO1" value="0" readonly>
                     </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">SDO2:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                            <cfset t=0>
                            <cfloop query="TLU_SDO">
                            <cfset t=t+1>
                                <li><a val="#TLU_SDO.SDO_ID#" class="getvals" id="add_SDO2_#t#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a></li>
                            </cfloop>
                            </ul>
                        </div>
                        <input type="text" class="form-control" id="add_SDO2" value="0" readonly>
                        <input type="hidden" class="form-control" id="add_SDO2_ID" name="SDO2" value="0" readonly>
                     </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">SDO3:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                            <cfset t=0>
                            <cfloop query="TLU_SDO">
                            <cfset t=t+1>
                                <li><a val="#TLU_SDO.SDO_ID#" class="getvals" id="add_SDO3_#t#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a></li>
                            </cfloop>
                            </ul>
                        </div>
                        <input type="text" class="form-control" id="add_SDO3" value="0" readonly>
                        <input type="hidden" class="form-control" id="add_SDO3_ID" name="SDO3" value="0" readonly>
                     </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                        <div class="input-group-btn">
                            <button class="btn btn-inverse" type="button">SDO4:</button>
                            <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu">
                            <cfset t=0>
                            <cfloop query="TLU_SDO">
                            <cfset t=t+1>
                                <li><a val="#TLU_SDO.SDO_ID#" class="getvals" id="add_SDO4_#t#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a></li>
                            </cfloop>
                            </ul>
                        </div>
                        <input type="text" class="form-control" id="add_SDO4" value="0" readonly>
                        <input type="hidden" class="form-control" id="add_SDO4_ID" name="SDO4" value="0" readonly>
                     </div>
                    </div>
                      
                      <!---<div class="form-group">--->
                        <!---<label for="pwd">PQP:</label>--->
                        <!---<input type="checkbox" class="checkbox-inline" name="PQP" value="1">--->
                      <!---</div>--->
                      
                      <div class="form-group">
                      <h3>Heath and Fitness
                      </h3>
                      
    
                        <!---<div class="input-wrap">--->
                            <!---<input type="text" class="form-control body-condition" name="SDR_Description" id="SDR_Description" value="">--->
                        <!---</div>--->
                      </div>
                      
    
                      
                       <!---<div class="form-group">--->
                        <!---<div class="label-wrap">--->
                            <!---<label for="pwd">BC:</label>--->
                            <!---<input type="checkbox" class="checkbox-inline" name="BC"  value="1">--->
                        <!---</div>--->
                        <!---<div class="select-wrap">--->
                            <!---<select  class="form-control bc-rate"   name="BC_rate" >--->
                                <!---<option value="">BC Rate</option>--->
                                <!---<option value="1">1</option>--->
                                <!---<option value="2">2</option>--->
                                 <!---<option value="3">3</option>--->
                                  <!---<option value="4">4</option>--->
                                   <!---<option value="5">5</option>--->
                            <!---</select>--->
                        <!---</div>--->
                        <!---<div class="input-wrap after-select-input">--->
                            <!---<!---<input type="text" class="form-control" style="width:10%;" name="BC_rate" id="BC_rate" value="">--->--->
                            <!---<input type="text" class="form-control body-condition" name="BC_Description" id="BC_Description" value="">--->
                         <!---</div>--->
                     <!---</div>--->
                     
                      
                      
                      <div class="form-group">
                        <div class="label-wrap inline-box">
                            <label for="pwd">Xeno:</label>
                            <div class="form-inline">
                                <p>yes</p>
                                <input type="radio" id="xnone" name="Xeno" value="1">
                            </div>
                            <div class="form-inline">
                                <p>No</p>
                                <input type="radio" id="xnozero" name="Xeno" value="0">
                            </div>
                        </div>
                        <!---<div class="input-wrap">--->
                            <!---<input type="text" class="form-control body-condition"  name="Xeno_Description" id="Xeno_Description" value="">--->
                         <!---</div>--->
                      </div>
                    
                      <div class="form-group">
                        <div class="label-wrap inline-box">
                            <label for="pwd">RDS:</label>
                            <div class="form-inline">
                                <p>Yes</p>
                                <input type="radio" id="rdsone" class="checkbox-inline" name="RDS" value="1">
                            </div>
                            <div class="form-inline">
                                <p>No</p>
                                <input type="radio" id="rdszero" class="checkbox-inline" name="RDS" value="0">
                            </div>
                        </div>
                        <!---<div class="input-wrap">--->
                            <!---<input type="text" class="form-control body-condition"  name="RDS_Description" id="RDS_Description" value="">--->
                        <!---</div>--->
                      </div>
                      
                      <div class="form-group">
                        <div class="label-wrap inline-box">
                           <label for="pwd">REM:</label>
                           <div class="form-inline">
                                <p>Yes</p>
                                <input type="radio" id="remone"  class="checkbox-inline" name="REM"  value="1">
                           </div>
                           <div class="form-inline"> 
                                <p>No</p>
                                <input type="radio" id="remzero" class="checkbox-inline" name="REM"  value="0">
                           </div> 
                        </div>
                        <!---<div class="input-wrap">--->
                            <!---<input type="text" class="form-control body-condition" name="REM_Description" id="REM_Description" value="">--->
                        <!---</div>--->
                      </div>
                     
                      <div class="form-group">
                        <div class="label-wrap inline-box">
                           <label for="pwd">Fresh wound:</label>
                           <div class="form-inline">
                                <p>Yes</p>
                                <input type="radio" id="freshone" class="checkbox-inline" name="Freshwound"  value="1">
                           </div>
                           <div class="form-inline"> 
                                <p>No</p>
                                <input type="radio" id="freshzero" class="checkbox-inline" name="Freshwound"  value="0">
						   </div>    
                        </div>
                        <!---<div class="input-wrap">--->
                            <!---<input type="text" class="form-control body-condition" name="Freshwound_Description" id="Freshwound_Description" value="">--->
                        <!---</div>--->
                      </div>
                      
                      <!---<div class="form-group">--->
                        <!---<label for="pwd">W/mom:</label>--->
                        <!---<input type="checkbox" class="checkbox-inline" name="wMom"  value="1">--->
                      <!---</div>--->
                      
                      
                        <!---<div class="form-group">
                            <div class="label-wrap">
                                <label for="pwd">Tiger:</label>
                                <input type="checkbox" class="checkbox-inline" name="Tiger" id="tgr" value="1">
                            </div>
                            <div class="input-wrap">
                            	<input type="text" class="form-control body-condition" name="Tiger_Description" id="Tiger_Description" value="">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label-wrap">
                                <label for="pwd">Shark:</label>
                                <input type="checkbox" id="shrk" class="checkbox-inline" name="Shark" value="1">
                            </div>
                            <div class="input-wrap">
                                <input type="text" class="form-control body-condition" name="shark_Description" id="shark_Description" value="">
                            </div>
                        </div>--->
                        <div class="form-group">
                            <div class="label-wrap">
                                <label for="Dolphin_Sighting_Date">Date of sighting:</label>
                            </div>
                            <div class="input-wrap">    
                        		<input type="text" class="form-control datetimepicker" value="#DateTimeFormat(project_detail.Date, 'YYYY-MM-DD')#" name="Dolphin_Sighting_Date" placeholder="YYYY-MM-DD" required >
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label-wrap">
                                <label for="body_condition">Body Condition:</label>
                            </div>
                            <div class="input-wrap">
                                <select class="form-control" id="BodyCondition" name="BodyCondition">
                                    <option value="">Select Body Condition</option>
                        			<option value="Shark Bite">Shark Bite</option>
                                    <option value="Tiger Stripes">Tiger Stripes</option>
                                    <option value="Pox">Pox</option>
                                    <option value="Boat Hit">Boat Hit</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label-wrap">
                                <label for="region">Region:</label>
                            </div>
                            <div class="input-wrap">
                                <select class="form-control" id="Region" name="Region">
                                    <option value="">Select Region</option>
                                    <cfloop from="1" to="8" index="j">
                                		<option value="#j#">#j#</option>
                                	</cfloop>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label-wrap">
                                <label for="Side">Side:</label>
                            </div>
                            <div class="input-wrap">
                                <select class="form-control" id="Side" name="Side">
                                    <option value="">Select Side L/R</option>
                                    <option value="L">L</option>
                                    <option value="R">R</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label-wrap">
                                <label for="Status">Status:</label>
                            </div>
                            <div class="input-wrap">
                                <select class="form-control" id="Status" name="Status">
                                    <option value="">Select Status</option>
                                    <option value="1-Fresh">1-Fresh</option>
                                    <option value="2-Healing">2-Healing</option>
                                    <option value="3-Healed">3-Healed</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label-wrap">
                                <label for="pwd">Area:</label>
                            </div>
                            <div class="input-wrap">
                                <select class="form-control" id="Area" name="Area">
                                    <option value="">Select Area</option>
                        			<option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                    <option value="E">E</option>
                                    <option value="F">F</option>
                                    <option value="G">G</option>
                                    <option value="H">H</option>
                                    <option value="I">I</option>
                                    <option value="J">J</option>
                                </select>
                            </div>
                        </div>        
    					<div class="form-group">
                        	<a href="javascript:void(0);" class="btn btn-success" id="btn_dolphin_history" style="float:right;margin-top: 23px;">History</a>
                            <label for="image">Choose Photo</label>
                            <img src="" id="alt_img" alt="" width="50" >
                            <input class="input-5" name="SightingImage" type="file" class="file-loading">
                        </div>
                     </div>
                </form>
		</div>
	   </div>
	  
	  
	  
	  
	  <div class="col-md-12 display_data">
      <!------------------------------------->
      <cfparam name='d1total' default="0">
      <cfparam name='d2total' default="0">
      <cfparam name='d3total' default="0">
      <cfparam name='d4total' default="0">
      <cfparam name='d5total' default="0">
      <cfparam name='d6total' default="0">
		<cfparam name='d7total' default="0">
		<cfparam name='d8total' default="0">
		<cfparam name='d9total' default="0">
		<cfparam name='d10total' default="0">
      <cfparam name='total' default="0">
      
      <cfloop query="dolphine_sight" group="Code">
      	 <cfquery name="dscore" datasource="#Application.dsn#">
                    select top 1 DScore  from Dolphin_DScore where DolphinID=#singleSightingDolphins.Dolphin_ID# order by ID DESC
          </cfquery>
          <!------>
			<cfif dscore.DScore EQ 'D1'>
				<cfset d1total =d1total+1>
			</cfif>
			<cfif dscore.DScore EQ 'D2'>
				<cfset d2total =d2total+1>
			</cfif>
			<cfif dscore.DScore EQ 'D3'>
				<cfset d3total =d3total+1>
			</cfif>
			<cfif dscore.DScore EQ 'D4'>
				<cfset d4total =d4total+1>
			</cfif>
			<cfif dscore.DScore EQ 'D5'>
				<cfset d5total =d5total+1>
			</cfif>
			<cfif dscore.DScore EQ 'D6'>
				<cfset d6total =d6total+1>
			</cfif>
			<cfif dscore.DScore EQ 'D7'>
				<cfset d7total =d7total+1>
			</cfif>
			<cfif dscore.DScore EQ 'D8'>
				<cfset d8total =d8total+1>
			</cfif>
			<cfif dscore.DScore EQ 'D9'>
				<cfset d9total =d9total+1>
			</cfif>

			<cfif dscore.DScore EQ 'D10'>
				<cfset d10total =d10total+1>
			</cfif>


		</cfloop>
 	 <cfset total=d1total+d2total+d3total+d4total+d5total+d6total+d7total+d8total+d9total+d10total>


	  	<h2>List of Dolphins</h2>
		<div class="right-box-dolphin p-10 m-b-20 col-lg-12">
          <div class="row"><div class="pull-right col-lg-2 m-b-10 p-0 m-r-10">
            	<label>D Total</label>
                <input type="text" value="#total#" class="form-control d-total">
            </div></div>
           <div class="row">
            <div class="col-lg-2">
            	<label>D1</label>
                <input type="text" value="#d1total#" class="form-control" />
            </div>
            <div class="col-lg-2">
            	<label>D2</label>
                <input type="text" value="#d2total#" class="form-control" />
            </div>
			<div class="col-lg-2">
				<label>D3</label>
					<input type="text" class="form-control" value="#d3total#" />
			</div>
			<div class="col-lg-2">
				<label>D4</label>
					<input type="text" class="form-control" value="#d4total#" />
			</div>
			<div class="col-lg-2">
				<label>D5</label>
					<input type="text" class="form-control" value="#d5total#" />
			</div>
			<div class="col-lg-2">
				<label>D6</label>
					<input type="text" class="form-control" value="#d6total#" />
			</div>
			<div class="col-lg-2">
				<label>D7</label>
					<input type="text" class="form-control" value="#d7total#" />
			</div>
			<div class="col-lg-2">
				<label>D8</label>
					<input type="text" class="form-control" value="#d8total#" />
			</div>
			<div class="col-lg-2">
				<label>D9</label>
					<input type="text" class="form-control" value="#d9total#" />
			</div>
			<div class="col-lg-2">
				<label>D10</label>
					<input type="text" class="form-control" value="#d10total#" />
			</div>
	     </div>
           </div>
		<div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff">
		<div class="col-md-2">Dophin Code</div>
		<div class="col-md-1">DScore</div>
		<div class="col-md-2">DScore Date</div>
        <div class="col-md-2">Sighting ID</div>
        <div class="col-md-1">Sex</div>
        <div class="col-md-2">Lineage</div>
		<div class="col-md-2">Actions</div>
		
        </div>
		<cfset i=0>
		<cfloop query="dolphine_sight" group="Code">
			<cfset i=i+1>
            <div class="row" id="dolphindetail_#i#">
				<!----------
                         ---
                         --- Find Dscore
                         ---
                         ------------>
                <cfset dscore_date="">
                    <cfquery name="dscore" datasource="#Application.dsn#">
                        select top 1 * from Dolphin_DScore where DolphinID = #dolphine_sight.Dolphin_ID# order by DScoreDate DESC
                    </cfquery>
                <cfset dscore_date="#dscore.DScoreDate#">
                        
                <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;">
                    <!---<div class="col-md-2">#dolphine_sight.Name#</div>--->
                    <div class="col-md-2">#dolphine_sight.Code#</div>
                    <div class="col-md-1">#dscore.DScore#</div>
                    <div class="col-md-2">#DateFormat(dscore.DScoreDate, 'YYYY-MM-DD')#</div> 
                    <div class="col-md-2">#dolphine_sight.Sighting_ID#</div> 
                    <div class="col-md-1">#dolphine_sight.Sex#</div> 
                    <div class="col-md-2">#dolphine_sight.Lineage#</div> 
                    <div class="col-md-2">
                        <button  href="##collapse#i#" class="btn btn-xs btn-primary" data-toggle="collapse" >
                        <i class="fa fa-pencil-square-o"></i></button>
                       
                        <button type="button" id="delete_#i#" class="btn btn-xs btn-primary delete_dolphin" 
                        Sighting_ID="#dolphine_sight.Sighting_ID#" Dolphin_ID="#dolphine_sight.Dolphin_ID#">
                        <i class="glyphicon glyphicon-trash"></i></button>
                        <cfif dolphine_sight.review eq 'Review Complete'>
                            <a href="" title="Review Complete" style="background-color:  ##5cb85c;color:  ##fff;padding: 2px 6px;font-size: 13px;border-radius: 3px;"><i class="fa fa-check-square"></i></a>
                        <cfelseif dolphine_sight.review eq 'To be Reviewed'>
                            <a href="" title="Need Review" style="background-color:  ##c03c38;color:  ##fff;padding: 2px 6px;font-size: 13px;border-radius: 3px;"><i class="fa fa-search"></i></a>
                    </cfif>
                    </div> 
                </div>
                <div id="collapse#i#" class="col-md-12 panel-collapse collapse" style="border: solid 2px ##ccc;">
                    <div class="panel-body">
                        
                        <form role="form" id="update_dolhpin_#i#">	 
                        
                                         <!--------- Left Side-------------->
                         <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                             <div class="form-group">
                                <div class="label-wrap inline-box SDR_layout">
                                    <label for="pwd">Same Day Resight:</label>
                                    <div class="form-inline">
                                        <input type="checkbox" class="checkbox-inline" name="SDR" <cfif dolphine_sight.SDR eq 1>checked</cfif> value="1">
                                    </div>
                                </div>
                             </div>
                            <div class="form-group selectwidth">
                                <label for="Dolphin_ID">Dolphin Name/Code:</label>
                                <select class="form-control" required id="dolphin_up_code" readonly name="Dolphin_ID">
                                    <option value="#dolphine_sight.Dolphin_ID#" >
                                    <cfloop query="dolphine"><cfif dolphine_sight.Dolphin_ID eq dolphine.id > #dolphine.Name# | #dolphine.code# </cfif></cfloop></option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="pwd">Sex:</label>
                                <input type="text" class="form-control"  value="#dolphine_sight.Sex#" id="update_sex" readonly >
                            </div>
                            
                            <div class="form-group">
                                <label for="pwd">Lineage:</label>
                                <input type="text" class="form-control" id="update_Lineage" readonly  value="#dolphine_sight.Lineage#">
                            </div>
                            
                            <div class="form-group">
                                <label for="pwd">Distict Date:</label>
                                <input type="text" class="form-control" id="update_distictdate" readonly value="#DateTimeFormat(dolphine_sight.DistinctDate, 'YYYY-MM-DD')#">
                            </div>
                            
                            <div class="form-group">
                                <label for="pwd">Distict:</label>
                                <input type="checkbox" class="checkbox-inline"  
                                <cfif dolphine_sight.Distinct eq 1>checked</cfif> id="update_distict"  value="1" disabled  readonly>
                            </div>
                        <div class="form-group">
                        <div class="label-wrap">
                            <label for="pwd">Fetals:</label>
                                <input type="checkbox" class="checkbox-inline" name="Fetals" <cfif dolphine_sight.Fetals eq 1>checked</cfif> value="1">
                        </div>
                        <div class="input-wrap">
                                <input type="text" class="form-control body-condition" name="Fetals_Description" id="Fetals_Description" value="<cfif dolphine_sight.Fetals_Description neq "">  #dolphine_sight.Fetals_Description# </cfif>">
                        </div>
                        </div>
        
                    
                         <div class="form-group">
                            <label for="pwd">Dscore:</label>
                            <input type="text" class="form-control" id="update_dscore" readonly value="#dscore.DScore#">
                          </div>
                        
                        <div class="form-group">
                            <label for="pwd">FB_No:</label>
                            <input type="text" class="form-control" value="#dolphine_sight.FB_No#" id="add_FB_No" readonly>
                          </div>
                       
                       <div class="form-group">
                            <label for="pwd">Note:</label>
                            <textarea class="form-control" name="Note">#dolphine_sight.Note#</textarea>
                        </div>
                    
                    
                            
                         <!---<div class="form-group">--->
                            <!---<label for="pwd">Echelon:</label>--->
                            <!---<input type="text"   class="form-control" name="Echelon" maxlength="5" value="#dolphine_sight.Echelon#">--->
                          <!---</div>--->
        
                                <div class="form-group">
                                    <label for="email">Echelon:</label>
        
                                    <select class="form-control"  name="Echelon" >
                                        <option value="1">Yes</option>
                                        <option value="0">No</option>
                                    </select>
                                </div>
        
                        <!---<div class="form-group">
                            <label for="pwd">REMPI:</label>
                            <input type="text" class="form-control" value="#dolphine_sight.REMPI#" name="REMPI" maxlength="5">
                          </div>
                         
                           <div class="form-group">
                            <label for="pwd">Body Condition:</label>
                            <input type="text" class="form-control" value="#dolphine_sight.BodyCondition#" name="BodyCondition">
                          </div>--->
                          
                       <div class="form-group">
                            <label for="pwd">Best Image:</label>
                            <!---<img src="http://cloud.wildfins.org/BNIC(L) 2004 05 06.jpg" id="alt_img" alt="" width="50">--->
                            <!---<cfset namee = "#dolphine_sight.Dolphin_ID#(R) #DateFormat(DSCOREDATE,'yyyy mm dd')#.jpg">--->
                        <!---  "#Dolphin_ID#(R) #DateFormat(DSCOREDATE,'yyyy mm dd')#.jpg">--->
                        
                           <!--- <img src="#Application.CloudDirectory##dolphine_sight.Dolphin_ID#(R) #DateFormat(dscore_date,'yyyy mm dd')#.jpg" id="alt_img" alt="" width="50">
                            <img src="#Application.CloudDirectory#27(R) 1997 03 29.jpg" id="alt_img" alt="" >--->
        
                            <cfparam name="fin" default="0">
                            <cfset Fin_Left = '#Application.CloudRoot##dolphine_sight.Dolphin_ID#(L) #DateFormat(dscore_date,'yyyy mm dd')#.jpg'>
                            <cfset Fin_Right = '#Application.CloudRoot##dolphine_sight.Dolphin_ID#(R) #DateFormat(dscore_date,'yyyy mm dd')#.jpg'>
        
                            <cfif FileExists('#Application.CloudDirectory#(L) #DateFormat(dscore_date,'yyyy mm dd')#.jpg')>
                                <cfset  Fin = '#Fin_Left#'>
                                <cfset imageName = #dolphine_sight.Dolphin_ID#&"(L) "&#DateFormat(dscore_date,'yyyy mm dd')#&".jpg">
                                <cfset imageNameDate = #DateFormat(dscore_date,'yyyy mm dd')#>
        <!--- <cfbreak>--->
                                <cfelseif FileExists('#Application.CloudDirectory##dolphine_sight.Dolphin_ID#(R) #DateFormat(dscore_date,'yyyy mm dd')#.jpg')>
                                <cfset  Fin  = '#Fin_Right#'>
                                <cfset imageName = #dolphine_sight.Dolphin_ID#&"(R) "&#DateFormat(dscore_date,'yyyy mm dd')#&".jpg">
                                <cfset imageNameDate = #DateFormat(dscore_date,'yyyy mm dd')#>
                            <cfelse>
                                <cfset  Fin  = '#Application.CloudRoot#no-image.jpg'>
                                <cfset imageNameDate = #DateFormat(dscore_date,'yyyy mm dd')#>
                                <cfset imageName = "no-image">
                            </cfif>
                             <input type="hidden" name="imageName" value="#imageName#">
                             <input type="hidden" name="imageNameDate" value="#imageNameDate#">
                            <!---<cfoutput>#Fin_Left#</cfoutput>--->
                            <!---<br>--->
                            <!---<cfoutput>Fin_Right</cfoutput>--->
                            <!---<cfoutput>'#Application.CloudRoot##dolphine_sight.Dolphin_ID#(L) #DateFormat(dscore_date,'yyyy mm dd')#.jpg'</cfoutput>--->
                               
        
        <!---<cfbreak>--->
                      
                            <img src="#Fin#" id="alt_img" alt=""  width="70px">
                           
                            
                            
                          <!---<input type="text" class="form-control" value="#Fin#" name="BestImage">--->
                            
                        
                            
                            
                            <!---<img src="#Application.CloudRoot##dolphine_sight.Dolphin_ID#(R) #DateFormat(dscore_date,'yyyy mm dd')#.jpg" id="alt_img" alt=""  width="120px">
                            <img src="http://cloud.wildfins.org/BEAT(L) 2012 03 28.jpg" alt="" width="120" />
                            
                          <input type="text" class="form-control" value="#Application.CloudRoot##dolphine_sight.Dolphin_ID#(R) #DateFormat(dscore_date,'yyyy mm dd')#.jpg" name="BestImage">--->
        
                          </div>
                               
                            <div class="form-group">
                                <label for="image">Select Dolphin Photo</label>
                                <img src="" id="alt_img" alt="" width="50" >
                                <input class="input-5" name="BestImage" type="file"  class="file-loading">
                            </div>
                            <div class="form-group">
                                <label for="pwd">Best Shot </label>
                                <input type="text" class="form-control" id="BestShot" name="BestShot" value="<cfif dolphine_sight.BestShot neq ""> #dolphine_sight.BestShot#</cfif>">
                             </div>
                             
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="pwd">Entered By:</label>
                                </div>
                                <div class="input-wrap">
                                    <select class="form-control" id="entered_by" name="entered_by">
                                        <option value="">Select Entered By</option>
                                        <cfloop query="getuserlist"><option value="#user_id#" <cfif (dolphine_sight.entered_by NEQ '' and dolphine_sight.entered_by eq user_id) OR (dolphine_sight.entered_by eq '' and SESSION['UserDetails']['Id'] eq user_id)>selected</cfif>>#first_name# #last_name#</option></cfloop>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="pwd">Review:</label>
                                </div>
                                <div class="input-wrap">
                                    <select class="form-control" id="review" name="review">
                                        <option value="">Select Review</option>
                                        <option value="Review Complete" <cfif dolphine_sight.review eq 'Review Complete'>selected</cfif>>Review Complete</option>
                                        <option value="To be Reviewed"  <cfif dolphine_sight.review eq 'To be Reviewed'>selected</cfif>>To be Reviewed</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="pwd">Reviewed By:</label>
                                </div>
                                <div class="input-wrap">
                                    <select class="form-control" id="reviewed_by" name="reviewed_by">
                                        <option value="">Select Reviewed By</option>
                                        <cfloop query="getuserlist">
                                            <option value="#user_id#" <cfif dolphine_sight.reviewed_by neq '' and dolphine_sight.reviewed_by eq user_id>selected</cfif>>#first_name# #last_name#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                          
                          
                          <div class="message"></div>
                         
                          <div class="form-group">
                            <button type="button" class="btn btn-success update_dolphin" data_id="update_dolhpin_#i#">Update</button>
                          </div>
                         
                         </div>
                         
                                          <!--------- Right Side-------------->
                         <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                         <!---<div class="form-group">--->
                                <!---<div class="input-group">--->
                                <!---<div class="input-group-btn">--->
                                    <!---<button class="btn btn-inverse" type="button">Verified</button>--->
                                    <!---<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">--->
                                        <!---<span class="caret"></span>--->
                                    <!---</button>--->
                                    <!---<ul class="dropdown-menu">--->
                                        <!---<li><a val="P" class="get_val" id="update_varified#i#_1">P</a></li>--->
                                        <!---<li><a val="V" class="get_val" id="update_varified#i#_2">V</a></li>--->
                                        <!---</ul>--->
                                <!---</div>--->
                                <!---<input type="text" id="update_varified#i#" class="form-control" value="#dolphine_sight.Verified#" maxlength="7"  name="Verified">--->
                             <!---</div>--->
                            <!---</div>--->
                            
                          
                            <div class="form-group">
                                <div class="input-group">
                                <div class="input-group-btn">
                                    <button class="btn btn-inverse" type="button">PQ F:</button>
                                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a val="2" class="get_val sum_calculate_update" id="update_pqf#i#_1" index="#i#">2</a></li>
                                        <li><a val="4" class="get_val sum_calculate_update" id="update_pqf#i#_2" index="#i#">4</a></li>
                                        <li><a val="6" class="get_val sum_calculate_update" id="update_pqf#i#_3" index="#i#">6</a></li>
                                        </ul>
                                </div>
                                <input type="number" class="form-control sum_calculate_update"  index="#i#" id="update_pqf#i#" name="pq_focus" value="<cfif len(trim(dolphine_sight.pq_focus)) EQ 0>0<cfelse>#dolphine_sight.pq_focus#</cfif>">
                             </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="input-group">
                                <div class="input-group-btn">
                                    <button class="btn btn-inverse" type="button">PQ A:</button>
                                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                    <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a val="1" class="get_val sum_calculate_update" id="update_pqa#i#_1" index="#i#">1</a></li>
                                        <li><a val="2" class="get_val sum_calculate_update" id="update_pqa#i#_2" index="#i#">2</a></li>
                                        <li><a val="8" class="get_val sum_calculate_update" id="update_pqa#i#_3" index="#i#">8</a></li>
                                    </ul>
                                </div>
                                <input type="number" class="form-control sum_calculate_update"  index="#i#" name="pq_Angle" id="update_pqa#i#" value="<cfif len(trim(dolphine_sight.pq_Angle)) EQ 0>0<cfelse>#dolphine_sight.pq_Angle#</cfif>">
                             </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="input-group">
                                <div class="input-group-btn">
                                    <button class="btn btn-inverse" type="button">PQ C:</button>
                                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
        
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a val="1" class="get_val sum_calculate_update" id="update_pqc#i#_1" index="#i#">1</a></li>
                                        <li><a val="3" class="get_val sum_calculate_update" id="update_pqc#i#_2" index="#i#">3</a></li>
                                        </ul>
                                </div>
                                <input type="number" class="form-control sum_calculate_update"  index="#i#" name="pq_Contrast" id="update_pqc#i#" value="<cfif len(trim(dolphine_sight.pq_Contrast)) EQ 0>0<cfelse>#dolphine_sight.pq_Contrast#</cfif>">
                             </div>
                            </div>
                          
                            <div class="form-group">
                            <div class="input-group">
                            <div class="input-group-btn">
                                <button class="btn btn-inverse" type="button">Pq Pro:</button>
                                <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a val="1" class="get_val sum_calculate_update" id="update_pqpro#i#_1" index="#i#">1</a></li>
                                    <li><a val="5" class="get_val sum_calculate_update" id="update_pqpro#i#_2" index="#i#">5</a></li>
                                    </ul>
                            </div>
                            <input type="number" class="form-control sum_calculate_update"  index="#i#" name="pq_Proportion" id="update_pqpro#i#" value="<cfif len(trim(dolphine_sight.pq_Proportion)) EQ 0>0<cfelse>#dolphine_sight.pq_Proportion#</cfif>">
                         </div>
                        </div>
                    
                        <div class="form-group">
                            <div class="input-group">
                            <div class="input-group-btn">
                                <button class="btn btn-inverse" type="button">Pq Par:</button>
                                <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a val="1" class="get_val sum_calculate_update" id="update_pqpar#i#_1" index="#i#">1</a></li>
                                    <li><a val="8" class="get_val sum_calculate_update" id="update_pqpar#i#_1" index="#i#">8</a></li>
                                    </ul>
                            </div>
                            <input type="number" class="form-control sum_calculate_update"  index="#i#" name="pq_Partial" id="update_pqpar#i#" value="<cfif len(trim(dolphine_sight.pq_Partial)) EQ 0>0<cfelse>#dolphine_sight.pq_Partial#</cfif>">
                         </div>
                        </div>
                        
                        <div class="form-group">
                            <cfset pqsum_final = Val(dolphine_sight.pq_focus)+Val(dolphine_sight.pq_Angle)+Val(dolphine_sight.pq_Contrast)+Val(dolphine_sight.pq_Proportion)+Val(dolphine_sight.pq_Partial)>
                            <label for="pwd">Pq sum:</label>
                            <input type="number" class="form-control" id="update_pqsum_#i#" value="<!---<cfif len(trim(dolphine_sight.pqSum)) EQ 0>0<cfelse>#dolphine_sight.pqSum#</cfif>--->#pqsum_final#" name="pqSum"  readonly>
                          </div>
                          <cfif pqsum_final gt 0 and pqsum_final lte 5>
                            <cfset  Qscore = pqsum_final>
                          <cfelseif pqsum_final gte 6 and pqsum_final lte 9>
                            <cfset  Qscore = "Q-1">
                          <cfelseif pqsum_final gte 10 and pqsum_final lt 12>
                            <cfset  Qscore = "Q-2">
                          <cfelseif pqsum_final gte 12>
                             <cfset Qscore = "Q-3">
                          <cfelse>
                             <cfset Qscore = "">   
                          </cfif>   
               
                            <div class="form-group">
                                <label for="pwd">Qscore:</label>
                                <input type="text" class="form-control" name="Qscore" id="qscore_#i#" value="#Qscore#">
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <button class="btn btn-inverse" type="button">SDO1:</button>
                                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                        <cfset t=0>
                                        <cfloop query="TLU_SDO">
                                        <cfset t=t+1>
                                            <li><a val="#TLU_SDO.SDO_ID#" class="getvals_update" id="update_SDO1_#t#_#i#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a>	</li>
                                        </cfloop>
                                        </ul>
                                    </div>
                                    <input type="text" class="form-control" id="update_SDO1_val_#i#" value="<cfloop query="TLU_SDO">
                                    <cfif dolphine_sight.SDO1 eq TLU_SDO.SDO_ID>#TLU_SDO.SDO_ID# | #TLU_SDO.Name#</cfif></cfloop>" readonly>
                                    <input type="hidden" class="form-control" id="update_SDO1_id_#i#" name="SDO1" value="<cfif len(trim(dolphine_sight.SDO1)) EQ 0><cfoutput>0</cfoutput><cfelse><cfoutput>#dolphine_sight.SDO1#</cfoutput></cfif>" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <button class="btn btn-inverse" type="button">SDO2:</button>
                                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                        <cfset t=0>
                                        <cfloop query="TLU_SDO">
                                        <cfset t=t+1>
                                            <li><a val="#TLU_SDO.SDO_ID#" class="getvals_update" id="update_SDO2_#t#_#i#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a>	</li>
                                        </cfloop>
                                        </ul>
                                    </div>
                                    <input type="text" class="form-control" id="update_SDO2_val_#i#" value="<cfloop query="TLU_SDO">
                                    <cfif dolphine_sight.SDO2 eq TLU_SDO.SDO_ID>#TLU_SDO.SDO_ID# | #TLU_SDO.Name#</cfif></cfloop>" readonly>
                                    <input type="hidden" class="form-control" id="update_SDO2_id_#i#" name="SDO2" value="<cfif len(trim(dolphine_sight.SDO2)) EQ 0>0<cfelse>#dolphine_sight.SDO2#</cfif>" readonly>
                                </div>
                            </div>                    
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <button class="btn btn-inverse" type="button">SDO3:</button>
                                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                        <cfset t=0>
                                        <cfloop query="TLU_SDO">
                                        <cfset t=t+1>
                                            <li><a val="#TLU_SDO.SDO_ID#" class="getvals_update" id="update_SDO3_#t#_#i#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a>	</li>
                                        </cfloop>
                                        </ul>
                                    </div>
                                        
                                      
                                    <input type="text" class="form-control" id="update_SDO3_val_#i#" value="<cfloop query="TLU_SDO">
                                    <cfif dolphine_sight.SDO3 eq TLU_SDO.SDO_ID>#TLU_SDO.SDO_ID# | #TLU_SDO.Name#</cfif></cfloop>" readonly>
                                    <input type="hidden" class="form-control" id="update_SDO3_id_#i#" name="SDO3" value="<cfif len(trim(dolphine_sight.SDO3)) EQ 0>0<cfelse>#dolphine_sight.SDO3#</cfif>" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <button class="btn btn-inverse" type="button">SDO4:</button>
                                        <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                        <cfset t=0>
                                        <cfloop query="TLU_SDO">
                                        <cfset t=t+1>
                                            <li><a val="#TLU_SDO.SDO_ID#" class="getvals_update" id="update_SDO4_#t#_#i#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a>	</li>
                                        </cfloop>
                                        </ul>
                                    </div>
                                        
                                      
                                    <input type="text" class="form-control" id="update_SDO4_val_#i#" value="<cfloop query="TLU_SDO">
                                    <cfif dolphine_sight.SDO4 eq TLU_SDO.SDO_ID>#TLU_SDO.SDO_ID# | #TLU_SDO.Name#</cfif></cfloop>" readonly>
                                    <input type="hidden" class="form-control" id="update_SDO4_id_#i#" name="SDO4" value="<cfif len(trim(dolphine_sight.SDO4)) EQ 0>0<cfelse>#dolphine_sight.SDO4#</cfif>" readonly>
                                </div>
                            </div>     
        
                           
                          
                        <!---<div class="form-group">
                            <label for="pwd">PQP:</label>
                            <input type="checkbox" class="checkbox-inline" name="PQP" <cfif dolphine_sight.PQP eq 1>checked</cfif>  value="1">
                          </div>--->
                          
                         <!---<div class="form-group">
                            <label for="pwd">SDR:</label>
                            <input type="checkbox" class="checkbox-inline" name="SDR" <cfif dolphine_sight.SDR eq 1>checked</cfif>  value="1"> 
                          </div>
                        
                        
                        <div class="form-group">
                            <label for="pwd">Fetals:</label>
                            <input type="checkbox" class="checkbox-inline" name="Fetals" <cfif dolphine_sight.Fetals eq 1>checked</cfif>  value="1">
                          </div>
                        
                        <div class="form-group">
                            <label for="pwd">BC:</label>
                            <input type="checkbox" class="checkbox-inline" name="BC" <cfif dolphine_sight.BC eq 1>checked</cfif>  value="1">
                          </div>
                        
                        <div class="form-group">
                            <label for="pwd">Xeno:</label>
                            <input type="checkbox" name="Xeno" <cfif dolphine_sight.Xeno eq 1>checked</cfif>  value="1">
                          </div>
                        
                        <div class="form-group">
                            <label for="pwd">RDS:</label>
                            <input type="checkbox" class="checkbox-inline" name="RDS" <cfif dolphine_sight.RDS eq 1>checked</cfif>  value="1">
                          </div>
                          
                         <div class="form-group">
                            <label for="pwd">REM:</label>
                            <input type="checkbox" class="checkbox-inline" name="REM" <cfif dolphine_sight.REM eq 1>checked</cfif>  value="1">
                         </div>
                         
                          <div class="form-group">
                            <label for="pwd">Fresh wound:</label>
                            <input type="checkbox" class="checkbox-inline" <cfif dolphine_sight.Freshwound eq 1>checked</cfif> name="Freshwound"  value="1">
                          </div>
                         
                         
                         <div class="form-group">
                            <label for="pwd">Tiger:</label>
                            <input type="checkbox" class="checkbox-inline" name="Tiger" <cfif dolphine_sight.Tiger eq 1>checked</cfif>  value="1">
                          </div>--->
                         
                         
                           <!-----Start Body Condition ------>
                         
                         
                          <div class="form-group">
                          <h3>Heath and Fitness
                          </h3>
                          
        
                            <!---<div class="input-wrap">--->
                                <!---<input type="text" class="form-control body-condition" name="SDR_Description" id="SDR_Description" value="<cfif dolphine_sight.SDR_Description neq "">  #dolphine_sight.SDR_Description# </cfif>">--->
                            <!---</div>--->
                          </div>
                          
        
                          
                           <!---<div class="form-group">--->
                            <!---<div class="label-wrap">--->
                                <!---<label for="pwd">BC:</label>--->
                                <!---<input type="checkbox" class="checkbox-inline" name="BC"  <cfif dolphine_sight.BC eq 1>checked</cfif> value="1">--->
                            <!---</div>--->
                            <!---<div class="select-wrap">--->
                                <!---<select  class="form-control bc-rate"   name="BC_rate" >--->
                                    <!---<option value="<cfif  dolphine_sight.BC_rate neq ""> #dolphine_sight.BC_rate# </cfif>">--->
                                    <!---<cfif  dolphine_sight.BC_rate neq ""> #dolphine_sight.BC_rate# <cfelse>BC Rate</cfif></option>--->
                                    <!---<option value="1">1</option>--->
                                    <!---<option value="2">2</option>--->
                                     <!---<option value="3">3</option>--->
                                      <!---<option value="4">4</option>--->
                                       <!---<option value="5">5</option>--->
                                <!---</select>--->
                            <!---</div>--->
                            <!---<div class="input-wrap after-select-input">--->
                                <!---<!---<input type="text" class="form-control" style="width:10%;" name="BC_rate" id="BC_rate" value="">--->--->
                                <!---<input type="text" class="form-control body-condition" name="BC_Description" id="BC_Description" value="<cfif dolphine_sight.BC_Description neq "">  #dolphine_sight.BC_Description# </cfif>">--->
                             <!---</div>--->
                         <!---</div>--->
        
        
        
                        <div class="form-group">
                            <div class="label-wrap inline-box">
                                <label for="pwd">Xeno:</label>
                                <div class="form-inline">
                                    <p>yes</p>
                                    <input type="radio" name="Xeno" value="1">
                                </div>
                                <div class="form-inline">
                                    <p>No</p>
                                    <input type="radio" name="Xeno" value="0">
                                </div>
                            </div>
        <!---<div class="input-wrap">--->
        <!---<input type="text" class="form-control body-condition"  name="Xeno_Description" id="Xeno_Description" value="">--->
        <!---</div>--->
                        </div>
        
                        <div class="form-group">
                            <div class="label-wrap inline-box">
                                <label for="pwd">RDS:</label>
                                <div class="form-inline">
                                    <p>Yes</p>
                                    <input type="radio" class="checkbox-inline" name="RDS" value="1">
                                </div>
                                <div class="form-inline">
                                    <p>No</p>
                                    <input type="radio" class="checkbox-inline" name="RDS" value="0">
                                </div>
                            </div>
        <!---<div class="input-wrap">--->
        <!---<input type="text" class="form-control body-condition"  name="RDS_Description" id="RDS_Description" value="">--->
        <!---</div>--->
                        </div>
        
                        <div class="form-group">
                            <div class="label-wrap inline-box">
                                <label for="pwd">REM:</label>
                                <div class="form-inline">
                                    <p>Yes</p>
                                    <input type="radio" class="checkbox-inline" name="REM"  value="1">
                                </div>
                                <div class="form-inline">
                                    <p>No</p>
                                    <input type="radio" class="checkbox-inline" name="REM"  value="0">
                                </div>
                            </div>
        <!---<div class="input-wrap">--->
        <!---<input type="text" class="form-control body-condition" name="REM_Description" id="REM_Description" value="">--->
        <!---</div>--->
                        </div>
        
                        <div class="form-group">
                            <div class="label-wrap inline-box">
                                <label for="pwd">Fresh wound:</label>
                                <div class="form-inline">
                                    <p>Yes</p>
                                    <input type="radio" class="checkbox-inline" name="Freshwound"  value="1">
                                </div>
                                <div class="form-inline">
                                    <p>No</p>
                                    <input type="radio" class="checkbox-inline" name="Freshwound"  value="0">
                                </div>
                            </div>
        <!---<div class="input-wrap">--->
        <!---<input type="text" class="form-control body-condition" name="Freshwound_Description" id="Freshwound_Description" value="">--->
        <!---</div>--->
                        </div>
        
        <!---<div class="form-group">--->
        <!---<label for="pwd">W/mom:</label>--->
        <!---<input type="checkbox" class="checkbox-inline" name="wMom"  value="1">--->
        <!---</div>--->
        
        
                            <!---<div class="form-group">
                                <div class="label-wrap">
                                    <label for="pwd">Tiger:</label>
                                    <input type="checkbox" class="checkbox-inline" name="Tiger" value="1">
                                </div>
                                <div class="input-wrap">
                                    <input type="text" class="form-control body-condition" name="Tiger_Description" id="Tiger_Description" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="pwd">Shark:</label>
                                    <input type="checkbox" class="checkbox-inline" name="Shark" value="1">
                                </div>
                                <div class="input-wrap">
                                    <input type="text" class="form-control body-condition" name="shark_Description" id="shark_Description" value="">
                                </div>
                            </div>--->
                            
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="Dolphin_Sighting_Date">Date of sighting:</label>
                                </div>
                                <div class="input-wrap">    
                                    <input type="text" class="form-control datetimepicker" value="#DateTimeFormat(dolphine_sight.Dolphin_Sighting_Date, 'YYYY-MM-DD')#" name="Dolphin_Sighting_Date" placeholder="YYYY-MM-DD" required >
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="body_condition">Body Condition:</label>
                                </div>
                                <div class="input-wrap">
                                    <select class="form-control" id="BodyCondition" name="BodyCondition">
                                        <option value="">Select Body Condition</option>
                                        <option value="Shark Bite" <cfif dolphine_sight.BodyCondition eq 'Shark Bite'>selected</cfif>>Shark Bite</option>
                                        <option value="Tiger Stripes" <cfif dolphine_sight.BodyCondition eq 'Tiger Stripes'>selected</cfif>>Tiger Stripes</option>
                                        <option value="Pox" <cfif dolphine_sight.BodyCondition eq 'Pox'>selected</cfif>>Pox</option>
                                        <option value="Boat Hit" <cfif dolphine_sight.BodyCondition eq 'Boat Hit'>selected</cfif>>Boat Hit</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="Region">Region:</label>
                                </div>
                                <div class="input-wrap">
                                    <select class="form-control" id="Region" name="Region">
                                        <option value="">Select Region</option>
                                        <cfloop from="1" to="8" index="j">
                                            <option value="#j#" <cfif dolphine_sight.Region eq j>selected</cfif>>#j#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="Side">Side:</label>
                                </div>
                                <div class="input-wrap">
                                    <select class="form-control" id="Side" name="Side">
                                        <option value="">Select Side L/R</option>
                                        <option value="L" <cfif dolphine_sight.Side_L_R eq 'L'>selected</cfif>>L</option>
                                        <option value="R" <cfif dolphine_sight.Side_L_R eq 'R'>selected</cfif>>R</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="Status">Status:</label>
                                </div>
                                <div class="input-wrap">
                                    <select class="form-control" id="Status" name="Status">
                                        <option value="">Select Status</option>
                                        <option value="1-Fresh"   <cfif dolphine_sight.Status eq '1-Fresh'>selected</cfif>>1-Fresh</option>
                                        <option value="2-Healing" <cfif dolphine_sight.Status eq '2-Healing'>selected</cfif>>2-Healing</option>
                                        <option value="3-Healed"  <cfif dolphine_sight.Status eq '3-Healed'>selected</cfif>>3-Healed</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label-wrap">
                                    <label for="pwd">Area:</label>
                                </div>
                                <div class="input-wrap">
                                    <select class="form-control" id="Area" name="Area">
                                        <option value="">Select Area</option>
                                        <option value="A" <cfif dolphine_sight.Area eq 'A'>selected</cfif>>A</option>
                                        <option value="B" <cfif dolphine_sight.Area eq 'B'>selected</cfif>>B</option>
                                        <option value="C" <cfif dolphine_sight.Area eq 'C'>selected</cfif>>C</option>
                                        <option value="D" <cfif dolphine_sight.Area eq 'D'>selected</cfif>>D</option>
                                        <option value="E" <cfif dolphine_sight.Area eq 'E'>selected</cfif>>E</option>
                                        <option value="F" <cfif dolphine_sight.Area eq 'F'>selected</cfif>>F</option>
                                        <option value="G" <cfif dolphine_sight.Area eq 'G'>selected</cfif>>G</option>
                                        <option value="H" <cfif dolphine_sight.Area eq 'H'>selected</cfif>>H</option>
                                        <option value="I" <cfif dolphine_sight.Area eq 'I'>selected</cfif>>I</option>
                                        <option value="J" <cfif dolphine_sight.Area eq 'J'>selected</cfif>>J</option>
                                    </select>
                                </div>
                            </div> 
                            <cfif FileExists('#Application.CloudDirectory##dolphine_sight.SightingImage#')>
                                <cfset  SightingImageName = '#dolphine_sight.SightingImage#'>
                            <cfelse>
                                <cfset  SightingImageName  = 'no-image.jpg'>
                            </cfif>
                            <input type="hidden" name="hdnImageName" value="#SightingImageName#">
                            <div class="form-group">
                                <label for="pwd">Photo:</label>
                                <img src="#Application.CloudRoot##SightingImageName#" id="alt_img" alt=""  width="70px">  
                            </div>  
                            <div class="form-group">
                            	<a href="javascript:void(0);" class="btn btn-success" id="btn_dolphin_history" style="float:right;margin-top: 23px;">History</a>
                                <label for="image">Choose Photo</label>
                                <img src="" id="alt_img" alt="" width="50" >
                                <input class="input-5" name="SightingImage" type="file" class="file-loading">
                            </div>
                         <!-----End Body Condition ------>
                         </div>
                         
                          <div class="col-md-12">
                          
                          <input type="hidden" class="form-control" name="Sighting_ID" value="#qGetSightings.id#">
                          
                          </div>
                    </form>
        
                    </div>
                </div>
            </div>
		</cfloop>
                
		</div> <!--- end data div ----->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div id="dolphin_history" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close closeHistoryModal">&times;</button>
        <h4 class="modal-title">History Table</h4>
      </div>
	  <div class="modal-body" style="overflow:hidden">
		  <cfif dolphine_sight.recordcount gt 0>
                <!---History Table--->
                <div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff">
                    <div class="col-md-2">Date</div>
                    <div class="col-md-2">Body Condition</div>
                    <div class="col-md-1">Region</div>
                    <div class="col-md-1">Side L/R</div>
                    <div class="col-md-2">Status</div>
                    <div class="col-md-2">Area</div>
                    <div class="col-md-2">Photo</div>
                </div>
                <cfset i=0>
                <div class="history_section">
                    <cfloop query="dolphine_sight" group="Code">
                        <cfset i=i+1>
                        <cfif FileExists('#Application.CloudDirectory##dolphine_sight.SightingImage#')>
                            <cfset  SightingImageName = '#dolphine_sight.SightingImage#'>
                        <cfelse>
                            <cfset  SightingImageName  = 'no-image.jpg'>
                        </cfif>
                        <div class="row" id="sightingHistory_#i#">
                            <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;">
                                <div class="col-md-2">#DateFormat(dolphine_sight.Dolphin_Sighting_Date, 'YYYY-MM-DD')#</div>
                                <div class="col-md-2">#dolphine_sight.BodyCondition#</div>
                                <div class="col-md-1">#dolphine_sight.Region#</div> 
                                <div class="col-md-1">#dolphine_sight.Side_L_R#</div> 
                                <div class="col-md-2">#dolphine_sight.Status#</div> 
                                <div class="col-md-2">#dolphine_sight.Area#</div> 
                                <div class="col-md-2"><img src="#Application.CloudRoot##SightingImageName#" id="alt_img" alt=""  width="70px"></div> 
                            </div>
                        </div>
                    </cfloop>
                </div>
                <!---History Table--->
            </cfif>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default closeHistoryModal">Close</button>
      </div>
    </div>
  </div>
</div>
</cfif>
</cfoutput>
