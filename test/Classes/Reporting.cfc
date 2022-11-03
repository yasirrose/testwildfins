<cfcomponent displayName="Reporting" output="false">
  <cfset variables.dsn = "wildfins_new">
<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
  <cfargument name="dsn" type="string" required="true" hint="datasource">
  <cfset variables.dsn = arguments.dsn>
  <cfreturn this>
</cffunction>
<!------- Roll Call Report ---------->
<cffunction name="getRollCallMain" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT DOLPHIN_SIGHTINGS.Dolphin_ID, COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) AS SEEN_TIMES,DOLPHINS.Name,DOLPHINS.Code,DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,YEAR (DOLPHINS.[Date of Death]) AS DeathYear,DOLPHINS.[Dead?] AS IsDead,
        
           (SELECT  count(ds.Dolphin_ID)
            FROM PROJECTS p
            INNER JOIN SIGHTINGS s ON s.Project_ID = p.ID
            INNER JOIN DOLPHIN_SIGHTINGS ds ON s.ID = ds.Sighting_ID
            INNER JOIN DOLPHINS d ON ds.Dolphin_ID = d.ID
            INNER JOIN TLU_Zones tz ON s.Zone_id = tz.ID
        
            WHERE YEAR (p.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND p.Type = 'Census' AND p.SurveyArea <> 'Atlantic Ocean'
            and ds.Dolphin_ID = DOLPHIN_SIGHTINGS.Dolphin_ID and tz.ZSEGMENT = '1A') as segment_1A,
        
        
           (SELECT  count(ds.Dolphin_ID)
            FROM PROJECTS p
            INNER JOIN SIGHTINGS s ON s.Project_ID = p.ID
            INNER JOIN DOLPHIN_SIGHTINGS ds ON s.ID = ds.Sighting_ID
            INNER JOIN DOLPHINS d ON ds.Dolphin_ID = d.ID
            INNER JOIN TLU_Zones tz ON s.Zone_id = tz.ID
        
            WHERE YEAR (p.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND p.Type = 'Census' AND p.SurveyArea <> 'Atlantic Ocean'
            and ds.Dolphin_ID = DOLPHIN_SIGHTINGS.Dolphin_ID and tz.ZSEGMENT = '1B') as segment_1B,
        

           (SELECT  count(ds.Dolphin_ID)
            FROM PROJECTS p
            INNER JOIN SIGHTINGS s ON s.Project_ID = p.ID
            INNER JOIN DOLPHIN_SIGHTINGS ds ON s.ID = ds.Sighting_ID
            INNER JOIN DOLPHINS d ON ds.Dolphin_ID = d.ID
            INNER JOIN TLU_Zones tz ON s.Zone_id = tz.ID
        
            WHERE YEAR (p.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND p.Type = 'Census' AND p.SurveyArea <> 'Atlantic Ocean'
            and ds.Dolphin_ID = DOLPHIN_SIGHTINGS.Dolphin_ID and tz.ZSEGMENT = '1C') as segment_1C,
        
           (SELECT  count(ds.Dolphin_ID)
            FROM PROJECTS p
            INNER JOIN SIGHTINGS s ON s.Project_ID = p.ID
            INNER JOIN DOLPHIN_SIGHTINGS ds ON s.ID = ds.Sighting_ID
            INNER JOIN DOLPHINS d ON ds.Dolphin_ID = d.ID
            INNER JOIN TLU_Zones tz ON s.Zone_id = tz.ID
        
            WHERE YEAR (p.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND p.Type = 'Census' AND p.SurveyArea <> 'Atlantic Ocean'
            and ds.Dolphin_ID = DOLPHIN_SIGHTINGS.Dolphin_ID and tz.ZSEGMENT = '2') as segment_2,
        
        
           (SELECT  count(ds.Dolphin_ID)
            FROM PROJECTS p
            INNER JOIN SIGHTINGS s ON s.Project_ID = p.ID
            INNER JOIN DOLPHIN_SIGHTINGS ds ON s.ID = ds.Sighting_ID
            INNER JOIN DOLPHINS d ON ds.Dolphin_ID = d.ID
            INNER JOIN TLU_Zones tz ON s.Zone_id = tz.ID
        
            WHERE YEAR (p.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND p.Type = 'Census' AND p.SurveyArea <> 'Atlantic Ocean'
            and ds.Dolphin_ID = DOLPHIN_SIGHTINGS.Dolphin_ID and tz.ZSEGMENT = '3') as segment_3,
        
        
           (SELECT  count(ds.Dolphin_ID)
            FROM PROJECTS p
            INNER JOIN SIGHTINGS s ON s.Project_ID = p.ID
            INNER JOIN DOLPHIN_SIGHTINGS ds ON s.ID = ds.Sighting_ID
            INNER JOIN DOLPHINS d ON ds.Dolphin_ID = d.ID
            INNER JOIN TLU_Zones tz ON s.Zone_id = tz.ID
        
            WHERE YEAR (p.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND p.Type = 'Census' AND p.SurveyArea <> 'Atlantic Ocean'
            and ds.Dolphin_ID = DOLPHIN_SIGHTINGS.Dolphin_ID and tz.ZSEGMENT = '4') as segment_4
  

        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY DOLPHIN_SIGHTINGS.Dolphin_ID,DOLPHINS.Name,DOLPHINS.Code,DOLPHINS.Sex,DOLPHINS.YearOfBirth,YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]

        HAVING COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) >= #form.seentimes#

        ORDER BY DOLPHIN_SIGHTINGS.Dolphin_ID ASC
    </cfquery>
  <cfreturn  query>
</cffunction>
    <cffunction name="getSingleObserverDetails" returntype="any" output="false" access="public">
       <cfargument name="user" default="">
        <cfparam name="form.user" default="">
        <cfquery name="getSingleObserverDetails" datasource="#variables.dsn#">
        SELECT top 1 Observation_Details.*, Observation_Details.[Live Dolphins Sightings] as livedsight,Observation_Details.[Other Observation Type] as othrtype
        ,Observation_Details.[Observed Dolphin Number] as totaldolphins,Observation_Details.[First Dolphin Size] as size1,Observation_Details.[Second Dolphin Size] as size2,Observation_Details.[third Dolphin Size] as size3,
         Observation_Details.[Authorize Media] as authmedia,Observation_Details.[Behavior Details] as behavdetails,
         Observation_Details.[Additional Size Notes] as additionsize,Observation_Details.[City Water Body] as waterbody, Observation_Details.[Sighting Confidence] as confidence
         ,Dolphin_Observer.*, Dolphin_Observer.[is_public member] as pmember , Dolphin_Observer.[other observers] as othrobserver , Dolphin_Observer.[is_nature photographer] as naturalgrapher  from Observation_Details
          join Dolphin_Observer on Observation_Details.user_id = Dolphin_Observer.id where Observation_Details.observation_id ='#user#'
    </cfquery>
        <cfreturn getSingleObserverDetails>
    </cffunction>
<cffunction name="getWatchingReport" returntype="any" output="false" access="public">
    <cfquery name="getWatchingReport" datasource="#variables.dsn#">
        SELECT Observation_Details.*,Dolphin_Observer.* from Observation_Details
        join Dolphin_Observer on Observation_Details.user_id = Dolphin_Observer.id
        order by Observation_Details.observation_id desc
    </cfquery>
    <cfreturn getWatchingReport>
</cffunction>
<cffunction name="getRollCallGrapghFromYear" returntype="any" output="false" access="public" >
  <!---<cfquery name="query" datasource="#variables.dsn#" >
              SELECT
              DOLPHIN_SIGHTINGS.Sighting_ID,
              PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) =  #FORM.fromYear# <!---BETWEEN #FORM.fromYear# AND #FORM.toYear#--->
        AND DOLPHINS.Code NOT LIKE 'UNK%'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC

       </cfquery>--->
       
       <cfquery name="query" datasource="#variables.dsn#">
    	SELECT
              DOLPHIN_SIGHTINGS.Sighting_ID,
              PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
		CASE
			WHEN MONTH (PROJECTS.[Date]) IN (1,2,3) THEN  1
			WHEN MONTH (PROJECTS.[Date]) IN (4,5,6) THEN 2
			WHEN MONTH (PROJECTS.[Date]) IN (7,8,9) THEN 3
			WHEN MONTH (PROJECTS.[Date]) IN (10,11,12) THEN 4
		END AS count
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) =  #FORM.fromYear# AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
    </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="combineChartLinefromYear" returntype="any" output="false" access="public" >
	<cfset res_fromYear = [0,0,0,0,0,0,0,0,0,0,0,0] >
    <cfquery name="query" datasource="#variables.dsn#">
    	SELECT
        PROJECTS.ID,
        PROJECTS.BeginZoneID,
		PROJECTS.EndZoneID,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) =  #FORM.fromYear# AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        PROJECTS.ID,
        PROJECTS.BeginZoneID,
		PROJECTS.EndZoneID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date])
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
    </cfquery>
    <cfloop query="query">
    	<cfset beginZone = 0>
        <cfset endZone = 0>
    	<!---<cfif query.BeginZoneID EQ 0>
        	<cfset res_fromYear[query.SurveryMONTH] += 0>
        <cfelse>--->
        	<cfquery name="zoneBegin" datasource="#variables.dsn#">SELECT Zone FROM TLU_Zones WHERE ID = #query.BeginZoneID# AND ZONE NOT LIKE 'ATL%'</cfquery>
            <cfquery name="zoneEnd" datasource="#variables.dsn#">SELECT Zone FROM TLU_Zones WHERE ID = #query.EndZoneID# AND ZONE NOT LIKE 'ATL%'</cfquery>
            <cfif zoneBegin.Zone contains 'ALT'>
            <cfset beginZone = RemoveChars(zoneBegin.Zone,1,3)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            <cfelseif zoneBegin.Zone contains 'BR'>
            <cfset beginZone = RemoveChars(zoneBegin.Zone,1,2)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,2) - RemoveChars(zoneEnd.Zone,1,2))>--->
            <cfelseif zoneBegin.Zone contains 'IR'>
            	<cfset beginZone = RemoveChars(zoneBegin.Zone,1,2)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            <cfelseif zoneBegin.Zone contains 'ML'>
            	<cfset beginZone = RemoveChars(zoneBegin.Zone,1,3)>
				<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,2) - RemoveChars(zoneEnd.Zone,1,2))>--->
            <cfelseif zoneBegin.Zone contains 'SLR'>
            	<cfset beginZone = RemoveChars(zoneBegin.Zone,1,3)>
				<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            </cfif>
            <cfif zoneEnd.Zone contains 'ALT'>
            <cfset endZone = RemoveChars(zoneEnd.Zone,1,3)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            <cfelseif zoneEnd.Zone contains 'BR'>
            <cfset endZone = RemoveChars(zoneEnd.Zone,1,2)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,2) - RemoveChars(zoneEnd.Zone,1,2))>--->
            <cfelseif zoneEnd.Zone contains 'IR'>
            	<cfset endZone = RemoveChars(zoneEnd.Zone,1,2)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            <cfelseif zoneEnd.Zone contains 'ML'>
            	<cfset endZone = RemoveChars(zoneEnd.Zone,1,3)>
				<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,2) - RemoveChars(zoneEnd.Zone,1,2))>--->
            <cfelseif zoneEnd.Zone contains 'SLR'>
            	<cfset endZone = RemoveChars(zoneEnd.Zone,1,3)>
				<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            </cfif>
			<cfset res_fromYear[query.SurveryMONTH] += abs(beginZone - endZone)>
            <!---<cfdump var="#res_fromYear[query.SurveryMONTH]#">--->
        <!---</cfif>--->
    </cfloop>
    <!---<cfloop from="1" to="12" index="i">	
        <cfquery name="query" datasource="#variables.dsn#">
            SELECT 
            COUNT(DISTINCT TLU_Zones.ZONE) as zone_num
            FROM
            PROJECTS
            INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
            INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
            INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
            INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID
    
            WHERE
            YEAR (PROJECTS.[Date]) = #FORM.fromYear# AND MONTH(PROJECTS.[Date]) = #i# AND PROJECTS.SurveyArea <> 'Atlantic Ocean' AND TLU_Zones.ZONE NOT LIKE 'ATL%'
            <!---AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'--->
        </cfquery>
        <cfif query.recordcount NEQ 0 >
			<cfset res_fromYear[i] = query.zone_num>
            <cfelse>
            <cfset res_fromYear[i] = 0>
      </cfif>
	</cfloop>--->
    <cfreturn res_fromYear> 
</cffunction>
<cffunction name="combineChartLinetoYear" returntype="any" output="false" access="public" >
	<cfset res_toYear = [0,0,0,0,0,0,0,0,0,0,0,0] >
    <cfquery name="query" datasource="#variables.dsn#">
    	SELECT
        PROJECTS.ID,
        PROJECTS.BeginZoneID,
		PROJECTS.EndZoneID,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) =  #FORM.toYear# AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        PROJECTS.ID,
        PROJECTS.BeginZoneID,
		PROJECTS.EndZoneID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date])
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
    </cfquery>
    <cfloop query="query">
    	<cfset beginZone = 0>
        <cfset endZone = 0>
    	<!---<cfif query.BeginZoneID EQ 0>
        	<cfset res_fromYear[query.SurveryMONTH] += 0>
        <cfelse>--->
        	<cfquery name="zoneBegin" datasource="#variables.dsn#">SELECT Zone FROM TLU_Zones WHERE ID = #query.BeginZoneID# AND ZONE NOT LIKE 'ATL%'</cfquery>
            <cfquery name="zoneEnd" datasource="#variables.dsn#">SELECT Zone FROM TLU_Zones WHERE ID = #query.EndZoneID# AND ZONE NOT LIKE 'ATL%'</cfquery>
            <cfif zoneBegin.Zone contains 'ALT'>
            <cfset beginZone = RemoveChars(zoneBegin.Zone,1,3)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            <cfelseif zoneBegin.Zone contains 'BR'>
            <cfset beginZone = RemoveChars(zoneBegin.Zone,1,2)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,2) - RemoveChars(zoneEnd.Zone,1,2))>--->
            <cfelseif zoneBegin.Zone contains 'IR'>
            	<cfset beginZone = RemoveChars(zoneBegin.Zone,1,2)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            <cfelseif zoneBegin.Zone contains 'ML'>
            	<cfset beginZone = RemoveChars(zoneBegin.Zone,1,3)>
				<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,2) - RemoveChars(zoneEnd.Zone,1,2))>--->
            <cfelseif zoneBegin.Zone contains 'SLR'>
            	<cfset beginZone = RemoveChars(zoneBegin.Zone,1,3)>
				<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            </cfif>
            <cfif zoneEnd.Zone contains 'ALT'>
            <cfset endZone = RemoveChars(zoneEnd.Zone,1,3)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            <cfelseif zoneEnd.Zone contains 'BR'>
            <cfset endZone = RemoveChars(zoneEnd.Zone,1,2)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,2) - RemoveChars(zoneEnd.Zone,1,2))>--->
            <cfelseif zoneEnd.Zone contains 'IR'>
            	<cfset endZone = RemoveChars(zoneEnd.Zone,1,2)>
            	<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            <cfelseif zoneEnd.Zone contains 'ML'>
            	<cfset endZone = RemoveChars(zoneEnd.Zone,1,3)>
				<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,2) - RemoveChars(zoneEnd.Zone,1,2))>--->
            <cfelseif zoneEnd.Zone contains 'SLR'>
            	<cfset endZone = RemoveChars(zoneEnd.Zone,1,3)>
				<!---<cfset res_check[query.SurveryMONTH] += abs(RemoveChars(zoneBegin.Zone,1,3) - RemoveChars(zoneEnd.Zone,1,3))>--->
            </cfif>
			<cfset res_toYear[query.SurveryMONTH] += abs(beginZone - endZone)>
            <!---<cfdump var="#res_fromYear[query.SurveryMONTH]#">--->
        <!---</cfif>--->
    </cfloop>
	<!---<cfloop from="1" to="12" index="i">	
        <cfquery name="query" datasource="#variables.dsn#">
            SELECT 
            COUNT(DISTINCT TLU_Zones.ZONE) as zone_num
            FROM
            PROJECTS
            INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
            INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
            INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
            INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID
    
            WHERE
            YEAR (PROJECTS.[Date]) = #FORM.toYear# AND MONTH(PROJECTS.[Date]) = #i# AND PROJECTS.SurveyArea <> 'Atlantic Ocean' AND TLU_Zones.ZONE NOT LIKE 'ATL%'
            <!---AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'--->
        </cfquery>
        <cfif query.recordcount NEQ 0 >
			<cfset res_fromYear[i] = query.zone_num>
            <cfelse>
            <cfset res_fromYear[i] = 0>
      </cfif>
	</cfloop>--->
    <cfreturn res_toYear> 
</cffunction>

<cffunction name="getRollCallGrapghEndYear" returntype="any" output="false" access="public" >
  <!---<cfquery name="query" datasource="#variables.dsn#" >
              SELECT
              DOLPHIN_SIGHTINGS.Sighting_ID,
              PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) =  #FORM.toYear# <!---BETWEEN #FORM.fromYear# AND #FORM.toYear#--->
        AND DOLPHINS.Code NOT LIKE 'UNK%'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC

       </cfquery>--->
       
       <cfquery name="query" datasource="#variables.dsn#">
    	SELECT
              DOLPHIN_SIGHTINGS.Sighting_ID,
              PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
		CASE
			WHEN MONTH (PROJECTS.[Date]) IN (1,2,3) THEN  1
			WHEN MONTH (PROJECTS.[Date]) IN (4,5,6) THEN 2
			WHEN MONTH (PROJECTS.[Date]) IN (7,8,9) THEN 3
			WHEN MONTH (PROJECTS.[Date]) IN (10,11,12) THEN 4
		END AS count
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) =  #FORM.toYear#
         AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
    </cfquery>
  <cfreturn  query>
</cffunction>

    <cffunction name="getBiopsyreportData" access="public" returntype="any" output="false">
        <cfargument name="bodyConditionStartYear" type="any" required="true" default="">
        <cfargument name="bodyConditionEndYear" type="any" required="true" default="">
    </cffunction>
<!--- Dead Dolphins Body Conditions --->
    <cffunction name="getBiopsyShooterrecord" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" type="any" required="true" default="">
        <cfquery name="getBiopsyShooterrecord" datasource="#variables.dsn#">
          select * from BIOPSY_SHOTS where Arbalester = #form.Arbalester#
        </cfquery>
    </cffunction>
    <cffunction name="deadBodyConditions" access="public" returntype="any" output="false">
  <cfargument name="bodyConditionStartYear" type="any" required="true" default="">
  <cfargument name="bodyConditionEndYear" type="any" required="true" default="">
  <cfargument name="conditionCode" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
SELECT
	PROJECTS.ID AS pro_id,
	YEAR (PROJECTS.[Date]) AS SurveryYear,
	MONTH (PROJECTS.[Date]) AS SurveryMONTH,
	DOLPHIN_SIGHTINGS.Dolphin_ID,
	DOLPHIN_SIGHTINGS.Sighting_ID,
	DOLPHIN_SIGHTINGS.Xeno,
	DOLPHIN_SIGHTINGS.REM,
	DOLPHIN_SIGHTINGS.Fetals,
	DOLPHIN_SIGHTINGS.BC,
	DOLPHIN_SIGHTINGS.RDS,
	DOLPHIN_SIGHTINGS.Freshwound,
dbo.DOLPHINS.Name,
dbo.DOLPHINS.Code,
dbo.DOLPHINS.Sex,
dbo.DOLPHINS.[Dead?]
FROM
	PROJECTS
INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
WHERE
	YEAR (PROJECTS.[Date]) BETWEEN <cfqueryparam cfsqltype="cf_sql_integer" value="#bodyConditionStartYear#"> AND <cfqueryparam cfsqltype="cf_sql_integer" value="#bodyConditionEndYear#">
AND (
	DOLPHIN_SIGHTINGS.Xeno = 1
	OR DOLPHIN_SIGHTINGS.REM = 1
	OR DOLPHIN_SIGHTINGS.Fetals = 1
	OR DOLPHIN_SIGHTINGS.BC = 1
	OR DOLPHIN_SIGHTINGS.RDS = 1
	OR DOLPHIN_SIGHTINGS.Freshwound = 1
)
AND DOLPHINS.[Dead?] = 1
<cfif conditionCode neq 0>
<cfif conditionCode eq 'UNK'>
 AND Code LIKE 'UNK%'
 </cfif>
<cfif conditionCode eq 'UK'>
 AND Code NOT LIKE 'UNK%'
</cfif>
</cfif>

</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Previously Known Dolphins --->
<cffunction name="previouslyKnownDolphins" access="public"  returntype="any" output="false">
  <cfargument name="HearYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
SELECT DOLPHINS.ID FROM DOLPHINS WHERE [DOLPHINS].[Source Sexed] = 'HERA'
AND DOLPHINS.Code != '' AND YEAR([DOLPHINS].[DistinctDate]) < <cfqueryparam cfsqltype="cf_sql_integer" value="#HearYear#">
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Early Released Dolphins --->
<cffunction name="earlyReleasedDolphins" access="public" returntype="any" output="false">
  <cfargument name="HearYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
SELECT DISTINCT DOLPHINS.ID, DOLPHINS.Name, DOLPHINS.Code, DOLPHINS.SEX, SIGHTINGS.Date_Entered, DOLPHIN_SIGHTINGS.Note FROM DOLPHINS INNER JOIN DOLPHIN_SIGHTINGS ON DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID
INNER JOIN SIGHTINGS ON DOLPHIN_SIGHTINGS.SIGHTING_ID = SIGHTINGS.ID
WHERE YEAR(SIGHTINGS.Date_Entered) < <cfqueryparam cfsqltype="cf_sql_integer" value="#HearYear#"> AND [DOLPHINS].[Source Sexed] = 'HERA'
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Late Releases Dolphins --->
<cffunction name="lateReleasedDolphins" access="public" returntype="any" output="false">
  <cfargument name="HearYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
SELECT DISTINCT DOLPHINS.ID, DOLPHINS.Name, DOLPHINS.Code, DOLPHINS.SEX, SIGHTINGS.Date_Entered FROM DOLPHINS INNER JOIN DOLPHIN_SIGHTINGS ON DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID
INNER JOIN SIGHTINGS ON DOLPHIN_SIGHTINGS.SIGHTING_ID = SIGHTINGS.ID
WHERE YEAR(SIGHTINGS.Date_Entered) >= <cfqueryparam cfsqltype="cf_sql_integer" value="#HearYear#"> AND [DOLPHINS].[Source Sexed] = 'HERA'
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Hera Report Indivisual Capture ---->
<cffunction name="indivisualCaptureDolphins" access="public" returntype="any" output="false">
  <cfargument name="HearYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
select [DOLPHINS].* from [DOLPHINS]
join [DOLPHIN_SIGHTINGS] ON [DOLPHINS].id = [DOLPHIN_SIGHTINGS].dolphin_id
join [SIGHTINGS] ON [DOLPHIN_SIGHTINGS].sighting_id = [SIGHTINGS].id
join [PROJECTS] ON [SIGHTINGS].project_id = [PROJECTS].ID AND year([PROJECTS].[date]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#HearYear#">
Where [DOLPHINS].[Source Sexed] = 'HERA'
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!---- Recovered By Augencies --->
<cffunction name="RecoveredAgencyEAI" access="public" returntype="any" output="false">
  <cfargument name="filterRecoveredYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	Select DOLPHINS.*, DOLPHINS.[Date of Death] As deathdate, DOLPHINS.[Field ID] As FieldID from DOLPHINS Where DOLPHINS.[Field ID] LIKE 'EAI%'
</cfquery>
  <cfreturn getRec/>
</cffunction>
<cffunction name="RecoveredAgencyHBOI" access="public" returntype="any" output="false">
  <cfargument name="filterRecoveredYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	Select DOLPHINS.*, DOLPHINS.[Date of Death] As deathdate, DOLPHINS.[Field ID] As FieldID from DOLPHINS Where DOLPHINS.[Field ID] LIKE 'HBOI%'
</cfquery>
  <cfreturn getRec/>
</cffunction>
<cffunction name="RecoveredAgencyHubbs" access="public" returntype="any" output="false">
  <cfargument name="filterRecoveredYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	Select DOLPHINS.*, DOLPHINS.[Date of Death] As deathdate, DOLPHINS.[Field ID] As FieldID from DOLPHINS Where DOLPHINS.[Field ID] LIKE 'Hubbs%'
</cfquery>
  <cfreturn getRec/>
</cffunction>
<cffunction name="getRollCallGrapghMonthfromYear" returntype="any" output="true" access="remote" >
    <cfif URL.monthName EQ 'Jan' >
    <cfset month_no = 1 >
    <cfelseif URL.monthName EQ 'Feb' >
    <cfset month_no = 2 >
    <cfelseif URL.monthName EQ 'Mar' >
    <cfset month_no = 3 >
    <cfelseif URL.monthName EQ 'Apr' >
    <cfset month_no = 4 >
    <cfelseif URL.monthName EQ 'May' >
    <cfset month_no = 5 >
    <cfelseif URL.monthName EQ 'Jun' >
    <cfset month_no = 6 >
    <cfelseif URL.monthName EQ 'Jul' >
    <cfset month_no = 7 >
    <cfelseif URL.monthName EQ 'Aug' >
    <cfset month_no = 8 >
    <cfelseif URL.monthName EQ 'Sep' >
    <cfset month_no = 9 >
    <cfelseif URL.monthName EQ 'Oct' >
    <cfset month_no = 10 >
    <cfelseif URL.monthName EQ 'Nov' >
    <cfset month_no = 11 >
    <cfelseif URL.monthName EQ 'Dec' >
    <cfset month_no = 12 >
  </cfif>
  <cfquery name="query" datasource="#variables.dsn#" >
          SELECT
          DOLPHIN_SIGHTINGS.Sighting_ID,
          PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) = #URL.fromYear# AND MONTH (PROJECTS.[Date]) = #month_no# 
         AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC

       </cfquery>
  <cfoutput>#SerializeJSON(query)#</cfoutput>
</cffunction>


