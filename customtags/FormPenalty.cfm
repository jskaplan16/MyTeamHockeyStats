<cfparam name="attributes.GameId">
<cfparam name="attributes.PenaltyID" default="">
<cfparam name="attributes.PenaltyUnitTypeId" default="1">
<cfparam name="attributes.PenaltyTimeTypeId" default="1">
<cfparam name="attributes.Period" default="1">
<cfparam name="attributes.TeamSeasonId" default="#session.TeamSeasonId#">
<cfparam name="attributes.PlayerId" default="">
<cfparam name="attributes.PenaltyLength" default="2.0">
<cfparam name="attributes.PenaltyStart" default="">
<cfparam name="attributes.PenaltyEnd" default="">
<cfparam name="attributes.PenaltyStartPoint" default="">
<cfparam name="attributes.PenaltyStopPoint" default="">	
<cfparam name="attributes.SelectedValues" default="">
<cfparam name="attributes.PenaltyGoalId" default="">

	
	
	
	<cfquery name="qGameInfo" datasource="#Application.DataSource#">
		SELECT GameVideoID,GamesheetURL,OpponentTeam,OpponentTeamSeasonId,MainTeam,MainTeamSeasonId FROM vGames
		 where GameId=#attributes.GameId#
	</cfquery>
	
	<cfquery name="qPenaltyUnitType" datasource="#Application.DataSource#">
	SELECT [PenaltyUnitTypeId]
      ,[PenaltyUnitType]
      ,[PenaltyUnitCode]
	  FROM [dbo].[tblPenaltyUnitType]
	</cfquery>

	<cfquery name="qPentaltyTimeType" datasource="#Application.Datasource#">
	SELECT  [PenaltyTimeTypeId]
      ,[PenaltyTimeType]
  FROM .[dbo].[tblPenaltyTimeType]
	</cfquery>
	
	<cfquery name="qRoster" datasource="#application.datasource#">
exec stpGetRoster @TeamSeasonId=#qGameInfo.MainTeamSeasonId#,@OpponentTeamSeasonId=#qGameInfo.OpponentTeamSeasonId#
			</cfquery>	
	
	<cfquery dbtype="query" name="qDefaultRoster">
		Select * from qRoster where TeamSeasonId=<cfif len(attributes.TeamSeasonId)>#attributes.TeamSeasonId#<cfelse>#qGameInfo.MainTeamSeasonId#</cfif>	   
	</cfquery>
	<cfoutput>
	<div class="game-wrapper">
		<div style="display: table-cell;width: 50%;text-align: left;padding-left: 25px;">
			<a href="#application.displays#DisplayGameSheetViewer.cfm?GameId=#attributes.gameId#" target="_blank">
				<img src="#application.images#GamesheetsIcon.png" width="100" style="padding: 5px;"></a>
		</div>
	</cfoutput>
	<cfoutput>
<form action="#Application.actions#ActionSavePenalty.cfm" method="post">
	
<input type="hidden" name="PenaltyId" value="#attributes.PenaltyId#">
		</cfoutput>
<div class="row-odd" style="text-align: left;padding: 5px;">
<label> Period</label>

	<cfloop from="1" to="3" index="i">
	<cfoutput>
	<div style="display: inline;padding-left: 75px;">Period #i# </label>	<input type="radio" name="Period" value="#i#" required <cfif attributes.Period is i> checked </cfif> >
</div>
	</cfoutput>
		</cfloop>
	</div>
<div class="row-Odd" style="text-align: left;padding: 5px;">
  <div style="display:inline-block;margin-right:30px;">
    <label>
      Time of Penalty (Game clock - start time)
    </label>
    <cfoutput>
      <label>
        <input type="text" name="PenaltyStart" pattern="^[0-5]?[0-9]:[0-5][0-9]$" placeholder="MM:SS" required value="#attributes.PenaltyStart#" style="width:75px;">
      </label>
    </cfoutput>
  </div>
  <div style="display:inline-block;">
    <label>
      Time of Penalty End (Game clock - End time)
    </label>
    <cfoutput>
      <label>
        <input type="text" name="PenaltyEnd" pattern="^[0-5]?[0-9]:[0-5][0-9]$" placeholder="MM:SS" value="#attributes.PenaltyEnd#" style="width:75px;">
      </label>
    </cfoutput>
  </div>
