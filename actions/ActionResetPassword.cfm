

<cfquery  datasource="#application.datasource#" name="qResetPassword">
 exec stpResetPassword @UserId=#session.userId#, @Password='#form.CONFIRMPASSWORD#'
</cfquery>
<cfif qResetPassword.isFailure is 1>
    <cfset Message=qResetPassword.Message>
    <cfinclude template="resetPassword.cfm">
<cfelse>
    <cfset form.userName=qResetPassword.username>
    <cfset form.password=form.CONFIRMPASSWORD>
    <cfinclude template="authenticate.cfm" >
</cfif>

