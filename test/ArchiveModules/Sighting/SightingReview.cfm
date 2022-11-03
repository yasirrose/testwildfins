<cfoutput>
<cfparam name="form.PROJECT_ID" default="0">
<!---<cfset Application.dsn = "wildfins">--->

<!----
--
--		Update Query
--
                           --->
<cfif isdefined('form.submit')>

<cfset SIGHT=Application.Sighting.qUpdateAnalyzd_SIGHT(argumentCollection="#Form#")>

<cfif SIGHT.recordcount EQ 1>
    <cfset message="Sighting analyzing completed">
    </cfif>

</cfif>

<!----
--
--	 Insert Query
--
                           --->
<cfif isdefined('form.add_data')>
 <!---- last sight ID------>
<cfset qInsertid = Application.Sighting.qInsertid()>

  <cfset dummydate="1899-12-30 ">
  <cfset StartTime=dummydate & StartTime>
  <cfset EndTime=dummydate & EndTime >
  <cfset SurveyStartTime=dummydate & SurveyStartTime>
  <cfset SurveyEndTime=dummydate & SurveyEndTime>
  <cfset Sightingstart=dummydate & Sightingstart>
  <cfset Sightingend=dummydate & Sightingend>
   <cfif StartTime gte EndTime>
    <cfset error="Dock Start time must be less than Dock End Time">
    <cfelseif SurveyStartTime gte SurveyEndTime>
    <cfset error="Survey Start time must be less than Survey End Time">
    <cfelseif Sightingstart gte Sightingend>
    <cfset error="Sight Start time must be less than Sight End Time">
    <cfelse>
    
<cfset project_id = qInsertid.id + 1>
<cfset qInsertProject = Application.Sighting.qInsertProject(argumentCollection="#Form#")>

<cftry>
<!---- Insert sight ID------>
<cfset qInsertProject = Application.Sighting.InsertSight(argumentCollection="#Form#")>

 <!---- last sight ID------>
<cfset lastsight_id = Application.Sighting.qInsertids()>

<!---- photo roool------->
<cfset qPHOTO_ROLLS = Application.Sighting.qPHOTO_ROLLS()>


<!---- camera lens insert------->
<cfset camera_lensinsert = Application.Sighting.camera_lensinsert(argumentCollection="#Form#")>

<cfif qInsertProject.RECORDCOUNT eq 1 ><cfset success = 1></cfif>
 	  <!--------  image upload rename/extention changing .direcrtory create.image delete ----------------->
      
	  <cfset strPath=ExpandPath("./")>
      <cfif not DirectoryExists("#ExpandPath('.')#/assets/project_image/#project_id#")>
        <cfdirectory action = "create" directory="#ExpandPath('.')#/assets/project_image/#project_id#" />
      </cfif>
      <!--- upload     --->
      <cfif len(trim(form.image))>
        <cffile action="upload"
     fileField="image"
     destination="#strPath#assets\project_image\#project_id#\"
     result="image_info"
     nameconflict="overwrite">
     <!------- Resize rename/extension changed------------->
<cfimage
action = "resize"
source = "#strPath#assets\project_image\#project_id#\#image_info.serverfile#"
width = "100%" 
height = "100%"
destination = "#strPath#assets\project_image\#project_id#\#lastsight_id.ids#.png" 
name = "#lastsight_id.ids#"
overwrite = "yes">
        <cfset message="image uploaded">
      </cfif>    
      <cfcatch>
        <cfdump var="#cfcatch#">
      </cfcatch>
    </cftry>
  </cfif>
  <!-- timer conditions end --->
</cfif>


<!----
--		Insert Sighting for Project Query
--
                            --->
<cfif isdefined('form.add_sighting')>
<cfset dummydate="1899-12-30 ">
<cfset Sightingstart=dummydate & Sightingstart>
<cfset Sightingend=dummydate & Sightingend>
<cfif Sightingstart gte Sightingend>
    <cfset error="Sight Start time must be less than Sight End Time">
<cfelse>

<cfset qInsertsigting = Application.Sighting.InsertSight(argumentCollection="#Form#")>
 <!---- last sight ID------>
<cfset lastsight_id = Application.Sighting.qInsertids()>

<!---- camera lens insert------->
<cfset camera_lensinsert = Application.Sighting.camera_lensinsert(argumentCollection="#Form#")>

