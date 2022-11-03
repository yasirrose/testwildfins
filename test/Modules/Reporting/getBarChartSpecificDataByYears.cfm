<style>
table.table.table-striped.table-bordered {
    table-layout: fixed;
}
table.table.table-striped.table-bordered.table-head {
    width: 98%;
}
</style>
<cfset ReportEndyear = year(now())>
<cfset responce = "<table class='table table-striped table-bordered table-head'>
		<tr>
			<th width='20'>ID</th>
			<th width='20'>Code</th>
			<th width='20'>Sighting ID</th>
			<th width='20'>Name</th>
			<th width='20'>Sex</th>
			<th width='20'>Seen Times</th>
		</tr>
	</table>
	<div class='datacontainer'> 
	<table class='table table-striped table-bordered'>
	<tbody>">
	
    <cfquery name="check" datasource="#Application.dsn#">
    	SELECT
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHIN_SIGHTINGS.Sighting_ID
        
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
        INNER JOIN TLU_SurveyArea on TLU_SurveyArea.AreaName LIKE CONCAT('%', PROJECTS.SurveyArea, '%')

        WHERE 
        YEAR (PROJECTS.[Date]) = #FORM.fromYear# AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%' AND DOLPHINS.Code NOT LIKE 'MUM%'
		
        GROUP BY
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHIN_SIGHTINGS.Sighting_ID
        ORDER BY 
        DOLPHIN_SIGHTINGS.Dolphin_ID
    </cfquery>
    
    
    <cfloop query="check">
    	<cfset responce &= '<tr>
                                <td width="20">#Dolphin_ID#</td>
                                <td width="20">#Code#</td>
                                <td width="20">#Sighting_ID#</td>
                                <td width="20">#Name#</td>
                                <td width="20">#Sex#</td>
                                <td width="20">#SEEN_TIMES#</td>
                            </tr>'>
    </cfloop>
    <cfset responce &= '</tbody></table></div>'>
	<cfoutput>#responce#</cfoutput>