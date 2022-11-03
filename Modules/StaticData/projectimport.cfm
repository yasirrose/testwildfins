<cfset showForm = true>
<cfset counter = 0>
<cfset missing=''>
<cfif structKeyExists(form, "xlsfile") and len(form.xlsfile)>
<!--- Destination outside of web root --->
    <cffile action="upload" destination="#Application.CloudDirectory#" filefield="xlsfile" result="upload" nameconflict="makeunique">
    <cfif upload.fileWasSaved>
        <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
        <cfif right(theFile,3) eq 'xls' or right(theFile,4) eq 'xlsx'>
            <cfspreadsheet action="read" src="#theFile#" query="exceldata" headerrow="1">
            <cfset showForm = false>
        <cfelse>
            <cfset errors = "The file was not an Excel file.">
            <cffile action="delete" file="#theFile#">
        </cfif>
    <cfelse>
        <cfset errors="the file was not uploaded successfully">
    </cfif>
</cfif>
<cfif showForm>
    <cfif structKeyExists(variables, "errors")>
        <cfoutput>
            <p>
            <b style="text-align: center;">Error: #variables.errors#</b>
        </p>
        </cfoutput>
    </cfif>
    <form action="" enctype="multipart/form-data" method="post" style="margin-left: 300px">
        <div class="form-group">
            <label for=""> Upload Utility </label>
            <input id="upload-utility-4" class="file-loading" type="file"  name="xlsfile"  required>
        </div>
        <br>
        <div class="form-group">
            <input type="submit" class="btn btn-success" value="Upload XLS File">
        </div>
    </form>
    <br>
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-8">
                <div class="download-butns-custom">
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" data-target="#myModal" id="excelval">Export to Excel</button>
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" id="exceltmp" data-target="#myModal">Download Template</button>
                    <button type="button" style="margin-left: 300px" class="btn btn-primary btn-md" data-toggle="modal" id="exceldel" data-target="#myModal">Delete Data</button>
                </div>
            </div>

            <div class="col-md-4">
            </div>
            <div class="col-md-4">

            </div>
        </div>
    </div>

    <br>
