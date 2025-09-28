<cfparam name="attributes.DefaultVideoLink" default="nqxdRW9fw2k">
<cfparam name="attributes.StartPoint" default="">
<cfparam name="attributes.StopPoint" default="">

    <!--- Define properties (optional) --->


<cfif thisTag.executionMode EQ "start">

	 
 <cfsavecontent variable="PlayerScript">
	<script>
    // Create a function to load the YouTube API and set up the player
    function loadYouTubeAPI() {
      // Load the YouTube API script
      var tag = document.createElement('script');
      tag.src = "https://www.youtube.com/iframe_api";
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      // Set up the function to be called when the API is ready
      window.onYouTubeIframeAPIReady = function() {
        new YT.Player('player', {
          height: '360',
          width: '640',
          videoId: '<cfoutput>#attributes.DefaultVideoLink#</cfoutput>', // Replace with your YouTube video ID
          events: {
            'onReady': onPlayerReady
          }
        });
      };
    }

    function onPlayerReady(event) {
		<cfif  len(attributes.StartPoint)>	
		<cfoutput>
		event.target.seekTo(#attributes.startPoint#, true);
		event.target.pauseVideo(); 	
		document.getElementById('startPoint').value= '#attributes.startPoint#';
		document.getElementById('endPoint').value= '#attributes.stopPoint#';
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
function copyStartPoint(){
	 let goalTime= document.getElementById('currentTimeField').value;
	
	document.getElementById('startPoint').value= goalTime;
	//document.getElementById('showGoalOffset').innerHTML=goalTime;
	
}
function copyCopyData(id){
	 let goalTime= document.getElementById('currentTimeField').value;
	
	document.getElementById(id).value= goalTime;
	//document.getElementById('showGoalOffset').innerHTML=goalTime;
	
}
		
		
    // Call the function to load the API when the page loads
    window.addEventListener('load', loadYouTubeAPI);
  </script>
					
</cfsavecontent>
<cfoutput>#PlayerScript#</cfoutput>
</cfif>
<div align="center" style="padding: 5px; width: 100%">	
	<div id="player"></div>

<div style="padding:10px;">
	<div style="display:inline;">
		<label>Start Point:</label>
	
		<input type="text" id="startPoint" name="startPoint" readonly style="width:50px;padding:5px;height: 25px;">

		<input type="button" name="set" value="Start Point" onclick="Javascript:copyCopyData('startPoint');" class="submit">

	</div>
	<div style="display:inline;">
		<label>Run Time:</label>
		<input type="text" id="currentTimeField" name="currentTimeField" readonly style="width:50px;padding:5px; height: 25px;">
	</div>
	<div style="display:inline;">
		<label>End Point:</label>
		<input type="text" id="endPoint" name="endPoint" readonly style="width:50px;padding:5px;height: 25px;">
		<input type="button" name="set" value="End Point" onclick="Javascript:copyCopyData('endPoint');" class="submit">
	</div>
</div>
	</div>	

