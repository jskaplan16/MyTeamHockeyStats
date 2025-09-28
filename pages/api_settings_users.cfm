<cfprocessingdirective suppressWhitespace="true">
<cfparam name="url.email" default="" />

<cfquery name="qSearchUsers" datasource="#application.datasource#">
    exec dbo.stpFindUsers @UserName = <cfqueryparam value="#url.email#" cfsqltype="cf_sql_varchar">,
                          @TeamSeasonId=#session.teamSeasonId# 
</cfquery>
<cfset resultArr = []>
<cfloop query="qSearchUsers">
  <cfset row = structNew()>
  <cfloop list="#qSearchUsers.columnList#" index="col">
    <cfset row[LCase(col)] = qSearchUsers[col][qSearchUsers.currentRow]>
  </cfloop>
  <cfset arrayAppend(resultArr, row)>
</cfloop>

<cfsetting enablecfoutputonly="true">
<cfsetting showdebugoutput="false">
<cfcontent type="application/json" />
<cfoutput>#serializeJSON(resultArr)#</cfoutput>
</cfprocessingdirective>
