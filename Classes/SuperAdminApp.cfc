<cfcomponent displayName="SuperAdmin" output="false">
<cfset variables.dsn = "wildfins">
<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
  <cfargument name="dsn" type="string" required="true" hint="datasource">
  <cfset variables.dsn = arguments.dsn>
  <cfreturn this>
</cffunction>

<!--- Get Super Admin --->
<cffunction name="getSuperAdmin" returntype="any" output="false" access="public" >
    <cfset hashedPassword = Hash(FORM.PASSWORD) />
    <!---<cfset hashedPassword = '1346CBACF6E1D69C43FC42DF80552D30'>--->
    <cftry>
    <cfquery name="qgetSuperAdmin" datasource="#variables.dsn#"  >
        SELECT * FROM users where user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.Email#" >
        AND
        user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hashedPassword#" >
        AND
        status = 'Enable'
    </cfquery>
    <cfcatch type="any">
        <cfdump  var="#cfcatch#"><cfabort>
    </cfcatch>
    </cftry>
    <cfreturn qgetSuperAdmin>
</cffunction>


<cffunction name="updateloginTime" returntype="any" output="false" access="public" >
<cfargument name="userid" default="" required="yes" type="numeric">
<cfquery name="qEditProfile" datasource="#variables.dsn#" result="userupdated">
    UPDATE users SET  logintime =#Now()# where user_id = #userid#
</cfquery>
</cffunction>

<cffunction name="EditProfile" returntype="any" output="false" access="public" >
<cfquery name="qUser" datasource="#variables.dsn#" >
    	Select user_email from  users
    	where user_email != '#session.userdetails.email#' AND user_email = '#FORM.user_email#'
  </cfquery>
<cfif qUser.recordcount eq 0>
   <cfquery name="qEditProfile" datasource="#variables.dsn#" result="userupdated">
    UPDATE users SET
    first_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.first_name#" >,
    last_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.last_name#" > ,
    user_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.username#" >,
    <cfif len(trim(form.user_password))>
      <cfset userPassword =  Hash(form.user_password, "md5")>
    user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#userPassword#" >,
	</cfif>
    user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.user_email#" >

    where user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.userId#" >

     </cfquery>
 </cfif>
     <cfreturn userupdated>
</cffunction>

<cffunction name="getUserinfo" returntype="any" output="false" access="public" >
<cfquery name="qUser" datasource="#variables.dsn#" >
    	Select * from  users
    	where user_id = #SESSION["UserDetails"]["Id"]#
  </cfquery>
     <cfreturn qUser>
</cffunction>

<cffunction name="emailexist" returntype="any" output="false" access="public" >
<cfquery name="qUser" datasource="#variables.dsn#" result="emailcheck">
    	Select user_email from users where user_email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
  </cfquery>
     <cfreturn emailcheck>
</cffunction>

<cffunction name="updatepassby_emial" returntype="any" output="false" access="public" >
<cfargument name="FORM" default="" type="struct" required="true">
<cfargument name="userPassword" default="" type="any" required="true">
<cfdump var="#arguments.userpassword#">
<cfquery name="qUser" datasource="#variables.dsn#" result="update">
UPDATE users SET  user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#userPassword#" > where user_email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
        </cfquery>
     <cfreturn update>
</cffunction>

<cffunction name="ZoneSurveyed" returntype="any" output="false" access="public" >
	<cfquery name="qZoneSurveyed" datasource="#variables.dsn#" >
        SELECT count(*) as currentmonthzones
        FROM PROJECTS
        LEFT JOIN
        (TLU_Zones RIGHT JOIN Project_Zones
        ON
        TLU_Zones.ID = Project_Zones.TZ_Zone_ID)
        ON
        PROJECTS.ID = Project_Zones.TZ_Project_ID
        WHERE (((Year([Date]))=YEAR(GETDATE())) AND ((Month([Date]))=MONTH(GETDATE())))
  	</cfquery>

    <cfquery name="qLastZoneSurveyed" datasource="#variables.dsn#" >
 		 SELECT count(*) as lastmonthzones
        FROM PROJECTS
        LEFT JOIN
        (TLU_Zones RIGHT JOIN Project_Zones
        ON
        TLU_Zones.ID = Project_Zones.TZ_Zone_ID)
        ON
        PROJECTS.ID = Project_Zones.TZ_Project_ID
        WHERE (((Year([Date]))=YEAR(GETDATE())) AND ((Month([Date]))=MONTH(DATEADD(m, -1, getdate()))))
  	</cfquery>
       <cfset data = qZoneSurveyed.currentmonthzones &','& qLastZoneSurveyed.lastmonthzones>
     <cfreturn data>