<cffunction name="getRollCallGrapghMonthtoYear" returntype="any" output="true" access="remote" >
    <cfif URL.monthName EQ 'Jan' >
    <cfset month_no = 1 >
    <cfelseif URL.monthName EQ 'Feb' >
    <cfset month_no = 2 >
    <cfelseif URL.monthName EQ 'Mar' >
    <cfset month_no = 3 >
    <cfelseif URL.monthName EQ 'Apr' >
    <cfset month_no = 4 >
    <cfelseif URL.monthName EQ 'May' >
    <cfset month_no = 5 >
    <cfelseif URL.monthName EQ 'Jun' >
    <cfset month_no = 6 >
    <cfelseif URL.monthName EQ 'Jul' >
    <cfset month_no = 7 >
    <cfelseif URL.monthName EQ 'Aug' >
    <cfset month_no = 8 >
    <cfelseif URL.monthName EQ 'Sep' >
    <cfset month_no = 9 >
    <cfelseif URL.monthName EQ 'Oct' >
    <cfset month_no = 10 >
    <cfelseif URL.monthName EQ 'Nov' >
    <cfset month_no = 11 >
    <cfelseif URL.monthName EQ 'Dec' >
    <cfset month_no = 12 >
  </cfif>
  <cfquery name="query" datasource="#variables.dsn#" >
          SELECT
          DOLPHIN_SIGHTINGS.Sighting_ID,
          PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) = #URL.toYear# AND MONTH (PROJECTS.[Date]) = #month_no# 
        AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC

       </cfquery>
  <cfoutput>#SerializeJSON(query)#</cfoutput>
</cffunction>

