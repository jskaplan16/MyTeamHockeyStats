<cfif isDefined("showNavBar")  and showNavBar is not true>
<cfset attributes.showNavBar=false>

<cfelse>
<cfset attributes.showNavBar=True>
</cfif>
<cfparam name="form.showNavBar" default="#attributes.showNavBar#">
<cfinclude template="#application.includes#header.cfm">

<cfparam name="form.PlayerNumber" default="">
<cfparam name="form.Firstname" default="">
<cfparam name="form.Lastname" default="">


<cfparam name="url.Action" default="">
<cfparam name="form.action" default="Insert">
<cfparam name="form.PositionCode" default="">
<cfparam name="form.ShootingSide" default="">

<cfif isdefined("url.TeamSeasonId")>
   <cfset form.TeamSeasonId=url.TeamSeasonId>

<cfelseif isDefined("form.TeamSeasonId") and len(form.TeamSeasonId)>
    <cfset form.TeamSeasonId=form.TeamSeasonId>
  
<cfelse>
    <cfset form.TeamSeasonId=session.TeamSeasonId>
</cfif>

<cfif url.action is "edit" and isDefined("url.PlayerId")>

 <cfquery name="qPlayer" datasource="#application.datasource#">
            Select * from dbo.vRoster where PlayerId=#url.PlayerId# Order by PlayerNumber asc
    </cfquery>
	
        <cfset form.PlayerNumber=qPlayer.PlayerNumber>
        <cfset form.PlayerName=qPlayer.PlayerName>
        <cfset form.Firstname=qPlayer.FirstName>
        <cfset form.Lastname=qPlayer.LastName>
  
        <cfset form.TeamName = qPlayer.TeamName>
        <cfset form.PositionCode=qPlayer.PositionCode>
        <cfset form.ShootingSide=qPlayer.ShootingSide>
        <cfset form.PositionGeneral=qPlayer.PositionGeneral>
        </cfif>

<cfif isDefined("url.TeamId")>
 <cfset form.TeamId=url.TeamId>
</cfif>
   
	<cfquery name="qTeam" datasource="#application.datasource#">
	Select TeamId, TeamName from vTeam where TeamSeasonId=#form.TeamSeasonId# 
	</cfquery>
<cfset form.TeamName=qTeam.TeamName>
    
<br>
    <div class="form-container" style="width: 40%;background-color:antiquewhite;border:1px solid black;">
   
        <h2>Save Roster</h2>
         <cfoutput>
        <form name="#Application.actions#ActionSaveRoster" method="Post" action="#Application.actions#ActionSaveRoster.cfm">
       <cfif url.Action is "Edit">
        <input type="hidden" name="PlayerId" value="#url.PlayerId#">
        <input type="hidden" name="Action" value="#url.Action#">
        <cfelse>
        <input type="hidden" name="Action" value="Insert">
        </cfif>
             <table>
                <tr>
                    <td>Team Name:</td>
                    <td>                    
                    <label for="TeamSeasonId" style="color:black">#form.TeamName#</label>
                    <input type="hidden" name="TeamSeasonId" value="#form.TeamSeasonId#"> 
                </td>
                </tr>
               
                <tr>
                    <td>Player Number:</td>
                    <td>
                    <input type="text" name="PlayerNumber" value="#form.PlayerNumber#" style="width: 50px;">
                    <input type="hidden" name="showNavBar" value="#form.showNavBar#" required>
                    </td>
                </tr>
                <tr>
                    <td>Player Name:</td>
                    <td>
                    <label for="FirstName" style="color:black">First Name:</label>
                    <input type="text" name="FirstName" value="#form.FirstName#" class="inputFld" style="width: 150px;" required <cfif url.Action is "edit"> readonly</cfif>>
                    <label for="LastName" style="color:black">Last Name:</label>
                    <input type="text" name="LastName" value="#form.LastName#" class="inputFld" style="width: 150px;" required <cfif url.Action is "edit"> readonly</cfif>>
                    </td>
                </tr>
 
                </cfoutput>

       <cfquery name="qPosition" datasource="#application.datasource#">
           Select [PositionId]
      ,[PositionCode]
      ,[Position]
      ,[GeneralPosition]
      ,[PositionOrder]
      ,[LineAppOrder]
      ,[PositionGeneral]
      from tblPosition
            </cfquery>
            
    

                   <tr>
                    <td>Position Code</td>
                    <td>
           
                    <select name="PositionCode" required>
                     <option value="">Select Position Code</option>
                        <cfoutput  query="qPosition">
                            <option value="#PositionCode#" <cfif form.PositionCode is PositionCode> selected </cfif> >
                                #Position#
                            </option>   
                         </cfoutput>
                        </select>
                    
                    </td>
                </tr>

                 <tr>
                    <td>Shooting Side</td>
                    <td>
                    <select name="ShootingSide" required>
                        <option value="">Select Shooting Side</option>
                         <option value="L" <cfif form.ShootingSide is "L"> Selected </cfif>>Left Side</option>
                          <option value="R" <cfif form.ShootingSide is "R"> Selected </cfif>>Right Side</option>
                        </select>
                    
                    </td>
                </tr>
                

                <tr>
                    <td colspan="2" style="text-align:center;">
                        <input type="submit" value="Submit" <cfif not attributes.showNavBar> onclick="parent.document.getElementById('webModal_#TeamSeasonId#').close()" </cfif>>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <cfoutput>
