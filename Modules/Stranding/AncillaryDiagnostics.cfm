<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    
    <cfset getTeams=Application.SightingNew.getTeams()>
    <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()>
    <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>
    <cfset qgetDiagnosticTest=Application.StaticDataNew.getDiagnosticTest()>
    <cfset qgetStrandingType=Application.StaticDataNew.getStrandingType()>
    <cfset getStock=Application.StaticDataNew.getStock()>
    <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
    <cfset qgetDiagnosticLab=Application.StaticDataNew.getDiagnosticLab()>
    <cfset testResult = ['Positive','Negative','Inconclusive','Normal','Abnormal','N/A']>
    <cfparam  name="url.LCE_ID" DEFAULT="0">
    <cfif isDefined('SaveAndNew') OR isDefined('SaveandgotoSampleArchive') OR isDefined('SaveAndClose')>
        <!--- If updating existing data --->
        <cfif  isDefined('form.ADID') and form.ADID neq "">
            <cfset Application.Stranding.AncillaryFormUpdate(argumentCollection="#Form#")>
            <cfif form.TestingDate neq "">
                <cfset Application.Stranding.AncillaryReportInsert(argumentCollection="#Form#")>
            </cfif>
            <cfif isDefined('SaveandgotoSampleArchive') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=SampleArchive&LCE_ID=#url.LCE_ID#" >
            <cfelseif isDefined('SaveandgotoSampleArchive') and url.LCE_ID eq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=SampleArchive">
            </cfif>
        <cfelse>
            <!--- If inserting new data --->
            <cfset form.LCE_ID = url.LCE_ID>
            <cfset NEWADID = Application.Stranding.AncillaryFormInsert(argumentCollection="#Form#")>
            <cfif form.TestingDate neq "">
                <cfset form.ADID = #NEWADID#>
                <cfset Application.Stranding.AncillaryReportInsert(argumentCollection="#Form#")>
            </cfif>
            <cfif isDefined('SaveandgotoSampleArchive')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=SampleArchive&LCE_ID=#url.LCE_ID#" >            
            </cfif>
        </cfif>
    <cfelseif isDefined('delete')>
        <cfset Application.Stranding.deleteAncillary("#form#")>
    <cfelseif isDefined('deleteAncillaryAllRecord')>
        <cfset Application.Stranding.deleteAncillaryAllRecord()>
    </cfif>
    <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->
    <cfif url.LCE_ID neq 0>
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.getAncillaryDataByLCE("#form.LCEID#")>
        <cfset qgetHIData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>    
        <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
            <cfset form.AD_ID = neworexist.ID>
            <cfset qAncillaryReportGet=Application.Stranding.AncillaryReportGet(ADID="#form.AD_ID#")>
        </cfif>
    </cfif>
    <!---   getting data on the basis of HI_ID  --->
    <cfif  isDefined('form.AD_ID') and form.AD_ID neq "">
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetHIData=Application.Stranding.getAncillaryData("#form.AD_ID#")>
        <cfset qAncillaryReportGet=Application.Stranding.AncillaryReportGet("#form.AD_ID#")>
    </cfif>
    <!---  setup empty form when directly clicked the HI link from side bar --->
    <cfif url.LCE_ID eq 0 AND Not isDefined('form.AD_ID')>
        <cfset qgetHIData=Application.Stranding.getAncillary_ten()>
        <!---  setup empty form when when entering new record --->
    <cfelseif  isDefined('form.AD_ID') AND form.AD_ID eq "">
        <cfset qgetHIData=Application.Stranding.getAncillary_ten()>
    </cfif>
    <!---  get all records order by ID DESC--->
    <cfset getHistoID=Application.Stranding.getAncillaryID()>
    <!---  get all records order by Date Desc --->
    <cfset qgetHIDate=Application.Stranding.getAncillaryDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetHIFBNumber=Application.Stranding.getAncillaryBNumber()>
    <cfoutput>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Ancillary Diagnostics</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Ancillary Diagnostics</h1>
            <!-- end page-header -->
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myform" action="#Application.siteroot#/?Module=Stranding&Page=AncillaryDiagnostics" method="post" >
                            <label for="sel1">Select Ancillary Diagnostics</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="AD_ID" onChange="this.form.submit()">
                                    <option value="">Select Ancillary Diagnostics</option>
                                    <cfloop query="getHistoID">
                                        <option value="#getHistoID.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #getHistoID.ID#>selected</cfif>>#getHistoID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="#Application.siteroot#/?Module=Stranding&Page=AncillaryDiagnostics" method="post" >
                            <label for="sel1">Search Ancillary Diagnostics By Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="AD_ID" onChange="this.form.submit()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetHIDate">
                                        <option value="#qgetHIDate.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #qgetHIDate.ID#>selected</cfif>>#qgetHIDate.date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                    <form  action="#Application.siteroot#/?Module=Stranding&Page=AncillaryDiagnostics" method="post" >
                        <label for="sel1">Search Ancillary By Field Number:</label>
                        <div class="input"> 
                            <select class="form-control search-box" name="AD_ID" onChange="this.form.submit()">
                                <option value="">Select Filed Number</option>
                                <cfloop query="qgetHIFBNumber">
                                    <option value="#qgetHIFBNumber.ID#" <cfif isDefined('form.AD_ID') and form.AD_ID eq #qgetHIFBNumber.ID#>selected</cfif>>#qgetHIFBNumber.Fnumber#</option>
                                </cfloop>
                            </select>
                        </div>
                    </form>
                    </div>
                </div>
                <cfif isDefined('form.AD_ID') and form.AD_ID neq "">
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
            <form id="myform" action="" method="post" enctype="multipart/form-data">
                <cfif isdefined('qgetHIData.LCE_ID')>
                    <input type="hidden" name="LCE_ID" value="#qgetHIData.LCE_ID#">
                    <input type="hidden"  name="ADID" value="#qgetHIData.ID#">
                <cfelse>
                    <input type="hidden" name="LCE_ID" value="#url.LCE_ID#">
                    <input type="hidden"  name="ADID" value="">
                </cfif>
                <input type="hidden"  name="check" value="1">
                <input type="hidden"  name="histopathology_fields" value="1">
                <div class="form-wrapper">  
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-holder blue-bg pb-2">  
                                <div class="ancillaryDiagnostic-date-form form-group m-0 blue-bg-l">
                                    <div class="row">
                                        <div class="col-lg-12 p-0">
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class=" form-group flex-center">
                                                    <label class="date-padd">Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <input type="text" placeholder="mm/dd/yyyy" name="date" id="date"
                                                                class="form-control" value='#DateTimeFormat(qgetHIData.Date, "MM/dd/YYYY")#' required/>
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
                <!---Sample Collection --->
                <div class="form-holder blue-bg sample-accession-form">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="">Diagnostic Test</label>
                                    <select class="form-control" id="DiagnosticTest">
                                        <option value="">Select Diagnostic Test</option>
                                        <cfloop query="qgetDiagnosticTest">
                                            <option value="#qgetDiagnosticTest.Diagnostic#">Select #qgetDiagnosticTest.Diagnostic#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="DiagnosticTest" id="DT">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="">Test Result</label>
                                    <select class="form-control" id="TestResults">
                                        <option value="">Select Test Result</option>
                                        <cfloop from="1" to="#ArrayLen(testResult)#" index="j">
                                            <option value="#testResult[j]#">#testResult[j]#</option>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="TestResults" id="TR">
                            </div>
                        </div>
                      
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <div class="form-input-holder">
                                <div class="form-group input-group flex-center">
                                    <label class="lab-label">Diagnostic Lab</label>
                                    <select class="form-control" id="DiagnosticLab">
                                        <option value="">Select Diagnostic Lab</option>
                                        <cfloop query="#qgetDiagnosticLab#">
                                            <cfif status eq 1>
                                                <option value="#qgetDiagnosticLab.Diagnostic#">#qgetDiagnosticLab.Diagnostic#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <input type="hidden" value="" name="DiagnosticLab" id="DLAB">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6"> 
                            <div class="form-input-holder">
                                <div class="form-group flex-center">
                                    <label class="label-TestingDate">Testing Date</label>
                                    <div class="input-group date " id="datetimepicker_Date_TD">
                                        <input type="text" placeholder="mm/dd/yyyy" id="TestingDate"
                                            class="form-control" value='' />
                                            <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div>
                                </div>
                                <input type="hidden" name="TestingDate" id="TD">
                            </div>
                        </div>
                        <input type="hidden" name="pdfFiles" value="" id="pdfFiles">
                        <div class="form-group" id="find">
                            <div class="row" id="start">
                                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <div class="input-group flex-center" id="filediv">
                                            <label class="file-label">Upload PDF File (Max Size: 10MB)</label>
                                            <input class="input-style xl-width" type="file" name="emptypdf" id="files" accept="application/pdf" <cfif findNoCase("Read only ST", permissions) neq 0> Disabled</cfif>>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                            <input type="button" class="btn btn-success ml-auto" id="TestNew" value="Add New" onClick="AddNewTest()"/>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="simple-accession-table">
                                <div class="responsive-tale">
                                    <table class="table table-bordered table-hover" id="drugHistory" <cfif isDefined('qAncillaryReportGet') AND #qAncillaryReportGet.recordcount# gt 0><cfelse> hidden</cfif>>
                                        <thead>
                                            <tr>
                                                <th>Diagnostic Test</th>
                                                <th>Test Result</th>
                                                <th>Diagnostic Lab</th>
                                                <th>Testing Date</th>
                                                <th>PDF</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <cfif isDefined('qAncillaryReportGet')>
                                                <cfloop query="qAncillaryReportGet">
                                                    <tr>
                                                        <td>#qAncillaryReportGet.DiagnosticTest#</td>
                                                        <td>#qAncillaryReportGet.TestResults#</td>
                                                        <td>#qAncillaryReportGet.DiagnosticLab#</td>
                                                        <td>#qAncillaryReportGet.TestingDate#</td>
                                                        <td>
                                                            <cfif #qAncillaryReportGet.pdfFiles# neq 0>
                                                            <span>
                                                                <a data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##qAncillaryReportGet.pdfFiles#" target="blank">
                                                                    <img  class="imageThumb" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#qAncillaryReportGet.pdfFiles#" onclick="selected(this)"/>
                                                                </a>
                                                            </span>
                                                            </cfif>
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
                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoSampleArchive" value="Save and go to Sample Archive" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div>
                        <div class="flex-center flex-wrap bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.AD_ID') and form.AD_ID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                 <input type="submit" id="deleteAncillaryAllRecord" name="deleteAncillaryAllRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>
            </form>  
            <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">
            
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="pdfname"></h4>
                    </div>
                    <div class="modal-body">
                        <object data="mypdf.pdf" type="application/pdf" frameborder="0" width="100%" height="600px" style="padding: 20px;">
