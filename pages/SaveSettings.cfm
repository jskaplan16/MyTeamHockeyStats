<cfquery  datasource="#application.datasource#" name="qSettingsUpdate">
    EXEC stpUpdateSettings 
        @TeamSeasonId=#session.TeamSeasonId#,
        @SettingName='GameDuration',
        @SettingValue='#form.GameDuration#'
    
</cfquery>