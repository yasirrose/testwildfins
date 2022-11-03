<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    
    <cfset getTeams=Application.SightingNew.getTeams()>
    <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()>
    <cfset getSurveyAreaData=Application.SightingNew.getSurveyArea()>
    <cfset qgetStrandingType=Application.StaticDataNew.getStrandingType()>
    <cfset qgetIR_CountyLocation=Application.StaticDataNew.getIR_CountyLocation()>
    <cfset getStock=Application.StaticDataNew.getStock()>
    <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
    <cfset qgetDiagnosticLab=Application.StaticDataNew.getDiagnosticLab()>
    <cfset qgetRBCMorphology=Application.StaticDataNew.getRbcMorphology()>
    <cfset qgetPlateletMorphology=Application.StaticDataNew.getPlateletMorphology()>
    <cfset qgetWbcMorphology=Application.StaticDataNew.getWbcMorphology()>
    <cfset qgetHemolysisIndex=Application.StaticDataNew.getHemolysisIndex()>
    <cfset qgetLipemiaIndex=Application.StaticDataNew.getLipemiaIndex()>
    <cfset qgetTissueType=Application.StaticDataNew.getTissueType()>
    <cfset Selectoptions = ['High','Low','Critical Result','Corrected Result','None']>
    <cfparam  name="url.LCE_ID" DEFAULT="0">
    <cfif isDefined('SaveAndNew') OR isDefined('SaveandgotoAncillaryDiagnostics') OR isDefined('SaveAndClose') OR isdefined('Add_new') >
        <!--- If updating existing data --->
        <cfif  isDefined('form.TX_ID') and form.TX_ID neq "">
            <cfset form.Toxi_ID = "#form.TX_ID#">
            <cfif form.tisu_type neq "" and form.tisu_type neq "0">
                <cfset Application.Stranding.ToxiType_FormUpdate(argumentCollection="#Form#")>
                <cfset Application.Stranding.Update_DynamicToxiType(argumentCollection="#Form#")>
                <cfset Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
            <cfelse>
                <cfset TT_ID =Application.Stranding.ToxiType_Insert(argumentCollection="#Form#")>
                <cfset Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
            </cfif>
            <cfset Application.Stranding.Toxicology_FormUpdate(argumentCollection="#Form#")>
            <cfset form.HI_ID = "">
            <cfset form.Tissue_type = "">
            <cfif isDefined('SaveandgotoAncillaryDiagnostics') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=AncillaryDiagnostics&LCE_ID=#url.LCE_ID#" >
            <cfelseif isDefined('SaveandgotoAncillaryDiagnostics') and url.LCE_ID eq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=AncillaryDiagnostics" >
            </cfif>
        <cfelse>     
            <!--- If inserting new data --->
            <cfset form.LCE_ID = url.LCE_ID>
            <cfset Toxi_ID = Application.Stranding.Toxicology_FormInsert(argumentCollection="#Form#")>
            <cfset form.Toxi_ID = "#Toxi_ID#">
            <cfset TT_ID = Application.Stranding.ToxiType_Insert(argumentCollection="#Form#")>
            <!--- DT is Dynamic toxi --->
            <cfset DT_ID = Application.Stranding.DynamicToxiType_Insert(argumentCollection="#Form#")>
            <cfset form.HI_ID = "">
            <cfset form.Tissue_type = "">
            <cfif isDefined('SaveandgotoAncillaryDiagnostics')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=AncillaryDiagnostics&LCE_ID=#url.LCE_ID#" >
            </cfif>
        </cfif>

    <cfelseif isDefined('delete')>
        <cfset Application.Stranding.deletToxicology("#form#")>
        <cfset form.HI_ID = "">
    <cfelseif isDefined('deleteToxicologyAllRecord')>
        <cfset Application.Stranding.deleteToxicologyAllRecord()>
        <!--- <cfset form.HI_ID = ""> --->
    </cfif>
    <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->
    <cfif url.LCE_ID neq 0>
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.gettoxiByLCE("#form.LCEID#")>
        <cfset qgetHIDataCetacean=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>
        <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
            <cfset form.HI_ID = neworexist.ID>
        </cfif>
    </cfif>
    <!---   getting data on the basis of HI_ID  --->
    <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetHIData=Application.Stranding.gettoxiform("#form.HI_ID#")>
        <cfif isdefined('form.Tissue_type') and form.Tissue_type neq "">
            <cfset qgetToxitype=Application.Stranding.getToxitype("#form.Tissue_type#,#form.TX_ID#")>
            <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype("#form.Tissue_type#")>
        <cfelse>
            <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
            <cfset qgetDynamicToxitype=Application.Stranding.getDynamicToxitype_ten()>
        </cfif>
    <cfelse>
        <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
        <cfset qgetHIData=Application.Stranding.gettoxiform_ten()>
    </cfif>
    
    <!---  setup empty form when directly clicked the HI link from side bar --->
    <cfif url.LCE_ID eq 0 AND Not isDefined('form.HI_ID')>
        <cfset qgetHIData=Application.Stranding.gettoxiform_ten()>
        <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
        <!---  setup empty form when when entering new record --->
    <cfelseif  isDefined('form.HI_ID') AND form.HI_ID eq "">
        <cfset qgetToxitype=Application.Stranding.getToxitype_ten()>
    </cfif>
    <!---  get all records order by ID DESC--->
    <cfset getHistoID=Application.Stranding.gettoxiform_ID()>
    <!---  get all records order by Date Desc --->
    <cfset qgetHIDate=Application.Stranding.gettoxiformDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetHIFBNumber=Application.Stranding.gettoxifNumber()>
    <cfoutput>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Toxicology</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Toxicology</h1>
            <!-- end page-header -->
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                        <form action="#Application.siteroot#/?Module=Stranding&Page=Toxicology" method="post" >
                            <label for="sel1">Select Toxicology</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                    <option value="">Select Toxicology</option>
                                    <cfloop query="getHistoID">
                                        <option value="#getHistoID.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #getHistoID.ID#>selected</cfif>>#getHistoID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                        <form  action="#Application.siteroot#/?Module=Stranding&Page=Toxicology" method="post" >
                            <label for="sel1">Search Toxicology By Analysis Date:</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                    <option value="">Select Date</option>
                                    <cfloop query="qgetHIDate">
                                        <option value="#qgetHIDate.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #qgetHIDate.ID#>selected</cfif>>#qgetHIDate.Analysis_date#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                    <form  action="#Application.siteroot#/?Module=Stranding&Page=Toxicology" method="post" >
                        <label for="sel1">Search Toxicology By Field Number:</label>
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
                        <div class="form-group blood-from-froup input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#qgetHIData.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                <cfelse>
                    <div class="col-lg-3 col-md-4">
                        <div class="form-group blood-from-froup input-group select-width">
                            <label for="sel1">Cetacean Exam Number</label>
                            <div class="input">
                                <input type="text" value="#url.LCE_ID#" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                </cfif>    
            </div>
            <form id="myform" action="" method="post">
                <input type="hidden"  name="TX_ID" value="#qgetHIData.ID#">
                <input type="hidden"  name="HI_ID" value="#qgetHIData.ID#">
                <input type="hidden" name="tisu_type" value="#qgetToxitype.Tissue_type#">
                <input type="hidden" name="toxi_type_ID" value="#qgetToxitype.ID#">
                <input type="hidden" name="LCE_ID" value="#qgetHIData.LCE_ID#">
                
                <!--- this input field is using for check in stranding.cfc for general Update function --->
                <input type="hidden"  name="check" value="1">
                <input type="hidden"  name="bloodvalue_fields" value="1">
                <input type="hidden"  name="blood_toxi" value="1">
                <div class="form-wrapper">  
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="bloodValues-date-form form-holder blue-bg pb-2 cust-css">  
                                <div class="form-group blood-from-froup m-0 blue-bg-l pt-m">
                                    <div class="row">
                                        <div class="col-lg-12 p-0">
                                            <div class="col-lg-6 col-md-6 col-sm-4 col-xs-6"> 
                                                <div class="form-group blood-from-froup">
                                                    <label class="date-padd">Collection Date</label>
                                                        <div class="input-group date field-size" id="collection_date_picker">
                                                            <input type="text" placeholder="mm/dd/yyyy" name="collection_date" id="collection_date"
                                                                class="form-control" value='#DateTimeFormat(qgetHIData.Collection_Date, "MM/dd/YYYY")#'  />
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-4 col-xs-6"> 
                                                <div class="form-group blood-from-froup">                                                   
                                                    <label class="date-padd">Analysis Date</label>
                                                        <div class="input-group date field-size" id="datetimepicker_Date">
                                                            <input type="text" placeholder="mm/dd/yyyy" name="Analysis_date" id="date"
                                                                class="form-control" value='#DateTimeFormat(qgetHIData.Analysis_date, "MM/dd/YYYY")#'  />
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-4 col-xs-6">
                                                <div class="form-group blood-from-froup input-group sl-p">
                                                    <label class="lab-label">Diagnostic Lab</label>
                                                    <select class="form-control" name="LabSentto" id="LabSentto">
                                                        <option value="">Select Lab</option>
                                                        <cfloop query="#qgetDiagnosticLab#">
                                                            <cfif status eq 1>
                                                                <option value="#qgetDiagnosticLab.ID#" <cfif #qgetDiagnosticLab.ID# eq #qgetHIData.Diagnostic_Lab#>selected</cfif>>#qgetDiagnosticLab.Diagnostic#</option>
                                                            </cfif>
                                                        </cfloop>
                                                    </select>
                                                    <input type="hidden" value="" name="LabSentto" id="lsto">
                                                </div>
                                            </div> 
                                            <div class="col-lg-6 col-md-6 col-sm-4 col-xs-6"> 
                                                <div class="form-group blood-from-froup">
                                                    <div class="input-group">
                                                        <label class="field-number cust-l">Field Number</label>
                                                        <div class="input">
                                                            <input type="text" value="<cfif isdefined('qgetHIDataCetacean')>#qgetHIDataCetacean.Fnumber#<cfelse>#qgetHIData.Fnumber#</cfif>" class="form-control xl-width" name="Fnumber" id="Fnumber" required >
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-6 col-md-6 col-sm-4 col-xs-6"> 
                                                <div class="form-group blood-from-froup">
                                                    <div class="input-group">
                                                        <label class="cust-l">Lab number</label>
                                                        <input class="input-style xl-width" type="text" value="#qgetHIData.Lab_Number#" name="Lab_num" id="Lab_numb">
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
                                <div class="form-group blood-from-froup m-0">
                                    <div class="row">
                                        <div class="col-lg-12 p-0 green-labels">
                                            <div class="col-lg-12">
                                                <div class="form-group blood-from-froup input-group flex-center">
                                                    <label>Team Members</label>
                                                    <div class="input"> 

                                                            <select class="form-control search-box" multiple="multiple" name="ResearchTeam"
                                                            id="ResearchTeam">
                                                            <cfloop query="getTeams">
                                                                <cfif active eq 1>
                                                                    <option value="#getTeams.RT_ID#" <cfif isdefined('qgetHIDataCetacean') and ListFind(ValueList(qgetHIDataCetacean.ResearchTeam,","),getTeams.RT_ID)>selected<cfelseif #ListFind(ValueList(qgetHIData.ResearchTeam,","),getTeams.RT_ID)#>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group blood-from-froup input-group flex-center">
                                                    <label class="veterinarian">Veterinarian</label>
                                                    <div class="input">
                                                        <select class="form-control search-box" multiple="multiple" name="Veterinarian" id="Veterinarian">
                                                            <cfloop query="qgetVeterinarians">
                                                                <cfif status eq 1>
                                                                    <option value="#qgetVeterinarians.ID#" <cfif isdefined('qgetHIDataCetacean') and ListFind(ValueList(qgetHIDataCetacean.Veterinarian,","),qgetVeterinarians.ID)>selected<cfelseif #ListFind(ValueList(qgetHIData.Veterinarian,","),qgetVeterinarians.ID)#>selected</cfif>>#qgetVeterinarians.Veterinarians#</option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                            <div class="col-lg-12"> 
                                                <div class="form-group blood-from-froup">
                                                    <div class="input-group flex-center">
                                                        <label class="">Body of Water</label>
                                                        <div class="input">
                                                            <select class="combobox form-control search-box" multiple="multiple" name="BodyOfWater">
                                                                <cfloop query="getSurveyAreaData">
                                                                    <cfif active eq 1>
                                                                        <option value="#getSurveyAreaData.ID#" <cfif isdefined('qgetHIDataCetacean') and  ListFind(ValueList(qgetHIDataCetacean.BodyOfWater,","),getSurveyAreaData.ID)>selected<cfelseif #ListFind(ValueList(qgetHIData.BodyOfWater,","),getSurveyAreaData.ID)#>selected</cfif>>#getSurveyAreaData.AreaName#</option>
                                                                    </cfif>
                                                                </cfloop>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group blood-from-froup flex-center">
                                                    <label class="">Species</label>
                                                    <div class="input">
                                                        <select class="form-control selectCustomReset" name="species" id="species"
                                                            onChange="getCode()">
                                                            <cfloop query="qgetCetaceanSpecies">
                                                                <cfif active eq 1>
                                                                    <option value="#qgetCetaceanSpecies.id#" <cfif isdefined('qgetHIDataCetacean') and #qgetCetaceanSpecies.id# eq #qgetHIDataCetacean.species#>selected<cfelseif #qgetCetaceanSpecies.id# eq #qgetHIData.species#>selected</cfif>>
                                                                        #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group blood-from-froup input-group flex-center">
                                                    <label class="veterinarian">Stranding Type</label>
                                                    <div class="input">
                                                        <select class="form-control" name="StTpye" id="StTpye">
                                                            <option value="">Select Stranding Type</option>
                                                            <cfloop query="qgetStrandingType">
                                                                <cfif status eq 1>
                                                                    <option value="#qgetStrandingType.ID#" <cfif isdefined('qgetHIDataCetacean') and #qgetStrandingType.ID# eq #qgetHIDataCetacean.StTpye#>selected<cfelseif #qgetStrandingType.ID# eq #qgetHIData.StTpye#>selected</cfif>>#qgetStrandingType.type#</option>
                                                                </cfif>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12"> 
                                                <div class="form-group blood-from-froup m-0">
                                                    <div class="input-group flex-center">
                                                        <label class="">NOAA Stock</label>
                                                        <div class="input">
                                                            <select class="combobox form-control search-box" multiple="multiple" name="NOAAStock" id="stock_value">
                                                                <option value="">Select NOAA Stock</option>
                                                                <cfloop query="getStock">
                                                                    <cfif active eq 1>
                                                                        <option class="stock_value" value="#getStock.ID#" <cfif isdefined('qgetHIDataCetacean') and  ListFind(ValueList(qgetHIDataCetacean.NOAAStock,","),getStock.ID)>selected<cfelseif #ListFind(ValueList(qgetHIData.NOAAStock,","),getStock.ID)#>selected</cfif>>
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
               
                <h5 class="mb-1"><strong>Toxicology</strong></h5>
                <div class="form-holder blood-form-holder Toxi-sec">  
                    <div class="form-group blood-from-froup scrol">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
                                <div class="form-group blood-from-froup type">
                                    <div class="input-group ">
                                        <label class="">Tissue Type</label>
                                        <select class="form-control search-box" name="Tissue_type" id="Tissue_type" <cfif isdefined('form.HI_ID') and form.HI_ID neq "">onChange="this.form.submit()"</cfif>>
                                            <option value="">Select Tissue Type</option>
                                            <cfloop query="qgetTissueType">
                                                <cfif status  neq 0>
                                                    <option value="#qgetTissueType.ID#" <cfif isdefined('form.Tissue_type') and form.Tissue_type eq #qgetTissueType.ID#>selected</cfif>>#qgetTissueType.Type#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group c-b">
                                        <label class="">Dry Weight Fraction (gravimetry)</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group c-b">
                                        <label class="">Reference Range</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group c-b">
                                        <label class="">Sample Result</label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Arsenic</label>
                                        <input class="Arsenic" type="text" maxlength="8" value="#qgetToxitype.Arsenic#" name="Arsenic"  id="Arsenic"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Arsenic _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Arsenic_Reference_Range#" name="Arsenic_Reference_Range"  id="Arsenic_Reference_Range"><span>ug/g dry</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Arsenic_Sample_Result" id="Arsenic_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Arsenic_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Cadmium</label>
                                        <input class="Cadmium" type="text" maxlength="8" value="#qgetToxitype.Cadmium#" name="Cadmium"  id="Cadmium"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Cadmium _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Cadmium_Reference_Range#" name="Cadmium_Reference_Range"  id="Cadmium _Reference_Range"><span>ug/g dry</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Cadmium_Sample_Result" id="Cadmium_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Cadmium_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Lead</label>
                                        <input class="Lead" type="text" maxlength="8" value="#qgetToxitype.Lead#" name="Lead"  id="Lead"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Lead _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Lead_Reference_Range#" name="Lead_Reference_Range"  id="Lead _Reference_Range"><span>ug/g dry</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm- col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Lead_Sample_Result" id="Lead_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Lead_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Mercury</label>
                                        <input class="Mercury" type="text" maxlength="8" value="#qgetToxitype.Mercury#" name="Mercury"  id="Mercury"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Mercury _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Mercury_Reference_Range#" name="Mercury_Reference_Range"  id="Mercury _Reference_Range"><span>ug/g dry</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Mercury_Sample_Result" id="Mercury_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Mercury_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Thallium</label>
                                        <input class="Thallium" type="text" maxlength="8" value="#qgetToxitype.Thallium#" name="Thallium"  id="Thallium"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Thallium _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Thallium_Reference_Range#" name="Thallium_Reference_Range"  id="Thallium _Reference_Range"><span>ug/g dry</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Thallium_Sample_Result" id="Thallium_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Thallium_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Selenium</label>
                                        <input class="Selenium" type="text" maxlength="8" value="#qgetToxitype.Selenium#" name="Selenium"  id="Selenium"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Selenium _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Selenium_Reference_Range#" name="Selenium_Reference_Range"  id="Selenium _Reference_Range"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Selenium_Sample_Result" id="Selenium_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Selenium_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Iron</label>
                                        <input class="Iron" type="text" maxlength="8" value="#qgetToxitype.Iron#" name="Iron"  id="Iron"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Iron _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Iron_Reference_Range#" name="Iron_Reference_Range"  id="Iron _Reference_Range"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Iron_Sample_Result" id="Iron_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Iron_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Copper</label>
                                        <input class="Copper" type="text" maxlength="8" value="#qgetToxitype.Copper#" name="Copper"  id="Copper"><span>ug/g dry</span>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Copper _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Copper_Reference_Range#" name="Copper_Reference_Range"  id="Copper _Reference_Range"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Copper_Sample_Result" id="Copper_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Copper_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Zinc</label>
                                        <input class="Zinc" type="text" maxlength="8" value="#qgetToxitype.Zinc#" name="Zinc"  id="Zinc"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Zinc _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Zinc_Reference_Range#" name="Zinc_Reference_Range"  id="Zinc _Reference_Range"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Zinc_Sample_Result" id="Zinc_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Zinc_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Molybdenum</label>
                                        <input class="Molybdenum" type="text" maxlength="8" value="#qgetToxitype.Molybdenum#" name="Molybdenum"  id="Molybdenum"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Molybdenum _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Molybdenum_Reference_Range#" name="Molybdenum_Reference_Range"  id="Molybdenum _Reference_Range"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Molybdenum_Sample_Result" id="Molybdenum_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Molybdenum_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Manganese</label>
                                        <input class="Manganese" type="text" maxlength="8" value="#qgetToxitype.Manganese#" name="Manganese"  id="Manganese"><span>ug/g dry</span>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Manganese _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Manganese_Reference_Range#" name="Manganese_Reference_Range"  id="Manganese _Reference_Range"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Manganese_Sample_Result" id="Manganese_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Manganese_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Cobalt</label>
                                        <input class="Cobalt" type="text" maxlength="8" value="#qgetToxitype.Cobalt#" name="Cobalt"  id="Cobalt"><span>ug/g dry</span>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup thre-rw">
                                    <div class="input-group ">
                                        <label class="">Reference Range</label>
                                        <input class="Cobalt _Reference_Range" type="text" maxlength="8" value="#qgetToxitype.Cobalt_Reference_Range#" name="Cobalt_Reference_Range"  id="Cobalt _Reference_Range"><span>ug/g dry</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group result-row">
                                        <label class="county-label">Sample Result</label>
                                        <select class="form-control" name="Cobalt_Sample_Result" id="Cobalt_Sample_Result">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetToxitype.Cobalt_Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <cfif isDefined('qgetDynamicToxitype') AND #qgetDynamicToxitype.recordcount# gt 0>
                                <input type="hidden" id="saad" value="#qgetDynamicToxitype.recordcount#" name="count">
                                <cfloop query="qgetDynamicToxitype">
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                        <div class="form-group blood-from-froup thre-rw">
                                            <div class="input-group ">
                                                <label class="">#qgetDynamicToxitype.Label#</label>
                                                <input class="" type="text" value="#qgetDynamicToxitype.Toxi_type#" name="toxitype#qgetDynamicToxitype.ID#"  id=""><span>ug/g dry</span>  
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                        <div class="form-group blood-from-froup thre-rw">
                                            <div class="input-group ">
                                                <label class="">Reference Range</label>
                                                <input class=" _Reference_Range" type="text" maxlength="8" value="#qgetDynamicToxitype.Reference_Range#" name="toxirange#qgetDynamicToxitype.ID#"  id=" _Reference_Range"><span>ug/g dry</span> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                        <div class="form-group blood-from-froup">
                                            <div class="input-group result-row">
                                                <label class="county-label">Sample Result</label>
                                                <select class="form-control" name="toxireport#qgetDynamicToxitype.ID#" id="_Sample_Result">
                                                    <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                        <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetDynamicToxitype.Sample_Result#>selected</cfif>>#Selectoptions[j]#</option>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </cfloop>
                            </cfif>
                            <div id="Toxi"> </div>
                            <input type="hidden" name="dynamic_Toxi" value="" id="dynamic_Toxi">
                            <input type="button" id="Add_new" name="Add_new" class="btn btn-success m-rl-4" value="Add New" onclick="newToxi()">
                        </div>
                    </div>
                </div>
                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoAncillaryDiagnostics" value="Save and go to Ancillary Diagnostics" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div>
                        <div class="flex-center flex-wrap bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.HI_ID') and form.HI_ID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-oRangem-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                <input type="submit" id="deleteToxicologyAllRecord" name="deleteToxicologyAllRecord" class="btn btn-oRangem-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>
            </form>    
        </div>
    </cfoutput>

