<cfinclude template="includes/headers/Header.cfm">	
	
<cfparam name="url.GameId" default="1">
<cfparam  name="url.showMore" default="25">
<cfparam name="url.PlayerId" default="0" >
<cfparam name="url.Action" default="" >
<cfparam name="url.SortField" default="Total_Points">
<cfparam name="url.SortOrder" default="Desc">	


		
	
	<cfquery datasource="#application.datasource#" name="qHome">
			Select PlayerNumber, PlayerName, Count(GoalId) as Cnt from vGoals 
			where TeamId=#session.teamId#
			and PlayerId=#url.PlayerId#
		    Group by PlayerNumber, PlayerName
	</cfquery>
		<cfquery datasource="#application.datasource#" name="qAssists">
		
			exec stpGetPlaysBestWith @teamSeasonId=#session.teamSeasonId#,@PlayerId=#url.PlayerId#
		</cfquery>	
		



	<cfoutput>
<div class="content">	
    <div class="PageHeader">
      #session.TeamName#  -  Partner report 	
    </div>
	<label class="labelFld">Click player and scrolldown to see results.</label>
		<cf_DisplayGoalSummary  GameId="All" showMore="#url.showMore#" SortOrder="#url.SortOrder#" SortField="#url.SortField#" PageName="Roster.cfm" DetailsPage="PlayerDetail.cfm" NameDetailsPage="WorksBestWith.cfm" 
							   StartGameDate="#session.StartOfSeason#" EndGameDate="#session.EndofSeason#" LinksOn="false">
							
							
			<br>
			</cfoutput>
<cfoutput>
	<table width="100%" class="table-container">
		<tr>
			<td style="background-color: black;color:white;">
				Player Name: #qHome.PlayerName#
			</td>
			<td style="background-color: black;color:white;">
				Player Number: #qHome.PlayerNumber#
			</td>
			<td style="background-color: black;color:white;">
				Number of Goals: #qHome.Cnt#
			</td>
		</tr>
	</table>
</cfoutput>
	
	
	<table cellspacing="0"  style="width: 100%">
			<tr>
				<td class="row-odd" colspan="4" style="text-align: center;">
				<cfoutput>
									
				
		<b>Players - that work best with this player. % of Assist by other  player(s) that allow  #qHome.PlayerName# to Score </b>
								</cfoutput>
				</td>
			</tr>
<cfset TotalAssists=0> 
		<cfoutput query="qAssists" maxrows="10">
			<cfset TotalAssists=TotalAssists + qAssists.Points>
				<cfif qAssists.currentRow  mod 2> 
				<cfset classValue="row-even">
						<cfelse>
				<cfset classValue="row-odd">
				</cfif>	
	
		<tr>
				<td class="#classValue#" style="text-align: left;">
					#PlayerNumber# #PlayerName#	
				</td>				
				<td class="#classValue#">
					#PositionCode#
			
			
			     </td>
				<td align="center" class="#classValue#">
			        Assists: #Points#
			</td>
			<td class="#classValue#">
					(#Round(PercentOffensiveGoals*100)#%)
				</td>	
			</tr>	
		</cfoutput>	
					
					<tr>
					<td style="background-color: black">
					</td>
					<td style="background-color: black">
					</td>
					<td align="left" style="background-color: black">
						<cfoutput>Total Assists: #TotalAssists#</cfoutput>	
						</td>
					
					<td style="background-color: black">
					</td>
					</tr>
					
			</table>
<!---	
			
		<table width="100%" cellspacing="0">
			<tr>
				<td "row-odd">
		<b>Defensive players - that work best with this player. % of Assist by Player.</b>
				</td>
			</tr>
		<cfset TotalAssists=0>
		<cfoutput query="qAssists" maxrows="5">
			<cfset TotalAssists=TotalAssists + qAssistsDefense.Points>
			<cfif qAssistsDefense.currentRow  mod 2> 
				<cfset classValue="row-even">
						<cfelse>
				<cfset classValue="row-odd">
				</cfif>	
			<tr>
				<td class="#classValue#">
					#PlayerNumber# #PlayerName#	
				</td>				
				<td class="#classValue#">
					#PositionCode#
				</td>
				<td align="center" class="#classValue#">
					 Assists: #Points# 
				</td>
				<td class="#classValue#">
					#Round(PercentOffensiveGoals*100)#%
				</td>	
			</tr>	
		</cfoutput>	
			<tr>
					<td style="background-color: black">
					</td>
					<td style="background-color: black">
					</td>
					<td align="left" style="background-color: black">
						<cfoutput>Total Assists: #TotalAssists#</cfoutput>	
						</td>
					
					<td style="background-color: black">
					</td>
					</tr>		
					
			</table>
--->
</div>
<cfinclude template="includes/footers/Footer.cfm">