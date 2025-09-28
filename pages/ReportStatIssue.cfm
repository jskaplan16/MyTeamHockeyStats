<cfif not StructKeyExists(session,"username")>
<cflocation url="index.cfm">
</cfif>

<cfinclude template="includes/headers/Header.cfm">

	<div class="content">
		<div class="PageHeader">
	<cfoutput>			#session.TeamName# - Report Stat Issue</cfoutput>
		</div>	
<cfif isDefined("form.GoalId")>
	
	<cfquery datasource="#Application.Datasource#" name="qInsertIssue">
	 exec  stpInsertGoalIssue @GoalId=#form.goalId#, 
			 				@GoalIssue='#form.StatIssue#'
	</cfquery>

	<cfif qInsertIssue.recordcount> 



	<cfmail
    to="jskaplan@gmail.com"
    from="mailadmin@myfreehockeystats.com"
    subject="Issue Reported"
    type="html">	
<cfoutput>
Goal Id: #form.GoalId#<br>
<a href="http://myfreehockeystats.com/GoalWizard.cfm?step=5&GoalId=#qInsertIssue.GoalId#&GameId=#qInsertIssue.GameId#">Edit Goal</a><br>
Reported by: #session.fullName#
Issue Reported By:#session.username#<br>		
#form.StatIssue#
		</cfoutput>
</cfmail>	
	
		<div>Message: <cfoutput> #qInsertIssue.InsertMessage# </cfoutput>. We will review the issue and make the change if your claim is accurate. 
		</div>
	</cfif>

<cfelse>
	

			<form action="ReportStatIssue.cfm" method="post">
			<cfoutput>
						<input type="hidden" name="goalId" value="#url.goalId#">
			</cfoutput>
			
			<table>
			<tr class="row-odd">
					<td colspan="2" style="text-align: center;">
						<cf_DisplayGoalsbyGoals goalList=#url.GoalId#>
					</td>
				</tr>
				<tr class="row-odd">
					<td style="text-align: left;" colspan="2" >
						<b>What is the issue you discovered with this goal?</b>
					</td>
				</tr>	
				<tr class="row-odd">
					<td colspan="2" style="text-align: left;">
					 <textArea cols="135" rows="5" name="StatIssue"></textArea>
					</td>

				</tr>
				<cfif session.showAdminFunctions>
				<tr class="row-odd">
					<td style="text-align: left;">
						
							<b>Note: This will send an email to the site admin.</b>
						
					</td>
				</tr>
				</cfif>
					<cfif session.username is not "Guest">

				<tr class="row-odd">
					<td style="text-align: left;">
						<b>Note: If you are reporting a goal that is not yours, please include the player name and number in the issue description.</b>
					</td>	
								<td align="center">
					<input type="submit" value="Submit">
					</td>
				</tr>
				<cfelse>
				<tr class="row-odd">
					<td style="text-align: left;">
						<b>Note: You must be logged in to report an issue.</b>
					</td>	
								<td align="center">
					<input type="button" value="Login" onclick="location.href='authenticate.cfm'">
					</td>
					</cfif>					

			</table>
				</form>

</cfif>	
</div>
<cfinclude template="includes/footers/Footer.cfm">