<cftry>
<cfset mailServer = "smtp.sendgrid.net">
<cfset mailPort = "587"> <!-- Use 465 for SSL -->
<cfset mailUsername = "apikey"> <!-- Keep this as "apikey" -->
<cfset mailPassword = "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">
<cfset fromEmail = "no-reply@spotternet.com">
<cfset toEmail = "tldz.dev12@gmail.com">

<cfmail 
    to="#toEmail#"
    from="no-reply@spotternet.com"
    subject="Test Email from ColdFusion via SendGrid"
    type="html"
    server="smtp.sendgrid.net"
    port="587"
    username="apikey"
    password="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"
    useTLS="true"
>
<html>
    <head>
        <style>
            body { font-family: Arial, sans-serif; color: ##333; }
            .container { padding: 20px; background-color: ##f4f4f4; border-radius: 10px; width: 80%; margin: auto; }
            h2 { color: ##0073e6; }
            p { font-size: 14px; }
            a { color: ##0073e6; text-decoration: none; font-weight: bold; }
            .footer { margin-top: 20px; font-size: 12px; color: ##777; }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Password Reset Request</h2>
            <p>Hello,</p>
            <p>Your new login password is <strong>2415454</strong>.</p>
            <p>You can log in to your account by clicking the link below:</p>
            <p><a href="http://test.wildfins.org" target="_blank">Harbor Branch Login</a></p>
            <p>If you did not request this, please contact support immediately.</p>
            <div class="footer">
                <p>Best regards,<br>Harbor Branch Support Team</p>
            </div>
        </div>
    </body>
    </html>
</cfmail>

<cfoutput>
    <p>Email sent to: #toEmail#</p>
</cfoutput>
<cfcatch type="any">
    <!-- Error Handling -->
    <cfoutput>
        <p style="color: red;"><strong>Error Sending Email:</strong> #cfcatch.message#</p>
        <p><strong>Detail:</strong> #cfcatch.detail#</p>
        <p><strong>Stack Trace:</strong> <br> #cfcatch.stackTrace#</p>
    </cfoutput>
</cfcatch>

</cftry>