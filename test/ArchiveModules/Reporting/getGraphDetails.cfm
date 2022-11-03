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
<cfif isdefined("form.report_type") and report_type eq 'BestPlaces'>

	<cfset responce = "<div class='cus_scroll_v table-responsive'><table class='cus_table table table-striped table-bordered table-head'>
        <thead>
			<tr>
				<th width='20'>## of Dolphins</th>
				<th width='20'>## of Calfs</th>
				<th width='10'>Birth Rate</th>
				<th width='10'>Death Rate</th>
				<th width='20'>## of Shark Bites</th>
				<th width='20'>## of tiger Stripes</th>
				<th width='20'>% of Mill</th>
				<th width='20'>% of Feed</th>
				<th width='20'>% of Prob Feed</th>
				<th width='20'>% of Travel</th>
				<th width='20'>% of Play</th>
				<th width='20'>% of Rest</th>
				<th width='20'>% of Leap</th>
				<th width='20'>% of Social</th>
				<th width='20'>% of w/boat</th>
				<th width='20'>% of Other</th>
				<th width='20'>% of Avoid Boat</th>
				<th width='20'>% of Depredation</th>
				<th width='20'>% of Herding</th>
			</tr>
		</thead>
    <tbody>">
    
    <cfquery name="check" datasource="#Application.dsn#">
        SELECT count(distinct Dolphin_ID) as dolphin_count,
        (	SELECT count(distinct Dolphin_ID)
			FROM PROJECTS INNER JOIN
			(TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
			ON
			DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
			ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
			ON TLU_Zones.ID = SIGHTINGS.Zone_id)
			ON PROJECTS.ID = SIGHTINGS.Project_ID
			WHERE YEAR (PROJECTS.[Date]) BETWEEN '#Form.StartYear#' AND '#Form.EndYear#' and TLU_Zones.ZSEGMENT = '#Form.label#' and ((DOLPHINS.Lineage) Is Not Null)
		) as calf_count,
		(
			SELECT  COUNT (ID) AS SEEN_TIMES
			FROM DOLPHINS
			WHERE [DOB EST] IS NOT NULL AND [DOB EST]!='' AND Substring([DOB EST], Charindex('/', [DOB EST])+1, LEN([DOB EST])) BETWEEN '#Form.StartYear#' AND '#Form.EndYear#'
		) as birth_rate,

			(SELECT COUNT (ID) AS SEEN_TIMES
			 FROM DOLPHINS
			 WHERE [Date of Death] IS NOT NULL AND [Date of Death]!='' AND YEAR([Date of Death]) BETWEEN '#Form.StartYear#' AND '#Form.EndYear#'
		) as death_rate,
	    (  SELECT count(distinct Dolphin_ID)
			FROM PROJECTS INNER JOIN
			(TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
			ON
			DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
			ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
			ON TLU_Zones.ID = SIGHTINGS.Zone_id)
			ON PROJECTS.ID = SIGHTINGS.Project_ID
			WHERE YEAR (PROJECTS.[Date]) BETWEEN '#Form.StartYear#' AND '#Form.EndYear#' and TLU_Zones.ZSEGMENT = '#Form.label#' and bodyCondition = 'Shark Bite'
	     ) as shark_bite_count,
		(  SELECT count(distinct Dolphin_ID)
			FROM PROJECTS INNER JOIN
			(TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
			ON
			DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
			ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
			ON TLU_Zones.ID = SIGHTINGS.Zone_id)
			ON PROJECTS.ID = SIGHTINGS.Project_ID
			WHERE YEAR (PROJECTS.[Date]) BETWEEN '#Form.StartYear#' AND '#Form.EndYear#' and TLU_Zones.ZSEGMENT = '#Form.label#' and bodyCondition = 'Tiger Stripes'
	     ) as tiger_stripes_count

		
        FROM
        PROJECTS INNER JOIN
        (TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
        ON
        DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
        ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
        ON TLU_Zones.ID = SIGHTINGS.Zone_id)
        ON PROJECTS.ID = SIGHTINGS.Project_ID
        WHERE YEAR (PROJECTS.[Date]) BETWEEN '#Form.StartYear#' AND '#Form.EndYear#' and TLU_Zones.ZSEGMENT = '#Form.label#'
    </cfquery>
    
    <cfquery name="activity_sighting" datasource="#Application.dsn#">
    	SELECT Activity_Mill,Activity_Feed,Activity_ProbFeed,Activity_Travel,Activity_Play,Activity_Rest,Activity_Leap_tailslap_chuff
        ,Activity_Social,Activity_WithBoat,Activity_Other,Activity_Avoid_Boat,Depredation,Herding
        FROM PROJECTS INNER JOIN
        (TLU_Zones INNER JOIN (SIGHTINGS INNER JOIN (DOLPHINS RIGHT JOIN DOLPHIN_SIGHTINGS
        ON
        DOLPHINS.ID = DOLPHIN_SIGHTINGS.Dolphin_ID)
        ON SIGHTINGS.ID = DOLPHIN_SIGHTINGS.Sighting_ID)
        ON TLU_Zones.ID = SIGHTINGS.Zone_id)
        ON PROJECTS.ID = SIGHTINGS.Project_ID
        WHERE YEAR (PROJECTS.[Date]) BETWEEN '#Form.StartYear#' AND '#Form.EndYear#' and TLU_Zones.ZSEGMENT = '#Form.label#'
    </cfquery>
    <cfset cActivity_Mill     		= 0>
    <cfset cActivity_Feed     		= 0>
    <cfset cActivity_ProbFeed 		= 0>
    <cfset cActivity_Travel   		= 0>
    <cfset cActivity_Play     		= 0>
    <cfset cActivity_Rest     		= 0>
    <cfset cActivity_Leap     		= 0>
    <cfset cActivity_Social   		= 0>
    <cfset cActivity_WithBoat 		= 0>
    <cfset cActivity_Other    		= 0>
    <cfset cActivity_Avoid_Boat     = 0>
    <cfset cDepredation     		= 0>
    <cfset cHerding     			= 0>
    
    <cfloop query="activity_sighting">
    	<cfif Activity_Mill eq 1>                <cfset cActivity_Mill ++></cfif>	
        <cfif Activity_Feed eq 1>				 <cfset cActivity_Feed ++></cfif>
        <cfif Activity_ProbFeed eq 1>			 <cfset cActivity_ProbFeed ++></cfif>
        <cfif Activity_Travel eq 1>				 <cfset cActivity_Travel ++></cfif>
		<cfif Activity_Play eq 1>				 <cfset cActivity_Play ++></cfif>
        <cfif Activity_Rest eq 1>				 <cfset cActivity_Rest ++></cfif>
        <cfif Activity_Leap_tailslap_chuff eq 1> <cfset cActivity_Leap ++></cfif>
        <cfif Activity_Social eq 1>				 <cfset cActivity_Social ++></cfif>
        <cfif Activity_WithBoat eq 1>			 <cfset cActivity_WithBoat ++></cfif>
        <cfif Activity_Other eq 1>				 <cfset cActivity_Other ++></cfif>
        <cfif Activity_Avoid_Boat eq 1>			 <cfset cActivity_Avoid_Boat ++></cfif>
        <cfif Depredation eq 1>					 <cfset cDepredation ++></cfif>
        <cfif Herding eq 1>						 <cfset cHerding ++></cfif>
    </cfloop>
    <cfif activity_sighting.recordcount gt 0>
		<cfif cActivity_Mill neq 0>       <cfset cActivity_Mill = #NumberFormat((cActivity_Mill/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_Feed neq 0>		  <cfset cActivity_Feed = #NumberFormat((cActivity_Feed/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_ProbFeed neq 0>	  <cfset cActivity_ProbFeed = #NumberFormat((cActivity_ProbFeed/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_Travel neq 0> 	  <cfset cActivity_Travel = #NumberFormat((cActivity_Travel/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_Play neq 0>		  <cfset cActivity_Play = #NumberFormat((cActivity_Play/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_Rest neq 0>		  <cfset cActivity_Rest = #NumberFormat((cActivity_Rest/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_Leap neq 0>		  <cfset cActivity_Leap = #NumberFormat((cActivity_Leap/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_Social neq 0>	  <cfset cActivity_Social = #NumberFormat((cActivity_Social/activity_sighting.recordcount)*100,9.99)#></cfif>
		<cfif cActivity_WithBoat neq 0>	  <cfset cActivity_WithBoat = #NumberFormat((cActivity_WithBoat/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_Other neq 0>	  <cfset cActivity_Other = #NumberFormat((cActivity_Other/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cActivity_Avoid_Boat neq 0> <cfset cActivity_Avoid_Boat = #NumberFormat((cActivity_Avoid_Boat/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cDepredation neq 0>		  <cfset cDepredation = #NumberFormat((cDepredation/activity_sighting.recordcount)*100,9.99)#></cfif>
        <cfif cHerding neq 0>			  <cfset cHerding = #NumberFormat((cHerding/activity_sighting.recordcount)*100,9.99)#></cfif>
	</cfif>
    <cfloop query="check">
        <cfset responce &= '<tr>
                                <td width="20">#dolphin_count#</td>
                                <td width="20">#calf_count#</td>
                                <td width="10">#birth_rate#</td>
                                <td width="10">#death_rate#</td>
                                <td width="20">#shark_bite_count#</td>
                                <td width="20">#tiger_stripes_count#</td>
								<td width="20">#cActivity_Mill#</td>
								<td width="20">#cActivity_Feed#</td>
								<td width="20">#cActivity_ProbFeed#</td>
								<td width="20">#cActivity_Travel#</td>
								<td width="20">#cActivity_Play#</td>
								<td width="20">#cActivity_Rest#</td>
								<td width="20">#cActivity_Leap#</td>
								<td width="20">#cActivity_Social#</td>
								<td width="20">#cActivity_WithBoat#</td>
								<td width="20">#cActivity_Other#</td>
								<td width="20">#cActivity_Avoid_Boat#</td>
								<td width="20">#cDepredation#</td>
								<td width="20">#cHerding#</td>
                            </tr>'>
    </cfloop>
    <cfset responce &= '</tbody></table></div>'>
