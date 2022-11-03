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
    <cfset Skeletal_Findings= ['No Findings','Fractures','Dislocation','Avulsions','Deformities','Other- Note Location in Comments']>
    <cfset Conditions = ['Alive', 'Fresh Dead', 'Moderate Decomposition' ,'Advanced Decomposition','Mummified']>
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
    <cfset Spinal_Cord= ['No Findings','Trauma','Hemorrhage','Necrosis','Exudate','Possible Parasite Ova','Not Examed','Partial Examed','Other']>
    <cfset sex = ['Male','Female','unknown']>
    <cfif isDefined('form.histoUpload')>
        <!--- <cfdump var="#Form#"><cfabort> --->
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
        <div class="col-lg-3">
        <div class="cust-row">
        <div class="cust-fld"><label class="fl-lbl">Field Number</label>
        </div>
        <div class="cust-inp">
            <select name="fieldnumber"class="stl-op">
                <option value="">Search</option>
                <option value="">Add New</option>
                <option value="">100</option>
                <option value="">101</option>
                <option value="">102</option>
            </select>
        </div>
        </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Date</label></div>
                <div class="cust-inp input-group date"id="first_date">
                <input type="text" id="birthday" name="birthday"  placeholder="YYYY-MM-DD"class="text-field"> 
                <span class="input-group-addon time-icon"> <span class="glyphicon glyphicon-calendar"></span> </span>
            </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Species</label></div>
                <div class="cust-inp">
                    <select class="stl-op" name="species" id="species">
                        <option value="">Select</option>
                        <cfloop query="qgetCetaceanSpecies">
                            <cfif active eq 1>
                                <option value="#qgetCetaceanSpecies.id#">
                                    #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                            </cfif>
                        </cfloop>
                    </select>
                </div>
                </div>
                </div>
        <div class="col-lg-3">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Location</label></div>
                <div class="cust-inp">
                <input type="text" name="location"class="text-field">
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
                    <input type="checkbox" name="new"class="check-bxt-fld">
                    <label class="check-cust-fld">New</label>
                </div>
                <div class="check-bx">
                    <input type="checkbox"  name="hera"class="check-bxt-fld">
                    <label class="check-cust-fld">HERA</label>
                </div>
                <div class="check-ipt">
                    <input type="text" class="text-field">
                </div>
                </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Photo ID Code</label>
                </div>
                <div class="cust-inp">
                    <select name="photocode"class="stl-op">
                        <option value="0">Select</option>
                        <option value="1">Code 1</option>
                        <option value="2">Code 2</option>
                        <option value="3">Code 3</option>
                    </select>
                </div>
                </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Initial Condition Code:</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="InitialCondition" id="InitialCondition">
                        <option value="">Select Initial Condition</option>
                        <cfloop array="#Conditions#" item="item" index="j">
                            <option value="#item#">#j#-#item#</option>
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
                            <option value="#sex[j]#" >#sex[j]#</option>
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
                    <input type="text" name="weight"class="text-field">
                </div>
                </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Age Class</label>
                </div>
                <div class="cust-inp">
                    <input type="text" name="ageClass"class="text-field">
                </div>
                </div>
        </div>
    </div>
    <div class="row pt-20">
        <div class="col-lg-12 fldarea">
            <label class="fl-lbl">Brief History</label>
            <textarea id="top-area" name="briefhistory" rows="4" cols="50"></textarea>
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
                                <option value="#qgetVeterinarians.ID#">#qgetVeterinarians.Veterinarians#</option>
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
                                <option value="#getTeams.RT_ID#">#getTeams.RT_MemberName#</option>
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
                    <input type="text" name="Tentative"placeholder="Expandable field to multi-line" class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-12 mt-15">
                <div class="cust-row panel-rw">
                    <div class="cust-fld"><label class="fl-lbl">Cause of Death</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="deathcause" placeholder="Expandable field to multi-line" class="text-field">
                    </div>
                </div>
                </div>
        </div>
        <div class="row pt-15">
            <div class="col-lg-8 fldarea">
            <label class="fl-lbl">Histopathology Remarks / Diagnosis</label>
            <textarea id="top-area" name="historemark" rows="4" cols="50"></textarea>
            </div>
            <div class="col-lg-4">
                <div class="cust-row btn-rw mt-30">
                <div class="cust-inp">
                    <input type="file" placeholder="pdf Path" name="histofile"class="text-field">
                </div>
                <div class="cust-fld"><button name="histoUpload"class="upld-btn">Upload</button></div>
                </div>
                <div class="simple-button pt-15"><a href="#Application.siteroot#?Module=Stranding&Page=Histopathology" class="linkhisto">Open Histopathology</a></div>
            </div>
        </div>
        </div>
    <div class="full-img-sec">
        <div class="row">
            <div class="col-lg-6">
                <div class="img-group">
                    <img src="http://test.wildfins.org/resources/assets/img/LiveCetaceanImages/Tursiops_Diagram.png">
                </div>
            </div>
            <div class="col-lg-6">
                <div class="cust-row right-panel-rw">
                    <div class="right-fld"><label class="fl-lbl">Total Length (1)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="totalLength"placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm (rostrum to fluke notch)</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Rostrum to Dorsal Fin (2)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="rostrum"placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm (center of blowhole)</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Blowhole to Dorsal (3)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="blowhole" placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Fluke Width (4)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text"name="fluke" placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Girth (circumference) (5)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text"name="girth" placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Axillary (6)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="axillary"placeholder="" class="text-field">
                    </div>
                    <div class="right-fld"><label class="fl-lbl">cm</label>
                    </div>
                </div>
                <div class="cust-row right-panel-rw mt-10">
                    <div class="right-fld"><label class="fl-lbl">Maximum (7)</label>
                    </div>
                    <div class="right-inp">
                        <input type="text" name="maxium"placeholder="" class="text-field">
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
                        <input type="text" name="blubber"class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-7"></div>
        </div>
        <div class="row mt-10">
            <div class="col-lg-5">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Mid-Lateral</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="midlateral"class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Upper Left</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Lateralupperleft"class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Lower Left</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Laterallowerleft"class="text-field">
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
                        <input type="text" name="midVentral" class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Upper Left</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Ventralupperleft" class="text-field">
                </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div class="cust-row mid-dorsal">
                    <div class="cust-fld"><label class="fl-lbl">Lower Right</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ventrallowerright" class="text-field">
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
                            <cfloop array="#Condition_at_Necropsy#" item="item" index="j">
                                <option value="#item#">#j#-#item#</option>
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
                            <option value="Yes">Yes</option>
                            <option value"No">No</option>
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
                        <input type="text"  name="generalBody"class="text-field">
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
                        <input type="text" id="Level_A_Date" name="LevelADate"  placeholder="YYYY-MM-DD"class="text-field"> 
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
                                <option value="#Animal_Renderings[j]#" >#Animal_Renderings[j]#</option>
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
                        <input type="text" id="NecropsyDate" name="NecropsyDate"  placeholder="YYYY-MM-DD"class="text-field"> 
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
                                    <option value="#qgetNxLocation.ID#">#qgetNxLocation.location#</option>
                                </cfif>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="col-lg-5">
                <div class="cust-row btn-rw">
                    <div class="cust-inp">
                        <input type="file" placeholder="image Path" name="ExternalExamphoto" class="text-field">
                    </div>
                    <div class="cust-fld"><button class="upld-btn">Upload</button></div>
                </div>
            </div>
        </div>
        </div>
    </div>
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
                            <option value="Yes">Yes</option>
                            <option value"No">No</option>
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
                            <option value="Yes">Yes</option>
                            <option value"No">No</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Number of Cookie Cutter Wounds</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="cutterwounds"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Number of Cookie Cutter Scars</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"  name="cutterscars"class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Eye Findings LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op search-box" multiple="multiple" name="eyeleft" id="eye_left">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Eye_Finding)#" index="j">
                                <option value="#Eye_Finding[j]#" >#Eye_Finding[j]#</option>
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
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Eye_Finding)#" index="j">
                                <option value="#Eye_Finding[j]#" >#Eye_Finding[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
                <div class="simple-button pt-15 align-right"><a href="#Application.siteroot#?Module=Stranding&Page=CetaceanExam" class="linkcetacean">Open Cetacean Exam</a></div>
            </div>
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">If skin lesion present, please describe</label>
            <textarea id="top-area" name="lessiondescribe" rows="12" cols="120"></textarea>
        </div>
        <div class="col-lg-12 fldarea">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="lessioncomments" rows="12" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="lessionphototaken" class="check-bxt-fld">
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row btn-rw">
                <div class="cust-inp">
                    <input type="file" placeholder="image Path" name="Integumentphoto" class="text-field">
                </div>
                <div class="cust-fld"><button class="upld-btn">Upload</button></div>
            </div>
        </div>
    </div>
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
                                <option value="#Fat_Blubber[j]#" >#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
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
                                <option value="#Fat_Blubber[j]#" >#Fat_Blubber[j]#</option>
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
                                <option value="#Fat_Blubber[j]#" >#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Kidneys</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="kidney" id="kidney">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" >#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mt-10">
                <!--- <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><input type="text" class="text-field"></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op">
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Fat_Blubber)#" index="j">
                                <option value="#Fat_Blubber[j]#" >#Fat_Blubber[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div> --->
                <div id="newNUTRI"></div>
                <div class="simple-button pt-15 align-right">
                    <input type="hidden" name="dynamic_NUTRITIONAL" value="" id="dynamic_NUTRITIONAL">
                    <!--- <button class="upld-btn">Add New</button> --->
                    <input type="button" id="Add_new" name="Add_new" class="upld-btn" value="Add New" onclick="newNUTRITIONAL()">
                </div>
            </div>
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="internal_comments" rows="12" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="internal_phototaken"class="check-bxt-fld">
            </div>
        </div>
        <div class="col-lg-5 mt-20">
            <div class="cust-row btn-rw">
                <div class="cust-inp">
                    <input type="file" name="intenalExamphoto" class="text-field">
                </div>
                <div class="cust-fld"><button class="upld-btn">Upload</button></div>
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
            <div class="col-lg-12">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">MUSCULOSKELETAL SYSTEM</h3></div></label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="MUSCULOSKELETAL" id="MUSCULOSKELETAL">
                            <option value="">Select</option>
                            <option value="Examined">Examined</option>
                            <option value="NE">NE</option>
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
                                <option value="#Joint_Fluid[j]#" >#Joint_Fluid[j]#</option>
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
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Skeletal_Findings)#" index="j">
                                <option value="#Skeletal_Findings[j]#" >#Skeletal_Findings[j]#</option>
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
                                <option value="#Muscle_Status[j]#" >#Muscle_Status[j]#</option>
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
                            <option value="">Select</option>
                            <cfloop from="1" to="#ArrayLen(Musculature_Findings)#" index="j">
                                <option value="#Musculature_Findings[j]#" >#Musculature_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="muscular_comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="muscular_phototaken" class="check-bxt-fld">
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
                            <option value="Examined">Examined</option>
                            <option value="NE">NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="fluidVolume" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Ml</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ml" id="ml">
                            <option value="">Select</option>
                            <option value="Actual">Actual</option>
                            <option value="Estimate">Estimate</option>
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
                                <option value="#Joint_Fluid[j]#" >#Joint_Fluid[j]#</option>
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
                                <option value="#Lining[j]#" >#Lining[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="thoratic_comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="thoratic_phototaken"class="check-bxt-fld">
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
                            <option value="Examined">Examined</option>
                            <option value="NE">NE</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Fluid Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="abdominal_fluidVolume" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Ml</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="ABDOMINAL_ml" id="ABDOMINAL_ml">
                            <option value="">Select</option>
                            <option value="Actual">Actual</option>
                            <option value="Estimate">Estimate</option>
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
                                <option value="#Joint_Fluid[j]#" >#Joint_Fluid[j]#</option>
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
                                <option value="#Lining[j]#" >#Lining[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="abdominal_comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="abdominal_phototaken"class="check-bxt-fld">
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
                            <option value="Examined">Examined</option>
                            <option value="NE">NE</option>
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
                                    <option value="#qgetLiverFinding.ID#">#qgetLiverFinding.finding#</option>
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
                                <option value="#Biliary_Findings[j]#" >#Biliary_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
    </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="hepatobiliary_comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="hepatobiliary_phototaken"class="check-bxt-fld">
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
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row hrt-rw">
                <div class="cust-fld"><label class="fl-lbl">Blood in Heart Chambers</label>
                </div>
                <div class="cust-inp" name="Chambers" id="Chambers">
                    <select class="stl-op">
                        <option value="">Select</option>
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row describe-rw">
                <div class="cust-fld"><label class="fl-lbl">Describe</label>
                </div>
                <div class="cust-inp">
                    <input type="text" name="cardio_describe"class="text-field">
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
                                <option value="#Pericardial_Fluid[j]#" >#Pericardial_Fluid[j]#</option>
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
                                <option value="#Overall_Findings[j]#" >#Overall_Findings[j]#</option>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="cardio_comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="cardio_phototaken"class="check-bxt-fld">
            </div>
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
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
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
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                <div class="cust-fld"><label class="fl-lbl">If Present</label>
                </div>
                <div class="cust-inp" name="If_Present" id="If_Present">
                    <select class="stl-op">
                        <option value="">Select</option>
                        <option value="Anterior to Bifurction">Anterior to Bifurction</option>
                        <option value="Posterior to Bifurction">Posterior to Bifurction</option>
                        <option value="Anterior and Posterior to Bifurction">Anterior and Posterior to Bifurction</option>
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
                            <option value="Small">Small </option>
                            <option value="Moderate">Moderate</option>
                            <option value="Copious">Copious</option>
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
                                <option value="#Color_of_Foam[j]#" >#Color_of_Foam[j]#</option>
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
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>  
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
                                <option value="#Trachea_Bronchi[j]#" >#Trachea_Bronchi[j]#</option>
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
                                    <option value="#qgetLungFinding.ID#">#qgetLungFinding.finding#</option>
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
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="pulmonary_comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="pulmonary_phototaken" class="check-bxt-fld">
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
                    <select class="stl-op " name="Parasites_Location" id="Parasites_Location">
                        <cfloop query="qgetParasiteLocation">
                            <cfif status eq 1>
                                <option value="#qgetParasiteLocation.ID#">#qgetParasiteLocation.location#</option>
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
                    <textarea id="top-area" name="pulmonary_textarea" rows="5" cols="50" spellcheck="false"></textarea>
                </div>
            </div>
        </div>
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
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
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
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
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
                        <option value="No Findings">No Findings</option>
                        <option value="Trauma">Trauma</option>
                        <option value="Enlarged">Enlarged</option>
                        <option value="Masses">Masses</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row describe-rw other">
                <!--- <div class="cust-fld"><label class="fl-lbl"></label>
                </div> --->
                <div class="cust-inp">
                    <input type="text" name="lympho_other"placeholder="Other" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-5">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Lymph Node Present</label>
                </div>
                <div class="cust-inp">
                    <select name="lymphnode"id="lymphnode"class="stl-op">
                        <cfloop query="qgetLymphNodePresent">
                            <cfif status eq 1>
                                <option value="#qgetLymphNodePresent.ID#">#qgetLymphNodePresent.LymphNodePresent#</option>
                            </cfif>
                        </cfloop>
                    </select>
                </div>
            </div>
            <div id="newLymph"></div>
            <input type="hidden" name="dynamic_Lymph" value="" id="dynamic_Lymph">
            <input type="button" id="Add_newLymph" name="Add_newLymph" class="upld-btn" value="Add New" onclick="newLymphnode()">
        </div>
        <div class="col-lg-2">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Size Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text" placeholder="cm" name="nodelength"class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" placeholder="cm" name="nodewidth" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5">
        </div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="lympho_comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="lympho_phototaken" class="check-bxt-fld">
            </div>
        </div>
    </div>
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
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
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
                        <option value="No Findings">No Findings</option>
                        <option value="Enlarged">Enlarged</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Left Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text" name="adrenal_leftLength"placeholder="cm" class="text-field">
                </div>
            </div>
            <div class="cust-row ingm-rw mt-10">
                <div class="cust-fld"><label class="fl-lbl">Right Length</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_rightLength"placeholder="cm" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_leftwidth"placeholder="cm" class="text-field">
                </div>
            </div>
            <div class="cust-row mt-10">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="adrenal_rightwidth"placeholder="cm" class="text-field">
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
                        <option value="No Findings">No Findings</option>
                        <option value="Enlarged">Enlarged</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text"name="thyroid_length" placeholder="cm" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" name="thyroid_width"placeholder="cm" class="text-field">
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
                        <option value="No Findings">No Findings</option>
                        <option value="Enlarged">Enlarged</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Length</label>
                </div>
                <div class="cust-inp">
                    <input type="text"name="Pituitary_length" placeholder="cm" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Width</label>
                </div>
                <div class="cust-inp">
                <input type="text" placeholder="cm" name="Pituitary_width"class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-5"></div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="endocrine_comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="endocrine_phototaken" class="check-bxt-fld">
            </div>
        </div>
    </div>
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
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
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
                                <option value="#Kidneys_Findings[j]#" >#Kidneys_Findings[j]#</option>
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
                                <option value="#Kidneys_Findings[j]#" >#Kidneys_Findings[j]#</option>
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
                            <option value="Empty">Empty </option>
                            <option value="Contents">Contents</option>
                            
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Volume</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="urin_volume" placeholder="ml" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-3 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Color</label>
                    </div>
                    <div class="cust-inp">
                        <select class="stl-op" name="UROGENITAL_color" id="UROGENITAL_color">
                            <option value="">Select</option>
                            <option value="Clear">Clear</option>
                            <option value="Light yellow">Light yellow</option>
                            <option value="Dark yellow">Dark yellow</option>
                            <option value="Pink - Red">Pink - Red</option>
                            <option value="Brown">Brown</option>
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
                            <option value="Clear">Clear</option>
                            <option value="Cloudy">Cloudy</option>
                            <option value="Flocculent">Flocculent</option>
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
                            <option value="Mass(es)">Mass(es)</option>
                            <option value="Parasites">Parasites</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Describe</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Abnormalities_describe" class="text-field">
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
                            <option value="Examined">Examined</option>
                            <option value="NE">NE</option>
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
                            <option value="Penis">Penis</option>
                            <option value="Vagina">Vagina</option>
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
                            <option valu="Yes">Yes</option>
                            <option valu="No">No</option>
                            <option value="Unknown">Unknown</option>
                            
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
                            <option value="">Select</option>
                            <option value="">Testes </option>
                            <option value="">Ovaries</option>
                         
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Testes Length LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_Length_LEFT" placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Testes_Length_width"placeholder="cm" class="text-field">
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
                            <option value="No Findings">No Findings </option>
                            <option value="Milk Production">Milk Production</option>
                            <option value="Abnormal">Abnormal</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Testes Length RIGHT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_Length_right" placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Testes_width_right" placeholder="cm" class="text-field">
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
                            <option value="No Findings">No Findings </option>
                            <option value="Milk Production">Milk Production</option>
                            <option value="Abnormal">Abnormal</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-10">
                <div class="cust-row ingm-rw">
                    <div class="cust-fld"><label class="fl-lbl">Ovary Length LEFT</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ovary_Length_LEFT" placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text" name="Ovary_Width_LEFT"placeholder="cm" class="text-field">
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
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                           
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
                        <input type="text"name="Ovary_Length_right" placeholder="cm" class="text-field">
                    </div>
                </div>
            </div>
            <div class="col-lg-2 mt-10">
                <div class="cust-row">
                    <div class="cust-fld"><label class="fl-lbl">Width</label>
                    </div>
                    <div class="cust-inp">
                        <input type="text"name="Ovary_width_right" placeholder="cm" class="text-field">
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
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
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
            <textarea id="top-area" name="UROGENITAL_Comments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="UROGENITAL_phototaken"class="check-bxt-fld">
            </div>
        </div>
    </div>
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
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
                        <option value="Complete">Complete</option>
                        <option value="Partial">Partial</option>
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
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Trauma</p>
                <select class="sys-op" name="ESOPHAGUSTrauma">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Masses</p>
                <select class="sys-op" name="ESOPHAGUSMasses">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Impaction</p>
                <select class="sys-op" name="ESOPHAGUSImpaction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Obstruction</p>
                <select class="sys-op" name="ESOPHAGUSObstruction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>lntussusception</p>
                <select class="sys-op" name="ESOPHAGUSlntussusception">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <p>Parasites</p>
                <select class="sys-op" name="ESOPHAGUSParasites">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <p>Other</p>
                <input type="text" class="text-field" name="ESOPHAGUSOther">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="ESOPHAGUSContents">
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
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHTrauma">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHMasses">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHImpaction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHObstruction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHlntussusception">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="FORESTOMACHParasites">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="FORESTOMACHOther">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="FORESTOMACHContents">
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
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHTrauma">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHMasses">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHImpaction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHObstruction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHlntussusception">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="GLANDULARSTOMACHParasites">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="GLANDULARSTOMACHOther">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="GLANDULARSTOMACHContents">
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
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSTrauma">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSMasses">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSImpaction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSObstruction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSlntussusception">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="PYLORUSParasites">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="PYLORUSOther">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="PYLORUSContents">
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
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINETrauma">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEMasses">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEImpaction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEObstruction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINElntussusception">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="SMALLINTESTINEParasites">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="SMALLINTESTINEOther">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="SMALLINTESTINEContents">
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
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONTrauma">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONMasses">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONImpaction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONObstruction">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONlntussusception">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum">
                <select class="sys-op" name="COLONParasites">
                    <option value="">Select</option>
                    <option value=">5%">>5%</option>
                    <option value="5-25%">5-25%</option>
                    <option value="25-50%">25-50%</option>
                    <option value=">50%">>50%</option>
                </select>
            </div>
            <div class="sys-colum clm-15">
                <input type="text" class="text-field" name="COLONOther">
            </div>
        </div>
        <div class="sys-comment-row mt-20">
            <div class="sys-colum-left">
                <h3 class="sys-title">Contents</h3>
            </div>
            <div class="sys-colum-right">
                <input type="text" class="text-field" name="COLONContents">
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
                        <option value="">Examined</option>
                        <option value="">NE</option>
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
                        <option value="">No Findings</option>
                        <option value="">Trauma</option>
                        <option value="">Masses</option>
                        <option value="">Engorged</option>
                        <option value="">Other</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                <!--- <div class="cust-fld"><label class="fl-lbl">Describe</label>
                </div> --->
                <div class="cust-inp">
                    <input type="text" placeholder="Other" class="text-field" name="PANCREASOthers">
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
                        <option value="">Yes</option>
                        <option value="">No</option>
                    </select>
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
                        <option value="">Yes</option>
                        <option value="">No</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="sys-comment-row mt-20 btm-sec">
        <div class="sys-colum-left">
            <h3 class="sys-title">Contents</h3>
        </div>
        <div class="sys-colum-right">
            <textarea id="top-area" name="InjuryLesionAssociatedContents" rows="10" cols="120"></textarea>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl">GI Foreign Material Type</label>
                </div>
                <div class="cust-inp ">
                    <select class="stl-op search-box" name="GIForeignMaterialType" id="GIForeignMaterialType" multiple>
                        <cfloop query="qGIForeignMaterial">
                            <cfif status eq 1 >
                                <option value="#qGIForeignMaterial.GIForeignMaterial#">#qGIForeignMaterial.GIForeignMaterial#</option>
                            </cfif>
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
                    <input type="text" class="text-field" name="MaterialLesionLocation">
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 mt-10">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl">Material Collected</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="MaterialCollected" id="MaterialCollected">
                        <option value="">Select</option>
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Disposition of Material Collected</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field" name="DispositionofMaterialCollected">
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 mt-100">
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
            <div  id="newparasite"></div>
            <div class="simple-button pt-15 align-right">
                <input type="hidden" name="dynamic_parasite" value="" id="dynamic_parasite">
                <input type="button" id="Add_newparasite" name="Add_newparasite" class="upld-btn" value="Add New" onclick="newparasite()">
            </div>
        </div>
        

        

        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Parasite Type</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="ParasiteType" id="">
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
                    <select class="stl-op" name="Parasitelocation" id="">
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
    </div>
    <div class="row">
        <div class="col-lg-5"></div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="Parasitecomments" rows="10" cols="120"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox" name="Parasite_phototaken"class="check-bxt-fld">
            </div>
        </div>
    </div>
    <div class="row pt-30">
        <div class="col-lg-12">
        <div class="col-lg-4">
            <div class="cust-row btm-rw">
                <div class="cust-fld"><label class="fl-lbl"><div class="mid-t"><h3 class="m-0">CENTRAL NERVOUS SYSTEM</h3></div></label>
                </div>
                <div><label class="fl-lbl">Brain</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CENTRALbrain" id="">
                        <option value="">Select</option>
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
                        <option value="Partial Examined">Partial Examined</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Brain Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CENTRALBrainFindings" id="">
                        <cfloop from="1" to="#ArrayLen(brain_Findings)#" index="j">
                            <option value="#brain_Findings[j]#" >#brain_Findings[j]#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                
                <div class="cust-inp">
                    <input type="text"name="brainother" placeholder="Other" class="text-field">
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
                        <option value="Examined">Examined</option>
                        <option value="NE">NE</option>
                        <option value="Partial Examined">Partial Examined</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Spinal Cord Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op" name="CENTRALSpinalCordfinding" id="">
                        <cfloop from="1" to="#ArrayLen(brain_Findings)#" index="j">
                            <option value="#brain_Findings[j]#" >#brain_Findings[j]#</option>
                        </cfloop>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="cust-row describe-rw">
                
                <div class="cust-inp">
                    <input type="text"name="spinalother" placeholder="Other" class="text-field">
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="row pt-20">
        <div class="col-lg-5"></div>
    <div class="col-lg-7">
            <label class="fl-lbl">Comments</label>
            <textarea id="top-area" name="nervoussystemcomments" rows="10" cols="120" spellcheck="false"></textarea>
            <div class="area-check align-right">
                <label class="check-cust-fld">Photographs Taken</label>
                <input type="checkbox"name="nervoussystemphototaken" class="check-bxt-fld">
            </div>
        </div>
    </div>
    </form> 
    </div>
    </div>














    </div>
    </cfoutput>

    <style>
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
        display: flex;
        padding-right: 20px;
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