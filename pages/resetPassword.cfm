<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reset Password</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color:#185abc;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .reset-container {
      background: white;
      padding: 2rem;
      border-radius: 8px;
      box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
      max-width: 350px;
      width: 100%;
    }
    h2 {
      text-align: center;
      margin-bottom: 1rem;
    }
    label {
      display: block;
      font-weight: bold;
      margin-top: 1rem;
    }
    input {
      width: 100%;
      padding: 0.5rem;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .note {
      font-size: 0.85rem;
      color: #666;
      margin: 0.5rem 0;
    }
    button {
      margin-top: 1.5rem;
      width: 100%;
      padding: 0.7rem;
      background-color: #007BFF;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 1rem;
    }
    button:disabled {
      background-color: #ccc;
      cursor: not-allowed;
    }
    .link {
      text-align: center;
      display: block;
      margin-top: 1rem;
      color: #007BFF;
      text-decoration: none;
    }
  </style>
</head>
<body>



  <div class="reset-container">
  <cfif isdefined("Message")>
      <cfoutput>
   <p style="color:red">#Message#</p>
     </cfoutput>   
</cfif>  
    <h2>Reset Password</h2>
    <p>Enter your new password below</p>

    <form id="resetForm" action="ActionResetPassword.cfm" method="post">
      <label for="newPassword">New Password</label>
      <input type="password" id="newPassword" name="newPassword" required>
     

      <label for="confirmPassword">Confirm New Password</label>
      <input type="password" id="confirmPassword" name="confirmPassword" required>

      <p class="note">Password must be at least 8 characters, include one number and one symbol.</p>

      <button type="submit" id="resetBtn" disabled>Reset Password</button>
      
    </form>

   
  </div>

  <script>
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    const resetBtn = document.getElementById('resetBtn');

    function validatePasswords() {
      const pwd = newPassword.value;
      const confirm = confirmPassword.value;
      const validCriteria = /^(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$/;
      resetBtn.disabled = !(pwd && confirm && pwd === confirm && validCriteria.test(pwd));
    }

    newPassword.addEventListener('input', validatePasswords);
    confirmPassword.addEventListener('input', validatePasswords);

    document.getElementById('resetForm').addEventListener('submit', function(e) {
      e.enableDefault();
      alert('Password reset successful!');
    });
  </script>
</body>
</html>

<cfsetting showdebugoutput="false" >