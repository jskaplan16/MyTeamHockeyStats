<cfinclude template="includes/headers/Header.cfm">


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
 WHERE   PositionGeneral='FWD'
	
</cfquery>

<cfquery dbtype="query" name="qRosterRW">
SELECT * FROM qRoster 
WHERE  PositionGeneral='FWD'
</cfquery>

<cfquery dbtype="query" name="qRosterC">
SELECT * FROM qRoster 
WHERE  PositionGeneral='FWD'
</cfquery>
	
<cfquery dbtype="query" name="qRosterD">
	Select * from qRoster where PositionGeneral='DEF'
</cfquery>
<cfoutput>
<div class="content">
	    <div class="PageHeader">
      #session.TeamName#  - Line Builder 	
    </div>
  </cfoutput>		
	
	
				<cfif errors gt 0>
					<table align="center" style="border: 1px solid black;">
						<tr>
							<th  class="errorMsgHeader">
							Error Message
								</th>
						</tr>
					
					<tr> 
						<td class="errorBox" style="text-align: left;">
						<cfoutput>#ErrorMsg#</cfoutput>
						</td>
					</tr>
					</table>	
				</cfif>
		
		<br>

	<div style="text-align: left;">
		<b>Build Optimal Lines</b> 
		</div>	


					

								  

			<cfform action="LineApp.cfm" method="POST" name="LineApp">

	<table style="width: 70%" align="center" cellspacing="0">
		<tr>
		<th class="tblHeader">Line</th>
		<th class="tblHeader">Left Wing</th>
		<th class="tblHeader">Center</th>
		<th class="tblHeader">Right Wing</td>
		<th class="tblHeader">Left Defense</td>
		<th class="tblHeader">Right Defense</td>	
		<th class="tblHeader">&nbsp;</td>
		</tr>
		
		<tr>
			<td class="Row-Even" align="center">
				<cfoutput>
				#NextLine#
				<input type="hidden" name="FixedLineGroupId" value="#NextLine#">
				<input type="hidden" name="AddLine" value="Add">
			</cfoutput>
					</td>
			<td class="Row-Even">

		<cfquery dbtype="query" name="qRWDefault">
			Select * from qGetLines where PositionCode='LW' and FixedLineGroupId=1
		</cfquery>

				

				<cfselect name="PlayerId_LW" query="qRosterLW" display="PlayerName" value="PlayerId" selected="#qRWDefault.PlayerId#" required="yes" message="Left Wind Required">
					 <option value = "0" disabled selected>Select Left Wing</option> 
					</cfselect>
				

			</td>	
			<td class="Row-Even">
				
				
				
				<cfselect name="PlayerId_C" query="qRosterC" display="PlayerName" value="PlayerId" required="yes">
					<option value = "0" disabled selected>Select Center</option>
				</cfselect>	

			</td>
			<td class="Row-Even">

				<cfselect name="PlayerId_RW" query="qRosterRW" display="PlayerName" value="PlayerId" required="yes">
				<option value = "0" disabled selected>Select Right Wing</option>
				</cfselect>			
					

			</td>
			<td class="Row-Even">



				<cfselect name="PlayerId_LD" query="qRosterD" display="PlayerName" value="PlayerId" required="yes">
				<option value = "0" disabled selected>Select Left  Defense</option>
				</cfselect>			
			</td>

			<td class="Row-Even">
				<cfselect name="PlayerId_RD" query="qRosterD" display="PlayerName" value="PlayerId" required="yes">
				<option value = "0" disabled selected>Select Right Defense</option>
				</cfselect>		
			</td>
			<td valign="middle" class="Row-Even">
			<input type="submit" value="Add">
			</td>
		</tr>
	
	</table>
</cfform>
	
<div align="right">
<a href="LineApp.cfm?Email=True" class="mainLink" style="color: white;text-decoration: underline;">Email Report</a>		
	<br>
</div>
		
