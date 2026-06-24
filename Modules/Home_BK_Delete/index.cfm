<cfoutput>
<cfset ZoneSurveyed = Application.SuperAdminApp.ZoneSurveyed()>
<cfset SegmentSurveyed = Application.SuperAdminApp.SegmentSurveyed()>
<cfset DolphinsSighted = Application.SuperAdminApp.DolphinsSighted()><!---
<cfset TotalNamedDolphins = Application.SuperAdminApp.TotalNamedDolphins()>--->
<cfset remainingZones = ListLast(ZoneSurveyed) - ListFirst(ZoneSurveyed) >
<cfset remainingSegmentSurveyed = ListLast(SegmentSurveyed) - ListFirst(SegmentSurveyed) >


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
                    <div class="widget widget-stat widget-stat-right bg-inverse text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"><i class="fa fa-repeat"></i></a></div>
                        <div class="widget-stat-icon"><i class="fa fa-chrome"></i></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Zone Surveyed</div>
                            <div class="widget-stat-number">#ListFirst(ZoneSurveyed)#/#ListLast(ZoneSurveyed)#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: 80%"></div>
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
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"><i class="fa fa-repeat"></i></a></div>
                        <div class="widget-stat-icon"><i class="fa fa-diamond"></i></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Segment Surveyed</div>
                            <div class="widget-stat-number">#ListFirst(SegmentSurveyed)#/#ListLast(SegmentSurveyed)#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: 60%"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Remaining This Month #remainingSegmentSurveyed#</div>
                    </div>
                    <!-- end widget -->
                </div>
                <!-- end col-3 -->
                <!-- begin col-3 -->
                <div class="col-sm-6 col-lg-3">
                    <!-- begin widget -->
                    <div class="widget widget-stat widget-stat-right bg-primary text-white">
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"><i class="fa fa-repeat"></i></a></div>
                        <div class="widget-stat-icon"><i class="fa fa-hdd-o"></i></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Dolphins Sighted</div>
                            <div class="widget-stat-number">#ListFirst(DolphinsSighted)#</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: 70%"></div>
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
                        <div class="widget-stat-btn"><a href="javascript:;" data-click="widget-reload"><i class="fa fa-repeat"></i></a></div>
                        <div class="widget-stat-icon"><i class="fa fa-file"></i></div>
                        <div class="widget-stat-info">
                            <div class="widget-stat-title">Total Named Dolphins</div>
                            <div class="widget-stat-number">209</div>
                        </div>
                        <div class="widget-stat-progress">
                            <div class="progress">
                                <div class="progress-bar" style="width: 70%"></div>
                            </div>
                        </div>
                        <div class="widget-stat-footer">Total unmaed 6</div>
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
			                <h4 class="panel-title">Population sighted </h4>
			            </div>
			            <div class="panel-body">
                            <div class="panel-option">
                                <div class="dropdown pull-right">
                                    <a href="javascript:;" class="btn btn-white btn-rounded btn-sm" data-toggle="dropdown">Change Date <b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="javascript:;">Last Week</a></li>
                                        <li><a href="javascript:;">Last Month</a></li>
                                        <li><a href="javascript:;">Last Year</a></li>
                                    </ul>
                                </div>
                                <div class="text-ellipsis">Date: 1 November 2015 - 30 November 2015</div>
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
			    <div class="col-lg-6 hide">
			        <!-- begin panel -->
			        <div class="panel panel-inverse">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
			                <h4 class="panel-title">Browser Analytics <small>monthly stat</small></h4>
			            </div>
			            <div class="panel-body p-b-0">
			                <!-- begin row -->
                            <div class="row">
                                <!-- begin col-6 -->
                                <div class="col-sm-6 m-b-20">
                                    <div class="chart-summary-container">
                                        <div class="chart-title text-purple">Google Chrome</div>
                                        <div class="chart-doughnut">
                                            <canvas id="doughnut-chrome"></canvas>
                                            <div id="doughnut-chrome-tooltip" class="chartjs-tooltip"></div>
                                        </div>
                                        <div class="chart-info">
                                            <div class="chart-summary">
                                                <div class="text">Total Visits</div>
                                                <div class="number">192,102 <small>(65.5%)</small></div>
                                            </div>
                                            <div class="chart-summary">
                                                <div class="text">Unique Visitors</div>
                                                <div class="number">52,102</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- end col-6 -->
                                <!-- begin col-6 -->
                                <div class="col-sm-6 m-b-20">
                                    <div class="chart-summary-container">
                                        <div class="chart-title text-primary">Internet Explorer</div>
                                        <div class="chart-doughnut">
                                            <canvas id="doughnut3"></canvas>
                                            <div id="doughnut-ie-tooltip" class="chartjs-tooltip"></div>
                                        </div>
                                        <div class="chart-info">
                                            <div class="chart-summary">
                                                <div class="text">Total Visits</div>
                                                <div class="number">2,102 <small>(2.2%)</small></div>
                                            </div>
                                            <div class="chart-summary">
                                                <div class="text">Unique Visitors</div>
                                                <div class="number">602</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end row -->
                            <!-- begin row -->
                            <div class="row">
                                <!-- begin col-6 -->
                                <div class="col-sm-6 m-b-20">
                                    <div class="chart-summary-container">
                                        <div class="chart-title text-warning">Mozilla Firefox</div>
                                        <div class="chart-doughnut">
                                            <canvas id="doughnut4"></canvas>
                                            <div id="doughnut-firefox-tooltip" class="chartjs-tooltip"></div>
                                        </div>
                                        <div class="chart-info">
                                            <div class="chart-summary">
                                                <div class="text">Total Visits</div>
                                                <div class="number">62,102 <small>(20.2%)</small></div>
                                            </div>
                                            <div class="chart-summary">
                                                <div class="text">Unique Visitors</div>
                                                <div class="number">8,402</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- end col-6 -->
                                <!-- begin col-6 -->
                                <div class="col-sm-6 m-b-20">
                                    <div class="chart-summary-container">
                                        <div class="chart-title text-success">Safari</div>
                                        <div class="chart-doughnut">
                                            <canvas id="doughnut5"></canvas>
                                            <div id="doughnut-safari-tooltip" class="chartjs-tooltip"></div>
                                        </div>
                                        <div class="chart-info">
                                            <div class="chart-summary">
                                                <div class="text">Total Visits</div>
                                                <div class="number">22,102 <small>(4.5%)</small></div>
                                            </div>
                                            <div class="chart-summary">
                                                <div class="text">Unique Visitors</div>
                                                <div class="number">5,291</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- end col-6 -->
                            </div>
			                <!-- end row -->
			            </div>
			        </div>
			        <!-- end panel -->
                </div>
                <!-- end col-6 -->
			</div>
			<!-- end row -->

			<!-- begin row -->
			<div class="row">
			    <!-- begin col-4 -->
			    <div class="col-lg-4">
			        <!-- begin panel -->
			        
			        <!-- end panel -->
			    </div>
			    <!-- end col-4 -->
			    <!-- begin col-4 -->
			    
			    <!-- end col-4 -->
			    <!-- begin col-4 -->
			    
			    <!-- end col-4 -->
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
