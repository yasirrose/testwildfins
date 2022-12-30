<cfcomponent displayName="Stranding" output="false">
    <cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
      <cfargument name="dsn" type="string" required="true" hint="datasource">
      <cfset variables.dsn = arguments.dsn>
      <cfreturn this>
    </cffunction>

    <cffunction name="sightingSpot" returntype="any" output="false" access="remote" returnformat="plain">
  
        <!--- <cfquery name="query" datasource="#application.dsn#">
            SELECT * from Survey_Sightings where ATLATITUDE != '' and ATLONGITUDE != '' 
				</cfquery> --->
						<!--- <cfquery name="query" datasource="#Application.dsn#">
							SELECT * from Survey_Sightings 
								 JOIN Surveys on Survey_Sightings.Project_ID = Surveys.ID								 
								 JOIN Cetacean_Sightings on Survey_Sightings.ID = Cetacean_Sightings.Sighting_ID	
								 where ATLATITUDE != '' and ATLONGITUDE != ''
						 </cfquery> --->
						 <!--- <cfquery name="query" datasource="#Application.dsn#"  >
							SELECT * from Survey_Sightings 
								 JOIN Surveys on Survey_Sightings.Project_ID = Surveys.ID
								 where ATLATITUDE != '' and ATLONGITUDE != ''
						 </cfquery> --->


						 		<cfquery name="query" datasource="#Application.dsn#"  >
									SELECT s.Date as date, ss.FE_SPECIES,ss.SIGHTINGNUMBER, s.ID as s_id,ss.ATLATITUDE,ss.ATLONGITUDE, ss.id as ss_id from Survey_Sightings as ss
											Join Surveys as s on ss.Project_ID = s.ID	
												 where ATLATITUDE != '' and ATLONGITUDE != ''
							 </cfquery>
						 <!--- <cfdump var="#query#" abort="true"> --->

				<!--- <cfset jazzmen = [[-77.032, 38.913],[-122.414, 37.776],[-112.414, 38.776]]> --->
				<!--- [#query.ATLATITUDE#, #query.ATLONGITUDE#][-80.337171, 27.534991] --->
				<!--- <cfset geojsonn.properties = {title:'Mapbox', date:"#DateFormat(date,'mm/dd/yyyy')#", sightingNo:#query.SIGHTINGNUMBER#, Species:#query.FE_SPECIES#,SightingId:#query.s_id#,SurveyId:#query.SIGHTINGNUMBER#}> --->
        <cfset features=[]>
		<cfloop query = "query">        
			
			<cfset geojsonn=StructNew("ordered","text","asc",false)>
			<cfset geojsonn.type = "Feature">
			<cfset geojsonn.geometry = {type:'Point', coordinates:[#query.ATLATITUDE#, #query.ATLONGITUDE#] }>	
			<cfset geojsonn.properties = {title:'Mapbox', date:"#DateFormat(date,'mm/dd/yyyy')#", sightingNo:#query.SIGHTINGNUMBER#, Species:#query.FE_SPECIES#,SightingId:#query.ss_id#,SurveyId:#query.s_id#}>
	

		<cfset ArrayAppend(features,geojsonn,"true") >           
		</cfloop>


		<cfset geojson=StructNew("ordered","text","asc",false)>
		<cfset geojson.type = "FeatureCollection">
		<cfset geojson.features = features>


        <cfreturn serializeJSON(geojson)>


		</cffunction>
		
		<cffunction name="getSightingMapData" returntype="any" output="false" access="remote" returnformat="plain">
			<cfquery name="qgetSightingMap" datasource="#application.dsn#"  >
					SELECT * from SightingMap
			</cfquery>
			<cfreturn serializeJSON(qgetSightingMap)>
	</cffunction>
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

</cfcomponent> 