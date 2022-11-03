<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    <!--- Static data --->
    <cfset qgetCetaceanSpecies=Application.Stranding.getCetaceanSpecies()>
    <cfset qgetVeterinarians= Application.StaticDataNew.getVeterinarians()>
    <cfset qgetLiverFinding= Application.StaticDataNew.getLiverFinding()>
    <cfset qgetLungFinding= Application.StaticDataNew.getLungFinding()>
    <cfset qgetParasiteLocation= Application.StaticDataNew.getParasiteLocation()>
    <cfset qGIForeignMaterial= Application.StaticDataNew.getGIForeignMaterial()>
    <cfset qgetParasiteType= Application.StaticDataNew.getParasiteType()>
    <cfset qgetParasiteLocation= Application.StaticDataNew.getParasiteLocation()>
    <cfset qgetLymphNodePresent= Application.StaticDataNew.getLymphNodePresent()>
    <cfset qgetNxLocation= Application.StaticDataNew.getNxLocation()>
    <cfset getTeams=Application.SightingNew.getTeams()>
 
    <!--- getting all fieldnumbers from stranding sections --->
    <!--- <cfset qgetallfieldnumber=application.Stranding.getallfieldnumber()> --->
    <cfset Skeletal_Findingss= ['No Findings','Fractures','Dislocation','Avulsions','Deformities','Other- Note Location in Comments']>
    <cfset Conditions = ['Fresh Dead', 'Moderate Decomposition' ,'Advanced Decomposition','Mummified']>
    <cfset Condition_at_Necropsy = ['Fresh Dead','Moderate Decomposition','Advanced Decomposition','Mummified']>
    <cfset Animal_Renderings = ['Buried On Site','Towed Offshore','Burried and Towed Offshore','Landfill']>
    <cfset Fat_Blubber = ['Abundant - No Atrophy','Mild to Moderate Atrophy','Severe Atrophy','NE']>
    <cfset Eye_Finding = ['No Findings','Cloudy','Bloody','Predated','Present']>
    <cfset Joint_Fluid = ['No Findings','Cloudy - Solid Material','Bloody']>
    <cfset Muscle_Status = ['Well Muscled - No Atropy','Mild to Modrate Atropy','Severe Atropy','NE']>
    <cfset Musculature_Findings= ['No Findings','Trauma','Hemorrhage','Pallor','Necrosis','Other']>
    <cfset Lining= ['No Findings','Masess','Hemorrhage','Adhesions','Other']>
    <cfset Biliary_Findings= ['No Findings','Gall Bladder thickened','Bile Ducts thickened','Ulcer','Exudate','Stones','Other']>
    <cfset Pericardial_Fluid= ['No Findings','Cloudy/Solid Material','Blood-tinged','Blood clots','Fibrin','Other']>
    <cfset Overall_Findings= ['None','Trauma','Endocarditis-Arteritis','Blood clots','Vessels thickened','Adhesions','Other']>
    <cfset Color_of_Foam= ['White','Pink','Red','Tan','Yellow','Green','Other']>
    <cfset Trachea_Bronchi= ['No Findings','Exudate','Masses','Ulceration','Other']>
    <cfset Kidneys_Findings= ['No Findings','Trauma','Enlarged','Masses','Parasites','Other']>
    <cfset brain_Findings= ['No Findings','Trauma','Congestion','Hemorrhage','Necrosis','Exudate','Possible Parasite Ova','Not Examed','Partial Examed','Other']>
    <cfset material_type= ['Hook','Line','Hard Plastic','Plastic Bags','Misc Soft Plastic','Ballon','Other']>
    <cfset Spinal_Cord= ['No Findings','Trauma','Hemorrhage','Necrosis','Exudate','Possible Parasite Ova','Not Examed','Partial Examed','Other']>
    <cfset ageClas = ['Neonate','YOY','Yearling','Calf','Juvenile','Subadult','Adult','CBD/Unknown','Pup','Fetus']>
    <cfset sex = ['Male','Female','unknown']>
    <cfparam  name="form.fieldnumber" DEFAULT="empty">
    <cfparam  name="form.report" DEFAULT="emptys">
    <cfif isDefined('form.save')>
        <!--- <cfdump var="#Form#"><cfabort> --->
        <cfif isDefined('form.report') and (form.report eq 0 or form.report eq "emptys")>
           
            <cfset CNR = Application.Stranding.CetaceanNecropsyinsert(argumentCollection="#Form#")>
            <cfset  Application.Stranding.DynamicNutritioninsert(argumentCollection="#Form#")>
            <cfset  Application.Stranding.DynamicLymphoreticularinsert(argumentCollection="#Form#")>
            <cfset  Application.Stranding.DynamicParasitesinsert(argumentCollection="#Form#")>
        <cfelse>
            <cfset Application.Stranding.updateCetaceanNecropsy(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicNutrition(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicLymphoreticular(argumentCollection="#Form#")>
            <cfset Application.Stranding.updateDynamicParasites(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicNutritioninsert(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicLymphoreticularinsert(argumentCollection="#Form#")>
            <cfset Application.Stranding.DynamicParasitesinsert(argumentCollection="#Form#")>
        
          
        </cfif>
        
    <cfelseif isDefined('delete')>
        <!--- <cfdump var="#Form#"><cfabort> --->
        <cfset Application.Stranding.deletcetaceannecropsy("#form#")>
    <cfelseif isDefined('deletCetaceanNecropsyAllRecord')>
        <cfset Application.Stranding.deletCetaceanNecropsyAllRecord()>
    </cfif>
    <cfset qgetallfieldnumber=application.Stranding.getallfieldnumber()>
    <cfif isDefined('form.fieldnumber') and fieldnumber neq "">
        <cfset form.field = form.fieldnumber>
        <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy("#form.field#")>
        <cfset qgetAllData=Application.Stranding.getAllData("#form.field#")>
        
        <cfset qgetNutritional=Application.Stranding.getNutritional("#form.field#")>
        
        <!--- <cfdump var="#qgetAllData#" >  --->
    
        <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular("#form.field#")>
        <!--- <cfdump var="#qgetLymphoreticular#" abort="true"> --->
        <cfset qgetParasites=Application.Stranding.getParasites("#form.field#")>
        <cfif #qgetCetaceanNecropsy.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetCetaceanNecropsy.species#")>
            
        </cfif>
        <cfif isDefined('qgetAllData.species') and #qgetAllData.species# neq "">
            <cfset getCetaceansCode=Application.SightingNew.getCetaceansCode(Cetacean_Species="#qgetAllData.species#")>
            
            <!--- <cfdump var="#getCetaceansCode#"><cfabort> --->
        </cfif>
    <cfelse>
        <cfset qgetCetaceanNecropsy=Application.Stranding.getCetaceanNecropsy_ten()>
        <cfset qgetNutritional=Application.Stranding.getNutritional_ten()>
        <cfset qgetLymphoreticular=Application.Stranding.getLymphoreticular_ten()>
        <cfset qgetParasites=Application.Stranding.getParasites_ten()>
       
    </cfif>
    <cfoutput>
        
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Cetacean Necropsy Report</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Cetacean Necropsy Report</h1>
            <!-- end page-header -->
        <form id="myform" action="" method="post" autocomplete="on">
        <div class="main-new-page-content">
        <div class="top-sec">
        <div class="row">
        <div class="col-lg-4">
        <div class="cust-row">
        <div class="cust-fld"><label class="fl-lbl">Field Number</label> 
        </div>
        <!--- <form id="myform" action="" method="post" autocomplete="on"> --->
            <div class="cust-inp">
                <select name="fieldnumber" id="fieldnumber" class="stl-op search-box" required onChange="checkfield()" >
                    <option value="">Select</option>
                    <option value="0" class="adnew">Add New</option>
                    <cfloop query="qgetallfieldnumber">
                     <option value="#qgetallfieldnumber.Fnumber#" <cfif isDefined('form.fieldnumber') and form.fieldnumber eq #qgetallfieldnumber.Fnumber#>selected</cfif>>#qgetallfieldnumber.Fnumber#</option>
                    </cfloop>
                </select>
            </div>
            
            <span style="color:red; display:none;" Id="errorMessage">This field is required.</span>
        </div>
        </div>


        <div class="col-lg-4" style="margin-bottom: 10px;">
            <div class="cust-row nflex">
                <!-- line 162 add new row this cfif code placed there -->
                <!--- <cfif isDefined('qgetCetaceanNecropsy.ID') and #qgetCetaceanNecropsy.ID# neq "" > --->
                    <input type='hidden' name='report' id="report" value='#form.report#'>
                    <input type='hidden' name='report_ID' id="repotrt_ID" value='#qgetCetaceanNecropsy.ID#'>
                    <input type='hidden' name='fieldno' id="fieldno" value='#form.fieldnumber#'>
                    <input type='hidden' name='form_id' id="form_id" value='#qgetCetaceanNecropsy.ID#'>
                <!--- </cfif> --->

                <div class="cust-fld apend"><label class="fl-lbl">Date</label></div>
                <!--- <cfif (isDefined('qgetCetaceanNecropsy.species') and #qgetCetaceanNecropsy.species# neq "") OR (isDefined('qgetAllData.species') and #qgetAllData.species# neq "") > --->
                <div class="cust-inp input-group date"id="first_date">
                <input type="text" id="birthday" name="birthday" value='<cfif #qgetCetaceanNecropsy.date# neq ''>#DateTimeFormat(qgetCetaceanNecropsy.date, "MM/dd/YYYY")#<cfelseif isDefined('qgetAllData')>#DateTimeFormat(qgetAllData.date, "MM/dd/YYYY")#</cfif>' placeholder="mm/dd/yyyy"class="text-field"> 
                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                </div>
            <!--- </cfif> --->
            </div>
        </div>
        
        <div class="col-lg-4" style="margin-bottom: 10px;">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Species</label></div>
                <div class="cust-inp">
                    <!--- <cfdump var="#qgetCetaceanNecropsy.species#" >  --->
                    <select class="stl-op" name="species" id="species" onChange="changeimg()">
                        <option value="0">Select</option>
                        <cfloop query="qgetCetaceanSpecies">
                            <cfif isDefined('qgetCetaceanNecropsy.species') and #qgetCetaceanNecropsy.species# neq ''>
                                
                                <option value="#qgetCetaceanSpecies.id#" <cfif isDefined('qgetCetaceanNecropsy.species') and            qgetCetaceanNecropsy.species eq #qgetCetaceanSpecies.id#>selected</cfif>>
                                    #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                                <cfelse>
                                    <option value="#qgetCetaceanSpecies.id#" <cfif isDefined('qgetAllData.species') and qgetAllData.species eq #qgetCetaceanSpecies.id#>selected</cfif>>
                                        #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                            </cfif>
                            <!--- <cfif active eq 1> --->
                                <!--- <option value="#qgetCetaceanSpecies.id#" <cfif isDefined('qgetCetaceanNecropsy.species') and qgetCetaceanNecropsy.species eq #qgetCetaceanSpecies.id#>selected</cfif>>
                                    #qgetCetaceanSpecies.CetaceanSpeciesName# </option> --->
                            <!--- </cfif> --->
                            <!--- <option value="#qgetCetaceanSpecies.id#" <cfif isDefined('qgetCetaceanNecropsy.species')><cfif isDefined('qgetCetaceanNecropsy.species') and qgetCetaceanNecropsy.species eq #qgetCetaceanSpecies.id#>selected</cfif><cfelse><cfif isDefined('qgetAllData.species') and qgetAllData.species eq #qgetCetaceanSpecies.id#>selected</cfif></cfif>>
                                #qgetCetaceanSpecies.CetaceanSpeciesName# </option> --->
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Location</label></div>
                <div class="cust-inp">
                    <input type="text" value="<cfif #qgetCetaceanNecropsy.location# neq ''>#qgetCetaceanNecropsy.location#<cfelseif isDefined('qgetAllData')>#qgetAllData.location#</cfif>" name="location"class="text-field">
                </div>
            </div>
        </div>
    </div>

    <div class="row pt-20">
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="check-fld"><label class="fl-lbl">Animal ID</label>
                </div>
                <div class="check-bx">
                    <input type="checkbox" name="new"class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.new') and  qgetCetaceanNecropsy.new  eq 'on'>checked</cfif>>
                    <label class="check-cust-fld">New</label>
                </div>
                <div class="check-bx">
                    <input type="checkbox"  name="hera"class="check-bxt-fld" <cfif isdefined('qgetCetaceanNecropsy.hera') and  qgetCetaceanNecropsy.hera  eq 'on'>checked</cfif>>
                    <label class="check-cust-fld">HERA</label>
                </div>
                <div class="check-ipt">
                    <input type="text" name="heratext" value="#qgetCetaceanNecropsy.heratext#"class="text-field">
                </div>
                </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Photo ID Code</label>
                </div>
                <div class="cust-inp">
                    <!--- <cfdump var="#getCetaceansCode#"> --->
                    <select name="photocode" id="photocode" class="stl-op" onChange="getFbAndSex1()">
                        
                        <option value="">Select Code</option>
                        <cfif (isDefined('qgetCetaceanNecropsy.species') and #qgetCetaceanNecropsy.species# neq "") OR (isDefined('qgetAllData.species') and #qgetAllData.species# neq "") >
                            <cfloop query="getCetaceansCode">
                                <option value="#getCetaceansCode.id#" <cfif #getCetaceansCode.id# eq #qgetCetaceanNecropsy.photocode#>selected</cfif>>
                                        #getCetaceansCode.code# </option>
                            </cfloop>
                        </cfif>
                    </select>
                </div>
                </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Necropsy Condition Code:</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="InitialCondition" id="InitialCondition">
                        <option value="">Select Initial Condition</option>
                        <cfset cout = "2">
                        <cfloop array="#Conditions#" item="item" index="j">
                            <option value="#item#" <cfif isdefined('qgetCetaceanNecropsy.InitialCondition') and  qgetCetaceanNecropsy.InitialCondition  eq #item#>selected</cfif>>#cout#-#item#</option>
                            <cfset cout = cout +1>
                        </cfloop>
                    </select>
                </div>
                </div>
        </div>
    </div>
    <div class="row pt-20">
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Sex</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="sex" id="sex">
                        <option value="">Select Sex</option>
                        <cfloop from="1" to="#ArrayLen(sex)#" index="j">
                            <option value="#sex[j]#" <cfif isdefined('qgetCetaceanNecropsy.sex') and  qgetCetaceanNecropsy.sex  eq #sex[j]#>selected</cfif>>#sex[j]#</option>
                        </cfloop>
                    </select>
                </div>
                </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Weight</label>
                </div>
                <div class="cust-inp">
                    <input type="text" value="#qgetCetaceanNecropsy.weight#"name="weight"class="text-field">
                </div>
                </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Age Class</label>
                </div>
                <div class="cust-inp">
                        <select class="stl-op" name="ageclass" id="ageclass"onChange="changeimg()">
                            <option value="">Select Age Class</option>
                            <cfloop from="1" to="#ArrayLen(ageClas)#" index="j">
                                <option value="#ageClas[j]#" <cfif #ageClas[j]# eq #qgetCetaceanNecropsy.ageClass#>selected</cfif>>#ageClas[j]#</option>
                            </cfloop>
                        </select>
                </div>
                </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Actual Age</label>
                </div>
                <div class="cust-inp">
                    <input type="text" value="#qgetCetaceanNecropsy.actualAge#"name="actualAge"class="text-field">
                </div>
                </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Affiliated ID</label>
                </div>
                <div class="cust-inp">
                    <!--- qgetAllData --->
                    <input type="text" value="<cfif #qgetCetaceanNecropsy.affiliatedID# neq'' >#qgetCetaceanNecropsy.affiliatedID#<cfelseif isDefined('qgetAllData')>#qgetAllData.affiliatedID#</cfif>" name="affiliatedID" class="text-field">
                </div>
                </div>
        </div>
    </div>
    <div class="row pt-20">
        <div class="col-lg-12 fldarea">
            <label class="fl-lbl">Brief History</label>
            <textarea id="top-area" name="briefhistory" rows="4" cols="50">#qgetCetaceanNecropsy.briefhistory#</textarea>
        </div>
    </div>
    </div>
    <div class="sec-two">
        <div class="row">
            <div class="col-lg-5">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Attending Veterinarian</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op search-box" multiple="multiple" name="attendingVeterinarian" id="attendingVeterinarian">
                        <cfloop query="qgetVeterinarians">
                            <cfif status eq 1>
                                <option value="#qgetVeterinarians.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.attendingVeterinarian,","),#qgetVeterinarians.ID#)>selected</cfif>>#qgetVeterinarians.Veterinarians#</option>
                            </cfif>
                        </cfloop>
                    </select>
                </div>
                </div>
            </div>
        </div>
        <div class="row pt-15">
            <div class="col-lg-5">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Prosectors</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op search-box" multiple="multiple" name="Prosectors" id="Prosectors">
                        <cfloop query="getTeams">
                            <cfif active eq 1>
                                <option value="#getTeams.RT_ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Prosectors,","),#getTeams.RT_ID#)>selected</cfif>>#getTeams.RT_MemberName#</option>
                            </cfif>
                        </cfloop>
                    </select>
                </div>
                </div>
            </div>
        </div>
        <div class="row pt-15">
            <div class="col-lg-12">
            <div class="cust-row panel-rw">
                <div class="cust-fld"><label class="fl-lbl">Tentative Gross Diagnosis</label>
                </div>
                <div class="cust-inp">
                    <!-- <input type="text" name="Tentative" placeholder="Expandable field to multi-line" value="#qgetCetaceanNecropsy.Tentative#"class="text-field"> -->
                    <textarea id="top-area" name="Tentative" rows="1" class="text-field" cols="50">#qgetCetaceanNecropsy.Tentative#</textarea>
                </div>
                </div>
            </div>
            <div class="col-lg-12 mt-15">
                <div class="cust-row panel-rw">
                    <div class="cust-fld"><label class="fl-lbl">Cause of Death</label>
                    </div>
                    <div class="cust-inp">
                        <!-- <input type="text" name="deathcause" placeholder="Expandable field to multi-line" value="#qgetCetaceanNecropsy.deathcause#"class="text-field"> -->
                        <textarea id="top-area" name="deathcause" rows="1" class="text-field" cols="50">#qgetCetaceanNecropsy.deathcause#</textarea>
                    </div>
                </div>
                </div>
        </div>
        <div class="row pt-15">
            <div class="col-lg-8 fldarea">
            <label class="fl-lbl">Histopathology Remarks / Diagnosis</label>
            <textarea id="top-area" name="historemark" rows="4" cols="50">#qgetCetaceanNecropsy.historemark#</textarea>
            </div>

<!---             working strat --->
            <div class="col-lg-4">
                <div class="btn-rw cust-row mt-30 cst-rows">
                <div class="cust-inp inps">
                    <div class="cust-inp test" id="histoSpinner">
                    <input type="file" placeholder="pdf Path" name="histofile" id="histofile" class="text-field text-fields" accept="application/pdf">
                </div>
                <div class="cust-fld"><button type="button" onclick="histoUploadshowPictures()" name="histoUpload"class="upld-btn upld-btns">Upload</button></div>
                </div>


            <cfset HistoImagess = ValueList(qgetCetaceanNecropsy.HistoImages,",")> 
                <!--- <input type="hidden" name="imagesFile2" value="#imgss#" id="imagesFile2"> --->
                <input type="hidden" name="histoImages" value="#HistoImagess#" id="histoImages">
        
                <div id="histoUpload" >
                 <CFIF listLen(HistoImagess)>  
                        <cfloop list="#HistoImagess#" item="item" index="index">
        
                            <span class="pip pipw" style="width: 30%;">
                                <a data-toggle="modal" data-target="##myModala" href="##" title="#Application.CloudRoot##item#" target="blank">
                                    <img  class="imageThumb imageTh" src="http://test.wildfins.org/resources/assets/img/PDF_icon.png" title="#item#" onclick="pdfselected(this)"/>                                  
                                </a>
                                <br/>
                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <span class="remove rem" onclick="histoPdfRemove(this)" id="#item#">Remove image</span>
                                </cfif>
                            </span>
                        </cfloop>
                    </cfif>
                </div>  

                <!-- modal -->
                <div class="modal fade" id="myModala" role="dialog">
                    <div class="modal-dialog">
                    
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" id="pdfname"></h4>
                            </div>
                            <div class="modal-body">
                                <embed id="embe" src="" width="98%" height="500" type="application/pdf" title="test.pdf">
                            </div>
                            <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="simple-button pt-15">
                    <!--- <cfif isDefined('qgetCetaceanNecropsy.fnumber') and qgetCetaceanNecropsy.fnumber neq ""> --->
                    <cfif isDefined('form.fieldno')  and #form.fieldno# neq "empty">
                        <cfquery name="qgetHistoLCEID" datasource="#Application.dsn#"  result="return_data" >
                            SELECT ID from ST_HistoForm where deleted != '1' and Fnumber = '#form.fieldnumber#' 
                        </cfquery>
                        <!--- <cfdump var="#qgetLCEID.ID#" abort="true"> --->
                        <cfif  #qgetHistoLCEID.ID# eq " ">
                            <cfset form.CetaceanID= "0">
                        <cfelse>
                            <cfset form.CetaceanID= "#qgetHistoLCEID.ID#">
                        </cfif>
                        
                    </cfif>
                    <a href="#Application.siteroot#?Module=Stranding&Page=Histopathology&LCE_ID=<cfif isDefined('form.CetaceanID') and #form.CetaceanID# neq "">#form.CetaceanID#<cfelse>0</cfif>"class="linkhisto">
                        Open Histopathology
                    </a>
                </div>
            </div>
        </div>
        </div>
    <div class="full-img-sec">
        <div class="row">
            <div class="col-lg-6">
                <div class="img-group">
                    <img src="http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Tursiops_Diagram.png"id="measureImage">
                </div>
            </div>
            <div class="col-lg-6">
                <div class="cust-row right-panel-rw">
                    <div class="right-fld"><label class="fl-lbl">Total Length (1)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="totalLength"placeholder="" value="#qgetCetaceanNecropsy.totalLength#" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm (rostrum to fluke notch)</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Rostrum to Dorsal Fin (2)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="rostrum"placeholder=""  value="#qgetCetaceanNecropsy.rostrum#" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm (center of blowhole)</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Blowhole to Dorsal (3)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="blowhole"  value="#qgetCetaceanNecropsy.blowhole#"  placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Fluke Width (4)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text"name="fluke"   value="#qgetCetaceanNecropsy.fluke#" placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Girth (circumference) (5)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text"name="girth"   value="#qgetCetaceanNecropsy.girth#" placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Axillary (6)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="axillary"placeholder=""  value="#qgetCetaceanNecropsy.axillary#" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Maximum (7)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="maxium"placeholder=""   value="#qgetCetaceanNecropsy.maxium#" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                </div>
        </div>
        <div class="row pt-30">
            <div class="col-lg-5">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Blubber Thickness Mid-Dorsal</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="blubber"  value="#qgetCetaceanNecropsy.blubber#" class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-7">
                <div class="cust-fld">
            <lable class="fl-lbl">Tooth Count</lable>
        </div>
            </div>
        </div>
        <div class="row mt-10">
            <div class="col-lg-5">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Mid-Lateral</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="midlateral"  value="#qgetCetaceanNecropsy.midlateral#" class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Upper Left</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Lateralupperleft"  value="#qgetCetaceanNecropsy.Lateralupperleft#" class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Lower Left</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Laterallowerleft"  value="#qgetCetaceanNecropsy.Laterallowerleft#" class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-3"></div>
        </div>
        <div class="row mt-10">
            <div class="col-lg-5">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Mid-Ventral</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="midVentral"  value="#qgetCetaceanNecropsy.midVentral#"  class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Upper Right</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Ventralupperleft" value="#qgetCetaceanNecropsy.Ventralupperleft#"class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Lower Right</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ventrallowerright" value="#qgetCetaceanNecropsy.Ventrallowerright#"class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-3"></div>
        </div>
        </div>

    <div class="examination-sec">
        <div class="sec-title"><h2>External Examination</h2><span></span></div>
        <div class="row pt-30">
        <div class="col-lg-12">
            <div class="col-lg-5">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Condition at Necropsy</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Necropsycondition" id="Necropsy_condition">
                            <option value="">Select</option>
                            <cfset coutt = "2">
                            <cfloop array="#Condition_at_Necropsy#" item="item" index="j">
                                <option value="#item#"<cfif isdefined('qgetCetaceanNecropsy.Necropsycondition') and  qgetCetaceanNecropsy.Necropsycondition  eq #item#>selected</cfif>>#coutt#-#item#</option>
                                <cfset coutt = coutt +1>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="col-lg-5">
                <div class="cust-row">
                    <div class="cust-fld">
                        <label class="fl-lbl">Euthanized</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Euthanized" id="Euthanized">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Euthanized') and  qgetCetaceanNecropsy.Euthanized  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Euthanized') and  qgetCetaceanNecropsy.Euthanized  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="col-lg-8">
                <div class="cust-row exam-rw">
                    <div class="cust-fld">
                        <label class="fl-lbl">General Body Condition</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"  name="Bodycondition"class="text-field" value="#qgetCetaceanNecropsy.Bodycondition#">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="col-lg-5">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Level A Date</label>
                    </div>
                    <div class="cust-inp input-group date"id="LevelA_Date">
                        <input type="text" id="Level_A_Date" name="LevelADate" value='#DateTimeFormat(qgetCetaceanNecropsy.LevelADate, "MM/dd/YYYY")#' placeholder="mm/dd/yyyy"class="text-field"> 
                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Animal Renderings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="AnimalRenderings" id="Animal_Renderings">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Animal_Renderings)#" index="j">
                                <option value="#Animal_Renderings[j]#" <cfif isdefined('qgetCetaceanNecropsy.AnimalRenderings') and  qgetCetaceanNecropsy.AnimalRenderings  eq #Animal_Renderings[j]#>selected</cfif>>#Animal_Renderings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="col-lg-5">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Necropsy Date</label>
                    </div>
                    <div class="cust-inp input-group date"id="Necropsy_Date">
                        <input type="text" id="NecropsyDate" name="NecropsyDate"value='#DateTimeFormat(qgetCetaceanNecropsy.NecropsyDate, "MM/dd/YYYY") #' placeholder="mm/dd/yyyy"class="text-field"> 
                        <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Nx Location</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="NxLocation" id="NxLocation">
                            <cfloop query="qgetNxLocation">
                                <cfif status eq 1>
                                    <option value="#qgetNxLocation.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.NxLocation,","),#qgetNxLocation.ID#)>selected</cfif>>#qgetNxLocation.location#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        
    <!--- working start --->
        <div class="col-lg-5" id="ExternalExamDiv" style="display: none;">
            <div class="cust-row btn-rw startSpinner" >
                <div class="cust-inp test" id="start">                    
                    <input type="file" placeholder="image Path" name="ExternalExamphoto" id="ExternalExamphoto" class="text-field text-fields" accept="image/*">
                </div>
                <div class="cust-fld"><button type="button"  onclick="showPictures()" class="upld-btn upld-btns">Upload</button></div>
            </div>
        </div>
            <div class="choose-images">
                <cfset imgss = ValueList(qgetCetaceanNecropsy.images,",")>
                <input type="hidden" name="imagesFile" value="#imgss#" id="imagesFile">
        
                <div id="previousimages"  class="choose-images-detail">
                    <!--- <div id="previousImagesRemove"> --->
                    
                    <CFIF listLen(imgss)> 

                        <cfloop list="#imgss#" item="item" index="index">
        
                            <span class="pip pipwse" >
                                <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                </a>
                                <br/>
                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <span class="remove rms" onclick="remov(this)" id="#item#">Remove image</span>
                                </cfif>
                            </span>
                        </cfloop>
                    </cfif>	
                <!--- </div> --->
                </div>
            </div>        
        </div>
    </div>

            <!--- working --->
            <!--- modal --->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
        
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="pdfname"></h4>
                </div>
                <div class="modal-body">
                    <img id="emb" src="" width="98%" height="500" type="application/jpeg" title="test.jpeg">
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!--- working end --->
    <div class="examination-sec">
        <div class="sec-title"><h2>Integument</h2><span></span></div>
        <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-6">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Skin Lesion Form</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Lesionform" id="Lesion_Form">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Lesionform') and  qgetCetaceanNecropsy.Lesionform  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Lesionform') and  qgetCetaceanNecropsy.Lesionform  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">HI Form</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="HIForm" id="HI_Form">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.HIForm') and  qgetCetaceanNecropsy.HIForm  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value"No" <cfif isdefined('qgetCetaceanNecropsy.HIForm') and  qgetCetaceanNecropsy.HIForm  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Number of Cookie Cutter Wounds</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" value="#qgetCetaceanNecropsy.cutterwounds#"name="cutterwounds"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Number of Cookie Cutter Scars</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" value="#qgetCetaceanNecropsy.cutterscars#" name="cutterscars"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Eye Findings LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="eyeleft" id="eye_left">
                            <!--- <option value="">Select</option> --->
                            <cfloop from="1" to="#ArrayLen(Eye_Finding)#" index="j">
                                <option value="#Eye_Finding[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.eyeleft,","),#Eye_Finding[j]#)>selected</cfif>>#Eye_Finding[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Eye Findings RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="eyeright" id="eye_right">
                            <!--- <option value="">Select</option> --->
                            <cfloop from="1" to="#ArrayLen(Eye_Finding)#" index="j">
                                <option value="#Eye_Finding[j]#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.eyeright,","),#Eye_Finding[j]#)>selected</cfif>>#Eye_Finding[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
                <cfif isDefined('form.fieldno')  and #form.fieldno# neq "empty">
                    <cfquery name="qgetLCEID" datasource="#Application.dsn#"  result="return_data" >
                        SELECT ID from ST_LiveCetaceanExam where deleted != '1' and Fnumber = '#form.fieldnumber#' 
                    </cfquery>
                    <!--- <cfdump var="#qgetLCEID.ID#" abort="true"> --->
                    <cfif  #qgetLCEID.ID# eq " ">
                        <cfset form.CetaceanID= "0">
                    <cfelse>
                        <cfset form.CetaceanID= "#qgetLCEID.ID#">
                    </cfif>
                    
                    <!--- <cfdump var="#form.CetaceanID#" > --->
                </cfif>
                <div class="simple-button pt-15 align-right">
                    <a href="#Application.siteroot#?Module=Stranding&Page=CetaceanExam&LCEID=<cfif isDefined('form.CetaceanID') and #form.CetaceanID# neq "">#form.CetaceanID#<cfelse>0</cfif>"class="linkcetacean">
                        Open Cetacean Exam
                    </a>
                </div>
            </div>
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">If skin lesion present, please describe</label>
            <textarea id="top-area" name="lessiondescribe" rows="12" cols="120">#qgetCetaceanNecropsy.lessiondescribe#</textarea>
        </div>
        <div class="col-lg-12 fldarea">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="lessioncomments" rows="12" cols="120">#qgetCetaceanNecropsy.lessioncomments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input  type="checkbox"name="lessionphototaken" id="lessionphototaken" onclick="lessionphotos()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.lessionphototaken') and  qgetCetaceanNecropsy.lessionphototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
        <!--- working start --->
        <div class="col-lg-5" id="integumentdiv" style="display: block;">
            <div class="cust-row btn-rw startSpinner">
                <div class="cust-inp cust-inpts">
                    <div class="cust-inp test" id="startSpinner">
                        <input type="file" placeholder="image Path" name="Integumentphoto" id="Integumentphoto" class="text-field text-fields" accept="image/*">
                    </div>
                    <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="integumentshowPictures()">Upload</button></div>
                </div>
            </div>
        </div>
        <div class="choose-images">
            <cfset imgs = ValueList(qgetCetaceanNecropsy.integumentImages,",")>
                <input type="hidden" name="integumentImagesFile" value="#imgs#" id="integumentImagesFile">
                <div id="IntegumentPreviousimages" class="choose-images-detail">
                    <CFIF listLen(imgs)> 
                        <cfloop list="#imgs#" item="item" index="index">
        
                            <span class="pip pipws">
                                <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                </a>
                                <br/>
                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <span class="remove rms" onclick="integumentImageremove(this)" id="#item#">Remove image</span>
                                </cfif>
                            </span>
                        </cfloop>
                    </cfif>	
                </div> 
        </div>

        <!--- working end --->
    

    </div>
    <div class="examination-sec">
        <div class="sec-title"><h2>Internal Examination</h2><span></span></div>
        <div class="mid-t"><h3>NUTRITIONAL CONDITION - INTERNAL</h3></div>
        <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fat/Blubber Status</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Fat_Blubber" id="Fat_Blubber">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" <cfif isdefined('qgetCetaceanNecropsy.Fat_Blubber') and  qgetCetaceanNecropsy.Fat_Blubber  eq '#Fat_Blubber[j]#'>selected</cfif>>#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"></label>
                    </div>
                    <div class="cust-fld"><label class="fl-lbl"><strong>Fat Around Organs</strong></label>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Heart</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="heart" id="heart">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" <cfif isdefined('qgetCetaceanNecropsy.heart') and  qgetCetaceanNecropsy.heart  eq '#Fat_Blubber[j]#'>selected</cfif>>#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Mesentery</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="mesentery" id="mesentery">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" <cfif isdefined('qgetCetaceanNecropsy.mesentery') and  qgetCetaceanNecropsy.mesentery  eq '#Fat_Blubber[j]#'>selected</cfif>>#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw ">
                    <div class="cust-fld"><label class="fl-lbl">Kidneys</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="kidney" id="kidney">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" <cfif isdefined('qgetCetaceanNecropsy.kidney') and  qgetCetaceanNecropsy.kidney  eq '#Fat_Blubber[j]#'>selected</cfif>>#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <cfif isDefined('qgetNutritional') AND #qgetNutritional.recordcount# gt 0>
                    <input type="hidden" id="dynamicone" value="#qgetNutritional.recordcount#" name="count">
                    <cfloop query="qgetNutritional">
                        <div class="cust-row ingm-rw kidneyClass">
                            <cfif isDefined('qgetNutritional.organs_label')>
                            <div class="cust-fld"><label class="fl-lbl"><input name="organlabel#qgetNutritional.ID#" type="text" value="#qgetNutritional.organs_label#" class="text-field"></label>
                            </div>
                        
                            <div class="cust-inp">
                                <select class="stl-op" name="NUTRI#qgetNutritional.ID#">
                                    <option value="">Select</option>
                                    <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                        <option value="#Fat_Blubber[j]#"<cfif isdefined('qgetNutritional.newNUTRI') and  qgetNutritional.newNUTRI  eq '#Fat_Blubber[j]#'>selected</cfif> >#Fat_Blubber[j]#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </cfif>
                        </div>
                    </cfloop>
                </cfif>
                <div id="newNUTRI" class="add_new_btn_content"></div>
                <div class="simple-button pt-15 align-right">
                    <input type="hidden" name="dynamic_NUTRITIONAL" value="" id="dynamic_NUTRITIONAL">
                    <!--- <button class="upld-btn">Add New</button> --->
                    <input type="button" id="Add_new" name="Add_new" class="upld-btn" value="Add New" onclick="newNUTRITIONAL()">
                </div>
            </div>
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="internal_comments" rows="12" cols="120">#qgetCetaceanNecropsy.internal_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="internal_phototaken" id="internal_phototaken" onclick="internalPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.internal_phototaken') and  qgetCetaceanNecropsy.internal_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
        <div class="col-lg-8" id="intenalExamphotoDiv">
            <div class="cust-row btn-rw startSpinner">
                <div class="cust-inp cust-inptsi">
                    <div class="cust-inp test" id="intenalExamSpinner">
                        <input type="file" name="intenalExamphoto" id="intenalExamphoto" class="text-field text-fields" accept="image/*">
                    </div>
                    <div class="cust-fld"><button type="button" onclick="intenalExamPictures()" class="upld-btn upld-btns">Upload</button></div>
                </div>
            </div>
        </div>
        <div class="choose-images">
            <cfset IntenalExamimg = ValueList(qgetCetaceanNecropsy.IntenalExamImages,",")>
                    <input type="hidden" name="intenalExamImagesFile" value="#IntenalExamimg#" id="intenalExamImagesFile">
                    <div id="intenalExamPreviousimages" class="choose-images-detail"> 
                        <div id="">
                        </div>
                    <CFIF listLen(IntenalExamimg)> 
                            <cfloop list="#IntenalExamimg#" item="item" index="index">
            
                                <span class="pip pipswi">
                                    <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                        <!-- <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/> -->
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="intenalImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                </div>
        </div>
    <div class="row pt-30">
        <div class="col-lg-7 mt-10">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">MUSCULOSKELETAL SYSTEM</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="MUSCULOSKELETAL" id="MUSCULOSKELETAL">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.MUSCULOSKELETAL') and  qgetCetaceanNecropsy.MUSCULOSKELETAL  eq 'Examined'>selected</cfif>>Examined</option>
                            <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.MUSCULOSKELETAL') and  qgetCetaceanNecropsy.MUSCULOSKELETAL  eq 'NE'>selected</cfif>>NE</option>
                            
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Joint Fluid</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Joint_Fluid"id="Joint_Fluid">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Joint_Fluid)#" index="j">
                                <option value="#Joint_Fluid[j]#"<cfif isdefined('qgetCetaceanNecropsy.Joint_Fluid') and  qgetCetaceanNecropsy.Joint_Fluid  eq #Joint_Fluid[j]#>selected</cfif>>#Joint_Fluid[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Skeletal Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="Skeletal_Findings"id="Skeletal_Findings">
                            <!--- <option value="">Select</option> --->
                            <cfloop from="1" to="#ArrayLen(Skeletal_Findingss)#" index="j">
                                <option value="#Skeletal_Findingss[j]#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Skeletal_Findings,","),#Skeletal_Findingss[j]#)>selected</cfif>>#Skeletal_Findingss[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Muscle Status</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Muscle_Status"id="Muscle_Status">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Muscle_Status)#" index="j">
                                <option value="#Muscle_Status[j]#"<<cfif ListFind(ValueList(qgetCetaceanNecropsy.Muscle_Status,","),#Muscle_Status[j]#)>selected</cfif>>#Muscle_Status[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Musculature Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="Musculature_Findings" id="Musculature_Findings">
                            <!--- <option value="">Select</option> --->
                            <cfloop from="1" to="#ArrayLen(Musculature_Findings)#" index="j">
                                <option value="#Musculature_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.Musculature_Findings,","),#Musculature_Findings[j]#)>selected</cfif>>#Musculature_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>


        <!--- working start --->
        <div class="col-lg-12" id="musculoskeletalDiv">
            <div class="cust-row btn-rw startSpinner">
                <div class="cust-inp cust-inpts">
                    <div class="cust-inp test" id="startMusculoskeletalSpinner">
                        <input type="file" placeholder="image Path" name="musculoskeletal" id="musculoskeletal" class="text-field text-fields" accept="image/*">
                    </div>
                    <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="musculoskeletalshowPictures()">Upload</button></div>
                </div>
            </div>
        </div>
        <div class="choose-images">
            <cfset musculoskeletalImgs = ValueList(qgetCetaceanNecropsy.musculoskeletalImages,",")>
                <input type="hidden" name="musculoskeletalImagesFile" value="#musculoskeletalImgs#" id="musculoskeletalImagesFile">
                <div id="musculoskeletalPreviousimages" class="choose-images-detail">
                    <CFIF listLen(musculoskeletalImgs)> 
                        <cfloop list="#musculoskeletalImgs#" item="item" index="index">
        
                            <span class="pip pipws">
                                <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                </a>
                                <br/>
                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <span class="remove rms" onclick="musculoskeletalImageremove(this)" id="#item#">Remove image</span>
                                </cfif>
                            </span>
                        </cfloop>
                    </cfif>	
                </div> 
        </div>

        <!--- working end --->
        </div>
        <div class="col-lg-5 mt-5">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="muscular_comments" rows="10" cols="120">#qgetCetaceanNecropsy.muscular_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="muscular_phototaken" id="muscular_phototaken" onclick="muscularPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.muscular_phototaken') and  qgetCetaceanNecropsy.muscular_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">THORACIC CAVITY</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op"name="THORACIC"id="THORACIC">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.THORACIC') and  qgetCetaceanNecropsy.THORACIC  eq 'Examined'>selected</cfif>>Examined</option>
                            <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.THORACIC') and  qgetCetaceanNecropsy.THORACIC  eq 'NE'>selected</cfif>>NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="fluidVolume" value="#qgetCetaceanNecropsy.fluidVolume#"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">ml</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ml" id="ml">
                            <option value="">Select</option>
                            <option value="Actual"<cfif isdefined('qgetCetaceanNecropsy.ml') and  qgetCetaceanNecropsy.ml  eq 'Actual'>selected</cfif>>Actual</option>
                            <option value="Estimate"<cfif isdefined('qgetCetaceanNecropsy.ml') and  qgetCetaceanNecropsy.ml  eq 'Estimate'>selected</cfif>>Estimate</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="THORACIC_Fluid"id="THORACIC_Fluid">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Joint_Fluid)#" index="j">
                                <option value="#Joint_Fluid[j]#" <cfif isdefined('qgetCetaceanNecropsy.THORACIC_Fluid') and  qgetCetaceanNecropsy.THORACIC_Fluid  eq #Joint_Fluid[j]#>selected</cfif>>#Joint_Fluid[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Lining</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op"name="THORACIC_Lining"id="THORACIC_Lining">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Lining)#" index="j">
                                <option value="#Lining[j]#"<cfif isdefined('qgetCetaceanNecropsy.THORACIC_Lining') and  qgetCetaceanNecropsy.THORACIC_Lining  eq #Lining[j]#>selected</cfif> >#Lining[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
         
                    <!--- working start --->
                    <div class="col-lg-12" id="thoracicphotoDiv">
                        <div class="cust-row btn-rw startSpinner">
                            <div class="cust-inp cust-inpts">
                                <div class="cust-inp test" id="startThoracicSpinner">
                                    <input type="file" placeholder="image Path" name="thoracicphoto" id="thoracicphoto" class="text-field text-fields" accept="image/*">
                                </div>
                                <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="thoracicshowPictures()">Upload</button></div>
                            </div>
                        </div>
                    </div>
                    <div class="choose-images">
                        <cfset thoracictImgs = ValueList(qgetCetaceanNecropsy.thoracictImages,",")>
                            <input type="hidden" name="thoracicImagesFile" value="#thoracictImgs#" id="thoracicImagesFile">
                            <div id="thoracicPreviousimages" class="choose-images-detail">
                                <CFIF listLen(thoracictImgs)> 
                                    <cfloop list="#thoracictImgs#" item="item" index="index">
                    
                                        <span class="pip pipws">
                                            <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                            </a>
                                            <br/>
                                            <cfif findNoCase("Read only ST", permissions) eq 0>
                                                <span class="remove rms" onclick="thoracicImageremove(this)" id="#item#">Remove image</span>
                                            </cfif>
                                        </span>
                                    </cfloop>
                                </cfif>	
                            </div> 
                    </div>
            
                    <!--- working end --->
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="thoratic_comments" rows="10" cols="120">#qgetCetaceanNecropsy.thoratic_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="thoratic_phototaken" id="thoratic_phototaken" onclick="thoraticPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.thoratic_phototaken') and  qgetCetaceanNecropsy.thoratic_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
    <div class="row pt-30">
    <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">ABDOMINAL CAVITY</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ABDOMINAL" id="ABDOMINAL">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL') and  qgetCetaceanNecropsy.ABDOMINAL  eq 'Examined'>selected</cfif>>Examined</option>
                            <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL') and  qgetCetaceanNecropsy.ABDOMINAL  eq 'NE'>selected</cfif>>NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="abdominal_fluidVolume" value="#qgetCetaceanNecropsy.abdominal_fluidVolume#"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">ml</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ABDOMINAL_ml" id="ABDOMINAL_ml">
                            <option value="">Select</option>
                            <option value="Actual"<cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL_ml') and  qgetCetaceanNecropsy.ABDOMINAL_ml  eq 'Actual'>selected</cfif>>Actual</option>
                            <option value="Estimate"<cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL_ml') and  qgetCetaceanNecropsy.ABDOMINAL_ml  eq 'Estimate'>selected</cfif>>Estimate</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ABDOMINAL_Fluid" id="ABDOMINAL_Fluid">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Joint_Fluid)#" index="j">
                                <option value="#Joint_Fluid[j]#" <cfif isdefined('qgetCetaceanNecropsy.ABDOMINAL_Fluid') and  qgetCetaceanNecropsy.ABDOMINAL_Fluid  eq #Joint_Fluid[j]#>selected</cfif>
                                    >#Joint_Fluid[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Lining</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="ABDOMINAL_Lining" id="ABDOMINAL_Lining">
                            <cfloop from="1" to="#ArrayLen(Lining)#" index="j">
                                <option value="#Lining[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.ABDOMINAL_Lining,","),#Lining[j]#)>selected</cfif>
                                    >#Lining[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
              
                    <!--- working start --->
                    <div class="col-lg-12" id="abdominalDiv">
                        <div class="cust-row btn-rw startSpinner">
                            <div class="cust-inp cust-inpts">
                                <div class="cust-inp test" id="startAbdominalSpinner">
                                    <input type="file" placeholder="image Path" name="abdominalphoto" id="abdominalphoto" class="text-field text-fields" accept="image/*">
                                </div>
                                <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="abdominalshowPictures()">Upload</button></div>
                            </div>
                        </div>
                    </div>
                    <div class="choose-images">
                        <cfset abdominalImgs = ValueList(qgetCetaceanNecropsy.abdominalImages,",")>
                            <input type="hidden" name="abdominalImagesFile" value="#abdominalImgs#" id="abdominalImagesFile">
                            <div id="abdominalPreviousimages" class="choose-images-detail">
                                <CFIF listLen(abdominalImgs)> 
                                    <cfloop list="#abdominalImgs#" item="item" index="index">
                    
                                        <span class="pip pipws">
                                            <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                            </a>
                                            <br/>
                                            <cfif findNoCase("Read only ST", permissions) eq 0>
                                                <span class="remove rms" onclick="abdominalImageremove(this)" id="#item#">Remove image</span>
                                            </cfif>
                                        </span>
                                    </cfloop>
                                </cfif>	
                            </div> 
                    </div>
            
                    <!--- working end --->
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="abdominal_comments" rows="10" cols="120">#qgetCetaceanNecropsy.abdominal_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="abdominal_phototaken" id="abdominal_phototaken" onclick="abdominalPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.abdominal_phototaken') and  qgetCetaceanNecropsy.abdominal_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">HEPATOBILIARY SYSTEM</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="HEPATOBILIARY" id="HEPATOBILIARY">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.HEPATOBILIARY') and  qgetCetaceanNecropsy.HEPATOBILIARY  eq 'Examined'>selected</cfif>>Examined</option>
                            <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.HEPATOBILIARY') and  qgetCetaceanNecropsy.HEPATOBILIARY  eq 'NE'>selected</cfif>>NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Liver Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple"name="Liver_Findings" id="Liver_Findings">
                            <cfloop query="qgetLiverFinding">
                                <cfif status eq 1>
                                    <option value="#qgetLiverFinding.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Liver_Findings,","),#qgetLiverFinding.ID#)>selected</cfif>>#qgetLiverFinding.finding#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Biliary Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Biliary_Findings" id="Biliary_Findings">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Biliary_Findings)#" index="j">
                                <option value="#Biliary_Findings[j]#"<cfif isdefined('qgetCetaceanNecropsy.Biliary_Findings') and  qgetCetaceanNecropsy.Biliary_Findings  eq #Biliary_Findings[j]#>selected</cfif> >#Biliary_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            
<!--- working start --->
<div class="col-lg-12" id="hepatobiliaryDiv">
    <div class="cust-row btn-rw startSpinner">
        <div class="cust-inp cust-inpts">
            <div class="cust-inp test" id="startHepatobiliarySpinner">
                <input type="file" placeholder="image Path" name="hepatobiliaryphoto" id="hepatobiliaryphoto" class="text-field text-fields" accept="image/*">
            </div>
            <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="hepatobiliaryShowPictures()">Upload</button></div>
        </div>
    </div>
</div>
<div class="choose-images">
    <cfset hepatobiliaryImgs = ValueList(qgetCetaceanNecropsy.hepatobiliaryImages,",")>
        <input type="hidden" name="hepatobiliaryImagesFile" value="#hepatobiliaryImgs#" id="hepatobiliaryImagesFile">
        <div id="hepatobiliaryPreviousimages" class="choose-images-detail">
            <CFIF listLen(hepatobiliaryImgs)> 
                <cfloop list="#hepatobiliaryImgs#" item="item" index="index">

                    <span class="pip pipws">
                        <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                            <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                        </a>
                        <br/>
                        <cfif findNoCase("Read only ST", permissions) eq 0>
                            <span class="remove rms" onclick="hepatobiliaryImageremove(this)" id="#item#">Remove image</span>
                        </cfif>
                    </span>
                </cfloop>
            </cfif>	
        </div> 
</div>

<!--- working end --->
    </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="hepatobiliary_comments" rows="10" cols="120">#qgetCetaceanNecropsy.hepatobiliary_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="hepatobiliary_phototaken" id="hepatobiliary_phototaken" onclick="hepatobiliaryPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.hepatobiliary_phototaken') and  qgetCetaceanNecropsy.hepatobiliary_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
    <!--- 6 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">CARDIOVASCULAR SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CARDIOVASCULAR" id="CARDIOVASCULAR">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.CARDIOVASCULAR') and  qgetCetaceanNecropsy.CARDIOVASCULAR  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.CARDIOVASCULAR') and  qgetCetaceanNecropsy.CARDIOVASCULAR  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl">Blood in Heart Chambers</label>
                </div>
                <div class="cust-inp" >
                    <select class="stl-op"name="Chambers" id="Chambers">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Chambers') and  qgetCetaceanNecropsy.Chambers  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Chambers') and  qgetCetaceanNecropsy.Chambers  eq 'No'>selected</cfif>>No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row describe-rw">
                <div class="cust-fld"><label class="fl-lbl">Describe</label>
                </div>
                <div class="cust-inp">
                    <input type="text" name="cardio_describe" value="#qgetCetaceanNecropsy.cardio_describe#" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <!--- 7 --->
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Pericardial Fluid</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Pericardial_Fluid" id="Pericardial_Fluid">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Pericardial_Fluid)#" index="j">
                                <option value="#Pericardial_Fluid[j]#"<cfif isdefined('qgetCetaceanNecropsy.Pericardial_Fluid') and  qgetCetaceanNecropsy.Pericardial_Fluid  eq #Pericardial_Fluid[j]#>selected</cfif>
                                    >#Pericardial_Fluid[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Overall Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple" name="Overall_Findings" id="Overall_Findings">
                            <cfloop from="1" to="#ArrayLen(Overall_Findings)#" index="j">
                                <option value="#Overall_Findings[j]#"
                                 <cfif ListFind(ValueList(qgetCetaceanNecropsy.Overall_Findings,","),#Overall_Findings[j]#)>selected</cfif>
                                    >#Overall_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
               
               <!--- working start --->
               <div class="col-lg-12" id="cardiovascularDiv">
                   <div class="cust-row btn-rw startSpinner">
                       <div class="cust-inp cust-inpts">
                           <div class="cust-inpst test" id="startCardiovascularSpinner">
                               <input type="file" placeholder="image Path" name="cardiovascularphoto" id="cardiovascularphoto" class="text-field text-fields" accept="image/*">
                           </div>
                           <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="cardiovascularShowPictures()">Upload</button></div>
                       </div>
                   </div>
               </div>
               <div class="choose-images">
                   <cfset cardiovascularImgs = ValueList(qgetCetaceanNecropsy.cardiovascularImages,",")>
                       <input type="hidden" name="cardiovascularImagesFile" value="#cardiovascularImgs#" id="cardiovascularImagesFile">
                       <div id="cardiovascularPreviousimages" class="choose-images-detail">
                           <CFIF listLen(cardiovascularImgs)> 
                               <cfloop list="#cardiovascularImgs#" item="item" index="index">
               
                                   <span class="pip pipws">
                                       <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                           <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                       </a>
                                       <br/>
                                       <cfif findNoCase("Read only ST", permissions) eq 0>
                                           <span class="remove rms" onclick="cardiovascularImageremove(this)" id="#item#">Remove image</span>
                                       </cfif>
                                   </span>
                               </cfloop>
                           </cfif>	
                       </div> 
               </div>
       
               <!--- working end --->
        </div>
    
    </div>
    <div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="cardio_comments" rows="10" cols="120">#qgetCetaceanNecropsy.cardio_comments#</textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" name="cardio_phototaken" id="cardio_phototaken" onclick="cardioPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.cardio_phototaken') and  qgetCetaceanNecropsy.cardio_phototaken  eq 'on'>checked</cfif>
            >
        </div>
    </div>
    <!--- 8 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">PULMONARY SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="PULMONARY" id="PULMONARY">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.PULMONARY') and  qgetCetaceanNecropsy.PULMONARY  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.PULMONARY') and  qgetCetaceanNecropsy.PULMONARY  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl">Foam - Froth in Airway</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Froth_in_Airway" id="Froth_in_Airway">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Froth_in_Airway') and  qgetCetaceanNecropsy.Froth_in_Airway  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Froth_in_Airway') and  qgetCetaceanNecropsy.Froth_in_Airway  eq 'No'>selected</cfif>>No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                <div class="cust-fld"><label class="fl-lbl">If Present</label>
                </div>
                <div class="cust-inp" >
                    <select class="stl-op"name="If_Present" id="If_Present">
                        <option value="">Select</option>
                        <option value="Anterior to Bifurction"<cfif isdefined('qgetCetaceanNecropsy.If_Present') and  qgetCetaceanNecropsy.If_Present  eq 'Anterior to Bifurction'>selected</cfif>>Anterior to Bifurction</option>
                        <option value="Posterior to Bifurction"<cfif isdefined('qgetCetaceanNecropsy.If_Present') and  qgetCetaceanNecropsy.If_Present  eq 'Posterior to Bifurction'>selected</cfif>>Posterior to Bifurction</option>
                        <option value="Anterior and Posterior to Bifurction"<cfif isdefined('qgetCetaceanNecropsy.If_Present') and  qgetCetaceanNecropsy.If_Present  eq 'Anterior and Posterior to Bifurction'>selected</cfif>>Anterior and Posterior to Bifurction</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Foam Amount:</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Foam_Amount" id="Foam_Amount">
                            <option value="">Select</option>
                            <option value="Small"<cfif isdefined('qgetCetaceanNecropsy.Foam_Amount') and  qgetCetaceanNecropsy.Foam_Amount  eq 'Small'>selected</cfif>>Small </option>
                            <option value="Moderate"<cfif isdefined('qgetCetaceanNecropsy.Foam_Amount') and  qgetCetaceanNecropsy.Foam_Amount  eq 'Moderate'>selected</cfif>>Moderate</option>
                            <option value="Copious"<cfif isdefined('qgetCetaceanNecropsy.Foam_Amount') and  qgetCetaceanNecropsy.Foam_Amount  eq 'Copious'>selected</cfif>>Copious</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Color of Foam</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Color_of_Foam" id="Color_of_Foam">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Color_of_Foam)#" index="j">
                                <option value="#Color_of_Foam[j]#" <cfif isdefined('qgetCetaceanNecropsy.Color_of_Foam') and  qgetCetaceanNecropsy.Color_of_Foam  eq #Color_of_Foam[j]#>selected</cfif>>#Color_of_Foam[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Sand/Sediment in Airway</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Sand_Sediment" id="Sand_Sediment">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Sand_Sediment') and  qgetCetaceanNecropsy.Sand_Sediment  eq 'Yes'>selected</cfif>>Yes</option>
                             <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Sand_Sediment') and  qgetCetaceanNecropsy.Sand_Sediment  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Trachea/Bronchi</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Trachea_Bronchi" id="Trachea_Bronchi">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Trachea_Bronchi)#" index="j">
                                <option value="#Trachea_Bronchi[j]#" <cfif isdefined('qgetCetaceanNecropsy.Trachea_Bronchi') and  qgetCetaceanNecropsy.Trachea_Bronchi  eq #Trachea_Bronchi[j]#>selected</cfif>>#Trachea_Bronchi[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Lungs Findings</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple" name="Lungs_Findings" id="Lungs_Findings">
                            <cfloop query="qgetLungFinding">
                                <cfif status eq 1>
                                    <option value="#qgetLungFinding.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Lungs_Findings,","),#qgetLungFinding.ID#)>selected</cfif>>#qgetLungFinding.finding#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Lungs Float in Formalin</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Lungs_Float" id="Lungs_Float">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Lungs_Float') and  qgetCetaceanNecropsy.Lungs_Float  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value"No" <cfif isdefined('qgetCetaceanNecropsy.Lungs_Float') and  qgetCetaceanNecropsy.Lungs_Float  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="pulmonary_comments" rows="10" cols="120">#qgetCetaceanNecropsy.pulmonary_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="pulmonary_phototaken" id="pulmonary_phototaken" onclick="pulmonaryPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.pulmonary_phototaken') and  qgetCetaceanNecropsy.pulmonary_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Parasites</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="PULMONARYParasites" id="PULMONARYParasites">
                        <option value="">Select</option>
                        <option value="Yes">Yes</option>
                            <option value="No">No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Location</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op search-box"multiple="multiple" name="Parasites_Location" id="Parasites_Location">
                        <cfloop query="qgetParasiteLocation">
                            <cfif status eq 1>
                                <option value="#qgetParasiteLocation.ID#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.Parasites_Location,","),#qgetParasiteLocation.ID#)>selected</cfif>>#qgetParasiteLocation.location#</option>
                            </cfif>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row describe-rw">
                <div class="cust-fld"><label class="fl-lbl"></label>
                </div>
                <div class="cust-inp">
                    <textarea id="top-area" name="pulmonary_textarea" rows="5" cols="50" spellcheck="false">#qgetCetaceanNecropsy.pulmonary_textarea#</textarea>
                </div>
            </div>
        </div>

                       <!--- working start --->
                       <div class="col-lg-5" id="pulmonaryDiv">
                        <div class="cust-row btn-rw startSpinner">
                            <div class="cust-inp cust-inpts">
                                <div class="cust-inp test" id="startPulmonarySpinner">
                                    <input type="file" placeholder="image Path" name="pulmonaryphoto" id="pulmonaryphoto" class="text-field text-fields" accept="image/*">
                                </div>
                                <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="pulmonaryShowPictures()">Upload</button></div>
                            </div>
                        </div>
                    </div>
                    <div class="choose-images">
                        <cfset pulmonaryImgs = ValueList(qgetCetaceanNecropsy.pulmonaryImages,",")>
                            <input type="hidden" name="pulmonaryImagesFile" value="#pulmonaryImgs#" id="pulmonaryImagesFile">
                            <div id="pulmonaryPreviousimages" class="choose-images-detail">
                                <CFIF listLen(pulmonaryImgs)> 
                                    <cfloop list="#pulmonaryImgs#" item="item" index="index">
                    
                                        <span class="pip pipws">
                                            <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                                <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                            </a>
                                            <br/>
                                            <cfif findNoCase("Read only ST", permissions) eq 0>
                                                <span class="remove rms" onclick="pulmonaryImageremove(this)" id="#item#">Remove image</span>
                                            </cfif>
                                        </span>
                                    </cfloop>
                                </cfif>	
                            </div> 
                    </div>
            
                    <!--- working end --->
    </div>
    </div>
    <!--- 9 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">LYMPHORETICULAR SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="LYMPHORETICULAR" id="LYMPHORETICULAR">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.LYMPHORETICULAR') and  qgetCetaceanNecropsy.LYMPHORETICULAR  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.LYMPHORETICULAR') and  qgetCetaceanNecropsy.LYMPHORETICULAR  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
    <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Spleen</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Spleen" id="Spleen">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.Spleen') and  qgetCetaceanNecropsy.Spleen  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.Spleen') and  qgetCetaceanNecropsy.Spleen  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Spleen Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Spleen_Findings" id="Spleen_Findings">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Trauma"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'Trauma'>selected</cfif>>Trauma</option>
                        <option value="Enlarged"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'Enlarged'>selected</cfif>>Enlarged</option>
                        <option value="Masses"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'Masses'>selected</cfif>>Masses</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Spleen_Findings') and  qgetCetaceanNecropsy.Spleen_Findings  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row describe-rw other">
                <!--- <div class="cust-fld"><label class="fl-lbl"></label>
                </div> --->
                <div class="cust-inp">
                    <input type="text" value="#qgetCetaceanNecropsy.lympho_other#"name="lympho_other"placeholder="Other" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <cfif isDefined('qgetLymphoreticular') AND #qgetLymphoreticular.recordcount# gt 0>
            <cfloop query="qgetLymphoreticular">
                <div class="col-lg-12 chako" >
                    <div class="col-lg-5">
                        <div class="cust-row">
                            <div class="cust-fld"><label class="fl-lbl">Lymph Node Present</label>
                            </div>
                            <div class="cust-inp">
                                <select name="lymphnode#qgetLymphoreticular.id#"id="lymphnode"class="stl-op">
                                    <option value="">Select</option>
                                    <cfloop query="qgetLymphNodePresent">
                                        <cfif status eq 1>
                                            <option value="#qgetLymphNodePresent.LymphNodePresent#"<cfif isdefined('qgetLymphoreticular.lymphnode') and  qgetLymphoreticular.lymphnode  eq #qgetLymphNodePresent.LymphNodePresent#>selected</cfif>>#qgetLymphNodePresent.LymphNodePresent#</option>
                                        </cfif>
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="theak"></div>
                    <div class="col-lg-2">
                        <div class="cust-row ingm-rw">
                            <div class="cust-fld"><label class="fl-lbl">Size Length</label>
                            </div>
                            <div class="cust-inp">
                                <input type="text" placeholder="cm" value="#qgetLymphoreticular.nodelength#" id="nodelength" name="nodelength#qgetLymphoreticular.id#"class="text-field">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="cust-row ingm-rw">
                            <div class="cust-fld"><label class="fl-lbl">Width</label>
                            </div>
                            <div class="cust-inp">
                            <input type="text" placeholder="cm"  value="#qgetLymphoreticular.nodewidth#" id="nodewidth" name="nodewidth#qgetLymphoreticular.id#" class="text-field">
                            </div>
                        </div>
                    </div>
                </div>
            </cfloop>
        <cfelse>
            <div class="col-lg-12 chako" >
                <div class="col-lg-5">
                    <div class="cust-row">
                        <div class="cust-fld"><label class="fl-lbl">Lymph Node Present</label>
                        </div>
                        <div class="cust-inp">
                            <select name="lymphnode"id="lymphnode"class="stl-op">
                                <option value="">Select</option>
                                <cfloop query="qgetLymphNodePresent">
                                    <cfif status eq 1>
                                        <option value="#qgetLymphNodePresent.LymphNodePresent#"<cfif isdefined('qgetLymphoreticular.lymphnode') and  qgetLymphoreticular.lymphnode  eq #qgetLymphNodePresent.LymphNodePresent#>selected</cfif>>#qgetLymphNodePresent.LymphNodePresent#</option>
                                    </cfif>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="theak"></div>
                <div class="col-lg-2">
                    <div class="cust-row ingm-rw">
                        <div class="cust-fld"><label class="fl-lbl">Size Length</label>
                        </div>
                        <div class="cust-inp">
                            <input type="text" placeholder="cm" value="#qgetLymphoreticular.nodelength#" name="nodelength"class="text-field">
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="cust-row ingm-rw">
                        <div class="cust-fld"><label class="fl-lbl">Width</label>
                        </div>
                        <div class="cust-inp">
                        <input type="text" placeholder="cm"  value="#qgetLymphoreticular.nodewidth#" name="nodewidth" class="text-field">
                        </div>
                    </div>
                </div>
            </div>
        </cfif>
        
    <div id="newLymph" class="add_new_btn_content"></div>
    <div class="col-lg-12">
        <input type="hidden" name="dynamic_Lymph" value="" id="dynamic_Lymph">
        <input type="button" id="Add_newLymph" name="Add_newLymph" class="upld-btn" value="Add New" onclick="newLymphnode()">
    </div>

    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="lympho_comments" rows="10" cols="120">#qgetCetaceanNecropsy.lympho_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="lympho_phototaken" id="lympho_phototaken" onclick="lymphoPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.lympho_phototaken') and  qgetCetaceanNecropsy.lympho_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
    </div>
                   <!--- working start --->
              <div class="col-lg-5" id="lymphoreticularDiv">
                <div class="cust-row btn-rw startSpinner">
                    <div class="cust-inp cust-inpts">
                        <div class="cust-inp test" id="startLymphoreticularSpinner">
                            <input type="file" placeholder="image Path" name="lymphoreticularphoto" id="lymphoreticularphoto" class="text-field text-fields" accept="image/*">
                        </div>
                        <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="lymphoreticularShowPictures()">Upload</button></div>
                    </div>
                </div>
            </div>
            <div class="choose-images">
                <cfset lymphoreticularImgs = ValueList(qgetCetaceanNecropsy.lymphoreticularImages,",")>
                    <input type="hidden" name="lymphoreticularImagesFile" value="#lymphoreticularImgs#" id="lymphoreticularImagesFile">
                    <div id="lymphoreticularPreviousimages" class="choose-images-detail">
                        <CFIF listLen(lymphoreticularImgs)> 
                            <cfloop list="#lymphoreticularImgs#" item="item" index="index">
            
                                <span class="pip pipws">
                                    <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="lymphoreticularImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                    </div> 
            </div>
    
            <!--- working end --->
    <!--- 10 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">ENDOCRINE SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="ENDOCRINE" id="ENDOCRINE">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.ENDOCRINE') and  qgetCetaceanNecropsy.ENDOCRINE  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.ENDOCRINE') and  qgetCetaceanNecropsy.Spleen  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Adrenal Glands</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Adrenal_Glands" id="Adrenal_Glands">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Adrenal_Glands') and  qgetCetaceanNecropsy.Adrenal_Glands  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Enlarged"<cfif isdefined('qgetCetaceanNecropsy.Adrenal_Glands') and  qgetCetaceanNecropsy.Adrenal_Glands  eq 'Enlarged'>selected</cfif>>Enlarged</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Adrenal_Glands') and  qgetCetaceanNecropsy.Adrenal_Glands  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Left Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text" name="adrenal_leftLength"placeholder="cm" value="#qgetCetaceanNecropsy.adrenal_leftLength#"class="text-field">
                </div>
            </div>
            <div class="cust-row ingm-rw mt-10">
                <div class="cust-fld"><label class="fl-lbl">Right Length</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_rightLength"placeholder="cm" value="#qgetCetaceanNecropsy.adrenal_rightLength#"class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_leftwidth"placeholder="cm" value="#qgetCetaceanNecropsy.adrenal_leftwidth#"class="text-field">
                </div>
            </div>
            <div class="cust-row mt-10">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_rightwidth"placeholder="cm"value="#qgetCetaceanNecropsy.adrenal_rightwidth#" class="text-field">
            </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Thyroid</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Thyroid" id="Thyroid">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Thyroid') and  qgetCetaceanNecropsy.Thyroid  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Enlarged"<cfif isdefined('qgetCetaceanNecropsy.Thyroid') and  qgetCetaceanNecropsy.Thyroid  eq 'Enlarged'>selected</cfif>>Enlarged</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Thyroid') and  qgetCetaceanNecropsy.Thyroid  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text"name="thyroid_length" value="#qgetCetaceanNecropsy.thyroid_length#"placeholder="cm" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="thyroid_width"placeholder="cm"value="#qgetCetaceanNecropsy.thyroid_width#" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Pituitary Gland</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="Pituitary_Gland" id="Pituitary_Gland">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Pituitary_Gland') and  qgetCetaceanNecropsy.Pituitary_Gland  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Enlarged"<cfif isdefined('qgetCetaceanNecropsy.Pituitary_Gland') and  qgetCetaceanNecropsy.Pituitary_Gland  eq 'Enlarged'>selected</cfif>>Enlarged</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Pituitary_Gland') and  qgetCetaceanNecropsy.Pituitary_Gland  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text"name="Pituitary_length" placeholder="cm" value="#qgetCetaceanNecropsy.Pituitary_length#"class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" placeholder="cm" name="Pituitary_width"value="#qgetCetaceanNecropsy.Pituitary_width#"class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5"></div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="endocrine_comments" rows="10" cols="120">#qgetCetaceanNecropsy.endocrine_comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="endocrine_phototaken" id="endocrine_phototaken" onclick="endocrinePhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.endocrine_phototaken') and  qgetCetaceanNecropsy.endocrine_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
    </div>

                  <!--- working start --->
              <div class="col-lg-5" id="endocrineDiv">
                <div class="cust-row btn-rw startSpinner">
                    <div class="cust-inp cust-inpts">
                        <div class="cust-inp test" id="startEndocrineSpinner">
                            <input type="file" placeholder="image Path" name="endocrinephoto" id="endocrinephoto" class="text-field text-fields" accept="image/*">
                        </div>
                        <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="endocrineShowPictures()">Upload</button></div>
                    </div>
                </div>
            </div>
            <div class="choose-images">
                <cfset endocrineImgs = ValueList(qgetCetaceanNecropsy.endocrineImages,",")>
                    <input type="hidden" name="endocrineImagesFile" value="#endocrineImgs#" id="endocrineImagesFile">
                    <div id="endocrinePreviousimages" class="choose-images-detail">
                        <CFIF listLen(endocrineImgs)> 
                            <cfloop list="#endocrineImgs#" item="item" index="index">
            
                                <span class="pip pipws">
                                    <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="endocrineImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                    </div> 
            </div>
    
            <!--- working end --->
    <!--- 11 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">UROGENITAL SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="UROGENITAL" id="UROGENITAL">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL') and  qgetCetaceanNecropsy.UROGENITAL  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.UROGENITAL') and  qgetCetaceanNecropsy.UROGENITAL  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Kidneys Findings LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple" name="Kidney_left" id="Kidney_left">
                            <cfloop from="1" to="#ArrayLen(Kidneys_Findings)#" index="j">
                                <option value="#Kidneys_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.Kidney_left,","),#Kidneys_Findings[j]#)>selected</cfif>>#Kidneys_Findings[j]#</option>
                                
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Kidneys Findings RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box"multiple="multiple" name="Kidney_right" id="Kidney_right">
                            <cfloop from="1" to="#ArrayLen(Kidneys_Findings)#" index="j">
                                <option value="#Kidneys_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.Kidney_right,","),#Kidneys_Findings[j]#)>selected</cfif>>#Kidneys_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-3 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Urinary Bladder</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Urinary_Bladder" id="Urinary_Bladder">
                            <option value="">Select</option>
                            <option value="Empty"<cfif isdefined('qgetCetaceanNecropsy.Urinary_Bladder') and  qgetCetaceanNecropsy.Urinary_Bladder  eq "Empty">selected</cfif>>Empty </option>
                            <option value="Contents"<cfif isdefined('qgetCetaceanNecropsy.Urinary_Bladder') and  qgetCetaceanNecropsy.Urinary_Bladder  eq "Contents">selected</cfif>>Contents</option>
                            
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="urin_volume" value="#qgetCetaceanNecropsy.urin_volume#"placeholder="ml" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-3 mt-10">
                <strong class="strong-position">If Urine Present</strong>
                <div class="cust-row">
                    <div class="cust-fld">  <label class="fl-lbl">  Color</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="UROGENITAL_color" id="UROGENITAL_color">
                            <option value="">Select</option>
                            <option value="Clear"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Clear">selected</cfif>>Clear</option>
                            <option value="Light yellow"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Light yellow">selected</cfif>>Light yellow</option>
                            <option value="Dark yellow"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Dark yellow">selected</cfif>>Dark yellow</option>
                            <option value="Pink - Red"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Pink - Red">selected</cfif>>Pink - Red</option>
                            <option value="Brown"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_color') and  qgetCetaceanNecropsy.UROGENITAL_color  eq "Brown">selected</cfif>>Brown</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Consistancy</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Consistancy" id="Consistancy">
                            <option value="">Select</option>
                            <option value="Clear"<cfif isdefined('qgetCetaceanNecropsy.Consistancy') and  qgetCetaceanNecropsy.Consistancy  eq "Clear">selected</cfif>>Clear</option>
                            <option value="Cloudy"<cfif isdefined('qgetCetaceanNecropsy.Consistancy') and  qgetCetaceanNecropsy.Consistancy  eq "Cloudy">selected</cfif>>Cloudy</option>
                            <option value="Flocculent"<cfif isdefined('qgetCetaceanNecropsy.Consistancy') and  qgetCetaceanNecropsy.Consistancy  eq "Flocculent">selected</cfif>>Flocculent</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Abnormalities</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Abnormalities" id="Abnormalities">
                            <option value="">Select</option>
                            <option value="Mass(es)"<cfif isdefined('qgetCetaceanNecropsy.Abnormalities') and  qgetCetaceanNecropsy.Abnormalities  eq "Flocculent">selected</cfif>>Mass(es)</option>
                            <option value="Parasites"<cfif isdefined('qgetCetaceanNecropsy.Abnormalities') and  qgetCetaceanNecropsy.Abnormalities  eq "Flocculent">selected</cfif>>Parasites</option>
                            <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.Abnormalities') and  qgetCetaceanNecropsy.Abnormalities  eq "Flocculent">selected</cfif>>Other</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Describe</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Abnormalities_describe" value="#qgetCetaceanNecropsy.Abnormalities_describe#"class="text-field">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Reproductive Organs</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Reproductive_Organs" id="Reproductive_Organs">
                            <option value="">Select</option>
                            <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.Reproductive_Organs') and  qgetCetaceanNecropsy.Reproductive_Organs  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.Reproductive_Organs') and  qgetCetaceanNecropsy.Reproductive_Organs  eq 'NE'>selected</cfif>>NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Identified As</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Identified_As" id="Identified_As">
                            <option value="">Select</option>
                            <option value="Penis"<cfif isdefined('qgetCetaceanNecropsy.Identified_As') and  qgetCetaceanNecropsy.Identified_As  eq 'Penis'>selected</cfif>>Penis</option>
                            <option value="Vagina"<cfif isdefined('qgetCetaceanNecropsy.Identified_As') and  qgetCetaceanNecropsy.Identified_As  eq 'Vagina'>selected</cfif>>Vagina</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Lesions</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Lesions" id="Lesions">
                            <option valu="">Select</option>
                            <option valu="Yes"<cfif isdefined('qgetCetaceanNecropsy.Lesions') and  qgetCetaceanNecropsy.Lesions  eq 'Yes'>selected</cfif>>Yes</option>
                            <option valu="No"<cfif isdefined('qgetCetaceanNecropsy.Lesions') and  qgetCetaceanNecropsy.Lesions  eq 'No'>selected</cfif>>No</option>
                            <option value="Unknown"<cfif isdefined('qgetCetaceanNecropsy.Lesions') and  qgetCetaceanNecropsy.Lesions  eq 'Unknown'>selected</cfif>>Unknown</option>
                            
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Gonads Identified as</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Gonads_Identified" id="Gonads_Identified">
                            <option value=" ">Select</option>
                            <option value="Testes"<cfif isdefined('qgetCetaceanNecropsy.Gonads_Identified') and  qgetCetaceanNecropsy.Gonads_Identified  eq 'Testes'>selected</cfif>>Testes </option>
                            <option value=""<cfif isdefined('qgetCetaceanNecropsy.Gonads_Identified') and  qgetCetaceanNecropsy.Gonads_Identified  eq 'Ovaries'>selected</cfif>>Ovaries</option>
                         
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Testes Length LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_Length_LEFT" value="#qgetCetaceanNecropsy.Testes_Length_LEFT#"placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Testes_Length_width"placeholder="cm" value="#qgetCetaceanNecropsy.Testes_Length_width#"class="text-field">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Mammary Glands LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Glands_LEFT" id="Glands_LEFT">
                            <option value="">Select</option>
                            <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Glands_LEFT') and  qgetCetaceanNecropsy.Glands_LEFT  eq "No Findings">selected</cfif>>No Findings </option>
                            <option value="Milk Production"<cfif isdefined('qgetCetaceanNecropsy.Glands_LEFT') and  qgetCetaceanNecropsy.Glands_LEFT  eq 'Milk Production'>selected</cfif>>Milk Production</option>
                            <option value="Abnormal"<cfif isdefined('qgetCetaceanNecropsy.Glands_LEFT') and  qgetCetaceanNecropsy.Glands_LEFT  eq 'Abnormal'>selected</cfif>>Abnormal</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Testes Length RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_Length_right" placeholder="cm" value="#qgetCetaceanNecropsy.Testes_Length_right#" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_width_right" value="#qgetCetaceanNecropsy.Testes_width_right#" placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Mammary Glands RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Glands_RIGHT" id="Glands_RIGHT">
                            <option value="">Select</option>
                            <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.Glands_RIGHT') and  qgetCetaceanNecropsy.Glands_RIGHT  eq 'No Findings'>selected</cfif>>No Findings </option>
                            <option value="Milk Production"<cfif isdefined('qgetCetaceanNecropsy.Glands_RIGHT') and  qgetCetaceanNecropsy.Glands_RIGHT  eq 'Milk Production'>selected</cfif>>Milk Production</option>
                            <option value="Abnormal"<cfif isdefined('qgetCetaceanNecropsy.Glands_RIGHT') and  qgetCetaceanNecropsy.Glands_RIGHT  eq 'Abnormal'>selected</cfif>>Abnormal</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Ovary Length LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ovary_Length_LEFT" placeholder="cm"value="#qgetCetaceanNecropsy.Ovary_Length_LEFT#" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Ovary_Width_LEFT"placeholder="cm" value="#qgetCetaceanNecropsy.Ovary_Width_LEFT#"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row lnth-rw">
                    <div class="cust-fld"><label class="fl-lbl">Follicles Present</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Follicles_Present_Left" id="Follicles_Present_Left">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Follicles_Present_Left') and  qgetCetaceanNecropsy.Follicles_Present_Left  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value="No"<cfif isdefined('qgetCetaceanNecropsy.Follicles_Present_Left') and  qgetCetaceanNecropsy.Follicles_Present_Left  eq 'No'>selected</cfif>>No</option>
                           
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="col-lg-4 mt-10"></div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Ovary Length RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ovary_Length_right" placeholder="cm" value="#qgetCetaceanNecropsy.Ovary_Length_right#" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ovary_width_right" value="#qgetCetaceanNecropsy.Ovary_width_right#" placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row lnth-rw">
                    <div class="cust-fld"><label class="fl-lbl">Follicles Present</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Follicles_Present_right" id="Follicles_Present_right">
                            <option value="">Select</option>
                            <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.Follicles_Present_right') and  qgetCetaceanNecropsy.Follicles_Present_right  eq 'Yes'>selected</cfif>>Yes</option>
                            <option value="No"<cfif isdefined('qgetCetaceanNecropsy.Follicles_Present_right') and  qgetCetaceanNecropsy.Follicles_Present_right  eq 'No'>selected</cfif>>No</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5"></div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="UROGENITAL_Comments" rows="10" cols="120">#qgetCetaceanNecropsy.UROGENITAL_Comments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="UROGENITAL_phototaken" id="UROGENITAL_phototaken" onclick="UROGENITALPhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.UROGENITAL_phototaken') and  qgetCetaceanNecropsy.UROGENITAL_phototaken  eq 'on'>checked</cfif>>
            </div>
        </div>
    </div>
                   <!--- working start --->
              <div class="col-lg-5" id="urogenitalDiv">
                <div class="cust-row btn-rw startSpinner">
                    <div class="cust-inp cust-inpts">
                        <div class="cust-inp test" id="startUrogenitalSpinner">
                            <input type="file" placeholder="image Path" name="urogenitalphoto" id="urogenitalphoto" class="text-field text-fields" accept="image/*">
                        </div>
                        <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="urogenitalShowPictures()">Upload</button></div>
                    </div>
                </div>
            </div>
            <div class="choose-images">
                <cfset urogenitalImgs = ValueList(qgetCetaceanNecropsy.urogenitalImages,",")>
                    <input type="hidden" name="urogenitalImagesFile" value="#urogenitalImgs#" id="urogenitalImagesFile">
                    <div id="urogenitalPreviousimages" class="choose-images-detail">
                        <CFIF listLen(urogenitalImgs)> 
                            <cfloop list="#urogenitalImgs#" item="item" index="index">
            
                                <span class="pip pipws">
                                    <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="urogenitalImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                    </div> 
            </div>
    
            <!--- working end --->
    <!--- 12 --->
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">ALIMENTARY SYSTEM</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="ALIMENTARYSYSTEM" id="ALIMENTARYSYSTEM">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.ALIMENTARYSYSTEM') and  qgetCetaceanNecropsy.ALIMENTARYSYSTEM  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE"<cfif isdefined('qgetCetaceanNecropsy.ALIMENTARYSYSTEM') and  qgetCetaceanNecropsy.ALIMENTARYSYSTEM  eq 'NE'>selected</cfif>>NE</option>
                        <option value="Complete"<cfif isdefined('qgetCetaceanNecropsy.ALIMENTARYSYSTEM') and  qgetCetaceanNecropsy.ALIMENTARYSYSTEM  eq 'Complete'>selected</cfif>>Complete</option>
                        <option value="Partial"<cfif isdefined('qgetCetaceanNecropsy.ALIMENTARYSYSTEM') and  qgetCetaceanNecropsy.ALIMENTARYSYSTEM  eq 'Partial'>selected</cfif>>Partial</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">ESOPHAGUS</h3>
            </div>
            <div class="sys-colum">
                <p>Ulcers/exudate</p>
                <select class="sys-op" name="ESOPHAGUSUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSUlcers') and  qgetCetaceanNecropsy.ESOPHAGUSUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSUlcers') and  qgetCetaceanNecropsy.ESOPHAGUSUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSUlcers') and  qgetCetaceanNecropsy.ESOPHAGUSUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSUlcers') and  qgetCetaceanNecropsy.ESOPHAGUSUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Trauma</p>
                <select class="sys-op" name="ESOPHAGUSTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSTrauma') and  qgetCetaceanNecropsy.ESOPHAGUSTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSTrauma') and  qgetCetaceanNecropsy.ESOPHAGUSTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSTrauma') and  qgetCetaceanNecropsy.ESOPHAGUSTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSTrauma') and  qgetCetaceanNecropsy.ESOPHAGUSTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Masses</p>
                <select class="sys-op" name="ESOPHAGUSMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSMasses') and  qgetCetaceanNecropsy.ESOPHAGUSMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSMasses') and  qgetCetaceanNecropsy.ESOPHAGUSMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSMasses') and  qgetCetaceanNecropsy.ESOPHAGUSMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSMasses') and  qgetCetaceanNecropsy.ESOPHAGUSMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Impaction</p>
                <select class="sys-op" name="ESOPHAGUSImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSImpaction') and  qgetCetaceanNecropsy.ESOPHAGUSImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSImpaction') and  qgetCetaceanNecropsy.ESOPHAGUSImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSImpaction') and  qgetCetaceanNecropsy.ESOPHAGUSImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSImpaction') and  qgetCetaceanNecropsy.ESOPHAGUSImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Obstruction</p>
                <select class="sys-op" name="ESOPHAGUSObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSObstruction') and  qgetCetaceanNecropsy.ESOPHAGUSObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSObstruction') and  qgetCetaceanNecropsy.ESOPHAGUSObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSObstruction') and  qgetCetaceanNecropsy.ESOPHAGUSObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSObstruction') and  qgetCetaceanNecropsy.ESOPHAGUSObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>lntussusception</p>
                <select class="sys-op" name="ESOPHAGUSlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSlntussusception') and  qgetCetaceanNecropsy.ESOPHAGUSlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSlntussusception') and  qgetCetaceanNecropsy.ESOPHAGUSlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSlntussusception') and  qgetCetaceanNecropsy.ESOPHAGUSlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSlntussusception') and  qgetCetaceanNecropsy.ESOPHAGUSlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Parasites</p>
                <select class="sys-op" name="ESOPHAGUSParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSParasites') and  qgetCetaceanNecropsy.ESOPHAGUSParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSParasites') and  qgetCetaceanNecropsy.ESOPHAGUSParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSParasites') and  qgetCetaceanNecropsy.ESOPHAGUSParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.ESOPHAGUSParasites') and  qgetCetaceanNecropsy.ESOPHAGUSParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <p>Other</p>
                <input type="text" class="text-field"value="#qgetCetaceanNecropsy.ESOPHAGUSOther#" name="ESOPHAGUSOther">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="ESOPHAGUSContents" value="#qgetCetaceanNecropsy.ESOPHAGUSContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">FORESTOMACH</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHUlcers') and  qgetCetaceanNecropsy.FORESTOMACHUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHUlcers') and  qgetCetaceanNecropsy.FORESTOMACHUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHUlcers') and  qgetCetaceanNecropsy.FORESTOMACHUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHUlcers') and  qgetCetaceanNecropsy.FORESTOMACHUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHTrauma') and  qgetCetaceanNecropsy.FORESTOMACHTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHTrauma') and  qgetCetaceanNecropsy.FORESTOMACHTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHTrauma') and  qgetCetaceanNecropsy.FORESTOMACHTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHTrauma') and  qgetCetaceanNecropsy.FORESTOMACHTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHMasses') and  qgetCetaceanNecropsy.FORESTOMACHMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHMasses') and  qgetCetaceanNecropsy.FORESTOMACHMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHMasses') and  qgetCetaceanNecropsy.FORESTOMACHMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHMasses') and  qgetCetaceanNecropsy.FORESTOMACHMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHImpaction') and  qgetCetaceanNecropsy.FORESTOMACHImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHImpaction') and  qgetCetaceanNecropsy.FORESTOMACHImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHImpaction') and  qgetCetaceanNecropsy.FORESTOMACHImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHImpaction') and  qgetCetaceanNecropsy.FORESTOMACHImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHObstruction') and  qgetCetaceanNecropsy.FORESTOMACHObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHObstruction') and  qgetCetaceanNecropsy.FORESTOMACHObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHObstruction') and  qgetCetaceanNecropsy.FORESTOMACHObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHObstruction') and  qgetCetaceanNecropsy.FORESTOMACHObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHlntussusception') and  qgetCetaceanNecropsy.FORESTOMACHlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHlntussusception') and  qgetCetaceanNecropsy.FORESTOMACHlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHlntussusception') and  qgetCetaceanNecropsy.FORESTOMACHlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHlntussusception') and  qgetCetaceanNecropsy.FORESTOMACHlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHParasites') and  qgetCetaceanNecropsy.FORESTOMACHParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHParasites') and  qgetCetaceanNecropsy.FORESTOMACHParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHParasites') and  qgetCetaceanNecropsy.FORESTOMACHParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.FORESTOMACHParasites') and  qgetCetaceanNecropsy.FORESTOMACHParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="FORESTOMACHOther"value="#qgetCetaceanNecropsy.FORESTOMACHOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="FORESTOMACHContents"value="#qgetCetaceanNecropsy.FORESTOMACHContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">GLANDULAR STOMACH</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers') and  qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers') and  qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers') and  qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers') and  qgetCetaceanNecropsy.GLANDULARSTOMACHUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma') and  qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma') and  qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma') and  qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma') and  qgetCetaceanNecropsy.GLANDULARSTOMACHTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHMasses') and  qgetCetaceanNecropsy.GLANDULARSTOMACHMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHMasses') and  qgetCetaceanNecropsy.GLANDULARSTOMACHMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHMasses') and  qgetCetaceanNecropsy.GLANDULARSTOMACHMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHMasses') and  qgetCetaceanNecropsy.GLANDULARSTOMACHMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction') and  qgetCetaceanNecropsy.GLANDULARSTOMACHObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception') and  qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception') and  qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception') and  qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception') and  qgetCetaceanNecropsy.GLANDULARSTOMACHlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHParasites') and  qgetCetaceanNecropsy.GLANDULARSTOMACHParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHParasites') and  qgetCetaceanNecropsy.GLANDULARSTOMACHParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHParasites') and  qgetCetaceanNecropsy.GLANDULARSTOMACHParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.GLANDULARSTOMACHParasites') and  qgetCetaceanNecropsy.GLANDULARSTOMACHParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="GLANDULARSTOMACHOther" value="#qgetCetaceanNecropsy.GLANDULARSTOMACHOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="GLANDULARSTOMACHContents" value="#qgetCetaceanNecropsy.GLANDULARSTOMACHContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">PYLORUS</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSUlcers') and  qgetCetaceanNecropsy.PYLORUSUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSUlcers') and  qgetCetaceanNecropsy.PYLORUSUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSUlcers') and  qgetCetaceanNecropsy.PYLORUSUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSUlcers') and  qgetCetaceanNecropsy.PYLORUSUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSTrauma') and  qgetCetaceanNecropsy.PYLORUSTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSTrauma') and  qgetCetaceanNecropsy.PYLORUSTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSTrauma') and  qgetCetaceanNecropsy.PYLORUSTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSTrauma') and  qgetCetaceanNecropsy.PYLORUSTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSMasses') and  qgetCetaceanNecropsy.PYLORUSMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSMasses') and  qgetCetaceanNecropsy.PYLORUSMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSMasses') and  qgetCetaceanNecropsy.PYLORUSMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSMasses') and  qgetCetaceanNecropsy.PYLORUSMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSImpaction') and  qgetCetaceanNecropsy.PYLORUSImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSImpaction') and  qgetCetaceanNecropsy.PYLORUSImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSImpaction') and  qgetCetaceanNecropsy.PYLORUSImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSImpaction') and  qgetCetaceanNecropsy.PYLORUSImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSObstruction') and  qgetCetaceanNecropsy.PYLORUSObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSObstruction') and  qgetCetaceanNecropsy.PYLORUSObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSObstruction') and  qgetCetaceanNecropsy.PYLORUSObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSObstruction') and  qgetCetaceanNecropsy.PYLORUSObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSlntussusception') and  qgetCetaceanNecropsy.PYLORUSlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSlntussusception') and  qgetCetaceanNecropsy.PYLORUSlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSlntussusception') and  qgetCetaceanNecropsy.PYLORUSlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSlntussusception') and  qgetCetaceanNecropsy.PYLORUSlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSParasites') and  qgetCetaceanNecropsy.PYLORUSParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSParasites') and  qgetCetaceanNecropsy.PYLORUSParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSParasites') and  qgetCetaceanNecropsy.PYLORUSParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.PYLORUSParasites') and  qgetCetaceanNecropsy.PYLORUSParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="PYLORUSOther"value="#qgetCetaceanNecropsy.PYLORUSOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="PYLORUSContents" value="#qgetCetaceanNecropsy.PYLORUSContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">SMALL INTESTINE</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEUlcers') and  qgetCetaceanNecropsy.SMALLINTESTINEUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEUlcers') and  qgetCetaceanNecropsy.SMALLINTESTINEUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEUlcers') and  qgetCetaceanNecropsy.SMALLINTESTINEUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEUlcers') and  qgetCetaceanNecropsy.SMALLINTESTINEUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINETrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINETrauma') and  qgetCetaceanNecropsy.SMALLINTESTINETrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINETrauma') and  qgetCetaceanNecropsy.SMALLINTESTINETrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINETrauma') and  qgetCetaceanNecropsy.SMALLINTESTINETrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINETrauma') and  qgetCetaceanNecropsy.SMALLINTESTINETrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEMasses') and  qgetCetaceanNecropsy.SMALLINTESTINEMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEMasses') and  qgetCetaceanNecropsy.SMALLINTESTINEMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEMasses') and  qgetCetaceanNecropsy.SMALLINTESTINEMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEMasses') and  qgetCetaceanNecropsy.SMALLINTESTINEMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEImpaction') and  qgetCetaceanNecropsy.SMALLINTESTINEImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEImpaction') and  qgetCetaceanNecropsy.SMALLINTESTINEImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEImpaction') and  qgetCetaceanNecropsy.SMALLINTESTINEImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEImpaction') and  qgetCetaceanNecropsy.SMALLINTESTINEImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEObstruction') and  qgetCetaceanNecropsy.SMALLINTESTINEObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEObstruction') and  qgetCetaceanNecropsy.SMALLINTESTINEObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEObstruction') and  qgetCetaceanNecropsy.SMALLINTESTINEObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEObstruction') and  qgetCetaceanNecropsy.SMALLINTESTINEObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINElntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINElntussusception') and  qgetCetaceanNecropsy.SMALLINTESTINElntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINElntussusception') and  qgetCetaceanNecropsy.SMALLINTESTINElntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINElntussusception') and  qgetCetaceanNecropsy.SMALLINTESTINElntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINElntussusception') and  qgetCetaceanNecropsy.SMALLINTESTINElntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEParasites') and  qgetCetaceanNecropsy.SMALLINTESTINEParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEParasites') and  qgetCetaceanNecropsy.SMALLINTESTINEParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEParasites') and  qgetCetaceanNecropsy.SMALLINTESTINEParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.SMALLINTESTINEParasites') and  qgetCetaceanNecropsy.SMALLINTESTINEParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="SMALLINTESTINEOther"value="#qgetCetaceanNecropsy.SMALLINTESTINEOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="SMALLINTESTINEContents"value="#qgetCetaceanNecropsy.SMALLINTESTINEContents#">
            </div>
        </div>
    </div>
    <div class="systum-sec">
        <div class="systum-row">
            <div class="sys-colum clm-15">
                <h3 class="sys-title">COLON</h3>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONUlcers">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONUlcers') and  qgetCetaceanNecropsy.COLONUlcers  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONUlcers') and  qgetCetaceanNecropsy.COLONUlcers  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONUlcers') and  qgetCetaceanNecropsy.COLONUlcers  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONUlcers') and  qgetCetaceanNecropsy.COLONUlcers  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONTrauma">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONTrauma') and  qgetCetaceanNecropsy.COLONTrauma  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONTrauma') and  qgetCetaceanNecropsy.COLONTrauma  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONTrauma') and  qgetCetaceanNecropsy.COLONTrauma  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONTrauma') and  qgetCetaceanNecropsy.COLONTrauma  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONMasses">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONMasses') and  qgetCetaceanNecropsy.COLONMasses  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONMasses') and  qgetCetaceanNecropsy.COLONMasses  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONMasses') and  qgetCetaceanNecropsy.COLONMasses  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONMasses') and  qgetCetaceanNecropsy.COLONMasses  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONImpaction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONImpaction') and  qgetCetaceanNecropsy.COLONImpaction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONImpaction') and  qgetCetaceanNecropsy.COLONImpaction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONImpaction') and  qgetCetaceanNecropsy.COLONImpaction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONImpaction') and  qgetCetaceanNecropsy.COLONImpaction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONObstruction">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONObstruction') and  qgetCetaceanNecropsy.COLONObstruction  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONObstruction') and  qgetCetaceanNecropsy.COLONObstruction  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONObstruction') and  qgetCetaceanNecropsy.COLONObstruction  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONObstruction') and  qgetCetaceanNecropsy.COLONObstruction  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONlntussusception">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONlntussusception') and  qgetCetaceanNecropsy.COLONlntussusception  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONlntussusception') and  qgetCetaceanNecropsy.COLONlntussusception  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONlntussusception') and  qgetCetaceanNecropsy.COLONlntussusception  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONlntussusception') and  qgetCetaceanNecropsy.COLONlntussusception  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONParasites">
                    <option value="">Select</option>
                    <option value=">5%"<cfif isdefined('qgetCetaceanNecropsy.COLONParasites') and  qgetCetaceanNecropsy.COLONParasites  eq '>5%'>selected</cfif>>>5%</option>
                    <option value="5-25%"<cfif isdefined('qgetCetaceanNecropsy.COLONParasites') and  qgetCetaceanNecropsy.COLONParasites  eq '5-25%'>selected</cfif>>5-25%</option>
                    <option value="25-50%"<cfif isdefined('qgetCetaceanNecropsy.COLONParasites') and  qgetCetaceanNecropsy.COLONParasites  eq '25-50%'>selected</cfif>>25-50%</option>
                    <option value=">50%"<cfif isdefined('qgetCetaceanNecropsy.COLONParasites') and  qgetCetaceanNecropsy.COLONParasites  eq '>50%'>selected</cfif>>>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="COLONOther"value="#qgetCetaceanNecropsy.COLONOther#">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="COLONContents"value="#qgetCetaceanNecropsy.COLONContents#">
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">PANCREAS</h3></div></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="PANCREAS" id="PANCREAS">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.PANCREAS') and  qgetCetaceanNecropsy.PANCREAS  eq 'Examined'>selected</cfif>>Examined</option>
                        <option value="NE" <cfif isdefined('qgetCetaceanNecropsy.PANCREAS') and  qgetCetaceanNecropsy.PANCREAS  eq 'NE'>selected</cfif>>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Pancreas Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="PancreasFindings" id="PancreasFindings">
                        <option value="">Select</option>
                        <option value="No Findings"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'No Findings'>selected</cfif>>No Findings</option>
                        <option value="Trauma"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'Trauma'>selected</cfif>>Trauma</option>
                        <option value="Masses"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'Masses'>selected</cfif>>Masses</option>
                        <option value="Engorged"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'Engorged'>selected</cfif>>Engorged</option>
                        <option value="Other"<cfif isdefined('qgetCetaceanNecropsy.PancreasFindings') and  qgetCetaceanNecropsy.PancreasFindings  eq 'Other'>selected</cfif>>Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                <!--- <div class="cust-fld"><label class="fl-lbl">Describe</label>
                </div> --->
                <div class="cust-inp">
                    <input type="text" placeholder="Other" class="text-field" name="PANCREASOthers"value="#qgetCetaceanNecropsy.PANCREASOthers#">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">GI FOREIGN MATERIAL</h3></div></label>
                </div>
                 <div class="cust-inp">
                    <select class="stl-op" name="GIFOREIGNMATERIAL" id="GIFOREIGNMATERIAL">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.GIFOREIGNMATERIAL') and  qgetCetaceanNecropsy.GIFOREIGNMATERIAL  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value="No"<cfif isdefined('qgetCetaceanNecropsy.GIFOREIGNMATERIAL') and  qgetCetaceanNecropsy.GIFOREIGNMATERIAL  eq 'No'>selected</cfif>>No</option>
                    </select>
                    <!---<select class="stl-op search-box" multiple="multiple" name=" GIFOREIGNMATERIAL" id="GIFOREIGNMATERIAL">
                       
                        <cfloop query="qGIForeignMaterial">
                            <cfif status eq 1 >
                                <option value="#qGIForeignMaterial.GIForeignMaterial#"<cfif ListFind(ValueList(qgetCetaceanNecropsy.GIFOREIGNMATERIAL,","),#qGIForeignMaterial.GIForeignMaterial#)>selected</cfif>>#qGIForeignMaterial.GIForeignMaterial#</option>
                            </cfif>
                        </cfloop>
                    </select>--->
                </div> 
            </div>
        </div>
        <div class="col-lg-2">
                <div class="just-fld"><label class="fl-lbl">If Yes, see below</label>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row material-rw">
                <div class="cust-fld"><label class="fl-lbl">Injury/Lesion Associated with Foreign Material</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="InjuryLesionAssociated" id="InjuryLesionAssociated">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.InjuryLesionAssociated') and  qgetCetaceanNecropsy.InjuryLesionAssociated  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value="No"<cfif isdefined('qgetCetaceanNecropsy.InjuryLesionAssociated') and  qgetCetaceanNecropsy.InjuryLesionAssociated  eq 'No'>selected</cfif>>No</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="sys-comment-row mt-20 btm-sec">
        <div class="sys-colum-left">
            <h3 class="sys-title">Describe</h3>
        </div>
        <div class="sys-colum-right">
            <textarea id="top-area" name="InjuryLesionAssociatedContents" rows="10" cols="120">#qgetCetaceanNecropsy.InjuryLesionAssociatedContents#</textarea>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl">GI Foreign Material Type</label>
                </div>
                <div class="cust-inp ">
                    <!--- <select class="stl-op search-box" multiple="multiple" name="GIForeignMaterialType" id="GIForeignMaterialType" >
                       <option value="">Select</option>
                        <cfloop array="#material_type#" item="item" index="j">
                            <option value="#item#" <cfif isdefined('qgetCetaceanNecropsy.GIForeignMaterialType') and  qgetCetaceanNecropsy.GIForeignMaterialType  eq #item#>selected</cfif>>#item#</option>
                            
                        </cfloop>
                    </select> --->

                    <select class="stl-op search-box" multiple="multiple" name="GIForeignMaterialType" id="GIForeignMaterialType">
                        <cfloop from="1" to="#ArrayLen(material_type)#" index="j">
                            <option value="#material_type[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.GIForeignMaterialType,","),#material_type[j]#)>selected</cfif>
                                >#material_type[j]#</option>
                        </cfloop>
                    </select>

                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Material Lesion Location</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field" name="MaterialLesionLocation" value="#qgetCetaceanNecropsy.MaterialLesionLocation#">
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 material">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl">Material Collected</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="MaterialCollected" id="MaterialCollected">
                        <option value="">Select</option>
                        <option value="Yes"<cfif isdefined('qgetCetaceanNecropsy.MaterialCollected') and  qgetCetaceanNecropsy.MaterialCollected  eq 'Yes'>selected</cfif>>Yes</option>
                        <option value="No"<cfif isdefined('qgetCetaceanNecropsy.MaterialCollected') and  qgetCetaceanNecropsy.MaterialCollected  eq 'No'>selected</cfif>>No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-6 ">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Disposition of Material Collected</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field" name="DispositionofMaterialCollected"value="#qgetCetaceanNecropsy.DispositionofMaterialCollected#">
                </div>
            </div>
        </div>
    </div>
    <!--- AND #report# neq '' AND #report# neq 'emptys' --->
    <cfif isDefined('qgetParasites') AND #qgetParasites.recordcount# gt 0>
        <input type="hidden" id="Dynamicparasites" value="#qgetParasites.recordcount#" name="counting">
        <cfloop query="qgetParasites">
            <div class="col-lg-12 parasitediv ">
                <div class="col-lg-4">
                    <div class="cust-row btm-rw">
                        <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">PARASITES</h3></div></label>
                        </div>
                        <div class="cust-inp">
                            <select class="stl-op" name="PARASITES#qgetParasites.id#" id="PARASITES">
                                <!--- <option value="">Select</option> --->
                                <option value="Yes"<cfif isdefined('qgetParasites.PARASITES') and  qgetParasites.PARASITES  eq 'Yes'>selected</cfif>>Yes</option>
                                <option value="No"<cfif isdefined('qgetParasites.PARASITES') and  qgetParasites.PARASITES  eq 'No'>selected</cfif>>No</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="cust-row">
                        <div class="cust-fld"><label class="fl-lbl">Parasite Type</label>
                        </div>
                        <div class="cust-inp">
                            <select class="stl-op" name="ParasiteType#qgetParasites.id#" id="ParasiteType">
                                
                                <cfloop query="qgetParasiteType">
                                    <cfif status eq 1 >
                                        <option value="#qgetParasiteType.type#"<cfif isdefined('qgetParasites.ParasiteType') and  qgetParasites.ParasiteType  eq #qgetParasiteType.type#>selected</cfif>>#qgetParasiteType.type#</option>
                                    </cfif>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="cust-row describe-rw">
                        <div class="cust-fld"><label class="fl-lbl">Location</label>
                        </div>
                        <div class="cust-inp">
                            <select class="stl-op" name="Parasitelocation#qgetParasites.id#" id="Parasitelocation">
                                <cfloop query="qgetParasiteLocation">
                                    <cfif status eq 1 >
                                        <option value="#qgetParasiteLocation.location#"<cfif isdefined('qgetParasites.Parasitelocation') and  qgetParasites.Parasitelocation  eq #qgetParasiteLocation.location#>selected</cfif>>#qgetParasiteLocation.location#</option>
                                    </cfif>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </cfloop>
    <cfelse>
        <div class="col-lg-12 parasitediv ">
            <div class="col-lg-4">
                <div class="cust-row btm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">PARASITES</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="PARASITES" id="PARASITES">
                            <option value="">Select</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Parasite Type</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ParasiteType" id="ParasiteType">
                            <cfloop query="qgetParasiteType">
                                <cfif status eq 1 >
                                    <option value="#qgetParasiteType.type#">#qgetParasiteType.type#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="cust-row describe-rw">
                    <div class="cust-fld"><label class="fl-lbl">Location</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="Parasitelocation" id="Parasitelocation">
                            <cfloop query="qgetParasiteLocation">
                                <cfif status eq 1 >
                                    <option value="#qgetParasiteLocation.location#">#qgetParasiteLocation.location#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </cfif>
    <div  id="newparasite"></div>
    <div class="col-lg-12">
        <div class="simple-button pt-15 align-right">
            <input type="hidden" name="dynamic_parasite" value="" id="dynamic_parasite">
            <input type="button" id="Add_newparasite" name="Add_newparasite" class="upld-btn" value="Add New" onclick="newparasite()">
        </div>
    </div>
    </div>
    <div class="row">
    <div class="col-lg-12">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="Parasitecomments" rows="10" cols="120">#qgetCetaceanNecropsy.Parasitecomments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="Parasite_phototaken" id="Parasite_phototaken" onclick="ParasitePhoto()" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.Parasite_phototaken') and  qgetCetaceanNecropsy.Parasite_phototaken  eq 'on'>checked</cfif>
                >
            </div>
        </div>
    </div>
               <!--- working start --->
              <div class="col-lg-5" id="alimentaryphotoDiv">
                <div class="cust-row btn-rw startSpinner">
                    <div class="cust-inp cust-inpts">
                        <div class="cust-inp test" id="startAlimentarySpinner">
                            <input type="file" placeholder="image Path" name="alimentaryphoto" id="alimentaryphoto" class="text-field text-fields" accept="image/*">
                        </div>
                        <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="alimentaryShowPictures()">Upload</button></div>
                    </div>
                </div>
            </div>
            <div class="choose-images">
                <cfset alimentaryImgs = ValueList(qgetCetaceanNecropsy.alimentaryImages,",")>
                    <input type="hidden" name="alimentaryImagesFile" value="#alimentaryImgs#" id="alimentaryImagesFile">
                    <div id="alimentaryPreviousimages" class="choose-images-detail">
                        <CFIF listLen(alimentaryImgs)> 
                            <cfloop list="#alimentaryImgs#" item="item" index="index">
            
                                <span class="pip pipws">
                                    <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                        <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                    </a>
                                    <br/>
                                    <cfif findNoCase("Read only ST", permissions) eq 0>
                                        <span class="remove rms" onclick="alimentaryImageremove(this)" id="#item#">Remove image</span>
                                    </cfif>
                                </span>
                            </cfloop>
                        </cfif>	
                    </div> 
            </div>
    
            <!--- working end --->
    <!-- 13 -->
    <div class="row pt-30">
    <div class="">
        <div class="mrb-40">
            <label class="fl-lbl">
                <div class="mid-t">
                    <h3 class="m-0">CENTRAL NERVOUS SYSTEM</h3>
                </div>
            </label>
        </div>
    </div>
    <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld">
                    <label class="fl-lbl">Brain</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CENTRALbrain" id="">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.CENTRALbrain') and  qgetCetaceanNecropsy.CENTRALbrain  eq "Examined">selected</cfif>
                            >Examined</option>
                        <option value="NE"<cfif isdefined('qgetCetaceanNecropsy.CENTRALbrain') and  qgetCetaceanNecropsy.CENTRALbrain  eq 'NE'>selected</cfif>
                            >NE</option>
                        <option value="Partial Examined"<cfif isdefined('qgetCetaceanNecropsy.CENTRALbrain') and  qgetCetaceanNecropsy.CENTRALbrain  eq "Partial Examined">selected</cfif>
                            >Partial Examined</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Brain Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op search-box" multiple="multiple" name="CENTRALBrainFindings" id="CENTRALBrainFindings">
                        <cfloop from="1" to="#ArrayLen(brain_Findings)#" index="j">
                            <option value="#brain_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.CENTRALBrainFindings,","),#brain_Findings[j]#)>selected</cfif>
                                >#brain_Findings[j]#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                
                <div class="cust-inp">
                    <input type="text"name="brainother" value="#qgetCetaceanNecropsy.brainother#"placeholder="Other" class="text-field">
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 mt-10">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl">Spinal Cord</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CENTRALSpinalCord" id="">
                        <option value="">Select</option>
                        <option value="Examined"<cfif isdefined('qgetCetaceanNecropsy.CENTRALSpinalCord') and  qgetCetaceanNecropsy.CENTRALSpinalCord  eq "Examined">selected</cfif>
                            >Examined</option>
                        <option value="NE"<cfif isdefined('qgetCetaceanNecropsy.CENTRALSpinalCord') and  qgetCetaceanNecropsy.CENTRALSpinalCord  eq 'NE'>selected</cfif>
                            >NE</option>
                        <option value="Partial Examined"<cfif isdefined('qgetCetaceanNecropsy.CENTRALSpinalCord') and  qgetCetaceanNecropsy.CENTRALSpinalCord  eq "Partial Examined">selected</cfif>
                            >Partial Examined</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Spinal Cord Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op search-box" multiple="multiple" name="CENTRALSpinalCordfinding" id="CENTRALSpinalCordfinding">
                        <cfloop from="1" to="#ArrayLen(brain_Findings)#" index="j">
                            <option value="#brain_Findings[j]#" <cfif ListFind(ValueList(qgetCetaceanNecropsy.CENTRALSpinalCordfinding,","),#brain_Findings[j]#)>selected</cfif>
                                >#brain_Findings[j]#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                
                <div class="cust-inp">
                    <input type="text"name="spinalother" placeholder="Other" value="#qgetCetaceanNecropsy.spinalother#"class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-20">
        <div class="col-lg-5"></div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="nervoussystemcomments" rows="10" cols="120" spellcheck="false">#qgetCetaceanNecropsy.nervoussystemcomments#</textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="nervoussystemphototaken" onclick="centralNervous()" id="centralNervousCheck" class="check-bxt-fld"<cfif isdefined('qgetCetaceanNecropsy.nervoussystemphototaken') and  qgetCetaceanNecropsy.nervoussystemphototaken  eq 'on'>checked</cfif>
                >
            </div>

            <!--- working start --->
            





    
            <!--- working end --->
            




        </div>
        <div class="col-lg-5" id="centralNervousdiv">
            <div class="cust-row btn-rw startSpinner">
                <div class="cust-inp cust-inpts">
                    <div class="cust-inp test" id="startCentralNervousSpinner">
                        <input type="file" placeholder="image Path" name="centralNervousphoto" id="centralNervousphoto" class="text-field text-fields" accept="image/*">
                    </div>
                    <div class="cust-fld"><button class="upld-btn upld-btns" type="button" onclick="centralNervousShowPictures()">Upload</button></div>
                </div>
            </div>
        </div>
        <div class="choose-images">
            <cfset centralNervousImgs = ValueList(qgetCetaceanNecropsy.centralNervousImages,",")>
                <input type="hidden" name="centralNervousImagesFile" value="#centralNervousImgs#" id="centralNervousImagesFile">
                <div id="centralNervousPreviousimages" class="choose-images-detail">
                    <CFIF listLen(centralNervousImgs)> 
                        <cfloop list="#centralNervousImgs#" item="item" index="index">
        
                            <span class="pip pipws">
                                <a class="imag" data-toggle="modal" data-target="##myModal" href="##" title="#Application.CloudRoot##item#" target="blank">
                                    <img  class="imageThumb image-fluid imag" style="width: 100%;"  src="http://cloud.wildfins.org/#item#" title="#item#" onclick="selected(this)"/>
                                </a>
                                <br/>
                                <cfif findNoCase("Read only ST", permissions) eq 0>
                                    <span class="remove rms" onclick="centralNervousImageremove(this)" id="#item#">Remove image</span>
                                </cfif>
                            </span>
                        </cfloop>
                    </cfif>	
                </div>
            
        </div>

        <div class="col-lg-6 sd-btns">
            <input type="hidden" value="" id="dropdownvalues">
                <button type="submit" value="Save"  id="savebutton" name="save" class="btn btn-success btn-save">Save</button>
                <cfif isDefined('qgetCetaceanNecropsy.ID') and qgetCetaceanNecropsy.ID neq "">
                    <input type="submit" id="delete_btn" name="delete" class="btn btn-oRangem-rl-4 btn-del" value="Delete" onclick="if(confirm('Are you sure to Delete ?')){}else{return false;};">
                </cfif>
                <cfif (permissions eq "full_access")>
                    <input  type="submit" id="deletCetaceanNecropsyAllRecord" name="deletCetaceanNecropsyAllRecord" class="btn btn-oRangem-rl-4 btn-del" value="Delete All Records" onclick="if(confirm('Are you sure to Delete all Records?')){}else{return false;};">
                </cfif>
        </div>

        
    </div>
    </form> 
    </div>
    </div>

    </div>
    </cfoutput>

    <style>
        strong.strong-position {
    position: absolute;
    top: -30px;
    font-size: 16px;
}
    .choose-images .choose-images-detail {
        display: flex;
        width: 100%;
        padding: 20px 10px 0;
    }
    .choose-images .choose-images-detail .pip {
        width: 150px;
        margin-right: 15px;
    }
    .imageTh {
        height: 80px !important;
        width: 80px !important;
    }

    .rem {
        font-size: 8px !important;
        width: 80px !important;
    }

    .pipw {
        width: 17% !important;
    }


    .imgsw {
        width: 805px !important;
    }


    .rms {
        width: 150px;
    }

    .inps {
        display: flex !important;
        flex-direction: row;
        width: 82% !important;
    }

    .cst-rows {
        flex-direction: column;
    }

    .imag {
        object-fit: cover !important;
        height: 160px !important;
        width: 150px !important;
    }

    .cust-inpts {
        display: flex !important;
        width: 75% !important;
    }

    .btn-save {
        margin-top: 10px;
        /* margin-left: 500px !important; */
    }

    .btn-del {
        margin-top: 10px !important;
    }

    .sd-btns {
        width: 60%;
        float: right;
    }

    .select2.select2-container.select2-container--default {
        width: 100% !important;
    }

    .appnd {
        margin-left: 12px;
    }

    .input-label {
        padding: 5px;
        width: 54% !important;
        margin-right: 5px;
    }

    @media (max-width: 1200px) {
        .nflex {
            display: flex;
            flex-wrap: wrap;
        }

        .input-label {
            margin-right: 1px !important;
            width: 75% !important;
            margin-left: auto;
            margin-bottom: 15px;
        }
    }

    @media (max-width: 850px) {
        .input-label {
            width: 70% !important;
        }
    }

    @media (max-width: 600px) {
        .input-label {
            width: 100% !important;
        }
    }

    @media (max-width : 1200px) {
        .appnd {
            margin-left: 0px;
        }
    }

    @media (max-width: 575px) {
        .sd-btns {
            width: 68% !important;
        }
    }

    @media (max-width: 1500px) {
        .inps {
            width: 85% !important;
        }
    }

    @media (max-width: 1463px) {
        .inps {
            width: 90% !important;
        }
    }

    @media (max-width: 1439px) {
        .cust-inpts {
            width: 100% !important;
        }

        .inps {
            width: 115% !important;
        }
    }

    .cust-inpst {
        width: 78% !important;
    }

    @media (max-width: 767px) {
        .cust-inpts {
            width: 90% !important;
        }

        .cust-inpst {
            width: 93% !important;
        }
    }

    @media (max-width: 575px) {
        .upld-btns {
            font-size: 7px !important; 
        }

        .text-fields {
            font-size: 6px !important;
            padding: 2px !important;
        }
    }

    .cust-inptsi {
        display: flex !important;
    }

    .cust-inptsii {
        width: 32% !important;
    }

    .imgexs {
        margin-left: 25px;
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
    .pt-30{
    padding-top: 30px;
    }
    .pt-20{
    padding-top: 20px;
    }
    .pt-15{
    padding-top: 15px;
    }
    .mt-100{
    margin-top: 100px;
    }
    .mt-20{
    margin-top: 20px;
    }
    .mt-15{
    margin-top: 15px;
    }
    .mt-10{
    margin-top: 10px;
    }
    .mt-0{
    margin: 0px;
    }
    .align-right{
        text-align: right;
    }
    .mrb-40 {
        margin-bottom: 40px;
    }
    div#newparasite .col-lg-12 {
        padding: 0 10px;
    }
    .top-sec {
        background-color: #add8e6;
        padding: 20px 15px;
    }
    .cust-row {
        display: flex;
    }
    .cust-fld {
        width: 35%;
        margin-top: auto;
        margin-bottom: auto;
    }
    .cust-inp {
        width: 65%;
    }
    .cust-row .fl-lbl {
        font-size: 16px;
    }
    .cust-inp select {
        width: 100%;
        display: block;
        padding: 6px;
        font-size: 15px;
        border: 1px solid;
    }
    .text-field {
        padding: 6px;
        width: 100%;
        border: 1px solid;
    }
    .cust-inp select option{
        font-size: 15px;
    }
    input.check-bxt-fld {
        width: 17px;
        height: 17px;
        border: 0;
        border-radius: 0;
    }
    label.check-cust-fld {
        margin: 0;
        font-size: 16px;
        position: relative;
        bottom: 2px;
    }
    .check-fld {
        width: 26%;
        margin-top: auto;
    }
    .cust-row .check-bx {
        width: 16%;
        margin-top: auto;
    }
    .cust-row .check-ipt {
        width: 42%;
    }
    .panel-rw .cust-fld {
        width: 14%;
        margin-right: 4px;
    }
    .fldarea .fl-lbl {
        display: block;
        font-size: 16px;
    }
    .fldarea #top-area {
        display: block;
        width: 100%;
        height: 170px;
        border: 1px solid;
    }
    .sec-two {
        padding: 20px 15px;
    }
    .btn-rw .cust-fld {
        margin-left: 25px;
        margin-bottom: auto;
    }
    .upld-btn {
        font-size: 15px;
        padding: 4px 12px;
        background: #17B6A4;
        border: 0;
        color: #fff;
    }
    /* .smp-btn {
        text-decoration: none;
        font-size: 15px;
        font-style: normal;
        font-weight: 400;
        padding: 5px 30px;
        background-color: #4472c4;
        color: #FFF;
        border: 0;
    } */
    .linkhisto{
        background-color: #4472c4;
        color: white;
        padding: 14px 25px;
        font-size: 15px;
        font-style: normal;
        font-weight: 400;
        text-align: center;
        text-decoration: none;
        display: inline-block;
    }
    .linkhisto:hover, .linkhisto:active {
        background-color: #4472c4;
        color: white;
    }
    .linkcetacean{
        background-color: #4472c4;
        color: white;
        padding: 14px 25px;
        font-size: 15px;
        font-style: normal;
        font-weight: 400;
        text-align: center;
        text-decoration: none;
        display: inline-block;
    }
    .linkcetacean:hover, .linkcetacean:active {
        background-color: #4472c4;
        color: white;
    }
    .full-img-sec {
        padding: 20px 15px;
        background-color: #efefef;
    }
    .img-group img {
        width: 100%;
    }
    .right-fld {
        width: 30%;
        margin-top: auto;
        margin-bottom: auto;
    }
    .right-inp {
        width: 40%;
        margin-right: 15px;
    }
    .cust-row.mid-dorsal .cust-fld {
        width: 45%;
    }
    .cust-row.mid-dorsal .cust-fld {
        width: 55%;
    }
    .sec-title h2 {
        font-size: 30px;
        color: #02254b;
        margin: 0;
    }
    .sec-title {
        position: relative;
    }
    .sec-title span {
        background: #02254b;
        display: block;
        width: 78%;
        height: 3px;
        position: absolute;
        top: 15px;
        right: 12px;
    }
    .examination-sec {
        padding: 20px;
    }
    .exam-rw .cust-fld {
        width: 21.5%;
    }
    .ingm-rw .cust-fld {
        width: 50%;
    }
    /* .cust-inp {
        width: 50%;
    } */
    .fl-lbl {
        font-size: 16px;
    }
    .mid-t h3 {
        font-size: 20px;
        color: #02254b;
        font-weight: 500;
    }
    .material{
        margin-top: 10px;
        margin-bottom:100px;
    }
    .parasitediv{
        margin-bottom:10px;
    }
    .chako{
        margin-bottom:10px;
    }
    .hrt-rw .cust-fld {
        width: 70%;
    }
    .hrt-rw .cust-inp {
        width: 30%;
    }
    .describe-rw .cust-fld {
        width: 20%;
    }
    .describe-rw .cust-inp {
        width: 80%;
    }
    #top-area {
        width: 100%;
        border: 1px solid;
    }
    .lnth-rw .cust-fld {
        width: 60%;
    }
    .lnth-rw .cust-inp {
        width: 40%;
    }
    .sys-op {
        width: 100%;
        display: block;
        padding: 6px;
        font-size: 15px;
    }
    .sys-colum p {
        font-size: 17px;
        font-weight: bold;
    }
    .systum-row,.sys-comment-row {
        display: flex;
    }
    .sys-colum {
        width: 8%;
        margin-right: 33px;
    }
    .sys-colum.clm-15 {
        width: 12%;
        margin: auto;
    }
    .sys-colum-left {
        width: 12%;
        margin-right: 60px;
        text-align: center;
        margin-top: auto;
        margin-bottom: auto;
    }
    .sys-colum-right {
        width: 69.5%;
    }
    .sys-colum.clm-15:last-child {
        margin: 0;
    }
    .sys-title {
        margin: 0;
        font-size: 19px;
        font-weight: bold;
    }
    .systum-sec {
        padding-bottom: 20px;
        border-bottom: 3px solid #b7b9ba;
        padding-top: 20px;
    }
    .btm-rw .cust-fld {
        width: 48%;
    }
    .btm-rw .cust-inp {
        width: 50%;
    }
    .material-rw .cust-fld {
        width: 70%;
    }
    .material-rw .cust-inp {
        width: 30%;
    }
    .btm-sec .sys-colum-right {
        width: 74.5%;
    }
    .add_new_btn_content {
        display: inline-block;
        width: 100%;
    }
    .add_new_btn_content .col-lg-12 {
        padding: 0;
    }
    .add_new_btn_content .cust-row.ingm-rw label.fl-lbl input:focus {
        outline: none;
    }
    .add_new_btn_content .cust-row.ingm-rw label.fl-lbl input {
        padding: 8px 0;
        background: transparent;
        border: none;
        border-bottom: 1px solid;
        width: 60%;
    }
    .add_new_btn_content .cust-row.ingm-rw label.fl-lbl input::placeholder {
        color: #3c454d;
    }
    div#newLymph .col-lg-12 {
        padding: 0 10px;
        margin-top: 10px;
    }
    .cst-rows #histoUpload {
        display: flex;
        flex-wrap: wrap;
        padding-top: 10px;
    }
    .btn-rw.startSpinner {
    padding-top: 20px;
}
    @media (max-width: 1800px){
        .cust-row .fl-lbl,.fl-lbl {
        font-size: 15px;
    }
    label.check-cust-fld {
        font-size: 15px;
    }
    .mid-t h3 {
        font-size: 17px;
    }
    .sec-title span {
        width: 72%;
    }
    .sec-title h2 {
        font-size: 27px;
    }

    }
    @media (max-width: 1600px){
        .cust-row .fl-lbl,.fl-lbl {
        font-size: 13px;
    }
    label.check-cust-fld {
        font-size: 13px;
    }
    .mid-t h3 {
        font-size: 15px;
    }
    .cust-row .check-bx {
        width: 19%;
        margin-top: auto;
    }
    .cust-row .check-ipt {
        width: 37%;
    }
    .sys-title {
        font-size: 13px;
    }
    .sys-colum p {
        font-size: 13px;
    }
    }
    @media (max-width: 1400px){
        .cust-fld {
        width: 50%;
        margin-top: auto;
    }
    }
    @media (max-width: 1300px){
    .main-new-page-content{
        width: 1155px;
        overflow: scroll;
    }
    }
    @media (max-width: 1200px){
        .cust-fld {
        width: 25%;
        margin-top: auto;
    }
    strong.strong-position {
    position: static;
}
    .main-new-page-content {
        width: auto;
        overflow: initial;
    }
    .cust-inp {
        width: 75%;
    }
    .row .col-lg-2,.row .col-lg-3,.row .col-lg-4,.row .col-lg-5,.row .col-lg-6,.row .col-lg-7,.row .col-lg-8,.row .col-lg-9,.row .col-lg-10,.row .col-lg-11,.row .col-lg-12 {
        padding: 0;
    }
    .cust-row {
        margin-bottom: 15px;
    }
    .panel-rw .cust-fld {
        width: 25%;
        margin-right: 0;
    }
    .right-fld {
        width: 25%;
    }
    .right-inp {
        width: 50%;
        margin-right: 15px;
    }
    .cust-row.mid-dorsal .cust-fld {
        width: 25%;
    }
    .sec-title span {
        width: 58%;
    }
    .sec-title h2 {
        font-size: 20px;
    }
    .exam-rw .cust-fld {
        width: 25%;
    }
    .ingm-rw .cust-fld {
        width: 25%;
    }
    .hrt-rw .cust-fld {
        width: 25%;
    }
    .hrt-rw .cust-inp,.hrt-rw .cust-inp {
        width: 75%;
    }
    .describe-rw .cust-fld {
        width: 25%;
    }
    .describe-rw .cust-inp {
        width: 75%;
    }
    .systum-row{
        display: block;
    }
    .sys-colum {
        width: 100%;
        margin-right: 0;
        margin-bottom: 10px;
    }
    .sys-colum.clm-15{
        width: 100%;
    }
    .sys-title {
        font-size: 20px;
        margin-bottom: 20px;
    }
    .sys-colum-left {
        width: 12%;
        margin-right: 1%;
    }
    .sys-colum-right {
        width: 100%;
    }
    .material-rw .cust-fld {
        width: 25%;
    }
    .material-rw .cust-inp {
        width: 75%;
    }
    .systum-row, .sys-comment-row {
        display: block;
    }
    .btm-sec .sys-colum-left {
        width: 100%;
    }
    .btm-sec .sys-colum-right {
        width: 100%;
    }
    .examination-sec {
        padding: 20px 10px;
    }
    .img-group img {
        width: 100%;
        margin-bottom: 20px;
    }
    .fldarea {
        margin-bottom: 15px;
    }
    .lnth-rw .cust-fld,.btm-rw .cust-fld {
        width: 25%;
    }
    .lnth-rw .cust-inp,.btm-rw .cust-inp {
        width: 75%;
    }

    }
    @media (max-width: 1199px){
        .rms {
            width: 120px;
        }
        .imag {
            height: 130px !important;
            width: 120px !important;
        }
        .choose-images .choose-images-detail .pip {
            width: 120px;
            margin-right: 10px;
        }
    }
    @media (max-width: 991px){
        .choose-images .choose-images-detail {
            padding: 0;
            flex-wrap: wrap;
        }
        .choose-images .choose-images-detail .pip {
            margin-bottom: 6px;
            margin-right: 6px;
        }
    }
    @media (max-width: 850px){
        .cust-fld {
        width: 30%;
        margin-top: auto;
    }
    .main-new-page-content {
        width: auto;
        overflow: initial;
    }
    .cust-inp {
        width: 70%;
    }
    .panel-rw .cust-fld {
        width: 30%;
        margin-right: 0;
    }
    .right-fld {
        width: 30%;
    }
    .right-inp {
        width: 50%;
        margin-right: 15px;
    }
    .cust-row.mid-dorsal .cust-fld {
        width: 30%;
    }
    .sec-title span {
        width: 58%;
    }
    .exam-rw .cust-fld,.ingm-rw .cust-fld,.hrt-rw .cust-fld,.describe-rw .cust-fld,.material-rw .cust-fld {
        width: 30%;
    }
    .hrt-rw .cust-inp,.hrt-rw .cust-inp,.describe-rw .cust-inp,.material-rw .cust-inp  {
        width: 70%;
    }
    .cust-row.describe-rw.other .cust-inp {
        width: 100%;
    }
    .top-sec,.full-img-sec,.examination-sec {
        padding: 20px;
    }
    .sec-title span {
        display: none;
    }
    #top-area,.fldarea #top-area {
        height: 100px;
    }
    .lnth-rw .cust-fld, .btm-rw .cust-fld {
        width: 30%;
    }
    .lnth-rw .cust-inp, .btm-rw .cust-inp {
        width: 70%;
    }
    .sys-colum-left {
        text-align: left;
    }
    .cust-inp select,.sys-op {
        padding: 5px;
        font-size: 13px;
    }
    .text-field {
        padding: 5px;
    }
    }
    @media (max-width: 767px){
        .btn-rw.startSpinner .cust-inp.cust-inpts {
            width: 100% !important;
        }
        .choose-images .choose-images-detail {
            justify-content: center;
        }
        .pipw {
            width: 30% !important;
        }
        .cst-rows #histoUpload {
            flex-wrap: wrap;
        }
    }
    @media (max-width: 600px){
        .exam-rw .cust-fld,.ingm-rw .cust-fld,.hrt-rw .cust-fld,.describe-rw .cust-fld,.material-rw .cust-fld,.cust-row.mid-dorsal .cust-fld,
        .right-fld,.cust-fld,.btm-rw .cust-fld {
        width: 100%;
    }
    .hrt-rw .cust-inp,.hrt-rw .cust-inp,.describe-rw .cust-inp,.material-rw .cust-inp,
    .cust-inp,.cust-row .check-ipt,.right-inp,.btm-rw .cust-inp  {
        width: 100%;
    }
    .cust-row {
        display: block;
    }
    .cust-row.btn-rw {
        display: flex;
    }
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