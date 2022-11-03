<cfoutput>
<cfif isdefined('form.DOLPHIN_ID') and form.DOLPHIN_ID neq ''>
	<cfset getBiopsy=Application.Sighting.getBiopsylist(argumentCollection="#Form#")>   
</cfif>
<cfset getDolphinsCode = Application.Sighting.getDolphinsCode()>
<div id="content" class="content">
    <!-- begin breadcrumb -->
    <ol class="breadcrumb pull-right">
      <li><a href="javascript:;">Home</a></li>
      <li><a href="javascript:;" class="active">Biopsy</a></li>
    </ol>
    <!-- end breadcrumb -->
    <!-- begin page-header -->
    <h1 class="page-header">Biopsy

    </h1>
    <!-- end page-header -->
    <div class="section-container section-with-top-border p-b-10">
      <!-- begin row -->
      <div class="main-form-section">
        <div class="row">
          <cfif isdefined('qaddBiopsy') and qaddBiopsy.recordcount eq 1  >
            <div class="alert alert-success fade in m-b-10" id="sucess-div"> <strong>Successfully Added!
              </strong> <span data-dismiss="alert" class="close"><i class="icon-remove"></i></span> </div>
          </cfif>
          <div  class="pull-right col-lg-12" style="margin-bottom:10px">
            <form role="form"  method="post" id="disp_biopsy" action="#Application.superadmin#?ArchiveModule=Sighting&Page=Biopsy" > 
              <div class="col-md-4">
              
                  <div class="form-group">
                    <label for="sel1">Select Dolphin:</label>
                    <select class="form-control search-box" required id="DOLPHIN_ID" name="DOLPHIN_ID" >
                      <option value="">Select Dolphin</option>
                      <option value="3668" <cfif isdefined('form.DOLPHIN_ID') and form.DOLPHIN_ID eq 36680>selected</cfif>>Unknown Dolphin</option>
                      <cfloop query="getDolphinsCode">
                        <option value="#getDolphinsCode.id#" 
						<cfif isdefined('form.DOLPHIN_ID') and form.DOLPHIN_ID eq getDolphinsCode.id>selected</cfif>> #getDolphinsCode.Name# | #getDolphinsCode.code#</option>
                      </cfloop>
                    </select>
                  </div>
                  
                </div>

				<div class="col-md-4 m-t-10"> <br>
  				<button type="submit" class="btn btn-success" name="addBiopsy">Submit</button>
 				</div>
                </form>   
              </div>
        
        
        
         <cfif isdefined('form.DOLPHIN_ID') and form.DOLPHIN_ID neq ''>
            <div class="col-lg-12" style="margin-top:10px">
            	<div class="form-group">
                <div style="display:none" class="alert alert-success message">
                  <strong>Success!</strong> Record Deleted.
                </div>
                </div>
                
            <cfif getBiopsy.recordcount GT 0>
			<table id="data-table" data-order='[[1,"asc"]]' class="table table-bordered table-hover panel">
                <thead>
                  <tr class="inverse">
                    <th>Dolphin </th>
                    <th>Sighting ID</th>
                    <th>Shot Number</th>
                    <th>Sample Number</th>
                    <th>Outcome</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody >
                <cfloop query="getBiopsy">
                 <tr id="remov_#Biopsy_ID#">
                 <td>#Name# | #Code# </td>
                 <td>#Sighting_ID# </td>
                 <td>#ShotNumber# </td>
                 <td>#SampleNumber#</td>
                 <td><cfif getBiopsy.Outcome EQ 1>Hit <cfelseif getBiopsy.Outcome EQ 0>Miss</cfif></td>
                 <td>
                   <div style="display:inline-block" class="col-mad-6">
                   <a href="#Application.superadmin#?ArchiveModule=Sighting&Page=EditBiopsy&Archive&Biopsy=#Biopsy_ID#" class="btn btn-xs btn-primary update"><i class="fa fa-pencil-square-o"></i></a>
             
                     </div>
                    <div style="display:inline-block" class="col-mad-6">
             		<button onclick="deleteRecord(#Biopsy_ID#)" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i>
                    </button>
                    </div>
                 </td>
                 </tr>
                 </cfloop>
                </tbody>
              </table>
              
			<cfelse>
            <div class="mypagination">No record found.</div>
            </cfif>
              
            </div>
            </cfif>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
</cfoutput> 