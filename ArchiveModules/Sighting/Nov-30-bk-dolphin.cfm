<cfoutput>
<cfif isdefined('form.PROJECT_ID') and form.project_id gt 0 and form.sight_id GT 0>
 <!-------------  Dolphine ---------------------------------->
<cfparam name="form.PROJECT_ID" default="0">
<cfquery name="dolphine" datasource="#Application.dsn#" result ='get_dolphine_result'>
	select code,id,Name from DOLPHINS order by id ASC
</cfquery>

<cfparam name="qGetSightings.id" default="0">

<!---<cfquery name="project_sightins" datasource="#Application.dsn#">
	SELECT ID FROM SIGHTINGS WHERE Project_ID = #form.PROJECT_ID#
</cfquery>--->
<!---GET ALL SIGHTINGS_DOLPHINS OF PROJECT--->
<cfquery name="dolphine_sight" datasource="#Application.dsn#" result ='get_dolphine_result'>
    SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID IN (SELECT ID FROM SIGHTINGS WHERE Project_ID = #form.PROJECT_ID#) order by DOLPHIN_SIGHTINGS.Sighting_ID;
</cfquery>

<cfquery name="singleSightingDolphins" datasource="#Application.dsn#" result ='get_dolphine_result'>
    SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID=#qGetSightings.id# order by DOLPHIN_SIGHTINGS.Sighting_ID;
</cfquery>

<cfquery name="TLU_SDO" datasource="#Application.dsn#" result ='get_sdo'>
	SELECT * FROM TLU_SDO
</cfquery>

<cfquery name="getYOBSource" datasource="#Application.dsn#" result ='get_YOB_Source'>
	SELECT * FROM TLU_YOB_Source
</cfquery>
<cfset getcatalog=Application.Dolphin.getCatalog()>

<div id="dolphin" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" id="dolphin_modal_close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Dolphin</h4>
      </div>

	  <div class="col-md-12 panel-heading pull-right" id="dscore_assign">
      <a class="btn btn-success pull-right" >Add New</a>
      <a class="btn btn-primary pull-right m-r-5" id="mybiopsy"> Add Biopsy</a>
      <a class="btn btn-primary pull-right m-r-5" href="#Application.superadmin#?Module=Sighting&Page=Biopsy" target="_blank" id="Viewbiopsy">View Biopsy</a>
      </div>
      
      <div class="col-md-12 panel-heading" id="goback-block" style="display:none">
      <a class="btn btn-primary pull-right" id="goback" style="display:none">Go Back</a> 
      <a class="btn btn-primary pull-right" id="dolhphinadd" style="display:none;margin-right: 5px">Add Dolphin</a> 
      <a class="btn btn-primary pull-right" id="dolhphinassign" style="display:none;margin-right: 5px">Assign Dolphin</a> 
      </div>
     
	 <div class="modal-body" style="overflow:hidden">
      
      <div class="col-md-12 add_new_dolphin_form" style="display:none">
       <h2>Add New  Dolphin</h2>
	  
      <div class="panel-body">
      
      
               <form role="form" id="add_dolphinto_dolhpin">	 
				  <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                  <div class="form-group">
					<label for="email">Dolphin Name:</label>
				 <input type="text" class="form-control" name="Name" required >
				  </div>
                 <div class="form-group">
					<label for="email">Dolphin Code:</label>
				<input type="text" class="form-control" name="Code" required >
				  </div>

                 
				  <div class="form-group">
					<label for="email">Sex:</label>
					<select class="form-control" name="sex" required>
                    <option value="">Select sex</option>
                    <option value="F">F</option>
                    <option value="M">M</option>
                    </select>
				  </div>
                  
				  <div class="form-group">
					<label for="email">Distict Date:</label>
					<input type="text" class="form-control datetimepicker" name="DistinctDate" placeholder="MM/DD/YYYY" required >
				  </div>

               	  <div class="form-group">
					<label for="email">Dscore:</label>
					<input type="text" class="form-control" name="Dscore" maxlength="2" required >
				  </div>
                  
                  <div class="form-group">
					<label for="email">Date of Death:</label>
					<input type="text" class="form-control datetimepicker" name="Date_of_Death" placeholder="MM/DD/YYYY" required >
                  </div>
                  
                  <div class="form-group">
					<label for="email">Year Of Birth:</label>
					<input type="text" class="form-control" name="YearOfBirth" placeholder="year" required >
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
                  <input type="text" id="Source_YOB" class="form-control"  name="Source_YOB" required>
                  <input type="hidden" id="Source_YOB_ID" class="form-control"  name="Source_YOB_ID" required>
                </div>
              </div>
               
             <div class="message">
				 </div>
                <div class="form-group">
					<button type="submit" class="btn btn-success" name="addnew_dolphin" >Add Dolphin</button> 
                    <input type="reset" class="btn btn-defualt reset" />
 				</div>
                           
                      
                          <!-------left end------->
                 </div>
                 
              <div class="col-md-4" style="border-right: solid 0.5px ##EEEEEE">
                  <!-------Middel strt------->
                
                <div class="form-group">
					<label for="email">Mothers:</label>
					<input type="text" class="form-control" name="Mothers"  required >
            	</div>
                
                <div class="form-group">
					<label for="email">Grandmother:</label>
					<input type="text" class="form-control" name="Grandmother" maxlength="6"  required >
            	</div>
            	
                <div class="form-group">
					<label for="email">Great Grandmother:</label>
					<input type="text" class="form-control" name="GreatGrandmother" required>
				  </div>
                  
                <div class="form-group">
					<label for="email">Date of Birth EST:</label>
					<input type="text" class="form-control" id="datetimepickerEST" name="Date_of_Birth_EST"  required >
            	</div>
                
                <div class="form-group">
					<label for="email">Dispersal Date:</label>
					<input type="text" class="form-control datetimepicker" name="Dispersal_Date"  required >
            	</div>
                
                
                <div class="form-group">
                <label for="email">Catalog:</label>
                <select name="Catalog" class="form-control" required>
                <option value="">Select Catalog</option>
                <cfloop query="getCatalog">
                <option value="#getCatalog.Catalog#">#getCatalog.Catalog#</option>
				</cfloop>
                </select>
                </div>
                
                <div class="form-group">
                <label for="email">Biopsy No:</label>
                        <input type="text" class="form-control" name="Biopsy_No"  required >
                </div>
                

                
                <div class="form-group">
                        <label for="email">First Sighting Date:</label>
                        <input type="text" class="form-control datetimepicker" name="First_Sighting_Date" placeholder="MM/DD/YYYY" required >
                 </div>
                 
              	<!-------- middl end----------------->
                 
                 </div>
                 
                 
                 <!-------- Right Side----------------->
               <div class="col-md-4">
                  
                 <div class="form-group">
                <label for="email">CFS ID:</label>
                <input type="text" class="form-control " name="CFSID" required >
                </div>
                
                <div class="form-group">
                <label for="email">Hubbs ID:</label>
                <input type="text" class="form-control " name="HubbsID" required >
                </div>
                
                <div class="form-group">
                <label for="email">MJ ID:</label>
                <input type="text" class="form-control " name="MJID" required >
                </div>
                
                <div class="form-group">
                <label for="email">JU ID:</label>
                <input type="text" class="form-control " name="JUID" required >
                </div>
                
                <div class="form-group">
                <label for="email">FIT ID:</label>
                <input type="text" class="form-control" name="FITID" required >
                </div>
                    
   
                 <div class="form-group">
                 
                     <label for="email">Verified</label>
                     
                     <select class="form-control" name="Verify" required>
                     <option value="">Select</option>
                     <option value="1">Verified</option>
                     <option value="2">Unable To Verify</option>
                     <option value="3">Never Sighted</option>
                     </select>
                     
                    </div>
                
              
            <!-------- newdolhpin right side end------>
            </div>
                 
                 
            <div class="col-md-12"> 
               
                
                 </div>
                  
                 </form>
               
                
      </div>
      </div>
      
      
	   <div class="col-md-12 add_new" style="display:none">
	   <h2>Assign Dolphin to Sighting</h2>
	   
		<div class="panel-body ">
        <form role="form" id="add_dolphin_form">	 
				 
                 <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                 
				 <div class="form-group selectwidth">
					<label for="email">Dolphin Name/Code:</label>
					
					<select class="form-control" required id="dolphin_code" name="Dolphin_ID">
					<option value="">Select Code</option>
					<cfloop query="dolphine">
					<option value="#dolphine.id#"> #dolphine.Name# | #dolphine.code# </option>                  
	               	 </cfloop>
					</select>
 
                      </div>

                 
				  <div class="form-group">
					<input type="hidden" name="Sighting_ID" id="getsight_ID" value="#qGetSightings.id#">
				  
                    <label for="pwd">Sex:</label>
					<input type="text" class="form-control" id="add_sex" readonly >
				  </div>
				
				  <div class="form-group">
					<label for="pwd">Lineage:</label>
					<input type="text" class="form-control" id="add_Lineage" readonly>
				  </div>
				  
				  <div class="form-group">
					<label for="pwd">Distict Date:</label>
					<input type="text" class="form-control" id="add_distictdate" readonly>
				  </div>
				  	 
				   <div class="form-group">
					<label for="pwd">Distict:</label>
					<input type="checkbox" class="checkbox-inline" id="add_distict"  value="1" disabled  readonly>
				  </div>

				 <div class="form-group">
					<label for="pwd">Dscore:</label>
					<input type="text" class="form-control" id="add_dscore" readonly>
				  </div>
         		 <div class="form-group">
					<label for="pwd">FB_No:</label>
					<input type="text" class="form-control" id="add_FB_No" readonly>
				 </div>
                 
				  <div class="form-group">
					<label for="pwd">Note:</label>
					<textarea class="form-control" name="Note"></textarea>
				  </div>
		
				 
				  <div class="form-group">
					<label for="pwd">Echelon:</label>
					<input type="text"   class="form-control" name="Echelon" maxlength="5">
				  </div>
				   
                 <div class="form-group">
					<label for="pwd">REMPI:</label>
					<input type="text" class="form-control" name="REMPI" maxlength="5">
				</div>
                
                <div class="form-group">
					<label for="pwd">Body Condition:</label>
					<input type="text" class="form-control" name="BodyCondition">
				  </div>
                  
               <div class="form-group">
					<label for="pwd">Best Image:</label>
					<input type="text" class="form-control" name="BestImage">
				  </div>
                  
                
                <div class="form-group">
				  <div class="message"></div>
				 <button type="submit" class="btn btn-success">Submit</button>
                 <button type="reset" class="btn btn-default reset">Reset</button>
                </div> 
                
                 </div>
                 
                 <!--------- Right Side-------------->
                 <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                 
				<div class="form-group">
						<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-inverse" type="button">Verified</button>
							<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a val="P" class="get_val" id="add_varified_1">P</a></li>
								<li><a val="V" class="get_val" id="add_varified_2">V</a></li>
								</ul>
						</div>
						<input type="text" id="add_varified" class="form-control" value="p" maxlength="7"  name="Verified">
					 </div>
					</div>
						
		
				<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">PQ F:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a val="2" class="get_val sum_calculate" id="add_pqf_1">2</a></li>
							<li><a val="4" class="get_val sum_calculate" id="add_pqf_2">4</a></li>
							<li><a val="6" class="get_val sum_calculate" id="add_pqf_3">6</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate" id="add_pqf" name="pq_focus" value="0">
				 </div>
				</div>
				
				<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">PQ A:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a val="1" class="get_val sum_calculate" id="add_pqa_1">1</a></li>
							<li><a val="2" class="get_val sum_calculate" id="add_pqa_2">2</a></li>
							<li><a val="8" class="get_val sum_calculate" id="add_pqa_3">8</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate" name="pq_Angle" id="add_pqa" value="0">
				 </div>
				</div>
				
				
				<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">PQ C:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a val="1" class="get_val sum_calculate" id="add_pqc_1">1</a></li>
							<li><a val="3" class="get_val sum_calculate" id="add_pqc_2">3</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate" name="pq_Contrast" id="add_pqc" value="0">
				 </div>
				</div>
				
				<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">Pq Pro:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a val="1" class="get_val sum_calculate" id="add_pqpro_1">1</a></li>
							<li><a val="5" class="get_val sum_calculate" id="add_pqpro_2">5</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate" name="pq_Proportion" id="add_pqpro" value="0">
				 </div>
				</div>
				
			<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">Pq Par:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a val="1" class="get_val sum_calculate" id="add_pqpar_1">1</a></li>
							<li><a val="8" class="get_val sum_calculate" id="add_pqpar_1">8</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate" name="pq_Partial" id="add_pqpar" value="0">
				 </div>
				</div>
				
				<div class="form-group">
					<label for="pwd">Pq sum:</label>
					<input type="number" class="form-control" id="add_pqsum" value="0" name="pqSum"  readonly>
				  </div>
				
				<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">SDO1:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
						<cfset t=0>
						<cfloop query="TLU_SDO">
						<cfset t=t+1>
							<li><a val="#TLU_SDO.SDO_ID#" class="getvals" id="add_SDO1_#t#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a></li>
						</cfloop>
						</ul>
					</div>
					<input type="text" class="form-control" id="add_SDO1" value="0" readonly>
					<input type="hidden" class="form-control" id="add_SDO1_ID" name="SDO1" value="0" readonly>
				 </div>
				</div>
            	

                 <div class="form-group">
					<label for="pwd">Qscore:</label>
					<input type="text" class="form-control" name="Qscore" id="add_qscoresum">
				  </div>
                  
                  
				  <div class="form-group">
					<label for="pwd">PQP:</label>
					<input type="checkbox" class="checkbox-inline" name="PQP" value="1">
				  </div>
				  
				  <div class="form-group">
					<label for="pwd">SDR:</label>
					<input type="checkbox" class="checkbox-inline" name="SDR" value="1"> 
				  </div>
				  
				  <div class="form-group">
					<label for="pwd">Fetals:</label>
					<input type="checkbox" class="checkbox-inline" name="Fetals" value="1">
				  </div>
				  
				   <div class="form-group">
					<label for="pwd">BC:</label>
					<input type="checkbox" class="checkbox-inline" name="BC"  value="1">
				  </div>
				  
				  
				  <div class="form-group">
					<label for="pwd">Xeno:</label>
					<input type="checkbox" name="Xeno" value="1">
				  </div>
				
				<div class="form-group">
					<label for="pwd">RDS:</label>
					<input type="checkbox" class="checkbox-inline" name="RDS" value="1">
				  </div>
				  
				  <div class="form-group">
					<label for="pwd">REM:</label>
					<input type="checkbox" class="checkbox-inline" name="REM"  value="1">
				  </div>
				 
                <div class="form-group">
					<label for="pwd">Fresh wound:</label>
					<input type="checkbox" class="checkbox-inline" name="Freshwound"  value="1">
				  </div>
				 </div>
                 
                 
                 
                 
                 <div class="col-md-12">
                
				 </div>
            </form>
	</div>
	   </div>
	  
	  
	  
	  
	  <div class="col-md-12 display_data">
      <!------------------------------------->
      <cfparam name='d1total' default="0">
      <cfparam name='d2total' default="0">
      <cfparam name='d3total' default="0">
      <cfparam name='d4total' default="0">
      <cfparam name='d5total' default="0">
      <cfparam name='d6total' default="0">
      <cfparam name='total' default="0">
      
      <cfloop query="singleSightingDolphins">
      	 <cfquery name="dscore" datasource="#Application.dsn#">
                    select top 1 DScore from Dolphin_DScore where DolphinID=#singleSightingDolphins.Dolphin_ID# order by ID DESC
          </cfquery>
          
          <cfif dscore.DScore EQ 'D1'>
		  <cfset d1total=d1total+1>
          
          <cfelseif dscore.DScore EQ 'D2'>
           <cfset d2total=d2total+1>
          
		  <cfelseif dscore.DScore EQ 'D3'>
           <cfset d3total=d3total+1>
          
		  <cfelseif dscore.DScore EQ 'D4'>
           <cfset d4total=d4total+1>
          
		  <cfelseif dscore.DScore EQ 'D5'>
           <cfset d5total=d5total+1>
          
		  <cfelseif dscore.DScore EQ 'D6'>
           <cfset d6total=d6total+1>
      	</cfif>
                          
 	   </cfloop>
 	 <cfset total=d1total+d2total+d3total+d4total+d5total+d6total>
      
	  	<h2>List of Dolphins</h2>
		<div class="right-box-dolphin p-10 m-b-20 col-lg-12">
          <div class="row"><div class="pull-right col-lg-2 m-b-10 p-0 m-r-10">
            	<label>D Total</label>
                <input type="text" value="#total#" class="form-control d-total">
            </div></div>
           <div class="row">
            <div class="col-lg-2">
            	<label>D1</label>
                <input type="text" value="#d1total#" class="form-control" />
            </div>
            <div class="col-lg-2">
            	<label>D2</label>
                <input type="text" value="#d2total#" class="form-control" />
            </div>
            <div class="col-lg-2">
            	<label>D3</label>
                <input type="text" class="form-control" value="#d3total#" />
            </div>
            <div class="col-lg-2">
            	<label>D4</label>
                <input type="text" class="form-control" value="#d4total#" />
            </div>
            <div class="col-lg-2">
            	<label>D5</label>
                <input type="text" class="form-control" value="#d5total#" />
            </div>
            <div class="col-lg-2">
            	<label>D6</label>
                <input type="text" class="form-control" value="#d6total#" />
            </div>
           </div>
           </div>
		<div class="row panel-heading" style="background:##011A35;overflow:hidden;color:##fff">
		<div class="col-md-2">Dophin Name</div>
		<div class="col-md-2">Dscore</div>
		<div class="col-md-2">DScore date</div>
        <div class="col-md-2">Sighting ID</div>
		<div class="col-md-2">Actions</div>
		
        </div>
		<cfset i=0>
		<cfloop query="dolphine_sight">
		<cfset i=i+1>
		<div class="row" id="dolphindetail_#i#">
        
		<!----------
				 ---
				 --- Find Dscore
				 ---
				 ------------>
				<cfquery name="dscore" datasource="#Application.dsn#">
				select top 1 * from Dolphin_DScore where DolphinID=#dolphine_sight.Dolphin_ID# order by ID DESC
				</cfquery>
		<div class="col-md-12 panel-heading p-10 m-b-5" style="background:##ccc;">
		<div class="col-md-2">#dolphine_sight.Name#</div>
		<div class="col-md-2">#dscore.DScore#</div>
		<div class="col-md-2">#DateFormat(dscore.DScoreDate, 'MM/DD/YYYY')#</div> 
        <div class="col-md-2">#dolphine_sight.Sighting_ID#</div> 
		<div class="col-md-2">
        <button  href="##collapse#i#" class="btn btn-xs btn-primary" data-toggle="collapse" >
        <i class="fa fa-pencil-square-o"></i></button>
       
        <button type="button" id="delete_#i#" class="btn btn-xs btn-primary delete_dolphin" 
        Sighting_ID="#dolphine_sight.Sighting_ID#" Dolphin_ID="#dolphine_sight.Dolphin_ID#">
        <i class="glyphicon glyphicon-trash"></i></button>
        </div> 
		
        </div>
		
		<div id="collapse#i#" class="col-md-12 panel-collapse collapse" style="border: solid 2px ##ccc;">
			<div class="panel-body">
				
                <form role="form" id="update_dolhpin_#i#">	 
                
                                 <!--------- Left Side-------------->
                 <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                 
				 <div class="form-group selectwidth">
					<label for="email">Dolphin Name/Code:</label>
					<select class="form-control " required id="dolphin_up_code" readonly name="Dolphin_ID">
					<option value="#dolphine_sight.Dolphin_ID#" > <cfloop query="dolphine"><cfif dolphine_sight.Dolphin_ID eq dolphine.id > #dolphine.Name# | #dolphine.code# </cfif></cfloop></option>
					</select>
                    
					</div>
				 
				  <div class="form-group">
					<label for="pwd">Sex:</label>
					<input type="text" class="form-control"  value="#dolphine_sight.Sex#" id="update_sex" readonly >
				  </div>
				
				  <div class="form-group">
					<label for="pwd">Lineage:</label>
					<input type="text" class="form-control" id="update_Lineage" readonly  value="#dolphine_sight.Lineage#">
				  </div>
				  
				  <div class="form-group">
					<label for="pwd">Distict Date:</label>
					<input type="text" class="form-control" id="update_distictdate" readonly value="#DateTimeFormat(dolphine_sight.DistinctDate, 'MM/DD/YYYY')#">
					
				  </div>
				  	 
				   <div class="form-group">
					<label for="pwd">Distict:</label>
					<input type="checkbox" class="checkbox-inline"  
					<cfif dolphine_sight.Distinct eq 1>checked</cfif> id="update_distict"  value="1" disabled  readonly>
				  </div>

			
				 <div class="form-group">
					<label for="pwd">Dscore:</label>
					<input type="text" class="form-control" id="update_dscore" readonly value="#dscore.DScore#">
				  </div>
		  		
				<div class="form-group">
					<label for="pwd">FB_No:</label>
					<input type="text" class="form-control" value="#dolphine_sight.FB_No#" id="add_FB_No" readonly>
				  </div>
               
               <div class="form-group">
					<label for="pwd">Note:</label>
					<textarea class="form-control" name="Note">#dolphine_sight.Note#</textarea>
				</div>
			
            
                    
                 <div class="form-group">
					<label for="pwd">Echelon:</label>
					<input type="text"   class="form-control" name="Echelon" maxlength="5" value="#dolphine_sight.Echelon#">
				  </div>
                  
				<div class="form-group">
					<label for="pwd">REMPI:</label>
					<input type="text" class="form-control" value="#dolphine_sight.REMPI#" name="REMPI" maxlength="5">
				  </div>
                 
                   <div class="form-group">
					<label for="pwd">Body Condition:</label>
					<input type="text" class="form-control" value="#dolphine_sight.BodyCondition#" name="BodyCondition">
				  </div>
                  
               <div class="form-group">
					<label for="pwd">Best Image:</label>
					<input type="text" class="form-control" value="#dolphine_sight.BestImage#" name="BestImage">
				  </div>
                  
                  
                 <div class="message"></div>
                 
                  <div class="form-group">
                  <button type="submit" class="btn btn-success update_dolphin" data_id="update_dolhpin_#i#">Update</button>
                 </div>
                 
                 </div>
                 
                                  <!--------- Right Side-------------->
                 <div class="col-md-6" style="border: solid 0.5px ##EEEEEE">
                 <div class="form-group">
						<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-inverse" type="button">Verified</button>
							<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a val="P" class="get_val" id="update_varified#i#_1">P</a></li>
								<li><a val="V" class="get_val" id="update_varified#i#_2">V</a></li>
								</ul>
						</div>
						<input type="text" id="update_varified#i#" class="form-control" value="#dolphine_sight.Verified#" maxlength="7"  name="Verified">
					 </div>
					</div>
					
				  
					<div class="form-group">
						<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-inverse" type="button">PQ F:</button>
							<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a val="2" class="get_val sum_calculate_update" id="update_pqf#i#_1" index="#i#">2</a></li>
								<li><a val="4" class="get_val sum_calculate_update" id="update_pqf#i#_2" index="#i#">4</a></li>
								<li><a val="6" class="get_val sum_calculate_update" id="update_pqf#i#_3" index="#i#">6</a></li>
								</ul>
						</div>
						<input type="number" class="form-control sum_calculate_update" index="#i#" id="update_pqf#i#" name="pq_focus" value="<cfif len(trim(dolphine_sight.pq_focus)) EQ 0>0<cfelse>#dolphine_sight.pq_focus#</cfif>">
					 </div>
					</div>
					
					<div class="form-group">
						<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-inverse" type="button">PQ A:</button>
							<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a val="1" class="get_val sum_calculate_update" id="update_pqa#i#_1" index="#i#">1</a></li>
								<li><a val="2" class="get_val sum_calculate_update" id="update_pqa#i#_2" index="#i#">2</a></li>
								<li><a val="8" class="get_val sum_calculate_update" id="update_pqa#i#_3" index="#i#">8</a></li>
							</ul>
						</div>
						<input type="number" class="form-control sum_calculate_update" index="#i#" name="pq_Angle" id="update_pqa#i#" value="<cfif len(trim(dolphine_sight.pq_Angle)) EQ 0>0<cfelse>#dolphine_sight.pq_Angle#</cfif>">
					 </div>
					</div>
					
					<div class="form-group">
						<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-inverse" type="button">PQ C:</button>
							<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a val="1" class="get_val sum_calculate_update" id="update_pqc#i#_1" index="#i#">1</a></li>
								<li><a val="3" class="get_val sum_calculate_update" id="update_pqc#i#_2" index="#i#">3</a></li>
								</ul>
						</div>
						<input type="number" class="form-control sum_calculate_update" index="#i#" name="pq_Contrast" id="update_pqc#i#" value="<cfif len(trim(dolphine_sight.pq_Contrast)) EQ 0>0<cfelse>#dolphine_sight.pq_Contrast#</cfif>">
					 </div>
					</div>
				  
					<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">Pq Pro:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a val="1" class="get_val sum_calculate_update" id="update_pqpro#i#_1" index="#i#">1</a></li>
							<li><a val="5" class="get_val sum_calculate_update" id="update_pqpro#i#_2" index="#i#">5</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate_update" index="#i#" name="pq_Proportion" id="update_pqpro#i#" value="<cfif len(trim(dolphine_sight.pq_Proportion)) EQ 0>0<cfelse>#dolphine_sight.pq_Proportion#</cfif>">
				 </div>
				</div>
			
				<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">Pq Par:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a val="1" class="get_val sum_calculate_update" id="update_pqpar#i#_1" index="#i#">1</a></li>
							<li><a val="8" class="get_val sum_calculate_update" id="update_pqpar#i#_1" index="#i#">8</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate_update" index="#i#" name="pq_Partial" id="update_pqpar#i#" value="<cfif len(trim(dolphine_sight.pq_Partial)) EQ 0>0<cfelse>#dolphine_sight.pq_Partial#</cfif>">
				 </div>
				</div>
				
				<div class="form-group">
					<label for="pwd">Pq sum:</label>
					<input type="number" class="form-control" id="update_pqsum_#i#" value="<cfif len(trim(dolphine_sight.pqSum)) EQ 0>0<cfelse>#dolphine_sight.pqSum#</cfif>" name="pqSum"  readonly>
				  </div>
				
	<div class="form-group">
					<div class="input-group">
					<div class="input-group-btn">
						<button class="btn btn-inverse" type="button">SDO1:</button>
						<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
						<cfset t=0>
						<cfloop query="TLU_SDO">
						<cfset t=t+1>
							<li><a val="#TLU_SDO.SDO_ID#" class="getvals_update" id="update_SDO1_#t#_#i#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a>	</li>
						</cfloop>
						</ul>
					</div>
						
					<input type="text" class="form-control" id="update_SDO1_val_#i#" value="<cfloop query="TLU_SDO">
					<cfif dolphine_sight.SDO1 eq TLU_SDO.SDO_ID>#TLU_SDO.SDO_ID# | #TLU_SDO.Name#</cfif></cfloop>" readonly>
					<input type="hidden" class="form-control" id="update_SDO1_id_#i#" name="SDO1" value="<cfif len(trim(dolphine_sight.SDO1)) EQ 0>0<cfelse>#dolphine_sight.SDO1#</cfif>" readonly>
					</div>
					</div>
				 
                   <div class="form-group">
					<label for="pwd">Qscore:</label>
					<input type="text" class="form-control" name="Qscore">
				  </div>
                  
				<div class="form-group">
					<label for="pwd">PQP:</label>
					<input type="checkbox" class="checkbox-inline" name="PQP" <cfif dolphine_sight.PQP eq 1>checked</cfif>  value="1">
				  </div>
				  
				 <div class="form-group">
					<label for="pwd">SDR:</label>
					<input type="checkbox" class="checkbox-inline" name="SDR" <cfif dolphine_sight.SDR eq 1>checked</cfif>  value="1"> 
				  </div>
				
				
				<div class="form-group">
					<label for="pwd">Fetals:</label>
					<input type="checkbox" class="checkbox-inline" name="Fetals" <cfif dolphine_sight.Fetals eq 1>checked</cfif>  value="1">
				  </div>
				
				<div class="form-group">
					<label for="pwd">BC:</label>
					<input type="checkbox" class="checkbox-inline" name="BC" <cfif dolphine_sight.BC eq 1>checked</cfif>  value="1">
				  </div>
				
				<div class="form-group">
					<label for="pwd">Xeno:</label>
					<input type="checkbox" name="Xeno" <cfif dolphine_sight.Xeno eq 1>checked</cfif>  value="1">
				  </div>
				
                <div class="form-group">
					<label for="pwd">RDS:</label>
					<input type="checkbox" class="checkbox-inline" name="RDS" <cfif dolphine_sight.RDS eq 1>checked</cfif>  value="1">
				  </div>
				  
                 <div class="form-group">
					<label for="pwd">REM:</label>
					<input type="checkbox" class="checkbox-inline" name="REM" <cfif dolphine_sight.REM eq 1>checked</cfif>  value="1">
				 </div>
                 
                  <div class="form-group">
					<label for="pwd">Fresh wound:</label>
					<input type="checkbox" class="checkbox-inline" <cfif dolphine_sight.Freshwound eq 1>checked</cfif> name="Freshwound"  value="1">
				  </div>
                 
                 
				 </div>
				 
                  <div class="col-md-12">
				  
				  <input type="hidden" class="form-control" name="Sighting_ID" value="#qGetSightings.id#">
                  
                  </div>
			</form>

			</div>
		</div>
		</div>
		</cfloop>
		</div> <!--- end data div ----->
			
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
</cfif>
</cfoutput>