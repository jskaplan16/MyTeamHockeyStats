<cfcomponent>
    <cfset this.name = "HockeyStatsRelease10">

    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0, 2, 0, 0)>
    <cfset this.turnonTest = false >
    <cfset this.customtagpaths = getDirectoryFromPath(getCurrentTemplatePath()) & "customtags/">
    <cfset this.customtagpaths = ListAppend(this.customtagpaths, getDirectoryFromPath(getCurrentTemplatePath()) &  "includes/")>
    <cfset this.customtagpaths = ListAppend(this.customtagpaths, getDirectoryFromPath(getCurrentTemplatePath()) &  "displays/")>
    
    <cffunction name="onApplicationStart" returntype="boolean">
            <cfset application.customtagpaths = this.customtagpaths>

                    <cfif cgi.SERVER_NAME is "myteamhockeystats.com" or this.turnonTest>
                        <cflock scope="application" type="exclusive" timeout="10">
                            <cfset application.datasource = "HockeyStats">
                            <cfif this.turnonTest> 
                            <cfset application.environment="Test">
                            <cfelse>
                            <cfset application.environment="Production">
                            </cfif>               

                            <cfset this.ormEnabled = true>

                            </cflock>
                    <cfelseif cgi.SERVER_NAME is "myhockeystats.com">
                        <cflock scope="application" type="exclusive" timeout="10">
                            <cfset application.datasource = "TestHockeyStats">
                            <cfset application.environment="Test">
                        </cflock>
                    <cfelse>
                    <cflock scope="application" type="exclusive" timeout="10">
                            <cfset application.datasource = "HockeyStats">
                            <cfset application.environment="Production">
                            </cflock>		
                    </cfif>	
        <cflock scope="application" type="exclusive" timeout="10">               
    <cfset application.datasource = application.datasource>
    <cfset this.base = "/HockeyStatsApp/">
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
            </cflock>
        <cfreturn true>
    </cffunction>
    

    <cffunction name="onSessionStart" returntype="void">
 
        <cfset session.startTime = now()>
    </cffunction>
<!---
<cfif this.turnonTest>
<cffunction name="onError" returnType="void" output="true">

    <cfargument name="exception" required="yes">
    <cfargument name="eventName" required="yes">
    <!--- Optional: log or email the error details here --->

<cfsavecontent variable="errorMsg" >
    
  
        <cfoutput>
            <h2>Error Details</h2>
            <p>Date/Time: #now()#</p>
            <p>Script Name: #cgi.script_name#</p>
            <p>Error Message: #arguments.exception.message#</p>
            <p>Error Detail: #arguments.exception.detail#</p>
            <p>Error Type: #arguments.exception.type#</p>
            <cfif structKeyExists(arguments.exception, "tagContext") and isArray(arguments.exception.tagContext) and arrayLen(arguments.exception.tagContext)>
                <p>Line Number: #arguments.exception.tagContext[1].line#</p>
                <p>Template: #arguments.exception.tagContext[1].template#</p>
            </cfif>
            
            <h3>Debug Information</h3>
            <cfdump var="#arguments.exception#" label="Exception Object">
            <cfdump var="#form#" label="Form Variables">
            <cfdump var="#url#" label="URL Variables">
            <cfdump var="#cgi#" label="CGI Variables">
        </cfoutput>
        
</cfsavecontent>

    <cfinclude template="errorPage.cfm" runonce="true">


</cffunction>
</cfif>
--->
<!---
<cffunction name="onError" returnType="void" output="true">

    <cfargument name="exception" required="true">
    <cfargument name="eventName" type="string" required="true">

  <cfif application.environment EQ "Production">  
    <cfset var errorDetails = "">
    
    <!--- Capture error details --->
    <cfsavecontent variable="errorDetails">
        <cfoutput>
            <h2>Error Details</h2>
            <p>Date/Time: #now()#</p>
            <p>Script Name: #cgi.script_name#</p>
            <p>Error Message: #arguments.exception.message#</p>
            <p>Error Detail: #arguments.exception.detail#</p>
            <p>Error Type: #arguments.exception.type#</p>
            <cfif structKeyExists(arguments.exception, "tagContext") and isArray(arguments.exception.tagContext) and arrayLen(arguments.exception.tagContext)>
                <p>Line Number: #arguments.exception.tagContext[1].line#</p>
                <p>Template: #arguments.exception.tagContext[1].template#</p>
            </cfif>
            
            <h3>Debug Information</h3>
            <cfdump var="#arguments.exception#" label="Exception Object">
            <cfdump var="#form#" label="Form Variables">
            <cfdump var="#url#" label="URL Variables">
            <cfdump var="#cgi#" label="CGI Variables">
        </cfoutput>
    </cfsavecontent>
    
   

	<cfmail to="jskaplan@gmail.com" from="mailadmin@myfreehockeystats.com" subject="My Hockey Stats - ERROR " type="html">	
		<cfoutput> #errorDetails#</cfoutput>
     </cfmail>
    
    <!--- Log the error --->
    <cflog file="myApplicationErrors" text="#arguments.exception.message# - #arguments.exception.detail#">
    
    <!--- Display a user-friendly error message --->
    <cfoutput>
        <h1>An error has occurred</h1>
        <p>We apologize for the inconvenience. The error has been logged and we will investigate it shortly.</p>
    </cfoutput>
    <cflocation url="/errorPage.cfm" addtoken="false">
    <cfreturn >
    <cfelse>
		 <cfthrow object="#arguments.Exception#">
	</cfif>
    <cfreturn>
</cffunction>
--->
</cfcomponent>