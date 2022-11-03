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
.datacontainer{
    height: 350px; 
    overflow:scroll; 
}

.sighting-detail {
     cursor:pointer;
     color:blue;
     text-decoration:underline;
}

.sighting-detail:hover {
     text-decoration:none;
     text-shadow: 1px 1px 1px #555;
}
canvas#pie-chart {
    height: 200px;
}
.inline-text {
    text-align: left;
    display: inline-block;
    margin: 12px 0 0;
}
canvas#bar-chart-by-zones, canvas#bar-chart, canvas#bar-chart-by-segments {
    width: 100% !important;
}
.content table th{
	cursor:pointer;
	}
.row.center-row {
    position: absolute;
    top: 50px;
    bottom: 0;
    margin: auto;
    left: 0;
    right: 0;
    display: table;
    width: 50%;
}
.space-bottom {
    margin-bottom: 40px;
}
.color-scheme li {
    display: inline-block;
    vertical-align: middle;
    margin: 0 10px 0 0;
}
.color-scheme-box label {
    font-size: 14px;
    display: inline-block;
    vertical-align: top;
}
.color-scheme-box span.color {
    float: left;
    width: 45px;
    height: 15px;
    border: 2px solid ##ddd;
    margin: 2px 8px 0 0;
}
.color-scheme {
    text-align: center;
    margin: 0 0 8px 0;
}
.color-scheme ul {
    display: inline-block;
    padding: 0;
    margin: 0;
    list-style: none;
}
@media (max-width:767px) {
.row.center-row {
    position: static;
    display: inline-block;
    width: 100%;
}
.space-bottom {
    margin-bottom: 10px;
}
}
</style>

<cfparam name="startHereIndex1" default="1">
<cfparam name="startHereIndex2" default="1">
<cfparam name="startHereIndex3" default="1">
<cfparam name="startHereIndex4" default="1">
<cfset Application.record_per_page = 10>
<cfset ReportStartyear = 1998>
<cfset ReportEndyear = year(now())>
<cfset from = ReportEndyear>
<cfparam name="FORM.fromYear" default="#from#">

<cfset qgetAnnualCensusPieChart  		     = Application.Reporting.getAnnualCensusReportGraphPopulationViability(argumentCollection="#Form#")>
<cfset qgetAnnualSightingBarChart  		     = Application.Reporting.getAnnualSightingreportFromStart(argumentCollection="#Form#")>


