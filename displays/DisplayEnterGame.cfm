<cfparam name="attributes.navBar"  default="true" >
<cfparam name="form.ResultTypeId" default="">
<cfparam name="form.Game" default="">
<cfparam name="form.GameDate" default="">
<cfparam name="form.OpponentTeamSeasonId" default="">
<cfparam name="form.OpponentTeamScore" default="">	
<cfparam name="form.MainTeamScore" default="">	
<cfparam name="form.GamesheetURL" default="">	
<cfparam name="form.VideoEmbed" default="">	
<cfparam name="form.FullGameVideoURL" default="">
<cfparam name="form.GameVideoId" default="">
<cfparam name="url.action" default="Insert">
<cfparam name="url.showHeader" default="Yes">			
	
<cfif isDefined("url.Action") and url.Action is "Edit">
	<cfquery name="qGameInfo" datasource="#application.datasource#">
		Select GameVideoId,ResultTypeId,GameId,GameDate,OpponentTeamScore,MainTeamScore,OpponentTeamSeasonId,GamesheetURL,VideoEmbed,FullGameVideoURL,Game,MainTeamSeasonId
		from vGames 
		where GameId=#session.selectedGameId#	
		and MainTeamSeasonId=#Session.teamSeasonId#
		
	</cfquery>
	
	<cfset form.ResultTypeId=qGameInfo.ResultTypeId>
	<cfset form.GameDate=qGameInfo.GameDate>
	<cfset form.Game=qGameInfo.Game>	
	<cfset form.OpponentTeamSeasonId=qGameInfo.OpponentTeamSeasonId>
	<cfset form.OpponentTeamScore=qGameInfo.OpponentTeamScore>
	<cfset form.MainTeamScore=qGameInfo.MainTeamScore>
    <cfset form.GamesheetURL=qGameInfo.GamesheetURL>
	<cfset form.VideoEmbed=qGameInfo.VideoEmbed>
	<cfset form.FullGameVideoURL=qGameInfo.FullGameVideoURL>
	<cfset form.GameVideoId=qGameInfo.GameVideoId>
	<cfset action="Edit">
</cfif>
	
<cfquery name="qTeams" datasource="#application.datasource#">
	Select * from vTeam 
	where MainTeamSeasonId=#session.TeamSeasonId#
	Order by TeamId desc 
</cfquery>

<cfquery name="qResult" datasource="#application.datasource#">
	SELECT  [ResultTypeId]
      ,[ResultType]
      ,[ParentResultTypeId]
      ,[ParentResultType]
  FROM [dbo].[vResultType]
</cfquery>
<cfif attributes.navBar>
<cfinclude template="includes/headers/Header.cfm">
</cfif>
<cfoutput>
	
    <div class="content">
         <div class="PageHeader">
		 	<cfif action is "Insert">
			Enter New Game
			<cfelse>
			Edit Game
			</cfif>
		 </div>

  </cfoutput>		
	

<table>
<tr>

	<cfif isDefined("url.Action") and url.Action is not "Edit">
<td class="TdCellLeftTtl">
		&nbsp;
		
</td>	
	<cfelse>
	<td class="TdCellLeftTtl">
		Game:
		
</td>	
<td class="TdCellLeftTtl">
<cfoutput> #session.selectedGame# </cfoutput>
		
</td>

	</tr>	

</cfif>

	<form action="SaveGame.cfm" method="post" enctype="multipart/form-data">	
		<cfoutput>
	
<tr>
	<td class="TdCellLeftTtl">				
	<input type="hidden" name="Action" value="#Action#">
<cfif structKeyExists(session,"selectedGameId")>
	<input type="hidden" name="GameId" value="#session.SelectedGameId#">
</cfif>					
	Game Date
	</td>
<td> <input type="Date" name="GameDate" value="#form.GameDate#" class="inputFld"></td>
		</tr>
			
<tr>
	<td class="TdCellLeftTtl">
	Opponent Team 	
	<!--- hidden field for the main team season ID --->
	<input type="hidden" name="MainTeamSeasonId" value="#session.TeamSeasonId#">		
	</td>
</cfoutput>

	<td>

	<select id="opponentTeamSeasonId" name="opponentTeamSeasonId" class="inputFld">
		<option value=""></option>
		<cfoutput query="qTeams">
			<option value="#TeamSeasonId#" <cfif len(form.OpponentTeamSeasonId) and qTeams.TeamSeasonId is form.OpponentTeamSeasonId> selected </cfif>>#TeamName#</option>
			</cfoutput>
	</select>
	</td>
	</tr>

<cfoutput>
		<tr>
		<td class="TdCellLeftTtl" nowrap>
			<label style="padding-right: 50px;"> Game Name</label>
		</td>
		<td>
				<input type="text" name="Game" id="game" size="50" value="#form.Game#" class="inputFld">			
		</td>
		</tr>		

		<tr>
		<td class="TdCellLeftTtl" nowrap>
