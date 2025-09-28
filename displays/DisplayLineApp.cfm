<cfinclude template="#application.includes#header.cfm">


<cfparam name="errors" default="0">
<cfparam name="url.GameId" default="1">
<cfparam  name="url.showMore" default="25">
<cfparam name="url.PlayerId" default="1" >
<cfparam name="url.Action" default="" >
<cfparam name="url.SortField" default="Total_Points">
<cfparam name="url.SortOrder" default="Desc">	
	
			<cfif NOT structKeyExists(session, "ShowCoachFunctions")>
    			<cflocation url="index.cfm">	
			</cfif>	
	

	

	<cfif isDefined("form.formAction") and form.formAction is "delete">
		<cfquery name="qDeleteLines" datasource="#application.datasource#">
		exec stpDeleteLineApp @FixLineGroupId=#form.FIXEDLINEGROUPID#,@UserId=#session.userId#
			</cfquery>
	</cfif>
	
<cfif isDefined("form.AddLine")>
	<cfsavecontent variable="ErrorMsg">
<div>
		<cfif not isDefined("form.PLAYERID_C")>
			<div>
			Player position center not selected.
			</div>
		<cfset errors=1>	
		</cfif>
		<cfif not isDefined("form.PLAYERID_LW")>
			<div>
						Player position left wing not selected. 
			</div>
		<cfset errors=1>	
		</cfif>	
		<cfif not isDefined("form.PLAYERID_RW")>
			<div>
			Player position right wing not selected. 
			</div>
		<cfset errors=1>	
		</cfif>
		<cfif not isDefined("form.PLAYERID_LD")>
			<div>
			Player position left defense not selected. 
			</div>
		<cfset errors=1>	
		</cfif>		
		<cfif not isDefined("form.PLAYERID_RD")>
			<div>
			Player position right defense not selected. 
			</div>
		<cfset errors=1>	
		</cfif>		
</div>
		</cfsavecontent>

	<cfif errors is  0>	
		<cfquery name="qInsertLines" datasource="#application.datasource#">
		exec dbo.stpLineAppAddLineMember 
		 @FixedLineGroupId=#form.FixedLineGroupId#, 
		 @PlayerId_LW=#form.PlayerId_LW#, 
		 @PlayerId_C=#form.PlayerId_C#, 
		 @PlayerId_RW=#form.PlayerId_RW#, 	
		 @PlayerId_LD=#form.PlayerId_LD#, 	
		 @PlayerId_RD=#form.PlayerId_RD#,
		 @UserId=#session.userId#,
		 @TeamSeasonId=#session.TeamSeasonId#
		</cfquery>
		
	<cfif isDefined("qInsertLines.recordcount") and  (qInsertLines.recordcount gt 0)>
		<cfset errors=1>
			<cfsavecontent variable="errorMsg">
			   <div>
				<cfoutput>#qInsertLines.ErrorMsg#</cfoutput>
			</div>  
			</cfsavecontent>
	</cfif>
		
	</cfif>	
			
</cfif>
	
<cfquery datasource="#application.datasource#" name="qLine">
SELECT FixedLineGroupId  FROM [dbo].[tblFixLineGroup]
Order by FixedLineGroupId
</cfquery>

	<cfquery name="qGetLines" datasource="#application.datasource#">
		exec dbo.stpGetLineApp @UserId=<cfqueryParam value=#session.userId# cfsqltype="CF_SQL_INTEGER">,
		@TeamSeasonId=<cfqueryParam value="#session.TeamSeasonId#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
<cfset PlayerList=valueList(qGetLines.PlayerId)>
	