<cfset all_Male            = 0>
<cfset all_Female          = 0>
<cfset all_Unknown         = 0>
<cfset calves_sex_Male     = 0>
<cfset calves_sex_Female   = 0>
<cfset calves_sex_Unknown  = 0>
<cfset juvenile_sex_Male   = 0>
<cfset juvenile_sex_Female = 0>
<cfset juvenile_sex_Unknown= 0>
<cfset adult_sex_Male      = 0>
<cfset adult_sex_Female    = 0>
<cfset adult_sex_Unknown   = 0>
<cfset unknown_sex_Male    = 0>
<cfset unknown_sex_Female  = 0>
<cfset unknown_sex_Unknown = 0>
<cfset Calf                = 0>
<cfset Juvenile_male       = 0>
<cfset Juvenile_female     = 0>
<cfset Adult_male          = 0>
<cfset Adult_female        = 0>
<cfset Unknown_sex         = 0>
<cfset ArrJuvenile_male    = ArrayNew(1)>
<cfset ArrJuvenile_female  = ArrayNew(1)>
<cfset ArrAdult_male       = ArrayNew(1)>
<cfset ArrAdult_female     = ArrayNew(1)>
<cfset ArrUnknown_sex      = ArrayNew(1)>
<cfset sightingYear        = ArrayNew(1)>
<cfset dolphinsSeen        = ArrayNew(1)>
<cfset CalfData            = ArrayNew(1)>
<cfset JuvenalData         = ArrayNew(1)>
<cfset AdultData           = ArrayNew(1)>
<cfset UnknownData         = ArrayNew(1)>
<cfloop query="qgetAnnualCensusPieChart">
           
           <cfif YEAROFBIRTH NEQ '' AND IsNumeric(YEAROFBIRTH)>
              <cfif IsDead	EQ 0 OR DeathYear EQ ''>
                  <cfset age = #FORM.fromYear# - YEAROFBIRTH >
              <cfelse>
                  <cfif IsNumeric(DeathYear)>
                    <cfset age = DeathYear - YEAROFBIRTH >
                  <cfelse>
                    <cfset age = '' >
                  </cfif>
              </cfif>
           <cfelse>
              <cfset age = '' >
           </cfif>
           <cfif age NEQ ''>
                <cfif age LTE 4>
                    <cfset Calf++>
                    <cfif SEX NEQ ''>
						<cfif SEX EQ 'M'>
                            <cfset calves_sex_Male++>
                        <cfelseif SEX EQ 'F'>
                            <cfset calves_sex_Female++>
                        <cfelseif SEX EQ 'U'>
                            <cfset calves_sex_Unknown++>   
                        </cfif>
                   </cfif>
                <cfelseif age GT 4 and age LT 10>
                	<cfif SEX NEQ ''>
						<cfif age GTE 5 AND age LTE 9 AND SEX EQ 'M'>
                            <cfset juvenile_sex_Male++>
                        <cfelseif age GTE 5 AND age LTE 6 AND SEX EQ 'F'>
                            <cfset juvenile_sex_Female++>
                        <cfelseif SEX EQ 'U'>
                            <cfset juvenile_sex_Unknown++>   
                        </cfif>
                   </cfif>
                </cfif>
                
				<cfif age GTE 10 and SEX EQ 'M'>
                	<cfset adult_sex_Male++>
                </cfif>
                <cfif age GTE 7 and SEX EQ 'F'>
                	<cfset adult_sex_Female++>
                </cfif>
                <cfif age GTE 10 and SEX EQ 'U'>
                	<cfset adult_sex_Unknown++>
                </cfif>    
                <!---<cfif age GTE 5 and age LTE 9>
                    <cfset Juvenile_male++>
                </cfif>
                <cfif age GTE 5 and age LTE 6>
                    <cfset Juvenile_female++>
                </cfif>    
                <cfif age GT 10>
                    <cfset Adult_male++>
                </cfif>
                <cfif age GT 7>
                    <cfset Adult_female++>
                </cfif>
                <cfif age GTE 10>
                    <cfset Unknown_sex++>
                </cfif>--->
           <cfelse>
           		<cfif SEX NEQ ''>
					<cfif SEX EQ 'M'>
                        <cfset unknown_sex_Male++>
                    <cfelseif SEX EQ 'F'>
                        <cfset unknown_sex_Female++>
                    <cfelseif SEX EQ 'U'>
                        <cfset unknown_sex_Unknown++>
                    </cfif>
           		</cfif>
           </cfif>
           
		   <cfif SEX NEQ ''>
           		<cfif SEX EQ 'M'>
                	<cfset all_Male++>
           		<cfelseif SEX EQ 'F'>
                	<cfset all_Female++>
                <cfelseif SEX EQ 'U'>
                	<cfset all_Unknown++>
                </cfif>
           </cfif>
                 
        </cfloop>
<cfset all_sex_categories = [all_Male,all_Female,all_Unknown] >
<cfset calves_sex_categories = [calves_sex_Male,calves_sex_Female,calves_sex_Unknown] >
<cfset juvenile_sex_categories = [juvenile_sex_Male,juvenile_sex_Female,juvenile_sex_Unknown] >
<cfset adult_sex_categories = [adult_sex_Male,adult_sex_Female,adult_sex_Unknown] >
<cfset unknown_sex_categories = [unknown_sex_Male,unknown_sex_Female,unknown_sex_Unknown] >
<cfloop query="qgetAnnualSightingBarChart">
	<cfset arrayappend(sightingYear,SIGHTING_YEAR)>
	<cfset arrayappend(CalfData,CALF)>
    <cfset arrayappend(JuvenalData,JUVENAL)>
    <cfset arrayappend(AdultData,ADULT)>
    <cfset arrayappend(UnknownData,UNKNOWN)>
</cfloop>
<script>
    <cfoutput>
		var #toScript(all_sex_categories, "all_sex_categories")#;
		var #toScript(calves_sex_categories, "calves_sex_categories")#;
		var #toScript(juvenile_sex_categories, "juvenile_sex_categories")#;
		var #toScript(adult_sex_categories, "adult_sex_categories")#;
		var #toScript(unknown_sex_categories, "unknown_sex_categories")#;
		var #toScript(sightingYear, "sightingYear")#;
		var #toScript(CalfData, "CalfData")#;
		var #toScript(JuvenalData, "JuvenalData")#;
		var #toScript(AdultData, "AdultData")#;
		var #toScript(UnknownData, "UnknownData")#;
    </cfoutput>
