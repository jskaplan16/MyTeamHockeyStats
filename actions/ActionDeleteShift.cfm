<cftry>
    <!-- Read the incoming JSON payload -->
    <cfset rawData = ToString(GetHttpRequestData().content)>
    <cfset requestData = DeserializeJSON(rawData)>

    <!-- Extract values from the JSON object -->
    <cfset ShiftMapperId = requestData.ShiftMapperId>
   <cfquery datasource="#Application.Datasource#" name="qDeleteShift">
        DELETE FROM tblShift
        WHERE ShiftMapperId = <cfqueryparam cfsqltype="cf_sql_integer" value="#ShiftMapperId#">
    </cfquery>

    <!-- Create a success response -->

   <cfset result = {
        "success": true,
        "message": "Shift data deleted successfully",
        "data": {
            "ShiftMapperId": ShiftMapperId
        }
    }>

    <!-- Return the response as JSON -->
    <cfcontent type="application/json">
    <cfoutput>#SerializeJSON(result)#</cfoutput>
<cfcatch type="any">
    <!-- Handle errors and return an error response -->
    <cfset errorResponse = {
        "success": false,
        "message": "An error occurred while saving shift data.",
        "errorDetails": "#cfcatch.message#"
    }>

    <!-- Return the error response as JSON -->
    <cfcontent type="application/json">
    <cfoutput>#SerializeJSON(errorResponse)#</cfoutput>
</cfcatch>
</cftry>


<cfsetting showdebugoutput="false">
