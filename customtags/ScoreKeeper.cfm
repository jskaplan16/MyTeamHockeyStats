<cfparam name="attributes.GameId">

<cfquery datasource="#application.datasource#" name="qScoreKeeper">
    Exec stpGetScoreKeeper 
    @GameId=<cfqueryparam value="#Attributes.GameId#" cfsqltype="CF_SQL_INTEGER">
</cfquery>


  <table class="table-container">
	  <thead>
		  <tr>
<cfoutput query="qScoreKeeper">
        <th>#MainTeam#</th>
			<th>
			<img src="#application.icons##MainTeamIcon#" alt="#MainTeam# Logo" class="team-logo">
			</th>
	
			<th class="score">
			   #MainTeamScore#
			</th>

	        <th class="score">#ResultType#<br>
				<div class="date">#DateFormat(GameDate,"mm/dd/yyyy")#</div>
			</th>
			<th class="score">#OpponentTeamScore#</th>
			<th>#OpponentTeam#</th>
        	<th> <img src="#application.icons##OpponentTeamIcon#" alt="#OpponentTeam# Logo" class="team-logo"></th>
        	
 		</tr>
		</thead>
</cfoutput>
</table>	