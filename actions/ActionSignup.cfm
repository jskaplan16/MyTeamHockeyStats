
<cfif not isDefined("form.FirstName")>
    <cflocation url="SignUpPage.cfm" >
</cfif>


<cfif structKeyExists(form, "myFile") AND len(form.myFile) GT 0>
 <cfset uploadDirectory = expandPath("assets/images/HockeyIcons/")>
    <cffile 
        action="upload"
        filefield="myFile"
        destination="#uploadDirectory#"
        nameConflict="makeunique"
        allowedExtensions="jpg,png,gif,jpeg"
        accept="image/jpg,image/png,image/gif,image/jpeg">

</cfif>

<cfsavecontent variable="sqlCode" >
<cfoutput>
 exec dbo.stpCreateAccount 
     @FirstName = '#form.FirstName#'
    ,@LastName = '#form.LastName#'
    ,@MembershipEmail = '#form.Email#'
    ,@MembershipTeamName= '#form.SEARCHORGTEXT#'
    ,@MembershipTypeId = 1
   <cfif isDefined("ServerFile")> ,@TeamIcon = '#serverFile#' </cfif>
    ,@BirthYearId = #form.BirthYearId#
    ,@SeasonStartDate = '#form.seasonStart#'
    ,@SeasonEndDate = '#form.seasonEnd#'
    ,@SeasonId = #form.SeasonId#
    ,@OrganizationText = '#form.searchOrgText#'
    ,@OrganizationId = #form.OrganizationId#
    ,@AgeGroupId = #form.AgeGroupId#
    ,@TeamLevelId = #form.TeamLevelId#
    <cfif isDefined("form.OtherTeam")>,@OtherTeamLabel = '#form.OtherTeam#'</cfif>    
</cfoutput>
</cfsavecontent>




<cfquery  datasource="#Application.Datasource#" name="qInsert">
 exec dbo.stpCreateAccount 
     @FirstName = '#form.FirstName#'
    ,@LastName = '#form.LastName#'
    ,@MembershipEmail = '#form.Email#'
    ,@MembershipTeamName= '#form.SEARCHORGTEXT#'
    ,@MembershipTypeId = 1
   <cfif isDefined("ServerFile")> ,@TeamIcon = '#serverFile#' </cfif>
    ,@BirthYearId = #form.BirthYearId#
    ,@SeasonStartDate = '#form.seasonStart#'
    ,@SeasonEndDate = '#form.seasonEnd#'
    ,@SeasonId = #form.SeasonId#
    ,@OrganizationText = '#form.searchOrgText#'
    ,@OrganizationId = #form.OrganizationId#
    ,@AgeGroupId = #form.AgeGroupId#
    ,@TeamLevelId = #form.TeamLevelId#
    <cfif isDefined("form.OtherTeam")>,@OtherTeamLabel = '#form.OtherTeam#'</cfif>
</cfquery>



<cfif qInsert.AccountCreated eq 0>
    <cfset errorMsg=qInsert.ErrorMsg>
   <cfset form.OrganizationId = qInsert.OrganizationId>
    <cfset form.TeamName = qInsert.TeamName>
  
    <cfinclude template="SignUpPage.cfm">
    <cfabort>
</cfif>
	

	







	<cfmail
    to="#form.email#"
    bcc="jskaplan@gmail.com"
    from="mailadmin@myteamhockeystats.com"
    subject="Welcome to My Team Hockey Stats"
    type="html">	

Welcome to my hockey rankings. Here is your username and temporary password.
UserName: #qInsert.username# <br>
Passwords: #qInsert.Password#
     
</cfmail>
	<cfset session.loggedIn = false>
				<cfset session.userID = "Guest">
				<cfset session.username = "">

<cf_loginPage errorMsg="Your account has been created. A temporary password has been emailed to you. Please login and change your password." loginMsgType="success" showHeader="true">

		<!-- Passwords match, set session variables -->
			

				




	