<style>
#Toxi {
    width: 100%;
}
.row.toxi-rw {
    padding: 0 10px;
    margin-bottom: 15px;
}
.toxi-rw .col-lg-4 #toxi_label {
    width: 27%;
    margin-right: 5px;
}
.toxi-rw .col-lg-4 #toxi_type {
    width: 45%;
    margin-right: 4px;
}
.toxi-rw .col-lg-4 label {
    width: 28%;
}
#Toxi {
    width: 100%;
    padding: 0px 0 10px 0;
}
.toxi-rw .col-lg-4 input {
    width: 45%;
    margin-right: 4px;
    border: 0;
    border-bottom: 2px solid #bec3c6;
}
.toxi-rw span,.toxi-rw label{
    margin-top: auto;
}
.toxi-rw .col-lg-4 label.t-cust-l {
    padding-right: 55px;
    margin: auto;
}
.toxi-rw .col-lg-4 #toxi_report {
    height: 30px;
    padding: 0px 12px;
    border-radius: 0;
    width: 100%;
}
.toxi-rw .col-lg-4 {
    display: flex;
}
.thre-rw .input-group {
    display: flex;
}
.blood-form-holder.Toxi-sec .blood-column .blood-from-froup.thre-rw .input-group input[type="text"] {
    width: 45%;
}
.thre-rw .input-group label {
    width: 28%;
    margin-top: auto;
    line-height: .7;
}
.thre-rw .input-group span {
    margin-top: auto;
    line-height: .7;
}
.input-group.c-b label {
    text-align: center;
    font-weight: bold;
    display: block;
}
.result-row {
    display: flex;
}
.blood-form-holder.Toxi-sec .blood-column .blood-from-froup .input-group input[type="text"] {
    width: 25%;
    /* height: 6px; */
    margin-right: 4px;
    margin-top: 0;
    margin-bottom: 0;
}
.cust-css .field-number {
    padding-right: 0;
}
.cust-css .form-group label.cust-l {
    width: 45%;
    margin: unset;
    float: left;
}
.cust-css .form-group .xl-width {
    width: 55%;
}
    .cust-css .form-group {
    display: flex;
}
.cust-css .form-group label {
    width: 80%;
    min-width: unset;
    margin: auto;
    max-width: initial;
    display: block;
}
.type .input-group {
    display: flex;
}
.blue-bg-l.pt-m {
    padding-bottom: 148px;
}
.cust-css .form-group select {
    width: 96%;
    padding: 0;
}
/* .field-size input, .cust-css .form-control {
    font-size: 11px;
    padding: 0 5px;
} */
   .field-size input,.cust-css .form-control {
    font-size: 11px;
    padding: 0 5px;
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
        .wbc_count{
            width: 100%;
            margin: 8px 0;
            box-sizing: border-box;
            border: none;
            border-bottom: 1px solid black;

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
        .bloodValues-date-form .form-group blood-from-froup label {
            padding-right: 5px;
            width: 55%;
            display: block;
        }
        .btn {
            padding: 0 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 30px;
        }
        /* .date-padd{
            padding-right: 81px;
        } */
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
        .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
            width: 60%;
            margin: 8px 0;
            box-sizing: border-box;
            border: none;
            border-bottom: 2px solid #bec3c6;
            outline: none;
        }
        .blood-form-holder .blood-column .blood-from-froup .input-group.date input {
            width: 100%;
            margin: 0;
            border: 2px solid #bec3c6;
        }
        .blood-form-holder .blood-from-froup .row {
            justify-content: flex-start;
            display: flex;
            flex-wrap: wrap;
        }
        .blood-form-holder .blood-from-froup .blood-from-froup textarea {
            height: 44px !important;
            width: 100% !important;
            padding: 4px 10px;
        }
        @media (max-width: 1799px){
            .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
                width: 45%;
            }
        }
        @media (max-width: 1599px){
            .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
                width: 40%;
            }
        }
        @media (max-width: 1399px){
            .bloodValues-date-form .form-group blood-from-froup.flex-center {
            flex-wrap: wrap;
            }
            .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
                width: 25%;
            }
            .bloodValues-date-form .input-group.flex-center {
            flex-wrap: wrap;
            }
        }
        @media (max-width: 1199px){
            .bloodValues-date-form .form-group blood-from-froup.flex-center {
            flex-wrap: nowrap;
            }
            .bloodValues-date-form .input-group.flex-center {
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
        @media (max-width:1350px){
            .field-size input, .cust-css .form-control {
    font-size: 8px;
}
        }
        @media (max-width:1325px){
   
            .green-labels label {
                min-width: 30%;
            }
            .cust-css .form-group label {
               font-size: 11px;
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
        @media (max-width:1218px){
            .blood-form-holder.Toxi-sec .blood-column .blood-from-froup.thre-rw .input-group input[type="text"] {
    width: 27%;
}
.thre-rw .input-group label {
    font-size: 12px;
}
.county-label {
    padding-right: 15px;
}
.input-group .form-control {
    font-size: 12px;
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
        @media (max-width:1218px){
            .toxi-rw .col-lg-4 label {
    min-width: fit-content;
}
.toxi-rw .col-lg-4 span {
    min-width: fit-content;
}
.toxi-rw .col-lg-4 input {
    width: 25%;
}
.toxi-rw .col-lg-4 #toxi_type {
    width: 27%;
}
        }
        @media (max-width:1200px){
            .toxi-rw .col-lg-4 #toxi_label {
    width: 40%;
}
.toxi-rw .col-lg-4 #toxi_type {
    width: 45%;
}
.toxi-rw .col-lg-4 label {
    min-width: fit-content;
    font-size: 12px;
    width: 40%;
}
.toxi-rw .col-lg-4 input {
    width: 45%;
}
.toxi-rw .col-lg-4 label.t-cust-l {
    padding-right: 22px;
}
            .Toxi-sec {
    overflow-x: auto;
}
.Toxi-sec .scrol {
    width: 900px;
}
            .county-label {
    min-width: fit-content;
}
            .thre-rw .input-group label {
    width: 40%;
}
.thre-rw .input-group label {
    font-size: 12px;
    min-width: fit-content;
}
.thre-rw .input-group span {
    min-width: fit-content;
}
.blood-form-holder.Toxi-sec .blood-column .blood-from-froup.thre-rw .input-group input[type="text"] {
    width: 43%;
}
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
                        /* .input-group .form-control {
    width: 35%;
} */
.form-group.blood-from-froup.scrol .col-xs-4 {
    width: 33.33333333%;
}
            .blood-form-holder.Toxi-sec .blood-column .blood-from-froup.thre-rw .input-group input[type="text"] {
    width: 52%;
}
            .thre-rw .input-group label {
    width: 37%;
}
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
            .blood-form-holder .blood-column .blood-from-froup .input-group input[type="text"] {
                width: 80%;
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
            <li><a href="javascript:;">Toxicology</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>