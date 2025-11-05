<cfparam name="form.firstName" default="">
<cfparam name="form.lastName" default="">
<cfparam name="form.email" default="" >

<cfquery name="qAppDefaults" datasource="#application.datasource#"> 
  exec stpApplicationDefaults
</cfquery>

<cfparam name="form.BirthYearId" default="#qAppDefaults.BirthYearId#">
<cfparam name="form.AgeGroupId" default="#qAppDefaults.AgeGroupId#">
<cfparam name="form.TeamLevelId" default=""> 
<cfparam name="form.SeasonId" default="#qAppDefaults.SeasonId#">
<cfparam name="form.seasonStart" default="#qAppDefaults.DefaultStartDate#">
<cfparam name="form.seasonEnd" default="#qAppDefaults.DefaultEndDate#">
<cfparam name="form.searchOrgText" default="">
<cfparam name="form.OrganizationId" default="0">
<cfparam name="form.OtherTeam" default=""> 
<cfparam name="form.TeamName" default="" >  

<CF_BaseHeader>
<cfif isDefined("errorMsg")>
  <div>
  <cfoutput>
      #errorMsg#
    </cfoutput>
  <div>
</cfif>
<br>

<style>
  /* Ensure form and container don't affect grid alignment */
  form.signup {
    padding-left: 0;
    padding-right: 0;
    margin-left: 0;
    margin-right: 0;
  }
  
  .form-container {
    padding-left: 0;
    padding-right: 0;
  }
  
  /* Ensure org-select-form grids align with parent form grids */
  .org-select-form .form-grid {
    margin-left: 0;
    margin-right: 0;
  }
  
  /* Match the grid layout from DisplayOrganizationAutoSelect */
  .form-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    margin-bottom: 15px;
    margin-top: 0;
    margin-left: 0;
    margin-right: 0;
  }

  .form-row {
    display: flex;
    flex-direction: column;
    gap: 6px;
    align-items: flex-start;
    text-align: left;
    margin-left: 0;
    margin-right: 0;
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

  .form-row select,
  .form-row input[type="text"],
  .form-row input[type="email"],
  .form-row input[type="date"] {
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
  .form-row input[type="email"]:focus,
  .form-row input[type="date"]:focus {
    outline: none;
    border-color: var(--accent-blue, #2492ff);
    background: rgba(255,255,255,0.15);
  }

  .form-row input[type="text"]::placeholder,
  .form-row input[type="email"]::placeholder {
    color: rgba(0,0,0,0.5);
  }

  /* Mobile responsive */
  @media screen and (max-width: 768px) {
    .form-grid {
      grid-template-columns: 1fr;
      gap: 18px;
    }

    .form-row select,
    .form-row input[type="text"],
    .form-row input[type="email"],
    .form-row input[type="date"] {
      font-size: 16px;
      padding: 14px 16px;
      min-height: 48px;
    }
  }
</style>

<div class="form-container" style="width: 60%;padding:10px;">
    <h1 class="headerSignUp">Team Sign-Up</h1>
    <cfoutput>
    <form id="signupForm" class="signup" action="#application.actions#ActionSignup.cfm" method="post"  enctype="multipart/form-data" onsubmit="return validateAgeGroup();">
   
      
      <!-- First Name, Last Name, Email in grid layout -->
      <div class="form-grid">
        <div class="form-row">
          <label for="firstName" class="labelFld">First Name:</label>
          <input type="text" id="firstName" name="firstName" required class="inputFld" tabindex="1" value="#form.firstName#">
        </div>
        
        <div class="form-row">
          <label for="lastName" class="labelFld">Last Name:</label>
          <input type="text" id="lastName" name="lastName" class="inputFld" required tabindex="2" value="#form.lastName#">
        </div>
        
        <div class="form-row">
          <label for="email" class="labelFld">Email Address:</label>
          <input type="email" id="email" name="email" required class="inputFld" autocomplete="Email Address" tabindex="3" value="#form.email#">
        </div>
      </div>
          
        <cf_displayOrganizationAutoSelect 
        birthYearId="#form.BirthYearId#" 
        AgeGroupId="#form.AgeGroupId#"
        SeasonId="#form.SeasonId#"
        seasonStart="#form.seasonStart#"
        seasonEnd="#form.seasonEnd#"
        searchOrgText="#form.searchOrgText#"
        OrganizationId="#form.OrganizationId#"
        TeamName="#form.TeamName#"
        
        >
 
<br> 
<input type="submit" class="signup" id="submitBtn" style="width: 10em;" onclick="updateProposedName();">
  </div>

    </form>
  </cfoutput>
</div>
</div>


</CF_BaseHeader>
   

