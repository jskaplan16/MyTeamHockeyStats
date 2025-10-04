<cfinclude template="#Application.includes#Header.cfm">
<cfparam name="ErrorMsg" default="" >


<cfif structKeyExists(form, "ManualGamesheet") and len(form.ManualGamesheet)>


	<cfset uploadDirectory = expandPath("/Gamesheets/")>
    <cffile 
        action="upload"
        filefield="ManualGamesheet"
        destination="#uploadDirectory#"
        nameConflict="makeunique"
        allowedExtensions="jpg,png,gif,jpeg"
        accept="image/jpg,image/png,image/gif,image/jpeg">
<cfset form.GamesheetURL="/Gamesheets/" & cffile.ServerFile>


</cfif>
<!---
<cftry>
--->
<cfif form.Action is "Insert">

<cfquery name="qValidation" datasource="#application.datasource#">
	Select 1 From tblGame where GameDate='#form.GameDate#' and Game='#form.Game#'
</cfquery>

<cfif qValidation.recordcount eq 0>
	
	

	
	<cfquery name="qInsert" datasource="#application.datasource#">
exec dbo.stpInsertGame 
            @GameDate='#form.GameDate#'
           ,@Game = '#form.Game#'
           ,@MainTeamScore = #form.MainTeamScore# 
           ,@OpponentTeamScore=#form.OpponentTeamScore# 
           ,@MainTeamSeasonId=#Form.MainTeamSeasonId#
           ,@OpponentTeamSeasonId=#form.OpponentTeamSeasonId#  
		   ,@GamesheetURL ='#form.GamesheetURL#'
           ,@FullGameVideoURL='#form.FullGameVideoURL#'
           ,@VideoEmbed='#form.VideoEmbed#'
           ,@ResultTypeId=#form.ResultTypeId#
		   ,@GameVideoId='#form.GameVideoId#'
	</cfquery>
	<cfset ErrorMsg="Game Added Successfully">
	<cfelse>
	<cfsavecontent variable="ErrorMsg" >
	<div>
	Please use the back button, the Game Date and Game matched. Please make unique or edit the game instead of trying to add a new one. <input type="button" value="Back" onclick="history.back();">
	</div>
		</cfsavecontent>	
	</cfif>
</cfif>


<cfif form.Action is "Edit">
	
	<cfquery name="qUpdate" datasource="#application.datasource#">
	exec dbo.stpUpdateGame
				@GameId=#form.GameId#
			   ,@GameDate='#form.GameDate#'
			   ,@Game = '#form.Game#'
			   ,@MainTeamScore = #form.MainTeamScore# 
			   ,@OpponentTeamScore=#form.OpponentTeamScore# 
			   ,@MainTeamSeasonId=#Form.MainTeamSeasonId#
			   ,@OpponentTeamSeasonId=#form.OpponentTeamSeasonId#  
			   ,@GamesheetURL ='#form.GamesheetURL#'
			   ,@FullGameVideoURL='#form.FullGameVideoURL#'
			   ,@VideoEmbed='#form.VideoEmbed#'
			   ,@ResultTypeId=#form.ResultTypeId#
			   ,@GameVideoId='#form.GameVideoId#'
	</cfquery>
</cfif>
<!---
	<cfcatch>
	<cfoutput>
	#cfcatch.message#<br>
	#cfcatch.detail#<br> 
 
		</cfoutput>
		
	</cfcatch>
</cftry>
--->
<cf_Displayadmin useHeader=false Message="#ErrorMsg#">	
<cfinclude template="#Application.includes#Footer.cfm">
 