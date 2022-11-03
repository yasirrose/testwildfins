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
<cfoutput>
<cfparam name="form.searchword" default=" ">
<cfset cetaceanList =  Application.Cetaceans.get_CetaceanList(form.searchword) >
<cfset cetaceanSpeciesList = Application.StaticDataNew.getCetaceanSpecies()>
<cfparam name="message" default="">
<cfif isdefined('FORM.insertDscore')>
 <cfset qinsertFinFluke = Application.Sighting.insertFinFluke(argumentCollection="#Form#")>
    
 <!-------- image upload rename/extention changing .direcrtory create.image delete  --->
   
        <cftry>
   <cfif len(trim(form.image))>
      <cffile action="upload"
     fileField="image"
     destination="#Application.CloudDirectory#"

     result="image_info"
     nameconflict="overwrite">
     
     <cfset namee = "#DolphinName#(R) #DateFormat(FORM.DScoreDate,'yyyy mm dd')#.jpg">

    <!--------   Resize rename/extension changed------------->
    <cfimage
    action = "resize"
    source = "#Application.CloudDirectory##image_info.serverfile#"
    width = "100%" 
    height = "100%"
    destination = "#Application.CloudDirectory##DolphinName#(R) #DateFormat(FORM.DScoreDate,'yyyy mm dd')#.jpg" 
    name = "#namee#"
    overwrite = "yes">
          
    <cffile action = "delete" file = "#Application.CloudDirectory##image_info.serverfile#">

            
   <!---  <cfset message="image uploaded"> --->
  </cfif>

  <cfcatch>
  
  </cfcatch>
   </cftry>
</cfif>  
   

<cfset getDscoreCode = Application.Sighting.getDscoreDropdown()>
<cfset qgetDescription = Application.StaticDataNew.getActiveDescription()>

<cfparam name="FORM.DolphinID_fetch" default="">



  <div id="content" class="content"> 
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Home</a></li>
      <li><a href="javascript:;" class="active">Fin/Fluke Change</a></li>
    </ol>
    <!-- end breadcrumb --> 
    <!-- begin page-header -->
    <h1 class="page-header">Fin/Fluke Change
    <cfinclude template="SightingMenu.cfm">
    </h1>

    <!-- end page-header -->
    <div class="section-container section-with-top-border p-b-10"> 
      <!-- begin row -->
      <div class="main-form-section">
      <div class="row">
        <cfif isdefined('qinsertFinFluke') and qinsertFinFluke.recordcount eq 1  >
          <div class="alert alert-success fade in m-b-10" id="sucess-div">
              <strong>Successfully Inserted! <cfif len(trim(message)) GT 0> </cfif> </strong>
              <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
          </div>
        </cfif> 
         <div class="alert alert-success fade in m-b-10 delete-message">
              <strong>Successfully Deleted! </strong>
              <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
          </div>
         <div class="alert alert-success fade in m-b-10 update-message">
              <strong>Description Successfully Updated! </strong>
              <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
          </div>
          <div  class="pull-right col-lg-12 finchange-container" style="margin-bottom:10px">
          
          
           <form role="form"  method="post" action="" enctype="multipart/form-data">
            <div class="col-md-4 finchange-col">
                <label for="sel1">Species</label>
                <select class="form-control search-box" required id="species" name="Species" >
                  <option value="">Select Species</option>
                  <cfloop query="cetaceanSpeciesList">
                    <option value="#cetaceanSpeciesList.id#">  #cetaceanSpeciesList.CETACEANSPECIESNAME#</option>
                  </cfloop>
                </select>
                <label for="sel1">Cetacean</label>
                <select class="form-control get_cetacean_id search-box" required id="cetacean_list" name="CetaceanCode" >
                  <option value="">Select Cetaceans</option>
                  <cfloop query="cetaceanList">
                    <option value="#cetaceanList.id# #cetaceanList.Name#">  #cetaceanList.CODE#</option>
                  </cfloop>
                </select>
              <div>
               
                  <div class="form-group">
                    <label for="email">Cetacean Name:</label>
                    <input type="text" class="form-control" name="CetaceanName" id="CetaceanName"  readonly="readonly" value="">
                  </div>
                  
                  <div class="form-group">
                    <label for="email">Cetacean ID:</label>
                    <input type="text" class="form-control cetacean_id" name="CetaceanId" id="CetaceanId"  readonly="readonly" value="">
                  </div>
                  <br/>
                  <!---<div class="form-group">--->
                    <!---<label for="pwd">Dscore:</label>--->
                      <!---<input type="text" class="form-control" name="DScore" id="dscore" required>--->
                  <!---</div>--->
                    <label for="pwd">Dscore:</label>
                    <br/>
                    <select class="form-control search-box" required name="DScore" id="dscore" >
                        <option value="">Select Dscore</option>
                        <cfloop query="getDscoreCode">
                            <option value="#getDscoreCode.Dscore#"> #getDscoreCode.Dscore#</option>
                    	</cfloop>
                    </select>


                   <div class="form-group"> <br />
                    <cfif permissions eq "full_access" or findNoCase("Add Entry Data S-S-C", permissions) neq 0>
                      <button type="submit" class="btn btn-success" name="insertDscore">Add</button>
                    </cfif>  
                    <button type="reset" id="reset" class="btn btn-default">Reset</button>
                  </div>
                  
              </div>
              
            </div>

            <div class="col-md-8">

                    <div class="form-group form-finchange">
                      <label for="pwd">Description:</label>
                      <select class="form-control search-box" name="Description" id="description" required>
                        <option value="">Select Description</optin>
                        <cfloop query="qgetDescription">
                          <option value="#qgetDescription.id#">  #qgetDescription.description#</option>
                        </cfloop>
                      </select>

                      <label for="pwd">Date:</label>
                      <div class="input-group date col-lg-7 col-md-7 col-sm-12 col-xs-12" id="datetimepicker1">
                        <input type="text" required="" class="form-control" placeholder="mm/dd/yyyy" name="DScoreDate" required id="add_distictdate">
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
                  </form>         
            
           
            
            <div class="col-lg-12" style="margin-top:10px">
              <table id="data-table" data-order='[[1,"asc"]]' class="table panel table-bordered table-hover">
                <thead>
                  <tr class="inverse">
                    <th>Cetacean ID</th>
                    <th>Record ID</th>
                    <th>Code</th>
                    <th>Date</th>
                    <th>Dscore</th>
                    <th>Description</th>
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






