<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    
    <cfoutput>
        <div id="content" class="content">
            <!-- begin breadcrumb -->
            <ol class="breadcrumb pull-right">
                <li><a href="javascript:;">Stranding</a></li>
                <li><a href="javascript:;">Sample Archive</a></li>
            </ol>
            <!-- end breadcrumb -->
            <!-- begin page-header -->
            <h1 class="page-header">Cetacean Necropsy Report</h1>
            <!-- end page-header -->
<div class="top-sec">
<div class="row">
    <div class="col-lg-3">
    <div class="cust-row">
    <div class="cust-fld"><label class="fl-lbl">Field Number</label>
    </div>
    <div class="cust-inp">
        <select class="stl-op">
            <option>Search</option>
            <option>Add New</option>
            <option>100</option>
            <option>101</option>
            <option>102</option>
        </select>
    </div>
    </div>
    </div>
    <div class="col-lg-3">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Date</label></div>
            <div class="cust-inp">
            <input type="date" id="birthday" name="birthday"  class="text-field"> 
        </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Species</label></div>
            <div class="cust-inp">
                <select class="stl-op">
                    <option>Select</option>
                    <option>Bottlenose Dolphin (Tursiops truncatus)/option>
                    <option>Atlantic Spotted Dolphin (Stenella frontalis)</option>
                    <option>Blainville's Beaked Whale (Mesoplodon densirostris)</option>
                </select>
            </div>
            </div>
            </div>
    <div class="col-lg-3">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Location</label></div>
            <div class="cust-inp">
            <input type="text" class="text-field">
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
                <input type="checkbox" class="check-bxt-fld">
                <label class="check-cust-fld">New</label>
            </div>
            <div class="check-bx">
                <input type="checkbox" class="check-bxt-fld">
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Code 1</option>
                    <option>Code 2</option>
                    <option>Code 3</option>
                </select>
            </div>
            </div>
    </div>
    <div class="col-lg-4">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Initial Condition Code:</label>
            </div>
            <div class="cust-inp">
                <select class="stl-op">
                    <option>Select</option>
                    <option>1 Alive</option>
                    <option>1 Alive / 2 Fresh Dead</option>
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Male</option>
                    <option>Female</option>
                    <option>unkown</option>
                </select>
            </div>
            </div>
    </div>
    <div class="col-lg-2">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Weight</label>
            </div>
            <div class="cust-inp">
                <input type="text" class="text-field">
            </div>
            </div>
    </div>
    <div class="col-lg-3">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Age Class</label>
            </div>
            <div class="cust-inp">
                <input type="text" class="text-field">
            </div>
            </div>
    </div>
