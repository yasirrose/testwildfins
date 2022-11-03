<cfcomponent>
    <cfheader name="Access-Control-Allow-Origin" value="*" />
    <cfset variables.dsn = "wildfins">
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
                <cfif isdefined("form") and len(trim(form.searchword)) NEQ 0>
                    SELECT
                    <!---TOP 1--->
                    DOLPHINS.ID,
                    Dolphin_DScore.ID,
                    DOLPHINS.Code,
                    DOLPHINS.Name,
                    DOLPHINS.DistinctDate,
                    DOLPHINS.Sex,
                    Dolphin_DScore.DScore
                    FROM DOLPHINS left join Dolphin_DScore ON Dolphin_DScore.DolphinID = DOLPHINS.ID
                    AND Dolphin_DScore.ID = (
                        SELECT TOP 1 d.ID
                        FROM Dolphin_DScore d 
                        WHERE d.DolphinID = DOLPHINS.ID
                        ORDER BY d.DScoreDate DESC
                        )
                    where DOLPHINS.Name LIKE '%#form.searchword#%' OR DOLPHINS.Code LIKE  '%#form.searchword#%' GROUP BY DOLPHINS.ID,Dolphin_DScore.ID, DOLPHINS.Code, DOLPHINS.Name,DOLPHINS.DistinctDate,DOLPHINS.Sex, Dolphin_DScore.DScore
                    order by DOLPHINS.Name
                   <cfelse>
                    SELECT DOLPHINS.ID,
                    DOLPHINS.Code,
                    DOLPHINS.Name,
                    DOLPHINS.DistinctDate,
                    DOLPHINS.Sex,
                    Dolphin_DScore.DScore
                    FROM DOLPHINS left join Dolphin_DScore ON Dolphin_DScore.DolphinID = DOLPHINS.ID
                    AND Dolphin_DScore.ID = (
                        SELECT TOP 1 d.ID
                        FROM Dolphin_DScore d 
                        WHERE d.DolphinID = DOLPHINS.ID
                        ORDER BY d.DScoreDate DESC
                        )
                    order by DOLPHINS.Name
                    </cfif>
            </cfquery>
            <cfreturn getdolphin>
    </cffunction>
    <cffunction name="getDscoreDropdown" output="TRUE" returntype="any" access="public">
        <cfquery name="getDscoreDropdown" datasource="#variables.dsn#" result="get_dscore_value">
	    SELECT * FROM TLU_Dscore
        </cfquery>
        <cfreturn getDscoreDropdown>
    </cffunction>
    <cffunction name="add_New_dolphin" access="remote" returnformat="plain" output="true">
        <cfoutput>
        <cfparam name="Form.Verify" default="0">
        <cfparam name="Form.Source_YOB_ID" default="0">
        <cfparam name="Form.BestImage"	 default="">
        <cfquery name="lastentry" datasource="#variables.dsn#">
            select TOP 1 ID from DOLPHINS order by ID desc
        </cfquery>
        <cfset IDE = #lastentry.ID# + 1>
        <cfquery name="insert_dolhpin" datasource="#variables.dsn#" result='get_res'>
            insert into DOLPHINS(
                            ID,
                            Name,
                            Code,
                            sex,
                            [Source Sexed],
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
                            Verify,
                            [UNF ID],
                            [SAET ID]
                            )
                            Values(
                            <cfqueryparam cfsqltype="cf_sql_integer" value='#IDE#'>,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Name#'>,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Code#'>,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sex#'>,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sourcesex#'>,
                            <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.DistinctDate#'>,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#'>,
                            <cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Date_of_Death#'>,
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
                            <cfqueryparam  value='#Form.Source_YOB_ID#'>,
                            <cfqueryparam  value='#Form.Verify#'>,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.UNFID#'>,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.SAETID#'>
                           )

        </cfquery>
        <cfif len(trim(BestImage))>
            <cfquery name="getEnterdID"  datasource="#variables.dsn#">
                SELECT ID , Code, [First Sighting Date] AS DDATE FROM DOLPHINS WHERE Code = '#Form.Code#'
            </cfquery>
        
            <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
            <!--------   Resize rename/extension changed------------->
            <cfset namee = #getEnterdID.ID#&"_"&#getEnterdID.Code#&"_"&#returnBestImage.SERVERFILENAME#&".jpg">
            <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##namee#">
            <cfquery name="update_dolphin_image"datasource="#variables.dsn#" result='get_image'>
                UPDATE DOLPHINS
                SET ImageName = '#namee#'
                WHERE ID = #getEnterdID.ID#
            </cfquery>
        </cfif>
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
        <cfquery name="delete" datasource="#variables.dsn#">
            delete from DOLPHINS where ID=#url.id#
        </cfquery>
    </cffunction>
    <cffunction name="getShotDetails">
        <!---<cfparam name="dolphin_id" default="0">--->
        <!---<cfquery name="getShotDetails" datasource="#variables.dsn#">--->
            <!---select count (ShotNumber) as totalShots from BIOPSY_SHOTS WHERE Dolphin_ID = "#dolphin_id#"--->
        <!---</cfquery>--->
    </cffunction>
    <cffunction name="getsingl_Dolphin" access="public"  output="false">
        <cfquery name="query" datasource="#variables.dsn#">
            select DOLPHINS.ID,
            DOLPHINS.[Recapture Date 2] as RecaptureDate2 ,
            DOLPHINS.Field1,
            DOLPHINS.[Recapture Date 1] as RecaptureDate1,
            DOLPHINS.[Recapture Date 3] as RecaptureDate3,
            DOLPHINS.Code,
            DOLPHINS.Name,
            DOLPHINS.[Catalog],
            DOLPHINS.Sex,
            DOLPHINS.ImageName,
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
            DOLPHINS.[UNF ID] as UNFID,
            DOLPHINS.[SAET ID] as SAETID,
            Dolphin_DScore.DScore,
            TLU_YOB_Source.* from DOLPHINS left join TLU_YOB_Source on DOLPHINS.[Source YOB]=TLU_YOB_Source.ID left join Dolphin_DScore on Dolphin_DScore.DolphinID = DOLPHINS.ID where DOLPHINS.ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
        </cfquery>
        <cfreturn  query>
    </cffunction>
    <cffunction name="update_New_dolphin" access="remote" returnformat="plain" output="true">
        <cfoutput>
            <cfparam name="Form.BestImage" default="">
            <cfparam name="namee" default="">
            <cfif len(trim(BestImage))>
                <cffile action="upload" fileField="BestImage" destination="#Application.CloudDirectory#" result="returnBestImage" nameconflict="overwrite">
    <!--------   Resize rename/extension changed------------->
                <cfset namee =#Form.ID#&"_"&#Form.Code#&"_"&#returnBestImage.SERVERFILENAME#&".jpg">
                <cffile action = "rename" source = "#Application.CloudDirectory##returnBestImage.serverfile#" destination = "#Application.CloudDirectory##namee#">
            </cfif>
            <cfquery name="update_dolhpin" datasource="#variables.dsn#" result='get_res'>
                    update DOLPHINS set
                    Name=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Name#' null="#IIF(Form.Name EQ "", true, false)#">,
                    Code=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Code#' null="#IIF(Form.Code EQ "", true, false)#">,
                    sex=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sex#' null="#IIF(Form.sex EQ "", true, false)#">,
                    [Source Sexed]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sourcesex#'  null="#IIF(Form.sourcesex EQ "", true, false)#">,
                    DistinctDate=<cfqueryparam cfsqltype="cf_sql_timestamp"  value='#Form.DistinctDate#' null="#IIF(Form.DistinctDate EQ "", true, false)#">,
                    DScore=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#' null="#IIF(Form.Dscore EQ "", true, false)#" >,
                    [Date of Death]=<cfqueryparam cfsqltype="cf_sql_timestamp"  value='#Form.Date_of_Death#' null="#IIF(Form.Date_of_Death EQ "", true, false)#">,
                    YearOfBirth=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.YearOfBirth#' null="#IIF(Form.YearOfBirth EQ "", true, false)#">,
                    Mothers=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Mothers#' null="#IIF(Form.Mothers EQ "", true, false)#">,
                    Grandmother=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Grandmother#' null="#IIF(Form.Grandmother EQ "", true, false)#">,
                    GreatGrandmother=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.GreatGrandmother#' null="#IIF(Form.GreatGrandmother EQ "", true, false)#">,
                    [DOB EST]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Date_of_Birth_EST#' null="#IIF(Form.Date_of_Birth_EST EQ "", true, false)#">,
                    [Dispersal Date]=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.Dispersal_Date#' null="#IIF(Form.Dispersal_Date EQ "", true, false)#">,
                    Catalog=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Catalog#' null="#IIF(Form.Catalog EQ "", true, false)#">,
                    [Biopsy No]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Biopsy_No#' null="#IIF(Form.Biopsy_No EQ "", true, false)#">,
                    [First Sighting Date]=<cfqueryparam cfsqltype="cf_sql_timestamp" value='#Form.First_Sighting_Date#' null="#IIF(Form.First_Sighting_Date EQ "", true, false)#">,
                    [CFS ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.CFSID#' null="#IIF(Form.CFSID EQ "", true, false)#">,
                    [Hubbs ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.HubbsID#' null="#IIF(Form.HubbsID EQ "", true, false)#">,
                    [MJ ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.MJID#' null="#IIF(Form.MJID EQ "", true, false)#">,
                    [JU ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.JUID#' null="#IIF(Form.JUID EQ "", true, false)#">,
                    [FIT ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.FITID#' null="#IIF(Form.FITID EQ "", true, false)#">,
                    [UNF ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.UNFID#' null="#IIF(Form.UNFID EQ "", true, false)#">,
                    [SAET ID]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.SAETID#' null="#IIF(Form.SAETID EQ "", true, false)#">,
                    [Source YOB]=<cfqueryparam cfsqltype="cf_sql_integer" value='#Form.Source_YOB_ID#' null="#IIF(Form.Source_YOB_ID EQ "", true, false)#">,
                    ImageName= '#namee#'
                    where ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.ID#'>
                    update Dolphin_DScore set DScore =<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.Dscore#' null="#IIF(Form.Dscore EQ "", true, false)#">
                    where DolphinID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.ID#'>
            </cfquery>
            <cfif get_res.RECORDCOUNT eq 1>
                <div class="alert alert-success">
                    <strong>Success!</strong> Dolphin record Updated 1.
                </div>
            <cfelse>
                <div class="alert alert-danger">
                    <strong>Error!</strong> Updation Failed.
                </div>
            </cfif>
        </cfoutput>
    </cffunction>
    <cffunction name="getdolphin" access="public" returnformat="plain" output="true">
        <cfquery name="getdolphin" datasource="#variables.dsn#">
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
        DOLPHINS.ImageName,
        PROJECTS.Date as DateSeen,
        SIGHTINGS.Begin_LAT_Dec,
        SIGHTINGS.Begin_LON_Dec,
        DOLPHINS.[Date of Death] as DOD,
        DOLPHINS. [DOB EST] as DOB,
        SIGHTINGS.Zone_id,
        SIGHTINGS.ID as SightingNo,
        SIGHTINGS.Begin_LAT_Dec,SIGHTINGS.Begin_LON_Dec,
        DOLPHINS.[First Sighting Date],
        SIGHTINGS.Easting_X, SIGHTINGS.Northing_Y,
        SIGHTINGS.Project_ID,TLU_Zones.ZSegment
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
        <cfquery name="qgetdolphinFriends" datasource="#variables.dsn#">
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
    <cffunction name="getSourceSex" returntype="any" output="false" access="public" >
        <cfquery name="getSourceSex" datasource="#variables.dsn#"  >
            SELECT * from TLU_SourceSex where active = 1
        </cfquery>
        <cfreturn getSourceSex>
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
        <cfquery name="delete" datasource="#variables.dsn#">
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
        <cfquery name="insert_sdo" datasource="#variables.dsn#" result='get_res'>
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
        <cfquery name="update_sdo" datasource="#variables.dsn#" result='get_res'>
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
        <cfquery name="delete" datasource="#variables.dsn#">
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
    <cffunction name="getshotData" access="public" returnformat="plain" output="true">
        <cfargument name="sight_id" type="any" default="">
        <cfquery name="getshotData" datasource="#variables.dsn#">
            select  BIOPSY_SHOTS.* ,DOLPHINS.Name , TLU_ResearchTeamMembers.* , DOLPHINS.Code , DOLPHINS.ID from BIOPSY_SHOTS
            INNER JOIN DOLPHINS ON BIOPSY_SHOTS.Dolphin_ID = DOLPHINS.ID
             FULL OUTER JOIN TLU_ResearchTeamMembers on TLU_ResearchTeamMembers.RT_ID = BIOPSY_SHOTS.Arbalester
            where BIOPSY_SHOTS.Sighting_ID = #sight_id# AND BIOPSY_SHOTS.ShotNumber = 1  order by BIOPSY_SHOTS.Biopsy_ID DESC
       </cfquery>
        <cfreturn getshotData>
    </cffunction>
    <cffunction name="firstShotData" access="remote" returnformat="plain" output="true">
        <cfargument name="sight_id" default="">
        <cfargument name="shotNumber" default="">
        <cfargument name="dolphin_id" default="">
        <cfquery name="firstShotData" datasource="#variables.dsn#">
             SELECT  BIOPSY_SHOTS.*,TLU_ResearchTeamMembers.* ,DOLPHINS.Name , DOLPHINS.Code , DOLPHINS.ID from BIOPSY_SHOTS
             INNER JOIN DOLPHINS ON BIOPSY_SHOTS.Dolphin_ID = DOLPHINS.ID
             FULL OUTER JOIN TLU_ResearchTeamMembers on TLU_ResearchTeamMembers.RT_ID = BIOPSY_SHOTS.Arbalester
             WHERE BIOPSY_SHOTS.Sighting_ID = #sight_id# AND BIOPSY_SHOTS.ShotNumber = #shotNumber# AND BIOPSY_SHOTS.Dolphin_ID = #dolphin_id#  order by BIOPSY_SHOTS.Enter_Date DESC
       </cfquery>
        <cfset Arrayofshot = ArrayNew(1)>
        <cfset structOfshot = StructNew() />
        <cfset StructInsert(structOfshot,"Biopsy_ID",firstShotData.Biopsy_ID)>
        <cfset StructInsert(structOfshot,"probable_dolphin",firstShotData.probable_dolphin)>
        <cfset StructInsert(structOfshot,"DolphinID",firstShotData.Dolphin_ID)>
        <cfset StructInsert(structOfshot,"ShotTime", #TimeFormat(firstShotData.ShotTime, "hh:nn")#)>
        <cfset StructInsert(structOfshot,"DolphinCode",firstShotData.Code)>
        <cfset StructInsert(structOfshot,"DolphinName",firstShotData.Name)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior1",firstShotData.TargetResponseBehavior1)>
        <cfset StructInsert(structOfshot,"TargetLevel",firstShotData.TargetLevel)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior2",firstShotData.TargetResponseBehavior2)>
        <cfset StructInsert(structOfshot,"TargetLevel2",firstShotData.TargetLevel2)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior3",firstShotData.TargetResponseBehavior3)>
        <cfset StructInsert(structOfshot,"TargetLevel3",firstShotData.TargetLevel3)>
        <cfset StructInsert(structOfshot,"Arbalester",firstShotData.Arbalester)>
        <cfset StructInsert(structOfshot,"GroupResponseBehavior",firstShotData.GroupResponseBehavior)>
        <cfset StructInsert(structOfshot,"GroupLevel1",firstShotData.GroupLevel1)>
        <cfset StructInsert(structOfshot,"HitLocation",firstShotData.HitLocation)>
        <cfset StructInsert(structOfshot,"ShotDistance",firstShotData.ShotDistance)>
        <cfset StructInsert(structOfshot,"SampleNumber",firstShotData.SampleNumber)>
        <cfset StructInsert(structOfshot,"Outcome",firstShotData.Outcome)>
        <cfset StructInsert(structOfshot,"Processor",firstShotData.Processor)>
        <cfset StructInsert(structOfshot,"HitDescriptor",firstShotData.HitDescriptor)>
        <cfset StructInsert(structOfshot,"GroupSize",firstShotData.GroupSize)>
        <cfset StructInsert(structOfshot,"SampleLength",firstShotData.SampleLength)>
        <cfset StructInsert(structOfshot,"SampleTaken",firstShotData.SampleTaken)>
        <cfset StructInsert(structOfshot,"Samplehead",firstShotData.Samplehead)>
        <cfset StructInsert(structOfshot,"SampleCollected",firstShotData.SampleCollected)>
        <cfset StructInsert(structOfshot,"BlubberTeflonVial",firstShotData.BlubberTeflonVial)>
        <cfset StructInsert(structOfshot,"BlubberCryovialRed",firstShotData.BlubberCryovialRed)>
        <cfset StructInsert(structOfshot,"BlubberCryovialBlue",firstShotData.BlubberCryovialBlue)>
        <cfset StructInsert(structOfshot,"SkinDCryovial",firstShotData.SkinDCryovial)>
        <cfset StructInsert(structOfshot,"SkinDMSO",firstShotData.SkinDMSO)>
        <cfset StructInsert(structOfshot,"SkinRNAlater",firstShotData.SkinRNAlater)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Mill",firstShotData.TABPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Feed",firstShotData.TABPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_ProbFeed",firstShotData.TABPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Travel",firstShotData.TABPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Play",firstShotData.TABPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_REST",firstShotData.TABPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Leap_tailslap_chuff",firstShotData.TABPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_WITHBOAT",firstShotData.TABPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Avoid_Boat",firstShotData.TABPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPre_Depredation",firstShotData.TABPre_Depredation)>
        <cfset StructInsert(structOfshot,"TABPre_Herding",firstShotData.TABPre_Herding)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Mill",firstShotData.GBPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Feed",firstShotData.GBPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_ProbFeed",firstShotData.GBPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Travel",firstShotData.GBPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Play",firstShotData.GBPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_REST",firstShotData.GBPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Leap_tailslap_chuff",firstShotData.GBPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Social",firstShotData.GBPre_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_WITHBOAT",firstShotData.GBPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Other",firstShotData.GBPre_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Avoid_Boat",firstShotData.GBPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPre_Depredation",firstShotData.GBPre_Depredation)>
        <cfset StructInsert(structOfshot,"GBPre_Herding",firstShotData.GBPre_Herding)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Mill",firstShotData.TABPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Feed",firstShotData.TABPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_ProbFeed",firstShotData.TABPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Travel",firstShotData.TABPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Play",firstShotData.TABPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_REST",firstShotData.TABPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Leap_tailslap_chuff",firstShotData.TABPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Social",firstShotData.TABPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_WITHBOAT",firstShotData.TABPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Other",firstShotData.TABPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Avoid_Boat",firstShotData.TABPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPost_Depredation",firstShotData.TABPost_Depredation)>
        <cfset StructInsert(structOfshot,"TABPost_Herding",firstShotData.TABPost_Herding)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Mill",firstShotData.GBPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Feed",firstShotData.GBPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_ProbFeed",firstShotData.GBPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Travel",firstShotData.GBPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Play",firstShotData.GBPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_REST",firstShotData.GBPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Leap_tailslap_chuff",firstShotData.GBPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Social",firstShotData.GBPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_WITHBOAT",firstShotData.GBPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Other",firstShotData.GBPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Avoid_Boat",firstShotData.GBPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPost_Depredation",firstShotData.GBPost_Depredation)>
        <cfset StructInsert(structOfshot,"GBPost_Herding",firstShotData.GBPost_Herding)>
        <cfset StructInsert(structOfshot,"ShotCount",firstShotData.ShotCount)>
        <cfset ArrayAppend(Arrayofshot,structOfshot)>
        <cfoutput>#SerializeJSON(Arrayofshot)#</cfoutput>
    </cffunction>
    <cffunction name="countdailyshot" access="remote" returnformat="plain" output="true">
        <cfquery name="countdailyshot" datasource="#variables.dsn#" result="r">
            select  count(BIOPSY_SHOTS.ShotNumber) as biopsycount FROM BIOPSY_SHOTS WHERE
            cast(BIOPSY_SHOTS.Enter_Date as Date) = '#DATEFORMAT(now(),"yyyy/mm/dd")#'
        </cfquery>
        <cfoutput>#countdailyshot.biopsycount#</cfoutput>
    </cffunction>
    <cffunction name="secondShotData" access="remote" returnformat="plain" output="true">
        <cfargument name="sight_id" default="">
        <cfargument name="shotNumber" default="">
        <cfargument name="dolphin_id" default="">
        <cfquery name="firstShotData" datasource="#variables.dsn#">
           SELECT  BIOPSY_SHOTS.*  ,TLU_ResearchTeamMembers.* ,DOLPHINS.Name , DOLPHINS.Code , DOLPHINS.ID from BIOPSY_SHOTS
           INNER JOIN DOLPHINS ON BIOPSY_SHOTS.Dolphin_ID = DOLPHINS.ID
           FULL OUTER JOIN TLU_ResearchTeamMembers on TLU_ResearchTeamMembers.RT_ID = BIOPSY_SHOTS.Arbalester
           WHERE BIOPSY_SHOTS.Sighting_ID = #sight_id# AND BIOPSY_SHOTS.ShotNumber = #shotNumber# AND BIOPSY_SHOTS.Dolphin_ID = #dolphin_id#   order by BIOPSY_SHOTS.Enter_Date DESC
        </cfquery>
        <cfset Arrayofshot = ArrayNew(1)>
        <cfset structOfshot = StructNew() />
        <cfset StructInsert(structOfshot,"Biopsy_ID",firstShotData.Biopsy_ID)>
        <cfset StructInsert(structOfshot,"probable_dolphin",firstShotData.probable_dolphin)>
        <cfset StructInsert(structOfshot,"ShotTime", #TimeFormat(firstShotData.ShotTime, "hh:nn")#)>
        <cfset StructInsert(structOfshot,"DolphinID",firstShotData.Dolphin_ID)>
        <cfset StructInsert(structOfshot,"DolphinCode",firstShotData.Code)>
        <cfset StructInsert(structOfshot,"DolphinName",firstShotData.Name)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior1",firstShotData.TargetResponseBehavior1)>
        <cfset StructInsert(structOfshot,"TargetLevel",firstShotData.TargetLevel)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior2",firstShotData.TargetResponseBehavior2)>
        <cfset StructInsert(structOfshot,"TargetLevel2",firstShotData.TargetLevel2)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior3",firstShotData.TargetResponseBehavior3)>
        <cfset StructInsert(structOfshot,"TargetLevel3",firstShotData.TargetLevel3)>
        <cfset StructInsert(structOfshot,"Arbalester",firstShotData.Arbalester)>
        <cfset StructInsert(structOfshot,"GroupResponseBehavior",firstShotData.GroupResponseBehavior)>
        <cfset StructInsert(structOfshot,"GroupLevel1",firstShotData.GroupLevel1)>
        <cfset StructInsert(structOfshot,"HitLocation",firstShotData.HitLocation)>
        <cfset StructInsert(structOfshot,"ShotDistance",firstShotData.ShotDistance)>
        <cfset StructInsert(structOfshot,"SampleNumber",firstShotData.SampleNumber)>
        <cfset StructInsert(structOfshot,"Outcome",firstShotData.Outcome)>
        <cfset StructInsert(structOfshot,"Processor",firstShotData.Processor)>
        <cfset StructInsert(structOfshot,"HitDescriptor",firstShotData.HitDescriptor)>
        <cfset StructInsert(structOfshot,"GroupSize",firstShotData.GroupSize)>
        <cfset StructInsert(structOfshot,"SampleLength",firstShotData.SampleLength)>
        <cfset StructInsert(structOfshot,"SampleTaken",firstShotData.SampleTaken)>
        <cfset StructInsert(structOfshot,"Samplehead",firstShotData.Samplehead)>
        <cfset StructInsert(structOfshot,"SampleCollected",firstShotData.SampleCollected)>
        <cfset StructInsert(structOfshot,"BlubberTeflonVial",firstShotData.BlubberTeflonVial)>
        <cfset StructInsert(structOfshot,"BlubberCryovialBlue",firstShotData.BlubberCryovialBlue)>
        <cfset StructInsert(structOfshot,"SkinDCryovial",firstShotData.SkinDCryovial)>
        <cfset StructInsert(structOfshot,"SkinDMSO",firstShotData.SkinDMSO)>
        <cfset StructInsert(structOfshot,"SkinRNAlater",firstShotData.SkinRNAlater)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Mill",firstShotData.TABPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Feed",firstShotData.TABPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_ProbFeed",firstShotData.TABPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Travel",firstShotData.TABPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Play",firstShotData.TABPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_REST",firstShotData.TABPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Leap_tailslap_chuff",firstShotData.TABPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_WITHBOAT",firstShotData.TABPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Avoid_Boat",firstShotData.TABPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPre_Depredation",firstShotData.TABPre_Depredation)>
        <cfset StructInsert(structOfshot,"TABPre_Herding",firstShotData.TABPre_Herding)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Mill",firstShotData.GBPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Feed",firstShotData.GBPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_ProbFeed",firstShotData.GBPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Travel",firstShotData.GBPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Play",firstShotData.GBPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_REST",firstShotData.GBPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Leap_tailslap_chuff",firstShotData.GBPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Social",firstShotData.GBPre_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_WITHBOAT",firstShotData.GBPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Other",firstShotData.GBPre_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Avoid_Boat",firstShotData.GBPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPre_Depredation",firstShotData.GBPre_Depredation)>
        <cfset StructInsert(structOfshot,"GBPre_Herding",firstShotData.GBPre_Herding)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Mill",firstShotData.TABPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Feed",firstShotData.TABPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_ProbFeed",firstShotData.TABPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Travel",firstShotData.TABPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Play",firstShotData.TABPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_REST",firstShotData.TABPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Leap_tailslap_chuff",firstShotData.TABPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Social",firstShotData.TABPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_WITHBOAT",firstShotData.TABPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Other",firstShotData.TABPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Avoid_Boat",firstShotData.TABPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPost_Depredation",firstShotData.TABPost_Depredation)>
        <cfset StructInsert(structOfshot,"TABPost_Herding",firstShotData.TABPost_Herding)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Mill",firstShotData.GBPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Feed",firstShotData.GBPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_ProbFeed",firstShotData.GBPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Travel",firstShotData.GBPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Play",firstShotData.GBPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_REST",firstShotData.GBPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Leap_tailslap_chuff",firstShotData.GBPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Social",firstShotData.GBPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_WITHBOAT",firstShotData.GBPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Other",firstShotData.GBPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Avoid_Boat",firstShotData.GBPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPost_Depredation",firstShotData.GBPost_Depredation)>
        <cfset StructInsert(structOfshot,"GBPost_Herding",firstShotData.GBPost_Herding)>
        <cfset StructInsert(structOfshot,"ShotCount",firstShotData.ShotCount)>
        <cfset ArrayAppend(Arrayofshot,structOfshot)>
        <cfoutput>#SerializeJSON(Arrayofshot)#</cfoutput>
    </cffunction>
    <cffunction name="thirdShotData" access="remote" returnformat="plain" output="true">
        <cfargument name="sight_id" default="">
        <cfargument name="shotNumber" default="">
        <cfargument name="dolphin_id" default="">
        <cfquery name="thirdShotData" datasource="#variables.dsn#">
        SELECT  BIOPSY_SHOTS.*,TLU_ResearchTeamMembers.* ,DOLPHINS.Name , DOLPHINS.Code , DOLPHINS.ID from BIOPSY_SHOTS
         INNER JOIN DOLPHINS ON BIOPSY_SHOTS.Dolphin_ID = DOLPHINS.ID
         FULL OUTER JOIN TLU_ResearchTeamMembers on TLU_ResearchTeamMembers.RT_ID = BIOPSY_SHOTS.Arbalester
         WHERE BIOPSY_SHOTS.Sighting_ID = #sight_id# AND BIOPSY_SHOTS.ShotNumber = #shotNumber# AND BIOPSY_SHOTS.Dolphin_ID = #dolphin_id#  order by BIOPSY_SHOTS.Enter_Date DESC
        </cfquery>
        <cfset Arrayofshot = ArrayNew(1)>
        <cfset structOfshot = StructNew() />
        <cfset StructInsert(structOfshot,"DolphinID",thirdShotData.Dolphin_ID)>
        <cfset StructInsert(structOfshot,"probable_dolphin",thirdShotData.probable_dolphin)>
        <cfset StructInsert(structOfshot,"ShotTime", #TimeFormat(thirdShotData.ShotTime, "hh:nn")#)>
        <cfset StructInsert(structOfshot,"DolphinCode",thirdShotData.Code)>
        <cfset StructInsert(structOfshot,"DolphinName",thirdShotData.Name)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior1",thirdShotData.TargetResponseBehavior1)>
        <cfset StructInsert(structOfshot,"TargetLevel",thirdShotData.TargetLevel)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior2",thirdShotData.TargetResponseBehavior2)>
        <cfset StructInsert(structOfshot,"TargetLevel2",thirdShotData.TargetLevel2)>
        <cfset StructInsert(structOfshot,"TargetResponseBehavior3",thirdShotData.TargetResponseBehavior3)>
        <cfset StructInsert(structOfshot,"TargetLevel3",thirdShotData.TargetLevel3)>
        <cfset StructInsert(structOfshot,"Arbalester",thirdShotData.Arbalester)>
        <cfset StructInsert(structOfshot,"GroupResponseBehavior",thirdShotData.GroupResponseBehavior)>
        <cfset StructInsert(structOfshot,"GroupLevel1",thirdShotData.GroupLevel1)>
        <cfset StructInsert(structOfshot,"HitLocation",thirdShotData.HitLocation)>
        <cfset StructInsert(structOfshot,"ShotDistance",thirdShotData.ShotDistance)>
        <cfset StructInsert(structOfshot,"SampleNumber",thirdShotData.SampleNumber)>
        <cfset StructInsert(structOfshot,"Outcome",thirdShotData.Outcome)>
        <cfset StructInsert(structOfshot,"Processor",thirdShotData.Processor)>
        <cfset StructInsert(structOfshot,"HitDescriptor",thirdShotData.HitDescriptor)>
        <cfset StructInsert(structOfshot,"GroupSize",thirdShotData.GroupSize)>
        <cfset StructInsert(structOfshot,"SampleLength",thirdShotData.SampleLength)>
        <cfset StructInsert(structOfshot,"SampleTaken",thirdShotData.SampleTaken)>
        <cfset StructInsert(structOfshot,"Samplehead",thirdShotData.Samplehead)>
        <cfset StructInsert(structOfshot,"SampleCollected",thirdShotData.SampleCollected)>
        <cfset StructInsert(structOfshot,"BlubberTeflonVial",thirdShotData.BlubberTeflonVial)>
        <cfset StructInsert(structOfshot,"BlubberCryovialBlue",thirdShotData.BlubberCryovialBlue)>
        <cfset StructInsert(structOfshot,"SkinDCryovial",thirdShotData.SkinDCryovial)>
        <cfset StructInsert(structOfshot,"SkinDMSO",thirdShotData.SkinDMSO)>
        <cfset StructInsert(structOfshot,"SkinRNAlater",thirdShotData.SkinRNAlater)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Mill",thirdShotData.TABPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Feed",thirdShotData.TABPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_ProbFeed",thirdShotData.TABPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Travel",thirdShotData.TABPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Play",thirdShotData.TABPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_REST",thirdShotData.TABPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Leap_tailslap_chuff",thirdShotData.TABPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPre_ACTIVITY_WITHBOAT",thirdShotData.TABPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPre_Activity_Avoid_Boat",thirdShotData.TABPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPre_Depredation",thirdShotData.TABPre_Depredation)>
        <cfset StructInsert(structOfshot,"TABPre_Herding",thirdShotData.TABPre_Herding)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Mill",thirdShotData.GBPre_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Feed",thirdShotData.GBPre_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_ProbFeed",thirdShotData.GBPre_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Travel",thirdShotData.GBPre_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Play",thirdShotData.GBPre_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_REST",thirdShotData.GBPre_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Leap_tailslap_chuff",thirdShotData.GBPre_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Social",thirdShotData.GBPre_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPre_ACTIVITY_WITHBOAT",thirdShotData.GBPre_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Other",thirdShotData.GBPre_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPre_Activity_Avoid_Boat",thirdShotData.GBPre_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPre_Depredation",thirdShotData.GBPre_Depredation)>
        <cfset StructInsert(structOfshot,"GBPre_Herding",thirdShotData.GBPre_Herding)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Mill",thirdShotData.TABPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Feed",thirdShotData.TABPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_ProbFeed",thirdShotData.TABPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Travel",thirdShotData.TABPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Play",thirdShotData.TABPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_REST",thirdShotData.TABPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Leap_tailslap_chuff",thirdShotData.TABPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Social",thirdShotData.TABPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"TABPost_ACTIVITY_WITHBOAT",thirdShotData.TABPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Other",thirdShotData.TABPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"TABPost_Activity_Avoid_Boat",thirdShotData.TABPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"TABPost_Depredation",thirdShotData.TABPost_Depredation)>
        <cfset StructInsert(structOfshot,"TABPost_Herding",thirdShotData.TABPost_Herding)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Mill",thirdShotData.GBPost_Activity_Mill)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Feed",thirdShotData.GBPost_Activity_Feed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_ProbFeed",thirdShotData.GBPost_Activity_ProbFeed)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Travel",thirdShotData.GBPost_Activity_Travel)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Play",thirdShotData.GBPost_Activity_Play)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_REST",thirdShotData.GBPost_ACTIVITY_REST)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Leap_tailslap_chuff",thirdShotData.GBPost_Activity_Leap_tailslap_chuff)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Social",thirdShotData.GBPost_Activity_Social)>
        <cfset StructInsert(structOfshot,"GBPost_ACTIVITY_WITHBOAT",thirdShotData.GBPost_ACTIVITY_WITHBOAT)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Other",thirdShotData.GBPost_Activity_Other)>
        <cfset StructInsert(structOfshot,"GBPost_Activity_Avoid_Boat",thirdShotData.GBPost_Activity_Avoid_Boat)>
        <cfset StructInsert(structOfshot,"GBPost_Depredation",thirdShotData.GBPost_Depredation)>
        <cfset StructInsert(structOfshot,"ShotCount",thirdShotData.ShotCount)>
        <cfset StructInsert(structOfshot,"GBPost_Herding",thirdShotData.GBPost_Herding)>
        <cfset ArrayAppend(Arrayofshot,structOfshot)>
        <cfoutput>#SerializeJSON(Arrayofshot)#</cfoutput>
    </cffunction>
    <cffunction name="Add_Biopsy" access="remote" returnformat="plain" output="true">
        <cfargument name="BiopsyTeam" default=" ">
        <cfparam name="form.TargetLevel1" default="">
        <cfparam name="form.TargetLevel2" default="">
        <cfparam name="form.TargetLevel3" default="">
        <cfparam name="form.Outcome" default="">
        <cfparam name="form.SkinDMSO" default="">
        <cfparam name="form.probable_dolphin " default="">
        <cfparam name="form.SkinRNAlater" default="">
        <cfparam name="form.SkinDCryovial" default="">
        <cfparam name="form.SampleTaken" default="">
        <cfparam name="form.Samplehead" default="">
        <cfparam name="form.SampleCollected" default="">
        <cfparam name="form.BlubberTeflonVial" default="">
        <cfparam name="form.BlubberCryovialRed" default="">
        <cfparam name="form.BlubberCryovialBlue" default="">
        <cfparam name="form.GroupLevel1" default="">
        <cfset TargetPre_Behavior1 = "">
        <cfset TargetPre_Behavior2 = "">
        <cfset TargetPre_Behavior3 = "">
