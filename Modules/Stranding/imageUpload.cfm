<html>
<head>
<title>Image Upload</title>
</head>
<body>
    <cfset  permissions ="#session['userdetails']['permissions']#">
<cfif permissions eq "full_access" or findNoCase("ST", permissions) neq 0>
    
    <form method="post" enctype="multipart/form-data">
        <input type="file" name="fileUpload">
        <input type="submit" value="Upload File">
      </form>

      <cfparam name="form.fileUpload" default="">
        <cfif len(trim(form.fileUpload))>
        <CFTRY>
            <!--- <cfdump var="#form.fileUpload#" abort="true"> --->

            <cffile 
            action = "upload"  
            <!--- name of input feiled name not optional --->
            fileField = "fileUpload"  
            destination = "#Application.CloudDirectory#"  
            accept="image/png,image/gif,image/jpeg,image/jpg,.png,.gif,.jpeg,.jpg"
            nameConflict = "Overwrite"
            result="fileUploaded"
            > 
            <!--- <CFSET BGFile = #fileUploaded.serverfile#> --->
            <CFCATCH type="any">
                <cfdump var="#cfcatch#" abort="true">
                <!--- <CFSET BGFile = ""> --->
            </CFCATCH>
        </CFTRY>
        <cfdump var="#fileUploaded#" abort="true">
        </cfif>
        </cfif>

</body>
</html>