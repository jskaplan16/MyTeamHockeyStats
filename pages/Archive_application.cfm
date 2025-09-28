<cfapplication name="HockeyStats" 
sessionmanagement="Yes" 
sessiontimeout=#CreateTimeSpan(0,2,0,0)#>

<cferror 
    type="exception" 
    template="errorPage.cfm" 
    /> 
	
	<cffunction name="onError" returnType="void">
<cfargument name="Exception" required=true/>
<cfargument name="EventName" type="String" required=true/>
			<cfmail
    to="jskaplan@gmail.com"
    from="admin@myfreehockeyStats.com"
    subject="Error"
    type="html">	
				
Exception: 	#exception#
Event: #EventName#				
		</cfmail>
<cflocation url="logout.cfm">
</cffunction>