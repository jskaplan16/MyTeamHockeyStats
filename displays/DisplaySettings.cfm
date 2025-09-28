<cfparam name="form.isAdmin" default="">

<cfset form.isCoach = "">
<cfset form.UserId = "">
<cfset form.firstName = "">
<cfset form.lastName = "">  
<cfset form.email="">

<cfif NOT structKeyExists(session, "userid")>
  <!--- Session expired or user not logged in --->
  <cflocation url="#application.pages#loginPage.cfm" addtoken="no">
<cfelseIf listFindNoCase("Guest","Anonymous",session.userId)>
  <cflocation url="#application.pages#loginPage.cfm" addtoken="no">
<cfelseif structKeyExists(session,"LoggedIn") and session.loggedIn eq false>
    <cflocation url="#application.pages#loginPage.cfm" addtoken="no">
</cfif>
<cfif not structKeyExists(session,"ShowAdminFunctions")>
    <cflocation url="#application.displays#DisplayGames.cfm" > 
</cfif>
<cfinclude template="#application.includes#header.cfm">
<cfparam name="form.teamUserId" default="">
<cfparam name="form.firstName" default="">
<cfparam name="form.lastName" default="">
<cfparam name="form.email" default="">
<cfparam name="form.userId" default="">
<cfparam name="form.UserName" default="">
<cfparam name="attributes.showAdminFunctions"  default="False">
<cfparam name="attributes.ShowCoachFunctions"  default="false">
<cfparam name="url.teamUserId" default="">
<cfset form.teamUserId = url.teamUserId>

<cfif len(form.teamUserId)>
    <cfquery name="qTeamUserInfo" datasource="#application.datasource#">
        exec stpGetTeamUsers @TeamUserId=#form.teamUserId#, @teamSeasonID=#session.teamSeasonID#      
        </cfquery>

    <cfset form.firstName=qTeamUserInfo.FirstName>
    <cfset form.lastName=qTeamUserInfo.LastName>  
    <cfset form.email=qTeamUserInfo.UserName>
    <cfset form.userId=qTeamUserInfo.UserId>
    <cfif qTeamUserInfo.isAdmin>
        <cfset form.isAdmin="checked">
    <cfelse>
        <cfset form.isAdmin="">
   </cfif>
     <cfif qTeamUserInfo.isCoach>
          <cfset form.isCoach="checked">
      <cfelse>
          <cfset form.isCoach="">
      </cfif>

</cfif>

<div class="content">
    <div class="PageHeader">
       <cfoutput> #session.TeamName# - Settings </cfoutput>
    </div>

<cfoutput>
 <div>
  <label for="searchEmail" class="labelfld">Search by Email:</label>
  <input type="text" id="searchEmail" placeholder="Type email address..." autocomplete="off" style="width:300px;" class="inputFld" value="#form.email#">
  <ul id="dropdownList" class="dropdown-list"></ul>
  
  <form autocomplete="on" action="#application.actions#ActionSaveAddUsers.cfm" method="post">
    <label for="firstName" class="labelFld">First Name:</label>
    <input type="text" class="inputFld" id="firstName" name="firstname" style="width: 25%;" value="#form.firstName#">
    <input type="hidden"  id="userid" name="userId" value="#form.userId#">
    <input type="hidden"  id="email" name="email" value="#form.email#">
    <input type="hidden"  id="teamUserId" name="teamUserId" value="#form.teamUserId#">
    <br>
    <label for="lastName" class="labelFld">Last Name:</label>
    <input type="text" class="inputFld" id="lastName" name="lastname" style="width: 25%;" value="#form.lastname#">
    <br>

<div class="container">

  
  <input name="isAdmin" type="checkbox" id="isAdmin" class="inputfld" #form.isAdmin#>
  <label for="isAdmin" class="labelfld">Admin Permissions</label> 
  
     <br>
    <input type="checkbox" name="isCoach" id="isCoach" class="inputfld" #form.isCoach#>   
    <label for="isCoach" class="labelfld">Coach Permissions</label>        
 </div>   
 </cfoutput>
 <input type="submit" value="Save User" class="inputfld">
  </form>
</div>
 
  <cfquery  datasource="#application.datasource#" name="qUsers">
      exec stpGetTeamUsers @TeamSeasonId=#session.TeamSeasonId#
    </cfquery>
<table class="table-container">
<tr>
<th class="admin-header" style="text-align: center;">User Name</th>
<th class="admin-header" style="text-align: center;">First Name</th>
<th class="admin-header" style="text-align: center;">Last Name</th>
<th class="admin-header" style="text-align: center;">&nbsp;</th>
</tr>
<cfoutput query="qUsers">
  <cfif qUsers.CurrentRow  mod 2>
    <cfset className="row-even">
  <cfelse>
    <cfset className="row-odd">
  </cfif>  
<tr class="#className#">
<td style="text-align: left;margin: 5px;padding: 5px;">
#qUsers.UserName#
</td>
<td style="text-align: left;margin: 5px;padding: 5px;">
#qUsers.FirstName#
</td>
<td style="text-align: left;margin: 5px;padding: 5px;">
#qUsers.LastName#
</td>
<td>
<input type="button" onclick="location.href='#application.displays#DisplaySettings.cfm?teamUserId=#qUsers.TeamUserId#'" value="Edit" class="inputfld">
</td>
</tr>
</cfoutput>
</table>
 </div>
  </div>
<script type="text/javascript">
  const emailInput = document.getElementById("searchEmail");
const dropdownList = document.getElementById("dropdownList");


function fetchUserByEmail(email) {
  fetch(`api_settings_users.cfm?email=${encodeURIComponent(email)}`)
    .then(response => response.json())
    .then(user => {
      console.log(user);
      if (user[0] && user[0].userid) {
        document.getElementById("firstName").value = user[0].firstname;
        document.getElementById("lastName").value = user[0].lastname;
        document.getElementById("isAdmin").checked = !!user[0].admin;
        document.getElementById("isCoach").checked = !!user[0].coach;
        document.getElementById("userid").value = user[0].userid; // Always checked
        document.getElementById("email").value = user[0].email; 
       
      } else {
        // Clear fields if user not found
        document.getElementById("firstName").value = "";
        document.getElementById("lastName").value = "";
        document.getElementById("isAdmin").checked = false;
        document.getElementById("isCoach").checked = false;
         document.getElementById("userid").value = ""; // 
         document.getElementById("email").value = email; 
      }
    });
}

// Add this inside your dropdown select handler:
function selectUser(email) {
  emailInput.value = email;
  dropdownList.style.display = "none";
  fetchUserByEmail(email);
}

// Example: Trigger fetch when user types a full email or selects from dropdown
emailInput.addEventListener("change", function() {

  if (emailInput.value.includes("@")) {
    fetchUserByEmail(emailInput.value);
  }
});
</script>
  



<cfinclude template="#application.includes#footer.cfm" >