<cfparam name="form.PositionCode"  default="">
<cfparam name="form.ShootingSide" default="">

<cfquery name="qGeneralPosition" datasource="#application.datasource#">
Select GeneralPosition from [dbo].[tblPosition]
where PositionCode='#form.PositionCode#'
</cfquery>

   <cfif isDefined("url.action")>
   		<cfset form.action=url.action>
   </cfif>
 


<cfswitch expression="#form.action#">
        
   <cfcase value="edit">
   	<cfquery name="qInsertPlayer" datasource="#Application.Datasource#">
exec stpInsertRosterPlayer 
		@PlayerNumber = #form.PlayerNumber#,
		@FirstName = '#form.FirstName#',
		@LastName = '#form.LastName#',
		@TeamSeasonId = #form.TeamSeasonId#,
		@PositionCode = '#form.PositionCode#',
		@ShootingSide = '#form.ShootingSide#',
		@PositionGeneral = '#qGeneralPosition.GeneralPosition#'
	</cfquery>


    <cfquery name="qPlayer" datasource="#application.datasource#">
            Select * from dbo.vRoster where PlayerId=#qInsertPlayer.PlayerId# Order by PlayerNumber asc
    </cfquery>
	
        <cfset form.PlayerNumber=qPlayer.PlayerNumber>
        <cfset form.PlayerName=qPlayer.PlayerName>
        <cfset form.Firstname=qPlayer.FirstName>
        <cfset form.Lastname=qPlayer.LastName>
        <cfset form.TeamSeasonId=qPlayer.TeamSeasonId>
        <cfset form.TeamName = qPlayer.TeamName>
        <cfset form.PositionCode=qPlayer.PositionCode>
        <cfset form.ShootingSide=qPlayer.ShootingSide>
        <cfset form.PositionGeneral=qPlayer.PositionGeneral>
    </cfcase> 
    
    <cfcase value="Insert">

   	<cfquery name="qInsertPlayer" datasource="#Application.Datasource#">
exec stpInsertRosterPlayer 
		@PlayerNumber = #form.PlayerNumber#,
		@FirstName = '#form.FirstName#',
		@LastName = '#form.LastName#',
		@TeamSeasonId = #form.TeamSeasonId#,
		@PositionCode = '#form.PositionCode#',
		@ShootingSide = '#form.ShootingSide#',
		@PositionGeneral = '#qGeneralPosition.GeneralPosition#'
	</cfquery>
        <cfquery name="qPlayer" datasource="#application.datasource#">
            Select * from dbo.vRoster where PlayerId=#qInsertPlayer.PlayerId# Order by PlayerNumber asc
    </cfquery>


        <cfset form.PlayerNumber="">
        <cfset form.PlayerName="">
        <cfset form.Firstname="">
        <cfset form.Lastname="">
        <cfset form.TeamSeasonId=qPlayer.TeamSeasonId>
        <cfset form.TeamName = qPlayer.TeamName>
        <cfset form.PositionCode="">
        <cfset form.ShootingSide="">

    </cfcase>

    <cfcase value="Delete">
        <cfquery name="qDeletePlayer" datasource="#application.datasource#">
            Delete from dbo.tblRoster where PlayerId=#url.PlayerId#
        </cfquery>

        <cfquery name="qPlayer" datasource="#application.datasource#">
                Select * from dbo.vRoster where TeamSeasonId=#url.TeamSeasonId# Order by PlayerNumber asc
        </cfquery>
		
	
        <cfset form.PlayerNumber="">
        <cfset form.PlayerName="">
        <cfset form.TeamSeasonId=session.TeamSeasonId>
        <cfset form.TeamName = qPlayer.TeamName>
    </cfcase> 


</cfswitch>

<cfinclude template="DisplayPlayerRoster.cfm">