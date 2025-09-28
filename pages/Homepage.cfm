<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

  <!-- Try modifying viewport tag -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

  <title>MyFreeHockeyStats.com</title>
  <link rel="stylesheet" href="styles.css"> <!-- Link to external CSS -->
  <style>
    /* Basic inline CSS for demonstration purposes */
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      line-height: 1.6;
    }
    header, search {
      background: #8f2b2b;
      color: #fff;
      padding: 20px 10%;
      text-align: center;
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
      background-color: #f4f4f4;
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
      background-color: #8f2b2b;
      border-radius: 5px;
    }
    .cta-buttons a.secondary {
      background-color: #555;
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
      color: #8f2b2b;
      text-decoration: none;
    }
    .searchBox,.SearchLabel {
      width: 75%;
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
  background-color: #f0f0f0;
}

    
  </style>
 
   
</head>
<body>

<cfquery  datasource="#Application.Datasource#" name="getTeams">
    SELECT TeamId,TeamName,BirthYear FROM dbo.tblteam
 WHERE TeamId=MainTeamId
   
</cfquery>

<!-- Header Section -->
<header>
<div style="background-color: #8f2b2b; color: #fff; padding: 20px 10%; text-align: right;">
  <a href="authenticate.cfm" class="login">Login</a>
</div>
  <img src="assets/images/HockeyIcons/MyFreeHockeyStatsNew2.png" alt="Hockey Icon" width="50%">
  <p>Empower Your Hockey Team with Pro-Level Stats – Anytime, Anywhere.</p>

<search>
<form action="selectGame.cfm" method="post">
  <label for="searchBox" class="SearchLabel">Search Teams:</label>
  <select  id="searchBox" name="TeamId" placeholder="Search Teams using my FreeHockeyStats.com"  class="searchBox" onchange="submit()">
    <option value="">Select a Team</option>
    <cfoutput query="getTeams">
      <option value="#getTeams.TeamId#">#getTeams.TeamName#</option> 
        </cfoutput>
  </select>

<div id="searchResults"></div>
</search>  
  <!-- Navigation Menu -->
   <!---
  <nav>
    <a href="#features">Features</a>
   <a href="#pricing">Pricing</a> 
    <a href="#about">About Us</a>
    <a href="#contact">Contact</a>
  </nav>
--->
</header>

<!-- Hero Section -->
<section class="hero">
  <h2>Take Control of Your Hockey Team’s Performance – Simplified Stats Tracking!</h2>
  <p>Track goals, assists, plus/minus, and more with our easy-to-use DIY stats platform. Perfect for coaches, players, and team managers.</p>

  <!-- Call-to-Action Buttons -->
  <div class="cta-buttons">
  <!---  <a href="SignUpPage.cfm">Get Started for Free</a> 
    <a href="#features" class="secondary">Learn More</a>
    --->
  </div>
</section>



<!-- Why Choose Us Section -->
<section id="features">
  <h3>Why Teams Love MyFreeHockeyStats.com</h3>
  
  <!-- Benefits -->
  <div class="benefits">
    <div class="benefit">
      <h4>Blazing Fast & Easy to Use</h4>
      <p>Our system is designed for speed and simplicity, ensuring you can focus on what matters – improving your team’s performance.</p>
    </div>
    
    <div class="benefit">
      <h4>Customizable Stats Tracking</h4>
      <p>Track what matters most to your team – goals, assists, plus/minus, and more. Our platform is flexible and adaptable to your needs.</p>
    </div>

    <div class="benefit">
      <h4>100% Free to Get Started</h4>
      <p>Sign up today and start tracking your team’s performance without any cost. Perfect for teams of all sizes.</p>
    </div>
  </div>
</section>

<!-- How It Works Section -->
<!---
<section id="how-it-works">
  <h3>Start Tracking in Just Three Easy Steps</h3>

  <!-- Steps -->
  <div class="steps">
    <div class="step">
      <h4>Create Your Team Account</h4>
      <p>Sign up for free and set up your team in minutes.</p>
    </div>

    <div class="step">
      <h4>Input Game Data</h4>
      <p>Record goals, assists, and other key stats during or after the game using our mobile app or website.</p>
    </div>

    <div class="step">
      <h4>Analyze & Improve</h4>
      <p>View detailed reports to identify strengths and areas for improvement.</p>
    </div>
  </div>
--->
</section>
<!---
<!-- Testimonials Section -->
<section id="testimonials">
  <h3>What Coaches and Players Are Saying</h3>

  <!-- Testimonials -->
  <blockquote>"This tool has completely transformed how we track performance. It’s simple but powerful!" – Coach Sarah T.</blockquote>

  <blockquote>"Finally, a stats platform that doesn’t require a degree to use. Our team loves it!" – Player Alex R.</blockquote>

</section>
--->
<!---  
<!-- Pricing Section -->
<section id="pricing">
  <h3>Start Free – Upgrade When You’re Ready</h3>

  <!-- Pricing Plans -->
  <ul style="list-style-type:none; padding-left:0; text-align:center;">
    <li><strong>Free Plan:</strong> Perfect for small teams just getting started. Track basic stats with no cost.</li>
    <li><strong>Pro Plan:</strong> Unlock advanced features like detailed analytics and multi-team support.</li>
  </ul>

</section>
--->
<!-- Footer Section -->
<footer id="contact">
<!---
  <!-- Quick Links -->
  Quick Links:
   | 
   Contact Us
   Social Media Links

  <!-- Contact Info -->
  Email: support@myfreehockeystats.com | Phone: (555) 123-4567

  <!-- Social Media Icons -->
  <a href="https://facebook.com/myfreehockeystats" target="_blank">Facebook</a> | 
  <a href="https://twitter.com/myfreehockeystats" target="_blank">Twitter</a> | 
  <a href="https://instagram.com/myfreehockeystats" target="_blank">Instagram</a>

--->
</footer>

<!-- Final CTA (Sticky at Bottom of Page) -->
<div style="position: fixed; bottom: 0; left: 0; width: 100%; background-color: #fff; color: #fff; text-align: center; padding: 10px;border-top:1px solid black;font-weight:bold;">
 <!--- <a href="#signup" style="color: #8f2b2b; text-decoration: none;">Sign Up for Free</a> --->
</div>

</body>
</html>


