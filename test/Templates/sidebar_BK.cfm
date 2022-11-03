<cfoutput>
		<!-- begin ##sidebar -->
		<div id="sidebar" class="sidebar">
			<!-- begin sidebar scrollbar -->
			<div data-scrollbar="true" data-height="100%">
				<!-- begin sidebar nav -->
				<ul class="nav">
				    <li class="nav-user">
				        <div class="image">
  						<cfif  DirectoryExists("#ExpandPath('.')#/assets/user_images/#SESSION["UserDetails"]["Id"]#") and  FileExists("#ExpandPath('.')#/assets/user_images/#SESSION["UserDetails"]["Id"]#/#SESSION["UserDetails"]["Id"]#.png")>
     <img src="#Application.superadmin#assets/user_images/#SESSION["UserDetails"]["Id"]#/#SESSION["UserDetails"]["Id"]#.png" alt="" width="50" height="50"/>
				        <cfelse>
   							<img src="#Application.superadminTemplateIncludes#img/user_profile.jpg" alt="" />
				        </cfif>
                        
                        </div>
				        <div class="info">
				            <div class="name dropdown">
				                <a href="javascript:;" data-toggle="dropdown"> <cfif isdefined('Session.UserDetails')>#SESSION["UserDetails"]["firstName"]# #SESSION["UserDetails"]["lastName"]#</cfif><b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#Application.superadmin#?Module=Home&Page=Profile">Edit Profile</a></li>
                                    <li><a href="javascript:;">Setting</a></li>
                                    <li class="divider"></li>
                                    <li><a href="javascript:;">Log Out</a></li>
                                </ul>
				            </div>
				            <div class="position">Admin</div>
				        </div>
				    </li>
					<li class="nav-header">Main Menu</li>

                    <li>
						<a href="#Application.siteroot#?Module=Home&Page=Dashboard">
						    <i class="fa fa-suitcase"></i>
						    <span>Dashboard</span>
						</a>
					</li>


  				<li class="has-sub <cfif Module eq 'Reporting' >active</cfif>">
						<a href="javascript:;">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-suitcase"></i>
						    <span>Reporting</span>
						</a>
						<ul class="sub-menu" >
                        
                        
                          <li class="has-sub <cfif Page eq 'RollcallReport' OR Page eq 'BestplacesReport' OR Page eq 'BiopsyReport' or Page eq 'HERAReport' or Page eq 'MMHSRPReport' or Page eq 'NCSGReport' >active</cfif>">
                          <a href="javascript:;"><b class="caret pull-right"></b>Survey Reports</a>
                          <ul class="sub-menu">
                            <li <cfif Page eq 'RollcallReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=RollcallReport">Roll Call Report</a></li>
                             <li <cfif Page eq 'BestplacesReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=BestplacesReport">Best Places Report</a></li>
                          <li <cfif Page eq 'BiopsyReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=BiopsyReport">Biopsy Report</a></li>
                          <li <cfif Page eq 'HERAReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=HERAReport">HERA Report</a></li>
                          <li <cfif Page eq 'MMHSRPReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=MMHSRPReport">MMHSRP Report</a></li>
                          <li <cfif Page eq 'NCSGReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=NCSGReport">NCSG Report</a></li>
                          </ul>
                          </li>
                          
                          <li class="has-sub <cfif Page eq 'BodyReport' or Page eq 'VitalStatsReport' >active</cfif>" >
                          <a href="javascript:;"><b class="caret pull-right"></b>Project Reports</a>
                          <ul class="sub-menu">
                          <li><a href="#Application.superadmin#?Module=Reporting&Page=BodyReport">Body Report</a></li>
                          <li><a href="#Application.superadmin#?Module=Reporting&Page=VitalStatsReport">Vital Stats Report</a></li>
                          </ul>
                          </li>
                          
						  <li class="has-sub">
                            <a href="javascript:;"><b class="caret pull-right"></b>
                            Productivity Reports</a>
                            <ul class="sub-menu">
                            <li><a href="##">TBA</a></li>
                            <li><a href="##">TBA</a></li>
                            </ul>
                          </li>
                          
                          <li class="has-sub">
                            <a href="javascript:;"><b class="caret pull-right"></b>
                            NOAA Reports</a>
                            <ul class="sub-menu">
                            <li><a href="##">TBA</a></li>
                            <li><a href="##">TBA</a></li>
                           </ul>
                          </li>
                          
                          <li class="has-sub">
                          <a href="javascript:;"><b class="caret pull-right"></b>Coverage Reports</a>
                          <ul class="sub-menu">
                           <li><a href="##">TBA</a></li>
                            <li><a href="##">TBA</a></li>
                           </ul>
                         </li>
                          
                        </ul>
                        </li>
                        
                       <li class="has-sub <cfif Module eq 'Accounts' >active</cfif>">
						<a href="javascript:;">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-suitcase"></i>
						    <span>Accounts</span>
						</a>
						<ul class="sub-menu">
							<li <cfif Page eq 'UsersList' > class='active'</cfif>><a href="#Application.superadmin#?Module=Accounts&Page=UsersList">Users List</a></li>
                          <li <cfif Page eq 'AddUser' > class='active'</cfif>><a href="#Application.superadmin#?Module=Accounts&Page=AddUser">Add User</a></li>
                        </ul>
                        </li>

                    <li class="has-sub <cfif Module eq 'Group' >active</cfif>">
						<a href="javascript:;">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-suitcase"></i>
						    <span>Group Mangement</span>
						</a>
						<ul class="sub-menu">
							<li <cfif Page eq 'AddGroup' > class='active'</cfif>><a href="#Application.superadmin#?Module=Group&Page=AddGroup">Add Group</a></li>
							<li <cfif Page eq 'ViewGroups' > class='active'</cfif>><a href="#Application.superadmin#?Module=Group&Page=ViewGroups">View Groups</a></li>
						</ul>
					</li>

                    <li class="has-sub <cfif Module eq 'StaticData' >active</cfif>">
						<a href="javascript:;">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-suitcase"></i>
						    <span>Static Data </span>
						</a>
						<ul class="sub-menu">
                        
                        <li class="has-sub <cfif Module eq 'StaticData' >active</cfif>">
								<a href="javascript:;">
						            <b class="caret pull-right"></b>
						            Condition
						        </a>
								<ul class="sub-menu">
									<li <cfif Page eq 'WaveHeight' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=WaveHeight">Wave Height</a></li>
                                    <li <cfif Page eq 'Weather' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Weather">Weather</a></li>
                                    <li <cfif Page eq 'Sightability' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Sightability">Sightability</a></li>
                                    <li <cfif Page eq 'Beaufort' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Beaufort">Beaufort</a></li>
                                    <li <cfif Page eq 'Glare' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Glare">Glare</a></li>
                                    <li <cfif Page eq 'AssocBio' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=AssocBio">Assoc Bio</a></li>
                                    
								</ul>
							</li>
                        
							<li <cfif Page eq 'Camera' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Camera">Cameras</a></li>
							<li <cfif Page eq 'DolphinCondition' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=DolphinCondition">Dolphins Conditions</a></li>
							<li <cfif Page eq 'Descriptor' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Descriptor">Descriptors</a></li>
							<li <cfif Page eq 'EstimatedScore' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=EstimatedScore">Estimated Score</a></li>
							<li <cfif Page eq 'TeamMembers' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=TeamMembers">Team Members</a></li>
							
							<li <cfif Page eq 'Iloc' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Iloc">ILoc</a></li>
							<li <cfif Page eq 'Interaction' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Interaction">Interaction</a></li>
							<li <cfif Page eq 'Lens' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Lens">Lens</a></li>
							<li <cfif Page eq 'Plateform' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Plateform">PlateForms</a></li>
							<li <cfif Page eq 'ResearchTeamMembers' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=ResearchTeamMembers">Research Team Members</a></li>
							<li <cfif Page eq 'SDO' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SDO">SDO</a></li>
							<li <cfif Page eq 'SurveyArea' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SurveyArea">Survey Area</a></li>
                            <li <cfif Page eq 'SubType' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SubType">Sub Type</a></li>
                            <li <cfif Page eq 'Type' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Type">Type</a></li>
                            
							<li <cfif Page eq 'YobSource' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=YobSource">YOB Source</a></li>
                            <li <cfif Page eq 'Zones' > class='active'</cfif>>
                            <a href="#Application.superadmin#?Module=StaticData&Page=Zones">Zones</a>
                            </li>
                            <li <cfif Page eq 'Stock' > class='active'</cfif>>
                            <a href="#Application.superadmin#?Module=StaticData&Page=Stock">Stocks</a>
                            </li>
                            <li <cfif Page eq 'Catalog' > class='active'</cfif>>
                            <a href="#Application.superadmin#?Module=StaticData&Page=Catalog">Catalog</a>
                            </li>
                            <li <cfif Page eq 'BiopsyBehavior' > class='active'</cfif>>
                            <a href="#Application.superadmin#?Module=StaticData&Page=BiopsyBehavior">Biopsy Behavior</a>
                            </li>
                           <li <cfif Page eq 'HitLocation' > class='active'</cfif>>
                            <a href="#Application.superadmin#?Module=StaticData&Page=HitLocation">Hit Location</a>
                            </li>
                           <li <cfif Page eq 'SubSampleType' > class='active'</cfif>>
                            <a href="#Application.superadmin#?Module=StaticData&Page=SubSampleType">Sub-Sample Tissue  Type</a>
                           </li>
                            
						</ul>
					</li>

                     <li class="has-sub <cfif Module eq 'Sighting' >active</cfif>">
						<a href="javascript:;">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-suitcase"></i>
						    <span>Sighting</span>
						</a>
						<ul class="sub-menu">
							<li <cfif Page eq 'Home' > class='active'</cfif>><a href="#Application.superadmin#?Module=Sighting&Page=Home">Sighting Form</a></li>
                           
                            <li <cfif Page eq 'Dscore' > class='active'</cfif>><a href="#Application.superadmin#?Module=Sighting&Page=Dscore">Fin Change</a>
                            </li>
                              
                             <li <cfif Page eq 'SightingReview' > class='active'</cfif>><a href="#Application.superadmin#?Module=Sighting&Page=SightingReview"> Sighting Review</a>
                            </li>
                            
						</ul>
					</li>

                    <li class="has-sub <cfif Module eq 'Dolphin' >active</cfif>">
						<a href="javascript:;">
						    <b class="caret pull-right"></b>
						    <i class="fa fa-suitcase"></i>
						    <span>Dolphin</span>
						</a>
						<ul class="sub-menu">
							<li <cfif Page eq 'AddDolphin' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=AddDolphin">Add Dolphin</a></li>
                            <li <cfif Page eq 'ListDolphin' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=ListDolphin">All Dolphin</a></li>
                             <li <cfif Page eq 'DolphinHistory' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=DolphinHistory">Dolphin History</a>
                             </li><li <cfif Page eq 'SDOForm' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=SDOForm">SDO Form</a> </li>
                             <li <cfif Page eq 'SDODolphinList' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=SDODolphinList">SDO List</a>
                             </li>
                             
						</ul>
					</li>
                    
<li class="divider has-minify-btn">
                        <!-- begin sidebar minify button -->
                        <a data-click="sidebar-minify" class="sidebar-minify-btn" href="javascript:;"><i class="fa fa-angle-left"></i></a>
                        <!-- end sidebar minify button -->
					</li>
                    


				</ul>
				<!-- end sidebar nav -->
			</div>
			<!-- end sidebar scrollbar -->
		</div>
		<div class="sidebar-bg"></div>
		<!-- end ##sidebar -->
		</cfoutput>
