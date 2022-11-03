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
<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page = 50>
<cfset today = now()>
<cfparam name="Form.StartYear" default="2013">
<cfparam name="Form.EndYear"   default="#year(now())#">
<cfset ReportStartyear = 1990>
<cfset ReportEndYear   = year(now())>

<cfset birthRateBySegment     = ["1A","1B","1C","2","3","4"]>
<cfset birthRateSeenBySegment = [0,0,0,0,0,0]>
<cfset deathRateBySegment     = ["1A","1B","1C","2","3","4"]>
<cfset deathRateSeenBySegment = [0,0,0,0,0,0]>

<cfset getBirthRateBySegment   = Application.Reporting.getBirthRateBySegment(StartYear = Form.StartYear,EndYear = Form.EndYear)>
<cfset getBirthRateByYear      = Application.Reporting.getBirthRateByYear(StartYear = Form.StartYear,EndYear = Form.EndYear)>
<cfset getBirthRateByMonth     = Application.Reporting.getBirthRateByMonth(StartYear = Form.StartYear,EndYear = Form.EndYear)>

<cfset getDeathRateBySegment   = Application.Reporting.getDeathRateBySegment(StartYear = Form.StartYear,EndYear = Form.EndYear)>
<cfset getDeathRateByYear      = Application.Reporting.getDeathRateByYear(StartYear = Form.StartYear,EndYear = Form.EndYear)>
<cfset getDeathRateByMonth     = Application.Reporting.getDeathRateByMonth(StartYear = Form.StartYear,EndYear = Form.EndYear)>

<cfloop query="getBirthRateBySegment">
	<cfif ZSEGMENT EQ "1A">
        <cfset birthRateSeenBySegment[1] ++>
    </cfif>
    <cfif ZSEGMENT EQ "1B">
        <cfset birthRateSeenBySegment[2] ++>
    </cfif>
    <cfif ZSEGMENT EQ "1C">
        <cfset birthRateSeenBySegment[3] ++>
    </cfif>
    <cfif ZSEGMENT EQ "2">
        <cfset birthRateSeenBySegment[4] ++>
    </cfif>
    <cfif ZSEGMENT EQ "3">
        <cfset birthRateSeenBySegment[5] ++>
    </cfif>
    <cfif ZSEGMENT EQ "4">
        <cfset birthRateSeenBySegment[6] ++>
    </cfif>
</cfloop>

<cfset birthRateByYear         = ListtoArray(ValueList(getBirthRateByYear.YEARS))>
<cfset birthRateSeenByYear     = ListtoArray(ValueList(getBirthRateByYear.SEEN_TIMES))>

<cfset birthRateByMonth        = ListtoArray(ValueList(getBirthRateByMonth.MONTHS))>
<cfset birthRateSeenByMonth    = ListtoArray(ValueList(getBirthRateByMonth.SEEN_TIMES))>

<cfloop query="getDeathRateBySegment">
	<cfif ZSEGMENT EQ "1A">
        <cfset deathRateSeenBySegment[1] ++>
    </cfif>
    <cfif ZSEGMENT EQ "1B">
        <cfset deathRateSeenBySegment[2] ++>
    </cfif>
    <cfif ZSEGMENT EQ "1C">
        <cfset deathRateSeenBySegment[3] ++>
    </cfif>
    <cfif ZSEGMENT EQ "2">
        <cfset deathRateSeenBySegment[4] ++>
    </cfif>
    <cfif ZSEGMENT EQ "3">
        <cfset deathRateSeenBySegment[5] ++>
    </cfif>
    <cfif ZSEGMENT EQ "4">
        <cfset deathRateSeenBySegment[6] ++>
    </cfif>
</cfloop>

<cfset deathRateByYear         = ListtoArray(ValueList(getDeathRateByYear.YEARS))>
<cfset deathRateSeenByYear     = ListtoArray(ValueList(getDeathRateByYear.SEEN_TIMES))>

<cfset deathRateByMonth        = ListtoArray(ValueList(getDeathRateByMonth.MONTHS))>
<cfset deathRateSeenByMonth    = ListtoArray(ValueList(getDeathRateByMonth.SEEN_TIMES))>

<script>
	<cfoutput>
		var #toScript(birthRateBySegment, "birthRateBySegment")#;
		var #toScript(birthRateSeenBySegment, "birthRateSeenBySegment")#;
		var #toScript(birthRateByYear, "birthRateByYear")#;
		var #toScript(birthRateSeenByYear, "birthRateSeenByYear")#;
		var #toScript(birthRateByMonth, "birthRateByMonth")#;
		var #toScript(birthRateSeenByMonth, "birthRateSeenByMonth")#;
		
		var #toScript(deathRateBySegment, "deathRateBySegment")#;
		var #toScript(deathRateSeenBySegment, "deathRateSeenBySegment")#;
		var #toScript(deathRateByYear, "deathRateByYear")#;
		var #toScript(deathRateSeenByYear, "deathRateSeenByYear")#;
		var #toScript(deathRateByMonth, "deathRateByMonth")#;
		var #toScript(deathRateSeenByMonth, "deathRateSeenByMonth")#;
	</cfoutput>    
