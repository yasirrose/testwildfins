
  <cfoutput>
    <cfparam name="form.searchword" default=" ">
    <cfset cetaceanList =  Application.Cetaceans.get_CetaceanList(form.searchword) >
    <cfset cetaceanSpeciesList = Application.StaticDataNew.getCetaceanSpecies()>
    <cfparam name="message" default="">
    <cfif isdefined('FORM.insertScar')>
      <cfif isDefined('form.updateFormID') and form.updateFormID neq ''>
        <!--- <cfdump var="#form.updateFormID#" abort="true"> --->
            <cfset qinsertFinFlukee = Application.Sighting.UpdatePermanentScar(argumentCollection="#Form#")>
      <cfelse>
            <cfset qinsertFinFluke = Application.Sighting.insertPermanentScar(argumentCollection="#Form#")>
      </cfif>
    </cfif>  
       
    
    <cfset getDscoreCode = Application.Sighting.getDscoreDropdown()>
    <cfset qgetActiveScarType = Application.StaticDataNew.getActiveScarType()>
    
    <cfparam name="FORM.DolphinID_fetch" default="">
    
    
    
      <div id="content" class="content"> 
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
          <li><a href="javascript:;">Home</a></li>
          <li><a href="javascript:;" class="active">Permanent Scar</a></li>
        </ol>
        <!-- end breadcrumb --> 
        <!-- begin page-header -->
        <h1 class="page-header">Enter Permanent Scar
          <cfinclude template="SightingMenu.cfm"> 
        </h1>
    
        <!-- end page-header -->
        <div class="section-container section-with-top-border p-b-10"> 
          <!-- begin row -->
          <div class="main-form-section">
          <div class="row">
          
            
            <cfif isdefined('qinsertFinFluke') and qinsertFinFluke eq 1  >
              <div class="alert alert-success fade in m-b-10" id="sucess-div">
                  <strong>Successfully Inserted! </strong>
                  <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
              </div>
            </cfif> 
            <cfif isdefined('qinsertFinFlukee') and qinsertFinFlukee eq 1  >
              <div class="alert alert-success fade in m-b-10" id="sucess-div">
                <strong>Successfully Updated! </strong>
                <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
              </div>
            </cfif> 
            
             <div class="alert alert-success fade in m-b-10 delete-message">
                <strong>Successfully Deleted! </strong>
                <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
              </div>
          
              <div  class="pull-right col-lg-12 finchange-container" style="margin-bottom:10px">
              
              
               <form role="form"  method="post" action="" id="ScarForm" enctype="multipart/form-data">
                <div class="col-md-4 finchange-col">
                  <div class="form-group form-finchange">
                    <label for="sel1">Species</label>
                      <select class="form-control search-box" id="species" name="Species" required>
                      <option value="">Select Species</option>
                      <cfloop query="cetaceanSpeciesList">
                        <option value="#cetaceanSpeciesList.id#">  #cetaceanSpeciesList.CETACEANSPECIESNAME#</option>
                      </cfloop>
                    </select>
                    <span style="color:red; display:none;" id="errorMessage">This field is required</span>
                  </div>
                  <div class="form-group form-finchange">
                    <label for="sel1">Cetacean</label>
                    <select class="form-control get_cetacean_id search-box" required id="cetacean_list" name="CetaceanCode" required="">
                      <option value="">Select Cetaceans</option>
                      <!--- <cfloop query="cetaceanList">
                        <option value="#cetaceanList.id# #cetaceanList.Name#">  #cetaceanList.CODE#</option>
                      </cfloop> --->
                    </select>
                    <span style="color:red; display:none;" id="requiredCetaceanCode">This field is required</span>
                  </div>
                  <div>
                   
                      <div class="form-group">
                        <label for="email">Cetacean Name:</label>
                        <input type="text" class="form-control" name="CetaceanName" id="CetaceanName"  readonly="readonly" value="">
                      </div>
                      
                      <div class="form-group">
                        <label for="email">Cetacean ID:</label>
                        <input type="text" class="form-control cetacean_id " name="CetaceanId" id="CetaceanId"  readonly="readonly" value="">
                      </div>
                      <br/>
               
                       <div class="form-group"> <br />
                        <cfif permissions eq "full_access" or findNoCase("Add Entry Data S-S-C", permissions) neq 0>
                          <button type="submit" class="btn btn-success" onclick="checkValue(event)" name="insertScar" id="insertScar">Add</button>
                        </cfif>  
                        <button type="submit" id="resett" onclick="ResetAll()" class="btn btn-default">Reset</button>
                      </div>
                      
                  </div>
                  
                </div>
    
                <div class="col-md-8">
    
                        <div class="form-group form-finchange">
                         <label for="pwd">Scar Type</label> 
                          <select class="form-control search-box" name="ScarType" id="ScarType" >
                            <option value="">Select Scar</optin>
                            <cfloop query="qgetActiveScarType">
                                <option value="#qgetActiveScarType.ID#">  #qgetActiveScarType.ScarTypeName#</option>
                            </cfloop>                            
                          </select>
    
                          <label for="pwd">Body Region</label>
                          <select class="form-control search-box" name="BodyRegion" id="BodyRegion" >
                              <option value="">Select Region</optin>
                              <option value="Head">Head</optin>
                              <option value="Cranial Ventral">Cranial Ventral</optin>
                              <option value="Thorax">Thorax</optin>
                              <option value="Flipper">Flipper</optin>
                              <option value="Lateral Abdomen">Lateral Abdomen</optin>
                              <option value="Caudel Ventral">Caudel Ventral</optin>
                              <option value="Peduncle">Peduncle</optin>
                              <option value="Flukes">Flukes</optin>                              
                            </select>
                        </div>
                        <div class="form-group form-finchange">
                           <label for="pwd">Side of Body</label> 
                          <select class="form-control search-box" name="SideOfBody" id="SideOfBody" >
                            <option value="">Select Side</optin>
                            <option value="L">L</optin>
                            <option value="R">R</optin>
                            <option value="L/R">L/R</optin>
                         
                          </select>
                        </div>
                        <div class="form-group form-finchange">
                          <label for="pwd">Date:</label>
                          <div class="input-group date col-lg-7 col-md-7 col-sm-12 col-xs-12" id="datetimepicker1">
                            <input type="text" class="form-control" placeholder="mm/dd/yyyy" name="ScarDate" required id="add_date">
                            <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span> 
                           </div>
                        </div>
    
                    <div class="imag_main_dev img-dev">
                      <div class="image_class my_image">
                        <cfset setPrimaryImage  = '#Application.CloudRoot#no-image.jpg'>
                        <span id="setPrimaryImage">
                          <img src="#setPrimaryImage#"  class="image_max_width">
                        </span>
                        <div class="form-group primary-btn">
                          <label class="control-label">Select Cetacean Photo (Primary)</label>
                          <input class="input-5" name="BestImage" id="BestImage" type="file">
                        </div>
                      </div> 
    
                       
                      <div class="image_class my_image">
                        <cfset setSecondaryImage  = '#Application.CloudRoot#no-image.jpg'>
                        <span id="SecondaryImage">
                          <img src="#setPrimaryImage#" class="image_max_width">
                        </span>
                        <div class="form-group primary-btn">
                          <label class="control-label">Select Cetacean Photo (Secondary)</label>
                          <input class="input-5" name="SecondaryImage" id="SecondaryImage" type="file">
                        </div>
    
                      </div> 
                  </div>  
    
                </div>
                <input type="hidden" name="CetaceanCodeValue" id="CetaceanCodeValue">
                <input type="hidden" name="updateFormID" id="updateFormID">
              </form>         
                
               
                <h3>Permanent Scar History</h3>
                <div class="col-lg-12" style="margin-top:10px">
                  <table id="data-table" data-order='[[1,"asc"]]' class="table panel table-bordered table-hover">
                    <thead>
                      <tr class="inverse">
                        <th>Cetacean ID</th>
                        <th>Code</th>
                        <th>Date</th>
                        <th>Scar Type </th>
                        <th>Body Region</th>
                        <th>Side of Body</th>
                        <th>Image</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody id="list_dolhpin">
                      
                    </tbody>
                  </table>
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
    
    <style type="text/css">
  
  
      .img-dev {
        padding: 0px !important;
      }
    
      .finchange-col .select2-container--default {
        width: 100% !important;
      }
    
      .form-finchange .select2-container--default {
        width: 100% !important;
      }
    
      .finchange-container {
        width: 100%;
      }
    
      .imag_main_dev{
    
        display: flex;
        width: 100%;
    
      }
      .image_class{
        width: 25%;
        margin: 13px 14px 19px 0px;
    }
    .image_class span img {
        width: 100%;
        display: block;
        box-shadow: 0px 1px 3px 1px #3333334d;
        border: 1px solid #ddd;
        object-fit: cover;
    }
    .main-form-section .control-label {
        font-size: 11px;
    }
      .image_max_width{
        max-width: 100%;
      }
      .imag_main_dev {
        padding: 0 15px;
    }
    .file-preview-frame {
        margin: 8px 0;
        width: 100% !important;
        height: 223px;
        flex-wrap: wrap;
    }
    .main-form-section .form-group .file-input .btn.btn-default, .main-form-section .form-group .file-input .btn.btn-primary {
        width: 70%;
        margin: 0 auto 5px;
    }
    .file-preview-frame .kv-file-content img {
        height: 130px !important;
    }
    .file-preview-frame .file-thumbnail-footer {
        width: 100%;
    }
    .file-preview-frame .file-thumbnail-footer .file-footer-caption {
        width: 100%;
    }
    .main-form-section .form-group .file-input{
          display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }
    
    @media (max-width: 1200px) {
      .primary-btn .btn-file {
        width: 85% !important;
        font-size: 11px !important;
      }
    }
    
    @media (max-width: 991px) {
      .primary-btn .btn-file {
        width: 80% !important;
        font-size: 12px !important;
      }
    }
    
    @media (max-width: 500px) {
      .primary-btn label {
        line-height: inherit;
      }
    }
    
    @media (max-width: 450px) {
      .my_image {
        width: 37%;
      }
    }
    </style>
    
    
    
    
    