<cfparam name="attributes.GameId">
<cfparam name="attributes.ShowEdit" type="boolean" default="False">
<cfparam name="attributes.ShowDelete" type="boolean" default="False">

		<cfquery datasource="#application.datasource#" name="qPenaltyByPeriod">
		Select 
	Distinct GameId,
			PenaltyGoalId,
			 Game,
			 GameDate,
			 PenaltyId,
			 PenalizedPlayerTeam,
			 PenalizedTeamIcon,
			 PenaltyUnitType,
			 Period,
			 PenaltyStart,
			 PenaltyURL,
			 PenalizedPlayerNumber,
		     PenalizedPlayerName,
			 IsPenaltyUnitSucessful,
			 DENSE_RANK() OVER (PARTITION BY GameId,Period Order by Convert(time,PenaltyStart) desc) as PeriodRow,
			 PenaltyTimeType,
			 TeamSeasonId,
			 Convert(time,PenaltyStart) as PeriodStartTime
	from vPenalty 
	where GameID=#attributes.GameId# 
	Order by Period asc, Convert(time,PenaltyStart) desc
		</cfquery>
	<div></div>
	<div class="game-wrapper">
<cfif qPenaltyByPeriod.RecordCount>

<table class="table-responsive">

			<cfloop query="qPenaltyByPeriod">

<cfoutput>			
				<cfif PeriodRow is 1 > 
					<tr class="period-row">
						<td align="center" colspan="5" style="color:white;text-align:center;height: 50px;">
							<b>Period #Period#</b>
						</td>
					</tr>
				</cfif>
		

						
				<cfif qPenaltyByPeriod.currentRow  mod 2> 
					<cfset classValue="row-even">
							<cfelse>
					<cfset classValue="row-odd">
					</cfif>		
				
			<tr>
					<td class="#classValue#" style="border-bottom: 0px solid black;">
						<div align="left" style="margin-left: 15px;">
						Penalized Team <br>
						<img src="#application.icons##PenalizedTeamIcon#" width="75">
						<br>
						#PenalizedPlayerTeam# <br>
			
							#PenalizedPlayerNumber# - #PenalizedPlayerName#	
			
						</div>	
				</td>
				<td class="#classValue#" style="border-bottom: 0px solid black;">
<cfset currentTime = Now()>
					Period: #Period# <br/>
					Time: #timeFormat(PenaltyStart,"HH:mm")#
						<div style="border:1px solid black; padding: 3px; text-align: center;"> 
					#PenaltyUnitType# 
						</div>
					<cfif len(IsPenaltyUnitSucessful) is not 0  AND IsPenaltyUnitSucessful>
						<div style="background-color:green; padding: 3px; text-align: center;"> 
							<a href="#Application.pages#showGoals.cfm?GoalList=#PenaltyGoalId#" class="mainlink" style="color:white;">Successful</a> 
						</div>
					</cfif>	
					<cfif len(IsPenaltyUnitSucessful) is not 0   AND IsPenaltyUnitSucessful IS 0>
						<div style="background-color:red; padding: 3px; text-align: center;color:white;"> 
							<b>Unsuccessful</b>
						</div>
					</cfif>	
						<div align="center">
							<cfif PenaltyTimeType is not "Normal"><i>#PenaltyTimeType#</i></cfif>
						</div>
				</td>
<cfquery datasource="#application.datasource#" name="qPenaltyDetail">
Select 
		PenaltyId,
		PlayerId,
		PlayerNumber,
		PlayerName,
		PlayerNote
from [dbo].[vPenalty] 
where GameId=#attributes.GameId#
	and PenaltyId=#qPenaltyByPeriod.PenaltyId#
</cfquery>
				

				
				
					<td class="#classValue#" width="250"  style="border-bottom: 0px solid black;">
					 <cfif qPenaltyByPeriod.PenaltyUnitType is not "offsetting"> <b>#qPenaltyByPeriod.PenaltyUnitType# Players:</b> </cfif> 
						<cfloop query="qPenaltyDetail">
							<cfif qPenaltyByPeriod.PenaltyUnitType is not "offsetting">
					<br>	#qPenaltyDetail.PlayerNumber# - #qPenaltyDetail.PlayerName#
								</cfif>
					<cfif len(qPenaltyDetail.PlayerNote) gt 0>
						<img src="#Application.images#InfoIcon.png" alt="icon" width="15" title="#qPenaltyDetail.PlayerNote#">
							</cfif>
						</cfloop>
					</td>
					<td valign="top" class="#classValue#" align="center" style="border-bottom: 0px solid black;">
						<div style="margin-top: 20px;margin-bottom: 20px;">
						<cfif PenaltyURL is not "">
							<iframe width="320" height="180" style="width:320;height:180" src="#PenaltyURL#" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
							</iframe>
					<cfelse>
					<img src="#application.images#NoVideo.png" width="220">
					</cfif>
							</div>
					<small>*Note: Player's are not counted as part of the power play if they get on the ice with less 20 seconds remaining in the penalty. </small> 		
				</td>
			</tr>
		<cfif qPenaltyByPeriod.PenaltyGoalId is not "">
				<cfquery datasource="#application.datasource#" name="qPenaltyGoal">
			exec dbo.stpGetPenaltyGoals 

			@PenaltyGoalId=#qPenaltyByPeriod.PenaltyGoalId#
				</cfquery>

				<tr>
					<td colspan="5" align="center">
							<div style="border:1px solid black; padding: 3px; width: 50%; margin: 0 auto; text-align: center;"> 
						#qPenaltyGoal.PenaltyGoalDesc# 
							</div>
						</td>
				</tr>
					
		</cfif>
				
			<cfif session.showadminfunctions>
			<tr class="#classValue#">
				<td align="left" colspan="5" style="text-align: left;padding: 10px;">
					<a href="#application.pages#GoalWizard.cfm?Step=10&GameId=#attributes.GameId#" class="profile-button" style="color:black;text-decoration:underline;">Add Penalty</a>
					<a href="#application.pages#GoalWizard.cfm?Step=13&PenaltyId=#qPenaltyByPeriod.PenaltyId#" class="profile-button" style="color:black;text-decoration:underline;">Edit Penalty</a>
					<a href="#application.pages#GoalWizard.cfm?Step=15&PenaltyId=#qPenaltyByPeriod.PenaltyId#" class="profile-button" style="color:black;text-decoration:underline;">Delete Penalty</a>
				</td>
								
		    </tr>
			</cfif>
						</cfoutput>

			</cfloop>
			</table>
	</cfif>
</div>