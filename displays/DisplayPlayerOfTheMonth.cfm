<cfquery datasource="#Application.Datasource#" name="qBestOf">
		 exec [dbo].[stpGetPlayerOfTheMonth]  @TeamId=#session.teamId#
</cfquery>


<cfquery dbType="query" name="qBestAllaround">
	Select
	EOMDATE,
	PlayerNumber,
	PlayerName,
	Goals,
	GoalsRow,
	Assists,
	AssistsRow,
	PlusMinus,
	PlusMinusRow,
	TotalRank,
	GamesPlayed
	from qBestOf 
	where 	TotalRankRow=1 
	Order by EOMDATE DESC
</cfquery>

<div align="left">
	<div style="padding: 5px;">
<b>Top Overall Player By Month</b>
	</div>
	<table class="table-responsive">
		<tr>
			<th>
			Month
			</th>
			<th>
			Games Played
			</th>

			<th>
			Player Name
			</th>
			
			<th>
			Goals Rank
			</th>
			<th>
			Assists Rank
			</th>
			<th>
			Plus/Minus Rank
			</th>
			
			<th>
			Rank Score
			</th>
		</tr>
	<cfoutput query="qBestAllaround">	
		<tr class="<cfif qBestAllaround.currentRow mod 2>row-even<cfelse>row-odd</cfif>">
			<td class="nav-cell-small">
			#EOMDate#
			</td>	
			<td class="nav-cell-small">
			#GamesPlayed#
			</td>
			<td class="nav-cell-left">
			#PlayerNumber# - #PlayerName#
			</td>
			<td class="nav-cell-small">
			 #GoalsRow# (#Goals#)
			</td>
			<td class="nav-cell-small">
			#AssistsRow# (#Assists#)
			</td>
		<td class="nav-cell-small">
			#PlusMinusRow# (#PlusMinus#)
			</td>
			<td class="nav-cell-small">
			#TotalRank#
			</td>
		</tr>	
	</cfoutput>
	</table>
</div>


<cfquery dbType="query" name="qBestGoals">
	Select
	EOMDATE,
	PlayerNumber,
	PlayerName,
	Goals,
	GamesPlayed
	from qBestOf 
	where 	GoalsRow=1 
	Order by EOMDATE DESC
</cfquery>


<div align="left">
	<div style="padding: 5px;">
<b>Top Goal Scorer By Month</b>
	</div>
		<table class="table-responsive">
		
		<tr>
			<th>
			Month
			</th>
			<th>
			Game Played
			</th>

			<th>
			Player Name
			</th>
			<th>
			Goals
			</th>
		</tr>
	<cfoutput query="qBestGoals">	
		<tr class="<cfif qBestGoals.currentRow mod 2>row-even<cfelse>row-odd</cfif>">
			<td class="nav-cell-small">
			#EOMDate#
			</td>	
			<td class="nav-cell-small">
			#GamesPlayed#
			</td>
			
			<td class="nav-cell-left">
			###PlayerNumber# - #PlayerName#
			</td>
			<td class="nav-cell-small">
			#Goals#
			</td>
		</tr>	
	</cfoutput>
	</table>
</div>
<br>
<cfquery dbType="query" name="qBestAssists">
	Select
	EOMDATE,
	PlayerNumber,
	PlayerName,
	Assists,
	GamesPlayed
	from qBestOf 
	where 	AssistsRow=1 
	Order by EOMDATE DESC
</cfquery>

<div align="left">
	<div style="padding: 5px;">
<b>Top Assistor By Month</b>
	</div>
	<table class="table-responsive">
		<tr>
			<th>
			Month
			</th>
			<th>
			Games Played
			</th>
			<th>
			Player Name
			</th>
			<th>
			Assists
			</th>
		</tr>
	<cfoutput query="qBestAssists">	
		<tr class="<cfif qBestAssists.currentRow mod 2>row-even<cfelse>row-odd</cfif>">
			<td class="nav-cell-small">
			#EOMDate#
			</td>	
			<td class="nav-cell-small">
			#GamesPlayed# 
			</td>
			<td class="nav-cell-left">
			#PlayerNumber# - #PlayerName#
			</td>
			<td class="nav-cell-small">
			#Assists#
			</td>
		</tr>	
	</cfoutput>
	</table>
</div>


<br>
<cfquery dbType="query" name="qBestPlusMinus">
	Select
	EOMDATE,
	PlayerNumber,
	PlayerName,
	PlusMinus,
	GamesPlayed
	from qBestOf 
	where 	PlusMinusRow=1 
	Order by EOMDATE DESC
</cfquery>

<div align="left">
	<div style="padding: 5px;">
<b>Top Plus/Minus By Month</b>
	</div>
	<table class="table-responsive">
		<tr>
			<th>
			Month
			</th>
			<th>
			Games Played
			</th>
			<th>
			Player Name
			</th>
			<th>
			Plus/Minus
			</th>
		</tr>
	<cfoutput query="qBestPlusMinus">	
		<tr class="<cfif qBestPlusMinus.currentRow mod 2>row-even<cfelse>row-odd</cfif>">
			<td class="nav-cell-small">
			#EOMDate#
			</td>	
			<td class="nav-cell-small">
			#GamesPlayed#
			</td>
			<td class="nav-cell-left">
			#PlayerNumber# - #PlayerName#
			</td>
			<td class="nav-cell-small">
			#PlusMinus#
			</td>
		</tr>	
	</cfoutput>
	</table>
</div>

<br>






