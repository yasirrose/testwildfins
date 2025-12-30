<cfparam name='qGetCetacean.Name' default =''>
  <cfparam name='qGetCetacean.DOB' default =''>
  <cfparam name='qGetCetacean.DOD' default =''>
  <cfparam name='qGetCetacean.Sex' default =''>
  <cfparam name='qGetCetacean.First_Sighting_Date' default =''>
  <cfparam name='qGetCetacean.SourceSexed' default =''>
  <cfparam name='qGetCetacean.FB_Number' default =''>
  <cfparam name='qGetCetacean.YearOfBirth' default =''>
  <cfparam name='qGetCetacean.BodyOfWater' default =''>
  <cfparam name='qGetCetacean.bodyCondition' default =''>
  <cfparam name='qGetCetacean.DScore' default =''>
  <cfparam name='qGetCetacean.Sighting_ID' default =''>
  <cfparam name='qGetCetacean.SurveyType' default =''>
  
  <cfparam name='qGetCetacean.recordcount' default =''>
  <cfset getLesionTypeData = Application.StaticDataNew.getLesionType()>
  <cfset getRegions = Application.ConditionLesions.getRegions()>

  <cfset qgetLesionScarType = Application.StaticDataNew.getLesionScarType()>
      
<!--- Separate data for Lesion and Scar types --->
<cfset lesionTypeData = []>
<cfset scarTypeData = []>

<cfloop query="qgetLesionScarType">
    <cfif Type EQ "Lesion">
        <cfset ArrayAppend(lesionTypeData, {
            ID = qgetLesionScarType.ID,
            Name = qgetLesionScarType.Name,
            Active = qgetLesionScarType.Active,
            Type = qgetLesionScarType.Type
        })>
    <cfelseif Type EQ "Scar">
        <cfset ArrayAppend(scarTypeData, {
            ID = qgetLesionScarType.ID,
            Name = qgetLesionScarType.Name,
            Active = qgetLesionScarType.Active,
            Type = qgetLesionScarType.Type
        })>
    </cfif>
