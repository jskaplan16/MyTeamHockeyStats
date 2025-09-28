<cfparam name="url.Step" default="Default">
<cfinclude template="includes/headers/Header.cfm">
    <div class="PageHeader">
    <cfoutput >
      #session.TeamName#  - Add Shifts	
       </cfoutput>
    </div>
<cfswitch expression="#url.step#">
<cfcase value="default">
    <div>Map a single game</div>
        <a href="ShiftMapper.cfm?Step=SelectGame">Map Game</a>    
</cfcase>

<cfcase value="SelectGame">
    <cf_ctrSelectGame ActionPage="ShiftMapper.cfm"  Nextstep="MapGame" action="edit">
</cfcase>
<cfcase value="MapGame">

<cfquery name="qGames"  datasource="#application.datasource#">
  Select GamevideoId  from tblGame where GameId=#form.GameId#
</cfquery>

<cfquery name="qRoster"  datasource="#application.datasource#">
  Select PlayerNumber,PlayerId, Convert(varchar,PlayerNumber) + ' ' + PlayerName as PlayerName from vRoster where TeamSeasonId=#session.TeamSeasonId# Order by PlayerNumber
</cfquery>

<cfquery name="qLastStart" datasource="#application.datasource#">
  SELECT top 1 
       MaxShift,
       MaxPeriod
  FROM vShift 
  where GameId=#form.gameId#
  Order by RowInsert Desc 
</cfquery>



   <form method="post" action="SaveShift.cfm" onsubmit="return false;">
   
        
  <cfif len(qLastStart.MaxShift)>
  <cfset maxShift=qLastStart.MaxShift>
  <cfelse>
  <cfset maxShift=0>
  </cfif>

    <cf_ClipSelector GameId="#form.GameId#" GoalOffset="#MaxShift#" action="edit">
   
   <div class="row-odd" style="padding: 15px;">Period 
    <input type="radio" name="Per" id="Period" value="1" <cfif qLastStart.MaxPeriod is 1> checked </cfif>>1
    <input type="radio" name="Per" id="Period" value="2" <cfif qLastStart.MaxPeriod is 2> checked </cfif>>2
    <input type="radio" name="Per" id="period" value="3" <cfif qLastStart.MaxPeriod is 3> checked </cfif>>3
    <input type="radio" name="Per" id="Period" value="4" <cfif qLastStart.MaxPeriod is 4> checked </cfif>>4
  </div>

  

  <div id="shiftContainer">
    <button id="addShift">Add Shift</button>
  </div>

</form> 





  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const shiftContainer = document.getElementById('shiftContainer');
      const addShiftButton = document.getElementById('addShift');
      const addRefreshButton = document.getElementById('refreshTable');
            fetchShifts(); // fetch shifts when the page loads

      const players = [
         { id: -1 , name:'Ice Stoppage'},
        <cfoutput query="qRoster">
      { id: #qRoster.PlayerId#, name: '#PlayerName#' } 
      <cfif qRoster.CurrentRow neq qRoster.RecordCount> , </cfif>
        </cfoutput>];

      addShiftButton.addEventListener('click', function() {
        // Create a new shift div
        const shiftDiv = document.createElement('div');
        shiftDiv.classList.add('row-even');

        // Create player dropdown
        const playerSelect = document.createElement('select');
        playerSelect.style.width = '200px';  
        const existingShifts = document.querySelectorAll('.shift-div');
        const isEven = existingShifts.length % 2 === 0;
        shiftDiv.classList.add('shift-div'); // general class
        shiftDiv.classList.add(isEven ? 'row-even' : 'row-odd');      
        players.forEach(player => {
          const option = document.createElement('option');
          option.value = player.id; // Use playerId as the value
          option.textContent = player.name; // Use player name as the display text
                   //
          playerSelect.appendChild(option);

        });


        // Create start time input and "Set Time" button
        const startTimeInput = document.createElement('input');
        startTimeInput.type = 'text';
        startTimeInput.placeholder = 'Start Time';
        startTimeInput.style.width = '100px';

        const setStartTimeButton = document.createElement('button');
        setStartTimeButton.textContent = 'SET START';
        setStartTimeButton.style.width = '100px';
        setStartTimeButton.addEventListener('click', function() {
          startTimeInput.value = document.getElementById('currentTimeField').value;
        });

        // Create end time input and "Set Time" button
        const endTimeInput = document.createElement('input');
        endTimeInput.type = 'text';
         endTimeInput.style.width = '100px';
        endTimeInput.placeholder = 'End Time';

        const setEndTimeButton = document.createElement('button');
        setEndTimeButton.textContent = 'SET END';
        setEndTimeButton.style = '100px';

        setEndTimeButton.addEventListener('click', function() {
          endTimeInput.value = document.getElementById('currentTimeField').value;
        });

        

     // Create end time input and "Set Time" button
        const label = document.createElement('label');
        label.textContent = 'Shots:';

        const shots = document.createElement('input');
        shots.type = 'number';
        shots.style.width = '50px';
        shots.placeholder = 'Shots';
        shots.value=0;

        // Create remove button
        const removeButton = document.createElement('button');
        removeButton.textContent = 'Remove';
        removeButton.addEventListener('click', function() {
          shiftContainer.removeChild(shiftDiv);
          
        });


const submitButton = document.createElement('button');
        submitButton.textContent = 'Submit Row';
        let rowCounter = 0; // Initialize a counter for unique IDs
               const uniqueRowId = `row-${rowCounter++}`;
submitButton.setAttribute('data-row-id', uniqueRowId);
       
      
        submitButton.addEventListener('click', function() {
     
selectedPeriod = document.querySelector('input[name="Per"]:checked');
          // Collect data from this row
          const rowData = {
            playerId: playerSelect.value,
            startTime: startTimeInput.value,
            endTime: endTimeInput.value,
            gameId: <cfoutput>#form.GameId#,</cfoutput>
            shots: parseInt(shots.value,10) || 0 ,    
            rowId: uniqueRowId, // Include the unique identifier in the data   
            period: parseInt(selectedPeriod.value,10) || 0 
            };

          // Send data to backend using fetch API
          fetch('SaveShift.cfm', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(rowData)
          })
          .then(response => response.json())
          .then(data => {
            console.log('Row submitted successfully:', data);
           // alert('Row submitted successfully!');
          })
          .catch(error => {
            console.error('Error submitting row:', error);
           // alert('Failed to submit row.');
          });
          removeButton.click();
          fetchShifts();
        });

  
        

        // Append all elements to the shift div
        shiftDiv.appendChild(playerSelect);
        shiftDiv.appendChild(startTimeInput);
        shiftDiv.appendChild(setStartTimeButton);
        shiftDiv.appendChild(endTimeInput);
        shiftDiv.appendChild(setEndTimeButton);
        shiftDiv.appendChild(label);
        shiftDiv.appendChild(shots);
        //shiftDiv.appendChild(periodInput);
        shiftDiv.appendChild(submitButton);
        shiftDiv.appendChild(removeButton);
        // Insert the new shift div before the "Add Shift" button
        shiftContainer.insertBefore(shiftDiv, addShiftButton);
        
        fetchShifts();
      });
    });