<cfif qInsertsigting.RECORDCOUNT eq 1 ><cfset message ="Sighting Added"></cfif>
 	  <!--------  image upload rename/extention changing .direcrtory create.image delete ----------------->
      
	  <cfset strPath=ExpandPath("./")>
      <cfif not DirectoryExists("#ExpandPath('.')#/assets/project_image/#project_id#")>
        <cfdirectory action = "create" directory="#ExpandPath('.')#/assets/project_image/#project_id#" />
      </cfif>
      <!--- upload     --->
      <cfif len(trim(form.image))>
     <cffile action="upload"
     fileField="image"
     destination="#strPath#assets\project_image\#project_id#\"
     result="image_info"
     nameconflict="overwrite">
     <!------- Resize rename/extension changed------------->

    <cfimage
    action = "resize"
    source = "#strPath#assets\project_image\#project_id#\#image_info.serverfile#"
    width = "100%" 
    height = "100%"
    destination = "#strPath#assets\project_image\#project_id#\#lastsight_id.ids#.png" 
    name = "#lastsight_id.ids#"
    overwrite = "yes">
    </cfif>
</cfif><!-- time if end -->
</cfif>


 <!----
--
--		Select Query
--
                           --->
<cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq ''>                           
	<!----- Projects------->
  	<cfset qProjects=Application.Sighting.qProjects(argumentCollection="#Form#")>
    <cfset qProjectszone=Application.Sighting.qProjectszone(argumentCollection="#Form#")>
    <cfelse>
  	<cfset qProjects=Application.Sighting.qProject_ten()>
	</cfif>
<!---- Sight Detail--->
<cfparam name="form.sight_id" default="0">
<cfset qGetSightings=Application.Sighting.qSightningDetails(argumentCollection="#Form#")>
<!---- get Sighting List--->
<cfset getsightinglist=Application.Sighting.getsightinglist(argumentCollection="#Form#")>

<!--- Camera And Lens --->
<cfset qGetCamera=Application.Sighting.qGetCameralens()>

<cfset cameras = ValueList(qGetCamera.Camera_Name,",")>
<cfset cameras_ids = ValueList(qGetCamera.camera_ID,",")>
<cfset lens = ValueList(qGetCamera.Lens_Name,",")>

<!--- Camera And Lens --->

<!--- Conditions --->

<cfset qGetWave=Application.Sighting.qGetWave()>
 <cfset getWaveHeight = Application.Sighting.getWaveHeight()> 
<cfset getWeather=Application.Sighting.qGetWeather()>
 <cfset getGlare = Application.Sighting.getGlare()>   
 <cfset getSightability = Application.Sighting.getSightability()>  

<!--- Conditions --->

<!--- Extracting Survey area --->
<cfset getSurveyArea=Application.Sighting.getSurveyArea()>
<cfset getSurvey=Application.Sighting.getSurvey()>
<cfset getTeams=Application.Sighting.getTeams()>

<!---
<cfset qGetSightings=Application.Sighting.qGetSightings(argumentCollection="#Form#")>
---->
<cfset qGetBeaufort=Application.Sighting.qGetBeaufort()>

<cfset qGetAssocBioData=Application.Sighting.qGetAssocBioData()>

