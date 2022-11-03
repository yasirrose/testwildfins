<style>
.pie-legend li span {
    width: 1em;
    height: 1em;
    display: inline-block;
    margin-right: 5px;
}
.pie-legend {
    list-style: none;    
}
</style>
<cfset today = now()>
<cfset ReportStartyear = 1990>
<cfset ReportEndyear = year(now())>
<cfparam name="startHereIndex" default="1">
<cfparam name="startHereIndex2" default="1">
<cfset Application.record_per_page = 10>
<cfset total_best_place = [0,0,0,0,0,0,0,0]>
<cfparam name="HearYear" default="2012">
<!------- Stock list--------->
<cfset getStock = Application.Sighting.getStock()>
<!------- Survey Type list--------->
<cfset getType=Application.Sighting.getType()>
<!------- Sub Survey Type list--------->
<cfset getSubType=Application.Sighting.getSubType()>
<!---  Survey area --->
<cfset getSurveyArea=Application.Sighting.getSurveyArea()>
<!--- Indivisual Caputer Dolphins --->
<cfset qGetindivisualCaptureDolphins = Application.Reporting.indivisualCaptureDolphins(HearYear)>
<cfset qGetAgeSexHera = Application.Reporting.AgeSexHera(HearYear)>
<cfset total_best_place = Application.Reporting.HeraDolphinsBySegment(HearYear)>
<cfset qGetHeraCapturedMultipleTimes = Application.Reporting.HeraCapturedMultipleTimes(HearYear)>
<cfset qGetcaptureSameDayYear = Application.Reporting.captureSameDayYear(HearYear)>
<cfset qGetearlyReleasedDolphins = Application.Reporting.earlyReleasedDolphins(HearYear)>
<cfset qGetlateReleasedDolphins = Application.Reporting.lateReleasedDolphins(HearYear)>
<cfset Releases = ArrayNew(1)>
<cfset ArrayAppend(Releases, qGetearlyReleasedDolphins.RecordCount)>
<cfset ArrayAppend(Releases, qGetlateReleasedDolphins.RecordCount)>
<script>
<cfoutput>
var #toScript(total_best_place, "total_best_place")#; 
var #toScript(Releases, "Releases")#;
</cfoutput>
</script>
<!--- Download PDF --->
<cfif isDefined("FORM.Graph")>
<cfif FORM.Graph eq "Download_graph_pdf">
<cfdocument name="HReport" format="pdf">
<cfset plot = {"styles":[
{
"background-color":"##F7464A"
},
{
"background-color":"##FDB45C"
},
{
"background-color":"##46BFBD"
},
{
"background-color":"##A7DBDB"
},
{
"background-color":"##orange"
},
{
"background-color":"##75EB00"
}]}>
<cfset length = len(total_best_place)>
<cfset U_str = Right(total_best_place, --length)>
<cfset length = len(U_str)>
<cfset U_str = Left(U_str, --length)>
<cfchart yaxistitle="% over artemis" format="png" chartheight="700" chartwidth="700" scalefrom="0" scaleto="#length#" title="Dolphins By Segment"  plot="#plot#">
	<cfchartseries type="bar">
    	<cfchartdata item="1" value="#listGetAt(U_str, 1)#">
        <cfchartdata item="1A" value="#listGetAt(U_str, 2)#">
        <cfchartdata item="2" value="#listGetAt(U_str, 3)#">
        <cfchartdata item="2A" value="#listGetAt(U_str, 4)#">
        <cfchartdata item="3" value="#listGetAt(U_str, 5)#">
        <cfchartdata item="3A" value="#listGetAt(U_str, 6)#">
        <cfchartdata item="4" value="#listGetAt(U_str, 7)#">
        <cfchartdata item="4A" value="#listGetAt(U_str, 8)#">
    </cfchartseries>
