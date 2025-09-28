<cfparam name="form.teamSeasonId" default="">
                <cfif len(form.teamSeasonId) EQ 0>
					<cflocation url="index.cfm">
				</cfif>
				 <cfquery name="getTeams" datasource="#Application.Datasource#">
		        	exec stpGetTeams @TeamSeasonId=#form.teamSeasonId#
                </cfquery>
		       

               <cfset session.TeamSeasonId=form.TeamSeasonId>
            	
				<cfset session.loggedIn = true>
				<cfset session.userID = "0">
				<cfset session.username = "Guest">
				<cfset session.fullName = "User">
				
				<cfset session.ShowCoachFunctions=false>
				<cfset session.ShowAdminFunctions=false>
				<cfset session.teamId=getTeams.TeamId>
				<cfset session.season=getTeams.Season>
				<cfset session.StartOfSeason=getTeams.SeasonStartDate>
				<cfset session.EndOfSeason=getTeams.SeasonEndDate>	
				<cfset session.TeamName=getTeams.TeamName>
				<cfset session.TeamSeasonId=getTeams.TeamSeasonId>
				
<cfinclude template="Games.cfm" >

