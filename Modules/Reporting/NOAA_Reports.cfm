
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
<cfset Application.record_per_page = 20>
<cfset ReportStartyear = 1990>
<cfset ReportEndyear = year(now())>
<cfset from = ReportEndyear-1>
<cfparam name="FORM.fromYear" default="#from#">
<cfparam name="FORM.toYear" default="#year(now())#">
<cfparam name="FORM.seentimes" default="1">
<cfparam name="code" default="">
<cfparam name="getSeentimes" default="">
<cfparam name="Date_from" default="#Now()#">
<cfparam name="Date_to" default="#Now()#">
<cfparam name="stockSelected" default="0">
<cfset res = [0,0,0,0,0,0,0,0,0,0,0,0] >
<cfset summary2 = [0,0,0] >
<!--- Stock Main Data Fetching --->
<cfset qGetTotalStock = Application.Reporting.TotalStock()>
<cfset qGetTotalDolphinsAndSightings = Application.Reporting.TotalDolphinsAndSightings(Date_from, Date_to, stockSelected)>
<cfset qGetTotalDolphins = Application.Reporting.TotalDolphins(Date_from, Date_to, stockSelected)>
<!------- Roll Call--------->
<!---When page loads--->
<!---<cfif  FORM.toYear  LT  FORM.fromYear  >
  <cfset msg = 'Start Year must be less and equal to End Year'>
  <cfelse>
  <cfset qgetRollCall = Application.Reporting.getRollCallMain(argumentCollection="#Form#")>
  <cfset qgetRollCallGrapgh = Application.Reporting.getRollCallGrapgh(argumentCollection="#Form#")>
  <cfif not isdefined('msg') >
    <cfset res = [] >
    <cfset summary2 = [] >
    <cfset Seasonal = ArrayNew(1)>
    <cfset Resident = ArrayNew(1) >
    <cfset Transient = ArrayNew(1) >
    <cfloop from="1" to="12" index="i">
      <cfquery name="getSeentimes" dbtype="query" >
            SELECT count(Dolphin_ID) as times from qgetRollCallGrapgh where  SurveryMONTH = #i#
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
  
  <cfif not isdefined('msg') >
    <cfset summary2 = [] >
    
    <cfset resident_count =  0>
    <cfset seasonal_count =  0>
    <cfset transients_count =  0>
    
    <cfloop query="qgetRollCallGrapgh" >
      
   
	   <cfset count =  0>
       <cfquery name="q1" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapgh where Dolphin_ID = #qgetRollCallGrapgh.Dolphin_ID# AND SurveryMONTH IN (1,2,3)
            
       </cfquery>

       <cfif q1.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       

       <cfquery name="q2" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapgh where Dolphin_ID = #qgetRollCallGrapgh.Dolphin_ID# AND SurveryMONTH IN (4,5,6)
       </cfquery>
       
       <cfif q2.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>

       <cfquery name="q3" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapgh where Dolphin_ID = #qgetRollCallGrapgh.Dolphin_ID# AND SurveryMONTH IN (7,8,9)
       </cfquery>
       
       <cfif q3.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       
       
       <cfquery name="q4" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapgh where Dolphin_ID = #qgetRollCallGrapgh.Dolphin_ID# AND SurveryMONTH IN (10,11,12)
       </cfquery>
       
       <cfif q4.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif> 

       
       <cfif count EQ 1 >
       		<cfset transients_count = transients_count + 1 >
            <cfset tr = StructNew() >
            <cfset tr['ID'] = qgetRollCallGrapgh.Dolphin_ID >
            <cfset tr['Name'] = qgetRollCallGrapgh.Name >
            <cfset tr['Code'] = qgetRollCallGrapgh.Code >
            <cfset tr['Sex'] = qgetRollCallGrapgh.Sex >
            <cfset tr['Sighting_ID'] = qgetRollCallGrapgh.Sighting_ID >
            <cfset tr['pro_id'] = qgetRollCallGrapgh.pro_id >
            <cfset ArrayAppend(Transient,tr)>
       <cfelseif count EQ 3 OR count EQ 2 >
       		<cfset seasonal_count = seasonal_count + 1 >
            <cfset tt = StructNew() >
            <cfset tt['ID'] = qgetRollCallGrapgh.Dolphin_ID >
            <cfset tt['Name'] = qgetRollCallGrapgh.Name >
            <cfset tt['Code'] = qgetRollCallGrapgh.Code >
            <cfset tt['Sex'] = qgetRollCallGrapgh.Sex >
            <cfset tt['Sighting_ID'] = qgetRollCallGrapgh.Sighting_ID >
            <cfset tt['pro_id'] = qgetRollCallGrapgh.pro_id >
            <cfset ArrayAppend(Seasonal,tt)>
       <cfelseif count  EQ 4 >
       	    <cfset resident_count = resident_count + 1 >
             <cfset rr = StructNew() >
            <cfset rr['ID'] = qgetRollCallGrapgh.Dolphin_ID >
            <cfset rr['Name'] = qgetRollCallGrapgh.Name >
            <cfset rr['Code'] = qgetRollCallGrapgh.Code >
            <cfset rr['Sex'] = qgetRollCallGrapgh.Sex >
            <cfset rr['Sighting_ID'] = qgetRollCallGrapgh.Sighting_ID >
            <cfset rr['pro_id'] = qgetRollCallGrapgh.pro_id >
            <cfset ArrayAppend(Resident,rr)>    
       </cfif>

    </cfloop>
   
    
    	<cfset summary2 = [resident_count,seasonal_count,transients_count] >
    <cfelse>
    <cfset summary2 = [0,0,0] >
  </cfif>
  
