<HTML>
    <HEAD>
    <TITLE>Bit.ly</TITLE>
    </HEAD>
    <BODY>
    <!--- cp = ["Charlie", "Parker"]; --->
  
<!--- Nouman --->
    <!--- <cfhttp url="https://open-api.tiktok.com/oauth/access_token/" method="get" result="results">
        <cfhttpparam type="formField" name="client_key" value="aww2i99e55jonvz7" />
        <cfhttpparam type="formField" name="client_secret"   value="f54fe48d70ed3e44ca8528b15499dbc5"/>
        <cfhttpparam type="formField" name="grant_type" value="authorization_code" />
        <cfhttpparam type="formField" name="code" value="Vxquc8ySA6qVzoMa5BkI-qQjg19JJJbOirgtMwF_WS3ONXOEDBYoExBZaxL62kMMOfbITuGJrfi_-KAp5dU0WRkVol8sz_61dA3r1ne9Ji8*1!5888" />
 
    </cfhttp> --->

    <!--- <cfhttp url="https://open-api.tiktok.com/oauth/refresh_token/" method="get" result="results">
        <cfhttpparam type="formField" name="client_key" value="aww2i99e55jonvz7" />
        <cfhttpparam type="formField" name="grant_type" value="refresh_token" />
        <cfhttpparam type="formField" name="refresh_token" value="rft.510905300aedec4812a4a454fc38f8b7va57qDFBqvnWCId5IG8TLsZ4umrm!5946" />
       
    </cfhttp> --->

    <!--- for revoke --->
    <!--- <cfhttp url="https://open-api.tiktok.com/oauth/revoke/" method="post" result="results">
        <cfhttpparam type="formField" name="open_id" value="_000UzrQQEwwVt-TUC1qJmECua2OourkeexE" />
        <cfhttpparam type="formField" name="access_token" value="act.aacc57aba4a691d98f9875f94ea3eedfwpC9skO2I2sITxYBF9d4kcKXqpP5!5925" />    

    </cfhttp> --->
 <cfset data = {    
     "domain": "bit.ly",
     "long_url": "https://dev.offrs.com/yasir/igapp/test.cfm"
}>

    <cfhttp url="https://api-ssl.bitly.com/v4/shorten" method="POST" result="results">
        <cfhttpparam type="header" name="Authorization" value="Bearer d4c5d1e21f00acde7cc16694479c3243d9c6a610" />
        <cfhttpparam type="header" name="Content-Type" value="application/json" />
        <cfhttpparam type="body" value="#serializeJSON(data)#" />
        <!--- <cfhttpparam type="formField" name="long_url" value="http://taskmania.techleadz.com/common_actions/view_day_plan" />
        <cfhttpparam type="formField" name="domain" value="bit.ly"/>     
        <cfhttpparam type="formField" name="group_guid" value="Ba1bc23dE4F"/>  --->
     
    </cfhttp>
    <cfdump var="#results.Filecontent#" abort="true"> 
  

    </BODY>
    </HTML>
    <!--- https://pstgm.com/tiktok/callback.cfm?code=Vxquc8ySA6qVzoMa5BkI-qQjg19JJJbOirgtMwF_WS3ONXOEDBYoExBZaxL62kMMOfbITuGJrfi_-KAp5dU0WRkVol8sz_61dA3r1ne9Ji8*1!5888&scopes=user.info.basic&state=cors --->

    <!--- {"data":{"access_token":"act.6661c827d5d1dabfeed606bbd4b20730y34qJjZ6o2KgKe2NWqPHoKCD9Q8Y!5889","captcha":"","desc_url":"","description":"","error_code":0,"expires_in":86400,"log_id":"2022070414475201000400500600304127E01B2F","open_id":"_000UzrQQEwwVt-TUC1qJmECua2OourkeexE","refresh_expires_in":31536000,"refresh_token":"rft.510905300aedec4812a4a454fc38f8b7va57qDFBqvnWCId5IG8TLsZ4umrm!5946","scope":"user.info.basic"},"message":"success"} --->

    <!--- {"data":{"access_token":"act.6661c827d5d1dabfeed606bbd4b20730y34qJjZ6o2KgKe2NWqPHoKCD9Q8Y!5889","captcha":"","desc_url":"","description":"","error_code":0,"expires_in":86400,"log_id":"202207041449010100020077350020331A373F7D","open_id":"_000UzrQQEwwVt-TUC1qJmECua2OourkeexE","refresh_expires_in":31535931,"refresh_token":"rft.510905300aedec4812a4a454fc38f8b7va57qDFBqvnWCId5IG8TLsZ4umrm!5946","scope":"user.info.basic"},"message":"success"} --->