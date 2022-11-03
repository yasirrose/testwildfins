<cfdocument pagetype="custom" format="pdf" name="pdf" pageheight="10.0" pagewidth="8.5">
	<cfoutput>
    	<h2 style="text-align:center; margin-bottom:20px;">Biopsy Catalog Report</h1>
    	<table style="width:100%; padding-top:10px" cellpadding="0" cellspacing="0">
    	<cfloop query="getBiopsyCatalog">
        	<cfset qgetdolphin = Application.Reporting.getdolphinfin(getBiopsyCatalog.ID)>
            
            <cfloop query='qgetdolphin'>
				<cfset  Fin  = '#Application.CloudRoot#no-image.jpg'>
                <cfif qgetdolphin.DATESEEN NEQ ''>
                	<cfif DAY(DATESEEN) lt 10 >
                	<cfset dayy = '0#DAY(DATESEEN)#'>
                <cfelse>
                	<cfset dayy  = DAY(DATESEEN)>  
                </cfif>
                <cfif MONTH(DATESEEN) lt 10 >
                	<cfset monthh = '0#MONTH(DATESEEN)#'>
                <cfelse>
                	<cfset monthh  = MONTH(DATESEEN)>  
                </cfif>
                <cfset Fin_Left = '#getBiopsyCatalog.Code#(L) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
                <cfset Fin_Right = '#getBiopsyCatalog.Code#(R) #Year(DATESEEN)# #monthh# #dayy#.jpg'>
                
                <cfif FileExists('#Application.CloudDirectory##Fin_Left#')>
					<cfset  Fin = '#Application.CloudRoot##Fin_Left#'>
                    <cfbreak>
                <cfelseif FileExists('#Application.CloudDirectory##Fin_Right#')>
					<cfset  Fin  = '#Application.CloudRoot##Fin_Right#'>
                    <cfbreak>
                </cfif>	
                </cfif>                       
            </cfloop>
        	<cfset newDate = DateFormat(getBiopsyCatalog.Date, "yyyy-mm-dd")>
           		<tr>
                	<td valign="middle" width="50%"><img src='#Fin#' width="320" height="200" id="imageresource"/></td>
                    <td width="50%" valign="top">
                    	<p style="font-size:15px; color:##000; font-family:Arial, Helvetica, sans-serif; line-height:25px; margin:0;"><b>Dolphin name </b> : #getBiopsyCatalog.Name#</p>
            			<p style="font-size:15px; color:##000; font-family:Arial, Helvetica, sans-serif; line-height:25px; margin:0;"><b>Code </b>: #getBiopsyCatalog.Code#</p>
            			<p style="font-size:15px; color:##000; font-family:Arial, Helvetica, sans-serif; line-height:25px; margin:0;"><b>Date sampled </b> : #newDate#</p>
                    </td>
                </tr>
                <tr><td colspan="2" style="height:20px;"></td></tr>
				<tr>
                	<td colspan="2"><hr></td>
                </tr>            
                <tr><td colspan="2" style="height:20px;"></td></tr>
                 </cfloop>
            </table>
      
	</cfoutput>
  
</cfdocument>

	
<cffile action="write" file="#expandPath('.')#\Reports\pdf\BiopsyCatalogReport.pdf" output="#pdf#">

<cfheader name="Content-Disposition" value="attachment;filename=BiopsyCatalogReport.pdf">
<cfcontent type="application/octet-stream" file="#expandPath('.')#\Reports\pdf\BiopsyCatalogReport.pdf">