</cfchart>
</cfdocument>
<cfpdf action="WRITE" source="HReport" destination="#Application.DirectoryRoot#PDF\HERA\HeraBySegment.pdf" overwrite="yes"/>
<cfhttp url="#Application.DirectoryRoot#PDF\HERA\HeraBySegment.pdf" method="get" getAsBinary="yes" file="HeraBySegment.pdf"/>
<cfheader name="Content-Disposition" value="attachment; filename=HeraBySegment.pdf" />
<cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\HERA\HeraBySegment.pdf" />
<cfelseif FORM.Graph eq "Download_graph_jpg">
<cfset length = len(total_best_place)>
<cfset U_str = Right(total_best_place, --length)>
<cfset length = len(U_str)>
<cfset U_str = Left(U_str, --length)>
<cfchart name="myGraph" format="jpg" scalefrom="0" scaleto="#length#" chartheight="700" chartwidth="700" title="Dolphins By Segment">
	<cfchartseries type="bar">
    	<cfchartdata item="1" value="#listGetAt(U_str, 1)#">
        <cfchartdata item="1A" value="#listGetAt(U_str, 2)#">
        <cfchartdata item="2" value="#listGetAt(U_str, 3)#">
        <cfchartdata item="2A" value="#listGetAt(U_str, 4)#">
        <cfchartdata item="3" value="#listGetAt(U_str, 5)#">
        <cfchartdata item="3A" value="#listGetAt(U_str, 6)#">
        <cfchartdata item="4" value="#listGetAt(U_str, 7)#">
        <cfchartdata item="4A" value="#listGetAt(U_str, 8)#">
    </cfchartseries>