</cffunction>

<cffunction name="SegmentSurveyed" returntype="any" output="false" access="public" >
<cfquery name="qSegmentSurveyed" datasource="#variables.dsn#" >
    SELECT PROJECTS.SurveyArea, PROJECTS.Date,
    DOLPHINS.Code, DOLPHINS.Sex, DOLPHINS.DScore,
    TLU_Zones.ZSEGMENT, Count(TLU_Zones.ZSegment) AS SegCount
    FROM
    PROJECTS INNER JOIN
    (TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
    ON
    DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
    ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
    ON TLU_Zones.ID = SIGHTINGS.Zone_id)
    ON PROJECTS.ID = SIGHTINGS.Project_ID
     WHERE (((Year([Date]))=YEAR(GETDATE())) AND ((Month([Date]))=MONTH(GETDATE())))
    GROUP BY PROJECTS.SurveyArea, PROJECTS.Date, DOLPHINS.Code, DOLPHINS.Sex, DOLPHINS.DScore, TLU_Zones.ZSEGMENT
    HAVING (((DOLPHINS.Code) Is Not Null) AND ((TLU_Zones.ZSEGMENT) Is Not Null))
    ORDER BY PROJECTS.Date, DOLPHINS.Code
  </cfquery>

  <cfquery name="qLastSegmentSurveyed" datasource="#variables.dsn#" >
    SELECT PROJECTS.SurveyArea, PROJECTS.Date,
    DOLPHINS.Code, DOLPHINS.Sex, DOLPHINS.DScore,
    TLU_Zones.ZSEGMENT, Count(TLU_Zones.ZSegment) AS SegCount
    FROM
    PROJECTS INNER JOIN
    (TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
    ON
    DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
    ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
    ON TLU_Zones.ID = SIGHTINGS.Zone_id)
    ON PROJECTS.ID = SIGHTINGS.Project_ID
     WHERE (((Year([Date]))=YEAR(GETDATE())) AND ((Month([Date]))=MONTH(DATEADD(m, -1, getdate()))))
    GROUP BY PROJECTS.SurveyArea, PROJECTS.Date, DOLPHINS.Code, DOLPHINS.Sex, DOLPHINS.DScore, TLU_Zones.ZSEGMENT
    HAVING (((DOLPHINS.Code) Is Not Null) AND ((TLU_Zones.ZSEGMENT) Is Not Null))
    ORDER BY PROJECTS.Date, DOLPHINS.Code
  </cfquery>
     <cfset data = qSegmentSurveyed.recordcount &','& qLastSegmentSurveyed.recordcount>
     <cfreturn data>
</cffunction>

<cffunction name="DolphinsSighted" returntype="any" output="false" access="public" >
	<cfquery name="qDolphinsSighted" datasource="#variables.dsn#" >
    SELECT
    PROJECTS.ID,
    SIGHTINGS.Project_ID,
    PROJECTS.[Date],
    DOLPHIN_SIGHTINGS.Dolphin_ID
    FROM
    PROJECTS
    INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
    INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
    WHERE (((Year([Date]))=YEAR(DATEADD(m, -1, getdate()))) AND ((Month([Date]))=MONTH(GETDATE())))
  </cfquery>

  <cfquery name="qLastDolphinsSighted" datasource="#variables.dsn#" >
   SELECT
    PROJECTS.ID,
    SIGHTINGS.Project_ID,
    PROJECTS.[Date],
    DOLPHIN_SIGHTINGS.Dolphin_ID
    FROM
    PROJECTS
    INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
    INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
     WHERE (((Year([Date]))=YEAR(GETDATE())) AND ((Month([Date]))=MONTH(DATEADD(m, -1, getdate()))))
  </cfquery>
   <cfset data = qDolphinsSighted.recordcount &','& qLastDolphinsSighted.recordcount >
     <cfreturn data>