<!--- TargetPre_Behavior1  --->
        <cfif form.TABPre_Activity_Mill neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Mill",",")></cfif>
        <cfif form.TABPre_Activity_Feed neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Feed",",")></cfif>
        <cfif form.TABPre_Activity_ProbFeed neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"ProbFeed",",")></cfif>
        <cfif form.TABPre_Activity_Travel neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Travel",",")></cfif>
        <cfif form.TABPre_Activity_Play neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Play",",")></cfif>
        <cfif form.TABPre_ACTIVITY_REST neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"REST",",")></cfif>
        <cfif form.TABPre_Activity_Leap_tailslap_chuff neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Leap_tailslap_chuff",",")></cfif>
        <cfif form.TABPre_Activity_Social neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Social",",")></cfif>
        <cfif form.TABPre_ACTIVITY_WITHBOAT neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"WITHBOAT",",")></cfif>
        <cfif form.TABPre_Activity_Avoid_Boat neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Avoid_Boat",",")></cfif>
        <cfif form.TABPre_Depredation neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Depredation",",")></cfif>
        <cfif form.TABPre_Herding neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Herding",",")></cfif>
        <cfif form.TABPre_Activity_Other neq 0><cfset TargetPre_Behavior1 = listAppend(TargetPre_Behavior1,"Other",",")></cfif>
        <cfset TargetPost_Behavior1 = "">
        <cfset TargetPost_Behavior2 = "">
        <cfset TargetPost_Behavior3 = "">
        <!--- TargetPre_Behavior3  --->
        <cfif form.TABpost_Activity_Mill neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Mill",",")></cfif>
        <cfif form.TABPost_Activity_Feed neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Feed",",")></cfif>
        <cfif form.TABPost_Activity_ProbFeed neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"ProbFeed",",")></cfif>
        <cfif form.TABPost_Activity_Travel neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Travel",",")></cfif>
        <cfif form.TABPost_Activity_Play neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Play",",")></cfif>
        <cfif form.TABPost_ACTIVITY_REST neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"REST",",")></cfif>
        <cfif form.TABPost_Activity_Leap_tailslap_chuff neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Leap_tailslap_chuff",",")></cfif>
        <cfif form.TABPost_Activity_Social neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Social",",")></cfif>
        <cfif form.TABPost_ACTIVITY_WITHBOAT neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"WITHBOAT",",")></cfif>
        <cfif form.TABPost_Activity_Avoid_Boat neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Avoid_Boat",",")></cfif>
        <cfif form.TABPost_Depredation neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Depredation",",")></cfif>
        <cfif form.TABPost_Herding neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Herding",",")></cfif>
        <cfif form.TABPost_Activity_Other neq 0><cfset TargetPost_Behavior1 = listAppend(TargetPost_Behavior1,"Other",",")></cfif>
        <cfset GroupPre_Behavior1 = "">
        <cfset GroupPre_Behavior2 = "">
        <cfset GroupPre_Behavior3 = "">
        <cfset GroupPost_Behavior1 = "">
        <cfset GroupPost_Behavior2 = "">
        <cfset GroupPost_Behavior3 = "">
        <cfif form.GBPre_Activity_Mill neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Mill",",")></cfif>
        <cfif form.GBPre_Activity_Feed neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Feed",",")></cfif>
        <cfif form.GBPre_Activity_ProbFeed neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"ProbFeed",",")></cfif>
        <cfif form.GBPre_Activity_Travel neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Travel",",")></cfif>
        <cfif form.GBPre_Activity_Play neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Play",",")></cfif>
        <cfif form.GBPre_ACTIVITY_REST neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"REST",",")></cfif>
        <cfif form.GBPre_Activity_Leap_tailslap_chuff neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Leap_tailslap_chuff",",")></cfif>
        <cfif form.GBPre_Activity_Social neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Social",",")></cfif>
        <cfif form.GBPre_ACTIVITY_WITHBOAT neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"WITHBOAT",",")></cfif>
        <cfif form.GBPre_Activity_Other neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Other",",")></cfif>
        <cfif form.GBPre_Activity_Avoid_Boat neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"AvoidBoat",",")></cfif>
        <cfif form.GBPre_Depredation neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Depredation",",")></cfif>
        <cfif form.GBPre_Herding neq 0><cfset GroupPre_Behavior1 = listAppend(GroupPre_Behavior1,"Herding",",")></cfif>
