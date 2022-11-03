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

        <li class="has-sub <cfif Module eq 'Alerts' >active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        <i class="fa fa-suitcase"></i>
        <span>Alerts</span>
    </a>
<ul class="sub-menu">
        <li <cfif Page eq 'alerts' > class='active'</cfif>><a href="#Application.superadmin#?Module=Alerts&Page=alerts">Alerts</a></li>
        <li <cfif Page eq 'alerts_tba' > class='active'</cfif>><a href="#Application.superadmin#?Module=Alerts&Page=alerts_tba">Rules (tba)</a>
</li>

</ul>
</li>




        <li class="has-sub <cfif Module eq 'Reporting' >active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        <i class="fa fa-suitcase"></i>
        <span>Reporting</span>
    </a>
<ul class="sub-menu" >


        <li class="has-sub <cfif Page eq 'RollcallReport' OR Page eq 'BestplacesReport' OR Page eq 'BiopsyReport' or Page eq 'BiopsyCatalogReport' or Page eq 'HERAReport' or Page eq 'MMHSRPReport' or Page eq 'NCSGReport' or Page eq 'BiopsyNOAASummary' or Page eq 'SampleDispositionReport'  >active</cfif>">
    <a href="javascript:;"><b class="caret pull-right"></b>Survey Reports</a>
<ul class="sub-menu">
        <li <cfif Page eq 'RollcallReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=RollcallReport">Roll Call Report</a></li>
        <li <cfif Page eq 'BestplacesReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=BestplacesReport">Best Places Report</a></li>
        <li <cfif Page eq 'BiopsyReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=BiopsyReport">Biopsy Report</a></li>
        <li <cfif Page eq 'BiopsyCatalogReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=BiopsyCatalogReport">Biopsy Catalog Report</a></li>
        <li <cfif Page eq 'HERAReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=HERAReport">HERA Report</a></li>
        <li <cfif Page eq 'MMHSRPReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=MMHSRPReport">MMHSRP Report</a></li>
        <li <cfif Page eq 'DeadDolphin' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=DeadDolphin">Dead Dolphins</a></li>

        <li <cfif Page eq 'NCSGReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=NCSGReport">NCSG Report</a></li>
        <li <cfif Page eq 'BiopsyNOAASummary' > class='active'</cfif>>
        <a href="#Application.superadmin#?Module=Reporting&Page=BiopsyNOAASummary">Biopsy NOAA Summary</a></li>
        <li <cfif Page eq 'SampleDispositionReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=SampleDispositionReport">Sample Disposition Report</a></li>
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

        <li class="has-sub<cfif Page eq 'NOAA_Reports' > active</cfif>">
        <a href="#Application.superadmin#?Module=Reporting&Page=NOAA_Reports">NOAA Reports</a>
</li>
<li class="has-sub">
    <a href="javascript:;"><b class="caret pull-right"></b>Coverage Reports</a>
<ul class="sub-menu">
        <li <cfif Page eq 'ZoneReport' > class='active'</cfif>><a href="#Application.superadmin#?Module=Reporting&Page=ZoneReport">Zone Report</a></li>
<li><a href="##">TBA</a></li>
<li><a href="##">TBA</a></li>
</ul>
</li>
        <li class="has-sub<cfif Page eq 'UsersActivityReport' > active</cfif>">
        <a href="#Application.superadmin#?Module=Reporting&Page=UsersActivityReport">Users Activity Reports</a>
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
        <li class="has-sub <cfif Page eq 'AddGroup' OR Page eq 'ViewGroups' >active</cfif>" >
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        Group Mangement
    </a>
<ul class="sub-menu">
        <li <cfif Page eq 'AddGroup' > class='active'</cfif>><a href="#Application.superadmin#?Module=Accounts&Page=AddGroup">Add Group</a></li>
        <li <cfif Page eq 'ViewGroups' > class='active'</cfif>><a href="#Application.superadmin#?Module=Accounts&Page=ViewGroups">View Groups</a></li>
</ul>
</li>
</ul>
</li>

<!---<li class="has-sub <cfif Module eq 'Group' >active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        <i class="fa fa-suitcase"></i>
        <span>Group Mangement</span>
    </a>
    <ul class="sub-menu">
        <li <cfif Page eq 'AddGroup' > class='active'</cfif>><a href="#Application.superadmin#?Module=Group&Page=AddGroup">Add Group</a></li>
        <li <cfif Page eq 'ViewGroups' > class='active'</cfif>><a href="#Application.superadmin#?Module=Group&Page=ViewGroups">View Groups</a></li>
    </ul>
