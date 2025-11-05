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
  /* Form container - no background/padding to avoid nested form appearance */
  .org-select-form {
    width: 100%;
    margin: 0;
    padding: 0;
  }

  /* Form grid layout - more horizontal on desktop */
  .form-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    margin-bottom: 15px;
    margin-top: 0;
    margin-left: 0;
    margin-right: 0;
  }
  
  /* Ensure first grid aligns with parent form */
  .org-select-form > .form-grid:first-of-type {
    margin-top: 0;
  }
  
  /* Ensure error row doesn't affect alignment */
  .org-select-form > .form-row.full-width:first-of-type {
    margin-top: 0;
    margin-bottom: 0;
    margin-left: 0;
    margin-right: 0;
    padding-left: 0;
    padding-right: 0;
  }
  
  /* Ensure consistent column alignment with parent form */
  .org-select-form .form-grid {
    align-items: start;
    margin-left: 0 !important;
    margin-right: 0 !important;
  }
  
  .org-select-form .form-row {
    margin-left: 0;
    margin-right: 0;
  }
  
  /* Ensure first form-grid in org-select-form aligns exactly with parent form-grid */
  .org-select-form > .form-grid:first-of-type {
    margin-left: 0 !important;
    clear: left;
  }

  .form-row {
    display: flex;
    flex-direction: column;
    gap: 6px;
    align-items: flex-start;
    text-align: left;
  }

  .form-row.full-width {
    grid-column: 1 / -1;
  }

  .form-row label {
    font-weight: 600;
    color: #13223b;
    font-size: 0.95em;
    text-shadow: none;
    margin-bottom: 2px;
    text-align: left;
    width: 100%;
    display: block;
  }

  .form-row label small {
    font-weight: 400;
    opacity: 0.8;
    font-size: 0.85em;
  }

  .form-row select,
  .form-row input[type="text"],
  .form-row input[type="date"],
  .form-row input[type="file"] {
    width: 100%;
    padding: 10px 12px;
    font-size: 16px;
    border: 2px solid rgba(255,255,255,0.3);
    border-radius: 8px;
    background: rgba(255,255,255,0.1);
    color: #000;
    box-sizing: border-box;
    transition: all 0.3s ease;
    min-height: 44px;
    text-align: left;
    margin: 0;
  }

  .form-row select:focus,
  .form-row input[type="text"]:focus,
  .form-row input[type="date"]:focus {
    outline: none;
    border-color: var(--accent-blue, #2492ff);
    background: rgba(255,255,255,0.15);
    box-shadow: none;
  }

  .form-row select option {
    background: #fff;
    color: #000;
    padding: 10px;
    text-align: left;
  }

  .form-row input[type="text"]::placeholder {
    color: rgba(0,0,0,0.5);
  }

  .form-row input[type="file"] {
    padding: 10px;
    cursor: pointer;
  }

  .form-row input[type="file"]::-webkit-file-upload-button {
    padding: 8px 16px;
    margin-right: 10px;
    border: none;
    border-radius: 6px;
    background: var(--accent-blue, #2492ff);
    color: #fff;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.3s ease;
  }

  .form-row input[type="file"]::-webkit-file-upload-button:hover {
    background: #1e7cd8;
  }

  .error-message {
    color: #ff6b6b;
    font-size: 0.9em;
    margin-bottom: 10px;
    min-height: 20px;
    font-weight: 500;
  }

  .error-message:empty {
    display: none;
    margin-bottom: 0;
    min-height: 0;
  }

  /* Autocomplete styling */
  .autocomplete-suggestions {
    background: rgba(255, 255, 255, 0.95);
    color: #000;
    border: 2px solid var(--accent-blue, #2492ff);
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    max-height: 300px;
    overflow-y: auto;
    text-transform: uppercase;
    font-size: 14px;
    text-align: left;
    z-index: 1000;
    position: absolute !important;
    margin-top: 0 !important;
  }

  .autocomplete-suggestion {
    background: rgba(255, 255, 255, 0.95);
    color: #000;
    padding: 12px 16px;
    text-transform: uppercase;
    font-size: 14px;
    text-align: left;
    cursor: pointer;
    transition: background 0.2s ease;
  }

  .autocomplete-suggestion:not(:last-child) {
    border-bottom: 1px solid rgba(0,0,0,0.1);
  }

  .autocomplete-suggestion:hover {
    background: rgba(36, 146, 255, 0.1);
  }

  .autocomplete-selected {
    background: var(--accent-blue, #2492ff);
    color: white;
    border-left: 4px solid var(--primary-blue, #185abc);
  }

  /* Team name display */
  .team-name-display {
    background: rgba(255,255,255,0.1);
    border: 2px dashed rgba(255,255,255,0.3);
    border-radius: 8px;
    padding: 10px 12px;
    color: rgba(255,255,255,0.9);
    font-weight: 500;
  }

  /* Desktop - 3 columns for compact horizontal layout */
  @media screen and (min-width: 1024px) {
    .form-grid {
      grid-template-columns: repeat(3, 1fr);
      gap: 20px;
    }
  }

  /* Tablet - 3 columns */
  @media screen and (min-width: 769px) and (max-width: 1023px) {
    .form-grid {
      grid-template-columns: repeat(3, 1fr);
      gap: 15px;
    }
  }

  /* Mobile responsive */
  @media screen and (max-width: 768px) {
    .form-grid {
      grid-template-columns: 1fr;
      gap: 18px;
    }

    .form-row select,
    .form-row input[type="text"],
    .form-row input[type="date"],
    .form-row input[type="file"] {
      font-size: 16px; /* Prevents zoom on iOS */
      padding: 14px 16px;
      min-height: 48px;
    }
  }

  @media screen and (max-width: 480px) {
    .form-grid {
      gap: 16px;
    }

    .form-row label {
      font-size: 0.9em;
    }
  }

  /* Organization search - needs relative positioning for autocomplete */
  .form-row.full-width.position-relative {
    position: relative;
  }
  
  /* Ensure autocomplete is positioned relative to the input container */
  .position-relative .autocomplete-suggestions {
    position: absolute !important;
    top: auto !important;
    left: auto !important;
    margin-top: 0 !important;
  }

  /* Ensure autocomplete works on mobile */
  @media screen and (max-width: 768px) {
    .autocomplete-suggestions {
      position: fixed !important;
      max-width: calc(100vw - 40px);
      left: 20px !important;
      right: 20px !important;
      margin-top: 0 !important;
    }
  }
</style>
</cfsavecontent>
<cfhtmlhead text="#styleTag#">

<div class="org-select-form">
  <!-- Error message display -->
  <div class="form-row full-width" id="ageGroupErrorRow" style="display: none;">
    <div id="ageGroupError" class="error-message"></div>
  </div>

  <!-- First row: Birth Year, Age Group, Level -->
  <div class="form-grid">
    <div class="form-row">
      <label for="birthYearId" class="labelFld">Birth Year</label>
      <select id="birthYearId" name="birthYearId" class="inputFld" required tabindex="5" onchange="updateProposedName(); validateAgeGroup();">
        <cfoutput query="qBirthYear">
          <option value="#BirthYearId#" <cfif attributes.BirthYearId is qBirthYear.BirthYearId> Selected </cfif>>#BirthYearDisplay#</option>
        </cfoutput>
      </select>
    </div>

    <div class="form-row">
      <label for="AgeGroupID" class="labelFld">Age Group</label>
      <select id="AgeGroupID" name="AgeGroupID" class="inputFld" required tabindex="6" onchange="updateProposedName(); validateAgeGroup();">
        <option value="" disabled selected>Select Age Group</option>
        <cfoutput query="qAgeGroup">
          <option value="#AgeGroupId#" #IIf(attributes.AgeGroupID EQ qAgeGroup.AgeGroupId, 'selected="selected"', '')#>#AgeGroup#</option>
        </cfoutput>
      </select>
    </div>

    <div class="form-row">
      <label for="TeamLevelId" class="labelFld">Level</label>
      <select id="TeamLevelId" name="TeamLevelId" class="inputFld" required tabindex="7" onchange="updateProposedName()">
        <option value="" selected>Select Level</option>
        <cfoutput query="qLevels">
          <option value="#TeamLevelId#" #IIf(attributes.TeamLevelId EQ qLevels.TeamLevelId, 'selected="selected"', '')#>#TeamLevel#</option>
        </cfoutput>
      </select>
    </div>
  </div>

  <!-- Second row: Season, Season Start, Season End -->
  <div class="form-grid">
    <div class="form-row">
      <label for="SeasonId" class="labelFld">Season</label>
      <select id="SeasonId" name="SeasonId" required class="inputFld" tabindex="8">
        <option value="" selected>Select Season</option>
        <cfoutput query="qSeason">
          <option value="#SeasonId#" #IIf(attributes.SeasonId EQ qSeason.SeasonId, 'selected="selected"', '')#>#Season#</option>
        </cfoutput>
      </select>
    </div>

    <cfoutput>
      <div class="form-row">
        <label for="seasonStart" class="labelFld">Season Start</label>
        <input type="date" id="seasonStart" name="seasonStart" required onblur="" class="inputFld" tabindex="9" value="#attributes.seasonStart#">
      </div>

      <div class="form-row">
        <label for="seasonEnd" class="labelFld">Season End</label>
        <input type="date" id="seasonEnd" name="seasonEnd" required onblur="" class="inputFld" tabindex="10" value="#attributes.seasonEnd#">
      </div>
    </cfoutput>
  </div>

  <!-- Organization search -->
  <div class="form-row full-width position-relative">
    <label for="searchOrgText" class="labelFld">Organization Name</label>
    <cfoutput>
      <input type="text" id="searchOrgText" name="searchOrgText" tabindex="#attributes.tabIndex#" required placeholder="Search for organization" value="#attributes.searchOrgText#" />
      <input type="hidden" id="OrganizationId" name="OrganizationId" value="#attributes.OrganizationId#" />
    </cfoutput>
  </div>

  <!-- Team Other Label -->
  <div class="form-row full-width">
    <label for="OtherTeam" class="labelFld">Team Other Label (Red, Green, etc.) <small>not required</small></label>
    <input type="text" id="OtherTeam" name="OtherTeam" class="inputFld" placeholder="Optional">
  </div>

  <!-- File upload -->
  <div class="form-row full-width" id="fileUploadRow">
    <label for="myFile" name="labelmyFile" class="labelFld">Team Icon File</label>
    <input type="file" name="myFile" id="myFile" class="inputFld" accept=".jpg, .png, .gif, .jpeg">
    <span id="fileName"></span>
  </div>

  <!-- Team Name Display -->
  <div class="form-row full-width">
    <label for="teamName" class="labelFld">Team Name</label>
    <cfoutput>
     
      <input type="text" id="teamName" name="teamName" disabled class="inputFld"  value="#attributes.TeamName#" />
    </cfoutput>
  </div>
</div>

<script>
<cfoutput>
$(function() {
  $('##searchOrgText').autocomplete({
    serviceUrl: '#application.actions#ajax_searchOrganization.cfm',
    appendTo: '.position-relative',
    onSelect: function (suggestion) {
      $('##OrganizationId').val(suggestion.data);
   
      if (suggestion.data !== "0") {
        $('##myFile').hide();
        $('label[for="myFile"]').hide();
        $('##fileUploadRow').hide();
      } else {
        $('##myFile').show();
        $('label[for="myFile"]').show();
        $('##fileUploadRow').show();
      }
      updateProposedName(); 
    }
  });
  
  // Function to position autocomplete dropdown
  function positionAutocompleteDropdown() {
    var $input = $('##searchOrgText');
    var $container = $input.closest('.position-relative');
    var $suggestions = $('.autocomplete-suggestions');
    
    if ($suggestions.length && $input.length) {
      var inputOffset = $input.position();
      var inputHeight = $input.outerHeight();
      var inputWidth = $input.outerWidth();
      
      $suggestions.css({
        'top': (inputOffset.top + inputHeight) + 'px',
        'left': inputOffset.left + 'px',
        'width': inputWidth + 'px',
        'margin-top': '0',
        'position': 'absolute'
      });
    }
  }
  
  // Ensure autocomplete dropdown appears directly below the input
  $('##searchOrgText').on('focus keyup', function() {
    setTimeout(positionAutocompleteDropdown, 50);
  });
  
  // Watch for autocomplete dropdown appearance using MutationObserver
  var observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      if (mutation.addedNodes.length) {
        var $suggestions = $('.autocomplete-suggestions:visible');
        if ($suggestions.length) {
          positionAutocompleteDropdown();
        }
      }
    });
  });
  
  // Observe the container for changes
  var $container = $('##searchOrgText').closest('.position-relative');
  if ($container.length) {
    observer.observe($container[0], { childList: true, subtree: true });
  }
  
  // Update position on window resize or scroll
  $(window).on('resize scroll', function() {
    if ($('.autocomplete-suggestions:visible').length) {
      positionAutocompleteDropdown();
    }
  });
  
  $('##searchOrgText').blur(function() {
    if ($('##searchOrgText').val() === '') {
      $('##OrganizationId').val('0');
    }
  });

  // Update file name display
  $('##myFile').change(function() {
    var fileName = $(this).val().split('\\').pop();
    $('##fileName').text(fileName ? 'Selected: ' + fileName : '');
  });
});
    </cfoutput>

// Function to update the proposed name
function updateProposedName() {
  // Get elements fresh each time to ensure they exist
  const birthyearEl = document.getElementById('birthYearId');
  const teamnameEl = document.getElementById('searchOrgText');
  const levelEl = document.getElementById('TeamLevelId');
  const ageGroupEl = document.getElementById('AgeGroupID');
  const otherTeamLabelEl = document.getElementById('OtherTeam');
  const proposednameEl = document.getElementById('teamName');
  const teamNameDisplayEl = document.getElementById('teamNameDisplay');
  const seasonIdEl = document.getElementById('SeasonId');

  // Check if required elements exist
  if (!birthyearEl || !teamnameEl || !levelEl || !ageGroupEl || !seasonIdEl) {
    return; // Exit early if elements don't exist
  }

  const lvl = levelEl.options[levelEl.selectedIndex] ? levelEl.options[levelEl.selectedIndex].text : '';
  const age = ageGroupEl.options[ageGroupEl.selectedIndex] ? ageGroupEl.options[ageGroupEl.selectedIndex].text : '';
  const year = birthyearEl.options[birthyearEl.selectedIndex] ? birthyearEl.options[birthyearEl.selectedIndex].text : '';
  const team = teamnameEl.value || '';
  const otherTeam = otherTeamLabelEl ? (otherTeamLabelEl.value || '') : '';
  const season = seasonIdEl.options[seasonIdEl.selectedIndex] ? seasonIdEl.options[seasonIdEl.selectedIndex].text : '';

  let ageName;
  let lvlName;
  
  if (age == "Select Age Group" || !age) {
    ageName = "";
  } else {
    ageName = `(${age})`;
  }

  if (lvl == "Select Level" || !lvl) {
    lvlName = "";
  } else {
    lvlName = `(${lvl})`;
  }

  let rawName = `${team} ${otherTeam} ${ageName} ${lvlName} ${season}`;
  const cleanedName = rawName.replace(/\s+/g, ' ').trim();
  
  // Update the hidden input field
  if (proposednameEl) {
    proposednameEl.value = cleanedName;
  }
  
  // Update the display div
  if (teamNameDisplayEl) {
    teamNameDisplayEl.textContent = cleanedName || 'Team name will appear here...';
  }
}

// Attach event listeners - wait for DOM to be ready
document.addEventListener('DOMContentLoaded', function() {
  const birthyear = document.getElementById('birthYearId');
  const teamname = document.getElementById('searchOrgText');
  const level = document.getElementById('TeamLevelId');
  const ageGroup = document.getElementById('AgeGroupID');
  const otherTeamLabel = document.getElementById('OtherTeam');
  const seasonId = document.getElementById('SeasonId');

  if (birthyear) {
    birthyear.addEventListener('change', updateProposedName);
    birthyear.addEventListener('change', validateAgeGroup);
  }
  if (teamname) {
    teamname.addEventListener('input', updateProposedName);
    teamname.addEventListener('change', updateProposedName);
  }
  if (ageGroup) {
    ageGroup.addEventListener('change', updateProposedName);
    ageGroup.addEventListener('change', validateAgeGroup);
  }
  if (level) {
    level.addEventListener('change', updateProposedName);
  }
  if (otherTeamLabel) {
    otherTeamLabel.addEventListener('input', updateProposedName);
    otherTeamLabel.addEventListener('change', updateProposedName);
  }
  if (seasonId) {
    seasonId.addEventListener('change', updateProposedName);
  }
  
  // Initialize on page load
  updateProposedName();
});

// Hide error row if empty on page load (also wait for DOM)
document.addEventListener('DOMContentLoaded', function() {
  const errorEl = document.getElementById('ageGroupError');
  const errorRow = document.getElementById('ageGroupErrorRow');
  if (errorEl && errorRow) {
    if (!errorEl.textContent || errorEl.textContent.trim() === '') {
      errorRow.style.display = 'none';
    }
  }
  
  // Initialize team name on page load
  updateProposedName();
});

function validateAgeGroup() {
  // Get elements fresh each time
  const ageGroupEl = document.getElementById('AgeGroupID');
  const birthYearSelect = document.getElementById('birthYearId');
  
  if (!ageGroupEl || !birthYearSelect) {
    return true; // If elements don't exist, return true to allow form submission
  }
  
  const selectedAgeGroup = ageGroupEl.options[ageGroupEl.selectedIndex] ? ageGroupEl.options[ageGroupEl.selectedIndex].text : '';
  const selectedBirthYearId = birthYearSelect.options[birthYearSelect.selectedIndex] ? birthYearSelect.options[birthYearSelect.selectedIndex].value : '';

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

  let result = ageTable.find(row => 
    row.ageGroup === selectedAgeGroup && 
    row.birthYearId === selectedBirthYearId
  );
  
  const submitButton = document.getElementById('submitBtn');
  const errorEl = document.getElementById('ageGroupError');
  const errorRow = document.getElementById('ageGroupErrorRow');
  
  if (!result && selectedAgeGroup && selectedBirthYearId && selectedAgeGroup !== 'Select Age Group') {
    if (errorEl) {
      errorEl.textContent = "Selected Age Group does not match the Birth Year.";
      if (errorRow) {
        errorRow.style.display = 'flex';
      }
    }
    return false;
  } else {
    if (errorEl) {
      errorEl.textContent = "";
      if (errorRow) {
        errorRow.style.display = 'none';
      }
    }
    return true;
  }
}
</script>



