<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">

<cfif isdefined('FORM.addMapSetting')>
    <!--- <cfdump var="test"abort="true"> --->
   <cfset qInsertSightingMap = Application.StaticDataNew.SightingMapInsert(argumentCollection="#Form#")>
   <!--- <cfif qInsertDescription.recordcount eq 1>
      <cfelse>
   </cfif> --->
</cfif>

 
<cfif isdefined('FORM.editMapSetting')>
<cfset qEditSightingMap = Application.StaticDataNew.EditSightingMap(argumentCollection="#Form#")>
<cfif qEditSightingMap.recordcount eq 1>
   <cfelse>
</cfif>
</cfif>

<!--- okkkkk --->
<cfset qgetSightingMap = Application.StaticDataNew.getSightingMapData()>
<!--- <cfdump var="#qgetDescription#">
<cfabort>
 --->
<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<cfset qgetDescription =Application.StaticDataNew.getDescriptionByword(form.searchword)>
</cfif> 
<!-- begin #content -->
<div id="content" class="content">
   <!-- begin breadcrumb -->
   <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Home</a></li>
      <li><a href="javascript:;">SightingMap</a></li>
   </ol>
   <!-- end breadcrumb -->
   <!-- begin page-header -->
   <h1 class="page-header">Sighting Map</h1>
   <!-- end page-header -->
   <cfif isdefined('qEditSightingMap') and qEditSightingMap.recordcount eq 1 >
   <div class="alert alert-success fade in m-b-10" id="sucess-div">
      <strong>Successfully Updated!</strong>
      <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
   </div>
   </cfif> 
   <cfif isdefined('qInsertSightingMap') and qInsertSightingMap.recordcount eq 1 >
   <div class="alert alert-success fade in m-b-10" id="sucess-div">
      <strong>Successfully Added!</strong>
      <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
   </div>
   </cfif>
   <div class="section-container section-with-top-border p-b-10">
      <div class="row">
         <!-- begin col-6 -->
         <div class="col-md-10">
            <h5 class="m-t-0">Map Setting</h5>
            <cfoutput>
               <form class="form-horizontal" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" name="add-camara" method="post">
                  <div class="form-group m-b-10">
                     <label class="col-md-3 control-label">Latitude</label>
                     <div class="col-md-7">
                        <input type="hidden" name="ID" value='' id="latitude_id" />
                        <input type="text" value="#qgetSightingMap.lat#" class="form-control" name="latitude" id="latitude" placeholder="Please input latitude" required/>
                     </div>
                  </div>
                  <div class="form-group m-b-10">
                     <label class="col-md-3 control-label">Longitude</label>
                     <div class="col-md-7">
                        <input type="hidden" name="IDd" value='' id="longitude_id" />
                        <input type="text" value="#qgetSightingMap.lng#" class="form-control" name="longitude" id="longitude" placeholder="Please input longitude" required/>
                     </div>
                  </div>
                  <div class="form-group m-b-10">
                     <label class="col-md-3 control-label">Map Zoom</label>
                     <div class="col-md-7">
                        <input type="hidden" name="IDa" value='' id="mapZoom_id" />
                        <input type="text" value="#qgetSightingMap.mapZoom#" class="form-control" name="mapZoom" id="mapZoom" placeholder="Please input mapZoom" required/>
                     </div>
                  </div>
                  <div id="menu" style="margin-left: 270px;">
                    <input id="satellite-v9" name="mapStyle" type="radio" value="satellite-v9" <cfif qgetSightingMap.mapStyle eq 'satellite-v9'>checked="checked"</cfif>>
                    <label class="map-label" for="satellite-v9">Satellite</label>
                    <input id="light-v10" name="mapStyle" class="ml-2" type="radio" value="light-v10" <cfif qgetSightingMap.mapStyle eq 'light-v10'>checked="checked"</cfif>>
                    <label class="map-label" for="light-v10"></label>Light</label>
                    <input id="dark-v10" name="mapStyle" type="radio" class="ml-2" value="dark-v10" <cfif qgetSightingMap.mapStyle eq 'dark-v10'>checked="checked"</cfif>>
                    <label class="map-label" for="dark-v10">Dark</label>
                    <input id="outdoors-v11" name="mapStyle" type="radio" class="ml-2" value="outdoors-v11" <cfif qgetSightingMap.mapStyle eq 'outdoors-v11'>checked="checked"</cfif>>
                    <label class="map-label" for="outdoors-v11">Outdoors</label>
                    <input id="heat-map" name="mapStyle" type="radio" class="ml-2" value="light-vv10" <cfif qgetSightingMap.mapStyle eq 'light-vv10'>checked="checked"</cfif>>
                    <label class="map-label" for="heat-map">Heat Map</label>
                    <LanguageSwitcher class="spotter-lang-select" />
                </div>
                  <!--- <div class="form-group m-b-10">
                     <label class="col-md-3 control-label">Status</label>
                     <div class="col-md-7">
                        <select class="form-control" name="active" id="active">
                           <option value="1">Active</option>
                           <option value="0">Inactive</option>
                        </select>
                     </div>
                  </div> --->
                  <div class="col-md-7 col-md-offset-3">
                    <!--- <button type="submit" name="addMapSetting" value ="submit" class="btn btn-success width-100 m-r-5" id="addMapSetting">Update</button> --->
                    <button type="submit" name="editMapSetting" value ="submit" class="btn btn-success width-100 m-r-5" id="editMapSetting">Update</button>
                    <button class="btn btn-default width-100" type='reset'>Cancel</button>
                  </div>
               </form>
            </cfoutput>
         </div>
         <!-- end col-6 -->
         <!-- begin col-6 -->
      </div>
      <!-- end row -->
   </div>
   <!--- <div class="form-group">
      <div class="alert alert-success message" style="display:none">
         <strong>Success!</strong> Deleted!.
      </div>
   </div> --->
   <!-- begin section-container -->
   <!--- <div class="section-container section-with-top-border">
      <div class="form-group m-b-10" style="overflow: hidden;">
         <div class="row col-md-3">
            <form class="navbar-form form-input-flat" method="post" name="paginationform">
               <div class="form-group">
                  <input type="text" name="searchword" class="form-control" 
                  value="<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
                  <cfoutput>#form.searchword#</cfoutput>
                  </cfif>" placeholder="search...">
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
                  <th>Latitude</th>
                  <th>Longitude</th>
                  <th>Map Zoom</th>
                  <th>Actions</th>
               </tr>
            </thead>
            <tbody>
               <cfoutput query="qgetSightingMap" >
                  <tr class="inverse" id="remov_#ID#">
                     <td >#qgetSightingMap.id#</td>
                     <td id='lat-#id#'>#qgetSightingMap.lat#</td>
                     <td id='lng-#id#'>#qgetSightingMap.lng#</td>
                     <td id='mapzoom-#id#'>#qgetSightingMap.mapZoom#</td>
               
                     <td >
                        <button class="btn btn-xs btn-primary update" onclick="updateRecord(#ID#)"><i class="fa fa-pencil-square-o"></i></button> &nbsp; &nbsp;&nbsp;&nbsp; <button class="btn btn-xs btn-primary" onclick="return deleteRecord(#ID#)"><i class="glyphicon glyphicon-trash"></i></button>
                     </td>
                  </tr>
               </cfoutput>
            </tbody>
         </table>
         <!--- <cfset qpagination = qgetDescription> --->
         <!--- <cfinclude template="../pagination.cfm"> --->
      </div>
      <!-- end panel -->
   </div> --->
   <!-- end section-container -->
   <div class="footer" id="footer">
      <span class="pull-right">
      <!--- <a data-click="scroll-top" class="btn-scroll-to-top" href="javascript:;">
      <i class="fa fa-arrow-up"></i> <span class="hidden-xs">Back to Top</span>
      </a>	 --->
      </span>
      &copy; 
      <cfoutput>#YEAR(NOW())#</cfoutput>
      <b>WildFins Admin</b> All Right Reserved
   </div>
</div>
<!-- end #content -->