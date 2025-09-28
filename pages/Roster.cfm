<cfif not structKeyExists(session,"TeamSeasonId")>
	<cflocation url="index.cfm">
</cfif>
<cfinclude template="includes/headers/Header.cfm">
<cfparam name="url.GameId" default="1">
<cfparam  name="url.showMore" default="25">
<cfparam name="url.PlayerId" default="1" >
<cfparam name="url.Action" default="" >
<cfparam name="url.SortField" default="Total_Points">
<cfparam name="url.SortOrder" default="Desc">
<cfparam name="form.FilterDateStart" default="#session.StartOfSeason#">
<cfparam name="form.FilterDateEnd" default="#session.EndOfSeason#">
<cfparam name="form.MinGoalScored" default="0">
<cfparam name="form.TournamentId" default="">
<cfparam name="form.RankingId" default="0">
	
	
<cfif isDefined("url.FilterDateStart")>
	  <cfset form.FilterDateStart=url.FilterDateStart>
</cfif>	
<cfif isDefined("url.FilterDateStart")>
	  <cfset form.FilterDateEnd=url.FilterDateEnd>
</cfif>	
<cfif isDefined("url.TournamentId") and len(url.TournamentId)>
<cfset form.TournamentId=url.TournamentId>	
</cfif>
<cfif isDefined("url.RankingId")>
<cfset form.RankingId=url.RankingId>
</cfif>
	
	<cfif IsDefined("form.TournamentId") and len(form.TournamentId)>
		<cfquery datasource="hockeyStats" name="qTournament">
			Select TournamentId,TournamentName,StartDate,EndDate from tblTournament 
			where TeamId=#session.TeamId#
			and   TournamentId=<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.TournamentId#">
		</cfquery>
			
		<cfif qTournament.recordcount>
			<cfset form.FilterDateStart=qTournament.StartDate>
			<cfset form.FilterDateEnd =qTournament.EndDate>
		</cfif>
	
	</cfif>
<div class="content">
	
	<cfoutput>
		<div class="PageHeader">
 #session.TeamName#  - Roster
		</div>

	</cfoutput>
	<cf_FormFilter ActionPagName="Roster.cfm" 
				   ActionQueryString="" 
				   FilterDateStart="#form.FilterDateStart#" 
				   FilterDateEnd="#form.FilterDateEnd#"
				   MinGoalScored="#form.MinGoalScored#"
				   MinGoalScoreOn="false"
				   FilterByTournamentOn="True"
				   TournamentId="#form.TournamentId#"
				   RankingId="#form.RankingId#"
				>
				  
	
			<cf_DisplayGoalSummary  GameId="All" 
									showMore="#url.showMore#" 
									SortOrder="#url.SortOrder#" 
									SortField="#url.SortField#" 
									PageName="Roster.cfm" 
									DetailsPage="PlayerDetail.cfm" 
								    StartGameDate="#form.FilterDateStart#" 
								    EndGameDate="#form.FilterDateEnd#" 
								   TournamentId="#form.TournamentId#"
								   RankingId="#form.RankingId#"  
								   >
</div>				
<cfinclude template="includes/footers/Footer.cfm">