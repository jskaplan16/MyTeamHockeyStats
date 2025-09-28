
<cfif NOT structKeyExists(session, "teamSeasonId")>
  <!--- Session expired or user not logged in --->
  <cflocation url="/loginPage.cfm" addtoken="no">
</cfif>

<cfinclude template="includes/headers/Header.cfm">

<cfparam name="form.FilterDateStart" default="#session.StartOfSeason#">
<cfparam name="form.FilterDateEnd" default="#session.EndOfSeason#">
<cfparam name="form.MinGoalScored" default="0">
<cfparam name="form.TournamentId" default="">
<cfparam name="form.RANKINGID" default="0">
	
<cfif IsDefined("form.TournamentId") and len(form.TournamentId)>
		<cfquery datasource="#application.datasource#" name="qTournament">
    exec stpGetTournaments @teamSeasonId=#session.TeamSeasonId#,
      @TournamentId=<cfqueryparam cfsqltype="CF_SQL_TINYINT" value="#form.TournamentId#">
		</cfquery>
			
		<cfif qTournament.recordcount>
			<cfset form.FilterDateStart=qTournament.StartDate>
			<cfset form.FilterDateEnd =qTournament.EndDate>
		</cfif>
	</cfif>	


	<cfquery datasource="#application.datasource#" name="qGames">
exec stpGetGames @FilterDateStart='#form.FilterDateStart#',
      @FilterDateEnd='#form.FilterDateEnd#',
      @teamSeasonId=#session.TeamSeasonId#
      <cfif isDefined("qRatingSelected.Rating") and qRatingSelected.Rating gt 0>
      ,@RatingId=#qRatingSelected.Rating#
      </cfif>
	</cfquery>

<cfquery dbtype="query" name="qTotal">
Select Sum(MainTeamScore) as TotalMain, Sum(OpponentTeamScore) as TotalOpponent from qGames
</cfquery>
	
<cfquery datasource="#application.datasource#"  name="qRecord">
    exec stpGetTeamRecord 
      @MainTeamSeasonId=#session.TeamSeasonId#,
      @FilterStartDate='#form.FilterDateStart#',
      @FilterEndDate='#form.FilterDateEnd#'
      <cfif isDefined("qRatingSelected.Rating") and qRatingSelected.Rating gt 0>
       , @OppenentRating=#qRatingSelected.Rating#
      </cfif>
	</cfquery>	

<cfoutput>
<div class="content">
    <div class="PageHeader">
      #session.TeamName# - Games 	
    </div>
  </cfoutput>	

<div>
	<cf_FormFilter ActionPagName="Games.cfm" 
				   ActionQueryString="" 
				   FilterDateStart="#form.FilterDateStart#" 
				   FilterDateEnd="#form.FilterDateEnd#"
				   MinGoalScored="#form.MinGoalScored#"
				   MinGoalScoreOn="false"
				   FilterByTournamentOn="True"
				   TournamentId="#form.TournamentId#"
           RankingId="#form.RANKINGID#"
				   >
  </div>	
	<cfoutput>

<cfif qRecord.GamesPlayed gt 0 > 
				
  <table class="form-filter-table">
				<tr class="form-filter-row">
				<cfset formattedPercentage = NumberFormat(Evaluate(qRecord.Wins/qRecord.GamesPlayed) * 100, "0.00") & "%">
					<td class="score-label">
          #qRecord.Wins# WINS <small>(#formattedPercentage#)</small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
         	<td class="score-label">#qRecord.Loss# LOSSES &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td class="score-label">#qRecord.Ties# TIES &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td class="score-label">#qRecord.GamesPlayed# TOTAL GAMES</td>
          </tr>
		</table>	
  </cfif>    
<!---          <cflocation url="index.cfm"> --->
       
		<br>
	</cfoutput>
  	<div class="game-wrapper">			
			 <table class="GameTable">


		<div class="table-responsive">
  <table style="border: 1px solid black;">

      <tr style="background: #13223b;">
        <th  class="header-game">Game Date</th>
        <th  class="header-game">Team Name</th>
       <cfoutput> <th  class="header-game">#session.TeamName#</th></cfoutput>
        <th  class="header-game">Opponent</th>
        <th  class="header-game">Result</th>
        <th  class="header-game">Rating</th>
      </tr>

    <tbody>
      <cfoutput query="qGames">
        <tr class="<cfif qGames.currentRow mod 2>row-even<cfelse>row-odd</cfif>">
          <td data-label="Game Date" class="tblCellLeft">#DateFormat(GameDate,"mm/dd/yyyy")#</td>
          <td data-label="Team Name">
            <a href="stats.cfm?GameId=#GameId#" class="grid-link">#Game#</a>
          </td>
          <td class="tblCellCenter" data-label="Jr Coyotes">#MainTeamScore#</td>
          <td class="tblCellCenter" data-label="Opponent">#OpponentTeamScore#</td>
          <td class="tblCellCenter" data-label="Result">
         #resultType#
          </td>
          <td class="tblCellCenter">#Rating#</td>
        </tr>
      </cfoutput>
      <cfoutput>
        <tr class="TRTTLRow">
          <td class="TdCellLeftTtl" data-label="Totals" style="color:white;">Totals</td>
          <td></td>
          <td class="TdCellCenterTtl" style="text-align: center;" data-label="Jr Coyotes Total">#qTotal.TotalMain#</td>
          <td class="TdCellCenterTtl" style="text-align: center;" data-label="Opponent Total">#qTotal.TotalOpponent#</td>
          <td></td>
          <td></td>
        </tr>
      </cfoutput>
    </tbody>
  </table>
</div>

				</div>
        </div>
<cfinclude template="includes/footers/Footer.cfm">

