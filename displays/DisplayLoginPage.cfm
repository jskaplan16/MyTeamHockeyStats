<cfparam name="attributes.ErrorMsg"  default="">
<cfparam name="attributes.username"  default="">
<CF_BaseHeader>

	<form action="authenticate.cfm" method="post">
  <div class="login-container">
    <!-- Error Message (ColdFusion) -->
    <cfoutput>
      <cfif len(attributes.ErrorMsg)>
        <div class="errorBox">#attributes.ErrorMsg#</div>
      </cfif>
    </cfoutput>
    <form action="authenticate.cfm" method="post" autocomplete="off">
      <div class="form-group">
        <label for="username" class="labelFld">Username:</label>
        <cfoutput>
          <input type="text"
                 class="tall-input"
                 id="username"
                 name="username"
                 required
                 placeholder="Enter username"
                 value="#attributes.username#"
                 autocomplete="username" />
        </cfoutput>
      </div>
      <div class="form-group" style="position:relative;">
        <label for="password" class="labelFld">Password:</label>
        <input type="password"
               class="tall-input"
               id="password"
               name="password"
               required
               placeholder="Enter password"
               autocomplete="current-password"/>
        <i class="bi bi-eye-slash eye-icon" id="togglePassword"></i>
      </div>
      <div class="form-group">
        <input type="submit"
               value="Submit"
               class="submit" />
      </div>
      <a class="forgot-link" href="DisplayResetEmail.cfm">Forgot UserName or Password?</a>
    </form>
  </div>
  <script>
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');
    togglePassword.addEventListener('click', function() {
      const type = passwordInput.type === 'password' ? 'text' : 'password';
      passwordInput.type = type;
      // Toggle between eye and eye-slash icons
      if (type === 'password') {
        this.classList.remove('bi-eye');
        this.classList.add('bi-eye-slash');
      } else {
        this.classList.remove('bi-eye-slash');
        this.classList.add('bi-eye');
      }
    });
  </script>




</CF_BaseHeader>