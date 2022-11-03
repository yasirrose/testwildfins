<cfcomponent>
<cfheader name="Access-Control-Allow-Origin" value="*" />
<cfset Application.dsn = "wildfins">
<cffunction name="getdolphin" access="remote" returnformat="plain" output="true">
<cfargument name="dolphin_ID" type="any" required="true" default="" >
<cfquery name="getdolphin" datasource="#application.dsn#">
 select  DOLPHINS.*,Dolphin_DScore.* from DOLPHINS inner join Dolphin_DScore on DOLPHINS.ID=Dolphin_DScore.DolphinID where DOLPHINS.ID=#dolphin_ID#
 </cfquery>

<!--- create array --->
<cfset Arr = ArrayNew(1)>
<!--- loop through query --->
<cfloop query="getdolphin">
	<cfset structofdolphin = StructNew() />
	<cfset structofdolphin["DolphinID"] = getdolphin.DolphinID >

	<cfset structofdolphin["Sex"] = getdolphin.Sex>
	<cfset structofdolphin["Lineage"] = getdolphin.Lineage>
	<cfset structofdolphin["DScoreDate"] = DateFormat(getdolphin.DScoreDate, "mm/dd/yyyy hh:mm:ss")>
	<cfset structofdolphin["Distinct"] = getdolphin.Distinct>
	<cfset structofdolphin["DScore"] = getdolphin.DScore>
	<cfset structofdolphin["FB_No"] = getdolphin.FB_No>
	
	<cfset ArrayAppend(Arr,structofdolphin)>
</cfloop>
<!---SerializeJSON --->
<cfoutput>#SerializeJSON(Arr)#</cfoutput>
</cffunction>




<cffunction name="add_dolphin" access="remote" returnformat="plain" output="true">

<cfoutput>
<cfparam name="Form.PQP" default="0">
<cfparam name="Form.SDR" default="0">
<cfparam name="Form.Fetals" default="0">
<cfparam name="Form.BC" default="0">
<cfparam name="Form.Xeno" default="0">
<cfparam name="Form.RDS" default="0">
<cfparam name="Form.REM" default="0">
<cfparam name="Form.Echelon" default=" ">
<cfparam name="Form.Verified" default=" ">
<cfparam name="Form.Note" default=" ">
<cfparam name="Form.REMPI" default=" ">


<!----------
<cfquery name="getdolphin_COUNT" datasource="#application.dsn#" res="dolph_count">
Select Dolphin_ID,Sighting_ID from DOLPHIN_SIGHTINGS where Dolphin_ID=#Form.Dolphin_ID# and Sighting_ID=#Form.Sighting_ID#;
</cfquery>

<cfif dolph_count.RECORDCOUNT eq 1>
<div class="alert alert-danger">
  <strong>Alert!</strong> This Dolphin already Exist.