#Session.TeamName# Score 
	</td>
		<td>
	<input name="MainTeamScore" type="number" required="Yes" style="width:100px;" value="#form.MainTeamScore#">	
	   </td>
		</tr>

		<tr>
		<td class="TdCellLeftTtl" nowrap>
<span id="opponentTeam" ></span> Score 
	</td>
			
		<td>
	<input name="OpponentTeamScore" type="number" required="Yes" style="width:100px;" value="#form.OpponentTeamScore#">	
	   </td>
		</tr>
</cfoutput>
<tr>
		<td class="TdCellLeftTtl" nowrap>
	 Result Type
	
	 </td>
	<td>

		<select id="ResultTypeId" name="ResultTypeId" class="inputFld">
		<option value="">Select Result</option>
		<cfoutput query="qResult">
			<option value="#ResultTypeId#" 
			<cfif len(form.ResultTypeId) and qResult.ResultTypeId is form.ResultTypeId> selected </cfif>>#ResultType#</option>
		</cfoutput>
	</select>
	
	</td>
		</tr>	   

	<cfoutput>	
		<tr>
<td class="TdCellLeftTtl" nowrap style="vertical-align: top;">
			Gamesheet URL
	</td>
	<td>
				<textarea name="GamesheetURL" cols="50" rows="5">#form.GamesheetURL#</textArea>
		 <br>
				<small>No Gamesheet URL? Manually upload File</small> 
				<input type="File" name="ManualGamesheet">
			</td>
		</tr>
		
		<tr>
<td class="TdCellLeftTtl" nowrap style="vertical-align: top;">
			Full Game Video URL
	</td>
		<td>
				<textarea name="FullGameVideoURL" id="FullGameVideoURL" cols="50" rows="5">#form.FullGameVideoURL#</textArea>
				<input type="hidden" id="GameVideoId" name="GameVideoId" value="#form.GameVideoId#">
                <input type="hidden" id="VideoEmbed" name="VideoEmbed" value="#form.VideoEmbed#">
			<br> 
			<!---
				<small><a href="#session.VideoSite#" class="mainLink" target="_blank" style="color:white;">#session.VideoSite#</a></small>
			--->
			</td>
		</tr>

		<tr>
<td class="TdCellLeftTtl" nowrap style="vertical-align: top;">
			Base Embed URL
	</td>
		<td>
				<label id="lblVideoEmbed">#form.GameVideoId#</label>
			
			</td>
		</tr>
	
	<tr>
<td class="TdCellLeftTtl" nowrap>
			Game Video ID
	</td>
		<td>
			<label id="lblgameVideoId">#form.VideoEmbed#</label> 			
			</td>
		</tr>	
		</cfoutput>
	
		<tr>
			<td colspan="2" align="center" style="align-items: center;text-align:center;">
				<input type="submit" name="submit" style="width:125px;">
			</td>
		</tr>
	
		
		</table>
 	</form>		
	</div> <!-- content -->
	</div> <!-- container -->
 <script>
        $('#opponentTeamSeasonId').on('change', function() {
            var selectedText = $('#opponentTeamSeasonId option:selected').text();
            $('#opponentTeam').text(selectedText);
			$('#game').val(selectedText);
		
        });

        // Trigger the change event initially to display the default selected option
        $('#opponentTeamSeasonId').trigger('change');



function extractGameVideoId(inputString) {
    // Try /live/ VIDEO ID pattern
    let match = inputString.match(/\/live\/([^?&#]+)/);
    if (match && match[1]) {
        return match[1];
    }
    // Try standard ?v= VIDEO ID pattern
    match = inputString.match(/[?&]v=([^?&#]+)/);
    if (match && match[1]) {
        return match[1];
    }
    return null;
}
document.getElementById('FullGameVideoURL').addEventListener('input', function() {
	const input = this.value;
	const videoId = extractGameVideoId(input);
	 if (videoId) {
        // Always use  for getElementsByName if the element exists
        const gameVideoIdElem = document.getElementById('GameVideoId');
        const videoEmbedElem = document.getElementById('VideoEmbed');
        const lblVideoEmbedElem = document.getElementById('lblVideoEmbed');
        const lblgameVideoIdElem = document.getElementById('lblgameVideoId');

        if (gameVideoIdElem) {
            gameVideoIdElem.value = videoId;
        }
        if (lblgameVideoIdElem) {
            lblgameVideoIdElem.innerText = videoId;
        }
        if (videoEmbedElem) {
            videoEmbedElem.value = `https://www.youtube.com/embed/${videoId}?start=`;
        }
        if (lblVideoEmbedElem) {
            lblVideoEmbedElem.innerText = `https://www.youtube.com/embed/${videoId}?start=`;
        }
    }
});
    </script>





<cfif attributes.navBar>
<cfinclude template="includes/footers/Footer.cfm">
</cfif>
