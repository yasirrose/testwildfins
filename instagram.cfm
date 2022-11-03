<html>
    <head>
        <title>Instagram Scrape</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    </head>
    
    <body class="container">
        <div>
            <h3>Instagram Scrape</h3>
        </div>
        <div>
            <form method="POST" action="#" name="insta" id="insta">
                <div class="form-group row">
                    <label for="inputEmail3" class="col-sm-3 col-form-label">Enter Instagram Username</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <button type="submit" name="submit" class="btn btn-primary">Get Metadata</button>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
<cfsetting requestTimeOut = "9000" />

<!--- <cfinclude template="../image/test.cfm"> --->

<cfif isDefined('form.submit')>
    
    <cfhttp url="https://www.instagram.com/#form.username#" method="get">    
        <cfhttpparam type="header" name="Cookie" value="ig_did=1FDD0F1A-3D64-45B9-A41B-F3F495E98F27; mid=Yp3GKAALAAHvqpnqLFELaOsqvhTH; datar=rgIBYt5CsBvqbw0JNKvoHgqp; csrftoken=4sEevzfFZHm4REl8yO9XwZtWrZKg8slt; ig_nrcb=1; rur=""ODN\05442426764964\0541686043164:01f75a0a5d558bc9c6149653241b35cfc7c1be06674213e24a774564a1322ac69642d7cd""; ds_user_id=42426764964; sessionid=42426764964%3ASWYJztCEWkIH1v%3A22">
    </cfhttp>

    <!--- <cfhttp url="https://www.instagram.com/#form.username#" method="get">    
        <cfhttpparam type="header" name="Cookie" value="ig_did=95456186-C405-4986-B534-820C8A05A0A2; mid=YCEPHgALAAEpKM3UdCW9sromknmF; ds_user_id=42426764964; csrftoken=HPtqim7feeT0OjjKfgx6Tc3BmmrYrgIb; sessionid=42426764964%3Ao9vyhXxSF8Gf1Z%3A2">
    </cfhttp> --->
<!--- 
    <cfhttp url="https://www.instagram.com/p/CWTCI0QIf28/" method="get">
        <cfhttpparam type="header" name="Cookie" value="ig_did=95456186-C405-4986-B534-820C8A05A0A2; mid=YCEPHgALAAEpKM3UdCW9sromknmF; ds_user_id=42426764964; csrftoken=HPtqim7feeT0OjjKfgx6Tc3BmmrYrgIb; sessionid=42426764964%3Ao9vyhXxSF8Gf1Z%3A2">
    </cfhttp>
    <cfhttp url="https://www.instagram.com/graphql/query/?query_hash=ed2e3ff5ae8b96717476b62ef06ed8cc&variables=%7B%22fetch_suggested_count%22%3A30%2C%22include_media%22%3Afalse%7D" method="get">
        <cfhttpparam type="header" name="Cookie" value="ig_did=95456186-C405-4986-B534-820C8A05A0A2; mid=YCEPHgALAAEpKM3UdCW9sromknmF; ds_user_id=42426764964; csrftoken=HPtqim7feeT0OjjKfgx6Tc3BmmrYrgIb; sessionid=42426764964%3Ao9vyhXxSF8Gf1Z%3A2">
    </cfhttp> --->

    


    <cfdump var="#cfhttp#" abort="false">
        
    <cfset metaKeyword = 'property="og:description"'>
    <cfset metaKeywordStart = FindNoCase(metaKeyword, cfhttp.filecontent)>
    <cfif #metaKeywordStart# neq 0>
        <cfset metaKeywordEnd = FindNoCase('/>', cfhttp.filecontent, metaKeywordStart)>
        <cfset data = "#mid(cfhttp.filecontent, metaKeywordStart, (metakeywordEnd-metaKeywordStart))#}">
        <br>
        <br>
        <cfdump var="#data#">
        <cfset metaKeyword = 'property="og:title"'>
        <cfset metaKeywordStart = FindNoCase(metaKeyword, cfhttp.filecontent)>
        <cfset metaKeywordEnd = FindNoCase('/>', cfhttp.filecontent, metaKeywordStart)>
        <cfset data = "#mid(cfhttp.filecontent, metaKeywordStart, (metakeywordEnd-metaKeywordStart))#}">
        <br>
        <br>
        <cfdump var="#data#">
        <cfset metaKeyword = 'property="og:image"'>
        <cfset metaKeywordStart = FindNoCase(metaKeyword, cfhttp.filecontent)>
        <cfset metaKeywordEnd = FindNoCase('/>', cfhttp.filecontent, metaKeywordStart)>
        <cfset data = "#mid(cfhttp.filecontent, metaKeywordStart, (metakeywordEnd-metaKeywordStart))#}">
        <br>
        <br>
        <cfdump var="#data#">
        <cfset metaKeyword = 'property="og:type"'>
        <cfset metaKeywordStart = FindNoCase(metaKeyword, cfhttp.filecontent)>
        <cfset metaKeywordEnd = FindNoCase('/>', cfhttp.filecontent, metaKeywordStart)>
        <cfset data = "#mid(cfhttp.filecontent, metaKeywordStart, (metakeywordEnd-metaKeywordStart))#}">
        <br>
        <br>
        <cfdump var="#data#">
        <cfset metaKeyword = 'property="og:url"'>
        <cfset metaKeywordStart = FindNoCase(metaKeyword, cfhttp.filecontent)>
        <cfset metaKeywordEnd = FindNoCase('/>', cfhttp.filecontent, metaKeywordStart)>
        <cfset data = "#mid(cfhttp.filecontent, metaKeywordStart, (metakeywordEnd-metaKeywordStart))#}">
        <br>
        <br>
        <cfdump var="#data#">
        <cfset metaKeyword = '"entry_data":{'>
        <cfset metaKeywordStart = FindNoCase(metaKeyword, cfhttp.filecontent)>
        <cfset metaKeywordEnd = FindNoCase(',"hostname"', cfhttp.filecontent, metaKeywordStart)>
        <cfset data = "#mid(cfhttp.filecontent, metaKeywordStart, (metakeywordEnd-metaKeywordStart))#}">
        <br>
        <br>
        <cfoutput>Shared Data: </cfoutput>
        <br>
        <cfset data = "{#data#">
        <cfdump var="#DeserializeJSON(data)#">
    <cfelse>
        <cfoutput><h3>No Record Found!!</h3></cfoutput>
    </cfif>

</cfif>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>

</script>
