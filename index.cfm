<cfif structKeyExists(session,"username") and (session.username is not "Guest" and session.loggedIn)>
<cflocation url="#application.displays#DisplayGames.cfm">
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
  --text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}
    /* Basic inline CSS for demonstration purposes */
    html, body {
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;
      overflow-x: hidden;
    }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Arial', sans-serif;
      line-height: 1.6;
      background-color: var(--primary-blue);
      position: relative;
      color: #fff;
    }
    
    /* Header/Navigation Styles */
    .top-header {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 15px 5% 5px 5%;
      position: relative;
      z-index: 10;
    }
    .logo-container {
      flex: 1;
      text-align: center;
    }
    .logo-container img {
      max-width: 240px;
      width: 100%;
      height: auto;
      filter: drop-shadow(0 2px 8px rgba(0,0,0,0.3));
    }
    .header-actions {
      display: flex;
      gap: 15px;
      align-items: center;
    }
    .top-right-actions {
      position: fixed;
      top: 20px;
      right: 20px;
      display: flex;
      gap: 12px;
      align-items: center;
      z-index: 100;
    }
    .login-link {
      color: #fff;
      text-decoration: none;
      font-weight: 500;
      padding: 10px 20px;
      border-radius: 25px;
      transition: all 0.3s ease;
      text-shadow: var(--text-shadow);
      background-color: rgba(19, 34, 59, 0.7);
      backdrop-filter: blur(5px);
      white-space: nowrap;
    }
    .login-link:hover {
      background-color: rgba(255,255,255,0.25);
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }
    .top-right-cta {
      display: inline-block;
      padding: 10px 20px;
      text-decoration: none;
      color: #fff;
      background: linear-gradient(135deg, var(--accent-blue) 0%, #1e7cd8 100%);
      border-radius: 25px;
      font-weight: 600;
      font-size: 0.95em;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(36, 146, 255, 0.4);
      white-space: nowrap;
    }
    .top-right-cta:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(36, 146, 255, 0.6);
      background: linear-gradient(135deg, #2a9fff 0%, #2585e0 100%);
    }
    
    .hero {
      text-align: center;
      padding: 15px 5% 15px 5%;
      position: relative;
      z-index: 5;
      margin-top: -10px;
    }
    .hero-content {
      background: rgba(19, 34, 59, 0.75);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      padding: 25px 30px;
      max-width: 900px;
      margin: 0 auto;
      box-shadow: 0 8px 32px rgba(0,0,0,0.3);
      border: 1px solid rgba(255,255,255,0.1);
    }
    .hero h2 {
      font-size: 2.3em;
      margin-bottom: 12px;
      text-shadow: var(--text-shadow);
      font-weight: 700;
      line-height: 1.2;
    }
    .hero p {
      font-size: 1.1em;
      margin-bottom: 0;
      line-height: 1.6;
      text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
    }

    .cta-buttons a {
      display: inline-block;
      padding: 16px 35px;
      margin: 5px;
      text-decoration: none;
      color: #fff;
      background: linear-gradient(135deg, var(--accent-blue) 0%, #1e7cd8 100%);
      border-radius: 30px;
      font-weight: 600;
      font-size: 1.1em;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(36, 146, 255, 0.4);
      text-shadow: none;
    }
    .cta-buttons a:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 20px rgba(36, 146, 255, 0.6);
      background: linear-gradient(135deg, #2a9fff 0%, #2585e0 100%);
    }
    
    /* Search Section */
    .search-section {
      width: 100%;
      max-width: 700px;
      margin: 20px auto 30px auto;
      padding: 0 5% 30px;
      position: relative;
      z-index: 5;
    }
    .search-container {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 15px;
      padding: 25px;
      box-shadow: 0 10px 40px rgba(0,0,0,0.3);
      border: 1px solid rgba(255,255,255,0.3);
    }
    .SearchLabel {
      display: block;
      margin: 0 0 12px 0;
      font-size: 1.3em;
      font-weight: 600;
      color: var(--dark);
      text-align: center;
    }
    .searchBox {
      width: 100%;
      padding: 14px 18px;
      font-size: 1.2em;
      border: 2px solid #ddd;
      border-radius: 10px;
      box-sizing: border-box;
      transition: all 0.3s ease;
      background-color: #fff;
      text-overflow: ellipsis;
      white-space: nowrap;
      overflow: hidden;
    }
    .searchBox:focus {
      outline: none;
      border-color: var(--accent-blue);
      box-shadow: 0 0 0 3px rgba(36, 146, 255, 0.2);
    }
    .searchBox option {
      white-space: normal;
      word-wrap: break-word;
      padding: 12px;
      font-size: 1em;
    }
    /* Mobile responsive styles */
    @media screen and (max-width: 768px) {
      .top-right-actions {
        top: 15px;
        right: 15px;
        gap: 8px;
        flex-wrap: wrap;
        justify-content: flex-end;
      }
      .login-link {
        padding: 8px 16px;
        font-size: 0.9em;
      }
      .top-right-cta {
        padding: 8px 16px;
        font-size: 0.85em;
      }
      .top-header {
        flex-direction: column;
        gap: 20px;
        padding: 15px 5% 5px 5%;
      }
      .logo-container img {
        max-width: 220px;
      }
      .header-actions {
        flex-direction: column;
        width: 100%;
        gap: 10px;
      }
      .cta-buttons {
        width: 100%;
      }
      .cta-buttons a {
        display: block;
        width: 100%;
        text-align: center;
      }
      .hero {
        padding: 10px 5% 30px 5%;
        margin-top: -5px;
      }
      .hero-content {
        padding: 35px 25px;
        border-radius: 15px;
      }
      .hero h2 {
        font-size: 2em;
        margin-bottom: 15px;
      }
      .hero p {
        font-size: 1.1em;
      }
      .search-section {
        margin: 30px auto;
        padding: 0 5% 30px;
      }
      .search-container {
        padding: 25px 20px;
        border-radius: 12px;
      }
      .SearchLabel {
        font-size: 1.2em;
        margin-bottom: 12px;
      }
      .searchBox {
        padding: 14px 16px;
        font-size: 1.1em;
        border-radius: 8px;
      }
      .searchBox option {
        font-size: 0.95em;
        padding: 10px;
      }
    }
    @media screen and (max-width: 480px) {
      .top-right-actions {
        top: 12px;
        right: 12px;
        gap: 6px;
      }
      .login-link {
        padding: 7px 14px;
        font-size: 0.85em;
      }
      .top-right-cta {
        padding: 7px 12px;
        font-size: 0.8em;
      }
      .top-header {
        padding: 12px 3% 5px 3%;
      }
      .logo-container img {
        max-width: 180px;
      }
      .hero {
        padding: 10px 3% 20px 3%;
        margin-top: -5px;
      }
      .hero-content {
        padding: 25px 18px;
      }
      .hero h2 {
        font-size: 1.6em;
        line-height: 1.3;
      }
      .hero p {
        font-size: 1em;
      }
      .search-section {
        padding: 0 3% 20px;
        margin: 20px auto;
      }
      .search-container {
        padding: 20px 15px;
      }
      .SearchLabel {
        font-size: 1.1em;
      }
      .searchBox {
        padding: 12px 14px;
        font-size: 1em;
      }
      .searchBox option {
        font-size: 0.9em;
      }
      .cta-buttons a {
        padding: 14px 25px;
        font-size: 1em;
      }
    }
    /* Mobile video fixes */
    @media screen and (max-width: 768px) {
      #backgroundVideo {
        width: 100%;
        height: 100%;
        min-width: 100%;
        min-height: 100%;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        object-fit: cover;
        object-position: center;
        /* Force hardware acceleration on mobile */
        -webkit-transform: translate3d(0, 0, 0);
        transform: translate3d(0, 0, 0);
        /* Fix for iOS Safari */
        -webkit-backface-visibility: hidden;
        backface-visibility: hidden;
      }
    }
    /* Additional fixes for very small screens */
    @media screen and (max-width: 480px) {
      #backgroundVideo {
        /* Ensure video fills screen on small devices */
        width: 100% !important;
        height: 100% !important;
        min-width: 100% !important;
        min-height: 100% !important;
        max-width: 100% !important;
        max-height: 100% !important;
      }
    }
    /* Landscape mobile orientation */
    @media screen and (max-width: 768px) and (orientation: landscape) {
      #backgroundVideo {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
      }
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
  top: 0;
  left: 0;
  min-width: 100vw;
  min-height: 100vh;
  width: 100vw;
  height: 100vh;
  z-index: -1;
  object-fit: cover;
  object-position: center center;
  background: #000;
  opacity: 50%;
  /* Ensure video stays behind content */
  transform: translateZ(0);
  /* Prevent video from breaking layout on mobile */
  -webkit-transform: translateZ(0);
}
.site-content {
  position: relative;
  z-index: 2;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}   
  </style>
 
   
