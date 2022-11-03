<cfsetting requesttimeout="3600">
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
    </div>
    <br>
    <br>
           <cfif isdefined('session.delete')>
               <cfif session.delete eq 1>
                <cfoutput><h3 style="margin-left: 300px">Upload data to DOLPHIN_INTERACTIONS TABLE to avoid conflict With Dolphins </h3></cfoutput>
                   <cfset session.delete = 0 >

               </cfif>
           </cfif>
    <br>--->
<cfelse>
    <cfif exceldata.recordCount is 1>
        <p>no recrod</p>
    <cfelse>
        <cftry>
            <cfloop query="exceldata" startrow="2">
                
                <cfset W_mom       			= exceldata['W/mom'][currentRow]>
                <cfset GCP       			= exceldata['GQP'][currentRow]>
                
            	<cfquery name="insert_dolhpin_sight" datasource="#application.dsn#" result="insert">
                    insert into DOLPHIN_SIGHTINGS (Dolphin_ID,Sighting_ID,Dolphin_Sighting_Date,Preliminary_Letter,Verified,PP,Xeno,Note,REM,REMPI
                    ,Echelon,Fetals,[W/mom],SDO1,TStrips,Frame1,SDO2,Frame2,SDO3,Frame3,SDO4,Frame4,CON1,CON2,BC,ESPhoto,GCP,PQP,SDR,BIO_LOBO,BIO_POX
                    ,BIOSDO,RDS,pq_focus,pq_Contrast,pq_Angle,pq_Partial,pq_Proportion,pqSum,ILoc1,ILoc2,Segment)
                    values(<cfqueryparam value='#Dolphin_ID#'  cfsqltype="cf_sql_integer" null='#IIF(exceldata.Dolphin_ID EQ "", true, false)#'>,
                    <cfqueryparam        value='#Sighting_ID#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.Sighting_ID EQ "", true, false)#'>,
                    <cfqueryparam        value="#Date#"        cfsqltype="cf_sql_date">,
                    <cfqueryparam value='#Preliminary_Letter#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Preliminary_Letter EQ "", true, false)#">,
                    <cfqueryparam value='#Verified#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Verified EQ "", true, false)#">,
                    <cfqueryparam value='#PP#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.PP EQ "", true, false)#">,
                    <cfqueryparam value='#Xeno#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.Xeno EQ "", true, false)#">,
                    <cfqueryparam value='#Note#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Note EQ "", true, false)#">,
                    <cfqueryparam value='#REM#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.REM EQ "", true, false)#">,
                    <cfqueryparam value='#REMPI#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.REMPI EQ "", true, false)#">,
                    <cfqueryparam value='#Echelon#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Echelon EQ "", true, false)#">,
                    <cfqueryparam value='#Fetals#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.Fetals EQ "", true, false)#">,
                    <cfqueryparam value='#W_mom#' cfsqltype="cf_sql_bit"  null="#IIF(W_mom EQ "", true, false)#">,
                    <cfqueryparam value='#SDO1#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.SDO1 EQ "", true, false)#">,
                    <cfqueryparam value='#TStrips#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.TStrips EQ "", true, false)#">,
                    <cfqueryparam value='#Frame1#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Frame1 EQ "", true, false)#">,
                    <cfqueryparam value='#SDO2#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.SDO2 EQ "", true, false)#">,
                    <cfqueryparam value='#Frame2#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Frame2 EQ "", true, false)#">,
                    <cfqueryparam value='#SDO3#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.SDO3 EQ "", true, false)#">,
                    <cfqueryparam value='#Frame3#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Frame3 EQ "", true, false)#">,
                    <cfqueryparam value='#SDO4#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.SDO4 EQ "", true, false)#">,
                    <cfqueryparam value='#Frame4#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Frame4 EQ "", true, false)#">,
                    <cfqueryparam value='#CON1#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.CON1 EQ "", true, false)#">,
                    <cfqueryparam value='#CON2#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.CON2 EQ "", true, false)#">,
                    <cfqueryparam value='#BC#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.BC EQ "", true, false)#">,
                    <cfqueryparam value='#ESPhoto#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.ESPhoto EQ "", true, false)#">,
                    <cfqueryparam value='#GCP#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.GCP EQ "", true, false)#">,
                    <cfqueryparam value='#PQP#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.PQP EQ "", true, false)#">,
                    <cfqueryparam value='#SDR#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.SDR EQ "", true, false)#">,
                    <cfqueryparam value='#BIO_LOBO#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.BIO_LOBO EQ "", true, false)#">,
                    <cfqueryparam value='#BIO_POX#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.BIO_POX EQ "", true, false)#">,
                    <cfqueryparam value='#BIOSDO#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.BIOSDO EQ "", true, false)#">,
                    <cfqueryparam value='#RDS#' cfsqltype="cf_sql_bit"  null="#IIF(exceldata.RDS EQ "", true, false)#">,
                    <cfqueryparam value='#pq_focus#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.pq_focus EQ "", true, false)#">,
                    <cfqueryparam value='#pq_Contrast#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.pq_Contrast EQ "", true, false)#">,
                    <cfqueryparam value='#pq_Angle#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.pq_Angle EQ "", true, false)#">,
                    <cfqueryparam value='#pq_Partial#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.pq_Partial EQ "", true, false)#">,
                    <cfqueryparam value='#pq_Proportion#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.pq_Proportion EQ "", true, false)#">,
                    <cfqueryparam value='#pqSum#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.pqSum EQ "", true, false)#">,
                    <cfqueryparam value='#ILoc1#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.ILoc1 EQ "", true, false)#">,
                    <cfqueryparam value='#ILoc2#' cfsqltype="cf_sql_integer"  null="#IIF(exceldata.ILoc2 EQ "", true, false)#">,
                    <cfqueryparam value='#Segment#' cfsqltype="cf_sql_varchar"  null="#IIF(exceldata.Segment EQ "", true, false)#">
            )
            </cfquery>
				<cfif #insert.recordcount# eq 1>
                    <cfset counter= 1>
                </cfif>
            </cfloop>
            
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
    <cfoutput><h3 style="text-align: center"> data inserted Successfully into Dolphins Sightings Table !</h3></cfoutput>
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