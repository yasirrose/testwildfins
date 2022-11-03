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
			<!---<th width='20'>Sighting ID</th>--->
			<th width='20'>Name</th>
			<th width='20'>Sex</th>
			<th width='20'>Age</th>
			<th width='20'>Seen Times</th>
		</tr>
	</table>
	<div class='datacontainer'> 
	<table class='table table-striped table-bordered'>
	<tbody>">
    
    
    
 <cfquery name="check" datasource="#Application.dsn#" >   
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
        YEAR (PROJECTS.[Date]) = #FORM.fromYear#
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
        DOLPHIN_SIGHTINGS.Dolphin_ID ASC
    
    </cfquery>
<!---<cfquery name="check" datasource="#Application.dsn#" >
        SELECT
        DOLPHIN_SIGHTINGS.Dolphin_ID,
        COUNT (
        DOLPHIN_SIGHTINGS.Dolphin_ID
        ) AS SEEN_TIMES,
        DOLPHINS.Name,
        DOLPHINS.Code,
        DOLPHINS.Sex,
        DOLPHIN_SIGHTINGS.Sighting_ID,
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
        DOLPHIN_SIGHTINGS.Sighting_ID,
		DOLPHINS.[Dead?]

        ORDER BY
        DOLPHIN_SIGHTINGS.Dolphin_ID ASC
</cfquery> --->
	<cfloop query="check">
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
       <cfif age NEQ ''>
		   <cfif FORM.label EQ 'Calf Male' or FORM.label EQ 'Calf Female' or FORM.label EQ 'Calf Unknown'>
                <cfif age LTE 4>
                    <cfif SEX NEQ ''>
                        <cfif FORM.label EQ 'Calf Male' and SEX EQ 'M'>
                            <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                        </cfif>
                        <cfif FORM.label EQ 'Calf Female' and SEX EQ 'F'>
                            <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                        </cfif>
                        <cfif FORM.label EQ 'Calf Unknown' and SEX EQ 'U'>
                            <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                        </cfif>
                    </cfif>
                </cfif>
           </cfif>
           <cfif FORM.label EQ 'Adult Male' or FORM.label EQ 'Adult Female' or FORM.label EQ 'Adult Unknown'>
                <cfif age GT 10 and SEX EQ 'M' and FORM.label EQ 'Adult Male'>
                    <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
    
                </cfif>
                <cfif age GT 7 and SEX EQ 'F' and FORM.label EQ 'Adult Female'>
                    <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
    
                </cfif>
                <cfif age GTE 10 and SEX EQ 'U' and FORM.label EQ 'Adult Unknown'>
                    <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                </cfif>
           </cfif>
           <cfif FORM.label EQ 'Juvenile Male' or FORM.label EQ 'Juvenile Female' or FORM.label EQ 'Juvenile Unknown'>
                <cfif age GT 4 and age LT 10>
                        <cfif SEX NEQ ''>
                            <cfif SEX EQ 'M' and FORM.label EQ 'Juvenile Male'>
                                <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                            <cfelseif SEX EQ 'F' and FORM.label EQ 'Juvenile Female'>
                                <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                            <cfelseif SEX EQ 'U'  and FORM.label EQ 'Juvenile Unknown'>
                                <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>   
                            </cfif>
                       </cfif>
                    </cfif>
           </cfif>
           <cfelse>
		   <cfif FORM.label EQ 'Unknown Age Male' or FORM.label EQ 'Unknown Age Female' or FORM.label EQ 'Unknown Age Unknown'>
                <cfif SEX NEQ ''>
                    <cfif SEX EQ 'M' and FORM.label EQ 'Unknown Age Male'>
                        <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'> 
                    <cfelseif SEX EQ 'F' and FORM.label EQ 'Unknown Age Female'>
                        <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'> 
                    <cfelseif SEX EQ 'U' and FORM.label EQ 'Unknown Age Unknown'>
                        <cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'> 
                    </cfif>
                </cfif>
           </cfif>
       </cfif>
       <cfif FORM.label EQ 'Unknown' or FORM.label EQ 'Male' or FORM.label EQ 'Female' >
		   <cfif SEX NEQ ''>
           		<cfif FORM.label EQ 'Male' and SEX EQ 'M'>
                	<cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                </cfif>
                <cfif FORM.label EQ 'Female' and SEX EQ 'F'>
                	<cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                </cfif>
                <cfif FORM.label EQ 'Unknown' and SEX EQ 'U'>
                	<cfset responce &= '<tr>
										<td>#Dolphin_ID#</td>
										<td>#Code#</td>
										<td>#Name#</td>
										<td>#Sex#</td>
										<td>#Age#</td>
										<td>#SEEN_TIMES#</td>
										</tr>'>
                </cfif>
           </cfif>
       </cfif>
	</cfloop>
    <cfset responce &= '</tbody></table></div>'>
	<cfoutput>#responce#</cfoutput>