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
<cfparam name="Form.Mother"    default="">
<cfparam name="Form.Seen"      default="">
<cfparam name="Form.Segment"   default="">
<cfset ReportStartyear = 1990>
<cfset ReportEndYear   = year(now())>
<cfset COA_Avg 		   = 0>

<cfset Mom_Calf    	   		    = ArrayNew(1)>
<cfset Mom_Calf_COA    		    = ArrayNew(1)>
<!---<cfset Unknown_Home_Range       = ["1A","1B","1C","2","3","4"]>
<cfset UnknownHomeRangeCount    = [0,0,0,0,0,0]>
<cfset UnknownHomeRangeCounter  = 0>
<cfset UnknownHomeRangeDolphins = ArrayNew(1)>--->

<cfset qGetCOAReport   = Application.Reporting.getCOAReport(StartYear = Form.StartYear,EndYear = Form.EndYear,Seen = Form.Seen,Mother = Form.Mother,Segment = Form.Segment)>
<cfset qGetAllMothers  = Application.Reporting.getAllMothers()>

  <!-- begin ##content -->
  
  <div id="content" class="content"> 
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Coefficient of Association (COA)</a></li>
      <li><a href="javascript:;">Coefficient of Association (COA) Report</a></li>
    </ol>
    <!-- end breadcrumb --> 
    <!-- begin page-header -->
    <h1 class="page-header">Coefficient of Association (COA) Report</h1>
    <!-- end page-header --> 
    
    <!-- begin row -->
    <div class="row"> 
     <div class="row col-lg-12"> 
        <div class="panel panel-inverse">
          <div class="panel-heading">
            <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
            <h4 class="panel-title">Coefficient of Association (COA)</h4>
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
                        <div class="col-md-2">
                          <div class="form-group">
                              <label>Seen</label>
                              <select class="form-control" name="Seen">
                                <option value=""></option>
                                <option value="=1"   <cfif Seen EQ '=1'>  selected="selected"</cfif>>1 Time</option>
                                <option value="2-5"  <cfif Seen EQ '2-5'> selected="selected"</cfif>>2-5 Time</option>
                                <option value="6-10" <cfif Seen EQ '6-10'>selected="selected"</cfif>>6-10 Time</option>
                                <option value=">5"   <cfif Seen EQ '>5'>  selected="selected"</cfif>>>5 Time</option>
                                <option value=">20"  <cfif Seen EQ '>20'> selected="selected"</cfif>>>20 Time</option>
                                <option value=">50"  <cfif Seen EQ '>50'> selected="selected"</cfif>>>50 Time</option>
                              </select>
                          </div>
                        </div>
                        <div class="col-md-2">
                          <div class="form-group">
                              <label>Mom</label>
                              <select class="combobox form-control" name="Mother" id="Mother">
                              	<option value=""></option>
                                <cfloop query="qGetAllMothers">
                                    <option value="#Mothers#" <cfif Form.Mother eq Mothers>selected</cfif>>#Mothers#</option>                                   
                                </cfloop>
                              </select>
                          </div>
                        </div>
                        <div class="col-md-2">
                          <div class="form-group">
                              <label>Segment</label>
                              <select class="form-control" name="Segment">
                                <option value=""></option>
                                <option value="1A"     <cfif Segment EQ '1A'>    selected="selected"</cfif>>1A</option>
                                <option value="1B"     <cfif Segment EQ '1B'>    selected="selected"</cfif>>1B</option>
                                <option value="1C"     <cfif Segment EQ '1C'>    selected="selected"</cfif>>1C</option>
                                <option value="2"      <cfif Segment EQ '2'>     selected="selected"</cfif>>2</option>
                                <option value="3"      <cfif Segment EQ '3'>     selected="selected"</cfif>>3</option>
                                <option value="4"      <cfif Segment EQ '4'>     selected="selected"</cfif>>4</option>
                                <option value="group"  <cfif Segment EQ 'group'> selected="selected"</cfif>>2-3-4</option>
                              </select>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="submit" value="Submit" name="Submit" id="Submit" class="btn btn-primary m-t-25" />
                        </div>
                        <div class="col-md-3">
                            <div class="widget widget-stat bg-success text-white">
                                <div class="widget-stat-icon"><img src="http://test.wildfins.org/resources/assets/img/dashboard-icons/dolphin.png" height="60" width="60"></div>
                                <div class="widget-stat-info">
                                    <div class="widget-stat-title">Average COA</div>
                                    <div class="widget-stat-number COA_avg"></div>
                                </div>
                            </div>
                        </div>
                      </div>
                      <input type="hidden" name="startHereIndex" value="1" />
                    </form>
                </cfoutput>
                <cfif qGetCOAReport.recordcount NEQ 0 >
                    <div class="col-lg-12">
                        <div class="panel panel-inverse">
                          <div class="panel-heading">
                            <div class="panel-heading-btn">
                              
                              <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                            <h4 class="panel-title">COA Graph</h4>
                          </div>
                          <div class="panel-body adjust_padding">
                              <canvas id="barChart" style="width:100%;"></canvas>
                          </div>
                        </div>
                    </div>
                    <!---<div class="col-lg-6 col-lg-offset-3">
                        <div class="panel panel-inverse">
                          <div class="panel-heading">
                            <div class="panel-heading-btn">
                              
                              <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                            <h4 class="panel-title">Unknown Home Range Dolphins Graph</h4>
                          </div>
                          <div class="panel-body adjust_padding">
                              <canvas id="UnknownHomeRange_Chart"></canvas>
                          </div>
                        </div>
                    </div>--->
                </cfif>
                <div class="panel pagination-inverse m-b-0 clearfix">
                  <table data-order='[[1,"asc"]]' class="table table-bordered table-hover home_range_sec">
                    <thead>
                      <tr class="inverse">
                        <th>MOM</th>
                        <th>CALF</th>
                        <th>COA</th>
                        <th>Home Range</th>
                        <th>Last Sighting</th>
                        <th>Birth Estimate</th>
                        <th>Age At Last Sighting</th>
                        <th>Lineage</th>
                      </tr>
                    </thead>
                    <tbody>
                      <cfif qGetCOAReport.recordcount NEQ 0 >
							<cfoutput query="qGetCOAReport" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                              <cfset qCOAdetail = Application.Reporting.getCOAdetail(Form.StartYear,Form.EndYear,CODE,Mothers,Segment)>
                              <cfset COA = NumberFormat(2*(SEEN_COMBINE)/(CALF_SEEN+MOTHER_SEEN), '9.99999')>
                              <cfset arrayappend(Mom_Calf,Mothers&'-'&Code)>
                              <cfset arrayappend(Mom_Calf_COA,COA)>
                              <!---Calculate Home Range--->
							  <cfif MOTHER_SEEN GT 0>
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
                                    <cfset "segments_#i#" = NumberFormat((evaluate('segment_#i#')/MOTHER_SEEN)*100,'0')>
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
                                 <cfif home_range eq 0>
