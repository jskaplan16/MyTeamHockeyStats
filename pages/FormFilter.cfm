<cfparam name="attributes.ActionPagName">
<cfparam name="url.PlayType" default="EvenStrength">	
<cfparam name="attributes.ActionQueryString" default="Evaluate(?PlayType=#url.PlayType#)">
<cfparam name="attributes.FilterDateStart">
<cfparam name="attributes.FilterDateEnd">	
<cfparam name="attributes.MinGoalsScored" default="100">
<cfparam name="attributes.MinGoalScoreOn" default="True">
<cfparam name="attributes.FilterByTournamentOn" default="False">
<cfparam name="attributes.TournamentId" default="">
<cfparam name="attributes.RankingId" default="0">
	
	<cfif Attributes.FilterByTournamentOn>
		<cfquery datasource="#application.datasource#" name="qTournament">
    exec stpGetTournaments @teamSeasonId=#session.TeamSeasonId#
		</cfquery>

	</cfif>

 

  	<cfquery datasource="#application.datasource#" name="qRating"> 
exec stpGetRanking 
	</cfquery>


	




    <!-- Table content -->



<cfswitch expression='#thisTag.ExecutionMode#'>
	<cfcase value='start'>
			<cfform method="POST" action="#attributes.ActionPagName##attributes.ActionQueryString#"> 

	<div class="game-wrapper">
  <table cellspacing="0" cellpadding="2" class="filterTable">
				


				<tr class="form-filter-row">
					<td>	
						<b>After</b> 
					</td>

				<td>
					<cfoutput> <input type="Date"  name="FilterDateStart" value="#DateFormat(attributes.FilterDateStart,"yyyy-mm-dd")#" > </cfoutput>
				</td>
				<td>
					<b>Before</b>
					</td>

				<td>
			<cfoutput>		
				<input type="Date" name="FilterDateEnd" value="#DateFormat(attributes.FilterDateEnd,"yyyy-mm-dd")#" > 
					</cfoutput>
				</td>	
				
<!---			
			<cfif attributes.FilterByTournamentOn>					 
					<td>
				 <b>Tournament</b> 
					</td>

				<td>			
				<Select name="TournamentId" onChange="submit()">
					<option value="">Select Tournament</option>
						<cfoutput query="qTournament">
					<option value="#TournamentId#" <cfif attributes.TournamentId is qTournament.TournamentId> Selected </cfif> >#qTournament.TournamentName#</option>
						</cfoutput>		
				</Select>
				</td>
				
				<td>
				<b> Opp. Ranking</b> 
				</td>
				<td> 
					<select name="RankingId" onChange="submit()">
					
						<cfoutput query="qRating">
						<option value="#RankingId#" <cfif attributes.RankingId is RankingId> selected </cfif>>#RankingDescription#</option>
						</cfoutput>	
					</select> 
				</td>
	
			</cfif>		   
			--->
					
				<cfif attributes.MinGoalScoreOn>					 
					<td>
				 Min Goals Scored 
					</td>

							<td >			
				<Select name="MinGoalsScored">

						<cfloop from="0" to="100" index="i">
			<cfoutput>
				<option value="#i#" <cfif attributes.MinGoalsScored is i> Selected </cfif>>#i#</option>
				</cfoutput>		
				</cfloop>
						</Select>
				</td>
					</cfif>
<td style="width:250px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>
<cfoutput>
					<input type="submit" value="Submit">
					<a href="/#attributes.ActionPagName#" class="grid-link">[Clear]</a>
</cfoutput>			
	</td>
	
				</tr>	

					</table>
			</div>
					</cfform>
		</cfcase>


		<cfcase value='end'>

		</cfcase>
	</cfswitch>	