<cffunction name="getRollCallSub" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
        DOLPHIN_SIGHTINGS.Sighting_ID
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
         AND  DOLPHINS.Code = '#code#'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
       </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="getRollCallPieGraphSliceDataFromYear" returntype="any" access="remote">
	<!---<cfset qgetRollCallGrapghFromYear = Application.Reporting.getRollCallGrapghFromYear(argumentCollection="#Form#")>--->
    <cfset Array_fromYear = ArrayNew(1)>
    <cfset responce = '    <table  class="table table-striped table-bordered" >
                <tr>
                <td width="80"><b>ID</b></td>
                <td width="100"><b>Code</b></td>
                <td width="120"><b>Sighting ID</b></td>
                <td width="250"><b>Name</b></td>
                <td width="50"><b>Sex</b></td>
            </tr>
         </table>
         <div class="datacontainer"> 
         <table class="table table-striped table-bordered">'>
    <cfquery name="qgetRollCallGrapghFromYear" datasource="#variables.dsn#">
    	SELECT
              DOLPHIN_SIGHTINGS.Sighting_ID,
              PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
		CASE
			WHEN MONTH (PROJECTS.[Date]) IN (1,2,3) THEN  1
			WHEN MONTH (PROJECTS.[Date]) IN (4,5,6) THEN 2
			WHEN MONTH (PROJECTS.[Date]) IN (7,8,9) THEN 3
			WHEN MONTH (PROJECTS.[Date]) IN (10,11,12) THEN 4
		END AS count
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) =  #FORM.fromYear#
        AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
    </cfquery>
    <cfloop query="qgetRollCallGrapghFromYear" >
      
   
	   <!---<cfset count =  0>
       <cfquery name="q1" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghFromYear where Dolphin_ID = #qgetRollCallGrapghFromYear.Dolphin_ID# AND SurveryMONTH IN (1,2,3)
            
       </cfquery>

       <cfif q1.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       

       <cfquery name="q2" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghFromYear where Dolphin_ID = #qgetRollCallGrapghFromYear.Dolphin_ID# AND SurveryMONTH IN (4,5,6)
       </cfquery>
       
       <cfif q2.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>

       <cfquery name="q3" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghFromYear where Dolphin_ID = #qgetRollCallGrapghFromYear.Dolphin_ID# AND SurveryMONTH IN (7,8,9)
       </cfquery>
       
       <cfif q3.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       
       
       <cfquery name="q4" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghFromYear where Dolphin_ID = #qgetRollCallGrapghFromYear.Dolphin_ID# AND SurveryMONTH IN (10,11,12)
       </cfquery>
       
       <cfif q4.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>---> 

       <cfif FORM.label EQ 'Transients'>
		   <cfif qgetRollCallGrapghFromYear.count EQ 1>
                <cfset tr = StructNew() >
                <cfset tr['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
                <cfset tr['Name'] = qgetRollCallGrapghFromYear.Name >
                <cfset tr['Code'] = qgetRollCallGrapghFromYear.Code >
                <cfset tr['Sex'] = qgetRollCallGrapghFromYear.Sex >
                <cfset tr['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
                <cfset tr['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
                <cfset ArrayAppend(Array_fromYear,tr)>
            </cfif>
       </cfif>
       <cfif FORM.label EQ 'Seasonal'>
		   <cfif qgetRollCallGrapghFromYear.count EQ 3 OR qgetRollCallGrapghFromYear.count EQ 2>
                <cfset tt = StructNew() >
                <cfset tt['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
                <cfset tt['Name'] = qgetRollCallGrapghFromYear.Name >
                <cfset tt['Code'] = qgetRollCallGrapghFromYear.Code >
                <cfset tt['Sex'] = qgetRollCallGrapghFromYear.Sex >
                <cfset tt['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
                <cfset tt['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
                <cfset ArrayAppend(Array_fromYear,tt)>
           </cfif>
       </cfif>
	   <cfif FORM.label EQ 'Resident'>
		   <cfif qgetRollCallGrapghFromYear.count  EQ 4>
                <cfset rr = StructNew() >
                <cfset rr['ID'] = qgetRollCallGrapghFromYear.Dolphin_ID >
                <cfset rr['Name'] = qgetRollCallGrapghFromYear.Name >
                <cfset rr['Code'] = qgetRollCallGrapghFromYear.Code >
                <cfset rr['Sex'] = qgetRollCallGrapghFromYear.Sex >
                <cfset rr['Sighting_ID'] = qgetRollCallGrapghFromYear.Sighting_ID >
                <cfset rr['pro_id'] = qgetRollCallGrapghFromYear.pro_id >
                <cfset ArrayAppend(Array_fromYear,rr)>    
           </cfif>
       </cfif>
    </cfloop>
	<cfif ArrayLen(Array_fromYear) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(Array_fromYear)#" index="i">
            	<cfset responce &= '<tr>
                	<td width="80">#i#</td>
                   <td width="100">#Array_fromYear[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#Array_fromYear[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#Array_fromYear[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#Array_fromYear[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#Array_fromYear[i].name#</td>
                   <td width="50">#Array_fromYear[i].sex#</td>
                </tr>'>  
            </cfloop>
            </cfif>    
        <cfset responce &= '</table>'>
        <cfoutput>#responce#</cfoutput>
</cffunction>


<cffunction name="getRollCallPieGraphSliceDataToYear" returntype="any" access="remote">
	<!---<cfset qgetRollCallGrapghEndYear = Application.Reporting.getRollCallGrapghEndYear(argumentCollection="#Form#")>--->
    <cfset Array_toYear = ArrayNew(1)>
    <cfset responce = '    <table  class="table table-striped table-bordered" >
                <tr>
                <td width="80"><b>ID</b></td>
                <td width="100"><b>Code</b></td>
                <td width="120"><b>Sighting ID</b></td>
                <td width="250"><b>Name</b></td>
                <td width="50"><b>Sex</b></td>
            </tr>
         </table>
         <div class="datacontainer"> 
         <table class="table table-striped table-bordered">'>
    <cfquery name="qgetRollCallGrapghEndYear" datasource="#variables.dsn#">
    	SELECT
              DOLPHIN_SIGHTINGS.Sighting_ID,
              PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
		CASE
			WHEN MONTH (PROJECTS.[Date]) IN (1,2,3) THEN  1
			WHEN MONTH (PROJECTS.[Date]) IN (4,5,6) THEN 2
			WHEN MONTH (PROJECTS.[Date]) IN (7,8,9) THEN 3
			WHEN MONTH (PROJECTS.[Date]) IN (10,11,12) THEN 4
		END AS count
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) =  #FORM.toYear#
        AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
    </cfquery>
    <cfloop query="qgetRollCallGrapghEndYear" >
      
   
	   <!---<cfset count =  0>
       <cfquery name="q1" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghEndYear where Dolphin_ID = #qgetRollCallGrapghEndYear.Dolphin_ID# AND SurveryMONTH IN (1,2,3)
            
       </cfquery>

       <cfif q1.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       

       <cfquery name="q2" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghEndYear where Dolphin_ID = #qgetRollCallGrapghEndYear.Dolphin_ID# AND SurveryMONTH IN (4,5,6)
       </cfquery>
       
       <cfif q2.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>

       <cfquery name="q3" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghEndYear where Dolphin_ID = #qgetRollCallGrapghEndYear.Dolphin_ID# AND SurveryMONTH IN (7,8,9)
       </cfquery>
       
       <cfif q3.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>
       
       
       <cfquery name="q4" dbtype="query" >
            SELECT Dolphin_ID  from qgetRollCallGrapghEndYear where Dolphin_ID = #qgetRollCallGrapghEndYear.Dolphin_ID# AND SurveryMONTH IN (10,11,12)
       </cfquery>
       
       <cfif q4.recordcount NEQ 0 >
       		<cfset count = count + 1>
       <cfelse>
       		<cfset count = count >     
       </cfif>---> 

       <cfif FORM.label EQ 'Transients'>
		   <cfif qgetRollCallGrapghEndYear.count EQ 1>
                <cfset tr = StructNew() >
                <cfset tr['ID'] = qgetRollCallGrapghEndYear.Dolphin_ID >
                <cfset tr['Name'] = qgetRollCallGrapghEndYear.Name >
                <cfset tr['Code'] = qgetRollCallGrapghEndYear.Code >
                <cfset tr['Sex'] = qgetRollCallGrapghEndYear.Sex >
                <cfset tr['Sighting_ID'] = qgetRollCallGrapghEndYear.Sighting_ID >
                <cfset tr['pro_id'] = qgetRollCallGrapghEndYear.pro_id >
                <cfset ArrayAppend(Array_toYear,tr)>
            </cfif>
       </cfif>
       <cfif FORM.label EQ 'Seasonal'>
		   <cfif qgetRollCallGrapghEndYear.count EQ 3 OR qgetRollCallGrapghEndYear.count EQ 2>
                <cfset tt = StructNew() >
                <cfset tt['ID'] = qgetRollCallGrapghEndYear.Dolphin_ID >
                <cfset tt['Name'] = qgetRollCallGrapghEndYear.Name >
                <cfset tt['Code'] = qgetRollCallGrapghEndYear.Code >
                <cfset tt['Sex'] = qgetRollCallGrapghEndYear.Sex >
                <cfset tt['Sighting_ID'] = qgetRollCallGrapghEndYear.Sighting_ID >
                <cfset tt['pro_id'] = qgetRollCallGrapghEndYear.pro_id >
                <cfset ArrayAppend(Array_toYear,tt)>
           </cfif>
       </cfif>
	   <cfif FORM.label EQ 'Resident'>
		   <cfif qgetRollCallGrapghEndYear.count  EQ 4>
                <cfset rr = StructNew() >
                <cfset rr['ID'] = qgetRollCallGrapghEndYear.Dolphin_ID >
                <cfset rr['Name'] = qgetRollCallGrapghEndYear.Name >
                <cfset rr['Code'] = qgetRollCallGrapghEndYear.Code >
                <cfset rr['Sex'] = qgetRollCallGrapghEndYear.Sex >
                <cfset rr['Sighting_ID'] = qgetRollCallGrapghEndYear.Sighting_ID >
                <cfset rr['pro_id'] = qgetRollCallGrapghEndYear.pro_id >
                <cfset ArrayAppend(Array_toYear,rr)>    
           </cfif>
       </cfif>
    </cfloop>
	<cfif ArrayLen(Array_toYear) NEQ 0 >
            	<cfloop from="1" to="#ArrayLen(Array_toYear)#" index="i">
            	<cfset responce &= '<tr>
                	<td width="80">#i#</td>
                   <td width="100">#Array_toYear[i].code#</td>
                  <td width="120">
                                    <form action="#Application.siteroot#?Module=Sighting&Page=Home" method="post" id="sighting_detail" target="_blank">
                                       <input type="hidden" name="project_id" value="#Array_toYear[i].pro_id#">
                                        <input type="hidden" name="sight_id" value="#Array_toYear[i].Sighting_ID#">
                                        <a href="javascript:void(0)" class="sighting-detail">#Array_toYear[i].Sighting_ID#</a>
                                     </form>
                                    </td>
                    <td width="250">#Array_toYear[i].name#</td>
                   <td width="50">#Array_toYear[i].sex#</td>
                </tr>'>  
            </cfloop>
            </cfif>    
        <cfset responce &= '</table>'>
        <cfoutput>#responce#</cfoutput>
</cffunction>

<cffunction name="getRollExcel" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
        DOLPHIN_SIGHTINGS.Sighting_ID
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# AND PROJECTS.Type = 'Census' AND PROJECTS.SurveyArea <> 'Atlantic Ocean'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
       </cfquery>
  <cfreturn  query>
</cffunction>

<!---<cffunction name="getRollCall" returntype="any" output="false" access="public" >
 <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
        DOLPHIN_SIGHTINGS.Sighting_ID,
        Dolphin_DScore.DScore
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        INNER JOIN Dolphin_DScore ON Dolphin_DScore.DScoreDate = PROJECTS.[Date]
        WHERE
        YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear#
        AND DOLPHINS.Code NOT LIKE 'UNK%'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        Dolphin_DScore.DScore
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
       </cfquery>
     <cfreturn  query>
</cffunction>--->

<cffunction name="getbestplace" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
    SELECT
    YEAR (PROJECTS.[Date]) AS SurveryYear,
    MONTH (PROJECTS.[Date]) AS SurveryMONTH,
    DOLPHIN_SIGHTINGS.Dolphin_ID,
    COUNT (
    DOLPHIN_SIGHTINGS.Dolphin_ID
    ) AS SEEN_TIMES,
    DOLPHINS.Name,
    DOLPHINS.Code,
    DOLPHINS.Sex,
    DOLPHINS.DScore,
    DOLPHINS.YearOfBirth,
    YEAR (
    DOLPHINS.[Date of Death]
    ) AS DeathYear,
    DOLPHINS.[Dead?] AS IsDead,
    TLU_Zones.ZSEGMENT
    FROM
    PROJECTS
    INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
    INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
    INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
    INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID
    WHERE
    YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear#
    AND DOLPHINS.Code NOT LIKE 'UNK%'
    GROUP BY
    DOLPHIN_SIGHTINGS.Dolphin_ID,
    YEAR (PROJECTS.[Date]),
    MONTH (PROJECTS.[Date]),
    DOLPHINS.Name,
    DOLPHINS.Code,
    DOLPHINS.Sex,
    DOLPHINS.DScore,
    DOLPHINS.YearOfBirth,
    DOLPHINS.[Date of Death],
    DOLPHINS.[Dead?],
    TLU_Zones.ZSEGMENT

    ORDER BY
    SurveryYear ASC,
    SurveryMONTH ASC

       </cfquery>
  <cfreturn  query>
</cffunction>
<!--- Dead Dolphins by Year --->
<cffunction name="DeadDolphins" access="public" returntype="any" output="false">
  <cfargument name="appendyear" type="any" required="true" default="">
  <cfargument name="code" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	<cfif code eq 0>
    SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#appendyear#">
   </cfif>
   <cfif code neq 0>
   <cfif code eq 'UNK'>
    SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#appendyear#">
    AND Code LIKE 'UNK%'
    </cfif>
    <cfif code eq 'NK'>
     SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#appendyear#">
    AND Code NOT LIKE 'UNK%'
    </cfif>
    <cfif code eq 'BOTH'>
      SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where YEAR (DOLPHINS.[Date of Death]) =  <cfqueryparam cfsqltype="cf_sql_integer" value="#appendyear#">
    </cfif>
     </cfif>
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Dead dolphins by month --->
<cffunction name="DeadDolphinsByMonth" access="public" returntype="any" output="false">
  <cfargument name="monthly" type="any" required="true" default="">
  <cfargument name="filterMonthlyYear" type="any" required="true" default="">
  <cfargument name="byMonthCode" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
<cfif byMonthCode eq 0>
SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where MONTH (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#monthly#">
    AND YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#filterMonthlyYear#">
   </cfif>
   <cfif byMonthCode neq 0>
   <cfif byMonthCode eq 'UNK'>
   SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where MONTH (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#monthly#">
    AND YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#filterMonthlyYear#">
    AND Code LIKE 'UNK%'
   </cfif>
   <cfif byMonthCode eq 'NK'>
    SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where MONTH (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#monthly#">
    AND YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#filterMonthlyYear#">
    AND Code NOT LIKE 'UNK%'
   </cfif>
   <cfif byMonthCode eq 'BOTH'>
    SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where MONTH (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#monthly#">
    AND YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#filterMonthlyYear#">

   </cfif>
   </cfif>
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Freez Brand Recovered --->
<cffunction name="freezbrandRecovered" access="public" returntype="any" output="false">
  <cfquery name="getRec" datasource="#variables.dsn#">

<cfif all eq 1>
    SELECT
	dbo.DOLPHINS.FB_No,
	dbo.DOLPHINS.FB_On_Date
	FROM
	dbo.DOLPHINS Where dbo.DOLPHINS.FB_No != ''
    AND ISNUMERIC(dbo.DOLPHINS.YearOfBirth) = 1
    AND (YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth)) = '#freezDate#'
 </cfif>
 <cfif all eq 0>
<cfif cName eq 'UNK'>
	SELECT
	dbo.DOLPHINS.FB_No,
	dbo.DOLPHINS.FB_On_Date
	FROM
	dbo.DOLPHINS Where dbo.DOLPHINS.FB_No != ''
	AND ISNUMERIC(dbo.DOLPHINS.YearOfBirth) = 1 AND (YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth)) = <cfqueryparam cfsqltype="cf_sql_integer" value="#SearchingAge#">
	AND Code LIKE 'UNK%'
    </cfif>
 <cfif cName eq 'NK'>
 SELECT
	dbo.DOLPHINS.FB_No,
	dbo.DOLPHINS.FB_On_Date
	FROM
	dbo.DOLPHINS Where dbo.DOLPHINS.FB_No != ''
 	AND ISNUMERIC(dbo.DOLPHINS.YearOfBirth) = 1 AND (YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth)) = <cfqueryparam cfsqltype="cf_sql_integer" value="#SearchingAge#">
	AND Code NOT LIKE 'UNK%'
 </cfif>
 <cfif cName eq 'BOTH'>
 SELECT
	dbo.DOLPHINS.FB_No,
	dbo.DOLPHINS.FB_On_Date
	FROM
	dbo.DOLPHINS Where dbo.DOLPHINS.FB_No != ''
 	AND ISNUMERIC(dbo.DOLPHINS.YearOfBirth) = 1 AND (YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth)) = <cfqueryparam cfsqltype="cf_sql_integer" value="#SearchingAge#">
 </cfif>
</cfif>



</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Hear Dolphins Age and Sex --->
<cffunction name="AgeSexHera" access="public" returntype="any" output="false">
  <cfargument name="HearYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
select [DOLPHINS].*, [DOLPHINS].[Date of Death] AS DOD from [DOLPHINS]
join [DOLPHIN_SIGHTINGS] ON [DOLPHINS].id = [DOLPHIN_SIGHTINGS].dolphin_id
join [SIGHTINGS] ON [DOLPHIN_SIGHTINGS].sighting_id = [SIGHTINGS].id
join [PROJECTS] ON [SIGHTINGS].project_id = [PROJECTS].ID AND year([PROJECTS].[date]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#HearYear#">
Where [DOLPHINS].[Source Sexed] = 'HERA'
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Hera Captured Multiple Times  --->
<cffunction name="HeraCapturedMultipleTimes" access="public" returntype="any" output="false">
  <cfargument name="HearYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
select [DOLPHINS].ID from [DOLPHINS]
join [DOLPHIN_SIGHTINGS] ON [DOLPHINS].id = [DOLPHIN_SIGHTINGS].dolphin_id
join [SIGHTINGS] ON [DOLPHIN_SIGHTINGS].sighting_id = [SIGHTINGS].id
join [PROJECTS] ON [SIGHTINGS].project_id = [PROJECTS].ID AND year([PROJECTS].[date]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#HearYear#">
Where [DOLPHINS].[Source Sexed] = 'HERA'
Group By [DOLPHINS].ID HAVING(COUNT([DOLPHINS].ID)>1)
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Dolphins Capture Same Day/Year --->
<cffunction name="captureSameDayYear" access="public" returntype="any" output="false">
  <cfargument name="HearYear" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
select [DOLPHINS].ID, [PROJECTS].[date] from [DOLPHINS]
join [DOLPHIN_SIGHTINGS] ON [DOLPHINS].id = [DOLPHIN_SIGHTINGS].dolphin_id
join [SIGHTINGS] ON [DOLPHIN_SIGHTINGS].sighting_id = [SIGHTINGS].id
join [PROJECTS] ON [SIGHTINGS].project_id = [PROJECTS].ID AND year([PROJECTS].[date]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#HearYear#">
Where [DOLPHINS].[Source Sexed] = 'HERA'
Group By [PROJECTS].[date], [DOLPHINS].[ID] HAVING (COUNT(year([PROJECTS].[date]))>1) AND (COUNT([DOLPHINS].[ID])>1)
Order By [DOLPHINS].[ID]
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Hera Dolphins By Segment --->
<cffunction name="HeraDolphinsBySegment" returntype="any" output="false" access="public" >
  <cfargument name="HearYear" type="any" required="true" default="">
  <cfset arr = ArrayNew(1)>
  <cfset arr[1] =0>
  <cfset arr[2] =0>
  <cfset arr[3] =0>
  <cfset arr[4] =0>
  <cfset arr[5] =0>
  <cfset arr[6] =0>
  <cfset arr[7] =0>
  <cfset arr[8] =0>
  <cfquery name="qBestPlace" datasource="#variables.dsn#" >
         SELECT
        DOLPHINS.Code as Dolphin_ID, DOLPHINS.[Source Sexed] AS SS,
        TLU_Zones.ZSEGMENT as segment, Count(DOLPHINS.Code) AS SegCount
        FROM
        PROJECTS INNER JOIN
        (TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
        ON
        DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
        ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
        ON TLU_Zones.ID = SIGHTINGS.Zone_id)
        ON PROJECTS.ID = SIGHTINGS.Project_ID
        WHERE YEAR (PROJECTS.[Date]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#HearYear#"> AND DOLPHINS.[Source Sexed] = 'HERA'
        GROUP BY DOLPHINS.Code, DOLPHINS.[Source Sexed], TLU_Zones.ZSEGMENT
        HAVING (((DOLPHINS.Code) Is Not Null) AND ((TLU_Zones.ZSEGMENT) Is Not Null))
        ORDER BY DOLPHINS.Code
	</cfquery>
  <cfquery name="qSegment1" dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where  segment = '1'
		</cfquery>
  <cfquery name="qSegment1A" dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '1A'
		</cfquery>
  <cfquery name="qSegment2"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '2'
		</cfquery>
  <cfquery name="qSegment2A"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '2A'
		</cfquery>
  <cfquery name="qSegment3"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '3'
		</cfquery>
  <cfquery name="qSegment3A"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '3A'
		</cfquery>
  <cfquery name="qSegment4"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '4'
		</cfquery>
  <cfquery name="qSegment4A"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '4A'
		</cfquery>
  <cfset arr[1] = arr[1] + qSegment1.recordcount>
  <cfset arr[2] =arr[2] + qSegment1A.recordcount>
  <cfset arr[3] =arr[3] + qSegment2.recordcount>
  <cfset arr[4] =arr[4] + qSegment2A.recordcount>
  <cfset arr[5] =arr[5] + qSegment3.recordcount>
  <cfset arr[6] =arr[6] + qSegment3A.recordcount>
  <cfset arr[7] =arr[7] + qSegment4.recordcount>
  <cfset arr[8] =arr[8] + qSegment4A.recordcount>

  <!---<cfoutput>#SerializeJSON(arr)#</cfoutput>--->

  <cfreturn  SerializeJSON(arr)>
</cffunction>
<!--- Age Sex Cohort --->
<cffunction name="AgeSexCohort" access="public" returntype="any" output="false">
  <cfargument name="cohortSex" type="any" required="true" default="">
  <cfargument name="SearchingAge" type="any" required="true" default="">
  <cfargument name="cohortName" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
<cfif cohortName eq 'BOTH'>
SELECT
dbo.DOLPHINS.Sex,
dbo.DOLPHINS.ID,
dbo.DOLPHINS.[Dead?],
YEAR (dbo.DOLPHINS.[Date of Death]) As Age1,
(dbo.DOLPHINS.YearOfBirth) As Age2,
YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth) As AgeTotal
FROM
dbo.DOLPHINS
Where dbo.DOLPHINS.[Dead?] = 1 AND dbo.DOLPHINS.Sex = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cohortSex#"> AND ISNUMERIC(dbo.DOLPHINS.YearOfBirth) = 1 AND (YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth)) = <cfqueryparam cfsqltype="cf_sql_integer" value="#SearchingAge#">
<cfelseif cohortName eq 'UNK'>
SELECT
dbo.DOLPHINS.Sex,
dbo.DOLPHINS.ID,
dbo.DOLPHINS.[Dead?],
YEAR (dbo.DOLPHINS.[Date of Death]) As Age1,
(dbo.DOLPHINS.YearOfBirth) As Age2,
YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth) As AgeTotal
FROM
dbo.DOLPHINS
Where dbo.DOLPHINS.[Dead?] = 1 AND dbo.DOLPHINS.Sex = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cohortSex#"> AND ISNUMERIC(dbo.DOLPHINS.YearOfBirth) = 1 AND (YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth)) = <cfqueryparam cfsqltype="cf_sql_integer" value="#SearchingAge#">
 AND Code LIKE 'UNK%'
 <cfelseif cohortName eq 'NK'>
 SELECT
dbo.DOLPHINS.Sex,
dbo.DOLPHINS.ID,
dbo.DOLPHINS.[Dead?],
YEAR (dbo.DOLPHINS.[Date of Death]) As Age1,
(dbo.DOLPHINS.YearOfBirth) As Age2,
YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth) As AgeTotal
FROM
dbo.DOLPHINS
Where dbo.DOLPHINS.[Dead?] = 1 AND dbo.DOLPHINS.Sex = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cohortSex#"> AND ISNUMERIC(dbo.DOLPHINS.YearOfBirth) = 1 AND (YEAR (dbo.DOLPHINS.[Date of Death]) - (dbo.DOLPHINS.YearOfBirth)) = <cfqueryparam cfsqltype="cf_sql_integer" value="#SearchingAge#">
 AND Code NOT NOT LIKE 'UNK%'
 </cfif>

</cfquery>
  <cfreturn getRec/>
</cffunction>
<!---Best Place to live Report--->

<cffunction name="getBestPlaceMain" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
            SELECT
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
		DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE
        YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear#
        AND DOLPHINS.Code NOT LIKE 'UNK%'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]

        HAVING COUNT (
		DOLPHIN_SIGHTINGS.Dolphin_ID
		) >= #form.seentimes#

        ORDER BY
        DOLPHIN_SIGHTINGS.Dolphin_ID ASC
    </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="getBestPlaceSub" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
               SELECT
        PROJECTS.ID AS pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        Count(DOLPHIN_SIGHTINGS.Dolphin_ID) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
        DOLPHIN_SIGHTINGS.Sighting_ID,
        DOLPHIN_SIGHTINGS.Xeno,
        DOLPHIN_SIGHTINGS.REM,
        DOLPHIN_SIGHTINGS.Fetals,
        DOLPHIN_SIGHTINGS.BC,
        DOLPHIN_SIGHTINGS.RDS,
        DOLPHIN_SIGHTINGS.BodyCondition,
        DOLPHIN_SIGHTINGS.Freshwound

        FROM
                PROJECTS
                INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
                INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
                YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear#
                 AND  DOLPHINS.Code = '#code#'
        GROUP BY
                DOLPHIN_SIGHTINGS.Dolphin_ID,
                YEAR (PROJECTS.[Date]),
                MONTH (PROJECTS.[Date]),
                DOLPHINS.Name,
                DOLPHINS.Code,
                DOLPHINS.Sex,
                DOLPHINS.DScore,
                DOLPHINS.YearOfBirth,
                DOLPHINS.[Date of Death],
                DOLPHINS.[Dead?],
                DOLPHIN_SIGHTINGS.Sighting_ID,
                PROJECTS.ID,
        DOLPHIN_SIGHTINGS.Xeno,
        DOLPHIN_SIGHTINGS.REM,
        DOLPHIN_SIGHTINGS.Fetals,
        DOLPHIN_SIGHTINGS.BC,
        DOLPHIN_SIGHTINGS.RDS,
        DOLPHIN_SIGHTINGS.BodyCondition,
        DOLPHIN_SIGHTINGS.Freshwound
        ORDER BY
                SurveryYear ASC,
                SurveryMONTH ASC

       </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="getBestPlaceGrapgh" returntype="any" output="false" access="public" >
  <cfset arr = ArrayNew(1)>
  <cfset arr[1] =0>
  <cfset arr[2] =0>
  <cfset arr[3] =0>
  <cfset arr[4] =0>
  <cfset arr[5] =0>
  <cfset arr[6] =0>
  <!---<cfset arr[7] =0>
  <cfset arr[8] =0>--->
  <cfquery name="qBestPlace" datasource="#variables.dsn#" >
         SELECT
        DOLPHINS.Code as Dolphin_ID,
        TLU_Zones.ZSEGMENT as segment, Count(DOLPHINS.Code) AS SegCount
        FROM
        PROJECTS INNER JOIN
        (TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
        ON
        DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
        ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
        ON TLU_Zones.ID = SIGHTINGS.Zone_id)
        ON PROJECTS.ID = SIGHTINGS.Project_ID
        WHERE YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear#
        GROUP BY DOLPHINS.Code, TLU_Zones.ZSEGMENT
        HAVING (((DOLPHINS.Code) Is Not Null) AND ((TLU_Zones.ZSEGMENT) Is Not Null))
        ORDER BY DOLPHINS.Code
	</cfquery>
    <!---<cfquery name="qSegment1" dbtype="query">
        SELECT Dolphin_ID from qBestPlace where  segment = '1'
    </cfquery>--->
    <cfquery name="qSegment1A" dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '1A'
    </cfquery>
    <cfquery name="qSegment1B" dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '1B'
    </cfquery>
    <cfquery name="qSegment1C" dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '1C'
    </cfquery>
    <cfquery name="qSegment2"  dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '2'
    </cfquery>
    <!---<cfquery name="qSegment2A"  dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '2A'
    </cfquery>--->
    <cfquery name="qSegment3"  dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '3'
    </cfquery>
    <!---<cfquery name="qSegment3A"  dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '3A'
    </cfquery>--->
    <cfquery name="qSegment4"  dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '4'
    </cfquery>
    <!---<cfquery name="qSegment4A"  dbtype="query">
        SELECT Dolphin_ID from qBestPlace where segment = '4A'
    </cfquery>--->
  <!---<cfset arr[1] = arr[1] + qSegment1.recordcount>--->
  <cfset arr[1] =arr[1] + qSegment1A.recordcount>
  <cfset arr[2] =arr[2] + qSegment1B.recordcount>
  <cfset arr[3] =arr[3] + qSegment1C.recordcount>
  <cfset arr[4] =arr[4] + qSegment2.recordcount>
  <!---<cfset arr[4] =arr[4] + qSegment2A.recordcount>--->
  <cfset arr[5] =arr[5] + qSegment3.recordcount>
  <!---<cfset arr[6] =arr[6] + qSegment3A.recordcount>--->
  <cfset arr[6] =arr[6] + qSegment4.recordcount>
  <!---<cfset arr[8] =arr[8] + qSegment4A.recordcount>--->

  <!---<cfoutput>#SerializeJSON(arr)#</cfoutput>--->

  <cfreturn  SerializeJSON(arr)>
</cffunction>
<cffunction name="getBodyConditionGrapgh" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
SELECT
	PROJECTS.ID AS pro_id,
	YEAR (PROJECTS.[Date]) AS SurveryYear,
	MONTH (PROJECTS.[Date]) AS SurveryMONTH,
	DOLPHIN_SIGHTINGS.Dolphin_ID,
	DOLPHIN_SIGHTINGS.Sighting_ID,
	DOLPHIN_SIGHTINGS.Xeno,
	DOLPHIN_SIGHTINGS.REM,
	DOLPHIN_SIGHTINGS.Fetals,
	DOLPHIN_SIGHTINGS.BC,
	DOLPHIN_SIGHTINGS.RDS,
	DOLPHIN_SIGHTINGS.Freshwound,
dbo.DOLPHINS.Name,
dbo.DOLPHINS.Code,
dbo.DOLPHINS.Sex
FROM
	PROJECTS
INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
WHERE
	YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear#
AND (
	DOLPHIN_SIGHTINGS.Xeno = 1
	OR DOLPHIN_SIGHTINGS.REM = 1
	OR DOLPHIN_SIGHTINGS.Fetals = 1
	OR DOLPHIN_SIGHTINGS.BC = 1
	OR DOLPHIN_SIGHTINGS.RDS = 1
	OR DOLPHIN_SIGHTINGS.Freshwound = 1
)

</cfquery>
  <cfreturn query>
</cffunction>
    <cffunction name="getBiopsyHitdetails" returntype="any" output="true" access="remote">
        <cfdump var=#form#>
        <cfabort>
        <cfquery name="query" datasource="#variables.dsn#" >



        </cfquery>
    </cffunction>
<!--- Get Stock Main Data --->
<cffunction name="TotalStock" access="public" returntype="any" output="false">
  <cfquery name="getRec" datasource="#variables.dsn#">
		Select * from TLU_Stock
	</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Get Total Sightning and Dolphins --->
<cffunction name="TotalDolphinsAndSightings" access="public" returntype="any" output="false">
  <cfargument name="Date_from" type="any" required="true" default="">
  <cfargument name="Date_to" type="any" required="true" default="">
  <cfargument name="stockSelected" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	Select PROJECTS.[Date] as O_Date, PROJECTS.[Stock], SIGHTINGS.ID, SIGHTINGS.FE_TotalDolphin_Best, SIGHTINGS.FE_TotalCalves_Best, SIGHTINGS.FE_YoungOfYear_Best,
    SIGHTINGS.Photo_TotalDolphins_FinalBest, SIGHTINGS.Photo_TotalCalves_FinalBest, SIGHTINGS.Photo_YoungOfYear_FinalBest, SIGHTINGS.SightingNumber
    FROM PROJECTS INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID <cfif Date_from neq '' and Date_to neq ''>where PROJECTS.[Date] >=
    <cfqueryparam cfsqltype="cf_sql_date" value="#Date_from#"> AND PROJECTS.[Date] <= <cfqueryparam cfsqltype="cf_sql_date" value="#Date_to#">
    </cfif><cfif Date_from neq '' and Date_to neq '' and stockSelected neq 0>AND PROJECTS.[Stock] = <cfqueryparam cfsqltype="cf_sql_varchar" value=
    "#stockSelected#"><cfelseif stockSelected neq 0>where PROJECTS.[Stock] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stockSelected#"></cfif>
    Order By PROJECTS.[Date] desc
</cfquery>
  <cfreturn getRec/>
</cffunction>
<!--- Get Total Dophins --->
<cffunction name="TotalDolphins" access="public" returntype="any" output="false">
  <cfargument name="Date_from" type="any" required="true" default="">
  <cfargument name="Date_to" type="any" required="true" default="">
  <cfargument name="stockSelected" type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	SELECT DOLPHIN_SIGHTINGS.Sighting_ID, DOLPHIN_SIGHTINGS.Dolphin_ID, PROJECTS.[Date], PROJECTS.ID, PROJECTS.Stock FROM PROJECTS INNER JOIN
    SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
	<cfif Date_from neq '' and Date_to neq ''>where PROJECTS.[Date] >= <cfqueryparam cfsqltype="cf_sql_date" value="#Date_from#">
    AND PROJECTS.[Date] <= <cfqueryparam cfsqltype="cf_sql_date" value="#Date_to#"></cfif>
	<cfif Date_from neq '' and Date_to neq '' and stockSelected neq 0>AND PROJECTS.[Stock] =
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#stockSelected#"><cfelseif stockSelected neq 0>
    where PROJECTS.[Stock] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stockSelected#"></cfif>
</cfquery>
  <cfreturn getRec/>
</cffunction>

<!---Current ZONE REPORT START--->

<cffunction name="CurrentMonthZones" access="public" returntype="any" output="false">
  <cfset arr = []>
  <cfset ss = StructNew() >

  <!---ML ZONES START--->
  <cfquery name="getML_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM  dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] LIKE 'ML%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] ASC
</cfquery>
  <cfquery name="getML_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] LIKE 'ML%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
  <cfset ML_start = Replace(getML_Start.ZONE , "ML" ,"", "All")>
  <cfset ML_end = Replace(getML_End.ZONE , "ML" , "" ,"All")>
  <cfset ML_diff = Val(ML_end) - Val(ML_start)+1 >
  <cfset ss['ML_start'] = Val(ML_start) >
  <cfset ss['ML_end'] = Val(ML_end) >
  <cfset ss['ML_bar'] = Val(ML_diff) >
  <cfif ML_diff GT 0>
    <cfset ss['ML_start_space'] = Val(ML_start) -1 >
    <cfset ss['ML_end_space'] = 45 - Val(ML_end) >
  </cfif>
  <cfif ML_diff LTE 0>
    <cfset ss['ML_full_space'] = VAl('45') >
  </cfif>

  <!---ML ZONES END--->

  <!---BR ZONES START--->
  <cfquery name="getML_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] LIKE 'BR%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] ASC
</cfquery>
  <cfquery name="getML_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] LIKE 'BR%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
  <cfset BR_start = Replace(getML_Start.ZONE , "BR" ,"", "All")>
  <cfset BR_end = Replace(getML_End.ZONE , "BR" , "" ,"All")>
  <cfset BR_diff = Val(BR_end) - Val(BR_start)+1 >
  <cfset ss['BR_start'] = Val(BR_start) >
  <cfset ss['BR_end'] = Val(BR_end) >
  <cfset ss['BR_bar'] = Val(BR_diff) >
  <cfif  BR_diff GT 0>
    <cfset ss['BR_start_space'] = Val(BR_start) - 55 >
    <cfset ss['BR_end_space'] = 103 - Val(BR_end) >
  </cfif>
  <cfif BR_diff LTE 0>
    <cfset ss['BR_full_space'] = VAl('31') >
  </cfif>
  <!---BR ZONES END--->

  <!---IR NorthIndianRiver Start--->
  <cfquery name="getIR_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] BETWEEN 'IR033' AND 'IR104'
    ORDER BY
        dbo.TLU_Zones.[ZONE] ASC
</cfquery>
  <cfquery name="getIR_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] BETWEEN 'IR033' AND 'IR104'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
  <cfset IR_NorthIndianRiver_start = Replace(getIR_Start.ZONE , "IR" ,"", "All")>
  <cfset IR_NorthIndianRiver_end = Replace(getIR_End.ZONE , "IR" , "" ,"All")>
  <cfset IR_NorthIndianRiver_diff = Val(IR_NorthIndianRiver_end) - Val(IR_NorthIndianRiver_start) >
  <cfset ss['IR_NorthIndianRiver_start'] = Val(IR_NorthIndianRiver_start) >
  <cfset ss['IR_NorthIndianRiver_end'] = Val(IR_NorthIndianRiver_end) >
  <cfset ss['IR_NorthIndianRiver_bar'] = Val(IR_NorthIndianRiver_diff) >
  <cfif IR_NorthIndianRiver_diff GT 0>
    <cfset ss['IR_NorthIndianRiver_start_space'] = Val(IR_NorthIndianRiver_start) - 33  >
    <cfset ss['IR_NorthIndianRiver_end_space'] = 104 - Val(IR_NorthIndianRiver_end) >
  </cfif>
  <cfif IR_NorthIndianRiver_diff LTE 0>
    <cfset ss['IR_NorthIndianRiver_full_space'] = VAl('71') >
  </cfif>
  <!---IR NorthIndianRiver END--->

  <!---IR NorthCentralIndianRiver Start--->
  <cfquery name="getIR_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] BETWEEN 'IR105' AND 'IR135'
    ORDER BY dbo.TLU_Zones.[ZONE] ASC
</cfquery>
  <cfquery name="getIR_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] BETWEEN 'IR105' AND 'IR135'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
  <cfset IR_NorthCentralIndianRiver_start = Replace(getIR_Start.ZONE , "IR" ,"", "All")>
  <cfset IR_NorthCentralIndianRiver_end = Replace(getIR_End.ZONE , "IR" , "" ,"All")>
  <cfset IR_NorthCentralIndianRiver_diff = Val(IR_NorthCentralIndianRiver_end) - Val(IR_NorthCentralIndianRiver_start) >
  <cfset ss['IR_NorthCentralIndianRiver_start'] = Val(IR_NorthCentralIndianRiver_start) >
  <cfset ss['IR_NorthCentralIndianRiver_end'] = Val(IR_NorthCentralIndianRiver_end) >
  <cfset ss['IR_NorthCentralIndianRiver_bar'] = Val(IR_NorthCentralIndianRiver_diff) >
  <cfif IR_NorthCentralIndianRiver_diff GT 0>
    <cfset ss['IR_NorthCentralIndianRiver_start_space'] = Val(IR_NorthCentralIndianRiver_start) - 105 >
    <cfset ss['IR_NorthCentralIndianRiver_end_space'] = 135 - Val(IR_NorthCentralIndianRiver_end) >
  </cfif>
  <cfif IR_NorthCentralIndianRiver_diff LTE 0>
    <cfset ss['IR_NorthCentralIndianRiver_full_space'] = VAl('30') >
  </cfif>

  <!---IR NorthCentralIndianRiver END--->

  <!---IR SouthCentralIndianRiver Start--->
  <cfquery name="getIR_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] BETWEEN 'IR136' AND 'IR168'
    ORDER BY
        dbo.TLU_Zones.[ZONE] ASC
</cfquery>
  <cfquery name="getIR_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] BETWEEN 'IR136' AND 'IR168'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
  <cfset IR_SouthCentralIndianRiver_start = Replace(getIR_Start.ZONE , "IR" ,"", "All")>
  <cfset IR_SouthCentralIndianRiver_end = Replace(getIR_End.ZONE , "IR" , "" ,"All")>
  <cfset IR_SouthCentralIndianRiver_diff = Val(IR_SouthCentralIndianRiver_end) - Val(IR_SouthCentralIndianRiver_start) >
  <cfset ss['IR_SouthCentralIndianRiver_start'] = Val(IR_SouthCentralIndianRiver_start) >
  <cfset ss['IR_SouthCentralIndianRiver_end'] = Val(IR_SouthCentralIndianRiver_end) >
  <cfset ss['IR_SouthCentralIndianRiver_bar'] = Val(IR_SouthCentralIndianRiver_diff) >
  <cfif IR_SouthCentralIndianRiver_diff GT 0 >
    <cfset ss['IR_SouthCentralIndianRiver_start_space'] = Val(IR_SouthCentralIndianRiver_start) -136 >
    <cfset ss['IR_SouthCentralIndianRiver_end_space'] = 168 - Val(IR_SouthCentralIndianRiver_end) >
  </cfif>
  <cfif IR_SouthCentralIndianRiver_diff LTE 0 >
    <cfset ss['IR_SouthCentralIndianRiver_full_space'] = VAl('32') >
  </cfif>

  <!---IR SouthCentralIndianRiver END--->

  <!---IR SouthIndianRiver Start--->
  <cfquery name="getIR_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] BETWEEN 'IR169' AND 'IR237'
    ORDER BY
        dbo.TLU_Zones.[ZONE] ASC
</cfquery>
  <cfquery name="getIR_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = YEAR (GETDATE())
    AND MONTH ([Date]) = MONTH (GETDATE())
    AND [ZONE] BETWEEN 'IR169' AND 'IR237'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
  <cfset IR_SouthIndianRiver_start = Replace(getIR_Start.ZONE , "IR" ,"", "All")>
  <cfset IR_SouthIndianRiver_end = Replace(getIR_End.ZONE , "IR" , "" ,"All")>
  <cfset IR_SouthIndianRiver_diff = Val(IR_SouthIndianRiver_end) - Val(IR_SouthIndianRiver_start) >
  <cfset ss['IR_SouthIndianRiver_start'] = Val(IR_SouthIndianRiver_start) >
  <cfset ss['IR_SouthIndianRiver_end'] = Val(IR_SouthIndianRiver_end) >
  <cfset ss['IR_SouthIndianRiver_bar'] = Val(IR_SouthIndianRiver_diff) >
  <cfif IR_SouthIndianRiver_diff GT  0>
    <cfset ss['IR_SouthIndianRiver_start_space'] = Val(IR_SouthIndianRiver_start) - 169 >
    <cfset ss['IR_SouthIndianRiver_end_space'] = 237 - Val(IR_SouthIndianRiver_end) >
  </cfif>
  <cfif IR_SouthIndianRiver_diff LTE 0>
    <cfset ss['IR_SouthIndianRiver_full_space'] = VAl('69') >
  </cfif>

  <!---IR SouthIndianRiver END--->

  <cfset ArrayAppend(arr,ss) >
  <cfreturn arr/>
</cffunction>

<!---Current ZONE REPORT END  --->

<!---Current ZONE REPORT START--->

<cffunction name="yearlyZones" access="public" returntype="any" output="false">
  <cfset dtStart =  CreateDate(FORM.fromYear, 1, 1)>
  <cfset dtEnd =  CreateDate(FORM.toYear, 12, 31)>
  <cfset ee = (val(FORM.toYear) - Val(FORM.fromYear)+1)*12>
  <cfset arr = []>
  <cfset ss = StructNew() >
  <cfset res = ArrayNew(1)>
  <cfset ML_bar = ArrayNew(1)>
  <cfset ML_start_space = ArrayNew(1)>
  <cfset ML_end_space = ArrayNew(1)>
  <cfset ML_full_space = ArrayNew(1)>
  <cfset IR_bar = ArrayNew(1)>
  <cfset IR_start_space = ArrayNew(1)>
  <cfset IR_end_space = ArrayNew(1)>
  <cfset IR_full_space = ArrayNew(1)>
  <cfset BR_empty = ArrayNew(1)>
  <cfset IR_empty = ArrayNew(1)>
  <cfset BR_bar = ArrayNew(1)>
  <cfset BR_start_space = ArrayNew(1)>
  <cfset BR_end_space = ArrayNew(1)>
  <cfset BR_full_space = ArrayNew(1)>
  <cfloop index="i" from="1" to="#ee#" >

    <!---<cfoutput> #i# :    #dtStart#</cfoutput><br>--->

    <!---ML ZONES START--->
    <cfquery name="getML_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM  dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = #YEAR (dtStart)#
    AND MONTH ([Date]) = #MONTH (dtStart)#
    AND [ZONE] LIKE 'ML%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] ASC

</cfquery>
    <cfquery name="getML_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
       YEAR ([Date]) = #YEAR (dtStart)#
    AND MONTH ([Date]) = #MONTH (dtStart)#
    AND [ZONE] LIKE 'ML%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
    <cfset ML_start = Replace(getML_Start.ZONE , "ML" ,"", "All")>
    <cfset ML_end = Replace(getML_End.ZONE , "ML" , "" ,"All")>
    <cfset ML_diff = Val(ML_end) - Val(ML_start)+1 >
    <cfif ML_diff GT 0>
      <cfset ArrayAppend(ML_bar,Val(ML_diff)) >
      <cfset ArrayAppend(ML_start_space,Val(ML_start) -1) >
      <cfset ArrayAppend(ML_end_space, 45 - Val(ML_end)) >
      <cfset ArrayAppend(ML_full_space, VAl('0')) >
      <cfelse>
      <cfset ArrayAppend(ML_bar,Val('0')) >
      <cfset ArrayAppend(ML_start_space,Val('0')) >
      <cfset ArrayAppend(ML_end_space, Val('0')) >
    </cfif>
    <cfif ML_diff LTE 0>
      <cfset ArrayAppend(ML_full_space, VAl('45')) >
    </cfif>

    <!---ML ZONES END--->

    <!---BR ZONES START--->
    <cfquery name="getML_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
         YEAR ([Date]) = #YEAR (dtStart)#
    AND MONTH ([Date]) = #MONTH (dtStart)#
    AND [ZONE] LIKE 'BR%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] ASC
</cfquery>
    <cfquery name="getML_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = #YEAR (dtStart)#
    AND MONTH ([Date]) = #MONTH (dtStart)#
    AND [ZONE] LIKE 'BR%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
    <cfset BR_start = Replace(getML_Start.ZONE , "BR" ,"", "All")>
    <cfset BR_end = Replace(getML_End.ZONE , "BR" , "" ,"All")>
    <cfset BR_diff = Val(BR_end) - Val(BR_start)+1 >
    <cfif BR_diff GT 0>
      <cfset ArrayAppend(BR_bar,Val(BR_diff)) >
      <cfset ArrayAppend(BR_start_space,Val(BR_start) -55) >
      <cfset ArrayAppend(BR_end_space, 103 - Val(BR_end)) >
      <cfset ArrayAppend(BR_full_space, VAl('0')) >
      <cfelse>
      <cfset ArrayAppend(BR_bar,Val('0')) >
      <cfset ArrayAppend(BR_start_space,Val('0')) >
      <cfset ArrayAppend(BR_end_space, Val('0')) >
    </cfif>
    <cfif BR_diff LTE 0>
      <cfset ss['BR_full_space'] = VAl('31') >
    </cfif>

    <!---BR ZONES END--->

    <!---IR NorthIndianRiver Start--->
    <cfquery name="getIR_Start" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
        YEAR ([Date]) = #YEAR (dtStart)#
    AND MONTH ([Date]) = #MONTH (dtStart)#
    AND [ZONE] BETWEEN 'IR033' AND 'IR237'
    ORDER BY
        dbo.TLU_Zones.[ZONE] ASC
</cfquery>
    <cfquery name="getIR_End" datasource="#variables.dsn#">
    SELECT TOP 1
        dbo.PROJECTS.[Date],
        dbo.TLU_Zones.[ZONE]
    FROM
        dbo.PROJECTS
    INNER JOIN dbo.Project_Zones ON dbo.Project_Zones.TZ_Project_ID = dbo.PROJECTS.ID
    INNER JOIN dbo.TLU_Zones ON dbo.Project_Zones.TZ_Zone_ID = dbo.TLU_Zones.ID
    WHERE
       YEAR ([Date]) = #YEAR (dtStart)#
    AND MONTH ([Date]) = #MONTH (dtStart)#
    AND [ZONE] LIKE 'IR%'
    ORDER BY
        dbo.TLU_Zones.[ZONE] DESC
</cfquery>
    <cfset IR_start = Replace(getIR_Start.ZONE , "IR" ,"", "All")>
    <cfset IR_end = Replace(getIR_End.ZONE , "IR" , "" ,"All")>
    <cfset IR_diff = Val(IR_end) - Val(IR_start) >
    <cfif IR_diff GT 0>
      <cfset ArrayAppend(IR_bar,Val(IR_diff)) >
      <cfset ArrayAppend(IR_start_space,Val(IR_start) -33) >
      <cfset ArrayAppend(IR_end_space, 237 - Val(IR_end)) >
      <cfset ArrayAppend(IR_full_space, VAl('0')) >
      <cfelse>
      <cfset ArrayAppend(IR_bar,Val('0')) >
      <cfset ArrayAppend(IR_start_space,Val('0')) >
      <cfset ArrayAppend(IR_end_space, Val('0')) >
    </cfif>
    <cfif IR_diff LTE 0>
      <cfset ss['IR_full_space'] = VAl('204') >
    </cfif>

    <!---IR NorthIndianRiver END--->

    <cfset dtStart = DateAdd('m',1,dtStart) >
    <cfset ArrayAppend(BR_empty,val('27'))>
    <cfset ArrayAppend(IR_empty,val('33'))>
  </cfloop>
  <cfset ArrayAppend(res,ML_bar)>
  <cfset ArrayAppend(res,ML_start_space)>
  <cfset ArrayAppend(res,ML_end_space)>
  <cfset ArrayAppend(res,ML_full_space)>
  <cfset ArrayAppend(res,BR_bar)>
  <cfset ArrayAppend(res,BR_start_space)>
  <cfset ArrayAppend(res,BR_end_space)>
  <cfset ArrayAppend(res,BR_full_space)>
  <cfset ArrayAppend(res,BR_empty)>
  <cfset ArrayAppend(res,IR_empty)>
  <cfset ArrayAppend(res,IR_bar)>
  <cfset ArrayAppend(res,IR_start_space)>
  <cfset ArrayAppend(res,IR_end_space)>
  <cfset ArrayAppend(res,IR_full_space)>
  <cfreturn res/>
</cffunction>

<!---Current ZONE REPORT END  --->

<!--- function to get NCSG reports-------->
<cffunction name="geteStolenReports" access="public"  returntype="any" output="false">
  <cfargument name="param" type="any" required="true" default="">
  <cfif isdefined('Form.eStolen')>
    <cfset eStolen = Form.eStolen >
    <cfelse>
    <cfset eStolen = 0>
  </cfif>
  <cfquery name="geteStolen" datasource="#variables.dsn#">
SELECT top 50
dbo.PROJECTS.[Date],
dbo.DOLPHINS.YearOfBirth,
dbo.DOLPHINS.name,
dbo.DOLPHINS.Sex,
dbo.DOLPHINS.Code,
dbo.DOLPHIN_SIGHTINGS.Dolphin_ID

FROM
dbo.DOLPHIN_SIGHTINGS
INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
Where dbo.DOLPHINS.DScore = 'D1' OR dbo.DOLPHINS.DScore = 'D2' OR dbo.DOLPHINS.DScore = 'D3'
<cfif param EQ 0>
AND dbo.PROJECTS.[Date] BETWEEN '2002-09-01' AND '2013-12-31'
</cfif>


  <!---<cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
    AND dbo.SIGHTINGS.Survey = 'On' </cfif>--->
     <!---	AND dbo.PROJECTS.SurveyArea = 'IRL'--->
	<cfif isDefined('Form.Stock') AND Form.Stock NEQ "">
    AND dbo.PROJECTS.Stock ='#Stock#' 
    </cfif>
    <cfif isDefined('Form.MType') AND Form.MType NEQ "">
    AND dbo.PROJECTS.[Type] ='#MType#'
    </cfif>
    <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
    AND dbo.PROJECTS.SubType ='#SubType#' 
    </cfif>
    <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
    AND dbo.PROJECTS.SurveyArea ='#SurveyArea#'
 </cfif>
 
<cfif eStolen NEQ 0>
<cfif eStolen EQ "Q1" AND eStolen EQ "Q2" AND  eStolen EQ "Q3">
AND dbo.PROJECTS.[Date] BETWEEN '2002-09-01' AND '2013-12-31'
AND dbo.SIGHTINGS.Survey = 'On'
AND dbo.PROJECTS.SurveyArea = 'IRL'
</cfif>
</cfif>






<!---- for export excel files------->
</cfquery>
  <cfreturn geteStolen/>
</cffunction>
<!---End function to get NCSG reports-------->

<cffunction name="geteStolenReportsList" access="public"  returntype="any" output="false">
  <cfargument name="dolphin_id" type="any" required="true" default="">
  <cfquery name="geteStolenList" datasource="#variables.dsn#">

SELECT
dbo.SIGHTINGS.Zone_id,
dbo.TLU_Zones.ZSEGMENT,
dbo.DOLPHIN_SIGHTINGS.Dolphin_ID,
dbo.DOLPHIN_SIGHTINGS.Sighting_ID,
dbo.PROJECTS.[Date]
FROM
dbo.DOLPHIN_SIGHTINGS
INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
WHERE DOLPHIN_SIGHTINGS.Dolphin_ID = '#dolphin_id#'
AND dbo.PROJECTS.[Date] BETWEEN '2002-09-01' AND '2013-12-31'

</cfquery>
  <cfreturn geteStolenList>
</cffunction>

<!---- for export excel files------->
<cffunction name="geteStolenReportsExl" access="public"  returntype="any" output="false">

  <cfargument name="dolphin_id" type="any" required="true" default="">
  <cfsetting requesttimeout="1200" >
  <cfif isdefined('Form.eStolen')>
  <!---<cfdump var="#Form#"><cfabort>--->
  
 <cfif Form.eStolen neq 'Q3'>
 <cfif Form.eStolen neq 'Q3'>

  <cfset arr = ArrayNew(1)>
  <cfset type = ArrayNew(1)>

   <cfif Form.eStolen EQ "Q2">
        <cfset startDate = CreateDate(2002,09,01)>
   		<cfset endDate = CreateDate(2005,08,31)>
   <cfelse>
   <cfset startDate = CreateDate(2002,09,01)>
   <cfset endDate = CreateDate(2005,08,31)>
   </cfif>

        <cfloop from="#startDate#" to="#endDate#" index="i" step="#CreateTimeSpan(30,0,0,0)#">
        	<cfset dates = DateFormat(i, "mmm_yy")>

			<cfset qtypr = 'VarChar'>

            <cfset  ArrayAppend(arr, dates)>
             <cfset allDates = ArrayToList(arr, ",")>

              <cfset  ArrayAppend(type, qtypr)>
             <cfset qt = ArrayToList(type, ",")>
       </cfloop>
          <cfset QrtDate = "Nov_06,Feb_07,May_07,Aug_07,Dec_07,Mar_08,Jun_08,Sep_08,Dec_08,Mar_09,
		 Jun_09,Sep_09,Dec_09,Mar_10,May_10,Nov_12,Dec_12,Aug_13,Sep_13,Oct_13,Dec_13">
         <cfset qrtType = "VarChar,VarChar,
		 VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,
		 VarChar,VarChar,VarChar,VarChar,VarChar">

  		 <cfset myQuery = QueryNew("Code, #allDates#,#QrtDate#", "VarChar, #qt#,#qrtType#")>
        

  <cfset res = ArrayNew(1)>
  <cfset chk = 1>
    <cfquery name="geteStolenExlt" datasource="#variables.dsn#">
       Select top 200  ID,Code from DOLPHINS
	</cfquery>
	 <cfset newRow = QueryAddRow(MyQuery, geteStolenExlt.recordcount)>
    <cfloop query="geteStolenExlt">

        <cfloop from="#startDate#" to="#endDate#" index="i" step="#CreateTimeSpan(30,0,0,0)#">
         <cfset qdate = DateFormat(i, "YYYY-MM-DD") >
         <cfset dates = DateFormat(i, "mmm_yy")>
     		<cfquery name="geteExcelReport" datasource="#variables.dsn#">
                SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH(qdate)# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR(qdate)#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
                <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              	<!---AND dbo.PROJECTS.SurveyArea = 'IRL',--->
                </cfif>
				<cfif isDefined('Form.Stock') AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#'
                </cfif>
                <cfif isDefined('Form.MType') AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#'
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
                
                <!---AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
        
        </cfquery>
        <!---<cfdump var="#geteExcelReport#"><cfabort>--->
       
        	<cfif geteExcelReport.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset  QuerySetCell(myQuery, "#dates#", "#geteExcelReport.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset  QuerySetCell(myQuery, "#dates#", "#geteExcelReport.ZSEGMENT#", "#chk#")>
                	 </cfif>
            <cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
                 <cfset QuerySetCell(myQuery, "#dates#", "0", "#chk#")>
            </cfif>
        </cfloop>
        <cfset Chek = chk+1>
      <cfquery name="geteExcelReport2" datasource="#variables.dsn#">
       		 SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH('11/1/2006')# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR('11/30/2006')#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              <!---	AND dbo.PROJECTS.SurveyArea = 'IRL'--->
                
                <cfif isDefined('Form.Stock') AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#' 
                </cfif>
                <cfif isDefined('Form.MType') AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#'
                </cfif>
                
                
               <!--- AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>

        </cfquery>
        <cfif geteExcelReport2.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset  QuerySetCell(myQuery, "Nov_06", "#geteExcelReport2.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset  QuerySetCell(myQuery, "Nov_06", "#geteExcelReport2.ZSEGMENT#", "#chk#")>
                	 </cfif>
            <cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
                 <cfset QuerySetCell(myQuery, "Nov_06", "0", "#chk#")>
            </cfif>
            <!---- 2007 block------->
     	<cfset startDate1 = CreateDate(2007,02,01)>
   		<cfset endDate1 = CreateDate(2007,08,31)>
        <cfset ck2 = 1>
        <cfset QrtDate1 = "Feb_07,May_07,Aug_07">
        <cfset arr = listToArray (QrtDate1, ",",false,true)>
      <cfloop from="#startDate1#" to="#endDate1#" index="l" step="#CreateTimeSpan(90,0,0,0)#">
      	 <cfset qdate3 = DateFormat(l, "YYYY-MM-DD") >
         <cfset dates3 = DateFormat(l, "mmm_yy")>
    <cfquery name="geteExcelReport3" datasource="#variables.dsn#">
          SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH(qdate3)# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR(qdate3)#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              <!---	AND dbo.PROJECTS.SurveyArea = 'IRL'--->
                
                <cfif isDefined('Form.Stock')  AND Form.Stock NEQ "" >
                AND dbo.PROJECTS.Stock ='#Stock#'
                </cfif>
                <cfif isDefined('Form.MType')  AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#'
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#'
                </cfif>
                
              <!---  AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>
         </cfquery>
         <cfif geteExcelReport3.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset  QuerySetCell(myQuery, "#arr[ck2]#", "#geteExcelReport3.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset  QuerySetCell(myQuery, "#arr[ck2]#", "#geteExcelReport3.ZSEGMENT#", "#chk#")>
                	 </cfif>
            <cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
                 <cfset QuerySetCell(myQuery, "#arr[ck2]#", "0", "#chk#")>
            </cfif>
   		<cfset ck2++>
      </cfloop>

      <cfquery name="geteExcelReport4" datasource="#variables.dsn#">
       		 SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH('12/1/2007')# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR('12/31/2007')#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              <!---	AND dbo.PROJECTS.SurveyArea = 'IRL'--->
                
                <cfif isDefined('Form.Stock')AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#'
                </cfif>
                <cfif isDefined('Form.MType')AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
                
               <!--- AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>

        </cfquery>
		<cfif geteExcelReport4.recordcount NEQ 0 >
         <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            <cfif Form.eStolen EQ "Q2">
                <cfset  QuerySetCell(myQuery, "Dec_07", "#geteExcelReport4.DScore#", "#chk#")>
             <cfelse>
                <cfset  QuerySetCell(myQuery, "Dec_07", "#geteExcelReport4.ZSEGMENT#", "#chk#")>
             </cfif>
        <cfelse>
             <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>

             <cfset QuerySetCell(myQuery, "Dec_07", "0", "#chk#")>
        </cfif>
        
         
        <!----End 2008 block------->

        <!---- 2008 block------->
		<cfset startDate2 = CreateDate(2008,03,01)>
        <cfset endDate2 = CreateDate(2008,12,31)>
         <cfset ck3 = 1>
        <cfset QrtDate2 = "Mar_08,Jun_08,Sep_08,Dec_08">
        <cfset arr2 = listToArray (QrtDate2, ",",false,true)>
        <cfloop from="#startDate2#" to="#endDate2#" index="l" step="#CreateTimeSpan(90,0,0,0)#">
      	 <cfset qdate4 = DateFormat(l, "YYYY-MM-DD") >
       <cfquery name="geteExcelReport3" datasource="#variables.dsn#">
          SELECT
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH(qdate4)# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR(qdate4)#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              	<!---AND dbo.PROJECTS.SurveyArea = 'IRL'--->
                
                
                <cfif isDefined('Form.Stock') AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#'
                </cfif>
                <cfif isDefined('Form.MType') AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
                
               <!--- AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>
         </cfquery>
      
         <cfif geteExcelReport3.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset  QuerySetCell(myQuery, "#arr2[ck3]#", "#geteExcelReport3.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset  QuerySetCell(myQuery, "#arr2[ck3]#", "#geteExcelReport3.ZSEGMENT#", "#chk#")>
                	 </cfif>
            <cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>

                 <cfset QuerySetCell(myQuery, "#arr2[ck3]#", "0", "#chk#")>
            </cfif>
   		<cfset ck3++>
      </cfloop>
      
    <!---- End 2008 block------->
 

     <!---- 2009 block------->
		<cfset startDate4 = CreateDate(2009,03,01)>
        <cfset endDate4 = CreateDate(2009,12,31)>
         <cfset ck4 = 1>
        <cfset QrtDate4 = "Mar_09,Jun_09,Sep_09,Dec_09">
        <cfset arr4 = listToArray (QrtDate4, ",",false,true)>
    <cfloop from="#startDate4#" to="#endDate4#" index="l" step="#CreateTimeSpan(90,0,0,0)#">
      	 <cfset qdate4 = DateFormat(l, "YYYY-MM-DD") >
          <cfquery name="geteExcelReport4" datasource="#variables.dsn#">
          SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH(qdate4)# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR(qdate4)#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              	<!---AND dbo.PROJECTS.SurveyArea = 'IRL'--->
                
                <cfif isDefined('Form.Stock')AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#'
                </cfif>
                <cfif isDefined('Form.MType')AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType')AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea')AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
                
               <!--- AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>
         </cfquery>
         <cfif geteExcelReport4.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset  QuerySetCell(myQuery, "#arr4[ck4]#", "#geteExcelReport4.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset  QuerySetCell(myQuery, "#arr4[ck4]#", "#geteExcelReport4.ZSEGMENT#", "#chk#")>
                	 </cfif>
            	<cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
                 <cfset QuerySetCell(myQuery, "#arr4[ck4]#","0", "#chk#")>
            </cfif>
   		<cfset ck4++>
      </cfloop> 
        
    <!---- End 2009 block------->

    <!---- 2010 block------->
		<cfset startDate5 = CreateDate(2010,03,01)>
        <cfset endDate5 = CreateDate(2010,05,31)>
         <cfset ck5 = 1>
        <cfset QrtDate5 = "Mar_10,May_10">
        <cfset arr5 = listToArray (QrtDate5, ",",false,true)>
    <cfloop from="#startDate5#" to="#endDate5#" index="l" step="#CreateTimeSpan(90,0,0,0)#">
      	 <cfset qdate5 = DateFormat(l, "YYYY-MM-DD") >
    <cfquery name="geteExcelReport5" datasource="#variables.dsn#">
          SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH(qdate5)# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR(qdate5)#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              	<!---AND dbo.PROJECTS.SurveyArea = 'IRL'--->
                
                <cfif isDefined('Form.Stock') AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#' 
                </cfif>
                <cfif isDefined('Form.MType') AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
               <!--- AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>
         </cfquery>
         <cfif geteExcelReport5.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset  QuerySetCell(myQuery, "#arr5[ck5]#", "#geteExcelReport5.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset  QuerySetCell(myQuery, "#arr5[ck5]#", "#geteExcelReport5.ZSEGMENT#", "#chk#")>
                	 </cfif>
            	<cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
                 <cfset QuerySetCell(myQuery, "#arr5[ck5]#", "0", "#chk#")>
            </cfif>
   		<cfset ck5++>
      </cfloop> 
    
    <!---- End 2010 block------->

     <!---- 2012 block------->
    <cfset startDate6 = CreateDate(2012,11,01)>
         <cfset endDate6 = CreateDate(2012,12,12)>
         <cfset ck6 = 1>
        <cfset QrtDate6 = "Nov_12,Dec_12">
        <cfset arr6 = listToArray (QrtDate6, ",",false,true)>
    <cfloop from="#startDate6#" to="#endDate6#" index="m" step="#CreateTimeSpan(30,0,0,0)#">
      	 <cfset qdate6 = DateFormat(m, "YYYY-MM-DD") >
     <cfquery name="geteExcelReport6" datasource="#variables.dsn#">
          SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH(qdate6)# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR(qdate6)#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              	<!---AND dbo.PROJECTS.SurveyArea = 'IRL'--->
                
                <cfif isDefined('Form.Stock') AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#'
                </cfif>
                <cfif isDefined('Form.MType') AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
                
                <!---AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>
         </cfquery>
         <cfif geteExcelReport6.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset  QuerySetCell(myQuery, "#arr6[ck6]#", "#geteExcelReport6.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset  QuerySetCell(myQuery, "#arr6[ck6]#", "#geteExcelReport6.ZSEGMENT#", "#chk#")>
                	 </cfif>
            	<cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
                 <cfset QuerySetCell(myQuery, "#arr6[ck6]#", "0", "#chk#")>
            </cfif>
   		<cfset ck6++>
      </cfloop>

    <!---- 2012 block------->


    <!---- 2013 block one------->

    	 <cfset startDate8 = CreateDate(2013,08,01)>
         <cfset endDate8 = CreateDate(2013,10,31)>
         <cfset ck8 = 1>
        <cfset QrtDate8 = "Aug_13,Sep_13,Oct_13">
        <cfset arr8 = listToArray (QrtDate8, ",",false,true)>
    <cfloop from="#startDate8#" to="#endDate8#" index="m" step="#CreateTimeSpan(33,0,0,0)#">

      	 <cfset qdate8 = DateFormat(m, "YYYY-MM-DD") >

          <cfquery name="geteExcelReport8" datasource="#variables.dsn#">
          SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH(qdate8)# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR(qdate8)#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              <!---	AND dbo.PROJECTS.SurveyArea = 'IRL'---> 
              
              <cfif isDefined('Form.Stock') AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#' 
                </cfif>
                <cfif isDefined('Form.MType') AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
              
                <!---AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>
         </cfquery>
         <cfif geteExcelReport8.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset QuerySetCell(myQuery, "#arr8[ck8]#", "#geteExcelReport8.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset QuerySetCell(myQuery, "#arr8[ck8]#", "#geteExcelReport8.ZSEGMENT#", "#chk#")>
                	 </cfif>
            	<cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
                 <cfset QuerySetCell(myQuery, "#arr8[ck8]#", "0", "#chk#")>
            </cfif>
   		<cfset ck8++>
      </cfloop>

    <!---- End 2013 block one------->

    <!------2013 Block 2 ------->
   

    <cfquery name="geteExcelReport9" datasource="#variables.dsn#">
       		 SELECT 
                dbo.DOLPHINS.Code,
                dbo.PROJECTS.[Date] as date,
                dbo.TLU_Zones.ZSEGMENT,
                dbo.DOLPHINS.DScore
                FROM
                dbo.DOLPHIN_SIGHTINGS
                INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
                INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
                INNER JOIN dbo.PROJECTS ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
                where
                MONTH(dbo.PROJECTS.[Date]) = #MONTH('12/1/2013')# AND YEAR(dbo.PROJECTS.[Date])  = #YEAR('12/31/2013')#
                AND
                dbo.DOLPHINS.ID = '#geteStolenExlt.ID#'
              <cfif Form.eStolen EQ "Q1" OR Form.eStolen EQ "Q2">
              	AND dbo.SIGHTINGS.Survey = 'On'
              	<!---AND dbo.PROJECTS.SurveyArea = 'IRL'--->
                
                <cfif isDefined('Form.Stock')AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#' 
                </cfif>
                <cfif isDefined('Form.MType') AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
                
                <!---AND dbo.TLU_Zones.ZSEGMENT IN ('2','3','4')--->
              </cfif>

        </cfquery> 
        
        
         
        
        <cfif geteExcelReport9.recordcount NEQ 0 >
            	 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>
            	 	<cfif Form.eStolen EQ "Q2">
             			<cfset  QuerySetCell(myQuery, "Dec_13", "#geteExcelReport9.DScore#", "#chk#")>
                	 <cfelse>
               	  		<cfset  QuerySetCell(myQuery, "Dec_13", "#geteExcelReport9.ZSEGMENT#", "#chk#")>
                	 </cfif>
            <cfelse>
                 <cfset QuerySetCell(myQuery, "Code", "#geteStolenExlt.Code#", "#chk#")>

                 <cfset QuerySetCell(myQuery, "Dec_13", "0", "#chk#")>
            </cfif>

    <!------ end 2013 block 2 -------->

    <cfset chk++>
    </cfloop>
  	</cfif>
   </cfif>
   
   
   
   
<cfif Form.eStolen EQ "Q3" OR Form.eStolen EQ "Q3">
 <cfset index = 1>
    <cfquery name="geteExcelQ3" datasource="#variables.dsn#">
          SELECT 
            dbo.PROJECTS.[Date] as date,
            dbo.PROJECTS.SurveyArea,
            dbo.SIGHTINGS.Survey,
            dbo.SIGHTINGS.SightingNumber,
            dbo.DOLPHINS.Code,
            dbo.DOLPHINS.DScore,
            dbo.DOLPHIN_SIGHTINGS.pqSum,
            dbo.SIGHTINGS.WaveHeight,
            dbo.SIGHTINGS.Glare,
            dbo.SIGHTINGS.Beaufort,
            dbo.SIGHTINGS.Sightability,
            dbo.SIGHTINGS.Weather
            FROM
            dbo.DOLPHIN_SIGHTINGS
            INNER JOIN dbo.DOLPHINS  ON dbo.DOLPHINS.ID = dbo.DOLPHIN_SIGHTINGS.Dolphin_ID
            INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.DOLPHIN_SIGHTINGS.Sighting_ID
            INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
            INNER JOIN dbo.PROJECTS  ON dbo.SIGHTINGS.Project_ID = dbo.PROJECTS.ID
            Where dbo.DOLPHINS.DScore IN('D1','D2','D3','D4','D5')
            <cfif Form.eStolen EQ "Q3">
               <!--- AND dbo.TLU_Zones.ZSEGMENT IN('2','3','4')--->
            </cfif>
            AND dbo.PROJECTS.[Date] BETWEEN '2002-09-01' AND '2005-12-31'
            <!---AND dbo.PROJECTS.SurveyArea = 'IRL'--->
            <cfif isDefined('Form.Stock') AND Form.Stock NEQ "">
                AND dbo.PROJECTS.Stock ='#Stock#' 
                </cfif>
                <cfif isDefined('Form.MType') AND Form.MType NEQ "">
                AND dbo.PROJECTS.[Type] ='#MType#'
                </cfif>
                <cfif isDefined('Form.SubType') AND Form.SubType NEQ "">
                AND dbo.PROJECTS.SubType ='#SubType#' 
                </cfif>
                <cfif isDefined('Form.SurveyArea') AND Form.SurveyArea NEQ "">
                AND dbo.PROJECTS.SurveyArea ='#SurveyArea#' 
                </cfif>
            
            
            
            ORDER BY dbo.PROJECTS.[Date]
    </cfquery>
    
    
    
    
		<cfset xlssRegistrant = SpreadsheetNew("Registrant",true) >
		 <cfif index EQ 1>
		<cfset SpreadsheetAddRow(xlssRegistrant,"Date,SurveyArea,Survey,SightingNumber,
		Code,DScore,pqSum,WaveHeight,Glare,Beaufort,Sightability,Weather")>
		</cfif>
         <!---<cfset geteExcelQ3.date = DateFormat(geteExcelQ3.Date, "YYYY-MM-DD")>--->

		<cfset SpreadsheetAddRows(xlssRegistrant, geteExcelQ3) >
		<cfheader name="Content-Disposition" value="attachment;filename=Q1-Report.xlsx">
		<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"  variable="#spreadSheetReadBinary(xlssRegistrant)#">
    <cfelse>
        <cfspreadsheet
            action="write"
            filename="#Application.DirectoryRoot#Reports\qReports\#Form.eStolen#.xls"
            overwrite="true"
            query="myQuery">
            
            
        <cflocation url="/Reports/qReports/#Form.eStolen#.xls" addtoken="no">
   </cfif>
   </cfif>
   
<cfreturn myQuery>
</cffunction>

<!---- Display data on tabuler view----------->
<cffunction name="getBiopsyData" access="public" returntype="any" output="false">
<cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
  <cfquery name="getBiopsyTable" datasource="#variables.dsn#" result="resk">
    SELECT
    	dbo.PROJECTS.[Date] as date,
        dbo.PROJECTS.Stock,
        dbo.SIGHTINGS.Takes,
        dbo.TLU_Zones.ZSEGMENT,
        dbo.PROJECTS.Platform as Vessel,
        dbo.TLU_Camera.camera as Device,
        dbo.SIGHTINGS.ID,
        dbo.BIOPSY_SHOTS.ShotNumber,
        dbo.BIOPSY_SHOTS.ShotTime as time,
        dbo.BIOPSY_SHOTS.ShotDistance as Distance,
        dbo.TLU_ResearchTeamMembers.RT_MemberName,
        dbo.BIOPSY_SHOTS.Outcome,
        dbo.BIOPSY_SHOTS.MissHeight,
        dbo.BIOPSY_SHOTS.MissWidth,
        dbo.TLU_HitDescriptors.HitDescriptors,
        dbo.BIOPSY_SHOTS.MissDistance,
        dbo.BIOPSY_SHOTS.TargetLevel,
        dbo.BIOPSY_SHOTS.TargetResponseBehavior1,
        dbo.BIOPSY_SHOTS.TargetResponseBehavior2,
        dbo.BIOPSY_SHOTS.TargetResponseBehavior3,
        dbo.BIOPSY_SHOTS.GroupResponseBehavior,
        dbo.BIOPSY_SHOTS.GroupSize,
        dbo.TLU_HitLocation.HitLocationAbbreviation as HitLocation,
        dbo.SIGHTINGS.Location,
        dbo.DOLPHINS.Code,
        dbo.DOLPHINS.Sex,
        dbo.BIOPSY_SHOTS.Sample,
        dbo.BIOPSY_SHOTS.SampleLength as sampleSize,
        dbo.BIOPSY_SHOTS.BlubberTeflonVial,
        dbo.BIOPSY_SHOTS.BlubberCryovialRed,
        dbo.BIOPSY_SHOTS.BlubberCryovialBlue,
        dbo.BIOPSY_SHOTS.SkinDMSO,
        dbo.BIOPSY_SHOTS.SkinRNAlater,
        dbo.BIOPSY_SHOTS.SkinDCryovial,
        dbo.BIOPSY_SHOTS.TargetPre_Behavior1,
        dbo.BIOPSY_SHOTS.TargetPre_Behavior2,
        dbo.BIOPSY_SHOTS.TargetPre_Behavior3,
        dbo.BIOPSY_SHOTS.TargetPost_Behavior1,
        dbo.BIOPSY_SHOTS.TargetPost_Behavior2,
        dbo.BIOPSY_SHOTS.TargetPost_Behavior3,
        dbo.BIOPSY_SHOTS.GroupPre_Behavior1,
        dbo.BIOPSY_SHOTS.GroupPre_Behavior2,
        dbo.BIOPSY_SHOTS.GroupPre_Behavior3,
        dbo.BIOPSY_SHOTS.GroupPost_Behavior1,
        dbo.BIOPSY_SHOTS.GroupPost_Behavior2,
        dbo.BIOPSY_SHOTS.GroupPost_Behavior3,
        dbo.BIOPSY_SHOTS.SampleCollected,
        dbo.BIOPSY_SHOTS.Samplehead,
        dbo.TLU_Zones.LAT_DD as Easting_X,
        dbo.TLU_Zones.lONG_DD as Northing_Y,
        dbo.TLU_HitLocation.Description,
        dbo.SIGHTINGS.notes
        
        FROM
        dbo.BIOPSY_SHOTS
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        LEFT JOIN dbo.TLU_HitDescriptors ON TLU_HitDescriptors.ID = dbo.BIOPSY_SHOTS.HitDescriptor
   		INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.BIOPSY_SHOTS.DOLPHIN_ID
		INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
        INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
		INNER JOIN dbo.TLU_ResearchTeamMembers ON dbo.TLU_ResearchTeamMembers.RT_ID = dbo.BIOPSY_SHOTS.Arbalester
        Inner JOIN dbo.PHOTO_ROLLS ON dbo.SIGHTINGS.ID = dbo.PHOTO_ROLLS.Sighting_ID
		INNER JOIN dbo.TLU_Camera
		ON dbo.TLU_Camera.ID = dbo.PHOTO_ROLLS.camera       
        where 1=1

        <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
            And dbo.BIOPSY_SHOTS.Arbalester= '#form.Arbalester#'
        </cfif>
        <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
			<cfset daterange = form.DEFAULT_DATERANGE>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            and dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>

</cfquery>

 <cfreturn getBiopsyTable>

</cffunction>
<!----BiopsyNOAASummary Display data ----------->
<cffunction name="getBiopsyNOAASummaryData" access="public" returntype="any" output="false">
  <cfquery name="getBiopsyNOAASummary" datasource="#variables.dsn#">
    SELECT Outcome 
        FROM
        dbo.BIOPSY_SHOTS
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE  
     <!--- <cfif isdefined("Form.Stock")>
      <cfset stockName = Form.Stock>
           dbo.PROJECTS.Stock ='#stockName#' 
         </cfif>--->
   <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>

</cfquery>

 <!---<cfreturn getShotDistance6>
 <cfreturn getBiopsyNOAASummary>--->
 
 <!---<cfset queries.getBiopsyNOAASummary = duplicate(getBiopsyNOAASummary)>
 <cfset queries.getShotDistance6= duplicate(getShotDistance6)>--->
 
  <cfreturn getBiopsyNOAASummary>
  </cffunction>
<!---getTotal Hits from 2,3,4,5,6++ meter---->
<cffunction name="HitsDistance" access="public" returntype="any" output="false">
   
<!---HitDistance three Meter---->
<cfquery name="getHitShotDistanceThreeMeter" datasource="#variables.dsn#">
    SELECT COUNT(ShotDistance) as HitDistance3
     FROM  dbo.BIOPSY_SHOTS
     INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
     INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
     INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
     
      where ShotDistance =3
     AND 
      <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>

<!---HitDistance four Meter---->
<cfquery name="getHitShotDistanceFourMeter" datasource="#variables.dsn#">
    SELECT COUNT(ShotDistance) as HitDistance4
     FROM  dbo.BIOPSY_SHOTS
     INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
     INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
     INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
     
      where ShotDistance =4 
     AND 
      <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>
<!---HitDistance five Meter---->
<cfquery name="getHitShotDistanceFiveMeter" datasource="#variables.dsn#">
    SELECT COUNT(ShotDistance) as HitDistance5
     FROM  dbo.BIOPSY_SHOTS
     INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
     INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
     INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
     
      where ShotDistance =5
     AND 
      <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>
<!---HitDistance six plus Meter---->
<cfquery name="getHitShotDistanceSixMeterPlus" datasource="#variables.dsn#">
    SELECT COUNT(ShotDistance) as HitDistance6
     FROM  dbo.BIOPSY_SHOTS
     INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
     INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
     INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
     
      where ShotDistance >=6 
     AND 
      <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>


<!---  <cfset CountHits=ArrayNew(1)>
    <cfset CountHits[1]  ="#getHitShotDistanceThreeMeter#"> 
    <cfset CountHits[2]  ="#getHitShotDistanceFourMeter#"> 
    <cfset CountHits[4]  ="#getHitShotDistanceFiveMeter#">
   <cfset CountHits[5]   ="#getHitShotDistanceSixMeterPlus#">--->
   <cfset CountHits=["#getHitShotDistanceThreeMeter.HitDistance3#","#getHitShotDistanceFourMeter.HitDistance4#","#getHitShotDistanceFiveMeter.HitDistance5#","#getHitShotDistanceSixMeterPlus.HitDistance6#"]>
  <cfreturn CountHits>
</cffunction>

<!---getTotal Miss from 2,3,4,5,6++ meter---->
<cffunction name="MissDistance" access="public" returntype="any" output="false">
   
<!---HitDistance three Meter---->
<cfquery name="getMissShotDistanceThreeMeter" datasource="#variables.dsn#">
    SELECT COUNT(MissDistance) as MissDistance3
     FROM  dbo.BIOPSY_SHOTS
     INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
     INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
     INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
     
      where ShotDistance =3
     AND 
      <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>

<!---HitDistance four Meter---->
<cfquery name="getMissShotDistanceFourMeter" datasource="#variables.dsn#">
    SELECT COUNT(MissDistance) as MissDistance4
     FROM  dbo.BIOPSY_SHOTS
     INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
     INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
     INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
     
      where ShotDistance =4 
     AND 
      <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>
<!---HitDistance five Meter---->
<cfquery name="getMissShotDistanceFiveMeter" datasource="#variables.dsn#">
    SELECT COUNT(MissDistance) as MissDistance5
     FROM  dbo.BIOPSY_SHOTS
     INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
     INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
     INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
     
      where ShotDistance =5
     AND 
      <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>
<!---HitDistance six plus Meter---->
<cfquery name="getMissShotDistanceSixMeterPlus" datasource="#variables.dsn#">
    SELECT COUNT(MissDistance) as MissDistance6
     FROM  dbo.BIOPSY_SHOTS
     INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
     INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
     INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
     
      where ShotDistance >=6 
     AND 
      <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
             dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>


<!---  <cfset CountHits=ArrayNew(1)>
    <cfset CountHits[1]  ="#getHitShotDistanceThreeMeter#"> 
    <cfset CountHits[2]  ="#getHitShotDistanceFourMeter#"> 
    <cfset CountHits[4]  ="#getHitShotDistanceFiveMeter#">
   <cfset CountHits[5]   ="#getHitShotDistanceSixMeterPlus#">--->
   <cfset CountMiss=["#getMissShotDistanceThreeMeter.MissDistance3#","#getMissShotDistanceFourMeter.MissDistance4#","#getMissShotDistanceFiveMeter.MissDistance5#","#getMissShotDistanceSixMeterPlus.MissDistance6#"]>
  <cfreturn CountMiss>
</cffunction>

<!---- export excel data on button click----------->
<cffunction name="getBiopsyExcel" access="public" returntype="any" output="false">
	
  <cfquery name="getBiopsyREport" datasource="#variables.dsn#">
 	SELECT
        dbo.PROJECTS.[Date] as Date,
        dbo.PROJECTS.Stock,
        dbo.SIGHTINGS.Takes,
        dbo.TLU_Zones.ZSEGMENT,
        dbo.PROJECTS.Platform as Vessel,
        dbo.TLU_Camera.camera as Device,
        dbo.SIGHTINGS.ID as S##,
        dbo.BIOPSY_SHOTS.ShotNumber,
        dbo.BIOPSY_SHOTS.ShotTime as Time,
        dbo.BIOPSY_SHOTS.ShotDistance as Distance,
        dbo.TLU_ResearchTeamMembers.RT_MemberName as Arbalester,
        dbo.BIOPSY_SHOTS.Outcome as HitMiss,
        dbo.BIOPSY_SHOTS.MissHeight,
        dbo.BIOPSY_SHOTS.MissWidth,
        dbo.BIOPSY_SHOTS.MissDistance,
        dbo.TLU_HitDescriptors.HitDescriptors as HitDescriptor,
        dbo.BIOPSY_SHOTS.TargetLevel,
        dbo.BIOPSY_SHOTS.TargetResponseBehavior1,
        dbo.BIOPSY_SHOTS.TargetResponseBehavior2,
        dbo.BIOPSY_SHOTS.TargetResponseBehavior3,
        dbo.BIOPSY_SHOTS.GroupResponseBehavior,
        dbo.BIOPSY_SHOTS.GroupSize,
        dbo.TLU_HitLocation.HitLocationAbbreviation as HitLocation,
        dbo.SIGHTINGS.Location,
        dbo.TLU_Zones.LAT_DD as LatX,
        dbo.TLU_Zones.lONG_DD as LongY,
        dbo.DOLPHINS.Code,
        dbo.DOLPHINS.Sex,
        dbo.BIOPSY_SHOTS.Sample,
        dbo.BIOPSY_SHOTS.SampleLength as SampleSize,
        dbo.BIOPSY_SHOTS.SampleCollected,
        dbo.BIOPSY_SHOTS.Samplehead,
        dbo.TLU_HitLocation.Description as Comments,
        dbo.BIOPSY_SHOTS.BlubberTeflonVial as BlubberTeflon,
        dbo.BIOPSY_SHOTS.BlubberCryovialRed as BlubberCryo1,
        dbo.BIOPSY_SHOTS.BlubberCryovialBlue as BlubberCryo2,
        dbo.BIOPSY_SHOTS.SkinDMSO,
        dbo.BIOPSY_SHOTS.SkinRNAlater,
        dbo.BIOPSY_SHOTS.SkinDCryovial,
        
        dbo.BIOPSY_SHOTS.TargetPre_Behavior1 as TargetPreBehavior1,
        dbo.BIOPSY_SHOTS.TargetPre_Behavior2 as TargetPreBehavior2,
        dbo.BIOPSY_SHOTS.TargetPre_Behavior3 as TargetPreBehavior3,
        dbo.BIOPSY_SHOTS.TargetPost_Behavior1 as TargetPostBehavior1,
        dbo.BIOPSY_SHOTS.TargetPost_Behavior2 as TargetPostBehavior2,
        dbo.BIOPSY_SHOTS.TargetPost_Behavior3 as TargetPostBehavior3,
        dbo.BIOPSY_SHOTS.GroupPre_Behavior1 as GroupPreBehavior1,
        dbo.BIOPSY_SHOTS.GroupPre_Behavior2 as GroupPreBehavior2,
        dbo.BIOPSY_SHOTS.GroupPre_Behavior3 as GroupPreBehavior3,
        dbo.BIOPSY_SHOTS.GroupPost_Behavior1 as GroupPostBehavior1,
        dbo.BIOPSY_SHOTS.GroupPost_Behavior2 as GroupPostBehavior2,
        dbo.BIOPSY_SHOTS.GroupPost_Behavior3 as GroupPostBehavior3,
        dbo.SIGHTINGS.notes as DispositionArchive
        
        FROM
        dbo.BIOPSY_SHOTS
        INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        LEFT JOIN dbo.TLU_HitDescriptors ON TLU_HitDescriptors.ID = dbo.BIOPSY_SHOTS.HitDescriptor
        INNER JOIN dbo.DOLPHINS ON dbo.DOLPHINS.ID = dbo.BIOPSY_SHOTS.DOLPHIN_ID
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
        INNER JOIN dbo.TLU_Zones ON dbo.SIGHTINGS.Zone_id = dbo.TLU_Zones.ID
        INNER JOIN dbo.TLU_ResearchTeamMembers ON dbo.TLU_ResearchTeamMembers.RT_ID = dbo.BIOPSY_SHOTS.Arbalester
        Inner JOIN dbo.PHOTO_ROLLS ON dbo.SIGHTINGS.ID = dbo.PHOTO_ROLLS.Sighting_ID
		INNER JOIN dbo.TLU_Camera
		ON dbo.TLU_Camera.ID = dbo.PHOTO_ROLLS.camera
        WHERE 1 = 1
        
        <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
            and dbo.BIOPSY_SHOTS.Arbalester= <cfqueryparam  cfsqltype="cf_sql_varchar" value='#form.Arbalester#'>
        </cfif>
        <cfif isdefined("form.DEFAULT_DATERANGE")>
			<cfset daterange = form.DEFAULT_DATERANGE>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

            and dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>

 <cfreturn getBiopsyREport>
</cffunction>

<!----SampleDispositionReport Display data on tabuler view----------->
<cffunction name="getSampleDispositionReportData" access="public" returntype="any" output="false">
  <cfquery name="getDispositionReport" datasource="#variables.dsn#">
   SELECT Sample as Sampletype,Samplehead as Sampleheading,notes as DispositionArchive
        FROM
        dbo.BIOPSY_SHOTS
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
      <!---<cfif isdefined("Form.Stock")>
      <cfset stockName = Form.Stock>
          dbo.BIOPSY_SHOTS.Stock ='#stockName#' 
         </cfif>--->
       <cfif isdefined("Form.samplehead")>
        <cfset daterange = Form.daterange>
          dbo.BIOPSY_SHOTS.Samplehead  = '#samplehead#' 
         </cfif>  
       <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            AND  dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>

</cfquery>

  <cfreturn getDispositionReport>
  </cffunction>

  <!----get All count Blubbers  BIOPSY_SHOTS on Basis Of Filters Slection---->
  <cffunction name="getBlubbers" access="public" returntype="any" output="false">
  <!---getBlubberTeflonVial--->
  <cfquery name="getBlubberTeflonVial" datasource="#variables.dsn#">
 SELECT COUNT(BlubberTeflonVial) as BlubberTeflonVial 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
       
       <!---<cfif isdefined("Form.Stock")>
      <cfset stockName = Form.Stock>
          dbo.BIOPSY_SHOTS.Stock ='#stockName#' 
         </cfif>--->
       <cfif isdefined("Form.samplehead")>
        <cfset daterange = Form.daterange>
          dbo.BIOPSY_SHOTS.Samplehead  = '#samplehead#' 
         </cfif>  
       <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            AND  dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
  
  </cfquery>
  <!---getBlubberCryovialRed--->
  <cfquery name="getBlubberCryovialRed" datasource="#variables.dsn#">
 SELECT COUNT(BlubberCryovialRed) as BlubberCryovialRed 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
            
            <!---<cfif isdefined("Form.Stock")>
      <cfset stockName = Form.Stock>
          dbo.BIOPSY_SHOTS.Stock ='#stockName#' 
         </cfif>--->
       <cfif isdefined("Form.samplehead")>
        <cfset daterange = Form.daterange>
          dbo.BIOPSY_SHOTS.Samplehead  = '#samplehead#' 
         </cfif>  
       <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            AND  dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
  
  </cfquery>
  <!---getBlubberCryovialBlue--->
  <cfquery name="getBlubberCryovialBlue" datasource="#variables.dsn#">
 SELECT COUNT(BlubberCryovialBlue) as BlubberCryovialBlue 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
            
            <!---<cfif isdefined("Form.Stock")>
      <cfset stockName = Form.Stock>
          dbo.BIOPSY_SHOTS.Stock ='#stockName#' 
         </cfif>--->
       <cfif isdefined("Form.samplehead")>
        <cfset daterange = Form.daterange>
          dbo.BIOPSY_SHOTS.Samplehead  = '#samplehead#' 
         </cfif>  
       <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            AND  dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
            
  
  </cfquery>
 
 <cfset TotalCountBlubbers=["#getBlubberTeflonVial.BlubberTeflonVial#","#getBlubberCryovialRed.BlubberCryovialRed#","#getBlubberCryovialBlue.BlubberCryovialBlue#"]>
 
   <cfreturn TotalCountBlubbers>
  </cffunction>
  
  <!----get All count  skin's from  BIOPSY_SHOTS on Basis Of Filters Slection ---->
  <cffunction name="getskins" access="public" returntype="any" output="false">
  <!---getTotalSkinDMSO--->
  <cfquery name="getTotalSkinDMSO" datasource="#variables.dsn#">
 SELECT COUNT(SkinDMSO) as SkinDMSO 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
           
           <!---<cfif isdefined("Form.Stock")>
      <cfset stockName = Form.Stock>
          dbo.BIOPSY_SHOTS.Stock ='#stockName#' 
         </cfif>--->
       <cfif isdefined("Form.samplehead")>
        <cfset daterange = Form.daterange>
          dbo.BIOPSY_SHOTS.Samplehead  = '#samplehead#' 
         </cfif>  
       <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            AND  dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
  
  </cfquery>
  <!---getTotalSkinRNAlater--->
  <cfquery name="getTotalSkinRNAlater" datasource="#variables.dsn#">
 SELECT COUNT(SkinRNAlater) as SkinRNAlater 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
           
           <!---<cfif isdefined("Form.Stock")>
      <cfset stockName = Form.Stock>
          dbo.BIOPSY_SHOTS.Stock ='#stockName#' 
         </cfif>--->
       <cfif isdefined("Form.samplehead")>
        <cfset daterange = Form.daterange>
          dbo.BIOPSY_SHOTS.Samplehead  = '#samplehead#' 
         </cfif>  
       <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            AND  dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
           
           
           
  
  </cfquery>
  <!---getBlubberCryovialBlue    SkinDCryovial--->
  <cfquery name="getTotalSkinDCryovial" datasource="#variables.dsn#">
 SELECT COUNT(SkinDCryovial) as SkinDCryovial 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
           
           <!---<cfif isdefined("Form.Stock")>
      <cfset stockName = Form.Stock>
          dbo.BIOPSY_SHOTS.Stock ='#stockName#' 
         </cfif>--->
       <cfif isdefined("Form.samplehead")>
        <cfset daterange = Form.daterange>
          dbo.BIOPSY_SHOTS.Samplehead  = '#samplehead#' 
         </cfif>  
       <cfif isdefined("Form.daterange")>
			<cfset daterange = form.daterange>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            AND  dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
  </cfquery>

 <cfset TotalCountskins=["#getTotalSkinDMSO.SkinDMSO#","#getTotalSkinRNAlater.SkinRNAlater#","#getTotalSkinDCryovial.SkinDCryovial#"]>
   <cfreturn TotalCountskins>
  </cffunction>
  
  
  
 
  
  <!----get All SampleDispositionReportDafault ---->
  <cffunction name="getSampleDispositionReportDafault" access="public" returntype="any" output="false">
  <cfquery name="getDispositionReport" datasource="#variables.dsn#">
  SELECT Sample as Sampletype,Samplehead as Sampleheading,notes as DispositionArchive
        FROM
        dbo.BIOPSY_SHOTS
		   INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
            dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '2016-01-01' AND '2016-12-23'
  
  </cfquery>

  <cfreturn getDispositionReport>
  </cffunction>
  
   <!----get All count Blubbers  BIOPSY_SHOTS ---->
<cffunction name="getTotalBlubbers" access="public" returntype="any" output="false">

  <!---getBlubberTeflonVial--->
  <cfquery name="getBlubberTeflonVial" datasource="#variables.dsn#">
 SELECT COUNT(BlubberTeflonVial) as BlubberTeflonVial 
 FROM [dbo].[BIOPSY_SHOTS] 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
        WHERE 
            dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '2016-01-01' AND '2016-12-23'
  
  </cfquery>
  <!---getBlubberCryovialRed--->
  <cfquery name="getBlubberCryovialRed" datasource="#variables.dsn#">
 SELECT COUNT(BlubberCryovialRed) as BlubberCryovialRed 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
            dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '2016-01-01' AND '2016-12-23'
  
  </cfquery>
  <!---getBlubberCryovialBlue--->
  <cfquery name="getBlubberCryovialBlue" datasource="#variables.dsn#">
 SELECT COUNT(BlubberCryovialBlue) as BlubberCryovialBlue 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
            dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '2016-01-01' AND '2016-12-23'
            
  
  </cfquery>
 
 <cfset TotalCountBlubbers=["#getBlubberTeflonVial.BlubberTeflonVial#","#getBlubberCryovialRed.BlubberCryovialRed#","#getBlubberCryovialBlue.BlubberCryovialBlue#"]>
 
   <cfreturn TotalCountBlubbers>
  </cffunction>
  
  
  <!----get All count  skin's from  BIOPSY_SHOTS ---->
  <cffunction name="getTotalskins" access="public" returntype="any" output="false">
  <!---getTotalSkinDMSO--->
  <cfquery name="getTotalSkinDMSO" datasource="#variables.dsn#">
 SELECT COUNT(SkinDMSO) as SkinDMSO 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
            dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '2016-01-01' AND '2016-12-23'
  
  </cfquery>
  <!---getTotalSkinRNAlater--->
  <cfquery name="getTotalSkinRNAlater" datasource="#variables.dsn#">
 SELECT COUNT(SkinRNAlater) as SkinRNAlater 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
            dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '2016-01-01' AND '2016-12-23'
  
  </cfquery>
  <!---getBlubberCryovialBlue    SkinDCryovial--->
  <cfquery name="getTotalSkinDCryovial" datasource="#variables.dsn#">
 SELECT COUNT(SkinDCryovial) as SkinDCryovial 
 FROM [dbo].[BIOPSY_SHOTS] 
 
		INNER JOIN dbo.SIGHTINGS ON dbo.SIGHTINGS.ID = dbo.BIOPSY_SHOTS.Sighting_ID
        INNER JOIN dbo.TLU_HitLocation ON TLU_HitLocation.ID = dbo.BIOPSY_SHOTS.HitLocation
        INNER JOIN dbo.PROJECTS ON dbo.PROJECTS.ID = dbo.SIGHTINGS.Project_ID
       WHERE 
            dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '2016-01-01' AND '2016-12-23'
            
  
  </cfquery>
 
 <cfset TotalCountskins=["#getTotalSkinDMSO.SkinDMSO#","#getTotalSkinRNAlater.SkinRNAlater#","#getTotalSkinDCryovial.SkinDCryovial#"]>
 
   <cfreturn TotalCountskins>
  </cffunction>
  
  
  
  

<!---- Hit vs Miss functions--------->
<cffunction name="getTotalHitMiss" access="public" returntype="any" output="false">
<cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getTotal"  datasource="#variables.dsn#" result="arbal">

    SELECT dbo.BIOPSY_SHOTS.Biopsy_ID FROM  dbo.BIOPSY_SHOTS
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
        WHERE dbo.BIOPSY_SHOTS.Arbalester = '#form.Arbalester#'
    </cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
        and dbo.BIOPSY_SHOTS.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>


<cfreturn getTotal>
</cffunction>

<cffunction name="getHitsRate" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
    <cfquery name="getHits" datasource="#variables.dsn#" result="arba">
        SELECT Outcome FROM BIOPSY_SHOTS WHERE Outcome = '1'
        <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
            AND Arbalester= '#form.Arbalester#'
        </cfif>
        <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
            <cfset daterange = form.DEFAULT_DATERANGE>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

            AND Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
    </cfquery>


 <cfreturn getHits>
</cffunction>

<cffunction name="getMissRate" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
    <cfquery name="getMiss"   datasource="#variables.dsn#" result="arbale">
    SELECT Outcome FROM BIOPSY_SHOTS WHERE Outcome = '0'

        <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
            AND Arbalester= '#form.Arbalester#'
        </cfif>
        <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
            <cfset daterange = form.DEFAULT_DATERANGE>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

            AND Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
</cfquery>

<cfreturn getMiss>
</cffunction>
<!----End Hit vs Miss functions--------->

<cffunction name="getGoodDiscriptor" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getGood" datasource="#variables.dsn#">
    SELECT count(HitDescriptor) as total FROM BIOPSY_SHOTS WHERE HitDescriptor = '1'
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
        AND Arbalester= '#form.Arbalester#'
    </cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

        and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>
<cfreturn getGood>
</cffunction>

<cffunction name="getHit_waterDiscriptor" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getHit_water" datasource="#variables.dsn#">
    SELECT count(HitDescriptor) as total FROM BIOPSY_SHOTS WHERE HitDescriptor = '2'
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
        AND Arbalester= '#form.Arbalester#'
    </cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

        and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>
<cfreturn getHit_water>
</cffunction>

<cffunction name="getAngledDiscriptor" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getAngled" datasource="#variables.dsn#">
    SELECT count(HitDescriptor) as total FROM BIOPSY_SHOTS WHERE HitDescriptor = '3'
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
    AND Arbalester= '#form.Arbalester#'
</cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

        and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>
<cfreturn getAngled>
</cffunction>

<cffunction name="getDriverJukeDiscriptor" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getDriverJuke" datasource="#variables.dsn#">
    SELECT count(HitDescriptor) as total FROM BIOPSY_SHOTS WHERE HitDescriptor = '5'
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
        AND Arbalester= '#form.Arbalester#'
    </cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
        and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>
<cfreturn getDriverJuke>
</cffunction>

<cffunction name="gettotalHitDiscriptor" returntype="any" output="false" access="public" >
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
    <cfquery name="qgetHitDescriptors" datasource="#variables.dsn#"  >
        select count(HitDescriptor) as total from BIOPSY_SHOTS where HitDescriptor > 0
        <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
            AND Arbalester= '#form.Arbalester#'
        </cfif>
        <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
            <cfset daterange = form.DEFAULT_DATERANGE>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

            and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
    </cfquery>
	<cfreturn qgetHitDescriptors>
</cffunction>


<cffunction name="getGoodHeightDiscriptor" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getGoodHeight" datasource="#variables.dsn#">
    SELECT count(MissDescriptor) as total FROM BIOPSY_SHOTS WHERE MissDescriptor = '1'
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
        AND Arbalester= '#form.Arbalester#'
    </cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

        and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>
<cfreturn getGoodHeight>
</cffunction>

<cffunction name="getLowDiscriptor" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getLow" datasource="#variables.dsn#">
    SELECT count(MissDescriptor) as total FROM BIOPSY_SHOTS WHERE MissDescriptor = '2'
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
        AND Arbalester= '#form.Arbalester#'
    </cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

        and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>
<cfreturn getLow>
</cffunction>

<cffunction name="getHighDiscriptor" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getHigh" datasource="#variables.dsn#">
    SELECT count(MissDescriptor) as total FROM BIOPSY_SHOTS WHERE MissDescriptor = '3'
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
    AND Arbalester= '#form.Arbalester#'
    </cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

        and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>
<cfreturn getHigh>
</cffunction>

<cffunction name="getwind_effectedDiscriptor" access="public" returntype="any" output="false">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getwind_effected" datasource="#variables.dsn#">
    SELECT count(MissDescriptor) as total FROM BIOPSY_SHOTS WHERE MissDescriptor = '4'
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
    AND Arbalester= '#form.Arbalester#'
</cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
        and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
</cfquery>
<cfreturn getwind_effected>
</cffunction>

<cffunction name="gettotalMissDiscriptor" returntype="any" output="false" access="public" >
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
    <cfquery name="qgetHitDescriptors" datasource="#variables.dsn#"  >
        select count(MissDescriptor) as total from BIOPSY_SHOTS where MissDescriptor > 0
        <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
            AND Arbalester= '#form.Arbalester#'
        </cfif>
        <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
            <cfset daterange = form.DEFAULT_DATERANGE>
            <cfset date_sep = daterange.split("-")>
            <cfset dateStart = trim(date_sep[1])>
            <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
            <cfset dateEnd = trim(date_sep[2])>
            <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>
            and Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
        </cfif>
    </cfquery>
	<cfreturn qgetHitDescriptors>
</cffunction>
<!---- Total Hit Descriptor function---------->

<cffunction name="TotalDiscriptor" access="public" returntype="any" output="false">
<cfquery name="getTotalDiscriptor" datasource="#variables.dsn#">

     select DescriptorID from TLU_Descriptors
</cfquery>
<cfreturn getTotalDiscriptor>
</cffunction>

<!---- Hit Descriptor function---------->
<cffunction name="hitTotalDiscriptor" access="public" returntype="any" output="false">
<cfquery name="getHitDiscriptor" datasource="#variables.dsn#">
   select count(DolphinID) from Dolphin_Descriptors GROUP BY DescriptorID
</cfquery>

<cfreturn getHitDiscriptor>
</cffunction>


<cffunction name="hitLocationTotal" access="public" returntype="any" output="false">
<cfquery name="getHitLocation" datasource="#variables.dsn#">
   SELECT  count(HitLocation) AS total FROM BIOPSY_SHOTS  
</cfquery>

<cfreturn getHitLocation>
</cffunction>
<cffunction name="hitLocation" access="public" returntype="any" output="false">
<cfquery name="getHitLocation" datasource="#variables.dsn#">
   SELECT  count(HitLocation) AS total FROM BIOPSY_SHOTS where HitLocation != 0 or HitLocation != Null 
</cfquery>

<cfreturn getHitLocation>
</cffunction>

<cffunction name="hitLocationName" access="public" returntype="any" output="false">
<cfargument name="ID" required="true" default="">
    <cfargument name="Arbalester" default="" type="any">
    <cfargument name="DEFAULT_DATERANGE" default="" type="any">
<cfquery name="getHitLocationName" datasource="#variables.dsn#">
  SELECT tl_h.HitLocationAbbreviation as Name,  
	(select count(bs.HitLocation) from BIOPSY_SHOTS as bs where bs.HitLocation = tl_h.ID
    <cfif isdefined("form.Arbalester") && FORM.Arbalester NEQ ''>
        And bs.Arbalester= '#form.Arbalester#'
    </cfif>
    <cfif isdefined("form.DEFAULT_DATERANGE") && form.DEFAULT_DATERANGE NEQ ''>
        <cfset daterange = form.DEFAULT_DATERANGE>
        <cfset date_sep = daterange.split("-")>
        <cfset dateStart = trim(date_sep[1])>
        <cfset StartDate = DateFormat(dateStart, "yyyy-mm-dd")>
        <cfset dateEnd = trim(date_sep[2])>
        <cfset EndDate = DateFormat(dateEnd, "yyyy-mm-dd")>

        and bs.Enter_Date BETWEEN '#StartDate#' AND '#EndDate#'
    </cfif>
	) as total
		from TLU_HitLocation  as tl_h
</cfquery>

<cfreturn getHitLocationName>
</cffunction>


<!---- Biopsy catalog function---------->

<cffunction name="getDataBiopsyCatalog" access="public" returntype="any" output="false">
	<cfquery name="getData" datasource="#variables.dsn#">
        SELECT 
            dol.Code,dol.Name,bio.Enter_Date as Date, bio.DOLPHIN_ID as ID
            FROM DOLPHINS as dol
            INNER JOIN BIOPSY_SHOTS as bio
            ON dol.ID = bio.DOLPHIN_ID
            WHERE 1 = 1
            <cfif isdefined("form.DEFAULT_DATERANGE")>
				<cfset daterange = form.DEFAULT_DATERANGE>
                <cfset date_sep = daterange.split("-")>
                <cfset dateStart = trim(date_sep[1])>
                <cfset dateEnd = trim(date_sep[2])>
            	and bio.Enter_Date BETWEEN '#dateStart#' AND '#dateEnd#'
        	</cfif>
    </cfquery>
    <cfreturn getData>        
</cffunction>

<cffunction name="getdolphinfin" access="public" returntype="any" output="false">
<cfargument name="ID" type="any" required="true" default="">
	<cfquery name="getFin" datasource="#variables.dsn#">
    	SELECT pro.Date as DATESEEN FROM PROJECTS AS pro
			LEFT JOIN
                ((SIGHTINGS LEFT JOIN 
                	(DOLPHINS RIGHT JOIN 
                	DOLPHIN_SIGHTINGS ON DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID) 
                ON 
                	SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
                LEFT JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID) 
                ON 
                pro.ID = SIGHTINGS.Project_ID
                where DOLPHINS.ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#ID#'>
                order by dateseen desc
    </cfquery>
    <cfreturn getFin>
</cffunction>


<cffunction name="getCameraById" returntype="any" output="false" access="public" >
<cfargument name="ID" type="any" required="true" default="">
    <cfquery name="qgetLens" datasource="#variables.dsn#"  >
        SELECT Camera from TLU_Camera where id = <cfqueryparam  cfsqltype="cf_sql_integer" value='#ID#'>
    </cfquery>
	<cfreturn qgetLens>
</cffunction>

<cffunction name="getHitDescriptorName" returntype="any" output="false" access="public" >
<cfargument name="ID" type="any" required="true" default="">
    <cfquery name="qgetHitDescriptors" datasource="#variables.dsn#"  >
        SELECT HitDescriptors from TLU_HitDescriptors where id = <cfqueryparam  cfsqltype="cf_sql_integer" value='#ID#'>
    </cfquery>
	<cfreturn qgetHitDescriptors>
</cffunction>

<!---Annual Census Report--->

<cffunction name="getAnnualCensusFirstYearReport" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
		DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE
        YEAR (PROJECTS.[Date]) = #FORM.fromYear#<!---BETWEEN #FORM.fromYear# AND #FORM.toYear#--->
        AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]

        ORDER BY
        DOLPHINS.Code
    </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="getAnnualCensusSecondYearReport" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
		DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE
        YEAR (PROJECTS.[Date]) = #FORM.toYear#<!---BETWEEN #FORM.fromYear# AND #FORM.toYear#--->
        AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]

        ORDER BY
        DOLPHINS.Code
    </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="getAnnualCensusUnseenReport" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
		DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE 
        YEAR (PROJECTS.[Date]) = #FORM.fromYear# AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'
		and NOT EXISTS (
		
				SELECT
                    COUNT (
                    DOLPHIN_SIGHTINGS.Dolphin_ID
                    ) AS SEEN_TIMES
                FROM
                PROJECTS
                INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
                INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN DOLPHINS d ON DOLPHIN_SIGHTINGS.Dolphin_ID = d.ID
        
                WHERE 
                YEAR (PROJECTS.[Date]) = #FORM.toYear# and d.Code = DOLPHINS.Code
        
                GROUP BY
                DOLPHIN_SIGHTINGS.Dolphin_ID,
                d.Name,
                d.Code,
                d.Sex,
                d.YearOfBirth,
                YEAR (d.[Date of Death]),
                d.[Dead?]
		)
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]),
        DOLPHINS.[Dead?]

        ORDER BY
        DOLPHINS.Code
    </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="getAnnualCensusNewDolphinsReport" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
		DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE 
        YEAR (PROJECTS.[Date]) = #FORM.toYear# AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'
		and NOT EXISTS (
		
				SELECT
                    COUNT (
                    DOLPHIN_SIGHTINGS.Dolphin_ID
                    ) AS SEEN_TIMES
                FROM
                PROJECTS
                INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
                INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN DOLPHINS d ON DOLPHIN_SIGHTINGS.Dolphin_ID = d.ID
        
                WHERE 
                YEAR (PROJECTS.[Date]) = #FORM.fromYear# and d.Code = DOLPHINS.Code
        
                GROUP BY
                DOLPHIN_SIGHTINGS.Dolphin_ID,
                d.Name,
                d.Code,
                d.Sex,
                d.YearOfBirth,
                YEAR (d.[Date of Death]),
                d.[Dead?]
		)
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]),
        DOLPHINS.[Dead?]

        ORDER BY
        DOLPHINS.Code
    </cfquery>
  <cfreturn  query>
</cffunction>



<cffunction name="getAnnualCensusReportGraph" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        <!---DOLPHIN_SIGHTINGS.Sighting_ID,--->
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        <!---PROJECTS.ID as pro_id,--->
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
		DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE
        YEAR (PROJECTS.[Date]) = #FORM.fromYear#
        AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]<!---,
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID--->

        ORDER BY
        DOLPHIN_SIGHTINGS.Dolphin_ID ASC
    </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="getAnnualCensusReportByBodyOFWater" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        PROJECTS.SurveyArea,
		
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES
        
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        INNER JOIN TLU_SurveyArea on TLU_SurveyArea.AreaName LIKE CONCAT('%', PROJECTS.SurveyArea, '%')

        WHERE 
        YEAR (PROJECTS.[Date]) = #FORM.fromYear# AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'
		
        GROUP BY
        PROJECTS.SurveyArea
    </cfquery>
  <cfreturn  query>
</cffunction>

<cffunction name="getAnnualCensusReportBySegment" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT 
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        TLU_Zones.ZSEGMENT
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
		 INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID

        WHERE
        YEAR (PROJECTS.[Date]) = #FORM.fromYear#
        AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'
        AND TLU_Zones.ZSEGMENT != 'AO'
        GROUP BY
        
        
		TLU_Zones.ZSEGMENT
		ORDER BY
        
        
		TLU_Zones.ZSEGMENT
    </cfquery>
  <cfreturn  query>
</cffunction>

<cffunction name="getAnnualCensusReportByZone" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT 
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        TLU_Zones.ZONE
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
		 INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID

        WHERE
        YEAR (PROJECTS.[Date]) = #FORM.fromYear#
        AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%'
        GROUP BY
        
        
		TLU_Zones.ZONE
    </cfquery>
  <cfreturn  query>
</cffunction>

<cffunction name="getAnnualCensusSub" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        PROJECTS.ID as pro_id,
        YEAR (PROJECTS.[Date]) AS SurveryYear,
        MONTH (PROJECTS.[Date]) AS SurveryMONTH,
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
        YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
        DOLPHINS.[Dead?] AS IsDead,
        DOLPHIN_SIGHTINGS.Sighting_ID
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        WHERE
        YEAR (PROJECTS.[Date]) = #years#
         AND  DOLPHINS.Code    = '#code#'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        YEAR (PROJECTS.[Date]),
        MONTH (PROJECTS.[Date]),
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.DScore,
        DOLPHINS.YearOfBirth,
        DOLPHINS.[Date of Death],
        DOLPHINS.[Dead?],
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
       </cfquery>
  <cfreturn  query>
</cffunction>
<!---Annual Census Report--->

<!---Population Viability Report--->

<cffunction name="getAnnualSightingreportFromStart" returntype="any" output="false" access="public" >
    <cfset CurrentYear = year(now())>
    <cfquery name="query" datasource="#variables.dsn#" >        
        <!---select SIGHTING_YEAR,sum(calf) calf,sum(juvenal) juvenal,sum(adult) adult,sum(unknown) unknown
        from(
               SELECT  count(DOLPHIN_SIGHTINGS.Dolphin_ID) seen_time,YEAR(DATE) AS SIGHTING_YEAR,
                        (sum(Distinct case 
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ([Dead?]=0 OR [Date of Death] = '') and YEAR(DATE) - YEAR(YEAROFBIRTH) <= 4) then 1
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ISNUMERIC(YEAR([Date of Death])) = 1 AND [Date of Death]!= '' and YEAR([Date of Death]) - YEAR(YEAROFBIRTH) <= 4) then 1
                            else 0 end)) as calf,
                        (sum(Distinct case 
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ([Dead?]=0 OR [Date of Death] = '') and YEAR(DATE) - YEAR(YEAROFBIRTH) > 4 and YEAR(DATE) - YEAR(YEAROFBIRTH) < 10) then 1
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ISNUMERIC(YEAR([Date of Death])) = 1 AND [Date of Death]!= '' and YEAR([Date of Death]) - YEAR(YEAROFBIRTH) > 4 and YEAR([Date of Death]) - YEAR(YEAROFBIRTH) < 10) then 1
                            else 0 end)) as juvenal,
                        (sum(Distinct case 
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ([Dead?]=0 OR [Date of Death] = '') and YEAR(DATE) - YEAR(YEAROFBIRTH) > 7) then 1
							when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ISNUMERIC(YEAR([Date of Death])) = 1 AND [Date of Death] != '' and YEAR([Date of Death]) - YEAR(YEAROFBIRTH) > 7) then 1
							else 0
                            end)) as adult,
                        (sum(Distinct case 
                            when (ISNUMERIC(YEAROFBIRTH) = 0 AND YEAROFBIRTH='') then 1
                            
							else 0
							end)) as unknown
                FROM
                PROJECTS
                INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
                INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
            
                WHERE
                YEAR(DATE)  >= 1998 AND YEAR(DATE) <= '#CurrentYear#' and
                DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%' AND DOLPHINS.Code NOT LIKE 'MUM%'
                
                group by YEAR(DATE),DOLPHIN_SIGHTINGS.Dolphin_ID
                
        ) as result

        group by SIGHTING_YEAR
        order by SIGHTING_YEAR--->
        
select SIGHTING_YEAR,sum(calf) calf,sum(juvenal) juvenal,sum(adult) adult,sum(unknown) unknown
        from(
               SELECT  count(DOLPHIN_SIGHTINGS.Dolphin_ID) seen_time,YEAR(DATE) AS SIGHTING_YEAR,DOLPHIN_SIGHTINGS.Dolphin_ID,
                        (sum(Distinct case 
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND  ([Dead?]=0 OR [Date of Death] is null) and YEAR(DATE) - YEAR(YEAROFBIRTH) <= 4) then 1
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ISNUMERIC(YEAR([Date of Death])) = 1 AND [Date of Death] is not null and YEAR([Date of Death]) - YEAR(YEAROFBIRTH) <= 4) then 1
                            else 0 end)) as calf,
                        (sum(Distinct case 
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ([Dead?]=0 OR [Date of Death] is null) and (((YEAR(DATE) - YEAR(YEAROFBIRTH) >= 5) and (YEAR(DATE) - YEAR(YEAROFBIRTH) <= 9) AND (Sex = 'M')) OR (((YEAR(DATE) - YEAR(YEAROFBIRTH) >= 5) and (YEAR(DATE) - YEAR(YEAROFBIRTH) <= 6) AND (Sex = 'F'))) OR ((YEAR(DATE) - YEAR(YEAROFBIRTH) > 4) and (YEAR(DATE) - YEAR(YEAROFBIRTH) < 10) AND (Sex = 'U')))) then 1
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ISNUMERIC(YEAR([Date of Death])) = 1 AND [Date of Death] is not null and (((YEAR([Date of Death]) - YEAR(YEAROFBIRTH) >= 5) and (YEAR([Date of Death]) - YEAR(YEAROFBIRTH) <= 9) AND (Sex = 'M')) OR ((YEAR([Date of Death]) - YEAR(YEAROFBIRTH) >= 5) and (YEAR([Date of Death]) - YEAR(YEAROFBIRTH) <= 6) AND (Sex = 'F')) OR ((YEAR([Date of Death]) - YEAR(YEAROFBIRTH) > 4) and (YEAR([Date of Death]) - YEAR(YEAROFBIRTH) < 10) AND (Sex = 'U')))) then 1
                            else 0 end)) as juvenal,
                        (sum(Distinct case 
                            when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ([Dead?]=0 OR [Date of Death] is null) and (((YEAR(DATE) - YEAR(YEAROFBIRTH) >= 7) AND (Sex = 'F')) OR ((YEAR(DATE) - YEAR(YEAROFBIRTH) >= 10) AND (Sex = 'M')) OR ((YEAR(DATE) - YEAR(YEAROFBIRTH) >= 10) AND (Sex = 'U')) )) then 1
							when (YEAROFBIRTH!='' AND ISNUMERIC(YEAROFBIRTH) = 1 AND ISNUMERIC(YEAR([Date of Death])) = 1 AND [Date of Death] is not null and (((YEAR([Date of Death]) - YEAR(YEAROFBIRTH) >= 7) AND (Sex = 'F')) OR ((YEAR([Date of Death]) - YEAR(YEAROFBIRTH) >= 10) AND (Sex = 'M')) OR ((YEAR([Date of Death]) - YEAR(YEAROFBIRTH) >= 10) AND (Sex = 'U'))) ) then 1
							else 0
                            end)) as adult,
                        (sum(Distinct case 
                            when (ISNUMERIC(YEAROFBIRTH) = 0 AND YEAROFBIRTH='') then 1
                            
							else 0
							end)) as unknown
                FROM
                PROJECTS
                INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
                INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
                INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
            
                WHERE
                YEAR(DATE)  >= 1998 AND YEAR(DATE) <= '#CurrentYear#' and
                DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%' AND DOLPHINS.Code NOT LIKE 'MUM%'
                
                group by YEAR(DATE),DOLPHIN_SIGHTINGS.Dolphin_ID
                
        ) as result

        group by SIGHTING_YEAR
        order by SIGHTING_YEAR
        
        
    </cfquery>
	<cfreturn  query>
