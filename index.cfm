<cfif structKeyExists(session,"username") and (session.username is not "Guest" and session.loggedIn)>
<cflocation url="Games.cfm">
</cfif> 

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>MyTeamHockeyStats.com</title>
  
  <style>
  :root {
  --primary-blue: #185abc;
  --accent-blue: #2492ff;
  --white: #ffffff;
  --gray: #f0f3f7;
  --dark: #13223b;
}
    /* Basic inline CSS for demonstration purposes */
    body {
      font-family: 'Roboto', 'Arial', sans-serif;
      margin: 0;
      padding: 0;
      line-height: 1.6;
      background-color: var(--primary-blue);
    }
    header, search {
      background: var(--primary-blue);
      color: #fff;
      padding: 20px 10%;
      text-align: center;
      width: auto;
    }
    header h1 {
      margin: 0;
    }
    nav {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin-top: 10px;
    }
    nav a {
      color: #fff;
      text-decoration: none;
    }
    .hero {
      text-align: center;
      padding: 50px 10%;
      background-color: var(--[primary-blue]);
    }
    .hero h2 {
      font-size: 2.5em;
      margin-bottom: 10px;
    }
    .hero p {
      font-size: 1.2em;
      margin-bottom: 20px;
    }
    .login{
        text-align: right;
        color: #fff;
    }

    .cta-buttons a {
      display: inline-block;
      padding: 15px 30px;
      margin: 5px;
      text-decoration: none;
      color: #fff;
      background-color:var(--accent-blue);
      border-radius: 5px;
    }
    .cta-buttons a.secondary {
      background-color: var(--gray); 
    }
    section {
      padding: 50px 10%;
    }
    section h3 {
      text-align: center;
      margin-bottom: 30px;
    }
    .benefits, .steps {
      display: flex;
      justify-content: space-between;
      gap: 20px;
    }
    .benefit, .step {
      flex-basis: calc(33.333% - 20px);
      text-align: center;
    }
    footer {
      background-color: #333;
      color: #fff;
      text-align: center;
      padding: 20px 10%;
    }
    footer a {
      color: var(--dark);
      text-decoration: none;
    }
    .searchBox,.SearchLabel {
      width: 65%;
      padding: 10px;
      font-size: 2.2em;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    .SearchLabel{
      display: inline;
      margin: 10px 0;
      font-size: 1.5em;
      border:0px;
    }
    #searchResults {
  border: 1px solid #ddd;
  max-height: 200px;
  overflow-y: auto;
  display: none;
}
#searchResults div:hover {
  background-color: var(--gray);
}
 #backgroundVideo {
  position: fixed;
  top: 0; left: 0;
  min-width: 100vw; min-height: 100vh;
  width: 100%; height: 100%;
  z-index: -1;
  object-fit: cover;
  background: #000;
  opacity: 50%;
}
.site-content {
  position: relative;
  z-index: 2;
  /* Further styling for page text/images */
}   
  </style>
 
   
</head>
<body>

<cfquery  datasource="#Application.Datasource#" name="getTeams">
  exec stpGetTeams @OnlyDisplayPublicMembers=1 
</cfquery>

<!-- Header Section -->
<div class="site-content">
  <!-- All navigation, text, buttons, overlays go here -->


<div style="color: #fff; padding: 20px 10%; text-align: right;">
  <a href="authenticate.cfm" class="login">Login</a>


    <div class="cta-buttons">
      <a href="SignUpPage.cfm">Get Started for Free</a>  
    </div>

</div>

<div style="text-align: center;">
  <cfoutput>
  <img src="#Application.icons#myTeamHockeyStats.png" 
       style="max-width: 300px;" 
       alt="Hockey Icon">
</cfoutput>
      </div>
<section class="hero" style="width: 70%;">
  <h2>Take Control of Your Hockey Team's Performance</h2>
  <p>Track games, goals, assists, penalties, plus/minus, and more with our easy-to-use DIY stats platform. 
  <br>Perfect for coaches, players, team managers and of course crazy hockey parents!!!!</p>
</section>
<div style="width: 50%;text-align: center; margin: 0 auto; padding-bottom: 50px;">
  <cfoutput>
<form action="#application.Displays#DisplaySelectGame.cfm" method="post">
 </cfoutput>
  <label for="searchBox" class="SearchLabel">Search Teams:</label>
  <select  id="searchBox" name="TeamSeasonId" placeholder="Search Teams using my FreeHockeyStats.com"  class="searchBox" onchange="submit()" style="width:50%">
    <option value="">Select a Team</option>
    <cfoutput query="getTeams">
      <option value="#getTeams.TeamSeasonId#">#getTeams.FullTeamName#</option> 
        </cfoutput>
  </select>

  </div>

</div>

<video autoplay muted loop playsinline preload="auto" id="backgroundVideo">
<cfoutput>
  <source src="#Application.icons#BackgroundVideo.mp4" type="video/mp4">
</cfoutput>
  Your browser does not support the video tag.
</video>





</body>
</html>


