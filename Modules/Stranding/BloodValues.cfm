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
    <cfset Selectoptions = ['Normal','Abnormal','N/A']>
    <cfparam  name="url.LCE_ID" DEFAULT="0">
    <cfif isDefined('SaveAndNew') OR isDefined('SaveandgotoToxicology') OR isDefined('SaveAndClose')>
        <!--- If updating existing data --->
        <cfif  isDefined('form.ID') and form.ID neq "">
            <cfset CBCUpdate = Application.Stranding.CBCUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.FibrinogenUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.ChemisteryUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.CapillaryUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.DolphinUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.iSTAT_ChemUpdate(argumentCollection="#Form#")>
            <cfset Application.Stranding.CG4Update(argumentCollection="#Form#")>
            <cfset LCE = Application.Stranding.Blood_VFormUpdate(argumentCollection="#Form#")>
            <cfif isDefined('SaveandgotoToxicology') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Toxicology&LCE_ID=#url.LCE_ID#" >
            <cfelseif isDefined('SaveandgotoToxicology') and url.LCE_ID eq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Toxicology" >
            </cfif>
        <cfelse>        
            <!--- If inserting new data --->
            <cfset form.LCE_ID = url.LCE_ID>
            <cfset BV_ID = Application.Stranding.Blood_VFormInsert(argumentCollection="#Form#")>
            <cfset form.BV_ID = "#BV_ID#">
            <!--- inserting CBC form --->
            <cfset CBC_ID = Application.stranding.CBCInsert(argumentcollection="#Form#")> 
            <!--- Inserting Fibrinogen Form --->
            <cfset Fib_ID = Application.stranding.Fibrinogeninsert(argumentcollection="#Form#")>
            <cfset Chem_ID = Application.stranding.Chemistryinsert(argumentcollection="#Form#")>
            <cfset Chap_ID = Application.stranding.Capillaryinsert(argumentcollection="#Form#")>
            <cfset Dol_ID = Application.stranding.Dolphininsert(argumentcollection="#Form#")>
            <cfset iSTAT_ID = Application.stranding.iSTAT_Cheminsert(argumentcollection="#Form#")>
            <cfset CG4_ID = Application.stranding.CG4_Cheminsert(argumentcollection="#Form#")>
            <cfif isDefined('SaveandgotoToxicology')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=Toxicology&LCE_ID=#url.LCE_ID#" >
            </cfif>
        </cfif>
    <cfelseif isDefined('delete')>
        <cfset Application.Stranding.deletBlood_V("#form#")>
    <cfelseif isDefined('deleteBloodValuesRecord')>
        <cfset Application.Stranding.deleteBloodValuesRecord()>
    </cfif>
    <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->
    <cfif url.LCE_ID neq 0>
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.getBlood_ValuesDataByLCE("#form.LCEID#")>
        <cfset qgetHIDataCetacean=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>    
        <cfset qgetHIData=Application.Stranding.getBlood_ValuesDataByLCE("#form.LCEID#")>
       
        <cfif neworexist.recordcount gt 0 and neworexist.LCE_ID neq 0 >
            <cfset form.HI_ID = neworexist.ID>
        </cfif>
    <!--- <cfelse>
        <cfset form.LCEID = url.LCE_ID>
        <cfset qgetB_value=Application.getBlood_value("#form.LCEID#")> --->
    </cfif>
    <!---   getting data on the basis of HI_ID  --->
    <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
        <cfset form.LCEID = form.HI_ID>
        <!----this qgetHIData variable fetching data for show data accordingly id,date,FN--->
        <cfset qgetHIData=Application.Stranding.getBlood_VData("#form.LCEID#")>
        <cfset form.bloodID = form.HI_ID>
        <cfset qgetCBC_Data=Application.Stranding.getCBC_Data("#form.bloodID#")>
        <cfset qgetFibrinogen=Application.Stranding.getFibrinogen("#form.bloodID#")>
        <cfset qgetchemistry=Application.Stranding.getchemistry("#form.bloodID#")>
        <cfset qgetCapillary=Application.Stranding.getCapillary("#form.bloodID#")>
        <cfset qgetDolphin=Application.Stranding.getDolphin("#form.bloodID#")>
        <cfset qgetiSTAT_Chem=Application.Stranding.getiSTAT_Chem("#form.bloodID#")>
        <cfset qgetiSTAT_CG4=Application.Stranding.getiSTAT_CG4("#form.bloodID#")>
       
    <cfelse>
        <cfset qgetCBC_Data=Application.Stranding.getCBC_Data_ten()>
        <cfset qgetFibrinogen=Application.Stranding.getFibrinogen_ten()>
        <cfset qgetchemistry=Application.Stranding.getchemistry_ten()>
        <cfset qgetCapillary=Application.Stranding.getCapillary_ten()>
        <cfset qgetDolphin=Application.Stranding.getDolphin_ten()>
        <cfset qgetiSTAT_Chem=Application.Stranding.getiSTAT_Chem_ten()>
        <cfset qgetiSTAT_CG4=Application.Stranding.getiSTAT_CG4_ten()>
    </cfif>
    <!---  setup empty form when directly clicked the HI link from side bar --->
    <cfif url.LCE_ID eq 0 AND Not isDefined('form.HI_ID')>
        <cfset qgetHIData=Application.Stranding.getBlood_V_ten()>
        <!---  setup empty form when when entering new record --->
    <cfelseif  isDefined('form.HI_ID') AND form.HI_ID eq "">
        <cfset qgetHIData=Application.Stranding.getBlood_V_ten()>
    </cfif>
    <!---  get all records order by ID DESC--->
    <cfset getHistoID=Application.Stranding.getBlood_VID()>
    <!---  get all records order by Date Desc --->
    <cfset qgetHIDate=Application.Stranding.getBlood_VDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetHIFBNumber=Application.Stranding.getBlood_VBNumber()>

    <cfoutput>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Blood Values</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Blood Values</h1>
            <!-- end page-header -->
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group blood-from-froup input-group select-width">
                        <form id="myform" action="#Application.siteroot#/?Module=Stranding&Page=BloodValues" method="post" >
                            <label for="sel1">Select Blood Values</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                    <option value="">Select Blood Values</option>
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
                        <form  action="#Application.siteroot#/?Module=Stranding&Page=BloodValues" method="post" >
                            <label for="sel1">Search Blood Values By Analysis Date:</label>
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
                    <form  action="#Application.siteroot#/?Module=Stranding&Page=BloodValues" method="post" >
                        <label for="sel1">Search Blood Values By Field Number:</label>
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
                <div class="form-wrapper">  
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="bloodValues-date-form form-holder blue-bg pb-2">  
                                <div class="form-group blood-from-froup m-0">
                                    <div class="row">
                                        <div class="col-lg-12 p-0">
                                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"> 
                                                <div class="form-group blood-from-froup flex-center flex-wrap-wrap">
                                                    <label class="date-padd">Collection Date</label>
                                                        <div class="input-group date" id="collection_date_picker">
                                                            <input type="text" placeholder="mm/dd/yyyy" name="collection_date" id="collection_date"
                                                                class="form-control" value='#DateTimeFormat(qgetHIData.Collection_Date, "MM/dd/YYYY")#'  />
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"> 
                                                <div class="form-group blood-from-froup flex-center flex-wrap-wrap">
                                                    <label class="date-padd">Analysis Date</label>
                                                        <div class="input-group date " id="datetimepicker_Date">
                                                            <input type="text" placeholder="mm/dd/yyyy" name="Analysis_date" id="date"
                                                                class="form-control" value='#DateTimeFormat(qgetHIData.Analysis_date, "MM/dd/YYYY")#'  />
                                                                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                                        </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                                <div class="form-group blood-from-froup input-group flex-center flex-wrap-wrap">
                                                    <label class="lab-label">Diagnostic Lab</label>
                                                    <select class="form-control" name="LabSentto" id="LabSentto">
                                                        <option value="">Select Lab</option>
                                                        <cfloop query="#qgetDiagnosticLab#">
                                                            <cfif status eq 1>
                                                                <option value="#qgetDiagnosticLab.ID#" <cfif #qgetDiagnosticLab.ID# eq #qgetHIData.Diagnostic_Lab#>selected</cfif> >#qgetDiagnosticLab.Diagnostic#</option>
                                                            </cfif>
                                                        </cfloop>
                                                    </select>
                                                    <input type="hidden" value="" name="LabSentto" id="lsto">
                                                </div>
                                            </div> 
                                            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12"> 
                                                <div class="form-group blood-from-froup">
                                                    <div class="input-group flex-center flex-wrap-wrap">
                                                        <label class="field-number">Field Number</label>
                                                        <div class="input">
                                                            <input type="text" value="<cfif isdefined('qgetHIDataCetacean')>#qgetHIDataCetacean.Fnumber#<cfelse>#qgetHIData.Fnumber#</cfif>" class="form-control" name="Fnumber" id="Fnumber" required >
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"> 
                                                <div class="form-group blood-from-froup">
                                                    <div class="input-group flex-center flex-wrap-wrap">
                                                        <label class="">Lab number</label>
                                                        <input class="input-style xl-width" type="text" value="#qgetHIData.Lab_Number#" name="Lab_num" id="NMFS">
                                                    </div>
                                                </div>
                                            </div>   
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 team-member-sec">
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
                <h5 class="mb-1"><strong>CBC</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">WBC Count</label>
                                        <input class="wbc_count" type="text" maxlength="8" value="#qgetCBC_Data.wbc_count#" name="wbc_count"  id="wbc_count"> 
                                        <span> &##215; 10<sup>3</sup>&##8725;&mu;l</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="wbc_report" id="wbc_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.wbc_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="wbc_comment" id="wbc_comment"
                                     >#qgetCBC_Data.wbc_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">RBC Count</label>
                                        <input class="RBC_count" type="text" maxlength="8" value="#qgetCBC_Data.RBC_count#" name="RBC_count"  id="RBC_count"> <span> &##215; 10<sup>6</sup>&##8725;&mu;l</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="RBC_count_report" id="RBC_count_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.RBC_report #>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="RBC_count_comment" id="RBC_count_comment"
                                         >#qgetCBC_Data.RBC_count_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hemoglobin</label>
                                        <input class="Hemoglobin" type="text" maxlength="8" value="#qgetCBC_Data.Hemoglobin#" name="Hemoglobin"  id="Hemoglobin"> <span>g/dL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hemoglobin_report" id="Hemoglobin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Hemoglobin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Hemoglobin_comment" id="Hemoglobin_comment"
                                         >#qgetCBC_Data.Hemoglobin_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hematocrit %</label>
                                        <input class="Hematocrit" type="text" maxlength="8" value="#qgetCBC_Data.Hematocrit#" name="Hematocrit"  id="Hematocrit"> <span>% </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hematocrit_report" id="Hematocrit_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Hematocrit_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Hematocrit_comment" id="Hematocrit_comment"
                                         >#qgetCBC_Data.Hematocrit_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">MCV fL</label>
                                        <input class="MCV" type="text" maxlength="8" value="#qgetCBC_Data.MCV#" name="MCV"  id="MCV"><span>fL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="MCV_report" id="MCV_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.MCV_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="MCV_comment" id="MCV_comment"
                                         >#qgetCBC_Data.MCV_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">MCH pg</label>
                                        <input class="MCH" type="text" maxlength="8" value="#qgetCBC_Data.MCH#" name="MCH"  id="MCH"><span>pg </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="MCH_report" id="MCH_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.MCH_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="MCH_comment" id="MCH_comment"
                                         >#qgetCBC_Data.MCH_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">MCHC %</label>
                                        <input class="MCHC" type="text" maxlength="8" value="#qgetCBC_Data.MCHC#" name="MCHC"  id="MCHC"><span>%</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="MCHC_report" id="MCHC_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.MCHC_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="MCHC_comment" id="MCHC_comment"
                                         >#qgetCBC_Data.MCHC_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Segmented Neutrophils Abs</label>
                                        <input class="Segmented_Neutrophils_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Segmented_Neutrophils_Abs#" name="Segmented_Neutrophils_Abs"  id="Segmented_Neutrophils_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Segmented_report" id="Segmented_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Segmented_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Segmented_comment" id="Segmented_comment"
                                         >#qgetCBC_Data.Segmented_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Band Neutrophils Abs </label>
                                        <input class="Band_Neutrophils_Abs " type="text" maxlength="8" value="#qgetCBC_Data.Band_Neutrophils_Abs#" name="Band_Neutrophils_Abs"  id="Band_Neutrophils_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Band_Neutrophils_report" id="Neutrophils_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Band_Neutrophils_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Band_Neutrophils_comment" id="Neutrophils_comment"
                                         >#qgetCBC_Data.Band_Neutrophils_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Lymphocytes Abs</label>
                                        <input class="Lymphocytes_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Lymphocytes_Abs#" name="Lymphocytes_Abs"  id="Lymphocytes_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Lymphocytes_report" id="Lymphocytes_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Lymphocytes_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Lymphocytes_comment" id="Lymphocytes_comment"
                                         >#qgetCBC_Data.Lymphocytes_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Monocytes Abs</label>
                                        <input class="Monocytes_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Monocytes_Abs#" name="Monocytes_Abs"  id="Monocytes_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Monocytes_report" id="Monocytes_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Monocytes_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Monocytes_comment" id="Monocytes_comment"
                                         >#qgetCBC_Data.Monocytes_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Eosinophils Abs</label>
                                        <input class="Eosinophils_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Eosinophils_Abs#" name="Eosinophils_Abs"  id="Eosinophils_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Eosinophils_report" id="Eosinophils_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Eosinophils_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Eosinophils_comment" id="Eosinophils_comment"
                                     >#qgetCBC_Data.Eosinophils_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Basophils Abs</label>
                                        <input class="Basophils_Abs" type="text" maxlength="8" value="#qgetCBC_Data.Basophils_Abs#" name="Basophils_Abs"  id="Basophils_Abs"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Basophils_report" id="Basophils_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Basophils_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Basophils_comment" id="Basophils_comment"
                                         >#qgetCBC_Data.Basophils_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">NRBC</label>
                                        <input class="NRBC" type="text" maxlength="8" value="#qgetCBC_Data.NRBC#" name="NRBC"  id="NRBC"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="NRBC_report" id="NRBC_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.NRBC_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="NRBC_comment" id="NRBC_comment"
                                         >#qgetCBC_Data.NRBC_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="county-label">RBC Morphology</label>
                                        <select class="form-control" name="RBC_Morphology" id="RBC_Morphology">
                                            <option value="">Select RBC Morphology</option>
                                            <cfloop query="qgetRBCMorphology">
                                                <cfif status  neq 0>
                                                    <option value="#qgetRBCMorphology.RBC#" <cfif #qgetRBCMorphology.RBC# eq #qgetCBC_Data.RBC_Morphology#>selected</cfif>>#qgetRBCMorphology.RBC#</option>
                                                </cfif>
                                            </cfloop>
                                        </select> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="RBC_report" id="RBC_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.RBC_count_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="RBC_comment" id="RBC_comment"
                                         >#qgetCBC_Data.RBC_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Platelet Count (auto)</label>
                                        <input class="Platelet_Count" type="text" maxlength="8" value="#qgetCBC_Data.Platelet_Count#" name="Platelet_Count"  id="Platelet_Count"><span>  &##215; 10<sup>3</sup>&##8725;&mu;l</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Platelet_Count_report" id="Platelet_Count_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Platelet_Count_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Platelet_Count_comment" id="Platelet_Count_comment"
                                         >#qgetCBC_Data.Platelet_Count_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="county-label">Platelet Morphology</label>
                                        <select class="form-control" name="Platelet_Morphology" id="Platelet_Morphology">
                                            <option value="">Select Platelet Morphology</option>
                                            <cfloop query="qgetPlateletMorphology">
                                                <cfif status  neq 0>
                                                    <option value="#qgetPlateletMorphology.Platelet#" <cfif #qgetPlateletMorphology.Platelet# eq #qgetCBC_Data.Platelet_Morphology#>selected</cfif>>#qgetPlateletMorphology.Platelet#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Platelet_report" id="Platelet_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.Platelet_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Platelet_comment" id="Platelet_comment"
                                         >#qgetCBC_Data.Platelet_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="county-label">WBC Morphology</label>
                                        <select class="form-control" name="WBC_Morphology" id="WBC_Morphology">
                                            <option value="">Select WBC Morphology</option>
                                            <cfloop query="qgetWbcMorphology">
                                                <cfif status  neq 0>
                                                    <option value="#qgetWbcMorphology.ID#" <cfif #qgetWbcMorphology.ID# eq #qgetCBC_Data.WBC_Morphology#>selected</cfif>>#qgetWbcMorphology.WBC#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="WBCMorphology_report" id="WBCMorphology_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCBC_Data.WBCMorphology_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="WBCMorphology_comment" id="WBCMorphology_comment"
                                         >#qgetCBC_Data.WBCMorphology_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <h5 class="mb-1"><strong>Fibrinogen</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Fibrinogen</label>
                                        <input class="Fibrinogen" type="text" maxlength="8" value="#qgetFibrinogen.Fibrinogen#" name="Fibrinogen"  id="Fibrinogen"><span>mg/dl</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Fibrinogen_report" id="Fibrinogen_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetFibrinogen.Fibrinogen_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Fibrinogen_comment" id="Fibrinogen_comment"
                                         >#qgetFibrinogen.Fibrinogen_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-1"><strong>Chemistry</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Total protein (refractometer)</label>
                                        <input class="Total_protein" type="text" maxlength="8" value="#qgetchemistry.Total_protein_refractometer #" name="Total_protein_refractometer"  id="Total_protein_refractometer"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="protein_refractometer_report" id="protein_refractometer_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.protein_refractometer_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="protein_refractometer_comment" id="protein_refractometer_comment"
                                         >#qgetchemistry.protein_refractometer_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hemolysis Index</label>
                                        <select class="form-control" name="Hemolysis_Index" id="Hemolysis_Index">
                                            <option value="">Select Hemolysis Index</option>
                                            <cfloop query="qgetHemolysisIndex">
                                                <cfif status  neq 0>
                                                    <option value="#qgetHemolysisIndex.ID#" <cfif #qgetHemolysisIndex.ID# eq qgetchemistry.Hemolysis_Index>selected</cfif>>#qgetHemolysisIndex.Hemolysis#</option>
                                                </cfif>
                                            </cfloop>
                                        </select> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hemolysis_report" id="Hemolysis_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Hemolysis_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Hemolysis_comment" id="Hemolysis_comment"
                                         >#qgetchemistry.Hemolysis_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Lipemia Index</label>
                                        <select class="form-control" name="Lipemia_Index" id="Lipemia_Index">
                                            <option value="">Select Lipemia Index</option>
                                            <cfloop query="qgetLipemiaIndex">
                                                <cfif status  neq 0>
                                                    <option value="#qgetLipemiaIndex.ID#" <cfif #qgetLipemiaIndex.ID# eq qgetchemistry.Lipemia_Index>selected</cfif>>#qgetLipemiaIndex.Lipemia#</option>
                                                </cfif>
                                            </cfloop>
                                        </select> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Lipemia_report" id="Lipemia_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Lipemia_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Lipemia_comment" id="Lipemia_comment"
                                         >#qgetchemistry.Lipemia_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Glucose</label>
                                        <input class="Glucose" type="text" maxlength="8" value="#qgetchemistry.Glucose#" name="Glucose"  id="Glucose"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Glucose_report" id="Glucose_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Glucose_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Glucose_comment" id="Glucose_comment"
                                         >#qgetchemistry.Glucose_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">BUN</label>
                                        <input class="BUNf" type="text" maxlength="8" value="#qgetchemistry.BUNf#" name="BUNf"  id="BUNf"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Bunf_report" id="Bunf_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Bunf_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="BUNf_comment" id="BUNf_comment"
                                         >#qgetchemistry.BUNf_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">CREA</label>
                                        <input class="CREA" type="text" maxlength="8" value="#qgetchemistry.CREA#" name="CREA"  id="CREA"><span> mg/dL</span>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="CREA_report" id="CREA_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.CREA_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="CREA_comment" id="CREA_comment"
                                         >#qgetchemistry.CREA_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">BUN/CREA Ratio</label>
                                        <input class="BUN_CREA" type="text" maxlength="8" value="#qgetchemistry.BUN_CREA#" name="BUN_CREA"  id="BUN_CREA"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Bun_Crea_report" id="Bun_Crea_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Bun_Crea_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="BUN_CREA_comment" id="BUN_CREA_comment"
                                         >#qgetchemistry.BUN_CREA_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Sodium</label>
                                        <input class="Sodium" type="text" maxlength="8" value="#qgetchemistry.Sodium#" name="Sodium"  id="Sodium"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Sodium_report" id="Sodium_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Sodium_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Sodium_comment" id="Sodium_comment"
                                         >#qgetchemistry.Sodium_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Potassium</label>
                                        <input class="Potassium" type="text" maxlength="8" value="#qgetchemistry.Potassium#" name="Potassium"  id="Potassium"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Potassium_report" id="Potassium_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Potassium_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Potassium_comment" id="Potassium_comment"
                                         >#qgetchemistry.Potassium_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Chloride</label>
                                        <input class="Chloride" type="text" maxlength="8" value="#qgetchemistry.Chloride#" name="Chloride"  id="Chloride"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Chloride_report" id="Chloride_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Chloride_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Chloride_comment" id="Chloride_comment"
                                         >#qgetchemistry.Chloride_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Magnesium</label>
                                        <input class="Magnesium" type="text" maxlength="8" value="#qgetchemistry.Magnesium#" name="Magnesium"  id="Magnesium"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Magnesium_report" id="Magnesium_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Magnesium_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Magnesium_comment" id="Magnesium_comment"
                                         >#qgetchemistry.Magnesium_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Calcium</label>
                                        <input class="Calcium" type="text" maxlength="8" value="#qgetchemistry.Calcium#" name="Calcium"  id="Calcium"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Calcium_report" id="Calcium_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Calcium_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Calcium_comment" id="Calcium_comment"
                                         >#qgetchemistry.Calcium_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Phosphorus</label>
                                        <input class="Phosphorus" type="text" maxlength="8" value="#qgetchemistry.Phosphorus#" name="Phosphorus"  id="Phosphorus"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Phosphurs_report" id="Phosphurs_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Phosphurs_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Phosphorus_comment" id="Phosphorus_comment"
                                         >#qgetchemistry.Phosphorus_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Ca/Phos Ratio</label>
                                        <input class="Ca_Phos" type="text" maxlength="8" value="#qgetchemistry.Ca_Phos#" name="Ca_Phos"  id="Ca_Phos"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Ca_Phos_report" id="Ca_Phos_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Ca_Phos_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Ca_Phos_comment" id="Ca_Phos_comment"
                                         >#qgetchemistry.Ca_Phos_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">CO<sup>2</sup></label>
                                        <input class="CO" type="text" maxlength="8" value="#qgetchemistry.CO#" name="CO"  id="CO"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Co_report" id="Co_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Co_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="CO_comment" id="CO_comment"
                                         >#qgetchemistry.CO_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Amylase</label>
                                        <input class="Amylase" type="text" maxlength="8" value="#qgetchemistry.Amylase#" name="Amylase"  id="Amylase"><span>U/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Amylase_report" id="Amylase_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Amylase_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Amylase_comment" id="Amylase_comment"
                                         >#qgetchemistry.Amylase_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Lipase </label>
                                        <input class="Lipase " type="text" maxlength="8" value="#qgetchemistry.Lipase#" name="Lipase"  id="Lipase "><span>U/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Lipase_report" id="Lipase_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Lipase_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Lipase_comment" id="Lipase_comment"
                                         >#qgetchemistry.Lipase_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Cholesterol</label>
                                        <input class="Cholesterol" type="text" maxlength="8" value="#qgetchemistry.Cholesterol#" name="Cholesterol"  id="Cholesterol"><span>mg/dL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Cholesterol_report" id="Cholesterol_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Cholesterol_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Cholesterol_comment" id="Cholesterol_comment"
                                         >#qgetchemistry.Cholesterol_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Uric Acid</label>
                                        <input class="Uric_Acid" type="text" maxlength="8" value="#qgetchemistry.Uric_Acid#" name="Uric_Acid"  id="Uric_Acid"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Uric_report" id="Uric_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Uric_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Uric_comment" id="Uric_comment"
                                         >#qgetchemistry.Uric_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Total Protein</label>
                                        <input class="Total_Protein" type="text" maxlength="8" value="#qgetchemistry.Total_Protein#" name="Total_Protein"  id="Total_Protein"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Protein2_report" id="Protein2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Protein2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Protein2_comment" id="Protein2_comment"
                                         >#qgetchemistry.Protein2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Albumin</label>
                                        <input class="Albumin" type="text" maxlength="8" value="#qgetchemistry.Albumin#" name="Albumin"  id="Albumin"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Albumin_report" id="Albumin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Albumin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Albumin_comment" id="Albumin_comment"
                                         >#qgetchemistry.Albumin_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">A/G Ratio</label>
                                        <input class="A_G" type="text" maxlength="8" value="#qgetchemistry.A_G#" name="A_G"  id="A_G"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="A_G_report" id="A_G_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.A_G_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="A_G_comment" id="A_G_comment"
                                         >#qgetchemistry.A_G_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">AST</label>
                                        <input class="AST" type="text" maxlength="8" value="#qgetchemistry.AST#" name="AST"  id="AST"><span> U/L </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="AST_report" id="AST_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.AST_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="AST_comment" id="AST_comment"
                                         >#qgetchemistry.AST_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">ALT</label>
                                        <input class="ALT" type="text" maxlength="8" value="#qgetchemistry.ALT#" name="ALT"  id="ALT"><span> U/L </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="ALT_report" id="ALT_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.ALT_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="ALT_comment" id="ALT_comment"
                                         >#qgetchemistry.ALT_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">LDH</label>
                                        <input class="LDH" type="text" maxlength="8" value="#qgetchemistry.LDH#" name="LDH"  id="LDH"><span> U/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="LDH_report" id="LDH_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.LDH_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="LDH_comment" id="LDH_comment"
                                         >#qgetchemistry.LDH_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">CPK</label>
                                        <input class="CPK" type="text" maxlength="8" value="#qgetchemistry.CPK#" name="CPK"  id="CPK"><span> U/L <span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="CPK_report" id="CPK_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.CPK_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="CPK_comment" id="CPK_comment"
                                         >#qgetchemistry.CPK_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Alkaline Phosphatase</label>
                                        <input class="Alkaline_Phosphatase" type="text" maxlength="8" value="#qgetchemistry.Alkaline_Phosphatase#" name="Alkaline_Phosphatase"  id="Alkaline_Phosphatase"><span> U/L <span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Alkaline_report" id="Alkaline_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Alkaline_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Alkaline_comment" id="Alkaline_comment"
                                         >#qgetchemistry.Alkaline_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">GGT</label>
                                        <input class="GGT" type="text" maxlength="8" value="#qgetchemistry.GGT#" name="GGT"  id="GGT"><span> U/L </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="GGT_report" id="GGT_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.GGT_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="GGT_comment" id="GGT_comment"
                                         >#qgetchemistry.GGT_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Total Bilirubin</label>
                                        <input class="Total_Bilirubin" type="text" maxlength="8" value="#qgetchemistry.Total_Bilirubin#" name="Total_Bilirubin"  id="Total_Bilirubin"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Bilirubin_report" id="Bilirubin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.Bilirubin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control   " name="Bilirubin_comment" id="Bilirubin_comment"
                                         >#qgetchemistry.Bilirubin_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Direct Bilirubin</label>
                                        <input class="Direct_Bilirubin" type="text" maxlength="8" value="#qgetchemistry.Direct_Bilirubin#" name="Direct_Bilirubin"  id="Direct_Bilirubin"><span> mg/dL </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="D_Bilirubin_report" id="D_Bilirubin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetchemistry.D_Bilirubin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="D_Bilirubin_comment" id="D_Bilirubin_comment"
                                         >#qgetchemistry.D_Bilirubin_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <h5 class="mb-1"><strong>Capillary Zone Electrophoresis</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Total Protein</label>
                                        <input class="Total_Protein_cap" type="text" maxlength="8" value="#qgetCapillary.Total_Protein_cap#" name="Total_Protein_cap"  id="Total_Protein_cap"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Total_Protein_cap_report" id="Total_Protein_cap_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Total_Protein_cap_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Total_Protein_cap_comment" id="Total_Protein_cap_comment"
                                     >#qgetCapillary.Total_Protein_cap_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">A/G ratio</label>
                                        <input class="A_G_ration" type="text" maxlength="8" value="#qgetCapillary.A_G_ration#" name="A_G_ration"  id="A_G_ration"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="A_G_ration_report" id="A_G_ration_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.A_G_ration_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="A_G_ration_comment" id="A_G_ration_comment"
                                     >#qgetCapillary.A_G_ration_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Pre Albumin</label>
                                        <input class="Pre_Albumin" type="text" maxlength="8" value="#qgetCapillary.Pre_Albumin#" name="Pre_Albumin"  id="Pre_Albumin"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Pre_Albumin_report" id="Pre_Albumin_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Pre_Albumin_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Pre_Albumin_comment" id="Pre_Albumin_comment"
                                     >#qgetCapillary.Pre_Albumin_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Albumin</label>
                                        <input class="Albumin" type="text" maxlength="8" value="#qgetCapillary.Albumin2#" name="Albumin2"  id="Albumin2"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Albumin2_report" id="Albumin2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Albumin2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Albumin2_comment" id="Albumin2_comment"
                                     >#qgetCapillary.Albumin2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Alpha 1</label>
                                        <input class="Alpha_1" type="text" maxlength="8" value="#qgetCapillary.Alpha_1#" name="Alpha_1"  id="Alpha_1"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Alpha_1_report" id="Alpha_1_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Alpha_1_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Alpha_1_comment" id="Alpha_1_comment"
                                     >#qgetCapillary.Alpha_1_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Alpha 2</label>
                                        <input class="Alpha_2" type="text" maxlength="8" value="#qgetCapillary.Alpha_2#" name="Alpha_2"  id="Alpha_2"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Alpha_2_report" id="Alpha_2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Alpha_2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Alpha_2_comment" id="Alpha_2_comment"
                                     >#qgetCapillary.vAlpha_2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Beta 1</label>
                                        <input class="Beta_1" type="text" maxlength="8" value="#qgetCapillary.Beta_1#" name="Beta_1"  id="Beta_1"><span> g/dL </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Beta_1_report" id="Beta_1_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Beta_1_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Beta_1_comment" id="Beta_1_comment"
                                     >#qgetCapillary.Beta_1_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Beta 2</label>
                                        <input class="Beta_2" type="text" maxlength="8" value="#qgetCapillary.Beta_2#" name="Beta_2"  id="Beta_2"><span> g/dL </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Beta_2_report" id="Beta_2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Beta_2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Beta_2_comment" id="Beta_2_comment"
                                     >#qgetCapillary.Beta_2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Beta Total</label>
                                        <input class="Beta_Total" type="text" maxlength="8" value="#qgetCapillary.Beta_Total#" name="Beta_Total"  id="Beta_Total"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Beta_Total_report" id="Beta_Total_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Beta_Total_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Beta_Total_comment" id="Beta_Total_comment"
                                     >#qgetCapillary.Beta_Total_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Gamma</label>
                                        <input class="Gamma" type="text" maxlength="8" value="#qgetCapillary.Gamma#" name="Gamma"  id="Gamma"><span> g/dL </span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Gamma_report" id="Gamma_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetCapillary.Gamma_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Gamma_comment" id="Gamma_comment"
                                     >#qgetCapillary.Gamma_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-1"><strong>Dolphin SAA</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Dolphin SAA</label>
                                        <input class="Dolphin_SAA" type="text" maxlength="8" value="#qgetDolphin.Dolphin_SAA#" name="Dolphin_SAA"  id="Dolphin_SAA"><span>mg/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Dolphin_SAA_report" id="Dolphin_SAA_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetDolphin.Dolphin_SAA_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Dolphin_SAA_comment" id="Dolphin_SAA_comment"
                                     >#qgetDolphin.Dolphin_SAA_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-1"><strong>ISTAT- Chem 8+</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup cust-date-r">
                                    <label class="date-padd">Date</label>
                                    <div class="input-group date " id="Chem_date_picker">
                                        <input type="text" maxlength="8" placeholder="mm/dd/yyyy" name="Chem_date" id="Chem_date"
                                        class="form-control" value='#DateTimeFormat(qgetiSTAT_Chem.Chem_date, "MM/dd/YYYY")#'  />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div> 
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <label class="start-time">Time</label>
                                    <div class="input-group date " id="datetimepicker_Chem_dateTime">
                                        <input type="text" maxlength="8" value="#TimeFormat(qgetiSTAT_Chem.Chem_dateTime, "HH:nn")#" placeholder="hh:mm:ss" name="Chem_dateTime" id="Chem_dateTime"
                                        class="form-control" />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Operator</label>
                                        <select class="form-control" name="Operator_chem" id="Operator_chem">
                                            <cfloop query="getTeams">
                                                <cfif active eq 1>
                                                    <option value="#getTeams.RT_ID#" <cfif #getTeams.RT_ID# eq #qgetiSTAT_Chem.Operator_che#>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Na</label>
                                        <input class="Na" type="text" maxlength="8" value="#qgetiSTAT_Chem.Na#" name="Na"  id="Na"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Na_report" id="Na_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Na_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Na_comment" id="Na_comment"
                                     >#qgetiSTAT_Chem.Na_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">K</label>
                                        <input class="K" type="text" maxlength="8" value="#qgetiSTAT_Chem.K#" name="K"  id="K"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="K_report" id="K_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.K_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="K_comment" id="K_comment"
                                     >#qgetiSTAT_Chem.K_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Cl</label>
                                        <input class="Cl" type="text" maxlength="8" value="#qgetiSTAT_Chem.Cl#" name="Cl"  id="Cl"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Cl_report" id="Cl_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Cl_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Cl_comment" id="Cl_comment"
                                     >#qgetiSTAT_Chem.Cl_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">iCa</label>
                                        <input class="iCa" type="text" maxlength="8" value="#qgetiSTAT_Chem.iCa#" name="iCa"  id="iCa"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="iCa_report" id="iCa_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.iCa_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="iCa_comment" id="iCa_comment"
                                     >#qgetiSTAT_Chem.iCa_comment#</textarea>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">TCO2</label>
                                        <input class="TCO2" type="text" maxlength="8" value="#qgetiSTAT_Chem.TCO2#" name="TCO2"  id="TCO2"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="TCO2_report" id="TCO2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.TCO2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="TCO2_comment" id="TCO2_comment"
                                     >#qgetiSTAT_Chem.TCO2_comment#</textarea>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Glu</label>
                                        <input class="Glu" type="text" maxlength="8" value="#qgetiSTAT_Chem.Glu#" name="Glu"  id="Glu"><span>mg/dL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Glu_report" id="Glu_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Glu_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Glu_comment" id="Glu_comment"
                                     >#qgetiSTAT_Chem.Glu_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">BUN</label>
                                        <input class="BUN" type="text" maxlength="8" value="#qgetiSTAT_Chem.BUN#" name="BUN"  id="BUN"><span>mg/dL </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="BUN_report" id="BUN_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.BUN_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="BUN_comment" id="BUN_comment"
                                     >#qgetiSTAT_Chem.BUN_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Crea</label>
                                        <input class="Crea" type="text" maxlength="8" value="#qgetiSTAT_Chem.Crea2#" name="Crea2"  id="Crea2"><span>mg/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Crea2_report" id="Crea2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Crea2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Crea2_comment" id="Crea2_comment"
                                     >#qgetiSTAT_Chem.Crea2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hct</label>
                                        <input class="Hct" type="text" maxlength="8" value="#qgetiSTAT_Chem.Hct#" name="Hct"  id="Hct"><span>% PCV</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hct_report" id="Hct_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Hct_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Hct_comment" id="Hct_comment"
                                     >#qgetiSTAT_Chem.Hct_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Hb</label>
                                        <input class="Hb" type="text" maxlength="8" value="#qgetiSTAT_Chem.Hb#" name="Hb"  id="Hb"><span>g/dL</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Hb_report" id="Hb_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.Hb_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Hb_comment" id="Hb_comment"
                                     >#qgetiSTAT_Chem.Hb_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">AnGap</label>
                                        <input class="AnGap" type="text" maxlength="8" value="#qgetiSTAT_Chem.AnGap#" name="AnGap"  id="AnGap"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="AnGap_report" id="AnGap_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_Chem.AnGap_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="AnGap_comment" id="AnGap_comment"
                                     >#qgetiSTAT_Chem.AnGap_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-1"><strong>ISTAT- CG4+</strong></h5>
                <div class="form-holder blood-form-holder cust-v-sec">  
                    <div class="form-group blood-from-froup cust-v-row">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup cust-date-r">
                                    <label class="date-padd">Date</label>
                                    <div class="input-group date " id="ISTAT_CG4_date_picker">
                                        <input type="text" maxlength="8" value="#DateTimeFormat(qgetiSTAT_CG4.ISTAT_CG4_date, "MM/dd/YYYY")#" placeholder="mm/dd/yyyy" name="ISTAT_CG4_date" id="ISTAT_CG4_date"
                                        class="form-control" value=''  />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                                    </div> 
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <label class="time">Time</label>
                                    <div class="input-group date " id="datetimepicker_Time">
                                        <input type="text" maxlength="8" value="#TimeFormat(qgetiSTAT_CG4.tTime, "HH:nn")#" placeholder="hh:mm:ss" name="tTime" id="Time"
                                        class="form-control" />
                                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-time"></span> </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Operator</label>
                                        <select class="form-control" name="Operator" id="Operator">
                                            <cfloop query="getTeams">
                                                <cfif active eq 1>
                                                    <option value="#getTeams.RT_ID#" <cfif #getTeams.RT_ID# eq #qgetiSTAT_CG4.Operator#>selected</cfif>>#getTeams.RT_MemberName#</option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Temperature</label>
                                        <input class="Temperature" type="text" maxlength="8" value="#qgetiSTAT_CG4.Temperature#" name="Temperature"  id="Temperature"><span>&##8451;</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Temperature_report" id="Temperature_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.Temperature_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Temperature_comment" id="Temperature_comment"
                                     >#qgetiSTAT_CG4.Temperature_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">pH</label>
                                        <input class="pH" type="text" maxlength="8" value="#qgetiSTAT_CG4.pH#" name="pH"  id="pH">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="pH_report" id="pH_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.pH_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="pH_comment" id="pH_comment"
                                     >#qgetiSTAT_CG4.pH_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">PCO2</label>
                                        <input class="PCO2" type="text" maxlength="8" value="#qgetiSTAT_CG4.PCO2#" name="PCO2"  id="PCO2"><span>mmHg</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="PCO2_report" id="PCO2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.PCO2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="PCO2_comment" id="PCO2_comment"
                                     >#qgetiSTAT_CG4.PCO2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">PO2</label>
                                        <input class="PO2" type="text" maxlength="8" value="#qgetiSTAT_CG4.PO2#" name="PO2"  id="PO2"><span>mmHg</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="PO2_report" id="PO2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.PO2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="PO2_comment" id="PO2_comment"
                                     >#qgetiSTAT_CG4.PO2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">BEecf</label>
                                        <input class="BEecf" type="text" maxlength="8" value="#qgetiSTAT_CG4.BEecf#" name="BEecf"  id="BEecf"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="BEecf_report" id="BEecf_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.BEecf_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="BEecf_comment" id="BEecf_comment"
                                     >#qgetiSTAT_CG4.BEecf_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">HCO3</label>
                                        <input class="HCO3" type="text" maxlength="8" value="#qgetiSTAT_CG4.HCO3#" name="HCO3"  id="HCO3"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="HCO3_report" id="HCO3_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.HCO3_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="HCO3_comment" id="HCO3_comment"
                                     >#qgetiSTAT_CG4.HCO3_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">TCO2</label>
                                        <input class="TCO2cg" type="text" maxlength="8" value="#qgetiSTAT_CG4.TCO2cg#" name="TCO2cg"  id="TCO2"><span>mmol/L </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="TCO2cg_report" id="TCO2cg_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.TCO2cg_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="TCO2cg_comment" id="TCO2cg_comment"
                                     >#qgetiSTAT_CG4.TCO2cg_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">sO2</label>
                                        <input class="sO2" type="text" maxlength="8" value="#qgetiSTAT_CG4.sO2#" name="sO2"  id="sO2"><span>% </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="sO2_report" id="sO2_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.sO2_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="sO2_comment" id="sO2_comment"
                                     >#qgetiSTAT_CG4.sO2_comment#</textarea>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group cust-blod">
                                        <label class="">Lac</label>
                                        <input class="Lac" type="text" maxlength="8" value="#qgetiSTAT_CG4.Lac#" name="Lac"  id="Lac"><span>mmol/L</span> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column">
                                <div class="form-group blood-from-froup">
                                    <div class="input-group ">
                                        <label class="county-label">Select Option</label>
                                        <select class="form-control" name="Lac_report" id="Lac_report">
                                            <cfloop from="1" to="#ArrayLen(Selectoptions)#" index="j">
                                                <option value="#Selectoptions[j]#" <cfif #Selectoptions[j]# eq #qgetiSTAT_CG4.Lac_report#>selected</cfif>>#Selectoptions[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 blood-column ">
                                <div class="form-group blood-from-froup">
                                    <label class="scomment-label">Comments</label>
                                    <textarea class="form-control" name="Lac_comment" id="Lac_comment"
                                     >#qgetiSTAT_CG4.Lac_comment#</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!---  Following logic to get the data from the HI table and seting value to qgetHIData variable --->
                <cfif url.LCE_ID neq 0>
                    <cfset qgetHIData=Application.Stranding.getBlood_V_ten()>
                </cfif>
                <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                    <cfset form.LCEID = form.HI_ID>
                    <cfset qgetHIData=Application.Stranding.getBlood_VData(argumentCollection="#Form#")>
                <cfelse>
                    <cfset qgetHIData=Application.Stranding.getBlood_V_ten()>
                </cfif>
                
                <input type="hidden"  name="ID" value="#qgetHIData.ID#">
                <input type="hidden" name="LCE_ID" value="#qgetHIData.LCE_ID#">
                <!--- this input field is using for check in stranding.cfc for general Update function --->
                <input type="hidden"  name="check" value="1">
                <input type="hidden"  name="blood_toxi" value="1">
                <input type="hidden"  name="bloodvalue_fields" value="1">

                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap d-flex">
                        <div class="flex-center flex-row flex-wrap d-flex bottons-wrap">
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoToxicology" value="Save and go to Toxicology" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div>
                        <div class="flex-center flex-row flex-wrap d-flex bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                            <cfif (permissions eq "full_access")>
                                <input type="submit" id="deleteBloodValuesRecord" name="deleteBloodValuesRecord" class="btn btn-orange m-rl-4" value="Delete All Records" onclick="if(confirm('Are you sure to Delete All Records?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>
            </form>    
        </div>
    </cfoutput>