</li>--->

    <li class="has-sub <cfif Module eq 'StaticData' >active</cfif>">
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
            <li <cfif Page eq 'WaveHeight' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=WaveHeight">Wave Height</a></li>
            <li <cfif Page eq 'Weather' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Weather">Weather</a></li>
            <li <cfif Page eq 'Sightability' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Sightability">Sightability</a></li>
            <li <cfif Page eq 'Beaufort' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Beaufort">Beaufort</a></li>
            <li <cfif Page eq 'Glare' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Glare">Glare</a></li>
            <li <cfif Page eq 'AssocBio' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=AssocBio">Assoc Bio</a></li>
            <li <cfif Page eq 'Tide' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Tide">Tide</a></li>
            <li <cfif Page eq 'Habitat' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Habitat">Habitat</a></li>
             <li <cfif Page eq 'Strcutres' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Strcutres">Strcutres</a></li>

    </ul>
        </li>
        <li class="has-sub <cfif Page eq 'Camera' OR Page eq 'Lens' >active</cfif>" >
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        Photo Equipment
    </a>
<ul class="sub-menu">
        <li <cfif Page eq 'Camera' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Camera">Cameras</a></li>
        <li <cfif Page eq 'Lens' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Lens">Lens</a></li>
</ul>
    <li>


        <li class="has-sub <cfif Page eq 'ResearchTeamMembers' OR Page eq 'Plateform' >active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        Team
    </a>
<ul class="sub-menu">

        <li <cfif Page eq 'ResearchTeamMembers' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=ResearchTeamMembers">Research Team Members</a></li>
        <li <cfif Page eq 'Plateform' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Plateform">Platforms</a></li>
</ul>
    <li>




        <li class="has-sub <cfif Page eq 'BiopsyBehavior' OR Page eq 'HitDescriptors' OR Page eq 'MissDescriptors' or Page eq 'HitLocation' or Page eq 'SubSampleType' >active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        Biopsy
    </a>
<ul class="sub-menu">

        <li <cfif Page eq 'BiopsyBehavior' > class='active'</cfif>>
        <a href="#Application.superadmin#?Module=StaticData&Page=BiopsyBehavior">Biopsy Behavior</a>
</li>
        <li <cfif Page eq 'HitDescriptors ' > class='active'</cfif>>
        <a href="#Application.superadmin#?Module=StaticData&Page=HitDescriptors">Shot Descriptors</a>
</li>

        <li <cfif Page eq 'MissDescriptors' > class='active'</cfif>>
        <a href="#Application.superadmin#?Module=StaticData&Page=MissDescriptors">Miss Descriptors</a>
</li>

        <li <cfif Page eq 'HitLocation' > class='active'</cfif>>
        <a href="#Application.superadmin#?Module=StaticData&Page=HitLocation">Hit Location</a>
</li>
        <li <cfif Page eq 'SubSampleType' > class='active'</cfif>>
        <a href="#Application.superadmin#?Module=StaticData&Page=SubSampleType">Sub-Sample Tissue  Type</a>
			</li>
			</ul>
				<li>


        <li class="has-sub <cfif Page eq 'SDO' OR Page eq 'Interaction'>active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        Skin Disorders
    </a>
<ul class="sub-menu">

        <li <cfif Page eq 'SDO' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SDO">SDO</a></li>
        <li <cfif Page eq 'Interaction' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Interaction">Interaction</a></li>
