<cfparam name = "attributes.GameId" default = "all">
<cfparam name = "attributes.ActionPage">
<cfparam name = "Attributes.NextStep" default = "">
<cfparam name = "Attributes.IncludeList" default = "">

<cfquery name = "qGames" datasource = "#application.datasource#">
    Select GameId, Game, Convert(varchar(10),GameDate,101) + ' ' + Game as 
    GameName,FullGameVideoURL,VideoEmbed from vGames
    Where MainTeamId=#session.TeamId#
    <cfif attributes.IncludeList neq "">
        And GameId in (
        #attributes.IncludeList#
        ) 
    </cfif>
    Order by GameDate desc,GameID desc
</cfquery>
<cfoutput>

    <div>
            <form action="#attributes.ActionPage#?Step=#attributes.NextStep#" method="POST" 
                    onchange="this.submit()" style="display: inline;">
                    <input type="hidden" name="NextStep" value="#attributes.NextStep#">
                </cfoutput>

                <label for="GameId" class="labelFld">Select Game</label>

                <select name="GameId">
                    <option value="">Select Game</option>
                <cfoutput query = "qGames">
                    <option value="#qGames.GameId#" 
                    <cfif qGames.GameId is attributes.GameId>
                        Selected 
                    </cfif>>#GameName#</option>
                </cfoutput>
                </select>
            </form>
    </div>