<HTML>
    <HEAD>
    <TITLE>TiktoK</TITLE>
    </HEAD>
    <BODY>
    <!--- cp = ["Charlie", "Parker"]; --->
    <cfform>
        <label>Enter Your TiktoK Name:</label>
        <input type="test" name="name" placeholder="Enter User Tiktok name">
        <button type="submit" name="submit">Submit</button>
    </cfform>
     
    <cfif IsDefined("form.submit")>
        
      

        <!--- curl -L -X POST 'https://open-api.tiktok.com/video/list/' \
        -H 'Content-Type: application/json' \
        --data-raw '{
            "access_token": "act.1a4b9d05d9ad1a56294b93b5609cdfbdNzQgbpbUWyFNvhC9QqIvKEjuuPHn",
            "open_id": "723f24d7-e717-40f8-a2b6-cb8464cd23b4",
            "cursor": 0,
            "max_count": 10,
            "fields": ["embed_html", "embed_link", "share_count"]
            }' --->
            <cfhttp url="https://www.tiktok.com/auth/authorize/" method="post" result="results">
                <cfhttpparam type="formField" name="client_key" value="aww2i99e55jonvz7" />
                <cfhttpparam type="formField" name="response_type" value="code" />
                <cfhttpparam type="formField" name="scope" value="Create, read, update, and delete labels only" />
                <!--- <cfhttpparam type="formField" name="client_secret"   value="f54fe48d70ed3e44ca8528b15499dbc5"/> --->
                <cfhttpparam type="formField" name="redirect_uri" value="##http://test.wildfins.org/?Module=Stranding&Page=testNew##"/>
                <cfhttpparam type="formField" name="state" value="state"/>
          
              </cfhttp>

              <cfdump var="#results#" abort="true">

    </cfif>

    </BODY>
    </HTML>