<!---                             <embed src="https://drive.google.com/file/d/1CRFdbp6uBDE-YKJFaqRm4uy9Z4wgMS7H/preview?usp=sharing" width="100%" height="600px"/>  --->
                        <embed id="emb" src="" width="1000" height="500" type="application/pdf" title="test.pdf">

                        </object>
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
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
            max-height: 35px;
            cursor: pointer;
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
        .label-TestingDate{
            padding-right: 19px;
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
        .TypeofHI-label {
            padding-right: 78px;
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
        .LocationofHI-label {
            padding-right: 55px;
        }
        .GearDeposition-label {
            padding-right: 93px;
        }
        @media (max-width: 1399px){
            .ancillaryDiagnostic-date-form .form-group.flex-center {
            flex-wrap: wrap;
            }
            .ancillaryDiagnostic-date-form .input-group.flex-center {
            flex-wrap: wrap;
            }
        }
        @media (max-width: 1199px){
            .ancillaryDiagnostic-date-form .form-group.flex-center {
            flex-wrap: nowrap;
            }
            .ancillaryDiagnostic-date-form .input-group.flex-center {
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
            .simple-accession-table {
                overflow-x: auto;
            }
            .simple-accession-table .responsive-tale {
                width: 740px;
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
            <li><a href="javascript:;">Ancillary Diagnostics</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>