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
.table {
        display: block;
        overflow-x: auto;
    }

.table >tbody > tr > td{
	width:300px !important;}
.pagination-inverse{
	margin-bottom:20px !important;}
table.getReports tr td, table.getReports tr th {
    white-space: nowrap;
    vertical-align: middle;
}
</style>

<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page = 10>
<cfset today = now()>
<cfset arb = "">
<cfset selectedDate = "">
<cfset Hit=8>

<cfset Miss=4>
<!---<cfset getDissPosition="">--->
<cfset getDissPosition = Application.Reporting.getSampleDispositionReportDafault()>
<cfset getTotalBlubbers = Application.Reporting.getTotalBlubbers()>
<cfset getTotalskins = Application.Reporting.getTotalskins()>

<!------- Get  Submit Disposition Form -------->
<cfif isdefined("form.daterange")>
	<cfset getDissPosition = Application.Reporting.getSampleDispositionReportData("#Form#")>
    <cfset getTotalBlubbers = Application.Reporting.getBlubbers()>
    <cfset getTotalskins = Application.Reporting.getskins()>
   
 </cfif>

<!---Get Stock,sample Heading and date data ---->
<cfset getBiopsyData = Application.Reporting.getBiopsyData()>

<!------- Stock list--------->         
<cfset getStock = Application.Sighting.getStock()>

<!---Blubbers---->
<cfset BlubberTeflonVial   = getTotalBlubbers[1]>
<cfset BlubberCryovialRed  = getTotalBlubbers[2]>
<cfset BlubberCryovialBlue = getTotalBlubbers[3]>
<!---skins---->
<cfset getTotalSkinDMSO      = getTotalskins[1]>
<cfset getTotalSkinRNAlater  = getTotalskins[2]>
<cfset getTotalSkinDCryovial = getTotalskins[3]>

<script type="text/javascript">
    <cfoutput>
	 // var #toScript(Hit, "Hit")#;
	  var #toScript(BlubberTeflonVial,   "BlubberTeflonVial")#;
	  var #toScript(BlubberCryovialRed,  "BlubberCryovialRed")#;
	  var #toScript(BlubberCryovialBlue, "BlubberCryovialBlue")#;
	  
	  var #toScript(getTotalSkinDMSO, "getTotalSkinDMSO")#;
	  var #toScript(getTotalSkinRNAlater, "getTotalSkinRNAlater")#;
	  var #toScript(getTotalSkinDCryovial, "getTotalSkinDCryovial")#;
	  
    function formCall() {
      $("##frm1").submit();
    }
    </cfoutput>
    </script>

