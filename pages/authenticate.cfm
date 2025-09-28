<!-- authenticate.cfm -->
<cfparam name="passwordMatch" default="false">
<cfparam name="form.username" default="">
<cfparam name="form.password" default="">

<cfif len(form.username)>
	<cfset form.username = trim(form.username)>
<cfelseif isDefined("url.username") and len(url.username)>
	<cfset form.username = url.username>
</cfif>

		<cfif isDefined("url.MagicLink")>
			<cfset form.username=url.username>
		</cfif>

		<cfquery name="getUser" datasource="#application.datasource#">
	exec stpGetAuthenticatedUser @username = '#form.username#' 
		</cfquery>

	<cfset session.getUser = getUser>


<cfparam name="ErrorMsg" default=""> 

<!-- Hash the password entered by the user -->
<cfset enteredPassword = form.password>

<cfif isDefined("url.MAGICLINK") and getUser.OnetimeMagicLink eq url.MagicLink>
				<cfset enteredPassword = getUser.password>
</cfif>



	

	<cfset session.getUser = getUser>

<!-- Query the database for the username -->
<cfif isDefined("form.userName") and  len(form.username)> 
		
		
			
							
					


			<cfif isDefined("getUser.password") >
				<cfset storedPassword = getUser.password>

				<cfif storedPassword is enteredPassword> 
					<cfset passwordMatch = true>
				<cfelse>
					<cfset passwordMatch = false>
				</cfif> 
			</cfif>


					<cfif passwordMatch and  getUser.ResetPassword>
							<!-- User needs to reset password -->
							<cfset session.loggedIn = false>
							<cfset session.userID = getUser.userid>

							<cfset ErrorMsg = "You must reset your password before logging in.">
							<cfinclude template="#application.pages#resetPassword.cfm">
							
							<cfabort >
						</cfif>

<!-- Check if user exists and password matches -->
				<cfif isDefined("getUser") and getUser.recordCount eq 1 and passwordMatch>
					<!-- Verify password using hash comparison -->
		


				<!-- Passwords match, set session variables -->
						<cfset session.loggedIn = true>
						<cfset session.userID = getUser.userid>
						<cfset session.username = getUser.username>
						<cfset session.fullName = getUser.fullname>
						<cfset session.ShowCoachFunctions=getUser.ShowCoachFunctions>
						<cfset session.ShowAdminFunctions=getUser.ShowAdminFunctions>
						<cfset session.TeamId= getUser.TeamId>
						<cfset session.StartOfSeason=getUser.SeasonStartDate>
						<cfset session.EndOfSeason=getUser.SeasonEndDate>	
						<cfset session.TeamName=getUser.TeamName>
						<cfset session.TeamSeasonId=getUSer.TeamSeasonId>
						<cfset session.SeasonId=getUser.SeasonId>
						<cfset session.FullTeamName=getUser.FullTeamName>
						<cfset session.season=getUser.Season>
			
						

						<cfset session.GoalDeletes=false>
						<!-- Redirect to the protected page -->
						<cflocation url="#application.displays#Displaygames.cfm">

		
			<cfelseif isDefined("getUser")  and getUser.RecordCount gte 1 and passwordMatch>	
			
				<cfset session.userId = getUser.userId>
				<cfset session.username = getUser.username>
			    <cfset session.loggedIn = true>
			
				

				<cfinclude template="#application.displays#DisplayMultiTeam.cfm">
				<cfabort>
			</cfif>
		<cf_loginPage ErrorMsg="Login Failed" username="#form.username#">		
<cfelseif not passwordMatch>
	
							<!-- Invalid password -->
							<cftry>
								<cfquery name="qUser" datasource="#application.datasource#">
							exec stpLoginAttempts @UserName=<cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
												@Password=<cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
							</cfquery>

							<cfcatch>
									<!--- caught error ---->
									</cfcatch>
							</cftry>
						
					<!-- User not found -->
				
		<cf_loginPage ErrorMsg="" username="#form.username#">	

<cfelse>
	<cf_loginPage ErrorMsg="#ErrorMsg#">		
</cfif>

<cfif isDefined("SessionExpired") and SessionExpired>

	<div> You have been inactive too long. Please login again.</div>
	<cf_loginPage ErrorMsg="#ErrorMsg#">

</cfif>	


		
	
