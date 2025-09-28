<!-- Search for products -->
<cfscript>
    searchText = "Jr"; // The text to search for
    results = ORMSearch(
        searchText,             // The text to search
        "teams",              // The entity name (CFC)
        ["TeamName", "BirthYear"],// Fields to search in
        { maxResults = 10 }     // Additional options (e.g., limit results)
    );
</cfscript>

<!-- Output the results -->

<h2>Search Results:</h2>
<cfdump var="#results#">