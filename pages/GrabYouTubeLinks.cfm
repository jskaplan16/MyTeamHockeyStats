<cfset youtubeURL = "https://www.youtube.com/watch?v=6FOQU2wFR_o">

<!--- Fetch the YouTube video page --->
<cfhttp url="#youtubeURL#" method="get" result="youtubeResult" />

<!--- Define a regex pattern to find the iframe embed URL --->
<cfset pattern = '<iframe[^>]*src="([^"]+)"[^>]*>'>
<cfset embedURL = "">

<!--- Search the response for the iframe src --->
<cfif REFindNoCase(pattern, youtubeResult.FileContent, 1, "true")>
    <cfset regexResult = REMatchNoCase(pattern, youtubeResult.FileContent)>
    <cfif ArrayLen(regexResult) GT 0>
        <!--- Extract 'src' attribute from the <iframe> tag --->
        <cfset temp = regexResult[1]>
        <!--- Further extract only the URL inside src="..." --->
        <cfset embedURL = REReplace(temp, '.*src="([^"]+)".*', '\1')>
    </cfif>
</cfif>

<!--- Output embed URL --->
<cfoutput>
    YouTube Embed URL: #embedURL#
</cfoutput>