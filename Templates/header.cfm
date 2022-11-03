<cfif structKeyExists(URL, "dest") && isdefined('url.dest')>
	<cfset StructClear(Session)>
	<cfabort>
</cfif>
<cfoutput>
	<!-- begin ##header -->
		<div id="header" class="header navbar navbar-default navbar-fixed-top">
			
			<!-- begin container-fluid -->
			<div class="container-fluid">
				<!-- begin mobile sidebar expand / collapse button -->
				<div class="navbar-header"><a href="#Application.siteroot#?Module=Home&Page=Dashboard" class="navbar-brand">
				<img src="#Application.superadminTemplateIncludes#img/logo.png" class="logo" alt="" /></a>
					<button type="button" class="navbar-toggle" data-click="sidebar-toggled">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>
				<!-- end mobile sidebar expand / collapse button -->
                <span  class="main-heading">Harbor Branch Oceanographic Institute</span>
				
				<!-- begin navbar-right -->
				<ul class="nav navbar-nav navbar-right">


					<li class="dropdown navbar-user">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
							<span class="image">
                        <cfif  DirectoryExists("#ExpandPath('.')#/assets/user_images/#SESSION["UserDetails"]["Id"]#") and  FileExists("#ExpandPath('.')#/assets/user_images/#SESSION["UserDetails"]["Id"]#/#SESSION["UserDetails"]["Id"]#.png")>
     						<img src="#Application.superadmin#assets/user_images/#SESSION["UserDetails"]["Id"]#/#SESSION["UserDetails"]["Id"]#.png" alt="" width="50" height="50"/>
				        <cfelse>
   							<img src="#Application.superadminTemplateIncludes#img/user_profile.jpg" alt="" />
				        </cfif>

                            <span class="hidden-xs" style="color:##fff"><cfif isdefined('Session.UserDetails')>#SESSION["UserDetails"]["firstName"]# #SESSION["UserDetails"]["lastName"]#</cfif></span> <b class="caret" style="color:##fff"></b>
						</a>
						<ul class="dropdown-menu pull-right">
							<li><a href="#Application.superadmin#?Module=Home&Page=Profile">Edit Profile</a></li>
							<li><a href="javascript:;">Setting</a></li>
							<li class="divider"></li>
							<li><a id="logout" onclick="javascript:window.location='#Application.superadmin#?Module=Home&page=logout';">Log Out</a></li>
						</ul>
					</li>
				</ul>
				<!-- end navbar-right -->
				
			</div>
			<!-- end container-fluid -->
		</div>
		<!-- end ##header -->
		<div class="modal" tabindex="-1" role="dialog" id="testMod" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
			  <div class="modal-content">
				<div class="modal-body">
					<div id="img" class="col-md-2">
						<img src="assets/dolphin.png" style="height:60px;">
					</div>
					<div id="info"> <h5>Are you still there? </h5> Your session will end in : <span id="timeOut"></span> seconds.</div>
					<button type="button" class="btn btn-sm btn-secondary" id="btn-info">Stay Logged In</button>
				</div>
			  </div>
			</div>
		</div>
</cfoutput>

<script>
 	var IdealTimeOut = 900; //900 seconds eq 15 mints
	var idleSecondsTimer = null;
	var idleSecondsCounter = 0;
	document.getElementById("btn-info").onclick = function () { 
		idleSecondsCounter = 0; 
		$("#testMod").modal('hide');
		if($('#cetacean').hasClass('in')){
			$('body').addClass("modal-open");
		}
	};
	idleSecondsTimer = window.setInterval(CheckIdleTime, 1000);

	document.addEventListener('mousemove', resetIdleTime, false);
	document.addEventListener('keypress', resetIdleTime, false);

function resetIdleTime ()
{
	if(idleSecondsCounter < 870 ){
		 idleSecondsCounter = 0;
	}
}
	function CheckIdleTime() {
		idleSecondsCounter++;
		// console.log(idleSecondsCounter);
		var oPanel = document.getElementById("timeOut");
		
		if (oPanel) {
			oPanel.innerHTML = (IdealTimeOut - idleSecondsCounter);
		}
		
		if (idleSecondsCounter >= IdealTimeOut) {
			window.clearInterval(idleSecondsTimer);
			$("#info").html("<h5 class='new-h5'>Your session has expired</h5>");
			$("#btn-info").text('Log Back In');
			$("#btn-info").removeAttr('data-dismiss');                
			$("#btn-info").attr('onclick', "redirect()");  
			const xhttp = new XMLHttpRequest();
			xhttp.open("GET", "templates/header.cfm?dest");
			xhttp.send();
		}
		// console.log(IdealTimeOut - idleSecondsCounter);
		if((IdealTimeOut - idleSecondsCounter) == '30'){
			$("#testMod").modal('show');
		}
	}

	function redirect(){
		window.location.href = "http://test.wildfins.org?destroy";
	}

</script>