</script>
<CFIF isdefined('FORM.Graph')> 
	<cfif FORM.Graph EQ "Download_graph_pdf">
    
        <cfdocument name="hreport" format="PDF">
			<cfset plot = {"styles":[
            {
            "background-color":"##008000"
            },
            {
            "background-color":"##FFA500"
            },
            {
            "background-color":"##FF0000"
            },
            {
            "background-color":"##FFFF00"
            },
            {
            "background-color":"##69D2E7"
            },
            {
            "background-color":"##A7DBDB"
            },
            {
            "background-color":"##28ABE3"
            },
            {
            "background-color":"##1FDA9A"
            },
            {
            "background-color":"##FF4C65"
            },
            {
            "background-color":"##6E9ECF"
            },
            {
            "background-color":"##75EB00"
            },
            {
            "background-color":"##9B539C"
            }]}>
            <cfchart yaxistitle="% over artemis" format="png" chartwidth="700" chartheight="700" scalefrom="0" scaleto="900" plot="#plot#"> 
                <cfchartseries type="bar" >
                    <cfloop query="qgetAnnualSightingBarChart">
                        <cfchartdata item="#SIGHTING_YEAR#" value="#SEEN_TIMES#">
                    </cfloop>
                </cfchartseries>
            </cfchart>
        </cfdocument>
        <cfpdf action="write"
           source="hreport"
           destination="#Application.DirectoryRoot#PDF\PopulationViability\SightingPerYear.pdf" overwrite="yes"/>
        <cfhttp url="#Application.DirectoryRoot#PDF\PopulationViability\SightingPerYear.pdf" 
                method="get" 
                getAsBinary="yes"
                file="BodyOfWaterSummary.pdf"/>
        
        <cfheader name="Content-Disposition" value="attachment; filename=SightingPerYear.pdf" />
        <cfcontent type="application/pdf" file="#Application.DirectoryRoot#PDF\PopulationViability\SightingPerYear.pdf" />
	<cfelseif FORM.Graph EQ "Download_graph_jpg">
		<cfset plot = {"styles":[
        {
        "background-color":"##008000"
        },
        {
        "background-color":"##FFA500"
        },
        {
        "background-color":"##FF0000"
        },
        {
        "background-color":"##FFFF00"
        },
        {
        "background-color":"##69D2E7"
        },
        {
        "background-color":"##A7DBDB"
        },
        {
        "background-color":"##28ABE3"
        },
        {
        "background-color":"##1FDA9A"
        },
        {
        "background-color":"##FF4C65"
        },
        {
        "background-color":"##6E9ECF"
        },
        {
        "background-color":"##75EB00"
        },
        {
        "background-color":"##9B539C"
        }]}>
        <cfchart name="MyGraph" format="jpg" scalefrom="0" scaleto="900" chartwidth="700" chartheight="700" plot="#plot#" showBorder="yes">
            <cfchartseries type="bar">
                <cfloop query="qgetAnnualSightingBarChart">
                    <cfchartdata item="#SIGHTING_YEAR#" value="#SEEN_TIMES#">
                </cfloop>
            </cfchartseries>
        </cfchart>
        <cffile  
            action="WRITE"  
            file="#Application.DirectoryRoot#Graphs\PopulationViability\SightingPerYear.jpg"  
            output="#MyGraph#"> 
        <cflocation url="/Graphs/PopulationViability/SightingPerYear.jpg" addtoken="no">
    </cfif>
