// JavaScript file (script.js)

// Function to fetch data from the ColdFusion API and populate the table
async function fetchDataAndDisplay() {
    try {
        // Fetch data from the ColdFusion API
        const response = await fetch('getShifts.cfm');
        const shifts = await response.json();

        // Select the table body
        const tableBody = document.getElementById('data-table');

        // Clear existing table rows (if any)
        tableBody.innerHTML = '';

        // Populate the table with fetched data
        shifts.forEach(shift => {
            const row = `
                <tr>
                    <td>${shift.PlayerName}</td>
                </tr>`;
            tableBody.innerHTML += row;
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
}

// Call the function initially to load data
fetchDataAndDisplay();

// Optional: Auto-refresh data every 10 seconds without page reload
setInterval(fetchDataAndDisplay, 10000);
