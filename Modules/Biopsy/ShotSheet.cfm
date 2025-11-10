<div id="content" class="content">
    <h2 style="text-align: center">Biopsy Shot Sheet
    </h2>
<cfoutput>
    <cfparam name="form.project_id" default="0">
    <cfparam name="form.sight_id" default="0">
    <cfset qProjectsId = Application.Sighting.qProjectsId()>
    <cfset qGetSightings=Application.Sighting.qSightningDetails(argumentCollection="#Form#")>
    <cfset getshotsdetail = Application.Dolphin.getShotDetails()>
    <cfset getsightinglist =  Application.Sighting.getsightinglist(argumentCollection="#Form#")>
    <cfset getTeams=Application.Sighting.getTeams()>
    <cfset getBiopsyBehavior = Application.Dolphin.getBiopsyBehavior()>
    <cfset getHitLocation=Application.Dolphin.getHitLocation()>
    <cfset getMissDescriptors=Application.Dolphin.getMissDescriptors()>
    <cfset getHitDescriptors=Application.Dolphin.getHitDescriptors()>
    <cfset getSubSampleType=Application.Dolphin.getSubSampleType()>
    <cfset qgetResearchTeamMembers = Application.StaticData.getResearchTeamMembers()>
    <cfif Page eq 'ShotSheet'>
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
              background-color: ##fff;
              border: 1px solid;
              padding: 9px 10px 5px;
          }
          .radioBtn {
              margin-bottom: 31px;
          }
          .behavior .form-group {
              display: inline-block;
          }
            .col-md-12.chkbxs_mrgn_adj .form-group {
                    margin-bottom: 8px;
              }
        </style>
    <cfset getprojectTeamnames = Application.Sighting.getprojectTeams(form.PROJECT_ID)>
      <!--Select Survey --->
    <cfparam name="form.PROJECT_ID" default="0">
        <div class="row">
          <div class="col-md-12">
            <div class="col-md-3" style="padding-left:0;">
               <div class="form-group">
                   <form id="myform" action="" method="post" >
                      <label for="sel1">Select Survey:</label>
                          <select class="form-control search-box" id="project_val" onChange="sendForm()" name="project_id">
                              <option value="0">Add New Survey</option>
                              <cfloop query="qProjectsId">
                                  <option value="#qProjectsId.id#" <cfif isdefined('form.project_id') and form.project_id eq qProjectsId.id>selected</cfif>>#qProjectsId.id#</option>
                              </cfloop>
                          </select>
                     </form>
                </div>
             </div>

          <!---SELECT SIGHINTG --->
           <cfif isdefined('form.PROJECT_ID') and form.PROJECT_ID neq 0>
               <div class="col-md-5">
                  <form method="post"  id="sightform">
                   <label for="sel1">Select Sighting: </label>
                      <select name="sight_id" onchange="submitsightForm()" id="sightid" class="form-control search-box">
                          <option value="0">Add New Sighting</option>
                              <cfset r= getsightinglist.recordcount>
                              <cfloop query="getsightinglist">
                                     <option value="#getsightinglist.ID#" <cfif getsightinglist.ID EQ  qGetSightings.ID> selected</cfif>>#r# - #getsightinglist.ID#</option>
                                     <cfset r = r-1 >
                              </cfloop>
                      </select>
                              <input type="hidden" name="project_id" value="#form.PROJECT_ID#">
                  </form>
               </div>
            <div class="col-md-4" style="margin-top: 22px">
              <div class="form-group">
                  <button type="button" class="btn  btn-primary" id="shotnumber1">Shot 1</button>
                  <button type="button" class="btn  btn-primary" id="shotnumber2">Shot 2</button>
                  <button type="button" class="btn  btn-primary" id="shotnumber3">Shot 3</button>
              </div>
            </div>
           </cfif>
          </div>
        </div>

          <!--- SHOT SHEET FORM --->
  <div class="totalFormWrap">
      <form role="form"  method="post" id="biopsyform">
        <cfif Page eq 'ShotSheet'>
          <div class="row">
            <div class="col-md-3">
              <div class="form-group">
                <label for="">Shot Number</label>
                <input type="text" readonly id="shot" name="ShotNumber" class="form-control">
              </div>
            </div>
            <div class="col-md-3">
              <div class="form-group">
                <label for="">Shot Count</label>
                <input type="text" name="ShotCount" id="countshots" class="form-control" value="">
              </div>
            </div>
            <div class="col-md-12">
              <div class="form-group">
                <label for="sel1"> Dolphin :</label>
                <select class="form-control" name="Dolphin_ID" required id="door">
                  <option value="">Select Dolphin</option>
                  <option value="3668">Unknown Dolphin</option>
                  <cfloop query="dolphine_sight" group="Code">
                    <option   value="#dolphine_sight.ID#" >#dolphine_sight.Name# | #dolphine_sight.Code#</option>
                  </cfloop>
                </select>
              </div>
            </div>
        </div>
        </cfif>
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
                    <option value="#getprojectTeamnames.RT_ID#" selected>#getprojectTeamnames.RT_MemberName#</option>
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
              <select class="form-control " name="Arbalester" id="arba">
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
     <!--- left row --->
        <div style="padding-left:0;" class="col-md-6">
          <div class="row">
            <div class="col-md-12">
              <div class="form-group">
                <label for="pwd">Shot Distance (Ft):</label>
                  <input type="text" class="form-control" name="ShotDistance">
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
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
          </div>
          <div class="row">
            <div class="col-md-12">
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
          <div class="row">
            <div class="col-md-12">
              <div class="form-group" id="hitlocati" style="display:none">
                <label for="email">Hit location:</label>
                  <select class="form-control " name="HitLocation" id="hitloc">
                    <option value="0">Select Hit location</option>
                    <cfloop query="getHitLocation">
                    <option value="#ID#">#HitLocationAbbreviation#</option>
                    </cfloop>
                  </select>
              </div>
            </div><!--- col-md-6 end ---->
          </div>
