<cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    <cfdump var="#form#">
    <cfscript>
        theDir=GetCurrentTemplatePath();
    </cfscript>
    <cfspreadsheet action="read" src="#theDir#" sheetname="data" name="spreadsheetData">
    <cfdump var="#data#">
<cfelse>
    <div id="content" class="content">
        <!-- begin breadcrumb -->
        <ol class="breadcrumb pull-right">
            <li><a href="javascript:;">Stranding</a></li>
            <li><a href="javascript:;">Cetacean Exam</a></li>
        </ol>
        <h3 class="text-danger">You do not have access to this page.<h3>
    </div>
</cfif>