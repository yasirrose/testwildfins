<cfparam name="form.PROJECT_ID" default="0">
<cfif Page eq 'EditDolphin' >
    <cfset getsightinglist=Application.Dolphin.getsightingByDolphin(argumentCollection="#Form#")>
</cfif>
<cfset getTeams=Application.Sighting.getTeams()>
<cfset getBiopsyBehavior = Application.Dolphin.getBiopsyBehavior()>
<cfset getHitLocation=Application.Dolphin.getHitLocation()>
<cfset getMissDescriptors=Application.Dolphin.getMissDescriptors()>
<cfset getHitDescriptors=Application.Dolphin.getHitDescriptors()>
<cfset getSubSampleType=Application.Dolphin.getSubSampleType()>
<cfset qgetResearchTeamMembers = Application.StaticData.getResearchTeamMembers()>


<cfset getprojectTeamnames = Application.Sighting.getprojectTeams(form.PROJECT_ID)>

<cfparam name="form.id" default="0">
<cfparam name="qGetSightings.id" default="0">

<cfif Page eq 'Home' >
    <cfset dolphine_sight=Application.Sighting.getdolphinBYSight(argumentCollection="#Form#")>
</cfif>
<style>
    .box_01 {
        float: left;
        margin-right: 4px;
        width: 75px;
    }
    .select2.select2-container {
        width: 100% !important;
    }
    .scroe-bttn > li {
        margin-right:7px !important;
    }
    .main-form-section .inner-border-box {
        background-color: #fff;
        border: 1px solid;
        padding: 9px 10px 5px;
    }
    .radioBtn {
        margin-bottom: 31px;
    }
    .behavior .form-group {
        display: inline-block;
    }
</style>

<cfoutput>
    <div <cfif qGetSightings.id GT 0 and Page eq 'Home' >id="biopsylist"</cfif>  <cfif Page eq 'EditDolphin' >id="biopsylist"</cfif> class="modal fade" role="dialog">

    <div class="modal-dialog">
        <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Biopsy Shot Sheet</h4>
        </div>
    <div class="modal-body">
      <div>
       <cfif Page eq 'Home'>
               <a class="btn btn-primary pull-right m-r-5" id="mybiopsy"> Add Biopsy</a>
       </cfif>
    </div>
    <br>
        <br><br>

            <div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff">
                <div class="col-md-3">Dophin Name</div>
                <div class="col-md-3">Code</div>
                <div class="col-md-3">ShotNumber</div>
                <div class="col-md-3">Sex</div>
            </div>
            <div class="row">

            <div class="col-md-12 panel-heading p-10 m-b-5 appendhere" style="background:##ccc;">

             </div>

         </div>
    </div>
    </div>
    </div>
</div>
    <div <cfif qGetSightings.id GT 0 and Page eq 'Home' >id="biopsyid"</cfif>  <cfif Page eq 'EditDolphin' >id="biopsyid"</cfif> class="modal fade" role="dialog">
<div class="modal-dialog">
    <!-- Modal content-->
<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Biopsy Shot Sheet</h4>
    </div>
<div class="modal-body">
<div class="row  p-10">
    <cfif Page eq 'Home' >
            <a class="btn btn-primary pull-right biopsy-list" style="margin-left:5px;" >Biopsy List</a>
            <a class="btn btn-success pull-right dolphin-modal" >Dolphin</a>
                <a class="btn btn-primary pull-right m-r-5" href="#Application.superadmin#?ArchiveModule=Sighting&Page=Biopsy&Archive" target="_blank" id="Viewbiopsy">View Biopsy</a>
    </cfif>
    <cfif Page eq 'EditDolphin' >
        <button type="button" class="btn  btn-primary  pull-right" dolphinID='#form.id#' id="viewbtn_Biopsy">View Biopsy</button>
        <button type="button" class="btn  btn-primary  pull-right  m-r-2" id="addbtn_Biopsy">Add Biopsy</button>
    </cfif>
    </div>
        <div class="alert alert-success message"  style="display:none">

        </div>
        <div class="row listBiopsy_disp" style="display:none">

            <table class="table table-bordered table-hover" data-order="[[1,&quot;asc&quot;]]" id="example">
                <thead>
                <tr class="inverse">
                    <th>Sighting ID</th>
                    <th>Shot Number</th>
                    <th>Sample Number</th>
                    <th>Outcome</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody id="listBiopsyBYdolphin">


                </tbody>
            </table>
        </div>

    <div class="addBiopsy_disp">
    <form role="form"  method="post" id="biopsyform">
