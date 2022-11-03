<cfoutput>
  <cfif isdefined('form.sight_delete') and form.sight_delete EQ 1>
    <cfset SightDelete=Application.Sighting.sight_delete(argumentCollection="#Form#")>
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
    <cfset SurveyStartTime=dummydate & SurveyStartTime>
    <cfset SurveyEndTime=dummydate & SurveyEndTime>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif StartTime gt EndTime>
      <cfset error="Dock Start time must be less than Dock End Time">
      <cfelseif SurveyStartTime gt SurveyEndTime>
      <cfset error="Survey Start time must be less than Survey End Time">
      <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
      <cfelse>
      <!--- Update sighting if this defined--->
      <cfif isdefined('form.update_data') or isdefined('form.update_data_clear')>
        <cfset qUpdateProject_SIGHT=Application.Sighting.qUpdateProject_SIGHT(argumentCollection="#Form#")>
        <cfset updatecameralens=Application.Sighting.updatecameralens(argumentCollection="#Form#")>
      </cfif>
      <cfset qUpdateProject=Application.Sighting.qUpdateProject(argumentCollection="#Form#")>
      <cfset updateteammember=Application.Sighting.updateteammember(argumentCollection="#Form#")>
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
    <cfset qInsertid = Application.Sighting.qInsertid()>
    <cfset dummydate="1899-12-30 ">
    <cfset StartTime=dummydate & StartTime>
    <cfset EndTime=dummydate & EndTime >
    <cfset SurveyStartTime=dummydate & SurveyStartTime>
    <cfset SurveyEndTime=dummydate & SurveyEndTime>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif StartTime gt EndTime>
      <cfset error="Dock Start time must be less than Dock End Time">
      <cfelseif SurveyStartTime gt SurveyEndTime>
      <cfset error="Survey Start time must be less than Survey End Time">
      <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
      <cfelse>
      <cfset project_id = qInsertid.id + 1>
      <cfset qInsertProject = Application.Sighting.qInsertProject(argumentCollection="#Form#")>
      <cftry>
        <cfif isdefined("form.add_data_withSight")>
          <!---- Insert sight ID------>
          <cfset qInsertProject = Application.Sighting.InsertSight(argumentCollection="#Form#")>
          <!---- last sight ID------>
          <cfset lastsight_id = Application.Sighting.qInsertids()>
          <!---- photo roool------->
          <cfset qPHOTO_ROLLS = Application.Sighting.qPHOTO_ROLLS()>
          <!---- camera lens insert------->
          <cfset camera_lensinsert = Application.Sighting.camera_lensinsert(argumentCollection="#Form#")>
        </cfif>
        
        <!----- Team member----------------->
        <cfset Insertteammember=Application.Sighting.Insertteammember(argumentCollection="#Form#")>
        <!-------Insert Zone Data-------------->
        <cfset InsetZonesData=Application.Sighting.InsetZonesData(argumentCollection="#Form#")>
        <cfif qInsertProject.RECORDCOUNT eq 1 >
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
    <cfset SurveyStartTime=dummydate & SurveyStartTime>
    <cfset SurveyEndTime=dummydate & SurveyEndTime>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif StartTime gt EndTime>
      <cfset error="Dock Start time must be less than Dock End Time">
      <cfelseif SurveyStartTime gt SurveyEndTime>
      <cfset error="Survey Start time must be less than Survey End Time">
      <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
      <cfelse>
      <cfset qUpdateProject=Application.Sighting.qUpdateProject(argumentCollection="#Form#")>
      <cfset qInsertsigting = Application.Sighting.InsertSight(argumentCollection="#Form#")>
      
      <!---- last sight ID------>
      <cfset lastsight_id = Application.Sighting.qInsertids()>
      
      <!---- camera lens insert------->
      <cfset camera_lensinsert = Application.Sighting.camera_lensinsert(argumentCollection="#Form#")>
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
    <cfset qProjects=Application.Sighting.qProjects(argumentCollection="#Form#")>
    <cfset qProjectszone=Application.Sighting.qProjectszone(argumentCollection="#Form#")>
    <cfelse>
    <cfset qProjects=Application.Sighting.qProject_ten()>
  </cfif>
  
  <!---- Sight Detail--->
  <cfparam name="form.sight_id" default="0">
  
  <!----- add sighting & retain---->
  <cfif isdefined('form.add_sighting')>
    <cfset lastsight_id = Application.Sighting.qInsertids()>
    <cfset form.sight_id = lastsight_id.ids>
  </cfif>
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
  <cfset qGetWave=Application.Sighting.qGetWeather()>
  
  <!--- Conditions ---> 
  
  <!--- Extracting Survey area --->
  <cfset getSurveyArea=Application.Sighting.getSurveyArea()>
  <cfset getType=Application.StaticData.getType()>
  <cfset getSubType=Application.Sighting.getSubType()>
  <!---<cfset getSurvey=Application.Sighting.getSurvey()>--->
  <cfset getSurvey=Application.StaticData.getPlateForm()>
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
  <cfset TideList = Application.Sighting.getTide()>
  <cfset StructureList = Application.Sighting.getStructureList()>
  <cfset getHabitatList = Application.Sighting.getHabitat()>
  <!------ Zone list ------------------>
  <cfset zonelist = Application.Sighting.zonelist()>
  <cfset zonelistall = Application.Sighting.zonelistall()>
  <cfset PRojectzonelist = Application.Sighting.PRojectzonelist(argumentCollection="#Form#")>
  <!------- Project list--------->
  <cfset qProjectsId = Application.Sighting.qProjectsId()>
  
  <!------- Stock list--------->
  <cfset getStock = Application.StaticData.getStock()>
  
  <!------- Funding Source list--------->
  <cfset getFundingSource = Application.Sighting.getFundingSource()>
  
  <!------- Conditions list--------->
  <cfset getWaveHeight = Application.Sighting.getWaveHeight()>
  <cfset getWeather = Application.Sighting.getWeather()>
  <cfset getGlare = Application.Sighting.getGlare()>
  <cfset getselectmember = Application.Sighting.getselectmember(argumentCollection="#Form#")>
  <cfset getteammember = ValueList(getselectmember.RT_ID,",")>
  <cfset getSightability = Application.Sighting.getSightability()>
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
            <a href="#Application.superadmin#?ArchiveModule=Sighting&Page=Home&Archive">
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
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label m-b-10">Dock Start</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12 m-b-10" id="datetimepicker2">
                      <input type="text" value="#TimeFormat(qProjects.StartTime, "HH:nn")#" placeholder="hh:mm" name="StartTime" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label m-b-10">Engine Start</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12 m-b-10" id="datetimepicker_enginestart">
                      <input type="text" value="#TimeFormat(qProjects.EngineStart, "HH:nn")#" placeholder="hh:mm" name="EngineStart" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Survey Start</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_srvystrt">
                      <input type="text" value="#TimeFormat(qProjects.SurveyStartTime, "HH:nn")#"  placeholder="hh:mm" name="SurveyStartTime" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                </div>
                <div class="box-inline second"> 
                  <!---<div class="form-group next-check">
                            <div class="checkbox-new">
                                <input type="radio" value='1' name="SurveyType"  id="rememberMe" class="float-left" <cfif qProjects.SurveyType eq 1>checked</cfif> />
                                <label class="float-left font_size_14" for="rememberMe">ICW</label>
                            </div>
                            <div class="checkbox-new">
                                <input type="radio" value='2' name="SurveyType" id="rememberMe1" class="float-left" <cfif qProjects.SurveyType eq 2>checked</cfif> >
                                <label class="float-left font_size_14" for="rememberMe">Transect</label>
                            </div>
                        </div>--->
                  <div class="form-group next-check">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Dock End</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_endtime">
                      <input type="text" value="#TimeFormat(qProjects.EndTime, "HH:nn")#" placeholder="hh:mm" name="EndTime" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="form-group next-check">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Engine Off</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_engineoff">
                      <input type="text" value="#TimeFormat(qProjects.EngineOff, "HH:nn")#" placeholder="hh:mm" name="EngineOff" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Survey End</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_srvyend">
                      <input type="text" value="#TimeFormat(qProjects.SurveyEndTime, "HH:nn")#"  placeholder="hh:mm" name="SurveyEndTime"class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <!--<div class="check-box-inline">-->
                  <div class="col-md-4"></div>
                  <!--</div>--> 
                </div>
                <!---<div>
                <div class="form-group has-feedback">
                    <label>Summary</label>
                    <div >
                        <textarea class="form-control" style="height: 69px;" maxlength="500" name="Summary">#qProjects.Summary#</textarea>
                    </div>
                </div>
            </div>---> 
              </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-8 col-xs-12 team-box">
              <div class="inner-border-box" style="min-height:235px" >
                <div class="form-group first-tab">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Team</button>
                    </div>
                    <select class="form-control search-box" multiple="multiple" name="ResearchTeam" id="ResearchTeam">
                      <cfloop query="getTeams">
                        <cfif active eq 1 or (active eq 0 and ListFind(getteammember,getTeams.RT_ID))>
                        <option value="#getTeams.RT_ID#" <cfif ListFind(getteammember,getTeams.RT_ID)>selected</cfif> >#getTeams.RT_MemberName#</option>
                      	</cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Platform</button>
                    </div>
                    <select class="combobox form-control" name="Platform" id="plateform_value">
                      <option value="">select Platform</option>
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
                      <select class="combobox form-control surveyArea_default" name="SurveyArea[]"  id="area_value">
                        <option value="">Select Area</option>
                        <cfloop query="getSurveyArea">
                          <cfif active eq 1 OR (active eq 0 and qProjects.SurveyArea eq getSurveyArea.AreaName)>
                          	<option class="area_value" value="#getSurveyArea.AreaName#" data-stock="#getSurveyArea.StockName#" <cfif qProjects.SurveyArea EQ getSurveyArea.AreaName>selected</cfif>>#getSurveyArea.AreaName#</option>
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
                        <cfif active eq 1 OR (active eq 0 and qProjects.Type eq getType.Type)>
                        	<option class="area_value" value="#getType.Type#" <cfif qProjects.Type EQ getType.Type>selected</cfif>>#getType.Type#</option>
                        </cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Sub Type</button>
                    </div>
                    <select class="combobox form-control" name="SubType" id="SubType" >
                      <option value="">Select Sub Type</option>
                      <cfloop query="getSubType">
                        <cfif active eq 1 OR (active eq 0 and qProjects.SubType eq getSubType.SubType)>
                        	<option class="area_value" value="#getSubType.SubType#" data-surveytype="#getSubType.Type#" <cfif qProjects.SubType EQ getSubType.SubType>selected</cfif>>#getSubType.SubType#</option>
                        </cfif>    
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Funding Source</button>
                    </div>
                    <select class="combobox form-control" name="FundingSource"  id="funding_source_value">
                      <option value="">Select Funding Source</option>
                      <cfloop query="getFundingSource">
                        <cfif active eq 1 OR (active eq 0 and qProjects.FundingSource eq getFundingSource.name)>
                        	<option class="funding_source_value" value="#getFundingSource.name#" <cfif qProjects.FundingSource EQ getFundingSource.name>selected<cfelseif getFundingSource.name EQ 'HBOC'>selected</cfif>>#getFundingSource.name#</option>
                        </cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 zone-box">
              <div class="inner-border-box m-b-5" style='min-height:15px;font-size:12px'>
                <div class="form-group">
                  <input type="checkbox" value="ATL" class="zonefilter">
                  ATL
                  <input type="checkbox" value="BR" class="zonefilter">
                  BR
                  <input type="checkbox" value="IR" class="zonefilter">
                  IR
                  <input type="checkbox" value="ML" class="zonefilter">
                  ML
                  <input type="checkbox" value="SLR" class="zonefilter">
                  SLR </div>
              </div>
              <div class="inner-border-box fixed-min-height">
                <div class="form-group">
                  <label class="control-label col-lg-3 col-md-3 col-sm-12 col-xs-12 text-right">Zone Begin</label>
                  <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 select-box">
                    <select name="BeginZoneID"  id="BeginZoneID"  class="form-control bg-blue" >
                      <option value=""></option>
                      <cfloop query="zonelist">
                        <option value="#zonelist.zone#" <cfif qProjects.BeginZoneID eq zonelist.ID>selected</cfif> >#zonelist.zone#</option>
                        <cfif qProjects.BeginZoneID eq zonelist.ID>
                        	<cfif zonelist.zone Contains 'ATL'>
                            	<cfset zoneVal='ATL'>
                            <cfelseif zonelist.zone Contains 'BR'>
                            	<cfset zoneVal='BR'>
							<cfelseif zonelist.zone Contains 'IR'>
                            	<cfset zoneVal='IR'>
							<cfelseif zonelist.zone Contains 'ML'>
                            	<cfset zoneVal='ML'>
							<cfelseif zonelist.zone Contains 'SLR'>
                            	<cfset zoneVal='SLR'>
                            </cfif>
                        </cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="control-label col-lg-3 col-md-3 col-sm-12 col-xs-12 text-right">Zone End</label>
                  <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 select-box">
                    <select name="EndZoneID" id="EndZoneID" class="form-control bg-blue" >
                      <option value=""></option>
                      <cfloop query="zonelist">
                        <option value="#zonelist.zone#"  <cfif qProjects.EndZoneID eq zonelist.ID>selected</cfif>>#zonelist.zone#</option>
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>
                    <button class="btn btn-primary pull-left"  type="button" id="zone_add">Add</button>
                    <button class="btn btn-primary pull-right"  type="button" id="zone_view">View</button>
                    <cfelse>
                    <button class="btn btn-primary pull-left"  type="button" id="zone_add_before">Add</button>
                    <button class="btn btn-primary pull-right"  type="button" id="zone_view_before">View</button>
                  </cfif>
                </div>
              </div>
            </div>
          </div>
          <div class="row m-t-10">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12  location">
              <div class="inner-border-box">
                <div class="row sighting_section">
                  <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="inline-boxes">
                      <div class="box-inline second">
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting Number</label>
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
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Begin ICW Marker</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.ICW_Begin#"  name="ICW_Begin" class="form-control"/>
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"></label>
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
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                    <div class="inline-boxes">
                      <div class="form-group">
                        <label>Location</label>
                        <textarea class="form-control" name="Location" maxlength="75">#qGetSightings.Location#</textarea>
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <div class="inline-boxes">
                      <div class="box-inline second">
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">UTM Zone</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <select name="UMT_zone_id" id="UMT_zone_id" class="form-control bg-blue" >
                              <option value="0">Select UTM Zone</option>
                              <cfloop from="10" to="18" index="i">
                                <option value="#i#" <cfif qGetSightings.Zone_id eq i>selected<cfelseif i eq 17>selected</cfif> >#i#</option>
                              </cfloop>
                              <!---<cfloop query="zonelistall">
                    <option value="#zonelistall.ID#" <cfif qGetSightings.Zone_id eq zonelistall.ID>selected</cfif> >#zonelistall.zone#</option>
            </cfloop>--->
                            </select>
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Easting</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.Easting_X#"  name="Easting_X" class="form-control bg-color" id="Easting_X"/>
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Northing</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.Northing_Y#"  name="Northing_Y" class="form-control bg-color" id="Northing_Y"/>
                            <input type="button" value='Convert' class='btn btn-success m-t-5' id='UTMConversion'>
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Begin Lattitude</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.Begin_LAT_Dec#"  name="Begin_LAT_Dec" id="Begin_LAT_Dec" class="form-control bg-color" />
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Begin Longitude</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.Begin_LON_Dec#"  name="Begin_LON_Dec" id="Begin_LON_Dec" class="form-control bg-color"/>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="srow col-lg-3 col-md-3 col-sm-12 col-xs-12">
                        <div class="form-group next-check">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Zone Grid</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <select name="zone_id" id="zone_id" class="form-control bg-blue" >
                              <option value="0">Select Zone</option>
                              <cfloop query="zonelist">
                                <option value="#zonelist.ID#" <cfif qGetSightings.Zone_id eq zonelist.ID>selected</cfif> >#zonelist.zone#</option>
                              </cfloop>
                            </select>
                          </div>
                        </div>
                        <div  id="body-of-water-sec">
                          <div class="form-group">
                         <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Body of Water</label>
                          <select class="combobox form-control surveyArea_default" name="SurveyArea_Sighting"  id="area_value">
                            <option value="">Select Area</option>
                            <cfloop query="getSurveyArea">
                              <cfif active eq 1 OR (active eq 0 and qProjects.SurveyArea eq getSurveyArea.AreaName)>
                                <option class="area_value" value="#getSurveyArea.AreaName#" data-stock="#getSurveyArea.StockName#" <cfif qProjects.SurveyArea EQ getSurveyArea.AreaName>selected</cfif>>#getSurveyArea.AreaName#</option>
                              </cfif>
                            </cfloop>
                          </select>
                          </div>
                        </div>
                        <cfif isdefined('form.sight_id') and form.sight_id neq 0>
                          <button type="button" class="btn btn-danger" onclick="sightingDelete()">Delete Sighting</button>
                        </cfif>
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
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Water Temp</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp"  class="form-control" />
                        <input type="checkbox" name="dgree" value="C" class="myCheckbox">
                        : C <br>
                        <input type="checkbox" name="dgree" value="F" class="myCheckbox">
                        : F
                        <input type="button" value='Convert' class='btn btn-success m-t-5'  id="convertTemp" >
                      </div>
                    </div>
                  </div>
                  <div class="radio-inline right">
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Heading</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control" id="value" name="Heading">
                          <option value=""></option>
                          <option value="N" <cfif qGetSightings.heading eq 'N'>selected</cfif> >N</option>
                          <option value="ND" <cfif qGetSightings.heading eq 'ND'>selected</cfif>>ND</option>
                          <option value="NE" <cfif qGetSightings.heading eq 'NE'>selected</cfif>>NE</option>
                          <option value="NW" <cfif qGetSightings.heading eq 'NW'>selected</cfif>>NW</option>
                          <option value="S" <cfif qGetSightings.heading eq 'S'>selected</cfif>>S</option>
                          <option value="SE" <cfif qGetSightings.heading eq 'SE'>selected</cfif>>SE</option>
                          <option value="SW" <cfif qGetSightings.heading eq 'SW'>selected</cfif>>SW</option>
                          <option value="E" <cfif qGetSightings.heading eq 'E'>selected</cfif>>E</option>
                          <option value="W" <cfif qGetSightings.heading eq 'W'>selected</cfif>>W</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">## of Boats</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.NumberOfBoats#" name="NumberOfBoats"  class="form-control"  />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">AssocBio 1</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control" id="value" name="AssocBioData1" >
                          <option value="0"></option>
                          <cfloop query="qGetAssocBioData">
                            <cfif active eq 1 OR (active eq 0 and qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData1)>
                            	<option value="#qGetAssocBioData.ASSOCBIOID#" <cfif qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData1>selected</cfif>>#qGetAssocBioData.ASSOCBIONAME# </option>
                            </cfif>
                          </cfloop>
                        </select>
                        <!---<input type="text" value="" name=""  class="form-control" />---> 
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">AssocBio 2</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control" id="value" name="AssocBioData2" >
                          <option value="0"></option>
                          <cfloop query="qGetAssocBioData">
                            <cfif active eq 1 OR (active eq 0 and qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData2)>
                            	<option value="#qGetAssocBioData.ASSOCBIOID#" <cfif qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData2>selected</cfif>>#qGetAssocBioData.ASSOCBIONAME# </option>
                            </cfif>
                          </cfloop>
                        </select>
                        <!---<input type="text" value="" name=""  class="form-control" />---> 
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">AssocBio 3</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control" id="value" name="AssocBioData3" >
                          <option value="0"></option>
                          <cfloop query="qGetAssocBioData">
                            <cfif active eq 1 OR (active eq 0 and qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData3)>
                            	<option value="#qGetAssocBioData.ASSOCBIOID#" <cfif qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBioData3>selected</cfif>>#qGetAssocBioData.ASSOCBIONAME# </option>
                            </cfif>
                          </cfloop>
                        </select>
                        <!---<input type="text" value="" name=""  class="form-control" />---> 
                      </div>
                    </div>
                    <!---<div class="form-group">
      <label class="col-lg-5 col-md-5 col-sm-12 control-label">## Takes</label>
      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
        <input type="text" value="#qGetSightings.Takes#" name="Takes"  class="form-control" maxlength="255" />
      </div>
    </div>---> 
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
                        <input type="text" value="#qGetSightings.FE_TotalDolphin_Min#" name="FE_TotalDolphin_Min" class="form-control"  />
                      </div>
                      <div class="box_01">
                        <input type="text" value="#qGetSightings.FE_TotalDolphin_Max#" name="FE_TotalDolphin_Max" class="form-control"  />
                      </div>
                      <div class="box_01">
                        <input type="text" value="#qGetSightings.FE_TotalDolphin_Best#" name="FE_TotalDolphin_Best" class="form-control"  />
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
                        <select class="form-control select_activity"  id="value0" name="Activity_Mill">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Mill eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Feed
                        <select class="form-control select_activity"  id="value1" name="Activity_Feed">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Feed eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Prob. Feed
                        <select class="form-control select_activity"  id="value2" name="Activity_ProbFeed">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_ProbFeed eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Travel
                        <select class="form-control select_activity"  id="value3" name="Activity_Travel">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Travel eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Play
                        <select class="form-control select_activity"  id="value4" name="Activity_Play">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Play eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Rest
                        <select class="form-control select_activity"  id="value5" name="ACTIVITY_REST">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Rest eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Leap
                        <select class="form-control select_activity"  id="value6" name="Activity_Leap_tailslap_chuff">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Leap_tailslap_chuff eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Social
                        <select class="form-control select_activity"  id="value7" name="Activity_Social">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Social eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> w/boat
                        <select class="form-control select_activity"  id="value8" name="ACTIVITY_WITHBOAT">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_WithBoat eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Other
                        <select class="form-control select_activity"  id="value9" name="Activity_Other">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Other eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Avoid Boat
                        <select class="form-control select_activity"  id="value10" name="Activity_Avoid_Boat">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Activity_Avoid_Boat eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Depre dation
                        <select class="form-control select_activity" id="value11"  name="Depredation">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Depredation eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Herding
                        <select class="form-control select_activity"   name="Herding" id="value12">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="6" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Herding eq i>selected</cfif> >#i#</option>
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
          <div class="inner-border-box">
            <label>Feeding Ecology</label>
            <div class="row">
              <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Chase Feed</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="chase_feed" class="myCheckbox" value="1" <cfif qGetSightings.chase_feed eq 1>checked</cfif> >
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Pinwheel</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Pinwheel" value="1" class="myCheckbox" <cfif qGetSightings.Pinwheel eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Herding</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="feed_Herding" value="1" class="myCheckbox" <cfif qGetSightings.feed_Herding eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Headstand</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Headstand" value="1" class="myCheckbox" <cfif qGetSightings.Headstand eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Repetitive Diving</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Repetitive_Diving" value="1" class="myCheckbox" <cfif qGetSightings.Repetitive_Diving eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Commercial Interaction</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Commercial_Interaction" value="1" class="myCheckbox" <cfif qGetSightings.Commercial_Interaction eq 1>checked</cfif>>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Crab Pot</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Crab_Pot" value="1" class="myCheckbox" <cfif qGetSightings.Crab_Pot eq 1>checked</cfif> >
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Boat Escort</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Boat_Escort" value="1" class="myCheckbox" <cfif qGetSightings.Boat_Escort eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Catch/Release</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Catch_Release" value="1" class="myCheckbox" <cfif qGetSightings.Catch_Release eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Bycatch Scavenge</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Bycatch_Scavenge" value="1" class="myCheckbox" <cfif qGetSightings.Bycatch_Scavenge eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Head Out Begging</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Head_Out_Begging" value="1" class="myCheckbox" <cfif qGetSightings.Head_Out_Begging eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Human Feed</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Human_Feed" value="1" class="myCheckbox" <cfif qGetSightings.Human_Feed eq 1>checked</cfif>>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Recreational Interaction</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="checkbox" name="Recreational_Interaction" value="1" class="myCheckbox" <cfif qGetSightings.Recreational_Interaction eq 1>checked</cfif>>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Feeding Latitude </label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="text" value="#qGetSightings.feed_latitude#"  name="feed_latitude" class="form-control"/>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Feeding Longitude </label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="text" value="#qGetSightings.feed_longitude#"  name="feed_longitude" class="form-control"/>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Tide</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <select class="form-control" id="value" name="Tide">
                      <option value="0">Select</option>
                      <cfloop query="TideList">
                        <cfif active eq 1 or (active eq 0 and qGetSightings.Tide eq TideID)>
                        	<option value="#TideID#" <cfif qGetSightings.Tide eq #TideID#>selected</cfif>>#TideName#</option>
                        </cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Structure Present</label>
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
                <div class="form-group chk-box-wrap">
                  <label class="col-lg-5 col-md-5 col-sm-6 control-label">Habitat</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <select class="form-control" id="value" name="feed_Habitat">
                      <option value="0">Select</option>
                      <cfloop query="getHabitatList">
                        <cfif active eq 1 or (active eq 0 and qGetSightings.feed_Habitat eq HabitatID)>
                        	<option value="#HabitatID#" <cfif qGetSightings.feed_Habitat eq #HabitatID#>selected</cfif>>#HabitatName#</option>
                        </cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <div class="clear"></div>
          </div>
          <br>
          <div class="row  m-b-10">
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
            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Photographer</button>
                </div>
                <select class="combobox form-control" name="Photographer">
                  <cfif len(trim(qGetCamera.Photographer)) EQ 0>
                    <option value="">select Photographer</option>
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
                    <option value="">select Driver</option>
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
              <div class="form-group image-box main">
                <textarea name="notes" class="form-control" placholder="Comment" >#qGetSightings.Notes#</textarea>
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
            <input type="submit" class="btn btn-success" value="Submit Survey & Retain" name="add_data">
            <input type="submit" class="btn btn-success" value="Submit Survey & Clear" name="add_data_clear">
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

