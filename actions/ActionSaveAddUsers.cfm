<cfparam name="form.isAdmin" default="0" >
<cfparam name="form.isCoach" default="0" >
<cfparam name="form.UserId"  default="">
<cfif isDefined("form.isAdmin") and form.isAdmin eq "on">
    <cfset form.isAdmin = 1>
</cfif>

<cfif isDefined("form.isCoach") and form.isCoach eq "on">
    <cfset form.isCoach = 1>
</cfif>

<cfquery  name="AddUsers" datasource="#application.datasource#">
    exec dbo.stpInsertUpdateUsers 
            @TeamSeasonId=#session.teamSeasonId#,
            @FirstName=<cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">,
            @LastName=<cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_varchar">,
            @UserName=<cfqueryparam value="#form.Email#" cfsqltype="cf_sql_varchar">,
            @ShowAdminFunctions=<cfqueryparam value="#form.isAdmin#" cfsqltype="cf_sql_bit">,
            @ShowCoachFunctions=<cfqueryparam value="#form.isCoach#" cfsqltype="cf_sql_bit"> , 
            @UserId=<cfif len(form.UserId)>#form.UserId#<cfelse>NULL</cfif>
</cfquery>

<cfset form.isAdmin = "">
<cfset form.isCoach = "">
<cfset form.UserId = "">
<cfset form.firstName = "">
<cfset form.lastName = "">  
<cfset form.email="">

<cfinclude template="settings.cfm">