<!---<cfif not isDefined("url.NoHeader")>--->
<cfinclude template="#application.includes#Header.cfm">

	<cfquery datasource="#application.datasource#" name="qGames">
		Select Replace(GamesheetURL,'/Gamesheets/','') as GamesheetURL from tblGame where GameId=#url.GameId#
	</cfquery>
	<div style="padding: 5px;text-align: left;">
		<button onclick="history.back()" class="Submit">Go Back</button>
	</div>
	<cfoutput>
<cfif REFindNoCase("(https://|\.pdf$)", qGames.GamesheetURL)>

			 <iframe src="#qGames.GamesheetURL#" style="width:100%;height:1000px;"></iframe>
		<cfelse>
			<img src="#application.gamesheets##qGames.GamesheetURL#" width="1400">
		</cfif>	
	</cfoutput>
<!---		<cfif not isDefined("url.NoHeader")> --->
		<cfinclude template="#application.includes#Footer.cfm">	
		
		<!---	</cfif> --->