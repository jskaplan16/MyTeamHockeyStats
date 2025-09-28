<cfinclude template="includes/headers/Header.cfm">
	<cfquery name="qGames" datasource="#application.datasource#">
			Select GameId, Game,   Convert(varchar(10),GameDate,101) + ' ' + Game as GameName  from tblGame 
		Where MainTeamId=#session.TeamId#
		Order by GameDate desc 
		
	</cfquery>
<cfform action="DisplayEnterGame.cfm" method="POST">
	<input type="hidden" name="Action" value="EditGame">
	<div align="left">
	<label>Select Game</label>
	<cfselect name="GameId" value="GameId" query="qGames" display="GameName"/>	
	</div>
	<input type="Submit" name="Submit">
</cfform>	
		
<cfinclude template="includes/footers/Footer.cfm">>