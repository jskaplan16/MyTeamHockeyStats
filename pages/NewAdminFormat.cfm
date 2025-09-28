<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>MyTeamHockeyStats Admin</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
  <style>
    body { margin:0; font-family:'Helvetica Neue',sans-serif; background:linear-gradient(110deg,#f8fafc 76%,#d1e6fa 100%); }
    .sidebar {
      position:fixed; top:0; left:0; width:220px; height:100%;
      background:#12243a; color:#fff; display:flex; flex-direction:column; align-items:center; padding-top:2rem;
      box-shadow:2px 0 16px #0002;
    }

  </style>

  <link rel="stylesheet" href="assets/css/myhockeyStatsStyle.css">
</head>
<body>
  <aside class="sidebar">
    <h2>Admin</h2>
    <nav class="menu">
      <a href="#"><i class="fas fa-home"></i> Dashboard</a>
      <a href="#"><i class="fas fa-users"></i> Roster</a>
      <a href="#"><i class="fas fa-calendar-check"></i> Games</a>
      <a href="#"><i class="fas fa-calendar-check"></i> Admin</a>
      <a href="#"><i class="fas fa-cog"></i> Settings</a>
    </nav>
  </aside>
  <main class="main">
    <div class="header">
      <div>
        <h1 style="margin:0;font-size:2rem;font-weight:700;letter-spacing:.04em;">Admin Dashboard</h1>
        <small style="color:#175ea8;">Welcome, Manager</small>
      </div>
      <div class="admin-info">

     
     

      </div>
    </div>
    <section class="stat-cards">
      <div class="card">
        <span class="icon"><i class="fas fa-hockey-puck"></i></span>
        <strong>17</strong>
        <div class="desc">Goals Today</div>
      </div>
      <div class="card">
        <span class="icon"><i class="fas fa-users"></i></span>
        <strong>19</strong>
        <div class="desc">Active Players</div>
      </div>
      <div class="card">
        <span class="icon"><i class="fas fa-calendar-alt"></i></span>
        <strong>2</strong>
        <div class="desc">Upcoming Games</div>
      </div>
      <div class="card">
        <span class="icon"><i class="fas fa-star"></i></span>
        <strong>5</strong>
        <div class="desc">Recent Wins</div>
      </div>
    </section>
    <!-- Add more dashboard modules here -->
    <!-- Example: roster list, schedule calendar, news editor, etc. -->
  </main>
</body>
</html>