</cffunction>


<cffunction name="getAnnualCensusReportGraphPopulationViability" returntype="any" output="false" access="public" >
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT
        <!---DOLPHIN_SIGHTINGS.Sighting_ID,--->
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        <!---PROJECTS.ID as pro_id,--->
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
		DOLPHINS.[Dead?] AS IsDead
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE
        YEAR (PROJECTS.[Date]) = #FORM.fromYear#
        AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%' AND DOLPHINS.Code NOT LIKE 'MUM%'
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,
		YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]<!---,
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID--->

        ORDER BY
        DOLPHIN_SIGHTINGS.Dolphin_ID ASC
    </cfquery>
  <cfreturn  query>
</cffunction>


<!---Population Viability Report--->

<!---MMHSRP Report--->
<cffunction name="DolphinDeathBySex" access="public" returntype="any" output="false">
  <cfargument name="cohortSex" type="any" required="true" default="">
  <cfargument name="cohortStartYear" type="any" required="true" default="">
  <cfargument name="cohortEndYear" type="any" required="true" default="">
  <cfargument name="cohortName" type="any" required="true" default="">
  
  <cfquery name="getRec" datasource="#variables.dsn#">
    SELECT Sex,ID,YEAR ([Date of Death]) As DeathYear
    FROM
    dbo.DOLPHINS
    Where dbo.DOLPHINS.[Dead?] = 1 <cfif cohortSex NEQ '-'>AND dbo.DOLPHINS.Sex = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cohortSex#"></cfif> 
    AND YEAR (dbo.DOLPHINS.[Date of Death]) BETWEEN '#cohortStartYear#' AND '#cohortEndYear#'
    <cfif cohortName eq 'UNK'>AND Code LIKE 'UNK%'<cfelseif cohortName eq 'NK'>AND Code NOT LIKE 'UNK%'</cfif>
  </cfquery>
  
  <cfreturn getRec/>
