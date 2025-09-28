<cfparam name="attributes.tabIndex"  default="0">
<cfparam name="attributes.BirthYearId" default="">
<cfparam name="attributes.AgeGroupId"  default="">
<cfparam name="attributes.SeasonId" default="">
<cfparam name="attributes.seasonStart" default="">
<cfparam name="attributes.seasonEnd" default="">
<cfparam name="attributes.searchOrgText"  default="">
<cfparam name="attributes.TeamName" default=""> 
<cfparam name="attributes.OrganizationId" default="">
<cfparam name="attributes.TeamLevelId" default="">




<cfquery datasource="#Application.Datasource#" name="qAgeGroupBase">
    exec dbo.stpGetAgeGroupDivision
</cfquery>

<cfquery  dbtype="query" name="qAgeGroup">
    select distinct AgeGroupId, AgeGroup 
    from qAgeGroupBase
    order by AgeGroupId
  
</cfquery>

<cfquery  dbtype="query" name="qBirthYear">
  Select distinct BirthYearId,BirthYearDisplay,BirthYearStartValue from qAgeGroupBase
  Order by BirthYearStartValue
</cfquery>

 <cfquery name="qLevels" datasource="#Application.Datasource#">
    exec dbo.stpGetTeamLevel
</cfquery>



<cfquery name="qSeason" datasource="#Application.Datasource#">
exec stpGetSeason
</cfquery>

<cfhtmlhead text='<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>'>
<cfhtmlhead text='<script src="https://cdn.jsdelivr.net/npm/devbridge-autocomplete@1.4.11/dist/jquery.autocomplete.min.js"></script>'>

<cfsavecontent variable="styleTag" >
    

<style>
.autocomplete-suggestions {
  background:lightgrey;
  color: #fff;
  border: 1px solid black;
  text-transform: uppercase;
  font-size: 12px;
  text-align: left;
}
.autocomplete-suggestion {
  background: lightgrey;
  color: #000;
   padding: 8px 12px; 
   text-transform: uppercase;
    font-size: 12px;
     text-align: left;
}
.autocomplete-suggestion:not(:last-child) {
  border-bottom: 1px solid #ddd; /* Light gray border between items */
}

.autocomplete-selected {
  background: #000000;
  color: white;
  border: 1px solid #000;
  text-transform: uppercase;
   font-size: 12px;
    text-align: left;
}
</style>
</cfsavecontent>
<cfhtmlhead text="#styleTag#">

      
      <!-- Team Birth Year -->
<table style="text-align:left;">
<tr>
<td style="text-align:left;" colspan="2">
  <div style="display: inline-block;">
<label id="ageGroupError" style="color: red;"></label>
</div>
</td>
</tr>
<tr>
<td style="text-align:left;">
  <div style="display: inline-block;">
    <label for="birthYearId" class="labelFld">Birth Year</label>
    <select id="birthYearId" name="birthYearId" class="inputFld" required style="width: 10em;" tabindex="5">
      <cfoutput query="qBirthYear" >
      <option value="#BirthYearId#" <cfif attributes.BirthYearId is qBirthYear.BirthYearId> Selected </cfif>>#BirthYearDisplay#</option>
      </cfoutput>
    </select>
  </div>
</td>

  <td style="text-align: left;">
    <div style="display: inline-block;">
      <label for="AgeGroupID" class="labelFld">Age Group</label>
      <select id="AgeGroupID" name="AgeGroupID" class="inputFld" required style="width: 12em;" tabindex="6">
        <option value="" disabled selected>Select Age Group</option>
        <cfoutput query="qAgeGroup">
          <option value="#AgeGroupId#" #IIf(attributes.AgeGroupID EQ qAgeGroup.AgeGroupId, 'selected="selected"', '')#>#AgeGroup#</option>
        </cfoutput>
      </select>
    </div>
  </td>

  <td style="text-align: left;">
    <div style="display: inline-block;">
      <label for="TeamLevelId" class="labelFld">Level</label><br>
    <select id="TeamLevelId" name="TeamLevelId"class="inputFld" required style="width: 12em;" tabindex="7">
      <option value="" selected>Select Level</option>
      <cfoutput query="qLevels">
      <option value="#TeamLevelId#" #IIf(attributes.TeamLevelId EQ qLevels.TeamLevelId, 'selected="selected"', '')#>#TeamLevel#</option>
      </cfoutput> 
    </select>
