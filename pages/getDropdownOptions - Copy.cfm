<cfparam name="form.option" default="">
<cfif form.option neq "">
  <cfset options = []>

  <!-- Example logic for populating options -->
  <cfif form.option EQ "1">
    <cfset arrayAppend(options, { "value": "a", "text": "Option A" })>
    <cfset arrayAppend(options, { "value": "b", "text": "Option B" })>
  <cfelseif form.option EQ "2">
    <cfset arrayAppend(options, { "value": "x", "text": "Option X" })>
    <cfset arrayAppend(options, { "value": "y", "text": "Option Y" })>
  </cfif>

  <!-- Return JSON response -->
  <cfoutput>
    #serializeJSON(options)#
  </cfoutput>
<cfelse>
  <cfoutput>
    []
  </cfoutput>
</cfif>