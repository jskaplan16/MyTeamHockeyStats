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

<cfif isDefined("Session.UserId") and len(session.userID) is not 0 and session.userID is not "Anonymous">
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
	<title>My Team Hockey Stats</title>
  <cfoutput>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
		<meta name="mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
		<meta name="apple-mobile-web-app-title" content="Hockey Stats">
		<meta name="theme-color" content="##185abc">
		<meta name="msapplication-TileColor" content="##185abc">
		<meta name="msapplication-navbutton-color" content="##185abc">
		<link rel="icon" href="#application.images#favicon.ico" type="image/x-icon">
		<link rel="apple-touch-icon" href="#application.images#favicon.ico">
		<link rel="manifest" href="manifest.json">
  
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
	  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <link rel="stylesheet" href="#application.css#myhockeyStatsStyle.css">
	</head>
  </cfoutput>

  <cfif attributes.showNavBar is false>
    <body style="background-color: #185abc;">
  <cfelse>
    <body>
 </cfif>
    <cfif attributes.showNavBar>
      
      <cfoutput>
<header class="header-banner">
  <div class="nav-cell logo" style="text-align: left;">
    <a href="#application.base#index.cfm" tabindex="-1">
      <img src="#application.images#myTeamHockeyStats.png" alt="My Team Hockey Stats" width="100" tabindex="-1">
    </a>
  </div>

  <div class="nav-links"> <!-- New wrapper for centered links -->
    <div class="nav-cell">
      <a href="#application.displays#DisplayGames.cfm" class="nav-link" tabindex="-1">Games</a>
    </div>
    <div class="nav-cell">
      <a href="#application.displays#DisplayRoster.cfm" class="nav-link" tabindex="-1">Roster</a>
    </div>
    <!---
    <div class="nav-cell">
      <a href="DisplayShift.cfm" tabindex="-1" class="nav-link">Shifts</a>
    </div>
--->
                <cfif session.ShowCoachFunctions>

                    <div class="nav-cell">
                        <a href="#Application.displays#DisplayReports.cfm"  tabindex="-1" class="nav-link">Coach Tools</a>
                    </div>
                </cfif>
                
                <cfif session.ShowAdminFunctions>
                    <div class="nav-cell">
                        <a href="#Application.displays#DisplayAdmin.cfm" tabindex="-1" class="nav-link">Admin Area</a>
                    </div>

                </cfif>


          
                           

  <cfif session.userID  is not "Anonymous">
    <div class="profile-container">
  <!-- Username button -->
      <cfif session.FullName is not "user">
        <button class="profile-button" tabindex="-1" onclick="toggleDropdown()">#session.FullName#</button>
      </cfif>
  <!-- Dropdown menu -->
    <cfif isDefined("session.getUser")>  
        <div class="dropdown-menu" id="profileDropdown">
 
          <cfif isdefined("session.getUSer") and session.getUSer.recordCount gt 1>    
                <a href="#Application.displays#DisplayMultiTeam.cfm" tabindex="-1">Change Teams</a>
          </cfif>
          <a href="#application.actions#Actionlogout.cfm" tabindex="-1">Log Out</a>
        </div>
      </cfif>
</div>
  </cfif>

<cfif session.userID  is "0" or session.userID is "" or session.userID is "Anonymous">
  <div class="nav-cell">
    <button class="profile-button" tabindex="-1" >
       <a href="#Application.displays#DisplaySignUpPage.cfm">Create Account</a> 
    </button>
  </div>

    <div class="nav-cell">
      <a href="#Application.displays#DisplayLoginPage.cfm" tabindex="-1"  class="nav-link">Login</a>
    </div>  
</cfif>
  
  <div class="nav-cell">
  <cfif structKeyExists(session,"Season")>  Season: #session.season# </cfif>
  </div>

            </header>
        </cfoutput>
  
    </cfif>


        <!-- Your main content goes here -->

