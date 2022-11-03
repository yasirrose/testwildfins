<cftry>

<cfif isdefined('form.saveReportOnly') OR  isdefined('form.generatePdfOnly')>
    <cfparam name="form.IR_Date" default="">
    <cfparam name="form.IR_Type" default="0">
    <cfparam name="form.IR_CountyLocation" default="0">

    <cfif isdefined('form.saveReportOnly')> 
        <cfset IR_CreatedDate = #DateFormat(Now(),"YYYY-MM-DD")#>

            <cfquery name="insertIncident" datasource="#Application.dsn#" result="insertInci">
                insert into TLU_IncidentReport
                (IR_Type
                ,IR_CountyLocation
                ,IR_Date
                ,IR_Dateinserted
                )
                values(
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#IR_Type#' null="#IIF(IR_Type EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_integer" value='#IR_CountyLocation#' null="#IIF(IR_CountyLocation EQ "", true, false)#">,
                <cfqueryparam  cfsqltype="cf_sql_date" value='#IR_Date#' null="#IIF(IR_Date EQ "", true, false)#">,
                <cfqueryparam cfsqltype="cf_sql_date" value="#IR_CreatedDate#" null="#IIF(IR_CreatedDate EQ "", true, false)#">
                )
            </cfquery>
    </cfif>
    
    <cfif isdefined('form.generatePdfOnly')> 

        <cfif isDefined('form.IR_Type') AND #form.IR_Type# NEQ 0>
            <cfset setIR_IR_TypeName = Application.IncidentReport.getIR_IR_TypeName(#form.IR_Type#)>
        <cfelse>
            <cfset setIR_IR_TypeName = "">
        </cfif>

        <cfif isDefined('form.IR_CountyLocation') AND #form.IR_CountyLocation# NEQ 0>
            <cfset setIR_CountyLocationName = Application.IncidentReport.getIR_CountyLocationName(#form.IR_CountyLocation#)> 
        <cfelse>
            <cfset setIR_CountyLocationName = "">
        </cfif>

        <cfdocument backgroundvisible="yes" fontembed="yes" format="pdf" localUrl="yes" pagetype="a4" orientation="portrait" margintop=".15" marginbottom="0.15" marginleft=".20" marginright=".20" unit="in" mimetype="text/html">
            <h2 style="text-align:center; font-family:Arial, Helvetica, sans-serif; text-transform:uppercase;">Harbor Branch Oceanographic Institute @ FAU Marine Mammal Stranding and Population Assessment Incident Report</h2>
            <cfoutput>
                <cfinclude template="styles.cfm">
            <table cellpadding="0" cellspacing="0" width="100%" style="font-size:12px; font-family:Arial, Helvetica, sans-serif; color:black;">
            
            <tr>
            <td>
            
            <table cellpadding="4" cellspacing="0" width="50%" style="border:1px solid black;">
                <tr>
                <td width="30%" style="border-right:1px solid black">
                    <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">Incident Report</h4>
                <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px;">
                    <tr>
                    <td>

                    <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
                        <tr>
                            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Type:</b></td>
                        <td width="220" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#setIR_IR_TypeName#&nbsp;</td>
                        </tr>
                    </table>


                    <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
                        <tr>
                            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>County/Location:</b></td>
                        <td width="220" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#setIR_CountyLocationName#&nbsp;</td>
                        </tr>
                    </table>

                    <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
                        <tr>
                            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Date:</b></td>
                        <td width="220" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#IR_Date#&nbsp;</td>
                        </tr>
                    </table>
                    
                    </td>
                    </tr>
                </table>
                </td>
                </tr>
            </table>
        
            </td>
            </tr>
            </table>
            </cfoutput>
        </cfdocument>
    </cfif>

</cfif>

<cfcatch type="any">
    <cfdump  var="#cfcatch#"><cfabort>
</cfcatch>
</cftry>

