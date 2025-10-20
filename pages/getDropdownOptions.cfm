<cfparam name="form.teamSeasonId" default="">

	<cfquery name="qPlayers" datasource="#application.datasource#">

		Select 

	PlayerId,Convert(varchar,PlayerNumber) + ' ' + PlayerName as PlayerName   

		from vRoster 

		where TeamSeasonId=#form.teamSeasonId#

		Order by PlayerNumber asc 

	</cfquery>

  <cfset options = []>

   <cfoutput  query="qPlayers">

	  <cfset arrayAppend(options, { "value": "#PlayerId#", "text": "#PlayerName#" })>

  </cfoutput>



  <cfoutput>

    #serializeJSON(options)#

  </cfoutput>



<cfsetting showdebugoutput="No">