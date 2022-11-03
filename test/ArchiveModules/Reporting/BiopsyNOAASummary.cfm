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
<cfset Hit=8>
<cfset Miss=4>
<cfset BarHits=4>
<cfset BarMiss = 4>
<cfset HitDistancesixmeter = 2>
 <cfset getHitDistance  =[3,3,3,3]> 
 <cfset getMissDistance  =[2,2,2,2]> 

<cfset arb = "">
<cfset selectedDate = "">
<cfset getHitMiss = "">
<cfif isdefined('FORM.daterange')>
<cfset getHitMiss = Application.Reporting.getBiopsyNOAASummaryData("#Form#")>
<cfset getHitDistance = Application.Reporting.HitsDistance("#Form#")>
<cfset getMissDistance = Application.Reporting.MissDistance("#Form#")>
<!---<cfdump var="#getMissDistance#">
<cfabort>--->

<cfquery dbtype="query" name="CountTotaloutcomeHit">
SELECT count(Outcome) as hit from  getHitMiss where Outcome =1
</cfquery>
<cfquery dbtype="query" name="CountTotaloutcomeMiss">

SELECT count(Outcome) as miss from  getHitMiss where Outcome =0
</cfquery>

<cfset HitDistancesixmeter="#CountTotaloutcomeHit.hit#">
<cfset Hit="#CountTotaloutcomeHit.hit#">
<cfset miss="#CountTotaloutcomeMiss.miss#">
<cfset getHitDistance="#getHitDistance#">
<cfset getMissDistance="#getMissDistance#">
<cfdump var="#getHitDistance#">
<script type="text/javascript">
<cfoutput>
	    var #toScript(Hit, "Hit")#;
		var #toScript(Miss, "miss")#;
		var #toScript(BarMiss, "BarMiss")#;
		var #toScript(BarHits, "BarHits")#;
		var #toScript(getHitDistance, "getHitDistance")#;
		var #toScript(getMissDistance, "getMissDistance")#;
</cfoutput>
</script>
</cfif>

<!------- Stock list--------->         
<cfset getStock = Application.Sighting.getStock()>

<script type="text/javascript">
    <cfoutput>
	
	  var #toScript(Hit, "Hit")#;
	  var #toScript(Miss, "Miss")#;
	  var #toScript(BarHits, "BarHits")#;
	   var #toScript(BarMiss, "BarMiss")#;
	  var #toScript(HitDistancesixmeter, "HitDistancesixmeter")#;
	  var #toScript(getHitDistance, "getHitDistance")#;
	    var #toScript(getMissDistance, "getMissDistance")#;
	
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
				<li><a href="javascript:;">Biopsy NOAA Summary</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Biopsy NOAA Summary </h1>
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
			                <h4 class="panel-title">Biopsy NOAA Summary</h4>
			            </div>

			            <div class="panel-body">
                         <form action="" method="post" name="NOAASumary"  id="frm1">
                        <!-- start col-md-6 -->
                            <div class="col-md-6">
                            <div class="panel-option m-2">
                            <h5>Date Range</h5>
                            <cfoutput>
                            <div id="Date-range" class="input-group">
                                    <input type="text" <cfif selectedDate eq ""> value="#DateFormat(CreateDate(year(today),1, 1), "mmmm d, yyyy")# - #DateFormat(CreateDate(year(today),month(today), 30), "mmmm d, yyyy")#"<cfelse> value="#selectedDate#"</cfif> class="form-control" name="daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                            </div>
                            </cfoutput>
			               <!-- end col-md-6 -->

                          <!-- start col-md-6 -->
                            <div class="col-md-6 ">
                            <div class="panel-option m-2">
                            <!---<div class="col-md-3 m-l-20"> <br>--->
                            <label>stock</label>
                           <select name="Stock"   onchange="formCall()" class="form-control">
                           <cfloop query="getStock">
                                <option class="stock_value" value="<cfoutput>#getStock.StockName#</cfoutput>"><cfoutput>#getStock.StockName#</cfoutput></option>
                            </cfloop>
                         </select>
                        <!---   </div>--->
                            </div>
                            </div>
                            </div>
			               <!-- end col-md-6 -->
                      </div>
			        </div>
			        <!-- end panel -->
			    </div>
                <!-- end row col-6 -->
               </form>
             
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
             <div class="col-lg-6"> 
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> 
                <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Graph" value="Download_graph_jpg">
                <button  class="btn btn-xs btn-icon btn-circle btn-primary" type="submit" >J</button>
                </form>
                <form action="" method="POST" name="SubmitGraphForm" style="float:left;margin-right:8px;" target="_blank">
                <input type="hidden" name="Graph" value="Download_graph_pdf">
                <button  class="btn btn-xs btn-icon btn-circle btn-danger" type="submit" >P</button>
                </form>
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Dolphin Sightings Summary</h4>
              </div>
             
              <div class="panel-body">
                <div>
                  <canvas id="bar-chart"></canvas>
                  <div id="legend_bar_chart">
				  
				  <!---<ul class="legend_bar_chart"><li><span style="background-color:##00cc66">Hit</span></li><li><span style="background-color:##ff6666">Miss</span></li></ul>--->
                  
                  </div>
                </div>
              </div>
            </div>
            <!-- end panel -->
                      
            </div>
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