<cfoutput>
<cfif isdefined('form.PROJECT_ID') and form.project_id gt 0 and form.sight_id GT 0>  
<cfset get_NCSG=Application.Sighting.get_NCSG(form.sight_id)>
  <!-- Modal -->
  <div class="modal fade" id="ncsgModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">NCSG</h4>
        </div>
        <div class="modal-body">
       <!-- begin section-container -->
    <div class="section-container p-b-5">
      <!-- begin row -->
      <form class="form-input-flat" id="ncsgform" method="post">
      <div class="row">
        <!-- begin col-4 -->
        <div class="col-md-12 p-t-10">
         		
                <div class="form-group">
                <div class="alert alert-success message" style="display:none">
              	<strong>Success!</strong> NCSG Data saved.
            	</div>
                
             
          <div class>
              <div class="row form-input-flat activity-sec">
			    <div class="row col-lg-8">
					<div class="col-lg-6">
                  <div class="form-group">
                    <label>Habitat:</label>
                    <input type="text" placeholder="Habitat" name="Habitat" value="#get_NCSG.Habitat#" class="form-control" >
                  </div>
                  
                  <div class="form-group">
                    <label class="control-label">Tide/ht:</label>
                    <div class="input-group location">
                      
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" data-fv-field="Survey" <cfif get_NCSG.Tide EQ 'IN'>checked</cfif> name="Tide" value="IN" class="float-left" >
                        <label class="float-left font_size_14" for="rememberMe">IN</label>
                      </div>
                      
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" data-fv-field="Survey" name="Tide" <cfif get_NCSG.Tide EQ 'OUT'>checked</cfif> value="OUT" class="float-left">
                        <label class="float-left font_size_14" for="rememberMe">OUT</label>
                 
                 
                 
                      </div>
                      
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" data-fv-field="Survey" name="Tide" <cfif get_NCSG.Tide EQ 'High'>checked</cfif> value="High" class="float-left" >
                        <label class="float-left font_size_14" for="rememberMe">High</label>
                      </div>
                      
                      
                      <div class="checkbox-new route_checkbox">
                        <input type="radio" data-fv-field="Survey" name="Tide" value="Low" <cfif get_NCSG.Tide EQ 'Low'>checked</cfif> class="float-left">
                        <i data-fv-icon-for="Survey" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" style="pointer-events: none;"></i>
                        <label class="float-left font_size_14" for="rememberMe"> Low</label>
                      </div>
                      
                  </div>
                </div>
             
                  
                  
                </div>
                <div class="col-lg-6">
				 
				  	<table cellpadding="0" cellspacing="0" class="table dataTable no-footer dtr-inline  left-dlpn-tbl animal-tbl">
						<tr>
							<td>Initial WPT:</td>
							<td> <div class="form-group">
                            <input type="text" name="initail_WPT1" value="#get_NCSG.initail_WPT1#" class="form-control" >
                            </div></td>
							<td> <div class="form-group">
                            <input type="text" name="initail_WPT2" value="#get_NCSG.initail_WPT2#" class="form-control" >
                            </div></td>
						</tr>
						<tr>
							<td>At animal:</td>
							<td> <div class="form-group">
                            <input type="text" name="End_WPT1" value="#get_NCSG.End_WPT1#" class="form-control" >
                            </div></td>
							<td> <div class="form-group">
                            <input type="text" name="End_WPT2" value="#get_NCSG.End_WPT2#"  class="form-control" >
                            </div></td>
						</tr>
						<tr>
							<td>End Wpt:</td>
							<td> <div class="form-group">
                            <input type="text" name="atanimal1" value="#get_NCSG.atanimal1#"  class="form-control" >
                            </div></td>
							<td> <div class="form-group">
                            <input type="text" name="atanimal2" value="#get_NCSG.atanimal2#" class="form-control" >
                            </div></td>
						</tr>
					</table>	
                
                </div>
                
				<div class="col-lg-12 p-b-10">
				<div class="form-group">
                    <label>Rating: (most prevalent)</label>
                    <input type="text" placeholder="Rating: (most prevalent)" value="#get_NCSG.Rating#" name="Rating" class="form-control" >
                  </div>
                  
                  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label class="control-label">Chop height:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio"  class="float-left" <cfif get_NCSG.ChopHeight EQ 0>checked</cfif> name="ChopHeight" value="0" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">0</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio"  class="float-left" name="ChopHeight" <cfif get_NCSG.ChopHeight EQ 1>checked</cfif> value="1" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">1</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio"  class="float-left" name="ChopHeight" <cfif get_NCSG.ChopHeight EQ 2>checked</cfif> value="2" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">2</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio"  class="float-left" name="ChopHeight" value="3" <cfif get_NCSG.ChopHeight EQ 3>checked</cfif> data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">3</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio"  class="float-left" name="ChopHeight" <cfif get_NCSG.ChopHeight EQ 4>checked</cfif> value="4" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">4</label>
                      </div>
                      <div class="checkbox-new route_checkbox m-r-5">
                        <input type="radio"  class="float-left" name="ChopHeight" value="5" <cfif get_NCSG.ChopHeight EQ 5>checked</cfif> data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">5</label>
                      </div>
                    </div>
                  </div>
				  </div>  
                  
                </div>
				</div>
                
                <div class="col-lg-4 vertical">
                  <div class="form-group">
				  	<div class="form-inline  m-b-5">
                    <label>Salinity (ppt):</label>
                    <input type="text" placeholder="Salinity (ppt)" name="salinity" value="#get_NCSG.salinity#" class="form-control  pull-right" >
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>H2O Temp:</label>
                    <input type="text" placeholder="H2O Temp" name="H20_temp" value="#get_NCSG.H20_temp#" class="form-control  pull-right" >
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>Air Temp:</label>
                    <input type="text" placeholder="Air Temp" name="Air_temp" value="#get_NCSG.Air_temp#" class="form-control  pull-right" >
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>Conductivity:</label>
                    <input type="text" placeholder="Conductivity" name="Conductivity" value="#get_NCSG.Conductivity#" class="form-control  pull-right" >
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>Init. Depth (ft):</label>
                    <input type="text" placeholder="Init. Depth (ft)" name="InitailDepth" value="#get_NCSG.InitailDepth#" class="form-control  pull-right" >
                  </div>
				  </div>
				  <div class="form-group">
                  <div class="form-inline m-b-5">
                    <label>B.SeaState:</label>
                    <input type="text" placeholder="B.SeaState" name="BSeaState" value="#get_NCSG.BSeaState#" class="form-control  pull-right" >
                  </div>
				  </div>
				  <div class="form-group">
				  <div class="form-inline m-b-5">
                    <label>Winds (mph):</label>
                    <input type="text" placeholder="Winds (mph)" name="Winds" value="#get_NCSG.Winds#" class="form-control   pull-right" >
                  </div>
				  </div>
				  <div class="form-group">
				  <div class="form-inline m-b-5">
                    <label>Water body:</label>
                    <input type="text" placeholder="Water body (ML/HAL/BR NIR)" value="#get_NCSG.Waterbody#" name="Waterbody" class="form-control    pull-right" >
                  </div></div>
                  
				
                  
                </div>
				
              </div>
          </div>
          <!-- end panel -->
          <!-- begin panel -->
          <!-- end panel -->
        </div>
        <!-- end col-4 -->
        <!-- begin col-8 -->
        <div class>
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
                                <input type="text" name="FE_TotalDolphin_Min" value="#get_NCSG.FE_TotalDolphin_Min#"  class="form-control">
                                </div>
                                </td>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalDolphin_Max" value="#get_NCSG.FE_TotalDolphin_Max#"  class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalDolphin_Best" value="#get_NCSG.FE_TotalDolphin_Best#"  class="form-control">
                                </div></td>
							</tr>
							<tr>
								<th>Total Adults</th>
								<td><div class="form-group">
                                <input type="text" name="FE_Adults_Min" value="#get_NCSG.FE_Adults_Min#"  class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_Adults_Max" value="#get_NCSG.FE_Adults_Max#"  class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_Adults_Best" value="#get_NCSG.FE_Adults_Best#"  class="form-control"></div></td>
							</tr>
							<tr>
								<th>Total Calves</th>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalCalves_Min" value="#get_NCSG.FE_TotalCalves_Min#"  class="form-control"></div></td>
								<td>
                                <div class="form-group">
                                <input type="text" name="FE_TotalCalves_Max" value="#get_NCSG.FE_TotalCalves_Max#"  class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_TotalCalves_Best" value="#get_NCSG.FE_TotalCalves_Best#"   class="form-control">
                                </div></td>
							</tr>
							<tr>
								<th>YOY Present</th>
								<td><div class="form-group">
                                <input type="text" name="FE_YOYPresent_Min" value="#get_NCSG.FE_YOYPresent_Min#"  class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_YOYPresent_Max"  value="#get_NCSG.FE_YOYPresent_Max#"  class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="FE_YOYPresent_Best"  value="#get_NCSG.FE_YOYPresent_Best#"  class="form-control">
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
								<td><div class="form-group"><input type="text" name="photo_posids1" value="#get_NCSG.photo_posids1#"  class="form-control"></div></td>
								<td><div class="form-group"><input type="text" name="photo_Minnotids1" value="#get_NCSG.photo_Minnotids1#"  class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Maxnotids1" value="#get_NCSG.photo_Maxnotids1#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMin1" value="#get_NCSG.photo_RevisedMin1#"   class="form-control">
                                </div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMax1" value="#get_NCSG.photo_RevisedMax1#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedBest1" value="#get_NCSG.photo_RevisedBest1#"  class="form-control"></div></td>
							</tr>
							<tr>
								<td><div class="form-group">
                                <input type="text" name="photo_posids2" value="#get_NCSG.photo_posids2#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Minnotids2" value="#get_NCSG.photo_Minnotids2#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Maxnotids2" value="#get_NCSG.photo_Maxnotids2#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMin2" value="#get_NCSG.photo_RevisedMin2#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMax2" value="#get_NCSG.photo_RevisedMax2#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedBest2" value="#get_NCSG.photo_RevisedBest2#"  class="form-control"></div></td>
							</tr>
							<tr>
								<td><div class="form-group">
                                <input type="text" name="photo_posids3" value="#get_NCSG.photo_posids3#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Minnotids3" value="#get_NCSG.photo_Minnotids3#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_Maxnotids3" value="#get_NCSG.photo_Maxnotids3#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMin3" value="#get_NCSG.photo_RevisedMin3#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedMax3" value="#get_NCSG.photo_RevisedMax3#"  class="form-control"></div></td>
								<td><div class="form-group">
                                <input type="text" name="photo_RevisedBest3" value="#get_NCSG.photo_RevisedBest3#"  class="form-control"></div></td>
							</tr>
						</table>
					</div>
				</div>
		
				<div class="form-group">
				  <label for="comment">Comments:</label>
				  <textarea class="form-control" name="Comments" rows="5">#get_NCSG.Comments#</textarea>
				</div>
		
              <div class="row form-input-flat dolpin-sec-count">
                <div class="col-lg-2">
                  <div class="form-group">
                    <label class="control-label">Dolphins 100m of active fisher:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Dolphin_activeFisher EQ 1>checked</cfif> name="Dolphin_activeFisher" value="1" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">YES</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Dolphin_activeFisher" <cfif get_NCSG.Dolphin_activeFisher EQ 0>checked</cfif> value="0" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">NO</label>
                      </div>
                    </div>
                  </div>
                </div>
				<div class="col-lg-1">
                  <div class="form-group">
                    <label class="control-label">##:</label>
                    <input type="text" class="form-control p-0" value="#get_NCSG.ActiveFisher_Number#" name="ActiveFisher_Number" placeholder >
                  </div>
                </div>
				<div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">TT response:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left"  name="Fisher_TT_respons" <cfif get_NCSG.Fisher_TT_respons EQ 'Approach'>checked</cfif> value="Approach" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">Approach</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Fisher_TT_respons" <cfif get_NCSG.Fisher_TT_respons EQ 'Neutral'>checked</cfif> value="Neutral" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Neutral</label>
                      </div>
                      
					  <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Fisher_TT_respons EQ 'relocate'>checked</cfif>  name="Fisher_TT_respons" value="relocate" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Relocate</label>
                      </div>
                      
            		  <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Fisher_TT_respons EQ 'change'>checked</cfif> name="Fisher_TT_respons" value="change" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Change</label>
                      </div>
                       <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Fisher_TT_respons EQ 'behaviour'>checked</cfif> name="Fisher_TT_respons" value="behaviour" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Behaviour</label>
                      </div>
            
                      
                    </div>
                  </div>
                </div>
                	
				<div class="col-lg-5">
                  <div class="form-group">
                    <label class="control-label"> Fisher response:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Fisher_respons EQ 'relocate'>checked</cfif> name="Fisher_TT_respons" name="Fisher_respons" value="relocate" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">relocate</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Fisher_respons" <cfif get_NCSG.Fisher_respons EQ 'pullinline'>checked</cfif> value="pullinline" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">pull in line</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Fisher_respons" <cfif get_NCSG.Fisher_respons EQ 'approach'>checked</cfif> value="approach" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">approach</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Fisher_respons" <cfif get_NCSG.Fisher_respons EQ 'noresponse'>checked</cfif> value="noresponse" data-fv-field="Survey">
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
                        <input type="radio"  class="float-left" name="DolphinRecreantial_vessal" value="1" <cfif get_NCSG.DolphinRecreantial_vessal EQ 1>checked</cfif> data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">YES</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.DolphinRecreantial_vessal EQ 0>checked</cfif> name="DolphinRecreantial_vessal" value="0" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">NO</label>
                      </div>
                    </div>
                  </div>
                </div>
				<div class="col-lg-1">
                  <div class="form-group">
                    <label class="control-label">##:</label>
                    <input type="text" class="form-control p-0" value="#get_NCSG.Vissel_Number#" name="Vissel_Number" placeholder >
                  </div>
                </div>
				<div class="col-lg-4">
                  <div class="form-group">
                    <label class="control-label">Vessel  TT response:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Vissel_TT_respons" <cfif get_NCSG.Vissel_TT_respons EQ 'Approach'>checked</cfif> value="Approach" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">Approach</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Vissel_TT_respons" <cfif get_NCSG.Vissel_TT_respons EQ 'Neutral'>checked</cfif> value="Neutral" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Neutral</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Vissel_TT_respons EQ 'relocate'>checked</cfif> name="Vissel_TT_respons" value="relocate" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Relocate</label>
                      </div>
                     
                     <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Vissel_TT_respons EQ 'chage'>checked</cfif> name="Vissel_TT_respons" value="chage" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Chage</label>
                      </div>
                      
                       <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Vissel_TT_respons EQ 'behaviour'>checked</cfif> name="Vissel_TT_respons" value="behaviour" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">Behaviour</label>
                      </div>
                      
                      
                      
                    </div>
                  </div>
                </div>
                	
				<div class="col-lg-5">
                  <div class="form-group">
                    <label class="control-label"> Vessel response:</label>
                    <div class="input-group location">
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" <cfif get_NCSG.Vissel_respons EQ 'relocate'>checked</cfif> name="Vissel_respons" value="relocate" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">relocate</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Vissel_respons" <cfif get_NCSG.Vissel_respons EQ 'pullinline'>checked</cfif> value="pullinline" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">pull in line</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Vissel_respons" <cfif get_NCSG.Vissel_respons EQ 'approach'>checked</cfif> value="approach" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">approach</label>
                      </div>
					  <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="Vissel_respons" <cfif get_NCSG.Vissel_respons EQ 'noresponse'>checked</cfif> value="noresponse" data-fv-field="Survey">
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
                        <input type="radio"  class="float-left" name="FB_Sighted" <cfif get_NCSG.FB_Sighted EQ 1>checked</cfif> value="1" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">YES</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="FB_Sighted" <cfif get_NCSG.FB_Sighted EQ 0>checked</cfif> value="0" data-fv-field="Survey">
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
                        <input type="radio"  class="float-left" name="XENOPresent" <cfif get_NCSG.XENOPresent EQ 1>checked</cfif> value="1" data-fv-field="Survey">
                        <label for="rememberMe" class="float-left font_size_14">YES</label>
                      </div>
                      <div class="checkbox-new route_checkbox">
                        <input type="radio"  class="float-left" name="XENOPresent"  <cfif get_NCSG.XENOPresent EQ 0>checked</cfif> value="0" data-fv-field="Survey">
                        <i style="pointer-events: none;" class="form-control-feedback fv-icon-no-label glyphicon glyphicon-ok-" data-fv-icon-for="Survey"></i>
                        <label for="rememberMe" class="float-left font_size_14">NO</label>
                      </div>
                    </div>
                  </div>
                </div>
				<div class="col-lg-3">
                  <div class="form-group">
                    <label class="control-label">Unusual markings/emaciated:</label>
                    <input type="text" placeholder name="Unusual_marking" value="#get_NCSG.Unusual_marking#" class="form-control">
                  </div>
                </div>
              </div>
               	
               
                
                </div>
            <input type="hidden" class="form-control" name="Sighting_ID" value="#qGetSightings.id#">
            	<div class="row p-t-20"> <input type="submit" class="btn btn-success" name="ncsgform" value="Save" /> </div>
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
    
     </div>
       
      </div>
      
    </div>
</cfif>
</cfoutput>