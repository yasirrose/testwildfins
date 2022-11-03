<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
<cfif isdefined('FORM.addZones')>
    <cfset qZonesInsert = Application.StaticData.ZonesInsert(argumentCollection="#Form#")>
    <cfif qZonesInsert.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>

<cfif isdefined('FORM.editZones')>
    <cfset qEditZones = Application.StaticData.EditZones(argumentCollection="#Form#")>
    <cfif qEditZones.recordcount eq 1>
    <cfelse>
    </cfif>
</cfif>
 <cfset qgetZones = Application.StaticData.getZones()>
 
  <cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<cfset   qgetZones=Application.StaticData.getZonesByword(form.searchword)>
</cfif>

		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">Zones</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Zones</h1>
			<!-- end page-header -->
			
                <cfif isdefined('qEditZones') and qEditZones.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Updated!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif> 
				   <cfif isdefined('qZonesInsert') and qZonesInsert.recordcount eq 1 >
                    <div class="alert alert-success fade in m-b-10" id="sucess-div">
                    <strong>Successfully Added!</strong>
                    <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
                    </div>
                 </cfif>
                 <div class="form-group">
                <div class="alert alert-success message" style="display:none">
                  <strong>Success!</strong> Zone Deleted.
                </div>
                </div>
			

            <div class="section-container section-with-top-border p-b-10">
			<div class="row">
                    <!-- begin col-6 -->
                    <div class="col-md-10">
                        <h5 class="m-t-0">Create Zone</h5>
                     <cfoutput>
                        <form class="form-horizontal" action="" name="add-zone" method="post">
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Zone Id</label>
                                <div class="col-md-7">
                      <input type="text" class="form-control" name="ZONE" id="ZONE" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Grid Id</label>
                                <div class="col-md-7">
               <input type="text" class="form-control" name="GRIDNUM" id="GRIDNUM"  required/>
                                </div>
                            </div>
                           <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Latitude</label>
                                <div class="col-md-7">
           <input type="text" class="form-control" name="LAT_DD" id="LAT_DD"  required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Longitude</label>
                                <div class="col-md-7">
             <input type="text" class="form-control" name="LONG_DD" id="LONG_DD" required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Easting</label>
                                <div class="col-md-7">
             <input type="text" class="form-control" name="EASTING" id="EASTING"  required/>
                                </div>
                            </div>
                            <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Northing</label>
                                <div class="col-md-7">
             <input type="text" class="form-control" name="NORTHING" id="NORTHING" required/>
                                </div>
                            </div>
                            <!---<div class="form-group m-b-10">
                                <label class="col-md-3 control-label">Segment</label>
                                <div class="col-md-7">
             <input type="text" class="form-control" name="SEGMENT" id="SEGMENT"  required/>
                                </div>
                            </div>--->
                             <div class="form-group m-b-10">
                                <label class="col-md-3 control-label">ZSegment</label>
                                <div class="col-md-7">
             <input type="text" class="form-control" name="ZSEGMENT" id="ZSEGMENT"  required/>
                                </div>
                            </div>
                            <div class="col-md-7 col-md-offset-3">
                         <input type="hidden" value="" id="zones_id" name="ID">
       <button type="submit" name="addZones" value ="submit" class="btn btn-success width-100 m-r-5" id="add">Submit</button>
                 <button class="btn btn-default width-100" type="reset">Cancel</button>
			</div>
                        </form>
                    </cfoutput>
                    </div>
                    <!-- end col-6 -->
                    <!-- begin col-6 -->

                </div>
                <!-- end row -->
		</div>

            <!-- begin section-container -->
            <div class="section-container section-with-top-border">
            
               <div class="form-group m-b-10" style="overflow: hidden;">
               	<div class="row col-md-3">
                   <form class="navbar-form form-input-flat" method="post" name="paginationform">
                   <div class="form-group">
                   <input type="text" name="searchword" class="form-control" 
                  value="<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0><cfoutput>#form.searchword#</cfoutput></cfif>" placeholder="search...">
                   <input type="hidden" name="startHereIndex" value="1" />
                   <button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
                   </div>
                   </form>
                   </div>
                 </div>
                 
                <!-- begin panel -->
                <div class="panel pagination-inverse m-b-0 clearfix">
                    <table id="example" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                               <th>Sr#</th>
                                <th>Zone ID</th>
                                <th>Grid ID</th>
                                <th>Latitude</th>
                                <th>Longitude</th>
                                <th>EASTING</th>
                                <th>NORTHING</th>
                                <th>ZSegment</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                       <tbody>
                      
                       
                       <cfoutput query="qgetZones" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                         	<tr class="inverse" id="remov_#ID#">
                                <td>#qgetZones.currentRow#</td>
                                <td id='ZONE-#ID#'>#ZONE#</td>
                                <td id='GRIDNUM-#ID#'>#GRIDNUM#</td>
                                <td id='LAT_DD-#ID#'>#LAT_DD#</td>
                                <td id='LONG_DD-#ID#'>#LONG_DD#</td>
                                <td id='EASTING-#ID#'>#EASTING#</td>
                                <td id='NORTHING-#ID#'>#NORTHING#</td>
                                <td id='ZSEGMENT-#ID#'>#ZSEGMENT#</td>
                                <td ><button class="btn btn-xs btn-primary update" onclick="updateRecord(#ID#)"><i class="fa fa-pencil-square-o"></i></button> &nbsp; &nbsp;&nbsp;&nbsp; <button class="btn btn-xs btn-primary" onclick="deleteRecord(#ID#)"><i class="glyphicon glyphicon-trash"></i></button></td>
                            </tr>
                         </cfoutput>
                       
                        </tbody>
                    </table>
                     
     <cfset qpagination = qgetZones >
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
