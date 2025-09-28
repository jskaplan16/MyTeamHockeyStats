<cfheader name="Content-Type" value="application/json">

<cfif structKeyExists(form, "name")>
    <cfset response = {
        "status": "success",
        "message": "Hello, #form.name#!"
    }>
<cfelse>
    <cfset response = {
        "status": "error",
        "message": "No name provided."
    }>
</cfif>

<cfoutput>#serializeJSON(response)#</cfoutput>
