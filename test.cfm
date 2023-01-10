<!--- <cfimage
					action = "resize"
					source = "#Application.CloudDirectory#Jellyfish.jpg"
					width = "100%"
					height = "100%"
					name = "xx.jpg"
					overwrite = "yes">
			<cffile action = "delete" file = "#Application.CloudDirectory#Jellyfish.jpg"> --->
			<!--- <cfquery name="query" datasource="#application.dsn#" >
				SELECT * from Survey_Sightings where ACT_FEED = '3'
				</cfquery> --->



		 <!--- <cfset geojsonn.properties = {title:'Mapbox', date:"#DateFormat(date,'mm/dd/yyyy')#", sightingNo:#query.SIGHTINGNUMBER#, Species:#query.FE_SPECIES#,SightingId:#query.ID#,SurveyId:#query.PROJECT_ID#}> --->
		 <!--- <cfquery name="query" datasource="#Application.dsn#"  >
			SELECT s.Date as date, ss.FE_SPECIES,ss.SIGHTINGNUMBER, s.ID as s_id,ss.ATLATITUDE,ss.ATLONGITUDE, ss.id as ss_id,cs.Cetaceans_ID from Survey_Sightings as ss
					Join Surveys as s on ss.Project_ID = s.ID	
					Join Cetacean_Sightings as cs on ss.SIGHTINGNUMBER = cs.SIGHTINGNUMBER	
					where 1=1
						<cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), s.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
						<cfif isdefined("form.FE_SPECIES") and form.FE_SPECIES neq ""> and ss.FE_SPECIES = '#form.FE_SPECIES#'</cfif>
				AND ATLATITUDE != '' and ATLONGITUDE != ''
	 </cfquery> --->
		 <cfset form.date = '01/01/2018 - 01/02/2023'>
		 <cfset form.FE_SPECIES = '36' >

		 <cfif isdefined("form.date") and form.date NEQ "">
			<cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
			<cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
		 </cfif>

		
		 <cfquery name="query" datasource="#Application.dsn#"  >
			SELECT s.Date as date, ss.FE_SPECIES,ss.SIGHTINGNUMBER, s.ID as s_id,ss.ATLATITUDE,ss.ATLONGITUDE, ss.id as ss_id from Survey_Sightings as ss
					Join Surveys as s on ss.Project_ID = s.ID	
					where ATLATITUDE != '' and ATLONGITUDE != ''
		</cfquery>

    <!--- <cfquery name="qgetCetaceanSpecies" datasource="#Application.dsn#"  >
			SELECT * from TLU_CetaceanSpecies where id = #query.FE_SPECIES#
	</cfquery> --->

				 


				<!--- <cfquery name="query" datasource="#application.dsn#">
					SELECT * from Survey_Sightings where ATLATITUDE != '' and ATLONGITUDE != '' 
				</cfquery> --->

				<!--- <cfdump var="#query#" abort="true"> --->


				 <!--- <cfset jazzmen = [[-77.032, 38.913],[-122.414, 37.776],[-112.414, 38.776]]> --->

				<cfquery name="query" datasource="#Application.dsn#"  >
					SELECT s.Date as date, ss.FE_SPECIES,ss.SIGHTINGNUMBER, s.ID as s_id,ss.ATLATITUDE,ss.ATLONGITUDE, ss.id as ss_id,ss.Project_ID from Survey_Sightings as ss
							Join Surveys as s on ss.Project_ID = s.ID	
							where ATLATITUDE != '' and ATLONGITUDE != ''
				</cfquery>
							
							<cfdump var="#query#" abort="true">
		
												
			  <cfset features=[]>
				<cfloop query = "query">
					<cfquery name="qgetCetaceanSpecies" datasource="#Application.dsn#">
						SELECT * from TLU_CetaceanSpecies where id = #query.FE_SPECIES#
				</cfquery>  
				
				<cfset CETACEANS_ID= '10' >
				<!--- tomottow work --->
					<cfquery name="cetaceansw" datasource="#Application.dsn#">
					select Cetaceans_ID from Cetacean_Sightings where Cetaceans_ID = #query.Project_ID#
				 </cfquery>
					
				<cfquery name="cetaceans" datasource="#Application.dsn#">
					select ID,Code,Name from Cetaceans where ID = #CETACEANS_ID#
				 </cfquery>
					
					<cfset geojsonn=StructNew("ordered","text","asc",false)>
					<cfset geojsonn.type = "Feature">
					<cfset geojsonn.geometry = {type:'Point', coordinates:[#query.ATLATITUDE#, #query.ATLONGITUDE#] }>	
					<cfset geojsonn.properties = {title:'Mapbox', date:"#DateFormat(date,'mm/dd/yyyy')#", sightingNo:#query.SIGHTINGNUMBER#, Species:#qgetCetaceanSpecies.CETACEANSPECIESNAME#,SightingId:#query.ss_id#,SurveyId:#query.s_id#,CETACEANS_ID:#cetaceans.code#}>
			
		
				<cfset ArrayAppend(features,geojsonn,"true") >           
				</cfloop>
		
		
				<cfset geojson=StructNew("ordered","text","asc",false)>
				<cfset geojson.type = "FeatureCollection">
				<cfset geojson.features = features>
		
				<cfdump var="#query.Project_ID#" abort="true">
		
				<cfreturn serializeJSON(geojson)>
		
		
		
				
		<cfabort>
<!--- const geojson = {
	type: 'FeatureCollection',
	features: [
	  {
		type: 'Feature',
		geometry: {
		  type: 'Point',
		  coordinates: [-77.032, 38.913]
		},
		properties: {
		  title: 'Mapbox',
		  description: 'Washington, D.C.'
		}
	  }
	]
  }; --->


<!--- <cfquery name="getSurvey" datasource="#application.dsn#" result="res">
	SELECT ID, NOAAStock from Surveys where NOAAStock != 'null';
</cfquery>


<cfloop query="getSurvey">
	
	<cfquery name="getAllNames" datasource="#application.dsn#">
		SELECT ID, StockName, active FROM TLU_Stock where StockName = '#getSurvey.NOAAStock#'
	</cfquery>

	<cfquery name="updateSurvey" datasource="#application.dsn#" result="res">
		Update Surveys set NOAAStock = '#getAllNames.ID#' where ID = '#getSurvey.ID#' and NOAAStock = '#getAllNames.StockName#'
	</cfquery>

	<cfdump var="#res#"> --->

<!--- </cfloop> --->