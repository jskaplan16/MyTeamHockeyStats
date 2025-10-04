<cfparam name="attributes.step" default="">
<cfparam name="attributes.PenaltyId" default="">
<cfparam name="url.step">	
<cfif session.ShowAdminFunctions is not true>		
	<cflocation url="index.cfm">
</cfif>


	<cfif len(attributes.step)>
	<cfset url.step=attributes.step>
	</cfif>
		
<cfif len(attributes.PenaltyId)>
	<cfset url.PenaltyId=attributes.PenaltyId>
</cfif>

<cfinclude  template="#Application.includes#Header.cfm">	

	

	<cfswitch expression="#url.step#">
		
		<cfcase value="1">	
			<cfset session.Action="Insert">
			<cf_ctrSelectgame GameId="" ActionPage="GoalWizard.cfm" NextStep="3">
		</cfcase>
		<cfcase value="2">
			
			<cfset session.Action="Edit">
			<cf_ctrSelectgame GameId="" ActionPage="GoalWizard.cfm" NextStep="4">
		</cfcase>	
				
		<cfcase value="3">	
			<div class="content">
			    <div class="PageHeader">
					<cfoutput>
						#session.selectedGame#  - Goals
					</cfoutput>
				</div>
				<cfset session.SelGameId=session.selectedGameId>
				<cfset form.GameId=session.selectedGameId>
				<cfset session.Action="Insert">
				<cfinclude template="#Application.displays#DisplaySelectClip.cfm">
				 <div class="table-container">	
				<cf_Displaygoals gameID="#session.selectedGameID#"  StartGameDate="#session.StartofSeason#" EndGameDate="#session.EndOfSeason#" showEdit="true" showAdd="true" showDelete="true">		
				</div>
			</div>			
		</cfcase>
		<cfcase value="4">
			<div class="content">
				<div class="PageHeader">
					<cfoutput>
						#session.selectedGame#  - Edit Goals
					</cfoutput>
				</div>
			<cfset session.SelGameId=session.selectedGameId>
		     <div class="table-container">	
			<cf_Displaygoals gameID="#session.SelGameId#"  StartGameDate="#session.StartofSeason#" EndGameDate="#session.EndOfSeason#" showEdit=true showDelete="true" showAdd="true">		
		   	</div>
		   </div>
		</cfcase>
								
		<cfcase value="5">	
			<div class="content">
				<div class="PageHeader">
					<cfoutput>
						#session.selectedGame#  - Edit Goal
					</cfoutput>
				</div>
		
			
			<cfif isDefined("url.GameId")>
			<cfset session.SelGameId=url.GameId>	
			<cfset form.GameId=url.GameId>
			</cfif>
			<cfset form.GoalId=url.GoalId>
			<cfset session.selGoalId=url.GoalId>
			<cfset form.Action="Edit">
			<cfset session.Action="Edit">
			<cfinclude template="#Application.displays#DisplaySelectClip.cfm">
			<div class="table-container">		
			<cf_Displaygoals gameID="#session.selectedGameID#"  StartGameDate="#session.StartofSeason#" EndGameDate="#session.EndOfSeason#" showEdit="true" showAdd="true" showDelete="true">		
		   	</div>
		</div>
		</cfcase>
				
		<cfcase value="6">

		<cfquery datasource="#Application.datasource#" name="qHardDelete">
			dbo.stpHardDeleteGoal @GoalId=#url.GoalId#
		</cfquery>		
		<div class="content">
				<div class="PageHeader">
					<cfoutput>
						#session.selectedGame#  - Edit Goal
					</cfoutput>
				</div>

				 <cf_Displaygoals gameID="#session.SelGameId#"  StartGameDate="#session.StartofSeason#" EndGameDate="#session.EndOfSeason#" showAdd="true" showEdit="true" showDelete="true">	
		</cfcase>
		<cfcase value="7">
				<div class="content">
				<div class="PageHeader">
					<cfoutput>
						#session.selectedGame#  - Delete Goal
					</cfoutput>
				</div>
			
			<cf_Displaygoals gameID="#session.selectedGameId#" showDelete="true"  StartGameDate="#session.StartofSeason#" EndGameDate="#session.EndOfSeason#" showEdit="false">	
			</div>
		</cfcase>
			<cfcase value="8">
			<cfset session.GoalDeletes=false>
			<cflocation url="admin.cfm">
		</cfcase>
		<cfcase value="9">
			<cfset session.Action="AddPenalty">
			<cf_ctrSelectgame GameId="" ActionPage="GoalWizard.cfm" NextStep="10">
				
		</cfcase>
				<cfcase value="10">

			<cfset session.selGameId=session.selectedGameId>
			<cfset session.Action="AddPenalty">
	    <div class="content">
		<div class="PageHeader">
					<cfoutput>
						Game: #session.SelectedGame#  - Penalties
					</cfoutput>
				</div>
			<cf_FormPenalty GameId="#session.selectedGameId#">
		</div>		
		</cfcase>		
		
		<cfcase value="11">
			
			<cfset session.Action="EditPenalty">
			<cf_ctrSelectgame GameId="" ActionPage="GoalWizard.cfm" NextStep="12">		
		</cfcase>
		
		<cfcase value="12">
		 <div class="content">
			<div class="PageHeader">
					<cfoutput>
						Game: #session.SelectedGame#  - Penalties
					</cfoutput>
			</div>
			<cf_DisplayPenalty  GameId="#session.selectedGameId#" showedit="true">	
				
		<cfset session.Action="EditPenalty">
		</div>	
		</cfcase>						
		<cfcase value="13">
				 <div class="content">
		<div class="PageHeader">
					<cfoutput>
						Edit Penalty: #session.SelectedGame# 
					</cfoutput>
				</div>
			
			<cfif len(attributes.PenaltyId)>
			<cfset PenaltyId=attributes.PenaltyId>
			<cfelseif isDefined("url.PenaltyId")>
			<cfset PenaltyId=url.penaltyId>
			<cfelseif isDefined("form.penaltyId")>
			<cfset PenaltyId=form.penaltyId>
			</cfif>
			
			<cfquery name="qPenalty" datasource="#application.datasource#">
				Select 	PenaltyId,
						GameId,
						PenaltyUnitTypeId,
						PenaltyTimeTypeId,
						PenaltyPeriod as Period,
						P.PenalizedPlayerId,
						R.TeamSeasonId AS PENALIZEDPLAYERTEAMID,
						PenaltyLength,
						PenaltyStart,
						PenaltyStartPoint,
						PenaltyStopPoint
						from tblPenalty P 
						LEFT OUTER JOIN dbo.tblRoster R 
						ON P.PenalizedPlayerId=R.PlayerId
						where PenaltyId=#PenaltyId#
						and IsNull(SoftDelete,0)=0
			</cfquery>
			

			<cfquery name="qPenaltyDetails" datasource="#application.datasource#">
			  SELECT PlayerId FROM dbo.vPenaltyDetail
			  WHERE PenaltyId=#PenaltyId#	
			</cfquery>