</cffunction>

<cffunction name="DolphinAgeAtDeath" access="public" returntype="any" output="false">
  <cfargument name="ageAtDeathStartYear" type="any" required="true" default="">
  <cfargument name="ageAtDeathEndYear" type="any" required="true" default="">
  
  <cfquery name="getRec" datasource="#variables.dsn#">
    SELECT ID,Code,YEAR ([Date of Death])-YEAROFBIRTH As AgeAtDeath
    FROM
    dbo.DOLPHINS
    Where [Date of Death] BETWEEN '#ageAtDeathStartYear#' and '#ageAtDeathEndYear#' AND dbo.DOLPHINS.[Dead?] = 1 
    AND [Date of Death]!='' AND YEAROFBIRTH!='' AND YEAR ([Date of Death])-YEAROFBIRTH !=0
  </cfquery>
  <cfreturn getRec/>
</cffunction>

<cffunction name="DolphinDeathBySegment" access="public" returntype="any" output="false">
  <cfargument name="deathBySegmentStartYear" type="any" required="true" default="">
  <cfargument name="deathBySegmentEndYear" type="any" required="true" default="">
  
  <cfquery name="getRec" datasource="#variables.dsn#">
    SELECT  TLU_Zones.ZSEGMENT,count(Dolphins.[Dead?]) deathCount
    FROM
    PROJECTS
    INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
    INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
    INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
    INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID
    Where Dolphins.[Dead?] = 1 and [Date of Death] BETWEEN '#deathBySegmentStartYear#' and '#deathBySegmentEndYear#' and zsegment!='AO'
    group by TLU_Zones.ZSEGMENT
    ORDER BY       
    TLU_Zones.ZSEGMENT
  </cfquery>
  <cfreturn getRec/>
