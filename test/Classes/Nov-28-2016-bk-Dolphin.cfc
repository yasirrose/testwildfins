<cfcomponent>

<cfheader name="Access-Control-Allow-Origin" value="*" />
<cfset variables.dsn = "">
<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
  <cfargument name="dsn" type="string" required="true" hint="datasource">
  <cfset variables.dsn = arguments.dsn>
  <cfreturn this>
</cffunction>


<!--- Get YOB Source --->
<cffunction name="get_YOB_Source" returntype="any" output="false" access="public" >
    <cfquery name="getYOBSource" datasource="#variables.dsn#"  >
	SELECT * FROM TLU_YOB_Source
	</cfquery>
	<cfreturn getYOBSource>
</cffunction>


<!--- Get get_Dolphinlist--->
<cffunction name="get_Dolphinlist" returntype="any" output="false" access="public" >
    <cfquery name="getdolphin" datasource="#variables.dsn#"  >
	SELECT ID,Code,Name,DistinctDate,DScore,Sex FROM DOLPHINS 
    <cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
    where Name LIKE '%#form.searchword#%' OR Code LIKE  '%#form.searchword#%'
    </cfif>
     order by ID DESC
	</cfquery>
	<cfreturn getdolphin>
</cffunction>

<cffunction name="add_New_dolphin" access="remote" returnformat="plain" output="true">
<cfoutput>

<cfparam name="Form.Verify" default="0">

<cfquery name="insert_dolhpin" datasource="#application.dsn#" result='get_res'>
insert into DOLPHINS   (Name,
					   	Code,
                        sex,
                        DistinctDate,
                        DScore,
                        [Date of Death],
                        YearOfBirth,
                        Mothers,
                        Grandmother,
                        GreatGrandmother,
                        [DOB EST],
                        [Dispersal Date],
                        Catalog,
                        [Biopsy No],
                        [First Sighting Date],
                        [CFS ID],
                        [Hubbs ID],
                        [MJ ID],
                        [JU ID],
                        [FIT ID],
                        [Source YOB],
                        Verify
                     	)

				Values(
						<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Name#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Code#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sex#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp"  value='#Form.DistinctDate#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp"  value='#Form.Date_of_Death#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.YearOfBirth#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Mothers#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Grandmother#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.GreatGrandmother#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Date_of_Birth_EST#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Dispersal_Date#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Catalog#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Biopsy_No#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.First_Sighting_Date#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.CFSID#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HubbsID#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.MJID#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.JUID#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FITID#'>,
                        <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.Source_YOB_ID#'>,
                        <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.Verify#'>
                       )
</cfquery>

<cfif get_res.RECORDCOUNT eq 1>
<div class="alert alert-success">
  <strong>Success!</strong> Dolphin Added.
</div>
<cfelse>
<div class="alert alert-danger">
  <strong>Error!</strong> Insertion Failed.
</div>
</cfif>

</cfoutput>
</cffunction>

<cffunction name="DeleteDolphin" access="remote" returnformat="plain" output="true">

<cfquery name="delete" datasource="#application.dsn#">
delete from DOLPHINS where ID=#url.id#
</cfquery>
</cffunction>

<cffunction name="getsingl_Dolphin" access="public"  output="false">

