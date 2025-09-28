<CF_BaseHeader showHeader="false" useHeader="false">
<cfquery  dbtype="query" name="getUser">
    select teamSeasonId, teamName,FullTeamName
    from session.getUser
</cfquery>
<div>



        <dialog id="webModal">
            <div style="text-align: right;">
                <div class="module-box">
                    <div style="text-align: left;font-weight:bold;color:white;">Switch Teams:</div>
                    <cfoutput>
                    <form method="post" action="#application.actions#ActionMultiTeamLogin.cfm">
                    </cfoutput>
                        <cfoutput>
                        <select name="TeamSeasonId" onchange="this.form.submit()" style="width:400px;" size="#getUser.recordcount#">
                            </cfoutput>
                            <cfoutput query="getUser">
                                <option value="#teamSeasonId#">#FullteamName#</option>
                            </cfoutput>
                        </select>
                    </form>
                </div>
            </div>
        </dialog>
</div>
        <script>
            // Open the modal dialog
            document.getElementById('webModal').showModal();
            // Close the modal dialog when clicked outside
            </script>


</CF_BaseHeader>
<cfsetting showdebugoutput="false">