</td>
</tr>

<tr>
    <td style="text-align: left;">
      <div style="display: inline-block;">
        <label for="SeasonId" class="labelFld">Season</label><br>
          <select id="SeasonId" name="SeasonId" required style="width: 10em;" class="inputFld " tabindex="8">
            <option value=""  selected>Select Season</option>
            <cfoutput query="qSeason">
            <option value="#SeasonId#" #IIf(attributes.SeasonId EQ qSeason.SeasonId, 'selected="selected"', '')#>#Season#</option>
            </cfoutput> 
          </select>
    </td>
<cfoutput>
  

<td style="text-align:left;">
  <div style="display: inline-block;">
      <!-- Organization -->
   <label for="seasonStart" class="labelFld">Season Start</label>
   <input type="date" id="seasonStart" name="seasonStart" required  onblur="" class="inputFld" style="width: 10em;display:inline;" tabindex="9" value="#attributes.seasonStart#">
  </div>
</td>

 <td style="text-align:left;">
    <div style="display: inline-block;">
   <label for="seasonEnd" class="labelFld">Season End</label>
   <input type="date"  id="seasonEnd" name="seasonEnd" required  onblur="" class="inputFld" style="width: 10em;" tabindex="10" value="#attributes.seasonEnd#">
    </div>
  </td>
</cfoutput>
  </table>
 <label  for="searchOrgText" class="labelFld">Organization Name:</label>
 <cfoutput>
    

<input type="text" id="searchOrgText" name="searchOrgText" tabindex="#attributes.tabIndex#" required placeholder="Search for organization" value="#attributes.searchOrgText#" style="width: 300px;" />
<input type="hidden" id="OrganizationId" name="OrganizationId" value="#attributes.OrganizationId#" />
<br>
<label for="OtherTeam" class="labelFld">Team Other Label:(Red,Green,etc..)<small> not required</small></label>
<input type="text" id="OtherTeam" name="OtherTeam" class="inputFld" style="width: 10em;">

<br>

 
       <!-- File Name -->
      <label for="myFile" name="labelmyFile" class="labelFld">Team Icon File</label>
      <input type="file" name="myFile" id="myFile"   class="inputFld" style="width: 30em;" accept=".jpg,  .png, .gif, .jpeg">
      <span id="fileName"></span>
<br>
<label for="teamName" class="labelFld">Team Name:</label>
<input type="text" id="teamName" name="teamName" disabled  class="inputFld" style="width: 30em;" value="#attributes.TeamName#" />
 </cfoutput>
<script>
$(function() {
  $('#searchOrgText').autocomplete({
    serviceUrl: 'ajax_searchOrganization.cfm',
    onSelect: function (suggestion) {
      $('#OrganizationId').val(suggestion.data);
   
      if (suggestion.data !== "0") {
        $('#myFile').hide();
        $('label[for="myFile"]').hide();
      } else {
        $('#myFile').show();
       $('label[for="myFile"]').hide();
      }
   updateProposedName(); 
    }

  });
    
  

  $('#searchOrgText').blur(function() {
    if ($('#searchOrgText').val() === '') {
      $('#OrganizationId').val('0');
    }
  });
});

const birthyear = document.getElementById('birthYearId');
const teamname = document.getElementById('searchOrgText');
const level = document.getElementById('TeamLevelId');
const ageGroup = document.getElementById('AgeGroupID');
const otherTeamLabel = document.getElementById('OtherTeam');
const proposedname = document.getElementById('teamName');
const searchOrg = document.getElementById('searchOrgText');
const seasonId = document.getElementById('SeasonId');
const season = seasonId.options[seasonId.selectedIndex].text;

