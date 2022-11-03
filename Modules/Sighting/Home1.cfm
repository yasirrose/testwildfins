<style>
.survey-info-holder .team-box {
  width: 39.2% !important;
}
.main-form-section .date-pick-box {
    width: 60% !important;
}
.main-form-section .form-group.completed-by {
	display: flex;
	align-content: center;
	white-space: nowrap;
	max-width: 250px;
	margin: 6px 0px 10px auto !important;
}
.main-form-section .form-group.completed-by strong {
	line-height: 33px;
	padding-right: 10px;
}
</style>
<cfoutput>
  <cfif isdefined('form.sight_delete') and form.sight_delete EQ 1>
    <cfset SightDelete=Application.SightingNew.sight_delete(argumentCollection="#Form#")>
    <cfset message="Sighting Deleted.">
  </cfif>
  
  <!----
--
--		Update Query
--
                           --->
  
  <cfif isdefined('form.update_data') or isdefined('form.update_data_clear') or isdefined('form.update_data_clear_pro') or isdefined('form.update_data_pro')>
    <cfset dummydate="1899-12-30 ">
    <cfset StartTime=dummydate & StartTime>
    <cfset EndTime=dummydate & EndTime >
    <cfset SurveyStart=dummydate & SurveyStart>
    <cfset SurveyEnd=dummydate & SurveyEnd>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif StartTime gt EndTime>
      <cfset error="Dock Start time must be less than Dock End Time">
      <cfelseif SurveyStart gt SurveyEnd>
      <cfset error="Survey Start time must be less than Survey End Time">
      <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
      <cfelse>
      <!--- Update sighting if this defined--->
      <cfif isdefined('form.update_data') or isdefined('form.update_data_clear')>
        <cfset qUpdateProject_SIGHT=Application.SightingNew.qUpdateProject_SIGHT(argumentCollection="#Form#")>
        <cfset updatecameralens=Application.SightingNew.updatecameralens(argumentCollection="#Form#")>
      </cfif>
      <cfset qUpdateProject=Application.SightingNew.qUpdateProject(argumentCollection="#Form#")>
      <cfset updateteammember=Application.SightingNew.updateteammember(argumentCollection="#Form#")>
      <cfset success = 2>
    </cfif>
  </cfif>
  <!----
--
--	 Insert Query
--
                           --->
  <cfif isdefined('form.add_data') or isdefined("form.add_data_clear")>
    
    <!---- last sight ID------>
    <cfset qInsertid = Application.SightingNew.qInsertid()>
    <cfset dummydate="1899-12-30 ">
    <cfset StartTime=dummydate & StartTime>
    <cfset EndTime=dummydate & EndTime >
    <cfset SurveyStart=dummydate & SurveyStart>
    <cfset SurveyEnd=dummydate & SurveyEnd>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif StartTime gt EndTime>
      <cfset error="Dock Start time must be less than Dock End Time">
      <cfelseif SurveyStart gt SurveyEnd>
      <cfset error="Survey Start time must be less than Survey End Time">
      <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
      <cfelse>
      <cfset project_id = qInsertid.id + 1>
      <cfset qInsertProject = Application.SightingNew.qInsertProject(argumentCollection="#Form#")>
      <cftry>
        <cfif isdefined("form.add_data_withSight")>
          <!---- Insert sight ID------>
          <cfset qInsertProject = Application.SightingNew.InsertSight(argumentCollection="#Form#")>
          <!---- last sight ID------>
          <cfset lastsight_id = Application.SightingNew.qInsertids()>
          <!---- photo roool------->
          <cfset qPHOTO_ROLLS = Application.SightingNew.qPHOTO_ROLLS()>
          <!---- camera lens insert------->
          <cfset camera_lensinsert = Application.SightingNew.camera_lensinsert(argumentCollection="#Form#")>
        </cfif>
        
        <!----- Team member----------------->
        <cfif qInsertProject.RECORDCOUNT eq 1 >
        <cfset Insertteammember=Application.SightingNew.Insertteammember(argumentCollection="#Form#")>
          <cfset success = 1>
          <cfset form.PROJECT_ID=project_id>
        </cfif>
        <!--------  image upload rename/extention changing .direcrtory create.image delete ----------------->
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
  <cfif isdefined('form.add_sighting') or isdefined('form.add_sighting_clear')>
    <cfset dummydate="1899-12-30 ">
    <cfset StartTime=dummydate & StartTime>
    <cfset EndTime=dummydate & EndTime >
    <cfset SurveyStart=dummydate & SurveyStart>
    <cfset SurveyEnd=dummydate & SurveyEnd>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif StartTime gt EndTime>
      <cfset error="Dock Start time must be less than Dock End Time">
      <cfelseif SurveyStart gt SurveyEnd>
      <cfset error="Survey Start time must be less than Survey End Time">
      <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
      <cfelse>
      <cfset qUpdateProject=Application.SightingNew.qUpdateProject(argumentCollection="#Form#")>
      <cfset qInsertsigting = Application.SightingNew.InsertSight(argumentCollection="#Form#")>
      
      <!---- last sight ID------>
      <cfset lastsight_id = Application.SightingNew.qInsertids()>
      
      <!---- camera lens insert------->
      <cfset camera_lensinsert = Application.SightingNew.camera_lensinsert(argumentCollection="#Form#")>
      <cfif qInsertsigting.RECORDCOUNT eq 1 >
        <cfset message ="Sighting Added">
      </cfif>
      <!--------  image upload rename/extention changing .direcrtory create.image delete ----------------->
    </cfif>
    <!-- time if end -->
  </cfif>
  <cfparam name="form.PROJECT_ID" default="0">
  <cfif isdefined('form.update_data_clear') OR isdefined('form.update_data_clear_pro') or isdefined('add_data_clear')>
    <cfset form.PROJECT_ID = 0>
  </cfif>
  
  <!----
    <cfif isdefined('form.add_sighting_clear')>
      <cfset form.PROJECT_ID = lastsight_id>
    </cfif>
 -------> 
  
  <!----
