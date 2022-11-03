<cfparam name="startHereIndex" default="1">
<cfif isdefined('form.search') and len(trim(form.Dolphin_ID)) GT 0 >
<cfset qgeSDO = Application.Dolphin.getSDODolphin(argumentCollection="#Form#")>
</cfif>

<cfset getDolphinsCode = Application.Sighting.getDolphinsCode()>
		<!-- begin #content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li><a href="javascript:;">SDO </a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">SDO </h1>
			<!-- begin section-container -->
            <div class="section-container section-with-top-border">
             <div class="row col-md-12">
             <form role="form" method="post" class="form-inline" id="sdosearch">
             <div class="form-group">      
               <select class="form-control search-box" required name="Dolphin_ID" >
                  <option value="">Select Dolphin</option>
                  <cfoutput query="getDolphinsCode">
                    <option value="#getDolphinsCode.id#" <cfif isdefined('FORM.Dolphin_ID') and FORM.Dolphin_ID eq getDolphinsCode.id>selected</cfif>> #getDolphinsCode.Name# | #getDolphinsCode.code#</option>
                  </cfoutput>
                </select>
                </div>
                <div class="form-group"> 
                <input type="submit" class="btn btn-success" name="search" value="Submit">
                </div>
                </form>
                 </div>
                <!-- begin panel -->
                <div class="clearfix m-b-10"></div>
                <div class="form-group">
                <div class="alert alert-success message" style="display:none">
                  <strong>Success!</strong> Dolphin Deleted.
                </div>
                </div>
                
                <cfif isdefined('form.search') and len(trim(form.Dolphin_ID)) GT 0>
                <cfif qgeSDO.recordcount GT 0>
                <div class="panel pagination-inverse m-b-0 clearfix">
                    <table id="example" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                                <th>Sr#</th>
                                <th>Name</th>
								<th>PRES LOBO DATE</th>
                                <th>Lobo Confirmed</th>
                                <th>Recapture Date 1</th>
                                <th>HERAError</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                       <tbody>
                       		<cfoutput query="qgeSDO" startrow="#startHereIndex#" maxrows="10">
                         	<tr class="inverse" id="remov_#qgeSDO.ID#">
                                <td>#qgeSDO.currentRow#</td>
                                <td id='sdo-#qgeSDO.ID#'>#qgeSDO.Name#</td>
                                <td >#qgeSDO.PRES_LOBO_DATE#</td>
                                <td>#qgeSDO.Lobo_Confirmed#</td>
								<td>#qgeSDO.Recapture_Date_1#</td>
                                <td>#qgeSDO.HERAError#</td>
                                <td >
                                
                                  <div class="col-mad-6" style="display:inline-block">
                                <form action="#Application.superadmin#?Module=Dolphin&Page=SDOFormEdit" method="post">
                                <input type="hidden" value="#qgeSDO.ID#" name="ID" /> 
                                <button class="btn btn-xs btn-primary update" type="submit"><i class="fa fa-pencil-square-o"></i></button>
                                 </form> 
                                 </div>
                                <div class="col-mad-6" style="display:inline-block">
                         <button class="btn btn-xs btn-primary" onclick="deleteRecord(#qgeSDO.ID#)"><i class="glyphicon glyphicon-trash"></i>
                                </button>
                                </div>
                                
                                </td>
                            </tr>
                         </cfoutput>
                      
                        </tbody>
                    </table>
 
                </div>
                <!-- end panel -->
                <cfelse>
				<div class="mypagination">
   				No record found.</div>
				</cfif>
            	</cfif>
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