<cfsavecontent variable="varOptimalLine">
	

	<cfif qGetLines.recordcount gt 0> 
<cfquery datasource="#application.datasource#" name="qPosition">
Select * from tblPosition  
where PositionCode<> 'FF'
and  PositionGeneral='FWD'
	Order by LineAppOrder ASC
</cfquery>
	
	
	<table align="left" class="center" style="cell-spacing:0px;width:100%;" cellspacing=0>
	<tr>
	<th colspan="5"  style="text-align: left;">
	Offense
	</th>
	</tr>
	<tr>
	<th class="tblHeader">
	Line #	
	</th>
		
	<cfoutput query="qPosition">
	
		<th class="tblHeader">
			#Position#
		</th>
	</cfoutput>
  <th class="tblHeader">
		TTL Goals
		</th>
	<th class="tblHeader">
		TTL PTS
		</th>
		<th class="tblHeader">
		 Plus/Minus 
		</th>
		<th class="tblHeader">
		Minus
		</th>
	</tr>
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
	<td class="#classValue#">
			#qLinesInApp.FixedLineGroupId#
			</td>
			</cfoutput>
		
<cfloop query="qPosition">
	<cfoutput>
		<td class="#classValue#">
		</cfoutput>
			<cfquery dbtype="query" name="qTmp">
			Select * from qGetLines where PositionCode='#qPosition.PositionCode#' and FixedLineGroupId=#qLinesInApp.FixedLineGroupId#
			and PositionGeneral='FWD'
		</cfquery>
		<cfoutput> #qTmp.PlayerName#</cfoutput>
		</td>
</cfloop>
		
	<cfquery dbtype="query" name="qTTL">
	Select 	FixedLineGroupId,
		Sum(Goals) as Goals,
		Sum(Points) as Points,
		Sum(PlusMinusPoints) as PlusMinusPoints,
		Sum(Minus) as Minus
		from qGetLines where FixedLineGroupId=#qLinesInApp.FixedLineGroupId# 
		and PositionGeneral='FWD'
		Group by FixedLineGroupId
	</cfquery>
	<cfoutput>
		
		<td class="#classValue#" style="text-align: center;">
			#qTTL.Goals#
		</td>
		
		<td class="#classValue#" style="text-align: center;">
			#qTTL.Points#
		</td>
		
		<td class="#classValue#" style="text-align: center;">
			#qTTL.PlusMinusPoints#
		</td>
		
		<td class="#classValue#" style="text-align: center;">
			#qTTL.Minus#
		</td>
</cfoutput>
	</tr>
</cfloop>	

</table>
	
	
	
	
	
<cfquery datasource="#application.datasource#" name="qPosition">
Select * from tblPosition  
where PositionCode<> 'FF'
and  PositionGeneral='DEF'
	Order by LineAppOrder ASC
</cfquery>	


	<table align="left" class="center" style="cell-spacing:0px;width:100%;" cellspacing=0>
	<tr>
	<th colspan="5"  style="text-align: left;">
	Defense
	</th>
	<tr>
	  <th class="tblHeader">
	Line #	
	</th>
		
	<cfoutput query="qPosition">
	
		  <th class="tblHeader">
			#Position#
		</th>
	</cfoutput>
    <th class="tblHeader">
		TTL Goals
		</th>
	  <th class="tblHeader">
		TTL PTS
		</th>
		  <th class="tblHeader">
		 Plus/Minus 
		</th>
		  <th class="tblHeader">
		Minus
		</th>
	</tr>
		
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
		<td class="#classValue#">
			#qLinesInApp.FixedLineGroupId#
			</td></cfoutput>
		
<cfloop query="qPosition">
	<cfoutput>
	<td class="#classValue#">
	</cfoutput>
		<cfquery dbtype="query" name="qTmp">
			Select * from qGetLines where PositionCode='#qPosition.PositionCode#' and FixedLineGroupId=#qLinesInApp.FixedLineGroupId#
			and PositionGeneral='DEF'
		</cfquery>
		<cfoutput> #qTmp.PlayerName#</cfoutput>
		</td>
