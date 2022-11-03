<cfoutput>
  	
<cfset getTeams=Application.Sighting.getTeams()>

<cfif isdefined('form.EditBiopsy')>
  		<cfset qEditBiopsy=Application.Sighting.EditBiopsy(argumentCollection="#Form#")>
         <cfset updateTeam=Application.Sighting.updateBiopsyteammember(argumentCollection="#Form#")>
</cfif>
  
<cfif isdefined('url.Biopsy') and url.Biopsy neq ''>
	<cfset getBiopsy=Application.Sighting.getBiopsyByID(Biopsy_ID=url.Biopsy)>

<cfelse>
	<cflocation addtoken="no" url="#Application.superadmin#?Module=Sighting&Page=Biopsy"> 
</cfif>

<cfset getBiopsyTeammember = Application.Sighting.getBiopsyTeammember(Biopsy_ID=url.Biopsy)>
<cfset getteammember = ValueList(getBiopsyTeammember.TeamMemberID,",")>
<cfset getBiopsyBehavior = Application.Dolphin.getBiopsyBehavior()>
<cfset getHitLocation=Application.Dolphin.getHitLocation()>
<cfset getMissDescriptors=Application.Dolphin.getMissDescriptors()>
<cfset getHitDescriptors=Application.Dolphin.getHitDescriptors()>
<cfset getSubSampleType=Application.Dolphin.getSubSampleType()>
<cfset getDolphinsCode = Application.Sighting.getDolphinsCode()>
<cfset qgetResearchTeamMembers = Application.StaticData.getResearchTeamMembers()>
  
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
.radioBtn {
    margin-bottom: 31px;
}
.main-form-section .inner-border-box {
    margin-bottom: 10px;
}
</style>

  <div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Home</a></li>
      <li><a href="javascript:;" class="active">Biopsy</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Edit Biopsy
    <cfinclude template="SightingMenu.cfm"></h1>
    <!-- end page-header -->
    <div class="section-container section-with-top-border p-b-10">
      <!-- begin row -->
      <div class="main-form-section">
      
       <cfif isdefined('qEditBiopsy') and qEditBiopsy.recordcount eq 1  >
            <div class="alert alert-success fade in m-b-10" id="sucess-div"> <strong>Successfully Updated!
              </strong> <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span> </div>
          </cfif>
          
       <div class="row addBiopsy_disp panel p-t-10 p-b-10">
          <form role="form"  method="post"> 
               <!---------- 1st row------------------->
             <div class="row col-md-12">
              <div class="col-md-6">
                 
                  <div class="form-group">
                    <label for="sel1"> Dolphin :</label>
                     <select class="form-control search-box" required id="DOLPHIN_ID" name="DOLPHIN_ID" >
                      <option value="">Select Dolphin</option>
                     
                      <cfloop query="getDolphinsCode">
                        <option value="#getDolphinsCode.id#" 
						<cfif getBiopsy.Dolphin_ID eq getDolphinsCode.id>selected</cfif>> #getDolphinsCode.Name# | #getDolphinsCode.code#</option>
                      </cfloop>
                    </select>
              
                  </div>
                  
                  <div class="form-group">
                    <label for="sel1">Sighting ID:</label>
                     <input type="text" readonly="readonly" class="form-control" value="#getBiopsy.Sighting_ID#" />
                  </div>
                 
                  
               
                  <div class="form-group">
                    <label for="pwd">Time:</label>
                    <input type="text" class="form-control timepicker"  name="ShotTime" value="#dateTimeFormat (getBiopsy.ShotTime,'HH:nn')#">
                  </div>
                  
                  <div class="form-group">
                    <label for="pwd">Arbalester :</label>
                    <select class="form-control " name="Arbalester">
                    <option value=""> SelectArbalester </option>
                    <cfloop query="qgetResearchTeamMembers">
                     <option value="#qgetResearchTeamMembers.RT_ID#" <cfif qgetResearchTeamMembers.RT_ID eq getBiopsy.Arbalester>selected </cfif>>#qgetResearchTeamMembers.RT_MemberName#</option>
               		</cfloop>
                     </select>
                  </div>
                  <div class="form-group">
                    <label for="email">Target Response Level:</label>
                     <select class="form-control " name="TargetLevel">
                    <option value="">Target behavior response</option>
                    <cfloop query="getBiopsyBehavior">
                    <cfif getBiopsyBehavior.LevelofResponse eq 1>
                     <option value="#getBiopsyBehavior.ObservedResponse#" <cfif getBiopsyBehavior.ObservedResponse EQ  getBiopsy.TargetLevel >selected</cfif>>#getBiopsyBehavior.ObservedResponse#</option>
                    </cfif> 
               		</cfloop>
                     </select>
                  </div>
                  <div class="form-group">
                    	<label for="email">Target Response Behavior 2:</label>
                     	<select class="form-control" name="TargetResponseBehavior2">
                            <option value="">Target behavior response</option>
                            <cfloop query="getBiopsyBehavior">
                                <cfif getBiopsyBehavior.LevelofResponse eq 3>
                                 	<option value="#getBiopsyBehavior.ObservedResponse#" <cfif getBiopsyBehavior.ObservedResponse EQ  getBiopsy.TargetResponseBehavior2 >selected</cfif>>#getBiopsyBehavior.ObservedResponse#</option>
                                </cfif>
                            </cfloop>
                    	 </select>
                  	</div>
                     <div class="form-group">
                    	<label for="email">Group Response Behavior:</label>
                     	<select class="form-control " name="GroupResponseBehavior">
                            <option value="">Target behavior response</option>
                            <cfloop query="getBiopsyBehavior">
                                <cfif getBiopsyBehavior.LevelofResponse eq 5>
                                 	<option value="#getBiopsyBehavior.ObservedResponse#" <cfif getBiopsyBehavior.ObservedResponse EQ  getBiopsy.GroupResponseBehavior >selected</cfif>>#getBiopsyBehavior.ObservedResponse#</option>
                                </cfif>
                            </cfloop>
                    	 </select>
                  	</div>
                     <div class="form-group">
                    	<label for="email" style="display:block">Outcome:</label>
                        <div class="radioBtn">
                            <input type="radio" class="radio-inline" name="Outcome" <cfif getBiopsy.Outcome EQ 1 >checked</cfif>  maxlength="1" value="1" id="hitOutcome"> Hit
                            <input type="radio" class="radio-inline" name="Outcome" <cfif getBiopsy.Outcome EQ 0 >checked</cfif>  maxlength="1" value="0" id="missOutcome"> Miss
                        </div>
                  </div>
                  <div class="form-group" id="missWidth" <cfif getBiopsy.Outcome EQ 0> style="display:block" <cfelse> style="display:none" </cfif>>
                    <label for="pwd">Miss-Width:</label>
                    <input type="text" class="form-control" name="missWidth" value="#getBiopsy.missWidth#">
                  </div>
                  <div class="form-group" id="missHeight" <cfif getBiopsy.Outcome EQ 0> style="display:block" <cfelse> style="display:none" </cfif>>
                    <label for="pwd">Miss-Height:</label>
                    <input type="text" class="form-control" name="missHeight" value="#getBiopsy.missHeight#"  min='0' max='255'>
                  </div>  
                 
                  
                   </div><!--- col-md-6 end ---->

                
              <div class="col-md-6">
               	
                 <div class="form-group">
                    <label for="pwd">Shot##:</label>
                    <input type="text" class="form-control" name="ShotNumber" value="#getBiopsy.ShotNumber#"  min='0' max='255'>
                  </div>
                  
                  <div class="form-group">
                    <label for="pwd">Shot Distance (Ft):</label>
                    <input type="text" class="form-control" name="ShotDistance" value="#getBiopsy.ShotDistance#">
                  </div>
                   
                   <!---<div class="form-group">
                    <label for="email">Outcome:</label>
                    <input type="radio" class="radio-inline" name="Outcome" <cfif getBiopsy.Outcome EQ 1 >checked</cfif>  maxlength="1" value="1"> Hit
                    <input type="radio" class="radio-inline" name="Outcome" <cfif getBiopsy.Outcome EQ 0 >checked</cfif>  maxlength="1" value="0"> Miss
                  </div>--->
                  
                 	<div class="form-group team">
                    <label for="email">Team:</label>
                    	<select class="form-control search-box" multiple="multiple" name="BiopsyTeam">
                 		<cfloop query="getTeams">
                      	<option value="#getTeams.RT_ID#" <cfif ListFind(getteammember,getTeams.RT_ID)>selected</cfif> >#getTeams.RT_MemberName#</option>
                    	</cfloop>
                  		</select>
                    </div>
                     <div class="form-group">
                        <label for="email">Target Response Behavior 1:</label>
                        <select class="form-control " name="TargetResponseBehavior1">
                            <option value="">Target behavior response</option>
                            <cfloop query="getBiopsyBehavior">
                                <cfif getBiopsyBehavior.LevelofResponse eq 2>
                                    <option value="#getBiopsyBehavior.ObservedResponse#" <cfif getBiopsyBehavior.ObservedResponse EQ  getBiopsy.TargetResponseBehavior1 >selected</cfif>>#getBiopsyBehavior.ObservedResponse#</option>
                                </cfif>
                            </cfloop>
                         </select>
                        </div>
                     <div class="form-group">
                            <label for="email">Target Response Behavior 3:</label>
                            <select class="form-control " name="TargetResponseBehavior3">
                                <option value="">Target behavior response</option>
                                <cfloop query="getBiopsyBehavior">
                                     <cfif getBiopsyBehavior.LevelofResponse eq 4>
                                        <option value="#getBiopsyBehavior.ObservedResponse#" <cfif getBiopsyBehavior.ObservedResponse EQ  getBiopsy.TargetResponseBehavior3 >selected</cfif>>#getBiopsyBehavior.ObservedResponse#</option>
                                    </cfif>
                                </cfloop>
                             </select>
                        </div>
                     <div class="form-group">
                            <label for="pwd">Group Size:</label>
                            <input type="text" class="form-control" name="groupSize" value="#getBiopsy.GroupSize#">
                        </div>
                     <div class="form-group" id="hitDescriptor" <cfif getBiopsy.Outcome EQ 1> style="display:block" <cfelse> style="display:none" </cfif>>
                        <label for="pwd">Hit Descriptor:</label>
                        <select class="form-control " name="hitDescriptor">
                            <option value="0">Select Hit Descriptor</option>
                            <cfloop query="getHitDescriptors">
                                <option value="#ID#" <cfif getBiopsy.HitDescriptor eq getHitDescriptors.ID> selected </cfif>>#HitDescriptors#</option>
                            </cfloop>
                        </select>
                    </div>
                 	<div class="form-group" id="missDescriptor" <cfif getBiopsy.Outcome EQ 0> style="display:block" <cfelse> style="display:none" </cfif>>
                        <label for="pwd">Miss Descriptor:</label>
                        <select class="form-control " name="missDescriptor">
                            <option value="0">Select Miss Descriptor</option>
                            <cfloop query="getMissDescriptors">
                                <option value="#ID#" <cfif getBiopsy.MissDescriptor eq getMissDescriptors.ID> selected </cfif>>#MissDescriptors#</option>
                            </cfloop>
                        </select>
                    </div>   
                     <div class="form-group" id="missDistance" <cfif getBiopsy.Outcome EQ 0> style="display:block" <cfelse> style="display:none" </cfif>>
                            <label for="pwd">Miss-Distance:</label>
                            <input type="text" class="form-control" name="missDistance" value="#getBiopsy.missDistance#"  min='0' max='255'>
                        </div>
                     
 
                  
                
                   </div><!--- col-md-6 end ---->
              </div><!--- row end ---->
            
            
                 <!---------- 2nd row------------------->
                  <div class="row ">
                  <div class="from-group title">
                    	<h4>Target Animal Behavior:</h4>
                    </div>
                  <div class="col-md-6">
                  	
                    <div class="form-group clearfix">
                     <div class="inner-border-box">
             			<label>Pre-Biopsy 1:</label>
                          <div class="form-group activity-top-40 m-t-10">
                              <div class="box_01"> Mill
                                <select class="form-control" id="value" name="TABPre_Activity_Mill">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPre_Activity_Mill EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control"  id="value" name="TABPre_Activity_Feed">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Feed EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="TABPre_Activity_ProbFeed">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_ProbFeed EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="TABPre_Activity_Travel">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Travel EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="TABPre_Activity_Play">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Play EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="TABPre_ACTIVITY_REST">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_ACTIVITY_REST EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="TABPre_Activity_Leap_tailslap_chuff">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Leap_tailslap_chuff EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="TABPre_Activity_Social">
                                  <cfloop from="1" to="6" index="i">

                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Social EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="TABPre_ACTIVITY_WITHBOAT">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_ACTIVITY_WITHBOAT EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="TABPre_Activity_Other">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Other EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="TABPre_Activity_Avoid_Boat">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Avoid_Boat EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="TABPre_Depredation">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Depredation EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="TABPre_Herding">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Herding EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                            </div>
                          </div>
                          
                        </div>
                   </div>     
                    <div class="form-group clearfix">
                     <div class="inner-border-box">
             				 <label>Pre-Biopsy 2:</label>
                          <div class="form-group activity-top-40 m-t-10">
                              <div class="box_01"> Mill
                                <select class="form-control" id="value" name="TABPre_Activity_Mill2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPre_Activity_Mill2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control"  id="value" name="TABPre_Activity_Feed2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Feed2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="TABPre_Activity_ProbFeed2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_ProbFeed2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="TABPre_Activity_Travel2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Travel2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="TABPre_Activity_Play2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Play2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="TABPre_ACTIVITY_REST2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_ACTIVITY_REST2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="TABPre_Activity_Leap_tailslap_chuff2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Leap_tailslap_chuff2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="TABPre_Activity_Social2">
                                  <cfloop from="1" to="6" index="i">

                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Social2 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="TABPre_ACTIVITY_WITHBOAT2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_ACTIVITY_WITHBOAT2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="TABPre_Activity_Other2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Other2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="TABPre_Activity_Avoid_Boat2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Avoid_Boat2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="TABPre_Depredation2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Depredation2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="TABPre_Herding2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Herding2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                            </div>
                          </div>
                          
                        </div>
                   </div>  
                    <div class="form-group clearfix">
                     <div class="inner-border-box">
             				 <label>Pre-Biopsy 1:</label>
                          <div class="form-group activity-top-40 m-t-10">
                              <div class="box_01"> Mill
                                <select class="form-control" id="value" name="TABPre_Activity_Mill3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPre_Activity_Mill3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control"  id="value" name="TABPre_Activity_Feed3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Feed3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="TABPre_Activity_ProbFeed3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_ProbFeed3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="TABPre_Activity_Travel3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Travel3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="TABPre_Activity_Play3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Play3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="TABPre_ACTIVITY_REST3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_ACTIVITY_REST3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="TABPre_Activity_Leap_tailslap_chuff3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Leap_tailslap_chuff3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="TABPre_Activity_Social3">
                                  <cfloop from="1" to="6" index="i">

                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Social3 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="TABPre_ACTIVITY_WITHBOAT3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_ACTIVITY_WITHBOAT3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="TABPre_Activity_Other3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Other3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="TABPre_Activity_Avoid_Boat3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Activity_Avoid_Boat3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="TABPre_Depredation3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Depredation3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="TABPre_Herding3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPre_Herding3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                            </div>
                          </div>
                          
                        </div>
                   </div>    
                   <div class="form-group clearfix title">
                   	<h4>Group Behavior:</h4>
                   </div>
                    <div class="form-group clearfix">
                      <div class="inner-border-box">
                                 <label>Pre-Biopsy:</label>
                              <div class="form-group activity-top-40 m-t-10">
                                  <div class="box_01"> Mill
                                    <select class="form-control" id="value" name="GBPre_Activity_Mill">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Mill EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Feed
                                    <select class="form-control" id="value" name="GBPre_Activity_Feed">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Feed EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Prob. Feed
                                    <select class="form-control" id="value" name="GBPre_Activity_ProbFeed">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_ProbFeed EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Travel
                                    <select class="form-control" id="value" name="GBPre_Activity_Travel">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Travel EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Play
                                    <select class="form-control" id="value" name="GBPre_Activity_Play">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Play EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                </div>
                              <div class="form-group">
                                <div class="inline-box input-box">
                                  <div class="box_01"> Rest
                                    <select class="form-control" id="value" name="GBPre_ACTIVITY_REST">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_ACTIVITY_REST EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Leap
                                    <select class="form-control" id="value" name="GBPre_Activity_Leap_tailslap_chuff">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_Activity_Leap_tailslap_chuff EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Social
                                    <select class="form-control" id="value" name="GBPre_Activity_Social">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Social EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Boat
                                    <select class="form-control" id="value" name="GBPre_ACTIVITY_WITHBOAT">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_ACTIVITY_WITHBOAT EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Other
                                    <select class="form-control" id="value" name="GBPre_Activity_Other">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Other EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                
                                <div class="box_01"> Avoid Boat
                                    <select class="form-control" id="value" name="GBPre_Activity_Avoid_Boat">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Avoid_Boat EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                  <div class="box_01"> Depre dation
                                    <select class="form-control"  name="GBPre_Depredation">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Depredation EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                  <div class="box_01"> Herding 
                                    <select class="form-control"  name="GBPre_Herding">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_Herding EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                </div>
                              </div>
                              
                            </div>
                  	</div>
                    <div class="form-group clearfix">
                      <div class="inner-border-box">
                          <label>Pre-Biopsy 2:</label>
                              <div class="form-group activity-top-40 m-t-10">
                                  <div class="box_01"> Mill
                                    <select class="form-control" id="value" name="GBPre_Activity_Mill2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Mill2 EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Feed
                                    <select class="form-control" id="value" name="GBPre_Activity_Feed2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Feed2 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Prob. Feed
                                    <select class="form-control" id="value" name="GBPre_Activity_ProbFeed2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_ProbFeed2 EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Travel
                                    <select class="form-control" id="value" name="GBPre_Activity_Travel2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Travel2 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Play
                                    <select class="form-control" id="value" name="GBPre_Activity_Play2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Play2 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                </div>
                              <div class="form-group">
                                <div class="inline-box input-box">
                                  <div class="box_01"> Rest
                                    <select class="form-control" id="value" name="GBPre_ACTIVITY_REST2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_ACTIVITY_REST2 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Leap
                                    <select class="form-control" id="value" name="GBPre_Activity_Leap_tailslap_chuff2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_Activity_Leap_tailslap_chuff2 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Social
                                    <select class="form-control" id="value" name="GBPre_Activity_Social2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Social2 EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Boat
                                    <select class="form-control" id="value" name="GBPre_ACTIVITY_WITHBOAT2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_ACTIVITY_WITHBOAT2 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Other
                                    <select class="form-control" id="value" name="GBPre_Activity_Other2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Other2 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                
                                <div class="box_01"> Avoid Boat
                                    <select class="form-control" id="value" name="GBPre_Activity_Avoid_Boat2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Avoid_Boat2 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                  <div class="box_01"> Depre dation
                                    <select class="form-control"  name="GBPre_Depredation2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Depredation2 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                  <div class="box_01"> Herding 
                                    <select class="form-control"  name="GBPre_Herding2">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_Herding2 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                </div>
                              </div>
                              
                            </div>
                  	</div>
                    <div class="form-group clearfix">
                      <div class="inner-border-box">
                          <label>Pre-Biopsy 3:</label>
                              <div class="form-group activity-top-40 m-t-10">
                                  <div class="box_01"> Mill
                                    <select class="form-control" id="value" name="GBPre_Activity_Mill3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Mill3 EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Feed
                                    <select class="form-control" id="value" name="GBPre_Activity_Feed3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Feed3 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Prob. Feed
                                    <select class="form-control" id="value" name="GBPre_Activity_ProbFeed3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_ProbFeed3 EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Travel
                                    <select class="form-control" id="value" name="GBPre_Activity_Travel3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Travel3 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Play
                                    <select class="form-control" id="value" name="GBPre_Activity_Play3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Play3 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                </div>
                              <div class="form-group">
                                <div class="inline-box input-box">
                                  <div class="box_01"> Rest
                                    <select class="form-control" id="value" name="GBPre_ACTIVITY_REST3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_ACTIVITY_REST3 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Leap
                                    <select class="form-control" id="value" name="GBPre_Activity_Leap_tailslap_chuff3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_Activity_Leap_tailslap_chuff3 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Social
                                    <select class="form-control" id="value" name="GBPre_Activity_Social3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Social3 EQ i >selected</cfif>  >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Boat
                                    <select class="form-control" id="value" name="GBPre_ACTIVITY_WITHBOAT3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_ACTIVITY_WITHBOAT3 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  <div class="box_01"> Other
                                    <select class="form-control" id="value" name="GBPre_Activity_Other3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Other3 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                
                                <div class="box_01"> Avoid Boat
                                    <select class="form-control" id="value" name="GBPre_Activity_Avoid_Boat3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Activity_Avoid_Boat3 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                  <div class="box_01"> Depre dation
                                    <select class="form-control"  name="GBPre_Depredation3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#" <cfif getBiopsy.GBPre_Depredation3 EQ i >selected</cfif> >#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                  <div class="box_01"> Herding 
                                    <select class="form-control"  name="GBPre_Herding3">
                                      <cfloop from="1" to="6" index="i">
                                        <cfset i = i - 1 >
                                        <option value="#i#"  <cfif getBiopsy.GBPre_Herding3 EQ i >selected</cfif>>#i#</option>
                                      </cfloop>
                                    </select>
                                  </div>
                                  
                                </div>
                              </div>
                              
                            </div>
                  	</div>
                  </div>
                   
                <!--- col-md-6 end ---->
                  
                  <div class="col-md-6">
                  
                    <div class="form-group clearfix">
                     <div class="inner-border-box">
                     
             			<label>Post-Biopsy 1:</label>
                          <div class="form-group activity-top-40 m-t-10">
                              <div class="box_01"> Mill
                                <select class="form-control" id="value" name="TABPost_Activity_Mill">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Mill EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control" id="value" name="TABPost_Activity_Feed">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_Activity_Feed EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="TABPost_Activity_ProbFeed">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_ProbFeed EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="TABPost_Activity_Travel">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Travel EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="TABPost_Activity_Play">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Play EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box  input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="TABPost_ACTIVITY_REST">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_ACTIVITY_REST EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="TABPost_Activity_Leap_tailslap_chuff">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Leap_tailslap_chuff EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="TABPost_Activity_Social">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Social EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="TABPost_ACTIVITY_WITHBOAT">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_ACTIVITY_WITHBOAT EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="TABPost_Activity_Other">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Other EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="TABPost_Activity_Avoid_Boat">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Avoid_Boat EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="TABPost_Depredation">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Depredation EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="TABPost_Herding">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_Herding EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                            </div>
                          </div>
                          
                        </div>
                  	</div>
                    <div class="form-group clearfix">
                     <div class="inner-border-box">
                     
             			<label>Post-Biopsy 2:</label>
                          <div class="form-group activity-top-40 m-t-10">
                              <div class="box_01"> Mill
                                <select class="form-control" id="value" name="TABPost_Activity_Mill2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Mill2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control" id="value" name="TABPost_Activity_Feed2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_Activity_Feed2 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="TABPost_Activity_ProbFeed2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_ProbFeed2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="TABPost_Activity_Travel2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Travel2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="TABPost_Activity_Play2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Play2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box  input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="TABPost_ACTIVITY_REST2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_ACTIVITY_REST2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="TABPost_Activity_Leap_tailslap_chuff2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Leap_tailslap_chuff2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="TABPost_Activity_Social2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Social2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="TABPost_ACTIVITY_WITHBOAT2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_ACTIVITY_WITHBOAT2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="TABPost_Activity_Other2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Other2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="TABPost_Activity_Avoid_Boat2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Avoid_Boat2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="TABPost_Depredation2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Depredation2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="TABPost_Herding2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_Herding2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                            </div>
                          </div>
                          
                        </div>
                  	</div>
                    <div class="form-group clearfix">
                     <div class="inner-border-box">
                     
             			<label>Post-Biopsy 3:</label>
                          <div class="form-group activity-top-40 m-t-10">
                              <div class="box_01"> Mill
                                <select class="form-control" id="value" name="TABPost_Activity_Mill3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Mill3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control" id="value" name="TABPost_Activity_Feed3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_Activity_Feed3 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="TABPost_Activity_ProbFeed3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_ProbFeed3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="TABPost_Activity_Travel3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Travel3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="TABPost_Activity_Play3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Play3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box  input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="TABPost_ACTIVITY_REST3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_ACTIVITY_REST3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="TABPost_Activity_Leap_tailslap_chuff3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Leap_tailslap_chuff3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="TABPost_Activity_Social3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Social3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="TABPost_ACTIVITY_WITHBOAT3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_ACTIVITY_WITHBOAT3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="TABPost_Activity_Other3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Other3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="TABPost_Activity_Avoid_Boat3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Activity_Avoid_Boat3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="TABPost_Depredation3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.TABPost_Depredation3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="TABPost_Herding3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.TABPost_Herding3 EQ i >selected</cfif>>#i#</option>
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
                                <select class="form-control" id="value" name="GBPost_Activity_Mill">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Mill EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control" id="value" name="GBPost_Activity_Feed">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Feed EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="GBPost_Activity_ProbFeed">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_ProbFeed EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="GBPost_Activity_Travel">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Travel EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="GBPost_Activity_Play">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Play EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box  input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="GBPost_ACTIVITY_REST">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_ACTIVITY_REST EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="GBPost_Activity_Leap_tailslap_chuff">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Leap_tailslap_chuff EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="GBPost_Activity_Social">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.GBPost_Activity_Social EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="GBPost_ACTIVITY_WITHBOAT">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_ACTIVITY_WITHBOAT EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="GBPost_Activity_Other">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Other EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="GBPost_Activity_Avoid_Boat">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Avoid_Boat EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="GBPost_Depredation">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Depredation EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="GBPost_Herding">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Herding EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                            </div>
                          </div>
                        </div>
                  	</div>
                    <div class="form-group clearfix">
                         <div class="inner-border-box">
 	    	          
        				 <label>Post-Biopsy 2:</label>
                          <div class="form-group activity-top-40 m-t-10">
                              <div class="box_01"> Mill
                                <select class="form-control" id="value" name="GBPost_Activity_Mill2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Mill2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control" id="value" name="GBPost_Activity_Feed2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Feed2 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="GBPost_Activity_ProbFeed2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_ProbFeed2 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="GBPost_Activity_Travel2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Travel2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="GBPost_Activity_Play2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Play2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box  input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="GBPost_ACTIVITY_REST2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_ACTIVITY_REST2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="GBPost_Activity_Leap_tailslap_chuff2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Leap_tailslap_chuff2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="GBPost_Activity_Social2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.GBPost_Activity_Social2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="GBPost_ACTIVITY_WITHBOAT2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_ACTIVITY_WITHBOAT2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="GBPost_Activity_Other2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Other2 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="GBPost_Activity_Avoid_Boat2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Avoid_Boat2 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="GBPost_Depredation2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Depredation2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="GBPost_Herding2">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Herding2 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                            </div>
                          </div>
                        </div>
                  	</div>
                    <div class="form-group clearfix">
                         <div class="inner-border-box">
 	    	          
        				 <label>Post-Biopsy 3:</label>
                          <div class="form-group activity-top-40 m-t-10">
                              <div class="box_01"> Mill
                                <select class="form-control" id="value" name="GBPost_Activity_Mill3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Mill3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Feed
                                <select class="form-control" id="value" name="GBPost_Activity_Feed3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Feed3 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Prob. Feed
                                <select class="form-control" id="value" name="GBPost_Activity_ProbFeed3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_ProbFeed3 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Travel
                                <select class="form-control" id="value" name="GBPost_Activity_Travel3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Travel3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Play
                                <select class="form-control" id="value" name="GBPost_Activity_Play3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Play3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            </div>
                          <div class="form-group">
                            <div class="inline-box  input-box">
                              <div class="box_01"> Rest
                                <select class="form-control" id="value" name="GBPost_ACTIVITY_REST3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_ACTIVITY_REST3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Leap
                                <select class="form-control" id="value" name="GBPost_Activity_Leap_tailslap_chuff3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Leap_tailslap_chuff3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Social
                                <select class="form-control" id="value" name="GBPost_Activity_Social3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#"  <cfif getBiopsy.GBPost_Activity_Social3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Boat
                                <select class="form-control" id="value" name="GBPost_ACTIVITY_WITHBOAT3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_ACTIVITY_WITHBOAT3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              <div class="box_01"> Other
                                <select class="form-control" id="value" name="GBPost_Activity_Other3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Other3 EQ i >selected</cfif>  >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                            
                            <div class="box_01"> Avoid Boat
                                <select class="form-control" id="value" name="GBPost_Activity_Avoid_Boat3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Activity_Avoid_Boat3 EQ i >selected</cfif>>#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Depre dation
                                <select class="form-control"  name="GBPost_Depredation3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Depredation3 EQ i >selected</cfif> >#i#</option>
                                  </cfloop>
                                </select>
                              </div>
                              
                              <div class="box_01"> Herding 
                                <select class="form-control"  name="GBPost_Herding3">
                                  <cfloop from="1" to="6" index="i">
                                    <cfset i = i - 1 >
                                    <option value="#i#" <cfif getBiopsy.GBPost_Herding3 EQ i >selected</cfif> >#i#</option>
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
                  <div class="row  col-md-12">
                  
                  <div class="col-md-6">
                  
                  <div class="form-group">
                    <label for="email">Hit location:</label>
                     <select class="form-control " name="HitLocation">
                    <option value="0">Select Hit location</option>
                    <cfloop query="getHitLocation">
                     <option value="#ID#" <cfif ID EQ getBiopsy.HitLocation>selected</cfif>>#HitLocationAbbreviation#</option>
                     </cfloop>
                     </select>
                  </div>
                  <div class="form-group">
                  <label for="email">Sub-Sample tissue type:</label>
                   <select class="form-control " name="SubSample">
                    <option value="0">Select Sub Sample</option>
                     <cfloop query="getSubSampleType">
                     <option value="#ID#" <cfif ID EQ getBiopsy.SubSample>selected</cfif>>#TissueType# - #IntendedAnalysis#</option>
                     </cfloop>
                     </select>
                  </div>
                   <div class="form-group">
                    <label for="email">Processor :</label>
                    <input type="text" class="form-control" name="Processor" value="#getBiopsy.Processor#" >
                    </div>
                  	
                    <div class="form-group">
                    <label for="email">Sample Length(mm) :</label>
                    <input type="text" class="form-control" name="SampleLength" value="#getBiopsy.SampleLength#" >
                    </div>
                      <div class="form-group">
                    <label for="email">Skin – DMSO:</label>
                    <input type="checkbox" class="radio-inline" name="SkinDMSO" <cfif getBiopsy.SkinDMSO EQ 1 >checked</cfif>   value="1">  
                  </div>	
                  
                  <div class="form-group">
                    <label for="email">Skin – RNAlater</label>
                    <input type="checkbox" class="radio-inline" name="SkinRNAlater"  <cfif getBiopsy.SkinRNAlater EQ 1 >checked</cfif>  value="1">  
                  </div>
                  
                  
				  </div><!--- col-md-6 end ---->
                  
                  
             <div class="col-md-6">
                  
                <div class="form-group">
                <label for="email">Sample##:</label>
                <input type="text" class="form-control" name="SampleNumber"  value="#getBiopsy.SampleNumber#"  maxlength="50">
                </div>
                
                 <div class="form-group">
                 <label for="email">Sample Taken:</label>
                 <input type="radio" class="radio-inline" name="SampleTaken" <cfif getBiopsy.SampleTaken EQ 1 >checked</cfif>   value="1"> Yes 
                 <input type="radio" class="radio-inline" name="SampleTaken" <cfif getBiopsy.SampleTaken EQ 0 >checked</cfif>   value="0"> No 
                 </div>
                    
                 <div class="form-group">
                    <label for="email">Sample head:</label>
                    <input type="radio" class="radio-inline" name="Samplehead" <cfif getBiopsy.Samplehead EQ  1>checked</cfif>   value="1"> M8  
                    <input type="radio" class="radio-inline" name="Samplehead" <cfif getBiopsy.Samplehead EQ 0 >checked</cfif>  value="0"> M11  
                  </div>
                  
                    <div class="form-group">
                    <label for="email">Sample Collected :</label>
                    <input type="radio" class="radio-inline" name="SampleCollected"  <cfif getBiopsy.SampleCollected EQ 1 >checked</cfif>  
                    value="1"> Full   
                    <input type="radio" class="radio-inline" name="SampleCollected"  <cfif getBiopsy.SampleCollected EQ 0 >checked</cfif> 
                     value="0"> Partial   
                  </div>
                 
                  <div class="form-group">
                    <label for="email">Blubber – Teflon vial (Time in LN2)  :</label>
                    <input type="checkbox" class="radio-inline" name="BlubberTeflonVial" <cfif getBiopsy.BlubberTeflonVial EQ 1 >checked</cfif>  value="1">  
                  </div>
                  
                  <div class="form-group">
                    <label for="email">Blubber – Cryovial, red   (Store in LN2) :</label>
                    <input type="checkbox" class="radio-inline" name="BlubberCryovialRed" <cfif getBiopsy.BlubberCryovialRed EQ 1 >checked</cfif>   value="1">  
                  </div>
                  <div class="form-group">
                    <label for="email">Blubber – Cryovial, blue (Store in LN2) :</label>
                    <input type="checkbox" class="radio-inline" name="BlubberCryovialBlue" <cfif getBiopsy.BlubberCryovialBlue EQ 1 >checked</cfif>   value="1">  
                  </div>
                  
                  <div class="form-group">
                    <label for="email">Skin – D Cryovial, green </label>
                    <input type="checkbox" class="radio-inline" name="SkinDCryovial" <cfif getBiopsy.SkinDCryovial EQ 1 >checked</cfif>   value="1">  
                  </div>
                  
                  </div><!--- col-md-6 end ---->
				 </div><!--- row end ---->
                   
            
                
                <div class="row  col-md-12">
                <div class="col-md-4 m-t-10"> 
                <input type="hidden" name="Biopsy_ID" value="#url.Biopsy#" />
                <button name="EditBiopsy" class="btn btn-success" type="submit">Update</button>
               
                </div>
                </div>
             
                </form>   
             
            </div>
        
        </div>
      </div>
    </div>
  </div>
  </div>
</cfoutput> 