<cfelse>
    <cfif exceldata.recordCount is 1>
        <p>no recrod</p>
    <cfelse>
        <cftry>
        	<cfquery name="qTurnOnInsert" datasource="#Application.dsn#">
                SET IDENTITY_INSERT PROJECTS ON
            </cfquery>
            <cfloop query="exceldata" startrow="2">
                <cfif  #Date# eq ''>
                    <cfset missing = ' Date'>
                    <cfset counter = 2>
                    <cfbreak>
                </cfif>
               <cfif isdefined("exceldata.SurveyArea")>
               		<cfset body_of_water = exceldata.SurveyArea>
               <cfelseif isdefined("exceldata.BodyOfWater")> 
               		<cfset body_of_water = exceldata.bodyofwater>
               <cfelse>
               		<cfset body_of_water = "">
               </cfif>
               <cfif isdefined("exceldata.Stock")>
               		<cfset NOAAStock = exceldata.Stock>
               <cfelseif isdefined("exceldata.NOAAStock")> 
               		<cfset NOAAStock = exceldata.NOAAStock>
               <cfelse>
               		<cfset NOAAStock = "">
               </cfif>
               
			   <cfif exceldata.BeginZoneID NEQ 0 and exceldata.BeginZoneID NEQ ''>
               		<cfset   BeginZoneIDD =Application.StaticData.getZoneByName(exceldata.BeginZoneID)>
               <cfelse>
               		<cfset   BeginZoneIDD = 0>     
               </cfif>
               <cfif exceldata.EndZoneID NEQ 0 and exceldata.EndZoneID NEQ ''>
               		<cfset   EndZoneIDD   =Application.StaticData.getZoneByName(exceldata.EndZoneID)>
               <cfelse>
               		<cfset   EndZoneIDD = 0> 
               </cfif>
			   
			   <cfif exceldata.BR_BeginZoneID NEQ 0 and exceldata.BR_BeginZoneID NEQ ''>
               		<cfset   BR_BeginZoneIDD =Application.StaticData.getZoneByName(exceldata.BR_BeginZoneID)>
               <cfelse>
               		<cfset   BR_BeginZoneIDD = 0>
               </cfif>
               <cfif exceldata.BR_EndZoneID NEQ 0 and exceldata.BR_EndZoneID NEQ ''>
               		<cfset   BR_EndZoneIDD   =Application.StaticData.getZoneByName(exceldata.BR_EndZoneID)>
               <cfelse>
               		<cfset   BR_EndZoneIDD = 0>
               </cfif>
               
               <cfif exceldata.IR_BeginZoneID NEQ 0 and exceldata.IR_BeginZoneID NEQ ''>
               		<cfset   IR_BeginZoneIDD =Application.StaticData.getZoneByName(exceldata.IR_BeginZoneID)>
               <cfelse>
               		<cfset   IR_BeginZoneIDD = 0>
               </cfif>
               <cfif exceldata.IR_EndZoneID NEQ 0 and exceldata.IR_EndZoneID NEQ ''>
               		<cfset   IR_EndZoneIDD   =Application.StaticData.getZoneByName(exceldata.IR_EndZoneID)>
               <cfelse>
               		<cfset   IR_EndZoneIDD = 0>
               </cfif>
               
               <cfif exceldata.ML_BeginZoneID NEQ 0 and exceldata.ML_BeginZoneID NEQ ''>
               		<cfset   ML_BeginZoneIDD =Application.StaticData.getZoneByName(exceldata.ML_BeginZoneID)>
               <cfelse>
               		<cfset   ML_BeginZoneIDD = 0>
               </cfif>
               <cfif exceldata.ML_EndZoneID NEQ 0 and exceldata.ML_EndZoneID NEQ ''>
               		<cfset   ML_EndZoneIDD   =Application.StaticData.getZoneByName(exceldata.ML_EndZoneID)>
               <cfelse>
               		<cfset   ML_EndZoneIDD = 0>
               </cfif>
               
               <cfif exceldata.SLP_BeginZoneID NEQ 0 and exceldata.SLP_BeginZoneID NEQ ''>
               		<cfset   SLP_BeginZoneIDD =Application.StaticData.getZoneByName(exceldata.SLP_BeginZoneID)>
               <cfelse>
               		<cfset   SLP_BeginZoneIDD = 0>
               </cfif>
               <cfif exceldata.SLP_EndZoneID NEQ 0 and exceldata.SLP_EndZoneID NEQ ''>
               		<cfset   SLP_EndZoneIDD   =Application.StaticData.getZoneByName(exceldata.SLP_EndZoneID)>
               <cfelse>
               		<cfset   SLP_EndZoneIDD = 0>
               </cfif>
               
               <cfif exceldata.ATL_BeginZoneID NEQ 0 and exceldata.ATL_BeginZoneID NEQ ''>
               		<cfset   ATL_BeginZoneIDD =Application.StaticData.getZoneByName(exceldata.ATL_BeginZoneID)>
               <cfelse>
               		<cfset   ATL_BeginZoneIDD = 0>
               </cfif>
               <cfif exceldata.ATL_EndZoneID NEQ 0 and exceldata.ATL_EndZoneID NEQ ''>
               		<cfset   ATL_EndZoneIDD   =Application.StaticData.getZoneByName(exceldata.ATL_EndZoneID)>
               <cfelse>
               		<cfset   ATL_EndZoneIDD = 0>
               </cfif>
               <cfset Historical_Survey_Time       		= exceldata['Historical Survey Time'][currentRow]>
                         
               <cfquery datasource="#Application.dsn#" name="insertproject" result="insert">
                    insert into PROJECTS(
                    ID,Date,SurveyStartTime,SurveyEndTime,StartTime,EndTime,[Historical Survey Time],Platform,ResearchTeam,
                    Squad,SurveyArea,TotalDistance,SurveyDistance,BeginZoneID,EndZoneID<!---,SurveyType--->,BR_BeginZoneID,
                    BR_EndZoneID,IR_BeginZoneID,IR_EndZoneID,ML_BeginZoneID,ML_EndZoneID,SLP_BeginZoneID,SLP_EndZoneID,ATL_BeginZoneID,
                    ATL_EndZoneID,EnteredBy,Stock,Summary,FundingSource,SubType,Type,Route,tempntbid
                    )
                    values(
                          <cfqueryparam value='#ID#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.ID   EQ "", true, false)#'>,
                          <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Date#">,
                          <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SurveyStartTime#" null='#IIF(exceldata.SurveyStartTime   EQ "", true, false)#'>,
                          <cfqueryparam cfsqltype="cf_sql_timestamp" value="#SurveyEndTime#" null='#IIF(exceldata.SurveyEndTime   EQ "", true, false)#'>,
                          <cfqueryparam cfsqltype="cf_sql_timestamp" value="#StartTime#" null='#IIF(exceldata.StartTime   EQ "", true, false)#'>,
                          <cfqueryparam cfsqltype="cf_sql_timestamp" value="#EndTime#" null='#IIF(exceldata.EndTime   EQ "", true, false)#'>,
                          <!---1,--->
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#Historical_Survey_Time#" null='#IIF(Historical_Survey_Time EQ "", true, false)#'>,
                          <cfqueryparam value='#Platform#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Platform   EQ "", true, false)#'>,
                          <cfqueryparam value='#ResearchTeam#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.ResearchTeam   EQ "", true, false)#'>,
                          <cfqueryparam value='#Squad#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Squad   EQ "", true, false)#'>,
                          <cfqueryparam value='#body_of_water#' cfsqltype="cf_sql_varchar" null='#IIF(body_of_water   EQ "", true, false)#'>,
                          <cfqueryparam value='#TotalDistance#' cfsqltype="cf_sql_float" null='#IIF(exceldata.TotalDistance   EQ "", true, false)#'>,
                          <cfqueryparam value='#SurveyDistance#' cfsqltype="cf_sql_float" null='#IIF(exceldata.SurveyDistance   EQ "", true, false)#'>,
                          <cfqueryparam value='#BeginZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(BeginZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#EndZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(EndZoneIDD   EQ "", true, false)#'>,
                          <!---<cfqueryparam value='#SurveyType#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.SurveyType   EQ "", true, false)#'>,--->
                          <cfqueryparam value='#BR_BeginZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(BR_BeginZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#BR_EndZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(BR_EndZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#IR_BeginZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(IR_BeginZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#IR_EndZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(IR_EndZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#ML_BeginZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(ML_BeginZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#ML_EndZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(ML_EndZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#SLP_BeginZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(SLP_BeginZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#SLP_EndZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(SLP_EndZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#ATL_BeginZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(ATL_BeginZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#ATL_EndZoneIDD#' cfsqltype="cf_sql_integer" null='#IIF(ATL_EndZoneIDD   EQ "", true, false)#'>,
                          <cfqueryparam value='#EnteredBy#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.EnteredBy   EQ "", true, false)#'>,
                          <cfqueryparam value='#NOAAStock#' cfsqltype="cf_sql_varchar" null='#IIF(NOAAStock   EQ "", true, false)#'>,
                          <cfqueryparam value='#Summary#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Summary   EQ "", true, false)#'>,
                          <cfqueryparam value='#FundingSource#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.FundingSource   EQ "", true, false)#'>,
                          <cfqueryparam value='#SubType#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.SubType   EQ "", true, false)#'>,
                          <!---<cfqueryparam value='#Type#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Type   EQ "", true, false)#'>,--->
                          <cfqueryparam value='#SurveyType#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.SurveyType   EQ "", true, false)#'>,
                          <cfqueryparam value='#Route#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Route   EQ "", true, false)#'>,
                          <cfqueryparam value='#tempntbid#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.tempntbid   EQ "", true, false)#'>
                        )
                  </cfquery>
                <cfif #insert.recordcount# eq 1>
                    <cfset counter= 1>
                </cfif>
            </cfloop>
            <cfquery name="qTurnOffInsert" datasource="#Application.dsn#">
                SET IDENTITY_INSERT PROJECTS OFF
            </cfquery>
            <cfcatch type="any">
                <form action="" enctype="multipart/form-data" method="post" style="margin-left: 300px">
                    <div class="form-group">
                        <label for=""> Upload Utility </label>
                        <input id="upload-utility-4" class="file-loading" type="file"  name="xlsfile"  required>
                    </div>
                    <br>
                    <div class="form-group">
                        <input type="submit" class="btn btn-success" value="Upload XLS File">
                    </div>
                </form><cfdump var="#cfcatch#"><cfabort>
                <h3 style="text-align: center">Error ! Data is incomplete or Please Select the correct file.</h3>
                <cfset counter = 0>
            </cfcatch>
        </cftry>
    </cfif>
</cfif>
<cfif counter eq 1>
    <cfoutput><h3 style="text-align: center"> data inserted Successfully into Projects Table !</h3></cfoutput>
    <cfelseif counter eq 2>
    <cfoutput><h3 style="text-align: center"> Complete data is not inserted, missing <cfloop> #missing# </cfloop> !</h3></cfoutput>
</cfif>

<div class="container">
    <div class="modal fade project-model-custom-main" id="myModal" role="dialog">
        <div class="modal-dialog project-model-custom modal-sm">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Enter Password to Continue</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input type="password" class="form-control" name="pas" id="passss">
                    </div>
                    <ul>
                        <li style="display: none" id="listerror">Please give correct password !</li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="subsight">Submit</button>
                </div>
            </div>

        </div>
    </div>
</div>