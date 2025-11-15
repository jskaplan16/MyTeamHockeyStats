<cfsetting showdebugoutput="false">
<cfcontent type="application/json" reset="true">

<cfparam name="url.teamSeasonId" default="">
<cfparam name="url.gameId" default="">

<cfif NOT len(trim(url.teamSeasonId))>
  <cfoutput>[]</cfoutput>
  <cfabort>
</cfif>

<cfquery name="qPenaltyGoals" datasource="#application.datasource#">
  exec stpGetPenaltyGoals
  @GameId=#url.GameId#,
  @TeamSeasonId=#url.TeamSeasonId#
</cfquery>

<cfset penaltyGoals = []>
<cfloop query="qPenaltyGoals">
  <cfset arrayAppend(
    penaltyGoals,
    {
      "GoalId" = qPenaltyGoals.GoalId,
      "TeamSeasonId" = qPenaltyGoals.TeamSeasonId,
      "TeamName" = qPenaltyGoals.TeamName,
      "PenaltyGoalDesc" = qPenaltyGoals.PenaltyGoalDesc,
      "GoalNumber" = qPenaltyGoals.GoalNumber
    }
  )>
</cfloop>

<cfoutput>#serializeJSON(penaltyGoals)#</cfoutput>

