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
  .location-margin {
      margin-left: 40%
  }
  .map-lat-lng {
    color: #0e6d62;
    font-weight: bold;
  }
  .set-btn-margin {
    margin-top: 10px;
  }
  .behvr-spec table tr th p{
    padding-left: 15px;
  }
  .behvr-spec table tr td:first-child{
      width: 60%;
  }
  .behvr-spec table tr td{
      padding-bottom: 6px;
  }
  .FisherResponsetofromCetacean{
    margin-top: 18% !important;
  }
  .mr h5{
    margin-bottom: 35% !important;
  }
  .chk-box-wrap {
      padding: 10px 20px 0 5px;
  }
  .chk-box-wrap input{
    position: relative;
    top: 5px;
  }


  .cohesiveness-label {
    background-color: transparent !important;
    color: #32abe0 !important;
    border: none !important;
    padding: 0px 15px !important;
  }

  .meter-input {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
  }

  .estimates-box.third label {
    margin: 0px !important;
  }


  @media (max-width: 480px) {
    .main-sighting-form .btn.btn-inverse:first-child {
    width: 70px;
    font-size: 9px;
    padding: 5.1px 2px;
    }

  .input-group-addon {
    padding: 3px 6px !important;
  }

    .select2-container--default .select2-selection--multiple {
    border-width: 1px!important;
    padding: 3px 6px!important;
    }
  }

  @media (max-width: 390px) {
    .main-sighting-form .btn.btn-inverse:first-child {
    width: 40px;
    font-size: 8px;
    padding: 5.1px 2px;
    }

    .select2-container--default .select2-selection--multiple {
    border-width: 1px!important;
    padding: 3px 6px!important;
    }
  }

</style>
<cfset  permissions ="#session['userdetails']['permissions']#">