</cffunction>

<!---MMHSRP Report--->

<!---COA Report--->
<cffunction name="getCOAReport" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear"   type="any" required="true" default="">
  <cfargument name="Seen"      type="any" required="true" default="">
  <cfargument name="Mother"    type="any"  default="">
  <cfargument name="Segment"   type="any"  default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	SELECT
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_COMBINE,
        DOLPHINS.Code,
		DOLPHINS.Mothers,
        DOLPHINS.Lineage,
        DOLPHINS.[Date of Birth Estimate] AS BIRTH_ESTIMATE,DOLPHINS.LINEAGE,
		(
			SELECT   COUNT (DS1.Dolphin_ID)
			FROM PROJECTS P1
			INNER JOIN SIGHTINGS S1 ON S1.Project_ID = P1.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS1 ON S1.ID = DS1.Sighting_ID
			INNER JOIN DOLPHINS D1 ON DS1.Dolphin_ID = D1.ID
            <cfif Segment NEQ ''> INNER JOIN TLU_Zones tz ON S1.Zone_id = tz.ID</cfif>

			WHERE YEAR (P1.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D1.Lineage Is Not Null AND D1.CODE = DOLPHINS.CODE 
            AND <cfif Mother NEQ ''>D1.Mothers  = '#Mother#'<cfelse>D1.Mothers Is Not Null</cfif>
            <cfif Segment NEQ ''> AND tz.zsegment <cfif Segment NEQ 'group'>= '#Segment#'<cfelse> IN ('2','3','4') </cfif> </cfif>
		
		) AS CALF_SEEN,
		(
			SELECT   COUNT (DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			<cfif Segment NEQ ''> INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID</cfif>
            
			WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null And D2.MOTHERS = DOLPHINS.MOTHERS
            <cfif Segment NEQ ''> AND tz.zsegment <cfif Segment NEQ 'group'>= '#Segment#'<cfelse> IN ('2','3','4') </cfif> </cfif>
		
		) AS MOTHER_SEEN,
        
       (    SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null AND D2.MOTHERS = DOLPHINS.MOTHERS 
            AND tz.zsegment = '1A'
        )   as segment_1A,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null And D2.MOTHERS = DOLPHINS.MOTHERS 
            AND tz.zsegment = '1B'
        )   as segment_1B,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null And D2.MOTHERS = DOLPHINS.MOTHERS 
            AND tz.zsegment = '1C'
        )   as segment_1C,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null And D2.MOTHERS = DOLPHINS.MOTHERS 
            AND tz.zsegment = '2'
        )   as segment_2,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null And D2.MOTHERS = DOLPHINS.MOTHERS 
            AND tz.zsegment = '3'
        )   as segment_3,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null And D2.MOTHERS = DOLPHINS.MOTHERS 
            AND tz.zsegment = '4'
        )   as segment_4,
        
       (	SELECT top 1 P2.Date
            FROM PROJECTS P2
            INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
            INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
            INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
            <cfif Segment NEQ ''> INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID</cfif>
    
            WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null
            AND <cfif Mother NEQ ''>D2.Mothers = '#Mother#'<cfelse>D2.Mothers Is Not Null</cfif>
            <cfif Segment NEQ ''> AND tz.zsegment <cfif Segment NEQ 'group'>= '#Segment#'<cfelse> IN ('2','3','4') </cfif> </cfif>
            AND D2.ID = DOLPHIN_SIGHTINGS.Dolphin_ID
            order by P2.ID desc
       )    as LastSceen,
       
       (	SELECT top 1 DATEDIFF(year,D2.YearOfBirth,p2.[Date])
            FROM PROJECTS P2
            INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
            INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
            INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
            <cfif Segment NEQ ''> INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID</cfif>
    
            WHERE YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND D2.Lineage Is Not Null
            AND <cfif Mother NEQ ''>D2.Mothers = '#Mother#'<cfelse>D2.Mothers Is Not Null</cfif>
            <cfif Segment NEQ ''> AND tz.zsegment <cfif Segment NEQ 'group'>= '#Segment#'<cfelse> IN ('2','3','4') </cfif> </cfif>
            AND D2.ID = DOLPHIN_SIGHTINGS.Dolphin_ID
            order by P2.ID desc
       )    as AgeAtLastSceen  
          
        
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        <cfif Segment NEQ ''>INNER JOIN TLU_Zones tz ON SIGHTINGS.Zone_id = tz.ID</cfif>

        WHERE YEAR (PROJECTS.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND DOLPHINS.Lineage Is Not Null
        AND <cfif Mother NEQ ''>DOLPHINS.Mothers = '#Mother#'<cfelse>DOLPHINS.Mothers Is Not Null</cfif>
        <cfif Segment NEQ ''> AND tz.zsegment <cfif Segment NEQ 'group'>= '#Segment#'<cfelse> IN ('2','3','4') </cfif> </cfif>
        
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Code,	
		DOLPHINS.Mothers,
        DOLPHINS.[Date of Birth Estimate],
        DOLPHINS.LINEAGE
        
        <cfif Seen NEQ ''>
        	HAVING COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) 
		    <cfif Seen EQ '2-5'>
                >=2 AND COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) <= 5
            <cfelseif Seen EQ '6-10'>
                >=6 AND COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) <= 10
            <cfelse>
                #Seen# 
            </cfif>               
        </cfif>

		order by DOLPHINS.MOTHERS,DOLPHINS.LINEAGE
     </cfquery>
   <cfreturn getRec/>  
