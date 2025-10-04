

<cfparam name="attributes.navBar" default="true">
<cfparam name="attributes.formGoalId" default="">
<cfparam name="vid" default="">
<cfparam name="Form.GoalId" default="">
<cfparam name="form.GOALNUMBER" default="">
<cfparam name="form.GOALTYPEID" default="">
<cfparam name="form.GOALOFFSET" default="">
<cfparam name="form.GOALTIME" default="">
<cfparam name="form.PERIOD" default="1">
<cfparam name="form.PLUSMINUS" default="">
<cfparam name="form.TEAMID" default="">
<cfparam name="form.PLAYERID" default="">	
<cfparam name="form.REASSIGNEDPLAYERID" default="">	
<cfparam name="form.GAMESHEETASSISTPLAYERID1" default="">
<cfparam name="form.GAMESHEETASSISTPLAYERID2" default="">
<cfparam name="form.REASSIGNEDASSISTPLAYERID1" default="">
<cfparam name="form.REASSIGNEDASSISTPLAYERID2" default="">
<cfparam name="PlusMinus" default="">

<cfparam name="form.Action" default="Insert">
<cfparam name="form.TeamID" default="#session.teamId#">
<cfif isdefined("form.TeamId") and len(form.TeamId) eq 0>
		<cfset form.TeamSeasonId=session.teamSeasonId>
