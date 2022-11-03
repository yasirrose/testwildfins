<cfparam name="startHereIndex" default="1">
<!--- Update user--->
<cfoutput>
<cfparam name="message" default=" ">
<cfif isdefined("form.id")>
	 <cfset getdolphin=Application.Dolphin.getsingl_Dolphin(argumentCollection="#Form#")>
<cfelse>
<cflocation url="#Application.superadmin#?Module=Dolphin&Page=ListDolphin" addtoken="no"> 
</cfif>
<cfif isdefined("form.MMHSRPsubmit")>

	 <cfset InsertMMHSRP=Application.Dolphin.InsertMMHSRP(argumentCollection="#Form#")>    
     <cfif InsertMMHSRP.RECORDCOUNT EQ 1>
	 <cfset message="<div class='alert alert-success'><strong>Success!</strong> MMHSRP Record Added.</div>">
	 </cfif>
</cfif>
<cfset getSourceSex = Application.Dolphin.getSourceSex()>
<cfset getDscoreCode = Application.Dolphin.getDscoreDropdown()>
<cfset getYOBSource=Application.Dolphin.get_YOB_Source()>
<cfset getcatalog=Application.Dolphin.getCatalog()>
<cfset getDolphinsCode = Application.Sighting.getDolphinsCode()>
<cfset getMMHSRP_Dophin = Application.Dolphin.getMMHSRP_Dophin(argumentCollection="#Form#")>

		<div id="content" class="content">
			<!-- begin breadcrumb -->
			<ol class="breadcrumb pull-right">
				<li><a href="javascript:;">Home</a></li>
				<li class="active">Edit Dolphin </li>
			</ol>
			<!-- end breadcrumb -->
			<!-- begin page-header -->
			<h1 class="page-header">Edit Dolphin 
            
            <div class="right-button-box right-button-box-holder text-right">
                <ul class="scroe-bttn">
                      <li><button class="btn  btn-primary" type="button" data-toggle="modal" data-target="##biopsyid">Biopsy</button></li>
                      <li> <form action="#Application.superadmin#?Module=Dolphin&Page=DolphinHistory" method="post">
                        <input type="hidden" value="#form.id#" name="dolphinid" /> 
                        
                        <button class="btn  btn-primary update pull-right" type="submit">View History</button>
                        </form></li>
                      <li><button class="btn  btn-primary" type="button" data-toggle="modal" data-target="##mmhsrpid">MMHSRP ID</button></li>
                     
                    </ul>
                </div>  
            </h1>
			<!-- end page-header -->
			<div class="section-container section-with-top-border p-b-10">
			<div class="row row p-t-10">
                    <!-- begin col-6 -->
                    <div>
                    <cfif len(trim(message)) GT 0 >
                    #message#
					</cfif>
                    </div>
                    
                    <div class="col-md-12">
                    
               <form role="form" id="update_dolphinto_dolhpin" enctype="multipart/form-data">	 
                <!--------- Left side------------------->
                <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
               
              	 <div class="form-group">
                  	<label for="email">Dolphin Name:</label>
                    <input type="text" class="form-control" name="Name" value="#getdolphin.Name#"  >
                 </div>
                 
                 <div class="form-group">
					<label for="email">Dolphin Code:</label>
				<input type="text" class="form-control" name="Code" value="#getdolphin.Code#"  >
				  </div>
                  
				  <div class="form-group">
					<label for="email">Sex:</label>
					<select class="form-control" name="sex" id="changesex" >
                    <option value="">Select sex</option>
                    <option value="F" <cfif getdolphin.sex eq "F"> selected</cfif> >F</option>
                    <option value="M" <cfif getdolphin.sex eq "M"> selected</cfif>>M</option>
                    </select>
				  </div>
                  
                  
                  
                  <div class="form-group" id="sourcedsex" style="display: none">
                  <label for="email">Source Sex:</label>
					<select class="form-control" name="sourcesex" >
                   <cfloop query="getSourceSex">
                       <option value="#getSourceSex.Ssex#" <cfif getSourceSex.Ssex EQ "Select Source"> selected </cfif> > #getSourceSex.Ssex#</option>
                   </cfloop>
                    </select>
                    </div>
				  <div class="form-group">
					<label for="email">Distict Date:</label>
					<input type="text" class="form-control datetimepicker" name="DistinctDate" value="#DateFormat(getdolphin.DistinctDate,"YYYY-MM-DD")#" placeholder="YYYY-MM-DD"  >
				  </div>
                 

                <!---<div class="form-group">--->
                    <!---<label for="email">Dscore:</label>--->
                <!---<select class="form-control"  name="Dscore">--->
                <!---<cfloop query="getDscoreCode">--->
                        <!---<option value="#getDscoreCode.id#">#getDscoreCode.Dscore#</option>--->
                <!---</cfloop>--->
                <!---</select>--->
                <!---</div>--->
                <div class="form-group">
                    <label for="email">Dscore:</label>
                	<select class="form-control"  name="Dscore">
                        <!---<option value="#getdolphin.DScore#" selected>#getdolphin.DScore#</option>--->
                        <cfloop query="getDscoreCode">
                        <option value="#getDscoreCode.id#" <cfif getdolphin.DScore eq getDscoreCode.DScore>selected</cfif>>#getDscoreCode.Dscore#</option>
                        </cfloop>
                    </select>
                   </div>
                  <div class="form-group">
					<label for="email">Date of Death:</label>
					<input type="text" class="form-control datetimepicker" name="Date_of_Death" value="#DateFormat(getdolphin.DateofDeath,"YYYY-MM-DD")#" placeholder="YYYY-MM-DD"  >
                  </div>
                  
                  <div class="form-group">
					<label for="email">Year Of Birth:</label>
					<input type="text" class="form-control" name="YearOfBirth" placeholder="year" value="#getdolphin.YearOfBirth#"  >
                  </div>
              <div class="form-group">
            <label for="email">Source YOB:</label>
                <div class="input-group">
                  <div class="input-group-btn">
                    <button class="btn btn-inverse" type="button">Source YOB</button>
                    <button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false"> <span class="caret"></span> </button>
                    <ul class="dropdown-menu">
                   
                      <cfloop query="getYOBSource">
                        <li><a  class="Source_YOB" value="#getYOBSource.ID#">#getYOBSource.YOBSource#</a></li>
                      </cfloop>
                    </ul>
                  </div>
                  <input type="text" id="Source_YOB" class="form-control" value="#getdolphin.YOBSource#"  name="Source_YOB" >
                  <input type="hidden" id="Source_YOB_ID" class="form-control"  name="Source_YOB_ID" value="#getdolphin.SourceYOB#" >
                </div>
              </div>
           
             <!-------left end------->
            <div class="form-group">
					<label for="pwd">Best Image:</label>
                    
          			 
                     <!--- <cfoutput>#dayy#</cfoutput>--->
    <cfset  Fin  = '#Application.CloudRoot#no-image.jpg'>
	<cfset Fin_Left = "#getdolphin.ImageName#">
    <cfset Fin_Right = "#getdolphin.ImageName#">
    
    
	<cfif FileExists('#Application.CloudDirectory##Fin_Left#')>
		<cfset  Fin = '#Application.CloudRoot##Fin_Left#'>
      
	<cfelseif FileExists('#Application.CloudDirectory##Fin_Right#')>
    	<cfset  Fin  = '#Application.CloudRoot##Fin_Right#'>
    </cfif>
    <img src="#Fin#" id="alt_img" alt="" width="80" height="60">
    
    
                     
                     
                     </div>
                     
                     
                     
                     <div class="form-group">
                          <label for="image">Select Dolphin Photo</label>
                          <img src="" id="alt_img" alt="" width="50" >
                          <input class="input-5" name="BestImage"  type="file" class="file-loading">
                      </div>
               
                 
               </div>
             <!------  Middle side---------------->  
            <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                 	
                    <div class="form-group">
					<label for="email">Mothers:</label>
					<input type="text" class="form-control" name="Mothers" value="#getdolphin.Mothers#"   >
            	</div>
                
                <div class="form-group">
					<label for="email">Grandmother:</label>
					<input type="text" class="form-control" name="Grandmother" maxlength="6" value="#getdolphin.Grandmother#"   >
                    </div>
            	
				<div class="form-group">
					<label for="email">Great Grandmother:</label>
					<input type="text" class="form-control" name="GreatGrandmother" value="#getdolphin.GreatGrandmother#"  >
				</div>
				  
                
                <div class="form-group">
					<label for="email">Date of Birth EST:</label>
               <input type="text" class="form-control" id="datetimepickerEST" name="Date_of_Birth_EST" <cfif getdolphin.DateofBirthEST eq 'CNBD'> value="" <cfelse> value="#DateFormat(getdolphin.DateofBirthEST,"mm/yyyy")#" </cfif> >
            	</div>
                
                <div class="form-group">
					<label for="email">Dispersal Date:</label>
					<input type="text" class="form-control datetimepicker" name="Dispersal_Date" value="#DateFormat(getdolphin.DispersalDate,"YYYY-MM-DD")#"   >
            	</div>
               
                    <div class="form-group">
                   <label for="email">Catalog:</label>
                    <select name="Catalog" class="form-control" >
                    <option value="">Select Catalog</option>
                    <cfloop query="getCatalog">
                    <option value="#getCatalog.Catalog#" 
					<cfif getdolphin.Catalog EQ getCatalog.Catalog > selected </cfif>>#getCatalog.Catalog#</option>
                    </cfloop>
                    </select>
                    </div>
                    
                    <div class="form-group">
                    <label for="email">Biopsy No:</label>
                            <input type="text" class="form-control" name="Biopsy_No" value="#getdolphin.BiopsyNo#"   >
                    </div>
                    
                    <div class="form-group">
                            <label for="email">First Sighting Date:</label>
                            <input type="text" class="form-control datetimepicker" name="First_Sighting_Date" value="#DATEFORMAT(getdolphin.FirstSightingDate,"YYYY-MM-DD")#" placeholder="YYYY-MM-DD"  >
                     </div>
                     
                         
                 </div>
                 
                 
                 <!-------- Right Side----------------->
             <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
            
            
             <div class="form-group">
			<label for="email">CFS ID:</label>
			<input type="text" class="form-control " name="CFSID" value="#getdolphin.CFSID#"  >
            </div>
            
            <div class="form-group">
			<label for="email">Hubbs ID:</label>
			<input type="text" class="form-control " name="HubbsID" value="#getdolphin.HubbsID#"  >
            </div>
            
            <div class="form-group">
			<label for="email">MJ ID:</label>
			<input type="text" class="form-control " name="MJID" value="#getdolphin.MJID#"  >
            </div>
            
            <div class="form-group">
			<label for="email">JU ID:</label>
			<input type="text" class="form-control " name="JUID" value="#getdolphin.JUID#"  >
            </div>
            
            <div class="form-group">
			<label for="email">FIT ID:</label>
			<input type="text" class="form-control" name="FITID" value="#getdolphin.FITID#"  >
            </div>
            
            <div class="form-group">
            <label for="email">UNF ID:</label>
            <input type="text" class="form-control" name="UNFID" value="#getdolphin.UNFID#" >
            </div>
            
            <div class="form-group">
            <label for="email">SAET ID:</label>
            <input type="text" class="form-control" name="SAETID" value="#getdolphin.SAETID#" >
            </div>
                
        <!---    <div class="form-group">
                 <label for="email">Verified</label>
                 
                 <select class="form-control" name="Verify" >
                 <option value="">Select</option>
                 <option value="1" <cfif getdolphin.Verify EQ 1 > selected </cfif> >Verified</option>
                 <option value="2" <cfif getdolphin.Verify EQ 2 > selected </cfif> >Unable To Verify</option>
                 <option value="3" <cfif getdolphin.Verify EQ 3 > selected </cfif> >Never Sighted</option>
                 </select>
                 
                </div>--->
           
           
           
            <!-------- newdolhpin right side end------>
            </div>
            <div class="col-md-12"> 
                 <div class="message">
				 </div>
                <div class="form-group">
                      <input type="hidden"  name="ID"  value="#form.id#">
                    <button type="submit" class="btn btn-success" id="submit" name="addnew_dolphin" >Update Dolphin</button>
 				</div>
                 </div>
                 </form>
                </div>
                <!-- end row -->
		</div>
 <cfinclude template="Biopsy.cfm">
