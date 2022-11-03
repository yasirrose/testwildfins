<cfoutput>
<cfparam name="zone_progress" default="0">
<cfparam name="segment_progress" default="0">
<cfparam name="dolphin_progress" default="0">
<cfparam name="calf_progress" default="0">
<cfparam name="MMHRSP_progress" default="0">
<cfparam name="NCSG_progress" default="0">
<cfset today = now()> 

<cfset ZoneSurveyed = Application.SuperAdminApp.ZoneSurveyed()>
<cfset SegmentSurveyed = Application.SuperAdminApp.SegmentSurveyed()>
<cfset DolphinsSighted = Application.SuperAdminApp.DolphinsSighted()>
<cfset TotalNamedDolphins = Application.SuperAdminApp.TotalNamedDolphins()>
<cfset TotalCalfs = Application.SuperAdminApp.Totalcalfs()>
<cfset thismonthCalfs = Application.SuperAdminApp.thismonthcalfs()>
<cfset lastmonthcalfs = Application.SuperAdminApp.lastmonthcalfs()>

<cfset thismonthMMHRSP = Application.SuperAdminApp.thismonthMMHRSP()>
<cfset lastmonthMMHRSP = Application.SuperAdminApp.lastmonthMMHRSP()>

<cfset thismonthNCSG = Application.SuperAdminApp.thismonthNCSG()>
<cfset lastmonthNCSG = Application.SuperAdminApp.lastmonthNCSG()>

<cfset thismonthBiopsy = Application.SuperAdminApp.thismonthBiopsy()>
<cfset lastmonthBiopsy = Application.SuperAdminApp.lastmonthBiopsy()>

<cfset thismonthHERA = Application.SuperAdminApp.thismonthHERA()>
<cfset lastmonthHERA = Application.SuperAdminApp.lastmonthHERA()>

<cfset remainingZones = ListLast(ZoneSurveyed) - ListFirst(ZoneSurveyed) >
<cfset remainingSegmentSurveyed = ListLast(SegmentSurveyed) - ListFirst(SegmentSurveyed) >

<cfif ListLast(ZoneSurveyed) neq 0 >
	<cfset zone_progress = (ListFirst(ZoneSurveyed)/ListLast(ZoneSurveyed))*100&'%'>
</cfif>

<cfif ListLast(SegmentSurveyed) neq 0 >
	<cfset segment_progress = (ListFirst(SegmentSurveyed)/ListLast(SegmentSurveyed))*100&'%'>
</cfif>

<cfif ListLast(DolphinsSighted) neq 0 >
	<cfset dolphin_progress = (ListFirst(DolphinsSighted)/ListLast(DolphinsSighted))*100&'%'>
</cfif>

<cfparam name="calf_progress" default="0">
<cfparam name="MMHRSP_progress" default="0">
<cfparam name="NCSG_progress" default="0">
<cfparam name="Biopsy_progress" default="0">
<cfparam name="HERA_progress" default="0">

<cfif lastmonthcalfs neq 0 >
	<cfset calf_progress = (thismonthCalfs/lastmonthcalfs)*100&'%'>
</cfif>
<cfif lastmonthMMHRSP neq 0 >
	<cfset MMHRSP_progress = (thismonthMMHRSP/lastmonthMMHRSP)*100&'%'>
</cfif>
<cfif lastmonthNCSG neq 0 >
	<cfset NCSG_progress = (thismonthNCSG/lastmonthNCSG)*100&'%'>
</cfif>
<cfif lastmonthBiopsy neq 0 >
	<cfset Biopsy_progress = (thismonthBiopsy/lastmonthBiopsy)*100&'%'>
</cfif>
<cfif lastmonthHERA neq 0 >
	<cfset HERA_progress = (thismonthHERA/lastmonthHERA)*100&'%'>
</cfif>

