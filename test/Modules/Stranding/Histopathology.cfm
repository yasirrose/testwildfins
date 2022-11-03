<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    
    <cfset getTeams=Application.SightingNew.getTeams()>
    <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()>
    <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>
    <cfset qgetStrandingType=Application.StaticDataNew.getStrandingType()>
    <cfset getStock=Application.StaticDataNew.getStock()>
    <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
    <cfset qgetDiagnosticLab=Application.StaticDataNew.getDiagnosticLab()>
    <cfset qgetSampleType=Application.StaticDataNew.getSampleType()>
    <cfparam  name="url.LCE_ID" DEFAULT="0">
    <cfif isDefined('SaveAndNew') OR isDefined('SaveandgotoBloodForm') OR isDefined('SaveAndClose')>
        <cfset form.check = "1">
        <!--- If updating existing data --->
        <cfif  isDefined('form.ID') and form.ID neq "">
            <!--- if sampletype field is not empty then insert Histo sample form's data which can be multiple at single time --->
            <cfif form.SampleType neq "" and form.SampleNote neq "">
                <cfset form.HI_ID = "#form.ID#">
                <cfset Application.Stranding.InsertHistopathologySampleData(argumentCollection="#Form#")>
            </cfif>
            <cfset LCE = Application.Stranding.HistoFormUpdate(argumentCollection="#Form#")>
            <cfif isDefined('SaveandgotoBloodForm') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=BloodValues&LCE_ID=#url.LCE_ID#" >
            <cfelseif isDefined('SaveandgotoBloodForm') and url.LCE_ID eq 0 >
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=BloodValues" >
            </cfif>
        <cfelse>
            <!--- If inserting new data --->
            <cfset form.LCE_ID = url.LCE_ID>
            <!--- here LCE is catching ID against the latest form/data inserted --->
            <cfset LCE = Application.Stranding.HistoFormInsert(argumentCollection="#Form#")>
            <cfset form.HI_ID = "#LCE#">
            <cfif form.SampleType neq "" and form.SampleNote neq "">
                <cfset Application.Stranding.InsertHistopathologySampleData(argumentCollection="#Form#")>
            </cfif>
            <cfif isDefined('SaveandgotoBloodForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=BloodValues&LCE_ID=#url.LCE_ID#" >
            </cfif>
        </cfif>
    <cfelseif isDefined('delete')>
        <cfset Application.Stranding.deleteHisto("#form#")>
    <cfelseif isDefined('deleteHIstoRecord')>
        <cfset Application.Stranding.deleteHIstoRecord()>
    </cfif>
    <!--- if user directed from the Cetacean form, here get first 4 forms data of Cetacean form --->
    

    <cfif url.LCE_ID neq 0 and url.LCE_ID neq " ">
        <!--- below storing LCE_ID in "form.LCEID" which catched from URL and getting data from tables against that id  --->
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.getHistoDataByLCE("#form.LCEID#")>
        <cfset qgetHIData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>
        <cfset qgetHistoSampleData = Application.Stranding.getHistoSampleData(HI_ID="#form.LCEID#")>    
        <cfif #qgetHIData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
        </cfif>
        <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
            <cfset form.HI_ID = neworexist.ID>
        </cfif>
    </cfif>
    <!---   getting data on the basis of HI_ID  --->
    <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
        <cfset form.LCEID = form.HI_ID>
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetHIData=Application.Stranding.getHistoData("#form.LCEID#")>
        <cfset qgetHistoSampleData = Application.Stranding.getHistoSampleData(HI_ID="#form.LCEID#")>
        <cfif #qgetHIData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
        </cfif>
    </cfif>
    <!---  setup empty form when directly clicked the HI link from side bar --->
    <cfif url.LCE_ID eq 0 AND Not isDefined('form.HI_ID')>
        <cfset qgetHIData=Application.Stranding.getHisto_ten()>
        <!---  setup empty form when when entering new record --->
    <cfelseif  isDefined('form.HI_ID') AND form.HI_ID eq "">
        <cfset qgetHIData=Application.Stranding.getHisto_ten()>
    </cfif>
    <!---  get all records order by ID DESC--->
    <cfset getHistoID=Application.Stranding.getHistoID()>
    <!---  get all records order by Date Desc --->
    <cfset qgetHIDate=Application.Stranding.getHistoDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetHIFBNumber=Application.Stranding.getHistoFBNumber()>
    <cfoutput>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Histopathology</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Histopathology</h1>
            <!-- end page-header -->
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myform" action="#Application.siteroot#/?Module=Stranding&Page=Histopathology" method="post" >
                            <label for="sel1">Select Histopathology</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                    <option value="">Select Histopathology</option>
                                    <cfloop query="getHistoID">
                                        <option value="#getHistoID.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #getHistoID.ID#>selected</cfif>>#getHistoID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="#Application.siteroot#/?Module=Stranding&Page=Histopathology" method="post" >
                            <label for="sel1">Search Histopathology By Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetHIDate">
                                        <option value="#qgetHIDate.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetHIDate.ID#>selected</cfif>>#qgetHIDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="#Application.siteroot#/?Module=Stranding&Page=Histopathology" method="post" >
                        <label for="sel1">Search Histopathology By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetHIFBNumber">
                                    <option value="#qgetHIFBNumber.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetHIFBNumber.ID#>selected</cfif>>#qgetHIFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <cfif isDefined('form.HI_ID') and form.HI_ID neq "">
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
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
            <form id="myform" action="" method="post">
                <div class="form-wrapper">  
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="histopathology-date-form form-group m-0 blue-bg-l">
                                    <div class="row">
                                        <div class="col-lg-12 p-0">
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="date-padd">Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <input type="text" placeholder="YYYY-MM-DD" name="date" id="date"
                                                                class="form-control" value='#DateTimeFormat(qgetHIData.Date, "YYYY-MM-DD")#' required/>
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="start-time">Start Time</label>
                                                        <div class="input-group date " id="datetimepicker_StartTime">
                                                            <input type="text" value="#TimeFormat(qgetHIData.StartTime, "HH:nn")#" placeholder="hh:mm:ss" name="StartTime" id="StartTime"
                                                                class="form-control" />
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
                                                    <label class="end-time">End Time</label>
                                                    <div class="input-group date" id="datetimepicker_EndTime">
                                                        <input type="text"  value="#TimeFormat(qgetHIData.EndTime, "HH:nn")#" placeholder="hh:mm:ss" name="EndTime" id="EndTime"
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
                                                            <input type="text" value="#qgetHIData.Fnumber#" class="form-control" name="Fnumber" id="Fnumber" required>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">NMFS Regional ##</label>
                                                        <input class="input-style xl-width" type="text" value="#qgetHIData.NMFS#" name="NMFS" id="NMFS">
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group">
                                                    <div class="input-group flex-center">
                                                        <label class="">National Database ##</label>
                                                        <input class="input-style xl-width" type="text" value="#qgetHIData.NDB#" name="NDB" id="NDB">
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-12 col-md-12"> 
                                                <div class="form-group m-0">
                                                    <div class="input-group flex-center">
                                                        <label class="">Standing Agreement or Authority</label>
                                                        <div class="input">
                                                            <input class="input input-style" type="text" value="#qgetHIData.NAA#" name="NAA" id="NAA">
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
                                                                <cfif active eq 1>
                                                                    <option value="#getTeams.RT_ID#" <cfif ListFind(ValueList(qgetHIData.ResearchTeam,","),getTeams.RT_ID)>selected</cfif>>#getTeams.RT_MemberName#</option>
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
                                                                    <option value="#qgetVeterinarians.ID#" <cfif ListFind(ValueList(qgetHIData.Veterinarian,","),qgetVeterinarians.ID)>selected</cfif>>#qgetVeterinarians.Veterinarians#</option>
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
                                                                        <option value="#getSurveyAreaData.ID#" <cfif ListFind(ValueList(qgetHIData.BodyOfWater,","),getSurveyAreaData.ID)>selected</cfif>>#getSurveyAreaData.AreaName#</option>
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
                                                        <select class="form-control selectCustomReset" name="species" id="species"
                                                            onChange="getCode()">
                                                            <cfloop query="qgetCetaceanSpecies">
                                                                <cfif active eq 1>
                                                                    <option value="#qgetCetaceanSpecies.id#" <cfif #qgetCetaceanSpecies.id# eq #qgetHIData.species#>selected</cfif>>
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
                                                                    <option value="#qgetStrandingType.ID#" <cfif #qgetStrandingType.ID# eq #qgetHIData.StTpye#>selected</cfif>>#qgetStrandingType.type#</option>
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
                                                                        <option class="stock_value" value="#getStock.ID#" <cfif ListFind(ValueList(qgetHIData.NOAAStock,","),getStock.ID)>selected</cfif>>
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
                <!---  Following logic to get the data from the HI table and seting value to qgetHIData variable --->
                <cfif url.LCE_ID neq 0>
                    <cfset qgetHIData=Application.Stranding.getHisto_ten()>
                </cfif>
                <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                    <cfset form.LCEID = form.HI_ID>
                    <cfset qgetHIData=Application.Stranding.getHistoData(argumentCollection="#Form#")>
                    <input type="hidden" name="LCE_ID" value="#qgetHIData.LCE_ID#">
                <cfelse>
                    <cfset qgetHIData=Application.Stranding.getHisto_ten()>
                <input type="hidden" name="LCE_ID" value="#url.LCE_ID#">
                </cfif>
                
                <input type="hidden"  name="ID" value="#qgetHIData.ID#">
                
                <!--- this input field is using for check in stranding.cfc for general Update function --->
                <input type="hidden"  name="check" value="1">
                <input type="hidden" name="histopathology_fields" value="1">
                <div class="form-holder">  
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6"> 
                                <div class="form-group flex-center">
                                    <label class="">Histopathology Date</label>
                                        <div class="input-group date " id="datetimepicker_Date_sad">
                                            <input type="text" placeholder="YYYY-MM-DD" name="HistopathologyDate" id="HistopathologyDate"
                                            class="form-control" value='#DateTimeFormat(qgetHIData.histoDate, "YYYY-MM-DD")#' />
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                        </div>
                                </div>
                                <input type="hidden" value="" name="SADate" id="sad">
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Pathologist Accession Number</label>
                                        <input class="input-style xl-width" type="text" value="#qgetHIData.PathologistAccession#" name="PathologistAccession" id="PathologistAccession">
                                    </div>
                                </div>
                            </div>                
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group input-group flex-center">
                                    <label class="lab-label">Diagnostic Lab</label>
                                    <select class="form-control" name="LabSentto" id="LabSentto">
                                        <option value="">Select Diagnostic Lab</option>
                                        <cfloop query="#qgetDiagnosticLab#">
                                            <cfif status eq 1>
                                                <option value="#qgetDiagnosticLab.ID#"<cfif #qgetHIData.DiagnosticLab# eq #qgetDiagnosticLab.ID#>selected</cfif>>#qgetDiagnosticLab.Diagnostic#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                    <input type="hidden" value="" name="LabSentto" id="lsto">
                                </div>
                            </div>                
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 ">
                                <div class="form-group flex-center">
                                    <label class="scomment-label">Sample Comments</label>
                                    <textarea class="form-control textareaCustomReset locations-textarea" name="SampleComments">
                                        #Trim(qgetHIData.SampleComments)#
                                    </textarea>
                                </div>
                            </div>             
                        </div>
                    </div>
                </div>

                <!---Sample Collection --->
                <div class="form-holder blue-bg sample-type-form">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group">
                                <div class="input-group flex-center" id="sampleT">
                                    <label class="county-label ">Sample Type</label>
                                    <select class="form-control search-box" name="" id="SampleType">
                                        <option value="">Select Sample</option>
                                        <cfloop query="qgetSampleType">
                                            <cfif status  neq 0>
                                                <option value="#qgetSampleType.ID#">#qgetSampleType.Type#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" name="SampleType" id="stype">
                            </div>
                            <span id="stypee" class="sampleType_error"></span>
                        </div>
                    
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-group flex-center">
                                <label class="snotes-label">Results</label>
                                <textarea type="text" class="form-control textareaCustomReset locations-textarea" id="SampleNote" maxlength="2084"></textarea>
                                <input type="hidden" name="SampleNote" id="snotes">
                            </div>
                        </div>
                        <input type="hidden" name="tables" id="tables">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <input type="button" class="btn btn-success ml-auto" id="drugsNew" value="Add New" onClick="AddDrug()"/>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-12">
                            <table class="table simple-type-table table-bordered table-hover" id="drugHistory" <cfif isDefined('qgetHistoSampleData') AND #qgetHistoSampleData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th class="col-lg-4">Sample Type</th>
                                        <th>Result</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetHistoSampleData')>
                                        <cfloop query="qgetHistoSampleData">
                                            <tr>
                                                <td>#qgetHistoSampleData.SampleType#</td>
                                                <td><cfif #qgetHistoSampleData.SampleNote# neq 0>#qgetHistoSampleData.SampleNote#</cfif></td>
                                            </tr>
                                        </cfloop>
                                    </cfif>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoBloodForm" value="Save and go to Blood Values" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div>
                        <div class="flex-center flex-wrap bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                <input type="submit" id="deleteHIstoRecord" name="deleteHIstoRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete all Records?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>
            </form>    
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
        .sampleType_error{
            font-style: oblique;
            color:red;
            margin-left: 111px;
        }
        .sampleNote_error{
            font-style: oblique;
            color:red;
            margin-left: 53px;
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
        .scomment-label {
            padding-right: 16px;
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
        #drugsNew{
            margin-top: 40px;
        }
        #sampleT{
            margin-top: 44px;
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
        .county-label {
            padding-right: 35px;
        }
        .sex-label {
            padding-right: 76px;
        }
        .Examtype-label {
            padding-right: 49px;
        }
        .LocationofHI-label {
            padding-right: 55px;
        }
        .GearDeposition-label {
            padding-right: 93px;
        }
        .form-holder .form-group textarea.form-control.locations-textarea {
            padding: 5px 12px;
        }
        
        .sample-type-form .form-group div#sampleT,
        .sample-type-form input#drugsNew {
            margin: 0;
        }
        .sample-type-form .row {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
        }
        .sample-type-form .simple-type-table td {
            word-break: break-all;
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
            .histopathology-date-form .form-group .input-group.date .form-control {
                padding: 0px 5px;
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
        @media (max-width: 1399px){
            .histopathology-date-form .form-group.flex-center {
                flex-wrap: wrap;
            }
            .histopathology-date-form .input-group.flex-center {
                flex-wrap: wrap;
            }
            .form-holder.blue-bg .histopathology-date-form.form-group.blue-bg-l {
                padding-bottom: 0;
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
            .histopathology-date-form .form-group.flex-center {
                flex-wrap: nowrap;
            }
            .sample-type-form label.county-label {
                padding-right: 10px;
            }
            .sample-type-form .sampleType_error {
                margin-left: 80px;
            }
            .histopathology-date-form .input-group.flex-center {
                flex-wrap: nowrap;
            }
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
            .sample-type-form .sampleType_error,
            .sample-type-form .sampleNote_error {
                margin-left: 0;
            }
            .sample-type-form .col-lg-12{
                width: 100%;
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
<cfelse>
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Stranding</a></li>
            <li><a href="javascript:;">Histopathology</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>