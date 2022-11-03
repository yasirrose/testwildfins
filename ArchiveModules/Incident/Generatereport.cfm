<cfif isdefined('form.generatepdf')>
    <cfset  submit_date = #DateFormat(Now(),"YYYY-MM-DD")#>
    <cfquery name="checkIncident" datasource="#application.dsn#" result="check">
        select * from Tlu_IncidentSighting where Dateinserted = '#submit_date#'
    </cfquery>
    <cfif #check.RECORDCOUNT# eq 1>
        <cfset SESSION.incidentBack = 1>
        <cflocation url="#Application.superadmin#?ArchiveModule=Incident&Page=incidentform&Archive">
    <cfelseif #check.RECORDCOUNT# eq 0>
    <cfparam name="form.image2" default="">
    <cfparam name="form.image1" default="">
    <cfparam name="theFile1" default="">
    <cfparam name="theFile2" default="">
    <cfif len(trim(form.image1))>
        <cffile action="upload"
                fileField="image1"
                destination="#Application.CloudDirectory#"
                result="image_info"
                nameconflict="overwrite">
        <cfif image_info.fileWasSaved>
            <cfset theFile1 = "#image_info.serverfile#">
        </cfif>
    </cfif>
    <cfif len(trim(form.image2))>
        <cffile action="upload"
                fileField="image2"
                destination="#Application.CloudDirectory#"
                result="image_info"
                nameconflict="overwrite">
        <cfif image_info.fileWasSaved>
            <cfset theFile2 =  "#image_info.serverFile#">
        </cfif>
    </cfif>
    <cfparam name="form.rights" default="0">
    <cfparam name="form.lefts" default="0">
    <cfparam name="form.pendu" default="0">
    <cfparam name="form.fluku" default="0">
    <cfparam name="form.vido" default="0">
    <cfparam name="form.rds" default="0">
    <cfparam name="form.emact" default="0">
    <cfparam name="form.abnrml" default="0">
    <cfparam name="form.shark" default="0">
    <cfparam name="form.boathit" default="0">
    <cfparam name="form.emaction" default="0">
    <cfparam name="form.cbd" default="0">
    <cfparam name="form.followup" default="0">
    <cfparam name="form.noaa" default="0">

    <cfquery name="insertIncident" datasource="#Application.dsn#" result="insertInci">
        insert into Tlu_IncidentSighting
        (
         project_id,
         sighting_id,
         Dolphin_ID,
         <!---MMIR_Num,--->
         <!---[name],--->
         <!---Genus,--->
         <!---Species,--->
         <!---examinar_name,--->
         <!---affiliation,--->
         <!---address,--->
         <!---phone,--->
         <!---research_authornumber,--->
         locality_details,
         research_survey,
         location_other,
         observedplace,
         lefts,
         leftdes,
         rights,
         rightdes,
         pendu,
         pendescription,
         fluku,
         flukdescription,
         vido,
         videscription,
         RDS,
         Emaciation,
         Abnormal_Behaivior,
         Shark,
         boathit,
         CBD,
         Cause_Description,
         respiration,
         observationother,
         followup,
         Noanumber,
         accession,
         image1,
         image2,
         Dateinserted
        )
        values(
        <cfqueryparam  cfsqltype="cf_sql_integer" value='#hiddent_project#'>,
        <cfqueryparam  cfsqltype="cf_sql_integer" value='#hidden_sight#'>,
        <cfqueryparam  cfsqltype="cf_sql_integer" value='#Dolphin_ID#'>,
        <!---<cfqueryparam  cfsqltype="cf_sql_integer" value='#hboi#' null="#IIF(hboi EQ "", true, false)#">,--->
        <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#cname#' null="#IIF(cname EQ "", true, false)#">,--->
        <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#genious#' null="#IIF(genious EQ "", true, false)#">,--->
        <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#spec#' null="#IIF(spec EQ "", true, false)#">,--->
        <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#examinar#' null="#IIF(examinar EQ "", true, false)#">,--->
        <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#affiliate#' null="#IIF(affiliate EQ "", true, false)#">,--->
        <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#address#' null="#IIF(address EQ "", true, false)#">,--->
        <!---<cfqueryparam  cfsqltype="cf_sql_varchar" value='#phone#' null="#IIF(phone EQ "", true, false)#">,--->
        <!---<cfqueryparam  cfsqltype="cf_sql_integer" value='#rauthorize#' null="#IIF(rauthorize EQ "", true, false)#">,--->
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#locdetails#' null="#IIF(locdetails EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_integer" value='#researchsurvey#' null="#IIF(researchsurvey EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#othr#' null="#IIF(othr EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_integer" value='#observedplace#' null="#IIF(observedplace EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#lefts#'>,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#leftdes#' null="#IIF(leftdes EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#rights#'>,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#rightdescription#' null="#IIF(rightdescription EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#pendu#'>,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#pendescription#' null="#IIF(pendescription EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#fluku#' >,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#flukdescription#' null="#IIF(flukdescription EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#vido#' >,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#videscription#' null="#IIF(videscription EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#rds#'>,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#emaction#'>,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#abnrml#'>,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#shark#'>,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#boathit#'>,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#cbd#'>,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#dscrptn#' null="#IIF(dscrptn EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_integer" value='#respiration#' null="#IIF(respiration EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#observationother#' null="#IIF(observationother EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#followup#'>,
        <cfqueryparam  cfsqltype="cf_sql_bit" value='#noaa#'>,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#accession#' null="#IIF(accession EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#theFile1#' null="#IIF(theFile1 EQ "", true, false)#">,
        <cfqueryparam  cfsqltype="cf_sql_varchar" value='#theFile2#' null="#IIF(theFile2 EQ "", true, false)#">,
        <cfqueryparam cfsqltype="cf_sql_date" value="#submit_date#">
        )
