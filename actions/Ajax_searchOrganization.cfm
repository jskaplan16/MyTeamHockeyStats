<cfsetting enablecfoutputonly="true" showdebugoutput="false">
<cfcontent type="application/json">
<cfset suggestions = []>
<cfquery name="qryOrg" datasource="#Application.Datasource#">
  SELECT OrganizationId, Organization, TeamIcon
  FROM  [dbo].[tblOrganization]
  WHERE Organization LIKE <cfqueryparam value="%#url.query#%" cfsqltype="cf_sql_varchar">
</cfquery>
<cfloop query="qryOrg">
  <cfset arrayAppend(suggestions, {
    "data" = toString(qryOrg.OrganizationId),
    "value" = qryOrg.Organization
  })>
</cfloop><cfoutput>{"suggestions":#serializeJSON(suggestions)#}</cfoutput>