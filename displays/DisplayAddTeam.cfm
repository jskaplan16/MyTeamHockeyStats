<cfinclude template="includes/headers/Header.cfm">

<cfparam name="form.TeamName" default="">
<cfparam name="form.TeamIcon" default="">
<cfparam name="form.BirthYearId" default="">
<cfparam name="form.AgeGroupId" default="">
<cfparam name="form.TeamLevelId" default="">
<cfparam name="form.TeamId" default="#session.teamId#">
<cfparam name="url.Action" default="Insert">
<cfparam name="form.OrganizationId" default="">
<cfparam name="form.seasonStartDate" default="">
<cfparam name="form.seasonEndDate" default="">

<cfquery datasource="#Application.Datasource#" name="qAgeGroup">
    exec dbo.stpGetAgeGroupDivision
</cfquery>


 <cfquery name="qLevels" datasource="#Application.Datasource#">
    exec dbo.stpGetTeamLevel
  </cfquery>

	<cfquery name="qTeam" datasource="#application.datasource#">
	Select TeamId, TeamName,TeamSeasonId,BirthYearId,AgeGroupID,TeamLevelId,SeasonId from vTeam where MainTeamSeasonId=#session.TeamSeasonId#
	</cfquery>
	

        <cfquery name="qTeam" datasource="#application.datasource#">
            Select * from vTeam where TeamSeasonId=#session.TeamSeasonId#
        </cfquery>

        <cfset form.TeamName=qTeam.TeamName>
        <cfset form.TeamIcon=qTeam.TeamIcon>
        <cfset form.TeamId=qTeam.TeamId>
        <cfset form.TeamIcon=qTeam.TeamIcon>
        <cfset form.BirthYearId=qTeam.BirthYearId>
        <cfset form.AgeGroupID=qTeam.AgeGroupID>
        <cfset form.TeamLevelId=qTeam.TeamLevelId>
        <cfset form.seasonEnd=session.endofSeason>
        <cfset form.seasonStart=session.startofSeason>



    <div class="form-container" style="width: 60%;">
        <h2>Add Team</h2>
         <cfoutput>
        <form name="SaveTeam" method="Post" action="SaveTeam.cfm" enctype="multipart/form-data">
            <cfif url.Action is "Edit">
                    <input type="hidden" name="TeamSeasonId" value="#url.TeamSeasonId#">
                    <input type="hidden" name="Action" value="#url.Action#">
                <cfelse>
                    <input type="hidden" name="Action" value="Insert">
                </cfif>
        </cfoutput>
        
             <table>
                <tr>
                 
                    <td colspan="2" style="text-align: left;">

                                     
                                   
                <CF_DisplayOrganizationAutoSelect tabIndex="0" 
                OrganizationId="#form.OrganizationId#" 
                BirthYearId=#form.BirthYearId#   
                AgeGroupID="#form.AgeGroupID#" 
                SeasonId="#session.SeasonId#"
                TeamLevelId="#form.TeamLevelId#"
                seasonStart="#form.seasonStart#"
                seasonEnd="#form.seasonEnd#"
                >
                    </td>
                </tr>

                <tr>
                    <td colspan="2" style="text-align:center;">
                        <input type="submit" value="Submit" tabindex="7">
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <br>
    <cfquery name="qTeam" datasource="#application.datasource#">
       Select t.TeamId, 
                t.TeamName, 
                t.TeamIcon,
                t.TeamSeasonId
            from vTeam t 
            where t.MainTeamSeasonId=#session.TeamSeasonId#
        </cfquery>

  <div class="form-container" style="width:60%;">
    <table class="table-responsive">
    <tr>
        <th align="left" style="width:100px;">
    Team Icon
    </th>
    <th style="width:250px;">
    Team Name
    </th>
    <th>
        Action
    </th>
    </tr>
 
    <cfoutput query="qTeam">
        <cfif qTeam.currentRow mod 2 eq 0>
            <tr class="row-even">
        <cfelse>
            <tr class="row-odd">
        </cfif>
            <td class="tblCellleft" style="width:10%">    
            <img src="assets/images/HockeyIcons/#qTeam.TeamIcon#" alt="Team Icon" style="width:50px;height:50px;">
            </td>
            <td class="tblCellLeft" style="width:70%">#qTeam.TeamName#</td>    
          
            
            <td class="tblCellleft" style="width:20%">
            <cfif session.TeamSeasonId is not qTeam.TeamSeasonId>
                <a href="DisplayAddTeam.cfm?Action=Edit&TeamSeasonId=#qTeam.TeamSeasonId#" class="mainLink">Edit</a>
            </cfif>
                 <a href="DisplayPlayerRoster.cfm?Action=Insert&TeamSeasonId=#qTeam.TeamSeasonId#" class="mainLink">Add Player</a>
          
        </tr>
                   
        </cfoutput>
    </table>
    </div>

<cfinclude template="includes/footers/Footer.cfm">

<script>
const teamname = document.getElementById('searchOrgText');
const level = document.getElementById('TeamLevelId');
const ageGroup = document.getElementById('AgeGroupID');
const otherTeamLabel = document.getElementById('OtherTeam');
const proposedname = document.getElementById('teamName');
const birthyear = document.getElementById('birthYearId')

// Function to update the proposed name
function updateProposedName() {
  const lvl= level.options[level.selectedIndex].text;
  let age= ageGroup.options[ageGroup.selectedIndex].text;
  const team = teamname.value;
  const otherTeam= otherTeamLabel.value;
  
  if(age=="Select Age Group" ) {
    age= "";
  }


  // Customize the concatenation as you wish
  proposedname.value = `${team} ${otherTeam} ${age}`;
}

// Attach event listeners
teamname.addEventListener('focusout', updateProposedName);
teamname.addEventListener('change', updateProposedName);
teamname.addEventListener('click', updateProposedName);
ageGroup.addEventListener('change', updateProposedName);
ageGroup.addEventListener('focus', updateProposedName);
ageGroup.addEventListener('click', updateProposedName);
level.addEventListener('change', updateProposedName);
otherTeamLabel.addEventListener('change', updateProposedName);
otherTeamLabel.addEventListener('focus', updateProposedName);
// Initialize on page load
updateProposedName();

</script>

  <script>
function showFileName() {
    var input = document.getElementById('myFile');
    var fileNameSpan = document.getElementById('fileName');
    if (input.files.length > 0) {
        fileNameSpan.textContent = input.files[0].name;
    } else {
        fileNameSpan.textContent = "";
    }
}
</script>