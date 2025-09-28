<cfparam name="defaultStartDate" default="#session.startofseason#">
<cfparam name="defaultEndDate" default="#session.endofSeason#">
<cfparam name="MinGoalsScored" default="0">
<cfparam name="url.PlayTypeId" default="2,4,5">
<cfparam name="url.PlayType" default="EvenStrength">	
<cfif isDefined("url.defaultStartDate")>
	<cfset form.FilterDateStart=url.defaultStartDate>	
</cfif>

<cfif isDefined("url.defaultEndDate")>
	<cfset form.FilterEndStart=url.defaultEndDate>	
</cfif>
	
<cfif isDefined("url.MinGoalsScored")>
	<cfset form.MinGoalsScored=url.MinGoalsScored>	
</cfif>	
	

	
<cfquery name="qryPowerDetail" datasource="#application.datasource#">
SELECT
<cfif url.PlayType is "EvenStrength"> sg.FWDGRP, <cfelse> sg.FullLine as FWDGrp, </cfif>
goalId,
GameDate,
GoalTypeId
FROM fnGetGoalScoringGroup(#session.TeamSeasonId#) sg
where sg.GoalTypeId <cfif url.PlayType is "EvenStrength"> not </cfif> in (#url.PlayTypeId#) 
<cfif isDefined("form.FilterDateStart")>and gameDate >='#form.FilterDateStart#' </cfif>
<cfif isDefined("form.FilterDateEnd") and len(form.FilterDateEnd)> and gameDate <='#form.FilterDateEnd#' </cfif>
</cfquery> 	
	
	
	
<cfquery name="qryPowerGroups" dbtype="query">
SELECT
FWDGRP, 
Count(goalId) AS Cnt,
Max(GameDate) as LastGoalDate
FROM qryPowerDetail
Group BY  FWDGRP 
<cfif isDefined("form.MinGoalsScored")>
having 	Count(goalId) >= #form.MinGoalsScored#
	</cfif>
	Order BY Cnt desc,LastGoalDate asc
</cfquery> 


	

<cfquery name="qryRoster" datasource="#application.datasource#">
	Select * from vRoster where TeamSeasonId=#session.TeamSeasonId# 
</cfquery>

<cfquery name="qTotalPower" dbtype="query">
	Select Sum(Cnt) as TotalPower,Max(LastGoalDate) as LastTeamGoalDate from qryPowerGroups
</cfquery>

<cfinclude template="#application.includes#header.cfm">
 <div class="content">
	<div> 
	<!---
	<div align="left" style="text-align: left; color:white;text-decoration: underline;margin-left: 10px;">
		<p>
	<b>NOTE: This report have known issues. Displaying it to show what is possible, but realize more work is needed before the report can  be useful and accurate.
			</b>	
		</p>
	</div>
   --->
<div>
	<cfform method="POST" action="#application.displays#DisplayGroups.cfm?PlayType=#url.PlayType#"> 

	<table cellspacing="0" cellpadding="2" width="100%">
		<tr>
<td colspan="7"" class="row-odd">
	Filter By:	
		</td>
		</tr>
	<tr>
		<td class="row-even">	
			Games After Date
		</td>

	<td class="row-even">
			<cfif isDefined("form.FilterDateStart")> 
				<cfset defaultStartDate=Form.FilterDateStart> 
			</cfif>
		<cfoutput> <input type="Date"  name="FilterDateStart" value="#defaultStartDate#" > </cfoutput>
	</td>
	<td class="row-even">
		Games Before Date
		</td>

	<td class="row-even">
			<cfif isDefined("form.FilterDateEnd")> 
				<cfset defaultEndDate=Form.FilterDateEnd> 
			</cfif>
<cfoutput>		<input type="Date" name="FilterDateEnd" value="#defaultEndDate#" > </cfoutput>
	</td>			
	
		<td class="row-even">
	 Min Goals Scored 
		</td>

	<td class="row-even">
			<cfif isDefined("form.MinGoalScored")>
				<cfset MinGoalsScored=form.MinGoalScored>
			</cfif>
		<Select name="MinGoalsScored">
			
			<cfloop from="0" to="11" index="i">
<cfoutput>
	<option value="#i#" <cfif MinGoalsSCored is i> Selected </cfif>>#i#</option>
	</cfoutput>		
	</cfloop>
			</Select>
	</td>
	
	
	<td class="row-even">
		<input type="submit" value="Submit">
		</td>
	</tr>	
		
		</table>
</div>
		</cfform>
<br>
<div style="color:black;text-align:left;margin-left:15px;">
	 <cfif url.PlayType is "EvenStrength">
							 <b>Even-Strength Offensive Report - Includes, short-Handed goals too. </b> 								
	 <cfelse>
								 <b>Power-Play Unit Report -  Empty-Net or Extra Attacker Report</b> 								
	</cfif>	
</div>		 
<br>										   
  <cfif isdefined("form.FilterDateStart")>
	     <cfoutput>
			 <br>
		<table border="0" class="row-odd" style="border: 1px solid black;width: 100%">

					<tr>
						
						<td a style="text-align: right;">
	      						<b>Filter By:</b> 
				<cfif isDefined("form.FilterDateStart") and len(form.FilterDateStart)>Games Greater than this date: 		#form.FilterDateStart#<br>
				</cfif> 		
				
				<cfif isDefined("form.FilterDateEnd") and len(form.FilterDateEnd)>
								Games Less than this date: #form.FilterDateEnd#<br>
				</cfif> 	
				<cfif isDefined("form.MinGoalsScored") and len(form.MinGoalsScored)>
							Goals greater than or equal to #form.MinGoalsScored#<br>
				</cfif>							  		
							<a href="#cgi.SCRIPT_NAME#?PlayType=#url.PlayType#" class="mainLink" style="color: black;">[Remove Filter]</a>
						</td>
					</tr>
					 <tr>
						<td colspan="2" align="center" style="font-size: 25px;text-align: center;width: 100%;">
							<b>Found #qryPowerGroups.Recordcount#  Groups </b>
						 </td>			 
		  			</tr>
			 </table>
			</cfoutput>
		</cfif>					
	

						

<table class="center" style="border:0px;cell-spacing:0px;width:100%;" cellspacing=0>
	<tr>
		<th class="tblHeader">
							 <cfif url.PlayType is "EvenStrength"> Forward Line <cfelse> Power Play</cfif> </td>
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


				<cfif qryPowerGroups.currentRow  mod 2> 
				<cfset classValue="row-even">
						<cfelse>
				<cfset classValue="row-odd">
				</cfif>			

							<tr id="#qryPowerGroups.currentRow#">
		<cfoutput>
		<td class="#classValue#" style="text-align:left">
		</cfoutput>
			<cfquery dbtype="query" name="qGroupName">
				Select * from qryRoster where PlayerNumber in(#qryPowerGroups.FwdGrp#)
			</cfquery>

			<cfoutput query="qGroupName">
				<cfif qGroupName.currentRow is 1>
										 <cfif url.PlayType is "EvenStrength"> <b>Offense:</b> <cfelse> <b>Power Play:</b></cfif> 
										
										
										<br></cfif>
				#PlayerName# <br>
			</cfoutput>	
		</td>
	<cfoutput>
		<td align="center" class="#classValue#" style="text-align:center">
			<cfset FWDGRP=qryPowerGroups.FWDGrp>
			<cfset GoalList="">
		<cfquery dbtype="query" name="qGoals">
		Select * from qryPowerDetail where FWDGrp='#FWDGRP#'									 
											 </cfquery>								 
											   
					<cfset GoalList=ValueList(qGoals.GoalId)>
			<a href="ShowGoals.cfm?GoalList=#GoalList#&FWDGrp=#FWDGRP#&defaultStartDate=#defaultStartDate#&defaultEndDate=#defaultEndDate#&MinGoalsScored=#MinGoalsScored#&PlayType=#url.PlayType#" class="mainLink" style="color: black;text-decoration: underline">
				#qryPowerGroups.cnt#
			</a>
		</td>
		<td align="center" class="#classValue#" style="text-align:center">
			#qryPowerGroups.LastGoalDate#
		</td>
		<td align="center" class="#classValue#" style="text-align:center">
		#Round(Evaluate((qryPowerGroups.cnt/qTotalPower.TotalPower)*100))#%	
		</td>
	</cfoutput>	
	</tr>
	</cfloop>
	<tr>
		<td  style="text-align:left;border-left:1px solid black;border-right:1 px solid white;border-top:1px solid black;border-bottom:1px solid black;background-color:black;color:white;">
		Goals This Season
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
</div>
	

<cfinclude template="#application.includes#footer.cfm">