<cfinclude template="#Application.includes#Header.cfm">
<cfif session.action is "Insert">
<cftry>
	<cfquery name="qInsertGoal" datasource="#application.datasource#">
		exec dbo.stpInsertGoal 
	@GameId=#session.SelGameId#
	<cfif isDefined("form.GoalNumber") AND len(form.GoalNumber)>	
	,@GOALNUMBER=#form.GoalNumber#
		</cfif>
	,@GOALTYPEID=#form.GoalTypeId#
	,@GOALOFFSET=#form.GoalOffSet# 
	<cfif isDefined("form.GoalTime") AND len(form.GoalTime)>	
	,@GOALTIME='#form.GoalTime#'
		</cfif>
	,@PERIOD=#form.Period#	
	<cfif isDefined("form.PlusMinus") AND len(form.PlusMinus)>	
	,@PLUSMINUS='#form.PlusMinus#' 
		</cfif>
	,@TEAMSEASONID=#form.TeamSeasonId#
	<cfif isDefined("form.PlayerId") AND len(form.PlayerId)>		
	,@PLAYERID=#form.PlayerId#
		</cfif>
	<cfif isDefined("form.REASSIGNEDPLAYERID") AND len(form.REASSIGNEDPLAYERID)>
	,@REASSIGNEDPLAYERID=#form.REASSIGNEDPLAYERID#
	</cfif>	
	<cfif isDefined("form.GAMESHEETASSISTPLAYERID1") and len(form.GAMESHEETASSISTPLAYERID1)>	
	,@GAMESHEETASSISTPLAYERID1=#form.GAMESHEETASSISTPLAYERID1#
		</cfif>
	<cfif isDefined("form.GAMESHEETASSISTPLAYERID2") AND len(form.GAMESHEETASSISTPLAYERID2)>		
	,@GAMESHEETASSISTPLAYERID2=#form.GAMESHEETASSISTPLAYERID2#
		</cfif>
	<cfif isDefined("form.REASSIGNEDASSISTPLAYERID1") AND len(form.REASSIGNEDASSISTPLAYERID1)>	
		,@REASSIGNEDASSISTPLAYERID1=#form.REASSIGNEDASSISTPLAYERID1#
	</cfif>
	<cfif isDefined("form.REASSIGNEDASSISTPLAYERID2") AND len(form.REASSIGNEDASSISTPLAYERID2)>
		,@REASSIGNEDASSISTPLAYERID2=#form.REASSIGNEDASSISTPLAYERID2#
	</cfif>
		
	,@MainTeamSeasonId=#session.TeamSeasonId#
	</cfquery>




	
	<cfcatch>
	
		<cfsavecontent variable="queryResult">
	<cfoutput>
			exec dbo.stpInsertGoal 
 @GameId=#session.SelGameId#
<cfif isDefined("form.GoalNumber") AND len(form.GoalNumber)>	
,@GOALNUMBER=#form.GoalNumber#
	</cfif>
,@GOALTYPEID=#form.GoalTypeId#
,@GOALOFFSET=#form.GoalOffSet# 
,@GOALTIME='#form.GoalTime#'
,@PERIOD=#form.Period#	
<cfif isDefined("form.PlusMinus") AND len(form.PlusMinus)>	
,@PLUSMINUS='#form.PlusMinus#' 
	</cfif>
,@TEAMSeasonID=#form.TeamSeasonId#
<cfif isDefined("form.PlayerId") AND len(form.PlayerId)>		
,@PLAYERID=#form.PlayerId#
	</cfif>
<cfif isDefined("form.REASSIGNEDPLAYERID") AND len(form.REASSIGNEDPLAYERID)>
,@REASSIGNEDPLAYERID=#form.REASSIGNEDPLAYERID#
</cfif>	
<cfif isDefined("form.GAMESHEETASSISTPLAYERID1") and len(form.GAMESHEETASSISTPLAYERID1)>	
,@GAMESHEETASSISTPLAYERID1=#form.GAMESHEETASSISTPLAYERID1#
	</cfif>