</cfquery>
    <cfdocument backgroundvisible="yes" fontembed="yes" format="pdf" localUrl="yes" pagetype="a4" orientation="portrait" margintop=".15" marginbottom="0.15" marginleft=".20" marginright=".20" unit="in" mimetype="text/html">
        <h2 style="text-align:center; font-family:Arial, Helvetica, sans-serif; text-transform:uppercase;">Harbor Branch Oceanographic @ Fau Photo-Id Marine Mammal Incident Report</h2>
        <cfoutput>
            <cfinclude template="styles.cfm">
            <table cellpadding="0" cellspacing="0" width="100%" style="font-size:12px; font-family:Arial, Helvetica, sans-serif; color:black;">
            <tr>
            <td>
            <table cellpadding="0" cellspacing="0">
            <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>HBOI MMRC MMIR##:</b></td>
        <!---<td width="200" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.hboi#&nbsp;</td>--->
        </tr>
        </table>
        </td>
        </tr>
        <tr>
        <td>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:10px;">
        <tr>
            <td width="120" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>COMMON NAME:</b></td>
        <!---<td width="200" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.cname#&nbsp;</td>--->
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>GENUS:</b></td>
        <!---<td width="200" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.genious#&nbsp;</td>--->
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>SPECIES:</b></td>
        <!---<td width="200" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.spec#&nbsp;</td>--->
        </tr>
        </table>
        </td>
        </tr>
        <tr>
        <td>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:10px;">
        <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>EXAMINER Name:</b></td>
        <!---<td width="300" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.examinar#&nbsp;</td>--->
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Affiliation:</b></td>
        <!---<td width="240" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.affiliate#&nbsp;</td>--->
        </tr>
        </table>
        </td>
        </tr>
        <tr>
        <td>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:10px;">
        <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Addrress:</b></td>
        <!---<td width="380" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.address#&nbsp;</td>--->
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Phone:</b></td>
        <!---<td width="240" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.phone#&nbsp;</td>--->
        </tr>
        </table>
        </td>
        </tr>
        <tr>
        <td>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:10px; padding-bottom:10px;">
        <tr>
            <td width="180" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Research Authorization Number:</b></td>
        <!---<td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.rauthorize#&nbsp;</td>--->
        </tr>
        </table>
        </td>
        </tr>
        <tr>
        <td>
        <table cellpadding="4" cellspacing="0" width="100%" style="border:1px solid black;">
        <tr>
        <td width="30%" style="border-right:1px solid black">
            <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">Location of Initial Observation</h4>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px;">
        <tr>
        <td>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
        <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>State:</b></td>
        <td width="80" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.state#&nbsp;</td>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Country:</b></td>
        <td width="140" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.country#&nbsp;</td>
        </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
        <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>City:</b></td>
        <td width="220" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.City#&nbsp;</td>
        </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
        <tr>
            <td width="80" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Body of Water:</b></td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.water_body#&nbsp;</td>
        </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
            <tr>
                <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Locality Details:</b></td>
            </tr>
        <tr>
        <td width="" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.locdetails#&nbsp;</td>
        </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
        <tr>
            <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Lat (DD):</b></td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.latitude#&nbsp;</td>
        </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
        <tr>
            <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Long (DD):</b></td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.longitude#&nbsp;</td>
        </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
            <tr>
                <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Discoverd during</b></td>
            </tr>
        <tr>
        <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-top:4px;">
            <label class="control-label col-sm-3" >Research Survey</label>
                <input type="radio" id="yes"  name="researchsurvey" <cfif #form.researchsurvey# eq 1>checked</cfif>>
            <label for="yes"> Yes</label>
                <input type="radio" id="yes"  name="researchsurvey" <cfif #form.researchsurvey# eq 0>checked</cfif>>
            <label for="No"> No</label>
        </td>
        </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px;">
        <tr>
            <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Other</b></td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.othr#&nbsp;</td>
        </tr>
        </table>

        </td>
        </tr>
        </table>
        </td>
        <td width="70%">
            <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">PHOTOGRAPHS</h4>
        <table cellpadding="4" cellspacing="4" width="100%" style="text-align:center;">
        <tr>
        <td height="200" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border:1px solid black; vertical-align:middle;"><img src="#Application.CloudRoot##theFile1#"  height="150px" width="200px"/><b></b></td>


        <td height="200" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border:1px solid black; vertical-align:middle;"><b><img src="#Application.CloudRoot##theFile2#" height="150px" width="200px" /></b></td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        <table cellpadding="4" cellspacing="0" width="100%" style="border:1px solid black; margin-top:-1px;">
        <tr>
        <td width="50%" style="border-right:1px solid black;">
            <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; text-transform:uppercase;">Initial Observation</h4>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
        <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">Date:</td>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">Year:</td>
        <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.year#</td>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-left:10px;">Month:</td>
        <td width="90" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.month#</td>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-left:10px;">Day:</td>
        <td width="40" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.day#</td>
        </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px;">
            <tr>
                <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:4px;">First Observed</td>
            </tr>
        <tr>
        <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:4px;">
            <cfif #form.observedplace# eq 0>
                    <input type="radio"    checked>Beach or Land
            <cfelse>
                    <input type="radio">Beach or Land
            </cfif>
            </td>
            </tr>
            <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:4px;">
            <cfif #form.observedplace# eq 1 >
                    <input type="radio"  checked>Floating
            <cfelse>
                    <input type="radio" >Floating
            </cfif>
            </td>
                <tr>
                </tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:4px;">
            <cfif #form.observedplace# eq 2>
                    <input type="radio"  checked>swimminig
            <cfelse>
                    <input type="radio" >swimminig
            </cfif>
            </td>
                </tr>
            </table>
            </td>
            <td width="50%">
                <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; text-transform:uppercase;">PHOTOGRAPHS <span style="text-transform:lowercase;">(or visual comments)</span></h4>
            <table cellpadding="0" cellspacing="0" width="100%" style="padding-top:4px; padding-bottom:4px;">
            <tr>
            <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><input type="Checkbox"   name="lefts" <cfif #form.lefts# eq 1>checked</cfif>> Left Side:</td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.leftdes#</td>
        </tr>
        <tr>
        <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><input type="Checkbox"   name="rights" <cfif #form.rights# eq 1>checked</cfif>> Right Side:</td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.rightdescription#</td>
        </tr>
        <tr>
        <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><input type="Checkbox"   name="pendu" <cfif #form.pendu# eq 1>checked</cfif>> Penduncle:</td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.pendescription#</td>
        </tr>
        <tr>
        <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><input type="Checkbox"   name="fluku" <cfif #form.fluku# eq 1>checked</cfif>> Flukes:</td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.flukdescription#</td>
        </tr>
        <tr>
        <td width="60" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><input type="Checkbox"   name="vido" <cfif #form.vido# eq 1>checked</cfif>> Video:</td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.videscription#</td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        <table cellpadding="4" cellspacing="0" width="100%" style="border:1px solid black; margin-top:-1px;">
        <tr>
        <td width="50%" style="border-right:1px solid black;">
            <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; text-transform:uppercase;">Cause for concern</h4>
        <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:0;">
            <cfif #form.rds# eq 1>
                    <input type="Checkbox"   name="rds" checked> <label for=""> RDS</label>
            <cfelse>
                    <input type="Checkbox"   name="rds" > <label for=""> RDS</label>
            </cfif>
            </td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:0;">
            <cfif #form.emact# eq 1>
                    <input type="Checkbox"   name="emact" checked> <label for=""> Emaciation</label>
            <cfelse>
                    <input type="Checkbox"   name="emact" > <label for=""> Emaciation</label>
            </cfif>
            </td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:0;">
            <cfif #form.abnrml# eq 1>
                    <input type="Checkbox"   name="abnrml" checked> <label for=""> Abnormal Behaivior</label>
            <cfelse>
                    <input type="Checkbox"   name="abnrml" ><label for="">Abnormal Behaivior</label>
            </cfif>
            </td>
            </tr>
            <tr>
            <td colspan="3"  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-top:4px;">
            <table cellpadding="0" cellspacing="0" >
                <tr>
                    <td colspan="3" valign="top" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Fresh Wound:</b></td>
                </tr>
            <tr>
            <td style="padding-bottom:0; font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">
            <cfif #form.shark# eq 1>
                    <input type="Checkbox"   name="shark" checked> Shark
            <cfelse>
                    <input type="Checkbox"   name="shark" > Shark
            </cfif>
            </td>
            <td style="padding-bottom:0; font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">
            <cfif #form.boathit# eq 1>
                    <input type="Checkbox"   name="boathit" checked> Boathit
            <cfelse>
                    <input type="Checkbox"   name="boathit" > Boathit
            </cfif>
            </td>
            <td style="padding-bottom:0; font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">
            <cfif #form.cbd# eq 1>
                    <input type="Checkbox"   name="cbd" checked> CBD
            <cfelse>
                    <input type="Checkbox"   name="cbd" > CBD
            </cfif>
            </td>
            </tr>
            </table>
            </td>
            </tr>
            <tr>
            <td colspan="3"  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-top:4px;">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td valign="top" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:4px;"><b>Description:</b></td>
                </tr>
            <tr>
            <td valign="top" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border:1px solid black; height:70px;">#form.dscrptn#</td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        </td>
        <td width="50%" valign="top">
            <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; text-transform:uppercase;">BEHAVIOUR OBSERVATIONAS</h4>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px;">
        <tr>
            <td width="90" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">Respiration Rate:</td>
        <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">#form.respiration#</td>
        </tr>
        </table>
            <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px;">
                <tr>
                    <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;" colspan="6"><b>Behaviour Count:</b></td>
                </tr>
                <tr>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                </tr>
                <tr>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                    <td><input type="checkbox" /></td>
                </tr>
                <tr>
                    <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-top:4px; padding-bottom:4px;" colspan="6"><b>Others:</b></td>
                </tr>
                <tr>
                    <td valign="top" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border:1px solid black; height:70px;" colspan="6">&nbsp;</td>
                </tr>
            </table>
        </td>
        </tr>
        </table>
        <table cellpadding="4" cellspacing="0" width="100%" style="border:1px solid black; margin-top:-1px;">
        <tr>
        <td width="50%" style="border-right:1px solid black;">
            <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; text-transform:uppercase;">LIFE HISTORY DATA</h4>
        <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px;">
        <tr>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">Sex:</td>
        <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">
            <cfif isdefined('form.unknowns')>
                    <input type="Checkbox"   name="unknowns" checked> <label for="">Unknown</label>
            <cfelse>
                    <input type="Checkbox"   name="unknowns" ><label for="">Unknown</label>
            </cfif>
            </td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">
            <cfif isdefined('form.males')>
                    <input type="Checkbox"   name="males" checked> <label for="">Male</label>
            <cfelse>
                    <input type="Checkbox"   name="males" ><label for="">Male</label>
            </cfif>
            </td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">
            <cfif isdefined('form.females')>
                    <input type="Checkbox"   name="females" checked> <label for="">Female</label>
            <cfelse>
                    <input type="Checkbox"   name="females" ><label for="">Male</label>
            </cfif>
            </td>
            </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px;">
            <tr>
                <td width="80" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Identity Code:</b></td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">
            <cfif isdefined('form.idcode')>
                                                    #idcode#
                                                </cfif>
            </td>
            </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px; padding-top:4px;">
            <tr>
                <td width="100" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Age (or age class):</b></td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">
            <cfif isdefined('form.ageorglass')>
                                                	#form.ageorglass#
                                                </cfif>
            </td>
            </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px; padding-top:4px;">
            <tr>
                <td width="80" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Home Range:</b></td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">
            <cfif isdefined('form.homerange')>
                                                	#form.homerange#
                                                </cfif>
            </td>
            </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px; padding-top:4px;">
            <tr>
                <td width="240" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Year identified and Number of Sightings:</b></td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">
            <cfif isdefined('form.sightingsnumb')>
                                                	#form.sightingsnumb#
                                                </cfif>
            </td>
            </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px; padding-top:4px;">
            <tr>
                <td width="220" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;"><b>Date of Last Sighting without Incident:</b></td>
            <td  style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">
            <cfif isdefined('form.lastsight')>
                                                    #form.lastsight#
                                                </cfif>
            </td>
            </tr>
            </table>
            </td>
            <td width="50%" valign="top">
                <h4 style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; text-transform:uppercase;">Determinations:</h4>
            <table cellpadding="0" cellspacing="0" width="100%" style="padding-bottom:4px;">
            <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-bottom:4px;" colspan="2">
            <cfif #form.followup# eq 1>
                    <input type="checkbox" class="form-control  accession" name="followup" checked>
            <cfelse>
                    <input type="checkbox" class="form-control  accession" name="followup">
            </cfif>
                <label for="">Follow-Up needed?: </label>
            </td>
            </tr>
            <tr>
            <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black;">
            <cfif #form.noaa# eq 1>
                    <input type="checkbox" class="form-control  accession" name="noaa" checked>
            <cfelse>
                    <input type="checkbox" class="form-control  accession" name="noaa">
            </cfif>
                NOAA MMHSRP accession number assigned?: #form.accession#

            </td>
                <td width="100" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border-bottom:1px solid black;">
                    &nbsp;
                </td>
            </tr>
                <tr>
                    <td style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; padding-top:4px; padding-bottom:4px;" colspan="2"><b>Other notes:</b></td>
                </tr>
            <tr>
            <td colspan="2" valign="top" style="font-size:10px; font-family:Arial, Helvetica, sans-serif; color:black; border:1px solid black; height:70px;" colspan="2"><cfif isdefined('form.determnotes')>#form.determnotes#</cfif></td>
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