<!--- GroupPost_Behavior1 --->
        <cfif form.GBPost_Activity_Mill neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Mill",",")></cfif>
        <cfif form.GBPost_Activity_Feed neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Feed",",")></cfif>
        <cfif form.GBPost_Activity_ProbFeed neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"ProbFeed",",")></cfif>
        <cfif form.GBPost_Activity_Travel neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Travel",",")></cfif>
        <cfif form.GBPost_Activity_Play neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Play",",")></cfif>
        <cfif form.GBPost_ACTIVITY_REST neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"REST",",")></cfif>
        <cfif form.GBPost_Activity_Leap_tailslap_chuff neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Leap_tailslap_chuff",",")></cfif>
        <cfif form.GBPost_Activity_Social neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Social",",")></cfif>
        <cfif form.GBPost_ACTIVITY_WITHBOAT neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"WITHBOAT",",")></cfif>
        <cfif form.GBPost_Activity_Other neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Other",",")></cfif>
        <cfif form.GBPost_Activity_Avoid_Boat neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"AvoidBoat",",")></cfif>
        <cfif form.GBPost_Depredation neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Depredation",",")></cfif>
        <cfif form.GBPost_Herding neq 0><cfset GroupPost_Behavior1 = listAppend(GroupPost_Behavior1,"Herding",",")></cfif>
