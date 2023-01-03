<cfcomponent displayName="Stranding" output="false">
    <cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
      <cfargument name="dsn" type="string" required="true" hint="datasource">
      <cfset variables.dsn = arguments.dsn>
      <cfreturn this>
    </cffunction>

    <cffunction name="sightingSpot" returntype="any" output="false" access="remote" returnformat="plain">
  
						 		<cfquery name="query" datasource="#Application.dsn#"  >
									SELECT s.Date as date, ss.FE_SPECIES,ss.SIGHTINGNUMBER, s.ID as s_id,ss.ATLATITUDE,ss.ATLONGITUDE, ss.id as ss_id,cs.Cetaceans_ID from Survey_Sightings as ss
											Join Surveys as s on ss.Project_ID = s.ID	
											Join Cetacean_Sightings as cs on ss.SIGHTINGNUMBER = cs.SIGHTINGNUMBER
												 where ATLATITUDE != '' and ATLONGITUDE != ''
							 </cfquery>
					
						 <!--- <cfdump var="#query#" abort="true"> --->

				<!--- <cfset jazzmen = [[-77.032, 38.913],[-122.414, 37.776],[-112.414, 38.776]]> --->
				<!--- [#query.ATLATITUDE#, #query.ATLONGITUDE#][-80.337171, 27.534991] --->
				<!--- <cfset geojsonn.properties = {title:'Mapbox', date:"#DateFormat(date,'mm/dd/yyyy')#", zsightingNo:#query.SIGHTINGNUMBER#, Species:#query.FE_SPECIES#,SightingId:#query.s_id#,SurveyId:#query.SIGHTINGNUMBER#}> --->
      <cfset features=[]>
		<cfloop query = "query">
			<cfquery name="qgetCetaceanSpecies" datasource="#Application.dsn#"  >
				SELECT * from TLU_CetaceanSpecies where id = #query.FE_SPECIES#
		</cfquery>  
		
		<cfquery name="cetaceans" datasource="#Application.dsn#">
			select ID,Code,Name from Cetaceans where ID = #query.CETACEANS_ID#
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


        <cfreturn serializeJSON(geojson)>


		</cffunction>
		
		<cffunction name="getSightingMapData" returntype="any" output="false" access="remote" returnformat="plain">
			<cfquery name="qgetSightingMap" datasource="#application.dsn#"  >
					SELECT * from SightingMap
			</cfquery>
			<cfreturn serializeJSON(qgetSightingMap)>
	</cffunction>


	<cffunction name="getFilterSightingMapData" returntype="any" output="false" access="remote" returnformat="plain">
	
				<cfset date = '01/01/2018 - 01/02/2023'>
				<!--- <cfset datee = '#date#'> --->
				<!--- 01/01/2018 - 01/02/2023 --->
				<!--- <cfset date = '#datee#'> --->

				<cfset FE_SPECIES = '36' >

				<cfset startDate = dateformat(startDate,'YYYY-mm-dd')>
				<cfset endDate   = dateformat(endDate,'YYYY-mm-dd')>
				<!--- <cfif isdefined("date") and date NEQ "">
				</cfif> --->

				<cfquery name="query" datasource="#Application.dsn#"  >
				SELECT s.Date as date, ss.FE_SPECIES,ss.SIGHTINGNUMBER, s.ID as s_id,ss.ATLATITUDE,ss.ATLONGITUDE, ss.id as ss_id,cs.Cetaceans_ID from Survey_Sightings as ss
						Join Surveys as s on ss.Project_ID = s.ID	
						Join Cetacean_Sightings as cs on ss.SIGHTINGNUMBER = cs.SIGHTINGNUMBER	
						where 1=1
							<cfif isdefined("startDate") and startDate neq "" and endDate NEQ "">and CONVERT(char(10), s.Date,126) BETWEEN '#startDate#' AND '#endDate#'</cfif>
							<cfif isdefined("FE_SPECIES") and FE_SPECIES neq ""> and ss.FE_SPECIES = '#FE_SPECIES#'</cfif>
					AND ATLATITUDE != '' and ATLONGITUDE != ''
			</cfquery>


				<!--- <cfset jazzmen = [[-77.032, 38.913],[-122.414, 37.776],[-112.414, 38.776]]> --->

				<cfset features=[]>
				<cfloop query = "query">
					<cfquery name="qgetCetaceanSpecies" datasource="#Application.dsn#"  >
						SELECT * from TLU_CetaceanSpecies where id = #query.FE_SPECIES#
				</cfquery>    
				
				<cfquery name="cetaceans" datasource="#Application.dsn#">
				 select ID,Code,Name from Cetaceans where ID = #query.CETACEANS_ID#
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
				<cfreturn serializeJSON(geojson)>


</cffunction>


</cfcomponent> 