<!---                                       <cfset UnknownHomeRangeCounter ++> --->
                                 </cfif>
                              </cfif>
                              <!---Calculate Home Range--->
                              <tr class="gradeU">
                                <td id="group_name"><a href="##collapse#qGetCOAReport.currentrow#" data-toggle="collapse" class="dataToggle" id="#qGetCOAReport.currentrow#">#Mothers#</a></td>
                                <td id="group_name">#CODE#</td>
                                <td id="group_status">#COA#</td>
                                <td class="home_range"><cfif home_range NEQ 0>#home_range#<cfelse>N/A</cfif></td>
                                <td id="group_name">#DateFormat(LastSceen,'YYYY-MM-DD')#</td>
                                <td id="group_name">#DateFormat(Birth_Estimate,'YYYY-MM-DD')#</td>
                                <td>#AgeAtLastSceen#</td>
                                <td>#Mothers#-#LINEAGE#</td>
                              </tr>
                              <tr id="collapse#qGetCOAReport.currentrow#" class="panel-collapse collapse" >
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
                                            
                                                <cfif qCOAdetail.recordcount NEQ 0 >
                                                    <cfloop query="qCOAdetail">
                                                      <tr>
                                                        <th scope="row">#qCOAdetail.currentrow#</th>
                                                        <td>
                                                        <form action="#Application.siteroot#?ArchiveModule=Sighting&Page=Home&Archive" method="post" id="sighting_detail" target="_blank">
                                                            <input type="hidden" name="project_id" value="#qCOAdetail.pro_id#">
                                                            <input type="hidden" name="sight_id" value="#qCOAdetail.SIGHTING_ID#">
                                                            <a href="javascript:void(0)" style="color:white" class="sighting-detail">#qCOAdetail.SIGHTING_ID#</a>
                                                         </form>
                                                        </td>
                                                        <td>#DateFormat(DATESEEN,'YYYY-MM-DD')#</td>
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
                            <cfloop query="qGetCOAReport">
                              <cfset COA = NumberFormat(2*(SEEN_COMBINE)/(CALF_SEEN+MOTHER_SEEN), '9.99999')>
                              <cfset COA_Avg = COA_Avg + COA>
                              <!---Calculate Home Range--->
							  <cfif MOTHER_SEEN GT 0>
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
                                    <cfset "segments_#i#" = NumberFormat((evaluate('segment_#i#')/MOTHER_SEEN)*100,'0')>
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
                                 <!---<cfif home_range eq 0>
                                      <cfset UnknownHomeRangeCounter ++>
                                      <cfset arrayappend(UnknownHomeRangeDolphins,Dolphin_ID)>
                                 </cfif>--->
                              </cfif>
                              <!---Calculate Home Range--->
                            </cfloop>
                            <cfset COA_Avg = NumberFormat(COA_Avg/qGetCOAReport.recordcount, '9.99999')>
                            <!---<cfif UnknownHomeRangeCounter GT 0>
                            	<cfloop from="1" to="#UnknownHomeRangeCounter#" index="i">
                                	<cfloop from="1" to="6" index="j">
                                    	<cfset UnknownHomeRangeCount[j] ++>
                                    </cfloop>
                                </cfloop>
                                <cfset UnknownHomeRangeDolphins = arraytolist(UnknownHomeRangeDolphins)>
                            </cfif>--->
                      <cfelse>
                          <tr>
                            <td colspan="3" style="text-align: center;">No Record Found.</td>
                          </tr>
                      </cfif>
                    </tbody>
                  </table>
                  <cfif isdefined('qGetCOAReport') AND isdefined('qGetCOAReport.recordcount') AND qGetCOAReport.recordcount NEQ 0 >
                    <cfset qpagination = qGetCOAReport >
                    <cfinclude template="../pagination.cfm">
                  </cfif>
                  <script>
					<cfoutput>
						var #toScript(COA_Avg, "COA_Avg")#;
						var #toScript(Mom_Calf, "Mom_Calf")#;
						var #toScript(Mom_Calf_COA, "Mom_Calf_COA")#;
						<!---var #toScript(Unknown_Home_Range, "Unknown_Home_Range")#;
						var #toScript(UnknownHomeRangeCount, "UnknownHomeRangeCount")#;	
						var #toScript(UnknownHomeRangeDolphins,"UnknownHomeRangeDolphins")#;--->			
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
  