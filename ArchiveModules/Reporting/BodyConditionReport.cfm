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
<cfset Application.record_per_page = 10>
<cfset today = now()>
<cfparam name="Form.StartYear" default="2013">
<cfparam name="Form.EndYear"   default="#year(now())#">
<cfparam name="Form.BodyCondition"   default="All">
<cfparam name="Form.Mother"   default="">
<cfparam name="SegmentReport"   default="">
<cfset ReportStartyear = 1990>
<cfset ReportEndYear   = year(now())>

<cfset dolphinBySegment     = ["1A","1B","1C","2","3","4"]>
<cfset dolphinSeenBySegment = [0,0,0,0,0,0]>


<cfset qgetBodyConditionReport          = Application.Reporting.getBodyConditionReport(StartYear = Form.StartYear,EndYear = Form.EndYear,BodyCondition = Form.BodyCondition)>
<cfset qgetBodyConditionSegmentReport   = Application.Reporting.getBodyConditionReport(StartYear = Form.StartYear,EndYear = Form.EndYear,BodyCondition = Form.BodyCondition,SegmentReport = 1)>
<cfset qgetBodyConditionByYearReport    = Application.Reporting.getBodyConditionByYear(StartYear = Form.StartYear,EndYear = Form.EndYear,BodyCondition = Form.BodyCondition)>

<cfset dolphinByYear = ListTOArray(ValueList(qgetBodyConditionByYearReport.SIGHTING_YEAR))>
<cfset dolphinSeen   = ListTOArray(ValueList(qgetBodyConditionByYearReport.Dolphin_Seen))>

<cfloop query="qgetBodyConditionSegmentReport">
	<cfif ZSEGMENT EQ "1A">
        <cfset dolphinSeenBySegment[1] ++>
    </cfif>
    <cfif ZSEGMENT EQ "1B">
        <cfset dolphinSeenBySegment[2] ++>
    </cfif>
    <cfif ZSEGMENT EQ "1C">
        <cfset dolphinSeenBySegment[3] ++>
    </cfif>
    <cfif ZSEGMENT EQ "2">
        <cfset dolphinSeenBySegment[4] ++>
    </cfif>
    <cfif ZSEGMENT EQ "3">
        <cfset DolphinSeenBySegment[5] ++>
    </cfif>
    <cfif ZSEGMENT EQ "4">
        <cfset dolphinSeenBySegment[6] ++>
    </cfif>
