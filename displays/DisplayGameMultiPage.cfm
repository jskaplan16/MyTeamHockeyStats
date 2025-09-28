<cfinclude template="includes/headers/Header.cfm" >
  <script>
    function openTab(tabName) {
      var i, tabcontent, tablinks;
      tabcontent = document.getElementsByClassName("tab-content");
      for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
      }
      tablinks = document.getElementsByClassName("tablinks");
      for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
      }
      document.getElementById(tabName).style.display = "block";
      document.getElementById('btn_' + tabName).className += " active";
    }
    window.onload = function() {
      openTab('Tab1');
    }
  </script>
  <style>
    .tab { overflow: hidden; border-bottom: 1px solid #ccc; }
    .tab button { background: inherit; border: none; cursor: pointer; padding: 10px; font-size: 16px; }
    .tab button.active { background: #ccc; }
    .tab-content { display: none; padding: 10px; border: 1px solid #ccc; border-top: none; }
  </style>
</head>
<body>
  <div class="tab">
    <button id="btn_Tab1" class="tablinks" onclick="openTab('Tab1')">Enter/Edit Game</button>
    <button id="btn_Tab2" class="tablinks" onclick="openTab('Tab2')">Add Goals</button>
    <button id="btn_Tab3" class="tablinks" onclick="openTab('Tab3')">Add Penalties</button>
  </div>

  <div id="Tab1" class="tab-content">
    <cf_DisplayEnterGame navBar=false>
  </div>
  <div id="Tab2" class="tab-content">
      <div class="PageHeader">
					<cfoutput>
						#session.TeamName#  - Goals
					</cfoutput>
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
</body>
</html>