<style>
table.table.table-striped.table-bordered {
    table-layout: fixed;
}
table.table.table-striped.table-bordered.table-head {
    width: 98%;
}
.cus_scroll_v.table-responsive {
    max-height: 550px;
}
table.cus_table.table {
    table-layout: inherit !important;
    text-align: center;
}
table.cus_table.table {
    table-layout: inherit !important;
    text-align: center;
}
table.cus_table.table th {
    white-space: nowrap;
}
</style>

<cfif isdefined("form.report_type") and report_type eq 'DolphinActivity'>

	<cfset responce = "<div class='cus_scroll_v table-responsive'><table class='cus_table table table-striped table-bordered table-head'>
        <thead>
			<tr>
				<th width='10'>ID</th>
				<th width='20'>Code</th>
				<th width='10'>Sighting ID</th>
				<th width='4'>Mill</th>
				<th width='4'>Feed</th>
				<th width='4'>Prob Feed</th>
				<th width='4'>Travel</th>
				<th width='3'>Play</th>
				<th width='3'>Rest</th>
				<th width='4'>Leap</th>
				<th width='4'>Social</th>
				<th width='4'>w/boat</th>
				<th width='4'>Other</th>
				<th width='4'>Avoid Boat</th>
				<th width='4'>Depredation</th>
				<th width='4'>Herding</th>
			</tr>
		</thead>
    <tbody>">
    
    <cfquery name="check" datasource="#Application.dsn#">
        SELECT DOLPHIN_SIGHTINGS.Dolphin_ID,DOLPHIN_SIGHTINGS.Sighting_ID,DOLPHINS.code,TLU_Zones.zone,Activity_Mill,Activity_Feed,Activity_ProbFeed
        ,Activity_Travel,Activity_Play,Activity_Rest,Activity_Leap_tailslap_chuff,Activity_Social,Activity_WithBoat,Activity_Other,Activity_Avoid_Boat
        ,Depredation,Herding
        FROM PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
		INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID

        WHERE YEAR (PROJECTS.[Date]) BETWEEN #FORM.StartYear# AND #FORM.EndYear#  and TLU_Zones.zone like '#FORM.label#%'
		AND ((Activity_Mill is not null and Activity_Mill!=0) or (Activity_Feed is not null and Activity_Feed!=0) or 
			 (Activity_ProbFeed is not null and Activity_ProbFeed!=0) or (Activity_Travel is not null and Activity_Travel!=0) or
			 (Activity_Play is not null and Activity_Play!=0) or (Activity_Rest is not null and Activity_Rest!=0) or (Activity_Leap_tailslap_chuff is not null and Activity_Leap_tailslap_chuff!=0) or (Activity_Social is not null and Activity_Social!=0) or 
			 (Activity_WithBoat is not null and Activity_WithBoat!=0) or (Depredation is not null and Depredation!=0) or (Herding is not null and Herding!=0))
    </cfquery>
    
    
    <cfloop query="check">
        <cfset responce &= '<tr>
                                <td width="10">#Dolphin_ID#</td>
                                <td width="20">#Code#</td>
                                <td width="10">#Sighting_ID#</td>
                                <td width="4">#Activity_Mill#</td>
                                <td width="4">#Activity_Feed#</td>
                                <td width="4">#Activity_ProbFeed#</td>
								<td width="4">#Activity_Travel#</td>
								<td width="3">#Activity_Play#</td>
								<td width="3">#Activity_Rest#</td>
								<td width="4">#Activity_Leap_tailslap_chuff#</td>
								<td width="4">#Activity_Social#</td>
								<td width="4">#Activity_WithBoat#</td>
								<td width="4">#Activity_Other#</td>
								<td width="4">#Activity_Avoid_Boat#</td>
								<td width="4">#Depredation#</td>
								<td width="4">#Herding#</td>
                            </tr>'>
    </cfloop>
    <cfset responce &= '</tbody></table></div>'>

<cfelse>
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
        DOLPHIN_SIGHTINGS.Sighting_ID,
        TLU_Zones.ZONE
        FROM
        PROJECTS
        INNER JOIN SIGHTINGS ON SIGHTINGS.Project_ID = PROJECTS.ID
        INNER JOIN DOLPHIN_SIGHTINGS ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID
        INNER JOIN DOLPHINS ON DOLPHIN_SIGHTINGS.Dolphin_ID = DOLPHINS.ID
         INNER  JOIN TLU_Zones ON SIGHTINGS.Zone_id = TLU_Zones.ID
    
        WHERE
        YEAR (PROJECTS.[Date]) = #FORM.fromyear#
        AND DOLPHINS.Code NOT LIKE 'UNK%' AND DOLPHINS.Code NOT LIKE 'cUNK%' AND TLU_Zones.ZONE LIKE '#FORM.label#%'
        GROUP BY
        
        
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHIN_SIGHTINGS.Sighting_ID,
        TLU_Zones.ZONE
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
</cfif>
	<cfoutput>#responce#</cfoutput>