</cffunction>
<cffunction name="getCOAdetail" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear" type="any" required="true" default="">
  <cfargument name="CODE" type="any" required="true" default="">
  <cfargument name="Mothers" type="any" required="true" default="">
  
    <cfquery name="getRec" datasource="#variables.dsn#">
		SELECT
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID as pro_id,
        PROJECTS.Date as DateSeen
        
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE YEAR (PROJECTS.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' AND DOLPHINS.Lineage Is Not Null AND DOLPHINS.Mothers = '#Mothers#' 
        AND DOLPHINS.CODE = '#CODE#'
        
		order by DOLPHIN_SIGHTINGS.Sighting_ID
     </cfquery>
   <cfreturn getRec/>  
</cffunction>
<cffunction name="getAllMothers" access="public" returntype="any" output="false">
  
    <cfquery name="getRec" datasource="#variables.dsn#">
		SELECT Distinct Mothers
        
        FROM DOLPHINS
        WHERE Mothers!=''
        
		order by Mothers
     </cfquery>
   <cfreturn getRec/>  
</cffunction>
<!---COA Report--->

<!---Birth -Death Rate Report--->
<cffunction name="getBirthRateBySegment" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear"   type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	  SELECT 
        DOLPHIN_SIGHTINGS.Dolphin_ID,TLU_Zones.ZSEGMENT
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
		INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID

        WHERE [DOB EST] IS NOT NULL AND [DOB EST]!='' AND Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])) BETWEEN '#StartYear#' AND '#EndYear#' AND TLU_Zones.ZSEGMENT != 'AO'
        GROUP BY TLU_Zones.ZSEGMENT,DOLPHIN_SIGHTINGS.Dolphin_ID
        ORDER BY TLU_Zones.ZSEGMENT
   </cfquery>
   <cfreturn getRec/>  
</cffunction>
<cffunction name="getBirthRateByYear" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear"   type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	  
	  SELECT  COUNT (ID) AS SEEN_TIMES,Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])) as Years
      FROM DOLPHINS

      WHERE [DOB EST] IS NOT NULL AND [DOB EST]!='' AND Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])) BETWEEN '#StartYear#' AND '#EndYear#'

      GROUP BY Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST]))
      ORDER BY Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST]))
   </cfquery>
   <cfreturn getRec/>  
</cffunction>
<cffunction name="getBirthRateByMonth" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear"   type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	  SELECT 
        COUNT (
        *
        ) AS SEEN_TIMES,
        concat(DATENAME(month,DATEFROMPARTS ( Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])), SUBSTRING([DOB EST],0,charindex('/',[DOB EST])), '1' )),' - ',Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST]))) as Months
        FROM
        DOLPHINS

        WHERE [DOB EST] is not null and [DOB EST]!='' and Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])) between '#StartYear#' AND '#EndYear#'

        GROUP BY Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])),SUBSTRING([DOB EST],0,charindex('/',[DOB EST]))
        ORDER BY Year(DATEFROMPARTS ( Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])), SUBSTRING([DOB EST],0,charindex('/',[DOB EST])), '1' )),Month(DATEFROMPARTS ( Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])), SUBSTRING([DOB EST],0,charindex('/',[DOB EST])), '1' ))
   </cfquery>
   <cfreturn getRec/>  
</cffunction>

<cffunction name="getDeathRateBySegment" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear"   type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	  SELECT 
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        TLU_Zones.ZSEGMENT
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
		INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID

        WHERE Dolphins.[Date of Death] IS NOT NULL AND Dolphins.[Date of Death]!='' AND Year(Dolphins.[Date of Death]) BETWEEN '#StartYear#' AND '#EndYear#' AND TLU_Zones.ZSEGMENT != 'AO'
        GROUP BY TLU_Zones.ZSEGMENT,DOLPHIN_SIGHTINGS.Dolphin_ID
        ORDER BY TLU_Zones.ZSEGMENT
   </cfquery>
   <cfreturn getRec/>  
</cffunction> 
<cffunction name="getDeathRateByYear" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear"   type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	  
	  SELECT COUNT (ID) AS SEEN_TIMES,YEAR([Date of Death]) as Years
      FROM DOLPHINS

      WHERE [Date of Death] IS NOT NULL AND [Date of Death]!='' AND YEAR([Date of Death]) BETWEEN '#StartYear#' AND '#EndYear#'

      GROUP BY YEAR([Date of Death])
      ORDER BY YEAR([Date of Death])
   </cfquery>
   <cfreturn getRec/>  
</cffunction>  
<cffunction name="getDeathRateByMonth" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear"   type="any" required="true" default="">
  <cfquery name="getRec" datasource="#variables.dsn#">
	SELECT COUNT (ID) AS SEEN_TIMES,concat(DATENAME(month,[Date of Death]),' - ',YEAR([Date of Death])) MONTHS
    FROM DOLPHINS

    WHERE [Date of Death] is not null and [Date of Death]!='' and YEAR([Date of Death]) between '#StartYear#' AND '#EndYear#'

    GROUP BY YEAR([Date of Death]),MONTH([Date of Death]),DATENAME(month,[Date of Death])
    ORDER BY YEAR([Date of Death]),MONTH([Date of Death])
  </cfquery>
  <cfreturn getRec/>  
</cffunction>        
      
<!---Birth -Death Rate Report--->

<!---Home Range Report--->
<cffunction name="getHomeRangeReport" returntype="any" output="false" access="public" >
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear"   type="any" required="true" default="">
  <cfargument name="Seen"      type="any" required="true" default="">
  <cfargument name="Mother"    type="any"  default="">
  <cfargument name="Segment"   type="any"  default="">
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT DOLPHIN_SIGHTINGS.Dolphin_ID, COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) AS SEEN_TIMES,DOLPHINS.Name,DOLPHINS.Code,DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,YEAR (DOLPHINS.[Date of Death]) AS DeathYear,DOLPHINS.[Dead?] AS IsDead<!---,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif> 
            AND tz.zsegment = '1A'
        )   as segment_1A,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif> 
            AND tz.zsegment = '1B'
        )   as segment_1B,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif> 
            AND tz.zsegment = '1C'
        )   as segment_1C,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif> 
            AND tz.zsegment = '2'
        )   as segment_2,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif> 
            AND tz.zsegment = '3'
        )   as segment_3,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif> 
            AND tz.zsegment = '4'
        )   as segment_4--->
        
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        <cfif Segment NEQ ''>INNER JOIN TLU_Zones tz ON SIGHTINGS.Zone_id = tz.ID</cfif>

        WHERE YEAR (PROJECTS.[Date]) BETWEEN #FORM.StartYear# AND #FORM.EndYear# <cfif Mother NEQ ''>AND DOLPHINS.Mothers = '#Mother#'</cfif>
		<cfif Segment NEQ ''> AND tz.zsegment <cfif Segment NEQ 'group'>= '#Segment#'<cfelse> IN ('2','3','4') </cfif> </cfif>
        GROUP BY DOLPHIN_SIGHTINGS.Dolphin_ID,DOLPHINS.Name,DOLPHINS.Code,DOLPHINS.Sex,DOLPHINS.YearOfBirth,YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]

        HAVING COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) >= '#FORM.Seen#'

        ORDER BY DOLPHIN_SIGHTINGS.Dolphin_ID ASC
    </cfquery>
  <cfreturn  query>
</cffunction>
<cffunction name="getDolphinDetail" access="public" returntype="any" output="false">
  <cfargument name="StartYear" type="any" required="true" default="">
  <cfargument name="EndYear" type="any" required="true" default="">
  <cfargument name="CODE" type="any" required="true" default="">
  <cfargument name="Mother" type="any" default="">
  <cfargument name="Segment" type="any"  default="">
  <cfargument name="BodyCondition" type="any" default="All">
  
    <cfquery name="getRec" datasource="#variables.dsn#">
		SELECT
        DOLPHIN_SIGHTINGS.Sighting_ID,
        PROJECTS.ID as pro_id,
        PROJECTS.Date as DateSeen
        
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        <cfif Segment NEQ ''>INNER JOIN TLU_Zones tz ON SIGHTINGS.Zone_id = tz.ID</cfif>

        WHERE DOLPHINS.CODE = '#CODE#' AND YEAR (PROJECTS.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
		<cfif Mother NEQ ''>AND DOLPHINS.Mothers = '#Mother#'</cfif> 
        <cfif Segment NEQ ''> AND tz.zsegment <cfif Segment NEQ 'group'>= '#Segment#'<cfelse> IN ('2','3','4') </cfif> </cfif>
        <cfif BodyCondition NEQ 'All'>AND DOLPHIN_SIGHTINGS.BodyCondition = '#BodyCondition#'</cfif> 
        
		order by DOLPHIN_SIGHTINGS.Sighting_ID
     </cfquery>
   <cfreturn getRec/>  
</cffunction>
<!---Home Range Report--->

<!---Body Condition Report--->

<!---<cffunction name="getBodyConditionReport" returntype="any" output="false" access="public" >
  <cfargument name="StartYear"       type="any"  required="true" default="">
  <cfargument name="EndYear"         type="any"  required="true" default="">
  <cfargument name="BodyCondition"   type="any"  default="">
  <cfargument name="SegmentReport"   type="any"  default="">
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT DOLPHIN_SIGHTINGS.Dolphin_ID, COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) AS SEEN_TIMES,DOLPHINS.Name,DOLPHINS.Code,DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,YEAR (DOLPHINS.[Date of Death]) AS DeathYear,DOLPHINS.[Dead?] AS IsDead<cfif SegmentReport eq 1>,TLU_Zones.ZSegment</cfif>,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif> 
            AND tz.zsegment = '1A'
        )   as segment_1A,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif>  
            AND tz.zsegment = '1B'
        )   as segment_1B,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif>  
            AND tz.zsegment = '1C'
        )   as segment_1C,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif> 
            AND tz.zsegment = '2'
        )   as segment_2,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif>  
            AND tz.zsegment = '3'
        )   as segment_3,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif>
            AND tz.zsegment = '4'
        )   as segment_4
        
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        <cfif SegmentReport eq 1>INNER JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID</cfif>

        WHERE YEAR (PROJECTS.[Date]) BETWEEN #FORM.StartYear# AND #FORM.EndYear# 
		<cfif BodyCondition NEQ 'All'>AND DOLPHIN_SIGHTINGS.BodyCondition = '#BodyCondition#'</cfif> 
        GROUP BY DOLPHIN_SIGHTINGS.Dolphin_ID,DOLPHINS.Name,DOLPHINS.Code,DOLPHINS.Sex,DOLPHINS.YearOfBirth,YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]<cfif SegmentReport eq 1>,TLU_Zones.ZSegment</cfif>

        ORDER BY DOLPHIN_SIGHTINGS.Dolphin_ID ASC
    </cfquery>
  <cfreturn  query>
</cffunction>--->
<cffunction name="getBodyConditionReport" returntype="any" output="false" access="public" >
  <cfargument name="StartYear"       type="any"  required="true" default="">
  <cfargument name="EndYear"         type="any"  required="true" default="">
  <cfargument name="BodyCondition"   type="any"  default="">
  <cfargument name="SegmentReport"   type="any"  default="">
  <cfquery name="query" datasource="#variables.dsn#" >
        SELECT DOLPHIN_SIGHTINGS.Dolphin_ID, COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) AS SEEN_TIMES,DOLPHINS.Name,DOLPHINS.Code,DOLPHINS.Sex,
        DOLPHINS.YearOfBirth,YEAR (DOLPHINS.[Date of Death]) AS DeathYear,DOLPHINS.[Dead?] AS IsDead<cfif SegmentReport eq 1>,TLU_Zones.ZSegment</cfif>
        
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        <cfif SegmentReport eq 1>INNER JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID</cfif>

        WHERE YEAR (PROJECTS.[Date]) BETWEEN #FORM.StartYear# AND #FORM.EndYear# 
		<cfif BodyCondition NEQ 'All'>AND DOLPHIN_SIGHTINGS.BodyCondition = '#BodyCondition#'</cfif> 
        GROUP BY DOLPHIN_SIGHTINGS.Dolphin_ID,DOLPHINS.Name,DOLPHINS.Code,DOLPHINS.Sex,DOLPHINS.YearOfBirth,YEAR (DOLPHINS.[Date of Death]),
		DOLPHINS.[Dead?]<cfif SegmentReport eq 1>,TLU_Zones.ZSegment</cfif>

        ORDER BY DOLPHIN_SIGHTINGS.Dolphin_ID ASC
    </cfquery>
  <cfreturn  query>
</cffunction>

<cffunction name="getDolphinSegmentsDetail" returntype="any" output="false" access="public" >
  <cfargument name="StartYear"       type="any"  required="true" default="">
  <cfargument name="EndYear"         type="any"  required="true" default="">
  <cfargument name="BodyCondition"   type="any"  default="">
  <cfargument name="Dolphin_ID"      type="any"  default="">
  <cfargument name="Mother"      	 type="any"  default="">
  <cfquery name="query" datasource="#variables.dsn#" >

	SELECT 
		(   SELECT  count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif> 
            <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif>
            AND tz.zsegment = '1A'
        )   as segment_1A,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif>
            <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif>  
            AND tz.zsegment = '1B'
        )   as segment_1B,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif>
            <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif>  
            AND tz.zsegment = '1C'
        )   as segment_1C,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif>
            <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif> 
            AND tz.zsegment = '2'
        )   as segment_2,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif> 
            <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif> 
            AND tz.zsegment = '3'
        )   as segment_3,
        
        (   SELECT   count(DS2.Dolphin_ID)
			FROM PROJECTS P2
			INNER JOIN SIGHTINGS S2 ON S2.Project_ID = P2.ID
			INNER JOIN DOLPHIN_SIGHTINGS DS2 ON S2.ID = DS2.Sighting_ID
			INNER JOIN DOLPHINS D2 ON DS2.Dolphin_ID = D2.ID
			INNER JOIN TLU_Zones tz ON S2.Zone_id = tz.ID

			WHERE D2.CODE = DOLPHINS.CODE AND YEAR (P2.[Date]) BETWEEN '#StartYear#' AND '#EndYear#' 
			<cfif BodyCondition NEQ 'All'>AND DS2.BodyCondition = '#BodyCondition#'</cfif>
            <cfif Mother NEQ ''>AND D2.Mothers = '#Mother#'</cfif>
            AND tz.zsegment = '4'
        )   as segment_4
 
		FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE DOLPHINS.ID = '#Dolphin_ID#' <cfif BodyCondition NEQ 'All'>AND DOLPHIN_SIGHTINGS.BodyCondition = '#BodyCondition#'</cfif> AND 
        YEAR (PROJECTS.[Date]) BETWEEN #FORM.StartYear# AND #FORM.EndYear# 
        GROUP BY DOLPHINS.CODE        
	</cfquery>
  <cfreturn  query>  
</cffunction>  
<cffunction name="getBodyConditionByYear" returntype="any" output="false" access="public" >
    <cfargument name="StartYear"       type="any"  required="true" default="">
  	<cfargument name="EndYear"         type="any"  required="true" default="">
  	<cfargument name="BodyCondition"   type="any"  default="">
    <cfquery name="query" datasource="#variables.dsn#" >        
      	SELECT  COUNT(Distinct DOLPHIN_SIGHTINGS.Dolphin_ID) Dolphin_Seen,YEAR(DATE) AS SIGHTING_YEAR
                        
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID

        WHERE YEAR (PROJECTS.[Date]) BETWEEN #FORM.StartYear# AND #FORM.EndYear# 
		<cfif BodyCondition NEQ 'All'>AND DOLPHIN_SIGHTINGS.BodyCondition = '#BodyCondition#'</cfif> 
        
        GROUP BY YEAR(PROJECTS.DATE)
        ORDER BY YEAR(PROJECTS.DATE)
    </cfquery>
	<cfreturn  query>
</cffunction>      
<!---Body Condition Report--->

<!---Dolphin Activity Report--->
<cffunction name="getDolphinActivityReport" returntype="any" output="false" access="public" >
    <cfargument name="StartYear"       type="any"  required="true" default="">
  	<cfargument name="EndYear"         type="any"  required="true" default="">
    <cfquery name="query" datasource="#variables.dsn#" >        
      	SELECT COUNT (DOLPHIN_SIGHTINGS.Dolphin_ID) AS SEEN_TIMES,TLU_Zones.ZONE
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
		INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID

        WHERE YEAR (PROJECTS.[Date]) BETWEEN #FORM.StartYear# AND #FORM.EndYear#  
		AND ((Activity_Mill is not null and Activity_Mill!=0) or (Activity_Feed is not null and Activity_Feed!=0) or 
			 (Activity_ProbFeed is not null and Activity_ProbFeed!=0) or (Activity_Travel is not null and Activity_Travel!=0) or
			 (Activity_Play is not null and Activity_Play!=0) or (Activity_Rest is not null and Activity_Rest!=0) 
             or (Activity_Leap_tailslap_chuff is not null and Activity_Leap_tailslap_chuff!=0) or (Activity_Social is not null and Activity_Social!=0) 
             or (Activity_WithBoat is not null and Activity_WithBoat!=0) or (Depredation is not null and Depredation!=0) 
             or (Herding is not null and Herding!=0))
        GROUP BY TLU_Zones.ZONE
    </cfquery>
	<cfreturn  query>
