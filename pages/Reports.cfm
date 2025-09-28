
<cfinclude template="includes/headers/Header.cfm">
<cfoutput>
<div class="content">
	    <div class="PageHeader">
      #session.TeamName#  - Coach Tools 	
    </div>
  </cfoutput>	
	<h1> Reports</h1>
	<table height="200" width="100%">
		<tr>
			<td class="Row-Even" style="text-align: left;">
				<a href="Groups.cfm?PlayType=EvenStrength" class="MainLink" style="color:black;text-decoration: underline;">Even Strength - Offense Group</a>  A history of goals and scores together earned as a group during Even Play or short-handed.  
			</td>
			
		</tr>
<tr>
		<td class="Row-Odd" style="text-align: left;">
				<a href="Groups.cfm?PlayType=PowerPlay" class="MainLink" style="color:black;text-decoration: underline;">
					Power Play Unit -
				</a>
			 A history of goals and scores together earned as a group during a power-play, extra-attacker or empty-net. 
			</td>
		</tr>
	<tr>
	<td class="Row-Even" style="text-align: left;">
				<a href="WorksBestWith.cfm" class="MainLink" style="color:black;text-decoration: underline;">
					Who helps who?</a>
			 Who has helped each player the most. 
			</td>
</tr>
	</table>
	<h1> Tools</h1>
	<table width="100%">
		<tr>
			<td class="Row-even" style="text-align: left;">

				<a href="LineApp.cfm" class="MainLink" style="color:black;text-decoration: underline;">Build Optimal Lines</a>  Use stats to build the best lines for your team.  
			</td>
			
		</tr>
	</table>

                    <div class="nav-cell">
                        
                    </div>

	</div>
<cfinclude template="includes/footers/Footer.cfm">