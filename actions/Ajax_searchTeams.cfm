<cfsetting enablecfoutputonly="true" showdebugoutput="false">
<cfcontent type="application/json">
<cfset suggestions = []>
<cfquery name="qryTeams" datasource="#Application.Datasource#">
  SELECT teamSeasonId, teamName, TeamIcon
  FROM vTeam
  WHERE teamName LIKE <cfqueryparam value="%#url.query#%" cfsqltype="cf_sql_varchar">
</cfquery>
<cfloop query="qryTeams">
  <cfset arrayAppend(suggestions, {
    "value" = qryTeams.teamSeasonId,
    "data" = qryTeams.teamName
  })>
</cfloop><cfoutput>{"suggestions":#serializeJSON(suggestions)#}</cfoutput>