</div>

	
<div class="row-even" style="text-align: left;padding: 15px;">

	<label>
	Which Team was Penalized:
	</label>
   <cfoutput>	
   
	 <label>
      <input type="radio" name="teamSeasonId" value="#qGameInfo.MainTeamSeasonId#"  <cfif qGameInfo.MainTeamSeasonId is attributes.TeamSeasonId> checked </cfif>>#qGameInfo.MainTeam#
    </label>
	
	<label>
      <input type="radio" name="teamSeasonId" value="#qGameInfo.OpponentTeamSeasonId#"  <cfif qGameInfo.OpponentTeamSeasonId is attributes.TeamSeasonId> checked </cfif>> #qGameInfo.OpponentTeam#
    </label>
	
	</cfoutput> 
</div>

<div class="row-even" style="text-align: left;padding: 15px;">

	Associate goal.
	</label>
<cfset penaltyGoalSelected = attributes.PenaltyGoalId>
<cfoutput>
<select
	name="PenaltyGoalId"
	id="penaltyGoalId"
	style="width:400px;"
	data-selected="#penaltyGoalSelected#"
	data-fetch-url="#application.actions#ActionPenaltyGoals.cfm"
	data-game-id="#attributes.GameId#"
>
	<option value="">Please select goal</option>
	<option value="0" <cfif penaltyGoalSelected eq "0">selected</cfif>>Undefined</option>
</select>
</cfoutput>
</div>



<div class="row-odd" style="text-align: left;padding: 5px;">

	<label>	Penalized Player Player</label>
	
	   <select id="playerId" name="PlayerId" style="width:400px;" >
      <option value="">Please select player</option>
	  <option value="0">Undefined</option>
<cfoutput query="qDefaultRoster">
	<option value="#PlayerId#" <cfif attributes.PlayerId is qDefaultRoster.PlayerId> selected </cfif> >
			#PlayerName#
	</option>
		   </cfoutput>
</select>
	</div>
	
<div class="row-even">
<cf_FormVideoSelector DefaultVideoLink="#qGameInfo.GameVideoID#" startPoint="#attributes.PenaltyStartPoint#" stopPoint="#attributes.PenaltyStopPoint#">
</div>
<div class="row-odd" style="text-align: left;padding: 5px;">
		<label>Penalty Time Type:</label>
	<cfoutput query="qPentaltyTimeType">
    <label>
      <input type="radio" name="PenaltyTimeTypeId" value="#PenaltyTimeTypeId#"  <cfif PenaltyTimeTypeId is attributes.PenaltyTimeTypeId> checked </cfif>> #PenaltyTimeType#
    </label>
			</cfoutput> 
	
</div>
	
<div class="row-even" style="text-align: left;padding: 5px;">
	<label>
	Penalty Length
	</label>
   <cfoutput>	
	 <label>
      <input type="text"  name="PenaltyLength" value="#attributes.PenaltyLength#"  style="width:75px;"> 
    </label>
	</cfoutput> 
</div>			

	<div class="row-odd" style="text-align: left;padding: 5px;">
	<label>Penalty Unit Type:</label>
	<cfoutput query="qPenaltyUnitType">
    <label>
      <input type="radio" name="PenaltyUnitTypeId" value="#PenaltyUnitTypeId#"  <cfif PenaltyUnitTypeId is attributes.PenaltyUnitTypeId> checked </cfif>> 
	
		#PenaltyUnitType#
    </label>
			</cfoutput> 
</div>	
	<div class="row-odd">
<cf_CtrlSelectPlayers TeamSeasonId="#session.TeamSeasonId#" ControlName="PenaltyUnitList" ControlLabel="Power Play" selectedValue="#attributes.SelectedValues#"> 
	</div>
	
<div align="center">
<cfoutput>
	<input type="hidden" name="GameId" value="#attributes.GameId#"></cfoutput>
	<input type="submit" class="submit-button" value="Save Penalty">	
</div>
		
	</form>
</div>