<cfoutput>
  <cfset userinfo=Application.SuperAdminApp.getUserinfo()>
  
  <cfif isdefined('form.sight_delete')>
    <cfset SightDelete=Application.SightingNew.sight_delete(argumentCollection="#Form#")>
    <cfset message="Sighting Deleted.">
  </cfif>
  <cfif isdefined('form.survey_delete')>
    <cfset SightDelete=Application.SightingNew.survey_delete(argumentCollection="#Form#")>
    <cfset message="Survey Deleted.">
  </cfif>
  
  <!----
  --
  --		Update Query
  --
  --->
  
  <cfif isdefined('form.update_data') or isdefined('form.update_data_clear') or isdefined('form.update_data_clear_pro') or isdefined('form.update_data_pro')>
    <cfset dummydate="1899-12-30 ">
    <cfset SurveyStart=dummydate & SurveyStart>
    <cfset SurveyEnd=dummydate & SurveyEnd>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif SurveyStart gt SurveyEnd>
      <cfset error="Survey Start time must be less than Survey End Time">
    <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
    <cfelse>
      <!--- Update sighting if this defined--->
      <cfset qUpdateProject=Application.SightingNew.qUpdateProject(argumentCollection="#Form#")>
      <cfset message ="Survey record updated!">
      <cfif isdefined('form.update_data') or isdefined('form.update_data_clear')>
        <cfset qUpdateProject_SIGHT=Application.SightingNew.qUpdateProject_SIGHT(argumentCollection="#Form#")>
        <cfset message ="Survey and Sighting record updated!">
      </cfif>
    </cfif>
  </cfif>
  <!----
  --
  --	 Insert Query
  --
  --->
  <cfif isdefined('form.add_survey') or isdefined("form.add_survey_clear")>
    
    <cfset dummydate="1899-12-30">
    <cfset SurveyStart=dummydate & SurveyStart>
    <cfset SurveyEnd=dummydate & SurveyEnd>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif SurveyStart gt SurveyEnd>
      <cfset error="Survey Start time must be less than Survey End Time">
      <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
      <cfelse>
      <cfset qInsertProject = Application.SightingNew.qInsertProject(argumentCollection="#Form#")>
      <cftry>    
        <cfif qInsertProject.RECORDCOUNT eq 1>
            <cfset lastSurveyId = Application.SightingNew.qInsertid()>
            <cfset form.PROJECT_ID=lastSurveyId.id>
            <cfif isdefined("form.FE_Species") AND #form.FE_Species# NEQ "">
                <cfset dummydate="1899-12-30 ">
                <cfset SurveyStart=dummydate & SurveyStart>
                <cfset SurveyEnd=dummydate & SurveyEnd>
                <cfset Sightingstart=dummydate & Sightingstart>
                <cfset Sightingend=dummydate & Sightingend>
                <cfif SurveyStart gt SurveyEnd>
                    <cfset error="Survey Start time must be less than Survey End Time">
                    <cfelseif Sightingstart gt Sightingend>
                    <cfset error="Sight Start time must be less than Sight End Time">
                  <cfelse>
                  <cfif form.SIGHTINGNUMBER neq "">
                      <cftry>
                        <cfset qInsertsigting = Application.SightingNew.InsertSight(argumentCollection="#Form#")>
                        <cfif qInsertsigting.RECORDCOUNT eq 1 >
                            <cfset lastsight_id = Application.SightingNew.qInsertids()>
                            <cfset form.sight_id = lastsight_id.ids>
                            <cfset message ="Survey and Sighting Added!">
                              <!--- Here we decide open cetacean sighting modal OR clear sighting--->
                            <cfif isdefined('form.add_survey') >
                                <input type="hidden" id="open_cetacean_sighting" value="1"/>
                              <cfelse>
                                <input type="hidden" id="open_cetacean_sighting" value="0"/>
                                <cfset form.PROJECT_ID=project_id>
                            </cfif>
                        </cfif>
                      
                        <cfcatch>
                        <cfset error="#cfcatch#">
                        </cfcatch>
                      </cftry>
                  </cfif>
              </cfif>
                <cfelse>
                  <cfset success = 1>	
            </cfif>
        </cfif>
        <cfcatch>
            <cfset error="#cfcatch#">
        </cfcatch>
      </cftry>
    </cfif>
    <!--- timer conditions end --->
  </cfif>

  <!----
  --		Insert Sighting for Project Query
  --
  --->

  <cfif isdefined('form.add_sighting') or isdefined('form.add_sighting_clear')>
    <cfset dummydate="1899-12-30 ">
    <cfset SurveyStart=dummydate & SurveyStart>
    <cfset SurveyEnd=dummydate & SurveyEnd>
    <cfset Sightingstart=dummydate & Sightingstart>
    <cfset Sightingend=dummydate & Sightingend>
    <cfif SurveyStart gt SurveyEnd>
      <cfset error="Survey Start time must be less than Survey End Time">
    <cfelseif Sightingstart gt Sightingend>
      <cfset error="Sight Start time must be less than Sight End Time">
    <cfelse> 
      <cfset qUpdateProject=Application.SightingNew.qUpdateProject(argumentCollection="#Form#")>
      <cfif form.SIGHTINGNUMBER neq "">
        <cftry>
        <cfset qInsertsigting = Application.SightingNew.InsertSight(argumentCollection="#Form#")>
          <cfif qInsertsigting.RECORDCOUNT eq 1 >
            <cfset message ="Sighting Added">
            <!--- Here we decide open cetacean sighting modal OR clear sighting--->
            <cfif isdefined('form.add_sighting') >
                <input type="hidden" id="open_cetacean_sighting" value="1"/>
            <cfelse>
              <input type="hidden" id="open_cetacean_sighting" value="0"/>
            </cfif>
          </cfif>
          <cfcatch>
            <cfset error="#cfcatch#">
          </cfcatch>
        </cftry>
        <!---- last sight ID------>
        <cfset lastsight_id = Application.SightingNew.qInsertids()>
      </cfif>
    </cfif>
    <!-- time if end -->
  </cfif>

  <cfparam name="form.PROJECT_ID" default="0">
  <cfif isdefined('form.update_data_clear') OR isdefined('form.update_data_clear_pro')>
    <cfset form.PROJECT_ID = 0>
  </cfif>
  
    <!----- Surveys------->
  <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq ''>
    <cfset qSurveys=Application.SightingNew.qSurveys(argumentCollection="#Form#")>
  <cfelse>
    <cfset qSurveys=Application.SightingNew.qProject_ten()>
  </cfif>
  
  <!---- Sight Detail--->
  <cfparam name="form.sight_id" default="0">
  
  <!----- add sighting & retain---->
  <cfif isdefined('form.add_sighting')>
    <cfif form.SIGHTINGNUMBER neq "">
      <cfset lastsight_id = Application.SightingNew.qInsertids()>
      <cfset form.sight_id = lastsight_id.ids>
    <cfelse>
      <cfset form.sight_id = 0>
    </cfif>
  </cfif>
  <cfset qGetSightings=Application.SightingNew.qSightningDetails(argumentCollection="#Form#")>
  
  <!---- get Sighting List--->
  <cfset getsightinglist=Application.SightingNew.getsightinglist(argumentCollection="#Form#")>
  
  <!--- Conditions --->
  <cfset qGetWave=Application.SightingNew.qGetWave()>
  <cfset qGetWave=Application.SightingNew.qGetWeather()>

  <cfset qCetaceanResponseToFisher=Application.SightingNew.qCetaceanResponseToFisher()>
  <cfset qFisherResponseToCetacean=Application.SightingNew.qFisherResponseToCetacean()>
  <cfset qCetaceanResponseToVessel=Application.SightingNew.qCetaceanResponseToVessel()>
  <cfset qVesselResponseToCetacean=Application.SightingNew.qVesselResponseToCetacean()>
  <!--- Conditions ---> 

  <!--- Cetacean Species --->
  <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>

  
  <!--- Extracting Survey area --->
  <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>
  <cfset getSelectedSurveyArea = Application.SightingNew.getSelectedSurveyArea(argumentCollection="#Form#")>
  <cfset getSurveyAreas = ValueList(getSelectedSurveyArea.ID,",")>

  <cfset getType=Application.StaticDataNew.getType()>
  <cfset getPlateForm=Application.StaticDataNew.getPlateForm()>

  <!---  Static data   --->


  <cfset staticInteractions = ['','Approach','Neutral','Relocate']>
  <cfset vesselResponseToCetacean = ['','Approach','Out of Gear','No Response','Other']>
  <cfset fisherResponseToCetacean = ['','Relocate','Pull in line','Approach','No Response']>


  <cfset TideList = Application.SightingNew.getTide()>
  <cfset StructureList = Application.SightingNew.getStructureList()>
  <cfset getHabitatList = Application.SightingNew.getHabitat()>
  <!------- Project list--------->
  <cfset qSurveysId = Application.SightingNew.qSurveysId()>
  <cfset qSurveysdate = Application.SightingNew.qSurveysdate()>
  <!------- Stock list--------->
  <cfset getStock = Application.StaticDataNew.getStock()>
  <cfset getSelectedStock = Application.SightingNew.getSelectedNOAAStock(argumentCollection="#Form#")>
  <cfset getSelectedStockValues = ValueList(getSelectedStock.ID,",")>
  
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
  <cfset qGetGHeadingData=Application.StaticDataNew.getGHeading()>
  <cfset qGetFHeadingData=Application.StaticDataNew.getFHeading()>

  <cfset getGlareDirection = Application.StaticDataNew.getGlareDirection()>

  <cfset getBehaviorsData = Application.StaticDataNew.getBehavior()>

  <cfset getSelectedBehavior = Application.SightingNew.getSelectedBehavior(argumentCollection="#Form#")>
  <cfset getBehaviors = ValueList(getSelectedBehavior.ID,",")>
  <cfset getTeams=Application.SightingNew.getTeams()>
  <cfset getselectmember = Application.SightingNew.getselectmember(argumentCollection="#Form#")>
  <cfset getteammember = ValueList(getselectmember.RT_ID,",")>

  <cfset getSurveyRouteData = Application.StaticDataNew.getSurveyRoute()>
  <cfset getSelectedSurveyRoute = Application.SightingNew.getSelectedSurveyRoute(argumentCollection="#Form#")>
  <cfset getSurveyRoutes = ValueList(getSelectedSurveyRoute.ID,",")>

  <cfset getPreySpeciesData = Application.StaticDataNew.getPreySpecies()>
  <cfset getSelectedPreySpecies = Application.SightingNew.getSelectedPreySpecies(argumentCollection="#Form#")>
  <cfset getPreySpecies = ValueList(getSelectedPreySpecies.ID,",")>

    <!--- Camera, Lens, Photographer, Driver --->
  <cfset cameralist = Application.SightingNew.getCamera()>
  <cfset getSelectedCamera=Application.SightingNew.getSelectedCamera(argumentCollection="#Form#")> 

  <cfset lenslist = Application.SightingNew.getLens()>
  <cfset getSelectedLens=Application.SightingNew.getSelectedLens(argumentCollection="#Form#")> 

  <cfset getSelectedGrapher=Application.SightingNew.getSelectedGrapher(argumentCollection="#Form#")> 

  <cfset getSelectedDriver=Application.SightingNew.getSelectedDriver(argumentCollection="#Form#")> 
  <!--- Camera, Lens, Photographer, Driver --->

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
      <div class="alert alert-success"> <strong>Success!</strong> Survey id #project_id# Inserted Successfully </div>
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
                  <cfloop query="qSurveysId">
                    <option value="#qSurveysId.id#" <cfif isdefined('form.project_id') and form.project_id eq qSurveysId.id>selected</cfif>>#qSurveysId.id#</option>
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
                  <cfloop query="qSurveysDate">
                    <option value="#qSurveysdate.id#"
                      <cfif isdefined('form.project_id') and form.project_id eq qSurveysdate.id>selected</cfif>> #DateTimeFormat(qSurveysdate.Date,'MM/dd/YYYY')#</option>
                  </cfloop>
                </select>
              </form>
            </div>
          </div>
          <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>
            <div class="col-md-2">
              <form method="post"  id="sightform">
                <label for="sel1">Select Sighting: </label>
                <select name="sight_id" onchange="submitsightForm()" id="sightid" class="form-control search-box selectCustomReset">
                  <option value="0">Add New Sighting</option>
                  <cfloop query="getsightinglist">
                    <option value="#getsightinglist.ID#" <cfif getsightinglist.ID EQ  qGetSightings.ID> selected</cfif> >
                    <cfif getsightinglist.SIGHTINGNUMBER NEQ ''>
                        #getsightinglist.SIGHTINGNUMBER#
                      <cfelse>
                        #getsightinglist.ID#
                    </cfif>
                    </option>
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
          <div class="col-md-1 reset-btn" style="margin-left: -5%;">
            <cfif (permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0) AND isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>
              <form method="post" onsubmit="return confirm('Do you really want to Delete Survey with all Sightings?');">
                <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
                <input type="submit"  class="btn btn-success" name="survey_delete" value="Delete Survey">
              </form>
            </cfif>
          </div>
        </div>
        <form class="main-sighting-form" name="ResetMe" id="ResetMe" action="" enctype="multipart/form-data" method="post" onsubmit="validateMyForm(event);">
          <div class="row clearfix survey-info-holder">
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 date-pick-box">
              <div class="inner-border-box">
                <div class="box-inline">
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Date</label>
                    <div id="datetimepicker1" class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12">
                      <input type="text" value='#DateTimeFormat(qSurveys.Date, "MM/dd/YYYY")#' name="ProjectDate"  placeholder="mm/dd/yyyy" class="form-control"  >
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label m-b-10">Engine On</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12 m-b-10" id="datetimepicker_enginestart">
                      <input type="text" value="#TimeFormat(qSurveys.EngineOn, "HH:nn")#" placeholder="hh:mm" name="EngineOn" id="EngineOn" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Survey Start</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_srvystrt">
                      <input type="text" value="#TimeFormat(qSurveys.SurveyStart, "HH:nn")#"  placeholder="hh:mm" name="SurveyStart" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                </div>
                <div class="box-inline second"> 
                  <div class="form-group next-check">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Engine Off</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_engineoff">
                      <input type="text" value="#TimeFormat(qSurveys.EngineOff, "HH:nn")#" placeholder="hh:mm" name="EngineOff" id="EngineOff" class="form-control" />
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-4 col-md-5 col-sm-12 col-xs-12 control-label">Survey End</label>
                    <div class="input-group date col-lg-8 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_srvyend">
                      <input type="text" value="#TimeFormat(qSurveys.SurveyEnd, "HH:nn")#"  placeholder="hh:mm" name="SurveyEnd"class="form-control" />
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
                    <select class="form-control search-box" multiple="multiple" name="ResearchTeam" id="ResearchTeam">
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
                    <select class="form-control search-box" multiple="multiple" name="SurveyRoute">
                      <cfloop query="getSurveyRouteData">
                        <cfif active eq 1 or (active eq 0 and ListFind(getSurveyRoutes,getSurveyRouteData.ID))>
                        <option value="#getSurveyRouteData.ID#" <cfif ListFind(getSurveyRoutes,getSurveyRouteData.ID)>selected</cfif> >#getSurveyRouteData.RouteName#</option>
                          </cfif>
                      </cfloop>
                    </select>
                  </div>
                </div>
                  <div class="form-group first-tab">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Body of Water</button>
                    </div>
                    <select class="form-control search-box" multiple="multiple" name="BodyOfWater">
                      <cfloop query="getSurveyAreaData">
                        <cfif active eq 1 or (active eq 0 and ListFind(getSurveyAreas,getSurveyAreaData.ID))>
                        <option value="#getSurveyAreaData.ID#" <cfif ListFind(getSurveyAreas,getSurveyAreaData.ID)>selected</cfif> >#getSurveyAreaData.AreaName#</option>
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
                    <select class="combobox form-control" name="Platform" id="plateform_value" onChange='EngOnOff()'>
                      <option value="">Select Platform</option>
                      <cfloop query="getPlateForm">
                        <cfif active eq 1 OR (active eq 0 and qSurveys.Platform eq getPlateForm.Name)>
                            <option class="plateform_value" value="#getPlateForm.Name#" <cfif qSurveys.Platform EQ getPlateForm.Name>selected</cfif>>#getPlateForm.Name#</option>
                        </cfif>    
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group first-tab">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">NOAA Stock</button>
                    </div>
                    <select class="form-control search-box" name="NOAAStock" id="stock_value" multiple="multiple">
                      <cfloop query="getStock">
                        <cfif active eq 1 OR (active eq 0 and ListFind(getSelectedStockValues,getStock.ID))>
                            <option class="stock_value" value="#getStock.ID#" <cfif ListFind(getSelectedStockValues,getStock.ID)>selected</cfif>>#getStock.StockName#</option>
                        </cfif>    
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Survey Type</button>
                    </div>
                    <select class="combobox form-control" name="SurveyType" id="Type" onChange='EngOnOff()'>
                      <option value="">Select Survey Type</option>
                      <cfloop query="getType">
                        <cfif active eq 1 OR (active eq 0 and qSurveys.SurveyType eq getType.Type)>
                            <option class="area_value" value="#getType.Type#" <cfif qSurveys.SurveyType EQ getType.Type>selected</cfif>>#getType.Type#</option>
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
                              <input type="radio" name="Survey" id="rememberMe" class="float-left radioCustomReset"  value="On" <cfif qGetSightings.Survey eq 'On'>checked</cfif> >
                              <label class="float-left font_size_14" for="rememberMe">ON</label>
                            </div>
                            <div class="checkbox-new">
                              <input type="radio" name="Survey" value="Off"  id="rememberMe1" class="float-left radioCustomReset" <cfif qGetSightings.Survey eq 'Off'>checked</cfif> >
                              <label class="float-left font_size_14" for="rememberMe">OFF</label>
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting No</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.SightingNumber#"  name="SightingNumber" class="form-control inputCustomReset"/>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting Start</label>
                          <div class="input-group date col-lg-7 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_sightingstrt">
                            <input type="text" value="#TimeFormat(qGetSightings.SightingStart, 'HH:nn')#"  placeholder="hh:mm" name="SightingStart"class="form-control inputCustomReset" />
                            <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                        </div>
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Sighting End</label>
                          <div class="input-group date col-lg-7 col-md-7 col-sm-12 col-xs-12" id="datetimepicker_sightingend">
                            <input type="text" value="#TimeFormat(qGetSightings.SightingEnd, 'HH:nn')#"  placeholder="hh:mm" name="SightingEnd" class="form-control inputCustomReset"  />
                            <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span> </div>
                        </div>
                        <div class="form-group">
                          <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">At ICW Marker</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.ICW_Start#"  name="ICW_Start" class="form-control inputCustomReset"/>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <div class="inline-boxes">
                      <div class="form-group">
                        <label>Location</label>
                        <textarea class="form-control textareaCustomReset" name="Location" maxlength="75">#qGetSightings.Location#</textarea>
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="inline-boxes">
                      <div class="box-inline second">
                        <div class="form-group next-check">
                          <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Initial Lattitude</label>
                          <label class="col-lg-1 col-md-1 col-sm-12 col-xs-12 control-label">N</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.InitialLatitude#" onblur="checkValue(this)" name="InitialLatitude" id="InitialLatitude" class="form-control bg-color inputCustomReset" />
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">Initial Longitude</label>
                          <label class="col-lg-1 col-md-1 col-sm-12 col-xs-12 control-label">W</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.InitialLongitude#" onblur="checkValue(this)"  name="InitialLongitude" id="InitialLongitude" class="form-control bg-color inputCustomReset"/>
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label map-lat-lng">At Lattitude</label>
                          <label class="col-lg-1 col-md-1 col-sm-12 col-xs-12 control-label">N</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.AtLatitude#" onblur="checkValue(this)"  name="AtLatitude" id="AtLatitude" class="form-control bg-color inputCustomReset" />
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label map-lat-lng">At Longitude</label>
                          <label class="col-lg-1 col-md-1 col-sm-12 col-xs-12 control-label">W</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.AtLongitude#" onblur="checkValue(this)"  name="AtLongitude" id="AtLongitude" class="form-control bg-color inputCustomReset"/>
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">End Lattitude</label>
                          <label class="col-lg-1 col-md-1 col-sm-12 col-xs-12 control-label">N</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.EndLatitude#"  name="EndLatitude" onblur="checkValue(this)" id="EndLatitude" class="form-control bg-color inputCustomReset" /> 
                          </div>
                        </div>
                        <div class="form-group next-check">
                          <label class="col-lg-4 col-md-4 col-sm-12 col-xs-12 control-label">End Longitude</label>
                          <label class="col-lg-1 col-md-1 col-sm-12 col-xs-12 control-label">W</label>
                          <div class="date-picker col-lg-7 col-md-7 col-sm-12 col-xs-12">
                            <input type="text" value="#qGetSightings.EndLongitude#"  name="EndLongitude" onblur="checkValue(this)" id="EndLongitude" class="form-control bg-color inputCustomReset"/>
                          </div>
                        </div>
                        <div class="form-group next-check">
                            <input type="button" class="btn btn-success" value="Validate" onclick="checkLatLng()">
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
                        <select class="form-control selectCustomReset" name="WaveHeight">
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
                        <select class="form-control selectCustomReset"  name="Weather" >
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
                        <select class="form-control selectCustomReset"  name="Glare" >
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
                        <select class="form-control selectCustomReset"  name="GlareDirection" >
                          <option value=""></option>
                          <cfset inc=0>
                          <cfloop query="getGlareDirection">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.GlareDirection eq getGlareDirection.id)>
                                <option value="#getGlareDirection.id#" <cfif qGetSightings.GlareDirection eq getGlareDirection.id>selected</cfif>>#inc# &nbsp;&nbsp;&nbsp; #getGlareDirection.Desc# </option>
                                <cfset inc=inc+1>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Sightability</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control selectCustomReset"  name="Sightability" >
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
                        <select class="form-control selectCustomReset" id="value" name="Beaufort" >
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
                      <input type="text" value="#qGetSightings.HabitatDepth#" name="HabitatDepth" id="HabitatDepth" onblur="checkValue(this)"  class="form-control inputCustomReset" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Habitat Type</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control selectCustomReset" id="value" name="HabitatType">
                          <option value="0">Select</option>
                          <cfloop query="getHabitatList">
                            <cfif active eq 1 or (active eq 0 and qGetSightings.HabitatType eq HabitatID)>
                              <option value="#HabitatID#" <cfif qGetSightings.HabitatType eq #HabitatID#>selected</cfif>>#HabitatName#</option>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Air Temp</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.AirTemp#" id="AirTemp" name="AirTemp" onblur="checkValue(this)"  class="form-control inputCustomReset" />
                        <!---<input type="number" value="<cfif qGetSightings.AirTemp neq "">#numberFormat(qGetSightings.AirTemp,'__.0')#</cfif>" name="AirTemp"  class="form-control inputCustomReset" />--->
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Water Temp</label>
                      <div class="input col-lg-5 col-md-9 col-sm-12 col-xs-12">
                         <input type="text" value="#qGetSightings.WaterTemp#" name="WaterTemp" id="WaterTemp" onblur="checkValue(this)"  class="form-control inputCustomReset" /> 
                       <!--- <input type="number" value="<cfif qGetSightings.WaterTemp neq "">#numberFormat(qGetSightings.WaterTemp,'__.0')#</cfif>" name="WaterTemp"  class="form-control inputCustomReset" />--->
                      </div>
                    </div>
                  </div>
                  <div class="radio-inline right">
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Wind Speed</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.WindSpeed#" name="WindSpeed" id="WindSpeed" onblur="checkValue(this)"  class="form-control inputCustomReset"  />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Wind Direction</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control selectCustomReset"  name="WindDirection" >
                          <option value=""></option>
                          <cfset inc=0>
                          <cfloop query="getGlareDirection">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.WindDirection eq getGlareDirection.id)>
                                <option value="#getGlareDirection.id#" <cfif qGetSightings.WindDirection eq getGlareDirection.id>selected</cfif>>#inc# &nbsp;&nbsp;&nbsp; #getGlareDirection.Desc# </option>
                                <cfset inc=inc+1>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Tide</label>
                          <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                            <select class="form-control selectCustomReset" id="value" name="Tide">
                              <option value="0">Select</option>
                                <cfloop query="TideList">
                                  <cfif active eq 1 or (active eq 0 and qGetSightings.Tide eq TideID)>
                                    <option value="#TideID#" <cfif qGetSightings.Tide eq #TideID#>selected</cfif>>#TideName#</option>
                                  </cfif>
                                </cfloop>
                            </select>
                          </div>
                      </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Salinity</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.Salinity#" name="Salinity" id="Salinity" onblur="checkValue(this)" class="form-control inputCustomReset" />
                      </div>
                    </div>

                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">pH</label>
                        <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.pH#" name="pH" id="pH" onblur="checkValue(this)" class="form-control inputCustomReset" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">DO</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.DO#" name="DO" id="DO" onblur="checkValue(this)" class="form-control inputCustomReset" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Conductivity</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.Conductivity#" name="Conductivity" id="Conductivity" onblur="checkValue(this)"  class="form-control inputCustomReset" />
                      </div>
                    </div>

                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Initial Heading</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control selectCustomReset" id="value" name="InitialHeading" >
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
                        <select class="form-control selectCustomReset" id="value" name="GeneralHeading" >
                          <option value="0"></option>
                          <cfloop query="qGetGHeadingData">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.GeneralHeading eq qGetGHeadingData.id)>
                                <option value="#qGetGHeadingData.id#" <cfif qGetSightings.GeneralHeading eq qGetGHeadingData.id>selected</cfif>> #qGetGHeadingData.GHeadingName# </option>
                            </cfif>
                          </cfloop>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">Final Heading</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control selectCustomReset" id="value" name="FinalHeading" >
                          <option value="0"></option>
                          <cfloop query="qGetFHeadingData">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.FinalHeading eq qGetFHeadingData.id)>
                                <option value="#qGetFHeadingData.id#" <cfif qGetSightings.FinalHeading eq qGetFHeadingData.id>selected</cfif>> #qGetFHeadingData.FHeadingName# </option>
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
                      <select class="form-control search-box selectCustomReset" multiple="multiple" name="AssocBio">
                        <cfloop query="qGetAssocBioData">
                          <cfif active eq 1 OR (active eq 0 and qGetAssocBioData.ASSOCBIOID eq qGetSightings.AssocBio)>
                          <option value="#qGetAssocBioData.ASSOCBIOID#" 
                          <cfif isdefined('form.sight_id') and form.sight_id GT 0> <cfif ListFind(getAssocBios,qGetAssocBioData.ASSOCBIOID)>selected</cfif>  </cfif>
                          >#qGetAssocBioData.ASSOCBIONAME#</option>
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
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <select class="form-control selectCustomReset"  name="FE_Species" >
                          <option value="36">Bottlenose Dolphin (Tursiops truncatus)</option>
                          <cfloop query="qgetCetaceanSpecies">
                            <cfif active eq 1 OR (active eq 0 and qGetSightings.FE_Species eq qgetCetaceanSpecies.id)>
                                <option value="#qgetCetaceanSpecies.id#" <cfif qGetSightings.FE_Species eq qgetCetaceanSpecies.id>selected</cfif>> #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                            </cfif>
                          </cfloop>
                        </select>
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
                      <div class="box_01">
                        <p><i>TAKES</i></p>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"> Total Cetaceans </label>
                      <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCetaceans_Min#" name="FE_TotalCetaceans_Min" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCetaceans_Max#" name="FE_TotalCetaceans_Max" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCetacean_Best#" name="FE_TotalCetacean_Best" class="form-control inputCustomReset"  />
                        </div>
                          <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCetacean_takes#" name="FE_TotalCetacean_takes" class="form-control inputCustomReset"  />
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"> Total Adults </label>
                      <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalAdults_Min#" name="FE_TotalAdults_Min" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalAdults_Max#" name="FE_TotalAdults_Max" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalAdults_Best#" name="FE_TotalAdults_Best" class="form-control inputCustomReset"  />
                        </div>
                          <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalAdults_takes#" name="FE_TotalAdults_takes" class="form-control inputCustomReset"  />
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label"> Total Calves</label>
                      <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCalves_Min#" name="FE_TotalCalves_Min" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCalves_Max#" name="FE_TotalCalves_Max" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCalves_Best#" name="FE_TotalCalves_Best" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_TotalCalves_takes#" name="FE_TotalCalves_takes" class="form-control inputCustomReset"  />
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 col-xs-12 control-label">Young of The Year</label>
                      <div class="inline-box col-lg-7 col-md-7 col-sm-12 input-box">
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_YoungOfYear_Min#" name="FE_YoungOfYear_Min" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_YoungOfYear_Max#" name="FE_YoungOfYear_Max" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_YoungOfYear_Best#" name="FE_YoungOfYear_Best" class="form-control inputCustomReset"  />
                        </div>
                        <div class="box_01">
                          <input type="text" value="#qGetSightings.FE_YoungOfYear_takes#" name="FE_YoungOfYear_takes" class="form-control inputCustomReset"  />
                        </div>
                      </div>
                    </div>
                </div>
              </div>
              <div class="inner-border-box">
                <label>Activity</label>
                <div class="form-group activity-top-40">
                  <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 input-box">
                      <div class="box_02"> Mill
                        <select class="form-control select_activity selectCustomReset" data-old="" id="value0" name="Act_Mill">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Mill eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Feed
                        <select class="form-control select_activity selectCustomReset"  id="value1" name="Act_Feed">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Feed eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Prob. Feed
                        <select class="form-control select_activity selectCustomReset"  id="value2" name="Act_Prob_Feed">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Prob_Feed eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Travel
                        <select class="form-control select_activity selectCustomReset"  id="value3" name="Act_Travel">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Travel eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02">Object Play
                        <select class="form-control select_activity selectCustomReset"  id="value4" name="Act_Object_Play">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Object_Play eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Rest
                        <select class="form-control select_activity selectCustomReset"  id="value5" name="Act_Rest">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Rest eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Social
                        <select class="form-control select_activity selectCustomReset"  id="value7" name="Act_Social">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Social eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> w/boat
                        <select class="form-control select_activity selectCustomReset"  id="value8" name="Act_With_Boat">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_With_Boat eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Avoid Boat
                        <select class="form-control select_activity selectCustomReset"  id="value10" name="Act_Avoid_Boat">
                          <option selected="" value=""></option>
                          <cfloop from="1" to="11" index="i">
                            <cfset i = i - 1 >
                            <option value="#i#" <cfif qGetSightings.Act_Avoid_Boat eq i>selected</cfif> >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_02"> Other
                        <select class="form-control select_activity selectCustomReset"  id="value9" name="Act_Other">
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
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 estimates-box second third">
              
              <div class="inner-border-box">
                <label>Cohesiveness</label>
                      </br>
                      <div class="row">
                        <div class="col-lg-5">
                          <div class="row">
                            <label class="col-lg-12 col-md-5 col-sm-12 control-label cohesiveness-label">Group</label>
                            <div class="form-group">
                              <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 meter-input">
                                <select class="form-control selectCustomReset"  name="groupeSelect1" >
                                  <option value="">Select Group</option>
                                  <cfdump var="#qGetSightings.groupeSelect1#">
                                  <option value="main" <cfif qGetSightings.groupeSelect1 eq "main">selected</cfif>>Main</option>
                                  <option value="sub" <cfif qGetSightings.groupeSelect1 eq "sub">selected</cfif>>Sub</option>
                                </select>
                              </div>
                              <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 meter-input">
                                <select class="form-control selectCustomReset"  name="groupeSelect2" >
                                  <option value="">Select Group</option>
                                  <option value="main" <cfif qGetSightings.groupeSelect2 eq "main">selected</cfif>>Main</option>
                                  <option value="sub" <cfif qGetSightings.groupeSelect2 eq "sub">selected</cfif>>Sub</option>
                                </select>
                              </div>
                              <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 meter-input">
                                <select class="form-control selectCustomReset"  name="groupeSelect3" >
                                  <option value="">Select Group</option>
                                  <option value="main" <cfif qGetSightings.groupeSelect3 eq "main">selected</cfif>>Main</option>
                                  <option value="sub" <cfif qGetSightings.groupeSelect3 eq "sub">selected</cfif>>Sub</option>
                                </select>
                              </div>
                              <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 meter-input">
                                <select class="form-control selectCustomReset"  name="groupeSelect4" >
                                  <option value="">Select Group</option>
                                  <option value="main" <cfif qGetSightings.groupeSelect4 eq "main">selected</cfif>>Main</option>
                                  <option value="sub" <cfif qGetSightings.groupeSelect4 eq "sub">selected</cfif>>Sub</option>
                                </select>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="col-lg-7">
                          <div class="row">
                            <label class="col-lg-12 col-md-5 col-sm-12 control-label cohesiveness-label">Distance</label>
                            <div class="form-group">
                              <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 meter-input">
                                <select class="form-control selectCustomReset"  name="distanceSelect1" >
                                  <option value="">Select Distance</option>
                                  <option value="0-10" <cfif qGetSightings.distanceSelect1 eq "0-10">selected</cfif>>0 to 10</option>
                                  <option value="10-50" <cfif qGetSightings.distanceSelect1 eq "10-50">selected</cfif>>10 to 50</option>
                                  <option value="50-100" <cfif qGetSightings.distanceSelect1 eq "50-100">selected</cfif>>50 to 100</option>
                                </select>
                                <label class="cohesiveness-label">meters</label>
                              </div>
                              <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 meter-input">
                                <select class="form-control selectCustomReset"  name="distanceSelect2" >
                                  <option value="">Select Distance</option>
                                  <option value="0-10" <cfif qGetSightings.distanceSelect2 eq "0-10">selected</cfif>>0 to 10</option>
                                  <option value="10-50" <cfif qGetSightings.distanceSelect2 eq "10-50">selected</cfif>>10 to 50</option>
                                  <option value="50-100" <cfif qGetSightings.distanceSelect2 eq "50-100">selected</cfif>>50 to 100</option>
                                </select>
                                <label class="cohesiveness-label">meters</label>
                              </div>
                              <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 meter-input">
                                <select class="form-control selectCustomReset"  name="distanceSelect3" >
                                  <option value="">Select Distance</option>
                                  <option value="0-10" <cfif qGetSightings.distanceSelect3 eq "0-10">selected</cfif>>0 to 10</option>
                                  <option value="10-50" <cfif qGetSightings.distanceSelect3 eq "10-50">selected</cfif>>10 to 50</option>
                                  <option value="50-100" <cfif qGetSightings.distanceSelect3 eq "50-100">selected</cfif>>50 to 100</option>
                                </select>
                                <label class="cohesiveness-label">meters</label>
                              </div>
                              <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 meter-input">
                                <select class="form-control selectCustomReset"  name="distanceSelect4" >
                                  <option value="">Select Distance</option>
                                  <option value="0-10" <cfif qGetSightings.distanceSelect4 eq "0-10">selected</cfif>>0 to 10</option>
                                  <option value="10-50" <cfif qGetSightings.distanceSelect4 eq "10-50">selected</cfif>>10 to 50</option>
                                  <option value="50-100" <cfif qGetSightings.distanceSelect4 eq "50-100">selected</cfif>>50 to 100</option>
                                </select>
                                <label class="cohesiveness-label">meters</label>
                              </div>
                            </div>
                          </div>
  
                        </div>
                      </div>
                </div>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6 col-md-4 col-sm-12 col-xs-12 condition-box">
              <div class="inner-border-box">
                <label>Dive Times</label><br><br>
                <div class="form-group">
                  <div class="radio-inline">
                      <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="row">
                          <div class="col-md-5">
                            <div class="form-group">
                              <div class="input-group  col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
                                <p><b>Start Time</b></p>
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="col-lg-3 col-md-4 col-sm-12 col-xs-12 control-label">Dive 1</label>
                              <div class="input-group  col-lg-9 col-md-8 col-sm-12 col-xs-12" id="StratTimeDive1">
                                <input tabindex="1" type="text" value="#qGetSightings.StratTimeDive1#" placeholder="hh:mm:ss" name="StratTimeDive1" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="col-lg-3 col-md-4 col-sm-12 col-xs-12 control-label">Dive 2</label>
                              <div class="input-group  col-lg-9 col-md-8 col-sm-12 col-xs-12" id="StratTimeDive2">
                                <input tabindex="3" type="text" value="#qGetSightings.StratTimeDive2#" placeholder="hh:mm:ss" name="StratTimeDive2" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="col-lg-3 col-md-4 col-sm-12 col-xs-12 control-label">Dive 3</label>
                              <div class="input-group  col-lg-9 col-md-8 col-sm-12 col-xs-12" id="StratTimeDive3">
                                <input tabindex="5" type="text" value="#qGetSightings.StratTimeDive3#" placeholder="hh:mm:ss" name="StratTimeDive3" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="col-lg-3 col-md-4 col-sm-12 col-xs-12 control-label">Dive 4</label>
                              <div class="input-group  col-lg-9 col-md-8 col-sm-12 col-xs-12" id="StratTimeDive4">
                                <input tabindex="7" type="text" value="#qGetSightings.StratTimeDive4#" placeholder="hh:mm:ss" name="StratTimeDive4" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="col-lg-3 col-md-4 col-sm-12 col-xs-12 control-label">Dive 5</label>
                              <div class="input-group  col-lg-9 col-md-8 col-sm-12 col-xs-12" id="StratTimeDive5">
                                <input tabindex="9" type="text" value="#qGetSightings.StratTimeDive5#" placeholder="hh:mm:ss" name="StratTimeDive5" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            
                          </div>
                          <div class="col-md-4">
                            <div class="form-group">
                              <div class="input-group  col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
                                <p><b>End Time</b></p>
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="EndTimeDive1">
                                <input tabindex="2" type="text" value="#qGetSightings.EndTimeDive1#" placeholder="hh:mm:ss" name="EndTimeDive1" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="EndTimeDive2">
                                <input tabindex="4" type="text" value="#qGetSightings.EndTimeDive2#" placeholder="hh:mm:ss" name="EndTimeDive2" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="EndTimeDive3">
                                <input tabindex="6" type="text" value="#qGetSightings.EndTimeDive3#" placeholder="hh:mm:ss" name="EndTimeDive3" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="EndTimeDive4">
                                <input tabindex="8" type="text" value="#qGetSightings.EndTimeDive4#" placeholder="hh:mm:ss" name="EndTimeDive4" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="EndTimeDive5">
                                <input tabindex="10" type="text" value="#qGetSightings.EndTimeDive5#" placeholder="hh:mm:ss" name="EndTimeDive5" class="form-control" />
                                <span class="input-group-addon"> <span class="glyphicon glyphicon-time"></span> </span>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-3">
                            <div class="form-group">
                              <div class="input-group  col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
                                <p><b>Total Time</b></p>
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="TotalTimeDive1">
                                <input  type="text" value="#qGetSightings.TotalTimeDive1#" placeholder="hh:mm:ss" name="TotalTimeDive1" class="form-control" readonly/>
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="TotalTimeDive2">
                                <input  type="text" value="#qGetSightings.TotalTimeDive2#" placeholder="hh:mm:ss" name="TotalTimeDive2" class="form-control" readonly />
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="TotalTimeDive3">
                                <input  type="text" value="#qGetSightings.TotalTimeDive3#" placeholder="hh:mm:ss" name="TotalTimeDive3" class="form-control" readonly/>
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="TotalTimeDive4">
                                <input  type="text" value="#qGetSightings.TotalTimeDive4#" placeholder="hh:mm:ss" name="TotalTimeDive4" class="form-control" readonly />
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="input-group" id="TotalTimeDive5">
                                <input  type="text" value="#qGetSightings.TotalTimeDive5#" placeholder="hh:mm:ss" name="TotalTimeDive5" class="form-control" readonly/>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-12 col-xs-12 condition-box">
              <div class="inner-border-box behvr-spec">
                <label>Behavioral Specifics</label><br><br>
                <div class="input col-lg-12 col-md-12 col-sm-12 col-xs-12 p-0">
                  <table>
                    <tr>
                      <th><p>Behavioral Event</p></th>
                      <th><p><b>Number</b></p></th>
                    </tr>
                    <tr>
                      <td>
                        <div class="col-lg-12 ">
                          <select class="form-control selectCustomReset" id="value" name="BehavioralSpecifics1"> 
                            <option value="0">Select </option>
                            <cfloop query="getBehaviorsData">
                              <option value="#getBehaviorsData.ID#" 
                                <cfif isdefined('form.sight_id') and form.sight_id GT 0> <cfif #qGetSightings.BehavioralSpecifics1# eq "#getBehaviorsData.ID#">selected</cfif> </cfif> 
                                >#getBehaviorsData.BehaviorName#
                              </option>
                            </cfloop>
                          </select>
                        </div>
                      </td>
                      <td>
                        <div class="input col-lg-12 ">
                          <input type="number" min="0" value="#qGetSightings.BehavioralSpecificsN1#" name="BehavioralSpecificsN1" class="form-control inputCustomReset">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <div class="col-lg-12 ">
                          <select class="form-control selectCustomReset" id="value" name="BehavioralSpecifics2"> 
                            <option value="0">Select </option>
                            <cfloop query="getBehaviorsData">
                              <option value="#getBehaviorsData.ID#" 
                                <cfif isdefined('form.sight_id') and form.sight_id GT 0> <cfif #qGetSightings.BehavioralSpecifics2# eq "#getBehaviorsData.ID#">selected</cfif> </cfif> 
                                >#getBehaviorsData.BehaviorName#
                              </option>
                            </cfloop>
                          </select>
                        </div>
                      </td>
                      <td>     
                        <div class="input col-lg-12 ">
                          <input type="number" min="0" value="#qGetSightings.BehavioralSpecificsN2#" name="BehavioralSpecificsN2" class="form-control inputCustomReset">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <div class="col-lg-12 ">
                          <select class="form-control selectCustomReset" id="value" name="BehavioralSpecifics3"> 
                            <option value="0">Select </option>
                              <cfloop query="getBehaviorsData">
                                <option value="#getBehaviorsData.ID#" 
                                  <cfif isdefined('form.sight_id') and form.sight_id GT 0> <cfif #qGetSightings.BehavioralSpecifics3# eq "#getBehaviorsData.ID#">selected</cfif> </cfif> 
                                  >#getBehaviorsData.BehaviorName#
                                </option>
                              </cfloop>
                            </select>
                        </div>
                      </td>
                      <td>
                        <div class="input col-lg-12 ">
                          <input type="number" min="0" value="#qGetSightings.BehavioralSpecificsN3#" name="BehavioralSpecificsN3" class="form-control inputCustomReset">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <div class="col-lg-12 ">
                          <select class="form-control selectCustomReset" id="value" name="BehavioralSpecifics4"> 
                            <option value="0">Select </option>
                              <cfloop query="getBehaviorsData">
                                <option value="#getBehaviorsData.ID#" 
                                  <cfif isdefined('form.sight_id') and form.sight_id GT 0> <cfif #qGetSightings.BehavioralSpecifics4# eq "#getBehaviorsData.ID#">selected</cfif> </cfif> 
                                  >#getBehaviorsData.BehaviorName#
                                </option>
                              </cfloop>
                            </select>
                        </div>
                      </td>
                      <td>
                        <div class="input col-lg-12 ">
                          <input type="number" min="0" value="#qGetSightings.BehavioralSpecificsN4#" name="BehavioralSpecificsN4" class="form-control inputCustomReset">
                          </div>
                      </td>
                    </tr>
                  </table>    
                </div>    
              </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-12 col-xs-12 condition-box">
              <div class="inner-border-box">
                <label>Feeding Ecology</label><br><br>
                  <div class="form-group">
                    <div class="input-group">
                    <div class="input-group-btn">
                      <button class="btn btn-inverse" type="button">Prey Species</button>
                    </div>
                      <select class="form-control search-box selectCustomReset" multiple="multiple" name="PreySpeciesName">
                      <cfloop query="getPreySpeciesData">
                        <option value="#getPreySpeciesData.ID#"
                          <cfif isdefined('form.sight_id') and form.sight_id GT 0> <cfif ListFind(getPreySpecies,getPreySpeciesData.ID)>selected</cfif> </cfif>
                          >#getPreySpeciesData.PreySpeciesName#</option>
                      </cfloop>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-6 col-md-6 col-sm-6 control-label"><strong> Feeding Latitude</strong> </label>
                    <label class="col-lg-1 col-md-1 col-sm-6 control-label">N </label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="text" value="#qGetSightings.Feeding_Lat#"  name="Feeding_Lat" class="form-control inputCustomReset"/>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-6 col-md-6 col-sm-6 control-label"><strong>Feeding Longitude</strong>  </label>
                  <label class="col-lg-1 col-md-1 col-sm-6 control-label">W</label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <input type="text" value="#qGetSightings.Feeding_Long#"  name="Feeding_Long" class="form-control inputCustomReset"/>
                  </div>
                </div>
                <br><br>
                <div class="form-group">
                  <label class="col-lg-7 col-md-5 col-sm-6 control-label"><strong>Structure Present</strong></label>
                  <div class="input col-lg-5 col-md-9 col-sm-6 col-xs-6">
                    <select class="form-control selectCustomReset" id="value" name="Structure_Present">
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
          </div>
          <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 condition-box">
              <div class="inner-border-box">
                <label>Fisheries Interactions</label><br><br>
                <div class="form-group">
                  <div class="radio-inline">
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">No. of Cetaceans w/in 100m of Active Fisher</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.NoOfCetaceansWithIn100mOfActiveFisher#" name="NoOfCetaceansWithIn100mOfActiveFisher"  class="form-control inputCustomReset"  />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label">No. of Fishers/Platforms</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <input type="text" value="#qGetSightings.NoOfFishers#" name="NoOfFishers"  class="form-control inputCustomReset"  />
                      </div>
                    </div>
                    <div class="form-group">
                      <br>
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label FisherResponsetofromCetacean">Cetacean Response to Fisher</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <div class="row sp">
                          <div class="row">
                            <div class="col-md-7">
                            </div>
                            <div class="col-md-5">
                              <p><b>Number</b></p>
                            </div>
                          </div>
                          <div class="col-md-7">
                            <input type="text" value="Approach"  class="form-control"  readonly />
                            <input type="text" value="Neutral"   class="form-control"  readonly/>
                            <input type="text" value="Relocate"  class="form-control"  readonly/>
                          </div>
                          <div class="col-md-5">
                            <input type="number" min="0" value="#qGetSightings.CetaceanResponsetoFisher1#" name="CetaceanResponsetoFisher1"  class="form-control"  />
                            <input type="number" min="0" value="#qGetSightings.CetaceanResponsetoFisher2#" name="CetaceanResponsetoFisher2"  class="form-control"  />
                            <input type="number" min="0" value="#qGetSightings.CetaceanResponsetoFisher3#" name="CetaceanResponsetoFisher3"  class="form-control"  />
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <br>
                      <label class="col-lg-5 col-md-5 col-sm-12 control-label FisherResponsetofromCetacean">Fisher Response to Cetacean</label>
                      <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                        <div class="row sp">
                          <div class="col-md-7">
                            <input type="text" value="Approach"  class="form-control" readonly />
                            <input type="text" value="No Response"   class="form-control"  readonly/>
                            <input type="text" value="Pull in Line"  class="form-control"  readonly/>
                            <input type="text" value="Relocate"  class="form-control"  readonly/>
                          </div>
                          <div class="col-md-5">
                            <input type="number" min="0" value="#qGetSightings.FisherResponsetoCetacean1#" name="FisherResponsetoCetacean1"  class="form-control"  />
                            <input type="number" min="0" value="#qGetSightings.FisherResponsetoCetacean2#" name="FisherResponsetoCetacean2"  class="form-control"  />
                            <input type="number" min="0" value="#qGetSightings.FisherResponsetoCetacean3#" name="FisherResponsetoCetacean3"  class="form-control"  />
                            <input type="number" min="0" value="#qGetSightings.FisherResponsetoCetacean4#" name="FisherResponsetoCetacean4"  class="form-control"  />
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <br>
                        <label class="col-lg-5 col-md-5 col-sm-12 control-label">Depredation</label>
                        <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                          <select class="form-control selectCustomReset" id="value" name="Depredation">
                            <option value=""></option>
                            <option value="High" <cfif qGetSightings.Depredation eq 'High'>selected</cfif> >Yes</option>
                            <option value="Low" <cfif qGetSightings.Depredation eq 'Low'>selected</cfif> >No</option>
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
                      <input type="text" value="#qGetSightings.NoOfCetaceansWithIn100mOfRecreationVessels#" name="NoOfCetaceansWithIn100mOfRecreationVessels"  class="form-control inputCustomReset"  />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label">No. of Vessels</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <input type="text" value="#qGetSightings.NumberOfVessels#" name="NumberOfVessels"  class="form-control inputCustomReset"  />
                    </div>
                  </div>
                  <div class="form-group">
                    <br>
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label FisherResponsetofromCetacean">Cetacean Response to Vessel</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div class="row sp">
                        <div class="row">
                          <div class="col-md-7">
                          </div>
                          <div class="col-md-5">
                            <p><b>Number</b></p>
                          </div>
                        </div>
                        <div class="col-md-7">
                          <input type="text" value="Approach"  class="form-control" readonly />
                          <input type="text" value="Neutral"   class="form-control"  readonly/>
                          <input type="text" value="Relocate"  class="form-control"  readonly/>
                        </div>
                        <div class="col-md-5">
                          <input type="number" min="0" value="#qGetSightings.CetaceanResponsetoVessel1#" name="CetaceanResponsetoVessel1"  class="form-control"  />
                          <input type="number" min="0" value="#qGetSightings.CetaceanResponsetoVessel2#" name="CetaceanResponsetoVessel2"  class="form-control"  />
                          <input type="number" min="0" value="#qGetSightings.CetaceanResponsetoVessel3#" name="CetaceanResponsetoVessel3"  class="form-control"  />
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <br>
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label FisherResponsetofromCetacean">Vessel Response to Cetacean</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div class="row sp">
                        <div class="col-md-7">
                          <input type="text" value="Approach"  class="form-control" readonly />
                          <input type="text" value="No Response"   class="form-control"  readonly/>
                          <input type="text" value="Out of Gear"  class="form-control"  readonly/>
                          <input type="text" value="Relocate"  class="form-control"  readonly/>
                        </div>
                        <div class="col-md-5">
                          <input type="number" min="0" value="#qGetSightings.VesselResponsetoCetacean1#" name="VesselResponsetoCetacean1"  class="form-control"  />
                          <input type="number" min="0" value="#qGetSightings.VesselResponsetoCetacean2#" name="VesselResponsetoCetacean2"  class="form-control"  />
                          <input type="number" min="0" value="#qGetSightings.VesselResponsetoCetacean3#" name="VesselResponsetoCetacean3"  class="form-control"  />
                          <input type="number" min="0" value="#qGetSightings.VesselResponsetoCetacean4#" name="VesselResponsetoCetacean4"  class="form-control"  />
                        </div>
                      </div>
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
                      <input type="text" value="#qGetSightings.No_of_Cetaceans_wHBOI_Vessel#" name="No_of_Cetaceans_wHBOI_Vessel"  class="form-control inputCustomReset"  />
                    </div>
                  </div>
                  <div class="form-group">
                    <br>
                    <label class="col-lg-5 col-md-5 col-sm-12 control-label FisherResponsetofromCetacean">Reaction to HBOI Vessel</label>
                    <div class="input col-lg-7 col-md-9 col-sm-12 col-xs-12">
                      <div class="row sp">
                        <div class="row">
                          <div class="col-md-7">
                          </div>
                          <div class="col-md-5">
                            <p><b>Number</b></p>
                          </div>
                        </div>
                        <div class="col-md-7">
                          <input type="text" value="Approach"  class="form-control" readonly />
                          <input type="text" value="Neutral"   class="form-control"  readonly/>
                          <input type="text" value="Relocate"  class="form-control"  readonly/>
                        </div>
                        <div class="col-md-5">
                          <input type="number" min="0" value="#qGetSightings.ReactiontoHBOIVessel1#" name="ReactiontoHBOIVessel1" class="form-control"  />
                          <input type="number" min="0" value="#qGetSightings.ReactiontoHBOIVessel2#" name="ReactiontoHBOIVessel2" class="form-control"  />
                          <input type="number" min="0" value="#qGetSightings.ReactiontoHBOIVessel3#" name="ReactiontoHBOIVessel3" class="form-control"  />
                        </div>
                      </div>
                    </div>
                  </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row  m-b-10">
              <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Camera</button>
                </div>
                <select class="combobox form-control selectCustomReset" id="Camera" name="Camera">
                  <cfif len(trim(getSelectedCamera.Camera)) EQ 0>
                    <option value="">Select Camera</option>
                    <cfelse>
                    <option value="#getSelectedCamera.ID#">#getSelectedCamera.Camera#</option>
                  </cfif>
                  <cfloop query="cameralist">
                  <cfif active EQ 1>
                      <option  data-id="#cameralist.id#" value="#cameralist.id#">#cameralist.Camera#</option>
                    </cfif>
                  </cfloop>
                </select>
              </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
              <div class="input-group m-b-15">
                <div class="input-group-btn">
                  <button class="btn btn-inverse" type="button">Lens</button>
                </div>
                <select class="combobox form-control selectCustomReset" id="Lens" name="Lens">
                  <cfif len(trim(getSelectedLens.Lens)) EQ 0>
                    <option value="">Select Lens</option>
                    <cfelse>
                    <option value="#getSelectedLens.ID#">#getSelectedLens.Lens#</option>
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
                <select class="combobox form-control selectCustomReset" name="Photographer" id="Photographer">
                  <cfif len(trim(getSelectedGrapher.RT_MemberName)) EQ 0>
                    <option value="">Select Photographer</option>
                    <cfelse>
                    <option value="#getSelectedGrapher.RT_ID#">#getSelectedGrapher.RT_MemberName#</option>
                  </cfif>
                  <cfloop query="getTeams">
                    <cfif active eq 1 or (active eq 0 and ListFind(getteammember,getTeams.RT_ID))>
                      <option value="#getTeams.RT_ID#">#getTeams.RT_MemberName#</option>
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
                <select class="combobox form-control selectCustomReset" name="Driver">
                  <cfif len(trim(getSelectedDriver.RT_MemberName)) EQ 0>
                    <option value="">Select Driver</option>
                    <cfelse>
                    <option value="#getSelectedDriver.RT_ID#">#getSelectedDriver.RT_MemberName#</option>
                  </cfif>
                  <cfloop query="getTeams">
                    <cfif active eq 1 or (active eq 0 and ListFind(getteammember,getTeams.RT_ID))>
                      <option value="#getTeams.RT_ID#">#getTeams.RT_MemberName#</option>
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
                <textarea name="Comments" maxlength="512" id="comments" class="form-control textareaCustomReset" onkeydown="commentsCount()" placholder="Comment" >#qGetSightings.Comments#</textarea>
              </div>
              </div>
              <div>
              <strong><p id="count"></p></strong>
              </div>
            </div><br>
            <div class="col-md-12">
              <div class="form-group float-right completed-by">
                <strong>Completed By:</strong><input disabled type="text" value="#qGetSightings.EnteredBy#"  name="EnteredBy" id="EnteredBy" class="form-control">
              </div>
            </div>
          </div>
          <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>
            <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
            <cfif isdefined('form.sight_id') and form.sight_id neq 0>
              <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0>
                <input type="hidden" name="sight_id" value="#qGetSightings.ID#">
                <input type="submit" class="btn btn-success update set-btn-margin" id="update"  value="Update and Retain" name="update_data">
                <input type="submit" class="btn btn-success update set-btn-margin" id="update2" value="Update and Clear" name="update_data_clear">
                <input type="submit" class="btn btn-success update set-btn-margin" id="update2" value="Update Survey and Clear" name="update_data_clear_pro">
              </cfif>
              <cfif permissions eq "full_access" or findNoCase("Add Entry Data S-S-C", permissions) neq 0>
                <a class="btn btn-success sighting_required set-btn-margin test" href="##" data-toggle="modal" data-target="##cetacean"  onclick="empty_Lesions_history()">Cetacean</a>
              </cfif>
              <button type="button" class="btn btn-success set-btn-margin" id="btn_CS_history">Cetacean Sighting History</button>
              <cfif permissions eq "full_access" or findNoCase("Delete S-S-C", permissions) neq 0>
                <input type="button" id="sight_delete" class="btn btn-success set-btn-margin" name="sight_delete" value="Delete Sighting" onclick="sightingDelete()">
              </cfif>
            <cfelse>
              <cfif permissions eq "full_access" or findNoCase("Add Entry Data S-S-C", permissions) neq 0>
                <input type="submit" class="btn btn-success set-btn-margin" value="Save Sighting & Go To Cetacean Sighting" name="add_sighting">
                <input type="submit" class="btn btn-success set-btn-margin" value="Save Sighting & Go To Next Sighting" name="add_sighting_clear">
              </cfif>
              <cfif permissions eq "full_access" or findNoCase("Modify/Update S-S-C", permissions) neq 0>
                <input type="submit" class="btn btn-success update set-btn-margin" id="update2" value="Update Survey and Clear" name="update_data_clear_pro">
              </cfif>
              <a class="btn btn-success sighting_required set-btn-margin test123" href="##" data-toggle="modal" data-target="##cetacean">Cetacean</a>
              <button type="button" class="btn btn-success set-btn-margin" id="btn_CS_history">Cetacean Sighting History</button>
            </cfif>
          <cfelse>
            <cfif permissions eq "full_access" or findNoCase("Add Entry Data S-S-C", permissions) neq 0>
              <input type="submit" class="btn btn-success set-btn-margin after_add_survey" value="Save Sighting & Go To Cetacean Sighting" name="add_survey">
              <input type="submit" class="btn btn-success set-btn-margin after_add_survey" value="Save Sighting & Go To Next Sighting" name="add_survey_clear">
              <a class="btn btn-success sighting_required set-btn-margin testabx" href="##" data-toggle="modal" data-target="##cetacean">Cetacean</a>
            </cfif>
            <button type="button" class="btn btn-success set-btn-margin" id="btn_CS_history">Cetacean Sighting History</button>
          </cfif>
        </form>
          <form method="post" id="sightingDelete" onsubmit="return confirm('Do you really want to Delete Sighting?');">
            <input type="hidden" name="sighting_id" value="#qGetSightings.ID#">
            <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
            <input type="hidden" class="btn btn-success set-btn-margin" name="sight_delete" value="Delete Sighting">
          </form>
      </div>
      <!-- end row --> 
    </div>
  </div>
</cfoutput> 
<script>
  function sightingDelete() {
    $('#sightingDelete').submit();
  }
  // function checkValue(elm){
  //   value = elm.value;
  //   value = value.replace('.....','.');
  //   value = value.replace('....','.');
  //   value = value.replace('...','.');
  //   value = value.replace('..','.');
  //   ID = elm.id;
  //   $('#'+ID).val(value);
  //   // alert(elm.id);
  //   // return value;
  // }
  function checkValue(elm){
    value = elm.value;
    num = value.match(/\./g).length;
    for (let i = 0; i < num; i=i+10) {
          value = value.replace('.....','.');
          value = value.replace('....','.');
          value = value.replace('...','.');
          value = value.replace('..','.');
        }
    ID = elm.id;
    $('#'+ID).val(value);
  
    }
</script>
<!-- ================== END PAGE LEVEL JS ================== --> 
  <cfinclude template="../Dolphin/Biopsy.cfm">
<!---   <cfinclude template="dolphin.cfm"> --->
  <cfinclude template="Cetacean.cfm">
  <cfinclude template="NCSG.cfm">
  <cfinclude template="GoogleMap.cfm">
      