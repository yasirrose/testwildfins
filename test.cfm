<!--- <cfimage
					action = "resize"
					source = "#Application.CloudDirectory#Jellyfish.jpg"
					width = "100%"
					height = "100%"
					name = "xx.jpg"
					overwrite = "yes">
			<cffile action = "delete" file = "#Application.CloudDirectory#Jellyfish.jpg"> --->

<!--- <cfdump var="#application.dsn#"> --->
<cfabort>
<cfquery name="getSurvey" datasource="#application.dsn#" result="res">
	SELECT ID, NOAAStock from Surveys where NOAAStock != 'null';
</cfquery>


<cfloop query="getSurvey">
	
	<cfquery name="getAllNames" datasource="#application.dsn#">
		SELECT ID, StockName, active FROM TLU_Stock where StockName = '#getSurvey.NOAAStock#'
	</cfquery>

	<cfquery name="updateSurvey" datasource="#application.dsn#" result="res">
		Update Surveys set NOAAStock = '#getAllNames.ID#' where ID = '#getSurvey.ID#' and NOAAStock = '#getAllNames.StockName#'
	</cfquery>

	<cfdump var="#res#">

</cfloop>