<!--- 1st --->
        </div>
<!--- right row --->
        <div class="clearfix"></div>
        <div class="row">
          <div class="col-md-6 behavior">
            <div class="form-group clearfix">
              <h4>Target Animal Activity:</h4>
                <div class="inner-border-box">
                  <label>Pre-Biopsy 1:</label>
                    <div class="form-group activity-top-40 m-t-10">
                      <div class="box_01"> Mill
                      <select class="form-control Pre-Biopsy1" id="preMill" name="TABPre_Activity_Mill">
                        <option  value="-1"></option>
                          <cfloop from="1" to="6" index="i">
                              <cfset i = i - 1 >
                              <option value="#i#"  >#i#</option>
                          </cfloop>
                      </select>
                      </div>
                      <div class="box_01"> Feed
                        <select class="form-control Pre-Biopsy1" id="prefeed" name="TABPre_Activity_Feed">
                          <option selected="" value="-1"></option>
                            <cfloop from="1" to="6" index="i">
                              <cfset i = i - 1 >
                                  <option value="#i#"  >#i#</option>
                            </cfloop>
                        </select>
                      </div>
                      <div class="box_01"> Prob. Feed
                        <select class="form-control Pre-Biopsy1" id="prebfeed" name="TABPre_Activity_ProbFeed">
                          <option selected="" value="-1"></option>
                          <cfloop from="1" to="6" index="i">
                          <cfset i = i - 1 >
                          <option value="#i#" >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_01"> Travel
                        <select class="form-control Pre-Biopsy1" id="pretravel" name="TABPre_Activity_Travel">
                          <option selected="" value="-1"></option>
                          <cfloop from="1" to="6" index="i">
                          <cfset i = i - 1>
                          <option value="#i#" >#i#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="box_01"> Play
                        <select class="form-control Pre-Biopsy1" id="preplay" name="TABPre_Activity_Play">
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
          <select class="form-control Pre-Biopsy1" id="prerest" name="TABPre_ACTIVITY_REST">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#"  >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Leap
              <select class="form-control Pre-Biopsy1" id="prechuff" name="TABPre_Activity_Leap_tailslap_chuff">
                  <option selected="" value="-1"></option>
                  <cfloop from="1" to="6" index="i">
                      <cfset i = i - 1 >
                          <option value="#i#" >#i#</option>
                  </cfloop>
              </select>
          </div>
          <div class="box_01"> Social
          <select class="form-control Pre-Biopsy1" id="presocial" name="TABPre_Activity_Social">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#"  >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Boat
          <select class="form-control Pre-Biopsy1" id="preboat" name="TABPre_ACTIVITY_WITHBOAT">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#">#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Other
          <select class="form-control Pre-Biopsy1" id="preother" name="TABPre_Activity_Other">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#" >#i#</option>
          </cfloop>
          </select>
          </div>

          <div class="box_01"> Avoid Boat
          <select class="form-control Pre-Biopsy1" id="preavoid" name="TABPre_Activity_Avoid_Boat">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#">#i#</option>
          </cfloop>
          </select>
          </div>

          <div class="box_01"> Depre dation
          <select class="form-control Pre-Biopsy1" id="predepredation"  name="TABPre_Depredation">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#" >#i#</option>
          </cfloop>
          </select>
          </div>

          <div class="box_01"> Herding
          <select class="form-control Pre-Biopsy1" id="preherding"  name="TABPre_Herding">
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
          <select class="form-control Pre-BiopsyG1" id="groupmill" name="GBPre_Activity_Mill">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#"  >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Feed
          <select class="form-control Pre-BiopsyG1" id="groupfeed" name="GBPre_Activity_Feed">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#"  >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Prob. Feed
          <select class="form-control Pre-BiopsyG1" id="groupbfeed" name="GBPre_Activity_ProbFeed">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#" >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Travel
          <select class="form-control Pre-BiopsyG1" id="grouptravel" name="GBPre_Activity_Travel">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#" >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Play
          <select class="form-control Pre-BiopsyG1" id="groupplay" name="GBPre_Activity_Play">
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
          <select class="form-control Pre-BiopsyG1" id="grouprest" name="GBPre_ACTIVITY_REST">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#"  >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Leap
          <select class="form-control Pre-BiopsyG1" id="groupchuff" name="GBPre_Activity_Leap_tailslap_chuff">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#" >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Social
          <select class="form-control Pre-BiopsyG1" id="groupsocial" name="GBPre_Activity_Social">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#"  >#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Boat
          <select class="form-control Pre-BiopsyG1" id="groupboat" name="GBPre_ACTIVITY_WITHBOAT">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#">#i#</option>
          </cfloop>
          </select>
          </div>
          <div class="box_01"> Other
          <select class="form-control Pre-BiopsyG1" id="groupother" name="GBPre_Activity_Other">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#" >#i#</option>
          </cfloop>
          </select>
          </div>

          <div class="box_01"> Avoid Boat
          <select class="form-control Pre-BiopsyG1" id="groupavoid" name="GBPre_Activity_Avoid_Boat">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#">#i#</option>
          </cfloop>
          </select>
          </div>

          <div class="box_01"> Depre dation
          <select class="form-control Pre-BiopsyG1" id="groupdepredation"  name="GBPre_Depredation">
              <option selected="" value="-1"></option>
          <cfloop from="1" to="6" index="i">
              <cfset i = i - 1 >
                  <option value="#i#" >#i#</option>
          </cfloop>
          </select>
          </div>

          <div class="box_01"> Herding
          <select class="form-control Pre-BiopsyG1" id="groupherding"  name="GBPre_Herding">
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
            <h4>&nbsp;</h4>
            <label>Post-Biopsy 1:</label>
        <div class="form-group activity-top-40 m-t-10">
        <div class="box_01"> Mill
        <select class="form-control Post-Biopsy1" id="postmill" name="TABPost_Activity_Mill">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Feed
        <select class="form-control Post-Biopsy1" id="postfeed" name="TABPost_Activity_Feed">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">

            <cfset i = i - 1>
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Prob. Feed
        <select class="form-control Post-Biopsy1" id="postbfeed" name="TABPost_Activity_ProbFeed">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Travel
        <select class="form-control Post-Biopsy1" id="posttravel" name="TABPost_Activity_Travel">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Play
        <select class="form-control Post-Biopsy1" id="postplay" name="TABPost_Activity_Play">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        </div>
        <div class="form-group">
        <div class="inline-box  input-box">
        <div class="box_01"> Rest
        <select class="form-control Post-Biopsy1" id="postrest" name="TABPost_ACTIVITY_REST">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Leap
        <select class="form-control Post-Biopsy1" id="postchuff" name="TABPost_Activity_Leap_tailslap_chuff">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Social
        <select class="form-control Post-Biopsy1" id="postsocial" name="TABPost_Activity_Social">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Boat
        <select class="form-control Post-Biopsy1" id="postboat" name="TABPost_ACTIVITY_WITHBOAT">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Other
        <select class="form-control Post-Biopsy1" id="postother" name="TABPost_Activity_Other">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Avoid Boat
        <select class="form-control Post-Biopsy1" id="postavoid" name="TABPost_Activity_Avoid_Boat">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Depre dation
        <select class="form-control Post-Biopsy1" id="postdepredation" name="TABPost_Depredation">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Herding
        <select class="form-control Post-Biopsy1" id="postherding" name="TABPost_Herding">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
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
            <h4>&nbsp;</h4>
            <label>Post-Biopsy 1:</label>
        <div class="form-group activity-top-40 m-t-10">
        <div class="box_01"> Mill
        <select class="form-control Post-BiopsyG1" id="gpmill" name="GBPost_Activity_Mill">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Feed
        <select class="form-control Post-BiopsyG1" id="gpfeed" name="GBPost_Activity_Feed">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Prob. Feed
        <select class="form-control Post-BiopsyG1" id="gpbfeed" name="GBPost_Activity_ProbFeed">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Travel
        <select class="form-control Post-BiopsyG1" id="gptravel" name="GBPost_Activity_Travel">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Play
        <select class="form-control Post-BiopsyG1" id="gpplay" name="GBPost_Activity_Play">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        </div>
        <div class="form-group">
        <div class="inline-box  input-box">
        <div class="box_01"> Rest
        <select class="form-control Post-BiopsyG1" id="gprest" name="GBPost_ACTIVITY_REST">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Leap
        <select class="form-control Post-BiopsyG1" id="gpchuff" name="GBPost_Activity_Leap_tailslap_chuff">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Social
        <select class="form-control Post-BiopsyG1" id="gpsocial" name="GBPost_Activity_Social">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#"  >#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Boat
        <select class="form-control Post-BiopsyG1" id="gpwithboat" name="GBPost_ACTIVITY_WITHBOAT">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>
        <div class="box_01"> Other
        <select class="form-control Post-BiopsyG1" id="gpother" name="GBPost_Activity_Other">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Avoid Boat
        <select class="form-control Post-BiopsyG1" id="gpboat" name="GBPost_Activity_Avoid_Boat">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Depre dation
        <select class="form-control Post-BiopsyG1" id="gpdepredation" name="GBPost_Depredation">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#" >#i#</option>
        </cfloop>
        </select>
        </div>

        <div class="box_01"> Herding
        <select class="form-control Post-BiopsyG1" id="gppostherding" name="GBPost_Herding">
            <option selected="" value="-1"></option>
        <cfloop from="1" to="6" index="i">
            <cfset i = i - 1>
                <option value="#i#">#i#</option>
        </cfloop>
        </select>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div> <!--- col-md-6 end ---->
    </div>
  <hr>
      <div style="padding-right:0;" class="col-md-6">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label for="email">Sample##:</label>
                <input type="text" class="form-control" name="SampleNumber" maxlength="50">
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 chkbxs_mrgn_adj">
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
                <label for="email">Sample Taken:</label>
                <input type="radio" class="radio-inline" id="smpl1" name="SampleTaken"   value="1"> Yes
                <input type="radio" class="radio-inline"  id="smpl2" name="SampleTaken"   value="0"> No
            </div>
            <div class="form-group">
                <label for="email">Sample head:</label>
                <input type="radio" class="radio-inline" id="smplhead1" name="Samplehead"   value="1"> M8
                <input type="radio" class="radio-inline" id="smplhead2" name="Samplehead"   value="0"> M11
            </div>
            <div class="form-group">
                <label for="email">Sample Collected :</label>
                <input type="radio" class="radio-inline" id="collected1" name="SampleCollected"   value="1"> Full
                <input type="radio" class="radio-inline" id="collected2" name="SampleCollected"   value="0"> Partial
            </div>
            <div class="form-group">
                <label for="email">Blubber  Teflon vial (Time in LN2)  :</label>
                <input type="checkbox" class="radio-inline" id="blubber1" name="BlubberTeflonVial"   value="1">
            </div>
            <div class="form-group">
                <label for="email">Blubber  Cryovial, red   (Store in LN2) :</label>
                <input type="checkbox" class="radio-inline" id="blubbercry" name="BlubberCryovialRed"   value="1">
            </div>
            <div class="form-group">
                <label for="email">Blubber  Cryovial, blue (Store in LN2) :</label>
                <input type="checkbox" class="radio-inline" id="blubberblue" name="BlubberCryovialBlue"   value="1">
            </div>
            <div class="form-group">
                <label for="email">Skin  D Cryovial, green </label>
                <input type="checkbox" class="radio-inline" id="skindcry" name="SkinDCryovial"   value="1">
            </div>
            <div class="form-group">
                <label for="email">Skin  DMSO:</label>
                <input type="checkbox" class="radio-inline" id="skindms" name="SkinDMSO"   value="1">
            </div>
            <div class="form-group">
                <label for="email">Skin  RNAlater</label>
                <input type="checkbox" class="radio-inline" id="rna" name="SkinRNAlater"   value="1">
            </div>
            <div class="form-group">
                <label for="email">Probable Dolphin:</label>
                <input type="checkbox" class="radio-inline" id="prbbldol" name="probable_dolphin"   value="1">
            </div>
        </div><!--- col-md-6 end ---->
    </div><!--- row end ---->
    </div>
        <div class="clearfix">
        </div>
    <div class="col-md-12">
      <div class="row">
      <div style="padding:0;" class="col-md-4 m-t-10">
    <cfif Page eq 'EditDolphin' >
              <input type="hidden" name="Dolphin_ID"  value="#form.id#">
      </cfif>
      <cfif Page eq 'ShotSheet' >
              <input type="hidden" class="form-control" name="Sighting_ID" value="#qGetSightings.id#">
      </cfif>
        <button name="addBiopsy" class="btn btn-success" type="submit">Submit</button>
        <button style="margin-left:8px;" class="btn btn-default" id="BiopsyReset" type="reset">Reset</button>
    </div>
    </div>
    </form>
    </div>
        <div class="clearfix"></div>
        <br>
    </div>
    <div class="alert alert-success message"  style="display:none; ">
    </div>
</cfoutput>
</div>