</div>
<cfelse>
</cfif>
---------------->

	<cfquery name="insert_dolhpin_sight" datasource="#application.dsn#" result='get_res'>
		insert into DOLPHIN_SIGHTINGS (Dolphin_ID,Sighting_ID,Verified,pq_focus,pq_Angle,pq_Contrast,pq_Proportion,pq_Partial,pqSum,PQP,SDR
		,Note,Fetals,Echelon,BC,Xeno,SDO1,RDS,REMPI,REM,[W/mom],GCP,BIO_LOBO,BIO_POX,BIOSDO)
		values(#Form.Dolphin_ID#,#Form.Sighting_ID#,'#Form.Verified#',#Form.pq_focus#,#Form.pq_Angle#,#Form.pq_Contrast#,#Form.pq_Proportion#,#Form.pq_Partial#,'#Form.pqSum#',#Form.PQP#,#Form.SDR#
		,'#Form.Note#',#Form.Fetals#,'#Form.Echelon#',#Form.BC#,#Form.Xeno#,#Form.SDO1#,#Form.RDS#,'#Form.REMPI#',#Form.REM#,0,0,0,0,0)
		
		</cfquery>

	<cfif get_res.RECORDCOUNT eq 1 >
	<div class='alert alert-success'>
	  <strong>Success!</strong> Dolphin Inserted.
	</div>
	</cfif>

	
</cfoutput>
</cffunction>


<cffunction name="del_dolphinsight" access="remote" returnformat="plain" output="true">

<cfargument name="SightingID" type="any" required="true" default="">
<cfargument name="DolphinID" type="any" required="true" default="">


<cfquery name="del_dolphin" datasource="#application.dsn#">
delete  from DOLPHIN_SIGHTINGS where Dolphin_ID=#DolphinID# and Sighting_ID=#SightingID#
</cfquery>
<cfoutput>
Dolphin Removed successfully.
	
</cfoutput>
</cffunction>


<cffunction name="update_dolphinsight" access="remote" returnformat="plain" output="true">
<cfoutput>

<cfparam name="Form.PQP" default="0">
<cfparam name="Form.SDR" default="0">
<cfparam name="Form.Fetals" default="0">
<cfparam name="Form.BC" default="0">
<cfparam name="Form.Xeno" default="0">
<cfparam name="Form.RDS" default="0">
<cfparam name="Form.REM" default="0">
<cfparam name="Form.Echelon" default=" ">
<cfparam name="Form.Verified" default=" ">
<cfparam name="Form.Note" default=" ">
<cfparam name="Form.REMPI" default=" ">
<cfparam name="Form.pqSum" default="0">
<cfparam name="Form.pq_focus" default="0">
<cfparam name="Form.pq_Angle" default="0">
<cfparam name="Form.pq_Contrast" default="0">
<cfparam name="Form.pq_Partial" default="0">
<cfparam name="Form.pq_Proportion" default="0">

<cfquery name="update_dolhpin_sight" datasource="#application.dsn#">
		 UPDATE DOLPHIN_SIGHTINGS SET Verified = '#Form.Verified#',pq_focus=#Form.pq_focus#, pq_Angle=#Form.pq_Angle#, pq_Contrast=#Form.pq_Contrast#, pq_Proportion=#Form.pq_Proportion#, pq_Partial=#Form.pq_Partial#
			,pqSum='#Form.pqSum#',PQP=#Form.PQP#, SDR=#Form.SDR#, Note='#Form.Note#',Fetals=#Form.Fetals#,Echelon='#Form.Echelon#' ,BC=#Form.BC#, Xeno=#Form.Xeno#, SDO1=#Form.SDO1#,RDS=#Form.RDS#,REMPI='#Form.REMPI#',REM=#Form.REM#
			where Dolphin_ID=#Form.Dolphin_ID# and Sighting_ID=#Form.Sighting_ID# 
			
		</cfquery>
		
	<div class='alert alert-success'>
	  <strong>Success!</strong> Dolphin record updated.
	</div>
</cfoutput>
</cffunction>


<cffunction name="getlist_dolphinsight" access="remote" returnformat="plain" output="true">
<cfargument name="Sightningid" type="any" required="true" default="">

<cfoutput>
<cfquery name="dolphine" datasource="#Application.dsn#" result ='get_dolphine_result'>
select code,id,Name from DOLPHINS ;
</cfquery>


<cfquery name="dolphine_sight" datasource="#Application.dsn#" result ='get_dolphine_result'>
SELECT  DOLPHIN_SIGHTINGS.*,DOLPHINS.* FROM DOLPHIN_SIGHTINGS INNER JOIN DOLPHINS on DOLPHIN_SIGHTINGS.dolphin_ID=DOLPHINS.ID  WHERE DOLPHIN_SIGHTINGS.Sighting_ID=#Sightningid# order by DOLPHIN_SIGHTINGS.Sighting_ID;

</cfquery>

<cfquery name="TLU_SDO" datasource="#Application.dsn#" result ='get_sdo'>
SELECT * FROM TLU_SDO
</cfquery>



<h2>List of Dolphin</h2>
		<div class="row panel-heading">
		<div class="col-md-2">Dophin Name</div>
		<div class="col-md-2">Dscore</div>	
		<div class="col-md-3">DScore date</div>
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
				select top 1 * from Dolphin_DScore where DolphinID=#dolphine_sight.Dolphin_ID#
				
				</cfquery>
		<div class="col-md-12 panel-heading" style="background:##ccc;margin-bottom:5px;">
		
		<div class="col-md-2">#dolphine_sight.Name#</div>
		<div class="col-md-2">#dscore.DScore#</div>
		<div class="col-md-3">#DateFormat(dscore.DScoreDate, "mm-dd-yyyy")#</div> 
		<div class="col-md-2"><button class="btn btn-primary" href="##collapse#i#"  style="cursur:pointer" data-toggle="collapse">Detail</button></div> 
		<div class="col-md-2"><button type="button" class="btn btn-danger delete_dolphin" id="delete_#i#" Sighting_ID="#dolphine_sight.Sighting_ID#" Dolphin_ID="#dolphine_sight.Dolphin_ID#"><span class="glyphicon glyphicon-remove"></span> Remove</button></div> 
		</div>
		
		<div id="collapse#i#" class="col-md-12 panel-collapse collapse" style="border: solid 2px ##ccc;">
			<div class="panel-body">
				<form role="form" id="update_dolhpin_#i#">	 
				 <div class="form-group">
					<label for="email">Dolphin Name/Code:</label>
					
					<select class="form-control" required id="dolphin_up_code" readonly name="Dolphin_ID">
					
					
					<option value="#dolphine_sight.Dolphin_ID#" > <cfloop query="dolphine"><cfif dolphine_sight.Dolphin_ID eq dolphine.id > #dolphine.Name# | #dolphine.code# </cfif></cfloop></option>
					
					</select>
					
				  </div>
				 
				  <div class="form-group">
						<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-inverse" type="button">Verified</button>
							<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a val="P" class="get_val" id="update_varified_1">P</a></li>
								<li><a val="V" class="get_val" id="update_varified_2">V</a></li>
								</ul>
						</div>
						<input type="text" id="update_varified" class="form-control" value="#dolphine_sight.Verified#" maxlength="7"  name="Verified">
					 </div>
					</div>
					
				  
				  <div class="form-group">
					<label for="pwd">Sex:</label>
					<input type="text" class="form-control"  value="#dolphine_sight.Sex#" id="update_sex" readonly >
				  </div>
				
				  <div class="form-group">
					<label for="pwd">Linage:</label>
					<input type="text" class="form-control" id="update_Lineage" readonly  value="#dolphine_sight.Lineage#">
				  </div>
				  
				  <div class="form-group">
					<label for="pwd">Distict Date:</label>
					<input type="text" class="form-control" id="update_distictdate" readonly value="#DateTimeFormat(dolphine_sight.DistinctDate, "mm-dd-yyyy")#">
					
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
						<div class="input-group">
						<div class="input-group-btn">
							<button class="btn btn-inverse" type="button">PQ F:</button>
							<button data-toggle="dropdown" class="btn btn-inverse" type="button" aria-expanded="false">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a val="2" class="get_val sum_calculate_update" id="update_pqf_1">2</a></li>
								<li><a val="4" class="get_val sum_calculate_update" id="update_pqf_2">4</a></li>
								<li><a val="6" class="get_val sum_calculate_update" id="update_pqf_3">6</a></li>
								</ul>
						</div>
						<input type="number" class="form-control sum_calculate_update" id="update_pqf" name="pq_focus" value="<cfif len(trim(dolphine_sight.pq_focus)) EQ 0>0<cfelse>#dolphine_sight.pq_focus#</cfif>">
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
								<li><a val="1" class="get_val sum_calculate_update" id="update_pqa_1">1</a></li>
								<li><a val="2" class="get_val sum_calculate_update" id="update_pqa_2">2</a></li>
								<li><a val="8" class="get_val sum_calculate_update" id="update_pqa_3">8</a></li>
							</ul>
						</div>
						<input type="number" class="form-control sum_calculate_update" name="pq_Angle" id="update_pqa" value="<cfif len(trim(dolphine_sight.pq_Angle)) EQ 0>0<cfelse>#dolphine_sight.pq_Angle#</cfif>">
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
								<li><a val="1" class="get_val sum_calculate_update" id="update_pqc_1">1</a></li>
								<li><a val="3" class="get_val sum_calculate_update" id="update_pqc_2">3</a></li>
								</ul>
						</div>
						<input type="number" class="form-control sum_calculate_update" name="pq_Contrast" id="update_pqc" value="<cfif len(trim(dolphine_sight.pq_Contrast)) EQ 0>0<cfelse>#dolphine_sight.pq_Contrast#</cfif>">
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
							<li><a val="1" class="get_val sum_calculate_update" id="update_pqpro_1">1</a></li>
							<li><a val="5" class="get_val sum_calculate_update" id="update_pqpro_2">5</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate_update" name="pq_Proportion" id="update_pqpro" value="<cfif len(trim(dolphine_sight.pq_Proportion)) EQ 0>0<cfelse>#dolphine_sight.pq_Proportion#</cfif>">
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
							<li><a val="1" class="get_val sum_calculate_update" id="update_pqpar_1">1</a></li>
							<li><a val="8" class="get_val sum_calculate_update" id="update_pqpar_1">8</a></li>
							</ul>
					</div>
					<input type="number" class="form-control sum_calculate_update" name="pq_Partial" id="update_pqpar" value="<cfif len(trim(dolphine_sight.pq_Partial)) EQ 0>0<cfelse>#dolphine_sight.pq_Partial#</cfif>">
				 </div>
				</div>
				
				<div class="form-group">
					<label for="pwd">Pq sum:</label>
					<input type="number" class="form-control" id="update_pqsum" value="<cfif len(trim(dolphine_sight.pqSum)) EQ 0>0<cfelse>#dolphine_sight.pqSum#</cfif>" name="pqSum"  readonly>
				  </div>
				
				<div class="form-group">
					<label for="pwd">FB_No:</label>
					<input type="text" class="form-control" value="#dolphine_sight.FB_No#" id="add_FB_No" readonly>
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
					<label for="pwd">Note:</label>
					<textarea class="form-control" name="Note">#dolphine_sight.Note#</textarea>
				  </div>
				
				<div class="form-group">
					<label for="pwd">Fetals:</label>
					<input type="checkbox" class="checkbox-inline" name="Fetals" <cfif dolphine_sight.Fetals eq 1>checked</cfif>  value="1">
				  </div>
				
				<div class="form-group">
					<label for="pwd">Echelon:</label>
					<input type="text"   class="form-control" name="Echelon" maxlength="5" value="#dolphine_sight.Echelon#">
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
							<li><a val="#TLU_SDO.SDO_ID#" class="getvals" id="update_SDO1_#t#"> #TLU_SDO.SDO_ID# | #TLU_SDO.Name# </a></li>
						</cfloop>
						</ul>
					</div>
						
					<input type="text" class="form-control" id="update_SDO1" value="<cfloop query="TLU_SDO"><cfif dolphine_sight.SDO1 eq TLU_SDO.SDO_ID>#TLU_SDO.SDO_ID# | #TLU_SDO.Name#</cfif></cfloop>" readonly>
					<input type="hidden" class="form-control" id="update_SDO1_ID" name="SDO1" value="<cfloop query="TLU_SDO"><cfif dolphine_sight.SDO1 eq TLU_SDO.SDO_ID>#TLU_SDO.SDO_ID#</cfif></cfloop>" readonly>
					</div>
					</div>
				
				  	<div class="form-group">
					<label for="pwd">RDS:</label>
					<input type="checkbox" class="checkbox-inline" name="RDS" <cfif dolphine_sight.RDS eq 1>checked</cfif>  value="1">
				  </div>
				  
				<div class="form-group">
					<label for="pwd">REMPI:</label>
					<input type="text" class="form-control" value="#dolphine_sight.REMPI#" name="REMPI" maxlength="5">
				  </div>
				  
				   <div class="form-group">
					<label for="pwd">REM:</label>
					<input type="checkbox" class="checkbox-inline" name="REM" <cfif dolphine_sight.REM eq 1>checked</cfif>  value="1">
				  </div>
				  <div class="message"></div>
				  
				  <input type="hidden" class="form-control" name="Sighting_ID" value="#Sightningid#">
				  <button type="submit" class="btn btn-primary update_dolphin" data_id="update_dolhpin_#i#">Update</button>
			</form>

			</div>
		</div>
		</div>
		</cfloop>
		</div> 
		<!--- end data div ----->




		
</cfoutput>
</cffunction>



</cfcomponent>