</cfloop>
  <!-- begin ##content -->
  
  <div id="content" class="content"> 
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Body Condition</a></li>
      <li><a href="javascript:;">Body Condition Report</a></li>
    </ol>
    <!-- end breadcrumb --> 
    <!-- begin page-header -->
    <h1 class="page-header">Body Condition Report</h1>
    <!-- end page-header --> 
    
    <!-- begin row -->
    <div class="row"> 
     <div class="row col-lg-12"> 
        <div class="panel panel-inverse">
          <div class="panel-heading">
            <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
            <h4 class="panel-title">Body Condition</h4>
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
                        <div class="col-md-3">
                          <div class="form-group">
                              <label>Body Condition</label>
                              <select class="form-control" id="BodyCondition" name="BodyCondition">
                                <option value="All">Select Body Condition</option>
                                <option value="Shark Bite" <cfif Form.BodyCondition eq 'Shark Bite'>selected</cfif>>Shark Bite</option>
                                <option value="Tiger Stripes" <cfif Form.BodyCondition eq 'Tiger Stripes'>selected</cfif>>Tiger Stripes</option>
                                <option value="Pox" <cfif Form.BodyCondition eq 'Pox'>selected</cfif>>Pox</option>
                                <option value="Boat Hit" <cfif Form.BodyCondition eq 'Boat Hit'>selected</cfif>>Boat Hit</option>
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
                <div class="row">
                    <div class="col-lg-6">
                        <div class="panel panel-inverse">
                          <div class="panel-heading">
                            <div class="panel-heading-btn">
                              
                              <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                            <h4 class="panel-title">Body Condition By Segment Graph</h4>
                          </div>
                          <div class="panel-body">
                              <canvas id="bodyConditionBySegment_Chart"></canvas>
                          </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="panel panel-inverse">
                          <div class="panel-heading">
                            <div class="panel-heading-btn">
                              
                              <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                            <h4 class="panel-title">Dolphins By Year Graph</h4>
                          </div>
                          <div class="panel-body">
                              <canvas id="dolphinByYear_Chart"></canvas>
                          </div>
                        </div>
                    </div>
                </div>
                <div class="panel pagination-inverse m-b-0 clearfix">
                  <table data-order='[[1,"asc"]]' class="table table-bordered table-hover home_range_sec">
                    <thead>
                      <tr class="inverse">
                        <th>Name</th>
                        <th>Code</th>
                        <th>Sex</th>
                        <th>Age</th>
                        <th>Seen Times</th>
                        <th>Home Range</th>
                      </tr>
                    </thead>
                    <tbody>
                      <cfif qgetBodyConditionReport.recordcount NEQ 0 >
							<cfoutput query="qgetBodyConditionReport" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                              
							  <cfif YEAROFBIRTH NEQ '' AND IsNumeric(YEAROFBIRTH)>
								<cfif IsDead	EQ 0 OR DeathYear EQ ''>
                                  <cfset age = ReportEndyear - YEAROFBIRTH >
                                  <cfelse>
                                  <cfif IsNumeric(DeathYear)>
                                    <cfset age = DeathYear - YEAROFBIRTH >
                                    <cfelse>
                                    <cfset age = 'N/A' >
                                  </cfif>
                                </cfif>
                        	  <cfelse>
								<cfset age = 'N/A' >
                              </cfif>
							  <cfset qDolphinDetail = Application.Reporting.getDolphinDetail(Form.StartYear,Form.EndYear,CODE,'','',Form.BodyCondition)>
                              <cfset qgetDolphinSegmentsDetail = Application.Reporting.getDolphinSegmentsDetail(Form.StartYear,Form.EndYear,Form.BodyCondition,Dolphin_ID)>
                              
                              <!---Calculate Home Range--->
							  <cfif SEEN_TIMES GT 0>
                                 <cfset segments   = ["1A","1B","1C","2","3","4"]>
                                 <cfset segmentVal = ArrayNew(1)>
                                 <cfset segment_1A = 0>
                                 <cfset segment_1B = 0>
                                 <cfset segment_1C = 0>
                                 <cfset segment_2  = 0>
                                 <cfset segment_3  = 0>
                                 <cfset segment_4  = 0>
                                 <cfset home_range = 0>
                                 <cfloop array="#segments#" index="i">
                                    <cfset "segments_#i#" = NumberFormat((evaluate('qgetDolphinSegmentsDetail.segment_#i#')/SEEN_TIMES)*100,'0')>
									<cfset ArrayAppend(segmentVal,evaluate('segments_#i#'))>
                                    <cfif evaluate('segments_#i#') GT 50>
                                        <cfset home_range = '<span class="segment_#i#">#i#</span>'>
                                    </cfif>
                                 </cfloop>
                                 <cfif home_range eq 0>
                                    <cfset isbreak = false >
                                    <cfloop from="1" to="#arrayLen(segmentVal)#" index="i">
                                        <cfloop from="1" to="5" index="j">
                                            <cfset currentSegment  = segmentVal[i]>
                                            <cfif ArrayIsDefined(segmentVal,i+j)>
                                                <cfset k = i+j>
                                            <cfelse>
                                                <cfset k = (i+j)-6>
                                            </cfif>
                                            <cfset comparedSegment = segmentVal[k]>
                                            <cfif (currentSegment + comparedSegment) GT 75>
                                                <cfset home_range = '<span class="segment_#segments[i]#">#segments[i]#</span><span class="seperator"> - </span><span class="segment_#segments[k]# right_segment">#segments[k]#</span>'>
                                                <cfset isbreak = true >
                                                <cfbreak>
                                            </cfif>
                                            <cfif isbreak>
                                                <cfbreak>
                                            </cfif>                
                                        </cfloop>
                                    </cfloop>
                                 </cfif>
                              </cfif>
                              <!---Calculate Home Range--->
                              <tr class="gradeU">
                                <td id="group_name"><a href="##collapse#qgetBodyConditionReport.currentrow#" data-toggle="collapse" class="dataToggle" id="#qgetBodyConditionReport.currentrow#">#qgetBodyConditionReport.NAME#</a></td>
                                <td id="group_name">#qgetBodyConditionReport.CODE#</td>
                                <td id="group_status">#qgetBodyConditionReport.SEX#</td>
                                <td id="group_status">#age#</td>
                                <td id="group_status">#qgetBodyConditionReport.SEEN_TIMES#</td>
                                <td class="home_range"><cfif home_range NEQ 0>#home_range#<cfelse>N/A</cfif></td>
                              </tr>
                              <tr id="collapse#qgetBodyConditionReport.currentrow#" class="panel-collapse collapse" >
                                <td colspan="8">
                                    <div class="table-responsive">
                                        <table class="table table-sm">
                                              <thead>
                                                <tr>
                                                  <th>##</th>
                                                  <th>Sighting ID</th>
                                                  <th>Sighting Date</th>
                                                </tr>
                                              </thead>
                                              <tbody style="background-color: ##636A71;color: ##eceeef;">
                                            
                                                <cfif qDolphinDetail.recordcount NEQ 0 >
                                                    <cfloop query="qDolphinDetail">
                                                      <tr>
                                                        <th scope="row">#qDolphinDetail.currentrow#</th>
                                                        <td>
                                                        <form action="#Application.siteroot#?ArchiveModule=Sighting&Page=Home&Archive" method="post" id="sighting_detail" target="_blank">
                                                            <input type="hidden" name="project_id" value="#qDolphinDetail.pro_id#">
                                                            <input type="hidden" name="sight_id" value="#qDolphinDetail.SIGHTING_ID#">
                                                            <a href="javascript:void(0)" style="color:white" class="sighting-detail">#qDolphinDetail.SIGHTING_ID#</a>
                                                         </form>
                                                        </td>
                                                        <td>#DateFormat(DATESEEN,'mm/dd/yyyy')#</td>
                                                      </tr>
                                                      </cfloop>
                                                <cfelse>
                                                  <tr>
                                                    <td colspan="5">No Record Found.</td>
                                                  </tr>
                                                </cfif>
                                              </tbody>
                                        </table>
                                    </div>
                                </td>
                             </tr>
                            </cfoutput>                           
                      <cfelse>
                          <tr>
                            <td colspan="6" style="text-align: center;">No Record Found.</td>
                          </tr>
                      </cfif>
                    </tbody>
                  </table>
                  <cfif isdefined('qgetBodyConditionReport') AND isdefined('qgetBodyConditionReport.recordcount') AND qgetBodyConditionReport.recordcount NEQ 0 >
                    <cfset qpagination = qgetBodyConditionReport >
                    <cfinclude template="../pagination.cfm">
                  </cfif>
                  <script>
					<cfoutput>
						var #toScript(dolphinBySegment, "dolphinBySegment")#;
						var #toScript(dolphinSeenBySegment, "dolphinSeenBySegment")#;
						var #toScript(dolphinByYear, "dolphinByYear")#;
						var #toScript(dolphinSeen, "dolphinSeen")#;
					</cfoutput>    
				  </script>
                </div>
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
  
    <div class="modal fade" id="unknownHomeRange-model">
        <div class="modal-dialog" role="document" style="width:55%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    	<span aria-hidden="true">&times;</span>
                    </button>
                	<h4 class="modal-title" id="unknownHomeRange-modal-title"></h4>
                </div>
            	<div class="modal-body" id="unknownHomeRange-modal-body"></div>
            </div>
        </div>
    </div> 
  