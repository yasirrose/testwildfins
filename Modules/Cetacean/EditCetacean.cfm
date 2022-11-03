<!--- Update Cetacean--->
<cfif isdefined("form.id")>
    <cfset getCetacean=Application.Cetaceans.getsingl_Cetacean(argumentCollection="#Form#")>
</cfif>

<cfset getSourceSex = Application.Dolphin.getSourceSex()>
<cfset getYOBSource=Application.Dolphin.get_YOB_Source()>
<cfset getCetaceanSpeciesData = Application.StaticDataNew.getCetaceanSpecies()>

<div id="content" class="content">
   <!-- begin breadcrumb -->
   <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Home</a></li>
         <li class="active">Update Cetacean </li> 
   </ol>
   <!-- end breadcrumb -->
   <!-- begin page-header -->
     <h1 class="page-header">Update Cetacean </h1>
   <!-- end page-header -->
   <div class="section-container section-with-top-border p-b-10">
      <div class="row p-t-10">
         <!-- begin col-6 -->
         <div class="col-md-12">
            <cfoutput>
               <form role="form" id="update_cetacean" enctype="multipart/form-data" autocomplete="off">
                    <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                              <div class="form-group">
                                 <label for="email">Cetacean Name:</label>
                                 <input type="text" class="form-control" value="#getCetacean.name#" name="Name" required placeholder="Enter Cetacean Name">
                                 <input type="hidden" value="#form.id#" name="ID">
                              </div>
                              <div class="form-group">
                                 <label for="email">Cetacean Code:</label>
                                 <input type="text" class="form-control" name="Code" value="#getCetacean.Code#" required placeholder="Enter Cetacean Code">
                              </div>
                              <div class="form-group">
                                 <label for="email">Sex:</label>
                                 <select class="form-control" name="Sex">
                                    <option value="">Select Sex</option>
                                    <option value="F" <cfif getCetacean.sex eq "F"> selected</cfif>>F</option>
                                    <option value="M" <cfif getCetacean.sex eq "M"> selected</cfif>>M</option>
                                    <option value="U" <cfif getCetacean.sex eq "U"> selected</cfif>>U</option>
                                 </select>
                              </div>
                              <div class="form-group">
                                 <label for="email">Source Sexed:</label>
                                  <select class="form-control" name="SourceSexed" >
                                    <option value="0">Select Source Sexed</option>
                                    <cfloop query="getSourceSex">
                                        <option value="#getSourceSex.ID#" <cfif getSourceSex.ID EQ #getCetacean.SourceSexed#> selected </cfif> > #getSourceSex.Ssex#</option>
                                    </cfloop>
                                  </select>
                              </div>
                              <div class="form-group">
                                 <label for="email">Lineage</label>
                                 <input type="text" class="form-control" name="Lineage" placeholder="Enter Lineage" value="#getCetacean.Lineage#">
                              </div>
                              <div class="form-group">
                                 <label for="email">Mother</label>
                                 <input type="text" class="form-control" name="Mother" placeholder="Enter Mother" value="#getCetacean.Mother#">
                              </div>
                               <div class="form-group">
                                 <label for="email">Date of Birth Estimate:</label>
                                 <input type="text" class="form-control datetimepicker" id="datetimepickerEST" name="Date_of_Birth_EST" value="#dateFormat(getCetacean.DateOfBirthEstimate,"mm/dd/yyyy")#" placeholder="MM/DD/YYYY">
                              </div>

                                <cfset setPrimaryImage  = '#Application.CloudRoot#no-image.jpg'>
                                <cfset setSecondaryImage  = '#Application.CloudRoot#no-image.jpg'>

                                <cfset PrimaryImage = "#getCetacean.ImageName#">
                                <cfset SecondaryImage = "#getCetacean.SecondaryImage#">
                                  
                                  
                                <cfif FileExists('#Application.CloudDirectory##PrimaryImage#')>
                                  <cfset  setPrimaryImage = '#Application.CloudRoot##PrimaryImage#'>
                                 </cfif> 
                                <cfif FileExists('#Application.CloudDirectory##SecondaryImage#')>
                                    <cfset  setSecondaryImage  = '#Application.CloudRoot##SecondaryImage#'>
                                </cfif>
                              <div class="form-group">
                                 <label for="pwd">Best Images:</label>
                              </div>

                              <div class="form-group">
                                    <label for="image">Select Cetacean Photo (Primary)</label>
                                   <span id="delete_image_1">
                                       <img src="#setPrimaryImage#" id="alt_img" alt="" width="265">
                                       <p style="margin-top:10px"> 
                                          <cfif "#getCetacean.ImageName#" NEQ "" AND "#getCetacean.ImageName#" NEQ 'no-image.jpg'>
                                             <button type="button" class="btn btn-danger" onclick="deleteBestImage(1,'#getCetacean.ID#',1,'#getCetacean.ImageName#')">Remove Image</button>
                                          </cfif>
                                       </p>
                                    </span>
                                    <input class="input-5" name="BestImage" id="BestImage" type="file" class="file-loading">
                                    <input type="hidden" name="oldImage" id="oldImage" value="#setPrimaryImage#">
                              </div>
                              <div class="form-group">
                                    <label for="image">Select Cetacean Photo (Secondary)</label>
                                    <span id="delete_image_2">
                                       <img src="#setSecondaryImage#" id="sec_alt_img" alt="" width="265">
                                          <p style="margin-top:10px"> 
                                          <cfif "#getCetacean.SecondaryImage#" NEQ "" AND "#getCetacean.SecondaryImage#" NEQ 'no-image.jpg'>
                                             <button type="button" class="btn btn-danger" onclick="deleteBestImage(2,'#getCetacean.ID#',0,'#getCetacean.SecondaryImage#')">Remove Image</button>
                                          </cfif>
                                       </p>
                                    </span>
                                    <input class="input-5" name="SecondaryImage" id="SecondaryImage" type="file" class="file-loading">
                                    <input type="hidden" name="SecOldImage" id="SecOldImage" value="#setSecondaryImage#">
                              </div>

                              <!-------left end------->
                           </div>
                           <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                              <!-------Middel strt------->
                               <div class="form-group">
                                 <label for="email">Year Of Birth:</label>
                                 <input type="text" class="form-control" name="YearOfBirth" value="#getCetacean.YearOfBirth#" placeholder="Enter Year">
                              </div>

                              <div class="form-group">
                                 <label for="email">Source YOB:</label>
                                 <select class="form-control" name="Source_YOB" >
                                    <option value="0">Select Source YOB</option>
                                    <cfloop query="getYOBSource">
                                        <option  value="#getYOBSource.ID#"<cfif getYOBSource.YOBSOURCE EQ #getCetacean.YOBSource#> selected </cfif> > #getYOBSource.YOBSource#</option>
                                    </cfloop>
                                </select>
                              </div>

                               <div class="form-group">
                                 <label for="email">Date of Death:</label>
                                 <input type="text" class="form-control datetimepicker" name="Date_of_Death" value="#dateFormat(getCetacean.DateDeath,"mm/dd/yyyy")#" placeholder="MM/DD/YYYY">
                              </div>
                              <div class="form-group">
                                 <label for="email">First Sighting Date:</label>
                                 <input type="text" class="form-control datetimepicker" name="First_Sighting_Date" value="#dateFormat(getCetacean.FirstSightingDate,"mm/dd/yyyy")#" placeholder="MM/DD/YYYY">
                              </div>

                              <div class="form-group">
                                <label for="email">Cetacean Species:</label>
                                <select class="form-control" name="CetaceanSpecies" >
                                    <option value="0">Select Cetacean Species</option>
                                    <cfloop query="getCetaceanSpeciesData">
                                        <option value="#getCetaceanSpeciesData.ID#" <cfif getCetaceanSpeciesData.ID EQ #getCetacean.CetaceanSpecies#> selected </cfif> > #getCetaceanSpeciesData.CetaceanSpeciesName#</option>
                                    </cfloop>
                                  </select>
                              </div>

                              <div class="form-group">
                                 <label for="email">Dscore:</label>
                                 <input type="text" class="form-control" name="Dscore" value="#getCetacean.DScore#" placeholder="Enter Dscore">
                              </div>
                              <!-------- middl end----------------->
                           </div>
                           <!-------- Right Side----------------->
                           <div class="col-md-4">
                              <div class="form-group">
                                 <label for="email">Presumed Dead:</label>
                                 <input type="text" class="form-control " name="PresumedDead" value="#getCetacean.PresumedDead#" placeholder="Enter Presumed Dead">
                              </div>
                              
                               <div class="form-group">
                                 <label for="email">Dead:</label>
                                 <select class="form-control" name="Dead">
                                    <option value="">Select Dead(Y/N)</option>
                                    <option value="Y" <cfif getCetacean.Dead eq "Y"> selected</cfif>>Yes</option>
                                    <option value="N" <cfif getCetacean.Dead eq "N"> selected</cfif>>No</option>
                                 </select>
                              </div>
                              <div class="form-group">
                                 <label for="email">Hubbs ID:</label>
                                 <input type="text" class="form-control" name="HUBBS_ID" value="#getCetacean.HUBBS_ID#" placeholder="Enter Hubbs ID:">
                              </div>
                              <div class="form-group">
                                 <label for="email">Field ID:</label>
                                 <input type="text" class="form-control" name="Field_ID" value="#getCetacean.Field_ID#" placeholder="Enter Field ID">
                              </div>
                              <div class="form-group">
                                 <label for="email">FB Number:</label>
                                 <input type="text" class="form-control" name="FB_Number" value="#getCetacean.FB_Number#" placeholder="Enter FB Number">
                              </div>
                              <div class="form-group">
                                 <label for="email">Previous HBOI Code</label>
                                 <input type="text" class="form-control" value="#getCetacean.HBOCI_CODE#" name="Previous_HBOCI_CODE" placeholder="Enter Previous HBOCI CODE">
                              </div>
                              <!-------- newdolhpin right side end------>
                           </div>
                        <div class="col-md-12"> 
                           <div class="message"></div>
                           <div class="form-group">
                             <button type="submit" class="btn btn-success" name="addnew_dolphin" >Update Cetacean</button> 
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