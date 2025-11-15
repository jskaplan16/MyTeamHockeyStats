<cfif not structKeyExists(session,"TeamSeasonId")>
	<cflocation url="#Application.base#index.cfm">
</cfif>
<cfinclude template="#application.includes#header.cfm">
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
<cfparam name="form.GoalTypeId" default="">
	
	
<cfset defaultFilterDateStart=session.StartOfSeason>
<cfset defaultFilterDateEnd=session.EndOfSeason>

<cfif isDefined("url.TournamentId") and len(url.TournamentId)>
	<cfset form.TournamentId=url.TournamentId>	
</cfif>

<cfif isDefined("url.RankingId")>
	<cfset form.RankingId=url.RankingId>
</cfif>  
	
	<cfif IsDefined("form.TournamentId") and len(form.TournamentId)>
		<cfquery datasource="#application.datasource#" name="qTournament">
			Select TournamentId,TournamentName,StartDate,EndDate from tblTournament 
			where TeamSeasonId=#session.TeamSeasonId#
			and   TournamentId=<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.TournamentId#">
		</cfquery>
			
		<cfif qTournament.recordcount and len(form.TournamentId) is not 0>
			<cfset form.FilterDateStart=qTournament.StartDate>
			<cfset form.FilterDateEnd =qTournament.EndDate>
		<cfelse>
			<cfset form.FilterDateStart=session.StartOfSeason>
			<cfset form.FilterDateEnd =session.EndOfSeason>
		</cfif>
		
	</cfif>
<div class="content">
	
	<cfoutput>
		<div class="PageHeader">
 #session.TeamName#  - Roster
		</div>

	</cfoutput>
	<cf_FormFilter ActionPagName="DisplayRoster.cfm" 
				   ActionQueryString="" 
				   FilterDateStart="#form.FilterDateStart#" 
				   FilterDateEnd="#form.FilterDateEnd#"
				   MinGoalScored="#form.MinGoalScored#"
				   MinGoalScoreOn="false"
				   FilterByTournamentOn="True"
				   TournamentId="#form.TournamentId#"
				   RankingId="#form.RankingId#"
				   GoalTypeId="#form.GoalTypeId#"
				>
				  
	
			<cf_DisplayGoalSummary  GameId="All" 
									showMore="#url.showMore#" 
									SortOrder="#url.SortOrder#" 
									SortField="#url.SortField#" 
									PageName="DisplayRoster.cfm" 
									DetailsPage="DisplayPlayerDetail.cfm" 
								    StartGameDate="#form.FilterDateStart#" 
								    EndGameDate="#form.FilterDateEnd#" 
								   TournamentId="#form.TournamentId#"
								   RankingId="#form.RankingId#"  
								   GoalTypeId="#form.GoalTypeId#"
								   >
</div>				
<cfinclude template="#application.includes#footer.cfm">