<cfparam name="attributes.GameId">
<cfparam name="attributes.filterBy" default="">
<cfparam name="attributes.PlayerId" default="">
<cfparam name="FilteredPlayer" default="">
<cfparam name="attributes.StartGameDate">
<cfparam name="attributes.EndGameDate">	
<cfparam name="attributes.ReturnFilterPage" default="stats.cfm">
<cfparam name="attributes.showGame" type=boolean default="false">
<cfparam name="attributes.showAdd" type="boolean" default="false">
<cfparam name="attributes.showEdit" type="boolean" default="false">
<cfparam name="attributes.showDelete" type="boolean" default="false">
<cfparam name="attributes.RankingId" default="0">

<cfif NOT structKeyExists(session, "userid")>
  <!--- Session expired or user not logged in --->
  <cflocation url="loginPage.cfm" addtoken="no">
</cfif>

<cfquery name="qGetGoals" datasource="#application.datasource#">
	exec stpGameGoalsandStats 
	@StartDate = '#attributes.StartGameDate#',
	@EndDate = '#attributes.EndGameDate#'
	<cfif len(attributes.PlayerId)>
		,@PlayerId=#attributes.PlayerId#
	</cfif>

	
	<cfif len(attributes.filterBy) gt 0>
	, @FilterBy='#attributes.filterBy#' 
	</cfif>
	
	<cfif attributes.GameId is not "all">
	,@GameId=#attributes.gameId# 
	</cfif>
	,@RankingId=#attributes.RankingId#	
</cfquery> 

<cfif len(attributes.filterBy) gt 0 >
	<cfquery name="qPlayerName" datasource="#application.datasource#">
		Select PlayerName from vRoster where PlayerId=<cfqueryparam value="#attributes.PlayerId#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>

	<cfset FilteredPlayer=qPlayerName.PlayerName>
</cfif>
	
<cfquery dbtype="query" name="qJustGoals">
	Select Distinct GameId,GameDate,GoalId,Period,TeamIcon,GoalTimeDisplay,GoalType,VideoURL,PeriodRow,GoalTime,PlayerNumber,PlayerName,Game,OpponentTeam,GoalLink ,OpponentTeamIcon,isReassigned,OriginalPlayerName,GoalNumber
	from qGetGoals 
	Where StatType='Goal'
	Order by GameDate,GameId,Period,GoalTime desc
</cfquery>


	<table cellspacing="0" id="video" align="left"  class="filterTable">	
			<cfloop query="qJustGoals">
			<cfoutput>			
				<cfif attributes.GameId is not "all">
							<cfif PeriodRow is 1>
								<tr class="Period-Row">
						<td colspan="6" align="center" class="period-header" style="text-align: center;color:white;">
							<b>Period #Period#</b>
						</td>
						</tr>
						</cfif>
				</cfif>
					
				<cfif qJustGoals.currentRow  mod 2> 
					<cfset classValue="Row-Even">
							<cfelse>
					<cfset classValue="Row-Odd">
				</cfif>	
				<tr class="#classValue#">
					<td class="TdCellLeftTtl">
						<cfif (attributes.GameId is "all") OR (attributes.showGame)>
						<a href="#application.displays#DisplayStats.cfm?GameId=#qJustGoals.GameId#" class="mainLink" style="color:black;text-decoration: underline;">
							#Game#
							</a>
							
							<div style="color:black;">#GameDate#</div>
							</cfif>
						</td>
					<td>
						<img src="#application.icons##TeamIcon#" width="75">
				</td>

<cfquery dbtype="query" name="qStatsAssist">
		 Select Distinct GoalId,Period,TeamIcon,GoalTimeDisplay,GoalType,VideoURL,PeriodRow,GoalTime,PlayerNumber,PlayerName,IsReassigned,OriginalPlayerName from qGetGoals 
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
				
					<td>
					Period: #Period# <br/>
					Time: #GoalTimeDisplay#
						<div style="border:1px solid black; padding: 3px; text-align: center;"> 
					#GoalType#
						</div>
					Goal ##: #GoalNumber#
				</td>

			<td class="#classValue#" width="250"  style="border-bottom: 0px solid black;">
