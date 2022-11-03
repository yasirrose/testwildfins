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
    <cfset Examtype = ['Photos Only','External Exam','Partial Internal Exam','Complete Internal Exam (necropsy)'] >
    <cfset TypeofHI = ['Entanglement','Hooking','Ingestion','Vessel Trauma','Gunshot','Harassment','Mutilation','CBD/Other'] >
    <cfset LocationofHI = ['Rostrum','Mandible','Head/Neck','L Flipper','R Flipper','Dorsum/Dorsal Fin','Ventrum','Peduncle','Flukes'] >
    <cfset ContributedtoStrandingEvent = ['Uncertain/CBD','Improbable','Suspect','Probable']>
    <cfset TypeofGearCollected = ['Hook','Monofilament Line','Braided Line','Crab Pot','Crab Pot Line','Crab Pot Buoy','Debris'] >
    <cfset GearDeposition =  ['NMFS','FAU Harbor Branch','FAU Ocean Discovery Visitor’s Center','Disposed of']>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Moderate Decomposition' ,'Advanced Decomposition','Mummified']>
    <cfparam  name="url.LCE_ID" DEFAULT="0">
    <cfif isDefined('SaveAndNew') OR isDefined('SaveandgotoAForm') OR isDefined('SaveAndClose')>
        <!--- If updating existing data --->
        <cfif  isDefined('form.ID') and form.ID neq "">
            <cfset LCE = Application.Stranding.HIFormUpdate(argumentCollection="#Form#")>
            <cfif isDefined('SaveandgotoAForm') and url.LCE_ID neq 0>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=LevelAForm&LCE_ID=#url.LCE_ID#" >
            </cfif>
            <cfset form.LCE= form.ID>
            <cfset Application.Stranding.InsertHiExampData(argumentCollection="#Form#")>
           
        <cfelse>
            <!--- If inserting new data --->
            <!--- <cfdump var="#form#" abort="true"> --->
            <cfset form.LCE_ID = url.LCE_ID>
            <cfset LCE = Application.Stranding.HIFormInsert(argumentCollection="#Form#")>
            <cfif form.HiType neq "">
                <cfset form.LCE= LCE>
                <cfset Application.Stranding.InsertHiExampData(argumentCollection="#Form#")>
            </cfif>

            <cfif isDefined('SaveandgotoAForm')>
                <cflocation addtoken="no" url="#Application.siteroot#?Module=Stranding&Page=LevelAForm&LCE_ID=#url.LCE_ID#" >
            </cfif>
        </cfif>
    <cfelseif isDefined('delete')>
        <cfset Application.Stranding.deleteHI("#form#")>
    </cfif>
   


    <!--- if user directed from the Cetacean form, here getr first 4 forms data of Cetacean form --->
    <cfif url.LCE_ID neq 0>
        <cfset form.LCEID = url.LCE_ID>
        <cfset neworexist=Application.Stranding.getHIDataByLCE("#form.LCEID#")>
        <cfset qgetHIData=Application.Stranding.getLiveCetaceanExamData("#form.LCEID#")>    
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
        <cfset qgetHIData=Application.Stranding.getHIData("#form.LCEID#")>
        <cfif #qgetHIData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(CETACEAN_SPECIES="#qgetHIData.species#")>
        </cfif>
          <!--- working --->
     <cfset qgetHiExamData = Application.Stranding.getHiExamData(LCEID="#form.LCEID#")>
    </cfif>
    <!---  setup empty form when directly clicked the HI link from side bar --->
    <cfif url.LCE_ID eq 0 AND Not isDefined('form.HI_ID')>
        <cfset qgetHIData=Application.Stranding.getHI_ten()>
        <!---  setup empty form when when entering new record --->
    <cfelseif  isDefined('form.HI_ID') AND form.HI_ID eq "">
        <cfset qgetHIData=Application.Stranding.getHI_ten()>
    </cfif>
    <!---  get all records order by ID DESC--->
    <cfset getHIID=Application.Stranding.getHIID()>
    <!---  get all records order by Date Desc --->
    <cfset qgetHIDate=Application.Stranding.getHIDate()>
    <!---  get all records order by Field Numbert Desc --->
    <cfset qgetHIFBNumber=Application.Stranding.getHIFBNumber()>
    <cfoutput>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">HI Form</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">HI Form</h1>
            <!-- end page-header -->
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form id="myform" action="#Application.siteroot#/?Module=Stranding&Page=HIForm" method="post" >
                            <label for="sel1">Select HI Form</label>
                            <div class="input"> 
                                <select class="form-control search-box" name="HI_ID" onChange="this.form.submit()">
                                    <option value="">Select HI Form</option>
                                    <cfloop query="getHIID">
                                        <option value="#getHIID.ID#" <cfif isDefined('form.HI_ID') and form.HI_ID eq #getHIID.ID#>selected</cfif>>#getHIID.ID#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="form-group input-group select-width">
                        <form  action="#Application.siteroot#/?Module=Stranding&Page=HIForm" method="post" >
                            <label for="sel1">Search HI Form By Date:</label>
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
                    <form  action="#Application.siteroot#/?Module=Stranding&Page=HIForm" method="post" >
                        <label for="sel1">Search HI Form By Field Number:</label>
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
                                <div class="HIForm-date-form form-group m-0 blue-bg-l">
                                    <div class="row">
                                        <div class="col-lg-12 p-0">
                                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"> 
                                                <div class="form-group flex-center">
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
                                                            <option value="0"></option>
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
                <h5 class="mb-1"><strong>Documents</strong></h5>
                <input type="hidden" name="pdfFiles" value="#qgetHIData.pdfFiles#" id="pdfFiles">
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
                        <cfset imgss = ValueList(qgetHIData.pdfFiles,",")>
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
                                            <cfif isDefined('qgetHIData.species') and #qgetHIData.species# neq "" >
                                                <cfloop query="getCetaceansCode">
                                                    <option value="#getCetaceansCode.id#" <cfif #getCetaceansCode.id# eq #qgetHIData.code#>selected</cfif>>
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
                                        <input class="input-style xl-width" type="text" value="#qgetHIData.hera#" name="hera" id="hera">
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
                                                <option value="#sex[j]#" <cfif #sex[j]# eq #qgetHIData.sex#>selected</cfif>>#sex[j]#</option>
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
                                                <option value="#ageClass[j]#" <cfif #ageClass[j]# eq #qgetHIData.ageClass#>selected</cfif>>#ageClass[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>    
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6 ">
                                <div class="form-group flex-center">
                                    <label >Location</label>
                                    <textarea class="form-control textareaCustomReset locations-textarea" name="Location"
                                        maxlength="75">#qgetHIData.Location#</textarea>
                                </div>
                            </div>   
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="lat-one">Lat</label>
                                        <input class="input-style xl-width" type="text" value="#qgetHIData.lat#" name="lat" id="AtLatitude">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="lon-one">Lon</label>
                                        <input class="input-style xl-width" type="text" value="#qgetHIData.lon#" name="lon" id="AtLongitude">
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
                                                <option value="#j#" <cfif #j# eq #qgetHIData.InitialCondition#>selected</cfif>>#j#</option>
                                            </cfloop> --->
                                            <cfloop array="#Conditions#" item="item" index="j">
                                                <option value="#item#" <cfif #item# eq #qgetHIData.InitialCondition#>selected</cfif>>#j#-#item#</option>
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
                                                <option value="#item#" <cfif #item# eq #qgetHIData.InitialCondition#>selected</cfif>>#j#-#item#</option>
                                            </cfloop>
                                            <!--- <cfloop from="1" to="5" index="j">
                                                <option value="#j#" <cfif #j# eq #qgetHIData.FinalCondition#>selected</cfif>>#j#</option>
                                            </cfloop> --->
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
                                                    <option value="#qgetIR_CountyLocation.IR_CountyLocation#" <cfif #qgetIR_CountyLocation.IR_CountyLocation# eq #qgetHIData.county#>selected</cfif>>#qgetIR_CountyLocation.IR_CountyLocation#</option>
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
                                        maxlength="75">#qgetHIData.BriefHistory#</textarea>
                                </div>
                            </div>        
                        </div>
                    </div>
                </div>
                <!---  Following logic to get the data from the HI table and seting value to qgetHIData variable --->
                <cfif url.LCE_ID neq 0>
                    <cfset qgetHIData=Application.Stranding.getHI_ten()>
                </cfif>
                <cfif  isDefined('form.HI_ID') and form.HI_ID neq "">
                    <cfset form.LCEID = form.HI_ID>
                    <cfset qgetHIData=Application.Stranding.getHIData(argumentCollection="#Form#")>
                <cfelse>
                    <cfset qgetHIData=Application.Stranding.getHI_ten()>
                </cfif>
                <h5 class="mb-1"><strong>HI Exam</strong></h5>
                <input type="hidden"  name="ID" value="#qgetHIData.ID#">
                <input type="hidden" name="LCE_ID" value="#qgetHIData.LCE_ID#">
                <div class="form-holder">  
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="Examtype-label">Exam type</label>
                                        <select class="form-control" name="Examtype" id="Examtype">
                                            <option value="">Select Exam type</option>
                                            <cfloop from="1" to="#ArrayLen(Examtype)#" index="j">
                                                <option value="#Examtype[j]#" <cfif #Examtype[j]# eq #qgetHIData.Examtype#>selected</cfif>>#Examtype[j]#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div> 
                            <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">HI Findings</label>
                                        <input class="finding" type="text" name="Hifindings" id="Hifindings" value="#qgetHIData.Hifindings#">
                                    </div>
                                </div>
                            </div>     
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="LocationofHI-label">Location of HI</label>
                                        <select class="form-control search-box" multiple="multiple" name="LocationofHI" id="LocationofHI">
                                            <cfloop from="1" to="#ArrayLen(LocationofHI)#" index="j">
                                                <option value="#LocationofHI[j]#" >#LocationofHI[j]#</option>
                                            </cfloop>
                                        </select>
                                        <input type="hidden" name="HiLocation" id="HiLocation" value="">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Contributed to Stranding Event</label>
                                        <select class="form-control" name="ContributedtoStrandingEvent" id="ContributedtoStrandingEvent">
                                            <option value="">Select Contributed to Stranding Event</option>
                                            <cfloop from="1" to="#ArrayLen(ContributedtoStrandingEvent)#" index="j">
                                                <option value="#ContributedtoStrandingEvent[j]#" >#ContributedtoStrandingEvent[j]#</option>
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
                                        <label class="">Gear Collected</label>
                                        <input class="input-style xl-width" type="checkbox" value="1" name="GearCollected" id="GearCollected" <cfif qgetHIData.GearCollected eq 1>checked</cfif>>
                                    </div>
                                    <input type="hidden" name="gearCollected" id="gearCollected" value="">
                                </div>
                            </div>    
                            <div class="col-lg-2 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Type of HI</label>
                                        <select class="form-control search-box" multiple="multiple" name="TypeofHI" id="TypeofHI">
                                            <cfloop from="1" to="#ArrayLen(TypeofHI)#" index="j">
                                                <option value="#TypeofHI[j]#" >#TypeofHI[j]#</option>
                                            </cfloop>
                                        </select>
                                        <input type="hidden" name="HiType" id="HiType" value="">
                                    </div>
                                </div>
                            </div>                
                            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="">Type of Gear Collected</label>
                                        <select class="form-control search-box" multiple="multiple" name="TypeofGearCollected" id="TypeofGearCollected">
                                            <cfloop from="1" to="#ArrayLen(TypeofGearCollected)#" index="j">
                                                <option value="#TypeofGearCollected[j]#">#TypeofGearCollected[j]#</option>
                                            </cfloop>
                                        </select>
                                        <input type="hidden" name="typeOfGearCollected" id="typeOfGearCollected" value="">
                                    </div>
                                </div>
                            </div>                
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <div class="input-group flex-center">
                                        <label class="GearDeposition-label">Gear Deposition</label>
                                        <select class="form-control" name="GearDeposition" id="GearDeposition">
                                            <option value="">Select Type of Gear Collected</option>
                                            <cfloop from="1" to="#ArrayLen(GearDeposition)#" index="j">
                                                <option value="#GearDeposition[j]#">#GearDeposition[j]#</option>
                                            </cfloop>
                                        </select>
                                        <input type="hidden" name="gearDeposition" id="gearDeposition" value="">
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="idForUpdateHiExam" value="">
                            <!--- <button type="button" id="addNewHiExam" value="Add New" onclick="AddNewHiExam(this)" class="float-right">Add New</button> --->
                            <input type="button" class="btn btn-success" id="addNewHiExam" value="Add New" onClick="AddNewHiExam()"/>
                            <!--- working start --->
                            <div class="col-lg-5 col-md-6 col-sm-12 col-xs-12">
                            <table class="table table-bordered table-hover" id="HiForm" <cfif isDefined('qgetHiExamData') AND #qgetHiExamData.recordcount# gt 0><cfelse> hidden</cfif>>
                                <thead>
                                    <tr>
                                        <th>Type of HI</th>
                                        <th>Location of HI</th>
                                        <th>Gear Collected</th>
                                        <th>Type of Gear Collected</th>
                                        <th>Gear Deposition</th>
                                        <cfif isDefined('qgetHiExamData')>
                                            <th >Action</th>
                                        </cfif>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfif isDefined('qgetHiExamData')>
                                        <!--- <cfset myList = ValueList(qgetHIData.TYPEOFHI,",")> --->
                                        <!--- <cfset myList = ListToArray(qgetHIData.TYPEOFHI)> --->
                                        <!--- <cfdump var="#qgetHiExamData#" abort="true"> --->
                                    <cfloop query="qgetHiExamData">
                                        <tr id="tr_#ID#">
                                            <td id="idd" hidden>#ID#</td>
                                            <td id="TYPEOFHI_#ID#"><cfif #qgetHiExamData.TYPEOFHI# eq 0><cfelse>#replace(qgetHiExamData.TYPEOFHI,"-",",","all")#</cfif></td>
                                            <td id="LocationofHI_#ID#">#replace(qgetHiExamData.LocationofHI,"-",",","all")#</td>
                                            <td id="TypeofGearCollected_#ID#">#replace(qgetHiExamData.TypeofGearCollected,"-",",","all")#</td>
                                            <!--- <td id="TYPEOFHI_#ID#">#qgetHiExamData.TYPEOFHI#</td> --->
                                            <td id="GearCollected_#ID#">#qgetHiExamData.GearCollected#</td>
                                            <td id="GearDeposition_#ID#">#qgetHiExamData.GearDeposition#</td>
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
                            </div>
                            
                            
                            
                            <!--- working end --->
                        </div>
                    </div>
                </div>
                <cfif findNoCase("Read only ST", permissions) eq 0>
                    <div class="flex-center flex-row flex-wrap">
                        <div class="flex-center flex-row flex-wrap bottons-wrap">
                            <input type="submit" id="ToLevelAForm" class="btn btn-skyblue m-rl-4" name="SaveandgotoAForm" value="Save and go to Level A Form" onclick="chkreq(event)">
                            <input type="button" id="ToIR" class="btn btn-skyblue m-rl-4" value="Save and go to  Incident Report">
                            <input type="button" id="ToSamples" class="btn btn-skyblue m-rl-4" value="Save and go to  Samples">
                        </div>
                        <div class="flex-center flex-wrap bottons-wrap">
                            <input type="submit" id="SaveAndNew" name="SaveAndNew" class="btn btn-pink m-rl-4" value="Save" onclick="chkreq(event)">
                            <!--- <input type="submit" id="SaveAndClose" class="btn btn-green m-rl-4" name="SaveAndClose" value="Save and Close" onclick="chkreq(event)"> --->
                            <cfif (permissions eq "full_access" or findNoCase("Delete ST", permissions) neq 0) AND (isDefined('form.LCEID') and form.LCEID neq "")>
                                <input type="submit" id="" name="delete" class="btn btn-orange m-rl-4" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                            </cfif>
                        </div>
                    </div>
                </cfif>
            </form>    
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
    .finding{
        width: 112px;
        border: 2px solid #bec3c6;
        background: #FFF;
        color: #30373F;
        height: 30px;
        padding: 0px 4px;
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
            .HIForm-date-form .form-group.flex-center {
            flex-wrap: wrap;
            }
            .HIForm-date-form .input-group.flex-center {
            flex-wrap: wrap;
            }
        }
        @media (max-width: 1199px){
            .HIForm-date-form .form-group.flex-center {
            flex-wrap: nowrap;
            }
            .HIForm-date-form .input-group.flex-center {
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
            <li><a href="javascript:;">HI Form</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>