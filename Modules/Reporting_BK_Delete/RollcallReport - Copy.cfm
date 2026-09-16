<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">

<cfset Application.record_per_page = 10>

<cfset ReportStartyear = 1990>
<cfset ReportEndyear = year(now())>
<cfset from = ReportEndyear-1>


<cfparam name="FORM.fromYear" default="#from#">
<cfparam name="FORM.toYear" default="#year(now())#">
<cfparam name="FORM.seentimes" default="1">


<!------- Roll Call--------->


  <cfif  FORM.toYear  LT  FORM.fromYear  >
    <cfset msg = 'Start Year must be less and equal to End Year'>
    <cfelse>
    <cfset qgetRollCall = Application.Reporting.getRollCall(argumentCollection="#Form#")>
  </cfif>


<CFIF isdefined('FORM.RollCall') and FORM.RollCall EQ  "Download as CSV">
  <cfspreadsheet 
    	action="write" 
        filename="C:\home\wildfins.org\subdomains\dev-wildfins\Reports\RollCall\RollCall.xls" 
        overwrite="true"
        query="qgetRollCall"
    >
  <cflocation url="/Reports/RollCall/RollCall.xls" addtoken="no">
</CFIF>

<cfparam name="getSeentimes" default="">
<cfset res = [] >
<cfif isdefined('FORM.seentimes') AND FORM.seentimes NEQ '' >
  <cfif not isdefined('msg') >
    <cfloop from="1" to="12" index="i">
      <cfquery name="getSeentimes" dbtype="query" >
 		SELECT count(SEEN_TIMES) as times from qgetRollCall where SEEN_TIMES >= #FORM.seentimes#  AND SurveryMONTH = #i#
 </cfquery>
      <cfif getSeentimes.recordcount NEQ 0 >
        <cfset res[i] = getSeentimes.times>
        <cfelse>
        <cfset res[i] = 0>
      </cfif>
    </cfloop>
    <cfelse>
    <cfset res = [0,0,0,0,0,0,0,0,0,0,0,0] >
  </cfif>
  <script>

<cfoutput>
	var #toScript(res, "res")#; 
</cfoutput>

</script>
  <!---<cfquery name="qgetRollCall" dbtype="query" >
 		SELECT * from qgetRollCall where SEEN_TIMES >= #FORM.seentimes# 
 </cfquery>--->
</cfif>
<!-- begin ##content -->

