<cfquery name="qryPowerGroups" datasource="#application.datasource#">
SELECT
sg.fullLine,
Count(goalId) AS Cnt,
Max(GameDate) as LastGoalDate
FROM vScoringGroup sg
where sg.GoalType in ('Power Play','Empty net','Extra attacker') 
Group BY sg.Fulline
Order BY Max(GameDate) asc,Cnt desc
</cfquery> 



<cfquery name="qryRoster" datasource="#application.datasource#">
	Select * from tblRoster where TeamId=16 
</cfquery>

<cfquery name="qTotalPower" dbtype="query">
	Select Sum(Cnt) as TotalPower,Max(LastGoalDate) as LastTeamGoalDate from qryPowerGroups
</cfquery>

<cfinclude template="includes/headers/Header.cfm">
<br>	
<table class="center" style="border:0px;cell-spacing:0px;width:100%;" cellspacing=0>
	<tr>
		<th class="tblHeader">
			Forward Power Play Line
		</th>
		<th class="tblHeader">
			&#35; of Goals
		</th>
		<th class="tblHeader">
			Last Goal Date
		
		</th>
		<th class="tblHeader">
			% of Goals
		</th>
	</tr>
	
	<cfloop query="qryPowerGroups">
<cfquery name="qryPowerDefGroups" datasource="#application.datasource#">
SELECT
sg.DGRP
FROM vScoringGroup sg
where sg.GoalType  in ('Power Play','Empty net','Extra attacker') 
and   sg.FwdGrp in ('#qryPowerGroups.FwdGrp#')
</cfquery> 


				<cfif qryPowerGroups.currentRow  mod 2> 
				<cfset classValue="rowOn">
						<cfelse>
				<cfset classValue="rowOff">
				</cfif>			

							<tr>
		<cfoutput>
		<td class="#classValue#">
		</cfoutput>
			<cfquery dbtype="query" name="qGroupName">
				Select * from qryRoster where PlayerNumber in(#qryPowerGroups.FwdGrp#)
			</cfquery>

			<cfquery dbtype="query" name="qDefGroupName">
				Select * from qryRoster where PlayerNumber in(#qryPowerDefGroups.DGrp#)
			</cfquery>

			<cfoutput query="qGroupName">
				<cfif qGroupName.currentRow is 1><b>Offense:</b><br></cfif>
				#PlayerName# <br>
			</cfoutput>	
			<cfoutput query="qDefGroupName">
								<cfif qDefGroupName.currentRow is 1><b>Defense:</b><br></cfif>
				#PlayerName# <br>
			</cfoutput>	
								
		</td>
	<cfoutput>
		<td align="center" class="#classValue#">
			<a href="GoodGroupsPowerPlay.cfm?GroupGoals_PowerPlay&FWDGrp=#FWDGRP#" class="mainLink" style="color: black;text-decoration: underline">
				#qryPowerGroups.cnt#
			</a>
		</td>
		<td align="center" class="#classValue#">
			#qryPowerGroups.LastGoalDate#
		</td>
		<td align="center" class="#classValue#">
		#Evaluate((qryPowerGroups.cnt/qTotalPower.TotalPower)*100)#%	
		</td>
	</cfoutput>	
	</tr>
	</cfloop>
	<tr>
		<td  style="text-align:left;border-left:1px solid black;border-right:1 px solid white;border-top:1px solid black;border-bottom:1px solid black;background-color:black;color:white;">
		Totals Power Play Goals This Season
		</td>
		<td  style="text-align:center;border-center:1px solid black;border-right:1 px solid white;border-top:1px solid black;border-bottom:1px solid black;background-color:black;color:white;">
			<cfoutput>#qTotalPower.TotalPower#</cfoutput>
		</td>
				<td  style="text-align:center;border-left:1px solid black;border-right:1 px solid white;border-top:1px solid black;border-bottom:1px solid black;background-color:black;color:white;">
		<cfoutput>#qTotalPower.LastTeamGoalDate#</cfoutput>
		</td>
		
		<td  style="text-align:center;border-left:1px solid black;border-right:1 px solid white;border-top:1px solid black;border-bottom:1px solid black;background-color:black;color:white;">
		100%
		</td>
		
		</tr>
</table>
<br>
	
<cfif isDefined("url.FWDGrp")>
	 
<cfquery name="qryPowerGoals" datasource="#application.datasource#">
SELECT
distinct GoalId	
FROM vScoringGroup sg
where sg.GoalType='Power Play' 
and  FWDGrp in ('#url.FWDGrp#')
</cfquery> 
	<cfset GoalList = ValueList(qryPowerGoals.goalId)>

<cf_displaygoalsbyGoals GoalList="#goalList#" showGame="true">
</cfif>	

<cfinclude template="includes/footers/Footer.cfm">