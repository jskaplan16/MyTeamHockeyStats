<cfif thisTag.ExecutionMode is "start">
<cfparam name="session.ShowCoachFunctions" default="false">
<cfparam name="session.ShowAdminFunctions" default="false">
<cfparam name="session.userID" default="Anonymous">
<cfparam name="session.startofSeason" default="07/01/2024">
<cfparam name="session.endofSeason" default="04/01/2025">
<cfparam name="session.TeamId" default="0">
<cfparam name="session.TeamName" default="">



<cfparam name="url.gameId" default="">
<cfparam name="attributes.showNavBar" default="true">
	
<cfparam name="session.loggedIn" default="false">

<cfif isDefined("Session.UserId")>
		<cftry>
		<cfquery datasource="#application.datasource#" name="qAudit">
	    dbo.stpInsertPageAudit 
			@PageName = '#cgi.SCRIPT_NAME#',
			@QueryString= '#cgi.QUERY_STRING#',
			@UserId = '#session.userId#'
		
		 </cfquery>
		
	<cfcatch>

	</cfcatch>
			</cftry>
		</cfif>		
<html>
	<title>My Free Hockey Stats</title>
	<head>
		<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
  
    <cfif session.userID  is not "Anonymous">
  
  <script>
  // Function to toggle the dropdown menu
  function toggleDropdown() {
    const dropdown = document.getElementById('profileDropdown');
    dropdown.classList.toggle('active');
  }

  // Close the dropdown if clicked outside
  

  window.addEventListener('click', function(event) {
  const dropdown = document.getElementById('profileDropdown');
  const button = document.querySelector('.profile-button');

  if (!dropdown || !button) return; // Avoid null reference errors

  if (!button.contains(event.target) && !dropdown.contains(event.target)) {
    dropdown.classList.remove('active');
  }
});
</script>
</cfif>
	 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

 <link rel="stylesheet" href="myteamhockeyStats.css">
  
	</head>

  <cfif attributes.showNavBar is false>
    <body style="background-color: white;">
  <cfelse>
    <body>
 </cfif>
    <cfif attributes.showNavBar>
      
        <cfoutput>
<header class="header-banner">
  <div class="nav-cell logo" style="text-align: left;">
    <a href="index.cfm" tabindex="-1">
      <img src="assets/images/HockeyIcons/myTeamHockeyStats.png" alt="My Team Hockey Stats" he tabindex="-1" width="125">
    </a>
  </div>

  <div class="nav-links"> <!-- New wrapper for centered links -->
    <div class="nav-cell">
      <a href="Games.cfm" class="nav-link" tabindex="-1">Games</a>
    </div>
    <div class="nav-cell">
      <a href="Roster.cfm" class="nav-link" tabindex="-1">Roster</a>
    </div>
    <div class="nav-cell">
      <a href="DisplayShift.cfm" tabindex="-1" class="nav-link">Shifts</a>
    </div>

                <cfif session.ShowCoachFunctions>
                    <div class="nav-cell">
                        <a href="LineApp.cfm" tabindex="-1" class="nav-link">Line Builder</a>
                    </div>
                    <div class="nav-cell">
                        <a href="Reports.cfm"  tabindex="-1" class="nav-link">Reports</a>
                    </div>
                </cfif>
                <cfif session.ShowAdminFunctions>
                    <div class="nav-cell">
                        <a href="Admin.cfm" tabindex="-1" class="nav-link">Admin Area</a>
                    </div>

                </cfif>


          
                           
  <div class="profile-container">
  <cfif session.userID  is not "Anonymous">
  <!-- Username button -->
      <cfif session.FullName is not "user">
        <button class="profile-button" tabindex="-1" onclick="toggleDropdown()">#session.FullName#</button>
      </cfif>
  <!-- Dropdown menu -->
    <cfif isDefined("session.getUser")>  
        <div class="dropdown-menu" id="profileDropdown">
          <cfif session.ShowAdminFunctions>
                <a href="/DisplaySetupSteps.cfm" tabindex="-1">Setup Page</a>
          </cfif>
          <cfif isdefined("session.getUSer") and session.getUSer.recordCount gt 1>    
                <a href="/DisplayMultiTeam.cfm" tabindex="-1">Change Teams</a>
          </cfif>
          <a href="/logout.cfm" tabindex="-1">Log Out</a>
        </div>
      </cfif>
</div>
  </cfif>

<cfif session.userID  is "0">
       <div class="nav-cell">
              <a href="LoginPage.cfm" tabindex="-1"  class="nav-link">Login</a>
          </div>
    <button class="profile-button" tabindex="-1" >
    <a href="SignUpPage.cfm">Create Account</a> 
    </button>
</cfif>
  
  <div class="nav-cell">
  <cfif structKeyExists(session,"Season")>  Season: #session.season# </cfif>
  </div>

            </header>
        </cfoutput>
  
    </cfif>

    <main class="content">
        <!-- Your main content goes here -->
</cfif>

<cfif thisTag.ExecutionMode is "end">

     </main>
</body>
</html>

<cfif isDefined("form.showNavBar") and form.showNavBar is not true>
<cfsetting showdebugoutput="no">
<cfelse>
<cfsetting showdebugoutput="yes">
</cfif>
</cfif>