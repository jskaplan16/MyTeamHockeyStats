// Replace the existing openTab function with this updated version
<script>
function initTabs() {
  const tabs = document.querySelectorAll('.tablinks');
  
  tabs.forEach(tab => {
    tab.addEventListener('click', (e) => {
      const tabName = e.target.getAttribute('data-tab');
      openTab(tabName);
      
      // Update URL without page reload
      history.pushState({tab: tabName}, '', `?tab=${tabName}`);
    });
  });

  // Handle browser back/forward
  window.addEventListener('popstate', (e) => {
    const tabName = e.state?.tab || 'Tab1';
    openTab(tabName);
  });
}

function openTab(tabName) {
  // Hide all tab content
  document.querySelectorAll('.tab-content')
    .forEach(tab => tab.style.display = 'none');
    
  // Remove active class from all buttons  
  document.querySelectorAll('.tablinks')
    .forEach(btn => btn.classList.remove('active'));

  // Show selected tab and mark button as active
  document.getElementById(tabName).style.display = 'block';
  document.querySelector(`[data-tab="${tabName}"]`).classList.add('active');
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
  initTabs();
  
  // Get initial tab from URL or default to Tab1
  const urlParams = new URLSearchParams(window.location.search);
  const initialTab = urlParams.get('tab') || 'Tab1';
  openTab(initialTab);
});
</script
<style>
.tab { 
  overflow: hidden; 
  border-bottom: 1px solid #ccc; 
}

.tab button { 
  background: inherit; 
  border: none; 
  cursor: pointer; 
  padding: 10px; 
  font-size: 16px;
  transition: background-color 0.3s;
}

.tab button.active { 
  background: #ccc; 
}

.tab-content { 
  display: none;
  padding: 10px; 
  border: 1px solid #ccc; 
  border-top: none;
  opacity: 0;
  transition: opacity 0.3s;
}

.tab-content.visible {
  display: block;
  opacity: 1;
}
</style>

<div class="tab">
  <button id="btn_Tab1" class="tablinks" data-tab="Tab1">Enter/Edit Game</button>
  <button id="btn_Tab2" class="tablinks" data-tab="Tab2">Add Goals</button>
  <button id="btn_Tab3" class="tablinks" data-tab="Tab3">Add Penalties</button>
</div>

<div id="Tab1" class="tab-content">
  <cf_DisplayEnterGame navBar=false>
</div>
<div id="Tab2" class="tab-content">
  <div class="PageHeader">
    <cfoutput>#session.TeamName# - Goals</cfoutput>
  </div>
  <cfif isDefined("form.GameId")>
    <cfset session.SelGameId=form.GameId>
  <cfelseif isDefined("url.GameId")>
    <cfset session.SelGameId=url.GameId>
    <cfset form.GameId=url.GameId>
  </cfif>
  <cfset session.Action="Insert">
  <cf_DisplaySelectClip>	
</div>
<div id="Tab3" class="tab-content">
  <cfinclude template="tab3.cfm">
</div>