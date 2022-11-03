
<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    <cfset showForm = true>
    <cfif structKeyExists(form, "sampleFile") and len(form.sampleFile)>
        <cfset dest = getTempDirectory()>
        <!--- <cfdump var="#isSpreadsheetFile(sampleFile)#"><cfabort> --->
        <cffile action="upload" destination="#dest#" filefield="sampleFile" result="upload" nameconflict="makeunique">
        <!--- <cfdump var="#upload#"><cfabort> --->
        <cfif upload.fileWasSaved>
            <cfset theFile = upload.serverDirectory & "/" & upload.serverFile>
            <cfif isSpreadsheetFile(theFile)>
                <cfspreadsheet action="read" src="#theFile#" query="data" headerrow="1">
                <cfset showForm = false>
            <cfelse>
                <cfset errors = "The file was not an Excel file.">
                <cfset showForm = true>
            </cfif>
        <cfelse>
            <cfset errors = "The file was not properly uploaded.">	
        </cfif>
        <cfif showForm>
            <div  class="container"  role="alert" id="notify">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <cfif structKeyExists(variables, "errors")>
                            <cfoutput>
                            <h3 style="padding-left: 111px;">
                            <b>Error: #variables.errors#</b>
                            </h3>
                            </cfoutput>
                        </cfif>  
                    </div>
                </div>
            </div>
        <cfelse>
        
            <cfif data.recordCount is 1>
                <p>
                This spreadsheet appeared to have no data.
                </p>
            <cfelse>

                <!--- <cfset Application.Stranding.SampleTypeUpdate(argumentCollection="#Form#")> --->
                <cfset colNameArray = data.getColumnNames() />
                <cfif arrayContains(colNameArray, 'Sample ID') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sample ID" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Tissue Type') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Tissue Type" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Preservation Method') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Preservation Method" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Sample Comments') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sample Comments" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Storage Type') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Storage Type" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Bin Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Bin Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date2') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date2" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location 2') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location 2" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Subsampled') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Subsampled" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Subsample Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Subsample Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date3') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date3" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location3') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location3" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Thaw') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Thaw" ');
                    </script>
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replace(' ','') />
                    </cfloop>
                    <cfset data.setColumnNames(colNameArray) />
                   
                    <cfoutput query="data" startRow="2">

                        <cfquery name="qcheckFilesampleArchive" datasource="#Application.dsn#">
                            SELECT ID,Fnumber,date FROM ST_SampleArchive
                            WHERE Fnumber ='#data.FieldNumber#'  
                            
                        </cfquery>
                        <!--- <cfoutput>#qcheckFilesampleArchive.recordCount#</cfoutput> --->
                       
                        <cfif qcheckFilesampleArchive.recordCount gt 0>
                            <cfset SA_ID = "#qcheckFilesampleArchive.ID#">
                        <cfelse>
                            <cfquery name="qinsertFilesampleArchive" datasource="#Application.dsn#" result="return_data">
                                INSERT INTO ST_SampleArchive
                                (
                                    Fnumber
                                    
                                )
                                VALUES
                                (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                                    
                                )
                            </cfquery>
                            <cfset SA_ID = "#return_data.generatedkey#">
                        </cfif>
                        <cfquery name="qcheckFilesampleType" datasource="#Application.dsn#">
                            SELECT ID,SampleID FROM ST_SampleType
                            WHERE SampleID ='#data.SampleID#' and SampleType = '#data.TissueType#' and SA_ID = #SA_ID#
                        </cfquery>
                        <cfif qcheckFilesampleType.recordCount gt 0>
                            <cfset ST_ID = "#qcheckFilesampleType.ID#">
                        <cfelse>   
                            <!--- <cfquery name="qcheckEMptySampleIDs" datasource="#Application.dsn#">
                                SELECT ID,SampleID FROM ST_SampleType
                                WHERE SampleID ='Not Available'  and SampleType = '#data.TissueType#' and SA_ID = #SA_ID#
                            </cfquery> --->
                            <!--- <cfif qcheckEMptySampleIDs.recordCount eq 0> --->
                                <cfif data.SampleID eq "">
                                    <cfset Sid = "Not Available">
                                <cfelse>
                                    <cfset Sid = "#data.SampleID#">
                                </cfif>
                                <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                                    INSERT INTO ST_SampleType
                                    (
                                    SampleID
                                    ,PreservationMethod
                                    ,SampleComments
                                    ,StorageType
                                    ,Sample_Location
                                    ,BinNumber
                                    ,SampleType
                                    ,Sample_Date
                                    ,maindate
                                    ,SA_ID
                                    ) 
                                    VALUES
                                    (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#Sid#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.PreservationMethod#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.SampleComments#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.StorageType#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.BinNumber#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.TissueType#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date2#' null="#IIF(Date2 EQ "", true, false)#">
                                    ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.Date#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_BIGINT" value='#SA_ID#'>
                                    )
                                </cfquery>
                                <cfset ST_ID = "#return_data.generatedkey#">
                                <cfquery name="qinsertFilesampleDetail" datasource="#Application.dsn#" result="return_data">
                                    Insert into ST_SampleDetail
                                    (
                                        SADate
                                        ,SampleLocation
                                        ,subsampleDate
                                        ,Thawed
                                        ,subsampled
                                        ,ST_ID
                                    )
                                    VALUES
                                    (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date3#' null="#IIF(Date3 EQ "", true, false)#">
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location2#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.SubsampleDate#' null="#IIF(SubsampleDate EQ "", true, false)#">
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Thaw#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Subsampled#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_BIGINT" value='#ST_ID#'>
                                    )
                                </cfquery>
                                <cfset count = 2>
                                <cfif isDefined('data.Location#count++#') AND evaluate('data.Location#count++#') neq "">
                                    <cfquery name="qinsertFilesampleDetail" datasource="#Application.dsn#" result="return_data">
                                        Insert into ST_SampleDetail
                                        (
                                            SADate
                                            ,SampleLocation
                                            ,subsampleDate
                                            ,Thawed
                                            ,subsampled
                                            ,ST_ID
                                        )
                                        VALUES
                                        (
                                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date3#' null="#IIF(Date3 EQ "", true, false)#">
                                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location3#'>
                                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.SubsampleDate#' null="#IIF(SubsampleDate EQ "", true, false)#">
                                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Thaw#'>
                                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Subsampled#'>
                                            ,<cfqueryparam cfsqltype="cf_sql_BIGINT" value='#ST_ID#'>
                                        )
                                    </cfquery>
                                </cfif>
                            <!--- </cfif> --->
                        </cfif>    
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>

   <cfset getTeams=Application.SightingNew.getTeams()>
    <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()>
    <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>
    <cfset qgetStrandingType=Application.StaticDataNew.getStrandingType()>
    <cfset qgetBinNumber=Application.StaticDataNew.getBinNumber()>
    <cfset qgetUnitofsample=Application.StaticDataNew.getUnitofsample()>
    <cfset qgetPreservationMethod=Application.StaticDataNew.getPreservationMethod()>
    <cfset qgetSampleType=Application.StaticDataNew.getSampleType()>
    <cfset qgetSampleLocation=Application.StaticDataNew.getSampleLocation()>
    <cfset qgetSampleTracking=Application.StaticDataNew.getSampleTracking()>
    <cfset qgetDiagnosticLab=Application.StaticDataNew.getDiagnosticLab()>
    <cfset getStock=Application.StaticDataNew.getStock()>
    <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
    <cfset StorageTypeArray = ['Room Temperature','-80 C','-20 C','-20 F','Refrigerated']>
    <cfset ThawedArray = ['Yes','No','Partial']>
    <cfset Availbility = ['Full Sample','Partial Sample','No Sample','No Sample Available']>
    <cfparam  name="url.LCE_ID" DEFAULT="0">

    <cfif isDefined('SaveAndNew') OR isDefined('SaveAndClose')>
        <cfset form.check = "1">
        <cfif isDefined('form.SEID') and form.SEID neq "">
            <cfset Application.Stranding.SampleArchiveUpdate(argumentCollection="#Form#")>
            <cfset form.SA_ID = "#form.SEID#">
            <cfif form.ST_ID neq "" AND form.ST_ID neq "0">
                <cfset Application.Stranding.SampleTypeUpdate(argumentCollection="#Form#")>
                <cfif form.SADate neq "">
                    <cfset Application.Stranding.InsertSampleData(argumentCollection="#Form#")>
                </cfif>
            <cfelse>
                <cfset ST_ID = Application.Stranding.SampleTypeInsert(argumentCollection="#Form#")>
                <cfset form.ST_ID = "#ST_ID#">
                <cfif form.SADate neq "">
                    <cfset Application.Stranding.InsertSampleData(argumentCollection="#Form#")>
                </cfif>
            </cfif>
        <cfelse>
            <cfset SA_ID = Application.Stranding.SampleArchiveInsert(argumentCollection="#Form#")>
            <cfset form.SA_ID = "#SA_ID#">
            <cfif form.SampleID neq "">
                <cfset ST_ID = Application.Stranding.SampleTypeInsert(argumentCollection="#Form#")>
                <cfset form.ST_ID = "#ST_ID#">
                <cfif form.SADate neq "">
                    <cfset Application.Stranding.InsertSampleData(argumentCollection="#Form#")>
                </cfif>
            </cfif>
           
        </cfif>
    <cfelseif isDefined('delete')>
        <cfset Application.Stranding.DeleteSampleType("#form.STID#")>
        <cfset form.STID = "">
    <cfelseif isDefined('deleteallSampleArchiveRecord')>
        <cfset Application.Stranding.deleteallSampleArchiveRecord()>
        <!--- <cfset form.STID = ""> --->
    </cfif>
    <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->
   
    <cfif url.LCE_ID neq 0>
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.getSampleDataByLCE("#form.LCEID#")>
        <cfset qgetSampleData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>    
        <cfset qgetSampleDetailData = Application.Stranding.getSampleDetailDataSingle(STID="#form.LCEID#")>
        <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
            <cfset form.SEID = neworexist.ID>
        </cfif>
    </cfif>
    <!---   getting data on the basis of LCEID  --->
    <cfif  isDefined('form.SEID') and form.SEID neq "">
        <cfset qgetSampleData=Application.Stranding.getSampleArchiveData("#form.SEID#")>
        <cfset qgetSampleList=Application.Stranding.getSampleList("#form.SEID#")>
        <cfset qgetSampleFBNumberList=Application.Stranding.getSampleFBNumberList("#form.SEID#")>
        
        <!---  get all records order by ID  Desc of SampleType agianst SEID--->
        <cfset qgetSampleTypeIByID=Application.Stranding.getSampleTypeIByID("#form.SEID#")>
        
        <cfif  isDefined('form.STID') and form.STID neq "">
            <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleTypeDataSingle("#form.STID#")>
            <cfset qgetSampleDetailData = Application.Stranding.getSampleDetailDataSingle("#form.STID#")>
        <cfelse>
            <cfset qgetSampleTypeDataSingle=Application.Stranding.getSampleType_ten()>
        </cfif>
        <cfset qgetcetaceanDate=Application.Stranding.getcetaceanexamDate(#form.SEID#)>
        <!--- <cfdump var="#qgetcetaceanDate.CNRDATE#" abort="true">/ --->
    <cfelse>
        <cfset qgetSampleTypeIByID=Application.Stranding.getSampleType_ten()>
        <cfset qgetSampleTypeDataSingle = #qgetSampleTypeIByID#>
    </cfif>
    <!---  setup empty form when directly clicked the HI link from side bar --->
    <cfif url.LCE_ID eq 0 AND Not isDefined('form.SEID')>
        <cfset qgetSampleData=Application.Stranding.getSampleArchive_ten()>
        <cfset qgetcetaceanDate=Application.Stranding.getcetaceanexamDate_ten()>
        <!---  setup empty form when when entering new record --->
    <cfelseif  isDefined('form.SEID') AND form.SEID eq "">
        <cfset qgetSampleData=Application.Stranding.getSampleArchive_ten()>
    </cfif>
    <!---  get all records order by ID DESC--->
    <cfset getSampleID=Application.Stranding.getSampleArchiveID()>
    <cfset getmaindate=Application.Stranding.getmaindate()>
    <!--- <cfdump var="#getmaindate#" abort="true"> --->
    <!---  get all records order by Date Desc --->
    <cfset qgetSampleDate=Application.Stranding.getSampleArchiveDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetSampleFBNumber=Application.Stranding.getSampleArchiveFBNumber()>
    <cfoutput>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Sample Archive</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Sample Archive</h1>
            <!-- end page-header -->
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myform" action="#Application.siteroot#?Module=Stranding&Page=SampleArchive" method="post" >
                            <label for="sel1">Select Sample Archive</label>
                            <div class="input" id="propag"> 
                                <select class="form-control search-box" name="SEID" id="myList" onchange="this.form.submit()">
                                    <option value="">Select Sample</option>
                                        <cfloop query="getSampleID">
                                            <option value="#getSampleID.ID#" <cfif isDefined('form.SEID') and form.SEID eq #getSampleID.ID#>selected</cfif>>#getSampleID.ID#</option>
                                        </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <!--- working --->          
                 
           
                <input type="hidden" name="startValue" value="1001" id="startValue">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  id="dateform" action="#Application.siteroot#?Module=Stranding&Page=SampleArchive" method="post" >
                        <label for="sel1">Search Sample Archive By Date:</label>
                        <div class="input"> 
                            <input type="hidden" name="searchDate" value=""  id="searchDate" autocomplete="off">
                            <input type="search" placeholder="Search by date" focusMethod="hidefeild()" style="display:none; width:100%;" onkeyup="searchData()" name="search" value="" id="search"></input>

                            <select class="form-control" name="SEID" id="listDate" onchange="addMoreRecords(event)">
                                
                                <option  value="">Select Date</option>
                                <option id="addSearch" value="Search">Search</option>
                                <cfloop query="getmaindate">
                                    <option value="#getmaindate.SA_ID#" <cfif isDefined('form.SEID') and form.SEID eq #getmaindate.SA_ID#>selected</cfif>>#getmaindate.maindate#</option>
                                </cfloop>
                                <option id="loadMore" value="LoadMore">Load More</option>
                            </select>



                            <!--- <select placeholder="Pick a state..." name="SEID" id="listDate" onchange="addMoreRecords()">
                                <option  value="">Select Date</option>
                                   <cfloop query="getmaindate">
                                    <option value="#getmaindate.SA_ID#" <cfif isDefined('form.SEID') and form.SEID eq #getmaindate.SA_ID#>selected</cfif>>#getmaindate.maindate#</option>
                                    </cfloop>
                                <option id="loadMore" value="LoadMore">Load More</option>
                                <!--- <input type="button" value="Add Record" onclick = "addMoreRecords()"> --->
                              </select> --->
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  id="fieldform"action="#Application.siteroot#?Module=Stranding&Page=SampleArchive" method="post" >
                        <label for="sel1">Search Sample Archive By Field Number:</label>
                        <div class="input"> 
                            <input type="hidden" name="searchField" value="" id="searchField">
                            <input type="hidden" name="fielnumb" value="" id="fielnumb">
                            <select class="form-control search-box" name="SEID" id="fieldList" onchange="fieldnum()">
                                <option value="">Select Field Number</option>
                                <cfloop query="qgetSampleFBNumber">
                                    <option value="#qgetSampleFBNumber.ID#" <cfif isDefined('form.SEID') and form.SEID eq #qgetSampleFBNumber.ID#>selected</cfif>>#qgetSampleFBNumber.Fnumber#</option>
                                </cfloop>
                               
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <cfif isDefined('form.SEID') and form.SEID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text"  value="#qgetSampleData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>   
            </div>
            <form id="myform" action="#Application.siteroot#?Module=Stranding&Page=SampleArchive" method="post">
                <input type="hidden" name="histopathology_fields" value="1">
                <cfif isDefined('form.SEID') and qgetSampleData.LCE_ID neq "" and qgetSampleData.LCE_ID neq 0  >
                    <input type="hidden" name="LCE_ID" value="#qgetSampleData.LCE_ID#">
                    <!--- <input type="hidden" name="SEID" value="#qgetSampleData.ID#"> --->
                <cfelse>
                    <input type="hidden" class="saaad" name="LCE_ID" value="#url.LCE_ID#">
                </cfif>
                <cfif isDefined('form.SEID') and form.SEID neq '' >
                    <input type="hidden" name="SEID" value="#qgetSampleData.ID#">
                </cfif>

                <!--- <input type="hidden" name="LCE_ID" value="#qgetSampleData.LCE_ID#"> --->
                <div class="form-wrapper">  
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="sampleArchive-date-form form-group m-0 blue-bg-l">
                                    <div class="row">
                                        <div class="col-lg-12 p-0">
                                            <div class="col-lg-8 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="field-number fie-padd">Field Number</label>
                                                        <div class="input inpt">
                                                            <input type="text" value="#qgetSampleData.Fnumber#" class="form-control inpts" name="Fnumber" id="Fnumber" required>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-8 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="date-padd ceta-padd">Cetacean Exam Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <input type="text" placeholder="YYYY-MM-DD" name="cetaceanexamdate" id="date"
                                                                class="form-control" value='#DateTimeFormat(qgetcetaceanDate.date, "YYYY-MM-DD")#' readonly/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-8 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="date-padd necr-padd">Necropsy Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date2">
                                                            <input type="text" placeholder="YYYY-MM-DD" name="necropsydate" id="necropsydate"
                                                                class="form-control" value='#DateTimeFormat(qgetcetaceanDate.CNRDATE, "YYYY-MM-DD")#' readonly/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <!--- <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="start-time">Start Time</label>
                                                        <div class="input-group date " id="datetimepicker_StartTime">
                                                            <input type="text" value="#TimeFormat(qgetSampleData.StartTime, "HH:nn")#" placeholder="hh:mm:ss" name="StartTime" id="StartTime"
                                                                class="form-control" />
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="end-time">End Time</label>
                                                    <div class="input-group date" id="datetimepicker_EndTime">
                                                        <input type="text"  value="#TimeFormat(qgetSampleData.EndTime, "HH:nn")#" placeholder="hh:mm:ss" name="EndTime" id="EndTime"
                                                            class="form-control" />
                                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                    </div>
                                                </div>
                                            </div>  --->
                                            
                                            <!--- <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">NMFS Regional ##</label>
                                                        <input class="input-style xl-width" type="text" value="#qgetSampleData.NMFS#" name="NMFS" id="NMFS">
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">National Database ##</label>
                                                        <input class="input-style xl-width" type="text" value="#qgetSampleData.NDB#" name="NDB" id="NDB">
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-12 col-md-12"> 
                                                <div class="form-group m-0">
                                                    <div class="input-group flex-center">
                                                        <label class="">Standing Agreement or Authority</label>
                                                        <div class="input">
                                                            <input class="input input-style" type="text" value="#qgetSampleData.NAA#" name="NAA" id="NAA">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  --->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="form-group m-0">
                                    <div class="row">
                                        <div class="col-lg-12 p-0 green-labels">
                                            <div class="col-lg-12">
                                                <div class="form-group input-group flex-center">
                                                    <label>Team Members</label>
                                                    <div class="input"> 

                                                            <select class="form-control search-box" multiple="multiple" name="ResearchTeam"
                                                            id="ResearchTeam">
                                                            <cfloop query="getTeams">
                                                                <cfif active eq 1>
                                                                    <option value="#getTeams.RT_ID#" <cfif ListFind(ValueList(qgetSampleData.ResearchTeam,","),getTeams.RT_ID)>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group input-group flex-center">
                                                    <label class="veterinarian">Veterinarian</label>
                                                    <div class="input">
                                                        <select class="form-control search-box" multiple="multiple" name="Veterinarian" id="Veterinarian">
                                                            <cfloop query="qgetVeterinarians">
                                                                <cfif status eq 1>
                                                                    <option value="#qgetVeterinarians.ID#" <cfif ListFind(ValueList(qgetSampleData.Veterinarian,","),qgetVeterinarians.ID)>selected</cfif>>#qgetVeterinarians.Veterinarians#</option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                            <div class="col-lg-12"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">Body of Water</label>
                                                        <div class="input">
                                                            <select class="combobox form-control search-box" multiple="multiple" name="BodyOfWater">
                                                                <cfloop query="getSurveyAreaData">
                                                                    <cfif active eq 1>
                                                                        <option value="#getSurveyAreaData.ID#" <cfif ListFind(ValueList(qgetSampleData.BodyOfWater,","),getSurveyAreaData.ID)>selected</cfif>>#getSurveyAreaData.AreaName#</option>
                                                                    </cfif>
                                                                </cfloop>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group flex-center">
                                                    <label class="">Species</label>
                                                    <div class="input">
                                                        <select class="form-control selectCustomReset" name="species" id="species">
                                                            <cfloop query="qgetCetaceanSpecies">
                                                                <cfif active eq 1>
                                                                    <option value="#qgetCetaceanSpecies.id#" <cfif #qgetCetaceanSpecies.id# eq #qgetSampleData.species#>selected</cfif>>
                                                                        #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group input-group flex-center">
                                                    <label class="veterinarian">Stranding Type</label>
                                                    <div class="input">
                                                        <select class="form-control" name="StTpye" id="StTpye">
                                                            <option value="">Select Stranding Type</option>
                                                            <cfloop query="qgetStrandingType">
                                                                <cfif status eq 1>
                                                                    <option value="#qgetStrandingType.ID#" <cfif #qgetStrandingType.ID# eq #qgetSampleData.StTpye#>selected</cfif>>#qgetStrandingType.type#</option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12"> 
                                                <div class="form-group m-0">
                                                    <div class="input-group flex-center">
                                                        <label class="">NOAA Stock</label>
                                                        <div class="input">
                                                            <select class="combobox form-control search-box" multiple="multiple" name="NOAAStock" id="stock_value">
                                                                <option value="">Select NOAA Stock</option>
                                                                <cfloop query="getStock">
                                                                    <cfif active eq 1>
                                                                        <option class="stock_value" value="#getStock.ID#" <cfif ListFind(ValueList(qgetSampleData.NOAAStock,","),getStock.ID)>selected</cfif>>
                                                                            #getStock.StockName#</option>
                                                                    </cfif>
                                                                </cfloop>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!---  Following logic to get the data from the HI table and seting value to qgetSampleData variable --->
                    <!--- <cfset qgetSampleData=Application.Stranding.getSampleType_ten()> --->
                <input type="hidden"  name="ST_ID" value="#qgetSampleTypeDataSingle.ID#">
                <input type="hidden" name="fielnumb" value="" id="fielnumb">

                <div class="form-holder">  
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="samples-label">Samples</label>
                                        <select class="form-control" name="STID" id="STID" onChange="this.form.submit()">
                                            <option value="">Add New Sample</option>
                                            <cfloop query="qgetSampleTypeIByID">
                                                <option value="#qgetSampleTypeIByID.ID#" <cfif #qgetSampleTypeDataSingle.ID# eq #qgetSampleTypeIByID.ID#>
                                                selected</cfif>>#qgetSampleTypeIByID.SampleID#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row rowbutton">
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6"> 
                                <div class="form-input-holder">
                                    <div class="form-group flex-center">
                                        <label class="">Sample Date</label>
                                        <div class="input-group date " id="datetimepicker_Date_sample">
                                            <input type="text" placeholder="YYYY-MM-DD" name="Sample_Date" id="Sample_Date"
                                                class="form-control" value='#DateTimeFormat(qgetSampleTypeDataSingle.Sample_Date, "YYYY-MM-DD")#' />
                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 offset-md-4 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-input-holder">
                                    <div class="form-group input-group flex-center">
                                        <label class="">Sample Location</label>
                                        <select class="form-control" name="Sample_Location" id="Sample_Location">
                                            <option value="">Select Sample Location</option>
                                            <cfloop query="#qgetSampleLocation#">
                                                <cfif status eq 1>
                                                    <option value="#qgetSampleLocation.Location#"<cfif #qgetSampleLocation.Location# eq #qgetSampleTypeDataSingle.Sample_Location#>
                                                        selected</cfif>>#qgetSampleLocation.Location#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="sample-label">Sample ID</label>
                                        <input class="input-style xl-width" type="text" value="#qgetSampleTypeDataSingle.SampleID#" name="SampleID" id="SampleID" required>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="bin-label">Bin Number</label>
                                        <select class="form-control" name="BinNumber" id="BinNumber">
                                            <option value="">Select Bin Number</option>
                                            <cfloop query="qgetBinNumber">
                                                <cfif status  neq 0>
                                                    <option value="#qgetBinNumber.Bin_Number#" <cfif #qgetBinNumber.Bin_Number# eq #qgetSampleTypeDataSingle.BinNumber#>selected</cfif>>#qgetBinNumber.Bin_Number#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>                
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="county-label extra-w ">Sample Type</label>
                                        <select class="form-control search-box" name="SampleType" id="SampleType">
                                            <option value="">Select Sample Type</option>
                                            <cfloop query="qgetSampleType">
                                                <cfif status  neq 0>
                                                    <option value="#qgetSampleType.Type#" <cfif #qgetSampleType.Type# eq #qgetSampleTypeDataSingle.SampleType#>selected</cfif>>#qgetSampleType.Type#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>                
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="county-label">Preservation Method</label>
                                        <select class="form-control" name="PreservationMethod" id="PreservationMethod">
                                            <option value="">Select Preservation Method</option>
                                            <cfloop query="qgetPreservationMethod">
                                                <cfif status  neq 0>
                                                    <option value="#qgetPreservationMethod.Method#" <cfif #qgetPreservationMethod.Method# eq #qgetSampleTypeDataSingle.PreservationMethod#>selected</cfif>>#qgetPreservationMethod.Method#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="am-l">Amount of Sample</label>
                                        <input class="input-style xl-width" type="number" value="#qgetSampleTypeDataSingle.AmountofSample#" name="AmountofSample" id="AmountofSample">
                                    </div>
                                </div>
                            </div>  
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="county-label">Unit of Sample</label>
                                        <select class="form-control" name="UnitofSample" id="UnitofSample">
                                            <option value="">Select Unit of Sample</option>
                                            <cfloop query="qgetUnitofsample">
                                                <cfif status  neq 0>
                                                    <option value="#qgetUnitofsample.Unit#" <cfif #qgetUnitofsample.Unit# eq #qgetSampleTypeDataSingle.UnitofSample#>selected</cfif>>#qgetUnitofsample.Unit#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>               
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="county-label extra">Storage Type</label>
                                        <select class="form-control" name="StorageType" id="StorageType">
                                            <cfloop from="1" to="#ArrayLen(StorageTypeArray)#" index="j">
                                                <option value="#StorageTypeArray[j]#" <cfif #StorageTypeArray[j]# eq #qgetSampleTypeDataSingle.StorageType#>selected</cfif>>#StorageTypeArray[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12 s-content">
                                <div class="form-group flex-center">
                                    <label class="scomment-label">Sample Comments</label>
                                    <textarea class="form-control textareaCustomReset locations-textarea" name="SampleComments" id="SampleComments"
                                        maxlength="75">#qgetSampleTypeDataSingle.SampleComments#</textarea>
                                </div>
                            </div> 
                             <!--- Buttons Section--->
                
                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <!--- <div class="flex-center flex-row flex-wrap"> --->
                        <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4 s-content two-btn">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save and New" onclick="chkreq(event)">
                            <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" value="Save and Close" name="SaveAndClose" onclick="chkreq(event)">
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.STID') and form.STID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){deleteit()}else{return false;};" >
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                <input type="submit" id="deleteallSampleArchiveRecord" name="deleteallSampleArchiveRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records ?')){deleteit()}else{return false;};" >
                            </cfif>
                        </div>
                        <!--- <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4 s-content">
                            <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" value="Save and Close" name="SaveAndClose" onclick="chkreq(event)">                        
                        </div> --->
                        <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4 s-content">
                            
                        </div>
                            
                        
                    <!--- </div> --->
                </cfif>            
                        </div>
                    </div>
                </div>
                <!---Sample Collection --->
                <div class="form-holder blue-bg sample-accession-form">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6"> 
                            <div class="form-input-holder">
                                <div class="form-group flex-center">
                                    <label class="">Sample Accession Date</label>
                                    <div class="input-group date " id="datetimepicker_Date_sad">
                                        <input type="text" placeholder="YYYY-MM-DD" name="SampleAccessionDate" id="SampleAccessionDate"
                                            class="form-control" value='' />
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div>
                                </div>
                                <input type="hidden" value="" name="SADate" id="sad">
                                <span id="sampleDate" class="sampleDate_error"></span>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="">Sample Location</label>
                                    <select class="form-control" id="SampleLocation">
                                        <option value="">Select Sample Location</option>
                                        <cfloop query="#qgetSampleLocation#">
                                            <cfif status eq 1>
                                                <option value="#qgetSampleLocation.ID#">#qgetSampleLocation.Location#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="SampleLocation" id="SL">
                                <span id="sampleLocation" class="sampleLocation_error"></span>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="">Sample Tracking</label>
                                    <select class="form-control" id="SampleTracking" onchange="check()">
                                        <option value="">Select Sample Tracking</option>
                                        <cfloop query="#qgetSampleTracking#">
                                            <cfif status eq 1>
                                                <option value="#qgetSampleTracking.ID#">#qgetSampleTracking.Current_Location#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="SampleTracking" id="ST">
                                <span id="sampleTracking" class="sampleTracking_error"></span>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="lab-label">Lab Sent to</label>
                                    <select class="form-control" id="LabSentto">
                                        <option value="">Select Lab Sent to</option>
                                        <cfloop query="#qgetDiagnosticLab#">
                                            <cfif status eq 1>
                                                <option value="#qgetDiagnosticLab.ID#">#qgetDiagnosticLab.Diagnostic#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="LabSentto" id="lsto">
                                <span id="labsentto" class="labSent_error"></span>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group flex-center">
                                    <label class="snotes-label">Sample Note</label>
                                    <textarea type="text" class="form-control textareaCustomReset locations-textarea" id="SampleNote" maxlength="75"></textarea>
                                </div>
                                 <input type="hidden" name="SampleNote" id="snotes">
                                <span id="sampleNote" class="sampleNote_error"></span>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6"></div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6" id="subsampleDatee"> 
                            <div class="form-input-holder">
                                <div class="form-group flex-center">
                                    <label class="">Subsampled Date</label>
                                    <div class="input-group date " id="datetimepicker_Date_subsample">
                                        <input type="text" placeholder="YYYY-MM-DD" name="subsampleDate" id="subsampleDate"
                                            class="form-control" value='' />
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div>
                                </div>
                                <input type="hidden" value="" name="subsampleDate" id="sub">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6" id="Thawedd">
                            <div class="form-group">
                                <div class="input-group flex-center" >
                                    <label class="county-label">Thawed</label>
                                    <select class="form-control" id="Thawed" >
                                        <option val="0">Select Thawed</option>
                                        <cfloop from="1" to="#ArrayLen(ThawedArray)#" index="j">
                                            <option value="#ThawedArray[j]#">#ThawedArray[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="Thawed" id="Thaw">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6" id="subsamplee">
                            <div class="form-group">
                                <div class="input-group flex-center" >
                                    <label class="county-label">Sample Availability</label>
                                    <select class="form-control" id="subsample" >
                                        <option val="0">Select Availability</option>
                                        <cfloop from="1" to="#ArrayLen(Availbility)#" index="j">
                                            <option value="#Availbility[j]#">#Availbility[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="subsample" id="Avail">
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <input type="button" class="btn btn-success ml-auto" id="drugsNew" value="Add New" onClick="AddNewDrug()"/>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="simple-accession-table">
                                <div class="responsive-tale">
                                    <table class="table table-bordered table-hover" id="drugHistory" <cfif isDefined('qgetSampleDetailData') AND #qgetSampleDetailData.recordcount# gt 0><cfelse> hidden</cfif>>
                                        <thead>
                                            <tr>
                                                <th>Sample Accession Date</th>
                                                <th>Sample ID</th>
                                                <th>Sample Location</th>
                                                <th>Sample Tracking</th>
                                                <th>Lab Sent to</th>
                                                <th>Sample Note</th>
                                                <th>Subsampled Date</th>
                                                <th >Sample Availability</th>
                                                <th >Thawed</th>
                                                <cfif isDefined('qgetSampleDetailData')>
                                                    <th >Action</th>
                                                </cfif>    
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <cfif isDefined('qgetSampleDetailData')>
                                                <cfloop query="qgetSampleDetailData">
                                                    <!--- <tr id= #ID#> --->
                                                    <tr id="tr_#ID#">
                                                        <td id="idd" hidden>#ID#</td>
                                                        <td id="date#ID#">#qgetSampleDetailData.SADate#</td>
                                                        <td >#qgetSampleTypeDataSingle.SampleID#</td>
                                                        <td id="location#ID#">#qgetSampleDetailData.SampleLocation#</td>
                                                        <td id="track#ID#">#qgetSampleDetailData.SampleTracking#</td>
                                                        <td id="labsent#ID#">#qgetSampleDetailData.LabSentto#</td>
                                                        <td id="samplenotes#ID#"><cfif #qgetSampleDetailData.SampleNote# neq 0>#qgetSampleDetailData.SampleNote#</cfif></td>
                                                        <td id="subdate#ID#"><cfif #qgetSampleDetailData.subsampleDate# neq 0>#qgetSampleDetailData.subsampleDate#</cfif></td>
                                                        <td id="availbility#ID#"><cfif #qgetSampleDetailData.Sample_available# neq 0 and #qgetSampleDetailData.Sample_available# neq 'Select Availability'>#qgetSampleDetailData.Sample_available#</cfif></td>
                                                        <td id="thawed#ID#"><cfif #qgetSampleDetailData.Thawed# neq 'Select Thawed' and #qgetSampleDetailData.Thawed# neq 0>#qgetSampleDetailData.Thawed#</cfif></td>
                                                        <td>
                                                            <div class="tablebutn" style="display: inline-flex;">
                                                                <input type="button" id="edit_button#ID#" value="Edit" class="edit" onclick="edit_row(#ID#)">
                                                                <input type="button" value="Delete"  class="delete" onclick="delete_row(#ID#)" style="margin-left: 5%;">
                                                            </div>
                                                            
                                                        </td>
                                                    </tr>
                                                </cfloop>
                                            </cfif>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="idForUpdate" value="">
                <div class="form-holder blue-bg"<cfif isDefined('qgetSampleTypeIByID') AND #qgetSampleTypeIByID.recordcount# gt 0><cfelse> hidden</cfif>>
                    <div class="row">
                        <div class="col-lg-12 cut-tabl">
                            <div class="simple-t-sec">
                                <div class="simple-t-row">
                            <table class="table table-bordered table-hover" id="lasttable" >
                                <thead>
                                    <tr>
                                        <th>Sample ID</th>
                                        <th>Bin Number</th>
                                        <th>Sample Type</th>
                                        <th>Preservation Method</th>
                                        <th>Amount of sample</th>
                                        <th>Unit of sample</th>
                                        <th>Storage Type</th>
                                        <th>Sample Comments</th>
                                        <cfif isDefined('qgetSampleData')>
                                         <th>Date</th>
                                        </cfif>
                                        <th>Date2</th>
                                        <cfif isDefined('qgetSampleDetailData')>
                                            <cfset c = 2>
                                            <cfloop index="index" from="1" to="#qgetSampleDetailData.recordcount#">
                                                <cfset c = incrementValue(#c#)>
                                                <th>Date#c#</th>
                                            </cfloop>
                                        </cfif>
                                        <th>Location</th>
                                        <cfif isDefined('qgetSampleDetailData')>
                                            <cfset c = 1>
                                            <cfloop index="index" from="1" to="#qgetSampleDetailData.recordcount#">
                                                <cfset c = incrementValue(#c#)>
                                                <th>Location#c#</th>
                                            </cfloop>
                                        </cfif>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetSampleTypeIByID')>
                                        <cfloop query="qgetSampleTypeIByID">
                                            <tr>
                                                <td>#qgetSampleTypeIByID.SampleID#</td>
                                                <td>#qgetSampleTypeIByID.BinNumber#</td>
                                                <td>#qgetSampleTypeIByID.SampleType#</td>
                                                <td>#qgetSampleTypeIByID.PreservationMethod#</td>
                                                <td>#qgetSampleTypeIByID.AmountofSample#</td>
                                                <td>#qgetSampleTypeIByID.UnitofSample#</td>
                                                <td>#qgetSampleTypeIByID.StorageType#</td>
                                                <td>#qgetSampleTypeIByID.SampleComments#</td>
                                                <!--- <cfif isDefined('qgetSampleData')> --->
                                                    <td id="archivedate">#qgetSampleTypeIByID.maindate#</td>
                                                <!--- </cfif> --->
                                                <td>#qgetSampleTypeIByID.Sample_Date#</td>
                                                <cfif isDefined('qgetSampleDetailData')>
                                                    <cfloop query="qgetSampleDetailData">
                                                        <td>#qgetSampleDetailData.SADate#</td>
                                                    </cfloop>    
                                                </cfif>
                                                <td>#qgetSampleTypeIByID.Sample_Location#</td>
                                                <cfif isDefined('qgetSampleDetailData')>
                                                    <cfloop query="qgetSampleDetailData">
                                                        <td>#qgetSampleDetailData.SampleLocation#</td>
                                                    </cfloop>    
                                                </cfif>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                    </div>
                </div>
               
            </form>
            <div class="row" style="float:right">
                <form id="myform" enctype="multipart/form-data" action="" method="post" >
                    <div class="col-lg-6 col-md-4">
                        <div class="form-group input-group select-width">
                            <cfif (permissions eq "full_access")>
                                <input type="file" name="sampleFile" required>
                            </cfif>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <cfif (permissions eq "full_access")>
                                <button type="submit" class="btn btn-success">Import</button>
                            </cfif>
                        </div>
                    </div>    
                </form>
            </div>
           
        </div>
    </cfoutput>

    <style>

    .col-lg-2.col-md-4.col-sm-4.col-xs-4.s-content.two-btn{
        display: flex;
    }

    .inpt {
        margin-left: 0px !important;
    }
    .fie-padd {
        padding-right: 49px !important;
    }
    .ceta-padd {
        padding-right: 8px !important;
    }
    .necr-padd {
        padding-right: 43px !important;
    }

    /* @media (max-width: 1280px) {
        .inpts {
        width: 155px !important;
        }
    } */

    /* @media (max-width: 1024px) {
        .inpts {
        width: 100% !important;
        }
    } */
    

.county-label.extra-w {
    width:40%;
}
.county-label.extra {
    width:58%;
}


    .select2-container--default .select2-selection--single .select2-selection__rendered {width: 142px;}
       label.snotes-label {
    margin: auto !important;
}
.row {
    margin: 0 -10px;
    /* display: flex; */
    flex-wrap: wrap;
}
.simple-t-sec,.simple-accession-table{
    overflow-x: auto;
}
.s-content {
    clear: both;
}
    .form-input-holder label {
    width: 69%;
}
        input[type="file"] {
        display: block;
        }
        .imageThumb {
        max-height: 132px;
        border: 4px solid;
        cursor: pointer;
        }
        .pip {
        display: inline-block;
        margin: 10px 10px 0 0;
        }
        .remove {
        display: block;
        background: #444;
        border: 1px solid black;
        color: white;
        text-align: center;
        cursor: pointer;
        }
        .remove:hover {
        background: white;
        color: black;
        }
        .sample-accession-form .form-group {
            margin: 5px;
        }
        .form-holder{
            background-color: #fff;
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #30373e73;
            box-shadow: 0px 0px 5px 5px #30373e1c;
        }
        .input-group {
            width: 100%;
        }
        .select2-container--default .select2-selection--single {
            border-radius: 0;
        }
        .flex-center{
            display: flex; 
            justify-content: space-between;
            align-items: center;
        }
        label {
            font-weight: 400;
            margin-bottom: 0;
            padding-right: 5px;
            min-width: fit-content;
        }
        .input{
            width: 100%;
        }
        .mb-1{
        margin-bottom: 10px;
        }
        .mb-2{
        margin-bottom: 20px;
        }
        .mb-3{
        margin-bottom: 30px;
        }
        .mb-5{
            margin-bottom: 50px;
        }
        .mt-1{
        margin-top: 10px;
        }
        .mt-2{
        margin-top: 20px;
        }
        .p-0{
            padding: 0;
        }
        .pl-0{
        padding-left: 0; 
        }
        .pr-0{
        padding-right: 0; 
        }
        .pb-2{
        padding-bottom: 15px !important; 
        }
        .p-rl-4{
            padding: 0 4px;
        }
        .m-rl-4{
            margin: 0 4px;
        }
        .m-0{
            margin: 0;
        }
        /* #propag .form-control {
            height: 30px;
        } */
        .blue-bg{
            background-color: #add8e6;
            padding-bottom: 70px;
        }
        .blue-bg-l{
            background-color: #add8e6;
            padding-bottom: 119px;
        }
        .saperator{
            border-top: 1px solid #c1c1c1;
            margin: 20px 0 30px;
        }
        .physical-exam textarea{
            min-height: 120px;
            resize: none;
        }
        .locations-textarea{
            min-height: 120px;
            resize: none;
        }
        .results-textarea{
            min-height: 52px;
            resize: none;
        }
        .release-textarea{
            min-height: 197px;
            padding: 12px !important;
            font-style: italic;
            border: none;
            resize: none;
        }
        .justify-content-end{
            display: flex;
            justify-content: flex-end;
        }
        .full-width{
            width: 100%;
        }
        .blue-btn{
            background-color: #0b36b5;
            color: #FFF;
        }
        .blue-btn:hover{
            color: #FFF;
            
        }
        .btn-skyblue{
            background-color: #4472c4;
            color: #FFF;
        }
        .sample-accession-form .form-input-holder {
            margin-bottom: 15px;
        }
        .sampleTracking_error, .sampleNote_error, .sampleDate_error, .labSent_error, .sampleLocation_error{
            font-style: oblique;
            color: red;
            margin-left: 0;
            width: 100%;
            display: block;
            text-align: center;
        }
        .btn-skyblue:hover{
            color: #FFF;
        }
        .sample-accession-form .form-group {
            margin: 5px;
            align-items: inherit;
        }
        .sample-accession-form .form-group label {
            margin-top: 4px;
            width: 75%;
            min-width: fit-content;
        }
        .btn-pink{
            background-color: #be44c4;
            color: #FFF;
        }
        .btn-pink:hover{
            color: #FFF;
        }
        .btn-green{
            background-color: #70ad47;
            color: #FFF;
        }
        .btn-green:hover{
            color: #FFF;
        }
        .btn-orange{
            background-color: #ed7d31;
            color: #FFF;
        }
        .btn-orange:hover{
            color: #FFF;
        }
        .form-control{
            height: 30px;
            padding: 0px 12px;
            border-radius: 0;
        }
        .select2-container .select2-selection--single {
            height: 30px!important;
            padding: 0px 12px!important;
            display: flex !important;
            align-items: center;
        }
        .form-wrapper .input-style {
            border: 2px solid #bec3c6;
            color: #30373F;
            height: 30px;
            padding: 0px 12px;
        }
        .form-wrapper  .focus-visible {
            border-color: #8d9aa5;
            border-radius: 0;
        }
        .form-holder .input-style {
            border: 2px solid #bec3c6;
            background: #FFF;
            color: #30373F;
            height: 30px;
            padding: 0px 4px;
        }
        .form-holder .focus-visible {
            border-color: #8d9aa5 !important;
            border-radius: 0;
        }
        .weight-input{
            width: 43%;
        }
        .weight-input-two{
            width: 68%;
        }
        .time-icon {
            padding: 4px 10px;
            border-width: 0px;
            border: 2px solid #bec3c6;
        }
        .body-water .select2-container--default .select2-selection--multiple {
            background-color: #fff !important;
            border: 2px solid #bec3c6 !important;
            border-radius: 0 !important;
        }
        .body-water span{
            width: 100% !important;
        }
        .xl-width{
            width: 100%;
        }
        .rosturn-text{
            font-style: italic;
            padding-left: 6px;
        }
        .fishone-width{
            width: 59%;
        }
        .fishone-width{
            width: 59%;
        }
        .end-time{
            padding-right: 52px;
        }
        .start-time{
            padding-right: 63px;
        }
        .body-of-water{
            padding-right: 10px;
        }
        .veterinarian{
            padding-right: 9px;
        }
        .field-number{
            padding-right: 45px;
        }
        .lat-one{
            padding-right: 65px;
        }
        .lon-one{
            padding-right: 62px;
        }
        .code-padd{
            padding-right: 25px;
        }
        .btn {
            padding: 0 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 30px;
        }
        .date-padd{
            padding-right: 81px;
        }
        .taged-type{
            padding-right: 27px;
        }
        .last-lat{
            padding-right: 8px;
        }
        .rate-wrap .time-icon{
            position: relative;
            left: -32px;
            border: 2px solid #bec3c6;
        }
        .rate-wrap .input-group{
            max-width: 102px;
        }
        .rate-wrap .input-type-time{
            max-width: 102px;
        }
        .rate-wrap label{
            padding-right: 39px;
        }
        .resp-rate{
            padding-right: 8px;
        }
        .refil-padd{
            padding-left: 25px !important;
        }
        .fishone-labelone{
            padding-right: 20px;
        }
        .fishone-labeltwo{
            padding-right: 21px;
        }
        .fishone-labelthree{
            padding-right: 17px;
        }
        .fishone-labelfour{
            padding-right: 19px;
        }
        .drug-time .input-type-time {
            max-width: 102px;
        }
        .drug-time .input-group{
            max-width: 102px;
        }
        .drug-time .time-icon{
            position: relative;
            left: -34px;
            border: 2px solid #bec3c6;
        }
        .first-date input {
            width: 100%;
        }
        .first-date .time-icon {
            padding: 6px 10px;
            width: 36px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .first-date input[type="date"]::-webkit-calendar-picker-indicator {
            display: none;
            -webkit-appearance: none;
        }
        .fishtwo-labelone {
            padding-right: 22px;
        }
        .fishtwo-labeltwo {
            padding-right: 37px;
        }
        .fishtwo-labelthree {
            padding-right: 42px;
        }
        .fishtwo-labelfour {
            padding-right: 35px;
        }
        .fishtwo-labelfive {
            padding-right: 12.5px;
        }
        .fishtwo-labelsix {
            padding-right: 25px;
        }
        .weight-input-three {
            width: 64%;
        }
        .green-labels label {
            min-width: 20%;
            background: #3C454D;
            box-shadow: 0 1px #24292e;
            font-size: 12px;
            color: #3dde42;
            min-height: 34.56px;
            border-radius: 4px 0 0 4px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .green-labels .input select { 
            height: 35px;
        }
        .green-labels .input span{ 
            width: 100% !important;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice {
            margin-right: 25px;
            position: relative;
        }
        .green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            position: absolute;
            right: -12px;
            width: 20px !important;
            height: 100% !important;
        }
        .select-width span{ 
            width: 100% !important;
        }
        .weight-input-four {
            width: 78.5%;
        }
        .history-label {
            padding-right: 19px;
        }
        .ageclass-label {
            padding-right: 33px;
        }
        .am-l{
            width: 70%;
        }
        .county-label {
            /* padding-right: 10px; */
            width: 69%;
        }
        .sample-label {
            /* padding-right: 54px; */
            width: 70%;
        }
        .bin-label {
            /* padding-right: 26px; */
            width: 69%;
        }
        label.scomment-label {
    width: 25%;
}
        .samples-label {
            /* padding-right: 64px; */
            width: 44%;
        }
        /* .scomment-label {
            padding-right: 19px;
        } */
        .lab-label {
            padding-right: 20px;
        }
        /* .snotes-label {
            padding-right: 26px;
        } */
        .sex-label {
            padding-right: 76px;
        }
        .sample-accession-form row{
           display: flex;
            flex-wrap: wrap;
            align-items: center; 
        }
        .form-holder.blue-bg.sample-accession-form .row {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
        }
        .sample-accession-form .col-lg-12 {
            width: 100%;
        }
        .simple-accession-table .responsive-tale table td{
            word-break: break-all;
        }
        .simple-t-sec .dataTables_scrollHeadInner table.table.table-bordered.table-hover.dataTable,
        .simple-t-sec .dataTables_scrollHeadInner, 
        ..dataTables_scrollBody table.table.table-bordered.table-hover.dataTable  {
            min-width: 100%;
        }

        @media (min-width: 1700px) {
            .simple-t-sec .dataTables_scrollHeadInner table.table.table-bordered.dataTable {
                min-width: 100%;
            }
            .simple-t-sec .dataTables_scrollHeadInner {
                min-width: 100%;
            }
            .simple-t-sec .dataTables_scrollBody table.table.table-bordered.dataTable {
                min-width: 100%;
            }
        }
        @media (max-width:1800px){
            .county-label.extra-w {
            width:44%;
        }
        }
        @media (max-width: 1500px){
            .am-l,.sample-label,.form-input-holder label,.samples-label,.bin-label,.county-label,label.scomment-label {
    min-width: auto;
}
}
@media (max-width: 1200px){
    .county-label {
    width: 74%;
}
.samples-label {
    width: 37%;
}
.am-l {
    width: 65%;
}
}
        }
        @media (max-width: 1399px){
            .sampleArchive-date-form .form-group.flex-center {
            flex-wrap: wrap;
            }
            .sampleArchive-date-form .input-group.flex-center {
            flex-wrap: wrap;
            }
            .sample-accession-form .form-group {
                flex-wrap: wrap;
            }
            .sample-accession-form .form-group label {
                margin-top: 4px;
            }
            .sampleTracking_error, .sampleNote_error, .sampleDate_error, .labSent_error, .sampleLocation_error{
                text-align: left;
            }
            .sampleArchive-date-form.form-group.m-0.blue-bg-l {
                padding: 0;
            }
        }
        @media (max-width: 1199px){
            .sampleArchive-date-form .form-group.flex-center {
            flex-wrap: nowrap;
            }
            .sampleArchive-date-form .input-group.flex-center {
            flex-wrap: nowrap;
            }
        }
        @media (max-width:1510px){
            .rosturn-text {
                display: block;
            }
            .weight-input {
                max-width: 52px;
            }
            .heartrate-two{
                padding-left: 20px !important;
            }
        }
        @media (max-width: 1400px){
            label.snotes-label {
    margin: unset !important;
}
        }
        @media (max-width:1439px){
            .flex-wrap{
                flex-wrap: wrap;
                justify-content: center;
                margin-bottom: 15px;
            }
            .sample-one{
                width: 75%;
            }
            .sample-two{
                width: 25%;
            }
            .heartrate-one{
                width: 35%;
            }
            .heartrate-two{
                width: 35%;
                padding-left: 10px !important;
            }
            .heartrate-full{
                width: 100%;
            }
            .drug-width{
                width: 25%;
            }
            .rate-wrap label{
                padding-right: 30px;
            }
            .refil-padd{
                padding-left: 10px !important;
            }
        }
        @media (max-width:1325px){
            .green-labels label {
                min-width: 30%;
            }
        }
        @media (max-width:1281px){
            .weight-input {
                max-width: 20px;
            }
        }
        @media (max-width:1254px){
            .weight-input-two {
                max-width: 38px;
            }
        }
        @media (max-width:1199px){
            .m-rl-4 {
                margin: 4px;
            }
            input{
                width: 100%;
            }
            .btn{
                max-width: fit-content;
            }
            .bottons-wrap  .btn{
                max-width: 100%;
            }
            .radio-btn input{
                width: auto;
            }
            .bottons-wrap{
                width: 40%
            }
            .locations-textarea {
                min-height: 80px;
            }
            .physical-exam textarea {
                min-height: 80px;
            }
            .sample-one{
                width: 100%;
            }
            .sample-two{
                width: 100%;
            }
            .heartrate-one{
                width: 50%;
            }
            .heartrate-two{
                width: 50%;
            }
            .heartrate-one .btn.btn-success{
            margin-left: auto;
            }
            .heartrate-two .btn.btn-success{
            margin-left: auto;
            }
            .blue-bg {
                padding-bottom: 20px;
            }
            .blue-bg-l {
                padding-bottom: 20px;
            }
            .weight-input-two {
                max-width: 52px;
            }
            .drug-width {
                width: 33.33%;
            }
            .mb-5 {
                margin-bottom: 20px;
            }
            .body-of-water{
                padding-right: 5px;
            }
            .veterinarian{
                padding-right: 5px;
            }
            .lat-one{
                padding-right: 5px;
            }
            .code-padd{
                padding-right: 5px;
            }
            .rate-wrap label{
                padding-right: 39px;
            }
            /* .ml-auto{
                margin-left: auto;
            } */
            .weight-input-three {
                width: 64%;
            }
            .rate-wrap .input-type-time {
                min-width: 102px;
            }
            .drug-time .input-type-time {
                min-width: 102px;
            }
            .weight-input-four {
                width: 65%;
            }
            .weight-input {
                max-width: 71px;
            }
            .simple-accession-table,.simple-t-sec {
                overflow-x: auto;
            }
            .cut-tabl {
    overflow: hidden;
}
            .simple-accession-table .responsive-tale,.simple-t-sec .simple-t-row{
                width: 855px;
            }
        }
        @media (max-width:991px){
            .bottons-wrap{
                width: 48%
            }
            .weight-input {
                width: 44%;
            }
            .mb-5{
                margin-bottom: 0;
            }
            .fishone-width{
                width: 100%;
            }
            .drug-width {
                width: 50%;
            }
            .date-padd{
                padding-right: 5px;
            }
            .taged-type{
                padding-right: 5px;
            }
            .last-lon{
                padding-right: 5px;
            }
            .heartrate-one{
                width: 50%;
            }
            .heartrate-two{
                width: 50%;
            }
            label{
                min-width: auto;
            }
            .flex-center {
                flex-direction: column;
                align-items: flex-start;
            }
            .flex-row {
                    flex-direction: row;
            }
            .rate-wrap{
                    flex-wrap: wrap;
                    align-items: center;
                    justify-content: flex-start;
            }
            .drug-width .btn.btn-success {
                margin-top: 15px;
            }
            .first-date .time-icon {
                position: absolute;
                top: 18.5px;
                right: 9px;
            }
            .green-labels .flex-center {
                flex-direction: row;
            }
            
        }
        @media (max-width: 917.9px){
            .heartrate-one .btn.btn-success{
            margin-top: 10px;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 10px;
            }
        }
        @media (max-width: 849px){
            .heartrate-three{
                width: 100%;
                padding: 0;
            }
            .heartrate-four{
                width: 100%;
            }
        }
        @media (max-width: 767px){
            .bottons-wrap{
                width: 60%
            }
            .heartrate-one{
                width: 100%;
            }
            .heartrate-two{
                width: 100%;
            }
            .heartrate-one .btn.btn-success{
            margin-top: 0;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 0;
            }
            .drug-width .btn.btn-success {
                margin-top: 20px;
            }
            .content {
                padding: 25px 15px;
            }
            
        }
        @media (max-width:574px){
            .col-xs-3 {
                width: 100%;
            }
            .col-xs-4 {
                width: 100%;
            }
            .col-xs-6 {
                width: 100%;
            }
            .col-xs-8 {
                width: 100%;
            }
            .bottons-wrap{
                width: 100%;
            }
            .drug-width {
                width: 100%;
            }
            .mucus-padd{
                padding: 0;
            }
            .refil-padd{
                padding: 0 !important;
            }
            .drug-width .btn.btn-success {
                margin-top: 0;
            }
            .green-labels label {
                min-width: 40%;
            }
        }
        @media (max-width: 354.9px){
            .heartrate-one .btn.btn-success{
            margin-top: 10px;
            }
            .heartrate-two .btn.btn-success{
            margin-top: 10px;
            }
        }
        .county-label.extra {
            width: 33%;
        }
    </style>
<cfelse>
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Stranding</a></li>
            <li><a href="javascript:;">Cetacean Exam</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>