<cfoutput>
  <div id="view_zone" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog"> 
      
      <!-- Modal content-->
      <div class="modal-content" style="width: 50%; margin-left:25%">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body text-center" id="content">
          <div class="form-group message" style="display:none"> </div>
          <div class="zoneform" style="display:none">
            <form  id="zoneform">
              <div class="form-group">
                <label for="email">Zone List:</label>
                <select name="addZoneID" id="addZoneID"  class="form-control" >
                  <option value="0">Select Zone</option>
                  <cfloop query="PRojectzonelist">
                    <option value="#PRojectzonelist.ID#">#PRojectzonelist.zone#</option>
                  </cfloop>
                </select>
                <input type="hidden" name="project_id" id="zoneprojectid" value="#form.PROJECT_ID#">
              </div>
              <button type="submit" class="btn btn-success">Submit</button>
            </form>
          </div>
          <div class="dataTables_scroll">
            <div class="dataTables_scrollHead" >
              <div class="dataTables_scrollHeadInner" >
                <table class="table table-striped table-bordered dataTable no-footer" role="grid" >
                  <thead>
                    <tr role="row">
                      <th width="31%" class="text-center">Zone Id</th>
                      <th width="38%" class="text-center">Zone</th>
                      <th width="32%" class="text-center">Action</th>
                    </tr>
                  </thead>
                </table>
              </div>
            </div>
            <div class="dataTables_scrollBody" style="position: relative; overflow: auto; max-height: 200px; width: 100%;">
              <table class="table table-striped table-bordered dataTable no-footer dtr-inline" >
                <tbody id='zones_list'>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <cfinclude template="../Dolphin/Biopsy.cfm">
  <cfinclude template="dolphin.cfm">
  <cfinclude template="NCSG.cfm">
  <cfif isdefined('zoneVal')>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(document).ready(function(e) {
            $('[value=#zoneVal#]').prop('checked',true);
        });
    </script>
  </cfif>
</cfoutput> 