</cfif>
<script>
    
    <cfoutput>
	    var #toScript(summary2, "summary2")#; 
        var #toScript(res, "res")#; 
		
		function checkForm() {
			if($("##fromYear").val() >  $("##toYear").val() ) {
				bootbox.alert('Start Year must be less and equal to End Year');
				return false;
				}
			}

		
		
    </cfoutput>
    
    </script>
	--->
<CFIF isdefined('FORM.NOAA') and FORM.NOAA EQ  "Download as Excel">
  <cfspreadsheet 
    	action="write" 
        filename="#Application.DirectoryRoot#Reports\NOAA\NOAA.xls" 
        overwrite="true"
        query="qGetTotalDolphinsAndSightings"
    >
  <cflocation url="/Reports/NOAA/NOAA.xls" addtoken="no">
</CFIF>
<!-- begin ##content -->

<div id="content" class="content">
  <!-- begin breadcrumb -->
  <ol class="breadcrumb pull-right">
    <li><a href="javascript:;">Reporting</a></li>
    <li><a href="javascript:;">NOAA Report</a></li>
  </ol>
  <!-- end breadcrumb -->
  <!-- begin page-header -->
  <h1 class="page-header">NOAA Report</h1>
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
            <form action="" method="POST">
            <div class="row">
              <div class="col-md-12">
                <h5>Date Range</h5>
                <div class="col-md-3">
                  <label>Start</label>
                  <!----- Date Picker----->
                  <div class="form-group">
                  <div id="datetimepicker1" class="input-group date col-lg-9 col-md-7 col-sm-12 col-xs-12">
                    <input type="text"  value='#application.Common.FormatDate(Date_from)#' name="Date_from"  placeholder="mm/dd/yyyy" class="form-control">
                    <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span> </div>
                </div>
                </div>
                <div class="col-md-3">
                  <label>End</label>
                  <div class="form-group">
                  <div id="datetimepicker2" class="input-group date col-lg-9 col-md-7 col-sm-12 col-xs-12">
                    <input type="text"  value='#application.Common.FormatDate(Date_to)#' name="Date_to"  placeholder="mm/dd/yyyy" class="form-control">
                    <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span> </div>
                </div>
                </div>
                <div class="col-md-3">
                </div>

                <div class="col-md-3" style="margin-bottom:-35px;margin-top:-27px">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin_sighted.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Total Sightings</div>
                                <div class="widget-stat-number"><cfif (stockSelected neq 0) OR (Date_to neq '' OR Date_from neq '')>#qGetTotalDolphinsAndSightings.RecordCount#<cfelse>0</cfif></div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                
              </div>
              </div>
            <div class="row">
              <div class="col-md-12">
                <h5>Stock</h5>
                <div class="col-md-3">
                  <select class="form-control" name="stockSelected" id="stockSelected" style="width:75%;">
                  	  <option value="0" selected="selected">-</option>
                  	<cfloop query="qGetTotalStock">
                      <option value="#qGetTotalStock.StockName#" <cfif qGetTotalStock.StockName eq stockSelected>selected</cfif>>#qGetTotalStock.StockName#</option>
                    </cfloop>
                  </select>
                </div>
                <div class="col-md-3" style="margin-top:-2.8%;">
                  <input type="submit" value="Submit" name="RollCall" class="btn btn-primary m-t-25" style="margin-bottom:10%;" />
                </div>
                
                <div class="col-md-3" style="margin-bottom:-35px;margin-top:-17px; margin-left:25%;">
                        <!-- begin widget -->
                        <div class="widget widget-stat bg-success text-white">
                            <div class="widget-stat-icon"><img src="#Application.superadminTemplateIncludes#img/dashboard-icons/dolphin.png" height="60" width="60"></div>
                            <div class="widget-stat-info">
                                <div class="widget-stat-title">Total dolphins</div>
                                <div class="widget-stat-number"><cfif (stockSelected neq 0) OR (Date_to neq '' OR Date_from neq '')>#qGetTotalDolphins.RecordCount#<cfelse>0</cfif></div>
                            </div>
                        </div>
                        <!-- end widget -->
                    </div>
                
              </div>
              </div>
            </form>
            <form name="NOAA" method="post" action="">
            <div class="row"> 
              <div class="col-md-3 m-l-20"> <br>
              </div>
               <div class="col-md-3 pull-right m-t-15">
                  <input type="submit" value="Download as Excel" name="NOAA" class="btn btn-sucess m-t-25" />
                </div> 
            </div>
            </form>
          </cfoutput>
          <!-- end col-md-6 -->
           <div class="row"> 
          <div class="col-md-12"> <br>
            <br>
            <div class="panel pagination-inverse m-b-0 clearfix">
              <table data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                <thead>
                  <tr class="inverse">
                    <th>Date</th>
                    <th>Stock</th>
                    <th>Field estimates</th>
                    <th>Photo estimates</th>
                    <th>Sighting number</th>
                  </tr>
                </thead>
                <tbody>
                 <cfif isdefined('qGetTotalDolphinsAndSightings') AND isdefined('qGetTotalDolphinsAndSightings.recordcount') AND qGetTotalDolphinsAndSightings.recordcount NEQ 0 >
                 	<cfset UniqueDate = qGetTotalDolphinsAndSightings.O_Date>
                    <cfset first = 1>
                    <cfoutput query="qGetTotalDolphinsAndSightings" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                     	<cfif UniqueDate neq qGetTotalDolphinsAndSightings.O_Date or first eq 1>
                        <cfset first = 0>
                        <cfset UniqueDate = qGetTotalDolphinsAndSightings.O_Date>
                        <cfquery name="SightningDetail" dbtype="query">
                        	Select * from qGetTotalDolphinsAndSightings Where qGetTotalDolphinsAndSightings.O_Date = <cfqueryparam cfsqltype="cf_sql_date" value="#UniqueDate#">
                        </cfquery>
                      <tr class="gradeU">
                        <td id="group_name"><a href="##collapse#qGetTotalDolphinsAndSightings.currentrow#" data-toggle="collapse" class="dataToggle" id="#qGetTotalDolphinsAndSightings.currentrow#">#Application.Common.FormatDate(qGetTotalDolphinsAndSightings.O_Date)#</a></td>
                        <td id="group_name">#qGetTotalDolphinsAndSightings.Stock#</td>
                        <td id="group_status"></td>
                        <td id="group_status"></td>
                        <td id="group_status">#qGetTotalDolphinsAndSightings.SightingNumber#</td>
                      </tr>
                      <tr id="collapse#qGetTotalDolphinsAndSightings.currentrow#" class="panel-collapse collapse" >
                        <td colspan="8"><div class="table-responsive">
                            <table class="table table-sm">
                              <thead>
                                <tr>
                                  <th>Sighting Id</th>
                                  <th>Dolphins Best</th>
                                  <th>Calves Best</th>
                                  <th>YoungOfYearBest</th>
                                  <th>Photo Dolphins Best</th>
                                  <th>Photo Calves Best</th>
                                  <th>Photo Final Best</th>
                                </tr>
                              </thead>
                              <tbody style="background-color: ##636A71;color: ##eceeef;">
                            
                               <cfif SightningDetail.recordcount NEQ 0 >
                                <cfloop query="SightningDetail">
                                  <tr>
                                    <th scope="row">#SightningDetail.ID#</th>
                                    <td>#SightningDetail.FE_TotalDolphin_Best#</td>
                                    <td>#SightningDetail.FE_TotalCalves_Best#</td>
                                    <td>#SightningDetail.FE_YoungOfYear_Best#</td>
                                    <td>#SightningDetail.Photo_TotalDolphins_FinalBest#</td>
                                    <td>#SightningDetail.Photo_TotalCalves_FinalBest#</td>
                                    <td>#SightningDetail.Photo_YoungOfYear_FinalBest#</td>
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
                      </cfif>
                    </cfoutput>
                  </cfif>
                </tbody>
              </table>
              <cfoutput>
              <form action="" method="post" name="paginationform">
                <input type="hidden" name="startHereIndex" value="1" />
                <input type="hidden" name="Date_from" value="#Date_from#" />
                <input type="hidden" name="Date_to" value="#Date_to#" />
                <input type="hidden" name="stockSelected" value="#stockSelected#" />
              </form>
              </cfoutput>
              <cfif isdefined('qGetTotalDolphinsAndSightings') AND isdefined('qGetTotalDolphinsAndSightings.recordcount') AND qGetTotalDolphinsAndSightings.recordcount NEQ 0 >
                <cfset qpagination = qGetTotalDolphinsAndSightings >
                <cfset noaaReport = true> 
                <cfinclude template="../pagination.cfm">
              </cfif>
            </div>
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

