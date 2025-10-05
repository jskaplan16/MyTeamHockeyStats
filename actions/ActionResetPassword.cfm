

<cfquery  datasource="#application.datasource#" name="qResetPassword">
 exec stpResetPassword @UserId=#session.userId#, @Password='#form.CONFIRMPASSWORD#'
</cfquery>
<cfif qResetPassword.isFailure is 1>
    <cfset Message=qResetPassword.Message>
    <cfinclude template="#application.pages#resetPassword.cfm">
<cfelse>
    <cfset form.userName=qResetPassword.username>
    <cfset form.password=form.CONFIRMPASSWORD>
    <cfinclude template="#application.pages#authenticate.cfm" >
</cfif>