<cfquery name="query" datasource="#application.dsn#">
select DOLPHINS.ID,
		DOLPHINS.[Recapture Date 2] as RecaptureDate2 ,
        DOLPHINS.Field1,
        DOLPHINS.[Recapture Date 1] as RecaptureDate1,
        DOLPHINS.[Recapture Date 3] as RecaptureDate3,
        DOLPHINS.Code,
        DOLPHINS.Name,
        DOLPHINS.[Catalog],
        DOLPHINS.Sex,
        DOLPHINS.[Distinct],
        DOLPHINS.DistinctDate,
        DOLPHINS.FB_No,
        DOLPHINS.FB_On_Date,
        DOLPHINS.FB_Side,
        DOLPHINS.[LEFT],
        DOLPHINS.Media_Left,
        DOLPHINS.[RIGHT],
        DOLPHINS.Media_Right,
        DOLPHINS.[Biopsy No] as BiopsyNo ,
        DOLPHINS.PRES_LOBO,
        DOLPHINS.PRES_LOBO_DATE,
        DOLPHINS.Coalitions,
        DOLPHINS.[Lobo Confirmed] as LoboConfirmed,
        DOLPHINS.[Other Partners] as OtherPartners,
        DOLPHINS.Mothers,
        DOLPHINS.Lineage,
        DOLPHINS.Grandmother,
        DOLPHINS.GreatGrandmother,
        DOLPHINS.[Naming regime] as Namingregime,
        DOLPHINS.[Family Name] as FamilyName,
        DOLPHINS.[DOB ACT] as DateofBirthACT,
        DOLPHINS.[DOB EST] as DateofBirthEST,
        DOLPHINS.[Date of Death] as DateofDeath,
        DOLPHINS.[Field ID] as FieldID,
        DOLPHINS.[Dead?] as Dead,
        DOLPHINS.YearOfBirth,
        DOLPHINS.SiteFide,
        DOLPHINS.[Dispersal Date] as DispersalDate,
        DOLPHINS.NeverSighted,
        DOLPHINS.VERIFY,
        DOLPHINS.UnableToVerify,
        DOLPHINS.DScore,
        DOLPHINS.[CFS ID] as CFSID,
        DOLPHINS.[Hubbs ID] as HubbsID,
        DOLPHINS.[MJ ID] as MJID,
        DOLPHINS.[JU ID] as JUID,
        DOLPHINS.[FIT ID] as FITID,
        DOLPHINS.[Source YOB] as SourceYOB,
        DOLPHINS.[HERA Error] as HERAError,
        DOLPHINS.[First Sighting Date] as FirstSightingDate,
        DOLPHINS.[Fin Change 1] as FinChange1,
        DOLPHINS.[HERA/Rescue Fin Change 1] as HERARescueFinChange1,
        DOLPHINS.[Fin Change 2] as FinChange2,
        DOLPHINS.[HERA/Rescue Fin Change 2] as HERARescueFinChange2,
        DOLPHINS.[Fin Change 3] as FinChange3,
        DOLPHINS.[HERA/Rescue Fin Change 3] as HERARescueFinChange3,
        DOLPHINS.[Fin Change 4] as FinChange4,
        DOLPHINS.[HERA/Rescue] as HERARescue,
        DOLPHINS.SSMA_TimeStamp,
       	TLU_YOB_Source.* from DOLPHINS inner join TLU_YOB_Source on DOLPHINS.[Source YOB]=TLU_YOB_Source.ID where DOLPHINS.ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
</cfquery>
<cfreturn  query>

</cffunction>



<cffunction name="update_New_dolphin" access="remote" returnformat="plain" output="true">
<cfoutput>

