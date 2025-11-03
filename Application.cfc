<cfcomponent>
    <cfset this.name = "HockeyStatsRelease_v1.33">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 2, 0, 0)>
    <cfset this.gamesheetsUploadDir = getDirectoryFromPath(getCurrentTemplatePath()) & "assets\gameSheets\">
    <cfset this.customtagpaths = getDirectoryFromPath(getCurrentTemplatePath()) & "customtags/">
    <cfset this.customtagpaths = ListAppend(this.customtagpaths, getDirectoryFromPath(getCurrentTemplatePath()) &  "includes/")>
    <cfset this.customtagpaths = ListAppend(this.customtagpaths, getDirectoryFromPath(getCurrentTemplatePath()) &  "displays/")>
    <cfset this.customtagpaths = ListAppend(this.customtagpaths, getDirectoryFromPath(getCurrentTemplatePath()) &  "pages/")>
   

    <cffunction name="onApplicationStart" returntype="boolean">    
        <cflock scope="application" type="exclusive" timeout="10">
            <cfif cgi.SERVER_NAME is "myteamhockeystats.local">
                <cfset application.environment = "Test">
                <cfset application.datasource = "TestHockeyStats">
                <cfset this.base = "/MyTeamHockeyStats/">
            <cfelse>
                <cfset application.environment = "Production">
                <cfset application.datasource = "HockeyStats">
                <cfset this.base = "/">
            </cfif>              
            
            <cfset application.customtagpaths = this.customtagpaths>  
            <cfset application.base = this.base>
            <cfset application.displays = this.base & "displays/"/>
            <cfset application.css = this.base & "assets/css/"/>
            <cfset application.js = this.base & "assets/js/"/>
            <cfset application.images = this.base & "assets/images/"/>
            <cfset application.icons = this.base & "assets/hockeyIcons/"/>
            <cfset application.includes = this.base & "includes/"/>
            <cfset application.actions = this.base & "actions/"/>
            <cfset application.forms = this.base & "forms/"/>
            <cfset application.pages = this.base & "pages/"/>
            <cfset application.admin = this.base & "admin/"/>
        
            <cfset application.gamesheets = this.base & "assets/gameSheets/"/>
            <cfset application.gamesheetsUploadDir = this.gamesheetsUploadDir>
            <cfset application.assets = this.base & "assets/"/>
        </cflock>
        <cfreturn true>
    </cffunction>
    


    <cffunction name="onSessionStart" returntype="void">
        <cfset session.startTime = now()>
    </cffunction>



<!---