<!--- GroupPost_Behavior2 --->
        <cfif #form.ShotNumber# gt 0  and #form.ShotNumber# lt 4>
            <cfquery name="insertdata" datasource="#variables.dsn#" result="result">
            INSERT INTO BIOPSY_SHOTS
    		(Enter_Date,
             Dolphin_ID,
             Sighting_ID,
             ShotTime,
             Arbalester,
             ShotNumber,
             ShotDistance,
             Outcome,
             ShotCount,
       		 TargetLevel,
       		 TargetLevel2,
       		 TargetLevel3,
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
             BlubberCryovialBlue,
             TargetResponseBehavior1,
             TargetResponseBehavior2,
             TargetResponseBehavior3,
             GroupResponseBehavior,
             GroupSize,
             HitDescriptor,
             MissDescriptor,
             TargetPre_Behavior1,
             TargetPre_Behavior2,
             TargetPre_Behavior3,
             TargetPost_Behavior1,
             TargetPost_Behavior2,
             TargetPost_Behavior3,
             GroupPre_Behavior1,
             GroupPre_Behavior2,
             GroupPre_Behavior3,
             GroupPost_Behavior1,
             GroupPost_Behavior2,
             GroupPost_Behavior3,
             GroupLevel1,
             probable_dolphin
            )Values(
             	<cfqueryparam cfsqltype="cf_sql_timestamp" value='#NOW()#'>,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Dolphin_ID#' null="#IIF(form.Dolphin_ID EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Sighting_ID#'>,
                <cfqueryparam cfsqltype="cf_sql_time" value='#form.ShotTime#' null="#IIF(form.ShotTime EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Arbalester#' null="#IIF(form.Arbalester EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ShotNumber#' null="#IIF(form.ShotNumber EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ShotDistance#' null="#IIF(form.ShotDistance EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Outcome#' null="#IIF(form.Outcome EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.ShotCount#' null="#IIF(form.ShotCount EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetLevel1#' null="#IIF(form.TargetLevel1 EQ "", true, false)#">,
             	<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetLevel2#' null="#IIF(form.TargetLevel2 EQ "", true, false)#">,
             	<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetLevel3#' null="#IIF(form.TargetLevel3 EQ "", true, false)#">,
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
                <!---<cfqueryparam cfsqltype="cf_sql_integer" value='#form.SubSample#' null="#IIF(form.SubSample EQ "", true, false)#">,--->
                <!------>
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Processor#' null="#IIF(form.Processor EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.SampleLength#' null="#IIF(form.SampleLength EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinDMSO#' null="#IIF(form.SkinDMSO EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinRNAlater#' null="#IIF(form.SkinRNAlater EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SkinDCryovial#' null="#IIF(form.SkinDCryovial EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.SampleNumber#' null="#IIF(form.SampleNumber EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SampleTaken#' null="#IIF(form.SampleTaken EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.Samplehead#' null="#IIF(form.Samplehead EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.SampleCollected#' null="#IIF(form.SampleCollected EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberTeflonVial#' null="#IIF(form.BlubberTeflonVial EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberCryovialRed#' null="#IIF(form.BlubberCryovialRed EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value='#form.BlubberCryovialBlue#' null="#IIF(form.BlubberCryovialBlue EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior1#' null="#IIF(form.TargetResponseBehavior1 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior2#' null="#IIF(form.TargetResponseBehavior2 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.TargetResponseBehavior3#' null="#IIF(form.TargetResponseBehavior3 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.GroupResponseBehavior1#' null="#IIF(form.GroupResponseBehavior1 EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.groupSize#' null="#IIF(form.groupSize EQ "", true, false)#">,
                <!---<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missDistance#' null="#IIF(form.missDistance EQ "", true, false)#">,--->
                <!---<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missHeight#' null="#IIF(form.missHeight EQ "", true, false)#">,--->
                <!---<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missWidth#' null="#IIF(form.missWidth EQ "", true, false)#">,--->
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.hitDescriptor#' null="#IIF(form.hitDescriptor EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.missDescriptor#' null="#IIF(form.missDescriptor EQ "", true, false)#">,
             	<cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior1#' null="#IIF(TargetPre_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior2#' null="#IIF(TargetPre_Behavior2 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPre_Behavior3#' null="#IIF(TargetPre_Behavior3 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior1#' null="#IIF(TargetPost_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior2#' null="#IIF(TargetPost_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#TargetPost_Behavior3#' null="#IIF(TargetPost_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior1#' null="#IIF(GroupPre_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior2#' null="#IIF(GroupPre_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPre_Behavior3#' null="#IIF(GroupPre_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior1#' null="#IIF(GroupPost_Behavior1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior2#' null="#IIF(GroupPost_Behavior2 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_varchar" value='#GroupPost_Behavior3#' null="#IIF(GroupPost_Behavior3 EQ "", true, false)#">,
           	   <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.GroupLevel1#' null="#IIF(form.GroupLevel1 EQ "", true, false)#">,
               <cfqueryparam cfsqltype="cf_sql_integer" value='#form.probable_dolphin#' null="#IIF(form.probable_dolphin  EQ "", true, false)#">
           	 )
	        </cfquery>
            <cfif BiopsyTeam NEQ '' >
                <cfloop index = "ListElement" list ="#BiopsyTeam#">
                    <cfquery name="update" datasource="#variables.dsn#" result="updating" >
                    insert into TEAMMEMBER_Biopsy (Biopsy_ID,TeamMemberID) values
                    (<cfqueryparam cfsqltype="cf_sql_integer" value='#result.identitycol#'>,
                    <cfqueryparam cfsqltype="cf_sql_integer" value='#VAL(ListElement)#'>
                    )
                    </cfquery>
                </cfloop>
            </cfif>
            <cfreturn result>
        <cfelse>
        <cfreturn "error">
        </cfif>
    </cffunction>
    <cffunction name="getBiopsy" access="remote" returntype="any" output="true">
        <cfquery name="query" datasource="#variables.dsn#">
            SELECT Biopsy_ID,Sighting_ID,SampleNumber,ShotNumber,Outcome FROM
            BIOPSY_SHOTS
            WHERE  Dolphin_ID=<cfqueryparam value='#url.id#' cfsqltype="cf_sql_integer"> order by  Biopsy_ID desc
        </cfquery>
    <cfoutput>#SerializeJSON(query)#</cfoutput>
    </cffunction>
    <cffunction name="DeleteBiopsy" access="remote" returntype="any" output="true">
            <cfquery name="query" datasource="#variables.dsn#">
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
    <cffunction name="getHitDescriptors" returntype="any" output="false" access="public" >
        <cfquery name="qgetHitDescriptors" datasource="#variables.dsn#"  >
            SELECT * from TLU_HitDescriptors where active=1
        </cfquery>
        <cfreturn qgetHitDescriptors>
    </cffunction>
    <cffunction name="getMissDescriptors" returntype="any" output="false" access="public" >
        <cfquery name="qgetMissDescriptors" datasource="#variables.dsn#"  >
        SELECT * from TLU_MissDescriptors where active=1
        </cfquery>
	    <cfreturn qgetMissDescriptors>
    </cffunction>
    <cffunction name="getSubSampleType" returntype="any" output="false" access="public" >
        <cfquery name="qgetSubSampleType" datasource="#variables.dsn#"  >
        SELECT * from TLU_SubSampleType where active=1
        </cfquery>
	    <cfreturn qgetSubSampleType>
    </cffunction>
