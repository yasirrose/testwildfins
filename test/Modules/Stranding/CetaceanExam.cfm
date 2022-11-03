<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    
    <cfset getTeams=Application.SightingNew.getTeams()>

    <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()>
    <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>

    <cfset qgetStrandingType=Application.StaticDataNew.getStrandingType()>

    <cfset qgetIR_CountyLocation=Application.StaticDataNew.getIR_CountyLocation()>

    <cfset getStock=Application.StaticDataNew.getStock()>
    <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
    <cfset qgetVeterinarianss= Application.StaticDataNew.getVeterinarianss()>
    <cfset qgetBiopsyType= Application.StaticDataNew.getBiopsyType()>
    <cfset qgetBiopsyLocation= Application.StaticDataNew.getBiopsyLocation()>
    <cfset qgetDrugType= Application.StaticDataNew.getDrugType()>
    <cfset qgetDrugMethod = Application.StaticDataNew.getDrugMethod()>
    <cfset getHeadNuchalCrest = Application.ConditionLesions.getHeadNuchalCrest()>
    <!---  Head Condition   --->
    <cfset getHeadLateralCervicalReg = Application.ConditionLesions.getHeadLateralCervicalReg()>
    <cfset getHeadFacialBones = Application.ConditionLesions.getHeadFacialBones()>
    <cfset getHeadEarOS = Application.ConditionLesions.getHeadEarOS()>
    <cfset getHeadChinSkinFolds = Application.ConditionLesions.getHeadChinSkinFolds()>
    <!---  Body Condition   --->
    <cfset getBodyEpaxialMuscle = Application.ConditionLesions.getBodyEpaxialMuscle()>
    <cfset getBodyDorsalRidgeScapula = Application.ConditionLesions.getBodyDorsalRidgeScapula()>
    <cfset getBodyRibs = Application.ConditionLesions.getBodyRibs()>
    <!---  Tail Condition   --->
    <cfset getTailTransversePro = Application.ConditionLesions.getTailTransversePro()>
    <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>
    <!---  Static data   --->
    <cfset getRegions = Application.ConditionLesions.getRegions()>
    <cfset bodyConditions = ['Emaciated','Underweight/Thin','Ideal','Overweight','Obese']>
    <cfset MucusMembraneColor = ['Dark Pink','Pink','Light Pink','Yellow','Pale (no color)','Blue','CBD']>
    <cfset sides = ['L','R','L/R','N/A']>
    <cfset sex = ['Male','Female','CBD']>
    <cfset ageClass = ['Neonate','YOY','Calf','Juvenile','Adult','CBD/Unknown','Pup','Fetus']>
    <cfset SSCollectedFor = ['Clinical Pathology', 'Infectious Disease', 'Toxicology' ,'Other']>
    <cfset SLCollectedFor = ['Infections Disease', 'Histopathology', 'Toxicology' ,'Other']>
    <cfset BSCollectedFor = ['Clinical Pathology', 'Infectious Disease', 'Histopathology' ,'Toxicology','Other']>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Alive/Fresh Dead','Moderate Decomposition' ,'Advanced Decomposition','Mummified']>
    <cfset ConditionsValue = ['1', '2', '1/2','3' ,'4','5']>
    <cfparam  name="url.LCEID" DEFAULT="0">
    <cfif isDefined('SaveAndNew') OR isDefined('SaveAndClose') OR isDefined('SaveandgotoHIForm') OR isDefined('SaveandgotoAForm')>
        <!--- <cfdump var="#form#" abort="true"> --->
        <!--- Working --->
        <cfif isDefined('form.ID') and form.ID neq "">
            <cfset form.LCE_ID = "#form.ID#">
            <cfset Application.Stranding.CetaceanExamUpdate(argumentCollection="#Form#")>
            <cfif form.count neq "">
                <cfset Application.Stranding.UpdateNotesData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.heartRate neq "" and form.heartRateTime neq "">
                <cfset Application.Stranding.InsertHeartData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.respRate neq "">
                <cfset Application.Stranding.InsertRespData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.Drugtype neq "">
                <cfset Application.Stranding.InsertDrugData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.BiopsyType neq "">
                <cfset Application.Stranding.InsertBiopsyData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.LesionPresent neq "">
                <cfset Application.Stranding.InsertLesionData(argumentCollection="#Form#")>
            </cfif>
            <cfif isDefined('SaveandgotoHIForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=HIForm&LCE_ID=#form.ID#" >
            </cfif>
            <cfif isDefined('SaveandgotoAForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=LevelAForm&LCE_ID=#form.ID#" >
            </cfif>
        <cfelse>
            <cfset LCE = Application.Stranding.LiveCetaceanExamInsert(argumentCollection="#Form#")>
            <!--- <cfdump var="#LCE#" abort="true"> --->
            <cfset form.LCE_ID = "#LCE#">
            <cfif form.heartRate neq "" and form.heartRateTime neq "">
                <cfset Application.Stranding.InsertHeartData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.respRate neq "">
                <cfset Application.Stranding.InsertRespData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.Drugtype neq "">
                <cfset Application.Stranding.InsertDrugData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.BiopsyType neq "">
                <cfset Application.Stranding.InsertBiopsyData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.LesionPresent neq "">
                <cfset Application.Stranding.InsertLesionData(argumentCollection="#Form#")>
            </cfif>
            <cfif form.maxNotes neq "">
                <cfset Application.Stranding.InsertNotesData(argumentCollection="#Form#")>
            </cfif>
            <cfif isDefined('SaveandgotoHIForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=HIForm&LCE_ID=#LCE#" >
            </cfif>
            <cfif isDefined('SaveandgotoAForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=LevelAForm&LCE_ID=#LCE#" >
            </cfif>
        </cfif>
    <cfelseif isDefined('delete')>
        <cfset form.LCE_ID = "#form.ID#">
        <cfset Application.Stranding.deleteCE("#form#")>
    
    <cfelseif isDefined('deleteAllRecord')>
        <!--- <cfset form.LCE_ID = "#form.ID#"> --->
        <cfset Application.Stranding.deleteCetaceanExamAllrecord()>
    </cfif>

    <cfset qgetLCEID=Application.Stranding.getLCEID()>
    <cfset qgetLCEDate=Application.Stranding.getLCEDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetLCEFBNumber=Application.Stranding.getLCEFBNumber()>
    <cfif url.LCEID neq 0>
        <cfset form.LCEID = url.LCEID>
        <cfset qLCEData=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
        <cfif #qLCEData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qLCEData.species#")>
        </cfif>
        <cfset qgetHeartData = Application.Stranding.getHeartData(LCEID="#form.LCEID#")>
        <cfset qgetRespData = Application.Stranding.getRespData(LCEID="#form.LCEID#")>
        <cfset qgetDrugData = Application.Stranding.getDrugData(LCEID="#form.LCEID#")>
        <cfset qgetBiopsyData = Application.Stranding.getBiopsyData(LCEID="#form.LCEID#")>
        <cfset qgetLesionData = Application.Stranding.getLesionData(LCEID="#form.LCEID#")>
        <cfset qgetNewSectionData = Application.Stranding.getNewSectionData(LCEID="#form.LCEID#")>
    </cfif>
    
    <cfif isDefined('form.LCEID') and form.LCEID neq "">
        <cfset qLCEData=Application.Stranding.getLiveCetaceanExamData(argumentCollection="#Form#")>
        <cfif #qLCEData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qLCEData.species#")>
        </cfif>
        <cfset qgetHeartData = Application.Stranding.getHeartData(LCEID="#form.LCEID#")>
        <cfset qgetRespData = Application.Stranding.getRespData(LCEID="#form.LCEID#")>
        <cfset qgetDrugData = Application.Stranding.getDrugData(LCEID="#form.LCEID#")>
        <cfset qgetBiopsyData = Application.Stranding.getBiopsyData(LCEID="#form.LCEID#")>
        <cfset qgetLesionData = Application.Stranding.getLesionData(LCEID="#form.LCEID#")>
        <cfset qgetNewSectionData = Application.Stranding.getNewSectionData(LCEID="#form.LCEID#")>
    <cfelse>
        <cfset qLCEData=Application.Stranding.getLCE_ten()>
    </cfif>


    <cfif structKeyExists(form, "sampleFile") and len(form.sampleFile)>
        <cfset dest = getTempDirectory()>
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
                <!--- <cfelseif arrayContains(colNameArray, 'Restrand') eq false>
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
                    </script> --->
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
                            INSERT INTO ST_LiveCetaceanExam
                            (
                            Fnumber
                            ,date
                            ,NMFS
                            ,NDB
                            ,species
                            ,Veterinarian
                            ,ResearchTeam
                            ,NAA
                            ,sex
                            ,ageClass
                            ,county
                            ,lat
                            ,lon
                            ,BodyOfWater
                            ,Location
                            ,BriefHistory                            
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
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Sex#'> 
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.AgeClass#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.County#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lat#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Lon#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#myConvertedWatarList#'>
                            ,<cfqueryparam cfsqltype="cf_sql_varchar" value='#data.Location#'>
                            ,<cfqueryparam cfsqltype="CF_SQL_varchar" value='#data.BriefHistory#'>
                                                       
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
                <li><a href="javascript:;">Cetacean Exam</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Cetacean Exam</h1>
            <!-- end page-header -->
            <cfif isDefined('form.LCEID')>
                <input type='hidden' name='form_id' id="form_id" value='#form.LCEID#'>
            </cfif>
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myform" action="" method="post" >
                            <label for="sel1">Select Cetacean Exam</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="LCEID" onChange="this.form.submit()">
                                    <option value="">Select Exam</option>
                                    <cfloop query="qgetLCEID">
                                        <option value="#qgetLCEID.ID#" <cfif isDefined('form.LCEID') and form.LCEID eq #qgetLCEID.ID#>selected</cfif>>#qgetLCEID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" >
                        <label for="sel1">Search Cetacean Exam By Date:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LCEID" onChange="this.form.submit()">
                                <option value="">Select Date</option>
                                <cfloop query="qgetLCEDate">
                                    <option value="#qgetLCEDate.ID#" <cfif isDefined('form.LCEID') and form.LCEID eq #qgetLCEDate.ID#>selected</cfif>>#qgetLCEDate.date#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="" method="post" >
                        <label for="sel1">Search Cetacean Exam By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="LCEID" onChange="this.form.submit()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetLCEFBNumber">
                                    <option value="#qgetLCEFBNumber.ID#" <cfif isDefined('form.LCEID') and form.LCEID eq #qgetLCEFBNumber.ID#>selected</cfif>>#qgetLCEFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
            </div>
            <form id="myform" action="" method="post">
                <input type="hidden"  name="ID" id="qLCEDataID" value="#qLCEData.ID#">
                <div class="form-wrapper">  
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="cetaceanExam-date-form form-group m-0 blue-bg-l">
                                    <div class="row">
                                        <div class="col-lg-12 p-0">
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="date-padd">Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <input type="text" placeholder="YYYY-MM-DD" name="date" id="date"
                                                                class="form-control" value='#DateTimeFormat(qLCEData.Date, "YYYY-MM-DD")#' required/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="start-time">Start Time</label>
                                                        <div class="input-group date " id="datetimepicker_StartTime">
                                                            <input type="text" value="#TimeFormat(qLCEData.StartTime, "HH:nn")#" placeholder="hh:mm:ss" name="StartTime" id="StartTime"
                                                                class="form-control" />
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="end-time">End Time</label>
                                                    <div class="input-group date" id="datetimepicker_EndTime">
                                                        <input type="text"  value="#TimeFormat(qLCEData.EndTime, "HH:nn")#" placeholder="hh:mm:ss" name="EndTime" id="EndTime"
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
                                                            <input type="text" value="#qLCEData.Fnumber#" class="form-control" name="Fnumber" id="Fnumber" required>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">NMFS Regional ##</label>
                                                        <input class="input-style xl-width" type="text" value="#qLCEData.NMFS#" name="NMFS" id="NMFS">
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">National Database ##</label>
                                                        <input class="input-style xl-width" type="text" value="#qLCEData.NDB#" name="NDB" id="NDB">
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-12 col-md-12"> 
                                                <div class="form-group m-0">
                                                    <div class="input-group flex-center">
                                                        <label class="">Standing Agreement or Authority</label>
                                                        <div class="input">
                                                            <input class="input input-style" type="text" value="#qLCEData.NAA#" name="NAA" id="NAA">
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
                                                                    <option value="#getTeams.RT_ID#" <cfif ListFind(ValueList(qLCEData.ResearchTeam,","),getTeams.RT_ID)>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                                <!--- </cfif> --->
                                                            </cfloop>

                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group input-group flex-center">
                                                    <label class="veterinarian">Veterinarian</label>
                                                    <!--- <cfdump var="#qgetVeterinarians.Veterinarians#" about="true"> --->
                                                    <div class="input">
                                                        <select class="form-control search-box" multiple="multiple" name="Veterinarian" id="Veterinarian" onclick ="removeOptions()">
                                                           
                                                            <cfloop query="qgetVeterinarians">

                                                                <!--- <cfif status eq 1> --->
                                                                    <option value="#qgetVeterinarians.ID#" 
                                                                    <cfif ListFind(ValueList(qLCEData.Veterinarian,","),                        qgetVeterinarians.ID)>selected
                                                                    </cfif>
                                                                    >#qgetVeterinarians.Veterinarians#</option>  
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
                                                                        <option value="#getSurveyAreaData.ID#" <cfif ListFind(ValueList(qLCEData.BodyOfWater,","),getSurveyAreaData.ID)>selected</cfif>>#getSurveyAreaData.AreaName#</option>
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
                                                            <option value=""></option>
                                                            <cfloop query="qgetCetaceanSpecies">
                                                                <!--- <cfif active eq 1> --->
                                                                    <option value="#qgetCetaceanSpecies.id#" <cfif #qgetCetaceanSpecies.id# eq #qLCEData.species#>selected</cfif>>
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
                                                                    <option value="#qgetStrandingType.ID#" <cfif #qgetStrandingType.ID# eq #qLCEData.StTpye#>selected</cfif>>#qgetStrandingType.type#</option>
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
                                                                        <option class="stock_value" value="#getStock.ID#" <cfif ListFind(ValueList(qLCEData.NOAAStock,","),getStock.ID)>selected</cfif>>
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
                <input type="hidden" name="pdfFiles" value="#qLCEData.pdfFiles#" id="pdfFiles">
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
                        </div>
                        <cfset imgss = ValueList(qLCEData.pdfFiles,",")>
                        <div id="previousimages">
                            <CFIF listLen(imgss)> 
                                <cfloop list="#imgss#" item="item" index="index">
                
                                    <span class="pip">
                                        <a data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                            <img  class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#item#" onclick="selected(this)"/>
                                        </a>
                                        <br/>
                                        <cfif findNoCase("Read only ST", permissions) eq 0>
                                            <span class="remove" onclick="remov(this)" id="#item#">Remove image</span>
                                        </cfif>
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
                                            <cfif isDefined('qLCEData.species') and #qLCEData.species# neq "" >
                                                <cfloop query="getCetaceansCode">
                                                    <option value="#getCetaceansCode.id#" <cfif #getCetaceansCode.id# eq #qLCEData.code#>selected</cfif>>
                                                            #getCetaceansCode.code# </option>
                                                </cfloop>
                                            </cfif>
                                        </select>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">HERA/FB No.</label>
                                        <input class="input-style xl-width" type="text" value="#qLCEData.hera#" name="hera" id="hera">
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
                                                <option value="#sex[j]#" <cfif #sex[j]# eq #qLCEData.sex#>selected</cfif>>#sex[j]#</option>
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
                                                <option value="#ageClass[j]#" <cfif #ageClass[j]# eq #qLCEData.ageClass#>selected</cfif>>#ageClass[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 ">
                                <div class="form-group flex-center">
                                    <label>Location</label>
                                    <textarea class="form-control textareaCustomReset locations-textarea" name="Location"
                                        maxlength="75">#qLCEData.Location#</textarea>
                                </div>
                                <div class="form-group flex-center">
                                    <label>Affiliated ID</label>
                                    <input class="form-control"type="text" name="affiliatedID" value="#qLCEData.affiliatedID#" maxlength="80">
                                </div>
                            </div>   
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="lat-one">Lat</label>
                                        <input class="input-style xl-width" type="text" value="#qLCEData.lat#" name="lat" id="AtLatitude">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="lon-one">Lon</label>
                                        <input class="input-style xl-width" type="text" value="#qLCEData.lon#" name="lon" id="AtLongitude">
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
                                            <cfloop array="#Conditions#" item="item" index="j">
                                                <option value="#item#" <cfif #item# eq #qLCEData.InitialCondition#>selected</cfif>>#ConditionsValue[j]#-#item#</option>
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
                                            <cfloop array="#Conditions#" item="item" index="j">
                                                <option value="#item#" <cfif #item# eq #qLCEData.FinalCondition#>selected</cfif>>#ConditionsValue[j]#-#item#</option>
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
                                                    <option value="#qgetIR_CountyLocation.IR_CountyLocation#" <cfif #qgetIR_CountyLocation.IR_CountyLocation# eq #qLCEData.county#>selected</cfif>>#qgetIR_CountyLocation.IR_CountyLocation#</option>
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
                                     style="resize: auto;">#qLCEData.BriefHistory#</textarea>
                                </div>
                            </div>        
                        </div>
                    </div>
                </div>
                <div class="form-holder">
                    <div class="row">
                        <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6 heartrate-one">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="flex-center mb-1">
                                        <label class="">Heart Rate</label>
                                        <div class="input">
                                            <input class="input input-style" type="text" value=""  id="heartRate" placeholder="beats/min">
                                            <span id="H_rate" class="heart_rate_error"></span>
                                            <input type="hidden" id="hr" name="heartRate" value="">
                                        </div>
                                    </div>
                                    <div class="flex-center flex-row rate-wrap">
                                        <label class="">Time</label>
                                        <div class="input-group date " id="datetimepicker_heartRateTime">
                                            <input class="input-style input-type-time" type="text" value=""  id="heartRateTime" placeholder="hh:mm:ss">
                                            <input type="hidden" id="hrt" name="heartRateTime" value="">
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                        </div>    
                                        <input type="button" class="btn btn-success" id="heartRateTimeNew"
                                            value="Add New" onClick="AddNewRate()" />
                                    </div>
                                    <span id="H_rate_time" class="H_rate_time_error"></span>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover" id="heartHistory" <cfif isDefined('qgetHeartData') AND #qgetHeartData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th>Heart Rate</th>
                                        <th>Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetHeartData')>
                                        <cfloop query="qgetHeartData">
                                            <tr>
                                                <td>#qgetHeartData.heartRate#</td>
                                                <td>#qgetHeartData.heartRateTime#</td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6 heartrate-two">
                                <div class="form-group">
                                <div class="input-group">
                                    <div class="flex-center mb-1">
                                        <label class="resp-rate">Resp Rate</label>
                                        
                                        <div class="input">
                                            <input type="text" class="input input-style"  value="" id="respRate" placeholder="beats/min">
                                            <span id="resp_rate" class="resp_rate_error"></span>
                                            <input type="hidden" value="" name="respRate" id="rr">
                                        </div>
                                    </div>
                                    <div class="flex-center flex-row rate-wrap">
                                        <label class="">Time</label>
                                        <div class="input-group date" id="datetimepicker_respRateTime">
                                            <input class="input-style input-type-time" type="text" value="" id="respRateTime" placeholder="hh:mm:ss">
                                            <input type="hidden" value="<cfif isDefined('qgetRespData')>#qgetRespData.respRateTime#</cfif>" name="respRateTime" id="rrt">
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                        </div> 
                                        <input type="button" class="btn btn-success" id="respRateTimeNew" value="Add New" onClick="AddNewResp()"/>
                                    </div>
                                    <span id="resp_rate_time" class="resp_rate_time_error"></span>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover" id="respHistory" <cfif isDefined('qgetRespData') AND #qgetRespData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th>Resp Rate</th>
                                        <th>Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetRespData')>
                                        <cfloop query="qgetRespData">
                                            <tr>
                                                <td>#qgetRespData.respRate#</td>
                                                <td>#qgetRespData.respRateTime#</td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-lg-6 col-md-12 heartrate-full">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 heartrate-three">
                                <div class="form-group">
                                    <div class="input-group flex-center flex-row">
                                        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6 p-0 flex-center flex-row"> 
                                            <label class="">ECG</label>
                                            <div class="radio-buttons"> 
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="1" name="ECG" id="ECGyes" <cfif #qLCEData.ECG# eq 1>
                                                    checked</cfif>>
                                                    <label for="ECGyes">Yes</label>
                                                </div>
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="0" name="ECG" id="ECGyno" <cfif #qLCEData.ECG# eq 0>
                                                    checked</cfif>>
                                                    <label for="ECGyno">No</label>
                                                </div>
                                            </div>
                                        </div>
                                            <div class="col-lg-7 col-md-7 col-sm-6 col-xs-6 p-0">
                                        <label class="">Results</label>
                                        <textarea class="form-control textareaCustomReset results-textarea" name="ECGresults"
                                            maxlength="75">#qLCEData.ECGresults#</textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 p-0 heartrate-four">
                                <div class="form-group">
                                    <div class="input-group flex-center flex-row">
                                            <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6 p-0 flex-center flex-row"> 
                                            <label class="">Ultrasound</label>
                                            <div class="radio-buttons"> 
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="1" name="Ultrasound" id="Ultrasoundyes" <cfif #qLCEData.Ultrasound# eq 1>
                                                    checked</cfif>>
                                                    <label for="Ultrasoundyes">Yes</label>
                                                </div>
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="0" name="Ultrasound" id="Ultrasoundyno" <cfif #qLCEData.Ultrasound# eq 0>
                                                    checked</cfif>>
                                                    <label for="Ultrasoundyno">No</label>
                                                </div>
                                            </div>
                                            </div>
                                            <div class="col-lg-7 col-md-7 col-sm-6 col-xs-6 p-0"> 
                                            <label class="">Results</label>
                                            <textarea class="form-control textareaCustomReset results-textarea" name="Ultrasoundresults"
                                            maxlength="75">#qLCEData.Ultrasoundresults#</textarea>
                                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 pl-0 mucus-padd">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Mucus Membrane Color</label>
                                        <div class="input">
                                            <select class="form-control" name="mmc" id="mmc">
                                                <option value="">Select Mucus Membrane Color</option>
                                                <cfloop from="1" to="#ArrayLen(MucusMembraneColor)#" index="j">
                                                    <option value="#MucusMembraneColor[j]#" <cfif #MucusMembraneColor[j]# eq #qLCEData.mmc#>selected</cfif>>#MucusMembraneColor[j]#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 pr-0 refil-padd">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Capillary Refill Time</label>
                                        <div class="input">
                                            <input class="input input-style" type="text" value="#qLCEData.crt#" name="crt" id="crt">
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div> 
                    </div>
                </div>
                <!---Drugs Administered --->
                <div class="form-holder blue-bg">
                    <h5><strong>Drugs Administered</strong></h5>
                    <div class="row">
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Type</label>
                                <select class="form-control" id="Drugtype">
                                    <option value="">Select Type</option>
                                    <cfloop query="#qgetDrugType#">
                                        <cfif status eq 1>
                                            <option value="#qgetDrugType.ID#">#qgetDrugType.Type#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                                <input type="hidden" value="" name="Drugtype" id="dt">
                            </div>
                            <span id="D_type" class="D_type_error"></span>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Admin Method</label>
                                <select class="form-control" id="DrugMethod">
                                    <option value="">Select Method</option>
                                    <cfloop query="#qgetDrugMethod#">
                                        <cfif status eq 1>
                                            <option value="#qgetDrugMethod.Method#">#qgetDrugMethod.Method#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                                <input type="hidden" value="" name="DrugMethod" id="dm">
                            </div>
                            <span id="D_method" class="D_method_error"></span>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width drug-time">
                            <div class="form-group input-group flex-center">
                                <label class="">Time</label>
                                <div class="input-group date" id="datetimepicker_DrugTime">
                                    <input class="input-style input-type-time" type="text" value="" id="DrugTime" placeholder="hh:mm:ss">
                                    <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                </div> 
                                <input type="hidden" value="" name="DrugTime" id="dtime">
                            </div>
                            <span id="D_time" class="D_time_error"></span>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Dosage</label>
                                <div class="input">
                                    <input type="text" class="input input-style" id="DrugDosage">
                                    <input type="hidden" value="" name="DrugDosage" id="dd">
                                </div>
                            </div>
                            <span id="D_dosage" class="D_dosage_error"></span>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <div class="form-group input-group flex-center">
                                <label class="">Total Volume</label>
                                <div class="input">
                                    <input type="text" class="input input-style" id="DrugVolume" placeholder="ml">
                                    <input type="hidden" value="" name="DrugVolume" id="dv">
                                </div>
                            </div>
                            <span id="D_volume" class="D_volume_error"></span>
                        </div>
                        <div class="col-lg-1 col-md-4 col-sm-6 col-xs-6 drug-width">
                            <input type="button" class="btn btn-success ml-auto" id="drugsNew" value="Add New" onClick="AddNewDrug()"/>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-6">
                            <table class="table table-bordered table-hover" id="drugHistory" <cfif isDefined('qgetDrugData') AND #qgetDrugData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th>Type</th>
                                        <th>Admin Method</th>
                                        <th>Time</th>
                                        <th>Dosage</th>
                                        <th>Total Volume</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetDrugData')>
                                        <cfloop query="qgetDrugData">
                                            <tr>
                                                <td>#qgetDrugData.Drugtype#</td>
                                                <td>#qgetDrugData.DrugMethod#</td>
                                                <td>#qgetDrugData.DrugTime#</td>
                                                <td>#qgetDrugData.DrugDosage#</td>
                                                <td><cfif #qgetDrugData.DrugVolume# neq 0>#qgetDrugData.DrugVolume#</cfif></td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!---Samples Taken --->
                <div class="form-holder">
                    <h5><strong>Samples Taken</strong></h5>
                    <div class="row">
                        <div class="col-lg-7 col-md-12 sample-one">
                            <div class="input-group mb-1">
                                <div class="col-lg-3 col-md-3 col-sm-4 col-xs-4 flex-center flex-row">
                                    <label class="">Sputum Sample</label>
                                    <div class="radio-buttons"> 
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="1" name="SputumSample" id="SputumSampleyes" <cfif #qLCEData.SputumSample# eq 1>
                                                    checked</cfif>>
                                            <label for="SputumSampleyes">Yes</label>
                                        </div>
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="0" name="SputumSample" id="SputumSampleno" <cfif #qLCEData.SputumSample# eq 0>
                                                    checked</cfif>>
                                            <label for="SputumSampleno">No</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-8 col-xs-8 flex-center ">
                                    <label class="">Collected For</label>

                                    <select class="form-control search-box" multiple="multiple" name="SSCollectedFor" id="SSCollectedFor">
                                        <cfloop from="1" to="#ArrayLen(SSCollectedFor)#" index="j">
                                            <option value="#SSCollectedFor[j]#" <cfif ListFind(ValueList(qLCEData.SSCollectedFor,","),#SSCollectedFor[j]#)>selected</cfif>>#SSCollectedFor[j]#</option>
                                        </cfloop>
                                    </select>
                                    </div>
                            </div>
                            <div class="input-group mb-1">
                                <div class="col-lg-3 col-md-3 col-sm-4 col-xs-4 flex-center flex-row">
                                    <label class="">Skin/Lesion</label>
                                    <div class="radio-buttons"> 
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="1" name="SkinLesion" id="SkinLesionYes" <cfif #qLCEData.SkinLesion# eq 1>
                                                    checked</cfif>>
                                            <label for="SkinLesionYes">Yes</label>
                                        </div>
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="0" name="SkinLesion" id="SkinLesioneNo" <cfif #qLCEData.SkinLesion# eq 0>
                                                    checked</cfif>>
                                            <label for="SkinLesioneNo">No</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-8 col-xs-8 flex-center">
                                    <label class="">Collected For</label>
                                    <select class="form-control search-box" multiple="multiple" name="SLCollectedFor" id="SLCollectedFor">
                                    <cfloop from="1" to="#ArrayLen(SLCollectedFor)#" index="j">
                                            <option value="#SLCollectedFor[j]#" <cfif ListFind(ValueList(qLCEData.SLCollectedFor,","),#SLCollectedFor[j]#)>selected</cfif>>#SLCollectedFor[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                            <div class="input-group mb-1">
                                <div class="col-lg-3 col-md-3 col-sm-4 col-xs-4 flex-center flex-row">
                                    <label class="">Blood Samples</label>
                                    <div class="radio-buttons"> 
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="1" name="BloodSamples" id="BloodSamplesYes" <cfif #qLCEData.BloodSamples# eq 1>
                                                    checked</cfif>>
                                            <label for="BloodSamplesYes">Yes</label>
                                        </div>
                                        <div class="radio-btn flex-center flex-row"> 
                                            <input type="radio" value="0" name="BloodSamples" id="BloodSamplesNo" <cfif #qLCEData.BloodSamples# eq 0>
                                                    checked</cfif>>
                                            <label for="BloodSamplesNo">No</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-8 col-xs-8 flex-center form-group">
                                    <label class="">Collected For</label>
                                    <select class="form-control search-box" multiple="multiple" name="BSCollectedFor" id="BSCollectedFor">
                                    <cfloop from="1" to="#ArrayLen(BSCollectedFor)#" index="j">
                                            <option value="#BSCollectedFor[j]#" <cfif ListFind(ValueList(qLCEData.BSCollectedFor,","),#BSCollectedFor[j]#)>selected</cfif>>#BSCollectedFor[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 flex-center">
                                    <label class="">Blood Volume</label>
                                    <div class="input">
                                        <input class="input input-style" type="text" value="#qLCEData.BSBloodVolume#" name="BSBloodVolume">
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-12 sample-two">
                            <div class="input-group">
                                <label class="">Notes</label>
                                <textarea class="form-control textareaCustomReset locations-textarea" name="BSNotes"
                                    maxlength="75">#qLCEData.BSNotes#</textarea>
                            </div>
                        </div>
                    </div>
                        <div class="saperator"></div>
                    <div class="row">
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group input-group flex-center">
                                <label class="">Biopsy Type</label>
                                <select class="form-control"id="BiopsyType">
                                    <option value="">Select Biopsy Type</option>
                                    <cfloop query="#qgetBiopsyType#">
                                        <cfif status eq 1>
                                            <option value="#qgetBiopsyType.ID#">#qgetBiopsyType.Type#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                                <input type="hidden" name="BiopsyType" id="bte" value="">
                            </div>
                            <sapn id="B_type" class="B_type_error"></sapn>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group input-group flex-center">
                                <label class="">Biopsy Location</label>
                                <select class="form-control"  id="BiopsyLocation">
                                    <option value="">Select Biopsy Location</option>
                                    <cfloop query="#qgetBiopsyLocation#">
                                        <cfif status eq 1>
                                            <option value="#qgetBiopsyLocation.ID#">#qgetBiopsyLocation.Location#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                                <input type="hidden" name="BiopsyLocation" id="bloc" value="">
                            </div>
                            <sapn id="B_location" class="B_location_error"></sapn>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group input-group flex-center">
                                <label class="">Biopsy Size</label>
                                <div class="input">
                                    <input type="text" class="input input-style" id="BiopsySize"
                                    placeholder="cm">
                                    <input type="hidden" name="BiopsySize" id="bsize" value="">
                                </div>
                            </div>
                            <sapn id="B_size" class="B_size_error"></sapn>
                        </div>
                        <div class="col-lg-3 col-md-12">
                            <div class="form-group input-group flex-center">
                                <input type="button" id="BiopsyNew" class="btn btn-success ml-auto"
                                    value="Add New Biopsy" onClick="AddNewBiopsy()">
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-5">
                            <table class="table table-bordered table-hover" id="biopsyHistory" <cfif isDefined('qgetBiopsyData') AND #qgetBiopsyData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th>Biopsy Type</th>
                                        <th>Biopsy Location</th>
                                        <th>Biopsy Size</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetBiopsyData')>
                                        <cfloop query="qgetBiopsyData">
                                            <tr>
                                                <td>#qgetBiopsyData.BiopsyType#</td>
                                                <td>#qgetBiopsyData.BiopsyLocation#</td>
                                                <td>#qgetBiopsyData.BiopsySize#</td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!---Body Conditions --->
                <div class="form-wrapper">
                        <h5 class="mb-1"><strong>Body Conditions</strong></h5>
                    <div class="form-holder">
                        <div class="row">
                            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-6 mb-2">
                                <div class="input-wrap flex-center">
                                <label for="BodyCondition">Body Condition</label>
                                    <select class="form-control" id="BodyCondition" name="BodyCondition">
                                        <option value="">Select Body Condition</option>
                                        <cfloop from="1" to="#ArrayLen(bodyConditions)#" index="j">
                                            <option value="#j#" <cfif #j# eq #qLCEData.BodyCondition#>selected</cfif>>#j&' - '&bodyConditions[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>    
                            <div class="col-lg-12 col-md-12">                    
                                <div class="col-lg-1 col-sm-12 col-xs-12 form-group text-center">
                                    <strong>HEAD</strong>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_NuchalCrest">Nuchal Crest:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_NuchalCrest" name="Head_NuchalCrest">
                                                <option value="0">Select Nuchal Crest</option>
                                                <cfloop query="getHeadNuchalCrest">
                                                    <option value="#getHeadNuchalCrest.ID#" <cfif #getHeadNuchalCrest.ID# eq #qLCEData.Head_NuchalCrest#>selected
                                                    </cfif>>#getHeadNuchalCrest.HNC_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_LateralCervicalReg">Lateral Cervical Region:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_LateralCervicalReg" name="Head_LateralCervicalReg">
                                                <option value="0">Select Lateral Cervical Region</option>
                                                <cfloop query="getHeadLateralCervicalReg">
                                                    <option value="#getHeadLateralCervicalReg.ID#" <cfif #getHeadLateralCervicalReg.ID# eq #qLCEData.Head_LateralCervicalReg#>selected
                                                    </cfif>>#getHeadLateralCervicalReg.HLCR_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_FacialBones">Facial Bones:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_FacialBones" name="Head_FacialBones">
                                                <option value="0">Select Facial Bones</option>
                                                <cfloop query="getHeadFacialBones">
                                                    <option value="#getHeadFacialBones.ID#" <cfif #getHeadFacialBones.ID# eq #qLCEData.Head_FacialBones#>selected
                                                    </cfif>>#getHeadFacialBones.HFB_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_EarOS">Ear OS:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_EarOS" name="Head_EarOS">
                                                <option value="0">Select Ear OS</option>
                                                <cfloop query="getHeadEarOS">
                                                    <option value="#getHeadEarOS.ID#" <cfif #getHeadEarOS.ID# eq #qLCEData.Head_EarOS#>selected
                                                    </cfif>>#getHeadEarOS.HEOS_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                            <label for="Head_ChinSkinFolds">Chin Skin Folds:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Head_ChinSkinFolds" name="Head_ChinSkinFolds">
                                                <option value="0">Select Chin Skin Folds</option>
                                                <cfloop query="getHeadChinSkinFolds">
                                                    <option value="#getHeadChinSkinFolds.ID#" <cfif #getHeadChinSkinFolds.ID# eq #qLCEData.Head_ChinSkinFolds#>selected
                                                    </cfif>>#getHeadChinSkinFolds.HCSF_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12">
                                <div class="col-lg-1 col-sm-12 col-xs-12 form-group text-center">
                                    <strong>BODY</strong>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Body_EpaxialMuscle">Epaxial Muscle:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Body_EpaxialMuscle" name="Body_EpaxialMuscle">
                                                <option value="0">Select Epaxial Muscle</option>
                                                <cfloop query="getBodyEpaxialMuscle">
                                                    <option value="#getBodyEpaxialMuscle.ID#" <cfif #getBodyEpaxialMuscle.ID# eq #qLCEData.Body_EpaxialMuscle#>selected
                                                    </cfif>>#getBodyEpaxialMuscle.BEM_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Body_DorsalRidgeScapula">Dorsal Ridge of Scapula:</label> 
                                        <div class="input-wrap">
                                            <select class="form-control" id="Body_DorsalRidgeScapula" name="Body_DorsalRidgeScapula">
                                                <option value="0">Select Dorsal Ridge of Scapula</option>
                                                <cfloop query="getBodyDorsalRidgeScapula">
                                                    <option value="#getBodyDorsalRidgeScapula.ID#" <cfif #getBodyDorsalRidgeScapula.ID# eq #qLCEData.Body_DorsalRidgeScapula#>selected
                                                    </cfif>>#getBodyDorsalRidgeScapula.BDRS_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Body_Ribs">Ribs:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Body_Ribs" name="Body_Ribs">
                                                <option value="0">Select Ribs</option>
                                                <cfloop query="getBodyRibs">
                                                    <option value="#getBodyRibs.ID#" <cfif #getBodyRibs.ID# eq #qLCEData.Body_Ribs#>selected
                                                    </cfif>>#getBodyRibs.BR_Name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12">
                                <div class="col-lg-1 col-sm-12 col-xs-12 form-group text-center">
                                    <strong>TAIL:</strong>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Tail_TransversePro">Transverse Processes:</label>
                                        <div class="input-wrap">
                                            <select class="form-control" id="Tail_TransversePro" name="Tail_TransversePro">
                                            <option value="0">Select Transverse Processes</option>
                                            <cfloop query="getTailTransversePro">
                                                <option value="#getTailTransversePro.ID#" <cfif #getTailTransversePro.ID# eq #qLCEData.Tail_TransversePro#>selected
                                                    </cfif>>#getTailTransversePro.TTP_Name#</option>
                                            </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12">
                                <div class="col-lg-1 col-sm-12 col-xs-12 form-group text-center">
                                    <strong>LESIONS</strong>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Lesion_Present">Lesion Present:</label>
                                        <div class="input-wrap">
                                        <select class="form-control customLesionSelect" id="LesionPresent">
                                            <option value="">Select Lesion Present</option>
                                            <option value="YES">YES</option>
                                            <option value="NO">NO</option>
                                            <option value="CBD">CBD</option> 
                                        </select>
                                        <input type="hidden" name="LesionPresent" id="lpet" value="">
                                        </div>
                                    </div>
                                    <span id="Lesion_present" class="Lession_present_error"></span>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="body_condition">Lesion Type:</label>
                                        <div class="input-wrap">
                                            <select class="form-control customLesionSelect" id="LesionType" >
                                                <option value="">Select Lesion Type</option>
                                                <cfloop query="getLesionTypeData">
                                                    <option value="#getLesionTypeData.LesionTypeName#">#getLesionTypeData.LesionTypeName#</option>
                                                </cfloop>
                                            </select>
                                            <input type="hidden" name="LesionType" id="ltype" value="">
                                        </div>
                                    </div>
                                    <span id="Lesion_type" class="Lession_type_error"></span>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="region">Region:</label>
                                        <div class="input-wrap body-water">
                                            <select class="form-control selected-region"id="Region">
                                            <option value="">Select Region</option>
                                            <cfset counter = 1>
                                                <cfloop query="getRegions">
                                                    <option value="#getRegions.ID#">#counter&' - '&getRegions.RegionName#</option>
                                                    <cfset counter = counter + 1>
                                                </cfloop>
                                            </select>
                                            <input type="hidden"  id="lregion" value="" name="Region">
                                        </div>
                                    </div>
                                    <span id="Lesion_region" class="Lession_region_error"></span>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Side">Side:</label>
                                        <div class="input-wrap">
                                        <select class="form-control customLesionSelect" id="Side" >
                                            <option value="">Select Side</option>
                                            <cfloop from="1" to="#ArrayLen(sides)#" index="j">
                                                <option value="#sides[j]#">#sides[j]#</option>
                                            </cfloop>
                                        </select>
                                        <input type="hidden" name="Side" id="lside" value="">
                                        </div>
                                    </div>
                                    <span id="Lesion_side" class="Lession_side_error"></span>
                                </div>
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6 p-rl-4">
                                    <div class="form-group">
                                        <label for="Status">Status:</label>
                                        <div class="input-wrap">
                                        <select class="form-control customLesionSelect" id="Status" >
                                            <option value="">Select Status</option>
                                            <option value="Fresh">Fresh</option>
                                            <option value="Healing">Healing</option>
                                            <option value="Healed">Healed</option>
                                        </select>
                                        <input type="hidden" name="Status" id="lstatus" value="">
                                        </div>
                                    </div>
                                    <span id="Lesion_status" class="Lession_status_error"></span>
                                </div>
                            </div>
                            <div class="col-lg-1">
                            </div>
                            <div class="col-lg-5 col-md-6 col-sm-12 col-xs-12">
                                <table class="table table-bordered table-hover" id="lesionHistory" <cfif isDefined('qgetLesionData') AND #qgetLesionData.recordcount# gt 0><cfelse> hidden</cfif>>
                                    <thead>
                                        <tr>
                                            <th>Lesion Present</th>
                                            <th>Lesion Type</th>
                                            <th>Region</th>
                                            <th>Side</th>
                                            <th>Status</th>
                                            <cfif isDefined('qgetLesionData')>
                                                <th >Action</th>
                                            </cfif>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <cfif isDefined('qgetLesionData')>
                                        <cfloop query="qgetLesionData">
                                            <tr id="tr_#ID#">
                                                <td id="idd" hidden>#ID#</td>
                                                <td id="L_present#ID#">#qgetLesionData.LesionPresent#</td>
                                                <td id="L_type#ID#">#qgetLesionData.LesionType#</td>
                                                <td id="L_region#ID#">#qgetLesionData.Region#</td>
                                                <td id="L_side#ID#">#qgetLesionData.Side#</td>
                                                <td id="L_status#ID#">#qgetLesionData.Status#</td>
                                                <td id="">
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
                                <div class="form-group">
                                    <div class="flex-center flex-row">
                                        <button type="button" class="btn blue-btn" id="btn_dolphin_img">Dolphin</button>
                                        <button type="button" class="btn blue-btn" id="btn_whale_img" style="float: right">Whale</button>
                                    </div>
                                    <div class="image-area">
                                        <!---<p class="cetacean-name">Dolphin</p> --->
                                        <img src="http://test.wildfins.org/resources/assets/img/dolphin-breakdown-diagram.png" class="breakdown-image full-width"/>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="idForUpdate" value="">
                            <div class="col-lg-5 col-md-6 col-sm-12 col-xs-12 justify-content-end">
                                <input type="button" class="btn btn-success" id="addNewLesion" value="Add New Lesion" onClick="AddNewLesion()"/>
                            </div>
                                
                        </div>
                    </div>
                </div>
                <!---Physical Exam Notes --->
                <div class="form-wrapper">
                        <h5 class="mb-1"><strong>Physical Exam Notes</strong></h5>
                    <div class="form-holder physical-exam">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">General</label>
                                    <textarea class="form-control textareaCustomReset" name="General">#qLCEData.General#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Scars and Natural Markings</label>
                                    <textarea class="form-control textareaCustomReset" name="SNM">#qLCEData.SNM#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Mentation</label>
                                    <textarea class="form-control textareaCustomReset" name="Mentation">#qLCEData.Mentation#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Palpation</label>
                                    <textarea class="form-control textareaCustomReset" name="Palpation">#qLCEData.Palpation#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2">
                                <div class="input-group">
                                    <label class="">Proprioception</label>
                                    <textarea class="form-control textareaCustomReset" name="Proprioception">#qLCEData.Proprioception#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 mb-2" id="needcopy">
                                <div class="input-group">
                                    <label class="">Reflexes</label>
                                    <textarea class="form-control textareaCustomReset" name="Reflexes" id="Reflexes">#qLCEData.Reflexes#</textarea>
                                </div>
                                <br>
                            </div>
                            <cfif isDefined('qgetNewSectionData') AND #qgetNewSectionData.recordcount# gt 0>
                                <input type="hidden" id="count" value="#qgetNewSectionData.recordcount#" name="count">
                                <cfloop query="qgetNewSectionData">
                                    <div class="col-lg-12" id="needco#qgetNewSectionData.currentrow#"><br>
                                        <div class="input-group" id="needcopytoo#qgetNewSectionData.currentrow#">
                                            <label class="">New Section #qgetNewSectionData.currentrow# </label>
                                            <textarea class="form-control textareaCustomReset" id="extraNotes#qgetNewSectionData.currentrow#"name="extraNotes#qgetNewSectionData.currentrow#">#qgetNewSectionData.New_Secion#</textarea>
                                        </div>
                                    </div>
                                </cfloop>
                            <cfelse>
                                <input type="hidden" id="count" value="0" name="count">
                            </cfif>
                            <div class="col-lg-12 col-md-12 mt-2 mb-5">
                                <div class="input-group justify-content-end">
                                    <input type="button" id="addnewsec" class="btn btn-success"
                                        value="Add New Section" onClick="AddNewSection()">
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
                <!--- Fish section --->
                <cfparam  name="measureDiagram" default="Tursiops_Diagram.png">
                <cfif qLCEData.recordcount gt 0 and #qLCEData.measureImage# neq "">
                    <cfset measureDiagram = #qLCEData.measureImage#>
                </cfif>
                <div class="form-wrapper">
                    <h5 class="mb-1"><strong>Morphometrics</strong></h5>
                    <div class="form-holder"id="sec2" >
                        <div class="row">
                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
                                <img id="measureImage" src="http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/#measureDiagram#" class="full-width"/>

                                <input type="hidden" name="measureImg" id="measureImg" value="#measureDiagram#">
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                                <div class="input-group flex-center mb-1">
                                    <label class="fishtwo-labelone">Estimated Weight</label>
                                    <div class="input"> 
                                        <input class="input-style weight-input " type="text" name="EstimatedWeight" id="EstimatedWeight" value="#qLCEData.EstimeateWeight#">

                                        <select class="input-style" name="EstimatedWeightUnit">
                                            <option value="lbs" <cfif #qLCEData.EstimeateWeightUnit# eq "lbs">selected</cfif>>lbs</option>
                                            <option value="kg" <cfif #qLCEData.EstimeateWeightUnit# eq "kg">selected</cfif>>kg</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="input-group flex-center mb-1">
                                    <label class="fishtwo-labeltwo">Total Length(1)</label>
                                    <div class="input"> 
                                        <input class="input-style xl-width weight-input-four" type="text" name="TotalLenght" id="TotalLenght" value="#qLCEData.TotalLenght#" placeholder="cm"> (cm)
                                    </div>
                                </div>

                                <div class="input-group flex-center mb-1">
                                    <label class="">Rostrum to Dorsal(2)</label>
                                    <div class="input"> 
                                        <input class="input-style xl-width weight-input-four" type="text" name="RosturntoDorsal" id="RosturntoDorsal" value="#qLCEData.RosturntoDorsal#" placeholder="cm"> (cm)
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                                <div class="input-group flex-center mb-1">
                                    <label class="">Blowhole to Dorsal(3)</label>
                                    <div class="input"> 
                                        <input class="input-style weight-input-three" type="text" name="BlowholetoDorsal" id="BlowholetoDorsal" value="#qLCEData.BlowholetoDorsal#" placeholder="cm"> (cm)
                                    </div>
                                </div>

                                <div class="input-group flex-center mb-1">
                                    <label class="fishtwo-labelthree">Fluke Width (4)</label>
                                    <div class="input"> 
                                        <input class="input-style weight-input-three" type="text" name="FlukeWidth" id="FlukeWidth" value="#qLCEData.FlukeWidth#" placeholder="cm"> (cm)
                                    </div>
                                </div>

                                <div class="input-group flex-center mb-1">
                                    <label class="fishtwo-labelfour">Cervical Girth (5)</label>
                                    <div class="input"> 
                                        <input class="input-style weight-input-three" type="text" name="Cervical" id="Cervical" value="#qLCEData.Cervical#" placeholder="cm"> (cm)
                                    </div>
                                </div>
                            </div>  
                            <div class="col-lg-2 col-md-6 col-sm-6 col-xs-6">
                                <div class="input-group mb-1">
                                    <label class="fishtwo-labelsix">Axillary Girth (6)</label>
                                    <div class="input flex-center"> 
                                        <input class="input-style xl-width" type="text" name="Axillary" id="Axillary" value="#qLCEData.Axillary#" placeholder="cm"> (cm)
                                    </div>
                                </div>
                                <div class="input-group mb-1">
                                    <label class="fishtwo-labelfive">Maximum Girth (7)</label>
                                    <div class="input flex-center"> 
                                    <input class="input-style xl-width" type="text" name="Maximum" id="Maximum" value="#qLCEData.Maximum#" placeholder="cm"> (cm)
                                    </div>
                                </div>

                                <div class="input-group mb-1" id="DorsalFinHeight"  <cfif isDefined('qLCEData') AND #qLCEData.DorsalFinHeight# neq ""><cfelse> style="display: none;"</cfif>>
                                    <label class="fishtwo-labelfive">Dorsal Fin Height (8)</label>
                                    <div class="input flex-center"> 
                                    <input class="input-style xl-width" type="text" name="DorsalFinHeight" value="#qLCEData.DorsalFinHeight#" placeholder="cm"> (cm)
                                    </div>
                                </div>
                                <div class="input-group mb-1" id="RostrumtoBlowhole" <cfif isDefined('qLCEData') AND #qLCEData.RostrumtoBlowhole# neq ""><cfelse> style="display: none;"</cfif>>
                                    <label class="fishtwo-labelfive">Rostrum to Blowhole (9)</label>
                                    <div class="input flex-center"> 
                                    <input class="input-style xl-width" type="text" name="RostrumtoBlowhole"  value="#qLCEData.RostrumtoBlowhole#" placeholder="cm"> (cm)
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
                <!--- Last section --->
                <div class="form-wrapper">
                    <div class="row">
                        <div class="col-lg-8 col-md-12">
                            <div class="form-holder">
                                <div class="row">
                                    <div class="col-lg-2 col-md-3 col-sm-3 col-xs-3">
                                        <div class="input-group flex-center flex-row">
                                            <label class="">Entangled</label>
                                            <div class="radio-buttons"> 
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="1" name="Entangled" id="Entangledyes" <cfif #qLCEData.Entangled# eq 1>
                                                    checked</cfif>>
                                                    <label for="Entangledyes">Yes</label>
                                                </div>
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="0" name="Entangled" id="Entangledno" <cfif #qLCEData.Entangled# eq 0>
                                                    checked</cfif>>
                                                    <label for="Entangledno">No</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-3 col-sm-3 col-xs-3">
                                        <div class="input-group flex-center flex-row">
                                            <label class="">Taged</label>
                                            <div class="radio-buttons"> 
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="1" name="Taged" id="Tagedyes" <cfif #qLCEData.Taged# eq 1>
                                                    checked</cfif>>
                                                    <label for="Tagedyes">Yes</label>
                                                </div>
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="0" name="Taged" id="Tagedno" <cfif #qLCEData.Taged# eq 0>
                                                    checked</cfif>>
                                                    <label for="Tagedno">No</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-5 col-md-6 col-sm-6 col-xs-6">
                                        <div class="input-group flex-center mb-1">
                                            <label class="taged-type">Tag Type</label>
                                            <div class="input"> 
                                                <input class="input-style xl-width" type="text" name="TagedType" id="TagedType" value="#qLCEData.TagedType#">
                                            </div>
                                        </div>

                                        <div class="input-group flex-center mb-1">
                                            <label class="">Tag Location</label>
                                            <div class="input"> 
                                                <input class="input-style xl-width" type="text" name="TagedLocation" id="TagedLocation" value="#qLCEData.TagedLocation#">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                                        <div class="input-group flex-center flex-row mb-2">
                                            <label class="">Released</label>
                                            <div class="radio-buttons"> 
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="1" name="Released" id="Releasedyes" <cfif #qLCEData.Released# eq 1>
                                                    checked</cfif>>
                                                    <label for="Releasedyes">Yes</label>
                                                </div>
                                                <div class="radio-btn flex-center flex-row"> 
                                                    <input type="radio" value="0" name="Released" id="Releasedno" <cfif #qLCEData.Released# eq 0>
                                                    checked</cfif>>
                                                    <label for="Releasedno">No</label>
                                                </div>
                                            </div>
                                            <input type="hidden" name="maxNotes" value="" id="maxNotes">
                                        </div>
                                        <div class="input-group flex-center mb-1">
                                            <label class="last-lat">Lat</label>
                                            <div class="input"> 
                                                <input class="input-style xl-width" type="text" name="TagedLat" id="AtLatitudeTaged" value="#qLCEData.TagedLat#">
                                            </div>
                                        </div>
                                        <div class="input-group flex-center mb-1">
                                            <label class="">Lon</label>
                                            <div class="input"> 
                                                <input class="input-style xl-width" type="text" name="TagedLon" id="AtLongitudeTaged" value="#qLCEData.TagedLon#">
                                            </div>
                                        </div>
                                        <div class="justify-content-end">
                                            <input type="button" id="verify" class="btn btn-skyblue" value="Verify" onclick="checkLatLngTaged()">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-12">
                            <div class="form-holder p-0">
                                <textarea class="form-control textareaCustomReset release-textarea" name="RLD" placeholder="Release Location Description">#qLCEData.RLD#</textarea> 
                            </div>
                        </div>

                    </div>
                </div>
                <!--- Buttons Section--->
                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToHIForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoHIForm" value="Save and go to HI Form" onclick="chkreq(event)"></input>
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoAForm" value="Save and go to Level A Form" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div>

                     

                        <div class="flex-center flex-wrap bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" value="Save and Close" name="SaveAndClose" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                <input type="submit" id="deleteAllRecord" name="deleteAllRecord" class="btn btn-orange m-rl-4" value="Delete All Record" onclick="if(confirm('Are you sure to Delete all Records?')){}else{return false;};">
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
  
        .pip {
        display: inline-block;
        margin: 10px 10px 0 0;
        }
        .dis-flex.just-center {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 30px 0 0;
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
        .btn-skyblue:hover{
            color: #FFF;
        }
        .H_rate_time_error{
            font-style: oblique;
            color:red;
            margin-left: 60px;
        }
        .heart_rate_error{
            font-style: oblique;
            color:red;
        }
        .resp_rate_time_error{
            font-style: oblique;
            color:red;
            margin-left: 64px;
        }
        .resp_rate_error{
            font-style: oblique;
            color:red;
        }
        .D_volume_error{
            font-style: oblique;
            color:red;
            margin-left: 74px;
        }
        .D_dosage_error{
            font-style: oblique;
            color:red;
            margin-left: 48px;
        }
        .D_time_error{
            font-style: oblique;
            color:red;
            margin-left: 32px;
        }
        .D_method_error{
            font-style: oblique;
            color:red;
            margin-left: 91px;
        }
        .D_type_error{
            font-style: oblique;
            color:red;
            margin-left: 53px;
        }
        .B_type_error{
            font-style: oblique;
            color:red;
            margin-left: 72px;
        }
        .B_location_error{
            font-style: oblique;
            color:red;
            margin-left: 95px;
        }
        .B_size_error{
            font-style: oblique;
            color:red;
            margin-left: 68px;
        }
        .Lession_present_error{
            font-style: oblique;
            color:red;
        }
        .Lession_type_error{
            font-style: oblique;
            color:red;
        }
        .Lession_region_error{
            font-style: oblique;
            color:red;
        }
        .Lession_side_error{
            font-style: oblique;
            color:red;
        }
        .Lession_status_error{
            font-style: oblique;
            color:red;
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
        .county-label {
            padding-right: 55px;
        }
        .sex-label {
            padding-right: 76px;
        }
        @media (max-width: 1399px){
            .cetaceanExam-date-form .form-group.flex-center {
            flex-wrap: wrap;
            }
            .cetaceanExam-date-form .input-group.flex-center {
            flex-wrap: wrap;
            }
        }
        @media (max-width: 1199px){
            .cetaceanExam-date-form .form-group.flex-center {
            flex-wrap: nowrap;
            }
            .cetaceanExam-date-form .input-group.flex-center {
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
            <li><a href="javascript:;">Cetacean Exam</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>