</cfloop>

	<cfquery dbtype="query" name="qTTL">
	Select 	FixedLineGroupId,
		Sum(Goals) as Goals,
		Sum(Points) as Points,
		Sum(PlusMinusPoints) as PlusMinusPoints,
		Sum(Minus) as Minus
		from qGetLines where FixedLineGroupId=#qLinesInApp.FixedLineGroupId# 
		and PositionGeneral='DEF'
		Group by FixedLineGroupId
	</cfquery>
	<cfoutput>
				<td class="#classValue#" style="text-align: center;">
		#qTTL.Goals#
		</td>
				<td class="#classValue#" style="text-align: center;">
		#qTTL.Points#
		</td>
				<td class="#classValue#" style="text-align: center;">
		#qTTL.PlusMinusPoints#
		</td>
							<td class="#classValue#" style="text-align: center;">
		#qTTL.Minus#
		</td>
</cfoutput>
	</tr>
</cfloop>	

</table>		

	
<cfquery datasource="#application.datasource#" name="qPosition">
Select * from tblPosition  
where PositionCode<> 'FF'
	Order by LineAppOrder ASC
</cfquery>	

		

<table align="left" class="center" style="cell-spacing:0px;width:100%;" cellspacing=0>
	<tr>
	<th colspan="11"  style="text-align: left;">
	Full Line
	</th>
	<tr>
	<th class="tblHeader">
	Line #	
	</th>
		
	<cfoutput query="qPosition">
	
			<th class="tblHeader">
			#Position#
		</th>
	</cfoutput>
   	<th class="tblHeader">
		TTL Goals
		</th>
		<th class="tblHeader">
		TTL PTS
		</th>
			<th class="tblHeader">
		 Plus/Minus 
		</th>
			<th class="tblHeader">
		Minus
		</th>
					<th class="tblHeader">&nbsp;
						
		</th>
	</tr>
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
	<td class="#classValue#">		
			#qLinesInApp.FixedLineGroupId#
			</td></cfoutput>
		
<cfloop query="qPosition">
<cfoutput>		<td class="#classValue#"></cfoutput>
		<cfquery dbtype="query" name="qTmp">
			Select * from qGetLines where PositionCode='#qPosition.PositionCode#' and FixedLineGroupId=#qLinesInApp.FixedLineGroupId#
		</cfquery>
		<cfoutput> #qTmp.PlayerName#</cfoutput>
		</td>
</cfloop>

	<cfquery dbtype="query" name="qTTL">
	Select 	FixedLineGroupId,
		Sum(Goals) as Goals,
		Sum(Points) as Points,
		Sum(PlusMinusPoints) as PlusMinusPoints,
		Sum(Minus) as Minus
		from qGetLines where FixedLineGroupId=#qLinesInApp.FixedLineGroupId# 
		
		Group by FixedLineGroupId
	</cfquery>
	<cfoutput>
				<td class="#classValue#" align="center">
		#qTTL.Goals#
		</td>
				<td class="#classValue#" align="center">
		#qTTL.Points#
		</td>
				<td class="#classValue#" align="center">
		#qTTL.PlusMinusPoints#
		</td>
			<td class="#classValue#">
		#qTTL.Minus#
		</td>
		

				<td class="#classValue#">
<cfif not isDefined("url.Email")>
		<cfform action="LineApp.cfm" method="POST" name="LineApp">
			<input	type="hidden" name="FixedLineGroupId" value="#qLinesInApp.FixedLineGroupId#">
			<input type="hidden" name="formAction" value="Delete">
			<input	type="submit" value="Delete">
		</cfform>
</cfif>	
			</td>
	</cfoutput>
	</tr>
</cfloop>	
</table>			
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



	
<cfinclude template="includes/footers/Footer.cfm">