<!--- function to add dead dolphins-------->
    <cffunction name="updateDeadDolphin" returntype="any" output="false" access="public" >
        <cfquery name="updateDeadDolphin" datasource="#variables.dsn#" result="result">
                UPDATE DOLPHINS SET
                waterBody =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.waterBody#'>,
                <cfif isdefined('form.dead')>
                <cfif form.dead EQ "on">
                <cfset dead = 1>
                     [Dead?] = '#dead#',
                </cfif>
                </cfif>
                 [Field ID] =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Field_ID#'>,
                 [Date of Death] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Year#'>,
                 [Source Sexed]=<cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.sourcesex#'  null="#IIF(Form.sourcesex EQ "", true, false)#">,
                 bodyConditionCode =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bodyConditionCode#'>,
                 Code =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Code#'>,
                 FB_No =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.FB_No#' null="#IIF(form.FB_No EQ "", true, false)#">,
                 Dscore =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Dscore#'>,
                 YearOfBirth = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.YearOfBirth#'>,
                 [Source YOB] = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Source_YOB_ID#'>,
                 ageAtDeath = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ageAtDeath#'>,
                 dorsalDecomposed = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.dorsalDecomposed#'>,
                 poorQualityPhoto =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.poorQualityPhoto#'>,
                 Unrecoveredo = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Unrecoveredo#'>,
                 momPushingDeadCalf = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.deadDorsalPhoto#'>,
                 deadDorsalPhoto = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.deadDorsalPhoto#'>,
                 sex = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.sex#'>,
                 bodyLenght = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.bodyLenght#'>,
                 ageCohort = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.ageCohort#'>,
                 Details = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.Details#'>,
                 otherAccessionNumbers =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.otherAccessionNumbers#'>,
                 photoType = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.photoType#'>,
                 irlSegment =<cfqueryparam cfsqltype="cf_sql_varchar" value='#form.irlSegment#'>,
                 utmEsting = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.utmEsting#'>,
                 utmNorting = <cfqueryparam cfsqltype="cf_sql_varchar" value='#form.utmNorting#'>
                 WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#form.ID#'>
                 </cfquery>
        <cfreturn result>
    </cffunction>