<cfset qGetProjectZones=Application.Sighting.qGetProjectZones(argumentCollection="#Form#")>

 <!------ Lens list----------------->
  <cfset lenslist = Application.Sighting.getLens()>
  
 <!---------- Camera list------------>
 <cfset cameralist = Application.Sighting.getCamera()>
 <!------ Zone list ------------------>
 <cfset zonelist = Application.Sighting.zonelist()>
 <!------- Project list--------->         
 <cfset qProjectsId = Application.Sighting.qProjectsId()>     
 <!------- Stock list--------->         
 <cfset getStock = Application.Sighting.getStock()>     
 
 
     
 <div id="content" class="content"> 
  <!-- begin breadcrumb -->
  <ol class="breadcrumb pull-right">
    <li><a href="javascript:;">Home</a></li>
    <li><a href="javascript:;">Sighting</a></li>
  </ol>
  <!-- end breadcrumb --> 
  <!-- begin page-header -->
   <h1 class="page-header">Sighting
    <cfinclude template="SightingMenu.cfm">
  </h1>
  
  
  <cfif isdefined('success') and success eq 1 >
  <div class="alert alert-success">
  	<strong>Success!</strong> Project id #project_id# Inserted Successfully
	</div>
    
  </cfif>
  <cfif isdefined('success') and success eq 2 >
    <div class="alert alert-success">
  	<strong>Success!</strong> Project  record updated.
	</div>
  </cfif>
  <cfif isdefined('error')>
  	<div class="alert alert-danger">
  	<strong>Alert!</strong> #error#
	</div>
  </cfif>
  
  <cfif isdefined('message')>
  	<div class="alert alert-success">
  	<strong>Success!</strong> #message#
	</div>
  </cfif>
  
  <!-- end page-header -->
  <div class="section-container section-with-top-border p-b-10 SightingReview-holder"> 
    <!-- begin row -->
    <div class="main-form-section">
      <div class="row">
        <div  class="pull-right col-lg-12" style="margin-bottom:10px">
          <div class="col-lg-4 col-md-12">
            <form id="myform" action="" method="post" >
              <label for="sel1">Select Project:</label>
              <select class="form-control search-box" id="project_val" onChange="sendForm()" name="project_id">
                <cfloop query="qProjectsId">
                  <option value="#qProjectsId.id#" <cfif isdefined('form.project_id') and form.project_id eq qProjectsId.id>
                  selected</cfif>>#DateTimeFormat(qProjectsId.Date,'YYYY-MM-DD')#</option>
                </cfloop>
              </select>
            </form>
          </div>
          
          <div class="col-lg-4 col-md-12">
          <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>
        	<form method="post"  id="sightform">
       		<div class="col-md-12 m-b-10">
       		<label for="sel1">Select Sighting: </label>
            <select name="sight_id" onchange="submitsightForm()" id="sightid" class="form-control search-box">
            <option value="0">Select Sighting</option>
            <cfset r=getsightinglist.recordcount>
            <cfloop query="getsightinglist">
           
            <option value="#getsightinglist.ID#" <cfif getsightinglist.ID EQ  qGetSightings.ID> selected</cfif>>#r#</option>
             <cfset r=r-1>
            </cfloop>
            
            </select>
            <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
            </div>
            </form>
       </cfif>
          </div>
             
        </div>
        
      </div>
        
       
   
        <div class="row clearfix survey-info-holder">
          <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 date-pick-box">
            <div class="inner-border-box">
              
              <div class="col-md-6 col-xs-12 no-padding">
              <div class="form-group">
                <label class="control-label col-lg-3 col-md-3 col-sm-12 col-xs-12">Date</label>
                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 select-box">
                  <div class="review-margin-left">#DateTimeFormat(qProjects.Date, "YYYY-MM-DD")#</div>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-3 col-md-3 col-sm-12 col-xs-12">Dock Start</label>
                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 select-box">
                  <div class="review-margin-left">#TimeFormat(qProjects.StartTime, "HH:nn")#</div>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-3 col-md-3 col-sm-12 col-xs-12">Dock End</label>
                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 select-box">
                  <div class="review-margin-left">#TimeFormat(qProjects.EndTime, "HH:nn")#</div>
                </div>
              </div>
              </div>
               <div class="col-md-6 col-xs-12 no-padding">
              <div class="form-group">
                <label class="control-label col-lg-5 col-md-5 col-sm-12 col-xs-12">Survey Start</label>
                <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12 select-box">
                  <div class="review-margin-left">#TimeFormat(qProjects.SurveyStartTime, "HH:nn")#</div>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-5 col-md-5 col-sm-12 col-xs-12">Survey End</label>
                <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12 select-box">
                  <div class="review-margin-left">#TimeFormat(qProjects.SurveyEndTime, "HH:nn")#</div>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-5 col-md-5 col-sm-12 col-xs-12">Survey type</label>
                <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12 select-box">
                  <div class="review-margin-left"><cfif qProjects.SurveyType eq 1> ICW<cfelseif qProjects.SurveyType eq 0> Transect</cfif></div>
                </div>
              </div>
              </div>
              
                <div>
                <div class="form-group has-feedback">
                  <label>Summary</label>
                  <div>
                    #qProjects.Summary#
                     </div>
                </div>
              </div>
              
            </div>
          </div>
          <div class="col-lg-3 col-md-3 col-sm-8 col-xs-12 team-box">
            <div class="inner-border-box">
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-btn">
                   <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Team</label>
                  </div>
                  <div class="review-margin-left">#qProjects.ResearchTeam#</div>
               </div>
              </div>
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-btn">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Platform</label>
                  </div>
                  <div class="review-margin-left">#qProjects.Platform#</div>
                </div>
              </div>
              
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-btn">
                     <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Area</label>
                  </div>
                  <div class="review-margin-left">#qProjects.SurveyArea#</div>
                </div>
              </div>
             <div class="form-group">
                <div class="input-group">
                  <div class="input-group-btn">
                     <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Stock</label>                                        
                  </div>
                  <div class="review-margin-left">#qProjects.Stock#</div>
                </div>
              </div>
              
            </div>
          </div>
          <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 zone-box">
            <div class="inner-border-box">
            
             <div class="form-group">
                <label class="control-label col-lg-3 col-md-3 col-sm-12 col-xs-12">Zone Begin</label>
                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 select-box">
                  <div class="review-margin-left">
				  <cfloop query="zonelist">
				  <cfif qProjects.BeginZoneID eq zonelist.ID>#zonelist.zone#</cfif>
                  </cfloop>
                  
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-lg-3 col-md-3 col-sm-12 col-xs-12">Zone End</label>
                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 select-box">
                	<div class="review-margin-left">
					<cfloop query="zonelist">
					<cfif qProjects.EndZoneID eq zonelist.ID>#zonelist.zone#</cfif>
                    </cfloop>
                    </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 date-pick-box location">
            <div class="inner-border-box">
              <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                  <div class="inline-boxes">
                    <div class="box-inline second">
                    
                      <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting Number</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div class="review-margin-left">#qGetSightings.SightingNumber#</div>
                        </div>
                      </div>
                      
                      <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting Start</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div class="review-margin-left">#TimeFormat(qGetSightings.StartTime, 'HH:nn')#</div>
                        </div>
                      </div>
                      <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting end</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div class="review-margin-left">#TimeFormat(qGetSightings.endTime, 'HH:nn')#</div>
                        </div>
                      </div>
                      <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Survey ##</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div class="review-margin-left">
						  <cfif qGetSightings.Survey eq 'On'>ON<cfelseif qGetSightings.Survey eq 'Off'>OFF</cfif></div>
                        </div>
                      </div>
                      
                     <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Begin ICW Marker</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div class="review-margin-left">#qGetSightings.ICW_Begin#</div>
                        </div>
                      </div>
                      
                      
                    </div>
                    <div class="check-box-inline">
                      
                    </div>
                  </div>
                </div>
                <div class="row col-lg-2 col-md-4 col-sm-12 col-xs-12">
                  <div class="inline-boxes">
                
                    <div class="form-group">
                      <label>Location</label>
                      <div>#qGetSightings.Location#</div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-12 col-xs-12">
                  <div class="inline-boxes">
                    <div class="box-inline second">
                    
						<div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Zone</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div class="review-margin-left">#qGetSightings.zone#</div>
                        </div>
                      </div>
                      
                      <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Easting</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div>#qGetSightings.Easting_X#</div>
                        </div>
                      </div>
                      
                       <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Northing</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                         <div>#qGetSightings.Northing_Y#</div>
                        </div>
                      </div>
                      
                      
                      <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Begin Lattitude</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div>#qGetSightings.Begin_LAT_Dec#</div>
                        </div>
                      </div>
                      
                      <div class="form-group next-check">
                        <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Begin Longitude</label>
                        <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                          <div>#qGetSightings.Begin_LON_Dec#</div>
                        </div>
                      </div>
                      
                      
                    </div>
                  </div>
                </div>
                
                <div class="srow col-lg-1 col-md-1 col-sm-12 col-xs-12">
                <cfif  qGetSightings.analyzed eq 1>
                <button type="button" class="btn btn-danger">Analyzed Completed</button>
                </cfif>
                </div>
                
              </div>
            </div>
          </div>
          
			<div class="label-box-holder">
          	<!------ Takes ----->
          </div>
          
 
        <div class="row">
        
          <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12 condition-box">
            <div class="inner-border-box">
                <label>Condition</label>
              <div class="form-group">
                <div class="radio-inline left">
                  
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">Wave Height</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div>
                      <cfloop query="getWaveHeight">
                          <cfif qGetSightings.WaveHeight eq getWaveHeight.id>#getWaveHeight.Desc#</cfif>
                        </cfloop>
                        </div>
                    </div>
                  </div>
                 
                 <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">Weather</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div>
                      <cfloop query="getWeather">
                       <cfif qGetSightings.Weather eq getWeather.id>#getWeather.Desc#</cfif>
                        </cfloop>
                      </div>
                    </div>
                  </div>
               <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">Glare</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div> <cfloop query="getGlare">
                         <cfif qGetSightings.Glare eq getGlare.id>#getGlare.Desc#</cfif>
                        </cfloop></div>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">Sightability</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                     	<div>
                        <cfloop query="getSightability">
                       <cfif qGetSightings.Sightability eq getSightability.id>#getSightability.Desc#</cfif>
                        </cfloop>
                        </div>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">Beaufort</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                     	<div>
                        <cfloop query="qGetBeaufort">
                    <cfif qGetSightings.Beaufort eq qGetBeaufort.id>#qGetBeaufort.Desc#</cfif>
                        </cfloop>
                        </div>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">Water Temp</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div>#qGetSightings.WaterTemp#</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">Heading</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div>#qGetSightings.heading#</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">## of Boats</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div>#qGetSightings.NumberOfBoats#</div>
                    </div>
                  </div>
                </div>
                <div class="radio-inline right"  style="vertical-align: top;">
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">AssocBio 1</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div>
                       <cfloop query="qGetAssocBioData">
                        <cfif qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData1>#qGetAssocBioData.ASSOCBIONAME#</cfif>
                        </cfloop>
                        
                        </div>
                       
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">AssocBio 2</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                     <div>
                     <cfloop query="qGetAssocBioData">
                        <cfif qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData2>#qGetAssocBioData.ASSOCBIONAME#</cfif>
                        </cfloop>
                       </div>
                      </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">AssocBio 3</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                     <div>
                     <cfloop query="qGetAssocBioData">
                        <cfif qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData3>#qGetAssocBioData.ASSOCBIONAME#</cfif>
                        </cfloop>
                       
                     </div>
                    
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">## Takes</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div>#qGetSightings.Takes#</div>
                    </div>
                  </div>
                </div>
              </div>
              
            </div>
          </div>
          <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 estimates-box">
            <div class="inner-border-box">
              <label>Fields Estimates</label>
              <div class="form-group">
                <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"></label>
                <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                  <div class="box_01">
                    <p><i>MIN</i></p>
                  </div>
                  <div class="box_01">
                    <p><i>MAX</i></p>
                  </div>
                  <div class="box_01">
                    <p><i>BEST</i></p>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"> Total Dolphin</label>
                  <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_TotalDolphin_Min#</div>
                    </div>
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_TotalDolphin_Max#</div>
                    </div>
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_TotalDolphin_Best#</div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"> Total Calves</label>
                  <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_TotalCalves_Min#</div>
                    </div>
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_TotalCalves_Max#</div>
                    </div>
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_TotalCalves_Best#</div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Young of The Year</label>
                  <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_YoungOfYear_Min#</div>
                    </div>
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_YoungOfYear_Max#</div>
                    </div>
                    <div class="box_01">
                      <div class="field-estimate-values">#qGetSightings.FE_YoungOfYear_Best#</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 estimates-box second">
            <div class="inner-border-box">
              <label>Activity</label>
              <div class="form-group" style="margin-top:-40px">
                <div class="inline-box col-lg-12 col-md-12 col-sm-12 input-box">
                  <div class="box_01"> Mill (1)
                   <div class="field-estimate-values">#qGetSightings.Activity_Mill#</div>
                  </div>
                  <div class="box_01"> Feed (2)
                   <div class="field-estimate-values">#qGetSightings.Activity_Feed#</div>
                  </div>
                  <div class="box_01"> Prob. Feed (3)
                  <div class="field-estimate-values">#qGetSightings.Activity_ProbFeed#</div>
                  </div>
                  <div class="box_01"> Travel (4)
                  <div class="field-estimate-values">#qGetSightings.Activity_Travel#</div>
                  </div>
                  <div class="box_01"> Play (5)
                  <div class="field-estimate-values">#qGetSightings.Activity_Play#</div>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <div class="inline-box col-lg-12 col-md-12 col-sm-12 input-box">
                  <div class="box_01"> Rest (6)
                  <div class="field-estimate-values">#qGetSightings.Activity_Rest#</div>
                  </div>
                  <div class="box_01"> Leap (7)
 	 			  <div class="field-estimate-values">#qGetSightings.Activity_Leap_tailslap_chuff#</div>              
                  </div>
                  <div class="box_01"> Social (8)
				  <div class="field-estimate-values">#qGetSightings.Activity_Social#</div>
                  </div>
                  <div class="box_01"> Boat (9)
                  <div class="field-estimate-values">#qGetSightings.Activity_WithBoat#</div>
                  </div>
                  <div class="box_01"> Other (10)
                  <div class="field-estimate-values">#qGetSightings.Activity_Other#</div>
                  </div>
                
                <div class="box_01"> Avoid Boat
                <div class="field-estimate-values">#qGetSightings.Activity_Avoid_Boat#</div>
                    
                  </div>
                  
                   <div class="box_01"> Depre dation
                <div class="field-estimate-values">#qGetSightings.Depredation#</div>
                    
                  </div>
                   <div class="box_01"> Herding
                <div class="field-estimate-values">#qGetSightings.Herding#</div>
                    
                  </div>
                  
                </div>
              </div>
              
            </div>
          </div>
        </div>
        
        <div class="sighting-review-bottom">
            <div class="row  m-b-10">
                  <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6">
                    <div class="input-group m-b-15">
                      <div class="input-group-btn">
                        <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Camera</label>
                      </div>
                      <div class="review-margin-left">#qGetCamera.Camera_Name#</div>
                    </div>
                  </div>
                  
                  <div class="row col-lg-3 col-md-3 col-sm-3 col-xs-6">
                    <div class="input-group m-b-15">
                      <div class="input-group-btn">
                        <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Lens</label>
                        
                      </div>
                      <div class="review-margin-left">#qGetCamera.Lens_Name#</div>
                    </div>
                  </div>
                  
                        <cfparam name='getPhotographer' default="">
                  
                  <cfloop query="getTeams">
                  <cfif getTeams.RT_ID EQ qGetSightings.Driver>
                  <cfset getPhotographer=getTeams.RT_MemberName>
                  </cfif>
                  </cfloop>
                 <div class="row col-lg-3 col-md-3 col-sm-3 col-xs-6">
                    <div class="input-group m-b-15">
                      <div class="input-group-btn">
                        <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Photographer</label>
                        
                      </div>
                      <div class="review-margin-left">#getPhotographer#</div>
                    </div>
                  </div>
                  
                  
                   <cfparam name='getDriver' default="">
                  <cfloop query="getTeams">
                  <cfif getTeams.RT_ID EQ qGetSightings.Driver>
                  <cfset getDriver=getTeams.RT_MemberName>
                  </cfif>
                  </cfloop>
                  
                  <div class="row col-lg-3 col-md-3 col-sm-3 col-xs-6">
                    <div class="input-group m-b-15">
                      <div class="input-group-btn">
                        <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Driver</label>
                        
                      </div>
                      <div class="review-margin-left">#getDriver#</div>
                    </div>
                  </div>
                  
            </div>
            
            <div class="row">
            	<div class="col-md-12">
               <label class="control-label">  Comments:</label>
              		<div class="form-group image-box main">
                      <div>#qGetSightings.Notes#</div>
                    </div>
                </div>
            </div>
            
   
            <div class="input-group m-b-15">
   <cfif isdefined('form.sight_id') and form.sight_id neq 0> 
    
     <div class="row">  
     <form   action="" enctype="multipart/form-data" method="post">         
     <input type="hidden" value="1" name="analyzed" />
     <input type="hidden" name="sight_id" value="#qGetSightings.ID#">
	<input type="hidden" name="project_id" value="#form.PROJECT_ID#">
	<input type="submit" class="btn btn-primary  m-t-10" name="submit"  value="Analyzed" />
          </form>
       </div>      
	 </cfif>  

    </div>
    <!-- end row --> 
  </div>
</div>
<!------------- Dscor Submit ------------->
</cfoutput>
<!-- ================== END PAGE LEVEL JS ================== --> 

