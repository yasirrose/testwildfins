<cfparam name="startHereIndex" default="1">
<cfparam name="form.searchword" default="">
<cfparam name="form.id" default="10">
<cfset Application.record_per_page = 5>


 <cfset qgetTrackingList=Application.Stranding.getLCE_ten()>
 
<cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
<cfset   qgetTrackingList=Application.Stranding.getSearchedData(form.searchword)>
<cfdump var="#qgetTrackingList#" abort="true">
</cfif>
		<!-- begin #content -->
		<div id="content" class="content content-padding">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Stranding</a></li>
				<li><a href="javascript:;">Search</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Search List</h1>
			<!-- end page-header -->
		
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
                <div class="panel pagination-inverse m-b-0 clearfix table-overflow">
                    <table id="example" class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                                <th>Field Number</th>
                                <th>Stranding Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                      	<tbody>
                         <cfoutput query="qgetTrackingList">
                         	<tr class="inverse">
                                <td>test</td>
                                <td >test</td>
                                <td>
                                    Open
                                </td>
                            </tr>
                         </cfoutput>
                        </tbody>
                    </table>
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