<cfset selectedList=valuelist(qPenaltyDetails.PlayerId)>

		
			<cf_FormPenalty GameId=#qPenalty.GameId#  
							PenaltyId="#qPenalty.PenaltyID#" 
							PenaltyUnitTypeId="#qPenalty.PenaltyUnitTypeId#"
							PenaltyTimeTypeId="#qPenalty.PenaltyTimeTypeId#"
						    TeamSeasonId="#qPenalty.PenalizedPlayerTeamId#" 
							Period="#qPenalty.Period#"
							PlayerId="#qPenalty.PenalizedPlayerId#"
							PenaltyLength="#qPenalty.PenaltyLength#"
							PenaltyStart="#qPenalty.PenaltyStart#"
							PenaltyStartPoint="#qPenalty.PenaltyStartPoint#"
							PenaltyStopPoint="#qPenalty.PenaltyStopPoint#"
							SelectedValues="#selectedList#">
				
		
					

				</div>
		</cfcase>						

<cfcase value="14">
			

		 <div class="content">
		<div class="PageHeader">
					<cfoutput>
						Game: #session.SelectedGame#  - Penalties
					</cfoutput>
				</div>
			<cf_DisplayPenalty  GameId="#session.selectedGameId#" showDelete="true">	
		</div>		
	
			
		</cfcase>	
		<cfcase value="15">

		<cfif len(attributes.PenaltyId)>
			<cfset PenaltyId=attributes.PenaltyId>
			<cfelseif isDefined("url.PenaltyId")>
			<cfset PenaltyId=url.penaltyId>
			<cfelseif isDefined("form.penaltyId")>
			<cfset PenaltyId=form.penaltyId>
			</cfif>
							
	<cfquery datasource="#Application.datasource#" name="qSoftDelete">
		exec dbo.stpDeletePenalty @PenaltyId=#PenaltyId#
	</cfquery>


		 <div class="content">
		<div class="PageHeader">
					<cfoutput>
						Game: #session.SelectedGame#  - Penalties
					</cfoutput>
				</div>
			<cf_DisplayPenalty  GameId="#session.selectedGameId#" showDelete="true">	
		</div>		


		</cfcase>

			</cfswitch>
</div>
<cfinclude template="#application.includes#footer.cfm">