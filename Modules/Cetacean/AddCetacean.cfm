<cfset getSourceSex = Application.Dolphin.getSourceSex()>
<cfset getYOBSource=Application.Dolphin.get_YOB_Source()>
<cfset getCetaceanSpeciesData = Application.StaticDataNew.getCetaceanSpecies()>
<!--- <cfset setDate = DateFormat(Now(),'mm/dd/yyyy')> --->
<div id="content" class="content">
   <!-- begin breadcrumb -->
   <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Home</a></li>
         <li class="active">Add Cetacean </li>
   </ol>
   <!-- end breadcrumb -->
   <!-- begin page-header -->
      <h1 class="page-header">Add Cetacean </h1>
   <!-- end page-header -->
   <div class="section-container section-with-top-border p-b-10">
      <div class="row p-t-10">
         <!-- begin col-6 -->
         <div class="col-md-12">
            <cfoutput>
               <form role="form" id="add_cetacean" enctype="multipart/form-data" autocomplete="off">
                    <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                              <div class="form-group">
                                 <label for="email">Cetacean Name:</label>
                                 <input type="text" class="form-control" name="Name" required placeholder="Enter Cetacean Name">
                              </div>
                              <div class="form-group">
                                 <label for="email">Cetacean Code:</label>
                                 <input type="text" class="form-control" name="Code" required placeholder="Enter Cetacean Code">
                              </div>
                              <div class="form-group">
                                 <label for="email">Sex:</label>
                                 <select class="form-control" name="Sex">
                                    <option value="">Select Sex</option>
                                    <option value="F">F</option>
                                    <option value="M">M</option>
                                    <option value="U">U</option>
                                 </select>
                              </div>
                              <div class="form-group">
                                 <label for="email">Source Sexed:</label>
                                 <select class="form-control" name="SourceSexed" >
                                    <option value="0">Select Source Sexed</option>
                                    <cfloop query="getSourceSex">
                                       <option value="#getSourceSex.ID#"> #getSourceSex.Ssex#</option>
                                    </cfloop>
                                 </select>
                              </div>
                              <div class="form-group">
                                 <label for="email">Lineage</label>
                                 <input type="text" class="form-control" name="Lineage" placeholder="Enter Lineage">
                              </div>
                              <div class="form-group">
                                 <label for="email">Mother</label>
                                 <input type="text" class="form-control" name="Mother" placeholder="Enter Mother">
                              </div>
                              <div class="form-group">
                                 <label for="pwd">Best Images:</label>
                              </div>
                              <div class="form-group">
                                    <label for="alt_img">Select Cetacean Photo(Primary)</label>
                                    <img src="" id="alt_img" alt="" width="50" >
                                    <input class="input-5" name="BestImage" type="file" class="file-loading">
                              </div>
                              <div class="form-group">
                                    <label for="sec_alt_img">Select Cetacean Photo(Secondary)</label>
                                    <img src="" id="sec_alt_img" alt="" width="50" >
                                    <input class="input-5" name="SecondaryImage" type="file" class="file-loading">
                              </div>
                              <!-------left end------->
                           </div>
                           <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                              <!-------Middel strt------->
                              <div class="form-group">
                                 <label for="email">Date of Birth Estimate:</label>
                                 <input type="text" class="form-control datetimepicker" name="Date_of_Birth_EST" placeholder="MM/DD/YYYY">
                              </div>

                               <div class="form-group">
                                 <label for="email">Year Of Birth:</label>
                                 <input type="text" class="form-control" value="" name="YearOfBirth" placeholder="Enter Year">
                              </div>
                               <div class="form-group">
                                 <label for="email">Source YOB:</label>
                                 <select class="form-control" name="Source_YOB">
                                    <option value="0">Select Source YOB</option>
                                    <cfloop query="getYOBSource">
                                        <option value="#getYOBSource.ID#"> #getYOBSource.YOBSource#</option>
                                    </cfloop>
                                </select>
                            </div>

                               <div class="form-group">
                                 <label for="email">Date of Death:</label>
                                 <input type="text" class="form-control datetimepicker" name="Date_of_Death" placeholder="MM/DD/YYYY">
                              </div>
                              <div class="form-group">
                                 <label for="email">First Sighting Date:</label>
                                 <input type="text" class="form-control datetimepicker" name="First_Sighting_Date" placeholder="MM/DD/YYYY">
                              </div>

                              <div class="form-group">
                                <label for="email">Cetacean Species:</label>
                                <select class="form-control" name="CetaceanSpecies">
                                    <option value="0">Select Cetacean Species</option>
                                    <cfloop query="getCetaceanSpeciesData">
                                        <option value="#getCetaceanSpeciesData.ID#"> #getCetaceanSpeciesData.CetaceanSpeciesName#</option>
                                    </cfloop>
                                  </select>
                              </div>
                              <!-------- middl end----------------->
                           </div>
                           <!-------- Right Side----------------->
                           <div class="col-md-4">
                              <div class="form-group">
                                 <label for="email">Dscore:</label>
                                 <input type="text" class="form-control" name="Dscore" placeholder="Enter Dscore">
                              </div>
                              <div class="form-group">
                                 <label for="email">Presumed Dead:</label>
                                 <input type="text" class="form-control " name="PresumedDead" placeholder="Enter Presumed Dead">
                              </div>
                               <div class="form-group">
                                 <label for="email">Dead:</label>
                                 <select class="form-control" name="Dead">
                                    <option value="0">Select Dead(Y/N)</option>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                 </select>
                              </div>
                              <div class="form-group">
                                 <label for="email">Hubbs ID:</label>
                                 <input type="text" class="form-control" value="" name="HUBBS_ID" placeholder="Enter Hubbs ID">
                              </div>
                              <div class="form-group">
                                 <label for="email">Field ID:</label>
                                 <input type="text" class="form-control" value="" name="Field_ID" placeholder="Enter Field ID">
                              </div>
                              <div class="form-group">
                                 <label for="email">FB Number:</label>
                                 <input type="text" class="form-control" value="" name="FB_Number" placeholder="Enter FB Number">
                              </div>
                              <div class="form-group">
                                 <label for="email">Previous HBOI Code</label>
                                 <input type="text" class="form-control" value="" name="Previous_HBOCI_CODE" placeholder="Enter Previous HBOI Code">
                              </div>
                              <!-------- newdolhpin right side end------>
                           </div>
                        <div class="col-md-12"> 
                           <div class="message"></div>
                           <div class="form-group">
                             <button type="submit" class="btn btn-success" name="addnew_dolphin" >Add Cetacean</button> 
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