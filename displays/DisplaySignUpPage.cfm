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
<cfoutput>
<div class="form-container" style="width: 40%;">
    <h1 class="headerSignUp">Team Sign-Up</h1>
    <cfoutput>
    <form id="signupForm" class="signup" action="#application.actions#ActionSignup.cfm" method="post"  enctype="multipart/form-data" onsubmit="return validateAgeGroup();">
    </cfoutput>
      <!-- First Name -->

              

      <label for="firstName" class="labelFld">First Name:</label>
      <input type="text" id="firstName" name="firstName" required class="inputFld" style="width: 30em;" tabindex="1" value="#form.firstName#">
      
      <!-- Last Name -->
      <label for="lastName" class="labelFld">Last Name:</label>
      <input type="text" id="lastName" name="lastName" class="inputFld" required style="width: 30em;" tabindex="2" value="#form.lastName#">
      
      <!-- Email Address -->
      <label for="email" class="labelFld">Email Address:</label>
      <input type="email" id="email" name="email" required class="inputFld" style="width: 30em;" autocomplete="Email Address" tabindex="3" value="#form.email#">
          
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
<input type="submit" class="signup" id="submitBtn" style="width: 10em;" onclick="updateProposedName();"></input>
  </div>

    </form>
</cfoutput>
</div>
</div>


</CF_BaseHeader>
   