</cfif>


	
	
	
	
	<cfif isDefined("form.GameId") and len(form.GameId)>
	 	<cfquery name="qSelectedGame" datasource="#application.datasource#">
			Select GameId, Game,   Convert(varchar(10),GameDate,101) + ' ' + Game as GameName,FullGameVideoURL,VideoEmbed,MainTeamSeasonId,OpponentTeamSeasonId,GameSheetURL,GameVideoId from vGames
		Where MainTeamSeasonId=#session.TeamSeasonId#
	  and GameId=#form.GameId#
		Order by GameDate desc	
	</cfquery>

	<cftry>
		<cfif  len(qSelectedGame.GameVideoId)>
			<cfset Vid=qSelectedGame.GameVideoId>				
		<cfelse>
			<cfset tmp = listToArray(qSelectedGame.FullGameVideoURL,"/",false)>
			<cfset Vid = listToArray(tmp[4],"?",false)>
			<cfset vid = vid[1]>

		</cfif>
	<cfcatch>
		<div>Error with parsing video link.Edit Game with video Id.</div>
		<cfset vid="">			
	</cfcatch>			
	</cftry>		
	<cfquery name="qTeams" datasource="#application.datasource#">
	Select TeamId,TeamName,TeamSeasonId from vTeam where TeamSeasonId in(#session.TeamSeasonId#,#qSelectedGame.OpponentTeamSeasonId#)	
		 Order by Case when #session.TeamId#=TeamId then 1 else 2 end asc   
	</cfquery>	
			
	<cfquery name="qRoster" datasource="#application.datasource#">
			
exec stpGetRoster @TeamSeasonId=#session.TeamSeasonID#,@OpponentTeamSeasonId=#qSelectedGame.OpponentTeamSeasonId#
			</cfquery>	
			
	<cfquery name="qGoalType" datasource="#application.datasource#">
		Select GoalTypeId,GoalType from tblgoaltype	
	</cfquery>
		
</cfif>

<cfif form.action is "insert">
	<cfquery name="qGetGoalOffSet" datasource="#application.datasource#">
   exec stpGetLatestVideoPointInGame @GameId=#session.selectedGameID#
	</cfquery>

   <cfset form.GOALOFFSET=qGetGoalOffSet.GoalOffset>
   <cfset form.PERIOD=qGetGoalOffSet.period>
		<cfif form.GOALOFFSET is "">
		<cfset form.GOALOFFSET=0>
		
	</cfif>
</cfif>
<cfif form.Action is "Edit">
	<cfquery name="qGetGoal" datasource="#application.datasource#">
   exec dbo.stpGetGoal @GoalId=#form.GoalId#	
	</cfquery>
	<cfset form.goalId     = qGetGoal.GoalId>
	<cfset form.goalOffset = qGetGoal.GoalOffset>
	<cfset form.GoalNumber = qGetGoal.GoalNumber>		
	<cfset form.GOALTYPEID = qgetGoal.GOALTYPEID>
	<cfset form.GoalTime   = qgetGoal.GOALTIME>
	<cfset form.Period     = qGetGoal.Period>
	<cfset form.TeamId     = qGetGoal.TeamId>
	<cfset form.PlayerId   = qGetGoal.PlayerId>
	<cfset form.REASSIGNEDPLAYERID = qGetGoal.REASSIGNEDPLAYERID>
	<cfset form.GAMESHEETASSISTPLAYERID1 = qGetGoal.GAMESHEETASSISTPLAYERID1>
	<cfset form.GAMESHEETASSISTPLAYERID2 = qGetGoal.GAMESHEETASSISTPLAYERID2>
	<cfset form.REASSIGNEDASSISTPLAYERID1 = qGetGoal.REASSIGNEDASSISTPLAYERID1>
	<cfset form.REASSIGNEDASSISTPLAYERID2 = qGetGoal.REASSIGNEDASSISTPLAYERID2>	
	<cfset form.teamSeasonId=qGetGoal.TeamSeasonID>

</cfif>
				

<cfif vid is not "">
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
          videoId: '<cfoutput>#vid#</cfoutput>', // Replace with your YouTube video ID
          events: {
            'onReady': onPlayerReady
          }
        });
      };
    }

    function onPlayerReady(event) {
	<cfif len(form.GOALOFFSET) gt 0>	
		<cfoutput>
		event.target.seekTo(#form.GOALOFFSET#, true);
		event.target.pauseVideo(); 					
		</cfoutput>
	  </cfif>	
	  document.getElementById('video_holder').style.visibility = 'visible';
	  // Set an interval to get the current playback time every second
     
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
function copyGoalTime(){
	 let goalTime= document.getElementById('currentTimeField').value;
	
	document.getElementById('goalOffset').value= goalTime;
	//document.getElementById('showGoalOffset').innerHTML=goalTime;
	
}
    // Call the function to load the API when the page loads
    window.addEventListener('load', loadYouTubeAPI);
  </script>
  <div>

</cfif>

	
	<div class="container">
		  	<cfif isDefined("qTeams.TeamId")>
				<!---    <form method="post" action="SaveGoal.cfm" onsubmit="return validateCheckboxes()">  --->
					<cfoutput>
   <form method="post" action="#Application.actions#ActionSaveGoal.cfm">
	</cfoutput>
<div class="row-even">
<br>
	<div class="video-center" id="video_holder" style="visibility: hidden;">
		<cfif vid is not "">
			<div style="text-align:center">

			<div id="player" style="width: 800px;height: 450px;border:1px solid black;padding 5px"></div>
			</div>
		<br>
		<div style="padding: 15px;">	   
		<label for="currentTimeField">Current Playback Time (seconds):</label>
		<input type="text" id="currentTimeField" readonly name="runningClock" style="width: 80px;">
		<input type="button" value="SET GOAL TIME" onclick="copyGoalTime()" class="profile-button">
		</div>	
			</cfif>
	</div>
	  
	
 <table class="table-responsive">
<tr class="row-odd">
<td> Period
	</td>
	<td colspan="4">
	<cfloop from="1" to="4" index="i">
	<cfoutput>
	<div style="display: inline;padding-left: 75px;">Period #i# </label>	
	<input type="radio" name="Period" value="#i#" required <cfif form.Period is i> checked </cfif> ></div>
	</cfoutput>
		</cfloop>
	</td>
	</tr>	 
<tr class="row-even">
	<td>
	Which Team Scored:
	</td>
	<td align="center" colspan="4">
	<cfoutput query="qTeams">
    <label>
      <input type="radio" name="teamSeasonId" value="#TeamSeasonId#" required <cfif teamSeasonId is form.teamSeasonId> checked </cfif>> #teamName# 
	<button type="button" onclick="document.getElementById('webModal_#TeamSeasonId#').showModal()" class="profile-button">Add Player</button>
<dialog id="webModal_#TeamSeasonId#" style="padding:15px;text-align:center;scollbar: none;">
<div style="text-align: right;">
  <button type="button" onclick="document.getElementById('webModal_#TeamSeasonId#').close()" class="profile-button" >X</button>
 </div> 
  <iframe src="DisplayPlayerRoster.cfm?Action=Insert&TeamSeasonId=#TeamSeasonId#&showNavBar=false"  style="padding:10px;border:none;width:900px;height:550px;scrolling:no;overflow: hidden;"></iframe>
   
</dialog>
    </label>
</cfoutput> 
</td>
	   </tr>
<tr class="row-odd">
<td>
	Goal Type
</td>

	<td align="left">
	<select name="GoalTypeId">
<cfoutput query="qGoalType">
		<option value="#GoalTypeId#">#GoalType#</option>
</cfoutput>	
	</select>
	</td>
	<td>
	Goal Offset: 
	</td>
	<td>
		<cfoutput>
	<input type="text" name="goalOffset" id="goalOffset" required  value="#form.goalOffset#">
	</cfoutput>
			</td>
	 </tr>

	<cfquery dbtype="query" name="qDefaultRoster">
		Select * from qRoster where TeamSeasonId=#form.TeamSeasonId#	   
	</cfquery>

	 
	<tr class="row-even">
		<td>
		Gamesheet Player
		</td>
	<td>
	   <select id="playerId" name="PlayerId" required>
      <option value="">Please select player that scored on gamesheet</option>


<cfoutput query="qDefaultRoster">
	<option value="#PlayerId#" <cfif form.PlayerId is qDefaultRoster.PlayerId> selected </cfif> >
			#PlayerName#
	</option>
		   </cfoutput>
</select>

	</td>
		<td nowrap>
		Reassigned Player
		</td>
	<td>
	   <select id="reAssignedPlayerID" name="ReAssignedPlayerID">
		       <option value="">Please select an gamesheet player</option> 
		  <cfoutput query="qDefaultRoster"> 
   <option value="#PlayerId#" <cfif form.reAssignedPlayerID is qDefaultRoster.PlayerId> selected </cfif> >
			#PlayerName#
	</option>
		   </cfoutput>
</select>
	</td>
	 </tr>
<tr class="row-odd">

	<td>
	 <label>Goal Number</label>	
	</td>
	
	<td align="left">
<cfoutput>
		<input type="Number" name="GoalNumber" style="width:80px;"  value="#form.GoalNumber#">
		<input type="hidden" name="GameId" value="#form.GameId#">
		<input type="hidden" name="Action" value="#form.Action#">
	<cfif len(form.GoalId)>
		<input type="hidden" name="GoalId" value="#form.GoalId#">
	</cfif>	
		</cfoutput>
</td>
	
	<td width="50">
		<label>Goal Time</label>
	</td>
	<td>
		<cfoutput>
	<input type="text" name="GoalTime" style="width:80px;"  value="#form.GoalTime#">	
	</cfoutput>
	
	</td>
	 </tr>
<tr class="row-even">
		<td>
		Gamesheet Assist #1 
		</td>
	<td>
	   <select id="gamesheetAssistPlayerId1" name="GamesheetAssistPlayerId1">
      <option value="">Please select an gamesheet player</option> 
		   
		<cfoutput query="qDefaultRoster">
 		<option value="#PlayerId#" 
			<cfif form.gamesheetAssistPlayerId1 is qDefaultRoster.PlayerId> selected </cfif> >
			#PlayerName#
	</option>
		   </cfoutput>   
    </select>
	</td>
		<td >
		Reassigned Assist 
		</td>
	<td>
	   <select id="reAssignedAssistPlayerId1" name="ReAssignedAssistPlayerId1">
      <option value="">Please select an gamesheet player</option>
<cfoutput query="qDefaultRoster">
 		<option value="#PlayerId#" 
			<cfif form.ReAssignedAssistPlayerId1 is qDefaultRoster.PlayerId> selected </cfif> >
			#PlayerName#
	</option>
		   </cfoutput>  
</select>
	</td>
	 </tr>	
<tr class="row-odd">
		<td nowrap>
		Gamesheet Assist #2
		</td>
	<td>
	   <select id="gamesheetAssistPlayerId2" name="GamesheetAssistPlayerId2">
      <option value="">Please select an gamesheet player</option>
		   <cfoutput query="qDefaultRoster"> 
   <option value="#PlayerId#" <cfif form.gamesheetAssistPlayerId2 is qDefaultRoster.PlayerId> selected </cfif> >
			#PlayerName#
	</option>
		   </cfoutput>
</select>

	</td>
		<td>
		Reassigned Assist Player
		</td>
	<td>
	   <select id="reAssignedAssistPlayerId2" name="ReAssignedAssistPlayerId2">
      <option value="">Please select an gamesheet player</option>
		   <cfoutput query="qDefaultRoster">
 		<option value="#PlayerId#" 
			<cfif form.ReAssignedAssistPlayerId2 is qDefaultRoster.PlayerId> selected </cfif> >
			#PlayerName#
	</option>
		   </cfoutput> 
    </select>
	</td>
</tr>	
	</table>
	<cfquery dbtype="query" name="qOffense">
	Select * from qRoster where PositionGeneral='F' and TeamSeasonId=#session.TeamSeasonID# 
	</cfquery>
	
	<cfquery dbtype="query" name="qDefense">
	Select * from qRoster where PositionGeneral='D' and  TeamSeasonId=#session.TeamSeasonID# 
	</cfquery> 

	 <table class="table-responsive">
		
		 <cfif form.Action is "edit">
	<cfquery name="qGoalStat" datasource="#application.datasource#">
SELECT FinalPlayerId
    FROM [dbo].[vGoalstat]
  where StatType <> 'Assist'
  and GoalId=#form.goalId#	 
		</cfquery>
		
		<cfset PlusMinus=ValueList(qGoalStat.FinalPlayerId)>

	</cfif>
	</table>
		
	 <div colspan="6">
		 Plus/Minus
		</div>

	<table class="table-responsive">

		<tr>
		<td align="center" class="Row-Even" style="text-align: center;" colspan="3">
			<b>OFFENSE</b>
				</td>
		</tr>
	<cfoutput query="qOffense">
<cfif listFindNoCase("1,4,7,10",qOffense.CurrentRow)>
		<tr>
</cfif>
			<td nowrap valign="center" class="MainStats">
				<div class="player-row">
    				<input type="checkbox" class="bigCheckbox" name="PlusMinus" value="#playerId#" id="player#PlayerNumber#" <cfif ListFind(PlusMinus,PlayerId,",","YES")> checked </cfif>>
					 <label for="player#PlayerNumber#" class="player-label" style="font-weight: normal;">
						#PlayerName#
					</label>
				</div>
			</td>
	
<cfif listFindNoCase("3,6,9,12",qOffense.CurrentRow)>
		</tr>
</cfif>		
	</cfoutput>	
			</table>
			

	<table class="table-responsive">
		<tr>
		<td align="center" class="Row-Even" colspan="2" style="text-align: center;">
			<b>DEFENSE</b>
		
			</td>
		</tr>
	<cfoutput query="qDefense">
<cfif listFindNoCase("1,3,5",qDefense.CurrentRow)>
		<tr style="align-items: center;">
</cfif>
			<td nowrap valign="center" class="MainStats">
				 <div class="player-row">
					 <input type="checkbox" name="PlusMinus" class="bigCheckbox"   value="#PlayerId#" <cfif ListFind(PlusMinus,PlayerId,",","YES")> checked </cfif>>
					<label for="player#PlayerNumber#" class="player-label" style="font-weight: normal;">
						<span class="Player-name">#PlayerName#</span>
					</label>
				</div>		
		   </td>
	<cfif listFindNoCase("2,4,7",qDefense.CurrentRow)>	
		</tr>
	</cfif>
	</cfoutput>
			</table>	
<div style="padding: 25px;text-align: center;">	
		 <input type="submit" name="Submit" class="profile-button" style="width: 150px;">
</div>
</div>

  <script>
    $(document).ready(function () {
      $("input[name='teamSeasonId']").change(function () {
        const selectedValue = $(this).val();

        // Make AJAX request
        $.ajax({
          url: "getDropdownOptions.cfm", // URL of the ColdFusion script
          method: "POST",
          data: { teamSeasonId: selectedValue }, // Send the selected radio button value
          dataType: 'json', // Expect JSON response
          success: function (options) {
            // Populate the dropdown
            const dropdown = $("#playerId");
			const dropdown2 = $("#reAssignedPlayerID");
			const dropdown3 = $("#gamesheetAssistPlayerId1");  
			const dropdown4 = $("#reAssignedAssistPlayerId1");    
			const dropdown5 = $("#gamesheetAssistPlayerId2");  
			const dropdown6 = $("#reAssignedAssistPlayerId2");   
			
		
            dropdown.find('option:not(:first)').remove(); // Clear existing options except the first one
			dropdown2.find('option:not(:first)').remove(); // Clear existing options 
	
			dropdown3.find('option:not(:first)').remove(); // Clear existing options
			dropdown4.find('option:not(:first)').remove(); // Clear existing options  
            dropdown5.find('option:not(:first)').remove(); // Clear existing options  
			dropdown6.find('option:not(:first)').remove(); // Clear existing options  
	
			  options.forEach(function (item) {
             dropdown.append(new Option(item.text, item.value));
             dropdown2.append(new Option(item.text, item.value));	
   	         dropdown3.append(new Option(item.text, item.value));	
			 dropdown4.append(new Option(item.text, item.value));	
			 dropdown5.append(new Option(item.text, item.value));	
		     dropdown6.append(new Option(item.text, item.value));			  
			});
          },
          error: function (xhr, status, error) {
            console.error("Error: ", error);
            alert("An error occurred while fetching options. Please try again.");
          }
        });
      });
    });
	

  function validateCheckboxes() {
    const checkboxes = document.querySelectorAll('input[name="PlusMinus"]:checked');
    const minChecked = 3; // Minimum number of checkboxes required

    if (checkboxes.length < minChecked) {
      alert(`Please select at least ${minChecked} Plus/Minus.`);
      return false; // Prevent form submission
    }

    return true; // Allow form submission
  }

  </script>

	</cfif>		
		
	</form>
<!---
<cfif isdefined("qSelectedGame.GamesheetURL")> 
<cfoutput>
	<cfif find("gamesheetstats.com",qSelectedGame.GamesheetURL)>
		<div class="tab-container">
    <div class="tabs">
      <div class="tab active" style="color:black;" data-tab="tab1" Info>Gamesheet</div>
      <div class="tab" style="color:black;" data-tab="tab2">Game Info</div>
    </div>
	
    <div class="iframe-container">
      <iframe id="iframe-tab1" src="#qSelectedGame.GamesheetURL#" style="width:1000px;height:1000px;"></iframe>
	  <iframe id="iframe-tab2" style="width:1200px;height:2000px;" src="stats.cfm?GameId=#form.GameId#&showNavBar=false&ShowGoalSummary=false&ShowEdit=false" style="display: none;"></iframe>
    </div>

  </div>
		<cfelse>
			<cfif len(qSelectedGame.GamesheetURL)>
				<img src="#qSelectedGame.GamesheetURL#" width="1400">
			</cfif>
		</cfif>	
</cfoutput>
<script>
    const tabs = document.querySelectorAll('.tab');
    const iframes = document.querySelectorAll('iframe');

    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        // Remove 'active' class from all tabs
        tabs.forEach(t => t.classList.remove('active'));

        // Hide all iframes
        iframes.forEach(iframe => iframe.style.display = 'none');

        // Add 'active' class to clicked tab
        tab.classList.add('active');

        // Show corresponding iframe
        const tabId = tab.getAttribute('data-tab');
        document.getElementById(`iframe-${tabId}`).style.display = 'block';
      });
    });
	



};
	
  </script>
	</cfif>
--->
</div>