</head>
<cfquery  datasource="#application.datasource#" name="getTeams">
  exec stpGetTeams @OnlyDisplayPublicMembers=1 
</cfquery>

<body>


<cfoutput>
<!-- Background Video -->
<video autoplay muted loop playsinline preload="auto" id="backgroundVideo">
  <source src="#Application.images#BackgroundVideo.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>
</cfoutput>
<!-- Main Content -->
<div class="site-content">
  
  <!-- Top Right Actions - Login & Get Started -->
  <cfoutput>
  <div class="top-right-actions">
    <a href="#application.pages#authenticate.cfm" class="login-link">Login</a>
    <a href="#application.displays#DisplaySignUpPage.cfm" class="top-right-cta">Get Started for Free</a>
  </div>

  <!-- Top Header with Logo -->
  <header class="top-header">
    <div class="logo-container">
      <img src="#Application.images#myTeamHockeyStats.png" alt="My Team Hockey Stats Logo">
    </div>
  </header>
</cfoutput>
  <!-- Hero Section -->
  <section class="hero">
    <div class="hero-content">
      <h2>Take Control of Your Hockey Team's Performance</h2>
      <p>Track games, goals, assists, penalties, plus/minus, and more with our easy-to-use DIY stats platform. 
      <br>Perfect for coaches, players, team managers and of course crazy hockey parents!!!!</p>
    </div>
  </section>

  <!-- Search Section -->
  <div class="search-section">
    <div class="search-container">
      <cfoutput>
      <form action="#application.Displays#DisplaySelectGame.cfm" method="post">
       </cfoutput>
        <label for="searchBox" class="SearchLabel">Search Teams:</label>
        <select id="searchBox" name="TeamSeasonId" placeholder="Search Teams using my FreeHockeyStats.com" class="searchBox" onchange="submit()">
          <option value="">Select a Team</option>
          <cfoutput query="getTeams">
            <option value="#getTeams.TeamSeasonId#">#getTeams.FullTeamName#</option> 
          </cfoutput>
        </select>
      </form>
    </div>
  </div>

</div>

</body>
</html>