</cffunction>

<cffunction name="TotalNamedDolphins" returntype="any" output="false" access="public" >
	<cfquery name="qTotalNamedDolphins" datasource="#variables.dsn#" >
    	select count(*) as named from Dolphins where code not like 'cUNK%' and [Dead?] = 0
   </cfquery>

   <cfquery name="qTotalUnNamedDolphins" datasource="#variables.dsn#" >
    	select count(*)  as unnamed from Dolphins where code like 'UNK%'
   </cfquery>
      <cfset data = qTotalNamedDolphins.named &','& qTotalUnNamedDolphins.unnamed>
     <cfreturn data>
</cffunction>

<cffunction name="Totalcalfs" returntype="any" output="false" access="public" >
	<cfquery name="qTotalcalfs" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_calfs
        FROM DOLPHINS
        WHERE ((DOLPHINS.Lineage) Is Not Null) 
        
   </cfquery>
     <cfreturn qTotalcalfs.total_calfs>
</cffunction>


<cffunction name="thismonthNCSG" returntype="any" output="false" access="public" >
	<cfquery name="qthisNCSG" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_NCSG
        FROM TLU_NCSG
        WHERE 
        Year([Date_Entered]) =  YEAR(GETDATE())
        AND Month([Date_Entered])= MONTH(GETDATE())
   </cfquery>
     <cfreturn qthisNCSG.total_NCSG>
</cffunction>

<cffunction name="lastmonthNCSG" returntype="any" output="false" access="public" >
	<cfquery name="qthisNCSG" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_NCSG
        FROM TLU_NCSG
        WHERE  Year([Date_Entered])  =  YEAR(DATEADD(m, -1, getdate()))
        AND Month([Date_Entered]) = MONTH(DATEADD(m, -1, getdate()))
   </cfquery>
     <cfreturn qthisNCSG.total_NCSG>
</cffunction>

<cffunction name="thismonthBiopsy" returntype="any" output="false" access="public" >
	<cfquery name="qthisBiopsy" datasource="#variables.dsn#" >
        SELECT count(SampleTaken) as total_Biopsy
        FROM BIOPSY_SHOTS
        WHERE  SampleTaken = 1 and
        Year([Enter_Date]) =  YEAR(GETDATE())
        AND Month([Enter_Date])= MONTH(GETDATE())
   </cfquery>
     <cfreturn qthisBiopsy.total_Biopsy>
</cffunction>

<cffunction name="lastmonthBiopsy" returntype="any" output="false" access="public" >
	<cfquery name="qthisBiopsy" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_Biopsy
        FROM BIOPSY_SHOTS
        WHERE  Year([Enter_Date])  =  YEAR(DATEADD(m, -1, getdate()))
        AND Month([Enter_Date]) = MONTH(DATEADD(m, -1, getdate()))
   </cfquery>
     <cfreturn qthisBiopsy.total_Biopsy>
</cffunction>

<cffunction name="thismonthHERA" returntype="any" output="false" access="public" >
	<cfquery name="qthisHERA" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_HERA
        FROM PROJECTS
        WHERE 
        Year([Date]) =  YEAR(GETDATE())
        AND Month([Date])= MONTH(GETDATE())
   </cfquery>
     <cfreturn qthisHERA.total_HERA>
</cffunction>