<div id="content" class="content">
  <!-- begin breadcrumb -->
  <ol class="breadcrumb pull-right">
    <li><a href="javascript:;">Reporting</a></li>
    <li><a href="javascript:;">Roll Call Report</a></li>
  </ol>
  <!-- end breadcrumb -->
  <!-- begin page-header -->
  <h1 class="page-header">Roll Call Report</h1>
  <!-- end page-header -->
  <!-- begin row -->
  <div class="row">
    <cfif isdefined('msg') and msg NEQ ''>
      <div class="alert alert-danger"> <strong>Alert!</strong> <cfoutput>#msg#</cfoutput> </div>
    </cfif>
    <!-- begin row col-6-->
    <div class="row col-lg-12">
      <!-- begin panel -->
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
          <h4 class="panel-title">Filters </h4>
        </div>
        <div class="panel-body">
          <!-- start col-md-6 -->
          <cfoutput>
            <form action="" method="POST">
              <div class="col-md-12">
                <h5>Date Range</h5>
                <div class="col-md-3">
                  <label>Start</label>
                  <select class="form-control" name="fromYear">
                    <cfloop to='#ReportStartyear#' from="#ReportEndyear#" index="i" step='-1'>
                      <option value="#i#" <cfif FORM.fromYear EQ i>selected</cfif> >#i#</option>
                    </cfloop>
                  </select>
                </div>
                <div class="col-md-3">
                  <label>End</label>
                  <select class="form-control" name="toYear">
                    <cfloop to='#ReportStartyear#' from="#ReportEndyear#" index="i" step='-1'>
                      <option value="#i#" <cfif FORM.toYear EQ i>selected</cfif>>#i#</option>
                    </cfloop>
                  </select>
                </div>
                <div class="col-md-3">
                  <input type="submit" value="Submit" name="RollCall" class="btn btn-primary m-t-25" />
                </div>
                <div class="col-md-3">
                  <input type="submit" value="Download as CSV" name="RollCall" class="btn btn-sucess m-t-25" />
                </div>
              </div>
            </form>
            <form action="" method="POST">
                  <div class="col-md-3 m-l-20">
                    <br>
                    <label>Filter</label>
                    
                    <select class="form-control" name="seentimes"  onchange="this.form.submit()">
                      <cfloop from='1' to="30" index="i" >
                        <cfoutput>
                          <option value="#i#" <cfif FORM.seentimes EQ i>selected</cfif>>Seen #i# or more times</option>
                        </cfoutput>
                      </cfloop>
                    </select>
					<cfoutput>
                    <input type="hidden" name="fromYear" value="#FORM.fromYear#">
                    <input type="hidden" name="toYear" value="#FORM.toYear#">
                    </cfoutput>
                  </div>
                </form>
          </cfoutput>
          <!-- end col-md-6 -->
          <div class="col-md-12"> <br>
            <br>
            <div class="panel pagination-inverse m-b-0 clearfix">
              <table id="data-table" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                <thead>
                  <tr class="inverse">
                    <th>Name</th>
                    <th>Code</th>
                    <th>Sex</th>
                    <th>Age</th>
                    <th>Seen Times</th>
                  </tr>
                </thead>
                <tbody>
                  <cfif isdefined('QGETROLLCALL') AND isdefined('qgetRollCall.recordcount') AND qgetRollCall.recordcount NEQ 0 >
                    <cfoutput query="qgetRollCall" startrow="#startHereIndex#" maxrows="#Application.record_per_page#" group="code">
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
                      <cfquery name="qdolphindetail" dbtype="query">
                      		SELECT * from qgetRollCall where code = '#qgetRollCall.CODE#' 
                      </cfquery>
                     
                      <tr class="gradeU">
                        <td id="group_name"><a href="##collapse#qgetRollCall.currentrow#" data-toggle="collapse" >#qgetRollCall.NAME#</a></td>
                        <td id="group_name">#qgetRollCall.CODE#</td>
                        <td id="group_status">#qgetRollCall.SEX#</td>
                        <td id="group_status">#age#</td>
                        <td id="group_status">#qdolphindetail.recordcount#</td>
                      </tr>
                      <tr id="collapse#qgetRollCall.currentrow#" class="panel-collapse collapse" >
                        <td colspan="8"><div class="table-responsive">
                            <table class="table table-sm">
                              <thead>
                                <tr>
                                  <th>##</th>
                                  <th>Sighting ID</th>
                                  <th>Date Seen</th>
                                  <th>Dscore</th>
                                  <th>Seen Times</th>
                                </tr>
                              </thead>
                              <tbody style="background-color: ##636A71;color: ##eceeef;">
                            
                                <cfif qdolphindetail.recordcount NEQ 0 >
                                <cfloop query="qdolphindetail">
                                  <tr>
                                    <th scope="row">#qdolphindetail.currentrow#</th>
                                    <td>#qdolphindetail.SIGHTING_ID#</td>
                                    <td>#qdolphindetail.SURVERYMONTH# / #qdolphindetail.SURVERYYEAR#</td>
                                    <td>#qdolphindetail.Dscore#</td>
                                    <td>#qdolphindetail.SEEN_TIMES#</td>
                                  </tr>
                                  </cfloop>
                                  <cfelse>
                                  <tr>
                                    <td colspan="5">No Record Found.</td>
                                  </tr>
                                </cfif>
                              </tbody>
                            </table>
                          </div></td>
                      </tr>
                    </cfoutput>
                  </cfif>
                </tbody>
              </table>
              <form action="" method="post" name="paginationform">
                <input type="hidden" name="startHereIndex" value="1" />
              </form>
              <cfif isdefined('QGETROLLCALL') AND isdefined('qgetRollCall.recordcount') AND qgetRollCall.recordcount NEQ 0 >
                <cfset qpagination = qgetRollCall >
                <cfinclude template="../pagination.cfm">
              </cfif>
            </div>
          </div>
          <!-- begin  col-6-->
          <div class="col-lg-6"> <br>
            <br>
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Summary 1</h4>
              </div>
              <div class="panel-body">
                <form action="" method="POST">
                  <div class="col-md-12">
                    <label>Filter</label>
                    <select class="form-control" name="seentimes" id="seenform" onchange="this.form.submit()">
                      <cfloop from='1' to="10" index="i" >
                        <cfoutput>
                          <option value="#i#" <cfif FORM.seentimes EQ i>selected</cfif>>Seen #i# or more times</option>
                        </cfoutput>
                      </cfloop>
                    </select>
                    <cfoutput>
                      <input type="hidden" name="fromYear" value="#FORM.fromYear#">
                      <input type="hidden" name="toYear" value="#FORM.toYear#">
                    </cfoutput> </div>
                </form>
                <div>
                  <canvas id="bar-chart"></canvas>
                </div>
              </div>
            </div>
            <!-- end panel -->
          </div>
          <!-- end  col-6 -->
        </div>
      </div>
      <!-- end panel -->
    </div>
    <!-- end row col-6 -->
  </div>
  <!-- end row -->
  <!-- begin ##footer -->
  <div id="footer" class="footer"> <span class="pull-right"> <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top"> <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span> </a> </span> &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved </div>
  <!-- end ##footer -->
</div>
<!-- end ##content -->
