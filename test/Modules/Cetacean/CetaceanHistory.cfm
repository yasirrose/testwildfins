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
  
  <cfparam name='arr' default =''>
  <cfset variables.dsn = "wildfins_new">
  <cfset setLeftImage  = '#Application.CloudRoot#no-image.jpg'> 
  <cfset setRightImage  = '#Application.CloudRoot#no-image.jpg'>
  
  <cfif isdefined('FORM.CetaceanId')>
    <cfquery name="qgetlesionCode" datasource="#Application.dsn#">
      select Code from Cetaceans where ID = '#FORM.CetaceanId#'
    </cfquery>
    <cfset form.cetacean_Code = qgetlesionCode.Code>
    <cfset qGetCetacean = Application.Cetaceans.getCetacean(argumentCollection="#Form#")>

    <cfset qgetCetacean_Lesions = Application.Cetaceans.getCetacean_Lesions(argumentCollection="#Form#")>
    <!--- <cfdump var="#qgetCetacean_Lesions#" abort="true"> --->
  
    
    <cfif qGetCetacean.RECORDCOUNT EQ 0> 
      <cfset isDataAvaiable = "Record not found on selected CODE">       
    </cfif>
  
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
    <cfset structofCetacean["DateSeen"] = DateTimeFormat(qGetCetacean.DateSeen, "YYYY-MM-DD")>
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
                      <div class="code-area">
                        <form id="myform" class="cetcean-form" action="#Application.siteroot#?Module=Cetacean&Page=CetaceanHistory" method="post" >
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
                      <input type="text" class="form-control" name="" id="DOB"  readonly="readonly" value="#DateFormat(qGetCetacean.DOB,'YYYY-MM-DD')#">
                    </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group">
                      <label for="email">DOD:</label>
                      <input type="text" class="form-control" name="" id="DOD"  readonly="readonly"  value="#DateFormat(qGetCetacean.DOD,'YYYY-MM-DD')#">
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
                      <input type="text" class="form-control" id="total_sightings"  readonly="readonly" value="#DateFormat(qGetCetacean.First_Sighting_Date,'YYYY-MM-DD')#">
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
                    <div class="dataTables_scroll" style="overflow:scroll; max-height: 200px;">
                      <div class="dataTables_scrollHead ">
                        <div class="dataTables_scrollHeadInner" >
                          <table class="table table-striped table-bordered dataTable no-footer" role="grid">
                            <thead>
                              <tr role="row">
                                <th  rowspan="1" colspan="1" >Survey ID</th>
                                <th  rowspan="1" colspan="1" >Date Seen</th>
                                <th  rowspan="1" colspan="1" >Sighting ID</th>
                                <th  rowspan="1" colspan="1" >Sighting No</th>
                                <th  rowspan="1" colspan="1" >Sighting Type</th>
                                <th  rowspan="1" colspan="1" >Body Condition</th>
                                <th  rowspan="1" colspan="1" >DScore</th>
                                <th  rowspan="1" colspan="1" >Body Of Water</th>
                                <th  rowspan="1" colspan="1" >Fetals Calf Yoy</th>
                              </tr>
                            </thead>
                          </table>
                        </div>
                      </div>
                      <div class="dataTables_scrollBody" >
                        <table class="table table-striped table-bordered dataTable no-footer dtr-inline" >
                          <tbody id="DateSeen">
                          <cfif isdefined('FORM.CetaceanId')>	
                            <cfloop query='qGetCetacean'>
                              <tr role="row" class="odd">
                                <td class="sorting_1">#qGetCetacean.Sighting_ID#</td>
                                <td class="sorting_1">#DateFormat(qGetCetacean.DATESEEN,'YYYY-MM-DD')#</td>
                                <td class="sorting_1">#qGetCetacean.Sighting_ID#</td>
                                <td class="sorting_1">#qGetCetacean.SightingNo#</td>
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
                            </cfloop>	
                          </cfif>		
                          </tbody>
                        </table>
                      </div>
                    </div>
                </div>
  
                  <div class="col-md-12">
                     <div class="dataTables_scroll">
                            <div class="dataTables_scrollHead" style="overflow: hidden; position: relative; border: 0px none; width: 100%;">
                              <div class="dataTables_scrollHeadInner" style="box-sizing: content-box; width: 100%;">
                                <table class="table table-striped table-bordered dataTable no-footer ">
                                  <thead>
                                    <tr>
                                      <th style='width:28%'>Friends(Code-Name)</th>
                                      <th style='width:21%'>Sex</th>
                                      <th style='width:25%'>Times Seen</th>
                                    </tr>
                                  </thead>
                                </table>
                              </div>
                            </div>
                            <div class="dataTables_scrollBody" >
                              <table class="table table-striped table-bordered dataTable no-footer ">
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
              <div class="col-lg-5 col-md-12" id="Cetacean-map">
                <h5 class="m-t-0">Sightings</h5>
                <div id="google-map-cobalt" class="height-sm">
                </div>
                
                <div class="dataTables_scroll">
                  <h3>Lesion History</h3>
                  <div class="lison-history-responsive">
                      <div class="lesion-history-table lesion-table" style="overflow: scroll; max-height: 200px;">
                        <div class="dataTables_scrollHead" >
                          <div class="dataTables_scrollHeadInner" >
                            <table class="table table-striped table-bordered dataTable no-footer" role="grid">
                              <thead>
                                <tr role="row">
                                  <th  rowspan="1" colspan="1" >Date Seen</th>
                                  <th  rowspan="1" colspan="1" >Sighting ID</th>
                                  <th  rowspan="1" colspan="1" >Sighting No</th>
                                  <th  rowspan="1" colspan="1" >Lesion Type</th>
                                  <th  rowspan="1" colspan="1" >Side</th>
                                  <th  rowspan="1" colspan="1" >Status</th>
                                  <th  rowspan="1" colspan="1" >Region</th>
                                </tr>
                              </thead>
                            </table>
                          </div>
                        </div>
                        <div class="dataTables_scrollBody" >
                          <table class="table table-striped table-bordered dataTable no-footer dtr-inline" >
                            <tbody id="DateSeen">
                            <cfif isdefined('FORM.CetaceanId')>	
                              <cfloop query='qgetCetacean_Lesions'>
                                <tr role="row" class="odd">
                                  <td class="sorting_1">#DateFormat(qgetCetacean_Lesions.DATESEEN,'YYYY-MM-DD')#</td>
                                  <td class="sorting_1">#qgetCetacean_Lesions.sightid#</td>
                                  <td class="sorting_1">#qgetCetacean_Lesions.SightingNumber#</td>
                                  <td class="sorting_1">#qgetCetacean_Lesions.LesionType#</td>
                                  <td class="sorting_1">#qgetCetacean_Lesions.Side_L_R#</td>
                                  <td class="sorting_1">#qgetCetacean_Lesions.Status#</td>
                                  <td class="sorting_1">#qgetCetacean_Lesions.Region#</td>
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
              
            </div>
          </div>
        </div>
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
  
  
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBxYI6DN6VquzG8dxWfN04TAK5Rfngn9ug"></script>
<style>
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
</style> 