<cffunction name="lastmonthHERA" returntype="any" output="false" access="public" >
	<cfquery name="qthisHERA" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_HERA
        FROM PROJECTS
        WHERE  Year([Date])  =  YEAR(DATEADD(m, -1, getdate()))
        AND Month([Date]) = MONTH(DATEADD(m, -1, getdate()))
   </cfquery>
     <cfreturn qthisHERA.total_HERA>
</cffunction>

<cffunction name="thismonthMMHRSP" returntype="any" output="false" access="public" >
	<cfquery name="qthisMMHRSP" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_MMHSRP
        FROM Dolphin_MMHSRP
        WHERE 
        Year([Date])  =  YEAR(GETDATE())
        AND Month([Date]) = MONTH(GETDATE())

   </cfquery>
     <cfreturn qthisMMHRSP.total_MMHSRP>
</cffunction>

<cffunction name="lastmonthMMHRSP" returntype="any" output="false" access="public" >
	<cfquery name="qthisMMHRSP" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_MMHSRP
        FROM Dolphin_MMHSRP
        WHERE  Year([Date])  =  YEAR(DATEADD(m, -1, getdate()))
        AND Month([Date]) = MONTH(DATEADD(m, -1, getdate()))

   </cfquery>
     <cfreturn qthisMMHRSP.total_MMHSRP>
</cffunction>



<cffunction name="thismonthcalfs" returntype="any" output="false" access="public" >
	<cfquery name="qthiscalfs" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_calfs
        FROM DOLPHINS
        WHERE ((DOLPHINS.Lineage) Is Not Null) and  
        Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST]))  =  convert(nvarchar(255),YEAR(GETDATE()))
        AND SUBSTRING([DOB EST],0,charindex('/',[DOB EST])) = convert(nvarchar(255),MONTH(GETDATE()))

   </cfquery>
     <cfreturn qthiscalfs.total_calfs>
</cffunction>


<cffunction name="lastmonthcalfs" returntype="any" output="false" access="public" >
	<cfquery name="qlastcalfs" datasource="#variables.dsn#" >
        SELECT COUNT(*) as total_calfs
        FROM DOLPHINS
        WHERE ((DOLPHINS.Lineage) Is Not Null) and  
        Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST]))  =  convert(nvarchar(255),YEAR(DATEADD(m, -1, getdate())))
        AND SUBSTRING([DOB EST],0,charindex('/',[DOB EST])) = convert(nvarchar(255),MONTH(DATEADD(m, -1, getdate())))
   </cfquery>

     <cfreturn qlastcalfs.total_calfs>
</cffunction>


<cffunction name="TotalDolphinsSighted" returntype="any" output="false" access="public" >
	<cfquery name="qTotalDolphinsSighted" datasource="#variables.dsn#" >
		SELECT
		Year([Date]) AS [Project Year],
		Month([Date]) AS [Project Month],
		Sum(SIGHTINGS.FE_TotalDolphin_Best) AS total_dolphins
		FROM PROJECTS LEFT JOIN SIGHTINGS
		ON PROJECTS.ID = SIGHTINGS.Project_ID
		WHERE (((Year([Date]))=2016) AND ((Month([Date])) between 1 and 8))
		GROUP BY Year([Date]),
		Month([Date])
	</cfquery>
     <cfreturn qTotalDolphinsSighted>
</cffunction>

