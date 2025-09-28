<input type="text" id="searchTeamText" name="searchTeamText" value="" style="width: 300px;" />
<input type="hidden" id="teamSeasonId" name="teamSeasonId" value="0" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/devbridge-autocomplete@1.4.11/dist/jquery.autocomplete.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/devbridge-autocomplete@1.4.11/dist/jquery.autocomplete.css">
<style>
<style>
.autocomplete-suggestions {
  background:lightgrey;
  color: #fff;
  border: 1px solid black;
  text-transform: uppercase;
  font-size: 12px;
  text-align: left;
}
.autocomplete-suggestion {
  background: lightgrey;
  color: #000;
   padding: 8px 12px; 
   text-transform: uppercase;
    font-size: 12px;
      text-align: left;
}
.autocomplete-suggestion:not(:last-child) {
  border-bottom: 1px solid #ddd; /* Light gray border between items */
  text-align: left;
}

.autocomplete-selected {
  background: #000000;
  color: white;
  border: 1px solid #000;
  text-transform: uppercase;
   font-size: 12px;
     text-align: left;
}
</style>

<script>
$(function() {
  $('#searchTeamText').autocomplete({
    serviceUrl: 'ajax_searchTeams.cfm',
    onSelect: function (suggestion) {
      $('#teamSeasonId').val(suggestion.data);
    }
  });

  $('#searchTeamText').blur(function() {
    if ($('#searchTeamText').val() === '') {
      $('#teamSeasonId').val('0');
    }
  });
});
</script>


<cfsetting showdebugoutput="false" enablecfoutputonly="true">