<cfif isDefined("form.GAMESHEETASSISTPLAYERID2") AND len(form.GAMESHEETASSISTPLAYERID2)>		
,@GAMESHEETASSISTPLAYERID2=#form.GAMESHEETASSISTPLAYERID2#
	</cfif>
<cfif isDefined("form.REASSIGNEDASSISTPLAYERID1") AND len(form.REASSIGNEDASSISTPLAYERID1)>	
	,@REASSIGNEDASSISTPLAYERID1=#form.REASSIGNEDASSISTPLAYERID1#
</cfif>
<cfif isDefined("form.REASSIGNEDASSISTPLAYERID2") AND len(form.REASSIGNEDASSISTPLAYERID2)>
	,@REASSIGNEDASSISTPLAYERID2=#form.REASSIGNEDASSISTPLAYERID2#
</cfif>
	,@MainTeamSeasonId=#session.TeamSeasonId#	
	</cfoutput>
		
		</cfsavecontent>
	
	</cfcatch>
</cftry>
<cflocation url="#Application.pages#GoalWizard.cfm?step=3">
		</cfif>
<cfif session.action is "edit">
		
<cfquery name="qUpdateGoal" datasource="#application.datasource#">
	exec dbo.stpUpdateGoal 
@GoalId=#session.SelGoalId#			
,@GameId=#session.SelGameId#
<cfif isDefined("form.GoalNumber") AND len(form.GoalNumber)>	
,@GOALNUMBER=#form.GoalNumber#
	</cfif>
,@GOALTYPEID=#form.GoalTypeId#
,@GOALOFFSET=#form.GoalOffSet# 
<cfif isDefined("form.GoalTime") AND len(form.GoalTime)>	
,@GOALTIME='#form.GoalTime#'
	</cfif>
,@PERIOD=#form.Period#	
<cfif isDefined("form.PlusMinus") AND len(form.PlusMinus)>	
,@PLUSMINUS='#form.PlusMinus#' 
	</cfif>
,@TEAMSEASONID=#form.TeamSeasonId#
<cfif isDefined("form.PlayerId") AND len(form.PlayerId)>		
,@PLAYERID=#form.PlayerId#
	</cfif>
<cfif isDefined("form.REASSIGNEDPLAYERID") AND len(form.REASSIGNEDPLAYERID)>
,@REASSIGNEDPLAYERID=#form.REASSIGNEDPLAYERID#
</cfif>	
<cfif isDefined("form.GAMESHEETASSISTPLAYERID1") and len(form.GAMESHEETASSISTPLAYERID1)>	
,@GAMESHEETASSISTPLAYERID1=#form.GAMESHEETASSISTPLAYERID1#
	</cfif>
<cfif isDefined("form.GAMESHEETASSISTPLAYERID2") AND len(form.GAMESHEETASSISTPLAYERID2)>		
,@GAMESHEETASSISTPLAYERID2=#form.GAMESHEETASSISTPLAYERID2#
	</cfif>
<cfif isDefined("form.REASSIGNEDASSISTPLAYERID1") AND len(form.REASSIGNEDASSISTPLAYERID1)>	
	,@REASSIGNEDASSISTPLAYERID1=#form.REASSIGNEDASSISTPLAYERID1#
</cfif>
<cfif isDefined("form.REASSIGNEDASSISTPLAYERID2") AND len(form.REASSIGNEDASSISTPLAYERID2)>
	,@REASSIGNEDASSISTPLAYERID2=#form.REASSIGNEDASSISTPLAYERID2#
</cfif>
	
,@MainTeamSeasonId=#session.TeamSeasonId#

</cfquery>
<cflocation url="#Application.pages#GoalWizard.cfm?step=5&GoalId=#session.SelGoalId#&GameId=#session.SelGameId#">		
</cfif>


<cfinclude template="#application.includes#Footer.cfm">
	