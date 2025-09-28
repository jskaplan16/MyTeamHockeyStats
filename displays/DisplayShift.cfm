
<cfinclude template="includes/headers/Header.cfm">
<div class="content">
<cfparam name="url.Order" default="ASC" >
<cfparam name="url.OrderBy" default="AvgShift" >
<cfparam name="url.period" default="1">

<cfquery  datasource="#application.datasource#" name="qGameWithShift">
    SELECT DISTINCT a.GameId FROM dbo.tblGame A
INNER JOIN dbo.tblShift b 
ON a.GameId=b.GameId
WHERE a.PublishShifts = 1 
</cfquery>

<cfif not isDefined("form.GameID") and isDefined("url.GameId")>
    <cfset form.GameId=url.GameId>
</cfif>

<cfoutput>
	
    <div class="PageHeader">
      #session.TeamName# Shifts 	
    </div>
  </cfoutput>	

	




<cfif form.GameId is not "all" and form.GameId neq "">
	<div align="center" style="width: 100%;padding:10px;align-items: center;">
		<cf_scorekeeper GameId="#form.GameId#">
	</div>

</cfif>

 <div style="padding: 5px;width:80%">
    <cf_ctrSelectGame GameId="#form.GameId#" ActionPage="DisplayShift.cfm" NextStep="Blank"  action="edit" includeList="#valueList(qGameWithShift.GameId)#">
  </div> 
<cfif form.GameId eq "">

    <cfinclude template="includes/footers/Footer.cfm">
    <cfabort>
</cfif>


<cfquery datasource="#application.datasource#" name="qShiftSummaryFirst" >
    dbo.stpShiftSummaryByGame 
    @GameId=#form.GameId#, 
    @TeamId=#session.teamId#,
    @StartDate='#session.startofseason#'
</cfquery>

<cfswitch expression="#url.OrderBy#" >
    <cfcase value="AvgShift">
        <cfset OrderByColumn = "Period" & url.period & "AvgIceTimeSeconds">
 
    </cfcase>
    <cfcase value="Shifts">
        <cfset OrderByColumn = "Period" & url.period & "ShiftCnt">
    </cfcase>
    <cfcase value="IceTime">
        <cfset OrderByColumn = "Period" & url.period & "IceTimeSeconds">
    </cfcase>
    <cfcase value="TTLAvgShift">
        <cfset OrderByColumn="AvgShiftLengthSeconds">
    </cfcase>
     <cfcase value="TTLShifts">
        <cfset OrderByColumn="Shifts">
        <cfset url.period="">
     </cfcase>
     <cfcase value="GPG">
        <cfset OrderByColumn="GPG">
     </cfcase>
          <cfcase value="PPG">
        <cfset OrderByColumn="PPG">
     </cfcase>
          <cfcase value="TTLIceTime">
        <cfset OrderByColumn="TTLActualIceTimeSeconds">
     </cfcase>
    <cfdefaultcase>
            <cfset OrderByColumn = "TTLActualIceTimeSeconds"> 
          
        </cfdefaultcase>
</cfswitch>


<cfquery  dbtype="query" name="qShiftSummary">
    Select * from qShiftSummaryFirst
  <cfif url.Period neq "all">
    ORDER BY #OrderByColumn# #url.Order#
  </cfif>   
</cfquery>







<cfif isdefined("qShiftSummary.RecordCount") and qShiftSummary.RecordCount>
<div class="table-wrapper">	
<table class="filterTable">
<tr>
<th>
&nbsp;
</th>
<th colspan="3" style="border-right:1px solid white;">Period 1</th>
<th colspan="3"style="border-right:1px solid white;">Period 2</th>
<th colspan="3"style="border-right:1px solid white;">Period 3</th>
<th colspan="3"style="border-right:1px solid white;">Full Game</th>
<!---
<th colspan="3"style="border-right:1px solid white;">Season <br>Player Stats</th>
--->
</tr>
<cfoutput>
    

