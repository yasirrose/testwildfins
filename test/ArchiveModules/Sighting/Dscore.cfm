<cfoutput>
<cfparam name="message" default="">
<cfif isdefined('FORM.insertDscore')>
 <cfset qinsertDolphin = Application.Sighting.insertDscoreDolphin(argumentCollection="#Form#")>
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
   
    <cfset getDolphinsCode = Application.Sighting.getDolphinsCode()>
    <cfset getDscoreCode = Application.Sighting.getDscoreDropdown()>
    <cfparam name="FORM.DolphinID_fetch" default="0">



  <div id="content" class="content"> 
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Home</a></li>
      <li><a href="javascript:;" class="active">Fin Change</a></li>
    </ol>
    <!-- end breadcrumb --> 
    <!-- begin page-header -->
    <!--- #Application.db# --->
    <h1 class="page-header">Fin Change 
    <cfinclude template="SightingMenu.cfm">
    </h1>

    <!-- end page-header -->
    <div class="section-container section-with-top-border p-b-10"> 
      <!-- begin row -->
      <div class="main-form-section">
      <div class="row">
          <cfif isdefined('qinsertDolphin') and qinsertDolphin.recordcount eq 1  >
            <div class="alert alert-success fade in m-b-10" id="sucess-div">
                <strong>Successfully Inserted! <cfif len(trim(message)) GT 0> </cfif> </strong>
                <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span>
            </div>
        </cfif> 
          <div  class="pull-right col-lg-12" style="margin-bottom:10px">
          
          
           <form role="form"  method="post" action="" enctype="multipart/form-data">
            <div class="col-md-4">
                <label for="sel1">Select Dolphin</label>
                <select class="form-control search-box" required id="dolphin_dscore" name="DOLPHINID" >
                  <option value="">Select Dolphin</option>
                  <cfloop query="getDolphinsCode">
                    <option value="#getDolphinsCode.id#" <cfif isdefined('FORM.DolphinID_fetch') and FORM.DolphinID_fetch eq getDolphinsCode.id>selected</cfif>>  #getDolphinsCode.code#</option>
                  </cfloop>
                </select>
              <div>
               
                  <div class="form-group">
                    <label for="email">Dolphin Name:</label>
                    <input type="text" class="form-control" name="DolphinName" id="dolphin_name"  readonly="readonly">
                  </div>
                  
                  <div class="form-group">
                    <label for="email">Dolphin ID:</label>
                    <input type="text" class="form-control" name="DolphinID_fetch" id="dolphin_id"  readonly="readonly">
                  </div>
                  <br/>
                  <!---<div class="form-group">--->
                    <!---<label for="pwd">Dscore:</label>--->
                      <!---<input type="text" class="form-control" name="DScore" id="dscore" required>--->
                  <!---</div>--->
                    <label for="pwd">Dscore:</label>
                    <br/>
                    <select class="form-control search-box" required name="DScore" id="dscore" >
                        <cfloop query="getDscoreCode">
                            <option value="#getDscoreCode.Dscore#"> #getDscoreCode.Dscore#</option>
                    	</cfloop>
                    </select>


                   <div class="form-group"> <br />
                    <button type="submit" class="btn btn-success" name="insertDscore">Add</button>
                    <button type="reset" id="reset" class="btn btn-default">Reset</button>
                  </div>
                  
              </div>
              
            </div>

            <div class="col-md-4">
              <div class="form-group">
                    <label for="pwd">Description:</label>
                    <select class="form-control" name="description" id="description" required>
                    <option value=""> Select Description</option>
                    <option value="Natural"> Natural</option>
                    <option value="HERA">HERA</option>
                    <option value="Rescue">Rescue</option>
                    </select>
                  </div>
                  
                  <div class="form-group">
                    <label for="pwd">Date:</label>
                    <div class="input-group date col-lg-7 col-md-7 col-sm-12 col-xs-12" id="datetimepicker1">
                      <input type="text" required="" class="form-control" placeholder="YYYY-MM-DD hh:mm a" name="DScoreDate" required id="add_distictdate">
                      <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span> </span> 
                     </div>
                  </div>
                  
                  <div class="form-group">
                  <label class="control-label">Select Dolphin Photo</label>
                  <input id="input-4" name="image" type="file"  class="file-loading">
                </div>
                

            </div>
                  </form>         
            <div class="col-md-4" >
            	<a href="##" id="image">
            	</a>
            </div>
           
            
            <div class="col-lg-12" style="margin-top:10px">
              <table id="data-table" data-order='[[1,"asc"]]' class="table panel table-bordered table-hover">
                <thead>
                  <tr class="inverse">
                    <th>Dolphin ID</th>
                    <th>Record ID</th>
                    <th>Code</th>
                    <th>Date</th>
                    <th>Dscore</th>
                    <th>Description</th>
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