</cfloop>

  <cfparam name='arr' default =''>
  <cfset variables.dsn = "wildfins_new">
  <cfset setLeftImage  = '#Application.CloudRoot#no-image.jpg'> 
  <cfset setRightImage  = '#Application.CloudRoot#no-image.jpg'>
  <!--- working --->
  <cfset qSurveysId = Application.SightingNew.qSurveysId()>

  <cfif isdefined('FORM.CetaceanId')>
    <cfquery name="qgetlesionCode" datasource="#Application.dsn#">
      select Code from Cetaceans where ID = '#FORM.CetaceanId#'
    </cfquery>
      <!--- <cfdump var="#FORM.CetaceanId#" abort="true"> --->
    <cfset form.cetacean_Code = qgetlesionCode.Code>    
    <cfset qgetPermanentScar = Application.Cetaceans.getPermanentScar(argumentCollection="#Form#")>
    
    <cfset qGetCetacean = Application.Cetaceans.getCetacean(argumentCollection="#Form#")>
    
    <!--- <cfset qgetCetacean_Lesions = Application.Cetaceans.getCetacean_Lesions(argumentCollection="#Form#")> --->
    <!--- <cfdump var="#qgetlesionCode.Code#" abort="true"> --->
    <cfif qGetCetacean.RECORDCOUNT EQ 0> 
      <cfset isDataAvaiable = "Record not found on selected CODE">       
    </cfif>
    <!--- <cfdump var="#Application.CloudDirectory##qGetCetacean.ImageName#" abort="true"> --->

    <cfif qGetCetacean.ImageName NEQ '' and FileExists('#Application.CloudRoot##qGetCetacean.ImageName#')>
      <cfset  setLeftImage = '#Application.CloudRoot##qGetCetacean.ImageName#'>
    <cfelse>
      <cfloop query='qGetCetacean'>
        <cfif qGetCetacean.ImageName NEQ ''>
          <cfset Fin_Left = '#Application.CloudRoot##qGetCetacean.ImageName#'>
          <cfif FileExists('#Application.CloudDirectory##Fin_Left#')>
            <cfset  setLeftImage = '#Application.CloudRoot##Fin_Left#'>
            <cfbreak>
          </cfif>	
        </cfif>                       
      </cfloop>
    </cfif>
    
  
    <cfif qGetCetacean.SecondaryImage NEQ '' and FileExists('#Application.CloudRoot##qGetCetacean.SecondaryImage#')>
      <cfset  setRightImage = '#Application.CloudRoot##qGetCetacean.SecondaryImage#'>
    <cfelse>
        <cfloop query='qGetCetacean'>
            <cfif qGetCetacean.SecondaryImage NEQ ''>
                <cfset Fin_Right = '#Application.CloudRoot##qGetCetacean.SecondaryImage#'>
                <cfif FileExists('#Application.CloudDirectory##Fin_Right#')>
                    <cfset setRightImage = '#Application.CloudRoot##Fin_Right#'>
                    <cfbreak>
                </cfif>	
            </cfif>                       
        </cfloop>
    </cfif>
  
  
    <!--- create array --->
   <cfset Arr = ArrayNew(1)>
  
   <!--- loop through query --->
    <cfloop query="qGetCetacean">
      <cfset structofCetacean = StructNew() />
      <cfset structofCetacean["AtLatitude"] = qGetCetacean.AtLatitude>
      <cfset structofCetacean["AtLongitude"] = qGetCetacean.AtLongitude>
    
      <cfset structofCetacean["Sighting_ID"] = qGetCetacean.Sighting_ID>
      <cfset structofCetacean["SightingNo"] = qGetCetacean.SightingNo>
      <cfset structofCetacean["DateSeen"] = DateTimeFormat(qGetCetacean.DateSeen, "MM/dd/YYYY")>
      <cfset ArrayAppend(Arr,structofCetacean)>
    
    </cfloop>
   <!---SerializeJSON --->
   <cfset Arr = SerializeJSON(Arr)>
     
    <cfset Sighting_ID = ValueList(qGetCetacean.Sighting_ID,",")>
    <cfset code = qGetCetacean.Code>
    <cfif Sighting_ID NEQ ''>
      <cfset qGetCetaceanFriends = Application.Cetaceans.getCetaceanFriends(#Sighting_ID#,#code#)>
    </cfif>
  
  </cfif>

  <cfif isdefined('FORM.Sighting_ID') and FORM.Sighting_ID neq ''>
    <cfset qgetCetacean_Lesions = Application.Cetaceans.getCetacean_Lesions( argumentCollection="#Form#" )>

  </cfif>

  <!--- Cetacean Species ---> 
  <cfset qgetCetaceanSpecies = Application.StaticDataNew.getCetaceanSpecies()>
  <cfif isdefined('FORM.Cetacean_Species')>
    <cfset getCetaceansCode = Application.SightingNew.getCetaceansCode(#FORM.Cetacean_Species#)>
  </cfif>
  
  <style>
  .cetacean_images {
    color: black;
    font-weight: bold;
  }
  .main-form-section a#image img {
      width: 100%;
      margin-bottom: 10px;
      height: auto;
  }
  .height-sm {
      height: 332px!important;
  }
  .dataTables_scroll .lison-history-responsive {
      overflow: hidden;
      overflow-x: auto;
  }
  .dataTables_scroll .lison-history-responsive .lesion-history-table {
      width: 600px;
  }

  .cetcean-form .select2-container--default {
      width: 100% !important;
    }

  @media (max-width: 1200px) {
    .myimg img {
      width: 150px !important;
    }

    .catecean_container {
      width: 100% !important;
    }

    .img-row {
      display: flex;
    }

    .img-col {
      text-align: center;
    }

    .cetcean-form .select2-container--default {
      width: 100% !important;
    }

    .lesion-table {
      width: 100% !important;
    }
  }

  @media (max-width: 500px) {
  .myimg img {
    width: 100px !important;
  }
}
  </style>
  
  <cfoutput>
  <script>
  var obj = [] ;
  arr = '<cfoutput>#Arr#</cfoutput>';
  if (arr != '') {
   obj = JSON.parse(arr);
   }
  </script>
  
    <div id="content" class="content">
      <!-- begin breadcrumb -->
      <ol class="breadcrumb pull-right">
        <li><a href="javascript:;">#URL.Module#</a></li>
        <li><a href="javascript:;" class="active">#URL.Page#</a></li>
      </ol>
      <!-- end breadcrumb -->
      <!-- begin page-header -->
      <h1 class="page-header">Cetacean History</h1>
  
      <cfif isdefined('isDataAvaiable')>
        <div class="alert alert-warning"> <strong>Alert!</strong> #isDataAvaiable# </div>
      </cfif>
  
      <!-- end page-header -->
      <div class="section-container section-with-top-border p-b-10">
        <!-- begin row -->
        <div class="panel main-form-section p-t-10">
        <div class="row">
            <div  class="pull-right col-lg-12 catecean_container" style="margin-bottom:10px">
              <div class="col-lg-7 col-md-12">
                <div class='row'>
                  <div class="col-lg-6 col-md-12">
                      <div class="specie-area">
                        <form id="myform" class="cetcean-form" action="#Application.siteroot#?Module=Cetacean&Page=CetaceanHistory" method="post" >
                            <label for="sel1">Select Species</label>
                            <select class="form-control search-box" id="Cetacean_Species" name="Cetacean_Species" onchange="this.form.submit()">
                                <option value="0">Select Species</option>
                                <cfloop query="qgetCetaceanSpecies">
                                    <option value="#qgetCetaceanSpecies.id#" <cfif isdefined('FORM.Cetacean_Species') and FORM.Cetacean_Species eq qgetCetaceanSpecies.id>selected</cfif>> #qgetCetaceanSpecies.CetaceanSpeciesName# </option>
                                </cfloop>
                            </select>
                        </form>
                      </div>
                       <!--- <div class="specie-area">
                        <form id="myform" class="cetcean-form" action="#Application.siteroot#?Module=Cetacean&Page=CetaceanHistory" method="post" >
                            <label for="sel1">Select SurveyID</label>
                            <select class="form-control search-box" id="Cetacean_SurveyID" name="Cetacean_SurveyID" onchange="setSurveyId(this.value)">
                                <option value="0">Select SurveyID</option>
                                <cfloop query="qSurveysId">
                                  <!---<option value="#qSurveysId.id#" <cfif isdefined('qgetCetacean_Lesions.surveyid') and qgetCetacean_Lesions.surveyid eq qSurveysId.id>selected</cfif> >#qSurveysId.id#</option>--->
                                </cfloop>
                            </select>
                        </form>
                      </div> --->
                      <div class="code-area">
                        <form id="myformmmmm" class="cetcean-form" action="#Application.siteroot#?Module=Cetacean&Page=CetaceanHistory" method="post" >
                            <input type="hidden" name="Cetacean_Survey" id="Cetacean_Survey" value=''>
                            <cfif isdefined('FORM.Cetacean_Species')>
                              <input type="hidden" name="Cetacean_Species" value='#FORM.Cetacean_Species#'>
                            </cfif>
                            <label for="sel1">Select Code</label>
                            <select class="form-control search-box" required id="Cetacean_dscore" name="CetaceanId" onchange="this.form.submit()">
                              <option value="0">Select Code</option>
                                <cfif isdefined('FORM.Cetacean_Species')>
                                <cfloop query="getCetaceansCode">
                                  <option value="#getCetaceansCode.id#" <cfif isdefined('FORM.CetaceanId') and FORM.CetaceanId eq getCetaceansCode.id>selected</cfif>> #getCetaceansCode.Name# | #getCetaceansCode.code#</option>
                                </cfloop>
                               </cfif>
                            </select>
                        </form>
                      </div>
                  </div>
  
                  <div class="col-lg-6 col-md-12">
                    <div class="row img-row">
                      <div class="col-lg-6 col-md-12 img-col"> 
                          <a href="##" id="image" class="myimg">
                            <img src='#setLeftImage#' width="150" height="160" id="imageresource"/>
                            <p class="text-center cetacean_images">Left Photo</p>
                          </a>
                      </div>
  
                      <div class="col-lg-6 col-md-12 img-col"> 
                          <a href="##" id="image" class="myimg">
                            <img src='#setRightImage#' width="150" height="160" id="imageresource"/>
                            <p class="text-center cetacean_images">Right Photo</p>
                          </a>
                      </div>
                    </div>
                  </div>
  
              </div>
  
              
                <div class="">
                 <div class="row">
                    <div class="col-lg-4">
                      <div class="form-group">
                        <label for="email">Cetacean Name:</label>
                        <input type="text" class="form-control" name="DolphinName" id="Cetacean_name"  readonly="readonly" value="#qGetCetacean.Name#">
                      </div>
                    </div>
                    <div class="col-lg-4">
                      <div class="form-group">
                        <label for="email">FB:</label>
                        <input type="text" class="form-control" name="DolphinName" id="Cetacean_name"  readonly="readonly" value="#qGetCetacean.FB_Number#">
                      </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-lg-4">
                    <div class="form-group">
                      <label for="email">DOB:</label>
                      <input type="text" class="form-control" name="" id="DOB"  readonly="readonly" value="#DateFormat(qGetCetacean.DOB,'mm/dd/yyyy')#">
                    </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group">
                      <label for="email">DOD:</label>
                      <input type="text" class="form-control" name="" id="DOD"  readonly="readonly"  value="#DateFormat(qGetCetacean.DOD,'mm/dd/yyyy')#">
                    </div>
                  </div>
                  <div class="col-lg-2">
                    <div class="form-group">
                      <label for="email">Sex</label>
                      <input type="text" class="form-control" name="" id="total_sightings"  readonly="readonly" value='#qGetCetacean.SEX#'>
                    </div>
                  </div>
                  <div class="col-lg-2">
                    <div class="form-group">
                      <label for="email">Sourced Sex</label>
                      <cfif qGetCetacean.SourceSexed NEQ "">
                        <cfset setSourceSexName = Application.Cetaceans.getSourceSexName(#qGetCetacean.SourceSexed#)>
                      <cfelse>
                        <cfset setSourceSexName = "">
                      </cfif>
                      <input type="text" class="form-control" name="" id="total_sightings"  readonly="readonly" value='#setSourceSexName#'>
                    </div>
                  </div>
                </div>
                  
                  <div class="row">
                   <div class="col-lg-4">
                    <div class="form-group">
                      <label for="email">First Sighting Date :</label>
                      <input type="text" class="form-control" id="total_sightings"  readonly="readonly" value="#DateFormat(qGetCetacean.First_Sighting_Date,'mm/dd/yyyy')#">
                    </div>
                  </div>
                    <div class="col-lg-4">
                    <div class="form-group">
                      <label for="email">Total Sightings</label>
                      <input type="text" class="form-control" name="" id="total_sightings"  readonly="readonly" value='#qGetCetacean.recordcount#'>
                    </div>
                  </div>
                  </div>
                </div>
                <br>
                <div class="row dolphin-history-table">
                  
                <div class="col-md-12" >
                    <div class="dataTables_scroll" style="overflow:auto; max-height: 200px;">
                      <div class="dataTables_scrollHead ">
                        <div class="dataTables_scrollHeadInner" >
                          <table class="table table-striped table-bordered dataTable no-footer" id="survey_table" role="grid">
                            <thead>
                              <tr role="row">
                                <th  rowspan="1" colspan="1" >Survey ID</th>
                                <th  rowspan="1" colspan="1" >Date Seen</th>
                                <th  rowspan="1" colspan="1" >Sighting ID</th>
                                <th  rowspan="1" colspan="1" >Survey Route</th>
                                <th  rowspan="1" colspan="1" >Sighting No</th>
                                <th  rowspan="1" colspan="1" >Sighting Type</th>
                                <th  rowspan="1" colspan="1" >Body Condition</th>
                                <th  rowspan="1" colspan="1" >DScore</th>
                                <th  rowspan="1" colspan="1" >Body Of Water</th>
                                <th  rowspan="1" colspan="1" >Fetals Calf Yoy</th>
                                </tr>
                            </thead>
                          <tbody id="DateSeen">
                          <cfif isdefined('FORM.CetaceanId')>	
                            <cfset lastSurveyID = "">
                            <cfloop query='qGetCetacean'>

                              <cfquery name="qgetsurveyRoutename" datasource="#Application.dsn#">
                                SELECT RouteName
                                FROM TLU_SurveyRoute
                                WHERE ID IN (
                                    <cfqueryparam value="#qGetCetacean.Survey_Route#" list="true" cfsqltype="CF_SQL_INTEGER">
                                )
                            </cfquery>
                            

                                <cfset routeNames = ValueList(qgetsurveyRoutename.RouteName)>


                                <cfif lastSurveyID NEQ qGetCetacean.Survey_ID>
                                    <tr role="row" class="odd">
                                  <td class="sorting_1">#qGetCetacean.Survey_ID#</td>
                                  <td class="sorting_1">#DateFormat(qGetCetacean.DATESEEN,'mm/dd/yyyy')#</td>
                                  <td class="sorting_1">
                                    <!--- #qGetCetacean.Sighting_ID# --->
                                    
                                    <!--- <select class="form-control sightingSelect" onchange="setSightingNo(this)">
                                        <option value="">Select Sighting</option>

                                        <cfset startRow = currentrow>
                                        <cfloop from="#startRow#" to="#qGetCetacean.recordcount#" index="i">
                                            <cfif qGetCetacean.Survey_ID[i] NEQ qGetCetacean.Survey_ID>
                                                <cfbreak>
                                            </cfif>

                                            <option 
                                                value="#qGetCetacean.Sighting_ID[i]#"
                                                data-sightingno="#qGetCetacean.SightingNo[i]#">
                                                #qGetCetacean.Sighting_ID[i]#
                                            </option>
                                        </cfloop>
                                    </select> --->


                                    <form id="lesionForm" method="post" action="#Application.siteroot#?Module=Cetacean&Page=CetaceanHistory">
                                        <cfif isdefined('FORM.Cetacean_Species')>
                                            <input type="hidden" name="Cetacean_Species" value="#FORM.Cetacean_Species#">
                                        </cfif>
                                        <cfif isdefined('FORM.CetaceanId')>
                                            <input type="hidden" name="CetaceanId" value="#FORM.CetaceanId#">
                                        </cfif>
                                        <cfif isdefined('FORM.Cetacean_Survey')>
                                            <input type="hidden" name="Cetacean_Survey" value="#FORM.Cetacean_Survey#">
                                        </cfif>
                                           <input type="hidden" name="selected_survery_id" value="<cfif isdefined('qGetCetacean.Survey_ID') >#qGetCetacean.Survey_ID#</cfif>">
                                        <!--- Add Sighting ID dropdown --->
                                        <label>Select Sighting</label>
                                        <cfset currentRowSurveyID = qGetCetacean.Survey_ID>
                                        <select name="Sighting_ID" onchange="updateSightingNo(this)">
                                           <option value="">Select Sighting</option>
                                              <cfloop query="qGetCetacean">
                                                  <!--- Only include sightings for the current survey_id --->
                                                  <cfif qGetCetacean.Survey_ID eq currentRowSurveyID>
                                                      <option value="#qGetCetacean.Sighting_ID#"
                                                              data-sightingno="#qGetCetacean.SightingNo#"
                                                          <cfif isdefined('FORM.Sighting_ID') and FORM.Sighting_ID eq qGetCetacean.Sighting_ID>selected</cfif>>
                                                          #qGetCetacean.Sighting_ID#
                                                      </option>
                                                  </cfif>
                                              </cfloop>
                                        </select>

                                    </form>


                                  </td>
                                  <td class="sorting_1">#routeNames#</td>
                                  <td class="sorting_1">
                                    <!--- #qGetCetacean.SightingNo# --->

                                     <span class="sightingNo">
                                          <cfif isdefined('FORM.Sighting_ID')>
                                              <!--- Pre-select the Sighting No based on selected Sighting ID --->
                                              <cfloop query="qGetCetacean">
                                                  <cfif FORM.Sighting_ID eq qGetCetacean.Sighting_ID>
                                                      #qGetCetacean.SightingNo#
                                                  </cfif>
                                              </cfloop>
                                          </cfif>
                                      </span>

                                  </td>
                                  <td class="sorting_1">#qGetCetacean.SurveyType#</td>
                                  <td class="sorting_1">
                                    <cfif #qGetCetacean.bodyCondition# eq 1>
                                        Emaciated
                                    </cfif>
                                    <cfif #qGetCetacean.bodyCondition# eq 2>
                                        Underweight/Thin
                                    </cfif>
                                    <cfif #qGetCetacean.bodyCondition# eq 3>
                                        Ideal
                                    </cfif>
                                    <cfif #qGetCetacean.bodyCondition# eq 4>
                                        Overweight
                                    </cfif>
                                    <cfif #qGetCetacean.bodyCondition# eq 5>
                                        Obese
                                    </cfif>
                                    <cfif #qGetCetacean.bodyCondition# eq 6>
                                        CBD
                                    </cfif>
                                  </td>
    
                                  <cfset qgetFin_Fluke_Dscore = Application.Sighting.getFin_Fluke_Dscore(#qGetCetacean.DATESEEN#,#FORM.CetaceanId#,#FORM.Cetacean_Species#)>
                                  <cfif qgetFin_Fluke_Dscore.RECORDCOUNT GT 0 > 
                                  <td class="sorting_1">#qgetFin_Fluke_Dscore.DScore#</td>
                                  <cfelse>
                                  <td class="sorting_1">#qGetCetacean.DScore#</td>
                                  </cfif>
                                  
                                  <cfif qGetCetacean.BodyOfWater NEQ "">
                                    <cfset setBodyOfWater = Application.Cetaceans.getBodyOfWaterName(#qGetCetacean.BodyOfWater#)>
                                  <cfelse>
                                    <cfset setBodyOfWater = "">
                                  </cfif>
                                  <td class="sorting_1">#setBodyOfWater#</td>
    
                                  <td class="sorting_1">
                                    <cfif qGetCetacean.Fetals EQ "on">
                                      Fetals<cfif qGetCetacean.Calf EQ "on" or qGetCetacean.Yoy EQ "on">,</cfif>
                                      </cfif>
                                      <cfif qGetCetacean.Calf EQ "on">
                                      Calf <cfif qGetCetacean.Yoy EQ "on">,</cfif>
                                      </cfif>
                                      <cfif qGetCetacean.Yoy EQ "on">
                                      Yoy
                                      </cfif>
                                  </td>
                                  
                                </tr>
                                </cfif>
                              

                                <cfset lastSurveyID = qGetCetacean.Survey_ID>
                            </cfloop>	
                          </cfif>		
                          </tbody>
                        </table>

                       <script>
function updateSightingNo(selectObj) {
    var selectedOption = selectObj.options[selectObj.selectedIndex];
    var sightingNo = selectedOption.getAttribute("data-sightingno");

    // Find the corresponding span in the same row and update it
    var row = selectObj.closest("tr");
    row.querySelector(".sightingNo").innerText = sightingNo ? sightingNo : "";
    
    // Optionally, submit the form if you want the page to reload
    selectObj.form.submit();
}
</script>

                      </div>
                    </div>
                </div>
  
                </div>
              
              </div>
              
            </div>
            <div class="col-lg-5 col-md-12" id="Cetacean-map">
              <h5 class="m-t-0">Sightings</h5>
              <div id="google-map-cobalt" class="height-sm">
              </div> 
            </div>
        <div class="col-md-12">
                     <div class="dataTables_scroll" style="overflow:auto; max-height: 200px;">
                            <div class="dataTables_scrollHead" style="overflow: hidden; position: relative; border: 0px none; width: 100%;">
                              <div class="dataTables_scrollHeadInner" style="box-sizing: content-box; width: 100%;">
                                <table class="table table-striped table-bordered dataTable no-footer " id="friends" >
                                  <thead>
                                    <tr>
                                      <th style='width:28%'>Friends(Code-Name)</th>
                                      <th style='width:21%'>Sex</th>
                                      <th style='width:25%'>Times Seen</th>
                                    </tr>
                                  </thead>
                              </div>
                            </div>
                            <div class="dataTables_scrollBody" >
                                <tbody id='Cetacean_friends'>
                                  <cfif isdefined('FORM.CetaceanId') and isdefined("qGetCetaceanFriends")>	
                                    <cfloop query='qGetCetaceanFriends'>
                                        <tr>
                                            <td style='width:28%'>#qGetCetaceanFriends.CetaceanCodeName#</td>
                                            <td style='width:21%'>#qGetCetaceanFriends.Sex#</td>
                                            <td style='width:25%'>#qGetCetaceanFriends.times#</td>
                                        </tr>
                                      </cfloop>	
                                  </cfif>		
                                </tbody>
                              </table>
                            </div>
                      </div>
                  </div>
          </div>
        </div>
        <div class="dataTables_scroll col-md-12">
        <h3>Lesion History</h3>
                  <div class="panel pagination-inverse m-b-0 clearfix table-overflow overflow-clearfix">
                    <table id="lesionHistoryTable" class="table table-bordered table-hover">
                        <thead>
                            <tr class="inverse">
                                <th>Date Seen</th>
                                <th>Survey ID</th>
                                <th>Sighting ID</th>
                                <th>Sighting No</th>
                                <th>Photo Number</th>
                                <th>Comments</th>
                                <th>Type Name</th>
                                <th>Permanent Date</th>
                                <th>Lesion/Scar Type</th>
                                <th>Side</th>
                                <th>Status</th>
                                <th>Region</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                      	<tbody>
                          <cfif isdefined('FORM.Sighting_ID')>	
                              <!--- <cfdump var="#qgetCetacean_Lesions#" abort="true">--->
                              
                              <cfloop query='qgetCetacean_Lesions'>
                                <cfif qgetCetacean_Lesions.id neq '43'>                                
                                <tr role="row" class="odd" id="tr_#qgetCetacean_Lesions.id#">
                                  <td class="sorting_1">#DateFormat(qgetCetacean_Lesions.DATESEEN,'mm/dd/yyyy')#</td>
                                  <td class="sorting_1">#qgetCetacean_Lesions.surveyid#</td>
                                  <td class="sorting_1">#qgetCetacean_Lesions.sightid#</td>
                                  <td class="sorting_1" >
                                    <cfif qgetCetacean_Lesions.SightingText NEQ ''>
                                       #qgetCetacean_Lesions.SightingText#
                                    <cfelse>
                                       #qgetCetacean_Lesions.SightingNumber#
                                    </cfif>
                                    <!--- #qgetCetacean_Lesions.SightingNumber# --->
                                  </td>
                                  <td class="sorting_1" id="PhotoNumber_#qgetCetacean_Lesions.id#">#qgetCetacean_Lesions.PhotoNumber#</td>
                                  <td class="sorting_1" id="Comments_#qgetCetacean_Lesions.id#">#qgetCetacean_Lesions.Comments#</td>
                                  <td class="sorting_1" id="TypeName_#qgetCetacean_Lesions.id#">#qgetCetacean_Lesions.TypeName#</td>
                                  <td class="sorting_1" id="PermanentScar_date_#qgetCetacean_Lesions.id#">
                                    #DateFormat(qgetCetacean_Lesions.PermanentScar_date,'mm/dd/yyyy')#
                                  </td>
                                  <td class="sorting_1" id="LesionType_#qgetCetacean_Lesions.id#">#qgetCetacean_Lesions.LesionType#</td>
                                  <td class="sorting_1" id="Side_L_R_#qgetCetacean_Lesions.id#">#qgetCetacean_Lesions.Side_L_R#</td>
                                  <td class="sorting_1" id="Status_#qgetCetacean_Lesions.id#">#qgetCetacean_Lesions.Status#</td>
                                  <td class="sorting_1" id="Region_#qgetCetacean_Lesions.id#">#qgetCetacean_Lesions.Region#</td>
                                  <td>
                                  <button onclick="openLesionHistoryModal(#qgetCetacean_Lesions.id#)">Edit</button>
                                  <cfif (permissions eq "full_access" or findNoCase("Delete LH", permissions) neq 0)>
                                    <button onclick="deleteLesion(#qgetCetacean_Lesions.id#)">Delete</button>
                                  </cfif>
                                  </td>
                                  
                                </tr>
                              </cfif>
                              </cfloop>	
                            </cfif>
                        </tbody>
                    </table>
                </div>
      </div>
      </div>


        <h3>Permanent Scar History</h3>
              <div class="panel pagination-inverse m-b-0 clearfix table-overflow overflow-clearfix" style="margin-top:10px">
                <table id="data-table" data-order='[[1,"asc"]]' class="table table-bordered table-hover">
                  <thead>
                    <tr class="inverse">
                      <th>Cetacean ID</th>
                      <th>Code</th>
                      <th>Date</th>
                      <th>Scar Type </th>
                      <th>Body Region</th>
                      <th>Side of Body</th>
                      <th>Image</th>
                    </tr>
                  </thead>
                  <tbody >
                  <cfif isDefined('qgetPermanentScar')>
                    <cfloop query='qgetPermanentScar'>
                      <tr class="gradeU_#qgetPermanentScar.ID#">
                        <td id="CI_#qgetPermanentScar.ID#">#qgetPermanentScar.CetaceanId#</td>
                        <td id="CetaceanCode_#qgetPermanentScar.ID#">#qgetPermanentScar.CetaceanCode#</td>
                        <td id="ScarDate_#qgetPermanentScar.ID#">#DateFormat(qgetPermanentScar.ScarDate, "mm/dd/yyyy")#</td>
                        <td id="ScarType_#qgetPermanentScar.ID#">#qgetPermanentScar.ScarTypeName#</td>
                        <td id="BodyRegion_#qgetPermanentScar.ID#">#qgetPermanentScar.BodyRegion#</td>
                        <td id="SideOfBody_#qgetPermanentScar.ID#">#qgetPermanentScar.SideOfBody#</td>
                        <td>
                        <cfif qgetPermanentScar.PrimaryImage neq ''>
                            <cfset setPrimaryImage=qgetPermanentScar.PrimaryImage>
                        <cfelse>
                            <cfset setPrimaryImage='no-image.jpg'>
                        </cfif>
                        <cfif qgetPermanentScar.SecondryImage neq ''>
                            <cfset setSecondaryImage=qgetPermanentScar.SecondryImage>
                        <cfelse>
                            <cfset setSecondaryImage='no-image.jpg'>
                        </cfif>
                        <img id="PrimaryImage_#qgetPermanentScar.ID#" src="#Application.CloudRoot##setPrimaryImage#"  style="max-width: 50%;">
                        <img id="SecondryImage_#qgetPermanentScar.ID#" src="#Application.CloudRoot##setSecondaryImage#"  style="max-width: 50%;">
                    </td>
                      </tr>
                    </cfloop>
                    </cfif>
                  </tbody>
                </table>
            </div>
    </div>
    </div>

  </cfoutput>
  
  <!-- Creates the bootstrap modal where the image will appear -->
  <div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:48%">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <h4 class="modal-title" id="myModalLabel">Fin preview</h4>
        </div>
        <div class="modal-body">
          <img src="" id="imagepreview" style="width: auto; height: auto;" >
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

<!-- modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog" style="max-width: 35%;">
  
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id=""></h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label for="dateSen">Date Seen:</label>
          <input type="hidden" class="form-control" id="IDForupdateData" >
          <input type="text" class="form-control" id="dateSen" disabled>
        </div>
        <div class="form-group">
          <label for="surveyID">Survey ID:</label>
          <input type="text" class="form-control" id="surveyID" disabled>
        </div>
        <div class="form-group">
          <label for="sightingNo">Sighting No:</label>
          <input type="text" class="form-control" id="sightingNo" disabled>
        </div>
        <div class="form-group">
          <label for="photoNumber">Photo Number:</label>
          <input type="text" class="form-control" id="photoNumber">
        </div>
        <div class="form-group">
          <label for="comments">Comments:</label>
          <input type="text" class="form-control" id="comments">
        </div>

        <div class="form-group">
          <label for="TypeName">TypeName:</label>          
          <select id="TypeName" name="TypeName" class="form-control" disabled>
            <option value="" >Please Select Type</option>
            <option value="Lesion_Type" >Lesion_Type</option>
            <option value="Scar_Type" >Scar Type</option>
          </select>
        </div>

        <input type="hidden" name="HiddenTypeName" id="HiddenTypeName">

        <div class="form-group">
          <label for="lesionType">Lesion Type:</label>
           <select class="form-control customLesionSelect" id="lesionType" name="lesionType">
              
          </select>
        </div>

         <div class="form-group">
          <label for="permanentScar_date">Permanent Date:</label>
          <input type="date" class="form-control" id="permanentScar_date">
        </div>

        

        <div class="form-group">
          <label for="side">Side:</label>          
          <select id="side">
            <option value="">Side</option>
            <option value="L">L</option>
            <option value="R">R</option>
            <option value="L/R">L/R</option>
          </select>
        </div>
        <div class="form-group">
          <label for="status">Status:</label>
          <select id="status">
            <option value="">Status</option>
            <option value="Fresh">Fresh</option>
            <option value="Healing">Healing</option>
            <option value="Healed">Healed</option>
          </select>
        </div>
        <div class="form-group">
          <label for="region">Region:</label>          
          <select class="form-control search-box selected-region" multiple="multiple" id="region" name="region">
            <cfoutput>
              <cfset counter = 1>
              <cfloop query="getRegions">
                    <option value="#getRegions.ID#">#counter&' - '&getRegions.RegionName#</option>
                    <cfset counter = counter + 1>
              </cfloop>
            </cfoutput>
          </select>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" onclick="updateFunction()" class="btn btn-success" >Update</button>
      </div>
    </div>
  </div>
</div>



  
  
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBxYI6DN6VquzG8dxWfN04TAK5Rfngn9ug"></script>
  <script>
  // $(document).ready(function() {
  //   localStorage.setItem("selectedValCetacean", '');	
  //   });
 
  
  function setSurveyId(val){
    $('#Cetacean_Survey').val(val);
    Cetacean_dscore = $('#Cetacean_dscore').val();
    
    var dropdown = document.getElementById("Cetacean_SurveyID");
    var selectedValue = dropdown.value;
    localStorage.setItem("selectedValCetacean", selectedValue);

 



    if(Cetacean_dscore != '0'){      
      var form = document.getElementById("myformmmmm");
      form.submit();
    }

  }

  //  document.addEventListener("DOMContentLoaded", function() {
  //     var dropdown = document.getElementById("Cetacean_SurveyID");
  //     var selectedValue = localStorage.getItem("selectedValCetacean");
      
  //     if (selectedValue) {
  //       dropdown.value = selectedValue;
  //     }
  //   });
  function deleteLesion(id){
    
    if(confirm('Are you sure to Delete All Record?'))
      {
        $.ajax({
              type: "POST",
              url: application_root + "Cetaceans.cfc?method=deleteLesion",
              data: {
                  id: id,
              },
              success: function(response) {
                var response = JSON.parse(response);
                console.log(response);
                $('#tr_' + id).remove();
                alert('Lesion deleted successfully!');

              },
              error: function(error) {
                  console.error("Error:", error);
              }
          });


      }
      else{
        return false;
      }
    }

  function updateFunction(){
    id = $('#IDForupdateData').val();
    photoNumber = $('#photoNumber').val();
    lesionType = $('#lesionType').val();
    TypeName = $('#TypeName').val();
    HiddenTypeName = $('#HiddenTypeName').val();
    Side = $('#side').val();
    status = $('#status').val();
    region = $('#region').val();
    comments = $('#comments').val();
    permanentScar_date = $('#permanentScar_date').val();
    var resultString = region.join(',');
    // console.log(region);
    var region = $('#region').val();

      var selectedOptions = [];

      // Function to get option text from value
      function getOptionText(value) {
        return $('#region option[value="' + value + '"]').text();
      }

      // Add the text of initially selected options to the array
      if (region) {
        selectedOptions = region.map(getOptionText);
      }

      var extractedTexts = selectedOptions.map(function(item) {
        return item.split('- ')[1]; 
      });

      var seletedOption = extractedTexts.join(', ');

      console.log(seletedOption);
      console.log('TypeName: ' + TypeName);
      console.log('HIddenvalue: ' + HiddenTypeName);

    // return false;
    
    $.ajax({
          type: "POST",
          url: application_root + "Cetaceans.cfc?method=UpdateCetacean_LesionsByID",
          data: {
              id: id,
              photoNumber: photoNumber,
              lesionType: lesionType,
              Side: Side,
              status: status,
              comments: comments,
              region: resultString,
              permanentScar_date: permanentScar_date,
          },
          success: function(response) {
            var response = JSON.parse(response);
            console.log(response);
            $('#PhotoNumber_' + id).text(photoNumber);
            $('#LesionType_' + id).text(lesionType);
            $('#Side_L_R_' + id).text(Side);
            $('#Status_' + id).text(status);
            $('#Region_' + id).text(seletedOption);
            $('#Comments_' + id).text(comments);

            if (permanentScar_date && permanentScar_date !== "" && permanentScar_date !== "null") {
                var p_date = new Date(permanentScar_date);
                var p_year = p_date.getFullYear();
                var p_month = (p_date.getMonth() + 1).toString().padStart(2, '0');
                var p_day = p_date.getDate().toString().padStart(2, '0');
                var p_formattedDate = `${p_month}/${p_day}/${p_year}`;
                $('#PermanentScar_date_' + id).text(p_formattedDate);
            } else {
                $('#PermanentScar_date_' + id).text('');
            }

            // $('#PermanentScar_date_' + id).text(permanentScar_date);

            $('#myModal').modal('hide');
          },
          error: function(error) {
              console.error("Error:", error);
          }
      });
  }

 function openLesionHistoryModal(id)
 {
  //  alert(id)
   $('#myModal').modal('show');


    var selectElement = document.getElementById('Cetacean_dscore');
    var selectedOption = selectElement.options[selectElement.selectedIndex];
    var selectedText = selectedOption.text;
    var parts = selectedText.split('|');
    var cetacean_Code = parts[1].trim();
  

   $.ajax({
          type: "POST",
          url: application_root + "Cetaceans.cfc?method=getCetacean_LesionsByID",
          data: {
              id: id,
          },
          success: function(response) {
            var response = JSON.parse(response);
            console.log(response.DATA[0]);
            var data= response.DATA[0]; 


            var date = new Date(data[3]);
            var year = date.getFullYear();
            var month = (date.getMonth() + 1).toString().padStart(2, '0'); // Months are zero-indexed, so add 1
            var day = date.getDate().toString().padStart(2, '0');
            var formattedDate = `${month}/${day}/${year}`;

            // var p_date = new Date(data[13]);
            // var p_year = p_date.getFullYear();
            // var p_month = (p_date.getMonth() + 1).toString().padStart(2, '0'); // Months are zero-indexed, so add 1
            // var p_day = p_date.getDate().toString().padStart(2, '0');
            // var p_formattedDate = `${p_month}/${p_day}/${p_year}`


                var rawDate = data[14];
                if (rawDate && rawDate !== "" && rawDate !== "null") {
                    var p_date = new Date(rawDate);
                    var p_year = p_date.getFullYear();
                    var p_month = (p_date.getMonth() + 1).toString().padStart(2, '0');
                    var p_day = p_date.getDate().toString().padStart(2, '0');
                    var p_formattedDate = `${p_year}-${p_month}-${p_day}`;
                    $('#permanentScar_date').val(p_formattedDate);
                } else {
                    $('#permanentScar_date').val('');
                }

                
                $('#dateSen').val(formattedDate);
                $('#surveyID').val(data[1]);


              // $('#sightingNo').val(data[0]);
                $('#sightingNo').val(data[10] ? data[10] : data[0]);

                $('#photoNumber').val(data[9]);
                // $('#lesionType').val(data[4]);
                $('#comments').val(data[12]);
                $('#TypeName').val(data[13]);
                $('#HiddenTypeName').val(data[13]);
                // $('#permanentScar_date').val(p_formattedDate);

                // var regionVal = data[5];
                // hilocation = regionVal.split(",")
                // $('#region').val(hilocation).trigger('change');

                // "Cranial Ventral, Dorsal Fin, Caudal Ventral"
var regionVal = data[5]; // could be null or empty
if (regionVal && regionVal.trim() !== "") {
    var regions = regionVal.split(',').map(function(item) {
        return item.trim(); // remove extra spaces
    });

    // Deselect all first
    $('#region option').prop('selected', false);

    // Loop through options and select matching ones
    $('#region option').each(function() {
        var optionText = $(this).text();
        regions.forEach(function(region) {
            if (optionText.includes(region)) {
                $(this).prop('selected', true);
            }
        }.bind(this)); // bind to keep correct context
    });
} else {
    // If null or empty, deselect all options
    $('#region option').prop('selected', false);
}

$('#region').trigger('change');

console.log('regionVal: ' + regionVal)

                
                
                  // $("#region option:contains('" + regionVal + "')").filter(function() {
                  //   return $(this).text() === regionVal;
                  // }).prop('selected', true);

                  $('#side').val(data[6]);
                  $('#status').val(data[7]);
                  $('#IDForupdateData').val(id);

                  var lesionType = String(data[4]).trim(); // Value to match against
                  var lesionTypeDropdown = $('#lesionType');
                  lesionTypeDropdown.empty();
                  var matched = false;

                  var lesionTypeData = <cfoutput>#SerializeJSON(lesionTypeData)#</cfoutput>;
                  var scarTypeData = <cfoutput>#SerializeJSON(scarTypeData)#</cfoutput>;

                  if (data[13] === "Lesion_Type") {
                    lesionTypeData.forEach(function(option) {
                        lesionTypeDropdown.append(
                            `<option value="${option.Name}" ${
                                option.Name == lesionType ? "selected" : ""
                            }>${option.Name}</option>`
                        );
                        if (option.Name == lesionType) matched = true; // Mark as matched
                    });
                  } else if (data[13] === "Scar_Type") {
                      scarTypeData.forEach(function(option) {
                          lesionTypeDropdown.append(
                              `<option value="${option.Name}" ${
                                  option.Name == lesionType ? "selected" : ""
                              }>${option.Name}</option>`
                          );
                          if (option.Name == lesionType) matched = true; // Mark as matched
                      });
                  }

                  // If no match found, add data[4] as a new option and select it
                  if (!matched) {
                      lesionTypeDropdown.append(
                          `<option value="${lesionType}" selected>${lesionType}</option>`
                      );
                  }

                  if (!matched) {
                      lesionTypeDropdown.append(
                          `<option value="${lesionType}" selected>${lesionType}</option>`
                      );
                  }

                },
                error: function(error) {
                    console.error("Error:", error);
                }
            });

    }




  </script>
<style>
    /* Style for dropdowns */
    .select2{
      width: 100% !important;
    }
    select {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    /* Style for the selected option */
    select option:checked {
        background-color: #007bff; /* Change to your preferred color */
        color: #fff; /* Text color for the selected option */
    }
table.dataTable thead th, table.dataTable thead td {
    padding: 10px 6px!important;
}
table.dataTable tbody th, table.dataTable tbody td {
    
    width: 80px;
}
.dataTables_scroll .lison-history-responsive {
    overflow: hidden;
    overflow-x: hidden;
}
table thead tr th {
    width: 87px;
}
.overflow-clearfix {
  overflow: auto;
  max-height: 426px;
  border-radius: 0px;
  margin-bottom: 20px !important;
}
.overflow-clearfix table tr th {
  min-width: 90px !important;
}
.overflow-clearfix table>thead>tr.inverse>th {
  background-color: #ebeced !important;
  border-color: #bec3c6!important;
  color: #30373e !important;
}
.overflow-clearfix table tr td {
  min-width: 90px !important;
}
</style> 