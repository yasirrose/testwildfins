<cfoutput>
<cfparam name="message" default="">
<cfif isdefined('form.ncsgform') >
<cfset update_ncsg = Application.Sighting.Update_NCSG(argumentCollection="#Form#")>
<cfif update_ncsg.RECORDCOUNT EQ 1>
<cfset message=" NCSG Record Updated ">
</cfif>
</cfif>
<cfif isdefined('form.ID') >
<cfset getNCSG = Application.Sighting.getNCSGByID(argumentCollection="#Form#")>
 </cfif>

 <!---------- Camera list------------>
 <cfset cameralist = Application.Sighting.getCamera()>		
        <div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">NCSG </li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Indian River Lagoon Photo-ID Sighting Sheet 
            <cfinclude template="SightingMenu.cfm"></h1>
			<!-- end page-header -->
       <!-- begin section-container -->
    <div class="section-container section-with-top-border p-b-5">
      <!-- begin row -->
      <form class="form-input-flat" id="ncsgform" method="post">
      <div class="row">
        <!-- begin col-4 -->
        <div class="col-md-12">
          <!-- begin panel -->
          <div class="panel p-20">
            
              <div class="row">
              <cfif len(trim(message)) GT 0 >
              <div class="alert alert-success">
              <strong>Success!</strong> #message#.
            </div>
			  </cfif>
                <div class="col-lg-4">
                  <div class="form-group">
                    <label>Photo Grade:</label>
                    <input type="text" placeholder="Photo Grade" name="photo_Grade" value="#getNCSG.photo_Grade#" class="form-control" required>
                  </div>
                </div>
                <div class="col-lg-4">
                  <div class="form-group" >
                    <label class="control-label">Date:</label>
                    <div class="input-group  datetimepicker" data-date-start-date="Date.default" data-date-format="mm-dd-yyyy">					<input type="text" class="form-control datetimepicker" value="#DateFormat(getNCSG.Date_Entered,'YYYY-MM-DD')#" name="Date_Entered" id="datepicker-default" placeholder="mm-dd-yyyy" required  />		  <span class="input-group-addon"> 
                    	<span class="glyphicon glyphicon-calendar"></span>
                     </span></div>
                     
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">Field Hours:</label>
                    <div class="input-group">
                      <input type="text" placeholder="Field Hour From" value="#getNCSG.FieldHours_from#" name="FieldHours_from" class="form-control" required>
                      <span class="input-group-addon">to</span>
                      <input type="text" placeholder="Field Hour To" value="#getNCSG.FieldHours_to#" name="FieldHours_to"  class="form-control" required>
                    </div>
                  </div>
                </div>
                <div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">Survey Hours:</label>
                    <div class="input-group">
                      <input type="text" placeholder="Hour Form" name="SurveyHour_from" value="#getNCSG.SurveyHour_from#" class="form-control" required>
                      <span class="input-group-addon">to</span>
                      <input type="text" placeholder="Hour To" name="SurveyHour_to" value="#getNCSG.SurveyHour_to#"  class="form-control" required>
                    </div>
                  </div>
                </div>
                <div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">Total Hours:</label>
                    <div id="datetimepicker_sightingend" class="input-group date col-lg-7 col-md-7 col-sm-12 col-xs-12">
                      <input type="text" required="" class="form-control" name="Totalhours" value="#getNCSG.Totalhours#"  data-fv-field="Sightingend">
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">Route:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" name="Rout" class="float-left" value="A" 
						<cfif getNCSG.Rout EQ 'A' > checked</cfif> data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">A</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" name="Rout" 
                        <cfif getNCSG.Rout EQ 'B' > checked</cfif> class="float-left" value="B" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">B</label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label">Effort:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" name="Effort"
                        <cfif getNCSG.Effort EQ 1 > checked</cfif> value="1" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">ON</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" name="Effort"
                         <cfif getNCSG.Effort EQ 0 > checked</cfif> value="0" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">OFF</label>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-4">
                  <div class="form-group has-feedback">
                    <label>Photographer:</label>
                    <textarea required="" name="Photographer" class="form-control" name="Photographer">#getNCSG.Photographer#</textarea>
                    <i style="display: none;" class="form-control-feedback" data-fv-icon-for="Location"></i> <small style="display: none;" class="help-block" data-fv-validator="notEmpty" data-fv-for="Location" data-fv-result="NOT_VALIDATED">Please enter a value</small></div>
                </div>
                
                <div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">Survey Time:</label>
                    <div class="input-group">
                      <input type="text" class="form-control timepickerStrt"
                       value="#DateFormat(getNCSG.SurveyTime_from,'hh:mm:ss')#" placeholder="HH:MM:SS" required  name="SurveyTime_from">
                      <span class="input-group-addon">to</span>
                      <input type="text" class="form-control timepickerEnd"
                      value="#DateFormat(getNCSG.SurveyTime_to,'hh:mm:ss')#" placeholder="HH:MM:SS" required name="SurveyTime_to">
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-lg-4">
                  <div class="form-group">
                    <label>Boat Name/Number:</label>
                    <input type="text" class="form-control" name="BoatNumber" value="#getNCSG.BoatNumber#" required placeholder="Boat Name/Number">
                  </div>
                </div>
                <div class="col-lg-4">
                  <div class="form-group">
                    <label>Recorder/Observers:</label>
                    <input type="text" class="form-control" name="record_observer" value="#getNCSG.record_observer#" required placeholder="Recorder/Observers">
                  </div>
                </div>
                <div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">Tide/ht:</label>
                    <div class="input-group location">
                      
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" data-fv-field="Survey" <cfif getNCSG.Tide EQ 'IN' > checked</cfif>
                         name="Tide" value="IN" class="float-left" required="">
                        <label class="float-left font_size_14" for="rememberMe">IN</label>
                      </div>
                      
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" data-fv-field="Survey" name="Tide" <cfif getNCSG.Tide EQ 'OUT' > checked</cfif> value="OUT" class="float-left" required="">
                        <label class="float-left font_size_14" for="rememberMe">OUT</label>
                      </div>
                      
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" data-fv-field="Survey" name="Tide" <cfif getNCSG.Tide EQ 'High' > checked</cfif>
                         value="High" class="float-left" required="">
                        <label class="float-left font_size_14" for="rememberMe">High</label>
                      </div>
                      
                      
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" data-fv-field="Survey" name="Tide" <cfif getNCSG.Tide EQ 'Low' > checked</cfif>
                         value="Low" class="float-left" required="">
                        <i data-fv-icon-for="Survey" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" style="pointer-events: none;"></i>
                        <label class="float-left font_size_14" for="rememberMe"> Low</label>
                      </div>
                      
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-lg-4">
                
                <div class="input-group">
                  <div class="input-group-btn">
                    <button class="btn btn-inverse" type="button">Camera</button>
                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false"> <span class="caret"></span> </button>
                    <ul class="dropdown-menu">
                      <cfloop query="cameralist">
                        <li><a  class="Camera_value" data-id="#cameralist.id#" value="#cameralist.Camera#">#cameralist.id# #cameralist.Camera#</a></li>
                      </cfloop>
                    </ul>
                  </div>
                  <div class="form-group">
                  <input type="text" class="form-control"  id="Camera_value" value="#getNCSG.Camera_used#" name="Camera_used" required>
               		</div>
                </div>
                
                
                </div>
                <div class="col-lg-4">
                  <div class="form-group">
                    <label>Photograph Folder ##:</label>
                    <input type="text" placeholder="Photograph Folder" name="Photographer_f" 
                    value="#getNCSG.Photographer_f#" class="form-control" required>
                  </div>
                </div>
              </div>
          </div>
          <div class="">
            
              <div class="row form-input-flat activity-sec">
			    <div class="row col-lg-8">
					<div class="col-lg-6">
                  <div class="form-group">
                    <label>Sighting No:</label>
                    <input type="text" placeholder="Sighting No" name="Sighting_number" value="#getNCSG.Sighting_number#" class="form-control" required>
                  </div>
                  <div class="form-group">
                    <label class="control-label">Time:</label>
                    <div class="input-group">
                      <input type="text" class="form-control timepickerStrt"  name="time_from" 
                      value="#DateFormat(getNCSG.time_from,'hh:mm:ss')#" placeholder="Time Start" required>
                      <span class="input-group-addon">to</span>
                      <input type="text" class="form-control timepickerEnd" name="time_to"
                      value="#DateFormat(getNCSG.time_to,'hh:mm:ss')#"  placeholder="Time End" required>
                    </div>
                  </div>
                  <div class="form-group">
                    <label>Location:</label>
                    <input type="text" placeholder="Location" name="Location" value="#getNCSG.Location#" class="form-control" required>
                  </div>
                  <div class="form-group">
                    <label>Habitat:</label>
                    <input type="text" placeholder="Habitat" name="Habitat" value="#getNCSG.Habitat#"  class="form-control" required>
                  </div>
                  <div class="form-group">
                    <label class="control-label">Heading:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" data-fv-field="Survey" name="Heading" 
                        <cfif getNCSG.Heading EQ 'Initial' > checked</cfif> value="Initial"  class="float-left" required="">
                        <label class="float-left font_size_14" for="rememberMe">Initial</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" data-fv-field="Survey" name="Heading"
                        <cfif getNCSG.Heading EQ 'General' > checked</cfif> value="General"  class="float-left" required="">
                        <i data-fv-icon-for="Survey" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" style="pointer-events: none;"></i>
                        <label class="float-left font_size_14" for="rememberMe">General</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" data-fv-field="Survey" 
                        <cfif getNCSG.Heading EQ 'Final' > checked</cfif> name="Heading" value="Final" class="float-left" required="">
                        <i data-fv-icon-for="Survey" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" style="pointer-events: none;"></i>
                        <label class="float-left font_size_14" for="rememberMe">Final</label>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6">
				 
				  	<table cellpadding="0" cellspacing="0" class="table dataTable no-footer dtr-inline  left-dlpn-tbl animal-tbl">
						<tr>
							<td>Initial WPT:</td>
							<td> <div class="form-group">
                            <input type="text" name="initail_WPT1" value="#getNCSG.initail_WPT1#" class="form-control" required>
                            </div></td>
							<td> <div class="form-group">
                            <input type="text" name="initail_WPT2" value="#getNCSG.initail_WPT2#" class="form-control" required>
                            </div></td>
						</tr>
						<tr>
							<td>At animal:</td>
							<td> <div class="form-group">
                            <input type="text" name="End_WPT1" value="#getNCSG.End_WPT1#" class="form-control" required>
                            </div></td>
							<td> <div class="form-group">
                            <input type="text" name="End_WPT2" value="#getNCSG.End_WPT2#" class="form-control" required>
                            </div></td>
						</tr>
						<tr>
							<td>End Wpt:</td>
							<td> <div class="form-group">
                            <input type="text" name="atanimal1" value="#getNCSG.atanimal1#" class="form-control" required>
                            </div></td>
							<td> <div class="form-group">
                            <input type="text" name="atanimal2" value="#getNCSG.atanimal2#" class="form-control" required>
                            </div></td>
						</tr>
					</table>	
                  <div class="form-group">
                    <label>ICW ##:</label>
                    <input type="text" placeholder="ICW" required name="ICW" value="#getNCSG.ICW#" class="form-control" required>
                  </div>
                  <div class="form-group">
                    <label>Transect:</label>
                    <input type="text" placeholder="Transect" name="Transect" value="#getNCSG.Transect#" required class="form-control" required>
                  </div>
                </div>
					<div class="col-lg-12">
					<div class="form-group">
                    <label class="control-label">Sighting Conditions:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox m-r-5 m-b-10">
                        <input type="radio" data-fv-field="Survey" <cfif getNCSG.sighting_conditions EQ 'Excellent' > checked</cfif>
                         name="sighting_conditions" value="Excellent"  required="">
                        <label class="float-left font_size_14" for="rememberMe">Excellent</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5 m-b-10">
                        <input type="radio" data-fv-field="Survey" name="sighting_conditions" 
						<cfif getNCSG.sighting_conditions EQ 'Good' > checked</cfif> value="Good" class="float-left" required="">
                        <i data-fv-icon-for="Survey" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" style="pointer-events: none;"></i>
                        <label class="float-left font_size_14 small_label" for="rememberMe">Good <small>(unlikely miss)</small></label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" data-fv-field="Survey" name="sighting_conditions" 
                        <cfif getNCSG.sighting_conditions EQ 'Fair' > checked</cfif> value="Fair"  class="float-left" required="">
                        <i data-fv-icon-for="Survey" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" style="pointer-events: none;"></i>
                        <label class="float-left font_size_14 small_label" for="rememberMe">Fair <small>(may miss)</small></label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" data-fv-field="Survey" <cfif getNCSG.sighting_conditions EQ 'Poor' > checked</cfif>
                         name="sighting_conditions" value="Poor" class="float-left" required="">
                        <i data-fv-icon-for="Survey" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" style="pointer-events: none;"></i>
                        <label class="float-left font_size_14 small_label" for="rememberMe">Poor <small>(likely miss)</small></label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label>Rating: (most prevalent)</label>
                    <input type="text" placeholder="Rating: (most prevalent)" value="#getNCSG.Rating#" name="Rating" class="form-control" required>
                  </div>
                  
                </div>
				</div>
                
                <div class="col-lg-4">
                  <div class="form-group">
				  	<div class="form-inline  m-b-5">
                    <label>Salinity (ppt):</label>
                    <input type="text" placeholder="Salinity (ppt)" name="salinity" value="#getNCSG.salinity#"  class="form-control  pull-right" required>
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>H2O Temp:</label>
                    <input type="text" placeholder="H2O Temp" name="H20_temp" value="#getNCSG.H20_temp#" class="form-control  pull-right" required>
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>Air Temp:</label>
                    <input type="text" placeholder="Air Temp" name="Air_temp" value="#getNCSG.Air_temp#" class="form-control  pull-right" required>
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>Conductivity:</label>
                    <input type="text" placeholder="Conductivity" name="Conductivity" value="#getNCSG.Conductivity#" class="form-control  pull-right" required>
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>Init. Depth (ft):</label>
                    <input type="text" placeholder="Init. Depth (ft)" name="InitailDepth" value="#getNCSG.InitailDepth#" class="form-control  pull-right" required>
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>B.SeaState:</label>
                    <input type="text" placeholder="B.SeaState" name="BSeaState" value="#getNCSG.BSeaState#" class="form-control  pull-right" required>
                  </div>
				  </div>
				  <div class="form-group">
				  <div class="form-inline m-b-5">
                    <label>Winds (mph):</label>
                    <input type="text" placeholder="Winds (mph)" name="Winds" value="#getNCSG.Winds#" class="form-control   pull-right" required>
                  </div>
				  </div>
				  <div class="form-group">
				  <div class="form-inline m-b-5">
                    <label>Water body:</label>
                    <input type="text" placeholder="Water body (ML/HAL/BR NIR)" value="#getNCSG.Waterbody#" name="Waterbody" class="form-control    pull-right" required>
                  </div></div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label class="control-label">Chop height:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" name="ChopHeight"
                        <cfif getNCSG.ChopHeight EQ 0 > checked</cfif>
                         value="0" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">0</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" 
                        <cfif getNCSG.ChopHeight EQ 1 > checked</cfif> name="ChopHeight" value="1" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">1</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" <cfif getNCSG.ChopHeight EQ 2 > checked</cfif> class="float-left" name="ChopHeight" value="2" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">2</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.ChopHeight EQ 3 > checked</cfif> name="ChopHeight" value="3" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">3</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.ChopHeight EQ 4 > checked</cfif> name="ChopHeight" value="4" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">4</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.ChopHeight EQ 5 > checked</cfif> name="ChopHeight" value="5" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">5</label>
                      </div>
                    </div>
                  </div>
				  </div>
				  <div class="form-group">
				  <div class="form-inline m-b-5">
                  
                    <label class="control-label">Cloud cover/weather:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox m-r-5 m-b-10">
                        <input type="radio" required="" class="float-left" name="CloudCover" 
						<cfif getNCSG.CloudCover EQ 'clear' > checked</cfif> value="clear" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">clear/few cl</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5 m-b-10">
                        <input type="radio" required="" <cfif getNCSG.CloudCover EQ 'pcloudy' > checked</cfif>
                         class="float-left" name="CloudCover" value="pcloudy" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">p cloudy</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5 m-b-10">
                        <input type="radio" required="" class="float-left" 
                        <cfif getNCSG.CloudCover EQ 'overcast' > checked</cfif> name="CloudCover" value="overcast" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">overcast</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.CloudCover EQ 'Rain' > checked</cfif>
                         name="CloudCover" value="Rain" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Rain</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.CloudCover EQ 'Tstorms' > checked</cfif>
                         name="CloudCover" value="Tstorms" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">T storms</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.CloudCover EQ 'Fog' > checked</cfif>
                         name="CloudCover" value="Fog" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Fog</label>
                      </div>
                    </div>
                  </div>
				  </div>
                  
                  <div class="form-group">
                    <label class="control-label">Glare:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" 
                        <cfif getNCSG.Glare EQ 'None' > checked</cfif> name="Glare" value="None" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">None</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" 
                        <cfif getNCSG.Glare EQ 'Little' > checked</cfif> name="Glare" value="Little" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Little</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Glare EQ 'Some' > checked</cfif>
                         name="Glare" value="Some" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Some</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Glare EQ 'Alot' > checked</cfif>
                         name="Glare" value="Alot" data-fv-field="Survey">

                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">A lot</label>
                      </div>
                    </div>
                  </div>
                  
                </div>
                <div class="col-lg-12">
					<div class="form-group">
                    <h4 class="form-header">Activity:</h4>
                    <div class="row">
                      <div class="col-lg-1 m-b-10">
                        <label>Mill</label>
                        <select class="form-control" name="Activity_Mill">
                        <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Mill EQ i > selected</cfif> >#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1 m-b-10">
                        <label>Feed</label>
                        <select class="form-control" name="Activity_Feed">
                        <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Feed EQ i > selected</cfif> >#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1 m-b-10">
                        <label>Prob Feed</label>
                        <select class="form-control" name="Activity_ProbFeed">
                        <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_ProbFeed EQ i > selected</cfif>>#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1 m-b-10">
                        <label>Travel</label>
                        <select class="form-control" name="Activity_Travel">
                        <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Travel EQ i > selected</cfif>>#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1 m-b-10">
                        <label>Play</label>
                        <select class="form-control" name="Activity_Play">
                         <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Play EQ i > selected</cfif>>#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1 m-b-10">
                        <label>Rest</label>
                        <select class="form-control" name="Activity_Rest">
                        <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Rest EQ i >selected</cfif> >#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1 m-b-10">
                        <label>Leap/TS/Ch</label>
                        <select class="form-control" name="Activity_Leap">
                        <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Leap EQ i >selected</cfif> >#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1 m-b-10">
                        <label>Social</label>
                        <select class="form-control" name="Activity_Social">
                        <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Social EQ i > selected</cfif> >#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1">
                        <label>w/Boat</label>
                        <select class="form-control" name="Activity_Wboat">
                     	<cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Wboat EQ i >selected</cfif> >#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1">
                        <label>Herding</label>
                        <select class="form-control" name="Activity_Herding">
                     		<cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Herding EQ i >selected</cfif> >#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1">
                        <label>Avoid Boat</label>
                        <select class="form-control" name="Activity_AvoidBoat">
                        <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_AvoidBoat EQ i >selected</cfif> >#i#</option>
                        </cfloop>
                        </select>
                      </div>
					  <div class="col-lg-1">
                        <label>Other</label>
                        <select class="form-control" name="Activity_Other">
                         <cfloop from="0" to="5" index="i">
                          <option value="#i#" <cfif getNCSG.Activity_Other EQ i > selected</cfif>>#i#</option>
                        </cfloop>
                        </select>
                      </div>
                    </div>
                  </div>
				</div>
              </div>
          </div>
          <!-- end panel -->
          <!-- begin panel -->
          <!-- end panel -->
        </div>
        <!-- end col-4 -->
        <!-- begin col-8 -->
        <div class="">
          <!-- begin panel -->
          <div class="panel p-20">
           <div class="row form-input-flat dolphin-table">
					<div class="col-md-5">
						
						<table cellpadding="0" cellspacing="0" class="table table-bordered table-hover dataTable no-footer dtr-inline  left-dlpn-tbl">
							<tr> 
								<th></th>
								<th class="text-center">Min</th>
								<th class="text-center">Max</th>
								<th class="text-center">Best</th>
							</tr>
							<tr>
								<th>Total Dolphins</th>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalDolphin_Min" value="#getNCSG.FE_TotalDolphin_Min#" required class="form-control">
                                </div>
                                </td>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalDolphin_Max" value="#getNCSG.FE_TotalDolphin_Max#" required class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalDolphin_Best" value="#getNCSG.FE_TotalDolphin_Best#" required class="form-control">
                                </div></td>
							</tr>
							<tr>
								<th>Total Adults</th>
								<td><div class="form-group">
                                <input type="text" name="FE_Adults_Min" value="#getNCSG.FE_Adults_Min#" required class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_Adults_Max" value="#getNCSG.FE_Adults_Max#" required class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_Adults_Best"  value="#getNCSG.FE_Adults_Best#" required class="form-control"></div></td>
							</tr>
							<tr>
								<th>Total Calves</th>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalCalves_Min" value="#getNCSG.FE_TotalCalves_Min#" required class="form-control"></div></td>
								<td>
                                <div class="form-group">
                                <input type="text" name="FE_TotalCalves_Max" value="#getNCSG.FE_TotalCalves_Max#" required class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalCalves_Best" value="#getNCSG.FE_TotalCalves_Best#" required class="form-control">
                                </div></td>
							</tr>
							<tr>
								<th>YOY Present</th>
								<td><div class="form-group">
                                <input type="text" name="FE_YOYPresent_Min" value="#getNCSG.FE_YOYPresent_Min#" required class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_YOYPresent_Max" value="#getNCSG.FE_YOYPresent_Max#" required class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_YOYPresent_Best" value="#getNCSG.FE_YOYPresent_Best#" required class="form-control">
                                </div></td>
							</tr>
						</table>
						
					</div>
					<div class="col-md-7">
						<table cellpadding="0" cellspacing="0" class="table table-bordered table-hover dataTable no-footer dtr-inline">
							<tr> 
								<th class="text-center">POS Ids</th>
								<th class="text-center">MIN not ID'd</th>
								<th class="text-center">Max not ID'd</th>
								<th class="text-center">Revised MIN</th>
								<th class="text-center">Revised MAX</th>
								<th class="text-center">Revised BEST</th>
							</tr>
							<tr>
								<td><div class="form-group"><input type="text" value="#getNCSG.photo_posids1#"
                                 name="photo_posids1" required class="form-control"></div></td>
								<td><div class="form-group"><input type="text" value="#getNCSG.photo_Minnotids1#"
                                 name="photo_Minnotids1" required class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Maxnotids1"  value="#getNCSG.photo_Maxnotids1#"
                                required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMin1" value="#getNCSG.photo_RevisedMin1#"
                                 required class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMax1" value="#getNCSG.photo_RevisedMax1#"
                                 required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedBest1" value="#getNCSG.photo_RevisedBest1#"
                                 required class="form-control"></div></td>
							</tr>
							<tr>
								<td><div class="form-group">
                                <input type="text" name="photo_posids2" value="#getNCSG.photo_posids2#"
                                 required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Minnotids2" value="#getNCSG.photo_Minnotids2#"
                                 required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Maxnotids2" value="#getNCSG.photo_Maxnotids2#" 
                                required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMin2" value="#getNCSG.photo_RevisedMin2#"
                                 required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMax2" value="#getNCSG.photo_RevisedMax2#" 
                                required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedBest2" value="#getNCSG.photo_RevisedBest2#"
                                 required class="form-control"></div></td>
							</tr>
							<tr>
								<td><div class="form-group">
                                <input type="text" name="photo_posids3" value="#getNCSG.photo_posids3#" 
                                required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Minnotids3" value="#getNCSG.photo_Minnotids3#"
                                 required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Maxnotids3" value="#getNCSG.photo_Maxnotids3#"
                                 required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMin3" value="#getNCSG.photo_RevisedMin3#"
                                 required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMax3" value="#getNCSG.photo_RevisedMax3#"
                                 required class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedBest3" value="#getNCSG.photo_RevisedBest3#"
                                 required class="form-control"></div></td>
							</tr>
						</table>
					</div>
				</div>
		
				<div class="form-group">
				  <label for="comment">Comments:</label>
				  <textarea class="form-control" name="Comments" rows="5"  required>#getNCSG.Comments#</textarea>
				</div>
		
              <div class="row form-input-flat dolpin-sec-count">
                <div class="col-lg-2">
                  <div class="form-group">
                    <label class="control-label">Dolphins 100m of active fisher:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" <cfif getNCSG.Dolphin_activeFisher EQ 1 > checked</cfif>
                         class="float-left" name="Dolphin_activeFisher" value="1" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">YES</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                         <input type="radio" required="" class="float-left" <cfif getNCSG.Dolphin_activeFisher EQ 0 > checked</cfif>
                         name="Dolphin_activeFisher" value="0" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">NO</label>
                      </div>
                    </div>
                  </div>
                </div>
				<div class="col-lg-1">
                  <div class="form-group">
                    <label class="control-label">##:</label>
                    <input type="text" class="form-control p-0" value="#getNCSG.ActiveFisher_Number#" name="ActiveFisher_Number" placeholder="" required>
                  </div>
                </div>
				<div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">TT response:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Fisher_TT_respons EQ 'Approach' > checked</cfif>  name="Fisher_TT_respons" value="Approach" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">Approach</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Fisher_TT_respons EQ 'Neutral' > checked</cfif> name="Fisher_TT_respons" value="Neutral" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Neutral</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Fisher_TT_respons EQ 'relocate' > checked</cfif> name="Fisher_TT_respons" value="relocate" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">reloc.-chg. behav.</label>
                      </div>
                      
                    </div>
                  </div>
                </div>
                	
				<div class="col-lg-5">
                  <div class="form-group">
                    <label class="control-label"> Fisher response:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Fisher_respons EQ 'relocate' > checked</cfif> name="Fisher_respons" value="relocate" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">relocate</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Fisher_respons EQ 'pullinline' > checked</cfif> name="Fisher_respons" value="pullinline" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">pull in line</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Fisher_respons EQ 'approach' > checked</cfif> name="Fisher_respons" value="approach" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">approach</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Fisher_respons EQ 'noresponse' > checked</cfif> name="Fisher_respons" value="noresponse" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">no response</label>
                      </div>
                    </div>
                  </div>
                </div>
				</div>
                
                <div class="row form-input-flat dolpin-sec-count">
                <div class="col-lg-2">
                  <div class="form-group">
                    <label class="control-label">Dolphins 100m of recreational vessel:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" 
						<cfif getNCSG.DolphinRecreantial_vessal EQ 1 > checked</cfif> name="DolphinRecreantial_vessal" value="1" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">YES</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" <cfif getNCSG.DolphinRecreantial_vessal EQ 0 > checked</cfif> class="float-left" name="DolphinRecreantial_vessal" value="0" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">NO</label>
                      </div>
                    </div>
                  </div>
                </div>
				<div class="col-lg-1">
                  <div class="form-group">
                    <label class="control-label">##:</label>
                    <input type="text" class="form-control p-0" value="#getNCSG.Vissel_Number#"
                     name="Vissel_Number" placeholder="" required>
                  </div>
                </div>
				<div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">TT response:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Vissel_TT_respons EQ 'Approach' > checked</cfif>
                         name="Vissel_TT_respons" value="Approach" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">Approach</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" name="Vissel_TT_respons" <cfif getNCSG.Vissel_TT_respons EQ 'Neutral' > checked</cfif> value="Neutral" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Neutral</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.Vissel_TT_respons EQ 'relocate' > checked</cfif> name="Vissel_TT_respons" value="relocate" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">reloc.-chg. behav.</label>
                      </div>
                      
                    </div>
                  </div>
                </div>
                	
				<div class="col-lg-5">
                  <div class="form-group">
                    <label class="control-label"> Vessel response:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left"
                        <cfif getNCSG.Vissel_respons EQ 'relocate' > checked</cfif>
                         name="Vissel_respons" value="relocate" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">relocate</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" 
                        <cfif getNCSG.Vissel_respons EQ 'pullinline' > checked</cfif>
                         name="Vissel_respons" value="pullinline" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">pull in line</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" 
                        <cfif getNCSG.Vissel_respons EQ 'approach' > checked</cfif>
                         name="Vissel_respons" value="approach" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">approach</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" 
                        <cfif getNCSG.Vissel_respons EQ 'noresponse' > checked</cfif>
                        name="Vissel_respons" value="noresponse" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">no response</label>
                      </div>
                    </div>
                  </div>
                </div>
                </div>
                
				<div class="row">
				<div class="col-lg-3">
                  <div class="form-group">
                    <label class="control-label">FB Sighted:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" 
                         <cfif getNCSG.FB_Sighted EQ 1 > checked</cfif> name="FB_Sighted" value="1" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">YES</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.FB_Sighted EQ 0 > checked</cfif> name="FB_Sighted" value="0" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">NO</label>
                      </div>
                    </div>
                  </div>
                </div>
				<div class="col-lg-3">
                  <div class="form-group">
                    <label class="control-label">Xeno present:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.XENOPresent EQ 1 > checked</cfif>
                         name="XENOPresent" value="1" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">YES</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" required="" class="float-left" <cfif getNCSG.XENOPresent EQ 0 > checked</cfif>
                         name="XENOPresent"  value="0" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">NO</label>
                      </div>
                    </div>
                  </div>
                </div>
				<div class="col-lg-3">
                  <div class="form-group">
                    <label class="control-label">Unusual markings/emaciated:</label>
                    <input type="text" placeholder="" name="Unusual_marking" value="#getNCSG.Unusual_marking#" required class="form-control">
                  </div>
                </div>
              </div>
              <input type="hidden" name="ID" value="#getNCSG.ID#">
              <div class="row p-t-20"> <input type="submit" class="btn btn-success"  name="ncsgform" value="submit" /> </div>
          </div>
          <!-- end panel -->
        </div>
        <!-- end col-8 -->
      </div>
      <!-- end row -->
    </div>
     </form>
    </div>
    <!-- end section-container -->
</cfoutput>