<%-- 
    Document   : Home
    Created on : Sep 14, 2024, 10:08:31 PM
    Author     : Admin
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Location"%>
<%@page import="model.Airport"%>
<%@page import="dal.LocationDAO"%>
<%@page import="dal.AirportDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <title>Flight Booking Form</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <style>
            .flight-form {
                max-width: 1000px;
                margin: 50px auto;
                padding: 20px;
            }
            .flight-type {
                display: flex;
                align-items: center;
            }
            .form-control.read-only {
                background-color: #e9ecef;
                cursor: not-allowed;
            }
            .btn-search {
                background-color: #28a745;
                color: white;
                padding: 10px 20px;
                font-size: 18px;
            }
            .discount-code-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .discount-code-container input {
                width: 30%;
            }
            .icon {
                font-size: 24px;
                color: green;
            }
            .btn-search {
                width: 200px;
                font-size: 18px;
            }
            .location-list {
                max-height: 200px;
                overflow-y: auto;
            }

            .location-item:hover {
                background-color: #f0f0f0;
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %> 
        <div class="container flight-form">
            <%
                LocationDAO locationDao = new LocationDAO();
                AirportDAO airportDao = new AirportDAO();

            %>
            <h1 id="errorMessage"></h1> <!-- Display the error message here -->
            <form action="routeTicket" method="GET" class="row g-3" onsubmit="return validateLocations(event)">
                <!-- From and To Fields -->
                <div class="col-md-2">
                    <label for="from" class="form-label">Từ</label>
                    <!-- Visible Input for displaying the selected location - airport -->
                    <input type="text" class="form-control" id="fromDisplay" placeholder="Chọn điểm đi" onclick="showLocationList('from')" oninput="filterLocations('from')" required>

                    <!-- Hidden Input for storing the actual location ID -->
                    <input type="hidden" id="from" name="departure">

                    <!-- Custom dropdown list for locations -->
                    <div id="from-locations" class="location-list" style="display:none; position:absolute; background-color:white; border:1px solid #ccc; z-index:1000;">
                        <%                
                            for(Location l : locationDao.getAllLocation()) {
                                for(Airport a : airportDao.getAllAirport()){
                    
                                if(a.getLocationId() == l.getId()){
                        %>
                        <div class="location-item" onclick="selectLocation('<%= a.getId() %>', '<%= l.getName() %> - <%= a.getName() %>', 'from')"
                             style="padding: 5px; cursor: pointer;">
                            <!-- Style for the location name (clear and prominent) -->
                            <span style="font-weight: bold; font-size: 16px; color: black;">
                                <%= l.getName() %>
                            </span>

                            <!-- Style for the airport name (blurred and less prominent) -->
                            <span style="font-size: 14px; color: grey; filter: blur(1%); margin-left: 5px;">
                                <%= a.getName() %>
                            </span>
                        </div>
                        <% } } } %>
                    </div>
                </div>

                <div class="col-md-2">
                    <label for="to" class="form-label">Tới</label>
                    <!-- For destination -->
                    <input type="text" class="form-control" id="toDisplay" placeholder="Chọn điểm đến" onclick="showLocationList('to')" oninput="filterLocations('to')"  required>
                    <input type="hidden" id="to" name="destination">

                    <!-- Custom dropdown list for locations -->
                    <div id="to-locations" class="location-list" style="display:none; position:absolute; background-color:white; border:1px solid #ccc; z-index:1000;">
                        <%                
                            for(Location l : locationDao.getAllLocation()) {
                                for(Airport a : airportDao.getAllAirport()){
                    
                                if(a.getLocationId() == l.getId()){
                        %>
                        <div class="location-item" onclick="selectLocation('<%= a.getId() %>', '<%= l.getName() %> - <%= a.getName() %>', 'to')"
                             style="padding: 5px; cursor: pointer;">
                            <!-- Style for the location name (clear and prominent) -->
                            <span style="font-weight: bold; font-size: 16px; color: black;">
                                <%= l.getName() %>
                            </span>

                            <!-- Style for the airport name (blurred and less prominent) -->
                            <span style="font-size: 14px; color: grey; filter: blur(1%); margin-left: 5px;">
                                <%= a.getName() %>
                            </span>
                        </div>
                        <% } } } %>
                    </div>
                </div>

                <!-- Date Field -->
                <div class="col-md-2">
                    <label for="departureDate" class="form-label">Ngày đi</label>
                    <input type="date" class="form-control" id="departureDate" name="departureDate" required>
                </div>

                <!-- Passengers Field -->
                <div class="col-md-4">
                    <label for="passengers" class="form-label">Hành khách</label>
                    <input type="number" class="form-control" id="passengers" value="1" min="1" max="10" required onclick="togglePassengerOptions()" readonly>
                    <!-- Passenger Options Div -->
                    <div id="passenger-options" class="passenger-options" style="display: none; border: 2px solid #ccc; padding: 10px; border-radius: 5px; margin-top: 10px;">

                        <div style="display:flex;justify-content: space-evenly;margin-top: 1%">

                            <label for="adult-count">Người lớn:</label>
                            <input type="number" id="adult-count" name="adult" value="1" min="1" max="10">

                            <label for="child-count">Trẻ em(2-11 tuổi):</label>
                            <input type="number" id="child-count" name="child" value="0" min="0" max="9">

                            <label for="infant-count">Trẻ sơ sinh(0-2 tuổi):</label>
                            <input type="number" id="infant-count" name="infant" value="0" min="0" max="5">

                        </div>
                    </div>
                </div>



                <div class="col-md-2 text-end" style="margin-top:2.6%">
                    <button type="submit" class="btn btn-success">Tìm Chuyến Bay</button>
                </div>

            </form>



        </div>
        <%@include file="footer.jsp" %> 
        <!-- Bootstrap JS (optional for Bootstrap features) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script>
                        const passengersInput = document.getElementById('passengers');
                        const adultCountInput = document.getElementById('adult-count');
                        const childCountInput = document.getElementById('child-count');
                        const infantCountInput = document.getElementById('infant-count');
                        const passengerOptionsDiv = document.getElementById('passenger-options');

                        // Function to update total passengers
                        function updateTotalPassengers() {
                            const adults = parseInt(adultCountInput.value) || 0;
                            const children = parseInt(childCountInput.value) || 0;
                            const infants = parseInt(infantCountInput.value) || 0;
                            const totalPassengers = adults + children + infants;
                            passengersInput.value = totalPassengers;
                            // Validation checks
                            if (infants > adults) {
                                alert("The number of infants cannot exceed the number of adults.");
                                infantCountInput.value = adults; // Adjust infants to equal adults
                                passengersInput.value -= 1;
                                return;
                            }

                            if (totalPassengers > 10) {
                                alert("Total passengers cannot exceed 10.");
                                passengersInput.value = 10; // Set to max allowed
                                return; // Stop further processing
                            }

                            // If the total reaches 10, lock the ability to add more passengers
                            if (totalPassengers === 10) {
                                const remainingSpots = 10 - (adults + children + infants);
                                adultCountInput.max = adults; // Prevent increasing adults
                                childCountInput.max = children; // Prevent increasing children
                                infantCountInput.max = infants; // Prevent increasing infants
                            } else {
                                // Allow to increase if total passengers < 10
                                adultCountInput.max = Math.min(10 - (children + infants), 10);
                                childCountInput.max = Math.min(10 - (adults + infants), 9); // Assume max 9 children
                                infantCountInput.max = Math.min(10 - (adults + children), 5); // Assume max 5 infants
                            }

                        }

                        // Event listeners for the input fields
                        adultCountInput.addEventListener('input', updateTotalPassengers);
                        childCountInput.addEventListener('input', updateTotalPassengers);
                        infantCountInput.addEventListener('input', updateTotalPassengers);

                        // Show passenger options when the main input is focused
                        passengersInput.addEventListener('focus', () => {
                            passengerOptionsDiv.style.display = 'block';
                        });


                        // Show options when focusing on the main input
                        passengersInput.addEventListener('focus', () => {
                            passengerOptionsDiv.style.display = "block";
                        });

                        // Hide options when clicking outside the input and options
                        document.addEventListener('click', (event) => {
                            const isClickInsideOptions = passengerOptionsDiv.contains(event.target);
                            const isClickOnInput = event.target === passengersInput;

                            if (!isClickInsideOptions && !isClickOnInput) {
                                passengerOptionsDiv.style.display = "none"; // Hide if click is outside
                            }
                        });

                        function showLocationList(inputId) {
                            // Hide all location lists first
                            hideAllLocationLists();

                            // Display the current location list for the clicked input
                            document.getElementById(inputId + '-locations').style.display = 'block';
                        }

                        function hideAllLocationLists() {
                            // Get all location lists and hide them
                            const locationLists = document.querySelectorAll('.location-list');
                            locationLists.forEach(list => {
                                list.style.display = 'none';
                            });
                        }

                        function selectLocation(locationId, displayText, inputId) {
                            // Set the visible input value to the selected location - airport text
                            document.getElementById(inputId + 'Display').value = displayText;

                            // Set the hidden input value to the selected locationId
                            document.getElementById(inputId).value = locationId;

                            // Hide the location list after selection
                            document.getElementById(inputId + '-locations').style.display = 'none';


                        }

                        // Filter locations based on input value
                        function filterLocations(type) {
                            const input = document.getElementById(type + 'Display');
                            const filter = input.value.toLowerCase();
                            const locationList = document.getElementById(type + '-locations');
                            const items = locationList.getElementsByClassName('location-item');

                            // Loop through all items and hide those that don't match the input
                            for (let i = 0; i < items.length; i++) {
                                const txtValue = items[i].textContent || items[i].innerText;
                                if (txtValue.toLowerCase().indexOf(filter) > -1) {
                                    items[i].style.display = "";
                                } else {
                                    items[i].style.display = "none";
                                }
                            }

                            // Show the location list only if there are items visible
                            if (filter.length > 0) {
                                locationList.style.display = 'block';
                            } else {
                                locationList.style.display = 'none';
                            }
                        }


                        // Hide the list if the user clicks outside of the input or list
                        document.addEventListener('click', function (event) {
                            // If the clicked element is not an from or to or part of the location list, hide all lists
                            if (!event.target.closest('.location-list') && !event.target.closest('#fromDisplay') && !event.target.closest('#toDisplay')) {
                                document.querySelectorAll('.location-list').forEach(list => {
                                    list.style.display = 'none';
                                });
                            }
                        });
                        function validateLocations(event) {
                            const departure = document.getElementById('fromDisplay').value;
                            const destination = document.getElementById('toDisplay').value;
                            const errorMessageElement = document.getElementById('errorMessage');

                            // Check if departure and destination are the same
                            if (departure === destination) {
                                event.preventDefault(); // Prevent form submission

                                // Display error message
                                errorMessageElement.textContent = "Điểm đi và điểm đến không được giống nhau.";
                                errorMessageElement.style.color = "red"; // Optional: Add styling to the error message

                                return false; // Prevent the form from submitting
                            }

                            // Clear the error message if validation passes
                            errorMessageElement.textContent = "";
                            return true; // Allow form submission if locations are different
                        }

        </script>

    </body>
</html>




