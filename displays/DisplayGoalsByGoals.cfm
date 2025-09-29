
<cfparam name="attributes.filterBy" default="">
<cfparam name="attributes.goalList" default="">
<cfparam  name="FilteredPlayer" default="">
<cfparam name="attributes.gameId" default="">
<cfparam name="attributes.ReturnFilterPage" default="Groups.cfm">
<cfparam name="attributes.ShowGame" default="False">
<cfquery name="qGetGoals" datasource="#application.datasource#">
	exec [stpGameGoalsandStatsByGoals] 
			@GoalList='#attributes.goalList#'
</cfquery> 
<cfquery dbtype="query" name="qJustGoals">
		 Select Distinct GameDate,GoalId,Period,TeamIcon,GoalTimeDisplay,GoalType,VideoURL,PeriodRow,GoalTime,PlayerNumber,PlayerName,Game,OpponentTeam,GoalLink ,OpponentTeamIcon
	from qGetGoals 
			Where StatType='Goal'
	Order by GameDate,GameId,Period,GoalTime desc
</cfquery>

 <cfif len(attributes.filterBy) gt 0>
	     <cfoutput>
		<table class="table-container" border="0" style="border: 1px solid black;float: left;">

					<tr>
						<td align="left" style="text-align: left;">
						 <b>Player Name:</b> <cfif FilteredPlayer is "">#qPlayerName.PlayerName#<cfelse>#FilteredPlayer#</cfif>
						</td>
						<td style="text-align: right;">
	      						<b>Filter By:</b> Filter by <cfif attributes.filterBy is "PlusMinus">Plus/Minus<cfelse>test #attributes.filterBy# </cfif> 
							<a href="#attributes.ReturnFilterPage#?&GameId=#attributes.GameId#" class="mainLink" style="color: black;">[Remove Filter]</a>
						</td>
					</tr>
					 <tr>
						<td colspan="2" align="center" style="font-size: 25px;text-align: center;width: 100%;">
							<b>Found #qJustGoals.Recordcount# #attributes.filterBy# Records </b>
						 </td>			 
		  			</tr>
			 </table>
		</cfoutput>
</cfif>						

	<table class="table-container" style="width: 100%; border-collapse: collapse;" cellspacing="0">
		<thead>
			<tr>
				<th style="text-align: center; padding: 10px; background-color: var(--primary-blue); color: white;">Game</th>
				<th style="text-align: center; padding: 10px; background-color: var(--primary-blue); color: white;">Team</th>
				<th style="text-align: center; padding: 10px; background-color: var(--primary-blue); color: white;">Period/Time</th>
				<th style="text-align: center; padding: 10px; background-color: var(--primary-blue); color: white;">Players</th>
				<th style="text-align: center; padding: 10px; background-color: var(--primary-blue); color: white;">Video</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="qJustGoals">
				
				<cfoutput>			

				<cfif qJustGoals.currentRow  mod 2> 
				<cfset classValue="Row-Even">
						<cfelse>
				<cfset classValue="Row-Odd">
				</cfif>	
							
							
				<tr>
					<td align="center" class="#classValue#" style="vertical-align: top; padding: 10px;">
						<cfif (attributes.GameId is "all") OR (Attributes.showGame)>
							<a href="stats.cfm?GameId=#attributes.GameId#" class="mainLink" style="color: black;text-decoration: underline;">#Game#</a>
							<br>#GameDate#</cfif>
					</td>
					<td class="#classValue#" style="text-align: center; vertical-align: top; padding: 10px;">
						<img src="#application.icons##TeamIcon#" width="75">
					</td>

<cfquery dbtype="query" name="qStatsAssist">
		 Select Distinct GoalId,Period,TeamIcon,GoalTimeDisplay,GoalType,VideoURL,PeriodRow,GoalTime,PlayerNumber,PlayerName from qGetGoals 
			Where StatType='Assist'
			and GoalId=#qJustGoals.GoalId#
	Order by StatDisplayOrder
</cfquery>

<cfquery dbtype="query" name="qStatsPlusMinus">
		 Select Distinct GoalId,Period,TeamIcon,GoalTimeDisplay,GoalType,VideoURL,PeriodRow,GoalTime,PlayerNumber,PlayerName,StatType from qGetGoals 
			Where StatType in('Plus','Minus')
			and GoalId=#qJustGoals.GoalId#
	Order by StatDisplayOrder
</cfquery>					
				
					<td class="#classValue#" style="vertical-align: top; padding: 10px;">
						Period: #Period# <br/>
						Time: #GoalTimeDisplay#
						<div style="border:1px solid black; padding: 3px; text-align: center; margin-top: 5px;"> 
							#GoalType#
						</div>
					</td>
					<td class="#classValue#" style="width: 250px; vertical-align: top; padding: 10px;">
	
	<b>Scored By:</b> 
		<cfif FilteredPlayer is PlayerName and ListContains("Goals,Points",attributes.filterBy,",") gt 0 >
				<span class="highlight">
			###playerNumber# - #PlayerName#					
			</span>
			<cfelse>
		<span>###playerNumber# - #PlayerName#</span>
	     </cfif> 

			
					<cfif qStatsAssist.PlayerNumber is not ""> <b>Assisted by:</b> <br>
						<cfloop query="qStatsAssist">
							<cfif FilteredPlayer is qStatsAssist.PlayerName and ListContains("Assists,Points",attributes.filterBy,",")>
								<span class="highlight">
							###qStatsAssist.PlayerNumber# - #qStatsAssist.PlayerName# 
								</span>
							<cfelse>
								###qStatsAssist.PlayerNumber# - #qStatsAssist.PlayerName#
							</cfif> 
								<br>
						</cfloop>	
							</cfif>

<cfif qStatsPlusMinus.recordcount gt 0> 
					<cfif GoalType is "Even Strength"> 
						<b><cfif qStatsPlusMinus.StatType is "Plus"> Plus: <cfelse> Minus </cfif></b> <br>
					<cfelse>
						<b>On Ice during goal:</b> <br>		
					</cfif> 
</cfif>							
							<cfloop query="qStatsPlusMinus">
									<cfif FilteredPlayer is qStatsPlusMinus.PlayerName and ListContains("Plus,Minus,PlusMinus",attributes.filterBy,",")>
										<span class="highlight">
											###qStatsPlusMinus.PlayerNumber# - #qStatsPlusMinus.PlayerName# 
										</span>
									<cfelse>
										###qStatsPlusMinus.PlayerNumber# - #qStatsPlusMinus.PlayerName#
										</cfif>
										<br>
							</cfloop>
				</td>
					<td valign="top" class="#classValue#" align="center" style="vertical-align: top; padding: 10px; text-align: center;">
						<div style="margin-top: 20px;margin-bottom: 20px;">
							<cfif VideoURL is not "">
								<iframe  src="#VideoURL#" style="width:320px;height:180px;border: 3px solid black;" title="YouTube video player" frameborder="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
								</iframe>
								<cfif find(".com",goalLink)	gt 0>	
									<div><a href="#goalLink#" style="color:black;">More Angles</a> </div>
									<iframe width="320" height="180" src="#GoalLink#" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
									</iframe>
								</cfif>
							<cfelse>
								<img src="#application.images#NoVideo.png" width="220">
							</cfif>
						</div>
					</td>
				
			</tr>
			</cfoutput>
			</cfloop>
		</tbody>
	</table>


