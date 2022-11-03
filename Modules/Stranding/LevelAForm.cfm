<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    
    <cfset getTeams=Application.SightingNew.getTeams()>
    <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()>
    <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>
    <cfset qgetStrandingType=Application.StaticDataNew.getStrandingType()>
    <cfset qgetIR_CountyLocation=Application.StaticDataNew.getIR_CountyLocation()>
    <cfset getStock=Application.StaticDataNew.getStock()>
    <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
    <cfset getRegions = Application.ConditionLesions.getRegions()>
    <cfset sex = ['Male','Female','CBD']>
    <cfset ageClass = ['Neonate','YOY','Yearling','Calf','Juvenile','Subadult','Adult','CBD/Unknown']>
    <cfset ILAD = ['Left at Site','Immediate Release at Site','Relocated and Released','Disentangled','Died at Site','Died During Transport','Euthanized','Transferred to Rehab','Other'] >
    <cfset CarcassStatus = ['Frozen for Later','Exam/Necropsy Pending','Left at Site','Landfill','Towed','Buried','Incinerated','Sunk','Rendered','Composted','Unknown/Other'] >
    <cfset GroupEventType = ['Cow/Calf Pair','Mass Stranding','UME','Unknown'] >
    <cfset TagsWere = ['Present at time of Stranding','Applied During Stranding','Absent but Suspect Prior Tag']>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Moderate Decomposition' ,'Advanced Decomposition','Mummified']>
    <cfparam  name="url.LCE_ID" DEFAULT="0">
    <cfif isDefined('SaveAndNew') OR isDefined('SaveAndClose') OR isDefined('SaveandgotoHistopathology')> 
        <!--- If updating existing data --->
        <cfif  isDefined('form.ID') and form.ID neq "">
            <cfset LCE = Application.Stranding.LevelAFormUpdate(argumentCollection="#Form#")>
            <cfif isDefined('SaveandgotoHistopathology') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Histopathology&LCE_ID=#url.LCE_ID#" >
            <cfelseif isDefined('SaveandgotoHistopathology') and url.LCE_ID neq 0 >
                <!--- <cfset form.LCE_ID = url.LCE_ID>
                <cfset LCE = Application.Stranding.LevelAFormInsert(argumentCollection="#Form#")> --->
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Histopathology" >
            </cfif>
        <cfelse>
            <!--- If inserting new data --->
            <!--- <cfdump var="Nouman" abort="true"> --->
            <cfset form.LCE_ID = url.LCE_ID>
            <cfset LCE = Application.Stranding.LevelAFormInsert(argumentCollection="#Form#")>
            <cfif isDefined('SaveandgotoHistopathology')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Histopathology&LCE_ID=#url.LCE_ID#" >
            </cfif>
        </cfif>
    <cfelseif isDefined('delete')>
        <cfset Application.Stranding.deleteLA("#form.ID#")>
    <cfelseif isDefined('deleteAllLevelAFormRecord')>
        <cfset Application.Stranding.deleteAllLevelAFormRecord()>
    </cfif>
    <!--- if user directed from the Cetacean form, here get first 4 forms data of Cetacean form --->
    <cfif url.LCE_ID neq 0>
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.getLevelADataByLCE("#form.LCEID#")>
        <cfset qgetLevelAData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>    
        <cfif #qgetLevelAData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetLevelAData.species#")>
        </cfif>
        <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
            <cfset form.HI_ID = neworexist.ID>
        </cfif>
    </cfif>
    <!---   getting data on the basis of LevelA ID  --->
    
    <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
        <cfset form.LCEID = form.HI_ID>
        <cfset qgetLevelAData=Application.Stranding.getLevelAData("#form.LCEID#")>
        <cfif #qgetLevelAData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetLevelAData.species#")>
        </cfif>
    </cfif>
    <!---  setup empty form when directly clicked the LevelA link from side bar --->
    <cfif url.LCE_ID eq 0 AND Not isDefined('form.HI_ID')>
        <cfset qgetLevelAData=Application.Stranding.getLevelA_ten()>
        <!---  setup empty form when when entering new record --->
    <cfelseif  isDefined('form.HI_ID') AND form.HI_ID eq "">
        <cfset qgetLevelAData=Application.Stranding.getLevelA_ten()>
    </cfif>
    <!---  get all records order by ID DESC--->
    <cfset qgetLevelAID=Application.Stranding.getLevelAID()>
    <!---  get all records order by Date Desc --->
    <cfset qgetLevelADate=Application.Stranding.getLevelADate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetLevelAFBNumber=Application.Stranding.getLevelAFBNumber()>


    <!--- working start --->
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
                <cfif arrayContains(colNameArray, 'Field Number') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Field Number" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Date') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Date" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'NMFS Regional ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "NMFS Regional #" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'National Database ##') eq false>
                    <script>
                        alert('The Column name in the sheet should be "National Database ##" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Species') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Species" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Veterinarian') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Veterinarian" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Team Members') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Team Members" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Stranding Agreement or Authority') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Stranding Agreement or Authority" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Restrand') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Restrand" ');
                    </script>
                 <cfelseif arrayContains(colNameArray, 'Group Event') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Group Event" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Number of Animals') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Number of Animals" ');
                    </script>
                 <cfelseif arrayContains(colNameArray, 'Sex') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Sex" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Age Class') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Age Class" ');
                    </script>  
                <cfelseif arrayContains(colNameArray, 'County') eq false>
                    <script>
                        alert('The Column name in the sheet should be "County" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lat') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lat" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Lon') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Lon" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Body of Water') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Body of Water" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Location') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Location" ');
                    </script>
                <cfelseif arrayContains(colNameArray, 'Brief History') eq false>
                    <script>
                        alert('The Column name in the sheet should be "Brief History" ');
                    </script>
                <cfelse>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll(' ','') />
                    </cfloop>
                    <cfloop from="1" to="#arrayLen(colNameArray)#" index="i">
                        <cfset colNameArray[i] = colNameArray[i].replaceAll('##','') />
                    </cfloop>
                    <cfset data.setColumnNames(colNameArray) />

                    <!--- <cfdump var="#data#"abort="true"> --->

                    <cfoutput query="data" startRow="2">
                        <!--- for Veterinarian --->
                       <cfset myarray=[] >
                        <cfloop from="1" to="#ListLen(data.Veterinarian)#" index="i">
                            <cfset VeterinarianDat = '#data.Veterinarian#'>
                            <cfset VeterinarianData = VeterinarianDat.replaceAll(', ',',') />
                        <!--- store query for insert data in master table --->
                            <cfset convertedData =listToArray(VeterinarianData,",",false,true) >

                            <cfquery name="qgetdata1" datasource="#Application.dsn#" result="getData">
                                SELECT Veterinarians FROM TLU_Veterinarians
                                WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                            </cfquery> 
                            <cfset veterian = '#qgetdata1.Veterinarians#' >
                        <!--- <cfdump var="#veterian#" abort="true"> --->
                            <cfif veterian eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_Veterinarians
                                        (
                                        Veterinarians
                                        ,status
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetdata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_Veterinarians
                            WHERE Veterinarians ='#ListGetAt(VeterinarianData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(myarray, qgetdata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedList=myarray.toList() >

                        <!--- for teamMember --->

                        <cfset teamMemberArray=[] >
                        <cfloop from="1" to="#ListLen(data.TeamMembers)#" index="i">
                            <cfset TeamMemberDat = '#data.TeamMembers#'>
                            <cfset TeamMemberData = TeamMemberDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedTeamData =listToArray(TeamMemberData,",",false,true) >

                            <cfquery name="qgetTeamData" datasource="#Application.dsn#" result="getData">
                                SELECT RT_MemberName FROM TLU_ResearchTeamMembers
                                WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                            </cfquery> 
                            <cfset team = '#qgetTeamData.RT_MemberName#' >
                        <!--- <cfdump var="#team#" abort="true"> --->
                            <cfif team eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_ResearchTeamMembers
                                        (
                                        RT_MemberName
                                        ,active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedTeamData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetTeamdata" datasource="#Application.dsn#" >
                            SELECT RT_ID FROM TLU_ResearchTeamMembers
                            WHERE RT_MemberName ='#ListGetAt(TeamMemberData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(teamMemberArray, qgetTeamdata.RT_ID ,"true") >
                        </cfloop>
                        <cfset myConvertedTeamList=teamMemberArray.toList() >

                        <!--- for Water of body --->
                        
                        <cfset waterOfBodyArray=[] >
                        <cfloop from="1" to="#ListLen(data.BodyofWater)#" index="i">
                            <cfset BodyofWaterDat = '#data.BodyofWater#'>
                            <cfset BodyofWaterData = BodyofWaterDat.replaceAll(', ',',') />
                        <!--- add query for insert data in master table --->
                            <cfset convertedWaterOfBodyData =listToArray(BodyofWaterData,",",false,true) >

                            <cfquery name="qgetWaterBodydata" datasource="#Application.dsn#" result="getData">
                                SELECT AreaName FROM TLU_SurveyArea
                                WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                            </cfquery> 
                            <cfset waterOFBody = '#qgetWaterBodydata.AreaName#' >
                        <!--- <cfdump var="#waterOFBody#" abort="true"> --->
                            <cfif waterOFBody eq ''>
                                <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                    INSERT INTO TLU_SurveyArea
                                        (
                                        AreaName
                                        ,Active
                                        ) 
                                        VALUES
                                        (
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#convertedWaterOfBodyData[i]#'>
                                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                        )
                                </cfquery>
                            </cfif>
                        <cfquery name="qgetWaterOfBodydata" datasource="#Application.dsn#" >
                            SELECT ID FROM TLU_SurveyArea
                            WHERE AreaName ='#ListGetAt(BodyofWaterData,i)#'                         
                        </cfquery> 
                        <cfset ArrayAppend(waterOfBodyArray, qgetWaterOfBodydata.ID ,"true") >
                        </cfloop>
                        <cfset myConvertedWatarList=waterOfBodyArray.toList() >
                        <!--- teamMember end --->
            <!--- for species --->

                        <cfset speciesData = '#data.Species#'> 
    
                        <cfquery name="qgetSpeciesData" datasource="#Application.dsn#" result="getData">
                            SELECT CetaceanSpeciesName FROM TLU_CetaceanSpecies
                            WHERE CetaceanSpeciesName ='#speciesData#'                         
                        </cfquery> 
                        <cfset team = '#qgetSpeciesData.CetaceanSpeciesName#'>
                    <!--- <cfdump var="#team#" abort="true"> --->
                        <cfif team eq ''>
                            <cfquery name="qinsertFileTLU" datasource="#Application.dsn#">
                                INSERT INTO TLU_CetaceanSpecies
                                    (
                                    CetaceanSpeciesName
                                    ,Active
                                    ) 
                                    VALUES
                                    (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#speciesData#'>
                                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value='0'>   
                                    )
                            </cfquery>
                        </cfif>
                    <cfquery name="qgetSpeciesdata" datasource="#Application.dsn#" >
                        SELECT ID FROM TLU_CetaceanSpecies
                        WHERE CetaceanSpeciesName ='#speciesData#'                         
                    </cfquery> 
                                    
            <!--- end for species --->

                        <cfquery name="qinsertFile" datasource="#Application.dsn#" result="return_data">
                            INSERT INTO ST_LevelAForm
                            (
                            Fnumber
                            ,date
                            ,NMFS
                            ,NDB
                            ,species
                            ,Veterinarian
                            ,ResearchTeam
                            ,NAA
                            ,Restrand
                            ,GroupEvent
                            ,noOfAnimals
                            ,sex
                            ,ageClass
                            ,county
                            ,lat
                            ,lon
                            ,BodyOfWater
                            ,Location
                            ,BriefHistory       
                            ,LCE_ID                      
                            ) 
                            VALUES
                            (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#data.FieldNumber#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Date#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NMFSRegional#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NationalDatabase#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#qgetSpeciesdata.ID#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedTeamList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.StrandingAgreementorAuthority#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Restrand#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.GroupEvent#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.NumberofAnimals#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Sex#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.AgeClass#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.County#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lat#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lon#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedWatarList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.BriefHistory#'>
                            ,<cfqueryparam  value='0'>                          
                            )
                        </cfquery>

                     
                    </cfoutput>
                </cfif>    
            </cfif>    
        </cfif>
    </cfif>
    <!--- working end --->




    <cfoutput>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Level A Form</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Level A Form</h1>
            <!-- end page-header -->
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myform" action="#Application.siteroot#/?Module=Stranding&Page=LevelAForm" method="post" >
                            <label for="sel1">Select Level A Form</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                    <option value="">Select Level A Form</option>
                                    <cfloop query="qgetLevelAID">
                                        <option value="#qgetLevelAID.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetLevelAID.ID#>selected</cfif>>#qgetLevelAID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="#Application.siteroot#/?Module=Stranding&Page=LevelAForm" method="post" >
                        <label for="sel1">Search Level A Form By Date:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                <option value="">Select Date</option>
                                <cfloop query="qgetLevelADate">
                                    <option value="#qgetLevelADate.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetLevelADate.ID#>selected</cfif>>#qgetLevelADate.date#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="#Application.siteroot#/?Module=Stranding&Page=LevelAForm" method="post" >
                        <label for="sel1">Search Level A By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetLevelAFBNumber">
                                    <option value="#qgetLevelAFBNumber.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetLevelAFBNumber.ID#>selected</cfif>>#qgetLevelAFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetLevelAData.LCE_ID#" class="form-control" readonly>
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
            <form id="myform" action="" method="post" autocomplete="on">
                <div class="form-wrapper">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="LevelAform-date-form form-group m-0 blue-bg-l">
                                    <div class="row">
                                        <div class="col-lg-12 p-0">
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="date-padd">Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <input type="text" placeholder="mm/dd/yyyy" name="date" id="date"
                                                                class="form-control" value='#DateTimeFormat(qgetLevelAData.Date, "MM/dd/YYYY")#' required/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="start-time">Start Time</label>
                                                        <div class="input-group date " id="datetimepicker_StartTime">
                                                            <input type="text" value="#TimeFormat(qgetLevelAData.StartTime, "HH:nn")#" placeholder="hh:mm:ss" name="StartTime" id="StartTime"
                                                                class="form-control" />
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="end-time">End Time</label>
                                                    <div class="input-group date" id="datetimepicker_EndTime">
                                                        <input type="text"  value="#TimeFormat(qgetLevelAData.EndTime, "HH:nn")#" placeholder="hh:mm:ss" name="EndTime" id="EndTime"
                                                            class="form-control" />
                                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                    </div>
                                                </div>
                                            </div> 
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="field-number">Field Number</label>
                                                        <div class="input">
                                                            <input type="text" value="#qgetLevelAData.Fnumber#" class="form-control" name="Fnumber" id="Fnumber" required>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">NMFS Regional ##</label>
                                                        <input class="input-style xl-width" type="text" value="#qgetLevelAData.NMFS#" name="NMFS" id="NMFS">
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">National Database ##</label>
                                                        <input class="input-style xl-width" type="text" value="#qgetLevelAData.NDB#" name="NDB" id="NDB">
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-12 col-md-12"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">Standing Agreement or Authority</label>
                                                        <div class="input">
                                                            <input class="input input-style" type="text" value="#qgetLevelAData.NAA#" name="NAA" id="NAA">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                            <div class="col-lg-12 col-md-12"> 
                                                <div class="form-group m-0">
                                                    <div class="input-group flex-center">
                                                        <label class="AI-label">Additional Identifier</label>
                                                        <div class="input">
                                                            <input class="input input-style" type="text" value="#qgetLevelAData.AdditionalIdentifier#" name="AdditionalIdentifier" id="AdditionalIdentifier">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
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
                                                                <!--- <cfif active eq 1> --->
                                                                    <option value="#getTeams.RT_ID#" <cfif ListFind(ValueList(qgetLevelAData.ResearchTeam,","),getTeams.RT_ID)>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                                <!--- </cfif> --->
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
                                                                <!--- <cfif status eq 1> --->
                                                                    <option value="#qgetVeterinarians.ID#" <cfif ListFind(ValueList(qgetLevelAData.Veterinarian,","),qgetVeterinarians.ID)>selected</cfif>>#qgetVeterinarians.Veterinarians#</option>
                                                                <!--- </cfif> --->
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
                                                                    <!--- <cfif active eq 1> --->
                                                                        <option value="#getSurveyAreaData.ID#" <cfif ListFind(ValueList(qgetLevelAData.BodyOfWater,","),getSurveyAreaData.ID)>selected</cfif>>#getSurveyAreaData.AreaName#</option>
                                                                    <!--- </cfif> --->
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
                                                        <select class="form-control selectCustomReset" name="species" id="species"
                                                            onChange="getCode()">
                                                            <option value="0"></option>
                                                            <cfloop query="qgetCetaceanSpecies">
                                                                <!--- <cfif active eq 1> --->
                                                                    <option value="#qgetCetaceanSpecies.id#" <cfif #qgetCetaceanSpecies.id# eq #qgetLevelAData.species#>selected</cfif>>
                                                                        #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                                                                <!--- </cfif> --->
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
                                                                    <option value="#qgetStrandingType.ID#" <cfif #qgetStrandingType.ID# eq #qgetLevelAData.StTpye#>selected</cfif>>#qgetStrandingType.type#</option>
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
                                                                        <option class="stock_value" value="#getStock.ID#" <cfif ListFind(ValueList(qgetLevelAData.NOAAStock,","),getStock.ID)>selected</cfif>>
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
                <h5 class="mb-1"><strong>Documents</strong></h5>
                <input type="hidden" name="pdfFiles" value="#qgetLevelAData.pdfFiles#" id="pdfFiles">
                <div class="form-holder">  
                    <div class="form-group" id="find">
                        <div class="row" id="start">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Upload PDF File (Max Size: 10MB)</label>
                                        <input class="input-style xl-width" type="file"  name="FileContents" id="files" onchange="img()" accept="application/pdf" <cfif findNoCase("Read only ST", permissions) neq 0> Disabled</cfif>>
                                    </div>
                                </div>
                            </div>
                            <!--- <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">NRT Report Filed</label>
                                        <input class="input-style xl-width" type="checkbox" value="1" name="NRT_report" id="NRT_report" <cfif isdefined('qgetLevelAData.NRT_report') and  qgetLevelAData.NRT_report  eq 1>checked</cfif>>
                                    </div>
                                </div>
                            </div> --->
                        </div>
                        <cfset imgss = ValueList(qgetLevelAData.pdfFiles,",")>
                        <div id="previousimages">
                            <CFIF listLen(imgss)> 
                                <cfloop list="#imgss#" item="item" index="index">
                
                                    <span class="pip">
                                        <a data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                            <img  class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#item#" onclick="selected(this)"/>
                                        </a>
                                        <br/>
                                        <span class="remove" onclick="remov(this)" id="#item#">Remove image</span>
                                    </span>
                                </cfloop>
                            </cfif>	
                        </div>
                    </div>
                </div>
                <div class="form-holder">  
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="code-padd">Code</label>
                                        <select class="form-control" name="code" id="code" onChange="getFbAndSex()">
                                            <option value="">Select Code</option>
                                            <cfif isDefined('getCetaceansCode')>
                                            <cfif isDefined('qgetLevelAData.species') and #qgetLevelAData.species# neq "" >
                                                <cfloop query="getCetaceansCode">
                                                    <option value="#getCetaceansCode.id#" <cfif #getCetaceansCode.id# eq #qgetLevelAData.code#>selected</cfif>>
                                                            #getCetaceansCode.code# </option>
                                                </cfloop>
                                            </cfif>
                                            </cfif>
                                        </select>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">HERA/FB No.</label>
                                        <input class="input-style xl-width" type="text" value="#qgetLevelAData.hera#" name="hera" id="hera">
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="sex-label">Sex</label>
                                        <select class="form-control" name="sex" id="sex">
                                            <option value="">Select Sex</option>
                                            <cfloop from="1" to="#ArrayLen(sex)#" index="j">
                                                <option value="#sex[j]#" <cfif #sex[j]# eq #qgetLevelAData.sex#>selected</cfif>>#sex[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="ageclass-label">Age Class</label>
                                        <select class="form-control" name="ageClass" id="ageClass">
                                            <option value="">Select Age Class</option>
                                            <cfloop from="1" to="#ArrayLen(ageClass)#" index="j">
                                                <option value="#ageClass[j]#" <cfif #ageClass[j]# eq #qgetLevelAData.ageClass#>selected</cfif>>#ageClass[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 ">
                                <div class="form-group flex-center">
                                    <label >Location</label>
                                    <textarea class="form-control textareaCustomReset locations-textarea" name="Location"
                                        maxlength="75">#qgetLevelAData.Location#</textarea>
                                </div>
                                <div class="form-group flex-center">
                                    <label>Affiliated ID</label>
                                    <input class="form-control"type="text" name="affiliatedID" value="#qgetLevelAData.affiliatedID#" maxlength="80">
                                </div>
                            </div>   
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="lat-one">Lat</label>
                                        <input class="input-style xl-width" type="text" value="#qgetLevelAData.lat#" name="lat" id="AtLatitude">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="lon-one">Lon</label>
                                        <input class="input-style xl-width" type="text" value="#qgetLevelAData.lon#" name="lon" id="AtLongitude">
                                    </div>
                                </div>
                                <div class="form-group justify-content-end">
                                    <input type="button" id="verifyLocation" class="btn btn-skyblue" value="Verify" onclick="checkLatLng()">
                                </div>
                            </div>   
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Initial Condition</label>
                                        <select class="form-control" name="InitialCondition" id="InitialCondition">
                                            <option value="">Select Initial Condition</option>
                                            <!--- <cfloop from="1" to="5" index="j">
                                                <option value="#j#" <cfif #j# eq #qgetLevelAData.InitialCondition#>selected</cfif>>#j#</option>
                                            </cfloop> --->
                                            <cfloop array="#Conditions#" item="item" index="j">
                                                <option value="#item#" <cfif #item# eq #qgetLevelAData.InitialCondition#>selected</cfif>>#j#-#item#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Final Condition</label>
                                        <select class="form-control" name="FinalCondition" id="FinalCondition">
                                            <option value="">Select Final Condition</option>
                                            <!--- <cfloop from="1" to="5" index="j">
                                                <option value="#j#" <cfif #j# eq #qgetLevelAData.FinalCondition#>selected</cfif>>#j#</option>
                                            </cfloop> --->
                                            <cfloop array="#Conditions#" item="item" index="j">
                                                <option value="#item#" <cfif #item# eq #qgetLevelAData.InitialCondition#>selected</cfif>>#j#-#item#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="county-label">County</label>
                                        <select class="form-control" name="county" id="county">
                                            <option value="">Select County</option>
                                            <cfloop query="qgetIR_CountyLocation">
                                                <cfif active  neq 0>
                                                    <option value="#qgetIR_CountyLocation.IR_CountyLocation#" <cfif #qgetIR_CountyLocation.IR_CountyLocation# eq #qgetLevelAData.county#>selected</cfif>>#qgetIR_CountyLocation.IR_CountyLocation#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>                
                                    
                            <div class="col-lg-6 col-md-12 col-sm-6 col-xs-6 ">
                                <div class="form-group flex-center">
                                    <label class="history-label">Brief History </label>
                                    <textarea class="form-control textareaCustomReset locations-textarea" name="BriefHistory"
                                        maxlength="75">#qgetLevelAData.BriefHistory#</textarea>
                                </div>
                            </div>        
                        </div>
                    </div>
                </div>
                <!---  Following logic to get the data from the LevelA table and seting value to qgetHIData variable --->
                <cfif url.LCE_ID neq 0>
                    <cfset qgetLevelAData=Application.Stranding.getLevelA_ten()>
                </cfif>
                <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                    <cfset form.LCEID = form.HI_ID>
                    <cfset qgetLevelAData=Application.Stranding.getLevelAData(argumentCollection="#Form#")>
                <cfelse>
                    <cfset qgetLevelAData=Application.Stranding.getLevelA_ten()>
                </cfif>
                <h5 class="mb-1"><strong>Stranding Event Details</strong></h5>
                <input type="hidden"  name="ID" value="#qgetLevelAData.ID#">
                <input type="hidden" name="LCE_ID" value="#qgetLevelAData.LCE_ID#">
                <div class="form-holder">  
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group mt-3">
                                    <div class="input-group flex-center">
                                        <label class="">Initial Live Animal Disposition</label>
                                        <select class="form-control" name="ILAD" id="ILAD">
                                            <option value="">Select Initial Disposition</option>
                                            <cfloop from="1" to="#ArrayLen(ILAD)#" index="j">
                                                <option value="#ILAD[j]#" <cfif #ILAD[j]# eq #qgetLevelAData.ILAD#>selected</cfif>>#ILAD[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 ">
                                <div class="form-group flex-center">
                                    <label >Comment</label>
                                    <textarea class="form-control textareaCustomReset locations-textarea" name="ILADComment"
                                        maxlength="75">#qgetLevelAData.ILADComment#</textarea>
                                </div>
                            </div> 
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group mt-3">
                                    <div class="input-group flex-center">
                                        <label class="">Carcass Status</label>
                                        <select class="form-control" name="CarcassStatus" id="CarcassStatus">
                                            <option value="">Select Carcass Status</option>
                                            <cfloop from="1" to="#ArrayLen(CarcassStatus)#" index="j">
                                                <option value="#CarcassStatus[j]#" <cfif #CarcassStatus[j]# eq #qgetLevelAData.CarcassStatus#>selected</cfif>>#CarcassStatus[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>     
                            <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="CarcassStatusLat-label">Lat</label>
                                        <input class="input-style xl-width" type="text" value="#qgetLevelAData.CarcassStatusLat#" name="CarcassStatusLat" id="CarcassStatusLat">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="CarcassStatusLon-label">Lon</label>
                                        <input class="input-style xl-width" type="text" value="#qgetLevelAData.CarcassStatusLon#" name="CarcassStatusLon" id="CarcassStatusLon">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="form-group justify-content-end">
                                            <input type="button" id="verifyLocation" class="btn btn-skyblue" value="Verify" onclick="checkCarcassStatus()">
                                        </div>
                                    </div>
                                </div>
                            </div>      
                        </div>
                        <div class="row">    
                            <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Group Event</label>
                                        <input class="input-style xl-width" type="checkbox" value="1" name="GroupEvent" id="GroupEvent" <cfif qgetLevelAData.GroupEvent eq 1>checked</cfif>>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group input-group flex-center">
                                    <label class="">Group Event Type</label>
                                    <div class="input"> 
                                        <select class="form-control" name="GroupEventType"
                                            id="GroupEventType">
                                            <option value="">Select Carcass Status</option>
                                            <cfloop from="1" to="#ArrayLen(CarcassStatus)#" index="j">
                                                <option value="#CarcassStatus[j]#" <cfif #CarcassStatus[j]# eq #qgetLevelAData.GroupEventType#>selected</cfif>>#CarcassStatus[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>  
                            <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="noOfAnimals-label">Number of Animals (Max 3 digit)</label>
                                        <input class="input-style xl-width" type="text" value="#qgetLevelAData.noOfAnimals#" name="noOfAnimals" id="noOfAnimals" onchange="maxnum()">
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-3">
                                <div class="form-group input-group flex-center">
                                    <label>Tags Were</label>
                                    <div class="input"> 
                                        <select class="form-control search-box" multiple="multiple" name="TagsWere"
                                        id="TagsWere">
                                        <cfloop from="1" to="#ArrayLen(TagsWere)#" index="j">
                                            <option value="#TagsWere[j]#" <cfif ListFind(ValueList(qgetLevelAData.TagsWere,","),#TagsWere[j]#)>selected</cfif>>#TagsWere[j]#</option>
                                        </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Restrand</label>
                                        <input class="input-style xl-width" type="checkbox" value="1" name="Restrand" id="Restrand" <cfif qgetLevelAData.Restrand eq 1>checked</cfif>>
                                    </div>
                                </div>
                            </div>   
                        </div>
                    </div>
                </div>
                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoHistopathology" value="Save and go to Histopathology" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report" onclick="chkreq(event)">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div>
                        <div class="flex-center flex-wrap bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose"value="Save and Close" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                 <input type="submit" id="deleteAllLevelAFormRecord" name="deleteAllLevelAFormRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records ?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>
            </form>    
                <!--- Working --->
                <div class="row mt-4">
                    <form id="myform" enctype="multipart/form-data" action="" method="post" >
                        <div class="col-lg-12 dis-flex just-center">
                            <div class="form-group select-width">
                                <cfif (permissions eq "full_access")>
                                    <input type="file" name="sampleFile" required>
                                </cfif>
                            </div>
                            <div class="form-group select-width">
                                <cfif (permissions eq "full_access")>
                                    <button type="submit" class="btn btn-success">Import</button>
                                </cfif>
                            </div>
                        </div>  
                    </form>
                </div>
                <!--- working end ---> 
        </div>
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">
            
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="pdfname"></h4>
                    </div>
                    <div class="modal-body">
                        <embed id="emb" src="" width="98%" height="500" type="application/pdf" title="test.pdf">
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>

    <style>
        input[type="file"] {
        display: block;
        }
        .imageThumb {
        max-height: 132px;
        border: 4px solid;
        cursor: pointer;
        }
        .dis-flex.just-center {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 30px 0 0;
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
        .mt-3{
        margin-top: 46px;
        }
        .p-0{
            padding: 0;
        }
        .pl-0{
        padding-left: 0; 
        }
        .pl-1{
        padding-left: 42px; 
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
        .blue-bg{
            background-color: #add8e6;
            padding-bottom: 70px;
        }
        .blue-bg-l{
            background-color: #add8e6;
            padding-bottom: 75px;
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
        .btn-skyblue:hover{
            color: #FFF;
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
        .AI-label{
            padding-right: 83px;
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
        .TypeofHI-label {
            padding-right: 78px;
        }
        .CarcassStatusLat-label{
            padding-right: 43px;
        }
        .CarcassStatusLon-label{
            padding-right: 38px;
        }
        .county-label {
            padding-right: 55px;
        }
        .sex-label {
            padding-right: 76px;
        }
        .Examtype-label {
            padding-right: 49px;
        }
        .GroupEventType-label {
            padding-right: 14px;
        }
        .LocationofHI-label {
            padding-right: 55px;
        }
        .GearDeposition-label {
            padding-right: 93px;
        }
        .noOfAnimals-label {
            min-width: 120px;
            text-align: center;
        }
        @media (max-width: 1399px){
            .LevelAform-date-form .form-group.flex-center {
            flex-wrap: wrap;
            }
            .LevelAform-date-form .input-group.flex-center {
            flex-wrap: wrap;
            }
        }
        @media (max-width: 1199px){
            .LevelAform-date-form .form-group.flex-center {
            flex-wrap: nowrap;
            }
            .LevelAform-date-form .input-group.flex-center {
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
            .ml-auto{
                margin-left: auto;
            }
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
    </style>
    <cfinclude template="GoogleMap.cfm">
<cfelse>
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Stranding</a></li>
            <li><a href="javascript:;">Level A Form</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>