<cfparam name="attributes.showHeader" default="true">
<cfif attributes.showHeader>
    <cfinclude template="includes/headers/Header.cfm">
</cfif>
<form id="myForm" action="DisplayPlayerRoster.cfm" method="post">
  <div class="form-row">

    <!-- Column: Link -->
        <!-- Column: Image -->
    <div class="form-cell-img">
      <img src="assets/images/HockeyIcons/ice-hockey.png" alt="Team Icon" class="icon-img" width="50">
    </div>

    <div class="form-cell-name" style="border: 0px;">
      <a href="#" onclick="document.getElementById('myForm').submit(); return false;" class="form-cell-name" style="border: 0px;">Add Player(s)</a>
      <input type="hidden" name="TeamId" value="#session.TeamId#">
    </div>



    <!-- Column: Instructions -->
    <div class="form-cell-description">
      <b>First step</b> add  player's to your team's roster.
    </div>
  </div>
</form>

<cfif attributes.showHeader>
<cfinclude template="includes/footers/Footer.cfm">
</cfif>