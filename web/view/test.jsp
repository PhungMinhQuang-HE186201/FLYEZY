<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Flight Management</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                var countries   
                        = {
                            "Vietnam": ["Ha Noi", "Da Nang", "Ho Chi Minh City"] // Sample locations and airports for Vietnam
                                    // Add other countries and their corresponding locations/airports here
                        };

                $("#departureCountry").change(function () {
                    var selectedCountry = $(this).val();
                    var locationOptions = "";

                    if (selectedCountry) {
                        var locations = countries[selectedCountry];

                        if (locations) {
                            locations.forEach(function (location) {
                                locationOptions += "<option value='" + location + "'>" + location + "</option>";
                            });
                        } else {
                            locationOptions = "<option value=''>No locations available</option>";
                        }

                        $("#departureLocation").html(locationOptions);

                        // Update airport options based on selected location (if data available)
                        updateAirportOptions(selectedCountry, $("#departureLocation").val());
                    } else {
                        $("#departureLocation").empty();
                        $("#departureAirport").empty(); // Clear airport options as well
                    }
                });

                $("#departureLocation").change(function () {
                    var selectedCountry = $("#departureCountry").val();
                    updateAirportOptions(selectedCountry, $(this).val());
                });

                function updateAirportOptions(country, location) {
                    // Assuming airports are associated with locations (modify as needed)
                    var airportOptions = "";
                    var airports = countries[country]; // Access country data again

                    if (airports && location) {
                        var locationAirports = airports.filter(function (airport) {
                            // Replace with logic to identify airports based on location (if data structure is different)
                            return airport.startsWith(location); // Sample filtering based on location prefix (improve as needed)
                        });

                        if (locationAirports.length > 0) {
                            locationAirports.forEach(function (airport) {
                                airportOptions += "<option value='" + airport + "'>" + airport + "</option>";
                            });
                        } else {
                            airportOptions = "<option value=''>No airports available for this location</option>";
                        }
                    } else {
                        airportOptions = "<option value=''>Select location first</option>";
                    }

                    $("#departureAirport").html(airportOptions);
                }
            });
        </script>
    </head>
    <body>
        <form>
            <label for="departureCountry">Departure Country:</label>
            <select id="departureCountry">
                <option value="">Select Country</option>
                <option value="Vietnam">Vietnam</option>
            </select>

            <label for="departureLocation">Departure Location:</label>
            <select id="departureLocation"></select>

            <label for="departureAirport">Departure Airport:</label>
            <select id="departureAirport"></select>

            <button type="submit">Add Flight</button>
        </form>
    </body>
</html>