<div class="modal fade" id="seasonal">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Seasonal Resident Dolphins</h4>
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
            <!---<cfif ArrayLen(Seasonal) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(Seasonal)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#Seasonal[i].code#</td>
                    <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#Seasonal[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#Seasonal[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#Seasonal[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                   
                   
                    <td width="250">#Seasonal[i].name#</td>
                   <td width="50">#Seasonal[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>--->    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- Seasonal modal -->



<div class="modal fade" id="resident">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Resident Dolphins</h4>
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
            <!---<cfif ArrayLen(Resident) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(Resident)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#Resident[i].code#</td>
                   <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                        <input type="hidden" name="project_id" value="#Resident[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#Resident[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#Resident[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#Resident[i].name#</td>
                   <td width="50">#Resident[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>--->    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Resident modal -->


<div class="modal fade" id="transient">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Transients Resident Dolphins</h4>
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
            <!---<cfif ArrayLen(Transient) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(Transient)#" index="i">
            <cfoutput>
            
            	<tr>
                	<td width="80">#i#</td>
                   <td width="100">#Transient[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#Transient[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#Transient[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#Transient[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#Transient[i].name#</td>
                   <td width="50">#Transient[i].sex#</td>
                </tr>
              </cfoutput>  
            </cfloop>
            </cfif>--->    
        </table>
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Transients modal -->


<div class="modal fade" id="summary1">
  <div class="modal-dialog" role="document" style="width:55%">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id='month_title'></h4>
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
         <cfoutput>
         <table class="table table-striped table-bordered" id='tbl_row'>  

            
        		
            
  
        </table>
        </cfoutput>  
        </div>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!--  Transients modal -->

<style>
.datacontainer{
    height: 350px; 
    overflow:auto; 
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


</style>



