
<cfparam type="string" name="Attributes.PlayerId">
<cfparam type="String" name="Attributes.FilterBy">
<cfparam name="Attributes.PlayerName" default="">
<cfparam name="attributes.StartGameDate">
<cfparam name="attributes.EndGameDate">	
<cfparam name="attributes.RankingId" default="0">
	
	<cfquery datasource="#application.datasource#" name="qSumGoals">
exec stpGetPlayerStatsByGameAgg 
     @PlayerId=#Attributes.PlayerId#
	,@StartDate ='#attributes.StartGameDate#'
	,@EndDate = '#attributes.EndGameDate#'
	,@FilterBy= '#Attributes.FilterBy#'
	,@RankingId= '#attributes.RankingId#'
	</cfquery>


<table id="gameGoals">		
<tr>
			
				<th class="header-game">
					Game Date
				</td>
				<th class="header-game">
					Game
				</th>
					
				<th class="header-game">
					Goals
				</th>	
				<th class="header-game">
					Assists
				</th>
				<th class="header-game">
					Points
				</th>
			
				<th class="header-game">
					Minus
				</th>
			
				<th class="header-game">
					Plus
				</th>
				
				<th class="header-game">
					Plus/Minus
				</th>			
			</tr>
			
		<cfoutput query="qSumGoals">
			<cfif qSumGoals.currentRow  mod 2> 
				<cfset classValue="row-even">
						<cfelse>
				<cfset classValue="row-odd">
			</cfif>

				
			<tr class="#classValue#">				
				<td class="tblCellLeft"> #DateFormat(GameDate,"mm/dd/yyyy")#</td>
				<td class="tblCellLeft"><a href="stats.cfm?GameID=#GameID#" class="mainLink">#Game#</a></td>
				<td class="tblCellCenter">#Goals# </td>
				<td class="tblCellCenter">#Assists# </td>				
				<td class="tblCellCenter">#Points# </td>	
				<td class="tblCellCenter">#Minus# </td>	
				<td class="tblCellCenter">#Plus# </td>
				<td class="tblCellCenter">#PlusMinus# </td>
			</tr>
			
			</cfoutput>							

			<cfquery dbtype="query" name="qStatsTotal">
						Select 	Sum(Goals) as TtlGoals, 
								Sum(Assists) as ttlAssists,
								Sum(Points) as TtlPoints, 
								Sum(Minus) as ttlMinus,
								Sum(Plus) as ttlPlus,
								Sum(PlusMinus) as ttlPlusMinus
					from qSumGoals
			</cfquery>					
		
		<cfoutput query="qStatsTotal">
	<tr class="TRTTLRow">
	<td align="left" style="color:white;text-align:left">
		Totals
					</td>
		<td></td>
<td  class="TdCellCenterTtl" style="color:white;text-align:center">#TtlGoals#</td>
<td align="center" class="TdCellCenterTtl" style="color:white;text-align:center">#TtlAssists#</td>											
<td align="center" class="TdCellCenterTtl" style="color:white;text-align:center">#TtlPoints#</td>
<td align="center" class="TdCellCenterTtl" style="color:white;text-align:center">#TtlMinus#</td>
<td align="center" class="TdCellCenterTtl" style="color:white;text-align:center">#TtlPlus#</td>
<td align="center" class="TdCellCenterTtl" style="color:white;text-align:center">#ttlPlusMinus#</td>
</tr>				
			</cfoutput>
</table>
							
		