<!---------- 1st row------------------->
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <button type="button" class="btn  btn-primary    m-r-2" id="shotnumber1">Shot 1</button>
                    <button type="button" class="btn  btn-primary    m-r-2" id="shotnumber2">Shot 2</button>
                    <button type="button" class="btn  btn-primary    m-r-2" id="shotnumber3">Shot 3</button>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <input type="text" class="form-control" style="display: none" id="shot" name="ShotNumber"  min='0' max='255' value="">
                </div>
            </div>
        </div>
    <div class="row">
    <cfif Page eq 'EditDolphin' >
            <div class="col-md-12">
            <div class="form-group">
                <label for="sel1">Sighting ID:</label>
            <select class="form-control"  id="Sighting_ID" name="Sighting_ID" required>
                <option value="0">Select Sighting</option>
            <cfloop query="getsightinglist">
                    <option value="#getsightinglist.Sighting_ID#" >#getsightinglist.Sighting_ID#</option>
            </cfloop>
            </select>
            </div>
            </div>
    </cfif>
    <cfif Page eq 'Home' >
            <div class="col-md-12">
            <div class="form-group">
                <label for="sel1"> Dolphin :</label>
            <select class="form-control"   name="Dolphin_ID" required id="door">
                <option value="">Select Dolphin</option>
                <option value="3668">Unknown Dolphin</option>
                <cfloop query="dolphine_sight">
                        <option   value="#dolphine_sight.ID#" >#dolphine_sight.Name# | #dolphine_sight.Code#</option>
                </cfloop>
            </select>
            </div>
            </div>
    </cfif>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="pwd">Time:</label>
                <input type="text" class="form-control timepicker" name="ShotTime" id="shttm">
            </div>
        </div>
    <div class="col-md-6">
    <div class="form-group team">
        <label for="email">Team:</label>
    <select class="form-control search-box" multiple="multiple" name="BiopsyTeam">
    <cfloop query="getprojectTeamnames">
            <option value="#getprojectTeamnames.RT_ID#">#getprojectTeamnames.RT_MemberName#</option>
    </cfloop>
    </select>
    </div>
    </div>
    </div>
    <div class="row">
    <div class="col-md-6">
    <div class="form-group">
        <label for="email">Target Response Behavior 1:</label>
    <select class="form-control " name="TargetResponseBehavior1" id="bhv1">
        <option value="">Target behavior response</option>
    <cfloop query="getBiopsyBehavior">
            <option value="#getBiopsyBehavior.ObservedResponse#">#getBiopsyBehavior.ObservedResponse#</option>
    </cfloop>
    </select>
    </div>
    </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="pwd">Target Response Level 1</label>
                <input type="text" readonly id="tgtr1" class="form-control" name="TargetLevel1" value="">
            </div>
        </div>
    </div>
    <div class="row">
    <div class="col-md-6">
    <div class="form-group">
        <label for="email">Target Response Behavior 2:</label>
    <select class="form-control" name="TargetResponseBehavior2" id="bhv2">
        <option value="">Target behavior response</option>
    <cfloop query="getBiopsyBehavior">
            <option value="#getBiopsyBehavior.ObservedResponse#">#getBiopsyBehavior.ObservedResponse#</option>
    </cfloop>
    </select>
    </div>
    </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="pwd">Target Response Level 2</label>
                <input type="text" readonly id="tgtr2" class="form-control" name="TargetLevel2" value="">
            </div>
        </div>
    </div>
    <div class="row">
    <div class="col-md-6">
    <div class="form-group">
        <label for="email">Target Response Behavior 3:</label>
    <select class="form-control " name="TargetResponseBehavior3" id="bhv3">
        <option value="">Target behavior response</option>
    <cfloop query="getBiopsyBehavior">
            <option value="#getBiopsyBehavior.ObservedResponse#">#getBiopsyBehavior.ObservedResponse#</option>
    </cfloop>
    </select>
    </div>
    </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="pwd">Target Response Level 3</label>
                <input type="text" readonly id="tgtr3" class="form-control" name="TargetLevel3" value="">
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="pwd">Group Size:</label>
                <input type="text" class="form-control" name="groupSize" id="grpsz">
            </div>
        </div>
    <div class="col-md-6">
    <div class="form-group">
        <label for="pwd">Arbalester :</label>
    <select class="form-control " name="Arbalester">
        <option value=""> SelectArbalester </option>
    <cfloop query="qgetResearchTeamMembers">
            <option value="#qgetResearchTeamMembers.RT_ID#">#qgetResearchTeamMembers.RT_MemberName#</option>
    </cfloop>
    </select>
    </div>
    </div>


    </div>
    <div class="row">
    <div class="col-md-6">
    <div class="form-group">
        <label for="email">Group Response Behavior :</label>
    <select class="form-control " name="GroupResponseBehavior1" id="grprp1">
        <option value="">Target behavior response</option>
    <cfloop query="getBiopsyBehavior">
            <option value="#getBiopsyBehavior.ObservedResponse#">#getBiopsyBehavior.ObservedResponse#</option>
    </cfloop>
    </select>
    </div>
    </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="pwd">Group Response Level </label>
                <input type="text" readonly id="grp1" class="form-control" name="GroupLevel1" value="">
            </div>
        </div>
    </div>

        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="email" style="display:block">Outcome:</label>
                    <div class="radioBtn">
                        <input type="radio" class="radio-inline" name="Outcome"  maxlength="1" value="1" id="hitOutcome"> Hit
                        <input type="radio" class="radio-inline" name="Outcome"  maxlength="1" value="0" id="missOutcome"> Miss
                    </div>
                </div>
            </div>
        </div>

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="pwd">Shot Distance (Ft):</label>
                <input type="text" class="form-control" name="ShotDistance">
            </div>
        </div>
    <div class="col-md-6">
    <div class="form-group">
    <label for="email">Sample##:</label>
    <input type="text" class="form-control" name="SampleNumber"   maxlength="50">