<cffunction name="onError" returnType="void" output="true">

    <cfargument name="exception" required="true">
    <cfargument name="eventName" type="string" required="true">


  <!--- Determine if this is production based on multiple checks --->

  <cfif structKeyExists(application, "environment") and application.environment is "Production">  
    <cfset var errorDetails = "">
    <cfset var errorKey = hash(arguments.exception.message & arguments.exception.type & cgi.SCRIPT_NAME)>

    
    <!--- Capture error details --->
    <cfsavecontent variable="errorDetails">
        <cfoutput>
            <h2>Error Details</h2>
            <p><strong>Date/Time:</strong> #now()#</p>
            <p><strong>Server:</strong> #cgi.SERVER_NAME#</p>
            <p><strong>Environment:</strong> #application.environment#</p>
            <p><strong>Script Name:</strong> #cgi.script_name#</p>
            <p><strong>Query String:</strong> #cgi.QUERY_STRING#</p>
            <p><strong>HTTP Method:</strong> #cgi.REQUEST_METHOD#</p>
            <p><strong>IP Address:</strong> #cgi.REMOTE_ADDR#</p>
            <hr>
            <p><strong>Error Message:</strong> #arguments.exception.message#</p>
            <p><strong>Error Detail:</strong> #arguments.exception.detail#</p>
            <p><strong>Error Type:</strong> #arguments.exception.type#</p>
            <cfif structKeyExists(arguments.exception, "tagContext") and isArray(arguments.exception.tagContext) and arrayLen(arguments.exception.tagContext)>
                <p><strong>Line Number:</strong> #arguments.exception.tagContext[1].line#</p>
                <p><strong>Template:</strong> #arguments.exception.tagContext[1].template#</p>
            </cfif>
            <hr>
            <h3>User Information</h3>
            <cfif structKeyExists(session, "teamId")>
                <p><strong>Team ID:</strong> #session.teamId#</p>
            </cfif>
            <cfif structKeyExists(session, "teamName")>
                <p><strong>Team Name:</strong> #session.teamName#</p>
            </cfif>
            <cfif structKeyExists(session, "userId")>
                <p><strong>User ID:</strong> #session.userId#</p>
            </cfif>
            <cfif structKeyExists(session, "username")>
                <p><strong>Username:</strong> #session.username#</p>
            </cfif>
            <hr>
            <h3>Request Variables</h3>
            <cfif structKeyExists(form, "fieldnames") and len(form.fieldnames)>
                <p><strong>Form Variables:</strong></p>
                <cfdump var="#form#" label="Form Variables">
            </cfif>
            <cfif structKeyExists(url, "fieldnames") and len(url.fieldnames)>
                <p><strong>URL Variables:</strong></p>
                <cfdump var="#url#" label="URL Variables">
            </cfif>
            <hr>
            <h3>Exception Details</h3>
            <cfdump var="#arguments.exception#" label="Exception Object">
        </cfoutput>
    </cfsavecontent>
    
    <!--- Rate limit: Only send email once per 5 minutes for the same error --->
    <cfset var shouldSendEmail = true>
    <cfif structKeyExists(application, "errorLog") and structKeyExists(application.errorLog, errorKey)>
        <cfset var timeSinceLastError = dateDiff("n", application.errorLog[errorKey], now())>
        <cfif timeSinceLastError lt 5>
            <cfset shouldSendEmail = false>
        </cfif>
    </cfif>

  
    <!--- Try to send email, but don't let email failure break error handling --->
    <cfif shouldSendEmail>
        <cftry>
            <cfmail to="jskaplan@gmail.com" from="mailadmin@myfreehockeystats.com" subject="My Hockey Stats - ERROR - #cgi.SERVER_NAME# - #arguments.exception.message#" type="html">	
                <cfoutput> #errorDetails#</cfoutput>
            </cfmail>
  
            <!--- Track when we sent this error --->
            <cfif NOT structKeyExists(application, "errorLog")>
                <cfset application.errorLog = structNew()>
            </cfif>
            <cfset application.errorLog[errorKey] = now()>
            <cfcatch>
                <!--- If email fails, continue anyway --->
            </cfcatch>
        </cftry>
    </cfif>
    
    <cftry>
        <cfset var templatePath = "">
        <cfif structKeyExists(arguments.exception, "tagContext") and isArray(arguments.exception.tagContext) and arrayLen(arguments.exception.tagContext)>
            <cfset templatePath = arguments.exception.tagContext[1].template>
        <cfelse>
            <cfset templatePath = "Unknown">
        </cfif>
        <cflog file="myApplicationErrors" text="#arguments.exception.message# - #arguments.exception.detail# - Template: #templatePath#">
        <cfcatch>
            <!--- If log fails, continue anyway --->
        </cfcatch>
    </cftry>
    
    <cftry>
        <cfinclude template="#application.pages#ErrorPage.cfm">
        <cfcatch>
            <!--- If error page fails, output basic error message --->
            <cfoutput>
                <h1>An error has occurred</h1>
                <p>#arguments.exception.message#</p>
                <p>Please contact the administrator if this problem persists.</p>
            </cfoutput>
        </cfcatch>
    </cftry>
  </cfif>
  <cfreturn>

</cffunction>
--->
</cfcomponent>