<cfelse>
	<cfset responce = "<table class='table table-striped table-bordered table-head'>
		<tr>
			<th width='20'>ID</th>
			<th width='20'>Code</th>
			<th width='20'>Name</th>
			<th width='20'>Sex</th>
			<th width='20'>Age</th>
		</tr>
	</table>
	<div class='datacontainer'> 
	<table class='table table-striped table-bordered'>
	<tbody>">
    
    <cfquery name="graphDetail" datasource="#Application.dsn#" >   
        SELECT ID,Code,Name,Sex,YearOfBirth,[Dead?] AS IsDead,YEAR ([Date of Death]) AS DeathYear
        FROM DOLPHINS
        WHERE ID IN(#FORM.DOLPHINS#)
        ORDER BY CODE ASC
    </cfquery>
    <cfloop query="graphDetail">
        <cfif YearOfBirth NEQ '' AND IsNumeric(YearOfBirth)>
          <cfif IsDead	EQ 0 OR DeathYear EQ ''>
              <cfset age = #FORM.fromYear# - YearOfBirth >
          <cfelse>
              <cfif IsNumeric(DeathYear)>
                <cfset age = DeathYear - YearOfBirth >
              <cfelse>
                <cfset age = '' >
              </cfif>
          </cfif>
        <cfelse>
          <cfset age = '' >
        </cfif>
        <cfset responce &= '<tr>
                            <td>#ID#</td>
                            <td>#Code#</td>
                            <td>#Name#</td>
                            <td>#Sex#</td>
                            <td>#replace(age,"-","")#</td>
                        </tr>'>
    </cfloop>
	<cfset responce &= '</tbody></table></div>'>
</cfif>
<cfoutput>#responce#</cfoutput>