</div>
<div class="row pt-20">
    <div class="col-lg-12 fldarea">
        <label class="fl-lbl">Brief History</label>
        <textarea id="top-area" name="" rows="4" cols="50"></textarea>
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
                <select class="stl-op">
                    <option>Dr. Annie Page-Karjian</option>
                    <option>Name</option>
                    <option>Name</option>
                    <option>Name</option>
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
                <select class="stl-op">
                    <option>Steve Burton</option>
                    <option>Name</option>
                    <option>Name</option>
                    <option>Name</option>
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
                <input type="text" placeholder="Expandable field to multi-line" class="text-field">
            </div>
            </div>
        </div>
        <div class="col-lg-12 mt-15">
            <div class="cust-row panel-rw">
                <div class="cust-fld"><label class="fl-lbl">Cause of Death</label>
                </div>
                <div class="cust-inp">
                    <input type="text" placeholder="Expandable field to multi-line" class="text-field">
                </div>
            </div>
            </div>
    </div>
    <div class="row pt-15">
        <div class="col-lg-8 fldarea">
        <label class="fl-lbl">Histopathology Remarks / Diagnosis</label>
        <textarea id="top-area" name="" rows="4" cols="50"></textarea>
        </div>
        <div class="col-lg-4">
            <div class="cust-row btn-rw mt-30">
            <div class="cust-inp">
                <input type="text" placeholder="pdf Path" class="text-field">
            </div>
            <div class="cust-fld"><button class="upld-btn">Upload</button></div>
            </div>
            <div class="simple-button pt-15"><button class="smp-btn">Open Histopathology</button></div>
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
                    <input type="text" placeholder="" class="text-field">
                </div>
                <div class="right-fld"><label class="fl-lbl">cm (rostrum to fluke notch)</label>
                </div>
            </div>
            <div class="cust-row right-panel-rw mt-10">
                <div class="right-fld"><label class="fl-lbl">Rostrum to Dorsal Fin (2)</label>
                </div>
                <div class="right-inp">
                    <input type="text" placeholder="" class="text-field">
                </div>
                <div class="right-fld"><label class="fl-lbl">cm (center of blowhole)</label>
                </div>
            </div>
            <div class="cust-row right-panel-rw mt-10">
                <div class="right-fld"><label class="fl-lbl">Blowhole to Dorsal (3)</label>
                </div>
                <div class="right-inp">
                    <input type="text" placeholder="" class="text-field">
                </div>
                <div class="right-fld"><label class="fl-lbl">cm</label>
                </div>
            </div>
            <div class="cust-row right-panel-rw mt-10">
                <div class="right-fld"><label class="fl-lbl">Fluke Width (4)</label>
                </div>
                <div class="right-inp">
                    <input type="text" placeholder="" class="text-field">
                </div>
                <div class="right-fld"><label class="fl-lbl">cm</label>
                </div>
            </div>
            <div class="cust-row right-panel-rw mt-10">
                <div class="right-fld"><label class="fl-lbl">Girth (circumference) (5)</label>
                </div>
                <div class="right-inp">
                    <input type="text" placeholder="" class="text-field">
                </div>
                <div class="right-fld"><label class="fl-lbl">cm</label>
                </div>
            </div>
            <div class="cust-row right-panel-rw mt-10">
                <div class="right-fld"><label class="fl-lbl">Axillary (6)</label>
                </div>
                <div class="right-inp">
                    <input type="text" placeholder="" class="text-field">
                </div>
                <div class="right-fld"><label class="fl-lbl">cm</label>
                </div>
            </div>
            <div class="cust-row right-panel-rw mt-10">
                <div class="right-fld"><label class="fl-lbl">Maximum (7)</label>
                </div>
                <div class="right-inp">
                    <input type="text" placeholder="" class="text-field">
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
                    <input type="text" class="text-field">
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
                    <input type="text" class="text-field">
            </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row mid-dorsal">
                <div class="cust-fld"><label class="fl-lbl">Upper Left</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field">
            </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row mid-dorsal">
                <div class="cust-fld"><label class="fl-lbl">Lower Left</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field">
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
                    <input type="text" class="text-field">
            </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row mid-dorsal">
                <div class="cust-fld"><label class="fl-lbl">Upper Left</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field">
            </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="cust-row mid-dorsal">
                <div class="cust-fld"><label class="fl-lbl">Lower Right</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field">
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>2 Fresh Dead</option>
                        <option>3 Moderate Decomposition</option>
                        <option>4 Advanced Decomposition</option>
                        <option>5 Mummified</option>
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Yes</option>
                        <option>No</option>
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
                    <input type="text"  class="text-field">
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 mt-10">
        <div class="col-lg-5">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Level A Date</label>
                </div>
                <div class="cust-inp">
                    <input type="date" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Animal Renderings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Buried On Site</option>
                        <option>Towed Offshore</option>
                        <option>Burried and Towed Offshore</option>
                        <option>Landfill</option>
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
                <div class="cust-inp">
                    <input type="date" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="cust-row">
                <div class="cust-fld"><label class="fl-lbl">Nx Location</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Master Date</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-12 mt-10">
        <div class="col-lg-5">
            <div class="cust-row btn-rw">
                <div class="cust-inp">
                    <input type="text" placeholder="image Path" class="text-field">
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Yes</option>
                        <option>No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">HI Form</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Yes</option>
                        <option>No</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Number of Cookie Cutter Wounds</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Number of Cookie Cutter Scars</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Eye Findings LEFT</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings</option>
                        <option>Cloudy</option>
                        <option>Bloody</option>
                        <option>Predated</option>
                        <option>Present</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Eye Findings RIGHT</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings</option>
                        <option>Cloudy</option>
                        <option>Bloody</option>
                        <option>Predated</option>
                        <option>Present</option>
                    </select>
                </div>
            </div>
            <div class="simple-button pt-15 align-right"><button class="smp-btn">Open Cetacean Exam</button></div>
        </div>
    </div>
    <div class="col-lg-7">
        <label class="fl-lbl">Histopathology Remarks / Diagnosis</label>
        <textarea id="top-area" name="" rows="12" cols="120"></textarea>
    </div>
    <div class="col-lg-12 fldarea">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="12" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
        </div>
    </div>
    <div class="col-lg-5">
        <div class="cust-row btn-rw">
            <div class="cust-inp">
                <input type="text" placeholder="image Path" class="text-field">
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Examined</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Heart</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Mesentery</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Kidneys</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl"><input type="text" class="text-field"></label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings</option>
                        <option>Cloudy</option>
                        <option>Bloody</option>
                        <option>Predated</option>
                        <option>Present</option>
                    </select>
                </div>
            </div>
            <div class="simple-button pt-15 align-right"><button class="upld-btn">Add New</button></div>
        </div>
    </div>
    <div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="12" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
        </div>
    </div>
    <div class="col-lg-5 mt-20">
        <div class="cust-row btn-rw">
            <div class="cust-inp">
                <input type="text" placeholder="image Path" class="text-field">
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings </option>
                        <option>Cloudy - Solid Material</option>
                        <option>Bloody</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Joint Fluid</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings </option>
                        <option>Cloudy - Solid Material</option>
                        <option>Bloody</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Skeletal Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Muscle Status</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Musculature Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="10" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Examined</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Fluid Volume</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-6 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Ml</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Actual</option>
                        <option>Estimate</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Fluid</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings </option>
                        <option>Cloudy - Solid Material</option>
                        <option>Bloody</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Lining</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="10" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Examined</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-6 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Fluid Volume</label>
                </div>
                <div class="cust-inp">
                    <input type="text" class="text-field">
                </div>
            </div>
        </div>
        <div class="col-lg-6 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Ml</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Actual</option>
                        <option>Estimate</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Fluid</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings </option>
                        <option>Cloudy - Solid Material</option>
                        <option>Bloody</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Lining</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
