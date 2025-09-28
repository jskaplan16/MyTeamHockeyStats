<cfparam name="attributes.useHeader" default="true">
<cfparam name="url.Action" default="">
<cfparam name="attributes.Message" default="">

<cfif not structKeyExists(session,"ShowAdminFunctions")>
    <cflocation url="Games.cfm" >
</cfif> 
	<cfif NOT structKeyExists(session, "userID")>
    			<cflocation url="#application.pages#authenticate.cfm?SessionExpired=true">
	</cfif>	

	<cfparam name="session.selectedGameId" default="">
    <cfparam name="session.selectedGame" default="">
    

			
	<cfif attributes.useHeader>
<cfinclude template="#application.includes#header.cfm">
	</cfif>


        <!-- Game Info Section -->
        <cfoutput>
        <div class="content">
        	    <div class="PageHeader">
      #session.TeamName#  - Admin Area 	
    </div>
    </cfoutput>
<cfif attributes.Message is not "">
    <div class="error">
    <cfoutput>#attributes.Message#</cfoutput>
    <div>
</cfif>
<table>
<tr>
	<cfquery name="qGames" datasource="#application.datasource#">
			Select GameId, Game,   Convert(varchar(10),GameDate,101) + ' ' + Game as GameName  from vGames 
		Where MainTeamSeasonId=#session.TeamSeasonId#
		Order by GameDate desc 
		
	</cfquery>

    <cfif url.Action is "SetGame" and url.GameId is not "clear">

        <cfquery name="qSelected" dbtype="query">
            SELECT Game FROM qGames WHERE GameId = #url.GameId#
        </cfquery>

        <cfset session.selectedGame = qSelected.Game>
        <cfset session.selectedGameId = url.GameId>
    <cfelse>
        <cfif isDefined("url.GameId") and url.GameId is "clear">
        <cfset session.selectedGame = "">
        <cfset session.selectedGameId = "">
        </cfif>
    </cfif>
<cfoutput>
<form action="#application.displays#DisplayAdmin.cfm" method="GET">
</cfoutput>
<table>
<tr>
	<td class="TdCellLeftTtl">
	<input type="hidden" name="Action" value="SetGame">
	SET CURRENT GAME
	</td>

	<td>
	<select style="font-size: 20px;"  name="GameId" onchange="submit()">
		<option value="clear">Select Game</option>
		<cfoutput query="qGames">
<option value="#GameId#" <cfif qGames.GameId is session.selectedGameId> Selected </cfif> >
				#GameName#
			</option>
			</cfoutput>
	</select>
	</td>


</form> 
 </table>    

<cfif session.selectedGameId is "">
 <cfset cardClass="card disabled">
 <cfelse>
<cfset cardClass="card">
  </cfif>
<cfoutput>
<div> 
    <div class="admin-header" style="text-align: left;">
                Admin Info
    </div>
    
    <section class="stat-cards" style="padding: 3px;align-items: left;">
     <div class="card">
        <span class="icon"><i class="fas fa-gear"></i></span>
                <strong></strong>
        <div class="desc">
             <a href="#application.displays#DisplaySettings.cfm" class="mainlink">Add/Edit Users</a></a>
        </div>
      </div>

      <div class="card">
        <span class="icon"><i class="fas fa-gear"></i></span>
                <strong></strong>
        <div class="desc">
             <a href="#application.displays#DisplayPlayerRoster.cfm" class="mainlink">Add Roster Players</a></a>
        </div>
      </div>

          <div class="card">
        <span class="icon"><i class="fas fa-gear"></i></span>
                <strong></strong>
        <div class="desc">
             <a href="#application.displays#DisplayAddTeam.cfm" class="mainlink">Add Opponents</a></a>
        </div>
      </div>
    </section>

