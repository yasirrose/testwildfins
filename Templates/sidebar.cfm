<cfoutput>
   <cfset isArchive = false>
   <cfif structKeyExists(url, 'Archive')>
   <cfset isArchive = true>
   </cfif>
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
                        <li><a onclick="javascript:window.location='#Application.superadmin#?Module=Home&page=logout';">Log Out</a></li>
                     </ul>
                  </div>
                  <div class="position"><cfif isdefined('Session.UserDetails')>#SESSION["UserDetails"]["userType"]#</cfif></div>
               </div>
            </li>
            <li class="nav-header">Main Menu</li>
            <li>
               <a href="#Application.siteroot#?Module=Home&Page=Dashboard">
               <i class="fa fa-suitcase"></i>
               <span>Dashboard</span>
               </a>
            </li>
            <li>
               <a href="#Application.siteroot#?Module=Home&Page=SightingMap">
               <i class="fa fa-suitcase"></i>
               <span>Sighting Map</span>
               </a>
            </li>
            <!--- <cfif structKeyExists(getSecurityPermissions, "noRestrict")> --->
            
            <!--- </cfif> --->

            <li class="has-sub <cfif Module eq 'Reporting' AND NOT isArchive >active</cfif>">
               <a href="javascript:;">
               <b class="caret pull-right"></b>
               <i class="fa fa-suitcase"></i>
               <span>Reporting</span>
               </a>
               <ul class="sub-menu" >
                  <li class="has-sub<cfif Page eq 'AllFormsReport' AND NOT isArchive> active</cfif>">
                     <a href="#Application.superadmin#?Module=Reporting&Page=AllFormsReport">All Forms Report</a>
                  </li>
                  <li class="has-sub<cfif Page eq 'LesionsReport' AND NOT isArchive> active</cfif>">
                     <a href="#Application.superadmin#?Module=Reporting&Page=LesionsReport">Lesions Report</a>
                  </li>
                  <li class="has-sub<cfif Page eq 'FriendsReport' AND NOT isArchive> active</cfif>">
                    <a href="#Application.superadmin#?Module=Reporting&Page=FriendsReport">Friends Report</a>
                 </li>
                  <li class="has-sub<cfif Page eq 'IncidentReport' AND NOT isArchive> active</cfif>">
                    <a href="#Application.superadmin#?Module=Reporting&Page=IncidentReport">Incident Report</a>
                 </li>
                  <li class="has-sub<cfif Page eq 'TrackingReport' AND NOT isArchive> active</cfif>">
                    <a href="#Application.superadmin#?Module=Reporting&Page=TrackingReport">Sample Archive and Tracking Report </a>
                 </li>
                  <!---<li class="has-sub <cfif Page eq 'RollcallReport' OR Page eq 'BestplacesReport' OR Page eq 'BiopsyReport' or Page eq 'BiopsyCatalogReport' or Page eq 'HERAReport' or Page eq 'MMHSRPReport' or Page eq 'NCSGReport' or Page eq 'BiopsyNOAASummary' or Page eq 'SampleDispositionReport'  >active</cfif>">
                     <a href="javascript:;"><b class="caret pull-right"></b>Survey Reports</a>
                     <ul class="sub-menu">
                        <li 
                        <cfif Page eq 'RollcallReport' AND NOT isArchive> class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=RollcallReport">Roll Call Report</a></li>
                        <li 
                        <cfif Page eq 'BestplacesReport' AND NOT isArchive> class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=BestplacesReport">Best Places Report</a></li>
                        <!--- <li <cfif Page eq 'BiopsyReport' AND NOT isArchive> class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=BiopsyReport">Biopsy Report</a></li> --->
                        <!--- <li <cfif Page eq 'BiopsyCatalogReport' AND NOT isArchive> class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=BiopsyCatalogReport">Biopsy Catalog Report</a></li> --->
                        <li 
                        <cfif Page eq 'HERAReport' AND NOT isArchive> class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=HERAReport">HERA Report</a></li>
                        <li 
                        <cfif Page eq 'MMHSRPReport' AND NOT isArchive> class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=MMHSRPReport">MMHSRP Report</a></li>
                        <li 
                        <cfif Page eq 'DeadDolphin' AND NOT isArchive> class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Dolphin&Page=DeadDolphin">Dead Dolphins</a></li>
                        <li 
                        <cfif Page eq 'NCSGReport' AND NOT isArchive> class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=NCSGReport">NCSG Report</a></li>
                     </ul>
                  </li>
                  <li class="has-sub <cfif Page eq 'BodyReport' or Page eq 'VitalStatsReport' AND NOT isArchive>active</cfif>" >
                     <a href="javascript:;"><b class="caret pull-right"></b>Project Reports</a>
                     <ul class="sub-menu">
                        <li><a href="#Application.superadmin#?Module=Reporting&Page=BodyReport">Body Report</a></li>
                        <li><a href="#Application.superadmin#?Module=Reporting&Page=VitalStatsReport">Vital Stats Report</a></li>
                     </ul>
                  </li>
                  <li class="has-sub<cfif Page eq 'NOAA_Reports' AND NOT isArchive> active</cfif>">
                     <a href="#Application.superadmin#?Module=Reporting&Page=NOAA_Reports">NOAA Reports</a>
                  </li>
                  <li class="has-sub">
                     <a href="javascript:;"><b class="caret pull-right"></b>Coverage Reports</a>
                     <ul class="sub-menu">
                        <li 
                        <cfif Page eq 'ZoneReport' AND NOT isArchive> class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=ZoneReport">Zone Report</a></li>
                       
                     </ul>
                  </li>
                  <li class="has-sub<cfif Page eq 'AnnualCensusReport' AND NOT isArchive> active</cfif>">
                     <a href="#Application.superadmin#?Module=Reporting&Page=AnnualCensusReport">Annual Census Report</a>
                  </li>
                  <li class="has-sub<cfif Page eq 'PopulationViability' AND NOT isArchive> active</cfif>">
                     <a href="#Application.superadmin#?Module=Reporting&Page=PopulationViability">Population Viability Report</a>
                  </li>
                  <li class="has-sub">
                     <a href="javascript:;"><b class="caret pull-right"></b>Calf Reports</a>
                     <ul class="sub-menu">
                        <li 
                        <cfif Page eq 'COAReport' AND NOT isArchive>class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=COAReport">COA Report</a></li>
                        <li 
                        <cfif Page eq 'Birth_Death_Rate_Report' AND NOT isArchive>class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=BirthDeathRateReport">Birth - Death Rate</a></li>
                        <li 
                        <cfif Page eq 'HomeRangeReport' AND NOT isArchive>class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=HomeRangeReport">Home Range Report</a></li>
                        <li 
                        <cfif Page eq 'BodyConditionReport' AND NOT isArchive>class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=BodyConditionReport">Body Condition Report</a></li>
                        <li 
                        <cfif Page eq 'DolphinActivityReport' AND NOT isArchive>class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=Reporting&Page=DolphinActivityReport">Dolphin Activity Report</a></li>
                     </ul>
                  </li>--->
               </ul>
            </li>
            <cfif session.userdetails.userType neq "team_members">
               <cfif  session.userdetails.userType neq "vet_assistant">
               <li class="has-sub <cfif (Module eq 'Accounts' or Module eq 'Security') AND NOT isArchive>active</cfif>">
                  <a href="javascript:;">
                  <b class="caret pull-right"></b>
                  <i class="fa fa-suitcase"></i>
                  <span>Accounts</span>
                  </a>
                  
                  <ul class="sub-menu">
                     <li <cfif Page eq 'Security' AND NOT isArchive> class='active'</cfif>
                     ><a href="#Application.siteroot#?Module=Security&Page=Security">Security Settings</a></li>
                     <li 
                     <cfif Page eq 'UsersList' AND NOT isArchive> class='active'</cfif>
                     ><a href="#Application.superadmin#?Module=Accounts&Page=UsersList">Users List</a></li>
                     <li 
                     <cfif Page eq 'AddUser' AND NOT isArchive> class='active'</cfif>
                     ><a href="#Application.superadmin#?Module=Accounts&Page=AddUser">Add User</a></li>
                     <!---<li class="has-sub <cfif Page eq 'AddGroup' OR Page eq 'ViewGroups' AND NOT isArchive>active</cfif>" >
                        <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        Group Mangement
                        </a>
                        <ul class="sub-menu">
                           <li 
                           <cfif Page eq 'AddGroup' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=Accounts&Page=AddGroup">Add Group</a></li>
                           <li 
                           <cfif Page eq 'ViewGroups' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=Accounts&Page=ViewGroups">View Groups</a></li>
                        </ul>
                     </li>--->
                  </ul>
               </li>
               </cfif>
               <li class="has-sub <cfif Module eq 'StaticData' AND NOT isArchive>active</cfif>">
                  <a href="javascript:;">
                  <b class="caret pull-right"></b>
                  <i class="fa fa-suitcase"></i>
                  <span>Master Data </span>
                  </a>
                  <ul class="sub-menu">
                     <li class="has-sub <cfif Page eq 'WaveHeight' OR Page eq 'Weather' OR Page eq 'Sightability' or Page eq 'Beaufort' or Page eq 'Glare' or Page eq 'GlareDirection' or Page eq 'Heading' or Page eq 'GeneralHeading'  or Page eq 'FinalHeading'or Page eq 'AssocBio'>active</cfif>" >
                        <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        Condition Environment
                        </a>
                        <ul class="sub-menu">
                           <li 
                           <cfif Page eq 'WaveHeight' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=WaveHeight">Wave Height</a></li>
                           <li 
                           <cfif Page eq 'Weather' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Weather">Weather</a></li>
                           <li 
                           <cfif Page eq 'Sightability' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Sightability">Sightability</a></li>
                           <li 
                           <cfif Page eq 'Beaufort' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Beaufort">Beaufort</a></li>
                           <li 
                           <cfif Page eq 'Glare' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Glare">Glare</a></li>
                           <li 
                           <cfif Page eq 'GlareDirection' > class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=GlareDirection">Glare Direction</a></li>
                           <li 
                           <cfif Page eq 'Heading' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Heading">Initial Heading</a></li>
                           <li 
                           <cfif Page eq 'GeneralHeading' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=GeneralHeading">General Heading</a></li>
                           <li 
                           <cfif Page eq 'FinalHeading' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=FinalHeading">Final Heading</a></li>
                           <li 
                           <cfif Page eq 'AssocBio' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=AssocBio">Assoc Bio</a></li>
                           <li 
                           <cfif Page eq 'Tide' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Tide">Tide</a></li>
                           <li 
                           <cfif Page eq 'Habitat' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Habitat">Habitat</a></li>
                           <li 
                           <cfif Page eq 'Strcutres' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Strcutres">Structures</a></li>
                        </ul>
                     </li>
                     <li class="has-sub <cfif Page eq 'Camera' OR Page eq 'Lens' AND NOT isArchive>active</cfif>" >
                        <a href="javascript:;">
                        <b class="caret pull-right"></b>
                        Photo Equipment
                        </a>
                        <ul class="sub-menu">
                           <li 
                           <cfif Page eq 'Camera' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Camera">Cameras</a></li>
                           <li 
                           <cfif Page eq 'Lens' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Lens">Lens</a></li>
                        </ul>
                     <li>
                     <li class="has-sub <cfif Page eq 'Stock' OR Page eq 'SurveyRoute' OR Page eq 'SurveyArea' OR Page eq 'Type' OR Page eq 'ResearchTeamMembers' OR Page eq 'Plateform'>active</cfif>">
                        <a href="javascript:;"><b class="caret pull-right"></b>Survey Data</a>
                        <ul class="sub-menu">
                           <li 
                           <cfif Page eq 'ResearchTeamMembers' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=ResearchTeamMembers">Research Team Members</a></li>
                           <li 
                           <cfif Page eq 'Plateform' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Plateform">Platforms</a></li>
                           <li 
                           <cfif Page eq 'Stock' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Stock">NOAA Stocks</a></li>
                           <li 
                           <cfif Page eq 'SurveyArea' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=SurveyArea">Body of Water</a></li>
                           <li 
                           <cfif Page eq 'Type' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Type">Survey Type</a></li>
                           <li 
                           <cfif Page eq 'SurveyRoute' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=SurveyRoute">Survey Route</a></li>
                        </ul>
                     <li>
                     <li class="has-sub <cfif Page eq 'CetaceanResponseToFisher' OR Page eq 'FisherResponseToCetacean'>active</cfif>">
                        <a href="javascript:;"><b class="caret pull-right"></b>Fisheries Interaction</a>
                        <ul class="sub-menu">
                           <li 
                           <cfif Page eq 'CetaceanResponseToFisher' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=CetaceanResponseToFisher">Cetacean Response to Fisher</a></li>
                           <li 
                           <cfif Page eq 'FisherResponseToCetacean' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=FisherResponseToCetacean">Fisher Response to Cetacean</a></li>
                        </ul>
                     <li>

                     <li class="has-sub <cfif Page eq 'CetaceanResponseToVessel' OR Page eq 'VesselResponseToCetacean'>active</cfif>">
                        <a href="javascript:;"><b class="caret pull-right"></b>Boating Interaction</a>
                        <ul class="sub-menu">
                           <li 
                           <cfif Page eq 'CetaceanResponseToVessel' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=CetaceanResponseToVessel">Cetacean Response to Vessel</a></li>
                           <li 
                           <cfif Page eq 'VesselResponseToCetacean' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=VesselResponseToCetacean">Vessel Response to Cetacean</a></li>
                        </ul>
                     <li>
                     <li class="has-sub <cfif Page eq 'TrackingListCategory'>active</cfif>">
                        <a href="javascript:;"><b class="caret pull-right"></b>Tracking List</a>
                        <ul class="sub-menu">
                           <li 
                           <cfif Page eq 'TrackingListCategory' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=TrackingListCategory">Category</a></li>
                        </ul>
                     <li>
                     <li class="has-sub <cfif Page eq 'StrandingType' OR Page eq 'DrugType' OR Page eq 'DrugMethod' OR Page eq 'Veterinarians' OR Page eq 'BiopsyType' OR Page eq 'BiopsyLocation' OR Page eq 'PreservationMethod' OR Page eq 'SampleType' OR Page eq 'SampleLocation' OR Page eq 'SampleTracking' OR Page eq 'Unit_Of_Sample' OR Page eq 'RbcMORphology' OR page eq 'PlateletMORphology' OR page eq 'WbcMORphology' OR page eq 'HemolysisIndex' OR Page eq 'LipemiaIndex' OR Page eq 'LiverFindings' OR Page eq 'LungFindings' OR Page eq 'ParasiteLocation' OR Page eq 'ParasiteType' or Page eq 'GIForeignMaterial'OR Page eq 'NxLocation'OR Page eq 'LymphNodePresent'>active</cfif>">
                        <a href="javascript:;"><b class="caret pull-right"></b>Stranding and Veterinary</a>
                        <ul class="sub-menu">
                           <li 
                           <cfif Page eq 'StrandingType' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=StrandingType">Stranding Event</a></li>
                           <li 
                           <cfif Page eq 'DrugType' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=DrugType">Drug Type</a></li>
                           <li
                           <cfif Page eq 'DrugMethod' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=DrugMethod">Drug Method</a></li>
                           <li
                           <cfif Page eq 'Veterinarians' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Veterinarians">Veterinarians</a></li>
                            <li 
                           <cfif Page eq 'BiopsyType' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=BiopsyType">Biopsy Type</a></li>
                           <li
                           <cfif Page eq 'BiopsyLocation' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=BiopsyLocation">Biopsy Location</a></li>
                           <li
                           <cfif Page eq 'BinNumber' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=BinNumber">Bin Number</a></li>
                           <li
                           <cfif Page eq 'DiagnosticTest' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=DiagnosticTest">Diagnostic Test</a></li>
                           <li
                           <cfif Page eq 'DiagnosticLab' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=DiagnosticLab">Diagnostic Lab</a></li>
                           <li
                           <cfif Page eq 'PreservationMethod' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=PreservationMethod">Preservation Method</a></li>
                           <li
                           <cfif Page eq 'SampleType' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=SampleType">Sample Type/Tissue Type</a></li>
                           <li
                           <cfif Page eq 'SampleLocation' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=SampleLocation">Sample Location</a></li>
                           <li
                           <cfif Page eq 'SampleTracking' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=SampleTracking">Sample Tracking</a></li>
                           <!--- <li
                           <cfif Page eq 'TissueType' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=TissueType">Tissue Type</a></li> --->
                           <li
                           <cfif Page eq 'Unit_Of_Sample' AND NOT isArchive> class='active'</cfif>
                           ><a href="#Application.superadmin#?Module=StaticData&Page=Unit_Of_Sample">Unit of Sample</a></li>

                           <li class="has-sub <cfif Page eq 'RbcMorphology' OR page eq 'PlateletMorphology' OR page eq 'WbcMorphology' OR page eq 'HemolysisIndex' OR page eq 'LipemiaIndex'>active</cfif>">
                              <a href="javascript:;"><b class="caret pull-right"></b>Blood Values</a>
                              <ul class="sub-menu">
                                <li 
                                  <cfif Page eq 'RbcMorphology' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=RbcMorphology">RBC Morphology</a></li>
                                  <li 
                                  <cfif Page eq 'PlateletMorphology' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=PlateletMorphology">Platelet Morphology</a></li>
                                  <li 
                                  <cfif Page eq 'WbcMorphology' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=WbcMorphology">WBC Morphology</a></li>
                                  <li 
                                  <cfif Page eq 'HemolysisIndex' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=HemolysisIndex">Hemolysis Index</a></li>
                                  <li 
                                  <cfif Page eq 'LipemiaIndex' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=LipemiaIndex">Lipemia Index</a></li>
                              </ul>
                           <li>
                           <li class="has-sub <cfif Page eq 'LiverFindings' OR page eq 'LungFindings' OR Page eq 'ParasiteLocation' OR Page eq 'ParasiteType' OR PAge eq 'GIForeignMaterial'OR Page eq 'NxLocation'OR Page eq 'LymphNodePresent'>active</cfif>">
                              <a href="javascript:;"><b class="caret pull-right"></b>Necropsy</a>
                              <ul class="sub-menu">
                                <li 
                                  <cfif Page eq 'LiverFindings' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=LiverFindings">Liver Findings</a></li>
                                  <li 
                                  <cfif Page eq 'LungFindings' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=LungFindings">Lung Findings</a>
                                  </li>
                                  <li 
                                  <cfif Page eq 'ParasiteLocation' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=ParasiteLocation">Parasite Location</a>
                                  </li>
                                  <li 
                                  <cfif Page eq 'ParasiteType' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=ParasiteType">Parasite Type</a>
                                  </li>
                                  <li 
                                  <cfif Page eq 'GIForeignMaterial' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=GIForeignMaterial">GI Foreign Material</a>
                                  </li>
                                  <li 
                                  <cfif Page eq 'NxLocation' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=NxLocation">Nx Location</a>
                                  </li>
                                  <li 
                                  <cfif Page eq 'LymphNodePresent' AND NOT isArchive> class='active'</cfif>
                                  ><a href="#Application.superadmin#?Module=StaticData&Page=LymphNodePresent">Lymph Node Present</a>
                                  </li>
                                 
                              </ul>
                           <li>
                        </ul>
                     <li>
                     <li 
                        <cfif Page eq 'Behaviors' AND NOT isArchive> class='active'</cfif>
                        ><a href="#Application.superadmin#?Module=StaticData&Page=Behaviors">Behaviors</a>
                     </li>
                     <li 
                     <cfif Page eq 'PreySpecies' AND NOT isArchive> class='active'</cfif>
                     ><a href="#Application.superadmin#?Module=StaticData&Page=PreySpecies">Prey Species</a></li>

                     <li 
                     <cfif Page eq 'LesionType' AND NOT isArchive> class='active'</cfif>
                     ><a href="#Application.superadmin#?Module=StaticData&Page=LesionType">Lesion Type</a></li>
                      <li <cfif Page eq 'ScarType' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=ScarType">Scar Type</a></li>
                     <li <cfif Page eq 'YobSource' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=YobSource">YOB Source</a></li>
                     <li <cfif Page eq 'SourceSex' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SourceSex">Source Sex</a></li>
                     <li <cfif Page eq 'CetaceanSpecies' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=CetaceanSpecies">Cetacean Species</a></li>
                     <li <cfif Page eq 'IR_CountyLocation' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=IR_CountyLocation">IR County/Location</a></li>
                     <li <cfif Page eq 'Descriptions' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Descriptions">Fin Change Descriptions</a></li>
                     <li <cfif Page eq 'SightingMap' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SightingMap">SightingMap</a></li>
                    
                  </ul>
               </li>
            </cfif>
            
            <li class="has-sub <cfif Module eq 'Sighting' AND NOT isArchive>active</cfif>">
               <a href="javascript:;">
               <b class="caret pull-right"></b>
               <i class="fa fa-suitcase"></i>
               <span>Sighting</span>
               </a>
               <ul class="sub-menu">
                  <li 
                  <cfif Page eq 'Home' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Sighting&Page=Home">Sighting Form</a></li>                  
                  <li 
                  <cfif Page eq 'Dscore' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Sighting&Page=Dscore">Fin Change</a></li>                  
                  <li 
                  <cfif Page eq 'PermanentScar' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Sighting&Page=PermanentScar">Permanent Scar</a></li>                  
                  <li 
                  <cfif Page eq 'PhotoAnalysis' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Sighting&Page=PhotoAnalysis">Photo Analysis</a></li>
                  <li 
                  <cfif Page eq 'TrackingList' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Sighting&Page=TrackingList">Tracking List</a></li>
               </ul>
            </li>
            <li class="has-sub <cfif Module eq 'Stranding' AND NOT isArchive>active</cfif>">
               <a href="javascript:;">
               <b class="caret pull-right"></b>
               <i class="fa fa-suitcase"></i>
               <span>Stranding</span>
               </a>
               <ul class="sub-menu">
                  <!--- <li
                  <cfif Page eq 'CetaceanExam' AND NOT isArchive> class='active'</cfif>>
                     <a href="#Application.superadmin#?Module=Stranding&Page=CetaceanExam">Cetacean Exam</a>
                  </li>
                  <li <cfif Page eq 'HIForm' AND NOT isArchive> class='active'</cfif>>
                     <a href="#Application.superadmin#?Module=Stranding&Page=HIForm">HI Form</a>
                  </li>
                  <li <cfif Page eq 'LevelAForm' AND NOT isArchive> class='active'</cfif>>
                     <a href="#Application.superadmin#?Module=Stranding&Page=LevelAForm">Level A Form</a>
                  </li>
                   <li <cfif Page eq 'Histopathology' AND NOT isArchive> class='active'</cfif>>
                     <a href="#Application.superadmin#?Module=Stranding&Page=Histopathology">Histopathology</a>
                  </li>
                  <li <cfif Page eq 'BloodValues' AND NOT isArchive> class='active'</cfif>>
                    <a href="#Application.superadmin#?Module=Stranding&Page=BloodValues">Blood Values</a>
                 </li>
                 <li <cfif Page eq 'Toxicolgy' AND NOT isArchive> class='active'</cfif>>
                  <a href="#Application.superadmin#?Module=Stranding&Page=Toxicology">Toxicology</a>
                  </li>
                    <li <cfif Page eq 'AncillaryDiagnostics' AND NOT isArchive> class='active'</cfif>>
                      <a href="#Application.superadmin#?Module=Stranding&Page=AncillaryDiagnostics">Ancillary Diagnostics</a>
                  </li>
                  <li <cfif Page eq 'SampleArchive' AND NOT isArchive> class='active'</cfif>>
                    <a href="#Application.superadmin#?Module=Stranding&Page=SampleArchive">Sample Archive</a>
                  </li>
                  <li <cfif Page eq 'CetaceanNecropsyReport' AND NOT isArchive> class='active'</cfif>>
                    <a href="#Application.superadmin#?Module=Stranding&Page=CetaceanNecropsyReport">Cetacean Necropsy Report</a>
                  </li> --->
                  <li <cfif Page eq 'StrandingTabs' AND NOT isArchive> class='active'</cfif>>
                    <a href="#Application.superadmin#?Module=Stranding&Page=StrandingTabs">StrandingTabs</a>
                  </li>
                  <li <cfif Page eq 'Search' AND NOT isArchive> class='active'</cfif>>
                    <a href="#Application.superadmin#?Module=Stranding&Page=Search">Search</a>
                  </li>
                  
                
               </ul>
            </li>
            <li class="has-sub <cfif Module eq 'Incident' AND NOT isArchive>active</cfif>">
               <a href="javascript:;">
               <b class="caret pull-right"></b>
               <i class="fa fa-suitcase"></i>
               <span>Incident</span>
               </a>
               <ul class="sub-menu">
                  <li 
                  <cfif Page eq 'incidentform' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Incident&Page=incidentform">Incident Form</a></li>
                  </li>
               </ul>
            </li>
            <li class="has-sub <cfif Module eq 'Cetacean' AND NOT isArchive>active</cfif>">
               <a href="javascript:;">
               <b class="caret pull-right"></b>
               <i class="fa fa-suitcase"></i>
               <span>Cetacean </span>
               </a>
               <ul class="sub-menu">
                  <li 
                  <cfif Page eq 'AddCetacean' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Cetacean&Page=AddCetacean">Add Cetacean</a></li>
                  <li 
                  <cfif Page eq 'ListCetacean' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Cetacean&Page=ListCetacean">All Cetacean</a></li>      
                  <li 
                  <cfif Page eq 'CetaceanHistory' AND NOT isArchive> class='active'</cfif>
                  ><a href="#Application.superadmin#?Module=Cetacean&Page=CetaceanHistory">Cetacean History</a></li>                
               </ul>
            </li>
            <li class="has-sub <cfif isArchive>active</cfif>">
               <a href="javascript:;">
               <b class="caret pull-right"></b>
               <i class="fa fa-suitcase"></i>
               <span>Archive</span>
               </a>
               <ul class="sub-menu">
                  <li class="has-sub <cfif ArchiveModule eq 'Reporting'>active</cfif>">
                     <a href="javascript:;">
                     <b class="caret pull-right"></b>
                     <i class="fa fa-suitcase"></i>
                     <span>Reporting</span>
                     </a>
                     <ul class="sub-menu" >
                        <li class="has-sub <cfif Page eq 'RollcallReport' OR Page eq 'BestplacesReport' OR Page eq 'BiopsyReport' or Page eq 'BiopsyCatalogReport' or Page eq 'HERAReport' or Page eq 'MMHSRPReport' or Page eq 'NCSGReport' or Page eq 'BiopsyNOAASummary' or Page eq 'SampleDispositionReport'  >active</cfif>">
                           <a href="javascript:;"><b class="caret pull-right"></b>Survey Reports</a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'RollcallReport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=RollcallReport&Archive">Roll Call Report</a></li>
                              <!---  <li 
                              <cfif Page eq 'BestplacesReport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=BestplacesReport&Archive">Best Places Report</a></li>
                              <li 
                              <cfif Page eq 'HERAReport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=HERAReport&Archive">HERA Report</a></li>
                             <li  
                              <cfif Page eq 'MMHSRPReport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=MMHSRPReport&Archive">MMHSRP Report</a></li>
                              <li 
                              <cfif Page eq 'DeadDolphin' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Dolphin&Page=DeadDolphin&Archive">Dead Dolphins</a></li>
                              <li 
                              <cfif Page eq 'NCSGReport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=NCSGReport&Archive">NCSG Report</a></li> --->
                           </ul>
                        </li>
                        <!---<li class="has-sub <cfif Page eq 'BodyReport' or Page eq 'VitalStatsReport' >active</cfif>" >
                           <a href="javascript:;"><b class="caret pull-right"></b>Project Reports</a>
                           <ul class="sub-menu">
                               <li><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=BodyReport&Archive">Body Report</a></li>
                            <li><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=VitalStatsReport&Archive">Vital Stats Report</a></li>
                           </ul>
                        </li> 
                        <li class="has-sub<cfif Page eq 'NOAA_Reports' > active</cfif>">
                           <a href="#Application.superadmin#?ArchiveModule=Reporting&Page=NOAA_Reports&Archive">NOAA Reports</a>
                        </li>
                        <li class="has-sub">
                           <a href="javascript:;"><b class="caret pull-right"></b>Coverage Reports</a>
                           <ul class="sub-menu">
                            <li 
                              <cfif Page eq 'ZoneReport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=ZoneReport&Archive">Zone Report</a></li>
                           </ul>
                        </li> --->
                        <li class="has-sub<cfif Page eq 'AnnualCensusReport'> active</cfif>">