<cfoutput>
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
            const dropdown = $("##playerId");

            dropdown.find('option:not(:first)').remove(); // Clear existing options except the first one

            options.forEach(function (item) {
              dropdown.append(new Option(item.text, item.value));
            });
          },
          error: function (xhr, status, error) {
            console.error("Error: ", error);
            alert("An error occurred while fetching options. Please try again.");
          }
        });
      });
    });

    document.addEventListener('DOMContentLoaded', function () {
      const penaltyGoalSelect = document.getElementById('penaltyGoalId');
      if (!penaltyGoalSelect) {
        return;
      }

      const fetchUrl = penaltyGoalSelect.dataset.fetchUrl;
      const gameId = penaltyGoalSelect.dataset.gameId;
      const baseOptions = [
        { value: '', text: 'Please select goal' }
      ];

      function setBaseOptions(selectedValue) {
        penaltyGoalSelect.innerHTML = '';
        baseOptions.forEach(function (opt) {
          const option = new Option(opt.text, opt.value);
          if (opt.value === selectedValue) {
            option.selected = true;
          }
          penaltyGoalSelect.appendChild(option);
        });
      }

      function populateGoalOptions(goals, selectedValue) {
        setBaseOptions(selectedValue);
        goals.forEach(function (goal) {
          const labelParts = [];
          if (goal.GoalNumber !== undefined && goal.GoalNumber !== null && goal.GoalNumber !== '') {
            labelParts.push('Goal ' + goal.GoalNumber);
          }
          if (goal.PenaltyGoalDesc) {
            labelParts.push(goal.PenaltyGoalDesc);
          }
          if (goal.TeamName) {
            labelParts.push('(' + goal.TeamName + ')');
          }
          const optionText = labelParts.join(' - ') || 'Goal ' + goal.GoalId;
          const option = new Option(optionText, goal.GoalId);
          if (String(goal.GoalId) === selectedValue) {
            option.selected = true;
          }
          penaltyGoalSelect.appendChild(option);
        });
      }

      async function fetchGoals(teamSeasonId, selectedValue) {
        if (!teamSeasonId) {
          setBaseOptions(selectedValue);
          return;
        }
        try {
          const url = new URL(fetchUrl, window.location.origin);
          url.searchParams.set('teamSeasonId', teamSeasonId);
          if (gameId) {
            url.searchParams.set('gameId', gameId);
          }

          const response = await fetch(url.toString(), {
            headers: {
              'Accept': 'application/json'
            }
          });

          if (!response.ok) {
            throw new Error('Network response was not ok');
          }

          const data = await response.json();
          const goals = Array.isArray(data) ? data : [];
          populateGoalOptions(goals, selectedValue);
        } catch (error) {
          console.error('Error fetching penalty goals:', error);
          setBaseOptions(selectedValue);
        }
      }

      const mainTeamSeasonId = "#encodeForJavaScript(qGameInfo.MainTeamSeasonId)#";
      const opponentTeamSeasonId = "#encodeForJavaScript(qGameInfo.OpponentTeamSeasonId)#";

      function getSelectedTeamSeasonId() {
        const radio = document.querySelector("input[name='teamSeasonId']:checked");
        return radio ? radio.value : '';
      }

      function getAssociatedTeamSeasonId(teamSeasonId) {
        if (teamSeasonId === mainTeamSeasonId) {
          return opponentTeamSeasonId;
        }
        if (teamSeasonId === opponentTeamSeasonId) {
          return mainTeamSeasonId;
        }
        return '';
      }

      const initialSelectedValue = penaltyGoalSelect.dataset.selected || '';
      setBaseOptions(initialSelectedValue);
      const teamRadios = document.querySelectorAll("input[name='teamSeasonId']");
      teamRadios.forEach(function (radio) {
        radio.addEventListener('change', function () {
          const associatedTeamSeasonId = getAssociatedTeamSeasonId(radio.value);
          fetchGoals(associatedTeamSeasonId, penaltyGoalSelect.value || '');
        });
      });

      fetchGoals(getAssociatedTeamSeasonId(getSelectedTeamSeasonId()), initialSelectedValue);
    });

    function resizeIframe(obj) {
      obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
    }
</script>
</cfoutput>