<style>
.blood-form-holder .blood-column .blood-from-froup .input-group.cust-blod input[type="text"] {
    margin-right: 10px;
}
html body .select2-container--default .select2-selection--single, 
html body input, html body select, html body textarea, html body .bloodValues-date-form.form-holder.blue-bg.pb-2 select, html body .bloodValues-date-form.form-holder.blue-bg.pb-2 input {
    border:1px solid #bec3c6 !important;
}
.blood-form-holder .blood-column .blood-from-froup .input-group.cust-blod span {
    width: 15%;
    text-align: left;
}
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) select, 
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) input {
    width: 70%;
}
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 1) {
    width: 27.5%;
}
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) {
    width: 24%;
}
.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4 {
    width: 48.5%;
}
.form-holder.blood-form-holder.cust-v-sec {
    padding-right: 0;
}
html body .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4 .date input {
    width: 100%;
}

.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) .form-group.blood-from-froup.cust-date-r {
    width: 70%;
}
.form-group.blood-from-froup.cust-v-row textarea, .form-group.blood-from-froup.cust-v-row select, .form-group.blood-from-froup.cust-v-row input {
    height: 34.5px;
    border-radius: 3px;
}
.d-flex, .form-group.blood-from-froup .input-group.cust-blod {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
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
    border: 1px solid #d5d8da;
    box-shadow: 0px 0px 5px 5px #30373e1c;
}
.form-group.blood-from-froup.cust-v-row label, 
.input-group {
    width: 100%;
}
.form-group.blood-from-froup.cust-v-row label {
    padding-bottom: 5px;
}
.select2-container--default .select2-selection--single {
    border: 1px solid #add8e6 !important;
    height: 34.5px !important;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
}
html body .form-group.blood-from-froup.input-group.select-width .input input.form-control {
    height: 34.5px;
    background: #fff;
    opacity: 1;
    box-shadow: none;
    border-radius: 4px;
}
html body .bloodValues-date-form.form-holder.blue-bg.pb-2 select, html body .bloodValues-date-form.form-holder.blue-bg.pb-2 input {
    height: 34.5px;
    border-radius: 4px;
}
.flex-center{
    justify-content: space-between;
}
.select2-container--default .select2-search--inline .select2-search__field {
    border: none !important;
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
padding-bottom: 15px ; 
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
    /*padding-bottom: 70px;*/
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
    padding: 12px ;
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
    border-color: #8d9aa5 ;
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
    background-color: #fff ;
    border: 2px solid #bec3c6 ;
    border-radius: 0 ;
}
.body-water span{
    width: 100% ;
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
    padding-left: 25px ;
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
    /*min-width: 20%;*/
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
html body .green-labels .input select:last-child, 
html body .green-labels .input select {
    height: 35px;
    background: #ebeced;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
}
.bloodValues-date-form.form-holder.blue-bg.pb-2 {
    min-height: 315px;
}
.green-labels .input span{ 
    width: 100% ;
}
.green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice {
    margin-right: 25px;
    position: relative;
}
.green-labels .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
    position: absolute;
    right: -12px;
    width: 20px ;
    height: 100% ;
}
.select-width span{ 
    width: 100% ;
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
.blood-form-holder .blood-from-froup .row {
    justify-content: flex-start;
    display: flex;
    flex-wrap: wrap;
    width: 100%;
}
html body .bloodValues-date-form.form-holder.blue-bg.pb-2 input:focus {
    outline: none;
}
.form-group.blood-from-froup .input-group {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
}
.form-group.blood-from-froup .input-group.date {
    display: table;
}
.flex-wrap-wrap {
    flex-wrap: wrap;
}
.form-group.blood-from-froup.blue-bg-l .input-group span,
.form-group.blood-from-froup .input-group span {
    white-space: nowrap;
}
.form-group.blood-from-froup .input-group.date span {
    white-space: inherit;
    border: 1px solid #bec3c6;
    border-left: none;
}
.form-group.blood-from-froup.blue-bg-l .form-group.blood-from-froup label,
.form-group.blood-from-froup .form-group.blood-from-froup label {
    padding-right: 5px;
}
.form-group.blood-from-froup {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
}
.form-group.blood-from-froup.input-group.select-width {
    display: table;
}
.form-group.blood-from-froup .green-labels .input-group{
    justify-content: space-between;
    align-items: center
}
.bloodValues-date-form .blue-bg-l {
    padding-bottom: 148px;
}
.col-lg-6.team-member-sec .form-holder.blue-bg.pb-2 .form-group.blood-from-froup.m-0 .input {
    width: 75%;
}
.col-lg-6.team-member-sec .form-holder.blue-bg.pb-2 .form-group.blood-from-froup.m-0 label {
    width: 25%;
}
.form-group.blood-from-froup.m-0 .row {
    width: 100%;
}
@media (max-width: 1399px){
    .form-group.blood-from-froup.input-group.select-width label{
        font-size: 11px;
    }
    .col-lg-6.team-member-sec .form-holder.blue-bg.pb-2 {
        padding-right: 0;
    }
}
@media (max-width: 1200px){
	.bloodValues-date-form.form-holder.blue-bg.pb-2 {
	    min-height: inherit;
	    padding-right: 0;
	}
}
@media (max-width: 1024px){
	.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) {
	    width: 33%;
	}
	.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 1) {
	    width: 30%;
	}
    .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4 {
        width: 37%;
    }
}
@media (max-width:991px){
    .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4 {
        width: 100%;
    }
    .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 1), .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) {
        width: 50%;
    }
    .flex-center.flex-row.flex-wrap.d-flex.bottons-wrap input {
        width: 47%;
        margin-bottom: 15px;
    }
}
@media (max-width:425px){
	.form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 1), .form-group.blood-from-froup.cust-v-row .col-lg-4.col-md-4.col-sm-4.col-xs-4:nth-child(3n - 2) {
	    width: 100%;
	}
	.flex-center.flex-row.flex-wrap.d-flex.bottons-wrap input {
	    width: 100%;
	}
}
    </style>
<cfelse>
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Stranding</a></li>
            <li><a href="javascript:;">Blood Values</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>