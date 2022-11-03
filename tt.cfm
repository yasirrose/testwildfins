<cftry>

<cfmail from="Noreply@domain.com" to="tldz.dev1@gmail.com" server="SMPT"  subject="Reset Password"  type="html">
Hello,
<p>
Your New login Passowrd is  <a href="http://test.wildfins.org">Harbor Branch</a>
</p>
</cfmail>
<cfcatch>
<cfdump  var="#cfcatch#">
</cfcatch>
</cftry>