<!---End function to update dead dolphins-------->
<!---Function for List dead dolphins-------->
    <cffunction name="getDeadDolphinList" returntype="any" output="false" access="public" >
            <cfquery name="getDeadDolphins" datasource="#variables.dsn#"  >
                  SELECT Code,name,ID from DOLPHINS where [Dead?] = 1
                  UNION All
                  SELECT Code,name,ID from DOLPHINS WHERE Code LIKE 'UNK%'
            </cfquery>
            <cfreturn getDeadDolphins>
    </cffunction>
<!---End Function for List dead dolphins-------->
<!---Function for get dead dolphins-------->
    <cffunction name="getDeadDolphinDetail" returntype="any" output="false" access="public" >
            <cfquery name="getDeadDolphinDetail" datasource="#variables.dsn#"  result="r">
                SELECT top 1 DOLPHINS.*,Dolphins.[Source Sexed] as ssexed, SIGHTINGS.* , DOLPHIN_SIGHTINGS.* ,PROJECTS.*, Dolphin_DScore.DScore as score , DOLPHINS.[Field ID] as FiledID, DOLPHINS.[Source YOB] as SourceYOB,
                DOLPHINS.[Date of Death] as deathDeate, DOLPHINS.[Dead?] as dead, <!----04-august-2017---->SIGHTINGS.[Date_Entered] as Last_Sighting_date FROM DOLPHINS
                INNER JOIN DOLPHIN_SIGHTINGS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
                INNER JOIN Dolphin_DScore on Dolphin_DScore.DolphinID = DOLPHINS.ID
                INNER JOIN SIGHTINGS ON DOLPHIN_SIGHTINGS.Sighting_ID = SIGHTINGS.ID
                INNER JOIN PROJECTS ON PROJECTS.ID = SIGHTINGS.Project_ID
                WHERE DOLPHINS.ID = #form.ID#
                ORDER BY DOLPHIN_SIGHTINGS.Sighting_ID DESC
        </cfquery>
    <cfreturn getDeadDolphinDetail>
    </cffunction>
    <cffunction name="geteditedDeadDolphinDetail" returntype="any" output="false" access="public" >
            <cfquery name="getDeadDolphinDetail" datasource="#variables.dsn#"  result="deadlist">
                SELECT top 1 DOLPHINS.*,Dolphins.[Source Sexed] as ssexed, SIGHTINGS.* , DOLPHIN_SIGHTINGS.* ,PROJECTS.*, Dolphin_DScore.DScore as score , DOLPHINS.[Field ID] as FiledID, DOLPHINS.[Source YOB] as SourceYOB,
                DOLPHINS.[Date of Death] as deathDeate, DOLPHINS.[Dead?] as dead, <!----04-august-2017---->SIGHTINGS.[Date_Entered] as Last_Sighting_date FROM DOLPHINS
                INNER JOIN DOLPHIN_SIGHTINGS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
                INNER JOIN Dolphin_DScore on Dolphin_DScore.DolphinID = DOLPHINS.ID
                INNER JOIN SIGHTINGS ON DOLPHIN_SIGHTINGS.Sighting_ID = SIGHTINGS.ID
                INNER JOIN PROJECTS ON PROJECTS.ID = SIGHTINGS.Project_ID
                WHERE DOLPHINS.ID = #form.dead_id#
                ORDER BY DOLPHIN_SIGHTINGS.Sighting_ID DESC
            </cfquery>
            <cfreturn getDeadDolphinDetail>
    </cffunction>
    <cffunction name="change_dolphindeath" returntype="any" output="false"  access="remote">
            <cfquery name="changedeath" datasource="#variables.dsn#"  result="death">
                update DOLPHINS set [Dead?] = 0 WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#'>
            </cfquery>
    </cffunction>
    <cffunction name="getDeadDolphins" returntype="any" output="false" access="public">
            <cfquery name="getDeadDolphins" datasource="#variables.dsn#"  result="dead">
                select * from Dolphins WHERE [Dead?] = 1
            </cfquery>
            <cfreturn getDeadDolphins>
    </cffunction>
