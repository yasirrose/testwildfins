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
<cfif isdefined('FORM.Arbalester')>
<cfset arb = FORM.Arbalester>
</cfif>
<cfif isdefined("form.DEFAULT_DATERANGE")>
	<cfset selectedDate = form.DEFAULT_DATERANGE >
</cfif>
<!------- Get  all Arbalesters
<cfset qgetResearchTeamMembers = Application.StaticData.getResearchTeamMembers()>
<cfset getArbalester = Application.Sighting.getArbalesters()>-------->


<!----- get data on page load in tabuler view------>
<cfset qgetdolphin = "">
<cfset getBiopsyCatalog = Application.Reporting.getDataBiopsyCatalog()>
<cfif isdefined('form.biopsyExcel')>
	<cfinclude template="pdf.cfm">
</cfif>


<script type="text/javascript">
	<cfoutput>
		function formCall() {
			$("##frm1").submit();
		}
	</cfoutput>
</script>


<cfoutput>
<!-- begin ##content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Reporting</a></li>
				<li><a href="javascript:;">Biopsy Calalog Report</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Biopsy Catalog Report</h1>
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
			                <h4 class="panel-title">Biopsy Catalog Report</h4>
			            </div>

			            <div class="panel-body">
                         <form action="" method="post" id="frm1">
                        <!-- start col-md-6 -->
                            <div class="col-md-6">
                            <div class="panel-option m-2">
                            <h5>Date Range</h5>
                            <div id="Date-range" class="input-group">
                                    <input type="text" <cfif selectedDate eq ""> value="#DateFormat(CreateDate(year(today),1, 1), "mmmm d, yyyy")# - #DateFormat(CreateDate(year(today),month(today), 1), "mmmm d, yyyy")#"<cfelse> value="#selectedDate#"</cfif> class="form-control" name="default_daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div>
                            </div>
                            </div>
			               <!-- end col-md-6 -->

                          <!-- start col-md-6 -->
                            <!---<div class="col-md-6 ">
                            <div class="panel-option m-2">
                            <h5>Arbalester</h5>
                            	<div class="form-group">
                                   <select class="search-box form-control" name="Arbalester" onchange="formCall()" >
                                   <option value="">Select Arbalester</option>
                                   <cfloop query="qgetResearchTeamMembers">
                                        <option value="#qgetResearchTeamMembers.RT_ID#" <cfif arb eq qgetResearchTeamMembers.RT_ID> selected </cfif> >#qgetResearchTeamMembers.RT_MemberName#</option>
                                     </cfloop>
                                   </select>
                                </div>
                            </div>
                            </div>--->
			               <!-- end col-md-6 -->


                    <div class="col-md-12">
                      <input type="submit" value="Download as PDF" name="biopsyExcel" class="btn btn-sucess m-t-25" />
                    </div>

			        </div>

			        </div>
			        <!-- end panel -->

			    </div>
                <!-- end row col-6 -->
               </form>
               <div class="panel pagination-inverse m-b-0 clearfix BiopsyReports">
              <table data-order='[[1,"asc"]]' class="table table-bordered table-hover getReports">
                <thead>
                  <tr class="inverse">
                    <th>Sample Date</th>
                    <th>Dolphin name</th>
                    <th>Code</th>
                    <th>Fin</th>
                    
                  </tr>
                </thead>
                <tbody>
                </cfoutput>
				<cfif getBiopsyCatalog.recordcount GT 0 >
					<cfset count = 1>
                    <cfoutput query="getBiopsyCatalog" startrow="#startHereIndex#" maxrows="#Application.record_per_page#">
                    
                    <cfset qgetdolphin = Application.Reporting.getdolphinfin(getBiopsyCatalog.ID)>
    				<cfloop query='qgetdolphin'>
                    	<cfset  Fin  = '#Application.CloudRoot#no-image.jpg'>
						<cfif qgetdolphin.DATESEEN NEQ ''>
                            <cfif DAY(DATESEEN) lt 10 >
                                <cfset dayy = '0#DAY(DATESEEN)#'>
                            <cfelse>
                                <cfset dayy  = DAY(DATESEEN)>  
                            </cfif>
                            
                            <cfif MONTH(DATESEEN) lt 10 >
                                <cfset monthh = '0#MONTH(DATESEEN)#'>
                            <cfelse>
                                <cfset monthh  = MONTH(DATESEEN)>  
                            </cfif>
                            
                           <!--- <cfoutput>#dayy#</cfoutput>--->
                            <cfset Fin_Left = '#getBiopsyCatalog.Code#(L) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
                            <cfset Fin_Right = '#getBiopsyCatalog.Code#(R) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
                            
                        <!---    <cfoutput>#Application.CloudDirectory##Fin_Left#</cfoutput> <br>
                            <cfoutput>#Application.CloudDirectory##Fin_Right#</cfoutput>--->
                            
                            <cfif FileExists('#Application.CloudDirectory##Fin_Left#')>
                                <cfset  Fin = '#Application.CloudRoot##Fin_Left#'>
                                <cfbreak>
                            <cfelseif FileExists('#Application.CloudDirectory##Fin_Right#')>
                                <cfset  Fin  = '#Application.CloudRoot##Fin_Right#'>
                                <cfbreak>
                            </cfif>	
                         </cfif>                       
                        </cfloop>
                                              
                    
                    <tr class="gradeU">
                        <td id="group_name">
                        <cfset newDate = DateFormat(getBiopsyCatalog.Date, "yyyy-mm-dd")>
                        <a href="javascript:void(0)" data-toggle="collapse" class="dataToggle" id="#count#">#newDate#</a>
                        </td>
                        <td id="group_name">#getBiopsyCatalog.Name#</td>
                        <td id="group_status">#getBiopsyCatalog.Code#</td>
                        <td id="group_status">
                        	<img src='#Fin#' width="80" height="80" id="imageresource"/>
                        </td>
                    
                    <cfset count++>
                    
                    </cfoutput>
                </cfif>
                </tbody>
              </table>
              </div>
               <cfoutput>

				

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