<cfquery name="update_dolhpin" datasource="#application.dsn#" result='get_res'>

 update DOLPHINS set

  						Name=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Name#'>,
					   	Code=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Code#'>,
                        sex=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sex#'>,
                        DistinctDate=<cfqueryparam cfsqltype="cf_sql_timestamp"  value='#Form.DistinctDate#'>,
                        [Distinct]=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Distinct#'>,
                     
                        DScore=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#'>,
                        [Date of Death]=<cfqueryparam cfsqltype="cf_sql_timestamp"  value='#Form.Date_of_Death#'>,
                        YearOfBirth=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.YearOfBirth#'>,
                        Mothers=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Mothers#'>,
                        Grandmother=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Grandmother#'>,
                        GreatGrandmother=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.GreatGrandmother#'>,
                        [DOB EST]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Date_of_Birth_EST#'>,
                        [Dispersal Date]=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Dispersal_Date#'>,
                        
                        Catalog=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Catalog#'>,
                        [Biopsy No]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Biopsy_No#'>,
                        [First Sighting Date]=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.First_Sighting_Date#'>,
                        
                       	[CFS ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.CFSID#'>,
                        [Hubbs ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HubbsID#'>,
                        [MJ ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.MJID#'>,
                        [JU ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.JUID#'>,
                        [FIT ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FITID#'>,
                        [Source YOB]=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.Source_YOB_ID#'>,
                        Verify=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.Verify#'>
                       
                        where ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.ID#'>

                        </cfquery>

 <cfif get_res.RECORDCOUNT eq 1>
<div class="alert alert-success">
  <strong>Success!</strong> Dolphin record Updated.
</div>
<cfelse>
<div class="alert alert-danger">
  <strong>Error!</strong> Updation Failed.
</div>
</cfif>

</cfoutput>
</cffunction>


<cffunction name="getdolphin" access="public" returnformat="plain" output="true">

<cfquery name="getdolphin" datasource="#application.dsn#">
	SELECT
	DOLPHINS.Code,
	DOLPHINS.Name,
	DOLPHINS.Mothers ,
	DOLPHINS.Grandmother,
	DOLPHINS.[Biopsy No] as Biopsy_No,
	DOLPHINS.[Sex],
    DOLPHINS.YearOfBirth,
	DOLPHINS.[First Sighting Date] as First_Sighting_Date,
	DOLPHINS.DistinctDate,
	PROJECTS.Date as DateSeen,
	SIGHTINGS.Begin_LAT_Dec,
	SIGHTINGS.Begin_LON_Dec,
	DOLPHINS.[Date of Death] as DOD,
	DOLPHINS. [DOB EST] as DOB,
	SIGHTINGS.Zone_id,
	SIGHTINGS.ID as SightingNo,
	SIGHTINGS.Begin_LAT_Dec,SIGHTINGS.Begin_LON_Dec,
	DOLPHINS.[First Sighting Date],
	SIGHTINGS.Easting_X, SIGHTINGS.Northing_Y
	FROM PROJECTS LEFT JOIN 
    ((SIGHTINGS LEFT JOIN 
    (DOLPHINS RIGHT JOIN 
    DOLPHIN_SIGHTINGS ON DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID) 
    ON 
      SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
     LEFT JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID) 
     ON 
     PROJECTS.ID = SIGHTINGS.Project_ID
	where DOLPHINS.ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.DOLPHINID#'>
	order by dateseen desc
 </cfquery>
 
 <cfreturn getdolphin>

</cffunction>
<cffunction name="getCalfs" access="public" returnformat="plain" output="true">
	<cfargument name="code" default="" required="yes">
<cfquery name="qgetCalfs" datasource="#variables.dsn#">
    SELECT DOLPHINS.Code, DOLPHINS.Lineage, 
    DOLPHINS.[DOB EST] AS Expr1, DOLPHINS.YearOfBirth, 
    DOLPHINS.[Date of Death]
    FROM DOLPHINS
    WHERE ((DOLPHINS.Lineage) Is Not Null)
    AND DOLPHINS.Mothers = <cfqueryparam cfsqltype="cf_sql_varchar" value='#code#'>
 </cfquery>   
 <cfreturn qgetCalfs>
</cffunction>

<cffunction name="getdolphinFriends" access="public" returnformat="plain" output="true">
<cfargument name='SightingNo' default=''>
<cfargument name='code' default=''>
<cfquery name="qgetdolphinFriends" datasource="#application.dsn#">
	SELECT   DOLPHINS.Name as DOLPHIN_NAME , DOLPHINS.[Sex] ,DOLPHINS.ID  , COUNT(*) as times 
	FROM DOLPHIN_SIGHTINGS
	inner join DOLPHINS
	on
	DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID
	where sighting_id IN (#SightingNo#)
    AND DOLPHINS.CODE != '#code#'
    GROUP BY
    DOLPHINS.Name, DOLPHINS.[Sex] ,DOLPHINS.ID
 </cfquery>
 
 <cfreturn qgetdolphinFriends>
</cffunction>

<cffunction name="getCatalog" returntype="any" output="false" access="public" >
    <cfquery name="qgetCatalog" datasource="#variables.dsn#"  >
        SELECT * from TLU_Catalog where active = 1
    </cfquery>
	<cfreturn qgetCatalog>
</cffunction>

<cffunction name="InsertMMHSRP" returntype="any" output="false" access="public" >
    <cfquery name="qinsert" datasource="#variables.dsn#" result="returndata">
        Insert into Dolphin_MMHSRP 
        (Dolphin_ID,MMHSRP_ID,Description,Date) 
        values
        (
        <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.id#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.MMHSRP_ID#">,
        <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.Description#">,
        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Form.Date_MMHSRP#">
        )
    </cfquery>
	<cfreturn returndata>
</cffunction>

<cffunction name="getMMHSRP_Dophin" returntype="any" output="false" access="public" >
    <cfquery name="qget" datasource="#variables.dsn#" result="returndata">
        select * from Dolphin_MMHSRP where Dolphin_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
    </cfquery>
	<cfreturn qget>
</cffunction>

<cffunction name="DeleteMMHSRP" access="remote" returnformat="plain" output="true">
<cfquery name="delete" datasource="#application.dsn#">
delete from Dolphin_MMHSRP where ID=#url.id#
</cfquery>
</cffunction>


<cffunction name="add_SDOdolphin" access="public"  output="false">

<cfparam name="Form.Dead" default="0">
<cfparam name="Form.Distinct" default="0">
<cfparam name="Form.PRES_LOBO" default="0">
<cfparam name="Form.HERARescueFinChange1" default="0">
<cfparam name="Form.HERARescueFinChange2" default="0">
<cfparam name="Form.HERARescueFinChange3" default="0">
<cfparam name="Form.HERARescue" default="0">

<cfquery name="insert_sdo" datasource="#application.dsn#" result='get_res'>
insert into TLU_Dolphin_SDO 
						(
                        Dolphin_ID,
                        PRES_LOBO_DATE,
                        Lobo_Confirmed,
                        Recapture_Date_1,
                        Recapture_Date_2,
                        Recapture_Date_3,
                        HERAError,
                        FinChange1,
                        FinChange2,
                        FinChange3,
                        FinChange4,
                        FB_on_Date,
                        FB_Side,
                        Dead,
                        [Distinct],
                        PRES_LOBO,
                        HERARescueFinChange1,
                        HERARescueFinChange2,
                        HERARescueFinChange3,
                        HERARescue
                        )
				Values(
						<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.DOLPHINID#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.PRES_LOBO_DATE#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Lobo_Confirmed#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_1#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_2#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_3#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HERAError#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange1#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange2#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange3#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FinChange4#'>,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FB_on_Date#'>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FB_Side#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Dead#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Distinct#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.PRES_LOBO#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange1#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange2#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange3#'>,
                        <cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescue#'>
                       )
</cfquery>
<cfreturn get_res>
</cffunction>



<cffunction name="Update_SDOdolphin" access="public"  output="false">

<cfparam name="Form.Dead" default="0">
<cfparam name="Form.Distinct" default="0">
<cfparam name="Form.PRES_LOBO" default="0">
<cfparam name="Form.HERARescueFinChange1" default="0">
<cfparam name="Form.HERARescueFinChange2" default="0">
<cfparam name="Form.HERARescueFinChange3" default="0">
<cfparam name="Form.HERARescue" default="0">

<cfquery name="update_sdo" datasource="#application.dsn#" result='get_res'>
update  TLU_Dolphin_SDO  set 
  						Dolphin_ID=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.Dolphin_ID#'>,
                        PRES_LOBO_DATE=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.PRES_LOBO_DATE#'>,
                        Lobo_Confirmed=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Lobo_Confirmed#'>,
                        Recapture_Date_1= <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_1#'>,
                        Recapture_Date_2=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_2#'>,
                        Recapture_Date_3=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Recapture_Date_3#'>,
                        HERAError=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HERAError#'>,
                        FinChange1=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange1#'>,
                        FinChange2=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange2#'>,
                        FinChange3=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FinChange3#'>,
                        FinChange4=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FinChange4#'>,
                        FB_on_Date=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.FB_on_Date#'>,
                        FB_Side=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FB_Side#'>,
                        Dead=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Dead#'>,
                        [Distinct]=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.Distinct#'>,
                        PRES_LOBO=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.PRES_LOBO#'>,
                        HERARescueFinChange1=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange1#'>,
                        HERARescueFinChange2=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange2#'>,
                        HERARescueFinChange3=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescueFinChange3#'>,
                        HERARescue=<cfqueryparam cfsqltype="cf_sql_bit" value='#Form.HERARescue#'>
                        where ID =<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.ID#'>
				

</cfquery>
<cfreturn get_res>
</cffunction>

<cffunction name="getSDODolphin" returntype="any" output="false" access="public" >
    <cfquery name="qget" datasource="#variables.dsn#" result="returndata">
        select 
        TLU_Dolphin_SDO.Dolphin_ID,
        TLU_Dolphin_SDO.PRES_LOBO_DATE,
        TLU_Dolphin_SDO.Lobo_Confirmed,
        TLU_Dolphin_SDO.Recapture_Date_1,
        TLU_Dolphin_SDO.Recapture_Date_2,
        TLU_Dolphin_SDO.Recapture_Date_3,
        TLU_Dolphin_SDO.HERAError,
        TLU_Dolphin_SDO.FinChange1,
        TLU_Dolphin_SDO.FinChange2,
        TLU_Dolphin_SDO.FinChange3,
         TLU_Dolphin_SDO.FB_on_Date,
         TLU_Dolphin_SDO.FB_Side,
         TLU_Dolphin_SDO.Dead,
         TLU_Dolphin_SDO.[Distinct],
         TLU_Dolphin_SDO.PRES_LOBO,
         TLU_Dolphin_SDO.HERARescueFinChange1,
         TLU_Dolphin_SDO.HERARescueFinChange2,
         TLU_Dolphin_SDO.HERARescueFinChange3,
         TLU_Dolphin_SDO.HERARescue,
         TLU_Dolphin_SDO.FinChange4,
         TLU_Dolphin_SDO.ID,
        
        DOLPHINS.Name from TLU_Dolphin_SDO inner join DOLPHINS on DOLPHINS.ID=TLU_Dolphin_SDO.Dolphin_ID  where Dolphin_ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.Dolphin_ID#">
    </cfquery>
	<cfreturn qget>
</cffunction>

<cffunction name="getSDODolphin_single" returntype="any" output="false" access="public" >
    <cfquery name="qget" datasource="#variables.dsn#" result="returndata">
        select 
        TLU_Dolphin_SDO.Dolphin_ID,
        TLU_Dolphin_SDO.PRES_LOBO_DATE,
        TLU_Dolphin_SDO.Lobo_Confirmed,
        TLU_Dolphin_SDO.Recapture_Date_1,
        TLU_Dolphin_SDO.Recapture_Date_2,
        TLU_Dolphin_SDO.Recapture_Date_3,
        TLU_Dolphin_SDO.HERAError,
        TLU_Dolphin_SDO.FinChange1,
        TLU_Dolphin_SDO.FinChange2,
        TLU_Dolphin_SDO.FinChange3,
         TLU_Dolphin_SDO.FB_on_Date,
         TLU_Dolphin_SDO.FB_Side,
         TLU_Dolphin_SDO.Dead,
         TLU_Dolphin_SDO.[Distinct],
         TLU_Dolphin_SDO.PRES_LOBO,
         TLU_Dolphin_SDO.HERARescueFinChange1,
         TLU_Dolphin_SDO.HERARescueFinChange2,
         TLU_Dolphin_SDO.HERARescueFinChange3,
         TLU_Dolphin_SDO.HERARescue,
         TLU_Dolphin_SDO.FinChange4,
         TLU_Dolphin_SDO.ID,
        
        DOLPHINS.Name from TLU_Dolphin_SDO inner join DOLPHINS on DOLPHINS.ID=TLU_Dolphin_SDO.Dolphin_ID  where TLU_Dolphin_SDO.ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.ID#">
    </cfquery>
	<cfreturn qget>
</cffunction>

<cffunction name="DeleteSdodolphin" access="remote" returnformat="plain" output="true">
<cfquery name="delete" datasource="#application.dsn#">
delete from TLU_Dolphin_SDO where ID=#url.id#
</cfquery>
</cffunction>

<cffunction name="getsightingByDolphin" access="public" returnformat="plain" output="true">
        <cfquery name="getdata" datasource="#variables.dsn#">
        SELECT DOLPHIN_SIGHTINGS.Dolphin_ID,
            DOLPHIN_SIGHTINGS.Sighting_ID
            FROM
            DOLPHIN_SIGHTINGS
            WHERE  DOLPHIN_SIGHTINGS.Dolphin_ID=<cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer"> order by  DOLPHIN_SIGHTINGS.Sighting_ID desc

        </cfquery>
        <cfreturn getdata>
</cffunction>

<cffunction name="Add_Biopsy" access="remote" returnformat="plain" output="true">
<cfargument name="BiopsyTeam" default=" ">

<cfparam name="form.TargetLevel" default="">
<cfparam name="form.Outcome" default="">
<cfparam name="form.SkinDMSO" default="">
<cfparam name="form.SkinRNAlater" default="">
<cfparam name="form.SkinDCryovial" default="">
<cfparam name="form.SampleTaken" default="">
<cfparam name="form.Samplehead" default="">
<cfparam name="form.SampleCollected" default="">
<cfparam name="form.BlubberTeflonVial" default="">
<cfparam name="form.BlubberCryovialRed" default="">
<cfparam name="form.BlubberCryovialBlue" default="">

<cfquery name="insertdata" datasource="#application.dsn#" result="result">
	INSERT INTO BIOPSY_SHOTS 
    		(Enter_Date,
             Dolphin_ID,
             Sighting_ID,
             ShotTime,
             Arbalester,
             TargetAnimalBehavior,
             ShotNumber,
             ShotDistance,
             Outcome,
       		 TargetLevel,
             TABPre_Activity_Mill,
             TABPre_Activity_Feed,
             TABPre_Activity_ProbFeed,
             TABPre_Activity_Travel,
             TABPre_Activity_Play,
             TABPre_ACTIVITY_REST,
             TABPre_Activity_Leap_tailslap_chuff,
             TABPre_Activity_Social,
             TABPre_ACTIVITY_WITHBOAT,
             TABPre_Activity_Other,
             TABPre_Activity_Avoid_Boat,
             TABPre_Depredation,
             TABPre_Herding,
             TABPost_Activity_Mill,
             TABPost_Activity_Feed,
             TABPost_Activity_ProbFeed,
             TABPost_Activity_Travel,
             TABPost_Activity_Play,
             TABPost_ACTIVITY_REST,
             TABPost_Activity_Leap_tailslap_chuff,
             TABPost_Activity_Social,
             TABPost_ACTIVITY_WITHBOAT,
             TABPost_Activity_Other,
             TABPost_Activity_Avoid_Boat,
             TABPost_Depredation,
             TABPost_Herding,
             
             GBPre_Activity_Mill,
             GBPre_Activity_Feed,
             GBPre_Activity_ProbFeed,
             GBPre_Activity_Travel,
             GBPre_Activity_Play,
             GBPre_ACTIVITY_REST,
             GBPre_Activity_Leap_tailslap_chuff,
             GBPre_Activity_Social,
             GBPre_ACTIVITY_WITHBOAT,
             GBPre_Activity_Other,
             GBPre_Activity_Avoid_Boat,
             GBPre_Depredation,
             GBPre_Herding,
             
             GBPost_Activity_Mill,
             GBPost_Activity_Feed,
             GBPost_Activity_ProbFeed,
             GBPost_Activity_Travel,
             GBPost_Activity_Play,
             GBPost_ACTIVITY_REST,
             GBPost_Activity_Leap_tailslap_chuff,
             GBPost_Activity_Social,
             GBPost_ACTIVITY_WITHBOAT,
             GBPost_Activity_Other,
             GBPost_Activity_Avoid_Boat,
             GBPost_Depredation,
             GBPost_Herding,
             
        	 HitLocation,
             SubSample,
             
             Processor,
             SampleLength,
             SkinDMSO,
             SkinRNAlater,
             SkinDCryovial,
             SampleNumber,
             SampleTaken,
             Samplehead,
             SampleCollected,
             BlubberTeflonVial,
             BlubberCryovialRed,
             BlubberCryovialBlue
            )Values(
             	<cfqueryparam cfsqltype="cf_sql_timestamp" value='#NOW()#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Dolphin_ID#' null="#IIF(form.Dolphin_ID EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Sighting_ID#'>,
                <cfqueryparam cfsqltype="cf_sql_time" value='#form.ShotTime#' null="#IIF(form.ShotTime EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Arbalester#' null="#IIF(form.Arbalester EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TargetAnimalBehavior#' null="#IIF(form.TargetAnimalBehavior EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ShotNumber#' null="#IIF(form.ShotNumber EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ShotDistance#' null="#IIF(form.ShotDistance EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.Outcome#' null="#IIF(form.Outcome EQ "", true, false)#">,
               
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetLevel#' null="#IIF(form.TargetLevel EQ "", true, false)#">,
             	
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Mill#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Feed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_ProbFeed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Travel#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Play#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_REST#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Leap_tailslap_chuff#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Social#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_ACTIVITY_WITHBOAT#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Other#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Activity_Avoid_Boat#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Depredation#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPre_Herding#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Mill#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Feed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_ProbFeed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Travel#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Play#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_REST#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Leap_tailslap_chuff#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Social#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_ACTIVITY_WITHBOAT#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Other#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Activity_Avoid_Boat#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Depredation#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.TABPost_Herding#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Mill#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Feed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_ProbFeed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Travel#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Play#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_REST#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Leap_tailslap_chuff#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Social#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_ACTIVITY_WITHBOAT#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Other#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Activity_Avoid_Boat#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Depredation#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPre_Herding#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Mill#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Feed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_ProbFeed#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Travel#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Play#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_REST#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Leap_tailslap_chuff#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Social#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_ACTIVITY_WITHBOAT#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Other#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Activity_Avoid_Boat#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Depredation#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.GBPost_Herding#'>,
              <cfqueryparam cfsqltype="cf_sql_integer" value='#form.HitLocation#' null="#IIF(form.HitLocation EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SubSample#' null="#IIF(form.SubSample EQ "", true, false)#">,
                
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Processor#' null="#IIF(form.Processor EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.SampleLength#' null="#IIF(form.SampleLength EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.SkinDMSO#' null="#IIF(form.SkinDMSO EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.SkinRNAlater#' null="#IIF(form.SkinRNAlater EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.SkinDCryovial#' null="#IIF(form.SkinDCryovial EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.SampleNumber#' null="#IIF(form.SampleNumber EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.SampleTaken#' null="#IIF(form.SampleTaken EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.Samplehead#' null="#IIF(form.Samplehead EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.SampleCollected#' null="#IIF(form.SampleCollected EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.BlubberTeflonVial#' null="#IIF(form.BlubberTeflonVial EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.BlubberCryovialRed#' null="#IIF(form.BlubberCryovialRed EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_bit" value='#form.BlubberCryovialBlue#' null="#IIF(form.BlubberCryovialBlue EQ "", true, false)#">
           	 )    
	</cfquery>
        <cfif BiopsyTeam NEQ '' >
 		<cfloop index = "ListElement" list = "#BiopsyTeam#">
		<cfquery name="update" datasource="#Application.dsn#" result="updating" >
        insert into TEAMMEMBER_Biopsy (Biopsy_ID,TeamMemberID) values
        (<cfqueryparam cfsqltype="cf_sql_integer" value='#result.identitycol#'>,
        <cfqueryparam cfsqltype="cf_sql_integer" value='#VAL(ListElement)#'>
        )
        </cfquery>
      </cfloop>
      </cfif>
     <cfreturn result>
</cffunction>


<cffunction name="getBiopsy" access="remote" returntype="any" output="true">
        <cfquery name="query" datasource="#Application.dsn#">
        SELECT Biopsy_ID,Sighting_ID,SampleNumber,ShotNumber,Outcome FROM
            BIOPSY_SHOTS
            WHERE  Dolphin_ID=<cfqueryparam value='#url.id#' cfsqltype="cf_sql_integer"> order by  Biopsy_ID desc
        </cfquery>
    <cfoutput>#SerializeJSON(query)#</cfoutput>
</cffunction>

<cffunction name="DeleteBiopsy" access="remote" returntype="any" output="true">
        <cfquery name="query" datasource="#Application.dsn#">
        Delete FROM BIOPSY_SHOTS
            WHERE  Biopsy_ID=<cfqueryparam value='#url.id#' cfsqltype="cf_sql_integer">
        </cfquery>
</cffunction>

<cffunction name="getBiopsyBehavior" returntype="any" output="false" access="public" >
    <cfquery name="qgetBiopsyBehavior" datasource="#variables.dsn#"  >
        SELECT * from TLU_BiopsyBehavior where active=1
    </cfquery>
	<cfreturn qgetBiopsyBehavior>
</cffunction>

<cffunction name="getHitLocation" returntype="any" output="false" access="public" >
    <cfquery name="qgetHitLocation" datasource="#variables.dsn#"  >
        SELECT * from TLU_HitLocation where active=1
    </cfquery>
	<cfreturn qgetHitLocation>
</cffunction>

<cffunction name="getSubSampleType" returntype="any" output="false" access="public" >
    <cfquery name="qgetSubSampleType" datasource="#variables.dsn#"  >
        SELECT * from TLU_SubSampleType where active=1
    </cfquery>
	<cfreturn qgetSubSampleType>
</cffunction>



</cfcomponent>