</CFIF>
<!-- begin ##content -->
<div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
    <li><a href="javascript:;">Reporting</a></li>
    <li><a href="javascript:;">Population Viability</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Population Viability</h1>
    <!-- end page-header -->
    <!-- begin row -->
    <cfif isdefined('msg') and msg NEQ ''>
      <div class="alert alert-danger"> <strong>Alert!</strong> <cfoutput>#msg#</cfoutput> </div>
    </cfif>
    <!-- begin row col-6-->
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
          <!-- start col-md-6 -->
          <cfoutput>
            <form action="" method="POST" onsubmit="">
                <div class="row">
                  <div class="col-md-12">
                    <!---<h5>Date Range</h5>--->
                    <div class="col-md-3">
                      <label>Start</label>
                      <select class="form-control" name="fromYear" id="fromYear">
                        <cfloop to='#ReportStartyear#' from="#ReportEndyear#" index="i" step='-1'>
                          <option value="#i#" <cfif FORM.fromYear EQ i>selected</cfif> >#i#</option>
                        </cfloop>
                      </select>
                    </div>
                    <div class="col-md-3">
                      <input type="submit" value="Submit" name="RollCall" class="btn btn-primary m-t-25" />
                    </div>
                  </div>
                </div>
            </form>
            <!---Graph Section--->
            	   <div class="row">
                   		<div class="col-lg-12"> 
                                <br>
                                <br>
                                <!-- begin panel -->
                                <div class="panel panel-inverse">
                                  <div class="panel-heading">
                                    <div class="panel-heading-btn"> 
                                        <!---<form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                            <input type="hidden" name="Graph" value="Download_graph_jpg">
                                            <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                                        </form>
                                        <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                                            <input type="hidden" name="Graph" value="Download_graph_pdf">
                                            <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                                        </form>--->
                                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                                        
                                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> 
                                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> 
                                    </div>
                                    <h4 class="panel-title">Dolphin sightings by Year</h4>
                                  </div>
                                  <div class="panel-body">
                                    <div class="color-scheme">
                                        <ul>
                                            <li>
                                                <div class="color-scheme-box">
                                                    <span class="color" style="background-color:##72bbe9;"></span>
                                                    <label>Calf</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="color-scheme-box">
                                                    <span class="color" style="background-color:##e6716f;"></span>
                                                    <label>Juvenal</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="color-scheme-box">
                                                    <span class="color" style="background-color:##f3c98c;"></span>
                                                    <label>Adult</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="color-scheme-box">
                                                    <span class="color" style="background-color:##85f18b;"></span>
                                                    <label>Unknown</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <canvas id="bar-chart" width="600" height="350">
                                  </div>
                                </div>
                                <!-- end panel -->
                                          
                              </div>
                   		</div>
                   </div>
                   <div class="row">   
                      <!-- begin  col-6-->
                          
                      <!-- end  col-6 -->
                      <!-- begin  col-6-->
                          <div class="col-lg-12"> 
                            <br>
                            <br>
                            <!-- begin panel -->
                            <div class="panel panel-inverse">
                              <div class="panel-heading">
                                <div class="panel-heading-btn"> 
                                    <!---<form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Chart" value="Download_chart_jpg">
                                        <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                                    </form>
                                    <form action="" method="POST" name="SubmitChartForm" style="float:left;margin-right:8px;" target="_blank">
                                        <input type="hidden" name="Chart" value="Download_chart_pdf">
                                        <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                                    </form>--->
                                
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> 
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> 
                                </div>
                                <h4 class="panel-title">All Sex Chart</h4>
                              </div>
                              <div class="panel-body" id="pie_panel_body">
                                <div class="row space-bottom">
                                	<div class="col-lg-3 col-sm-3 col-xs-12 text-left">
                                    	 <div>
                                         	<canvas id="calves-sex-pie-chart"></canvas>
                                             <div id="calves-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-sm-6 col-xs-12 text-center"></div>
                                    <div class="col-lg-3 col-sm-3 col-xs-12 text-right">
                                    	<div>
                                              <canvas id="adult-sex-pie-chart"></canvas>
                                             <div id="adult-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row center-row">
                                	<div class="col-lg-12 col-xs-12  text-center">
                                    	<div>
                                             <canvas id="all-sex-pie-chart"></canvas>
                                             <div id="all-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row space-bottom">
                                	<div class="col-lg-3 col-sm-3 col-xs-12  text-left">
                                    	<div>
                                             <canvas id="juvenile-sex-pie-chart"></canvas>
                                             <div id="juvenile-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-sm-6 col-xs-12 text-center"></div>
                                    <div class="col-lg-3 col-sm-3 col-xs-12 text-right">
                                    	<div>
                                            
                                             <canvas id="unknown-sex-pie-chart"></canvas>
                                             <div id="unknown-sex-legend" class="inline-text"></div>
                                        </div>
                                    </div>
                                </div>
                               
                                
                                
                              </div>
                            </div>
                            <!-- end panel -->
                          </div>
						</div>
            
            
            </cfoutput>
        
        
        
    </div>


<!-- begin ##footer -->
      <div id="footer" class="footer"> 
        <span class="pull-right"> 
            <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top"> <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span> </a> 
        </span> &copy; 
        <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved 
      </div>
  <!-- end ##footer -->

</div>
<!-- end ##content -->

<div class="modal fade" id="all-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="all-modal-title"></h4>
      </div>
      <div class="modal-body" id="all-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="year-model">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="year-modal-title"></h4>
      </div>
      <div class="modal-body" id="year-modal-body">
	  </div>
      </div>
    </div>
  </div>
</div>