<cfset showForm = true>
<cfset counter = 0>
<cfset missing =''>
<cfif structKeyExists(form, "xlsfile") and len(form.xlsfile)>

<!--- Destination outside of web root --->
    <cffile action="upload" destination="#Application.CloudDirectory#" filefield="xlsfile" result="upload" nameconflict="makeunique">
    <cfif upload.fileWasSaved>
        <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
        <cfif right(theFile,4) eq 'xlsx'>

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
    <!---<div class="col-md-12">
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
    </div>--->
    <br>
    <br>
    <br>
<cfelse>
    <cfif exceldata.recordCount is 1>
        <p>no recrod</p>
    <cfelse>

        <cftry>
        <!---<cfquery name="qTurnOnInsert" datasource="#Application.dsn#">
            SET IDENTITY_INSERT dolphin_Dscore ON
        </cfquery>--->
        <cfloop query="exceldata" startrow="2">
			<!---<cfquery name="getDolphinID" datasource="#Application.dsn#">
            	Select ID from dolphins where code = '#exceldata.DolphinID#'
        	</cfquery>
            <cfif isdefined('getDolphinID.ID')>
                <cfset Dolphin_ID = getDolphinID.ID>
			<cfelse>
				<cfset Dolphin_ID = 0>	
            </cfif>--->
			<!---<cfif isdefined('exceldata.DScore')>
                <cfset DScore = ''>
            </cfif>
			<cfif isdefined('exceldata.DScoreDate')>
                <cfset DScoreDate = ''>
            </cfif>--->
            
            <cfquery datasource="#Application.dsn#" name="insertDScore" result="insert">
			  insert into dolphin_Dscore(<!---ID,--->DolphinID,DScore,DScoreDate)
			  values(
					 <!---<cfqueryparam value='#ID#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.ID   EQ "", true, false)#'>,--->
                     <cfqueryparam value="#exceldata.DolphinID#" cfsqltype="cf_sql_integer" null="#IIF(exceldata.DolphinID EQ "", true, false)#">,
					 <cfqueryparam value="#DScore#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.DScore EQ "", true, false)#">,
					 <cfqueryparam value="#DScoreDate#" cfsqltype="cf_sql_date">
					)
			</cfquery>
			<cfif #insert.recordcount# eq 1>
				<cfset counter= 1>
			</cfif>
        </cfloop>
            <!---<cfquery name="qTurnOffInsert" datasource="#Application.dsn#">
                SET IDENTITY_INSERT dolphin_Dscore OFF
            </cfquery>--->
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
                </form>
                    <cfdump var=#cfcatch#>
            </cfcatch>
        </cftry>
    </cfif>
</cfif>
<cfif counter eq 1>
    <cfoutput><h3 style="text-align: center"> data inserted Successfully into Dscore Table !</h3></cfoutput>
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