// Function to update the proposed name
function updateProposedName() {
  const lvl= level.options[level.selectedIndex].text;
  const age= ageGroup.options[ageGroup.selectedIndex].text;
  const year = birthyear.options[birthyear.selectedIndex].text;
  const team = teamname.value;
  const otherTeam= otherTeamLabel.value;
  const seasonId = document.getElementById('SeasonId');
  const season = seasonId.options[seasonId.selectedIndex].text;

let ageName; // Declare in outer scope
let lvlName; // Declare in outer scope
if (age == "Select Age Group") {
  ageName = ""; // Set value if invalid
} else {
  ageName = `(${age})`; // Set value if valid
}

if (lvl == "Select Level") {
  lvlName = ""; // Set value if invalid
} else {
  lvlName = `(${lvl})`; // Set value if valid
}


let rawName = `${team} ${otherTeam} ${ageName} ${lvlName} ${season}`;
  // Replace multiple spaces with a single space and trim
  proposedname.value = rawName.replace(/\s+/g, ' ').trim();
}

// Attach event listeners
birthyear.addEventListener('change', updateProposedName);
birthyear.addEventListener('change', validateAgeGroup);
teamname.addEventListener('change', updateProposedName);
ageGroup.addEventListener('change', updateProposedName);
ageGroup.addEventListener('change', validateAgeGroup); 

level.addEventListener('change', updateProposedName);
otherTeamLabel.addEventListener('change', updateProposedName);
searchOrg.addEventListener('change', updateProposedName);

birthyear.addEventListener('focus', updateProposedName);
birthyear.addEventListener('focus', updateProposedName);

teamname.addEventListener('focus', updateProposedName);
ageGroup.addEventListener('focus', updateProposedName);
level.addEventListener('focus', updateProposedName);
otherTeamLabel.addEventListener('focus', updateProposedName);
searchOrg.addEventListener('focus', updateProposedName);

// Initialize on page load






function validateAgeGroup() {

  let selectedAgeGroup = ageGroup.options[ageGroup.selectedIndex].text;

  // Get selected birth year (value)
  let birthYearSelect = document.getElementById('birthYearId');
  let selectedBirthYearId = birthYearSelect.options[birthYearSelect.selectedIndex].value;




  const ageTable = [
    <cfoutput query="qAgeGroupBase">
      { 
        birthYearId: '#BirthYearId#',
        birthYearDisplay: '#BirthYearDisplay#',
        ageGroup: '#AgeGroup#',
        age: '#age#',
        ageGroupId: '#AgeGroupId#'
      } <cfif qAgeGroupBase.CurrentRow LT qAgeGroupBase.RecordCount>,</cfif>
    </cfoutput>
  ];
//let selectedAge = ageGroup.options[ageGroup.selectedIndex].text;
//let selectedbirthyear = birthYearId.options[birthYearId.selectedIndex].text;
//let selectedSeasonStart = season.split('-')[0];
//let ageMath = selectedSeasonStart-selectedbirthyear;
// Find the matching record
//console.log(selectedbirthyear);
//console.log(selectedSeasonStart);
//console.log(ageMath);


  let result = ageTable.find(row => 
    row.ageGroup === selectedAgeGroup && 
    row.birthYearId === selectedBirthYearId
  );
   submitButton = document.getElementById('submitBtn');
 if (!result) {
  document.getElementById('ageGroupError').textContent = "Selected Age Group does not match the Birth Year.";
// submitButton.disabled = true;
//submitButton.classList.add('disabled-look');
    return false; // 

  }
else {
document.getElementById('ageGroupError').textContent = "";
// submitButton.disabled = false;
//submitButton.classList.remove('disabled-look');
  return true;

}
  // ✅ Match found — allow submission


}
</script>