<div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="10" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Examined</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Liver Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings </option>
                        <option>Cloudy - Solid Material</option>
                        <option>Bloody</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Biliary Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
</div>
<div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="10" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Examined</option>
                    <option>NE</option>
                </select>
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="cust-row hrt-rw">
            <div class="cust-fld"><label class="fl-lbl">Blood in Heart Chambers</label>
            </div>
            <div class="cust-inp">
                <select class="stl-op">
                    <option>Select</option>
                    <option>Examined</option>
                    <option>NE</option>
                </select>
            </div>
        </div>
    </div>
    <div class="col-lg-5">
        <div class="cust-row describe-rw">
            <div class="cust-fld"><label class="fl-lbl">Describe</label>
            </div>
            <div class="cust-inp">
                <input type="text" class="text-field">
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
                <div class="cust-fld"><label class="fl-lbl">Liver Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings </option>
                        <option>Cloudy - Solid Material</option>
                        <option>Bloody</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Biliary Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
<div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="10" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Examined</option>
                    <option>NE</option>
                </select>
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="cust-row hrt-rw">
            <div class="cust-fld"><label class="fl-lbl">Foam - Froth in Airway</label>
            </div>
            <div class="cust-inp">
                <select class="stl-op">
                    <option>Select</option>
                    <option>Examined</option>
                    <option>NE</option>
                </select>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="cust-row describe-rw">
            <div class="cust-fld"><label class="fl-lbl">If Present</label>
            </div>
            <div class="cust-inp">
                <select class="stl-op">
                    <option>Select</option>
                    <option>Examined</option>
                    <option>NE</option>
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
                    <select class="stl-op">
                        <option>Select</option>
                        <option>No Findings </option>
                        <option>Cloudy - Solid Material</option>
                        <option>Bloody</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Color of Foam</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Sand/Sediment in Airway</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Trachea/Bronchi</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Lungs Findings</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Abundant - No Atrophy </option>
                        <option>Mild to Moderate Atrophy</option>
                        <option>Severe Atrophy</option>
                        <option>NE</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-12 mt-10">
            <div class="cust-row ingm-rw">
                <div class="cust-fld"><label class="fl-lbl">Lungs Float in Formalin</label>
                </div>
                <div class="cust-inp">
                    <select class="stl-op">
                        <option>Select</option>
                        <option>Yes</option>
                        <option>No</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
