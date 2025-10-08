<cfparam name="attributes.GameId">

<cfquery datasource="#application.datasource#" name="qScoreKeeper">
    Exec stpGetScoreKeeper 
    @GameId=<cfqueryparam value="#Attributes.GameId#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfoutput query="qScoreKeeper">
  <div class="scoreboard">
    <table class="table-container">
      <thead>
        <tr>
          <th class="team-name">#MainTeam#</th>
          <th>
            <img src="#application.icons##MainTeamIcon#" alt="#MainTeam# Logo" class="team-logo">
          </th>
          <th class="team-name">
            <div class="flip-card" id="home-score">#MainTeamScore#</div>
          </th>
          <th class="score">#ResultType#<br>
            <div class="date">#DateFormat(GameDate,"mm/dd/yyyy")#</div>
          </th>
          <th class="team-name">
            <div class="flip-card" id="away-score">#OpponentTeamScore#</div>
          </th>
          <th class="team-name">#OpponentTeam#</th>
          <th> 
            <img src="#application.icons##OpponentTeamIcon#" alt="#OpponentTeam# Logo" class="team-logo">
          </th>
        </tr>
      </thead>
    </table>
  </div>
</cfoutput>




<script type="text/javascript">
  // WebSocket connection status
  function updateConnectionStatus(status) {
    console.log('WebSocket Status:', status);
  }

  // WebSocket message handler
  function updateScore(message) {
    try {
      console.log('Received WebSocket message:', message);
      var data = JSON.parse(message.data);
      
      // Update scores with flip animation
      updateScoreWithAnimation('home-score', data.teamA);
      updateScoreWithAnimation('away-score', data.teamB);
      
      updateConnectionStatus('Connected');
    } catch (e) {
      console.error('Error parsing WebSocket message:', e);
      updateConnectionStatus('Error');
    }
  }

  // Update score with flip animation
  function updateScoreWithAnimation(id, value) {
    const card = document.getElementById(id);
    if (!card) return;
    
    if (card.textContent == value) return;
    
    card.classList.add('flipping');
    setTimeout(() => {
      card.textContent = value;
      card.classList.remove('flipping');
    }, 250); // Half of 0.5s animation duration
  }

 
</script>