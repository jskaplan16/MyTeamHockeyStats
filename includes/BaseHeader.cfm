<cfparam name="attributes.showHeader" default="true">

<cfswitch expression='#thisTag.ExecutionMode#'>

<cfcase value='start'>

<!DOCTYPE html>
<html lang="en">
<cfoutput>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>MyTeamHockeyStats.com</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="#application.css#myhockeyStatsStyle.css">
  <link rel="icon" href="#application.images#favicon.ico" type="image/x-icon">
  </cfoutput>
  <style>
    :root {
      --primary-blue: #185abc;
      --accent-blue: #2492ff;
      --white: #ffffff;
      --gray: #f0f3f7;
      --dark: #13223b;
      --text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }
    
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
    
    .site-content {
      position: relative;
      z-index: 2;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
    }
    
    .content-wrapper {
      position: relative;
      z-index: 2;
      padding: 10px 5% 20px 5%;
    }
    
    .header-banner {
      background: rgba(255, 255, 255, 0.05);
      backdrop-filter: blur(10px);
      border-radius: 15px;
      padding: 25px 20px;
      margin: 10px auto;
      max-width: 1000px;
      border: 1px solid rgba(255,255,255,0.1);
      box-shadow: 0 8px 32px rgba(0,0,0,0.3);
      display: block;
    }
    
    .nav-links {
      text-align: center;
      color: #fff;
    }
    
    .nav-cell-large {
      font-size: 2em;
      font-weight: 700;
      margin-bottom: 15px;
      text-shadow: var(--text-shadow);
      color: #fff;
    }
    
    .nav-cell-small {
      font-size: 1.1em;
      font-style: italic;
      opacity: 0.9;
      text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
      color: #fff;
      line-height: 1.5;
      padding: 0 10px;
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
      transform: translateZ(0);
      -webkit-transform: translateZ(0);
    }
    
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
      .logo-container img {
        max-width: 180px;
      }
      .nav-cell-large {
        font-size: 1.5em;
      }
      .nav-cell-small {
        font-size: 1em;
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
      .logo-container img {
        max-width: 150px;
      }
      .nav-cell-large {
        font-size: 1.3em;
      }
    }
  </style>
</head>
<cfoutput>
<body>
  <!-- Background Video -->
  <video autoplay muted loop playsinline preload="auto" id="backgroundVideo">
    <source src="#Application.images#BackgroundVideo.mp4" type="video/mp4">
    Your browser does not support the video tag.
  </video>
  
  <!-- Main Content -->
  <div class="site-content">
    <!-- Top Right Actions - Login & Get Started -->
    <cfif NOT structKeyExists(session, "userid") OR session.userID IS "0" OR session.userID IS "" OR session.userID IS "Anonymous">
      <div class="top-right-actions">
        <a href="#application.pages#authenticate.cfm" class="login-link">Login</a>
        <a href="#application.displays#DisplaySignUpPage.cfm" class="top-right-cta">Get Started for Free</a>
      </div>
    </cfif>
    
    <!-- Top Header with Logo -->
    <header class="top-header">
      <div class="logo-container">
        <a href="#application.base#index.cfm" tabindex="-1">
          <img src="#application.images#myTeamHockeyStats.png" alt="My Team Hockey Stats Logo">
        </a>
      </div>
    </header>
    
    <!-- Header Banner - Moved Higher -->
    <div style="padding: 10px 5% 100px 5%;">
      <header class="header-banner">
        <div class="nav-links">
          <div class="nav-cell-large">
              <i>Capture stats for every game, every player. Film, upload to YouTube and start tracking. Anyone can sign up and start tracking today!!!!</i> 
          </div>
        </div>
      </header>
    </div>
    
    <!-- Content Wrapper -->
    <div class="content-wrapper">
      <div style="margin:0px;">
</cfoutput>
</cfcase>

<cfcase value='end'>
      </div>
      <!-- Close content div with margin -->
    </div>
    <!-- Close content-wrapper -->
  </div>
  <!-- Close site-content -->

</body>

</html>

	</cfcase>

</cfswitch>	