<div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="10" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Yes</option>
                    <option>No</option>
                </select>
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Location</label>
            </div>
            <div class="cust-inp">
                <input type="text" class="text-field">
            </div>
        </div>
    </div>
    <div class="col-lg-5">
        <div class="cust-row describe-rw">
            <div class="cust-fld"><label class="fl-lbl"></label>
            </div>
            <div class="cust-inp">
                <textarea id="top-area" name="" rows="5" cols="50" spellcheck="false"></textarea>
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Yes</option>
                    <option>No</option>
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Examined</option>
                    <option>NE</option>
                </select>
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="cust-row ingm-rw">
            <div class="cust-fld"><label class="fl-lbl">Spleen Findings</label>
            </div>
            <div class="cust-inp">
                <select class="stl-op">
                    <option>Select</option>
                    <option>Examined</option>
                    <option>NE</option>
                </select>
            </div>
        </div>
    </div>
    <div class="col-lg-5">
        <div class="cust-row describe-rw">
            <!--- <div class="cust-fld"><label class="fl-lbl"></label>
            </div> --->
            <div class="cust-inp">
                <input type="text" placeholder="Other" class="text-field">
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
                   <select class="stl-op">
                       <option>Select From Master Data</option>
                   </select>
               </div>
           </div>
           <div class="simple-button pt-15 align-right"><button class="upld-btn">Add New Lymph Node</button></div>
       </div>
       <div class="col-lg-2">
           <div class="cust-row ingm-rw">
               <div class="cust-fld"><label class="fl-lbl">Size Length</label>
               </div>
               <div class="cust-inp">
                <input type="text" placeholder="cm" class="text-field">
               </div>
           </div>
       </div>
       <div class="col-lg-2">
        <div class="cust-row ingm-rw">
            <div class="cust-fld"><label class="fl-lbl">Width</label>
            </div>
            <div class="cust-inp">
             <input type="text" placeholder="cm" class="text-field">
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
        <textarea id="top-area" name="" rows="10" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Yes</option>
                    <option>No</option>
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
                   <select class="stl-op">
                       <option>Select From Master Data</option>
                   </select>
               </div>
           </div>
       </div>
       <div class="col-lg-3">
           <div class="cust-row ingm-rw">
               <div class="cust-fld"><label class="fl-lbl">Left Length</label>
               </div>
               <div class="cust-inp">
                <input type="text" placeholder="cm" class="text-field">
               </div>
           </div>
           <div class="cust-row ingm-rw mt-10">
            <div class="cust-fld"><label class="fl-lbl">Right Length</label>
            </div>
            <div class="cust-inp">
             <input type="text" placeholder="cm" class="text-field">
            </div>
        </div>
       </div>
       <div class="col-lg-2">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Width</label>
            </div>
            <div class="cust-inp">
             <input type="text" placeholder="cm" class="text-field">
            </div>
        </div>
        <div class="cust-row mt-10">
            <div class="cust-fld"><label class="fl-lbl">Width</label>
            </div>
            <div class="cust-inp">
             <input type="text" placeholder="cm" class="text-field">
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
                   <select class="stl-op">
                    <option>Select</option>
                    <option>No Findings</option>
                    <option>Enlarged</option>
                    <option>Other</option>
                   </select>
               </div>
           </div>
       </div>
       <div class="col-lg-3">
           <div class="cust-row ingm-rw">
               <div class="cust-fld"><label class="fl-lbl">Length</label>
               </div>
               <div class="cust-inp">
                <input type="text" placeholder="cm" class="text-field">
               </div>
           </div>
       </div>
       <div class="col-lg-2">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Width</label>
            </div>
            <div class="cust-inp">
             <input type="text" placeholder="cm" class="text-field">
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
                   <select class="stl-op">
                    <option>Select</option>
                    <option>No Findings</option>
                    <option>Enlarged</option>
                    <option>Other</option>
                   </select>
               </div>
           </div>
       </div>
       <div class="col-lg-3">
           <div class="cust-row ingm-rw">
               <div class="cust-fld"><label class="fl-lbl">Length</label>
               </div>
               <div class="cust-inp">
                <input type="text" placeholder="cm" class="text-field">
               </div>
           </div>
       </div>
       <div class="col-lg-2">
        <div class="cust-row">
            <div class="cust-fld"><label class="fl-lbl">Width</label>
            </div>
            <div class="cust-inp">
             <input type="text" placeholder="cm" class="text-field">
            </div>
        </div>
    </div>
   </div>
</div>
<div class="row pt-30">
    <div class="col-lg-5"></div>
<div class="col-lg-7">
        <label class="fl-lbl">Comments</label>
        <textarea id="top-area" name="" rows="10" cols="120"></textarea>
        <div class="area-check align-right">
            <label class="check-cust-fld">Photographs Taken</label>
            <input type="checkbox" class="check-bxt-fld">
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
                <select class="stl-op">
                    <option>Select</option>
                    <option>Examined</option>
                    <option>NE</option>
                </select>
            </div>
        </div>
    </div>
</div>
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
}
.text-field {
    padding: 6px;
    width: 100%;
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
}
.smp-btn {
    color: #E2202C;
    text-decoration: none;
    font-size: 15px;
    font-style: normal;
    font-weight: 400;
    padding: 5px 30px;
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