<div> 
    <div class="admin-header" style="text-align: left;">
                Game Info
    </div>
    
    <section class="stat-cards" style="padding: 3px;align-items: left;">
     <div class="card">
        <span class="icon"><i class="fas fa-calendar"></i></span>
                <strong></strong>
        <div class="desc">
            <a href="#application.displays#DisplayEnterGame.cfm?Action=Insert" class="mainlink">Enter New Game</a>
        </div>
      </div>

     <div class="#cardClass#">
        <span class="icon"><i class="fas fa-pen-to-square"></i></span>
         <strong></strong>
        <div class="desc">
        <a href="#application.displays#DisplayEnterGame.cfm?Action=edit" class="mainlink">
        Edit Current Game
        </a>
       
        </div>
      </div>   

    

           <div class="#cardClass#">
        <span class="icon"><i class="fas fa-binoculars"></i></span>
         <strong></strong>
        <div class="desc">
        <a href="#application.displays#DisplayStats.cfm?gameId=#session.selectedGameId#" <cfif session.selectedGameId is ""> style="pointer-events: none;" </cfif> class="mainlink">
        View Game
        </a>
    
        </div>
      </div>   


 </section>
     <div class="admin-header" style="text-align: left;">
                Goals
    </div>
 <section class="stat-cards">
     <div class="#cardClass#">
        <span class="icon"><i class="fas fa-hockey-puck"></i></span>
        <strong></strong>
        <div class="desc"><a href="#application.Pages#GoalWizard.cfm?Step=3" class="mainlink">Add Goals</a></div>
      </div>   


     <div class="#cardClass#">
        <span class="icon"><i class="fas fa-pen-to-square"></i></span>
        <strong></strong>
        <div class="desc"><a href="#application.Pages#GoalWizard.cfm?Step=4" class="mainlink">Edit Goals</a></div>
      </div>   

      <div class="#cardClass#">
        <span class="icon"><i class="fas fa-circle-minus"></i></span>
        <strong></strong>
         <div class="desc"><a href="#application.Pages#GoalWizard.cfm?Step=7" class="mainlink">Delete Goals</a></div>
      </div>
</div>
</section>


     <div class="admin-header" style="text-align: left;">
                Penalties
    </div>
 <section class="stat-cards">
     <div class="#cardClass#">
        <span class="icon"><i class="fas fa-ban"></i></span>
        <strong></strong>
        <div class="desc"><a href="#application.Pages#GoalWizard.cfm?Step=10" class="mainlink">Add Penality</a></div>
      </div>   


     <div class="#cardClass#">
        <span class="icon"><i class="fas fa-pen-to-square"></i></span>
        <strong></strong>
        <div class="desc"><a href="#application.Pages#GoalWizard.cfm?Step=12" class="mainlink">Edit Penality</a></div>
      </div>   

      <div class="#cardClass#">
        <span class="icon"><i class="fas fa-circle-minus"></i></span>
        <strong></strong>
         <div class="desc"><a href="#application.Pages#GoalWizard.cfm?Step=14" class="mainlink">Delete Penality</a></div>
      </div>
</div>
</cfoutput>
</section>

<!--- 
                <a href="DisplayEnterGame.cfm?Action=Insert">Enter New Game</a>
                <div style="display: inline;">
				<a href="GoalWizard.cfm?Step=1">Add Goals</a>
                </div>
                
                <div style="display: inline;">
                 <a href="GoalWizard.cfm?Step=2">Edit Goals</a>
                </div>
	            <a href="GoalWizard.cfm?Step=9">Add Penalty</a>
                <a href="ShiftMapper.cfm?Step=SelectGame">Add Player Shifts</a>
                <!-- Conditional Links -->
                <!-- Replace CFIF logic with dynamic server-side rendering -->
						 <cfif not session.GoalDeletes>
	<a href="GoalWizard.cfm?Edit=true&Step=7">
			Enable Goal Deletes
			 </a>
		<cfelse>
	<a href="GoalWizard.cfm?Edit=false&Step=8">
			 Disable Goal Deletes
		</a>
		</cfif>

  
            </div>  
        </div>

        <!-- Team Info Section -->
        <div class="admin-container">
            <div class="admin-header">
                Team Info
            </div>

            <div class="admin-links">
                  <a href="settings.cfm">Add User</a>
					<a href="DisplayAddTeam.cfm">Add Team</a>
					<a href="DisplayPlayerRoster.cfm">Add Player</a>
				

        </div>
    </div>
--->

	<cfif attributes.useHeader>
<cfinclude template="#application.includes#footer.cfm">
	</cfif>
