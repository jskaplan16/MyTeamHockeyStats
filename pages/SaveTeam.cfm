<!--- <cftry> --->
    <!--- Specify the upload destination directory --->
    <cfset uploadDirectory = expandPath("assets/images/HockeyIcons/")>

    <!--- Use cffile to upload the file --->
    <cfif isDefined("form.myFile") and len(form.myFile)>
        

        <cffile action="upload" 
                filefield="myFile" 
                destination="#uploadDirectory#" 
                nameconflict="makeunique">
        
            <cfset serverFile = cffile.serverFile>
        <!--- Output success message --->
        
        <cfsavecontent variable="Msg">
            <cfoutput>
 exec stpInsertUpdateteam
    @OrganizationText='#form.SEARCHORGTEXT#',
    @OrganizationId=#form.ORGANIZATIONID#,
	@TeamIcon='#serverFile#',
	@TeamLevelId=#form.TeamLevelId#,
	@OtherTeamLabel='#form.OTHERTEAM#',
	@AgeGroupId=#form.AGEGROUPID#,
	@SeasonStartDate='#session.startofseason#',
	@SeasonEndDate='#session.endofseason#',
	@MainTeamSeasonId=#session.teamseasonid#

                File uploaded successfully! 
            </cfoutput>
        </cfsavecontent>
    <cfelse>
        <cfset serverFile = form.myFile>
        
    </cfif>

<cfsavecontent variable="sqlError">
            <cfoutput>
    exec stpInsertUpdateteam
    @OrganizationText='#form.SEARCHORGTEXT#',
    @OrganizationId=<cfif #form.ORGANIZATIONID# is "">0<cfelse>#form.ORGANIZATIONID#</cfif>,
	@TeamIcon='#serverFile#',
	@TeamLevelId=#form.TeamLevelId#,
	@OtherTeamLabel='#form.OTHERTEAM#',
	@AgeGroupId=#form.AGEGROUPID#,
	@SeasonStartDate='#session.startofseason#',
	@SeasonEndDate='#session.endofseason#',
	@MainTeamSeasonId=#session.teamseasonid#
    </cfoutput>
</cfsavecontent>



        <cfquery  name="qInsertTeam" datasource="#Application.Datasource#">
        exec stpInsertUpdateteam
    @OrganizationText='#form.SEARCHORGTEXT#',
    @OrganizationId=<cfif #form.ORGANIZATIONID# is "">0<cfelse>#form.ORGANIZATIONID#</cfif>,
	@TeamIcon='#serverFile#',
	@TeamLevelId=#form.TeamLevelId#,
	@OtherTeamLabel='#form.OTHERTEAM#',
	@AgeGroupId=#form.AGEGROUPID#,
	@SeasonStartDate='#session.startofseason#',
	@SeasonEndDate='#session.endofseason#',
	@MainTeamSeasonId=#session.teamseasonid#
            </cfquery>
     


<cfset form.TeamName="">

<cfset form.TeamId="">
<cfset form.Action="Insert">
<cfif isDefined("qInsertTeam.ErrorMessage")>`
<cfset msg=qInsertTeam.ErrorMessage>
</cfif>
<!---
    <cfcatch type="any">
        <!--- Handle errors --->
        <cfoutput>
            Error uploading file: #cfcatch.message#
        </cfoutput>
    </cfcatch>
</cftry>
--->
<cfinclude template="DisplayAddTeam.cfm" >