<cffunction name="TotalDolphinSighted" returntype="any" output="true" access="remote" returnformat="plain">
    <!--- create array --->
    <cfset Arr = ArrayNew(1)>
	<cfset compare_date = DateFormat(fromDate,'mm-dd-yyyy')>
	<cfloop from="1" to="#month_diff#" index="i">
        <cfquery name="qTotalDolphinsSighted" datasource="#variables.dsn#"  >
			SELECT count(*) as total_dolphins
			FROM
			SIGHTINGS
			INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
			INNER JOIN PROJECTS ON SIGHTINGS.Project_ID = PROJECTS.ID
			WHERE Year(PROJECTS.[Date]) =  #Year(compare_date)# AND MONTH(PROJECTS.[Date]) = #Month(compare_date)#
        </cfquery>
        <cfquery name="qTotalUniqueDolphinsSighted" datasource="#variables.dsn#" >
			SELECT count(distinct(Dolphin_ID)) as total_dolphins
			FROM
			SIGHTINGS
			INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
			INNER JOIN PROJECTS ON SIGHTINGS.Project_ID = PROJECTS.ID
			WHERE Year(PROJECTS.[Date]) =  #Year(compare_date)# AND MONTH(PROJECTS.[Date]) = #Month(compare_date)#
        </cfquery>
        <cfset compare_date = #DateAdd("m", 1, compare_date)# >
    <!--- loop through query --->
		<cfset structofdolphin = StructNew() />
        <cfif qTotalDolphinsSighted.recordcount neq 0>
        	<cfset structofdolphin["total_dolphins"] = qTotalDolphinsSighted.total_dolphins>
        <cfelse>
        	  <cfset structofdolphin["total_dolphins"] = 0>
        </cfif>
        <cfset ArrayAppend(Arr,structofdolphin)>

		<cfset structofuniquedolphin = StructNew() />
        <cfif qTotalUniqueDolphinsSighted.recordcount neq 0>
        	<cfset structofuniquedolphin["total_unique_dolphins"] = qTotalUniqueDolphinsSighted.total_dolphins>
        <cfelse>
        	  <cfset structofuniquedolphin["total_unique_dolphins"] = 0>
        </cfif>
        <cfset ArrayAppend(Arr,structofuniquedolphin)>

    <!---SerializeJSON --->

    </cfloop>
    <!---<cfdump var="#qTotalUniqueDolphinsSighted#">
    <cfdump var="#qTotalDolphinsSighted#">
    --->
    
    <!---<cfdump var="#qTotalDolphinsSighted#" /> <!--- Shows object having "SQL" property --->
<cfoutput>SQL: #r.SQL#</cfoutput>
    
    
    
<cfabort>--->
<cfoutput>#SerializeJSON(Arr)#</cfoutput>
</cffunction>

<cffunction name="TotalUniqueDolphinsSighted" returntype="any" output="false" access="public" >
	<cfquery name="qTotalUniqueDolphinsSighted" datasource="#variables.dsn#" >
		SELECT
		Year([Date]) AS [Project Year],
		Month([Date]) AS [Project Month],
		Sum(Distinct(SIGHTINGS.FE_TotalDolphin_Best)) AS total_dolphins
		FROM PROJECTS LEFT JOIN SIGHTINGS
		ON PROJECTS.ID = SIGHTINGS.Project_ID
		WHERE (((Year([Date]))=2016) AND ((Month([Date])) between 1 and 8))
		GROUP BY Year([Date]),
		Month([Date])
        
	</cfquery>
   
     <cfreturn qTotalUniqueDolphinsSighted>
</cffunction>




