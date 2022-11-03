<cfparam name="startHereIndex" default="1">
<cfset Application.record_per_page = 10>
<cfif isdefined('form.eStolen')>
<cfset eStolen = Form.eStolen>
<cfset geteStolen = Application.Reporting.geteStolenReports(eStolen="#Form#")>
<cfelse>
<cfset eStolen = "Q1">
<cfset geteStolen = Application.Reporting.geteStolenReports(param = 0)>
</cfif>

<cfif isdefined('form.eStolenExcel')>
<!---<cfdump var="#Form#">
<cfabort>--->


<cfset gExcelReport = Application.Reporting.geteStolenReportsExl(argumentCollection="#Form#")>
<cfset geteStolenEx = Application.Reporting.geteStolenReports(argumentCollection="#Form#")>
</cfif>

<!------- Stock list--------->         
<cfset getStock = Application.Sighting.getStock()>  
 
<!------- getType--------->  
<cfset getType=Application.Sighting.getType()>
 
<!------- getSubType--------->  
<cfset getSubType=Application.Sighting.getSubType()>

<!--- Extracting Survey area --->
<cfset getSurveyArea=Application.Sighting.getSurveyArea()>
<!-- begin ##content -->
		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">NCSG</a></li>
				<li><a href="javascript:;">NCSG Report</a></li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">NCSG Report </h1>
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
			                <h4 class="panel-title">Filters</h4>
			            </div>
			            <div class="panel-body">
                           
                      <div class="col-md-12">
	<!---<cfif isdefined('form.eStolenExcel')>
     <cfloop query="geteStolenEx">
 
     #geteStolenEx.Date# <br />
     #geteStolenEx.Code# <br />
     #geteStolenEx.Dolphin_ID#<br />
     </cfloop>
    </cfif>--->

            <div class="row"> 
            <form action="" method="POST">
              <div class="col-md-3 m-l-20"> <br>
                <label>Filter</label>
                <select class="form-control" name="eStolen">
                <option value="" selected>Select Filters</option>
                      <option value="Q1" <cfif eStolen eq "Q1">selected</cfif>><!---EStolen---->Q1</option>
                     <!--- <option value="Q1-234" <cfif eStolen eq "Q1-234">selected</cfif>>Q1</option>--->
                      <option value="Q2" <cfif eStolen eq "Q2">selected</cfif>>Q2</option>
                      <!---<option value="Q2-234" <cfif eStolen eq "Q2-234">selected</cfif>>Q2</option>--->
                      <option value="Q3" <cfif eStolen eq "Q3">selected</cfif>>Q3</option>
                      <!---<option value="Q3-234" <cfif eStolen eq "Q3-234">selected</cfif>>Q3</option>--->
                </select>
                 </div>
                 
                  <div class="col-md-3 m-l-20"> <br>
                <label>stock</label>
                <select name="Stock" class="form-control">
                <option value="" selected>Select Stock</option>
                <cfloop query="getStock">
  <option class="stock_value" value="<cfoutput>#getStock.StockName#</cfoutput>" <cfif isdefined("Form.Stock") AND  Form.Stock eq "#getStock.StockName#">selected</cfif>><cfoutput>#getStock.StockName#</cfoutput></option>
                     </cfloop>
                </select>
                 </div>
                 
                 <div class="col-md-3 m-l-20"> <br>
                <label>Type</label>
                <select name="MType" class="form-control">
                <option value="" selected>Select Type</option>
                   <cfloop query="getType">
                        <option class="area_value" value="<cfoutput>#getType.Type#</cfoutput>" <cfif isdefined("Form.MType") AND  Form.MType eq "#getType.Type#"> selected</cfif>><cfoutput>#getType.Type#</cfoutput></option>
                     </cfloop>
                </select>
                 </div>
                 
                 <div class="col-md-3 m-l-20"> <br>
                <label>Sub Type</label>
                <select name="SubType" class="form-control">
                <option value="" selected>Select Sub Type</option>
                   <cfloop query="getSubType">
                        <option class="area_value" value="<cfoutput>#getSubType.SubType#</cfoutput>" <cfif isdefined("Form.SubType") And Form.SubType eq "#getSubType.SubType#">selected</cfif>><cfoutput> #getSubType.SubType#</cfoutput></option>
                     </cfloop>
                </select>
                 </div>
                 
                 <div class="col-md-3 m-l-20"><br>
                <label>Area</label>
                <select name="SurveyArea" class="form-control">
                <option value="" selected>Select Area</option>
                   <cfloop query="getSurveyArea">
                 <option class="area_value" value="<cfoutput>#getSurveyArea.AreaName#</cfoutput>" <cfif isdefined("Form.SurveyArea") And Form.SurveyArea eq "#getSurveyArea.AreaName#">selected</cfif>> <cfoutput>#getSurveyArea.AreaName#</cfoutput></option>
                     </cfloop>
                </select>
                 </div>
                 <div class="col-md-3 m-l-20"> <br>
                 <label>Date Range</label>
                 <div id="Date-range" class="input-group ">
                                    <input type="text"  value="<cfoutput>#DateFormat(CreateDate(year(now()),1, 1), "mmmm d, yyyy")# - #DateFormat(CreateDate(year(now()),month(now()), 28), "mmmm d, yyyy")#</cfoutput>"  class="form-control" name="default_daterange">
                                    <span class="input-group-btn">
                                    	<button type="button" class="btn btn-primary"><i class="fa fa-calendar"></i></button>
                                    </span>
                                </div> 
                  </div>              
                                
                 </div>
                 <div class="col-md-2 pull-left m-t-15 style="margin-right: -76px !important;" ">
                  <input type="submit" value="Submit"  onClick="this.form.submit()" class="btn btn-primary m-t-25" />
                </div> 
                 
               <div class="col-md-3 pull-letf m-t-15">
                  <input type="submit" value="Download as Excel" name="eStolenExcel" class="btn btn-primary m-t-25" />
                </div> 
            </form>
            </div>    
			</div> 
            <cfif isdefined('eStolenExcel')>
            <cfset index = 0>
            <cfset qgetExcel = Application.Reporting.geteStolenReportsExl(argumentCollection="#Form#")>
            
      <!---   <cfdump var="#qgetExcel#">
          <cfabort>--->
          
          
          
          
          <!---<cfset array = qgetExcel.Split(",")>--->
          <!---<cfdump var="#array#">
          <cfabort>----->

			<!---< Create Spreadsheet object for Registrant --->
            <!---<cfset xlssRegistrant = SpreadsheetNew("Registrant",true) >
             <cfif index EQ 0>
            <cfset SpreadsheetAddRow(xlssRegistrant,"Code,#qgetExcel#")> 
            </cfif>
           <!--- <cfset SpreadsheetAddRows(xlssRegistrant, qgetExcel) >--->
            <cfheader name="Content-Disposition" value="attachment;filename=Q1-Report.xlsx">
            <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"  variable="#spreadSheetReadBinary(xlssRegistrant)#">--->
            <!---</cfloop>
            <cfset index++>
        --->
            <!--- Download spreadsheet in memory --->

  
  
            </cfif>  
                            
                            
                    <div class="row"> 
          <div class="col-md-12"> <br>
            <br>
            <div class="panel pagination-inverse m-b-0 clearfix">
              <table data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                <thead>
                  <tr class="inverse">
                    <th>Name</th>
                    <th>Code</th>
                    <th>Sex</th>
                    <th>Year Of Birth</th>
                    
                    
                   
                  </tr>
                </thead>
                <tbody>    
           <cfif geteStolen.recordcount GT 0 >
             <cfset count = 1>
          <cfoutput query="geteStolen" startrow="#startHereIndex#" maxrows="#Application.record_per_page#" group ="name">
                 <tr class="gradeU">
                 <td id="group_name">
                 <a href="##collapse_#count#" data-toggle="collapse" class="dataToggle" id="#count#">#geteStolen.Name#</a>
                 </td>
                        <td id="group_name">#geteStolen.Code#</td>
                        
                        <td id="group_status">#geteStolen.SEX#</td>
                        <td id="group_status">#geteStolen.YearOfBirth#</td>  
                      
                      </tr>  
                      <tr id="collapse_#count#" class="panel-collapse collapse" >
                        <td colspan="8"><div class="table-responsive">
                            <table class="table table-sm">
                              <thead>
                                <tr>
                                  <th>##</th>
                                  <th>Sighting ID</th>
                                  <th>Segment</th>
                                  <th>Date Seen</th>
                                  
                                </tr>
                              </thead>
                              <tbody style="background-color: ##636A71;color: ##eceeef;">
                     <cfset geteStolenList = Application.Reporting.geteStolenReportsList(dolphin_id="#geteStolen.Dolphin_ID#")>
                               <cfif geteStolenList.recordcount NEQ 0 >
                                <cfset cont = 1>
                                <cfloop query="geteStolenList">
                                
                                  <tr>
                                    <th scope="row">#cont#</th>
                                    <td>
                                    #geteStolenList.Sighting_ID#
                                    </td>
                                   
                                    <td>#geteStolenList.ZSEGMENT#</td>
                                    <td>
                                    <cfset date = geteStolenList.Date>
									#DateFormat(date, "d-mmm-yyyy")#  
                                   
                                    </td>
                                  </tr>
                                  <cfset cont++>
                                </cfloop>
                                   <cfelse>
                                  <tr>
                                    <td colspan="5">No Record Found.</td>
                                  </tr>
                                 </cfif>
                              </tbody>
                            </table>
                          </div>
                          </td>
                      </tr>
                      <cfset count++>  
                    
                    </cfoutput>
                 </cfif>
                </tbody>
              </table>
              <form action="" method="post" name="paginationform">
                <input type="hidden" name="startHereIndex" value="1" />
              </form>
              <cfif isdefined('geteStolen.recordcount') AND geteStolen.recordcount NEQ 0 >
                <cfset qpagination = geteStolen >
                <cfinclude template="../pagination.cfm">
              </cfif>
             
            </div>
          </div>
			</div>          
			            </div>
			        </div>
			        <!-- end panel -->
			    </div>
                <!-- end row col-6 -->
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
