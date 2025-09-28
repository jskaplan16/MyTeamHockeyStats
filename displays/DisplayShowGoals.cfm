<cfinclude template="#application.includes#header.cfm">
<div class="content">
	
	<cfoutput>
		<div class="PageHeader">
 #session.TeamName#  - Show Goals By Goals
		</div>

	</cfoutput>
	<div>
	<cf_DisplayGoalsByGoals goalList="#url.goalList#" showGame="true">
</div>
		
	</div>
</div>
<cfinclude template="#application.includes#footer.cfm">