</script>
  <!-- begin ##content -->
  
  <div id="content" class="content"> 
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Birth - Death Rate</a></li>
      <li><a href="javascript:;">Birth - Death Rate</a></li>
    </ol>
    <!-- end breadcrumb --> 
    <!-- begin page-header -->
    <h1 class="page-header">Birth - Death Rate</h1>
    <!-- end page-header --> 
    
    <!-- begin row -->
    <!---Birth Rate Section--->
    <div class="row"> 
     <div class="row col-lg-12"> 
        <div class="panel panel-inverse">
          <div class="panel-heading">
            <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
            <h4 class="panel-title">Birth Rate Section</h4>
          </div>
          <div class="panel-body">
            <div class="row"> 
                <cfoutput>
                    <form name="DeathRateByYear" id="" action="" method="POST">
                      <div class="col-md-12">
                        <div class="col-md-2">
                            <div class="form-group">
                              <label>Start Year</label>
                              <select class="form-control" name="StartYear" id="StartYear">
                                <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                                  <cfif Form.StartYear eq i>
                                    <option value="#i#" selected="selected">#i#</option>
                                    <cfelse>
                                    <option value="#i#">#i#</option>
                                  </cfif>
                                </cfloop>
                              </select>
                            </div>  
                        </div>
                        <div class="col-md-2">
                          <div class="form-group">
                              <label>End year</label>
                              <select class="form-control" name="EndYear" id="EndYear">
                                <cfloop to='#ReportEndyear#' from="#ReportStartyear#" index="i">
                                  <cfif Form.EndYear eq i>
                                    <option value="#i#" selected="selected">#i#</option>
                                    <cfelse>
                                    <option value="#i#">#i#</option>
                                  </cfif>
                                </cfloop>
                              </select>
                          </div>
                        </div>
                        <div class="col-md-2">
                          <input type="submit" value="Submit" name="Submit" id="Submit" class="btn btn-primary m-t-25" />
                        </div>
                      </div>
                    </form>
                </cfoutput>
                <div class="col-lg-6">
                    <div class="panel panel-inverse">
                      <div class="panel-heading">
                        <div class="panel-heading-btn">
                          
                          <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                        <h4 class="panel-title">Birth Rate By Segment Graph</h4>
                      </div>
                      <div class="panel-body">
                          <canvas id="birthRateBySegmentChart"></canvas>
                      </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="panel panel-inverse">
                      <div class="panel-heading">
                        <div class="panel-heading-btn">
                          
                          <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                        <h4 class="panel-title">Birth Rate By Year Graph</h4>
                      </div>
                      <div class="panel-body">
                          <canvas id="birthRateByYearChart"></canvas>
                      </div>
                    </div>
                </div>
            </div>
            <div class="row"> 
                <div class="col-lg-12">
                    <div class="panel panel-inverse">
                      <div class="panel-heading">
                        <div class="panel-heading-btn">
                          
                          <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                        <h4 class="panel-title">Birth Rate By Month Graph</h4>
                      </div>
                      <div class="panel-body">
                          <canvas id="birthRateByMonthChart"></canvas>
                      </div>
                    </div>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!---Birth Rate Section--->
    
    <!---Death Rate Section--->
    <div class="row"> 
     <div class="row col-lg-12"> 
        <div class="panel panel-inverse">
          <div class="panel-heading">
            <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
            <h4 class="panel-title">Death Rate Section</h4>
          </div>
          <div class="panel-body">
            <div class="row"> 
                <div class="col-lg-6">
                    <div class="panel panel-inverse">
                      <div class="panel-heading">
                        <div class="panel-heading-btn">
                          
                          <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                        <h4 class="panel-title">Death Rate By Segment Graph</h4>
                      </div>
                      <div class="panel-body">
                          <canvas id="deathRateBySegmentChart"></canvas>
                      </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="panel panel-inverse">
                      <div class="panel-heading">
                        <div class="panel-heading-btn">
                          
                          <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                        <h4 class="panel-title">Death Rate By Year Graph</h4>
                      </div>
                      <div class="panel-body">
                          <canvas id="deathRateByYearChart"></canvas>
                      </div>
                    </div>
                </div>
            </div>
            <div class="row"> 
                <div class="col-lg-12">
                    <div class="panel panel-inverse">
                      <div class="panel-heading">
                        <div class="panel-heading-btn">
                          
                          <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                        <h4 class="panel-title">Death Rate By Month Graph</h4>
                      </div>
                      <div class="panel-body">
                          <canvas id="deathRateByMonthChart"></canvas>
                      </div>
                    </div>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!---Death Rate Section--->
    <!-- begin ##footer -->
    <div id="footer" class="footer"> <span class="pull-right"> <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top"> <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span> </a> </span> &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved </div>
    <!-- end ##footer --> 
    <!-- end ##content --> 
  </div>