//seekToTime(120)

    async function fetchShifts() {
  try {
    // Fetch data from the server
    const response = await fetch('getShifts.cfm?GameId=<cfoutput>#form.gameId#</cfoutput>', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    });
   
    // Parse JSON response
    const shifts = await response.json();

    // Log and validate response type
    console.log('Fetched data:', shifts);

    if (!Array.isArray(shifts)) {
      console.error('Error: Expected an array but received:', shifts);
      return; // Exit if data is not an array
    }
    const tableBody = document.getElementById('data-table');
     tableBody.innerHTML = '';
    // Select the table body
   shifts.forEach((shift, index) => {
    const row = document.createElement('tr');
    row.classList.add(index % 2 === 0 ? 'row-even' : 'row-odd');

    const playerNameCell = document.createElement('td');
    playerNameCell.textContent = shift.PlayerName;
    row.appendChild(playerNameCell);

    const secondsOnIceCell = document.createElement('td');
    secondsOnIceCell.textContent = shift.SecondsOnIce;
    row.appendChild(secondsOnIceCell);

    const startCell = document.createElement('td');
    startCell.textContent = shift.StartShift;
    row.appendChild(startCell);

    const endCell = document.createElement('td');
    endCell.textContent = shift.EndShift;
    row.appendChild(endCell);

    const shotsCell = document.createElement('td');
    shotsCell.textContent = shift.Shots;
    row.appendChild(shotsCell);

    const periodCell = document.createElement('td');
    periodCell.textContent = shift.Period;
    row.appendChild(periodCell);

    const showClipButtonCell = document.createElement('td');
    const showClipButton = document.createElement('button');
    showClipButton.textContent = 'Review';
    showClipButton.addEventListener('click', function() {
        seekAfterBuffering(shift.StartShift);
    });
    showClipButtonCell.appendChild(showClipButton);
    row.appendChild(showClipButtonCell);

    const deleteButtonCell = document.createElement('td');
    const deleteButton = document.createElement('button');
    deleteButton.textContent = 'Delete';
    deleteButton.addEventListener('click', () => {
        const rowData = { ShiftMapperId: shift.ShiftMapperId };
        fetch('deleteShift.cfm', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(rowData)
        })
        .then(response => response.json())
        .then(data => {
            console.log('Row submitted successfully:', data);
            

        })
        .catch(error => {
            console.error('Error submitting row:', error);
        });
        tableBody.innerHTML = '';
        fetchShifts();
    });
    deleteButtonCell.appendChild(deleteButton);
    row.appendChild(deleteButtonCell);

    tableBody.appendChild(row);
});

  } catch (error) {
    console.error('Error fetching data:', error);
  }
}


      
</script>




  

    <table border="1">
        <thead>
            <tr>
                <th>Player Name</th>
                <th style="width: 25;">Ice Time</th>
                <th style="width: 25;">Start Time</th>
                <th style="width: 25;">End Time</th>
                <th style="width: 25;">Shots</th>
                <th style="width: 25;">Period</th>
                <th style="width: 25;">Review Clip</th>
                <th style="width: 50px;">Delete</th>
             
            </tr>
        </thead>
        <tbody id="data-table">
            <!-- Data will be dynamically inserted here -->
        </tbody>
    </table>




</cfcase>

    

</cfswitch>

<cfinclude template="includes/footers/Footer.cfm">