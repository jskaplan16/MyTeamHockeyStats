<cfparam name="attributes.GameId">

<cfquery datasource="#application.datasource#" name="qScoreKeeper">
    Exec stpGetScoreKeeper 
    @GameId=<cfqueryparam value="#Attributes.GameId#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfoutput query="qScoreKeeper" >
 <div class="form-container" style="width: 80%;padding:10px;align-items: center;">
 <table class="arena-scoreboard">
	<tr>
	
	<td  class="team-block"  style="text-align: center;padding:5px; vertical-align: bottom;" nowrap>
          	<img src="assets/images/HockeyIcons/#MainTeamIcon#" alt="#MainTeam# Logo" class="team-logo" style="width: 150px;">
       		<div class="team-name" nowrap>#MainTeam#</div>
    </td>
	<td nowrap align="center">	 
		
					<span class="score-num">#MainTeamScore#</span>
					<span style="color:##888; font-size:2.4rem;">-</span>
					<span class="score-num">#OpponentTeamScore#</span>

				<div align="center" class="outcome-box #ResultType#" style="width:150px;text-align:center;">#ResultType#</div>
				<br>
			    <div class="date-box" style="width: 100px;">#DateFormat(GameDate,"mm/dd/yyyy")#</div>				
	</td>

  	<td class="team-block" style="text-align: center;padding:5px; vertical-align: bottom;" nowrap>
         <img src="assets/images/HockeyIcons/#OpponentTeamIcon#" alt="#OpponentTeam# Logo" class="team-logo" style="width: 150px;">
         <div class="team-name" nowrap>#OpponentTeam#</div>
    </td>
	</tr>
	</table>
  </div>
  </cfoutput>