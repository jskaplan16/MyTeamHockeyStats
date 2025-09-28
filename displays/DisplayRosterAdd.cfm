<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Dropdown</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <form id="myForm">
    <label>
      <input type="radio" name="option" value="16"> Option 1
    </label>
    <label>
      <input type="radio" name="option" value="3"> Option 2
    </label>

    <select id="myDropdown">
      <option value="">Please select an option</option>
    </select>
  </form>

  <script>
    $(document).ready(function () {
      $("input[name='option']").change(function () {
        const selectedValue = $(this).val();

        // Make AJAX request
        $.ajax({
          url: "getDropdownOptions.cfm", // URL of the ColdFusion script
          method: "POST",
          data: { option: selectedValue }, // Send the selected radio button value
          dataType: 'json', // Expect JSON response
          success: function (options) {
            // Populate the dropdown
            const dropdown = $("#myDropdown");
            dropdown.find('option:not(:first)').remove(); // Clear existing options except the first one
            options.forEach(function (item) {
              dropdown.append(new Option(item.text, item.value));
            });
          },
          error: function (xhr, status, error) {
            console.error("Error: ", error);
            alert("An error occurred while fetching options. Please try again.");
          }
        });
      });
    });
  </script>
</body>
</html>