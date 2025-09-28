<cftry>
    <!-- Read the incoming JSON payload -->
    <cfset rawData = ToString(GetHttpRequestData().content)>
    <cfset requestData = DeserializeJSON(rawData)>

    <!-- Extract values from the JSON object -->
    <cfset playerId = requestData.playerId>
    <cfset startTime = requestData.startTime>
    <cfset endTime = requestData.endTime>
    <cfset gameId = requestData.gameId>
    <cfset shots = requestData.shots>
    <cfset period = requestData.period>

  
    <cfquery datasource="#application.Datasource#" name="qSaveShift">
        INSERT INTO tblShift (PlayerId, StartShift, EndShift, GameId, Shots,Period)
        VALUES (
            <cfqueryparam value="#playerId#" cfsqltype="CF_SQL_INTEGER">,
            <cfqueryparam value="#startTime#" cfsqltype="CF_SQL_INTEGER">,
            <cfqueryparam value="#endTime#" cfsqltype="CF_SQL_INTEGER">,
            <cfqueryparam value="#gameId#" cfsqltype="CF_SQL_INTEGER">,
            <cfqueryparam value="#shots#" cfsqltype="CF_SQL_INTEGER">,
               <cfqueryparam value="#Period#" cfsqltype="CF_SQL_INTEGER">
        )
    </cfquery>

    <!-- Create a success response -->
    <cfset result = {
        "success": true,
        "message": "Shift data saved successfully",
        "data": {
            "playerId": playerId,
            "startTime": startTime,
            "endTime": endTime,
            "gameId": gameId,
            "shots": shots,
            "period": period
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


