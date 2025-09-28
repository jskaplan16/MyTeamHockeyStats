<cfcomponent rest="true" restpath="/autocomplete">
  <cffunction 
    name="getSuggestions" 
    access="remote" 
    returnType="array" 
    httpMethod="GET"
  >
    <cfargument name="query" type="string" required="true" restargsource="query">
    
    <cfset var results = []>
    <!--- Example: Query database or process logic --->
    <cfquery  name="getTeams" datasource="#Application.Datasource#">
   SELECT TeamName,BirthYear FROM dbo.tblteam
WHERE TeamId=MainTeamId
and TeamName like '%#arguments.query#%'
    </cfquery>
            
        
  <cfloop query="getTeams">
      <cfset arrayAppend(results, "Suggestion 1 for " & getTeams.TeamName)>
 </cfloop>
     
    <cfreturn results>
  </cffunction>
</cfcomponent>