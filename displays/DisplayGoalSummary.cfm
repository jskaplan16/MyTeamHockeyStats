<cfparam name="attributes.gameId">
<cfparam name="attributes.ShowMore" default="5">
<cfparam name="attributes.SortField" default="TotalPoints">
<cfparam name="attributes.SortOrder" default="Desc">
<cfparam name="attributes.PageName">
<cfparam name="attributes.StartGameDate" default="#session.StartOfSeason#">
<cfparam name="attributes.EndGameDate" default="#session.EndOfSeason#">
<cfparam name="attributes.DetailsPage">
<cfparam name="attributes.NameDetailsPage" default="#attributes.DetailsPage#">
<cfparam name="attributes.TournamentId" default="">
<cfparam name="attributes.RankingId" default="0">
<cfparam name="attributes.LinksOn" default="True">


<cfif NOT structKeyExists(session, "userid")>
  <!--- Session expired or user not logged in --->
  <cflocation url="#application.displays#DisplayLoginPage.cfm" addtoken="no">
</cfif>

<cfif NOT structKeyExists(session, "TeamSeasonId")>
  <!--- Session expired or user not logged in --->
  <cflocation url="#application.displays#DisplayLoginPage.cfm" addtoken="no">
</cfif>


<cfset TotalGoals = 0> 
<cfset TotalAssists=0> 

<cfif attributes.SortOrder is "Desc">
	<cfset newSortOrder="ASC">	
<cfelse>
	<cfset newSortOrder="Desc">
</cfif>	
	
<cfquery datasource="#application.datasource#" name="qStatsSummaryBase">
	exec stpGetRosterGoalSummary
		@StartDate='#attributes.StartGameDate#',
		@EndDate='#attributes.EndGameDate#',
		@TeamSeasonId = #session.teamSeasonId#
		<cfif len(attributes.gameId) and attributes.gameId is not "all"> 
			,@GameId=<cfqueryparam value="#attributes.gameId#" cfsqltype="CF_SQL_INTEGER">
		</cfif>
</cfquery>



<cfif qStatsSummaryBase.RecordCount gt 0>

	<cfquery dbtype="query" name="qStatsSummary">
		Select * from qStatsSummaryBase 
		Order by #Replace(attributes.SortField,"_","")# #attributes.SortOrder#, TotalGoals DESC 
		<cfif attributes.SortField is "PositionGeneral">
		,TotalPoints desc 
		</cfif>
	</cfquery>



<cfquery datasource="#application.datasource#" name="qHockeyGamesList">
	Select distinct OpponentTeamIcon from vGames 
	where MainTeamSeasonID=#session.teamSeasonId# 
	and   GameDate >='#attributes.StartGameDate#'
	and   GameDate  <='#attributes.EndGameDate#'
