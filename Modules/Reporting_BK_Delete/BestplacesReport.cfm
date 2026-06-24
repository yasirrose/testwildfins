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
<cfparam name="form.searchword" default="">
<cfset Application.record_per_page = 10>
<cfset ReportStartyear = 1990>
<cfset ReportEndyear = year(now())>
<cfset from = ReportEndyear-1>
<cfparam name="FORM.fromYear" default="#from#">
<cfparam name="FORM.toYear" default="#year(now())#">
<cfparam name="FORM.seentimes" default="1">
<cfparam name="code" default="">
<cfparam name="getSeentimes" default="">

<cfset summary2 = [0,0,0,0,0,0]>
<cfset total_best_place = [0,0,0,0,0,0,0,0]>

<!------- Roll Call--------->
<!---When page loads--->
<cfif  FORM.toYear  LT  FORM.fromYear  >
  <cfset msg = 'Start Year must be less and equal to End Year'>
  <cfelse>
  <cfset qgetRollCall = Application.Reporting.getBestPlaceMain(argumentCollection="#Form#")>
  
  <cfset qgetBodyConditionGrapgh = Application.Reporting.getBodyConditionGrapgh(argumentCollection="#Form#")>
  
  <cfset total_best_place = Application.Reporting.getBestPlaceGrapgh(argumentCollection="#Form#")>
  
 

  
  <cfif not isdefined('msg') >
    <cfset summary2 = [] >
    <cfset aFetals = ArrayNew(1) >
    <cfset aBC = ArrayNew(1) >
    <cfset aXeno = ArrayNew(1) >
    <cfset aRDS = ArrayNew(1) >
    <cfset aREM = ArrayNew(1) >
    <cfset aFreshwound = ArrayNew(1) >
		<cfif qgetBodyConditionGrapgh.recordcount GT 0 >
        		<cfquery name="qFetals" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where Fetals = 1
                </cfquery>
                <cfif qFetals.recordcount GT 0>
                	<cfoutput query="qFetals">
                    	<cfset tt = StructNew() >
						<cfset tt['ID'] = qFetals.Dolphin_ID >
                        <cfset tt['Name'] = qFetals.Name >
                        <cfset tt['Code'] = qFetals.Code >
                        <cfset tt['Sex'] = qFetals.Sex >
                         <cfset tt['Sighting_ID'] = qFetals.Sighting_ID >
                         <cfset tt['pro_id'] = qFetals.pro_id >
                        <cfset ArrayAppend(aFetals,tt)>
                    </cfoutput>
                </cfif>
                

                <cfquery name="qBC" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where BC = 1
                </cfquery>
                <cfif qBC.recordcount GT 0>
                	<cfoutput query="qBC">
                    	<cfset s1 = StructNew() >
						<cfset s1['ID'] = qBC.Dolphin_ID >
                        <cfset s1['Name'] = qBC.Name >
                        <cfset s1['Code'] = qBC.Code >
                        <cfset s1['Sex'] = qBC.Sex >
                         <cfset s1['Sighting_ID'] = qBC.Sighting_ID >
                         <cfset s1['pro_id'] = qBC.pro_id >
                        <cfset  ArrayAppend(aBC,s1)>
                    </cfoutput>
                </cfif>
                
                
                <cfquery name="qXeno" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where Xeno = 1
                </cfquery>
                <cfif qXeno.recordcount GT 0>
                	<cfoutput query="qXeno">
                    	<cfset s2 = StructNew() >
						<cfset s2['ID'] = qXeno.Dolphin_ID >
                        <cfset s2['Name'] = qXeno.Name >
                        <cfset s2['Code'] = qXeno.Code >
                        <cfset s2['Sex'] = qXeno.Sex >
                         <cfset s2['Sighting_ID'] = qXeno.Sighting_ID >
                         <cfset s2['pro_id'] = qXeno.pro_id >
                        <cfset ArrayAppend(aXeno,s2)>
                    </cfoutput>
                </cfif>
                
                
                <cfquery name="qRDS" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where RDS = 1
                </cfquery>
                <cfif qRDS.recordcount GT 0>
                	<cfoutput query="qRDS">
                    	<cfset s3 = StructNew() >
						<cfset s3['ID'] = qRDS.Dolphin_ID >
                        <cfset s3['Name'] = qRDS.Name >
                        <cfset s3['Code'] = qRDS.Code >
                        <cfset s3['Sex'] = qRDS.Sex >
                         <cfset s3['Sighting_ID'] = qRDS.Sighting_ID >
                         <cfset s3['pro_id'] = qRDS.pro_id >
                        <cfset  ArrayAppend(aRDS,s3)>
                    </cfoutput>
                </cfif>
                
                <cfquery name="qREM" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where REM = 1
                </cfquery>
                <cfif qREM.recordcount GT 0>
                	<cfoutput query="qREM">
                    	<cfset s4 = StructNew() >
						<cfset s4['ID'] = qREM.Dolphin_ID >
                        <cfset s4['Name'] = qREM.Name >
                        <cfset s4['Code'] = qREM.Code >
                        <cfset s4['Sex'] = qREM.Sex >
                         <cfset s4['Sighting_ID'] = qREM.Sighting_ID >
                         <cfset s4['pro_id'] = qREM.pro_id >
                        <cfset  ArrayAppend(aREM,s4)>
                    </cfoutput>
                </cfif>
                
                <cfquery name="qFreshwound" dbtype="query">
                	SELECT * FROM qgetBodyConditionGrapgh where Freshwound = 1
                </cfquery>
                <cfif qFreshwound.recordcount GT 0>
                	<cfoutput query="qFreshwound">
                    	<cfset s5 = StructNew() >
						<cfset s5['ID'] = qFreshwound.Dolphin_ID >
                        <cfset s5['Name'] = qFreshwound.Name >
                        <cfset s5['Code'] = qFreshwound.Code >
                        <cfset s5['Sex'] = qFreshwound.Sex >
                         <cfset s5['Sighting_ID'] = qFreshwound.Sighting_ID >
                         <cfset s5['pro_id'] = qFreshwound.pro_id >
                        <cfset ArrayAppend(aFreshwound,s5)>
                    </cfoutput>
                </cfif>
              <cfset summary2 = [qFetals.recordcount,qBC.recordcount,qXeno.recordcount,qRDS.recordcount,qREM.recordcount,qFreshwound.recordcount] >   
        </cfif>
        
        
        
    <cfelse>
    <cfset summary2 = [0,0,0,0,0,0] >
  </cfif>
  