<cfquery name="qRoster" datasource="#application.datasource#">	
	SELECT PlayerId,Concat(PlayerName,' ', PositionCode) as PlayerName,PositionCode,PositionGeneral FROM vRoster r Where TeamSeasonId=#session.teamSeasonId#
	<cfif len(PlayerList) gt 0>and PlayerId not in (#PlayerList#)</cfif>
</cfquery>

		<cfquery dbtype="query" name="qNextLine">
	Select  FixedLineGroupId+1 as NextLineID from qGetLines Group by FixedLineGroupId
	having count(*)=5
    Order by NextLineID desc
	</cfquery>
	
			<cfif isDefined("qNextLine.recordcount") and qNextLine.recordcount gt 0>
					<cfset nextLine=qNextLine.NextLineID[1]>
			<cfelse>
					<cfset nextLine=1>
			</cfif>

	
<cfquery dbtype="query" name="qRosterLW">
SELECT * FROM qRoster 
 WHERE   PositionGeneral='F'
	
</cfquery>

<cfquery dbtype="query" name="qRosterRW">
SELECT * FROM qRoster 
WHERE  PositionGeneral='F'
</cfquery>

<cfquery dbtype="query" name="qRosterC">
SELECT * FROM qRoster 
WHERE  PositionGeneral='F'
</cfquery>
	
<cfquery dbtype="query" name="qRosterD">
	Select * from qRoster where PositionGeneral='D'
</cfquery>
<cfoutput>
<div class="content">
	    <div class="PageHeader">
      #session.TeamName#  - Line Builder 	
    </div>
  </cfoutput>		
	
	
				<cfif errors gt 0>
					<div class="error-box" style="margin: 20px auto; max-width: 800px;">
						<h3 style="color: #e74c3c; margin-bottom: 10px; text-align: center;">⚠️ Error Message</h3>
						<div style="background-color: #fff5f5; border-left: 4px solid #e74c3c; padding: 15px; border-radius: 4px;">
							<cfoutput>#ErrorMsg#</cfoutput>
						</div>
					</div>
				</cfif>
		
		<br>


			<cfform action="#application.displays#DisplayLineApp.cfm" method="POST" name="LineApp">

	<table class="table-container" style="width: 100%; max-width: 1200px; margin: 0 auto;" cellspacing="0">
		<thead>
			<tr>
				<th class="tblHeader" style="text-align: center; padding: 15px;">Line</th>
				<th class="tblHeader" style="text-align: center; padding: 15px;">Left Wing</th>
				<th class="tblHeader" style="text-align: center; padding: 15px;">Center</th>
				<th class="tblHeader" style="text-align: center; padding: 15px;">Right Wing</th>
				<th class="tblHeader" style="text-align: center; padding: 15px;">Left Defense</th>
				<th class="tblHeader" style="text-align: center; padding: 15px;">Right Defense</th>	
				<th class="tblHeader" style="text-align: center; padding: 15px;">Action</th>
			</tr>
		</thead>
		<tbody>
		
		<tr>
			<td class="Row-Even" style="text-align: center; padding: 15px; vertical-align: middle;">
				<cfoutput>
				<strong style="font-size: 1.2em;">#NextLine#</strong>
				<input type="hidden" name="FixedLineGroupId" value="#NextLine#">
				<input type="hidden" name="AddLine" value="Add">
				</cfoutput>
			</td>
			<td class="Row-Even" style="padding: 15px; vertical-align: middle;">
				<cfquery dbtype="query" name="qRWDefault">
					Select * from qGetLines where PositionCode='LW' and FixedLineGroupId=1
				</cfquery>
				<cfselect name="PlayerId_LW" query="qRosterLW" display="PlayerName" value="PlayerId" selected="#qRWDefault.PlayerId#" required="yes" message="Left Wing Required" style="width: 100%; padding: 8px; border: 1px solid ##ccc; border-radius: 4px;">
					<option value = "0" disabled selected>Select Left Wing</option> 
				</cfselect>
			</td>	
			<td class="Row-Even" style="padding: 15px; vertical-align: middle;">
				<cfselect name="PlayerId_C" query="qRosterC" display="PlayerName" value="PlayerId" required="yes" style="width: 100%; padding: 8px; border: 1px solid ##ccc; border-radius: 4px;">
					<option value = "0" disabled selected>Select Center</option>
				</cfselect>	
			</td>
			<td class="Row-Even" style="padding: 15px; vertical-align: middle;">
				<cfselect name="PlayerId_RW" query="qRosterRW" display="PlayerName" value="PlayerId" required="yes" style="width: 100%; padding: 8px; border: 1px solid ##ccc; border-radius: 4px;">
					<option value = "0" disabled selected>Select Right Wing</option>
				</cfselect>			
			</td>
			<td class="Row-Even" style="padding: 15px; vertical-align: middle;">
				<cfselect name="PlayerId_LD" query="qRosterD" display="PlayerName" value="PlayerId" required="yes" style="width: 100%; padding: 8px; border: 1px solid ##ccc; border-radius: 4px;">
					<option value = "0" disabled selected>Select Left Defense</option>
				</cfselect>			
			</td>
			<td class="Row-Even" style="padding: 15px; vertical-align: middle;">
				<cfselect name="PlayerId_RD" query="qRosterD" display="PlayerName" value="PlayerId" required="yes" style="width: 100%; padding: 8px; border: 1px solid ##ccc; border-radius: 4px;">
					<option value = "0" disabled selected>Select Right Defense</option>
				</cfselect>		
			</td>
			<td class="Row-Even" style="text-align: center; padding: 15px; vertical-align: middle;">
				<input type="submit" value="Add Line" style="background-color: var(--accent-blue); color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold;">
			</td>
		</tr>
		</tbody>
	</table>
</cfform>
	
<div align="right">
<a href="#application.displays#DisplayLineApp.cfm?Email=True" class="mainLink" style="color: white;text-decoration: underline;">Email Report</a>		
	<br>
</div>
		
<cfsavecontent variable="varOptimalLine">
	

	<cfif qGetLines.recordcount gt 0> 
<cfquery datasource="#application.datasource#" name="qPosition">
Select * from vPosition  
where PositionCode<> 'FF'
and  PositionGeneral='FWD'
	Order by LineAppOrder ASC
</cfquery>
	
	
	<div style="margin: 30px 0;">
		<h2 style="color: var(--primary-blue); text-align: center; margin-bottom: 20px; font-size: 1.5em;">🏒 Offensive Lines</h2>
		<table class="table-container" style="width: 100%; margin: 0 auto;" cellspacing="0">
			<thead>
				<tr>
					<th class="tblHeader" style="text-align: center; padding: 12px;">
						Line #
					</th>
		
	<cfoutput query="qPosition">
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			#Position#
		</th>
	</cfoutput>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			TTL Goals
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			TTL PTS
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			Plus/Minus 
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			Minus
		</th>
			</tr>
		</thead>
		<tbody>
<cfquery dbtype="query" name="qLinesInApp">
Select distinct FixedLineGroupId from qGetLines	
</cfquery>


	<cfloop query="qLinesInApp">
		<cfif qLinesInApp.currentRow  mod 2> 
			<cfset classValue="Row-Even">
		<cfelse>
			<cfset classValue="Row-Odd">
		</cfif>	
		<tr>
			<cfoutput>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold;">
				#qLinesInApp.FixedLineGroupId#
			</td>
			</cfoutput>
		
		<cfloop query="qPosition">
			<cfquery dbtype="query" name="qTmp">
				Select * from qGetLines where PositionCode='#qPosition.PositionCode#' and FixedLineGroupId=#qLinesInApp.FixedLineGroupId#
				and PositionGeneral='FWD'
			</cfquery>
			<td class="#classValue#" style="padding: 10px; text-align: center;">
				<cfoutput>#qTmp.PlayerName#</cfoutput>
			</td>
		</cfloop>
		
		<cfquery dbtype="query" name="qTTL">
			Select FixedLineGroupId,
				Sum(Goals) as Goals,
				Sum(Points) as Points,
				Sum(PlusMinusPoints) as PlusMinusPoints,
				Sum(Minus) as Minus
				from qGetLines where FixedLineGroupId=#qLinesInApp.FixedLineGroupId# 
				and PositionGeneral='FWD'
				Group by FixedLineGroupId
		</cfquery>
		<cfoutput>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Goals#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Points#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.PlusMinusPoints#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Minus#
			</td>
		</cfoutput>
		</tr>
	</cfloop>	
		</tbody>
	</table>
	</div>
	
	
	
	
	
<cfquery datasource="#application.datasource#" name="qPosition">
Select * from vPosition  
where PositionCode<> 'FF'
and  PositionGeneral='DEF'
	Order by LineAppOrder ASC
</cfquery>	


	<div style="margin: 30px 0;">
		<h2 style="color: var(--primary-blue); text-align: center; margin-bottom: 20px; font-size: 1.5em;">🛡️ Defensive Lines</h2>
		<table class="table-container" style="width: 100%; margin: 0 auto;" cellspacing="0">
			<thead>
				<tr>
					<th class="tblHeader" style="text-align: center; padding: 12px;">
						Line #
					</th>
		
	<cfoutput query="qPosition">
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			#Position#
		</th>
	</cfoutput>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			TTL Goals
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			TTL PTS
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			Plus/Minus 
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			Minus
		</th>
			</tr>
		</thead>
		<tbody>
		
<cfquery dbtype="query" name="qLinesInApp">
Select distinct FixedLineGroupId from qGetLines	
</cfquery>

	<cfloop query="qLinesInApp">
		<cfif qLinesInApp.currentRow  mod 2> 
			<cfset classValue="Row-Even">
		<cfelse>
			<cfset classValue="Row-Odd">
		</cfif>		
		<tr>
			<cfoutput>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold;">
				#qLinesInApp.FixedLineGroupId#
			</td>
			</cfoutput>
		
		<cfloop query="qPosition">
			<cfquery dbtype="query" name="qTmp">
				Select * from qGetLines where PositionCode='#qPosition.PositionCode#' and FixedLineGroupId=#qLinesInApp.FixedLineGroupId#
				and PositionGeneral='DEF'
			</cfquery>
			<td class="#classValue#" style="padding: 10px; text-align: center;">
				<cfoutput>#qTmp.PlayerName#</cfoutput>
			</td>
		</cfloop>

		<cfquery dbtype="query" name="qTTL">
			Select FixedLineGroupId,
				Sum(Goals) as Goals,
				Sum(Points) as Points,
				Sum(PlusMinusPoints) as PlusMinusPoints,
				Sum(Minus) as Minus
				from qGetLines where FixedLineGroupId=#qLinesInApp.FixedLineGroupId# 
				and PositionGeneral='DEF'
				Group by FixedLineGroupId
		</cfquery>
		<cfoutput>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Goals#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Points#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.PlusMinusPoints#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Minus#
			</td>
		</cfoutput>
		</tr>
	</cfloop>	
		</tbody>
	</table>
	</div>		

	
<cfquery datasource="#application.datasource#" name="qPosition">
Select * from vPosition  
where PositionCode<> 'FF'

	Order by LineAppOrder ASC
</cfquery>	

		

	<div style="margin: 30px 0;">
		<h2 style="color: var(--primary-blue); text-align: center; margin-bottom: 20px; font-size: 1.5em;">🏆 Complete Lines</h2>
		<table class="table-container" style="width: 100%; margin: 0 auto;" cellspacing="0">
			<thead>
				<tr>
					<th class="tblHeader" style="text-align: center; padding: 12px;">
						Line #
					</th>
		
	<cfoutput query="qPosition">
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			#Position#
		</th>
	</cfoutput>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			TTL Goals
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			TTL PTS
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			Plus/Minus 
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			Minus
		</th>
		<th class="tblHeader" style="text-align: center; padding: 12px;">
			Action
		</th>
			</tr>
		</thead>
		<tbody>
<cfquery dbtype="query" name="qLinesInApp">
Select distinct FixedLineGroupId from qGetLines	
</cfquery>
	<cfloop query="qLinesInApp">
		<cfif qLinesInApp.currentRow  mod 2> 
			<cfset classValue="Row-Even">
		<cfelse>
			<cfset classValue="Row-Odd">
		</cfif>	
		<tr>
			<cfoutput>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold;">		
				#qLinesInApp.FixedLineGroupId#
			</td>
			</cfoutput>
		
		<cfloop query="qPosition">
			<cfoutput>
			<td class="#classValue#" style="padding: 10px; text-align: center;">
			</cfoutput>
			<cfquery dbtype="query" name="qTmp">
				Select * from qGetLines where PositionCode='#qPosition.PositionCode#' and FixedLineGroupId=#qLinesInApp.FixedLineGroupId#
			</cfquery>
			<cfoutput>#qTmp.PlayerName#</cfoutput>
			</td>
		</cfloop>

		<cfquery dbtype="query" name="qTTL">
			Select FixedLineGroupId,
				Sum(Goals) as Goals,
				Sum(Points) as Points,
				Sum(PlusMinusPoints) as PlusMinusPoints,
				Sum(Minus) as Minus
				from qGetLines where FixedLineGroupId=#qLinesInApp.FixedLineGroupId# 
				Group by FixedLineGroupId
		</cfquery>
		<cfoutput>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Goals#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Points#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.PlusMinusPoints#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px; font-weight: bold; background-color: var(--gray);">
				#qTTL.Minus#
			</td>
			<td class="#classValue#" style="text-align: center; padding: 10px;">
				<cfif not isDefined("url.Email")>
					<cfform action="#application.displays#DisplayLineApp.cfm" method="POST" name="LineApp">
						<input type="hidden" name="FixedLineGroupId" value="#qLinesInApp.FixedLineGroupId#">
						<input type="hidden" name="formAction" value="Delete">
						<input type="submit" value="Delete" style="background-color: ##e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 0.9em;">
					</cfform>
				</cfif>	
			</td>
		</cfoutput>
		</tr>
	</cfloop>	
		</tbody>
	</table>
	</div>			
	</cfif>

</cfsavecontent>

	<cfoutput>
	#varOptimalLine#
	</cfoutput>
<cf_DisplayGoalSummary  GameId="All" showMore="#url.showMore#" SortOrder="#url.SortOrder#" SortField="#url.SortField#" PageName="LineApp.cfm" DetailsPage="PlayerDetail.cfm" StartGameDate="#Session.StartofSeason#" EndGameDate="#Session.EndofSeason#" scrollable="true">
</div>

<cfif isdefined("url.Email")>
	<cfmail
		to="#session.userName#"
		bcc="jskaplan@gmail.com"
		from="admin@MyTeamhockeyStats.com"
		subject="Line Builder - Report "
		type="html">	
				#varOptimalLine#	

			</cfmail>
	
</cfif>	



	
<cfinclude template="#application.includes#footer.cfm">