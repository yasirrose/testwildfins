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
<cfparam name="Form.StartYear" default="2004">
<cfparam name="Form.EndYear"   default="#year(now())#">
<cfset ReportStartyear = 1990>
<cfset ReportEndYear   = year(now())>

<cfset dolphinsCodeByZone = ["ALT","BR","IR","ML","SLR"]>
<cfset dolphinsSeenByZone = [0,0,0,0,0]>

<cfset qGetDolphinActivityReport   = Application.Reporting.getDolphinActivityReport(StartYear = Form.StartYear,EndYear = Form.EndYear)>
<cfloop query="qGetDolphinActivityReport">
	<cfif ZONE contains "ALT">
        <cfset dolphinsSeenByZone[1] += SEEN_TIMES >
    </cfif>
    <cfif ZONE contains "BR">
        <cfset dolphinsSeenByZone[2] += SEEN_TIMES >
    </cfif>
    <cfif ZONE contains "IR">
        <cfset dolphinsSeenByZone[3] += SEEN_TIMES >
    </cfif>
    <cfif ZONE contains "ML">
        <cfset dolphinsSeenByZone[4] += SEEN_TIMES >
    </cfif>
    <cfif ZONE contains "SLR">
        <cfset dolphinsSeenByZone[5] += SEEN_TIMES >
    </cfif>
</cfloop>
<script>
    <cfoutput>
	    var #toScript(dolphinsCodeByZone, "dolphinsCodeByZone")#;
		var #toScript(dolphinsSeenByZone, "dolphinsSeenByZone")#;
	</cfoutput>
</script>		

  <!-- begin ##content -->
  
  <div id="content" class="content"> 
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Dolphin Activity</a></li>
      <li><a href="javascript:;">Dolphin Activity Report</a></li>
    </ol>
    <!-- end breadcrumb --> 
    <!-- begin page-header -->
    <h1 class="page-header">Dolphin Activity Report</h1>
    <!-- end page-header --> 
    
    <!-- begin row -->
    <div class="row"> 
     <div class="row col-lg-12"> 
        <div class="panel panel-inverse">
          <div class="panel-heading">
            <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
            <h4 class="panel-title">Dolphin Activity</h4>
          </div>
          <div class="panel-body">
            <div class="row"> 
                <cfoutput>
                    <form name="paginationform" id="" action="" method="POST">
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
                        <div class="col-md-1">
                          <input type="submit" value="Submit" name="Submit" id="Submit" class="btn btn-primary m-t-25" />
                        </div>
                      </div>
                      <input type="hidden" name="startHereIndex" value="1" />
                    </form>
                </cfoutput>
                <cfif qGetDolphinActivityReport.recordcount NEQ 0 >
                    <div class="col-lg-6 col-lg-offset-3">
                        <div class="panel panel-inverse">
                          <div class="panel-heading">
                            <div class="panel-heading-btn">
                              
                              <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                            <h4 class="panel-title">Dolphin Activity Graph</h4>
                          </div>
                          <div class="panel-body adjust_padding">
                              <canvas id="bar-chart-by-zones"></canvas>
                          </div>
                        </div>
                    </div>
                </cfif>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- begin ##footer -->
    <div id="footer" class="footer"> <span class="pull-right"> <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top"> <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span> </a> </span> &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved </div>
    <!-- end ##footer --> 
    <!-- end ##content --> 
  </div>
  
    <div class="modal fade" id="zone-model">
        <div class="modal-dialog" role="document" style="width:55%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                	<h4 class="modal-title" id="zone-modal-title"></h4>
                </div>
            	<div class="modal-body" id="zone-modal-body"></div>
            </div>
        </div>
    </div>