<cfoutput>
    <style>
    .mammalIncidentReport .form-wrap{
        padding-top: 30px;
    }
    .mammalIncidentReport label {
        font-size: 12px;
color: ##444444;
    text-align: left !important;
    font-weight: normal;
}
/*.mammalIncidentReport .box{
border: 1px solid ##d0cece;
}*/
.mammalIncidentReport .box .form-group{
    display: inline-block;
    width: 100%;
}
.mammalIncidentReport .box .heading{
    padding-bottom: 8px;
}
.mammalIncidentReport .longlat{
    width: 90%;
    display: inline-block;
}
.mammalIncidentReport .form-group{
    margin-bottom: 10px;
}
.mammalIncidentReport .form-control {
    height: 30px;
    border-radius: 0;
    box-shadow: none;
    font-size: 12px;
}
.mammalIncidentReport .sm-heading{
    font-size: 13px;
    padding-top: 5px;
}

.mammalIncidentReport .box-imgWrap2 {
    height: 250px;
    padding: 10px;
border: 1px solid ##bdbbbb;
    display: table;
    width: 100%;
}
.file-input.file-input-new{
    display: table-cell;
    vertical-align: middle;
}
.mammalIncidentReport .box-imgWrap2 label{
    display: table-cell;
    vertical-align: middle;
    font-weight: bold;
    font-size: 14px;
    text-align: center !important;
}
.mammalIncidentReport .photobox{
    padding-bottom: 20px;
}
.mammalIncidentReport .photoorvisual .form-control{
    width: 80%;
    display: inline-block;
}
.mammalIncidentReport .detrmination .form-control.accession{
    width: 45%;
    display: inline-block;
}
.mammalIncidentReport .form-control.accession{
    width: 10%;
    display: inline-block;
}
</style>

    <cfparam name="form.name"  default="" />
    <cfparam name="form.type"  default="" />
    <cfparam name="form.PROJECT_ID" default="0">
    <cfparam name="form.sight_id" default="0">
    <cfparam name="form.hiddent_project" default="0">
    <cfparam name="form.hidden_sight" default="0">
    <cfset qProjectsId = Application.Sighting.qProjectsId()>
    <cfset getsightinglist =  Application.Sighting.getsightinglist(argumentCollection="#Form#")>
    <cfset qGetSightings=Application.Sighting.qSightningDetails(argumentCollection="#Form#")>
    <cfset dolphine_sight=Application.Sighting.getdolphinBYSight(argumentCollection="#Form#")>
    <cfset value =0>
    <cfset sightvalue=0>
    <cfset dolphin_val = 0>

        <cfset getincidents = Application.Sighting.getavaiableincidents()>

 <div id="content" class="content">
    <div class="mammalIncidentReport">
        <div class="row">
            <div class="col-md-2">
                <div class="header">
                    <div class="logo">
                        <div class="logo-wrap">
                            <img src="" alt="">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8 text-center">
                <h2>Harbor Branch Oceanographic @ Fau <br> Photo-Id Marine Mammal Incident Report</h2>
            </div>
            <div class="col-md-2">
                <div class="header">
                    <div class="logo">
                        <div class="logo-wrap">
                            <img src="" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <cfif isdefined('SESSION.incidentBack')>
                <div>
                    <h4 style="margin-left: 10px; font-weight: bold">Incident on same day can't be made</h4>
                </div>
        </cfif>
        <cfset StructDelete(Session,"incidentBack")>
            <div class="form-group">
            <form id="myform" action="" method="post" >
                <label for="sel1">Select Survey:</label>
            <select class="form-control" style="width: 200px;" id="project_val" onChange="sendForm()" name="project_id">
                <option value="0">Add New Survey</option>
            <cfloop query="qProjectsId">
                    <option value="#qProjectsId.id#" <cfif isdefined('form.project_id') and form.project_id eq qProjectsId.id>selected</cfif>>#qProjectsId.id#</option>
            </cfloop>
            </select>
            </form>
            </div>

            <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>


                    <div class="">
                    <form method="post"  id="sightform">
                        <label for="sel1">Select Sighting: </label>
                    <select name="sight_id" onchange="submitsightForm()" id="sightid" class="form-control" style="width: 300px;">
                        <option value="0">Add New Sighting</option>
                    <cfset r= getsightinglist.recordcount>
                    <cfloop query="getsightinglist">
                            <option value="#getsightinglist.ID#" <cfif getsightinglist.ID EQ  qGetSightings.ID> selected</cfif>>#r# - #getsightinglist.ID#</option>
                         <cfif  getsightinglist.ID EQ  qGetSightings.ID>
                             <cfset sightvalue = #getsightinglist.ID#>
                         </cfif>
                        <cfset r = r-1 >
                    </cfloop>
                    </select>
                            <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
                <cfset value=#form.PROJECT_ID#>
              </form>
                </div>
            </cfif>
        <div class="">
            <label for="">Search Available Incidents</label>
        <select class="form-control" style="width: 200px;" name="getIncidents" id="incidentget">
            <option value="">Select Available Incident</option>
        <cfloop query="getincidents">
                <option value="#DateFormat(Dateinserted, "mm-dd-yyyy" )#">#DateFormat(Dateinserted, "mm-dd-yyyy" )#</option>
        </cfloop>
        </select>
        </div>
                <form  action="#Application.superadmin#?ArchiveModule=Incident&Page=Generatereport&Archive" method="post" enctype="multipart/form-data">
             <input type="hidden" name="hiddent_project" id="project_hidden" value="#value#">
             <input type="hidden" name="hidden_sight"  id="sight_hidden" value="#sightvalue#">
    <div>
    <cfif #sightvalue# neq 0>
            <div class="form-group">
                <label for="sel1"> Dolphin :</label>
            <select class="form-control"   name="Dolphin_ID" id="dol_id" required>
                <option value="">Select Dolphin</option>
            <cfif #sightvalue# neq 0>
                <cfloop query="dolphine_sight" group="Code">
                        <option   value="#dolphine_sight.ID#" >#dolphine_sight.Name# | #dolphine_sight.Code#</option>
                </cfloop>
            </cfif>
            </select>
            </div>
    </cfif>
    </div>
    <!---<div class="row">--->
    <!---<div class="col-md-12 form-wrap">--->
    <!---<div class="row">--->
    <!---<!---<cfif #sightvalue# neq 0>--->--->
        <!---<!---<div class="form-group">--->--->
            <!---<!---<label for="sel1"> Dolphin :</label>--->--->
        <!---<!---<select class="form-control"   name="Dolphin_ID" id="dol_id" required>--->--->
            <!---<!---<option value="">Select Dolphin</option>--->--->
            <!---<!---<cfif #sightvalue# neq 0>--->--->
            <!---<!---<cfloop query="dolphine_sight" group="Code">--->--->
                    <!---<!---<option   value="#dolphine_sight.ID#" >#dolphine_sight.Name# | #dolphine_sight.Code#</option>--->--->
            <!---<!---</cfloop>--->--->
            <!---<!---</cfif>--->--->
            <!---<!---</select>--->--->
            <!---<!---</div>--->--->
     <!---<!---</cfif>--->--->
    <!---<!---<div class="form-group">--->--->
    <!---<!---<label class="control-label col-sm-2">HBOI MMRC MMIR##:</label>--->--->
        <!---<!---<div class="col-sm-10">--->--->
            <!---<!---<input type="text"  class="form-control" name="hboi" id="hbnum"  placeholder="Enter HBOI MMRC MMIR">--->--->
        <!---<!---</div>--->--->
    <!---<!---</div>--->--->
    <!---</div>--->
        <!---<div class="row">--->
            <!---<div class="">--->
                <!---<div class="form-group">--->
                    <!---<label class="control-label col-sm-2">Common Name:</label>--->
                    <!---<div class="col-sm-3">--->
                        <!---<input type="text" class="form-control" name="cname" id="comname" placeholder="Common Name">--->
                    <!---</div>--->
                    <!---<label class="control-label col-sm-1">Genus:</label>--->
                    <!---<div class="col-sm-3">--->
                        <!---<input type="text" class="form-control" id="genus" name="genious" placeholder="Genus">--->
                    <!---</div><label class="control-label col-sm-1">Species:</label>--->
                    <!---<div class="col-sm-2">--->
                        <!---<input type="text" class="form-control"  id="spec" name="spec" placeholder="Species">--->
                    <!---</div></div>--->
            <!---</div>--->
        <!---</div>--->
        <!---<div class="row">--->
            <!---<div class="form-group"><label class="control-label col-sm-2">Examinar Name:</label><div class="col-sm-4">--->
                <!---<input type="text" class="form-control" id="exam" name="examinar" placeholder="Examinar Name">--->
            <!---</div><label class="control-label col-sm-1">Affiliation:</label>--->
                <!---<div class="col-sm-5">--->
                    <!---<input type="text" class="form-control" id="affiliat" name="affiliate" placeholder="Affiliation">--->
                <!---</div></div>--->
        <!---</div>--->
        <!---<div class="row">--->
            <!---<div class="form-group">--->
                <!---<label class="control-label col-sm-2">Addrress:</label><div class="col-sm-4">--->
                <!---<textarea class="form-control" id="addr" name="address" placeholder="Addrress"></textarea>--->
            <!---</div><label class="control-label col-sm-1">Phone:</label>--->
                <!---<div class="col-sm-5">--->
                    <!---<input type="text" class="form-control" id="phn" name="phone" placeholder="Phone">--->
                <!---</div></div>--->
        <!---</div>--->
        <!---<div class="row">--->
            <!---<div class="form-group">--->
                <!---<label class="control-label col-sm-2" >Research Authorization Number:</label>--->
                <!---<div class="col-sm-10">--->
                    <!---<input type="text"  class="form-control" id="researchthrz" name="rauthorize"  placeholder="Research Authorization Number">--->
                <!---</div>--->
            <!---</div>--->
        <!---</div>--->