<!-- Modal -->
<div id="mmhsrpid" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">MMHSRP </h4>
      </div>
      <div class="modal-body">
      <div class="row  p-10">
      <button type="button" class="btn  btn-primary  pull-right" id="viewbtn">View MMHSRP</button>
      <button type="button" class="btn  btn-primary  pull-right  m-r-2" id="addbtn">Add MMHSRP</button>
      
      </div>
       
       <div class="row listMMHSRP_disp" style="display:none">
      	 <div class="alert alert-success" id="succesmessage" style="display:none">
	  		<strong>Success!</strong> Record Deleted.
		</div>

       
       <table class="table table-bordered table-hover" data-order="[[1,&quot;asc&quot;]]" id="example">
                        <thead>
                            <tr class="inverse">
                                <th>Sr##</th>
                                <th>ID</th>
                                <th>Date</th>
                                <th>Description</th>
                                <th>Action</th>
                                </tr>
                                </thead>
                      		<tbody>
                            <cfloop query="getMMHSRP_Dophin">
                         	<tr id="remov_#ID#" class="inverse">
                                <td>#getMMHSRP_Dophin.currentrow#</td>
                                <td>#getMMHSRP_Dophin.MMHSRP_ID#</td>
								<td>#DateFormat(getMMHSRP_Dophin.Date,"YYYY-MM-DD")#</td>
                                <td>#getMMHSRP_Dophin.Description#</td>
                               
                                <td>
                                <button onclick="deleteRecord(#ID#)" class="btn btn-xs btn-primary"><i class="glyphicon glyphicon-trash"></i></button>	
                                </td>
                            </tr>
                            </cfloop>
                            </tbody>
                            </table>
       
       </div>
       
       <div class="row addMMHSRP_disp">
            <form class="form-horizontal" method="post" role="form" id="MMHSRPform">
            
              <div class="form-group">
                <label class="control-label col-sm-2" for="email">MMHSRP ID:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" name="MMHSRP_ID"  required placeholder="Enter ID">
                </div>
              </div>
              
              <div class="form-group">
                <label class="control-label col-sm-2" for="pwd">Date:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control datetimepicker"  name="Date_MMHSRP" required placeholder="Enter Date">
                </div>
              </div>
              
              <div class="form-group">
                <label class="control-label col-sm-2" for="pwd">Description:</label>
                <div class="col-sm-10">
                  <select class="form-control" name="Description" required>
                  <option value="">Select Description</option>
                  <cfloop  from="1" to="54" index="i">
                  <option value="#i#">#i#</option>
                  </cfloop>
                  </select>
                </div>
              </div>
              <input type="hidden" name="id" value="#form.id#" required />
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="submit" name="MMHSRPsubmit" class="btn btn-success">Submit</button>
                </div>
              </div>
            </form>
            </div>
            
            
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

</cfoutput>  