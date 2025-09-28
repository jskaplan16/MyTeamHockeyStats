<cfparam name="attributes.GameId">
<cfparam name="attributes.Action"  default="Insert">
<cfparam name="attributes.GoalOffset" default="0" >

  

<cfquery name="qGames"  datasource="#application.datasource#">
  Select GamevideoId  from tblGame where GameId=#attributes.GameId#
</cfquery>
<cfset vid=qGames.GameVideoId>

  <script>

   var player;

    function loadYouTubeAPI() {
        // Load YouTube API script
        var tag = document.createElement('script');
        tag.src = "https://www.youtube.com/iframe_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    }

    // Called when YouTube API is ready
    function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
            height: '560',
            width: '740',
            videoId: '<cfoutput>#vid#</cfoutput>', // Replace with actual video ID
            events: {
                'onReady': onPlayerReady,
                'onError': onPlayerError
            }
        });
    }

    function onPlayerReady(event) {
      player = event.target;
	<cfif attributes.Action is "Edit">	
		<cfoutput>
		event.target.seekTo(#attributes.GoalOffset#, true);
		event.target.pauseVideo(); 					
		</cfoutput>
	  </cfif>	
      setInterval(function() {
        getCurrentPlaybackTime(event.target);
      }, 1000);
    }

    function getCurrentPlaybackTime(player) {
      if (player && player.getCurrentTime) {
        let currentTime = Math.round(player.getCurrentTime());
        document.getElementById('currentTimeField').value = currentTime;
      }
    }

function seekAfterBuffering(seconds) {
        let checkBufferInterval = setInterval(() => {
            let state = player.getPlayerState();
            if (state === YT.PlayerState.PLAYING || state === YT.PlayerState.PAUSED) {
                clearInterval(checkBufferInterval);
                player.seekTo(seconds, true);
                console.log(`Seeked to ${seconds} seconds.`);
            }
        }, 100); // Check every 100ms
    }


function copyGoalTime(){
	 let goalTime= document.getElementById('currentTimeField').value;
	
	document.getElementById('goalOffset').value= goalTime;
	
}
    // Call the function to load the API when the page loads
    window.addEventListener('load', loadYouTubeAPI);


 function onPlayerStateChange(event) {
        if (event.data === YT.PlayerState.PLAYING) {
            console.log("Video is playing!");
        }
    }

    function onPlayerError(event) {
        console.error("YouTube Player Error:", event.data);
    }

   
 
  </script>
  <div>




	<cfquery name="qGames" datasource="#application.datasource#">
			Select GameId, Game,   Convert(varchar(10),GameDate,101) + ' ' + Game as GameName,FullGameVideoURL,VideoEmbed  from vGames 
		Where MainTeamSeasonId=#session.TeamSeasonId#
		Order by GameDate desc,GameID desc 
		
	</cfquery>
 


<div>

	   <cfif vid is not "">
		<div id="player"></div>
    <div>
    <label for="currentTimeField">Current Time:</label>
    <input type="text" id="currentTimeField" name="currentTimeField" value="" readonly style="width:50px;padding:5px;height: 25px;">
    </div>
    </cfif>