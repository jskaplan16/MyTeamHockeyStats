<cfquery datasource="#application.datasource#" name="qTeams">
Select * from tblTeam
</cfquery>

<cfform name="AddTeam" action="EditRoster.cfm">
<table align="center" >
	<tr>
		<td>
			Edit Roster
		</td>
		<td>
		<cfselect query="qTeams" name="SwitchTeamId" size="1" value="teamId" display="TeamName"></cfselect>

		</td>
		<td>
			<input type="submit" name="submit">
		</td>
	</tr>
</table>
</cfform>
	<cfform name="AddTeam" action="ActionAddPlayer.cfm">
<table align="center" style="margin-top:50px;">
	<tr>
		<td>
		Add Player
		</td>
	<tr>
		<td>		
<b>Select Team</b>
		</td>
		<td>	
		<cfselect query="qTeams" name="TeamId" size="1" value="teamId" display="TeamName"></cfselect>
		</td>
	</tr>
	<tr>
		<td>
	<b>Player Name</b> 
		</td>
		<td>			
		<cfinput name="PlayerName" maxlength="50" required="true" type="text" message="Player Name field is required">
		</td>
	</tr>
	

<tr>
	<td>
	<b>Player Number</b> 
	</td>	
<td>
		<cfinput name="PlayerNumber" maxlength="2" type="text"  required="true" message="Player Number field is required">
	</td>
</tr>
<tr>
	<td colspan="2" style="text-align:center">
<cfinput type="submit" name="submit">	
	</td>
	</cfform>
	</table>