<cfoutput>			
	<b>Scored By:</b> 
		<cfif FilteredPlayer is PlayerName and ListContains("Goals,Points",attributes.filterBy,",") gt 0 >
				<span class="highlight">
			###playerNumber# - #PlayerName#					
			</span>
			<cfelse>
		###playerNumber# - #PlayerName#
	     </cfif>
			<cfif qJustGoals.IsReassigned>
				<img src="#application.images#InfoIcon.png" width="15px" alt="Icon" Title="Orginally credited to: #OriginalPlayerName#">	
			</cfif>	
			<br> 
</cfoutput>			
			
					<cfif qStatsAssist.PlayerNumber is not ""> <b>Assisted by:</b> <br>
						<cfloop query="qStatsAssist">
							<cfif FilteredPlayer is qStatsAssist.PlayerName and ListContains("Assists,Points",attributes.filterBy,",")>
								<span class="highlight">
							###qStatsAssist.PlayerNumber# - #qStatsAssist.PlayerName# 
								</span>
								
							<cfelse>
								###qStatsAssist.PlayerNumber# - #qStatsAssist.PlayerName#
							</cfif>
								<cfif qStatsAssist.IsReassigned>
									<img src="#application.images#InfoIcon.png" width="15px" alt="Icon" Title="Orginally credited to: #OriginalPlayerName#">								
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
					<td valign="top" class="#classValue#" align="center" style="border-bottom: 0px solid black;">
						<div style="margin-top: 20px;margin-bottom: 20px;">
						<cfif VideoURL is not "">
							<iframe style="width:320px;height:180px;border: 3px solid black;" width="320" height="180" src="#VideoURL#" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
							</iframe>
					<cfif find(".com",goalLink)	gt 0>	
						<div><a href="#goalLink#" style="color:black;">More Angles</a> </div>
						<iframe style="width:320px;height:180px;" width="320" height="180" src="#GoalLink#" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
							</iframe>
					</div>							
			</cfif>
				<cfelse>
					<img src="#application.images#NoVideo.png" width="220">
				</cfif>		
				</td>
			</tr>
<cfif session.showAdminFunctions and (attributes.showEdit or attributes.showDelete)>
			<tr style="padding: 10px;">
				<td colspan="5" class="#classValue#" style="border-top:0px;text-align:left;padding: 10px;">
					<cfset GoalId=qJustGoals.GoalId>
	<cfoutput>
	
	<!---<a href="GoalWizard.cfm?Step=3&GameId=#attributes.GameId#" class="mainLink" style="color:black">Add Goal</a>	--->
<cfif attributes.showDelete>


</cfif>

<cfif attributes.showAdd>
	<a href="GoalWizard.cfm?step=3" class="profile-button" style="color:black">Add Goal</a>
</cfif>

<cfif attributes.showEdit>
	<a href="#application.pages#GoalWizard.cfm?step=5&GoalId=#GoalId#&GameId=#attributes.GameId#" class="profile-button" style="color:black">Edit Goal</a>
</cfif>
<cfif attributes.showDelete>

			<a href="#application.pages#GoalWizard.cfm?step=6&GoalId=#GoalId#&GameId=#attributes.GameId#" class="profile-button" style="color:black">Delete Goal</a>	
</cfif>	
			</cfoutput>


				</td>
			</tr>
			</cfif>	
			<tr>
				<td colspan="5" class="#classValue#" style="border-top:0px;text-align:left;">
				<cf_displayQuestionStat GoalId=#GoalID# GameId="#attributes.GameId#">		
			</td>			
			</tr>		
			</cfoutput>
		
			</cfloop>
			</table>

