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
    <cfelse>
        <cftry>
        <cfquery name="qTurnOnInsert" datasource="#Application.dsn#">
            SET IDENTITY_INSERT DOLPHINS ON
        </cfquery>
        <cfloop query="exceldata" startrow="2">
            
            <cfset Recapture_Date_2       		= exceldata['Recapture Date 2'][currentRow]>
            <cfset F_Repro       				= exceldata['F Repro'][currentRow]>
            <cfset SOURCE_SEXED       			= exceldata['Source Sexed'][currentRow]>
            <cfset Recapture_Date_1       		= exceldata['Recapture Date 1'][currentRow]>
            <cfset Recapture_Date_3       		= exceldata['Recapture Date 3'][currentRow]>
            <cfset Distinct       				= exceldata['Distinct'][currentRow]>
            <cfset Biopsy_No       				= exceldata['Biopsy No'][currentRow]>
            <cfset Lobo_Confirmed       		= exceldata['Lobo Confirmed'][currentRow]>
            <cfset Other_Partners       		= exceldata['Other Partners'][currentRow]>
            <cfset First_YOY_DOB_EST       		= exceldata['First YOY DOB EST'][currentRow]>
            <cfset Naming_regime       			= exceldata['Naming regime'][currentRow]>
            <cfset FAMILY_NAME       			= exceldata['FAMILY NAME'][currentRow]>
            <cfset DOB_ACT      			    = exceldata['DOB ACT'][currentRow]>
            <cfset DOB_EST       				= exceldata['DOB EST'][currentRow]>
            <cfset DATE_OF_DEATH       			= exceldata['DATE OF DEATH'][currentRow]>
            <cfset Field_ID       				= exceldata['Field ID'][currentRow]>
            <cfset Dead       					= exceldata['Dead?'][currentRow]>
            <cfset SiteFide       				= exceldata['SiteFide'][currentRow]>
            <cfset Dispersal_Date       		= exceldata['Dispersal Date'][currentRow]>
            <cfset CFS_ID       				= exceldata['CFS ID'][currentRow]>
            <cfset Hubbs_ID       				= exceldata['Hubbs ID'][currentRow]>
            <cfset MJ_ID       					= exceldata['MJ ID'][currentRow]>
            <cfset JU_ID       					= exceldata['JU ID'][currentRow]>
            <cfset FIT_ID       				= exceldata['FIT ID'][currentRow]>
            <cfset UNF_ID       				= exceldata['UNF ID'][currentRow]>
            <cfset SAET_ID       				= exceldata['SAET ID'][currentRow]>
            <cfset SOURCE_YOB       			= exceldata['SOURCE YOB'][currentRow]>
            <cfset HERA_Error       			= exceldata['HERA Error'][currentRow]>
            <cfset First_Sighting_Date       	= exceldata['First Sighting Date'][currentRow]> 
            <cfset Fin_Change_1       			= exceldata['Fin Change 1'][currentRow]>
			<cfset HERA_Rescue_Fin_Change_1     = exceldata['HERA/Rescue Fin Change 1'][currentRow]>
            <cfset Fin_Change_2       			= exceldata['Fin Change 2'][currentRow]>
            <cfset HERA_Rescue_Fin_Change_2     = exceldata['HERA/Rescue Fin Change 2'][currentRow]>
            <cfset Fin_Change_3       			= exceldata['Fin Change 3'][currentRow]>
            <cfset HERA_Rescue_Fin_Change_3     = exceldata['HERA/Rescue Fin Change 3'][currentRow]>
            <cfset Fin_Change_4       			= exceldata['Fin Change 4'][currentRow]>
            <cfset HERA_Rescue       			= exceldata['HERA/Rescue'][currentRow]>
            <cfset Pres_Dead                    = exceldata['Pres Dead'][currentRow]>
            <cfset GreatGrandmother             = exceldata['GreatGrandmother'][currentRow]>
            <cfset Verify                       = exceldata['Verify'][currentRow]>
            <cfset waterBody                    = exceldata['waterBody'][currentRow]>
            <cfset Dispersal_Date_Source        = exceldata['Dispersal Date Source'][currentRow]>
            
            
            <cfset Date_Of_Birth_Estimate       = exceldata['Date Of Birth Estimate'][currentRow]>
            <cfset Date_Of_Intervention         = exceldata['Date Of Intervention'][currentRow]>
            <cfset FB_Source                    = exceldata['FB Source'][currentRow]>
            <cfset Date_of_Second_Intervention  = exceldata['Date of Second Intervention'][currentRow]>
            <cfset Date_of_Third_Intervention   = exceldata['Date of Third Intervention'][currentRow]>
            

            
            <cfquery datasource="#Application.dsn#" name="insertdolphin" result="insert">
              insert into DOLPHINS(
              ID,[Recapture Date 2],Field1,[F Repro],[Source Sexed],[Recapture Date 1],[Recapture Date 3],Code,
              Name,Catalog,Sex,[Distinct],DistinctDate,FB_No,FB_On_Date,FB_Side,[LEFT],Media_Left,[RIGHT],Media_Right,
              [Biopsy No],PRES_LOBO,PRES_LOBO_DATE,Coalitions,[Lobo Confirmed],[Other Partners],Mothers,Lineage,[First YOY DOB EST],
              Grandmother,[Naming regime],[Family Name],[DOB ACT],[DOB EST],[Date of Death],[Field ID],[Dead?],YearOfBirth,
              SiteFide,[Dispersal Date],NeverSighted,Verified,UnableToVerify,DScore,[CFS ID],[Hubbs ID],[MJ ID],[JU ID],[FIT ID],[UNF ID],[SAET ID]
              ,[HERA Error],[First Sighting Date],[Fin Change 1],[HERA/Rescue Fin Change 1],[Fin Change 2],[HERA/Rescue Fin Change 2],
              [Fin Change 3],[HERA/Rescue Fin Change 3],[Fin Change 4],[HERA/Rescue],[Pres Dead],GreatGrandmother,
              waterBody,bodyConditionCode,ageAtDeath,dorsalDecomposed,poorQualityPhoto,Unrecoveredo,momPushingDeadCalf,deadDorsalPhoto,bodyLenght,ageCohort,
             Details,otherAccessionNumbers,photoType,irlSegment,utmEsting,utmNorting,wMom,[Dispersal Date Source],ImageName,[DATE OF BIRTH ESTIMATE],
             [Date Of Intervention],[FB Source],[Date of Second Intervention],[Date of Third Intervention]
                   )
          values(
                 <cfqueryparam value='#ID#' cfsqltype="cf_sql_integer" null='#IIF(exceldata.ID   EQ "", true, false)#'>,
                 <cfqueryparam value="#Recapture_Date_2#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#Field1#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Field1 EQ "", true, false)#">,
                 <cfqueryparam value="#F_Repro#" cfsqltype="cf_sql_bit">,
                 <cfqueryparam value="#Source_Sexed#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#Recapture_Date_1#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#Recapture_Date_3#" cfsqltype="cf_sql_date" >,
                 <cfqueryparam value="#Code#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Code EQ "", true, false)#">,
                 <cfqueryparam value="#Name#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Name EQ "", true, false)#">,
                 <cfqueryparam value="#Catalog#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Catalog EQ "", true, false)#">,
                 <cfqueryparam value="#Sex#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Sex EQ "", true, false)#">,
                 <cfqueryparam value="#Distinct#" cfsqltype="cf_sql_bit">,
                 <cfqueryparam value="#DistinctDate#" cfsqltype="cf_sql_date" null="#IIF(exceldata.DistinctDate EQ "", true, false)#">,
                 <cfqueryparam value="#FB_No#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.FB_No EQ "", true, false)#">,
                 <cfqueryparam value="#FB_On_Date#" cfsqltype="cf_sql_date" null="#IIF(exceldata.FB_On_Date EQ "", true, false)#">,
                 <cfqueryparam value="#FB_Side#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.FB_Side EQ "", true, false)#">,
                 <cfqueryparam value="#LEFT#" cfsqltype="cf_sql_tinyint" null="#IIF(exceldata.LEFT EQ "", true, false)#">,
                 <cfqueryparam value="#Media_Left#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Media_Left EQ "", true, false)#">,
                 <cfqueryparam value="#RIGHT#" cfsqltype="cf_sql_tinyint" null="#IIF(exceldata.Right EQ "", true, false)#">,
                 <cfqueryparam value="#Media_Right#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Media_Right EQ "", true, false)#">,
                 <cfqueryparam value="#Biopsy_No#" cfsqltype="cf_sql_varchar" null="#IIF(Biopsy_No EQ "", true, false)#">,
                 <cfqueryparam value="#PRES_LOBO#" cfsqltype="cf_sql_bit" null="#IIF(exceldata.PRES_LOBO EQ "", true, false)#">,
                 <cfqueryparam value="#PRES_LOBO_DATE#" cfsqltype="cf_sql_date" null="#IIF(exceldata.PRES_LOBO_DATE EQ "", true, false)#">,
                 <cfqueryparam value="#Coalitions#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Coalitions EQ "", true, false)#">,
                 <cfqueryparam value="#Lobo_Confirmed#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#OTHER_PARTNERS#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#Mothers#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Mothers EQ "", true, false)#">,
                 <cfqueryparam value="#Lineage#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Lineage EQ "", true, false)#">,
                 <cfqueryparam value="#First_YOY_DOB_EST#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#Grandmother#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Grandmother EQ "", true, false)#">,
                 <cfqueryparam value="#Naming_regime#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#Family_Name#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#DOB_ACT#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#DOB_EST#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#Date_of_Death#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#Field_ID#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#Dead#" cfsqltype="cf_sql_bit">,
                 <cfqueryparam value="#YearOfBirth#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#SiteFide#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#Dispersal_Date#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#NeverSighted#" cfsqltype="cf_sql_bit" null="#IIF(exceldata.NeverSighted EQ "", true, false)#">,
                 <cfqueryparam value="#Verified#" cfsqltype="cf_sql_bit" null="#IIF(exceldata.Verified EQ "", true, false)#">,
                 <cfqueryparam value="#UnableToVerify#" cfsqltype="cf_sql_bit" null="#IIF(exceldata.UnableToVerify EQ "", true, false)#">,
                 <cfqueryparam value="#DScore#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.DScore EQ "", true, false)#">,
                 <cfqueryparam value="#CFS_ID#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#Hubbs_ID#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#MJ_ID#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#JU_ID#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#FIT_ID#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#UNF_ID#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#SAET_ID#" cfsqltype="cf_sql_varchar">,
                 <!---<cfqueryparam value="#Source_YOB#" cfsqltype="cf_sql_integer">,--->
                 <cfqueryparam value="#HERA_Error#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#First_Sighting_Date#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#Fin_Change_1#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#HERA_Rescue_Fin_Change_1#" cfsqltype="cf_sql_bit">,
                 <cfqueryparam value="#Fin_Change_2#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#HERA_Rescue_Fin_Change_2#" cfsqltype="cf_sql_bit">,
                 <cfqueryparam value="#Fin_Change_3#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#HERA_Rescue_Fin_Change_3#" cfsqltype="cf_sql_bit">,
                 <cfqueryparam value="#Fin_Change_4#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#HERA_Rescue#" cfsqltype="cf_sql_bit">,
                 <cfqueryparam value="#Pres_Dead#" cfsqltype="cf_sql_bit">,
                 <cfqueryparam value="#GreatGrandmother#" cfsqltype="cf_sql_varchar">,
                 <!---<cfqueryparam value="#Verify#" cfsqltype="cf_sql_integer">,--->
                 <cfqueryparam value="#waterBody#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#bodyConditionCode#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.bodyConditionCode EQ "", true, false)#">,
                 <cfqueryparam value="#ageAtDeath#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.ageAtDeath EQ "", true, false)#">,
                 <cfqueryparam value="#dorsalDecomposed#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.dorsalDecomposed EQ "", true, false)#">,
                 <cfqueryparam value="#poorQualityPhoto#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.poorQualityPhoto EQ "", true, false)#">,
                 <cfqueryparam value="#Unrecoveredo#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Unrecoveredo EQ "", true, false)#">,
                 <cfqueryparam value="#momPushingDeadCalf#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.momPushingDeadCalf EQ "", true, false)#">,
                 <cfqueryparam value="#deadDorsalPhoto#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.deadDorsalPhoto EQ "", true, false)#">,
                 <cfqueryparam value="#bodyLenght#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.bodyLenght EQ "", true, false)#">,
                 <cfqueryparam value="#ageCohort#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.ageCohort EQ "", true, false)#">,
                 <cfqueryparam value="#Details#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.Details EQ "", true, false)#">,
                 <cfqueryparam value="#otherAccessionNumbers#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.otherAccessionNumbers EQ "", true, false)#">,
                 <cfqueryparam value="#photoType#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.photoType EQ "", true, false)#">,
                 <cfqueryparam value="#irlSegment#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.irlSegment EQ "", true, false)#">,
                 <cfqueryparam value="#utmEsting#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.utmEsting EQ "", true, false)#">,
                 <cfqueryparam value="#utmNorting#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.utmNorting EQ "", true, false)#">,
                 <cfqueryparam value="#wMom#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.wMom EQ "", true, false)#">,
                 <cfqueryparam value="#Dispersal_Date_Source#" cfsqltype="cf_sql_varchar">,
                 <cfqueryparam value="#ImageName#" cfsqltype="cf_sql_varchar" null="#IIF(exceldata.ImageName EQ "", true, false)#">,
                 <cfqueryparam value="#Date_Of_Birth_Estimate#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#Date_Of_Intervention#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#FB_Source#" cfsqltype="cf_sql_varchar" null="#IIF(FB_Source EQ "", true, false)#">,
                 <cfqueryparam value="#Date_of_Second_Intervention#" cfsqltype="cf_sql_date">,
                 <cfqueryparam value="#Date_of_Third_Intervention#" cfsqltype="cf_sql_date">
                )
        </cfquery>
                <!---<cfif exceldata.ID NEQ "">
                <cfquery name="updateDolphinDscore" datasource="#Application.dsn#">
                    update dolphin_Dscore set DolphinID = #insert['IDENTITYCOL']# where DolphinID = #exceldata.ID#
                </cfquery>
                </cfif>--->
                <cfif #insert.recordcount# eq 1>
                    <cfset counter= 1>
                </cfif>
        </cfloop>
        	<cfquery name="qTurnOffInsert" datasource="#Application.dsn#">
                SET IDENTITY_INSERT DOLPHINS OFF
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
                </form>
                    <cfdump var=#cfcatch#>
            </cfcatch>
        </cftry>
    </cfif>
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