<!-- begin ##content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">Dashboard</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Dashboard </h1>
			<!-- end page-header -->

			<!-- begin row -->
			<div class="row">
                <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-info text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"></a></div>
                        <div class="widget-stat-icon">
                        	<img src="#Application.superadminTemplateIncludes#img/dashboard-icons/zone.png" height="60" width="60">
                        	
                        
                        </div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Zone Surveyed</div>
                            <div class="widget-stat-number">#ListFirst(ZoneSurveyed)#/#ListLast(ZoneSurveyed)#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: #zone_progress#"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer text-left">Remaining This Month #remainingZones#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
               
             
                
                
                  <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-success text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"></a></div>
                        <div class="widget-stat-icon">
                        <img src="#Application.superadminTemplateIncludes#img/dashboard-icons/biopsy.png" height="60" width="60">
                        </div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">This Month Biopsy</div>
                            <div class="widget-stat-number">#thismonthBiopsy#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: #Biopsy_progress#" ></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Last Month #lastmonthBiopsy#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
                
                
                
                  <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-info text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"></a></div>
                        <div class="widget-stat-icon"><i class="fa fa-bar-chart"></i></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">This Month HERA</div>
                            <div class="widget-stat-number">#thismonthHERA#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: #Biopsy_progress#"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Last Month #lastmonthHERA#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
                
                
                  <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-danger text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"></a></div>
                        <div class="widget-stat-icon"><i class="fa fa-area-chart"></i></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">This Month MMHSRP</div>
                            <div class="widget-stat-number">#thismonthMMHRSP#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: #calf_progress#"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Last Month #lastmonthMMHRSP#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
                
                
                                  <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-info text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"></a></div>
                        <div class="widget-stat-icon"><i class="fa fa-bookmark"></i></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">This Month NCSG</div>
                            <div class="widget-stat-number">#thismonthNCSG#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Last Month #lastmonthNCSG#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
                
                
                
                
                
                <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-primary text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"></a></div>
                        <div class="widget-stat-icon">
                        
                       <img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60">
                        
                        </div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Dolphins Sighted</div>
                            <div class="widget-stat-number">#ListFirst(DolphinsSighted)#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: #dolphin_progress#"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Last Month #ListLast(DolphinsSighted)#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
                <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-info text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"></a></div>
                        <div class="widget-stat-icon">
                        
                       <img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin.png" height="60" width="60">
                        
                        </div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Total Named Dolphins</div>
                            <div class="widget-stat-number">#ListFirst(TotalNamedDolphins)#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: 70%"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Total unnamed #ListLast(TotalNamedDolphins)#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
                 <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-warning text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"></a></div>
                        <div class="widget-stat-icon">
                        
                        <img src="#Application.superadminTemplateIncludes#img/dashboard-icons/calf.png" height="60" width="60">
                        
                        </div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">This Month Calfs</div>
                            <div class="widget-stat-number">#thismonthCalfs#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: #calf_progress#"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Last Month #lastmonthcalfs#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
            </div>
            <!-- end row -->

			<!-- begin row -->
			<div class="row">
			    <!-- begin col-6 -->
			    <div class="col-lg-6">
			        <!-- begin panel -->
			        <div class="panel panel-inverse">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
			                <h4 class="panel-title">Dolphins sighted </h4>
			            </div>
			            <div class="panel-body">
                      

                            <div class="panel-option">
<!--------#DateFormat(CreateDate(year(today),1, 1), "mmmm d, yyyy")#----------->
                                <div id="default-daterange" class="input-group">
                                    <input type="text"  value="" class="form-control" name="default-daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
			                <div>
			                    <canvas id="chart-visitor-analytics" data-height="228px" class="width-full"></canvas>
                                <div id="visitor-analytics-tooltip" class="chartjs-tooltip"></div>
			                </div>
			            </div>
			        </div>
			        <!-- end panel -->
			    </div>
			    <!-- end col-6 -->
			    <!-- begin col-6 -->
			    <div class="col-lg-6">
			        <!-- begin panel -->
			        <div class="panel panel-inverse">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
			                <h4 class="panel-title">Birth Rate </h4>
			            </div>
			            <div class="panel-body">
                            <div class="panel-option">
                                <div id="birth-rate" class="input-group">
                                    <input type="text"  value="" class="form-control" name="default-daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
			                <div>
			                    <canvas id="chart-visitor-analytics1" data-height="228px" class="width-full"></canvas>
                                <div id="visitor-analytics-tooltip1" class="chartjs-tooltip"></div>
			                </div>
			            </div>
			        </div>
			        <!-- end panel -->
			    </div>
                <!-- end col-6 -->
				
				
             
			</div>
			<!-- end row -->
            
            
            <!-- begin row -->
			<div class="row">
			    <!-- begin col-6 -->
			    <div class="col-lg-6">
			        <!-- begin panel -->
			        <div class="panel panel-inverse">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
			                <h4 class="panel-title">Best Places to live </h4>
			            </div>
			            <div class="panel-body">
                            <div class="panel-option">
                               <div id="best-place" class="input-group">
                                    <input type="text"  value="" class="form-control" name="default-daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
			                <div>
			                    <canvas id="bar-chart" data-height="228px" class="width-full"></canvas>
			                </div>
			            </div>
			        </div>
			        <!-- end panel -->
			    </div>
			    <!-- end col-6 -->
			    <!-- begin col-6 -->
			    <div class="col-lg-6">
			        <!-- begin panel -->
			        <div class="panel panel-inverse">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
			                <h4 class="panel-title">Death Rate </h4>
			            </div>
			            <div class="panel-body">
                            <div class="panel-option">
                            <div id="death-rate" class="input-group">
                                    <input type="text"  value="" class="form-control" name="default-daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
			                <div>
			                    <canvas id="chart-visitor-analytics4" data-height="228px" class="width-full"></canvas>
                                <div id="visitor-analytics-tooltip4" class="chartjs-tooltip"></div>
			                </div>
			            </div>
			        </div>
			        <!-- end panel -->
			    </div>
                <!-- end col-6 -->
				
				
             
			</div>
			<!-- end row -->



            <!-- begin ##footer -->
            <div id="footer" class="footer">
                <span class="pull-right">
                    <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top">
                        <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
                    </a>
                </span>
                &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
            </div>
            <!-- end ##footer -->
		</div>
		<!-- end ##content -->
</cfoutput>
