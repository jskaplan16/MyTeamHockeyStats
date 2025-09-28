<cfparam name="attributes.showHeader" default="true">

<cfswitch expression='#thisTag.ExecutionMode#'>

<cfcase value='start'>

<html >

	<title>My Team Hockey Stats</title>

	<head>
	   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
		<link rel="stylesheet" href="assets/css/myhockeyStatsStyle.css">
		<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
	</head>

<body>
<header class="header-banner">
  <div class="nav-cell logo" style="text-align: left;">
    <a href="index.cfm" tabindex="-1">
      <img src="assets/images/HockeyIcons/myTeamHockeyStats.png" alt="My Team Hockey Stats" width="100" tabindex="-1">
    </a>
  </div>

  <div class="nav-links"> <!-- New wrapper for centered links -->
    <div class="nav-cell-large">
     MyTeamHockeyStats.com 
			<div class="nav-cell-small">
			 <i>Capture stats for every game, every player. Film, upload to YouTube and start tracking. Anyone can sign up start tracking today!!!!</i>
			</div>
    </div>
   
</header>
<div style="margin:50px;">
</cfcase>

	

<cfcase value='end'>

	</div>
	<!---<div class="footer-banner"></div>		--->

</body>

</html>

	</cfcase>

</cfswitch>	