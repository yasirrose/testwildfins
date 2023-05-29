<cfoutput>
   <cfif isdefined('form.PROJECT_ID') and form.project_id gt 0 and form.sight_id GT 0>
      <!-------------  Dolphine ---------------------------------->
      <cfparam name="form.PROJECT_ID" default="0">

      <cfquery name="cetaceans" datasource="#Application.dsn#">
         select ID,Code,Name from Cetaceans order by Code ASC
      </cfquery>

      <cfset sight_id = #form.sight_id#>
      
       <cfquery name="getSightingById" datasource="#Application.dsn#">
         SELECT FE_Species, SightingNumber FROM Survey_Sightings WHERE ID = #sight_id#
      </cfquery>
      
      <cfquery name="cetaceans_sight" datasource="#Application.dsn#">
         SELECT  Cetacean_Sightings.*,Cetacean_Sightings.ID,Cetaceans.*,TLU_CetaceanSpecies.CetaceanSpeciesName FROM Cetacean_Sightings left JOIN Cetaceans on Cetacean_Sightings.Cetaceans_ID=Cetaceans.ID  
         left join TLU_CetaceanSpecies on TLU_CetaceanSpecies.ID=Cetaceans.CetaceanSpecies  WHERE Cetacean_Sightings.Sighting_ID = #sight_id#  order by Cetacean_Sightings.Sighting_ID;
      </cfquery>

      <cfquery name="getConditionLesions" datasource="#Application.dsn#">
         SELECT * FROM Condition_Lesions where Sighting_ID = #sight_id#
      </cfquery>
      
      <cfquery name="singleSightingCetaceans" datasource="#Application.dsn#">
         SELECT Cetacean_Sightings.*,Cetaceans.* FROM Cetacean_Sightings INNER JOIN Cetaceans on Cetacean_Sightings.Cetaceans_ID=Cetaceans.ID  WHERE Cetacean_Sightings.Sighting_ID = #sight_id# order by Cetacean_Sightings.Sighting_ID;
      </cfquery>

      <cfset getuserlist=Application.Accounts.getuserlist()>
      <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>
      <!---  Head Condition   --->
      <cfset getHeadNuchalCrest = Application.ConditionLesions.getHeadNuchalCrest()>
      <cfset getHeadLateralCervicalReg = Application.ConditionLesions.getHeadLateralCervicalReg()>
      <cfset getHeadFacialBones = Application.ConditionLesions.getHeadFacialBones()>
      <cfset getHeadEarOS = Application.ConditionLesions.getHeadEarOS()>
      <cfset getHeadChinSkinFolds = Application.ConditionLesions.getHeadChinSkinFolds()>
       <!---  Body Condition   --->
      <cfset getBodyEpaxialMuscle = Application.ConditionLesions.getBodyEpaxialMuscle()>
      <cfset getBodyDorsalRidgeScapula = Application.ConditionLesions.getBodyDorsalRidgeScapula()>
      <cfset getBodyRibs = Application.ConditionLesions.getBodyRibs()>
       <!---  Tail Condition   --->
      <cfset getTailTransversePro = Application.ConditionLesions.getTailTransversePro()>


      
      
      
      <!---  Static data   --->
      <cfset getRegions = Application.ConditionLesions.getRegions()>
      <cfset bodyConditions = ['Emaciated','Underweight/Thin','Ideal','Overweight','Obese','CBD']>
      <cfset sides = ['L','R','L/R']>

      <div id="cetacean" class="modal fade" role="dialog">
         <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close cetacean_modal_close" id="cetacean_modal_close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Cetacean</h4>
               </div>

               <style>
                  .tddate{
                     width: 20% !important;
                  }
                  .sno{
                     width: 23% !important;
                  }
                  .ltype{
                     width: 21% !important;
                  }
                  .lside{
                     width: 14% !important;
                  }
                  .lstatus{
                     width: 14% !important;
                  }
                  .label-checkbox{
                  display: inline-block;
                  width: 49.5%;
                  margin-top: 5%;
                  }
                  .label-checkbox label {
                  margin-right: 35%;
                  }
                  .cetaceansSighting_from {
                     padding: 0px !important;
                  }
                  .breakdown-image{
                     width: 100%;
                  }
                  .cetacean-name{
                     text-align: center;
                     font-weight: bold;
                     font-style: italic;
                  }
                  .is-lesion-form {
                     display: none;
                  }
                  .form-separater{
                     border: 1px solid ##17B6A4;
                     padding: 10px;
                     margin-bottom: 10px;
                  }
                  ##preview{
                  position:fixed;
                  border:1px solid ##ccc;
                  background:##333;
                  padding:5px;
                  display:none;
                  color: ##fff;
                  top:10%;
                  z-index:999;
                  }
                  ul.cetacean_images {
                  display: inline-block;
                  width: 100%;
                  margin: 0 auto;
                  padding: 20px 15px;
                  margin-top: 15px;
                  text-align:center;
                  }
                  .cetacean_images li {
                  position: relative;
                  width: 48%;
                  margin-bottom: 20px;
                  margin-left: 0.5%;
                  list-style: none;
                  float: none;
                  display: inline-block;
                  margin-right: 0.8%;
                  border: 1px solid ##ddd;
                  text-align: center;
                  padding: 5px 5px;
                  border-radius: 4px;
                  background-color: ##fafafa;
                  box-shadow: 0 0 6px 0 ##eee;
                  }
                  .cetacean_images li:nth-child(4n+4) {
                  margin-right: 0px;
                  }
                  .cetacean_images img {
                  width: 100%;
                  border:none;
                  }
                  span.removeCetacean {
                  position: absolute;
                  right: -7px;
                  top: -10px;
                  background: red;
                  font-size: 20px;
                  line-height: normal;
                  width: 20px;
                  height: 20px;
                  text-align: center;
                  border-radius: 50%;
                  line-height: 15px;
                  color: ##fff;
                  font-weight: normal;
                  border: 1px solid red;
                  cursor: pointer;
                  }
                  .dataTables_scroll .lison-history-responsive {
                     overflow: hidden;
                     overflow-x: auto;
                  }
                  .dataTables_scroll .lison-history-responsive .lesion-history-table {
                     width: 600px;
                  }
                  div##updtaedata.updtaedata-select{
                     margin-bottom: 10px;
                     margin-top: 10px;
                  }
                  div##updtaedata.updtaedata-select select##sel {
                     width: 15%;
                  }
                  div##updtaedata.updtaedata-select select##unqueLesions {
                     margin-right: 10px;
                     width: 83%;
                  }
                  div##updtaedata.updtaedata-select select{
                     height: 34px;
                     padding: 6px 12px;
                     font-size: 14px;
                     border-radius: 4px;
                     border: 2px solid ##bec3c6;
                     background: ##ebeced;
                     color: ##000;
                     font-weight: 500;
                  }
                  .comdition-lesions .condition-details .row,
                  .comdition-lesions .condition-details .panel-heading{
                        margin: 0;
                        display: flex;
                        width: 100%;
                  }
                  .comdition-lesions {
                        overflow-x: auto;
                  }
                  .comdition-lesions .condition-details{
                        width: 850px;
                  }
                  .comdition-lesions .condition-details .col-md-1, .comdition-lesions .condition-details .col-md-2 {
                        padding: 0 5px;
                        /* font-size: 11px; */
                        /* word-break: break-all;
                        overflow: hidden; */
                        text-overflow: ellipsis;
                        display: -webkit-box;
                        /* -webkit-line-clamp: 2; */
                        -webkit-box-orient: vertical;
                  }

                  .updatedata-sec {
                     display: flex;
                     width: 100%;
                     overflow-x: auto;
                  }

                  .updatedata-sec select {
                     width: auto !important;
                     margin: 10px 5px;
                  }
                  /* .comdition-lesions .condition-details .col-md-1 {
                        width: 10%;
                  }
                  .comdition-lesions .condition-details .row .col-md-1:first-child {
                        width: 5%;
                  }
                  .comdition-lesions .condition-details .col-md-2 {
                        width: 7%;
                  } */
                  @media (max-width: 1659px){
                     div##updtaedata.updtaedata-select select##unqueLesions {
                        width: 80%;
                     }
                     div##updtaedata.updtaedata-select select##sel {
                        width: 17%;
                     }
                  }
                  @media (max-width: 1399px){
                     div##updtaedata.updtaedata-select select##unqueLesions {
                        width: 75%;
                     }
                     div##updtaedata.updtaedata-select select##sel {
                        width: 22%;
                     }
                  }
                  @media (max-width: 1199px){
                     div##updtaedata.updtaedata-select select##unqueLesions {
                        width: 70%;
                     }
                     div##updtaedata.updtaedata-select select##sel {
                        width: 26%;
                     }
                  }
                  @media (max-width: 991px){
                        .comdition-lesions .condition-details .col-md-2 {
                              width: 16%;
                        }
                        .comdition-lesions .condition-details .col-md-1 {
                              width: 8%;
                        }
                        .comdition-lesions .condition-details .col-md-3 {
                              width: 25%;
                        }
                  }
                  @media (max-width: 599px){
                     div##updtaedata.updtaedata-select select##unqueLesions {
                        margin-right: 0;
                        width: 100%;
                        margin-bottom: 10px;
                     }
                     div##updtaedata.updtaedata-select select##sel {
                        width: 100%;
                     }
                  }
               </style>

               <div class="modal-body cetaceansSighting_from" style="overflow:hidden">
                  <div class="col-md-12 add_new">
                     <h2 id="Cetacean_Sighting_Form_Text">Cetacean Sighting Form</h2>
                     <div class="panel-body ">
                        <form role="form" id="add_cetaceansSighting_from" enctype="multipart/form-data">
                        <input type="hidden" name="SightingNumber" id="SightingNumber" value="#getSightingById.SightingNumber#">
                         <input type="hidden" name="Sighting_ID" id="getsight_ID" value="#sight_id#">
                         <input type="hidden" name="update_cs_Id" id="update_cs_Id" value="0">      
                          <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                           <div class="form-group">
                              <div class="label-checkbox">
                                 <label for="SDR">Same Day Resight:</label>
                                 <input type="checkbox" class="checkbox-inline" name="SDR" id="SDR">
                              </div>
                              <div class="label-checkbox">
                                 <label for="bestSighting">Best Sighting:</label>
                                 <input type="checkbox" class="checkbox-inline" id="bestSighting" name="bestSighting">
                              </div>
                           </div>
                           <div class="form-group selectwidth">
                              <label for="Cetacean_code">Cetacean Name/Code:</label>
                              <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0>
                              <cfif cetaceans.recordCount neq "0">
                                 <button type="button" class="btn btn-success" id="replace-btn" onclick="replaceAnimal()" style="display:none; float:right; margin-bottom:5px;">Replace</button>
                              </cfif>
                              </cfif>
                              <select class="form-control multiple-select2 on_update_disabled" id="Cetacean_code" name="Cetacean_code">
                                 <option value="">Select  Code</option>
                                 <cfloop query="cetaceans">
                                    <option value="#cetaceans.ID#"> #cetaceans.Name# | #cetaceans.Code# </option>
                                 </cfloop>
                              </select>
                           </div>
                           
                            <input type="hidden" name="set_cetacean_code" id="set_cetacean_code" value="0">     

                           <div class="form-group">
                              <label for="add_dscore">Species:</label>
                                 <input type="text" class="form-control" name="species" id="add_species" readonly>
                           </div>

                           <input type="hidden" name="dolphnname" id="dolphnname">
                           <div class="form-group">
                              <label for="Sex">Sex:</label>
                              <input type="text" class="form-control" name="Sex" id="add_sex" readonly >
                           </div>
                           <div class="form-group">
                              <div class="label-wrap">
                                 <label for="pwd">Fetals:</label>
                                 <input type="checkbox" class="checkbox-inline" id="Fetals" name="Fetals">
                              </div>
                              <div class="label-wrap">
                                 <label for="calf">Calf:</label>
                                 <input type="checkbox" class="checkbox-inline" id="Calf" name="Calf">
                              </div>
                              <div class="label-wrap">
                                 <label for="yoy">Yoy:</label>
                                 <input type="checkbox" class="checkbox-inline" id="Yoy" name="Yoy">
                              </div>
                           </div>
                           <div class="form-group">
                              <label for="add_dscore">Dscore:</label>
                              <input type="text" class="form-control" id="add_dscore" name="DScore" readonly>
                              <input type="hidden" id="dscore_date" name="dscoredate">
                           </div>
                           <div class="form-group">
                              <label for="FB_Number">FB Number:</label>
                              <input type="text" class="form-control" id="FB_Number" readonly>
                           </div>
                           <div class="form-group">
                              <label for="email">With mom:</label>
                              <select class="form-control" name="wMomDropDown" id="wMomDropDown">
                                 <option value="0"></option>
                                 <option value="1">Yes</option>
                                 <option value="2">No</option>
                                 <option value="3">Partial</option>
                              </select>
                           </div>
                           <div class="form-group">
                              <label for="Note">Note:</label>
                              <textarea class="form-control" name="Note" id="Note"></textarea>
                           </div>

                           <div class="form-group">
                            <!---  Append images here  --->
                            <ul id="alt_images" class="cetacean_images" style="display:none;"> </ul>

                            <div class="cs_img_message"></div>
                              <label class="control-label">Select Cetacean Photo(Primary Image)</label>
                              <input class="input-5" name="BestImage" id="BestImage" type="file" class="file-loading">
                              <input id="primaryOldImage" name="primaryOldImage" type="hidden" value=""> <br>


                              <label class="control-label">Select Cetacean Photo(Secondary Image)</label>
                              <input class="input-5" name="SecondaryImage" id="SecondaryImage" type="file" class="file-loading">
                              <input id="SecondaryOldImage" name="SecondaryOldImage" type="hidden" value="">
                           </div>
               
                           <div class="form-group">
                              <div class="label-wrap">
                                 <label for="BestShot">Best Shot:</label>
                              </div>
                              <div class="input-wrap">    
                                 <input type="text" class="form-control" id="BestShot" name="BestShot">
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="label-wrap">
                                 <label for="pwd">Entered By:</label>
                              </div>
                              <div class="input-wrap">
                                 <select class="form-control" id="EnteredBy" name="EnteredBy">
                                    <option value="0">Select Entered By</option>
                                    <cfloop query="getuserlist">
                                       <cfif status eq "Enable">
                                          <option value="#user_id#" <cfif SESSION['UserDetails']['Id'] eq user_id>selected</cfif>>#first_name# #last_name#</option>
                                       </cfif>
                                    </cfloop>
                                 </select>
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="label-wrap">
                                 <label for="pwd">Initial Review:</label>
                              </div>
                              <div class="input-wrap">
                                 <select class="form-control" id="PhotoAnalysisInitial" name="PhotoAnalysisInitial">
                                    <option value="0">Select Analyst</option>
                                    <cfloop query="getuserlist">
                                       <cfif status eq "Enable">
                                       <option value="#user_id#">#first_name# #last_name#</option>
                                       </cfif>
                                    </cfloop>
                                 </select>
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="label-wrap">
                                 <label for="pwd">Final Review:</label>
                              </div>
                              <div class="input-wrap">
                                 <select class="form-control" id="PhotoAnalysisFinal" name="PhotoAnalysisFinal">
                                    <option value="0">Select Analyst</option>
                                    <cfloop query="getuserlist">
                                       <cfif status eq "Enable">
                                       <option value="#user_id#">#first_name# #last_name#</option>
                                       </cfif>
                                    </cfloop>
                                 </select>
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="message"></div>
                              <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0 >
                                    <button type="submit" class="btn btn-success" id="update_cetaceansSighting_btn" style="display:none">Update Cetacean Sighting</button>
                              </cfif>      
                              <cfif permissions eq "full_access" or findNoCase("Add Entry Data S-S-C", permissions) neq 0>
                                    <button type="submit" class="btn btn-success" id="add_cetaceansSighting_btn">Submit</button>
                              </cfif>      
                              <button type="reset" class="btn btn-default reset" id="reset_button">Reset</button>
                           </div>
                        </div>
                        <!--------- Right Side-------------->
                        <div class="col-md-6" style="border: solid 0.5px ##EEEEEE; padding-top: 20px">
                           <div class="form-group">
                              <div class="input-group">
                                 <div class="input-group-btn">
                                    <button class="btn btn-inverse" type="button" tabindex="-1">PQ F:</button>
                                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false" tabindex="-1">
                                    <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                       <li><a val="2" class="get_val sum_calculate" id="add_pqf_1">2</a></li>
                                       <li><a val="4" class="get_val sum_calculate" id="add_pqf_2">4</a></li>
                                       <li><a val="9" class="get_val sum_calculate" id="add_pqf_3">9</a></li>
                                    </ul>
                                 </div>
                                 <input type="text" class="form-control sum_calculate" min="0" id="add_pqf" name="pq_focus" value="0">
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="input-group">
                                 <div class="input-group-btn">
                                    <button class="btn btn-inverse" type="button" tabindex="-1">PQ A:</button>
                                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false" tabindex="-1">
                                    <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                       <li><a val="1" class="get_val sum_calculate" id="add_pqa_1">1</a></li>
                                       <li><a val="2" class="get_val sum_calculate" id="add_pqa_2">2</a></li>
                                       <li><a val="8" class="get_val sum_calculate" id="add_pqa_3">8</a></li>
                                    </ul>
                                 </div>
                                 <input type="text" class="form-control sum_calculate" min="0" name="pq_Angle" id="add_pqa" value="0">
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="input-group">
                                 <div class="input-group-btn">
                                    <button class="btn btn-inverse" type="button" tabindex="-1">PQ C:</button>
                                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false" tabindex="-1">
                                    <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                       <li><a val="1" class="get_val sum_calculate" id="add_pqc_1">1</a></li>
                                       <li><a val="3" class="get_val sum_calculate" id="add_pqc_2">3</a></li>
                                    </ul>
                                 </div>
                                 <input type="text" class="form-control sum_calculate" name="pq_Contrast" min="0" id="add_pqc" value="0">
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="input-group">
                                 <div class="input-group-btn">
                                    <button class="btn btn-inverse" type="button" tabindex="-1">Pq Pro:</button>
                                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false" tabindex="-1">
                                    <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                       <li><a val="1" class="get_val sum_calculate" id="add_pqpro_1">1</a></li>
                                       <li><a val="5" class="get_val sum_calculate" id="add_pqpro_2">5</a></li>
                                    </ul>
                                 </div>
                                 <input type="text" class="form-control sum_calculate" name="pq_Proportion" min="0" id="add_pqpro" value="0">
                              </div>
                           </div>
                           <div class="form-group">
                              <div class="input-group">
                                 <div class="input-group-btn">
                                    <button class="btn btn-inverse" type="button" tabindex="-1">Pq Par:</button>
                                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false" tabindex="-1">
                                    <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                       <li><a val="1" class="get_val sum_calculate" id="add_pqpar_1">1</a></li>
                                       <li><a val="8" class="get_val sum_calculate" id="add_pqpar_1">8</a></li>
                                    </ul>
                                 </div>
                                 <input type="text" class="form-control sum_calculate" name="pq_Partial" min="0" id="add_pqpar" value="0">
                              </div>
                           </div>
                           <div class="form-group">
                              <label for="pwd">Pq sum:</label>
                              <input type="text" class="form-control" id="add_pqsum" value="0" name="pqSum"  readonly>
                           </div>
                           <div class="form-group">
                              <label for="pwd">Qscore:</label>
                              <input type="text" class="form-control" name="Qscore" id="add_qscoresum">
                           </div>
                        </form>
                        <div id="condition_lesions_form_1">
                        </div>
                        <div id="condition_lesions_form">
                        <hr>
                        <div class="form-group">
                           <h3>Body Condition and Lesions</h3>
                        </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="body_condition">Body Condition:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="BodyCondition" name="BodyCondition">
                                 <option value="">Select Body Condition</option>
                                 <cfloop from="1" to="#ArrayLen(bodyConditions)#" index="j">
                                    <option value="#j#">#j&' - '&bodyConditions[j]#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                        <!---   New section under body condition  10-16-2020     --->
                        <label><strong>Head:</strong></label>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="Head_NuchalCrest">Nuchal Crest:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Head_NuchalCrest" name="Head_NuchalCrest">
                                 <option value="0">Select Nuchal Crest</option>
                                 <cfloop query="getHeadNuchalCrest">
                                    <option value="#getHeadNuchalCrest.ID#">#getHeadNuchalCrest.HNC_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                           <div class="form-group">
                           <div class="label-wrap">
                              <label for="Head_LateralCervicalReg">Lateral Cervical Region:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Head_LateralCervicalReg" name="Head_LateralCervicalReg">
                                 <option value="0">Select Lateral Cervical Region</option>
                                 <cfloop query="getHeadLateralCervicalReg">
                                    <option value="#getHeadLateralCervicalReg.ID#">#getHeadLateralCervicalReg.HLCR_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                           <div class="form-group">
                           <div class="label-wrap">
                              <label for="Head_FacialBones">Facial Bones:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Head_FacialBones" name="Head_FacialBones">
                                 <option value="0">Select Facial Bones</option>
                                 <cfloop query="getHeadFacialBones">
                                    <option value="#getHeadFacialBones.ID#">#getHeadFacialBones.HFB_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="Head_EarOS">Ear OS:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Head_EarOS" name="Head_EarOS">
                                 <option value="0">Select Ear OS</option>
                                 <cfloop query="getHeadEarOS">
                                    <option value="#getHeadEarOS.ID#">#getHeadEarOS.HEOS_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="Head_ChinSkinFolds">Chin Skin Folds:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Head_ChinSkinFolds" name="Head_ChinSkinFolds">
                                 <option value="0">Select Chin Skin Folds</option>
                                 <cfloop query="getHeadChinSkinFolds">
                                    <option value="#getHeadChinSkinFolds.ID#">#getHeadChinSkinFolds.HCSF_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                        <label><strong>Body:</strong></label>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="Body_EpaxialMuscle">Epaxial Muscle:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Body_EpaxialMuscle" name="Body_EpaxialMuscle">
                                 <option value="0">Select Epaxial Muscle</option>
                                 <cfloop query="getBodyEpaxialMuscle">
                                    <option value="#getBodyEpaxialMuscle.ID#">#getBodyEpaxialMuscle.BEM_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                           <div class="form-group">
                           <div class="label-wrap">
                              <label for="Body_DorsalRidgeScapula">Dorsal Ridge of Scapula:</label> 
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Body_DorsalRidgeScapula" name="Body_DorsalRidgeScapula">
                                 <option value="0">Select Dorsal Ridge of Scapula</option>
                                 <cfloop query="getBodyDorsalRidgeScapula">
                                    <option value="#getBodyDorsalRidgeScapula.ID#">#getBodyDorsalRidgeScapula.BDRS_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                           <div class="form-group">
                           <div class="label-wrap">
                              <label for="Body_Ribs">Ribs:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Body_Ribs" name="Body_Ribs">
                                 <option value="0">Select Ribs</option>
                                 <cfloop query="getBodyRibs">
                                    <option value="#getBodyRibs.ID#">#getBodyRibs.BR_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>

                        <label><strong>Tail:</strong></label>
                        <div class="form-group">
                              <div class="label-wrap">
                                 <label for="Tail_TransversePro">Transverse Processes:</label>
                              </div>
                              <div class="input-wrap">
                                 <select class="form-control" id="Tail_TransversePro" name="Tail_TransversePro">
                                    <option value="0">Select Transverse Processes</option>
                                    <cfloop query="getTailTransversePro">
                                       <option value="#getTailTransversePro.ID#">#getTailTransversePro.TTP_Name#</option>
                                    </cfloop>
                                 </select>
                              </div>
                        </div>
                        <div class="dataTables_scroll">
                           <h3>Lesion History</h3>
                           <div class="lison-history-responsive">
                              <div class="lesion-history-table">
                                 <div class="dataTables_scrollHead" >
                                    <div class="dataTables_scrollHeadInner" >
                                    <table class="table table-striped table-bordered dataTable no-footer" role="grid">
                                       <thead>
                                          <tr role="row">
                                             <th  rowspan="1" colspan="1" >Date Seen</th>
                                             <th  rowspan="1" colspan="1" >Sighting No</th>
                                             <th  rowspan="1" colspan="1" >Lesion Type</th>
                                             <th  rowspan="1" colspan="1" >Side</th>
                                             <th  rowspan="1" colspan="1" >Status</th>
                                             <th  rowspan="1" colspan="1" >Region</th>                                                
                                          </tr>
                                       </thead>
                                    </table>
                                    </div>
                                 </div>
                                 <div class="dataTables_scrollBody" style="position: relative; overflow: auto; max-height: 200px; width: 100%;">
                                    <table class="table table-striped table-bordered dataTable no-footer dtr-inline" >
                                    <tbody id="lesion_table">
                                          
                                    </tbody>
                                    </table>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div id="updtaedata" class="updtaedata-select updatedata-sec"></div>
                        <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0>
                        <div id="save_button" style="margin-bottom: 10px;text-align: right;"></div>
                        </cfif>
                        <div class="form-group">
                           <div class="lesion-message-exist"></div>
                        </div>
                        <form role="form" id="add_lesions_form">
                           <input type="hidden" name="Sighting_ID" id="getsight_ID" value="#sight_id#">
                           <input type="hidden" name="Cetacean_NameORcode" id="Cetacean_NameORcode" value="">
                           <input type="hidden" name="cl_cs_Id" id="cl_cs_Id" value="0">
                           <input type="hidden" name="cl_cs_code" id="cl_cs_code" value="">
                           <div class="form-separater">
                              <div class="form-group">
                                 <div class="label-wrap">
                                    <label for="Lesion_Present">Lesion Present:</label>
                                 </div>
                                 <div class="input-wrap">
                                    <select class="form-control customLesionSelect" id="LesionPresent" name="LesionPresent">
                                       <option value="">Select Lesion Present</option>
                                       <option value="YES">YES</option>
                                       <option value="NO">NO</option>
                                       <option value="CBD">CBD</option> 
                                    </select>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="label-wrap">
                                    <label for="body_condition">Lesion Type:</label>
                                 </div>
                                 <div class="input-wrap">
                                    <select class="form-control customLesionSelect" id="LesionType" name="LesionType">
                                       <option value="">Select Lesion Type</option>
                                       <cfloop query="getLesionTypeData">
                                          <option value="#getLesionTypeData.LesionTypeName#">#getLesionTypeData.LesionTypeName#</option>
                                       </cfloop>
                                    </select>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="label-wrap">
                                    <label for="region">Region:</label>
                                 </div>
                                 <div class="input-wrap">
                                    <select class="form-control search-box selected-region" multiple="multiple" id="Region" name="Region">
                                    <cfset counter = 1>
                                       <cfloop query="getRegions">
                                          <option value="#getRegions.ID#">#counter&' - '&getRegions.RegionName#</option>
                                          <cfset counter = counter + 1>
                                       </cfloop>
                                    </select>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="label-wrap">
                                    <label for="Side">Side:</label>
                                 </div>
                                 <div class="input-wrap">
                                    <select class="form-control customLesionSelect" id="Side" name="Side">
                                       <option value="">Select Side</option>
                                       <cfloop from="1" to="#ArrayLen(sides)#" index="j">
                                          <option value="#sides[j]#">#sides[j]#</option>
                                       </cfloop>
                                    </select>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="label-wrap">
                                    <label for="Status">Status:</label>
                                 </div>
                                 <div class="input-wrap">
                                    <select class="form-control customLesionSelect" id="Status" name="Status">
                                       <option value="">Select Status</option>
                                       <option value="Fresh">Fresh</option>
                                       <option value="Healing">Healing</option>
                                       <option value="Healed">Healed</option>
                                    </select>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="label-wrap">
                                    <label for="Photo Number">Photo Number:</label>
                                 </div>
                                 <div class="input-wrap">
                                    <input class="form-control" name="PhotoNumber" id="PhotoNumber" value="" maxlength="4">
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="label-wrap">
                                    <label class="comment-label">Comments</label>
                                 </div>
                                 <div class="input-wrap">
                                    <textarea class="form-control textareaCustomReset locations-textarea" name="Comments" id="Comments"></textarea>
                                 </div>
                              </div>
                              <div class="form-group">
                                 <div class="lesion-message"></div>
                              </div>
                              <div class="form-group" style="margin-top: 20px">
                                    <cfif permissions eq "full_access" or findNoCase("Add Entry Data S-S-C", permissions) neq 0>
                                          <button type="submit" class="btn btn-success" id="addNewLesionAndClearTxt">Add New Lesion And Clear</button> 
                                    </cfif>      
                                    <button type="reset" id="reset_lesion_history" style="display:none">Reset</button>
                                    <button type="button" class="btn btn-success" id="btn_lesion_history" style="float: right">Lesion History</button>
                              </div>
                              <hr/>
                              <div class="form-group">
                                 <button type="button" class="btn btn-success" id="btn_dolphin_img">Dolphin</button>
                                 <button type="button" class="btn btn-success" id="btn_whale_img" style="float: right">Whale</button>
                                 <div class="image-area">
                                    <p class="cetacean-name">Dolphin</p>
                                    <img src="http://test.wildfins.org/resources/assets/img/dolphin-breakdown-diagram.png" class="breakdown-image"/>
                                 </div>
                              </div>
                          </div>
                        </form>
                        </div>
                        </div>
                     </div>
                  </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default cetacean_modal_close" data-dismiss="modal">Close</button>
               </div>
            </div>
         </div>
      </div>
      </div>

      <!--- Modals  --->

      <!--- cetacean_sighting_history Modal  --->
      <div class="CS_history">
         <div id="CS_history" class="modal fade" role="dialog">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close closeCSHistoryModal">&times;</button>
                     <h4 class="modal-title">Cetacean Sighting</h4>
                     <div class="del_CS" style="display:none"></div>
                  </div>
                  <div class="modal-body" style="overflow:hidden">
                     <cfif cetaceans_sight.recordcount gt 0>
                     <cfset lastRow = cetaceans_sight.recordcount>
                        <div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff">
                           <div class="col-md-1">Code</div>
                           <div class="col-md-1">Species</div>
                           <div class="col-md-1">SDR</div>
                           <div class="col-md-1">Best</div>
                           <div class="col-md-1">Sex</div>
                           <div class="col-md-1">Fetals </div>
                           <div class="col-md-1">Dscore</div>
                           <div class="col-md-1">FB NO</div>
                           <div class="col-md-1">With Mom</div>
                           <div class="col-md-1">Notes </div>
                           <div class="col-md-1">Qscore </div>
                           <div class="col-md-1">Actions</div>
                        </div>
                        <cfset i=0>
                        <div class="history_section">
                           <cfloop query="cetaceans_sight">
                              <cfset i=i+1>
                              <div class="row" id="CSHistory_#i#">
                                 <div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;">
                                    <div class="col-md-1 CL Code_#cetaceans_sight.ID#">#cetaceans_sight.Code#</div> 
                                    <div class="col-md-1 CL Species_#cetaceans_sight.ID#">#cetaceans_sight.CetaceanSpeciesName#</div> 
                                    <div class="col-md-1 CL SDR_#cetaceans_sight.ID#">
                                       
                                       <cfif cetaceans_sight.SDR eq 'on'>
                                          yes
                                       <cfelse>
                                          #cetaceans_sight.SDR#
                                       </cfif>
                                    </div>
                                    <div class="col-md-1 CL BestSighting_#cetaceans_sight.ID#">
                                       
                                       <cfif cetaceans_sight.BestSighting eq 'on'>
                                          yes
                                       <cfelse>
                                          #cetaceans_sight.BestSighting#
                                       </cfif>
                                    </div>  
                                    <div class="col-md-1 CL Sex_#cetaceans_sight.ID#">#cetaceans_sight.Sex#</div>
                                    <div class="col-md-1 CL Fetals_#cetaceans_sight.ID#">
                                       <cfif cetaceans_sight.Fetals eq 'on'>
                                          yes
                                       <cfelse>
                                          #cetaceans_sight.Fetals#
                                       </cfif>
                                    </div>
                                    <div class="col-md-1 CL Dscore_#cetaceans_sight.ID#">#cetaceans_sight.Dscore#</div> 
                                    <div class="col-md-1 CL FB_Number_#cetaceans_sight.ID#">#cetaceans_sight.FB_Number#</div> 
                                    <div class="col-md-1 CL wMom_#cetaceans_sight.ID#">
                                       <cfif cetaceans_sight.wMomDropDown eq 1>
                                          Yes
                                       <cfelseif cetaceans_sight.wMomDropDown eq 2>
                                          No
                                       <cfelseif cetaceans_sight.wMomDropDown eq 3>
                                          Partial
                                       </cfif>
                                    </div>
                                    <div class="col-md-1 CL Note_#cetaceans_sight.ID#">#cetaceans_sight.Note#</div> 
                                    <div class="col-md-1 CL Qscore_#cetaceans_sight.ID#">#cetaceans_sight.Qscore#</div>
                                    <div class="col-md-1 CL">
                                       <div class="col-mad-6" style="display:inline-block">
                                          <button class="btn btn-xs btn-primary" type="button" onclick="getSingleCS_Record(#cetaceans_sight.ID#)"><i class="fa fa-pencil-square-o"></i></button>
                                       </div>
                                       <cfif permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0>
                                          <div class="col-mad-6" style="display:inline-block">
                                             <button class="btn btn-xs btn-primary" onclick="deleteCS_Record(#cetaceans_sight.ID#, #i#)"><i class="glyphicon glyphicon-trash"></i></button>
                                          </div>
                                       </cfif>
                                    </div>
                              </div>
                           </div>
                           </cfloop>
                     </div>
                     <cfelse>
                        <h2 style="text-align:center;color:red">There is no Cetacean Sighting added yet!</h2>
                     </cfif>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default closeCSHistoryModal">Close</button>
                  </div>
               </div>
            </div>
         </div>
      </div> 

      <!--- Lesion History Modal  --->
      <div class="lesion_history"></div>
      
      <!---  Update Lesion Modal  --->
      <div id="update_lesion" class="modal fade" role="dialog" style="overflow:auto;">
         <div class="modal-dialog" style="width: 40%;">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close closeLesionUpdateModal">&times;</button>
                  <h4 class="modal-title">Lesions Update Form</h4>
               </div>
               <div class="modal-body" style="overflow:hidden">
                 <form role="form" id="update_lesions_form">   
                  <input type="hidden" id="lesion_Id" name="lesion_Id">
                     <!--- <div class="form-group">
                        <h3>Condition and Lesions</h3>
                     </div>
                     <div class="form-group">
                        <div class="label-wrap">
                           <label for="body_condition">Body Condition:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="BodyCondition" name="BodyCondition">
                              <option value="">Select Body Condition</option>
                              <cfloop from="1" to="#ArrayLen(bodyConditions)#" index="j">
                                 <option value="#j#">#j&' - '&bodyConditions[j]#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>
                      <!---   New section under body condition  10-16-2020     --->
                     <label><strong>Head:</strong></label>
                     <div class="form-group">
                        <div class="label-wrap">
                           <label for="Head_NuchalCrest">Nuchal Crest:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="Head_NuchalCrest" name="Head_NuchalCrest">
                              <option value="0">Select Nuchal Crest</option>
                              <cfloop query="getHeadNuchalCrest">
                                 <option value="#getHeadNuchalCrest.ID#">#getHeadNuchalCrest.HNC_Name#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>
                        <div class="form-group">
                        <div class="label-wrap">
                           <label for="Head_LateralCervicalReg">Lateral Cervical Region:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="Head_LateralCervicalReg" name="Head_LateralCervicalReg">
                              <option value="0">Select Lateral Cervical Region</option>
                              <cfloop query="getHeadLateralCervicalReg">
                                 <option value="#getHeadLateralCervicalReg.ID#">#getHeadLateralCervicalReg.HLCR_Name#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>
                        <div class="form-group">
                        <div class="label-wrap">
                           <label for="Head_FacialBones">Facial Bones:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="Head_FacialBones" name="Head_FacialBones">
                              <option value="0">Select Facial Bones</option>
                              <cfloop query="getHeadFacialBones">
                                 <option value="#getHeadFacialBones.ID#">#getHeadFacialBones.HFB_Name#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>
                     <div class="form-group">
                        <div class="label-wrap">
                           <label for="Head_EarOS">Ear OS:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="Head_EarOS" name="Head_EarOS">
                              <option value="0">Select Ear OS</option>
                              <cfloop query="getHeadEarOS">
                                 <option value="#getHeadEarOS.ID#">#getHeadEarOS.HEOS_Name#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>
                     <div class="form-group">
                        <div class="label-wrap">
                           <label for="Head_ChinSkinFolds">Chin Skin Folds:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="Head_ChinSkinFolds" name="Head_ChinSkinFolds">
                              <option value="0">Select Chin Skin Folds</option>
                              <cfloop query="getHeadChinSkinFolds">
                                 <option value="#getHeadChinSkinFolds.ID#">#getHeadChinSkinFolds.HCSF_Name#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>
                     <label><strong>Body:</strong></label>
                     <div class="form-group">
                        <div class="label-wrap">
                           <label for="Body_EpaxialMuscle">Epaxial Muscle:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="Body_EpaxialMuscle" name="Body_EpaxialMuscle">
                              <option value="0">Select Epaxial Muscle</option>
                              <cfloop query="getBodyEpaxialMuscle">
                                 <option value="#getBodyEpaxialMuscle.ID#">#getBodyEpaxialMuscle.BEM_Name#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>
                        <div class="form-group">
                        <div class="label-wrap">
                           <label for="Body_DorsalRidgeScapula">Dorsal Ridge of Scapula:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="Body_DorsalRidgeScapula" name="Body_DorsalRidgeScapula">
                              <option value="0">Select Dorsal Ridge of Scapula</option>
                              <cfloop query="getBodyDorsalRidgeScapula">
                                 <option value="#getBodyDorsalRidgeScapula.ID#">#getBodyDorsalRidgeScapula.BDRS_Name#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>
                        <div class="form-group">
                        <div class="label-wrap">
                           <label for="Body_Ribs">Ribs:</label>
                        </div>
                        <div class="input-wrap">
                           <select class="form-control" id="Body_Ribs" name="Body_Ribs">
                              <option value="0">Select Ribs</option>
                              <cfloop query="getBodyRibs">
                                 <option value="#getBodyRibs.ID#">#getBodyRibs.BR_Name#</option>
                              </cfloop>
                           </select>
                        </div>
                     </div>

                     <label><strong>Tail:</strong></label>
                     <div class="form-group">
                           <div class="label-wrap">
                              <label for="Tail_TransversePro">Transverse Processes:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control" id="Tail_TransversePro" name="Tail_TransversePro">
                                 <option value="0">Select Transverse Processes</option>
                                 <cfloop query="getTailTransversePro">
                                    <option value="#getTailTransversePro.ID#">#getTailTransversePro.TTP_Name#</option>
                                 </cfloop>
                              </select>
                           </div>
                     </div> --->
                     <div class="form-separater">
                        <div class="form-group">
                                 <div class="label-wrap">
                                    <label for="Lesion_Present">Lesion Present:</label>
                                 </div>
                                 <div class="input-wrap">
                                    <select class="form-control customLesionSelect" id="LesionPresent" name="LesionPresent">
                                       <option value="">Select Lesion Present</option>
                                       <option value="YES">YES</option>
                                       <option value="NO">NO</option>
                                       <option value="CBD">CBD</option> 
                                    </select>
                                 </div>
                              </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="body_condition">Lesion Type:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control customLesionSelect" id="LesionType" name="LesionType">
                                 <option value="">Select Lesion Type</option>
                                 <cfloop query="getLesionTypeData">
                                    <option value="#getLesionTypeData.LesionTypeName#">#getLesionTypeData.LesionTypeName#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="region">Region:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control search-box selected-region" multiple="multiple" id="Region" name="Region">
                              <cfset counter = 1>
                              <cfloop query="getRegions">
                                    <option value="#getRegions.ID#">#counter&' - '&getRegions.RegionName#</option>
                                    <cfset counter = counter + 1>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="Side">Side:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control customLesionSelect" id="Side" name="Side">
                                 <option value="">Select Side</option>
                                 <cfloop from="1" to="#ArrayLen(sides)#" index="j">
                                    <option value="#sides[j]#">#sides[j]#</option>
                                 </cfloop>
                              </select>
                           </div>
                        </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="Status">Status:</label>
                           </div>
                           <div class="input-wrap">
                              <select class="form-control customLesionSelect" id="Status" name="Status">
                                 <option value="">Select Status</option>
                                 <option value="Fresh">Fresh</option>
                                 <option value="Healing">Healing</option>
                                 <option value="Healed">Healed</option>
                              </select>
                           </div>
                        </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label for="Photo Number">Photo Number:</label>
                           </div>
                           <div class="input-wrap">
                              <input class="form-control" name="PhotoNumber" id="PhotoNumber" value="" maxlength="4">
                           </div>
                        </div>
                        <div class="form-group">
                           <div class="label-wrap">
                              <label class="comment-label">Comments</label>
                           </div>
                           <div class="input-wrap">
                              <textarea class="form-control textareaCustomReset locations-textarea" style="width: 100% !important; height: auto !important;" name="Comments" id="Comments"></textarea>
                           </div>
                        </div>
                        <div class="form-group">
                           <div class="update-lesion-message"></div>
                        </div>
                        <div class="form-group" style="margin-top: 20px">
                           <button type="submit" class="btn btn-success">Update Lesion</button>
                        </div>
                     </div>
                  </form>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default closeLesionUpdateModal">Close</button>
               </div>
            </div>
         </div>
      </div>

      <!-- Creates the bootstrap modal where the image will appear -->
      <div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog" style="width:48%">
         <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title" id="myModalLabel"></h4>
            </div>
            <div class="modal-body">
            <img src="" id="imagepreview" style="width: 80%; height: auto;" >
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
         </div>
      </div>
      </div>

   </cfif>
</cfoutput>