--
--		Select Query
--
                          --->
  <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq ''>
    <!----- Projects------->
    <cfset qProjects=Application.SightingNew.qProjects(argumentCollection="#Form#")>
    <cfelse>
    <cfset qProjects=Application.SightingNew.qProject_ten()>
  </cfif>
  
  <!---- Sight Detail--->
  <cfparam name="form.sight_id" default="0">
  
  <!----- add sighting & retain---->
  <cfif isdefined('form.add_sighting')>
    <cfset lastsight_id = Application.SightingNew.qInsertids()>
    <cfset form.sight_id = lastsight_id.ids>
  </cfif>
  <cfset qGetSightings=Application.SightingNew.qSightningDetails(argumentCollection="#Form#")>
  <!---- get Sighting List--->
  <cfset getsightinglist=Application.SightingNew.getsightinglist(argumentCollection="#Form#")>
  
  <!--- Camera And Lens --->
  <cfset qGetCamera=Application.SightingNew.qGetCameralens()>
  <cfset cameras = ValueList(qGetCamera.Camera_Name,",")>
  <cfset cameras_ids = ValueList(qGetCamera.camera_ID,",")>
  <cfset lens = ValueList(qGetCamera.Lens_Name,",")>
  
  <!--- Camera And Lens ---> 
  
  <!--- Conditions --->
  
  <cfset qGetWave=Application.SightingNew.qGetWave()>
  <cfset qGetWave=Application.SightingNew.qGetWeather()>
  
  <!--- Conditions ---> 
  
  <!--- Extracting Survey area --->
  <cfset getSurveyArea=Application.SightingNew.getSurveyArea()>
  <cfset getType=Application.StaticDataNew.getType()>
  <cfset getSubType=Application.SightingNew.getSubType()>
  <!---<cfset getSurvey=Application.SightingNew.getSurvey()>---> 
  <cfset getSurvey=Application.StaticDataNew.getPlateForm()>

  
  <!---
