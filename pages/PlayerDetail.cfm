<cfif not StructKeyExists(session,"StartOfSeason")>
<cflocation url="index.cfm">
</cfif>


<cfparam name="url.GameId" default="1">
<cfparam  name="url.showMore" default="5">
<cfparam name="url.PlayerId" default="1" >
<cfparam name="url.Action" default="" >
<cfparam name="url.SortField" default="Total_Points">
<cfparam name="url.SortOrder" default="Desc">
<cfparam name="url.FilterDateStart" default="#session.StartOfSeason#">
<cfparam name="url.FilterDateEnd" default="#session.EndOfSeason#">
<cfparam name="url.RankingId" default="0">
<cfparam name="ReturnFilterPage" default="Roster.cfm">


<cfinclude template="includes/headers/Header.cfm">


<cfquery name="qGetGoals" datasource="#application.datasource#">
	exec stpGameGoalsandStats 
	@StartDate = '#url.FilterDateStart#',
	@EndDate = '#url.FilterDateEnd#'
	<cfif len(url.PlayerId)>
		,@PlayerId=#url.PlayerId#
	</cfif>

	
	<cfif len(url.Action) gt 0>
	, @FilterBy='#url.Action#' 
	</cfif>
	
	<cfif url.GameId is not "all">
	,@GameId=#url.gameId# 
	</cfif>
	,@RankingId=#url.RankingId#
</cfquery> 

<cfif len(url.action) gt 0 >
	<cfquery name="qPlayerName" datasource="#application.datasource#">
		Select PlayerName from vRoster where PlayerId=<cfqueryparam value="#url.PlayerId#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	<cfset FilteredPlayer=qPlayerName.PlayerName>

</cfif>
	

	
<cfquery dbtype="query" name="qJustGoals">
		 Select Distinct GameId,GameDate,GoalId,Period,TeamIcon,GoalTimeDisplay,GoalType,VideoURL,PeriodRow,GoalTime,PlayerNumber,PlayerName,Game,OpponentTeam,GoalLink ,OpponentTeamIcon,isReassigned,OriginalPlayerName
	from qGetGoals 
			Where StatType='Goal'
	Order by GameDate,GameId,Period,GoalTime desc
</cfquery>

<cfswitch expression="#url.action#" >
	<cfcase value="PlusMinus">
		<cfset displayFndRecords="Plus/Minus">
	</cfcase>
	<cfcase value="Goals">	
		<cfset displayFndRecords="Goal">
	</cfcase>
		<cfcase value="Points">	
		<cfset displayFndRecords="Point">
	</cfcase>
	<cfdefaultcase>
		<cfset displayFndRecords=url.action>
		</cfdefaultcase>
	
</cfswitch>


<div class="content">

				 <cfif len(url.action) gt 0>
	     <cfoutput>
	
		<table>
					<tr class="row-even">
						<td align="left" style="text-align: left;">
							 <b>Player Name:</b> #FilteredPlayer#
						</td>
						<td style="text-align: center;">
							<b>Found #qJustGoals.Recordcount# #displayFndRecords# Record(s) </b>
						</td>

						<td style="text-align: right;">
	      						<b>Filter By:</b> Filter by <cfif url.action is "PlusMinus">Plus/Minus<cfelse> #url.action# </cfif> 
							<a href="#ReturnFilterPage#?&GameId=#url.GameId#" class="mainLink" style="color: black;">[Remove Filter]</a>
						</td>
					</tr>
		 </table>
			</cfoutput>
		</cfif>	
<cfif url.GameId is not "all">
<button onclick="toggleTable();" class="table-style-btn" id="toggleButton" style="display: none;">Show Game Stats</button>
<br>
</cfif>

<div id="loader" class="loader" style="display:block;"></div>
<div id="loaderText" style="display: block;text-align:center;">Loading Videos...</div>

    <div class="table-container" id="gameGoalsContainer" style="display: none;">
        <cf_GameGoals	
            GameId="#url.GameId#" 
            filterBy="#url.Action#" 
            PlayerId="#url.PlayerId#" 
            ReturnFilterPage="Roster.cfm"
            StartGameDate="#url.FilterDateStart#"
            EndGameDate="#url.FilterDateEnd#"
            RankingId="#url.RankingId#">
    </div>
<br>
    <div class="table-container" id="videoGoalsContainer" style="display: none;border:0px;width:100%;">
        <cf_DisplayGoals 
            GameId="All" 
            filterBy="#url.Action#" 
            PlayerId="#url.PlayerId#" 
            ReturnFilterPage="Roster.cfm"
            StartGameDate="#url.FilterDateStart#"
            EndGameDate="#url.FilterDateEnd#"
            RankingId="#url.RankingId#">
    </div>
</div>

<script>
function toggleTable() {
    const loader = document.getElementById('loader');
    const container = document.getElementById('gameGoalsContainer');
    const table = document.getElementById('gameGoals');
    const button = document.getElementById('toggleButton');
    
        if (button.innerText === 'Show Game Stats') {
            table.style.display = 'table';
            container.style.display = 'block';
            button.innerText = 'Hide Game Stats';
        } else {
            table.style.display = 'none';
            container.style.display = 'none';
            button.innerText = 'Show Game Stats';
        }
       
}

onload =  function(){	
	const table = document.getElementById('videoGoalsContainer');
	const  btn = document.getElementById('toggleButton');
	const  loaderText = document.getElementById('loaderText');	
	const  loader = document.getElementById('loader');	
	// Initially hide the table
	table.style.display = 'table';
	loader.style.display = 'none';
	<cfif url.GameId is not "all">
	btn.style.display = 'block';
	btn.innerText = 'Show Game Stats';
	btn.style.display = 'none';
	</cfif>
	loader.style.display = 'none';
	loaderText.style.display = 'none';
  

}
	
</script>
<cfinclude template="includes/footers/Footer.cfm">
