	
<cfparam name="url.GameId">
<cfparam  name="url.showMore" default="5">
<cfparam name="url.PlayerId" default="1" >
<cfparam name="url.Action" default="" >
<cfparam name="url.SortField" default="Total_Points">
<cfparam name="url.SortOrder" default="Desc">	
<cfparam name="url.showNavBar" default="True">
<cfparam name="url.showGoalSummary" default="True">
<cfoutput>
<cf_header showNavBar="#url.showNavBar#">
</cfoutput>

	<div class="statsWrapper" style="border: 2px solid black;background-color:antiquewhite;padding-bottom:5px;">

<cfif url.gameid is not "all">
	<cf_scorekeeper GameId="#url.GameId#">

	</cfif>

	<cfif url.ShowGoalSummary>
		<cf_DisplayGoalSummary gameId=#url.GameId# showMore="#url.showMore#" SortOrder="#url.SortOrder#" SortField="#url.SortField#" PageName="Stats.cfm" DetailsPage="Stats.cfm" STARTGAMEDATE="#session.StartOfSeason#" EndGameDate="#session.EndofSeason#">
	</cfif>	
</div>
<br>

<div class="statsWrapper" style="border: 2px solid black;background-color:antiquewhite;">	
	<cf_DisplayGoals GameId="#url.gameId#" filterBy="#url.Action#" PlayerId="#url.PlayerId#" STARTGAMEDATE="#session.StartOfSeason#" EndGameDate="#session.EndofSeason#">
</div>


			<cfif isDefined("url.GameId")>
		<cf_DisplayPenalty GameId="#url.GameId#">
			</cfif>


<cfinclude template="#application.includes#Footer.cfm">

