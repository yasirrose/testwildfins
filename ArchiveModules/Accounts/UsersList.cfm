
<cfset   getuserlist=Application.Accounts.getuserlist()>
<cfset getgrouplist=Application.Accounts.getgrouplist()>
<cfparam name="startHereIndex" default="1">
<cfparam name="form.groupId" default="0">
<cfif isdefined("form") and form.groupId NEQ 0>
<cfset   getuserlist=Application.Accounts.getuserbygroup(argumentCollection="#Form#")>
</cfif>


		<div id="content" class="content">
			<!-- begin breadcrumb -->
			 <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Home</a></li>
            <li><a href="javascript:;">User List</a></li>
	        </ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">User List </h1>
			<!-- end page-header -->

            <!-- begin section-container -->
            <div class="section-container section-with-top-border">
               <!-- <p class="m-b-20">
                    <b>DataTables</b> is a plug-in for the jQuery Javascript library.
                    It is a highly flexible tool, based upon the foundations of progressive enhancement,
                    and will add advanced interaction controls to any HTML table.
                </p>-->
                <!-- begin panel -->
                <div class="section-container  p-b-10">
           
                 <div class="row">
                    <!-- begin col-6 -->
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 container-title-box">
                     <cfoutput>
                        <form class="form-horizontal Search Critaria" action="" name="searchform" method="post">
                             <div class="form-group m-b-10">
                                <label class="col-lg-3 col-md-3 col-sm-4 col-xs-12 control-label text-left">Search Critaria</label>
                                <div class="col-lg-7 col-md-7 col-sm-5 col-xs-12">
                                    <select name="groupId" class="form-control">
                                      <option value="0">Select Group</option>
                                      <CFLOOP QUERY="getgrouplist">
                                      <OPTION value="#getgrouplist.id#" <cfif isdefined('form.groupId') and form.groupId EQ getgrouplist.id>selected</cfif> >#getgrouplist.group_name#</OPTION>
                                      </CFLOOP>
                                    </select>
                                </div>
                               <input type="hidden" name="startHereIndex" value="1" />
                                    
								<div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 btn-submit text-right">
                                 	<input type="submit" name="search" value="search"  class="btn btn-default text-center form-control">
								</div>
                            </div>

                         </form>
                      </cfoutput>
                     </div>
                   </div>
          
          
          <cfif getuserlist.recordcount NEQ 0> 

                    <table id="data-table" data-order='[[1,"asc"]]' class="table table-bordered table-hover panel">
                        <thead>
                            <tr class="inverse">
                    
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Email</th>
                                <th>User Type</th>
                                <th>User Status</th>
                                
                                <th>User Group</th>
                                <th data-sorting="disabled">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                         <cfoutput query="getuserlist" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                            <tr class="gradeU">
                                <td>#getuserlist.first_name#</td>
                                <td>#getuserlist.last_name#</td>
                                <td>#getuserlist.user_email#</td>
                                <td>#getuserlist.user_type#</td>
                                <td>#getuserlist.status#</td>
                             		<cfif len(getuserlist.group_id) LT 1> <cfset getuserlist.group_id=0> </cfif>
                                   <cfquery name="getgroupName" datasource="wildfins" >
                                     select group_name from groups where id = '#getuserlist.group_id#'
                                  </cfquery>
                                  <td>#getgroupName.group_name#</td>
                                <td>
                                <div class="col-md-3" style="display:inline-block">
                                <form action="#Application.superadmin#?ArchiveModule=Accounts&Page=EditUser&Archive" method="post">
                                <input type="hidden" name="userid" value="#getuserlist.user_id#">
                                <button class="btn btn-xs btn-primary update" type="submit"><i class="fa fa-pencil-square-o"></i></button>
                                </form>
                                </div>
                                <div class="col-md-3" style="display:inline-block">
                                
                                <button class="btn btn-xs btn-primary" onClick="deleteRecord(#getuserlist.user_id#)"><i class="glyphicon glyphicon-trash"></i></button>
                                </div>
                                
                                </td>
                            </tr>
                         </cfoutput>
                        </tbody>
                    </table>
                    
       <cfset qpagination = getuserlist >
     <cfinclude template="../pagination.cfm">                      
                    
  
<cfelse>  
  <div class="alert alert-danger">
  <strong>Alert!</strong> No record found.
  </div>

  </cfif>
   
                </div>
                <!-- end panel -->
            </div>
            <!-- end section-container -->

