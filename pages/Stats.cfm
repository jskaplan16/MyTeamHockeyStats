	

<cfparam  name="url.showMore" default="5">
<cfparam name="url.PlayerId" default="1" >
<cfparam name="url.Action" default="" >
<cfparam name="url.SortField" default="Total_Points">
<cfparam name="url.SortOrder" default="Desc">	
<cfparam name="url.showNavBar" default="True">
<cfparam name="url.showGoalSummary" default="True">

<cfif not isdefined("url.GameId")>
	<cflocation url="index.cfm">
</cfif> 

<cfif NOT structKeyExists(session, "userid")>
  <!--- Session expired or user not logged in --->
  <cflocation url="/loginPage.cfm" addtoken="no">
</cfif>

<cfoutput>
		<cf_header showNavBar="#url.showNavBar#">
</cfoutput>




<div class="content">
	<cfif url.gameid is not "all">
		<div align="center" style="width: 100%;padding:10px;align-items: center;">
			<cf_scorekeeper GameId="#url.GameId#">
		</div>
	</cfif>
	 
	<cfif url.ShowGoalSummary>
	<div class="table-container">
		<cf_DisplayGoalSummary gameId=#url.GameId# showMore="#url.showMore#" SortOrder="#url.SortOrder#" SortField="#url.SortField#" PageName="Stats.cfm" DetailsPage="Stats.cfm" STARTGAMEDATE="#session.StartOfSeason#" EndGameDate="#session.EndofSeason#">
	</div>
	</cfif>	
		
	



	<div class="labelfld" style="display: flex;font-size:2em;">GOALS</div>	
	<div class="table-container">
	<cf_DisplayGoals GameId="#url.gameId#" filterBy="#url.Action#" PlayerId="#url.PlayerId#" STARTGAMEDATE="#session.StartOfSeason#" EndGameDate="#session.EndofSeason#">
	</div>

	<cfif isDefined("url.GameId")>
	<div class="labelfld" style="display: flex;font-size:2em;">PENALTIES</div>
	  <div class="table-container">
			<cf_DisplayPenalty GameId="#url.GameId#" showEdit="false">
	 </div>
	</cfif>
	

</div>
