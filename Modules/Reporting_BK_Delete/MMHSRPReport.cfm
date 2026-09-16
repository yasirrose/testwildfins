<cfset today = now()> 
<!------- Stock list--------->         
<cfset getStock = Application.Sighting.getStock()> 
<!------- Survey Type list--------->  
<cfset getType=Application.Sighting.getType()>
<!------- Sub Survey Type list---------> 
<cfset getSubType=Application.Sighting.getSubType()>
<!---  Survey area --->
<cfset getSurveyArea=Application.Sighting.getSurveyArea()>
 
<cfoutput>
<!-- begin ##content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">MMHSRP</a></li>
				<li><a href="javascript:;">MMHSRP Report</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">MMHSRP Report </h1>
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
			                <h4 class="panel-title">Filters </h4>
			            </div>
			            <div class="panel-body">
                       
                        <!-- start col-md-6 -->
                            <div class="col-md-6">
                            <div class="panel-option m-2">
                            <h5>Date Range</h5>
                            <div id="Date-range" class="input-group">
                                    <input type="text"  value="#DateFormat(CreateDate(year(today),1, 1), "mmmm d, yyyy")# - #DateFormat(CreateDate(year(today),month(today), 1), "mmmm d, yyyy")#" class="form-control" name="default-daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                            </div>
			               <!-- end col-md-6 -->
                           
                              <!-- start col-md-6 -->
                            <div class="col-md-6">
                            <div class="panel-option m-2">
                            <h5>Survey Type</h5>
                            	<div class="form-group">
                                <select class="form-control search-box" name="Type" >
                                    <option value="">Select  Type</option>
                                     <cfloop query="getType">
                                     <option value="#getType.Type#" >#getType.Type#</option>
                                   </cfloop>
                                </select>
                                </div>
                            </div>
                            </div>
			               <!-- end col-md-6 -->
                            
                            
                          <!-- start col-md-6 -->
                            <div class="col-md-6 ">
                            <div class="panel-option m-2">
                            <h5> Survey Sub  Type</h5>
                            	<div class="form-group">
                                   <select class="search-box form-control" name="SubType" >
                                   <option value="">Select Sub  Type</option>
                                   <cfloop query="getSubType">
                                        <option value="#getSubType.SubType#">#getSubType.SubType#</option>
                                     </cfloop>
                                   </select>
                                </div>
                            </div>
                            </div>
			               <!-- end col-md-6 -->
                           
                           
                           <!-- start col-md-6 -->
                            <div class="col-md-6">
                            <div class="panel-option m-2">
                            <h5>Survey Area</h5>
                            	<div class="form-group">
                                   <select class="search-box form-control" name="SurveyArea"  >
                                   <option value="">Select Area</option>
                                    <cfloop query="getSurveyArea">
                                        <option  value="#getSurveyArea.AreaName#" >#getSurveyArea.AreaName#</option>
                                     </cfloop>
                                    </select>
                                </div>
                            </div>
                            </div>
			               <!-- end col-md-6 -->
                           
                            <!-- start col-md-6 -->
                            <div class="col-md-6">
                            <div class="panel-option m-2">
                            <h5>Survey Stock</h5>
                            	<div class="form-group">
                                <select class="search-box form-control" name="Stock">
                                <option value="">Select stock</option>
                                <cfloop query="getStock">
                                <option class="stock_value" value="#getStock.StockName#">#getStock.StockName#</option>
                                 </cfloop>
                                </select> 
                                </div>
                            </div>
                            </div>
			               <!-- end col-md-6 -->
                            
                            
                            
			            </div>
			        </div>
			        <!-- end panel -->
			    </div>
                <!-- end row col-6 -->
             
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
			                <h4 class="panel-title">Summary</h4>
			            </div>
			            <div class="panel-body">
                            <p class="m-b-15">
                                A bar chart is a way of showing data as bars.
                                It is sometimes used to show trend data, and the comparison of multiple data sets side by side.
                            </p>
                            <div>
                                <canvas id="bar-chart"></canvas>
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
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
			                <h4 class="panel-title">Detail</h4>
			            </div>
			            <div class="panel-body">
            
            
            
             		 </div>
			        </div>
			        <!-- end panel -->
			  	  </div>
                <!-- end  col-6 -->
            
            
            
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