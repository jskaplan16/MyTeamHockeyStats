<cfquery name="qShifts" datasource="#application.datasource#">
  SELECT 
       ShiftMapperId	
      ,PlayerId
      ,PlayerNumber
      ,PlayerName
      ,GameId
      ,StartShift
      ,EndShift
      ,Shots
      ,GameDate
      ,VideoEmbed
      ,Game
      ,EndShift-StartShift AS SecondsOnIce
      ,RowInsert
      ,Period
  FROM vShift 
  where GameId=#url.GameId#
  Order by EndShift Desc 
</cfquery>

<!--- Convert query to an array of structs --->
<cfset shiftsArray = []>
<cfloop query="qShifts">
  <cfset arrayAppend(shiftsArray, {
    "ShiftMapperId": qShifts.ShiftMapperId,
    "PlayerId": qShifts.PlayerId,
    "PlayerNumber": qShifts.PlayerNumber,
    "PlayerName": qShifts.PlayerName,
    "GameId": qShifts.GameId,
    "StartShift": qShifts.StartShift,
    "EndShift": qShifts.EndShift,
    "Shots": qShifts.Shots,
    "GameDate": qShifts.GameDate,
    "VideoEmbed": qShifts.VideoEmbed,
    "Game": qShifts.Game,
    "SecondsOnIce": qShifts.SecondsOnIce,
    "RowInsert": qShifts.RowInsert,
    "Period": qShifts.Period
  })>
</cfloop>

<!--- Serialize the array of structs to JSON --->
<cfset jsonResponse = SerializeJSON(shiftsArray)>

<!--- Set response content type to JSON --->
<cfheader name="Content-Type" value="application/json">

<!--- Output the JSON response --->
<cfoutput>#jsonResponse#</cfoutput>
<cfsetting showdebugoutput="false">