<cfset qGetSightings=Application.SightingNew.qGetSightings(argumentCollection="#Form#")>
---->

  
  <!------ Lens list----------------->
  <cfset lenslist = Application.SightingNew.getLens()>
  
  <!---------- Camera list------------>
  <cfset cameralist = Application.SightingNew.getCamera()>
  <cfset TideList = Application.SightingNew.getTide()>
  <cfset StructureList = Application.SightingNew.getStructureList()>
  <cfset getHabitatList = Application.SightingNew.getHabitat()>
  <!------- Project list--------->
  <cfset qProjectsId = Application.SightingNew.qProjectsId()>
  
  <!------- Stock list--------->
  <cfset getStock = Application.StaticDataNew.getStock()>
  
  <!------- Funding Source list--------->
  <cfset getFundingSource = Application.SightingNew.getFundingSource()>
  
  <!------- Conditions list--------->
  <cfset getWaveHeight = Application.SightingNew.getWaveHeight()>
  <cfset getWeather = Application.SightingNew.getWeather()>
  <cfset getGlare = Application.SightingNew.getGlare()>
  <cfset qGetBeaufort=Application.SightingNew.qGetBeaufort()>

  <cfset qGetAssocBioData=Application.SightingNew.qGetAssocBioData()>
  <cfset getSelectedAssocBio = Application.SightingNew.getSelectedAssocBio(argumentCollection="#Form#")>
  <cfset getAssocBios = ValueList(getSelectedAssocBio.ASSOCBIOID,",")>
  

  <cfset qGetHeadingData=Application.StaticDataNew.getHeading()>
  <cfset getGlareDirection = Application.StaticDataNew.getGlareDirection()>

  <cfset getBehaviors = Application.StaticDataNew.getBehavior()>
  <cfset getPreySpecies = Application.StaticDataNew.getPreySpecies()>

  <cfset getTeams=Application.SightingNew.getTeams()>
  <cfset getselectmember = Application.SightingNew.getselectmember(argumentCollection="#Form#")>
  <cfset getteammember = ValueList(getselectmember.RT_ID,",")>
 

  <cfset getSightability = Application.SightingNew.getSightability()>
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
      <div class="alert alert-success"> <strong>Success!</strong> Project id #project_id# Inserted Successfully </div>
    </cfif>
    <cfif isdefined('success') and success eq 2 >
      <div class="alert alert-success"> <strong>Success!</strong> Project  record updated. </div>
    </cfif>
    <cfif isdefined('error')>
      <div class="alert alert-danger"> <strong>Alert!</strong> #error# </div>
    </cfif>
    <cfif isdefined('message')>
      <div class="alert alert-success"> <strong>Success!</strong> #message# </div>
    </cfif>
    
    <!-- end page-header -->
    <div class="section-container section-with-top-border sighting-project-holder p-b-10"> 
      <!-- begin row -->
      <div class="main-form-section">
        <div class="row m-b-10">
          <div class="col-md-3">
            <div class="form-group">
              <form id="myform" action="" method="post" >
                <label for="sel1">Select Survey:</label>
                <select class="form-control search-box" id="project_val" onChange="sendForm()" name="project_id">
                  <option value="0">Add New Survey</option>
                  <cfloop query="qProjectsId">
                    <option value="#qProjectsId.id#" <cfif isdefined('form.project_id') and form.project_id eq qProjectsId.id>selected</cfif>>#qProjectsId.id#</option>
                  </cfloop>
                </select>
              </form>
            </div>
          </div>
          <div class="col-md-3">
            <div class="form-group">
              <form  action="" method="post" >
                <label for="sel1">Search Survey By Date:</label>
                <select class="form-control search-box"  onchange="this.form.submit()" name="project_id">
                  <option value="0">Add New Survey</option>
                  <cfloop query="qProjectsId">
                    <option value="#qProjectsId.id#"
                       <cfif isdefined('form.project_id') and form.project_id eq qProjectsId.id>selected</cfif>> #DateTimeFormat(qProjectsId.Date,'MM/dd/YYYY')#</option>
                  </cfloop>
                </select>
              </form>
            </div>
          </div>
          <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>
            <div class="col-md-3">
              <form method="post"  id="sightform">
                <label for="sel1">Select Sighting: </label>
                <select name="sight_id" onchange="submitsightForm()" id="sightid" class="form-control search-box">
                  <option value="0">Add New Sighting</option>
                  <!---<cfset r=getsightinglist.recordcount>--->
                  <cfloop query="getsightinglist">
                    <option value="#getsightinglist.ID#" <cfif getsightinglist.ID EQ  qGetSightings.ID> selected</cfif>><cfif getsightinglist.SIGHTINGNUMBER NEQ ''>#getsightinglist.SIGHTINGNUMBER# - </cfif>#getsightinglist.ID#</option>
                    <!---<cfset r=r-1>--->
                  </cfloop>
                </select>
                <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
              </form>
            </div>
          </cfif>
          <div class="col-md-3 reset-btn">
            <input type="button" name="reset" id="reset" class="btn btn-default" value="Reset" onClick="ResetAll()"/>
            <a href="#Application.superadmin#?Module=Sighting&Page=Home">
            <input type="button"  value="New" class="btn btn-default">
            </a>
            <cfif isdefined('form.sight_id') and form.sight_id GT 0>
              <input type="button" value="Clear" onclick="sendForm()" class="btn btn-success">
            </cfif>
          </div>
        </div>
        <form class="main-sighting-form" name="ResetMe" id="ResetMe" action="" enctype="multipart/form-data" method="post">
          <div class="row clearfix survey-info-holder">
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 date-pick-box">
              <div class="inner-border-box">
                <div class="box-inline">
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Date</label>
                    <div id="datetimepicker1" class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12">
                      <input type="text"  value='#DateTimeFormat(qProjects.Date, "MM/dd/YYYY")#' name="Date_p"  placeholder="mm/dd/yyyy" class="form-control"  >
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label m-b-10">Engine On</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12 m-b-10" id="datetimepicker_enginestart">
                      <input type="text" value="#TimeFormat(qProjects.EngineOn, "HH:nn")#" placeholder="hh:mm" name="EngineOn" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Survey Start</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_srvystrt">
                      <input type="text" value="#TimeFormat(qProjects.SurveyStart, "HH:nn")#"  placeholder="hh:mm" name="SurveyStart" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                </div>
                <div class="box-inline second"> 
                  <div class="form-group next-check">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Engine Off</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_engineoff">
                      <input type="text" value="#TimeFormat(qProjects.EngineOff, "HH:nn")#" placeholder="hh:mm" name="EngineOff" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Survey End</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_srvyend">
                      <input type="text" value="#TimeFormat(qProjects.SurveyEnd, "HH:nn")#"  placeholder="hh:mm" name="SurveyEnd"class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="col-md-4"></div>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-8 col-xs-12 team-box">
              <div class="inner-border-box" style="min-height:235px" >
                <div class="form-group first-tab">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Team</button>
                    </div>
                    <select class="form-control search-box" multiple="multiple" name="ResearchTeam">
                      <cfloop query="getTeams">
                        <cfif active eq 1 or (active eq 0 and ListFind(getteammember,getTeams.RT_ID))>
                        <option value="#getTeams.RT_ID#" <cfif ListFind(getteammember,getTeams.RT_ID)>selected</cfif> >#getTeams.RT_MemberName#</option>
                      	</cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>

                 <div class="form-group first-tab">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Survey Route</button>
                    </div>
                      <input type="text" value="" placeholder="Survey Route" name="SurveyRoute"class="form-control" />
                  </div>
                </div>

                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Platform</button>
                    </div>
                    <select class="combobox form-control" name="Platform" id="plateform_value">
                      <option value="">Select Platform</option>
                      <cfloop query="getSurvey">
                        <cfif active eq 1 OR (active eq 0 and qProjects.Platform eq getSurvey.Name)>
                        	<option class="plateform_value" value="#getSurvey.id#" <cfif <!---getselectmember.PLATFORM_ID EQ getSurvey.id---> qProjects.Platform EQ getSurvey.Name>selected</cfif>>#getSurvey.Name#</option>
                        </cfif>    
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">NOAA Stock</button>
                    </div>
                    <select class="combobox form-control" name="Stock"  id="stock_value">
                      <option value="">Select NOAA Stock</option>
                      <cfloop query="getStock">
                        <cfif active eq 1 OR (active eq 0 and qProjects.Stock eq getStock.StockName)>
                        	<option class="stock_value" value="#getStock.StockName#" <cfif qProjects.Stock EQ getStock.StockName>selected</cfif>>#getStock.StockName#</option>
                        </cfif>    
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div  id="body-of-water-sec">
                  <div class="form-group">
                    <div class="input-group">
                      <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">Body of Water</button>
                      </div>
                      <select class="combobox form-control surveyArea_default" name="BodyOfWater[]"  id="area_value">
                        <option value="">Select Area</option>
                        <cfloop query="getSurveyArea">
                          <cfif active eq 1 OR (active eq 0 and qProjects.BodyOfWater eq getSurveyArea.AreaName)>
                          	<option class="area_value" value="#getSurveyArea.AreaName#" data-stock="#getSurveyArea.StockName#" <cfif qProjects.BodyOfWater EQ getSurveyArea.AreaName>selected</cfif>>#getSurveyArea.AreaName#</option>
                          </cfif>
                        </cfloop>
                      </select>
                      <a href="javascript:void(0);" id="AddBodyOfWater">+</a> </div>
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Survey Type</button>
                    </div>
                    <select class="combobox form-control" name="Type" id="Type" >
                      <option value="">Select Survey Type</option>
                      <cfloop query="getType">
                        <cfif active eq 1 OR (active eq 0 and qProjects.SurveyType eq getType.Type)>
                        	<option class="area_value" value="#getType.Type#" <cfif qProjects.SurveyType EQ getType.Type>selected</cfif>>#getType.Type#</option>
                        </cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row m-t-10">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12  location">
              <div class="inner-border-box">
                <div class="row sighting_section">
                  <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                    <div class="inline-boxes">
                      <div class="box-inline second">
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Survey Effort</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <div class="checkbox-new">
                              <input type="radio" name="Survey" id="rememberMe" class="float-left"  value="On" <cfif qGetSightings.Survey eq 'On'>checked</cfif> >
                              <label class="float-left font_size_14" for="rememberMe">ON</label>
                            </div>
                            <div class="checkbox-new">
                              <input type="radio" name="Survey" value="Off"  id="rememberMe1" class="float-left" <cfif qGetSightings.Survey eq 'Off'>checked</cfif> >
                              <label class="float-left font_size_14" for="rememberMe">OFF</label>
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting No</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.SightingNumber#"  name="SightingNumber" class="form-control"/>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting Start</label>
                          <div class="input-group date col-lg-7 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_sightingstrt">
                            <input type="text" value="#TimeFormat(qGetSightings.StartTime, 'HH:nn')#"  placeholder="hh:mm" name="Sightingstart"class="form-control"  />
                            <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                        </div>
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting end</label>
                          <div class="input-group date col-lg-7 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_sightingend">
                            <input type="text" value="#TimeFormat(qGetSightings.endTime, 'HH:nn')#"  placeholder="hh:mm" name="Sightingend" class="form-control"  />
                            <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                        </div>
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">At ICW Marker</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.ICW_Start#"  name="ICW_Start" class="form-control"/>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <div class="inline-boxes">
                      <div class="form-group">
                        <label>Location</label>
                        <textarea class="form-control" name="Location" maxlength="75">#qGetSightings.Location#</textarea>
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="inline-boxes">
                      <div class="box-inline second">
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Initial Lattitude</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.InitialLatitude#"  name="InitialLatitude" id="InitialLatitude" class="form-control bg-color" />
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Initial Longitude</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.InitialLongitude#"  name="InitialLongitude" id="InitialLongitude" class="form-control bg-color"/>
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">At Lattitude</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.InitialLatitude#"  name="InitialLatitude" id="InitialLatitude" class="form-control bg-color" />
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">At Longitude</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.InitialLongitude#"  name="InitialLongitude" id="InitialLongitude" class="form-control bg-color"/>
                          </div>
                        </div>
                        
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">End Lattitude</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.InitialLatitude#"  name="InitialLatitude" id="InitialLatitude" class="form-control bg-color" />
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">End Longitude</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.InitialLongitude#"  name="InitialLongitude" id="InitialLongitude" class="form-control bg-color"/>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="label-box-holder"> 
              <!------ Takes -----> 
            </div>
          </div>
          <div class="row">
            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12 condition-box">
              <div class="inner-border-box">
                <label>Condition</label>
                <div class="form-group">
                  <div class="radio-inline left">
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Wave Height</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control"  name="WaveHeight" >
                          <option value=""></option>
                          <cfset inc=0>
                          <cfloop query="getWaveHeight">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.WaveHeight eq getWaveHeight.id)>
                            	<option value="#getWaveHeight.id#" <cfif qGetSightings.WaveHeight eq getWaveHeight.id>selected</cfif>>#inc# &nbsp;&nbsp;&nbsp; #getWaveHeight.Desc# </option>
                            	<cfset inc=inc+1>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Weather</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control"  name="Weather" >
                          <option value=""></option>
                          <cfset inc=0>
                          <cfloop query="getWeather">
                             <cfif active eq 1 OR (active eq 0 and qGetSightings.Weather eq getWeather.id)>
                                <option value="#getWeather.id#"<cfif qGetSightings.Weather eq getWeather.id>selected</cfif>>#inc# &nbsp;&nbsp;&nbsp; #getWeather.Desc# </option>
                            	<cfset inc=inc+1>
                          	 </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Glare</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control"  name="Glare" >
                          <option value=""></option>
                          <cfset inc=0>
                          <cfloop query="getGlare">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.Glare eq getGlare.id)>
                            	<option value="#getGlare.id#" <cfif qGetSightings.Glare eq getGlare.id>selected</cfif>>#inc# &nbsp;&nbsp;&nbsp; #getGlare.Desc# </option>
                            	<cfset inc=inc+1>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Glare Direction</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control"  name="Glare" >
                          <option value=""></option>
                          <cfset inc=0>
                          <cfloop query="getGlareDirection">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.Glare eq getGlareDirection.id)>
                            	<option value="#getGlareDirection.id#" <cfif qGetSightings.Glare eq getGlareDirection.id>selected</cfif>>#inc# &nbsp;&nbsp;&nbsp; #getGlareDirection.Desc# </option>
                            	<cfset inc=inc+1>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Sightability</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control"  name="Sightability" >
                          <option value=""></option>
                          <cfset inc=0>
                          <cfloop query="getSightability">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.Sightability eq getSightability.id)>
                            	<option value="#getSightability.id#" <cfif qGetSightings.Sightability eq getSightability.id>selected</cfif>>#inc# &nbsp;&nbsp;&nbsp; #getSightability.Desc# </option>
                            	<cfset inc=inc+1>
                            </cfif>    
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Beaufort</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control" id="value" name="Beaufort" >
                          <option value=""></option>
                          <cfset inc=0>
                          <cfloop query="qGetBeaufort">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.Beaufort eq qGetBeaufort.id)>
                                <option value="#qGetBeaufort.id#" <cfif qGetSightings.Beaufort eq qGetBeaufort.id>selected</cfif>>#inc# &nbsp;&nbsp;&nbsp; #qGetBeaufort.Desc# </option>
                                <cfset inc=inc+1>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Habitat Depth</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                          <input type="text" value="#qGetSightings.HabitatDepth#" name="HabitatDepth"  class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Habitat Type</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.HabitatType#" name="HabitatType"  class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Air Temp</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.AirTemp#" name="AirTemp"  class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Water Temp</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp"  class="form-control" />
                      </div>
                    </div>
                  </div>
                  <div class="radio-inline right">
                   <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Wind Speed</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp"  class="form-control"  />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Wind Direction</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp"  class="form-control"  />
                      </div>
                    </div>
                  <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Tide</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control" id="value" name="Heading">
                          <option value=""></option>
                          <option value="High">High</option>
                          <option value="Low">Low</option>
                        </select>
                      </div>
                    </div>
                     <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Salinity</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.Salinity#" name="Salinity"  class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Initial Heading</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                       <select class="form-control" id="value" name="InitialHeading" >
                          <option value="0"></option>
                          <cfloop query="qGetHeadingData">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.InitialHeading eq qGetHeadingData.id)>
                                <option value="#qGetHeadingData.id#" <cfif qGetSightings.InitialHeading eq qGetHeadingData.id>selected</cfif>> #qGetHeadingData.HeadingName# </option>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">General Heading</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control" id="value" name="GeneralHeading" >
                          <option value="0"></option>
                          <cfloop query="qGetHeadingData">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.GeneralHeading eq qGetHeadingData.id)>
                                <option value="#qGetHeadingData.id#" <cfif qGetSightings.GeneralHeading eq qGetHeadingData.id>selected</cfif>> #qGetHeadingData.HeadingName# </option>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Final Heading</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                       <select class="form-control" id="value" name="FinalHeading" >
                          <option value="0"></option>
                          <cfloop query="qGetHeadingData">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.FinalHeading eq qGetHeadingData.id)>
                                <option value="#qGetHeadingData.id#" <cfif qGetSightings.FinalHeading eq qGetHeadingData.id>selected</cfif>> #qGetHeadingData.HeadingName# </option>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                  </div>
                   <div class="input-group">
                      <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">Assoc Bio</button>
                      </div>
                      <select class="form-control search-box" multiple="multiple" name="AssocBio">
                        <cfloop query="qGetAssocBioData">
                         <cfif active eq 1 OR (active eq 0 and qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBio)>
                          <option value="#qGetAssocBioData.ASSOCBIOID#" <cfif ListFind(getteammember,qGetAssocBioData.ASSOCBIOID)>selected</cfif> >#qGetAssocBioData.ASSOCBIONAME#</option>
                          </cfif>
                        </cfloop>
                      </select>
                    </div>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 estimates-box">
              <div class="inner-border-box">
                <label>Field Estimates</label>
                <div class="form-group">
                  <div class="form-group">
                        <label class="col-lg-5 col-md-5 col-sm-12 control-label">Species</label>
                        <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                          <input type="text" value="Tursiops truncates"  name="WaterTemp"  class="form-control" />
                        </div>
                    </div>
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
                      <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"> Total Cetaceans </label>
                      <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCetaceans_Min#" name="FE_Total_Cetaceans_MIN" class="form-control"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCetaceans_Max#" name="FE_Total_Cetaceans_MAX" class="form-control"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCetacean_Best#" name="FE_Total_Cetacean_Best" class="form-control"  />
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"> Total Calves</label>
                      <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCalves_Min#" name="FE_TotalCalves_Min" class="form-control"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCalves_Max#" name="FE_TotalCalves_Max" class="form-control"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCalves_Best#" name="FE_TotalCalves_Best" class="form-control"  />
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Young of The Year</label>
                      <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_YoungOfYear_Min#" name="FE_YoungOfYear_Min" class="form-control"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_YoungOfYear_Max#" name="FE_YoungOfYear_Max" class="form-control"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_YoungOfYear_Best#" name="FE_YoungOfYear_Best" class="form-control"  />
                        </div>
                      </div>
                    </div>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 estimates-box second">
              <div class="inner-border-box">
                <label>Activity</label>
                <div class="form-group activity-top-40">
                  <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 input-box">
                      <div class="box_02"> Mill
                        <select class="form-control select_activity"  id="value0" name="Act_Mill">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Mill eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Feed
                        <select class="form-control select_activity"  id="value1" name="Act_Feed">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Feed eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Prob. Feed
                        <select class="form-control select_activity"  id="value2" name="Act_Prob_Feed">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Prob_Feed eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Travel
                        <select class="form-control select_activity"  id="value3" name="Act_Travel">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Travel eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02">Object Play
                        <select class="form-control select_activity"  id="value4" name="Act_Object_Play">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Object_Play eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Rest
                        <select class="form-control select_activity"  id="value5" name="ACTIVITY_REST">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Rest eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Social
                        <select class="form-control select_activity"  id="value7" name="Act_Social">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Social eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> w/boat
                        <select class="form-control select_activity"  id="value8" name="Act_With_Boat">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_With_Boat eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Avoid Boat
                        <select class="form-control select_activity"  id="value10" name="Act_Avoid_Boat">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Avoid_Boat eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Other
                        <select class="form-control select_activity"  id="value9" name="Act_Other">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Other eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <style >
        .chk-box-wrap {
            padding: 10px 20px 0 5px;
        }
          .chk-box-wrap input{
            position: relative;
            top: 5px;
          }
        </style>
            <div class="row">
              <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 condition-box">
                  <div class="inner-border-box">
                    <label>Behavioral Events</label><br><br>
                    <div class="input-group">
                      <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">Behaviors</button>
                      </div>
                      <select class="form-control search-box" multiple="multiple" name="BehaviorName">
                        <cfloop query="getBehaviors">
                          <option value="#getBehaviors.ID#" <cfif ListFind(getteammember,getBehaviors.ID)>selected</cfif> >#getBehaviors.BehaviorName#</option>
                        </cfloop>
                      </select>
                    </div>
                  </div>
              </div>
              <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 condition-box">
                <div class="inner-border-box">
                  <label>Feeding Ecology</label><br><br>
                    <div class="form-group">
                      <div class="input-group">
                      <div class="input-group-btn">
                        <button class="btn btn-inverse" type="button">Prey Species</button>
                      </div>
                        <select class="form-control search-box" multiple="multiple" name="PreySpeciesName">
                        <cfloop query="getPreySpecies">
                          <option value="#getPreySpecies.ID#" <cfif ListFind(getteammember,getPreySpecies.ID)>selected</cfif> >#getPreySpecies.PreySpeciesName#</option>
                        </cfloop>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-6 control-label"><strong> Feeding Latitude</strong> </label>
                    <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                      <input type="text" value="#qGetSightings.Feeding_Lat#"  name="Feeding_Lat" class="form-control"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-6 control-label"><strong>Feeding Longitude</strong>  </label>
                    <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                      <input type="text" value="#qGetSightings.Feeding_Long#"  name="Feeding_Long" class="form-control"/>
                    </div>
                  </div>
                  <br><br>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-6 control-label"><strong>Structure Present</strong></label>
                    <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                      <select class="form-control" id="value" name="Structure_Present">
                        <option value="0">Select</option>
                        <cfloop query="StructureList">
                          <cfif active eq 1 or (active eq 0 and qGetSightings.Structure_Present eq ID)>
                            <option value="#ID#" <cfif qGetSightings.Structure_Present eq #ID#>selected</cfif>>#Name#</option>
                          </cfif>
                        </cfloop>
                      </select>
                    </div>
                  </div>
              </div>
          </div>
          <br>
          <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 condition-box">
                <div class="inner-border-box">
                  <label>Fisheries Interactions</label><br><br>
                  <div class="form-group">
                    <div class="radio-inline">
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">No. of Cetaceans w/in 100m of Active Fisher</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp"  class="form-control"  />
                      </div>
                    </div>
                      <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 control-label">Cetacean Response to Fisher</label>
                          <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                            <select class="form-control" id="value" name="Heading">
                              <option value=""></option>
                              <option value="Approach">Approach</option>
                              <option value="Neutral">Neutral</option>
                              <option value="Relocate">Relocate</option>
                            </select>
                          </div>
                      </div>
                      <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 control-label">Fisher Response to Cetacean</label>
                          <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                            <select class="form-control" id="value" name="Heading">
                              <option value=""></option>
                              <option value="Relocate" >Relocate</option>
                              <option value="PullInLine">Pull in line</option>
                              <option value="Approach">Approach</option>
                              <option value="NoRespons">No Response</option>
                            </select>
                          </div>
                      </div>
                      <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 control-label">Depredation</label>
                          <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                            <select class="form-control" id="value" name="Heading">
                              <option value=""></option>
                              <option value="High"  >Yes</option>
                              <option value="Low" >No</option>
                            </select>
                          </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 condition-box">
                <div class="inner-border-box">
                  <label>Boating Interactions</label><br><br>
                  <div class="form-group">
                    <div class="radio-inline">
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">No. of Cetaceans w/in 100m of Recreational Vessels</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp"  class="form-control"  />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">No. of Vessels</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp"  class="form-control"  />
                      </div>
                    </div>
                      <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 control-label">Cetacean Response to Vessel</label>
                          <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                            <select class="form-control" id="value" name="Heading">
                              <option value=""></option>
                              <option value="Approach">Approach</option>
                              <option value="Neutral">Neutral</option>
                              <option value="Relocate">Relocate</option>
                            </select>
                          </div>
                      </div>
                      <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 control-label">Vessel Response to Cetacean</label>
                          <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                            <select class="form-control" id="value" name="Heading">
                              <option value=""></option>
                              <option value="Approach">Approach</option>
                              <option value="OutOfGear">Out of Gear</option>
                              <option value="NoRespons">No Response</option>
                               <option value="Other">Other</option>
                            </select>
                          </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 condition-box">
                <div class="inner-border-box">
                  <label>HBOI Vessel Interactions</label><br><br>
                  <div class="form-group">
                    <div class="radio-inline">
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">No. of Cetaceans WIth HBOI vessel</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp"  class="form-control"  />
                      </div>
                    </div>
                      <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 control-label">Reaction to HBOI Vessel</label>
                          <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                            <select class="form-control" id="value" name="Heading">
                              <option value=""></option>
                              <option value="Approach"  >Approach</option>
                              <option value="Neutral" >Neutral</option>
                              <option value="Relocate" >Relocate</option>
                            </select>
                          </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
          </div>
          <br>
          
          <div class="row  m-b-10">
          <!---
            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Camera</button>
                  <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false"> <span class="caret"></span> </button>
                  <ul class="dropdown-menu">
                    <cfloop query="cameralist">
                      <li><a  class="Camera_value" data-id="#cameralist.id#" value="#cameralist.Camera#">#cameralist.id# #cameralist.Camera#</a></li>
                    </cfloop>
                  </ul>
                </div>
                <input type="text" class="form-control" value="#qGetCamera.Camera_Name#" id="Camera_value" name="camera_value" >
                <input type="hidden" class="form-control" value="#qGetCamera.camera_ID#" name="Camera_value_id" id="Camera_value_id"  >
              </div>
            </div>
            --->
             <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Camera</button>
                </div>
                <select class="combobox form-control" id="Lens_value" name="Lens_value">
                  <cfif len(trim(qGetCamera.Camera_Name)) EQ 0>
                    <option value="">Select Camera</option>
                    <cfelse>
                    <option value="#qGetCamera.camera_ID#">#qGetCamera.Camera_Name#</option>
                  </cfif>
                  <cfloop query="cameralist">
                  <cfif active EQ 1>
                      <option  data-id="#cameralist.id#" value="#cameralist.Camera#">#cameralist.Camera#</option>
                    </cfif>
                  </cfloop>
                </select>
              </div>
            </div>

           <!---
            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Lens</button>
                  <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false"> <span class="caret"></span> </button> 
                  <ul class="dropdown-menu">
                    <cfset i=0>
                    <cfloop query="lenslist">
					            <cfset i=i+1>
                      <li><a  class="Lens_value" data-id="#lenslist.id#" value="#lenslist.Lens#"> #lenslist.id# #lenslist.Lens#</a></li>
                    </cfloop>
                  </ul>
                </div>
                <input type="text" class="form-control" value="#qGetCamera.Lens_Name#"  id="Lens_value" name="Lens_value" >
                <input type="hidden" class="form-control" name="Lens_value_id" value="#qGetCamera.Lens_id#" id="Lens_value_id"  >
              </div>
            </div> 
            --->

            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Lens</button>
                </div>
                <select class="combobox form-control" id="Lens_value" name="Lens_value">
                  <cfif len(trim(qGetCamera.Lens_Name)) EQ 0>
                    <option value="">Select Lens</option>
                    <cfelse>
                    <option value="#qGetCamera.Lens_id#">#qGetCamera.Lens_Name#</option>
                  </cfif>
                  <cfloop query="lenslist">
                  <cfif active EQ 1>
                      <option data-id="#lenslist.id#" value="#lenslist.id#">#lenslist.Lens#</option>
                    </cfif>
                  </cfloop>
                </select>
              </div>
            </div>


            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Photographer</button>
                </div>
                <select class="combobox form-control" name="Photographer">
                  <cfif len(trim(qGetCamera.Photographer)) EQ 0>
                    <option value="">Select Photographer</option>
                    <cfelse>
                    <option value="#qGetCamera.Photographer#">#qGetCamera.Photographer#</option>
                  </cfif>
                  <cfloop query="getTeams">
                    <cfif active EQ 1 and qGetCamera.Photographer NEQ getTeams.RT_MemberName>
                      <option  value="#getTeams.RT_MemberName#">#getTeams.RT_MemberName#</option>
                    </cfif>
                  </cfloop>
                </select>
              </div>
            </div>

            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Driver</button>
                </div>
                <select class="combobox form-control" name="Driver">
                  <cfif len(trim(qGetCamera.Driver)) EQ 0>
                    <option value="">Select Driver</option>
                    <cfelse>
                    <option value="#qGetCamera.Driver#">#qGetCamera.Driver#</option>
                  </cfif>
                  <cfloop query="getTeams">
                    <cfif active EQ 1 and qGetCamera.Driver NEQ getTeams.RT_MemberName>
                      <option  value="#getTeams.RT_MemberName#">#getTeams.RT_MemberName#</option>
                    </cfif>
                  </cfloop>
                </select>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
             <div class="inner-border-box">
              <label>Comments</label><br><br>
               <div class="form-group image-box main">
                <textarea name="Comments" class="form-control" placholder="Comment" >#qGetSightings.Comments#</textarea>
              </div>
             </div>
            </div><br>
              <div class="col-md-12">
                <div class="form-group float-right completed-by">
                    <strong>Completed By:</strong><input type="text" value="#qGetSightings.EnteredBy#"  name="EnteredBy" class="form-control"/>
                </div>
              </div>
          </div>
          <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>
            <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
            <cfif isdefined('form.sight_id') and form.sight_id neq 0>
              <input type="hidden" name="sight_id" value="#qGetSightings.ID#">
              <input type="submit" class="btn btn-success update" id="update"  value="Update and Retain" name="update_data">
              <input type="submit" class="btn btn-success update" id="update2" value="Update and Clear" name="update_data_clear">
              <input type="submit" class="btn btn-success update" id="update"  value="Update Survey and Retain" name="update_data_pro">
              <input type="submit" class="btn btn-success update" id="update2" value="Update Survey and Clear" name="update_data_clear_pro">
              <cfelse>
              <input type="submit" class="btn btn-success" value="Add Sighting & Retain" name="add_sighting">
              <input type="submit" class="btn btn-success" value="Add Sighting & Clear" name="add_sighting_clear">
              <input type="submit" class="btn btn-success update" id="update"  value="Update Survey and Retain" name="update_data_pro">
              <input type="submit" class="btn btn-success update" id="update2" value="Update Survey and Clear" name="update_data_clear_pro">
            </cfif>
            <cfelse>
            <input type="submit" class="btn btn-success" value="Save Sighting & Go To Cetacean Sighting" name="add_data">
            <input type="submit" class="btn btn-success" value="Save Sighting & Go To Next Sighting" name="add_data_clear">
          </cfif>
        </form>
      </div>
      <!-- end row --> 
    </div>
  </div>
  <cfif isdefined('form.sight_id') and form.sight_id neq 0>
    <form method="post" id="sightingDelete">
      <input type="hidden" name="sighting_id" value="#qGetSightings.ID#">
      <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
      <input type="hidden" name="sight_delete" value="1">
    </form>
  </cfif>
</cfoutput> 
<!-- ================== END PAGE LEVEL JS ================== --> 
  <cfinclude template="../Dolphin/Biopsy.cfm">
  <cfinclude template="dolphin.cfm">
  <cfinclude template="NCSG.cfm">