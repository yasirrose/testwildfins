 <cfquery name="deletedoltran" datasource="#application.dsn#" result="trans">
        delete from DOLPHIN_INTERACTIONS
    </cfquery>
    <cfquery name="deletebiopsy" datasource="#Application.dsn#" result="deltdolphin">
        DELETE from DOLPHINS
    </cfquery>

   <cfif #deltdolphin.recordcount# gte 1 or #trans.recordcount# gte 1>
       <CFSET session.delete=1>
       <cflocation url="http://test.wildfins.org/?Module=StaticData&Page=dolphinimport">
  <cfelse>
       <h1 style="text-align:center">Data is empty</h1>
   </cfif>



 