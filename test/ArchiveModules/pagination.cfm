  <cfoutput>
   <div class="mypagination">
   <cfif isDefined("noaaReport") and noaaReport eq true>
   		<!--- Checks on Displaying Recrod number--->
 		<cfif qpagination.recordcount LT Application.record_per_page>
   			Displaying <cfoutput>#qpagination.recordcount#</cfoutput> Records.
  		<cfelse>
   			<cfif (startHereIndex+Application.record_per_page) GT qpagination.recordcount>
				Displaying <cfoutput>#startHereIndex# - #qpagination.recordcount# of #qpagination.recordcount#</cfoutput> Records
			<cfelse>
				Displaying <cfoutput>#startHereIndex# - #(startHereIndex+Application.record_per_page-1)# of #qpagination.recordcount#</cfoutput> Records
			</cfif>
   		<!--- Check on Showing Previous Or Next Button --->
   		<cfif startHereIndex LT Application.record_per_page>
   			<cfelse>
            	  <a class="prev" href="javascript:void(0);" onClick="ApplyPagination(#evaluate(startHereIndex - Application.record_per_page)#); return false;">Previous</a>
   			</cfif>
   		<a >|</a>
   		<cfif (startHereIndex+Application.record_per_page) GT qpagination.recordcount>
        <cfelse>
            <a class="next" href="javascript:void(0);" onClick="ApplyPagination(#evaluate(startHereIndex + Application.record_per_page)#); return false;">Next</a>
   		</cfif>
  	</cfif>
    <cfelseif page eq 'AnnualCensusReport'>
    	<cfset startHereIndex = evaluate('startHereIndex#startHereTable#')>
		<cfif qpagination.recordcount LT Application.record_per_page>
        	Displaying <cfoutput>#qpagination.recordcount#</cfoutput> Records.
        <cfelse>
			<cfif (startHereIndex+Application.record_per_page) GT qpagination.recordcount>
                    Displaying <cfoutput>#startHereIndex# - #qpagination.recordcount# of #qpagination.recordcount#</cfoutput> Records
            <cfelse>
                    Displaying <cfoutput>#startHereIndex# - #(startHereIndex+Application.record_per_page-1)# of #qpagination.recordcount#</cfoutput> Records
            </cfif>
        <!--- Check on Showing Previous Or Next Button --->
			<cfif startHereIndex LT Application.record_per_page>
            <cfelse>
                  <a class="prev" href="javascript:void(0);" onClick="ApplyPaginations(#evaluate(startHereIndex - Application.record_per_page)#,#startHereTable#); return false;">Previous</a>
            </cfif>
            <a >|</a>
            <cfif (startHereIndex+Application.record_per_page) GT qpagination.recordcount>
            <cfelse>
                  <a class="next" href="javascript:void(0);" onClick="ApplyPaginations(#evaluate(startHereIndex + Application.record_per_page)#,#startHereTable#); return false;">Next</a>
            </cfif>
        </cfif>
   <cfelse>
   	 <!--- Checks on Displaying Recrod number--->
	 <cfif qpagination.recordcount LT Application.record_per_page>
            Displaying <cfoutput>#qpagination.recordcount#</cfoutput> Records.
      <cfelse>
            <cfif (startHereIndex+Application.record_per_page) GT qpagination.recordcount>
                    Displaying <cfoutput>#startHereIndex# - #qpagination.recordcount# of #qpagination.recordcount#</cfoutput> Records
            <cfelse>
                    Displaying <cfoutput>#startHereIndex# - #(startHereIndex+Application.record_per_page-1)# of #qpagination.recordcount#</cfoutput> Records
            </cfif>
       <!--- Check on Showing Previous Or Next Button --->
       <cfif startHereIndex LT Application.record_per_page>
            <cfelse>
                  <a class="prev" href="javascript:void(0);" onClick="ApplyPagination(#evaluate(startHereIndex - Application.record_per_page)#); return false;">Previous</a>
       </cfif>
       <a >|</a>
       <cfif (startHereIndex+Application.record_per_page) GT qpagination.recordcount>
            <cfelse>
                  <a class="next" href="javascript:void(0);" onClick="ApplyPagination(#evaluate(startHereIndex + Application.record_per_page)#); return false;">Next</a>
       </cfif>
      </cfif>
  </cfif>
  </div>
  </cfoutput>