<!-- begin ##content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Reporting</a></li>
				<li><a href="javascript:;">Sample Disposition Report</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Sample Disposition Report</h1>
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
			                <h4 class="panel-title">Sample Disposition Report</h4>
			            </div>
			            <div class="panel-body">
                         <form action="" method="post" id="frm1">
                        <!-- start col-md-6 -->
                            <div class="col-md-6">
                            <div class="panel-option m-2">
                            <h5>Date Range</h5>
                            <cfoutput>
                            <div id="Date-range" class="input-group">
                                    <input  type="text" <cfif selectedDate eq ""> value="#DateFormat(CreateDate(year(today),1, 1), "mmmm d, yyyy")# - #DateFormat(CreateDate(year(today),month(today), 30), "mmmm d, yyyy")#"<cfelse> value="#selectedDate#"</cfif> class="form-control" name="daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                            </div>
                            </cfoutput>
			               <!-- end col-md-6 -->

                          <!-- start col-md-3 -->
                            <div class="col-md-3 ">
                            <div class="panel-option m-2">
                            <!---<div class="col-md-3 m-l-20"> <br>--->
                            <label>stock</label>
                           <select name="Stock" class="form-control">
                           <cfloop query="getStock">
                                <option class="stock_value" value="<cfoutput>#getStock.StockName#</cfoutput>"><cfoutput>#getStock.StockName#</cfoutput></option>
                            </cfloop>
                         </select>
                        <!---   </div>--->
                            </div>
                            </div>
			               <!-- end col-md-3 -->
                           <!-- start col-md-3 -->
                            <div class="col-md-3 ">
                            <div class="panel-option m-3">
                            <label>Sample Head </label>
                           <select name="samplehead" class="form-control">
                           <cfloop query="getBiopsyData">
                           <cfif getBiopsyData.Samplehead neq ""  or getBiopsyData.Samplehead eq "0">
                                <option class="stock_value" value="<cfoutput>#getBiopsyData.Samplehead#</cfoutput>"><cfif getBiopsyData.Samplehead eq "1" >M8</cfif><cfif getBiopsyData.Samplehead eq "2"> M11</cfif></option>
                                </cfif>
                            </cfloop>
                         </select>
                            </div>
                            <br>
                             <div class="col-md-3 pull-right m-t-15">
                          <input type="submit" value="Get Report"  onclick="formCall()"  name="dispositionReport" style="margin-left: -53px !important;" class="btn btn-sucess m-t-25">
                        </div>
                            </div>
                            </div>
			               <!-- end col-md-3 -->
                             <!-- Start col-md-3 -->
                           <!---<div class="col-md-3 ">
                           <div class="panel-option m-3">
                           <div class="col-md-3 pull-right m-t-15">
                          <input type="submit" value="Get Report" name="dispositionReport" class="btn btn-sucess m-t-25">
                        </div>  </div></div>--->
                           <!-- end col-md-3 -->  
                      </div>
			        </div>
			        <!-- end panel -->
			    </div>
                <!-- end row col-6 -->
               </form>
             <div class="row">
             <div class="col-lg-12 ">
              <div class="panel pagination-inverse m-b-0 clearfix BiopsyReports">
              <table data-order='[[1,"asc"]]' class="table table-bordered table-hover getReports">
                <thead>
                  <tr class="inverse">
                  <th><!---<cfoutput>#getTotalskins[1]#</cfoutput>--->Sampleing Heads</th>
                  
                    <!---<th>M8</th>
                    <th>M11 Smaple ID</th>--->
                    
                    
                    <th>Sample type</th>
                    <th>Disposition/Archive</th>
                  </tr>
                </thead>
                <tbody>
                <!---<cfoutput>
				<cfif #getDissPosition# neq "">
                </cfoutput>--->
                  <cfloop query="getDissPosition">
                  <cfset count = 1>
                  <tr class="gradeU">
                  <cfif getDissPosition.Sampleheading eq "1">
                        <td id="group_status">M8</td>
                      <cfelseif getDissPosition.Sampleheading eq "2">
                        <td id="group_status">M11</td>
                      <cfelse>
                          <td id="group_status">N/A</td>
                      </cfif>
                  
              <!---    <td id="group_name"><cfoutput>#count#</cfoutput></td>
                  <td id="group_name"><cfoutput>#getDissPosition.M11SmapleID#</cfoutput></td>--->
                  <td id="group_name">
                   <cfif getDissPosition.Sampletype neq "">
                     <cfoutput> #getDissPosition.Sampletype#</cfoutput>
                      <cfelse>
                      N/A  </cfif>
                      </td>
                  <td id="group_name"><cfoutput>#getDissPosition.DispositionArchive#</cfoutput></td>
                 </tr>
              <cfset count++>
                 </cfloop>
               <!---  </cfif>--->
                 </tbody>
              </table>
              </div>
               <cfoutput>
               
				<div class="row">
        			<!-- begin  col-6-->
                    <div class="col-lg-6">
                        <!-- begin panel -->
                        <div class="panel panel-inverse">
                            <div class="panel-heading">
                                <div class="panel-heading-btn">
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                                </div>
                                <h4 class="panel-title">Hits vs Misses</h4>
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

             		<!-- begin  col-6-->
                    <!---<div class="col-lg-6">
                        <!-- begin panel -->
                        <div class="panel panel-inverse">
                            <div class="panel-heading">
                                <div class="panel-heading-btn">
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                                </div>
                                <h4 class="panel-title">Hits Location</h4>
                            </div>
                            <div class="panel-body">
                            <div>
                                 <canvas id="pie-chart-loc"></canvas>
                                 <div id="legend-loc"></div>
    
                            </div>
    
                         </div>
                        </div>
                        <!-- end panel -->
                      </div>
                    --->
                	<!-- end  col-6 -->
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
                &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
            </div>
            <!-- end ##footer -->
		</div>
		<!-- end ##content -->
</cfoutput>