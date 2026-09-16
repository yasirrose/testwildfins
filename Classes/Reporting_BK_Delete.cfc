<cfcomponent displayName="Reporting" output="false">
<cfset variables.dsn = "">
<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
  <cfargument name="dsn" type="string" required="true" hint="datasource">
  <cfset variables.dsn = arguments.dsn>
  <cfreturn this>
</cffunction>


<!------- Roll Call Report ---------->



<cffunction name="getRollCallMain" returntype="any" output="false" access="public" >
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


<cffunction name="getRollCallGrapgh" returntype="any" output="false" access="public" >
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
        PROJECTS.ID 
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC

       </cfquery>
     <cfreturn  query>
</cffunction>
<!--- Dead Dolphins Body Conditions --->
<cffunction name="deadBodyConditions" access="public" returntype="any" output="false">
<cfargument name="bodyConditionStartYear" type="any" required="true" default="">
<cfargument name="bodyConditionEndYear" type="any" required="true" default="">
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
select distinct [DOLPHINS].* from [DOLPHINS]
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

<cffunction name="getRollCallGrapghMonth" returntype="any" output="true" access="remote" >

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

 <cfquery name="query" datasource="#Application.dsn#" >
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
        YEAR (PROJECTS.[Date]) BETWEEN #URL.fromYear# AND #URL.toYear#  AND  MONTH (PROJECTS.[Date]) = #month_no#
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
        PROJECTS.ID
        ORDER BY
        SurveryYear ASC,
        SurveryMONTH ASC
       </cfquery>
     <cfreturn  query>
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
        YEAR (PROJECTS.[Date]) BETWEEN #FORM.fromYear# AND #FORM.toYear# 
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
<cfquery name="getRec" datasource="#variables.dsn#">
	SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#appendyear#">
</cfquery>
<cfreturn getRec/>
</cffunction>
<!--- Dead dolphins by month --->
<cffunction name="DeadDolphinsByMonth" access="public" returntype="any" output="false">
<cfargument name="monthly" type="any" required="true" default="">
<cfargument name="filterMonthlyYear" type="any" required="true" default="">
<cfquery name="getRec" datasource="#variables.dsn#">
SELECT
	DOLPHINS.ID,
	YEAR (DOLPHINS.[Date of Death]) AS DeathYear,
	DOLPHINS.[Dead?]
	FROM
	DOLPHINS Where MONTH (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#monthly#"> 
    AND YEAR (DOLPHINS.[Date of Death]) = <cfqueryparam cfsqltype="cf_sql_integer" value="#filterMonthlyYear#">
</cfquery>
<cfreturn getRec/>
</cffunction>
<!--- Freez Brand Recovered --->
<cffunction name="freezbrandRecovered" access="public" returntype="any" output="false">
<cfquery name="getRec" datasource="#variables.dsn#">
	SELECT
	dbo.DOLPHINS.FB_No,
	dbo.DOLPHINS.FB_On_Date
	FROM
	dbo.DOLPHINS Where dbo.DOLPHINS.FB_No != ''
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

	<cfquery name="qBestPlace" datasource="#Application.dsn#" >
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
<cfquery name="getRec" datasource="#variables.dsn#">
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
        <cfset arr[7] =0>
        <cfset arr[8] =0>

	<cfquery name="qBestPlace" datasource="#Application.dsn#" >
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

<cffunction name="getBodyConditionGrapgh" returntype="any" output="false" access="public" >
<cfquery name="query" datasource="#Application.dsn#" >
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
<!--- Get Stock Main Data --->
<cffunction name="TotalStock" access="public" returntype="any" output="false">
	<cfquery name="getRec" datasource="#Application.dsn#">
		Select * from TLU_Stock
	</cfquery>
<cfreturn getRec/>
</cffunction>
<!--- Get Total Sightning and Dolphins --->    
<cffunction name="TotalDolphinsAndSightings" access="public" returntype="any" output="false">
<cfargument name="Date_from" type="any" required="true" default="">
<cfargument name="Date_to" type="any" required="true" default="">
<cfargument name="stockSelected" type="any" required="true" default="">
<cfquery name="getRec" datasource="#Application.dsn#">
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
<cfquery name="getRec" datasource="#Application.dsn#">
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
</cfcomponent>