<cfparam name="attributes.GameId">
<cfparam name="attributes.PenaltyID" default="">
<cfparam name="attributes.PenaltyUnitTypeId" default="1">
<cfparam name="attributes.PenaltyTimeTypeId" default="1">
<cfparam name="attributes.Period" default="1">
<cfparam name="attributes.TeamSeasonId" default="#session.TeamSeasonId#">
<cfparam name="attributes.PlayerId" default="">
<cfparam name="attributes.PenaltyLength" default="1.5">
<cfparam name="attributes.PenaltyStart" default="">
<cfparam name="attributes.PenaltyStartPoint" default="">
<cfparam name="attributes.PenaltyStopPoint" default="">	
<cfparam name="attributes.SelectedValues" default="">

	
	
	
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
	<div class="game-wrapper">

<form action="SavePenalty.cfm" method="post">
	<cfoutput>
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
	<label>
	Time of Penalty
	</label>
   <cfoutput>	
	 <label>
      <input type="text"  name="PenaltyStart" pattern="^[0-5]?[0-9]:[0-5][0-9]$" placeholder="MM:SS" required value="#attributes.PenaltyStart#"  style="width:75px;"> 
    </label>
	</cfoutput> 
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
<cf_CtrlSelectPlayers TeamId="#session.TeamId#" ControlName="PenaltyUnitList" ControlLabel="Power Play" selectedValue="#attributes.SelectedValues#"> 
	</div>
	
<div align="center">
<cfoutput>
	<input type="hidden" name="GameId" value="#attributes.GameId#"></cfoutput>
	<input type="submit" class="submit-button" value="Save Penalty">	
</div>
		
	</form>
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
		function resizeIframe(obj) {
  obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
}
	</script>