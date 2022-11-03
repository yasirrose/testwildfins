<cfsetting requesttimeout="3600">
<cfset showForm = true>
<cfset counter = 0>
<cfset missing =''>
<cfif structKeyExists(form, "xlsfile") and len(form.xlsfile)>
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
    <br>
           <cfif isdefined('session.delete')>
               <cfif session.delete eq 1>
                <cfoutput><h3 style="margin-left: 300px">Upload data to DOLPHIN_INTERACTIONS TABLE to avoid conflict With Dolphins </h3></cfoutput>
                   <cfset session.delete = 0 >
               </cfif>
           </cfif>
    <br>
    
    <cfelse>
    	<cfif exceldata.recordCount is 1>
        	<p>no recrod</p>
    	</cfif>
        
        
        <cftry>
        <!---<cfquery name="qTurnOnInsert" datasource="#Application.dsn#">
            SET IDENTITY_INSERT DOLPHINS OFF
        </cfquery>--->
        <!---<table>
        	<tr>
            	<td>Water Body</td>
                <td>Field ID</td>
                <td>Date of death</td>
                <td>Body Condition</td>
                <td>DScore</td>
                <td>Code</td>
                <td>IRL-Secment</td>
                <td>UTM X</td>
                <td>UTM Y</td>
                <td>FB NO</td>
                <td>YearOfBirth</td>
                <td>Source YOB</td>
                <td>Lineage</td>
                <td>MOM</td>
                <td>Age At Death</td>
                <td>Dorsal Decomp</td>
                <td>Poor Quality</td>
                <td>Unrecovered Code</td>
                <td>MOM Pushing Dead Calf</td>
                <td>SEX</td>
                <td>Body Length</td>
                <td>Age cohort</td>
                <td>Dead Dorsal</td>
                <td>Details</td>
                <td>Other Accessions</td>
                <td>Photo Type</td>
            </tr>--->
        <cfoutput>   <cfset count = 0><cfset countt = 0> 
        <cfloop query="exceldata" startrow="2">
        	<cfset Water_body       				= exceldata['Water body'][currentRow]>
            <cfset Field_ID       					= exceldata['Field ID'][currentRow]>
 			<cfset month_death       				= exceldata['Month'][currentRow]>
 			<cfset day_death       					= exceldata['Day'][currentRow]>
 			<cfset Year_death       				= exceldata['Year'][currentRow]>
            <cfif day_death NEQ ''>
				<cfset date_of_death            		= "#Year_death#-#month_death#-#day_death#">
            <cfelse>
            	<cfset date_of_death            		= "">
            </cfif>
            <cfset Body_Condition_Code       		= exceldata['Body Condition Code'][currentRow]>
            <cfset D_Score_at_Death_or_Intervention = exceldata['D Score at Death or Intervention'][currentRow]>
            <cfset Photo_ID_Code       				= exceldata['Photo-ID Code'][currentRow]>
            <cfset IRL_segment        				= exceldata['IRL segment '][currentRow]>
            
            
            <cfset UTM_Easting_X_coordinates      	= exceldata['UTM Easting (X) coordinates'][currentRow]>
            <cfset UTM_Northing_Y_coordinates       = exceldata['UTM Northing (Y) coordinates'][currentRow]>
 			<cfset FB_No       						= exceldata['FB_No'][currentRow]>
            <cfif exceldata['YearOfBirth'][currentRow] neq 'x'>
				<cfset YearOfBirth       				= exceldata['YearOfBirth'][currentRow]>
            <cfelse>
            	<cfset YearOfBirth       				= ''>
            </cfif>
            <cfset Source_YOB      					= exceldata['Source YOB'][currentRow]>
            <cfif exceldata['Lineage'][currentRow] neq 'x'>
            	<cfset Lineage       			    = exceldata['Lineage'][currentRow]>
            <cfelse>
            	<cfset Lineage       			    = ''>
            </cfif>
                
            <cfset Mom       						= exceldata['Mom'][currentRow]>
            <cfset AgeAtDeath	       				= exceldata['Age at death (formula)'][currentRow]>
            
            
            <cfset D1_D2_D6_D7_In_Catalogue      	= exceldata['D1, D2, D6, D7: In Catalogue'][currentRow]>
            <cfset D1_D2_Not_in_Catalogue       	= exceldata['D1, D2: Not in Catalogue'][currentRow]>
 			<cfset D3_D8_One_thingers_In_Catalogue  = exceldata['D3, D8: One thingers In Catalogue'][currentRow]>
            <cfset D4_Unmarked      				= exceldata['D4: Unmarked'][currentRow]>
            <cfset Dorsal_decomp_or_scavenged       = exceldata['Dorsal decomp or scavenged'][currentRow]>
            <cfset Poor_quality_or_no_photo       	= exceldata['Poor quality or no photo'][currentRow]>
            <cfset Unrecovered_CODE_0        		= exceldata['Unrecovered-CODE 0'][currentRow]>
            
            <cfset Mom_pushing_dead_calf      		= exceldata['Mom pushing dead calf'][currentRow]>
            <cfset Sex       						= exceldata['Sex'][currentRow]>
 			<cfset Body_length      				= exceldata['Body lenngth (cm)'][currentRow]>
            <cfset Age_cohort      					= exceldata['Age cohort (Adult, Juvenile, Calf)'][currentRow]>
            <cfset HBOI_tooth_to_MKS       			= exceldata['HBOI tooth to MKS'][currentRow]>
            <cfset Dead_dorsal_photo		       	= exceldata['Dead dorsal photo on file'][currentRow]>
            <cfset Details       					= exceldata['Details'][currentRow]>
            
            
            <cfset Other_accession_NOs       		= exceldata['Other accession ##s'][currentRow]>
            <cfset Photo_type       				= exceldata['Photo type'][currentRow]>
            <cfset Map       						= exceldata['Map'][currentRow]>
			<!---<tr>
            		<td>#Water_body#</td>
                    <td>#Field_ID#</td>
                    <td>#date_of_death#</td>
                    <td>#Body_Condition_Code#</td>
                    <td>#D_Score_at_Death_or_Intervention#</td>
                    <td>#Photo_ID_Code#</td>
                    <td>#IRL_segment#</td>
                    <td>#UTM_Easting_X_coordinates#</td>
                    <td>#UTM_Northing_Y_coordinates#</td>
                    <td>#FB_No#</td>
                    <td>#YearOfBirth#</td>
                    <td>#Lineage#</td>
                    <td>#Mom#</td>
                    <td>#AgeAtDeath#</td>
                    <td>#Dorsal_decomp_or_scavenged#</td>
                    <td>#Poor_quality_or_no_photo#</td>
                    <td>#Unrecovered_CODE_0#</td>
                    <td>#Mom_pushing_dead_calf#</td>
                    <td>#Sex#</td>
                    <td>#Body_length#</td>
                    <td>#Age_cohort#</td>
                    <td>#Dead_dorsal_photo#</td>
                    <td>#Details#</td>
                    <td>#Other_accession_NOs#</td>
                    <td>#Photo_type#</td>
            </tr>--->
            
            <cfif Photo_ID_Code NEQ ''>
                <cfquery name="isAlreadyExists" datasource="#Application.dsn#">
                    Select * from DOLPHINS where Code = '#Photo_ID_Code#'
                </cfquery>
            <cfelse>
            	<cfset count++>
                <cfset Photo_ID_Code = 'unkn'&count>
            </cfif>
            <!---<cfif (NOT isdefined("isAlreadyExists")) or (isAlreadyExists.recordcount EQ 0) or exceldata['Photo-ID Code'][currentRow] eq ''>
				<cfset countt++>
                <cfif Source_YOB NEQ ''>
                    <cfquery name="Source_YOBExists" datasource="#Application.dsn#">
                        Select ID from TLU_YOB_SOURCE where YOBSource = '#Source_YOB#'
                    </cfquery>
                    <cfif Source_YOBExists.recordcount GT 0>
                    	<cfset Source_YOB = Source_YOBExists.ID>
                    <cfelse>
                    	<cfset Source_YOB = ''>    
                    </cfif>
                </cfif>
                <cfquery datasource="#Application.dsn#" name="insertdolphin" result="insert">
                    insert into DOLPHINS(waterBody,[Field ID],[Date of Death],bodyConditionCode<!---,DScore--->,Code,irlSegment,utmEsting,utmNorting,FB_No,YearOfBirth
                    ,[Source YOB],Lineage,Mothers,ageAtDeath,dorsalDecomposed,poorQualityPhoto,Unrecoveredo,momPushingDeadCalf,Sex,bodyLenght,ageCohort
                    ,deadDorsalPhoto,Details,otherAccessionNumbers,photoType,[Dead?])
                    values(
                     <cfqueryparam value='#Water_body#' cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Field_ID#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#date_of_death#" cfsqltype="cf_sql_date">,
                     <cfqueryparam value="#Body_Condition_Code#" cfsqltype="cf_sql_varchar">,
                     <!---<cfqueryparam value="#D_Score_at_Death_or_Intervention#" cfsqltype="cf_sql_varchar">,--->
                     <cfqueryparam value="#Photo_ID_Code#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value='#IRL_segment#' cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#UTM_Easting_X_coordinates#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#UTM_Northing_Y_coordinates#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#FB_No#" cfsqltype="cf_sql_varchar" null='#IIF(exceldata.FB_No   EQ "", true, false)#'>,
                     <cfqueryparam value="#YearOfBirth#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Source_YOB#" cfsqltype="cf_sql_int">,
                     <cfqueryparam value='#Lineage#' cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Lineage   EQ "", true, false)#'>,
                     <cfqueryparam value="#Mom#" cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Mom   EQ "", true, false)#'>,
                     <cfqueryparam value="#AgeAtDeath#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Dorsal_decomp_or_scavenged#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Poor_quality_or_no_photo#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Unrecovered_CODE_0 #" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value='#Mom_pushing_dead_calf#' cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Sex#" cfsqltype="cf_sql_varchar" null='#IIF(exceldata.Sex   EQ "", true, false)#'>,
                     <cfqueryparam value="#Body_length#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Age_cohort#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Dead_dorsal_photo#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Details#" cfsqltype="cf_sql_text" null='#IIF(exceldata.Details   EQ "", true, false)#'>,
                     <cfqueryparam value="#Other_accession_NOs#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="#Photo_type#" cfsqltype="cf_sql_varchar">,
                     <cfqueryparam value="1" cfsqltype="cf_sql_bit">
                    )
            	</cfquery>
                <cfif D_Score_at_Death_or_Intervention NEQ ''>
                    <cfquery name="insert_Dscore" datasource="#Application.dsn#">
                        INSERT INTO DOLPHIN_DSCORE(DOLPHINID,DSCORE) VALUES('#insert.IDENTITYCOL#','#D_Score_at_Death_or_Intervention#')
                    </cfquery>
                </cfif>
                <!---<cfdump var="#insert.IDENTITYCOL#"><cfabort>--->
            </cfif>--->
                
            <!---
            <cfif #insert.recordcount# eq 1>
				<cfset counter= 1>
            </cfif>--->
        </cfloop>
        </cfoutput>
        <!---</table><cfabort>--->
        <!---<cfquery name="qTurnOffInsert" datasource="#Application.dsn#">
            SET IDENTITY_INSERT DOLPHINS ON
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
<cfif counter eq 1>
    <cfoutput><h3 style="text-align: center"> data inserted Successfully into Dolphins Table !</h3></cfoutput>
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