<!---End Function for get dead dolphins-------->

	<cffunction name="getDolphinCatalog" returntype="any" output="false" access="public" >
        <cfparam name="Form.catalog"     default="">
        <cfparam name="Form.dscore"      default="">
        <cfparam name="Form.bodyOfWater" default="">
        <cfquery name="getdolphinDetails" datasource="#variables.dsn#"  >
            SELECT  Distinct DOLPHINS.ID,
                    DOLPHINS.Code,
                    DOLPHINS.Name,
                    DOLPHINS.Catalog,
                    DOLPHINS.Sex,
                    DOLPHINS.ImageName
                    FROM DOLPHINS 
            <cfif form.dscore NEQ "">                   
            inner join Dolphin_DScore ON Dolphin_DScore.DolphinID = DOLPHINS.ID
            </cfif>
            <cfif form.bodyofwater NEQ "">
            inner join DOLPHIN_SIGHTINGS on DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
            inner join SIGHTINGS on SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
            inner join PROJECTS on PROJECTS.ID = SIGHTINGS.Project_ID
            </cfif>
            <cfif form.catalog NEQ "">
                where Catalog = '#form.catalog#'
            </cfif>
            <cfif form.dscore NEQ "">                   
            	<cfif form.catalog NEQ ""> and<cfelse> where</cfif> Dolphin_DScore.DScore = '#form.dscore#'
            </cfif>
            <cfif form.bodyOfWater NEQ "">
                <cfif form.catalog EQ "" and form.dscore EQ "" and form.bodyOfWater EQ ""> where<cfelse> and</cfif> PROJECTS.surveyarea like '%#trim(form.bodyOfWater)#%'
            </cfif>
        </cfquery>
        <cfreturn getdolphinDetails>
    </cffunction>
    <cffunction name="getDolphinSightings" access="public" returnformat="plain" output="true">
        <cfargument name="dolphin_id" default="">
        <cfquery name="getDolphinSighting" datasource="#variables.dsn#">
            SELECT
            PROJECTS.Date as DateSeen,
            SIGHTINGS.ID as SightingNo,
            SIGHTINGS.Project_ID
            
            FROM PROJECTS LEFT JOIN
            ((SIGHTINGS LEFT JOIN
            (DOLPHINS RIGHT JOIN
            DOLPHIN_SIGHTINGS ON DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
            ON
              SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
             LEFT JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID)
             ON
             PROJECTS.ID = SIGHTINGS.Project_ID
            where DOLPHINS.ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#dolphin_id#'>
            order by dateseen desc
        </cfquery>
        <cfreturn getDolphinSighting>
    </cffunction>
    
    <cffunction name="getSightingHistory" access="public" returnformat="plain" output="true">
        <cfquery name="getSightingHistory" datasource="#variables.dsn#">
        SELECT DS.Sighting_ID,DS.Dolphin_Sighting_Date,DS.BodyCondition,DS.Region,DS.Area
        FROM PROJECTS LEFT JOIN
        ((SIGHTINGS LEFT JOIN
        (DOLPHINS RIGHT JOIN
        DOLPHIN_SIGHTINGS DS ON DOLPHINS.ID = DS.Dolphin_ID)
        ON
          SIGHTINGS.ID = DS.Sighting_ID)
         LEFT JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID)
         ON
         PROJECTS.ID = SIGHTINGS.Project_ID
        where DOLPHINS.ID = <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.DOLPHINID#'> AND DS.Dolphin_Sighting_Date != ''
        GROUP BY DS.Sighting_ID,DS.Dolphin_Sighting_Date,DS.BodyCondition,DS.Region,DS.Area
        order by Sighting_ID desc
        </cfquery>
        <cfreturn getSightingHistory>
    </cffunction>
</cfcomponent>