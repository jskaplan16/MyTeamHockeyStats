<cfparam name="attributes.TeamSeasonId" default="#session.TeamSeasonId#">
<cfparam name="attributes.selectedValue" default="">
<cfparam name="attributes.ControlName">
<cfparam name="attributes.ControlLabel">
<cfset selectList=attributes.selectedValue>
<cfquery name="qRoster" datasource="#application.datasource#">
exec stpGetRoster @TeamseasonId=#attributes.TeamSeasonId#
			</cfquery>	

<cfquery dbtype="query" name="qOffense">
	Select * from qRoster where PositionGeneral='FWD' and TeamSeasonId=#attributes.TeamSeasonId#
	</cfquery>
	<cfquery dbtype="query" name="qDefense">
	Select * from qRoster where PositionGeneral='DEF'
	and TeamSeasonId=#attributes.TeamSeasonId#
	</cfquery> 

		
	 <div style="text-align: left;">
		<cfoutput> #attributes.ControlLabel#</cfoutput>
		</div>
	<table class="table-responsive">
		<tr class="header-game-row">
			<td align="center" colspan="3" style="color:white;text-align: center;">
			<b>FORWARDS</b>
			</td>
		</tr>
<cfoutput query="qOffense">
		<cfif listFindNoCase("1,4,7,10",qOffense.currentRow) >
		<tr style="align-items: center;">
		</cfif>


			<td nowrap valign="center" class="MainStats">
			
				<div class="player-row">
    				<input type="checkbox" class="bigCheckbox" name="#attributes.ControlName#" value="#playerId#" id="player#PlayerNumber#" <cfif ListFind(selectList,PlayerId,",","YES")> checked </cfif>>
					 <label for="player#PlayerNumber#" class="player-label">
						<span class="player-name">#PlayerName#</span>
					</label>
				</div>
			</td>
			<cfif listFindNoCase("3,6,9,12",qOffense.currentRow) >
				</tr>
			</cfif>
		</cfoutput>	
		   
			</td>
		</tr>
			</table>

	<table class="table-responsive">
		<tr class="header-game-row">
		<td align="center" colspan="2" style="color:white;text-align: center;">
			<b>DEFENSE</b>
			</td>
		</tr>
	<cfoutput query="qDefense">
	<cfif listFindNoCase("1,3,5",qDefense.currentRow) >
		<tr style="align-items: center;">
	</cfif>
			<td nowrap valign="center" class="MainStats">
				
			
				 <div class="player-row">
					 <input type="checkbox" name="#attributes.ControlName#" class="bigCheckbox"   value="#PlayerId#" <cfif ListFind(selectList,PlayerId,",","YES")> checked </cfif>>
					<label for="player#PlayerNumber#" class="player-label">
						<span class="Player-name">#PlayerName#</span>
					</label>
				</div>
				
		   </td>
<cfif listFindNoCase("2,4,6",qDefense.currentRow)>
		</tr>
</cfif>
		</cfoutput>	
			</table>	