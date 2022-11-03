 <cfparam name="startHereIndex" default="1">
 <cfset qgetNCSG = Application.Sighting.getNCSG()>

		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">NCSG</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">NCSG List
            <cfinclude template="SightingMenu.cfm"></h1>
			<!-- end page-header -->
                	 
            <!-- begin section-container -->
            <div class="section-container section-with-top-border">
                <!-- begin panel -->
                <div class="form-group">
                <div style="display:none" class="alert alert-success message">
                  <strong>Success!</strong> Dolphin Deleted.
                </div>
                </div>
                
                <div class="panel pagination-inverse m-b-0 clearfix">
                    <table id="example" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                                <th>Sr#</th>
                                <th>Date</th>
								<th>Totalhours</th>
                                <th>Record Observer</th>
                                <th>Boat Number</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                       <tbody>
                       		<cfoutput query="qgetNCSG" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                         	<tr class="inverse" id='remov_#ID#'>
                                <td>#qgetNCSG.currentRow#</td>
                                <td >#Date_Entered#</td>
                                <td >#Totalhours#</td>
                                <td >#record_observer#</td>
                                <td >#BoatNumber#</td>
								
							<td >
                                 <div style="display:inline-block" class="col-mad-6">
                                <form method="post" action="#Application.siteroot#?Module=Sighting&Page=NCSGFormEdit">
                                <input type="hidden" name="ID" value="#ID#"> 
                                <button type="submit" class="btn btn-xs btn-primary update"><i class="fa fa-pencil-square-o"></i></button></form></div>
                                <div style="display:inline-block" class="col-mad-6">
                        		 <button onclick="deleteRecord(#ID#)" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i>
                                </button>
                                </div>
                            </td>
                            </tr>
                         </cfoutput>
                      
                        </tbody>
                    </table>
  <form action="" method="post" name="paginationform">
<input type="hidden" name="startHereIndex" value="1" />
</form>
	<cfset qpagination = qgetNCSG >
     <cfinclude template="../pagination.cfm">       
    
                </div>
                <!-- end panel -->
            </div>
            <!-- end section-container -->
			<div class="footer" id="footer">
                <span class="pull-right">
                    <a data-click="scroll-top" class="btn-scroll-to-top" href="javascript:;">
                    	<i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
                    </a>	
                    </span>
                &copy; <cfoutput>#YEAR(NOW())#</cfoutput> <b>WildFins Admin</b> All Right Reserved
            </div>
		</div>
		<!-- end #content -->