<tr>

<th>
PlayerName
</th>

<th>
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=1&Orderby=AvgShift&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=1&Orderby=AvgShift&Order=ASC" class="nav-link">
</cfif>

Avg Shift</a>
</th>
<th>
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=1&Orderby=Shifts&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=1&Orderby=Shifts&Order=ASC" class="nav-link">
</cfif>
Shifts 
</a>
</th>

<th align="center" style="border-right:1px solid white;">
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=1&Orderby=IceTime&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=1&Orderby=IceTime&Order=ASC" class="nav-link">
</cfif>
Ice time
</a>
</th>

<th>
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=2&Orderby=AvgShift&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=2&Orderby=AvgShift&Order=ASC" class="nav-link">
</cfif>

Avg Shift</a>
</th>
<th>
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=2&Orderby=Shifts&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=2&Orderby=Shifts&Order=ASC" class="nav-link">
</cfif>
Shifts</a> 
</a>
</th>
<th align="center" style="border-right:1px solid white;">
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=2&Orderby=IceTime&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=2&Orderby=IceTime&Order=ASC" class="nav-link">
</cfif>
Ice time
</a>
</th>


<th>
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=3&Orderby=AvgShift&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=3&Orderby=AvgShift&Order=ASC" class="nav-link">
</cfif>
Avg Shift</a>
</th>
<th>
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=3&Orderby=Shifts&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=3&Orderby=Shifts&Order=ASC" class="nav-link">
</cfif>
Shifts 
</a>
</th>

<th align="center" style="border-right:1px solid white;">
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=3&Orderby=IceTime&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=3&Orderby=IceTime&Order=ASC" class="nav-link">
</cfif>
Ice time
</a>
</th>

<th>
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=3&Orderby=TTLAvgShift&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Period=3&Orderby=TTLAvgShift&Order=ASC" class="nav-link">
</cfif>
Avg Shift
</a>
</th>

<th align="center">
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Orderby=TTLShifts&Order=DESC&Period=All" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Orderby=TTLShifts&Order=ASC&Period=All" class="nav-link">
</cfif>
Shifts </a>
</th>


<th align="center" style="border-right:1px solid white;">
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Orderby=TTLIceTime&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Orderby=TTLIceTime&Order=ASC" class="nav-link">
</cfif>
Ice Time
</a>
</th>

<!---
<th align="center">
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Orderby=GPG&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Orderby=GPG&Order=ASC" class="nav-link">
</cfif>
GPG
</a>
</th>

<th align="center">
<cfif url.Order is "ASC"> 
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Orderby=PPG&Order=DESC" class="nav-link">
<cfelse>
<a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&Orderby=PPG&Order=ASC" class="nav-link">
</cfif>
PPG
</a>
</th>
--->

</tr>
</cfoutput>

<cfoutput query="qShiftSummary">
<cfif qShiftSummary.CurrentRow mod 2 eq 0>
<tr class="row-even">
<cfelse>
<tr class="row-odd">
</cfif>
	<td class="tblCellLeft">
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#" class="link-style">#PlayerNumber# - #PlayerName#</a> 
</td>

<td class="tblCellCenter">
#Period1AvgIceTime#
</td>
<td class="tblCellCenter">
<cfif url.Order is "ASC"> 
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#&Period=1&Order=DESC" class="link-style">
<cfelse>
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#&Period=1&Order=ASC" class="link-style">
</cfif>
#Period1ShiftCnt#
</a>
</td>

<td class="tblCellCenter" style="text-align: center;border-right:1px solid black;border-left:1px solid black;">
#Period1IceTime#
</td>



<td class="tblCellCenter">
#Period2AvgIceTime#
</td>
<td class="tblCellCenter">
<cfif url.Order is "ASC"> 
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#&Period=2&Order=DESC&Orderby=#url.OrderBy#" class="link-style">
<cfelse>
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#&Period=2&Order=ASC" class="link-style">
</cfif>
#Period2ShiftCnt#
</a>
</td>
<td class="tblCellCenter" style="border-right:1px solid black;border-left:1px solid black;">
#Period2IceTime#
</td>