</div>
</div>
</div>

<div class="row">
<div class="col-md-6">
<div class="form-group" id="missDescriptor" style="display:none">
    <label for="pwd">Hit Descriptor:</label>
<select class="form-control " name="missDescriptor">
    <option value="0">Select Hit Descriptor</option>
    <cfloop query="getMissDescriptors">
            <option value="#ID#">#MissDescriptors#</option>
    </cfloop>
    </select>
    </div>
    </div>
        <!---<div class="col-md-6">--->
            <!---<div class="form-group" id="missDistance" style="display:none">--->
                <!---<label for="pwd">Miss-Distance:</label>--->
                <!---<input type="text" class="form-control" name="missDistance"  min='0' max='255'>--->
            <!---</div>--->
        <!---</div>--->
    </div>
    <div class="row">

    <div class="col-md-6">
    <div class="form-group" id="hitDescriptor" style="">
        <label for="pwd">Shot Descriptor:</label>
    <select class="form-control " name="hitDescriptor" id="htdscrp">
        <option value="0">Select Shot Descriptor</option>
        <cfloop query="getHitDescriptors">
                <option value="#ID#">#HitDescriptors#</option>
        </cfloop>
    </select>
    </div>
    </div>
    </div>
<!--- row end ---->

        <div class="row">

        <div class="col-md-6">

        <div class="form-group" id="hitlocati" style="display:none">
            <label for="email">Hit location:</label>
        <select class="form-control " name="HitLocation" id="hitloc">
            <option value="0">Select Hit location</option>
        <cfloop query="getHitLocation">
                <option value="#ID#">#HitLocationAbbreviation#</option>
        </cfloop>
        </select>
        </div>
        <div class="form-group">
            <label for="email">Sub-Sample tissue type:</label>
        <select class="form-control " name="SubSample" id="subsmpl">
            <option value="0">Select Sub Sample</option>
        <cfloop query="getSubSampleType">
                <option value="#ID#">#TissueType# - #IntendedAnalysis#</option>
        </cfloop>
        </select>
        </div>
            <div class="form-group">
                <label for="email">Processor :</label>
               <select class="form-control"  name="Processor" id="process">
              <option value="">select processor</option>
                <cfloop query="getprojectTeamnames">
                        <option value="#getprojectTeamnames.RT_ID#">#getprojectTeamnames.RT_MemberName#</option>
                </cfloop>
                </select>
            </div>

            <div class="form-group">
                <label for="email">Sample Length(mm) :</label>
                <input type="text" class="form-control" id="smplngth" name="SampleLength" >
            </div>
            <div class="form-group">
                <label for="email">Skin  DMSO:</label>
                <input type="checkbox" class="radio-inline" name="SkinDMSO"   value="1">
            </div>

            <div class="form-group">
                <label for="email">Skin  RNAlater</label>
                <input type="checkbox" class="radio-inline" name="SkinRNAlater"   value="1">
            </div>


        </div><!--- col-md-6 end ---->


            <div class="col-md-6">



                <div class="form-group">
                    <label for="email">Sample Taken:</label>
                    <input type="radio" class="radio-inline" name="SampleTaken"   value="1"> Yes
                    <input type="radio" class="radio-inline" name="SampleTaken"   value="0"> No
                </div>

                <div class="form-group">
                    <label for="email">Sample head:</label>
                    <input type="radio" class="radio-inline" name="Samplehead"   value="1"> M8
                    <input type="radio" class="radio-inline" name="Samplehead"   value="0"> M11
                </div>

                <div class="form-group">
                    <label for="email">Sample Collected :</label>
                    <input type="radio" class="radio-inline" name="SampleCollected"   value="1"> Full
                    <input type="radio" class="radio-inline" name="SampleCollected"   value="0"> Partial
                </div>

                <div class="form-group">
                    <label for="email">Blubber  Teflon vial (Time in LN2)  :</label>
                    <input type="checkbox" class="radio-inline" name="BlubberTeflonVial"   value="1">
                </div>

                <div class="form-group">
                    <label for="email">Blubber  Cryovial, red   (Store in LN2) :</label>
                    <input type="checkbox" class="radio-inline" name="BlubberCryovialRed"   value="1">
                </div>
                <div class="form-group">
                    <label for="email">Blubber  Cryovial, blue (Store in LN2) :</label>
                    <input type="checkbox" class="radio-inline" name="BlubberCryovialBlue"   value="1">
                </div>

                <div class="form-group">
                    <label for="email">Skin  D Cryovial, green </label>
                    <input type="checkbox" class="radio-inline" name="SkinDCryovial"   value="1">
                </div>

            </div><!--- col-md-6 end ---->
        </div><!--- row end ---->