</ul>
    <li>


        <li class="has-sub <cfif Page eq 'Stock' OR Page eq 'Zones' OR Page eq 'SurveyArea' or Page eq 'Type' >active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        Location
    </a>
		<ul class="sub-menu">
				<li <cfif Page eq 'Stock' > class='active'</cfif>>
				<a href="#Application.superadmin#?Module=StaticData&Page=Stock">Stocks</a>
		</li>
				<li <cfif Page eq 'Zones' > class='active'</cfif>>
				<a href="#Application.superadmin#?Module=StaticData&Page=Zones">Zones</a>
		</li>
				<li <cfif Page eq 'SurveyArea' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SurveyArea">Survey Area</a></li>
				<li <cfif Page eq 'Type' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Type">Survey Type</a></li>
				<li <cfif Page eq 'SubType' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SubType">Sub Type</a></li>

		</ul>
    <li>

        <li class="has-sub <cfif Page eq 'YobSource' OR Page eq 'Catalog' OR Page eq 'Descriptor' or Page eq 'DolphinCondition' or Page eq 'Iloc' >active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        Dolphins
    </a>
		<ul class="sub-menu">

				<li <cfif Page eq 'YobSource' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=YobSource">YOB Source</a></li>
				<li <cfif Page eq 'Catalog' > class='active'</cfif>>
				<a href="#Application.superadmin#?Module=StaticData&Page=Catalog">Catalog</a>
		</li>
        <li <cfif Page eq 'Descriptor' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Descriptor">Fin Descriptors</a></li>
        <li <cfif Page eq 'DolphinCondition' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=DolphinCondition">Dolphins Conditions</a></li>
        <li <cfif Page eq 'Iloc' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Iloc">ILoc</a></li>
        <li <cfif Page eq 'Dscore' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Dscore">Dscore</a></li>
        <li <cfif Page eq 'SourceSex' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=SourceSex">Source Sex</a></li>
		</ul>

   		 <li>

        <li <cfif Page eq 'EstimatedScore' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=EstimatedScore">Estimated Score</a></li>

  <li class="has-sub <cfif Page eq 'dolphinimport' OR Page eq 'sightingimport' OR Page eq 'projectimport' or Page eq 'biopsyimport' or Page eq 'tluimport'>active</cfif>" >
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        Import Utility
    </a>
		<ul class="sub-menu">
				<li <cfif Page eq 'dolphinimport' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=dolphinimport">Dolphin Import</a></li>
				<li <cfif Page eq 'sightingimport' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=sightingimport">Sighting Import</a></li>
				<li <cfif Page eq 'projectimport' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=projectimport">Project Import</a></li>
				<li <cfif Page eq 'biopsyimport' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=biopsyimport">Biopsy Import</a></li>
				<li <cfif Page eq 'tluimport' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=tluimport">Tluzone Import</a></li>
	             <li <cfif Page eq 'Interactionimport' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=Interactionimport">Interaction Import</a></li>

		</ul>
		</li>
<!---<li <cfif Page eq 'TeamMembers' > class='active'</cfif>><a href="#Application.superadmin#?Module=StaticData&Page=TeamMembers">Team Members</a></li>--->


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

<!--- <li <cfif Page eq 'SightingReview' > class='active'</cfif>><a href="#Application.superadmin#?Module=Sighting&Page=SightingReview"> Sighting Review</a>
</li>--->

    </ul>
    </li>
            <li class="has-sub <cfif Module eq 'Incident' >active</cfif>">
				<a href="javascript:;">
					<b class="caret pull-right"></b>
					<i class="fa fa-suitcase"></i>
					<span>Incident</span>
				</a>
				<ul class="sub-menu">
						<li <cfif Page eq 'incidentform' > class='active'</cfif>><a href="#Application.superadmin#?Module=Incident&Page=incidentform">Incident Form</a></li>
                 </li>

<!--- <li <cfif Page eq 'SightingReview' > class='active'</cfif>><a href="#Application.superadmin#?Module=Sighting&Page=SightingReview"> Sighting Review</a>
</li>--->

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
			<!---<li <cfif Page eq 'SDODolphinList' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=SDODolphinList">SDO List</a>--->
					</li>
						<li <cfif Page eq 'AddDolphin' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=DeadDolphinList">MMHSRP</a></li>
			<!---<li <cfif Page eq 'Dscore' > class='active'</cfif>><a href="#Application.superadmin#?Module=Dolphin&Page=Dscore">Dscore</a></li>--->

				</ul>
    				</li>
            <li class="has-sub <cfif Module eq 'Biopsy' >active</cfif>">
    <a href="javascript:;">
        <b class="caret pull-right"></b>
        <i class="fa fa-suitcase"></i>
        <span>Biopsy</span>
    </a>
<ul class="sub-menu">
        <li <cfif Page eq 'ShotSheet' > class='active'</cfif>><a href="#Application.superadmin#?Module=Biopsy&Page=ShotSheet">Biopsy Shot Sheet</a></li>
<li  class='active'><a href="#Application.superadmin#?Module=Biopsy&Page=ShotSheet">Biopsy Sample</a></li>
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