<cffunction name="BirthRate" returntype="any" output="true" access="remote" returnformat="plain">
<cfset Arr = ArrayNew(1)>
	<cfset compare_date = DateFormat(fromDate,'mm-dd-yyyy')>
	<cfloop from="1" to="#month_diff#" index="i">
	<cfquery name="qBirthRate" datasource="#variables.dsn#" result="r" >
        SELECT
        SUBSTRING([DOB EST],0,charindex('/',[DOB EST])) as CMonth,
        Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])) as  Cyear
        FROM [DOLPHINS]
        where [DOB EST] is not null AND
        Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST]))  =  convert(nvarchar(255),#Year(compare_date)#) AND SUBSTRING([DOB EST],0,charindex('/',[DOB EST])) = convert(nvarchar(255),#Month(compare_date)#)
      
	</cfquery>

<cfset compare_date = #DateAdd("m", 1, compare_date)# >
    <!--- loop through query --->
		<cfset structofdolphin = StructNew() />
        <cfif qBirthRate.recordcount neq 0>
        	<cfset structofdolphin["total_dolphins"] = qBirthRate.recordcount>
        <cfelse>
        	  <cfset structofdolphin["total_dolphins"] = 0>
        </cfif>
        <cfset ArrayAppend(Arr,structofdolphin)>
    </cfloop>
   <!--- <cfoutput>SQL: #r.SQL#</cfoutput>
    <cfabort>--->
    
<cfoutput>#SerializeJSON(Arr)#</cfoutput>
</cffunction>

<cffunction name="DeathRate" returntype="any" output="true" access="remote" returnformat="plain">
<cfset Arr = ArrayNew(1)>
	<cfset compare_date = DateFormat(fromDate,'mm-dd-yyyy')>
	<cfloop from="1" to="#month_diff#" index="i">
	<cfquery name="qDeathRate" datasource="#variables.dsn#" result="r">
        SELECT count(*) as total_dolphins FROM Dolphins
		WHERE Year(Dolphins.[Date of Death]) =  #Year(compare_date)# AND MONTH(Dolphins.[Date of Death]) = #Month(compare_date)#
	</cfquery>

     <cfset compare_date = #DateAdd("m", 1, compare_date)# >
    <!--- loop through query --->
		<cfset structofdolphin = StructNew() />
        <cfif qDeathRate.recordcount neq 0>
        	<cfset structofdolphin["total_dolphins"] = qDeathRate.total_dolphins>
        <cfelse>
        	  <cfset structofdolphin["total_dolphins"] = 0>
        </cfif>
        <cfset ArrayAppend(Arr,structofdolphin)>
    </cfloop>
<!---<cfoutput>SQL: #r.SQL#</cfoutput>
    <cfabort>--->
    <cfoutput>#SerializeJSON(Arr)#</cfoutput>
</cffunction>




<cffunction name="BestPlace" returntype="any" output="true" access="remote" returnformat="plain">

    <cfset arr = ArrayNew(1)>
    	<cfset arr[1] =0>
        <cfset arr[2] =0>
        <cfset arr[3] =0>
        <cfset arr[4] =0>
        <cfset arr[5] =0>
        <cfset arr[6] =0>
        
	<cfset compare_date = DateFormat(fromDate,'mm-dd-yyyy')>
	<cfloop from="1" to="#month_diff#" index="i">
	<cfquery name="qBestPlace" datasource="#variables.dsn#" result="r" >
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
        WHERE (((Year([Date])) = #Year(compare_date)#) AND ((Month([Date])) = #Month(compare_date)#))
        GROUP BY DOLPHINS.Code, TLU_Zones.ZSEGMENT
        HAVING (((DOLPHINS.Code) Is Not Null) AND ((TLU_Zones.ZSEGMENT) Is Not Null))
        ORDER BY DOLPHINS.Code
	</cfquery>
    	<cfset compare_date = #DateAdd("m", 1, compare_date)# >
    	<!---<cfquery name="qSegment1" dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where  segment = '1'
		</cfquery>--->

        <cfquery name="qSegment1A" dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '1A'
		</cfquery>
		<cfquery name="qSegment1B"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '1B'
		</cfquery>
        <cfquery name="qSegment1C"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '1C'
		</cfquery>
        <cfquery name="qSegment2"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '2'
		</cfquery>
        <cfquery name="qSegment3"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '3'
		</cfquery>
        <cfquery name="qSegment4"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '4'
		</cfquery>

        <!---<cfquery name="qSegment4A"  dbtype="query">
        	SELECT Dolphin_ID from qBestPlace where segment = '4A'
		</cfquery>--->

        <cfset arr[1] = arr[1] + qSegment1A.recordcount>
        <cfset arr[2] = arr[2] + qSegment1B.recordcount>
        <cfset arr[3] = arr[3] + qSegment1C.recordcount>
        <cfset arr[4] = arr[4] + qSegment2.recordcount>
        <cfset arr[5] = arr[5] + qSegment3.recordcount>
        <cfset arr[6] = arr[6] + qSegment4.recordcount>
      </cfloop>

   <cfoutput>#SerializeJSON(arr)#</cfoutput>

</cffunction>




</cfcomponent>