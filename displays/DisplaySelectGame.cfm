

                <cfquery name="getTeams" datasource="#Application.Datasource#">
                Select TeamSeasonId,TeamName,BirthYear,TeamId,SeasonStartDate,SeasonEndDate from vTeam 
				where TeamSeasonId=#form.teamSeasonId#
                </cfquery>

            

                                    
                               

                <cfset session.loggedIn = true>
				<cfset session.userID = "Anonymous">
				<cfset session.username = "Guest">
				<cfset session.fullName = "User">
				<cfset session.ShowCoachFunctions=false>
				<cfset session.ShowAdminFunctions=false>
				<cfset session.teamSeasonId=getTeams.TeamSeasonId>
				<cfset session.StartOfSeason=getTeams.SeasonStartDate>
				<cfset session.EndOfSeason=getTeams.SeasonEndDate>	
				<cfset session.TeamName=getTeams.TeamName>
			
<cfinclude template="#Application.Displays#DisplayGames.cfm">

