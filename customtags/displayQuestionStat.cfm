<cfparam  name="attributes.GoalId" default="">
<cfparam  name="attributes.GameId">
<div>
	<cfoutput>
<img src="#application.images#QuestionMark.png" width="25" style="display: inline;"> Questionalble Stat? Please help by reporting the issue so we can correct it. 

	<a href="ReportStatIssue.cfm?GoalId=#attributes.goalId#" style="color: blue;">Click Here</a>
	</cfoutput>


</div>
