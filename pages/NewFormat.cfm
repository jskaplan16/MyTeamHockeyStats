<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>NHL Arena Scoreboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      background: #1b2838;
      font-family: 'Oswald', 'Arial Black', sans-serif;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .arena-scoreboard {
      background: linear-gradient(180deg, #232a44 95%, #a3a3a3 100%);
      border-radius: 18px;
      box-shadow: 0 0 36px 6px #000c;
      padding: 34px 50px;
      min-width: 420px;
      max-width: 600px;
      display: flex;
      flex-direction: column;
      align-items: center;
      border: 5px solid #d4af37;
      position: relative;
    }
    .score-row {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 100%;
      margin-bottom: 18px;
    }
    .team-block {
      display: flex;
      flex-direction: column;
      align-items: center;
      width: 100px;
      margin: 0 28px;
    }
    .logo-box {
      background: #fff;
      border-radius: 50%;
      box-shadow: 0 0 10px #fff3;
      width: 70px;
      height: 70px;
      margin-bottom: 8px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .logo-box img {
      width: 56px;
      height: 56px;
      object-fit: contain;
      border-radius: 50%;
    }
    .team-name {
      font-size: 1.15rem;
      font-weight: 700;
      color: #d4af37;
      letter-spacing: 1px;
      margin-top: 4px;
      text-transform: uppercase;
      text-align: center;
      text-shadow: 1px 1px 4px #232a44;
    }
    .score-num {
      font-size: 3.6rem;
      font-weight: bold;
      margin: 0 34px;
      color: #f8f8f8;
      text-shadow: 0 0 8px #000b, 0 0 24px #d4af37;
      text-align: center;
      min-width: 80px;
      letter-spacing: 2px;
    }
    .info-row {
      margin-top: 16px;
      width: 100%;
      display: flex;
      justify-content: space-between;
      font-size: 1.15rem;
      align-items: center;
    }
    .date-box {
      background: #232a44;
      color: #d4af37;
      padding: 6px 20px;
      border-radius: 12px;
      font-weight: 600;
      box-shadow: 0 2px 6px #0007;
    }
    .outcome-box {
      padding: 6px 20px;
      border-radius: 16px;
      font-weight: 800;
      font-size: 1.2rem;
      text-transform: uppercase;
      background: #20d07e;
      color: #232a44;
      margin-left: 18px;
      letter-spacing: 2px;
      box-shadow: 0 0 12px #1cf2c6;
    }
    .outcome-box.loss {
      background: #e74c3c;
      color: #fff;
      box-shadow: 0 0 12px #fc5c88;
    }
  </style>
</head>
<body>
  <div class="arena-scoreboard">
    <div class="score-row">
      <div class="team-block">
        <div class="logo-box">
          <img src="https://upload.wikimedia.org/wikipedia/commons/6/60/NHL_logo.png" alt="Sharks Logo">
        </div>
        <span class="team-name">Sharks</span>
      </div>
      <span class="score-num">5</span>
      <span style="color:#888; font-size:2.4rem;">-</span>
      <span class="score-num">2</span>
      <div class="team-block">
        <div class="logo-box">
          <img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Logo_NHL.png" alt="Kings Logo">
        </div>
        <span class="team-name">Kings</span>
      </div>
    </div>
    <div class="info-row">
      <span class="date-box">Aug 24, 2025</span>
      <span class="outcome-box win">WIN</span>
      <!-- For a loss: <span class="outcome-box loss">Loss</span> -->
    </div>
  </div>
</body>
</html>