</cffunction>
<!---Dolphin Activity Report--->
<!---All Form Report Excel--->
<cffunction  name="allFormExcel" returntype="any" output="false" access="remote">
  <cfset getAreaName =  Application.Sighting.getAreaName()>
  <cfset getSurveyRouteData = Application.StaticDataNew.getSurveyRoute()>
  <cfset qGetAssocBioData=Application.SightingNew.qGetAssocBioData()>
  <cfset getBehaviorsData = Application.StaticDataNew.getBehavior()>
  <cfset getPreySpeciesData = Application.StaticDataNew.getPreySpecies()>
  <cfset StructureList = Application.SightingNew.getStructureList()>
  <cfset getStock = Application.StaticDataNew.getStock()>
  <cfif isdefined("form.date") and form.date NEQ "">
    <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
    <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
  </cfif>
  <cfquery name="RTmembers" datasource="#variables.dsn#">
    SELECT * from TLU_ResearchTeamMembers
  </cfquery>
  <cfquery name="lesionRegion" datasource="#variables.dsn#">
    SELECT * from TLU_Regions
  </cfquery>

  <cfquery datasource="#variables.dsn#" name="qFiltered">
    SELECT
    s.ID AS SurveyID,
    CONVERT(varchar, s.DATE) AS DATE,
    s.SurveyRoute,
    s.BodyOfWater,
    s.Platform,
    s.NOAAStock,
    s.SurveyType,
    ss.Survey AS SurveyEffort,
    CONVERT(varchar, s.EngineOn) AS EngineOn,
    CONVERT(varchar, s.EngineOff) AS EngineOff,
    CONVERT(varchar, s.SurveyStart) AS SurveyStart,
    CONVERT(varchar, s.SurveyEnd) AS SurveyEnd,
    s.ResearchTeam,
    ss.SightingNumber,
    ss.ID AS sightingID,
    CONVERT(varchar, ss.SightingStart) AS SightingStart,
    CONVERT(varchar, ss.SightingEnd) AS SightingEnd,
    ss.ICW_Start AS At_ICW_Marker,
    ss.Location,
    ss.InitialLatitude,
    ss.InitialLongitude,
    ss.AtLatitude,
    ss.AtLongitude,
    ss.EndLatitude,
    ss.EndLongitude,
    ss.WaterTemp,
    ss.Comments,
    w.[Desc] AS Weather,
    wh.[Desc] AS WaveHeight,
    g.[Desc] AS Glare,
    gd.[Desc] AS GlareDirection,
    st.[Desc] AS Sightability,
    bt.[Desc] AS Beaufort,
    ss.HabitatDepth,
    ht.HabitatName,
    ss.AirTemp,
    ss.WindSpeed,
    gdw.[Desc] AS WindDirection,
    td.TideName,
    ss.Salinity,
    ss.pH,
    ss.DO,
    ss.Conductivity,
    ih.HeadingName AS InitialHeading,
    gh.GHeadingName AS GeneralHeading,
    fh.FHeadingName AS FinalHeading,
    ss.AssocBio,
    FE_TotalCetaceans_Max,
    FE_TotalCetaceans_Min,
    FE_TotalCetacean_Best,
    FE_TotalCetacean_takes,
    FE_TotalAdults_Min,
    FE_TotalAdults_Max,
    FE_TotalAdults_Best,
    FE_TotalAdults_takes,
    FE_TotalCalves_Max,
    FE_TotalCalves_Min,
    FE_TotalCalves_Best,
    FE_TotalCalves_takes,
    FE_YoungOfYear_Min,
    FE_YoungOfYear_Max,
    FE_YoungOfYear_Best,
    FE_YoungOfYear_takes,
    Act_Mill,
    Act_Feed,
    Act_Rest,
    Act_Other,
    Act_Social,
    Act_Travel,
    Act_Prob_Feed,
    Act_With_Boat,
    Act_Avoid_Boat,
    Act_Object_Play,
    BehavioralSpecifics1,
    BehavioralSpecificsN1,
    BehavioralSpecifics2,
    BehavioralSpecificsN2,
    BehavioralSpecifics3,
    BehavioralSpecificsN3,
    BehavioralSpecifics4,
    BehavioralSpecificsN4,
    PreySpecies,
    Feeding_Lat,
    Feeding_Long,
    srts.Name AS Structure_Present,
    NoOfCetaceansWithIn100mOfActiveFisher,
    NoOfFishers,
    CetaceanResponsetoFisher1 AS CetaceanResponsetoFisher_Approach,
    CetaceanResponsetoFisher2 AS CetaceanResponsetoFisher_Neutral,
    CetaceanResponsetoFisher3 AS CetaceanResponsetoFisher_Relocate,
    FisherResponsetoCetacean1 AS FisherResponsetoCetacean_Approach,
    FisherResponsetoCetacean2 AS FisherResponsetoCetacean_No_Response,
    FisherResponsetoCetacean3 AS FisherResponsetoCetacean_Pull_in_Line,
    FisherResponsetoCetacean4 AS FisherResponsetoCetacean_Relocate,
    Depredation,
    NoOfCetaceansWithIn100mOfRecreationVessels,
    NumberOfVessels,
    CetaceanResponsetoVessel1 AS CetaceanResponseToVessel_Approach,
    CetaceanResponsetoVessel2 AS CetaceanResponseToVessel_Neutral,
    CetaceanResponsetoVessel3 AS CetaceanResponseToVessel_Relocate,
    VesselResponsetoCetacean1 AS VesselResponseToCetacean_Approach,
    VesselResponsetoCetacean2 AS VesselResponseToCetacean_No_Response,
    VesselResponsetoCetacean3 AS VesselResponseToCetacean_Out_Of_Gear,
    VesselResponsetoCetacean4 AS VesselResponseToCetacean_Relocate,
    No_of_Cetaceans_wHBOI_Vessel,
    ReactiontoHBOIVessel1 AS ReactiontoHBOIVessel_Approach,
    ReactiontoHBOIVessel2 AS ReactiontoHBOIVessel_Neutral,
    ReactiontoHBOIVessel3 AS ReactiontoHBOIVessel_Relocate,
    StratTimeDive1,
    EndTimeDive1,
    TotalTimeDive1,
    StratTimeDive2,
    EndTimeDive2,
    TotalTimeDive2,
    StratTimeDive3,
    EndTimeDive3,
    TotalTimeDive3,
    StratTimeDive4,
    EndTimeDive4,
    TotalTimeDive4,
    StratTimeDive5,
    EndTimeDive5,
    TotalTimeDive5,
    cm.Camera,
    lns.Lens,
    rtp.RT_MemberName AS Photographer,
    rtd.RT_MemberName AS Driver,
    ss.EnteredBy AS CompletedBy,
    cs.SDR,
    cs.BestSighting,
    c.Code,
    tlu.CetaceanSpeciesName,
    c.Sex,
    cs.Fetals,
    cs.Calf,
    cs.Yoy,
    c.DScore,
    c.FB_Number,
    cs.wMomDropDown AS with_Mom,
    cs.Note,
    cs.pq_focus,
    cs.pq_Angle,
    cs.pq_Contrast,
    cs.pq_Proportion,
    cs.pq_Partial,
    cs.pqSum,
    cs.Qscore,
    cs.BestShot,
    concat(enby.first_name,enby.last_name) as EnteredBy,
    concat(ianaly.first_name,ianaly.last_name) as PhotoAnalysisInitial,
    concat(fanaly.first_name,fanaly.last_name) as PhotoAnalysisFinal,
    cs.bodyCondition,
    hncr.HNC_Name as Head_NuchalCrest,
    hlcr.HLCR_Name as Head_LateralCervicalReg,
    hfb.HFB_Name as Head_FacialBones,
    heos.HEOS_Name as Head_EarOS,
    hcsf.HCSF_Name as Head_ChinSkinFolds,
    bem.BEM_Name as Body_EpaxialMuscle,
    bdrs.BDRS_Name as Body_DorsalRidgeScapula,
    br.BR_Name as Body_Ribs,
    ttp.TTP_Name as Tail_TransversePro,
    cs.Cetaceans_ID AS Cetaceans_I,
    c.code AS cscode
  FROM
    Surveys s
    LEFT JOIN Survey_Sightings ss ON s.ID= ss.Project_ID
    LEFT JOIN Cetacean_Sightings cs ON ss.ID= cs.Sighting_ID
    LEFT JOIN Cetaceans c ON cs.Cetaceans_ID= c.ID
    LEFT JOIN TLU_CetaceanSpecies tlu ON tlu.ID= c.CetaceanSpecies
    LEFT JOIN TLU_Camera cm ON cm.ID = ss.Camera
    LEFT JOIN TLU_Lens lns ON lns.ID = ss.Lens
    LEFT JOIN TLU_Weather w ON w.ID = ss.Weather
    LEFT JOIN TLU_WaveHight wh ON wh.ID = ss.WaveHeight
    LEFT JOIN TLU_Glare g ON g.ID = ss.Glare
    LEFT JOIN TLU_GlareDirection gd ON gd.ID = ss.GlareDirection
    LEFT JOIN TLU_Sightability st ON st.ID = ss.Sightability
    LEFT JOIN TLU_Beaufort bt ON bt.ID = ss.Beaufort
    LEFT JOIN TLU_Habitat ht ON ht.HabitatID = ss.HabitatType
    LEFT JOIN TLU_GlareDirection gdw ON gdw.ID = ss.WindDirection
    LEFT JOIN TLU_Tide td ON td.TideID = ss.Tide
    LEFT JOIN TLU_Heading ih ON ih.ID = ss.InitialHeading
    LEFT JOIN TLU_GeneralHeading gh ON gh.ID = ss.GeneralHeading
    LEFT JOIN TLU_FinalHeading fh ON fh.ID = ss.FinalHeading
    LEFT JOIN TLU_ResearchTeamMembers rtp ON rtp.RT_ID = ss.Photographer
    LEFT JOIN TLU_ResearchTeamMembers rtd ON rtd.RT_ID = ss.Driver 
    left join TLU_CetaceanResponseToFisher crtf on crtf.ID=ss.CetaceanResponseToFisher
    left join TLU_FisherResponseToCetacean frtc on frtc.id=ss.FisherResponseToCetacean
    left join TLU_CetaceanResponseToVessel crtv on crtv.id=ss.CetaceanResponseToVessel
    left join TLU_VesselResponseToCetacean vrtc on vrtc.id=ss.VesselResponseToCetacean
    left join users enby on enby.user_id = cs.EnteredBy
    left join users ianaly on ianaly.user_id = cs.PhotoAnalysisInitial
    left join users fanaly on fanaly.user_id = cs.PhotoAnalysisFinal
    left join TLU_HeadNuchalCrest hncr on hncr.ID = cs.Head_NuchalCrest
    left join TLU_HeadLateralCervicalReg hlcr on hlcr.ID= cs.Head_LateralCervicalReg
    left join TLU_HeadFacialBones hfb on hfb.ID=cs.Head_FacialBones
    left join TLU_HeadEarOS heos on heos.ID=cs.Head_EarOS
    left join TLU_HeadChinSkinFolds hcsf on hcsf.ID=cs.Head_ChinSkinFolds
    left join TLU_BodyEpaxialMuscle bem on bem.ID = cs.Body_EpaxialMuscle
    left join TLU_BodyDorsalRidgeScapula bdrs on bdrs.ID = cs.Body_DorsalRidgeScapula
    left join TLU_BodyRibs br on br.ID=cs.Body_Ribs
    left join TLU_TailTransversePro ttp on ttp.ID= cs.Tail_TransversePro
    left join TLU_Structures srts on srts.ID = ss.Structure_Present
    where 1=1
    <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">and CONVERT(char(10), s.Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'</cfif>
    <cfif isdefined("form.surveyRoute") and form.surveyRoute neq ""> and CONCAT(',', s.SurveyRoute, ',') LIKE '%,#form.surveyRoute#,%'</cfif>
    <cfif isdefined("form.BodyCondition") and form.BodyCondition neq ""> and cs.BodyCondition = '#form.BodyCondition#'</cfif>
    <cfif isdefined("form.bodyOfWater") and form.bodyOfWater neq ""> and s.BodyOfWater = '#form.bodyOfWater#'</cfif>
    <cfif isdefined("form.surveyType")  and form.surveyType  neq ""> and s.SurveyType = '#form.surveyType#'</cfif>
    <cfif isdefined("form.code")  and form.code neq ""> and c.Code = '#form.code#'</cfif>
    <cfif isdefined("form.SDR")  and form.SDR neq ""> and cs.SDR = '#form.SDR#'</cfif>
    <cfif isdefined("form.cetaceanSpecies") and form.cetaceanSpecies neq ""> and tlu.CetaceanSpeciesName = '#form.cetaceanSpecies#'</cfif>
    <cfif isdefined("form.platform") and form.platform neq ""> and s.platform = '#form.platform#'</cfif>
    <cfif isdefined("form.NOAAStock") and form.NOAAStock neq ""> and s.NOAAStock like '%#form.NOAAStock#%'</cfif>
    <cfif isdefined("form.surveyEffort") and form.surveyEffort neq ""> and ss.Survey = '#form.surveyEffort#'</cfif>
    AND s.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
    AND ss.IsDeleted != <cfqueryparam  cfsqltype="cf_sql_bit" value='1'>
    ORDER BY
    s.ID DESC
  </cfquery>
 
  <!--- query to count maximum number of Lesion against a cetacean --->
  <cfquery datasource="#variables.dsn#" name="maximumLesions">
    SELECT Sighting_ID,Cetaceans_ID, COUNT(*) AS MaxLesion
    FROM Condition_Lesions b
    GROUP BY b.Sighting_ID,b.Cetaceans_ID
    HAVING count(*) > 1
    ORDER BY MaxLesion desc
  </cfquery>
  <cfset oo = 0>
  <!--- loop for adding columns in main query --->
  <cfloop index="index" from="1" to="#maximumLesions.MaxLesion#">
    <cfset oo = incrementValue(#oo#)> 
    <cfset lp =  "LesionPresent" & #oo#>
    <cfset lete =  "LesionType" & #oo#>
    <cfset re =  "Region" & #oo#>
    <cfset slr =  "Side_L_R" & #oo#>
    <cfset st =  "Status" & #oo#>
    <cfset QueryAddColumn(qFiltered, "#lp#","varchar",[""])>
    <cfset QueryAddColumn(qFiltered, "#lete#","varchar",[""])>
    <cfset QueryAddColumn(qFiltered, "#re#","varchar",[""])>
    <cfset QueryAddColumn(qFiltered, "#slr#","varchar",[""])>
    <cfset QueryAddColumn(qFiltered, "#st#","varchar",[""])>
  </cfloop>
  <!--- main query --->
  <cfloop query="qFiltered">
    <cfif #sightingID# neq "" and #Cetaceans_I# neq ""> 
      <!--- Query get lesion data against a cetacean and sighting ID --->
      <cfquery datasource="#variables.dsn#" name="cld">
        SELECT cl.*
        FROM Condition_Lesions cl
        where cl.Sighting_ID = #sightingID# and cl.Cetaceans_ID='#cscode#'
      </cfquery>
      <cfif cld.RECORDCOUNT gte 1 >
        <cfset cn = 0>
        <!--- loop for seting columns data  --->
        <cfloop query="cld" > 
          <cfset cn = incrementValue(#cn#)> 
          <cfset lp =  "LesionPresent" & #cn#>
          <cfset lete =  "LesionType" & #cn#>
          <cfset re =  "Region" & #cn#>
          <cfset slr =  "Side_L_R" & #cn#>
          <cfset st =  "Status" & #cn#>
          <cfset QuerySetCell(qFiltered, "#lp#", #LesionPresent#, qFiltered.currentRow)>
          <cfset QuerySetCell(qFiltered, "#lete#", #LesionType#, qFiltered.currentRow)>
          <cfset QuerySetCell(qFiltered, "#slr#", #Side_L_R#, qFiltered.currentRow)>
          <cfset QuerySetCell(qFiltered, "#st#", #Status#, qFiltered.currentRow)>
          <cfset bd = listToArray(#Region#, ",", false, true)> 
          <cfset RegionA = arrayNew(1,false)> 
          <cfloop query="lesionRegion">
            <cfif ArrayContains(bd,#ID#)>
                <cfset arn = ArrayAppend(RegionA,#RegionName#,"true")>
            </cfif>
          </cfloop>
          <cfset df = arrayToList(RegionA,"\")>
          <cfset QuerySetCell(qFiltered, "#re#", #df#, qFiltered.currentRow)>
        </cfloop> 
      </cfif>
    </cfif>
  
    <cfset Dated = Left(#DATE#,10)>
    <cfset QuerySetCell(qFiltered, "DATE", #Dated#, qFiltered.currentRow)>

    <cfif #qFiltered.Platform# eq "Land Survey" or #qFiltered.SurveyType# eq "Trail Camera">
      <cfset QuerySetCell(qFiltered, "EngineOn", "", qFiltered.currentRow)>
      <cfset QuerySetCell(qFiltered, "EngineOff", "", qFiltered.currentRow)>
    <cfelse>
      <cfset Engon= Left(#EngineOn#,16)>
      <cfset QuerySetCell(qFiltered, "EngineOn", #Engon#, qFiltered.currentRow)>
      <cfset Engoff = Left(#EngineOff#,16)>
      <cfset QuerySetCell(qFiltered, "EngineOff", #Engoff#, qFiltered.currentRow)>
    </cfif>

    <cfset Surstart = Left(#SurveyStart#,16)>
    <cfset Surstart = Right(#Surstart#,5)>
    <cfset QuerySetCell(qFiltered, "SurveyStart", #Surstart#, qFiltered.currentRow)>

    <cfset Surend = Left(#SurveyEnd#,16)>
    <cfset Surend = Right(#Surend#,5)>
    <cfset QuerySetCell(qFiltered, "SurveyEnd", #Surend#, qFiltered.currentRow)>

    <cfset Sighstart = Left(#SightingStart#,16)>
    <cfset Sighstart = Right(#Sighstart#,5)>
    <cfset QuerySetCell(qFiltered, "SightingStart", #Sighstart#, qFiltered.currentRow)>

    <cfset Sighend = Left(#SightingEnd#,16)>
    <cfset Sighend = Right(#Sighend#,5)>
    <cfset QuerySetCell(qFiltered, "SightingEnd", #Sighend#, qFiltered.currentRow)>
    <cfif AirTemp neq "">
      <cfset Airt = numberFormat(AirTemp,'__.0')>
      <cfset QuerySetCell(qFiltered, "AirTemp", #Airt#, qFiltered.currentRow)>
    </cfif>
    <cfif WaterTemp neq "">
      <cfset Watert = #numberFormat(WaterTemp,'__.0')#>
      <cfset QuerySetCell(qFiltered, "WaterTemp", #Watert#, qFiltered.currentRow)>
    </cfif>
    <cfset bd = listToArray(#BodyOfWater#, ",", false, true)>
    <cfset AreaNameA = arrayNew(1,false)>
    <cfloop query="getAreaName">
        <cfif ArrayContains(bd,#ID#)>
          <cfset arn = ArrayAppend(AreaNameA,#AreaName#,"true")> 
        </cfif>
    </cfloop>
    <cfset df = arrayToList(AreaNameA,"\")>
    <cfset QuerySetCell(qFiltered, "BodyOfWater", #df#, qFiltered.currentRow)>
    <cfset bd = listToArray(#NOAAStock#, ",", false, true)>
    <cfset NOAAStockA = arrayNew(1,false)>
    <cfloop query="getStock">
      <cfif ArrayContains(bd,#ID#)>
        <cfset arn = ArrayAppend(NOAAStockA,#STOCKNAME#,"true")> 
      </cfif>
    </cfloop>
    <cfset dn = arrayToList(NOAAStockA,"\")>
    <cfset QuerySetCell(qFiltered, "NOAAStock", #dn#, qFiltered.currentRow)>
    <cfset bd = listToArray(#SurveyRoute#, ",", false, true)>
    <cfset SurveyRouteA = arrayNew(1,false)> 
    <cfloop query="getSurveyRouteData">
        <cfif ArrayContains(bd,#ID#)>
            <cfset arn = ArrayAppend(SurveyRouteA,#ROUTENAME#,"true")>
        </cfif>
    </cfloop>
    <cfset df = arrayToList(SurveyRouteA,"\")>
    <cfset QuerySetCell(qFiltered, "SurveyRoute", #df#, qFiltered.currentRow)>

    <cfset bd = listToArray(#ResearchTeam#, ",", false, true)>
    <cfset ResearchTeamA = arrayNew(1,false)> 
    <cfloop query="RTmembers">
        <cfif ArrayContains(bd,#RT_ID#)>
            <cfset arn = ArrayAppend(ResearchTeamA,#RT_MemberName#,"true")>
        </cfif>
    </cfloop>
    <cfset df = arrayToList(ResearchTeamA,"\")>
    <cfset QuerySetCell(qFiltered, "ResearchTeam", #df#, qFiltered.currentRow)>

    <cfset bd = listToArray(#AssocBio#, ",", false, true)>
    <cfset AssocBioA = arrayNew(1,false)> 
    <cfloop query="qGetAssocBioData">
        <cfif ArrayContains(bd,#ASSOCBIOID#)>
            <cfset arn = ArrayAppend(AssocBioA,#ASSOCBIONAME#,"true")>
        </cfif>
    </cfloop>
    <cfset df = arrayToList(AssocBioA,"\")>
    <cfset QuerySetCell(qFiltered, "AssocBio", #df#, qFiltered.currentRow)>
    <cfloop query="getBehaviorsData">
      <cfif getBehaviorsData.ID eq #qFiltered.BehavioralSpecifics1#>
        <cfset QuerySetCell(qFiltered, "BehavioralSpecifics1", #getBehaviorsData.BehaviorName#, qFiltered.currentRow)>
      </cfif>
      <cfif getBehaviorsData.ID eq #qFiltered.BehavioralSpecifics2#>
        <cfset QuerySetCell(qFiltered, "BehavioralSpecifics2", #getBehaviorsData.BehaviorName#, qFiltered.currentRow)>
      </cfif>
      <cfif getBehaviorsData.ID eq #qFiltered.BehavioralSpecifics3#>
        <cfset QuerySetCell(qFiltered, "BehavioralSpecifics3", #getBehaviorsData.BehaviorName#, qFiltered.currentRow)>
      </cfif>
      <cfif getBehaviorsData.ID eq #qFiltered.BehavioralSpecifics4#>
        <cfset QuerySetCell(qFiltered, "BehavioralSpecifics4", #getBehaviorsData.BehaviorName#, qFiltered.currentRow)>
      </cfif>
    </cfloop>

    <cfset bd = listToArray(#PreySpecies#, ",", false, true)>
    <cfset PreySpeciesA = arrayNew(1,false)> 
    <cfloop query="getPreySpeciesData">
        <cfif ArrayContains(bd,#ID#)>
            <cfset arn = ArrayAppend(PreySpeciesA,#PreySpeciesName#,"true")>
        </cfif>
    </cfloop>
    <cfset df = arrayToList(PreySpeciesA,"\")>
    <cfset QuerySetCell(qFiltered, "PreySpecies", #df#, qFiltered.currentRow)>

    <cfif #with_Mom# eq 1>
      <cfset QuerySetCell(qFiltered, "with_Mom", "Yes", qFiltered.currentRow)>
    <cfelseif #with_Mom# eq 2>
      <cfset QuerySetCell(qFiltered, "with_Mom", "No", qFiltered.currentRow)>
    <cfelseif #with_Mom# eq 3>
      <cfset QuerySetCell(qFiltered, "with_Mom", "Partial", qFiltered.currentRow)>
    <cfelse>
      <cfset QuerySetCell(qFiltered, "with_Mom", "", qFiltered.currentRow)>
    </cfif>
    
    <cfset bd = listToArray(#Structure_Present#, ",", false, true)>
    <cfset Structure_PresentA = arrayNew(1,false)> 
    <cfloop query="StructureList">
        <cfif ArrayContains(bd,#Name#)>
            <cfset arn = ArrayAppend(Structure_PresentA,#Name#,"true")>
        </cfif>
    </cfloop>
    <cfset df = arrayToList(Structure_PresentA,"\")>
    <cfset QuerySetCell(qFiltered, "Structure_Present", #df#, qFiltered.currentRow)>

    <cfif "#bodyCondition#" eq 1>
      <cfset QuerySetCell(qFiltered, "bodyCondition","Emaciated", qFiltered.currentRow)>                           
    </cfif>
    <cfif "#bodyCondition#" eq 2>
      <cfset QuerySetCell(qFiltered, "bodyCondition","Underweight/Thin", qFiltered.currentRow)>
    </cfif>
    <cfif "#bodyCondition#" eq 3>
      <cfset QuerySetCell(qFiltered, "bodyCondition","Ideal", qFiltered.currentRow)>
    </cfif>
    <cfif "#bodyCondition#" eq 4>
      <cfset QuerySetCell(qFiltered, "bodyCondition","Overweight", qFiltered.currentRow)>
    </cfif>
    <cfif "#bodyCondition#" eq 5>
      <cfset QuerySetCell(qFiltered, "bodyCondition","Obese", qFiltered.currentRow)>
    </cfif>
    <cfif "#bodyCondition#" eq 6>
      <cfset QuerySetCell(qFiltered, "bodyCondition","CBD", qFiltered.currentRow)>
    </cfif>
    <cfif "#Depredation#" eq "Low">
      <cfset QuerySetCell(qFiltered, "Depredation","No", qFiltered.currentRow)>
    <cfelseif  "#Depredation#" eq "High">
      <cfset QuerySetCell(qFiltered, "Depredation","Yes", qFiltered.currentRow)>
    </cfif>
  </cfloop>
  <cfscript>
    QueryDeleteColumn(qFiltered, "CSCODE");
    QueryDeleteColumn(qFiltered, "Cetaceans_I");
    if( not isDefined('form.SightingStartEnd'))
    {
      QueryDeleteColumn(qFiltered, "SIGHTINGSTART");
      QueryDeleteColumn(qFiltered, "SIGHTINGEND");
    }
    if( not isDefined('form.ConditionFromSighting'))
    {
      QueryDeleteColumn(qFiltered, "Weather");
      QueryDeleteColumn(qFiltered, "WaveHeight");
      QueryDeleteColumn(qFiltered, "Glare");
      QueryDeleteColumn(qFiltered, "GlareDirection");
      QueryDeleteColumn(qFiltered, "Sightability");
      QueryDeleteColumn(qFiltered, "HabitatDepth");
      QueryDeleteColumn(qFiltered, "HabitatName");
      QueryDeleteColumn(qFiltered, "WaterTemp");
      QueryDeleteColumn(qFiltered, "AirTemp");
      QueryDeleteColumn(qFiltered, "WindSpeed");
      QueryDeleteColumn(qFiltered, "TideName");
      QueryDeleteColumn(qFiltered, "Salinity");
      QueryDeleteColumn(qFiltered, "pH");
      QueryDeleteColumn(qFiltered, "DO");
      QueryDeleteColumn(qFiltered, "Conductivity");
      QueryDeleteColumn(qFiltered, "InitialHeading");
      QueryDeleteColumn(qFiltered, "GeneralHeading");
      QueryDeleteColumn(qFiltered, "FinalHeading");
      QueryDeleteColumn(qFiltered, "AssocBio");
    }
    if( not isDefined('form.fieldEstimate'))
    {
      QueryDeleteColumn(qFiltered, "FE_TotalCetaceans_Max");
      QueryDeleteColumn(qFiltered, "FE_TotalCetaceans_Min");
      QueryDeleteColumn(qFiltered, "FE_TotalCetacean_Best");
      QueryDeleteColumn(qFiltered, "FE_TotalCetacean_takes");
      QueryDeleteColumn(qFiltered, "FE_TotalAdults_Min");
      QueryDeleteColumn(qFiltered, "FE_TotalAdults_Max");
      QueryDeleteColumn(qFiltered, "FE_TotalAdults_Best");
      QueryDeleteColumn(qFiltered, "FE_TotalAdults_takes");
      QueryDeleteColumn(qFiltered, "FE_TotalCalves_Max");
      QueryDeleteColumn(qFiltered, "FE_TotalCalves_Min");
      QueryDeleteColumn(qFiltered, "FE_TotalCalves_Best");
      QueryDeleteColumn(qFiltered, "FE_TotalCalves_takes");
      QueryDeleteColumn(qFiltered, "FE_YoungOfYear_Min");
      QueryDeleteColumn(qFiltered, "FE_YoungOfYear_Max");
      QueryDeleteColumn(qFiltered, "FE_YoungOfYear_Best");
      QueryDeleteColumn(qFiltered, "FE_YoungOfYear_takes");
    }
    if( not isDefined('form.activity'))
    {
      QueryDeleteColumn(qFiltered, "Act_Mill");
      QueryDeleteColumn(qFiltered, "Act_Feed");
      QueryDeleteColumn(qFiltered, "Act_Rest");
      QueryDeleteColumn(qFiltered, "Act_Other");
      QueryDeleteColumn(qFiltered, "Act_Social");
      QueryDeleteColumn(qFiltered, "Act_Travel");
      QueryDeleteColumn(qFiltered, "Act_Prob_Feed");
      QueryDeleteColumn(qFiltered, "Act_With_Boat");
      QueryDeleteColumn(qFiltered, "Act_Avoid_Boat");
      QueryDeleteColumn(qFiltered, "Act_Object_Play");
    }
    if( not isDefined('form.behavioralEvents'))
    {
      QueryDeleteColumn(qFiltered, "BehavioralSpecifics1");
      QueryDeleteColumn(qFiltered, "BehavioralSpecificsN1");
      QueryDeleteColumn(qFiltered, "BehavioralSpecifics2");
      QueryDeleteColumn(qFiltered, "BehavioralSpecificsN2");
      QueryDeleteColumn(qFiltered, "BehavioralSpecifics3");
      QueryDeleteColumn(qFiltered, "BehavioralSpecificsN3");
      QueryDeleteColumn(qFiltered, "BehavioralSpecifics4");
      QueryDeleteColumn(qFiltered, "BehavioralSpecificsN4");
    }
    if( not isDefined('form.feedingEcology'))
    {
      QueryDeleteColumn(qFiltered, "PreySpecies");
      QueryDeleteColumn(qFiltered, "Feeding_Lat");
      QueryDeleteColumn(qFiltered, "Feeding_Long");
      QueryDeleteColumn(qFiltered, "Structure_Present");
    }
    if( not isDefined('form.fisheriesInteractions'))
    {
      QueryDeleteColumn(qFiltered, "NoOfCetaceansWithIn100mOfActiveFisher");
      QueryDeleteColumn(qFiltered, "NoOfFishers");
      QueryDeleteColumn(qFiltered, "CetaceanResponsetoFisher_Approach");
      QueryDeleteColumn(qFiltered, "CetaceanResponsetoFisher_Neutral");
      QueryDeleteColumn(qFiltered, "CetaceanResponsetoFisher_Relocate");
      QueryDeleteColumn(qFiltered, "FisherResponsetoCetacean_Approach");
      QueryDeleteColumn(qFiltered, "FisherResponsetoCetacean_No_Response");
      QueryDeleteColumn(qFiltered, "FisherResponsetoCetacean_Pull_in_Line");
      QueryDeleteColumn(qFiltered, "FisherResponsetoCetacean_Relocate");
      QueryDeleteColumn(qFiltered, "Depredation");
    }
    if( not isDefined('form.boatingInteractions'))
    {
      QueryDeleteColumn(qFiltered, "NoOfCetaceansWithIn100mOfRecreationVessels");
      QueryDeleteColumn(qFiltered, "NumberOfVessels");
      QueryDeleteColumn(qFiltered, "CetaceanResponseToVessel_Approach");
      QueryDeleteColumn(qFiltered, "CetaceanResponseToVessel_Neutral");
      QueryDeleteColumn(qFiltered, "CetaceanResponseToVessel_Relocate");
      QueryDeleteColumn(qFiltered, "VesselResponseToCetacean_Approach");
      QueryDeleteColumn(qFiltered, "VesselResponseToCetacean_No_Response");
      QueryDeleteColumn(qFiltered, "VesselResponseToCetacean_Out_Of_Gear");
      QueryDeleteColumn(qFiltered, "VesselResponseToCetacean_Relocate");
    }
    if( not isDefined('form.HBOIVesselInteractions'))
    {
      QueryDeleteColumn(qFiltered, "No_of_Cetaceans_wHBOI_Vessel");
      QueryDeleteColumn(qFiltered, "ReactiontoHBOIVessel_Approach");
      QueryDeleteColumn(qFiltered, "ReactiontoHBOIVessel_Neutral");
      QueryDeleteColumn(qFiltered, "ReactiontoHBOIVessel_Relocate");
    }
    if( not isDefined('form.divetimes'))
    {
      QueryDeleteColumn(qFiltered, "StratTimeDive1");
      QueryDeleteColumn(qFiltered, "StratTimeDive2");
      QueryDeleteColumn(qFiltered, "StratTimeDive3");
      QueryDeleteColumn(qFiltered, "StratTimeDive4");
      QueryDeleteColumn(qFiltered, "StratTimeDive5");
      QueryDeleteColumn(qFiltered, "EndTimeDive1");
      QueryDeleteColumn(qFiltered, "EndTimeDive2");
      QueryDeleteColumn(qFiltered, "EndTimeDive3");
      QueryDeleteColumn(qFiltered, "EndTimeDive4");
      QueryDeleteColumn(qFiltered, "EndTimeDive5");
      QueryDeleteColumn(qFiltered, "TotalTimeDive1");
      QueryDeleteColumn(qFiltered, "TotalTimeDive2");
      QueryDeleteColumn(qFiltered, "TotalTimeDive3");
      QueryDeleteColumn(qFiltered, "TotalTimeDive4");
      QueryDeleteColumn(qFiltered, "TotalTimeDive5");
    }
    if( isDefined('form.LesionType') and form.LesionType neq "")
    {    
        
      qFiltered=QueryFilter(qFiltered,function(obj){
       
        return obj.LesionType1 eq #form.LesionType# OR obj.LesionType2 eq #form.LesionType# OR obj.LesionType3 eq #form.LesionType#;
      });
    }  
  </cfscript>
   
<cfreturn qFiltered>
</cffunction>
</cfcomponent>
  