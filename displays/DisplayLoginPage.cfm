<cfparam name="attributes.ErrorMsg"  default="">
<cfparam name="attributes.username"  default="">
<CF_BaseHeader>
<style>
  /* Desktop-specific fixes for DisplayLoginPage */
  .content-wrapper {
    padding-top: 10px !important;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    min-height: auto;
    width: 100%;
  }
  
  .login-container {
    margin-top: 0 !important;
    margin-bottom: 20px !important;
    margin-left: auto !important;
    margin-right: auto !important;
    max-width: 400px !important;
    width: 100%;
    padding: 38px 30px !important;
  }
  
  /* Reduce spacing in the header banner container */
  div[style*="padding: 10px 5%"] {
    padding-bottom: 20px !important;
  }
  
  /* Ensure header banner doesn't have excessive margin */
  .header-banner {
    margin-bottom: 0 !important;
  }
  
  /* Desktop-specific adjustments */
  @media screen and (min-width: 769px) {
    .content-wrapper {
      padding-top: 10px !important;
      min-height: auto;
      align-items: flex-start;
    }
    
    .login-container {
      margin-top: 10px !important;
      margin-bottom: 20px !important;
      max-width: 400px !important;
      padding: 38px 30px !important;
    }
  }
  
  /* Tablet adjustments */
  @media screen and (min-width: 481px) and (max-width: 768px) {
    .content-wrapper {
      padding-top: 10px !important;
      min-height: auto;
    }
    
    .login-container {
      margin-top: 10px !important;
      max-width: 380px !important;
    }
  }
  
  /* Mobile adjustments */
  @media screen and (max-width: 480px) {
    .login-container {
      margin-top: 10px !important;
      margin-bottom: 20px !important;
    }
    .content-wrapper {
      padding-top: 10px !important;
      min-height: auto;
    }
  }
</style>
    <div class="login-container">
    <!-- Error Message (ColdFusion) -->
    <cfoutput>
      <cfif len(attributes.ErrorMsg)>
        <div class="errorBox">#attributes.ErrorMsg#</div>
      </cfif>
    </cfoutput>
    <cfoutput>
    <form action="#application.pages#authenticate.cfm" method="post" autocomplete="off">
    </cfoutput>
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
      <cfoutput>
      <a class="forgot-link" href="#application.displays#DisplayResetEmail.cfm">Forgot UserName or Password?</a>
    </cfoutput>
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