</cfquery>
<!--- 	AND   OpponentRating >= (Select Rating from tblRankingDimension where RankingId=#attributes.RankingId#) --->
<cfif not IsNumeric(attributes.gameId)> 
	<cfif attributes.RankingId is not 0>
		<div style="background-color: white;text-align:center">
			<cfoutput query="qHockeyGamesList" >
				<img src="#application.icons##OpponentTeamIcon#" width="100" height="100" title="#OpponentTeamIcon#">
			</cfoutput>
		</div>
	</cfif>
</cfif>

<cfif attributes.gameId is not "All">	

<div style="width: 95%;display:table;padding: 3px;">
		<div style="display: table-row;">
		<cfoutput>
				<div style="display: table-cell;width: 50%;text-align: left;padding-left: 25px;">
	     <a href="#application.displays#DisplayGameSheetViewer.cfm?GameId=#attributes.gameId#">
	     	<img src="#application.images#GamesheetsIcon.png" width="100"></a>
			</div>
		<cfif qStatsSummaryBase.RecordCount is not 0>
		<div style="display: table-cell;width: 50%;text-align:right;vertical-align: middle;color:black;">
			 <a href="#qStatsSummary.FullGameVideoURL#" target="_blank" class="mainlink">Full Game Video</a>	
			</div>
		</cfif>
			</cfoutput>
		</div>
	</div>
<cfelse>
	<div>&nbsp;</div>
	</cfif>	
	


		
			 <table class="filterTable">

  
<cfoutput>
	<tr>
				<th class="header-game" style="width: 10px;">
					##
				</th>
				<th class="header-game">
					Player Name
				</th>
						<th  class="header-game">
				 				<cfif attributes.SortField  is "PositionGeneral" and Attributes.SortOrder is "Desc">
									<a href="#application.displays##attributes.PageName#?SortField=PositionGeneral&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">Position</a>
								<cfelse>
										<a href="#application.displays##attributes.PageName#?SortField=PositionGeneral&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">Position</a>
									</cfif>
				</th>
					<th class="header-game">
					GP
				</th>
		
				<th class="header-game">
										<cfif attributes.SortField  is "Total_Goals" and Attributes.SortOrder is "Desc">
						<a href="#application.displays##attributes.PageName#?SortField=Total_Goals&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					<cfelse>
						<a href="#application.displays##attributes.PageName#?SortField=Total_Goals&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					</cfif>		
					Goals  
				</th>
				<th class="header-game">
										<cfif attributes.SortField  is "Total_Assists" and Attributes.SortOrder is "Desc">
						<a href="#application.displays##attributes.PageName#?SortField=Total_Assists&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					<cfelse>
						<a href="#application.displays##attributes.PageName#?SortField=Total_Assists&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					</cfif>		
					Assists
						</a>
				</th>
	<th class="header-game">
					<cfif attributes.SortField  is "Total_Points" and Attributes.SortOrder is "Desc">
						<a href="#application.displays##attributes.PageName#?SortField=Total_Points&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					<cfelse>
						<a href="#application.displays##attributes.PageName#?SortField=Total_Points&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					</cfif>		
							Points</a>
				</th>
<th class="header-game">
										<cfif attributes.SortField  is "Minus" and Attributes.SortOrder is "Desc">
						<a href="#application.displays##attributes.PageName#?SortField=Minus&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					<cfelse>
						<a href="#application.displays##attributes.PageName#?SortField=Minus&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					</cfif>	
					Minus
						</a>
				</th>
<th class="header-game">
					<cfif attributes.SortField  is "Plus" and Attributes.SortOrder is "Desc">
						<a href="#attributes.PageName#?SortField=Plus&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					<cfelse>
						<a href="#attributes.PageName#?SortField=Plus&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					</cfif>	
					Plus 
				</th>
<th class="header-game">
										<cfif attributes.SortField  is "TotalPlusMinus" and Attributes.SortOrder is "Desc">
						<a href="#attributes.PageName#?SortField=TotalPlusMinus&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					<cfelse>
						<a href="#attributes.PageName#?SortField=TotalPlusMinus&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#">
					</cfif>	
					Plus/Minus
				</th>
<th class="header-game">
					<cfif attributes.SortField  is "GPG" and Attributes.SortOrder is "Desc">
						<a href="#attributes.PageName#?SortField=GPG&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#" title="Goals Per Game">
					<cfelse>
						<a href="#attributes.PageName#?SortField=GPG&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#" title="Goals Per Game">
					</cfif>	
					GPG 
				</th>
<th class="header-game">
					<cfif attributes.SortField  is "GPG" and Attributes.SortOrder is "Desc">
						<a href="#attributes.PageName#?SortField=PPG&SortOrder=ASC&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#" title="Points Per Game">
					<cfelse>
						<a href="#attributes.PageName#?SortField=PPG&SortOrder=Desc&GameId=#attributes.GameId#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&TournamentId=#attributes.TournamentId#&RankingId=#attributes.RankingId#" title="Points Per Game">
					</cfif>	
					PPG 
				</th>
					
							</tr>
											
	</cfoutput>
		
							<cfoutput query="qStatsSummary">
			
							<cfif qStatsSummary.currentRow  mod 2> 
				<cfset classValue="row-even">
						<cfelse>
				<cfset classValue="row-odd">
				</cfif>				
							
				<tr class="#classValue#">
				<td class="tblCellLeft">
			
					<a href="#attributes.NameDetailsPage#?GameId=#attributes.gameId#&Action=Points&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#" class="mainLink">
							#qStatsSummary.PlayerNumber#						
					</a>	
					</td>
					<td class="tblCellLeft">
			
					<a href="#attributes.NameDetailsPage#?GameId=#attributes.gameId#&Action=Points&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#" class="mainLink">
							#qStatsSummary.PlayerName#						
					</a>	
					</td>
		
				
				<td class="tblCellCenter">
					<b>#qStatsSummary.PositionGeneral#</b>
					</td>
				<td class="tblCellCenter">
					<b>#qStatsSummary.GamesPlayed#</b>
					</td>
					<td class="tblCellCenter">
					<cfif attributes.LinksOn>
				<a href="#attributes.DetailsPage#?GameId=#attributes.gameId#&Action=Goals&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&rankindId=#attributes.RankingId#" class="mainLink" title="Click to view Goals">
				
						</cfif>
							#qStatsSummary.totalGoals#
						<cfif attributes.LinksOn>
					</a>
					</cfif>
					</td>
					<td class="tblCellCenter">
						<cfif attributes.LinksOn>
					<a href="#attributes.DetailsPage#?GameId=#attributes.gameId#&Action=Assists&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&rankindId=#attributes.RankingId#" class="mainLink" title="Click to view Assists">
						</cfif>
							#qStatsSummary.totalAssists#
		 	<cfif attributes.LinksOn>
							</a>
			</cfif>
					</td>
					<td class="tblCellCenter">
					<cfif attributes.LinksOn>	
					<a href="#attributes.DetailsPage#?GameId=#attributes.gameId#&Action=Points&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&rankindId=#attributes.RankingId#" class="mainLink" title="Click to view Points">
					</cfif>
							#qStatsSummary.TotalPoints#
							<cfif attributes.LinksOn>
							</a>
							</cfif>
					</td>
					<td class="tblCellCenter">
					<cfif attributes.LinksOn>
						<a href="#attributes.DetailsPage#?GameId=#attributes.gameId#&Action=Minus&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&rankindId=#attributes.RankingId#" class="mainLink" title="Click to view Minus">
					</cfif>
								#Minus#
						<cfif attributes.LinksOn>
						</a>
						</cfif>
						</td>
					<td class="tblCellCenter">
						<cfif attributes.LinksOn>
						<a href="#attributes.DetailsPage#?GameId=#attributes.gameId#&Action=Plus&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&rankindId=#attributes.RankingId#" class="mainLink" title="Click to view Plus">
						</cfif>
								#Plus#
						 <cfif attributes.LinksOn>		
								</a>
						</cfif>
						</td>
					<td class="tblCellCenter">
						 <cfif attributes.LinksOn>	
						<a href="#attributes.DetailsPage#?GameId=#attributes.gameId#&Action=PlusMinus&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&rankindId=#attributes.RankingId#" class="mainLink" title="Click to view Plus/Minus">
							</cfif>
							#TotalPlusMinus#
								 <cfif attributes.LinksOn>	
							</a>
							</cfif>
						</td>
					
										<td class="tblCellCenter">
		 	 <cfif attributes.LinksOn>				
				<a href="#attributes.DetailsPage#?GameId=#attributes.gameId#&Action=Goals&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&rankindId=#attributes.RankingId#" class="mainLink" title="Click to view Goals Per Game(GPG)">
			</cfif>				
							#NumberFormat(qStatsSummary.GPG,'_.00')#
			<cfif attributes.LinksOn>				
					</a>
			</cfif>		
					</td>
												<td class="tblCellCenter">
												<cfif attributes.LinksOn>
				<a href="#attributes.DetailsPage#?GameId=#attributes.gameId#&Action=Points&PlayerId=#qStatsSummary.PlayerId#&ShowMore=#attributes.ShowMore#&FilterDateStart=#attributes.StartGameDate#&FilterDateEnd=#attributes.EndGameDate#&rankindId=#attributes.RankingId#" class="mainLink" title="Click to view PPG - Points Per Game(PPG)">
						</cfif>
							#NumberFormat(qStatsSummary.PPG,'_.00')#
						<cfif attributes.LinksOn>
					</a>
					</cfif>
					</td>
					</tr>
							
							
					</cfoutput>
				
					<cfquery dbtype="query" name="qStatsTotal">
						Select 	Sum(TotalGoals) as TtlGoals, 
								Sum(TotalAssists) as ttlAssists,
								Sum(TotalPoints) as TtlPoints, 
								Sum(Minus) as ttlMinus,
								Sum(Plus) as ttlPlus,
								Sum(TotalPlusMinus) as ttlPlusMinus,
								Min(GamesPlayed) as ttlGamesPlayed
						
						
					from qStatsSummary
					</cfquery>
					
		<cfoutput query="qStatsTotal">
		
					<tr class="TRTTLRow">
	<td style="color:white;">Totals</td>
	
						
			<td style="border: 0px;">  			</td>
			<td style="border: 0px;">   			</td>
					
			<td  style="text-align: center;">
		#ttlGamesPlayed#
					</td>
						
	<td style="text-align: center;">
		#TtlGoals#
						</td>
											</td>
	<td   style="text-align: center;">#TtlAssists#
						</td>
					
	<td  style="text-align: center;">#TtlPoints#
						</td>
															
	<td   style="text-align: center;">
#TtlMinus#
	</td>
	<td  style="text-align: center;">
#TtlPlus#
						</td>
	<td   style="text-align: center;">
#ttlPlusMinus#
						</td>
							<td  style="text-align: center;">
							<!---
							<cftry>
#NumberFormat(Evaluate(TtlGoals/ttlGamesPlayed),'_.00')#
<cfcatch >
0	
</cfcatch>															
														</cftry>
--->
						</td>
						<td style="text-align: center;">
<!---
<cftry>
	

#NumberFormat(Evaluate(TtlPoints/ttlGamesPlayed),'_.00')#
<cfcatch>
	0
</cfcatch>
</cftry>
	--->
						</td>
							</tr>
			</cfoutput>
	</table>
	
</cfif>