</cfif>
<script>
    
    <cfoutput>
	    var #toScript(summary2, "summary2")#; 
        var #toScript(total_best_place, "total_best_place")#; 
		var #toScript(FORM.fromYear, "fromYear")#; 
		var #toScript(FORM.toYear, "toYear")#; 
		
		function checkForm() {
			if($("##fromYear").val() >  $("##toYear").val() ) {
				bootbox.alert('Start Year must be less and equal to End Year');
				return false;
				}
			}
		
    </cfoutput>
    
    </script>
<CFIF isdefined('FORM.RollCall') and FORM.RollCall EQ  "Download as Excel">
<cfset qgetRollExcel = Application.Reporting.getRollCallMain(argumentCollection="#Form#")>

  <cfspreadsheet 
    	action="write" 
        filename="C:\home\wildfins.org\subdomains\dev-wildfins\Reports\RollCall\BestPlace.xls" 
        overwrite="true"
        query="qgetRollExcel"
    >
  <cflocation url="/Reports/RollCall/BestPlace.xls" addtoken="no">
</CFIF>
<!-- begin ##content -->

<div id="content" class="content">
  <!-- begin breadcrumb -->
  <ol class="breadcrumb pull-right">
    <li><a href="javascript:;">Reporting</a></li>
    <li><a href="javascript:;">Best Places Report</a></li>
  </ol>
  <!-- end breadcrumb -->
  <!-- begin page-header -->
  <h1 class="page-header">Best Places Report</h1>
  <!-- end page-header -->
  <!-- begin row -->

    <cfif isdefined('msg') and msg NEQ ''>
      <div class="alert alert-danger"> <strong>Alert!</strong> <cfoutput>#msg#</cfoutput> </div>
    </cfif>
    <!-- begin row col-6-->
      <!-- begin panel -->
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
          <h4 class="panel-title">Filters </h4>
        </div>
        <div class="panel-body">
          <!-- start col-md-6 -->
          <cfoutput>
            <form action="" method="POST" onsubmit="return checkForm()">
            <div class="row">
              <div class="col-md-12">
                <h5>Date Range</h5>
                <div class="col-md-3">
                  <label>Start</label>
                  <select class="form-control" name="fromYear" id="fromYear">
                    <cfloop to='#ReportStartyear#' from="#ReportEndyear#" index="i" step='-1'>
                      <option value="#i#" <cfif FORM.fromYear EQ i>selected</cfif> >#i#</option>
                    </cfloop>
                  </select>
                </div>
                <div class="col-md-3">
                  <label>End</label>
                  <select class="form-control" name="toYear" id="toYear">
                    <cfloop to='#ReportStartyear#' from="#ReportEndyear#" index="i" step='-1'>
                      <option value="#i#" <cfif FORM.toYear EQ i>selected</cfif>>#i#</option>
                    </cfloop>
                  </select>
                </div>
                <div class="col-md-3">
                  <input type="submit" value="Submit" name="RollCall" class="btn btn-primary m-t-25" />
                </div>
                
                
                <div class="col-md-3" style="margin-bottom:-35px;margin-top:-27px">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Dolphins Sighted</div>
                                <div class="widget-stat-number"><cfif isdefined('total_best_place') >#ArraySum(DeserializeJSON(total_best_place))#</cfif></div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                
              </div>
            </div>  
            </form>
            

    
           <div class="row"> 
          <!-- begin  col-6-->
          <div class="col-lg-6"> <br>
            <br>
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Number of dolphins by Area</h4>
              </div>
             
              <div class="panel-body">
                <div>
                  <canvas id="bestplace-chart" data-height="228px" class="width-full"></canvas>
                </div>
              </div>
            </div>
            <!-- end panel -->
          </div>
          <!-- end  col-6 -->
          
          <!-- begin  col-6-->
          <div class="col-lg-6"> <br>
            <br>
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Body Condition</h4>
              </div>
              <div class="panel-body">
                <div>
                 <canvas id="pie-chart"></canvas>
                 <div id="legend"></div>
                  
                </div>
              </div>
            </div>
            <!-- end panel -->
          </div>
          <!-- end  col-6 -->
            </div>  
            
            <form action="" method="POST">
            <div class="row">
              <div class="col-md-3 m-l-20"> <br>
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
                </cfoutput> </div>
               
               <div class="col-md-3 pull-right m-t-15">
                  <input type="submit" value="Download as Excel" name="RollCall" class="btn btn-sucess m-t-25" />
                </div> 
            </div>      
            </form>
            
          </cfoutput>
          <!-- end col-md-6 -->
          <div class="col-md-12"> <br>
            <br>
            <div class="panel pagination-inverse m-b-0 clearfix">
              <table data-order='[[1,"asc"]]' class="table table-bordered table-hover">
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
                    <cfoutput query="qgetRollCall" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
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
                       
                     
                      
                       <cfset qdolphindetail = Application.Reporting.getBestPlaceSub(FORM.fromYear=FORM.fromYear,FORM.toYear=FORM.toYear,code=qgetRollCall.CODE)>
                      
                      <tr class="gradeU">
                        <td id="group_name"><a href="##collapse#qgetRollCall.currentrow#" data-toggle="collapse" class="dataToggle" id="#qgetRollCall.currentrow#">#qgetRollCall.NAME#</a></td>
                        <td id="group_name">#qgetRollCall.CODE#</td>
                        <td id="group_status">#qgetRollCall.SEX#</td>
                        <td id="group_status">#age#</td>
                        <td id="group_status">#qgetRollCall.SEEN_TIMES#</td>
                      </tr>
                      <tr id="collapse#qgetRollCall.currentrow#" class="panel-collapse collapse" >
                        <td colspan="8"><div class="table-responsive">
                            <table class="table table-sm">
                              <thead>
                                <tr>
                                  <th>##</th>
                                  <th>Sighting ID</th>
                                  <th>Fetals</th>
                                  <th>BC</th>
                                  <th>Xeno</th>
                                  <th>RDS</th>
                                  <th>REM</th>
                                  <th>Fresh wound</th>
                                  <th>Date Seen</th>
                                </tr>
                              </thead>
                              <tbody style="background-color: ##636A71;color: ##eceeef;">
                            
                                <cfif qdolphindetail.recordcount NEQ 0 >
                                <cfloop query="qdolphindetail">
                                  <tr>
                                    <th scope="row">#qdolphindetail.currentrow#</th>
                                    <td>
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                        <input type="hidden" name="project_id" value="#qdolphindetail.pro_id#">
                                        <input type="hidden" name="sight_id" value="#qdolphindetail.SIGHTING_ID#">
                                        <a href="javascript:void(0)" style="color:white" class="sighting-detail">#qdolphindetail.SIGHTING_ID#</a>
                                     </form>
                                    </td>
                                    <!---#qdolphindetail.SIGHTING_ID#--->
                                    <td>#Fetals#</td>
                                     <td>#BC#</td>
                                      <td>#Xeno#</td>
                                       <td>#RDS#</td>
                                        <td>#REM#</td>
                                         <td>#Freshwound#</td>

                                    <td>#qdolphindetail.SURVERYMONTH# / #qdolphindetail.SURVERYYEAR#</td>
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

          
        </div>
      </div>
      <!-- end panel -->

    <!-- end row col-6 -->

  <!-- end row -->
  <!-- begin ##footer -->
  <div id="footer" class="footer"> <span class="pull-right"> <a href="javascript:;" class="btn-scroll-to-top" data-click="scroll-top"> <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span> </a> </span> &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved </div>
  <!-- end ##footer -->