<!---                            <a href="#Application.superadmin#?ArchiveModule=Reporting&Page=AnnualCensusReport&Archive">Annual Census Report</a> --->
                        </li>
                        <li class="has-sub<cfif Page eq 'PopulationViability'> active</cfif>">
                           <a href="#Application.superadmin#?ArchiveModule=Reporting&Page=PopulationViability&Archive">Population Viability Report</a>
                        </li>
                        <li class="has-sub">
                           <a href="javascript:;"><b class="caret pull-right"></b>Calf Reports</a>
                           <ul class="sub-menu">
<!---                               <li  
                              <cfif Page eq 'COAReport'>class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=COAReport&Archive">COA Report</a></li>
                             ---> <li 
                              <cfif Page eq 'Birth_Death_Rate_Report'>class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=BirthDeathRateReport&Archive">Birth - Death Rate</a></li>
                              <!--- <li 
                              <cfif Page eq 'HomeRangeReport'>class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=HomeRangeReport&Archive">Home Range Report</a></li>
                              <li  
                              <cfif Page eq 'BodyConditionReport'>class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=BodyConditionReport&Archive">Body Condition Report</a></li>
                              <li 
                              <cfif Page eq 'DolphinActivityReport'>class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Reporting&Page=DolphinActivityReport&Archive">Dolphin Activity Report</a></li>
                          ---> </ul>
                        </li>
                     </ul>
                  </li>
                  <!---<li class="has-sub <cfif ArchiveModule eq 'Accounts' >active</cfif>">
                     <a href="javascript:;">
                     <b class="caret pull-right"></b>
                     <i class="fa fa-suitcase"></i>
                     <span>Accounts</span>
                     </a>
                     <ul class="sub-menu">
                        <li 
                        <cfif Page eq 'UsersList' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Accounts&Page=UsersList&Archive">Users List</a></li>
                        <li 
                        <cfif Page eq 'AddUser' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Accounts&Page=AddUser&Archive">Add User</a></li>
                        <li class="has-sub <cfif Page eq 'AddGroup' OR Page eq 'ViewGroups' >active</cfif>" >
                           <a href="javascript:;">
                           <b class="caret pull-right"></b>
                           Group Mangement
                           </a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'AddGroup' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Accounts&Page=AddGroup&Archive">Add Group</a></li>
                              <li 
                              <cfif Page eq 'ViewGroups' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=Accounts&Page=ViewGroups&Archive">View Groups</a></li>
                           </ul>
                        </li>
                     </ul>
                  </li>
                  <li class="has-sub <cfif ArchiveModule eq 'StaticData' >active</cfif>">
                     <a href="javascript:;">
                     <b class="caret pull-right"></b>
                     <i class="fa fa-suitcase"></i>
                     <span>Master Data </span>
                     </a>
                     <ul class="sub-menu">
                        <li class="has-sub <cfif Page eq 'WaveHeight' OR Page eq 'Weather' OR Page eq 'Sightability' or Page eq 'Beaufort' or Page eq 'Glare' or Page eq 'AssocBio'>active</cfif>" >
                           <a href="javascript:;">
                           <b class="caret pull-right"></b>
                           Condition Environment
                           </a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'WaveHeight' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=WaveHeight&Archive">Wave Height</a></li>
                              <li 
                              <cfif Page eq 'Weather' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Weather&Archive">Weather</a></li>
                              <li 
                              <cfif Page eq 'Sightability' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Sightability&Archive">Sightability</a></li>
                              <li 
                              <cfif Page eq 'Beaufort' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Beaufort&Archive">Beaufort</a></li>
                              <li 
                              <cfif Page eq 'Glare' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Glare&Archive">Glare</a></li>
                              <li 
                              <cfif Page eq 'AssocBio' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=AssocBio&Archive">Assoc Bio</a></li>
                              <li 
                              <cfif Page eq 'Tide' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Tide&Archive">Tide</a></li>
                              <li 
                              <cfif Page eq 'Habitat' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Habitat&Archive">Habitat</a></li>
                              <li 
                              <cfif Page eq 'Strcutres' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Strcutres&Archive">Structures</a></li>
                           </ul>
                        </li>
                        <li class="has-sub <cfif Page eq 'Camera' OR Page eq 'Lens' >active</cfif>" >
                           <a href="javascript:;">
                           <b class="caret pull-right"></b>
                           Photo Equipment
                           </a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'Camera' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Camera&Archive">Cameras</a></li>
                              <li 
                              <cfif Page eq 'Lens' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Lens&Archive">Lens</a></li>
                           </ul>
                        <li>
                        <li class="has-sub <cfif Page eq 'ResearchTeamMembers' OR Page eq 'Plateform' >active</cfif>">
                           <a href="javascript:;">
                           <b class="caret pull-right"></b>
                           Team
                           </a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'ResearchTeamMembers' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=ResearchTeamMembers&Archive">Research Team Members</a></li>
                              <li 
                              <cfif Page eq 'Plateform' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Plateform&Archive">Platforms</a></li>
                           </ul>
                        <li>
                        <li class="has-sub <cfif Page eq 'BiopsyBehavior' OR Page eq 'HitDescriptors' OR Page eq 'MissDescriptors' or Page eq 'HitLocation' or Page eq 'SubSampleType' >active</cfif>">
                           <a href="javascript:;">
                           <b class="caret pull-right"></b>
                           Biopsy
                           </a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'BiopsyBehavior' > class='active'</cfif>
                              >
                              <a href="#Application.superadmin#?ArchiveModule=StaticData&Page=BiopsyBehavior&Archive">Biopsy Behavior</a></li>
                              <li 
                              <cfif Page eq 'HitDescriptors ' > class='active'</cfif>
                              >
                              <a href="#Application.superadmin#?ArchiveModule=StaticData&Page=HitDescriptors&Archive">Shot Descriptors</a></li>
                              <li 
                              <cfif Page eq 'MissDescriptors' > class='active'</cfif>
                              >
                              <a href="#Application.superadmin#?ArchiveModule=StaticData&Page=MissDescriptors&Archive">Miss Descriptors</a></li>
                              <li 
                              <cfif Page eq 'HitLocation' > class='active'</cfif>
                              >
                              <a href="#Application.superadmin#?ArchiveModule=StaticData&Page=HitLocation&Archive">Hit Location</a></li>
                              <li 
                              <cfif Page eq 'SubSampleType' > class='active'</cfif>
                              >
                              <a href="#Application.superadmin#?ArchiveModule=StaticData&Page=SubSampleType&Archive">Sub-Sample Tissue  Type</a></li>
                           </ul>
                        <li>
                        <li class="has-sub <cfif Page eq 'SDO' OR Page eq 'Interaction'>active</cfif>">
                           <a href="javascript:;">
                           <b class="caret pull-right"></b>
                           Skin Disorders
                           </a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'SDO' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=SDO&Archive">SDO</a></li>
                              <li 
                              <cfif Page eq 'Interaction' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Interaction&Archive">Interaction</a></li>
                           </ul>
                        <li>
                        <li class="has-sub <cfif Page eq 'Stock' OR Page eq 'Zones' OR Page eq 'SurveyArea' or Page eq 'Type' >active</cfif>">
                           <a href="javascript:;"><b class="caret pull-right"></b>Survey Data</a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'Stock' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Stock&Archive">NOAA Stocks</a></li>
                              <li 
                              <cfif Page eq 'SurveyArea'> class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=SurveyArea&Archive">Body of Water</a></li>
                              <li 
                              <cfif Page eq 'Type' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Type&Archive">Survey Type</a></li>
                              <li 
                              <cfif Page eq 'SubType' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=SubType&Archive">Sub Type</a></li>
                              <li 
                              <cfif Page eq 'FundingSource' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=FundingSource&Archive">Funding Source</a></li>
                              <li 
                              <cfif Page eq 'Zones' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Zones&Archive">Zones</a></li>
                           </ul>
                        <li>
                        <li class="has-sub <cfif Page eq 'YobSource' OR Page eq 'Catalog' OR Page eq 'Descriptor' or Page eq 'DolphinCondition' or Page eq 'Iloc' >active</cfif>">
                           <a href="javascript:;">
                           <b class="caret pull-right"></b>
                           Dolphins
                           </a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'YobSource' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=YobSource&Archive">YOB Source</a></li>
                              <li 
                              <cfif Page eq 'Catalog' > class='active'</cfif>
                              >
                              <a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Catalog&Archive">Catalog</a></li>
                              <li 
                              <cfif Page eq 'Descriptor' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Descriptor&Archive">Fin Descriptors</a></li>
                              <li 
                              <cfif Page eq 'DolphinCondition' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=DolphinCondition&Archive">Dolphins Conditions</a></li>
                              <li 
                              <cfif Page eq 'Iloc' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Iloc&Archive">ILoc</a></li>
                              <li 
                              <cfif Page eq 'Dscore' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Dscore&Archive">Dscore</a></li>
                              <li 
                              <cfif Page eq 'SourceSex' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=SourceSex&Archive">Source Sex</a></li>
                           </ul>
                        <li>
                           <li 
                           <cfif Page eq 'EstimatedScore' > class='active'</cfif>
                           ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=EstimatedScore&Archive">Estimated Score</a>
                        </li>
                        <li 
                        <cfif Page eq 'WatchedEmails' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=WatchedEmails&Archive">Dolphin watched emails</a></li>
                        <li class="has-sub <cfif Page eq 'dolphinimport' OR Page eq 'sightingimport' OR Page eq 'projectimport' or Page eq 'biopsyimport' or Page eq 'tluimport'>active</cfif>" >
                           <a href="javascript:;">
                           <b class="caret pull-right"></b>
                           Import Utility
                           </a>
                           <ul class="sub-menu">
                              <li 
                              <cfif Page eq 'dolphinimport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=dolphinimport&Archive">Dolphin Import</a></li>
                              <li 
                              <cfif Page eq 'sightingimport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=sightingimport&Archive">Sighting Import</a></li>
                              <li 
                              <cfif Page eq 'projectimport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=projectimport&Archive">Survey Import</a></li>
                              <li 
                              <cfif Page eq 'biopsyimport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=biopsyimport&Archive">Biopsy Import</a></li>
                              <li 
                              <cfif Page eq 'tluimport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=tluimport&Archive">Tluzone Import</a></li>
                              <li 
                              <cfif Page eq 'Interactionimport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=Interactionimport&Archive">Interaction Import</a></li>
                              <li 
                              <cfif Page eq 'Interactionimport' > class='active'</cfif>
                              ><a href="#Application.superadmin#?ArchiveModule=StaticData&Page=MMHSRPimport&Archive">MMHSRP Import</a></li>
                           </ul>
                        </li>
                     </ul>
                  </li>
                  <li class="has-sub <cfif ArchiveModule eq 'Sighting' >active</cfif>">
                     <a href="javascript:;">
                     <b class="caret pull-right"></b>
                     <i class="fa fa-suitcase"></i>
                     <span>Sighting</span>
                     </a>
                     <ul class="sub-menu">
                        <li 
                        <cfif Page eq 'Home' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Sighting&Page=Home&Archive">Sighting Form</a></li>
                        <li 
                        <cfif Page eq 'Dscore' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Sighting&Page=Dscore&Archive">Fin Change</a></li>
                        <li 
                        <cfif Page eq 'PhotoAnalysis' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Sighting&Page=PhotoAnalysis&Archive">Photo Analysis</a></li>
                     </ul>
                  </li>
                  <li class="has-sub <cfif ArchiveModule eq 'Incident' >active</cfif>">
                     <a href="javascript:;">
                     <b class="caret pull-right"></b>
                     <i class="fa fa-suitcase"></i>
                     <span>Incident</span>
                     </a>
                     <ul class="sub-menu">
                        <li 
                        <cfif Page eq 'incidentform' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Incident&Page=incidentform&Archive">Incident Form</a></li>
                        <li 
                        <cfif Page eq 'SightingReview' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Sighting&Page=SightingReview&Archive"> Sighting Review</a></li>
                     </ul>
                  </li> --->
                  <li class="has-sub <cfif ArchiveModule eq 'Dolphin' >active</cfif>">
                     <a href="javascript:;">
                     <b class="caret pull-right"></b>
                     <i class="fa fa-suitcase"></i>
                     <span>Dolphin</span>
                     </a>
                     <ul class="sub-menu">
                        <!---<li 
                        <cfif Page eq 'AddDolphin' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Dolphin&Page=AddDolphin&Archive">Add Dolphin</a></li> --->
                        <li 
                        <cfif Page eq 'ListDolphin' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Dolphin&Page=ListDolphin&Archive">All Dolphin</a></li>
                        <li 
                        <cfif Page eq 'DolphinHistory' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Dolphin&Page=DolphinHistory&Archive">Dolphin History</a>
                        </li>
                        <!---<li 
                        <cfif Page eq 'SDOForm' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Dolphin&Page=SDOForm&Archive">SDO Form</a> </li>--->
                        </li>
                        <li 
                        <cfif Page eq 'AddDolphin' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Dolphin&Page=DeadDolphinList&Archive">MMHSRP</a></li>
                        <li 
                        <cfif Page eq 'dolphinCatalog' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Dolphin&Page=dolphinCatalog&Archive">Dolphin Catalog</a></li>
                     </ul>
                  </li>
                  <!---<li class="has-sub <cfif ArchiveModule eq 'Biopsy' >active</cfif>">
                     <a href="javascript:;">
                     <b class="caret pull-right"></b>
                     <i class="fa fa-suitcase"></i>
                     <span>Biopsy</span>
                     </a>
                     <ul class="sub-menu">
                        <li 
                        <cfif Page eq 'ShotSheet' > class='active'</cfif>
                        ><a href="#Application.superadmin#?ArchiveModule=Biopsy&Page=ShotSheet&Archive">Biopsy Shot Sheet</a></li>
                        <li  class='active'><a href="#Application.superadmin#?ArchiveModule=Biopsy&Page=ShotSheet&Archive">Biopsy Sample</a></li>
                     </ul>
                  </li> --->
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