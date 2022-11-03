
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
<cfset ReportStartyear = 2002>
<cfset ReportEndyear = year(now())>
<cfset from = ReportEndyear-1>
<cfparam name="FORM.fromYear" default="#ReportStartyear#">
<cfparam name="FORM.toYear" default="#year(now())#">

<cfset dtStart =  DateFormat(CreateDate(FORM.fromYear, 1, 1), "mmmm  yyyy")> 
<cfset dtEnd =  DateFormat(CreateDate(FORM.toYear, 12, 31), "mmmm  yyyy")> 

<cfset qCurrentMonthZones = Application.Reporting.CurrentMonthZones()>
<cfset qyearlyZones = Application.Reporting.yearlyZones(argumentCollection="#Form#")>
<script>
    
    <cfoutput>
	    var #toScript(qCurrentMonthZones, "qCurrentMonthZones")#;
		var #toScript(qyearlyZones, "qyearlyZones")#; 	
		var #toScript(dtStart, "dtStart")#; 	
		var #toScript(dtEnd, "dtEnd")#; 	
    </cfoutput>
    
	 console.log(qCurrentMonthZones);
	  console.log(qyearlyZones);

    </script>

<!-- begin ##content -->

<div id="content" class="content">
  <!-- begin breadcrumb -->
  <ol class="breadcrumb pull-right">
    <li><a href="javascript:;">Reporting</a></li>
    <li><a href="javascript:;">Zone Report</a></li>
  </ol>
  <!-- end breadcrumb -->
  <!-- begin page-header -->
  <h1 class="page-header">Zone Report</h1>
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
                
                
                
              </div>
              </div>
            </form>
            
      
    
         <div class="row">   
          <!-- begin  col-6-->
          <div class="col-lg-12"> <br>
            <br>
            <!-- begin panel -->
            <div class="panel panel-inverse">
              <div class="panel-heading">
                <div class="panel-heading-btn"> 
                
                
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a> 
                
                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a> <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a> </div>
                <h4 class="panel-title">Zone Report</h4>
              </div>
             
              <div class="panel-body" >
					<div id="container" style="height: 1500px; margin: 0 auto"></div>
                <!---  <div id="stacked-chart" style='width:30000px;height:450px;'></div>--->
                  
              </div>
            </div>
            <!-- end panel -->
                      
            </div>
          <!-- end  col-6 -->

          <!-- begin  col-6-->
          
          <!-- end  col-6 -->
           </div>
            
             <div class="row">   
               <!-- begin  col-6-->
			    <div class="col-lg-12">
			        <!-- begin panel -->
			        <div class="panel panel-inverse">
			            <div class="panel-heading">
                            <div class="panel-heading-btn">
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-lime" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                                <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                            </div>
			                <h4 class="panel-title">Current Month</h4>
			            </div>
			            <div class="panel-body">
                            <p class="m-b-15">
                               
                            </p>
                            <div>
                                <div id="currentmonthzones" style="min-width: 310px; height: 1500px; margin: 0 auto"></div>
                            </div>
            
             		 </div>
			        </div>
			        <!-- end panel -->
			  	  </div>
                <!-- end  col-6 -->
                
                  </div>
            
          </cfoutput>
          <!-- end col-md-6 -->
           
          
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



