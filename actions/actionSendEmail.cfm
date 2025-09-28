

<cfif isdefined("url.userName") and len(url.userName)>
    <cfset form.userName = url.userName>
</cfif> 
<cfif not isDefined(form.username)>
<cflocation url="index.cfm">
</cfif>
<cfquery name="qSendResetEmail" datasource="#application.datasource#">
    exec stpResetUserName @UserName='#form.userName#'
</cfquery>

	<cfmail 
        to="#form.userName#"
         bcc="jskaplan@gmail.com" 
        from="mailadmin@myteamhockeystats.com" subject="My Hockey Stats - Username and Password" type="html">	
		<cfoutput> 
        Please sign in with your username: #qSendResetEmail.username# <br>
        and password: #qSendResetEmail.Password# <br>

        <a href="https://www.myteamhockeystats.com/authenticate.cfm?userName=#qSendResetEmail.username#">Click here to login</a>
        Or <br>
    Use onetime magic link  <a href="https://www.myteamhockeystats.com/authenticate.cfm?userName=#qSendResetEmail.username#&MagicLink=#qSendResetEmail.OnetimeMagicLink#">Click here to automatically login</a> <br>
        
        </cfoutput>
     </cfmail>
  

     <cfinclude template="loginPage.cfm" >

     