</div>
<!-- end ##content -->




<div class="modal fade" id="fetal">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Fetal Dolphins</h4>
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
            <cfif ArrayLen(aFetals) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(aFetals)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#aFetals[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#aFetals[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#aFetals[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#aFetals[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#aFetals[i].name#</td>
                   <td width="50">#aFetals[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Fetals modal -->


<div class="modal fade" id="bc">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">BC Dolphins</h4>
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
            <cfif ArrayLen(aBC) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(aBC)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#aBC[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#aBC[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#aBC[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#aBC[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#aBC[i].name#</td>
                   <td width="50">#aBC[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  BC modal -->


<div class="modal fade" id="xeno">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Xeno Dolphins</h4>
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
            <cfif ArrayLen(aXeno) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(aXeno)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#aXeno[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#aXeno[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#aXeno[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#aXeno[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#aXeno[i].name#</td>
                   <td width="50">#aXeno[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Xeno modal -->


<div class="modal fade" id="rds">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">RDS Dolphins</h4>
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
            <cfif ArrayLen(aRDS) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(aRDS)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#aRDS[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#aRDS[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#aRDS[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#aRDS[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#aRDS[i].name#</td>
                   <td width="50">#aRDS[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  RDS modal -->


<div class="modal fade" id="rem">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">REM Dolphins</h4>
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
</div><!--  REM modal -->


<div class="modal fade" id="freshwound">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Freshwound Dolphins</h4>
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
            <cfif ArrayLen(aFreshwound) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(aFreshwound)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#aFreshwound[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#aFreshwound[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#aFreshwound[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#aFreshwound[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#aFreshwound[i].name#</td>
                   <td width="50">#aFreshwound[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Fresh wound modal --> 


<style>
.datacontainer{
    height: 350px; 
    overflow:auto; 
}




</style>