<td class="tblCellCenter">
#Period3AvgIceTime#
</td>
<td class="tblCellCenter">
<cfif url.Order is "ASC"> 
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#&Period=3&Order=DESC" class="link-style">
<cfelse>
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#&Period=3&Order=ASC" class="link-style">
</cfif>
#Period3ShiftCnt#
</a>
</td>

<td class="tblCellCenter" style="border-right:1px solid black;border-left:1px solid black;">
#Period3IceTime#
</td>

<td class="tblCellCenter">
#AvgShiftLength#
</td>
<td class="tblCellCenter">
<cfif url.Order is "ASC"> 
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#&Period=all&Order=DESC" class="link-style">
<cfelse>
 <a href="DisplayShift.cfm?GameId=#qShiftSummary.GameId#&PlayerId=#qShiftSummary.PlayerId#&Period=all&Order=ASC" class="link-style">
</cfif>
#Shifts#
</a>
</td>
<td class="tblCellLeft" style="border-right:1px solid black;border-left:1px solid black;" nowrap>
#TTLActualIceTime# / <label title="This player is #TTLTimeRank# out of 16, for playing time. (1 Most, 16 Least)."> #TTLTimeRank# </label>
</td>
<!---
<td class="tblCellLeft" style="text-align: center;border-right:1px solid black;border-left:1px solid black;">
#NumberFormat(GPG,"0.000")# 
</td>
<td class="tblCellLeft" style="text-align: center;border-right:1px solid black;border-left:1px solid black;">
#NumberFormat(PPG,"0.000")#
</td>
--->


</tr>
</cfoutput>
</table>

<cfif isDefined("url.PlayerId")>
    <cfquery name="qShift" datasource="#Application.Datasource#">
    Select VideoEmbed,Game,GameId,ShiftMapperId,PlayerName,PlayerId,PlayerNumber,SecondsOnIce,PlayerShiftNumber,StartShift,EndShift,ActualIceTime,Period,
    ROW_NUMBER() OVER (Partition By GameID,Period Order by StartShift) as RwId 
    from vShift
    Where GameId=#qShiftSummary.GAMEID#
    and PlayerId <> -1 
    and   PlayerId=#url.PlayerId# 
    <cfif isDefined("url.Period") and url.Period neq "ALL">
    and period=#url.Period#
    </cfif>
        Order by StartShift ASC, PlayerShiftNumber ASC
    </cfquery>

<cfif qShift.RecordCount>
<br>
<table>

<cfoutput query="qShift">
<cfset minutes = qShift.ActualIceTime \ 60>
<cfset seconds = qShift.ActualIceTime mod 60>
<cfset TimeOnIce = minutes & ":" & iif(seconds lt 10,"0","") & seconds>
<cfif qShift.RwId eq 1>
<tr>
    <th colspan="2">
    Period: #qShift.Period#
    </th>
</tr>
</cfif>
<tr>
    <td style="text-vertical-align: top;text-align: left;">
    PlayerName: #PlayerName# <br>
    Shift Number: #PlayerShiftNumber# <br> 
    Time on Ice: #TimeOnIce# <br>
    Start Time: #StartShift# <br>
    End Time: #EndShift# <br>
    Period: #Period#
    </td>
    <td style="text-vertical-align: top;text-align: right;">
        <iframe id="Player" style="height: 150px; width: 260px;"
        src="#VideoEmbed#" 
        title="YouTube video player" 
        frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
        </iframe>
    </td>
</tr>
<cfset period = qShift.Period>
</cfoutput>
</table>
</div>	

</cfif>
</cfif>
</cfif>
</div>

<cfinclude template="includes/footers/Footer.cfm">