<script>
    function refreshFormWithParam(teamId) {
        // Get the current URL without query parameters
        const baseUrl = "#application.displays#DisplayPlayerRoster.cfm";

        // Redirect to the same page with the selected TeamId as a parameter
        window.location.href = `${baseUrl}?TeamId=${teamId}`;
    }
</script>
</cfoutput>
    <br>
    <cfquery name="qTeamRoster" datasource="#application.datasource#">
                 Select PlayerId,
			PlayerName,
            TeamName,
            PositionGeneral,
            PositionCode,
            ShootingSide,
            PlayerNumber
            from vRoster r 
            where r.TeamSeasonId=#form.TeamSeasonId# 
            Order by PlayerNumber asc
        </cfquery>

        <cfif attributes.showNavBar is "true">
  <div class="form-container" style="width:40%;">
    <table class="table-responsive">
    <tr>
    <th style="width:150px;">
    Player Number
    </th>
    <th>
    Player Name
    </th>
    <th>Position </th>
    <th>Position Code</th>
    <th>ShootingSide</th>
    
<th>Action</th>
    </tr>
 
    <cfoutput query="qTeamRoster">
        <cfif qTeamRoster.currentRow mod 2 eq 0>
            <tr class="row-even">
        <cfelse>
            <tr class="row-odd">
        </cfif>
      
            <td class="tblCellLeft">#PlayerNumber#</td>    
            <td class="tblCellCenter">#PlayerName#</td>
             <td class="tblCellCenter">#PositionGeneral#</td>
            <td class="tblCellCenter">#PositionCode#</td>
         
            <td class="tblCellCenter">#ShootingSide#</td>

            <td class="tblCellCenter">
                <a href="#application.displays#DisplayPlayerRoster.cfm?Action=Edit&PlayerId=#PlayerId#&TeamSeasonId=#form.TeamSeasonId#" class="mainLink">Edit</a>
               <a href="#application.actions#ActionSaveRoster.cfm?Action=Delete&PlayerId=#PlayerId#&TeamSeasonId=#form.TeamSeasonId#" class="mainLink">Delete</a>
        </tr>
                   
        </cfoutput>
    </table>
    </div>
    </cfif>
<cfinclude template="#application.includes#footer.cfm">

              <!---                         <select name="TeamId" id="TeamId" <cfif url.action is "Edit">disabled</cfif> onchange="refreshFormWithParam(this.value)"> 
                        <select name="TeamId" id="TeamId" <cfif url.action is "Edit">disabled</cfif> >
                            <option value="">Select Team</option>
                            <cfoutput query="qTeam">
                                <option value="#TeamId#" <cfif form.TeamId is TeamId> selected </cfif> >
                                    #TeamName#
                                </option>
                            </cfoutput>
                        </select>
                        --->