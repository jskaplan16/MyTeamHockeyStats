<cfif isDefined("form.TeamSeasonId") and form.TeamSeasonId neq "">
    <cfset session.TeamSeasonId = form.TeamSeasonId>

    	<cfquery name="getUser" datasource="#application.datasource#">
	exec stpGetAuthenticatedUser @username = <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
                                @TeamSeasonId = <cfqueryparam value="#form.TeamSeasonId#" cfsqltype="cf_sql_integer">
		</cfquery>

   
   
				<cfset session.userID = getUser.userid>
				<cfset session.username = getUser.username>
				<cfset session.fullName = getUser.fullname>
				<cfset session.ShowCoachFunctions=getUser.ShowCoachFunctions>
				<cfset session.ShowAdminFunctions=getUser.ShowAdminFunctions>
				<cfset session.TeamId= getUser.TeamId>
				<cfset session.StartOfSeason=getUser.SeasonStartDate>
				<cfset session.EndOfSeason=getUser.SeasonEndDate>	
				<cfset session.TeamName=getUser.TeamName>
				<cfset session.FullTeamName=getUser.FullTeamName>
				<cfset session.TeamSeasonId=getUSer.TeamSeasonId>
                <cfset session.GoalDeletes=false>
				<cfset session.SeasonId=getUser.SeasonId>
				<cfset session.season=getUser.Season>
				<cfset session.FullTeamName=getUser.FullTeamName>
        <!-- Redirect to the main page or dashboard -->
        <cflocation url="Roster.cfm">
 

</cfif>