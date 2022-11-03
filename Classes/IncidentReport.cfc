<cfcomponent>
	<cfheader name="Access-Control-Allow-Origin" value="*" />
    <cfset variables.dsn = "wildfins_new">
	<cffunction name="init" access="public" returnType="any" output="false" hint="Returns an instance of the CFC initialized with the correct DSN.">
		<cfargument name="dsn" type="string" required="true" hint="datasource">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
   
    <cffunction name="getIR_IR_TypeName" returntype="any" output="false" access="public" >
        <cfargument name="IR_Type" default="0" required="yes">
        <cfquery name="qgetIR_IR_TypeName" datasource="#variables.dsn#">
            SELECT IR_Type from TLU_IncidentReportType where ID = #IR_Type#
        </cfquery>
        <cfreturn qgetIR_IR_TypeName.IR_Type>
    </cffunction>

     <cffunction name="getIR_CountyLocationName" returntype="any" output="false" access="public" >
        <cfargument name="IR_CountyLocation" default="0" required="yes">
        <cfquery name="qgetIR_CountyLocationName" datasource="#variables.dsn#">
            SELECT IR_CountyLocation from TLU_IR_CountyLocation where ID = #IR_CountyLocation#
        </cfquery>
        <cfreturn qgetIR_CountyLocationName.IR_CountyLocation>
    </cffunction>

    <cffunction name="getIncidentReports" returntype="any" output="true" access="public">
        <cfquery name="qgetIncidentReport" datasource="#variables.dsn#">
            SELECT * FROM TLU_IncidentReport ORDER BY IR_Date DESC
        </cfquery>
        <cfreturn qgetIncidentReport>
    </cffunction>

    <cffunction name="getIncidentReportsWithFilters" returntype="any" output="true" access="public">
         <cfif isdefined("form.date") and form.date NEQ "">
            <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
            <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
        </cfif>
        <cfquery name="qgetIncidentReportsWithFilters" datasource="#variables.dsn#">
            SELECT * FROM TLU_IncidentReport 
            Where 1=1
            <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">
                and CONVERT(char(10), IR_Date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'
            </cfif>
            <cfif isdefined("form.IR_Type") and form.IR_Type neq "">
                and IR_Type = '#form.IR_Type#'
            </cfif>
            <cfif isdefined("form.IR_CountyLocation") and form.IR_CountyLocation neq "">
                and IR_CountyLocation = '#form.IR_CountyLocation#'
            </cfif>
            ORDER BY IR_Date DESC
        </cfquery>
        <cfreturn qgetIncidentReportsWithFilters>
    </cffunction>
    <cffunction name="getSampleArchive_ten" returntype="any" output="false" access="public" >
        <cfquery name="qgetSampleType_ten" datasource="#Application.dsn#">
            SELECT *  FROM ST_SampleArchive where ID = 0
        </cfquery>
        <cfreturn qgetSampleType_ten>
    </cffunction>


    <cffunction name="getSampleReportsWithFilters" returntype="any" output="true" access="public">
         <cfif isdefined("form.date") and form.date NEQ "">
            <cfset form.startDate = dateformat(form.date.split('-')[1],'YYYY-mm-dd')>
            <cfset form.endDate   = dateformat(form.date.split('-')[2],'YYYY-mm-dd')>
        </cfif>
        <!--- query1 --->
         <cfquery name="qgetSampleReportsWithFilters" datasource="#variables.dsn#">
            SELECT Fnumber,species,ID,StTpye,date FROM ST_SampleArchive 
            Where 1=1
            <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">
                and CONVERT(char(10), date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'
            </cfif>
            <cfif isdefined("form.sampleFN") and form.sampleFN neq "">
                and Fnumber = '#form.sampleFN#'
            </cfif>
            <cfif isdefined("form.Species") and form.Species neq "">
                and Species = '#form.Species#'
            </cfif>
            ORDER BY ID DESC
        </cfquery>
        <!--- query2 --->
        <cfquery name="qgetSampleTypeReportsWithFilters" datasource="#variables.dsn#">
            SELECT SampleType,StorageType,ID,PreservationMethod,SA_ID,date FROM ST_SampleType 
            Where 1=1
            <cfif isdefined("qgetSampleReportsWithFilters.ID") and qgetSampleReportsWithFilters.ID neq "">
                and SA_ID = '#qgetSampleReportsWithFilters.ID#'
            </cfif>
            <cfif isdefined("form.SampleType") and form.SampleType neq "">
                and SampleType = '#form.SampleType#'
            </cfif>
            <cfif isdefined("form.StorageType") and form.StorageType neq "">
                and StorageType = '#form.StorageType#'
            </cfif>
            <cfif isdefined("form.PreservationMethod") and form.PreservationMethod neq "">
                and PreservationMethod = '#form.PreservationMethod#'
            </cfif>
            ORDER BY ID DESC
        </cfquery> 
        <!--- <cfloop query="qgetSampleTypeReportsWithFilters">
        <cfdump var="#qgetSampleTypeReportsWithFilters.SampleType#">
        </cfloop>
        <cfdump var="n" abort="true"> --->
        <!--- <cfset SampleType =  "SampleType">
        <cfset SampleTypeVal =  '#qgetSampleTypeReportsWithFilters.SampleType#'> --->
        

        <cfset QueryAddColumn(qgetSampleReportsWithFilters, "SampleType","varchar",[""])>
        <cfset QueryAddColumn(qgetSampleReportsWithFilters, "StorageType","varchar",[""])>
        <cfset QueryAddColumn(qgetSampleReportsWithFilters, "PreservationMethod","varchar",[""])>
        <!--- <cfset row = 0> --->
        <cfloop query="qgetSampleTypeReportsWithFilters">        
            <cfset QuerySetCell(qgetSampleReportsWithFilters, "SampleType", "#qgetSampleTypeReportsWithFilters.SampleType#", qgetSampleReportsWithFilters.currentRow)>
            <cfset QuerySetCell(qgetSampleReportsWithFilters, "StorageType", "#qgetSampleTypeReportsWithFilters.StorageType#", qgetSampleReportsWithFilters.currentRow)>
            <cfset QuerySetCell(qgetSampleReportsWithFilters, "PreservationMethod", "#qgetSampleTypeReportsWithFilters.PreservationMethod#", qgetSampleReportsWithFilters.currentRow)>
            <!--- <cfdump var="#qgetSampleReportsWithFilters.currentRow#"> --->
        </cfloop>


        <cfif (isdefined("form.startDate") and form.startDate neq "" OR isdefined("form.sampleFN")  and form.sampleFN neq "" OR isdefined("form.Species")and form.Species neq "") AND  (isdefined("form.SampleType") and form.SampleType neq "" OR isdefined("form.StorageType") and form.StorageType neq "" OR isdefined("form.PreservationMethod") and form.PreservationMethod neq "")>
            <cfif qgetSampleTypeReportsWithFilters.RecordCount eq '0'>
                <cfset qgetSampleReportsWithFilters =  getSampleArchive_ten()>
            </cfif>

        </cfif>

        <cfreturn qgetSampleReportsWithFilters>
  
              <!---  SELECT Customers.CustomerName, Orders.OrderID
        FROM Customers
        FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
        ORDER BY Customers.CustomerName; --->

<!--- <cfloop index="index" from="1" to="#qgetSampleTypeReportsWithFilters.ID#">
    <!--- <cfset oo = incrementValue(#oo#)>  --->
    <cfset SampleType =  "SampleType">
    <cfset StorageType =  "StorageType">
    <cfset PreservationMethod =  "PreservationMethod">
    <cfset QueryAddColumn(qgetSampleReportsWithFilters, "#SampleType#","varchar",[""])>
    <cfset QueryAddColumn(qgetSampleReportsWithFilters, "#StorageType#","varchar",[""])>
    <cfset QueryAddColumn(qgetSampleReportsWithFilters, "#PreservationMethod#","varchar",[""])>   
</cfloop> --->
<!--- <cfloop query="qgetSampleReportsWithFilters"> --->
    <!--- <cfif #sightingID# neq "" and #Cetaceans_I# neq ""> 
        <!--- Query get lesion data against a cetacean and sighting ID --->
        <cfquery datasource="#variables.dsn#" name="cldd">
            SELECT cl.*
            FROM Condition_Lesions cl
            where cl.Sighting_ID = #sightingID# and cl.Cetaceans_ID='#cscode#'
        </cfquery> --->
        <!--- <cfif cldd.RECORDCOUNT gte 1 > --->
            <!--- <cfset cc = 0> --->
            <!--- loop for seting columns data  --->
            <!--- <cfloop query="cldd" > 
                <cfset cc = incrementValue(#cc#)> 
                <cfset lp =  "LesionPresent" & #cc#>
                <cfset lete =  "LesionType" & #cc#>              
                <cfset QuerySetCell(allCount, "#lp#", #LesionPresent#, allCount.currentRow)>
                <cfset QuerySetCell(allCount, "#lete#", #LesionType#, allCount.currentRow)>
                <cfset QuerySetCell(allCount, "#slr#", #Side_L_R#, allCount.currentRow)>
                
            </cfloop> --->
        <!--- </cfif> --->
    <!--- </cfif> --->
<!--- </cfloop> --->


        <!--- <CFQUERY NAME="getDetails" DBTYPE="query">
            SELECT * FROM qgetSampleReportsWithFilters
            UNION
            SELECT * FROM qgetSampleTypeReportsWithFilters
            ORDER BY ID DESC
        </CFQUERY> --->
        <!--- <cfdump var="#form#" abort="true"> --->
        
        <cfif (isdefined("form.startDate") and form.startDate neq "" OR isdefined("form.sampleFN")  and form.sampleFN neq "" OR isdefined("form.Species")and form.Species neq "") AND  (isdefined("form.SampleType") and form.SampleType neq "" OR isdefined("form.StorageType") and form.StorageType neq "" OR isdefined("form.PreservationMethod") and form.PreservationMethod neq "")>

         <cfquery name="qgetSampleTypeReportsWithFilters" datasource="#variables.dsn#">
            -- SELECT SampleType,StorageType,ID,PreservationMethod,date FROM ST_SampleType 
            SELECT SType.SampleType, SType.StorageType, SType.PreservationMethod, SType.ID, SA.Fnumber, SA.species, SA.date, SA.ID
            FROM ST_SampleArchive SA, ST_SampleType SType
            Where 1=1
            <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">
                and CONVERT(char(10), SA.date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'
            </cfif>
            <cfif isdefined("form.sampleFN") and form.sampleFN neq "">
                and SA.Fnumber = '#form.sampleFN#'
            </cfif>
            <cfif isdefined("form.Species") and form.Species neq "">
                and SA.Species = '#form.Species#'
            </cfif>
            <cfif isdefined("form.SampleType") and form.SampleType neq "">
                and Stype.SampleType = '#form.SampleType#'
            </cfif>
            <cfif isdefined("form.StorageType") and form.StorageType neq "">
                and Stype.StorageType = '#form.StorageType#'
            </cfif>
            <cfif isdefined("form.PreservationMethod") and form.PreservationMethod neq "">
                and Stype.PreservationMethod = '#form.PreservationMethod#'
            </cfif>
        </cfquery>
        <cfelseif isdefined("form.startDate") and form.startDate neq "" OR isdefined("form.sampleFN")  and form.sampleFN neq "" OR isdefined("form.Species")and form.Species neq "">
            <cfquery name="qgetSampleTypeReportsWithFilters" datasource="#variables.dsn#">
                SELECT Fnumber,species,ID,StTpye,date FROM ST_SampleArchive 
                Where 1=1
                <cfif isdefined("form.startDate") and form.startDate neq "" and form.endDate NEQ "">
                    and CONVERT(char(10), date,126) BETWEEN '#form.startDate#' AND '#form.endDate#'
                </cfif>
                <cfif isdefined("form.sampleFN") and form.sampleFN neq "">
                    and Fnumber = '#form.sampleFN#'
                </cfif>
                <cfif isdefined("form.Species") and form.Species neq "">
                    and Species = '#form.Species#'
                </cfif>
                ORDER BY ID DESC
            </cfquery>
            <cfelse>
                <cfquery name="qgetSampleTypeReportsWithFilters" datasource="#variables.dsn#">
                    SELECT SampleType,StorageType,ID,PreservationMethod,date FROM ST_SampleType 
                    Where 1=1
                    <cfif isdefined("form.SampleType") and form.SampleType neq "">
                        and SampleType = '#form.SampleType#'
                    </cfif>
                    <cfif isdefined("form.StorageType") and form.StorageType neq "">
                        and StorageType = '#form.StorageType#'
                    </cfif>
                    <cfif isdefined("form.PreservationMethod") and form.PreservationMethod neq "">
                        and PreservationMethod = '#form.PreservationMethod#'
                    </cfif>
                    ORDER BY ID DESC
                </cfquery>
        </cfif>
        <cfreturn qgetSampleTypeReportsWithFilters>
    </cffunction>

    <cffunction name="getSingleIncidentReport" returntype="any" output="true" access="public">
        <cfquery name="getSingleIncidentReport" datasource="#variables.dsn#">
            SELECT * FROM TLU_IncidentReport WHERE ID = #IR_ID#
        </cfquery>
        <cfreturn getSingleIncidentReport>
    </cffunction>



    <cffunction name="insertIncidentReport" returntype="any" output="false" access="public">
        <cfargument default="" name="IR_ID">
        <cfargument default="" name="IR_Type">
        <cfargument default="" name="IR_CountyLocation">
        <cfargument default="" name="IR_Date">
        <cfargument default="" name="IR_title">
        
        <cftry>
        
        <cfset IR_CreatedDate = #DateFormat(Now(),"YYYY-MM-DD")#>
        <cfset IR_UpdatedDate = #DateFormat(Now(),"YYYY-MM-DD")#>

        <cfif isDefined('IR_ID') AND #IR_ID# NEQ "" AND #IR_ID# NEQ 0>
            <cfquery name="updateIncident" datasource="#Application.dsn#" result="getResult">
                UPDATE TLU_IncidentReport SET
                IR_Type = <cfqueryparam  cfsqltype="cf_sql_integer" value='#IR_Type#' null="#IIF(IR_Type EQ "", true, false)#">,
                IR_CountyLocation = <cfqueryparam  cfsqltype="cf_sql_integer" value='#IR_CountyLocation#' null="#IIF(IR_CountyLocation EQ "", true, false)#">,
                IR_Date = <cfqueryparam  cfsqltype="cf_sql_date" value='#IR_Date#' null="#IIF(IR_Date EQ "", true, false)#">,
                IR_UpdatedDate =  <cfqueryparam cfsqltype="cf_sql_date" value="#IR_UpdatedDate#" null="#IIF(IR_UpdatedDate EQ "", true, false)#">,
                IR_title =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#IR_title#" null="#IIF(IR_title EQ "", true, false)#">
                WHERE ID = #IR_ID#
            </cfquery>
        <cfelse>
            <cfquery name="insertIncident" datasource="#Application.dsn#" result="getResult">
                insert into TLU_IncidentReport
                (IR_Type
                ,IR_CountyLocation
                ,IR_Date
                ,IR_CreatedDate
                ,IR_UpdatedDate
                ,IR_title
                )
                values(
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#IR_Type#' null="#IIF(IR_Type EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#IR_CountyLocation#' null="#IIF(IR_CountyLocation EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_date" value='#IR_Date#' null="#IIF(IR_Date EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_date" value="#IR_CreatedDate#" null="#IIF(IR_CreatedDate EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_date" value="#IR_UpdatedDate#" null="#IIF(IR_UpdatedDate EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#IR_title#" null="#IIF(IR_title EQ "", true, false)#">
                )
            </cfquery>
        </cfif>
         
        
        <cfreturn getResult>

        <cfcatch type="any">
            <cfdump  var="#cfcatch#"><cfabort>
        </cfcatch>
        </cftry>

    </cffunction>

     <cffunction name="getIncidentReportsByword" returntype="any" output="false" access="public" >
        <cfquery name="getIncidentReportsByword" datasource="#variables.dsn#"  >
            SELECT * from TLU_IncidentReport where [IR_Type] like '%#form.searchword#%'
        </cfquery>
        <cfreturn getIncidentReportsByword>
    </cffunction>

    <cffunction name="DeletIncidentReport" access="remote" returnformat="plain" output="true" >
         <cfquery name="DeletIncidentReport" datasource="#Application.dsn#" result="getResult">
            DELETE FROM TLU_IncidentReport  WHERE ID = <cfqueryparam  cfsqltype="cf_sql_integer" value='#URL.id#' >
          </cfquery>

          <cfset response = StructNew() />
          <cfif getResult.RECORDCOUNT eq 1>
                <cfset response["status"] = true>
                <cfset response["message"] = "<strong>Success!</strong> Incident Report Deleted.">
			<cfelse>
               <cfset response["status"] = false>
                <cfset response["message"] = "<strong>Error !</strong> Incident Report Deletion Faild">
			</cfif>
        <cfoutput>#SerializeJSON(response)#</cfoutput>
    </cffunction>

</cfcomponent>