<!---------- 2nd row------------------->
        <div class="row">
        <div class="col-md-6 behavior">
        <div class="form-group clearfix">
            <h4>Target Animal Activity:</h4>
        <div class="inner-border-box">
            <label>Pre-Biopsy 1:</label>
        <div class="form-group activity-top-40 m-t-10">
        <div class="box_01"> Mill
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_Mill">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Feed
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_Feed">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Prob. Feed
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_ProbFeed">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Travel
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_Travel">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Play
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_Play">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        </div>
        <div class="form-group">
        <div class="inline-box input-box">
        <div class="box_01"> Rest
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_ACTIVITY_REST">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Leap
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_Leap_tailslap_chuff">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Social
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_Social">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Boat
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_ACTIVITY_WITHBOAT">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Other
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_Other">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Avoid Boat
        <select class="form-control Pre-Biopsy1" id="value" name="TABPre_Activity_Avoid_Boat">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Depre dation
        <select class="form-control Pre-Biopsy1"  name="TABPre_Depredation">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Herding
        <select class="form-control Pre-Biopsy1"  name="TABPre_Herding">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>
        </div>
        </div>
        </div>
        </div>

        <div class="form-group clearfix">
            <h4>Group Behavior:</h4>
        <div class="inner-border-box">
            <label>Pre-Biopsy 1:</label>
        <div class="form-group activity-top-40 m-t-10">
        <div class="box_01"> Mill
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_Mill">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Feed
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_Feed">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Prob. Feed
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_ProbFeed">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Travel
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_Travel">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Play
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_Play">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        </div>
        <div class="form-group">
        <div class="inline-box input-box">
        <div class="box_01"> Rest
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_ACTIVITY_REST">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Leap
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_Leap_tailslap_chuff">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Social
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_Social">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Boat
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_ACTIVITY_WITHBOAT">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Other
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_Other">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Avoid Boat
        <select class="form-control Pre-BiopsyG1" id="value" name="GBPre_Activity_Avoid_Boat">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Depre dation
        <select class="form-control Pre-BiopsyG1"  name="GBPre_Depredation">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Herding
        <select class="form-control Pre-BiopsyG1"  name="GBPre_Herding">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1 >
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>

        </div>
        </div>

        </div>

        </div>
        </div><!--- col-md-6 end ---->

            <div class="col-md-6 behavior">

            <div class="form-group clearfix">
            <div class="inner-border-box">
                <br><br>
                <label>Post-Biopsy 1:</label>
            <div class="form-group activity-top-40 m-t-10">
            <div class="box_01"> Mill
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_Mill">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#"  >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Feed
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_Feed">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">

                <cfset i = i - 1 >
                    <option value="#i#"  >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Prob. Feed
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_ProbFeed">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Travel
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_Travel">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Play
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_Play">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>
            </div>
            <div class="form-group">
            <div class="inline-box  input-box">
            <div class="box_01"> Rest
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_ACTIVITY_REST">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#"  >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Leap
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_Leap_tailslap_chuff">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Social
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_Social">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#"  >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Boat
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_ACTIVITY_WITHBOAT">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#">#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Other
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_Other">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>

            <div class="box_01"> Avoid Boat
            <select class="form-control Post-Biopsy1" id="value" name="TABPost_Activity_Avoid_Boat">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#">#i#</option>
            </cfloop>
            </select>
            </div>

            <div class="box_01"> Depre dation
            <select class="form-control Post-Biopsy1"  name="TABPost_Depredation">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>

            <div class="box_01"> Herding
            <select class="form-control Post-Biopsy1"  name="TABPost_Herding">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#">#i#</option>
            </cfloop>
            </select>
            </div>

            </div>
            </div>

            </div>
            </div>

            <div class="form-group clearfix">
            <div class="inner-border-box">
                <label>Post-Biopsy 1:</label>
            <div class="form-group activity-top-40 m-t-10">
            <div class="box_01"> Mill
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_Mill">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#"  >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Feed
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_Feed">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#"  >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Prob. Feed
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_ProbFeed">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Travel
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_Travel">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Play
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_Play">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>
            </div>
            <div class="form-group">
            <div class="inline-box  input-box">
            <div class="box_01"> Rest
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_ACTIVITY_REST">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#"  >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Leap
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_Leap_tailslap_chuff">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Social
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_Social">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#"  >#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Boat
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_ACTIVITY_WITHBOAT">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#">#i#</option>
            </cfloop>
            </select>
            </div>
            <div class="box_01"> Other
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_Other">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>

            <div class="box_01"> Avoid Boat
            <select class="form-control Post-BiopsyG1" id="value" name="GBPost_Activity_Avoid_Boat">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#">#i#</option>
            </cfloop>
            </select>
            </div>

            <div class="box_01"> Depre dation
            <select class="form-control Post-BiopsyG1"  name="GBPost_Depredation">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#" >#i#</option>
            </cfloop>
            </select>
            </div>

            <div class="box_01"> Herding
            <select class="form-control Post-BiopsyG1"  name="GBPost_Herding">
                <option selected="" value="-1"></option>
            <cfloop from="1" to="6" index="i">
                <cfset i = i - 1 >
                    <option value="#i#">#i#</option>
            </cfloop>
            </select>
            </div>

            </div>
            </div>
            </div>
            </div>

            </div> <!--- col-md-6 end ---->

        </div> <!--- row end ---->

<!---------3rd row-------------->



    <div class="row">
    <div class="col-md-4 m-t-10">

    <cfif Page eq 'EditDolphin' >
            <input type="hidden" name="Dolphin_ID"  value="#form.id#">
    </cfif>
    <cfif Page eq 'Home' >
            <input type="hidden" class="form-control" name="Sighting_ID" value="#qGetSightings.id#">
    </cfif>

        <button name="addBiopsy" class="btn btn-success" type="submit">Submit</button>
        <button class="btn btn-default" id="BiopsyReset" type="reset">Reset</button>
    </div>
    </div>

    </form>
        <div class="clearfix"></div>
    </div>


    </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
    </div>

    </div>
    </div>
</cfoutput>