<!------>
    <!---</div>--->
    <!---</div>--->
        <div class="row">
			<div class="col-sm-12">
				<div class="heading text-center">
					<h4 style="padding-bottom: 20px; font-weight: bold">Location of Initial Observation</h4>
				</div>
			</div>
            <div class="col-sm-4 box">
                <div class="row">
                    <div class="form-group">
                        <label class="control-label col-sm-3" >State:</label>
                        <div class="col-sm-9">
                            <select name="state" id="">
                                <option value="" selected="selected">Select a State</option>
                                <option value="Alabama">Alabama</option>
                                <option value="Alaska">Alaska</option>
                                <option value="Arizona">Arizona</option>
                                <option value="Arkansas">Arkansas</option>
                                <option value="California">California</option>
                                <option value="Colorado">Colorado</option>
                                <option value="Connecticut">Connecticut</option>
                                <option value="Delaware">Delaware</option>
                                <option value="Columbia">District Of Columbia</option>
                                <option value="Florida">Florida</option>
                                <option value="Georgia">Georgia</option>
                                <option value="Hawaii">Hawaii</option>
                                <option value="Idaho">Idaho</option>
                                <option value="Illinois">Illinois</option>
                                <option value="Indiana">Indiana</option>
                                <option value="Iowa">Iowa</option>
                                <option value="Kansas">Kansas</option>
                                <option value="Kentucky">Kentucky</option>
                                <option value="Louisiana">Louisiana</option>
                                <option value="Maine">Maine</option>
                                <option value="Maryland">Maryland</option>
                                <option value="Massachusetts">Massachusetts</option>
                                <option value="Michigan">Michigan</option>
                                <option value="Minnesota">Minnesota</option>
                                <option value="Mississippi">Mississippi</option>
                                <option value="Missouri">Missouri</option>
                                <option value="Montana">Montana</option>
                                <option value="Nebraska">Nebraska</option>
                                <option value="Nevada">Nevada</option>
                                <option value="New Hampshire">New Hampshire</option>
                                <option value="New Jersey">New Jersey</option>
                                <option value="New Mexico">New Mexico</option>
                                <option value="New York">New York</option>
                                <option value="North Carolina">North Carolina</option>
                                <option value="North Dakota">North Dakota</option>
                                <option value="Ohio">Ohio</option>
                                <option value="Oklahoma">Oklahoma</option>
                                <option value="Oregon">Oregon</option>
                                <option value="Pennsylvania">Pennsylvania</option>
                                <option value="Rhode Island">Rhode Island</option>
                                <option value="South Carolina">South Carolina</option>
                                <option value="South Dakota">South Dakota</option>
                                <option value="Tennessee">Tennessee</option>
                                <option value="Texas">Texas</option>
                                <option value="Utah">Utah</option>
                                <option value="Vermont">Vermont</option>
                                <option value="Virginia">Virginia</option>
                                <option value="Washington">Washington</option>
                                <option value="West Virginia">West Virginia</option>
                                <option value="Wisconsin">Wisconsin</option>
                                <option value="Wyoming">Wyoming</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" >Country:</label>
                        <div class="col-sm-9">
                            <select class="form-control" name="country" id="">
                                <option value="">Select Country</option>
                                <option value="USA">US</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" >City:</label>
                        <div class="col-sm-9">
                            <input type="text" name="city" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" >Body of Water:</label>
                        <div class="col-sm-9">

                            <input type="text" id="bodywater" name="water_body"  class="form-control"  placeholder="Body of Water">
                        </div>
                    </div>
                </div>
            </div>
			<div class="col-sm-4 box">
				<div class="row">
					<div class="form-group">
                        <label class="control-label col-sm-3" >Locality Details:</label>
                        <div class="col-sm-9">
                            <textarea class="form-control" id="locdetails" name="locdetails" placeholder="Locality Details"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" >Lat (DD):</label>
                        <div class="col-sm-9">
                            <input type="text"  class="form-control longlat" id="lat" name="latitude" placeholder="Latitude"><span><b> N</b></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" >Long (DD):</label>
                        <div class="col-sm-9">
                            <input type="text"  class="form-control longlat" id="lon" name="longitude" placeholder="Longitude"><span><b> W</b></span>
                        </div>
                    </div>
				</div>
			</div>
			<div class="col-sm-4 box">
				<div class="row">
					<div class="form-group">
                        <label class="control-label col-sm-12 sm-heading" ><b>Discoverd during:</b></label>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" >Research Survey</label>
                        <div class="col-sm-9">
                            <input type="radio" id="rsurvey"   name="researchsurvey" value="1" checked> <label for="yes"> Yes</label>
                            &nbsp;&nbsp;<input type="radio"  id="rsurvey" name="researchsurvey" value="0">  <label for="no"> No</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" >Other:</label>
                        <div class="col-sm-9">
                            <textarea class="form-control" id="othrz" name="othr" placeholder="Other"></textarea>
                        </div>
                    </div>
				</div>
			</div>
        </div>
        <div class="row">
            <div class="col-sm-6 box" >
                <div class="row">
                    <div class="heading">
                        <h4> &nbsp;Initial Observation</h4>
                    </div>
                        <label class="control-label col-sm-2" >Date</label>
                    <div class="form-group">
                        <label class="control-label col-sm-2" >Year</label>
                        <div class="col-sm-3">
                            <input type="text"  class="form-control" id="yaer" name="year" placeholder="year">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" >Month</label>
                        <div class="col-sm-3">
                            <input type="text"  class="form-control" id="mnoth" name="month" placeholder="Month">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" >Day</label>
                        <div class="col-sm-3">
                            <input type="text"  class="form-control" id="da" name="day"  placeholder="Day">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-12 sm-heading" ><b>First Observed:</b></label>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-8">
                            <input type="radio" id="obs1"   name="observedplace" value="0" checked> <label for=""> Beach or Land</label>
                            &nbsp;&nbsp;<br>
                            <input type="radio" id="obs2"   name="observedplace" value="1"> <label for=""> Floating</label>
                            &nbsp;&nbsp;<br>
                            <input type="radio" id="obs3"  name="observedplace" value="2"> <label for=""> Swimming</label>
                            &nbsp;&nbsp;
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 box photoorvisual">
                <div class="row">
                    <div class="heading">
                        <h4> &nbsp;PHOTOGRAPHS (or visual comments)</h4>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <input type="Checkbox"  id="lefbox"  name="lefts" value="1"> <label for=""> Left Side:</label>
                                &nbsp;&nbsp; <input type="text" id="leftdes" class="form-control" name="leftdes">
                            </div>
                            <div class="form-group">
                                <input type="Checkbox"  id="rightbox"  name="rights" value="1"> <label for=""> Right Side:</label>
                                &nbsp;&nbsp; <input type="text" id="rightdes" class="form-control" name="rightdescription">
                            </div>
                            <div class="form-group">
                                <input type="Checkbox"  id="pend"  name="pendu" value="1"> <label for=""> Penduncle:</label>
                                &nbsp;&nbsp; <input type="text" id="pendes" class="form-control" name="pendescription">
                            </div>
                            <div class="form-group">
                                <input type="Checkbox"  id="fluk"  name="fluku" value="1"> <label for=""> Flukes:</label>
                                &nbsp;&nbsp; <input type="text" id="flukdes" class="form-control" name="flukdescription">
                            </div>
                            <div class="form-group">
                                <input type="Checkbox"   id="vido" name="vido" value="1"> <label for=""> Video:</label>
                                &nbsp;&nbsp; <input type="text" id="viddes" class="form-control" name="videscription">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6 box">
                <div class="row">
                    <div class="heading">
                        <h4> &nbsp;CAUSE FOR CONCERN</h4>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <input type="Checkbox"  id="rds"  name="rds" value="1"> <label for=""> RDS</label>
                                    &nbsp;&nbsp;
                                </div>
                                <div class="form-group">
                                    <input type="Checkbox" id="emact"   name="emaction" value="1"> <label for=""> Emaciation</label>
                                    &nbsp;&nbsp;
                                </div>
                                <div class="form-group">
                                    <input type="Checkbox" id="abnrml"   name="abnrml" value="1"> <label for=""> Abnormal Behaivior</label>
                                    &nbsp;&nbsp;
                                </div>
                                <br>
                                <div class="form-group">
                                    <label class="control-label  sm-heading"  ><b>Fresh wound:</b></label>
                                </div>
                                <div class="form-group">
                                    <input type="Checkbox" id="shark"  name="shark" value="1"> <label for=""> Shark</label>
                                    &nbsp;&nbsp;
                                </div>
                                <div class="form-group">
                                    <input type="Checkbox" id="boathit"  name="boathit" value="1"> <label for=""> boathit</label>
                                    &nbsp;&nbsp;
                                </div>
                                <div class="form-group">
                                    <input type="Checkbox" id="cbd"  name="cbd" value="1"> <label for=""> CBD</label>
                                    &nbsp;&nbsp;
                                </div>
                                <br>
                                <div class="form-group">
                                    <label class="control-label col-sm-3">Description:</label>
                                    <div class="col-sm-9">
                                        <textarea class="form-control" name="dscrptn" placeholder="Description"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 box detrmination">
                <div class="row">
                    <div class="heading">
                        <h4> &nbsp;BEHAVIOUR OBSERVATIONAS</h4>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group">
                             <label for=""> Respiration Rate (5 minutes):</label>
                            <input type="text" class="form-control" name="respiration">
                        </div>
                        <div class="form-group">
                            <label class="control-label  sm-heading"><b>Behaviour:</b></label>
                        </div>
                        <div class="form-group">
                            <input type="Checkbox" name=""> <label for=""> Unknown:</label> &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Male:</label>
                            &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Unknown:</label> &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Male:</label>
                            &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Unknown:</label> &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Male:</label>
                            &nbsp;&nbsp;
                        </div>
                        <div class="form-group">
                            <input type="Checkbox" name=""> <label for=""> Unknown:</label> &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Male:</label>
                            &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Unknown:</label> &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Male:</label>
                            &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Unknown:</label> &nbsp;&nbsp;
                            <input type="Checkbox" name=""> <label for=""> Male:</label>
                            &nbsp;&nbsp;
                        </div>
                        <br>
                        <div class="form-group">
                            <label class="control-label col-sm-3" >Other Notes:</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" name="observationother" placeholder="Other Notes"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6 box">
                <div class="row">
                    <div class="heading">
                        <h4> &nbsp;LIFE HISTORY DATA</h4>
                    </div>


                        <!---get sighting --->

                    <div class="">
                        <label class="control-label col-sm-12 sm-heading" ><b> Sex:</b></label>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <input type="Checkbox" id="unkn"  name="unknowns"> <label for=""> Unknown:</label> &nbsp;&nbsp;
                                <input type="Checkbox" id="ml"  name="males"> <label for=""> Male:</label>
                                &nbsp;&nbsp;
                                <input type="Checkbox"  id="fml"  name="females"> <label for=""> Female:</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" >Identity Code:</label>
                            <div class="col-sm-9">

                                <input type="text" name="idcode" id="icode">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" >Age (or age class):</label>
                            <div class="col-sm-9">
                                <input type="text"  class="form-control "  name="ageorglass">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" >Home Range:</label>
                            <div class="col-sm-9">
                                <input type="text"  class="form-control "  name="homerange">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-6" >Year identified and Number of Sightings:</label>
                            <div class="col-sm-6">
                                <input type="text"  class="form-control" id="countt" name="sightingsnumb">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-6" >Date of Last Sighting without Incident:</label>
                            <div class="col-sm-6">
                                <input type="text"  class="form-control" id="lastdate" name="lastsight" >
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 box detrmination">
                <div class="row">
                    <div class="heading">
                        <h4> &nbsp;DETERMINATIONS</h4>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group">
                            <input type="Checkbox"   name="followup" value="1"> <label for=""> Follow-Up needed?:</label>
                        </div>
                        <div class="form-group">
                            <input type="Checkbox"   name="noaa" value="1"> <label for=""> NOAA MMHSRP accession number assigned?:</label>
                            <input type="text" class="form-control  accession" name="accession">
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" >Other Notes:</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" placeholder="Other Notes" name="determnotes"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<div class="row">
			<div class="col-sm-8 box photobox">
                <div class="row">
                    <div class="heading">
                        <h4> &nbsp;PHOTOGRAPHS</h4>
                    </div>
                    <div class="col-sm-6">
                        <div class="box-imgWrap2">
                            <img src="" alt="" width="300px" height="300px" id="hide-image1" style="display: none">
                            <label for="image2">Click to add Photo</label>
                            <input id="input-6" name="image1" type="file" class="">
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="box-imgWrap2">
                            <img src="" alt="" id="hide-image2" width="300px" height="300px" style="display: none">
                            <label for="image1">Click to add Photo</label>
                            <input id="input-7" name="image2" type="file" class="">
                        </div>
                    </div>
                </div>
            </div>
		</div>			
    <input   class="btn btn-success" value="Update" name="generatepdf" type="submit">
</form>
    </div>
</div>
</cfoutput>