</cfchart>
<cffile action="WRITE" file="#Application.DirectoryRoot#Graphs\HERA\HeraBySegment.jpg" output="#MyGraph#"> 
<cflocation url="/Graphs/HERA/HeraBySegment.jpg" addtoken="no">
</cfif>
</cfif>
	<cfoutput>
    <!-- begin ##content -->
	<div id="content" class="content">
		<!-- begin breadcrumb -->
		<ol class="breadcrumb pull-right">
			<li><a href="javascript:;">HERA</a></li>
			<li><a href="javascript:;">HERA Report</a></li>
		</ol>
		<!-- end breadcrumb -->
		<!-- begin page-header -->
		<h1 class="page-header">HERA Report</h1>
		<!-- end page-header -->

		<!-- begin row -->
		<div class="row">


           <!-- begin row col-6-->
		    <div class="row col-lg-12">
		        <!-- begin panel -->
		        <div class="panel panel-inverse">
		            <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
		                <h4 class="panel-title">Filters </h4>
		            </div>
		            <div class="panel-body">
                        <form action="" method="POST" onsubmit="return checkForm()">
                            <div class="row">
                              <div class="col-md-12">
                                <h5></h5>
                                <div class="col-md-3">
                                  <label>Start Year</label>
                                  <select class="form-control" name="HearYear" id="HearYear">
                                    <cfloop to='#ReportStartyear#' from="#ReportEndyear#" index="i" step='-1'>
                                      <option value="#i#" <cfif HearYear EQ i>selected</cfif> >#i#</option>
                                    </cfloop>
                                  </select>
                                </div>
                                <div class="col-md-3">
                                  <input type="submit" value="Submit" name="RollCall" class="btn btn-primary m-t-25" />
                                </div>
                              </div>
                            </div>  
                		</form>
                        <div class="col-md-4" style="margin-bottom:10px;margin-top:-4%; margin-left:34%;">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Indivisual Dolphins </div>
                                <div class="widget-stat-number">#qGetindivisualCaptureDolphins.RecordCount#</div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                    	<div class="col-md-4" style="margin-bottom:10px;margin-top:-13.5%; margin-left:67%;">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Total Capture Dolphins</div>
                                <div class="widget-stat-number">#qGetAgeSexHera.RecordCount#</div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                    <!-- Start col-md-6--->
                    <div class="col-md-4" style="margin-bottom:-6px;margin-top:-1.5%; margin-left:67%;">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Multiple Time Captured</div>
                                <div class="widget-stat-number">#qGetHeraCapturedMultipleTimes.RecordCount#</div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                    <!-- End col-md-6--->
                    
                    <!-- Start col-md-6--->
                    <div class="col-md-4" style="margin-bottom:-6px;margin-top:-11.7%; margin-left:34%;">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Same Day/Year Capture</div>
                                <div class="widget-stat-number">#qGetcaptureSameDayYear.RecordCount#</div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                    <!-- End col-md-6--->
                    <!-- Start col-md-6--->
                    <div class="col-md-4" style="margin-top:-12.6%; margin-left:1.0%;">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Early Released Dolphins</div>
                                <div class="widget-stat-number">#qGetearlyReleasedDolphins.RecordCount#</div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                    <!-- End col-md-6--->
                    <!--  start col-md-6 --->
                    <div class="col-lg-6"><br><br>
		        <!-- begin panel -->
                       <div class="panel panel-inverse">
                            <div class="panel-heading">
                                <div class="panel-heading-btn">
                                	<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Graph" value="Download_graph_jpg">
                                        <input type="hidden" name="HearYear" value="#HearYear#" />
                                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                                    </form>
                                    <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Graph" value="Download_graph_pdf">
                                        <input type="hidden" name="HearYear" value="#HearYear#" />
                                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                                    </form>
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                                </div>
                                <h4 class="panel-title">Dolphins By Segment</h4>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <canvas id="bar-chart_segment"></canvas>
                                </div>
        
                         </div>
                        </div>
		        <!-- end panel -->
		  	  		</div>
                    <!-- bar-chart End --->
                    <!-- begin col-6--->
                        <div class="col-lg-6 m-t-30">        
                       <div class="panel panel-inverse">
                      <div class="panel-heading">
                        <div class="panel-heading-btn"> 
                        
                        <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
               			 	<input type="hidden" name="Chart1" value="Download_chart_jpg">
                			<button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                		</form>
                		<form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                			<input type="hidden" name="Chart1" value="Download_chart_pdf">
                			<button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                		</form>
                        
                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                        <h4 class="panel-title">Early VS Late Release Dolphins</h4>
                      </div>
                          <canvas id="pie-chart" style="margin-top:2%;"></canvas><br />
                		 <div id="legend"></div>              
                        </div>
                      </div>
                     <!-- End col-6 -->
                 </div>
		      </div>
		        <!-- end panel -->
                	<!-- Times Dolphin Captured --->
                    	<div class="col-md-12"> <br>
            <br>
            <div class="panel pagination-inverse m-b-0 clearfix">
              <label><b>Dolphins Multiple Seen Time</b></label>
              <table data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                <thead>
                  <tr class="inverse">
                    <th>Name</th>
                    <th>Code</th>
                    <th>Sex</th>
                    <th>Times</th>
                  </tr>
                </thead>
                <tbody>
                	</cfoutput>
                	<cfoutput query="qGetHeraCapturedMultipleTimes" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                    <cfquery name="SeenTimes" dbtype="query">
                    	Select * from qGetAgeSexHera Where qGetAgeSexHera.ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#qGetHeraCapturedMultipleTimes.ID#">
                    </cfquery>
                   <tr class="gradeU">
                        <td id="group_name"><a href="##collapse#qGetAgeSexHera.currentrow#" data-toggle="collapse" class="dataToggle" id="#qGetAgeSexHera.currentrow#">#SeenTimes.NAME#</a></td>
                        <td id="group_name">#SeenTimes.CODE#</td>
                        <td id="group_status">#SeenTimes.SEX#</td>
                        <td id="group_times">#SeenTimes.RecordCount#</td>
                      </tr>
                    </cfoutput>
                    <cfoutput>
                </tbody>
              </table>
              <form action="" method="post" name="paginationform2">
                <input type="hidden" name="startHereIndex" value="1" />
              </form>
              <cfif isdefined('qGetHeraCapturedMultipleTimes') AND isdefined('qGetHeraCapturedMultipleTimes.recordcount') AND qGetHeraCapturedMultipleTimes.recordcount NEQ 0 >
                <cfset qpagination = qGetHeraCapturedMultipleTimes >
                <cfinclude template="../pagination.cfm">
              </cfif>
            </div>
          </div>
                	<!-- END Times Caputer--->
                	<!-- Detail Sex and Age --->
            <div class="col-md-12"> <br>
            <br>
            <div class="panel pagination-inverse m-b-0 clearfix">
              <label><b>All Captured Dolphins Age And Sex</b></label>
              <table data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                <thead>
                  <tr class="inverse">
                    <th>Name</th>
                    <th>Code</th>
                    <th>Sex</th>
                    <th>Age</th>
                  </tr>
                </thead>
                <tbody>
                	</cfoutput>
                	<cfoutput query="qGetAgeSexHera" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                   <tr class="gradeU">
                        <td id="group_name"><a href="##collapse#qGetAgeSexHera.currentrow#" data-toggle="collapse" class="dataToggle" id="#qGetAgeSexHera.currentrow#">#qGetAgeSexHera.NAME#</a></td>
                        <td id="group_name">#qGetAgeSexHera.CODE#</td>
                        <td id="group_status">#qGetAgeSexHera.SEX#</td>
                        <cfif qGetAgeSexHera.DOD neq "" AND qGetAgeSexHera.YearOfBirth neq "" AND qGetAgeSexHera.DOD neq "exception" and qGetAgeSexHera.YearOfBirth neq "exception">
                        <cfset dateOfDeath = Application.Common.FormatDate(qGetAgeSexHera.DOD)>
                        <cfset YearofDeath = DatePart("yyyy",dateOfDeath)>
                        <td id="group_status">#(val(YearofDeath)-val(qGetAgeSexHera.YearOfBirth))#</td>
                        <cfelse>
                        <td id="group_status">N/A</td>
                        </cfif>
                      </tr>
                    </cfoutput>
                    <cfoutput>
                </tbody>
              </table>
              <form action="" method="post" name="paginationform">
                <input type="hidden" name="startHereIndex" value="1" />
              </form>
              <cfif isdefined('qGetAgeSexHera') AND isdefined('qGetAgeSexHera.recordcount') AND qGetAgeSexHera.recordcount NEQ 0 >
                <cfset qpagination = qGetAgeSexHera >
                <cfinclude template="../pagination.cfm">
              </cfif>
            </div>
          </div>
          			<!-- End --->
                
		   </div>
         </div>
        <!-- end row -->

        <!-- begin ##footer -->
        <div id="footer" class="footer">
            <span class="pull-right">
                <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top">
                    <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
                </a>
            </span>
            &copy; 2016 <b>WildFins Admin</b> All Right Reserved
        </div>
        <!-- end ##footer -->
	</div>
    <!-- end ##content -->
    
    
 	<div class="modal fade" id="earlyReleasesDiv">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Early Releases Dolphins</h4>
      </div>
      <div class="modal-body">
        <table  class="table table-striped table-bordered" >
                <tr>
                <td width="80"><b>ID</b></td>
                <td width="100"><b>Code</b></td>
                <td width="120"><b>Sighting ID</b></td>
                <td width="250"><b>Name</b></td>
                <td width="50"><b>Sex</b></td>
            </tr>
         </table>
         <div class="datacontainer"> 
         <table class="table table-striped table-bordered">  
            <cfif ArrayLen(aREM) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(aREM)#" index="i">
            <cfoutput>
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#aREM[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#aREM[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#aREM[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#aREM[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#aREM[i].name#</td>
                   <td width="50">#aREM[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>
</cfoutput>