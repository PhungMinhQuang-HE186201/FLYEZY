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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <!-- Bootstrap Datepicker CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
        <!-- Bootstrap JS (optional for Bootstrap features) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            .flight-form {
                position: relative;
                z-index: 10;
            }

            .banner {
                position: relative;
                overflow: hidden;
                color: white;
                width: 100%;
                height: 800px;
            }

            .banner video {
                position: absolute;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                object-fit: cover;
                z-index: 1;
            }

            #input-form {
                position: relative;
                z-index: 10;
                top: 45%
            }


            .form-container {
                border: 2px solid #ccc;
                padding: 2%;
                background-color: #f9f9f9;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                height: 210px;
                width: 70%;
                border-radius: 6px
            }

            .location-list {
                display: none;
                position: absolute;
                background-color: white;
                border: 1px solid #ccc;
                z-index: 1000;
                width: 250px;
                height: 153px;
                overflow-y: auto;
                top: 80px;
                left: 14px;
                border-radius: 8px;
            }

            .location-item {
                cursor: pointer;
                padding: 10px 15px;
                transition: background-color 0.3s ease;
            }

            .location-item:hover {
                background-color: #f0f0f0;
            }

            .location-item span {
                transition: color 0.3s ease, filter 0.3s ease;
            }

            .passenger-label {
                color: #3C6E57;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 5px;
            }
            .passenger-selector {
                background-color: white;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 20px;
                display: flex;
                justify-content: space-between;
                width: 100%;
                max-width: 600px;
            }
            .passenger-type {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 33%;
            }
            .passenger-input {
                color: activecaption;
                height: 50%;
                width: 40%;
                font-size: 18px;
            }
            .passenger-controls{
                display: flex;
            }
            .options-container {
                margin-top: 30px;
                width: 400px;
                height: auto;
                border-radius: 5px;
            }
            .passenger-count {
                color: #3C6E57;
                font-size: 20px;
                font-weight: bold;
                width: 55px;
                border: 2px solid;
                border-radius: 5px;
                text-align: center;
                margin: 0 10px;
            }

            .search-button {
                height: 100%;
                margin-top: 18px;
                width: 165px;
                font-size: 18px;
                color: #3C6E57;
                background-color: white;
                border: 2px solid #3C6E57;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .search-button:hover {
                color: white;
                background-color: #3C6E57;
            }

        </style>
    </head>
    <body>
        <%
            LocationDAO locationDao = new LocationDAO();
            AirportDAO airportDao = new AirportDAO();
        %>
        <%@include file="header.jsp" %> 
        <section>
            <div class="flight-form">
                <div class="banner" id="banner">
                    <video src="vid/bg-vid.mp4" muted loop autoplay></video>

                    <form id="input-form" action="flightTickets" method="GET" class="row g-1" onsubmit="return validateLocations(event)">
                        <div style="background-image: url('../img/modal-footer.png')"></div>
                        <div class="form-container" style="margin: 0 auto">
                            <div class="row form-input">
                                <div style="display: flex; margin-bottom: 20px">
                                    <div style="display: flex; align-items: center; font-size: 16px; margin-right: 20px">
                                        <input type="radio" id="oneWay" name="flightType" value="oneWay" style="transform: scale(1.5);" checked onclick="toggleReturnDate()">
                                        <label for="oneWay" style="color: black;margin: 0; margin-left: 10px">One-way</label>
                                    </div>
                                    <div style="display: flex; align-items: center; font-size: 16px">
                                        <input type="radio" id="roundTrip" name="flightType" value="roundTrip" style="transform: scale(1.5);" onclick="toggleReturnDate()">
                                        <label for="roundTrip" style="color: black;margin: 0; margin-left: 10px">Round-trip</label>
                                    </div>
                                </div>
                                <h3 id="errorMessage" style="color: red;margin-bottom: 10px"></h3> 
                                <div class="row" style="height: 55px">
                                    <!-- From Field -->
                                    <div class="col-md-2" style="padding-right: 0px">
                                        <p style="color: black; margin: 0; font-size: 12px">FROM</p>
                                        <input type="text" style="height: 100%;font-size: 18px" class="form-control" id="fromDisplay" onclick="showLocationList('from')" oninput="filterLocations('from')" placeholder="FROM" required>
                                        <input type="hidden" id="from" name="departure">
                                        <div id="from-locations" class="location-list">
                                            <%                
                                                for(Location l : locationDao.getAllLocation()) {
                                                    for(Airport a : airportDao.getAllAirport()){
                                                        if(a.getLocationId() == l.getId()){
                                            %>
                                            <div class="location-item" onclick="selectLocation('<%= a.getId() %>', '<%= l.getName() %>', 'from')">
                                                <span style="font-weight: bold; font-size: 16px; color: black;">
                                                    <%= l.getName() %>
                                                </span></br>
                                                <span style="font-size: 14px; color: grey; filter: blur(1%);">
                                                    <%= a.getName() %>
                                                </span>
                                            </div>
                                            <% } } } %>
                                        </div>
                                    </div>

                                    <!-- To Field -->
                                    <div class="col-md-2" style="padding-right: 0px">
                                        <p style="color: black; margin: 0; font-size: 12px">TO</p>
                                        <input type="text" style="height: 100%;font-size: 18px" class="form-control" id="toDisplay" onclick="showLocationList('to')" oninput="filterLocations('to')" placeholder="TO" required>
                                        <input type="hidden" id="to" name="destination">
                                        <div id="to-locations" class="location-list">
                                            <%                
                                                for(Location l : locationDao.getAllLocation()) {
                                                    for(Airport a : airportDao.getAllAirport()){
                                                        if(a.getLocationId() == l.getId()){
                                            %>
                                            <div class="location-item" onclick="selectLocation('<%= a.getId() %>', '<%= l.getName() %>', 'to')">
                                                <span style="font-weight: bold; font-size: 16px; color: black;">
                                                    <%= l.getName() %>
                                                </span></br>
                                                <span style="font-size: 14px; color: grey; filter: blur(1%);">
                                                    <%= a.getName() %>
                                                </span>
                                            </div>
                                            <% } } } %>
                                        </div>
                                    </div>

                                    <!-- Departure Date Field -->
                                    <div class="col-md-2" style="padding-right: 0px">
                                        <p style="color: black; margin: 0; font-size: 12px">DEPART</p>
                                        <input type="text" class="form-control" id="departureDate" name="departureDate" style="height: 100%;font-size: 18px;" placeholder="yyyy-mm-dd" required>
                                    </div>
                                    <div class="col-md-2" id="returnDateField" style="display:none;padding-right: 0px">
                                        <p style="color: black; margin: 0; font-size: 12px">RETURN</p>
                                        <input type="text" id="returnDate" class="form-control" name="returnDate" style="height: 100%;font-size: 18px;" placeholder="yyyy-mm-dd">
                                    </div>

                                    <!-- Passengers Field -->
                                    <div class="col-md-4" id="passengerField" style="position: relative; padding-right: 0;">
                                        <p style="color: black; margin: 0; font-size: 12px">PASSENGER</p>
                                        <input type="number" class="form-control" id="passengers" value="1" min="1" max="10" required readonly 
                                               onclick="togglePassengerOptions()"
                                               style="height: 100%; width: 100%; font-size: 18px;">

                                        <div id="passenger-options" class="passenger-options" 
                                             style="display: none; position: absolute; top: 50px; left: 15px; z-index: 1000;">
                                            <div class="options-container" style="border: 2px solid #ccc">
                                                <div class="passenger-selector">
                                                    <div class="passenger-type">
                                                        <div class="passenger-label">Adult</div>
                                                        <div class="passenger-controls">
                                                            <input type="number" id="adult-count" class="passenger-count" name="adult" value="1" min="1" max="10" class="passenger-input">
                                                        </div>
                                                    </div>
                                                    <div class="passenger-type">
                                                        <div class="passenger-label">Children</div>
                                                        <div class="passenger-controls">
                                                            <input type="number"id="child-count" class="passenger-count" name="child" value="0" min="0" max="9" class="passenger-input">
                                                        </div>
                                                        <div class="age-range">2-11 Year Olds</div>
                                                    </div>
                                                    <div class="passenger-type">
                                                        <div class="passenger-label">Infant</div>
                                                        <div class="passenger-controls">
                                                            <input type="number" id="infant-count" class="passenger-count" name="infant" value="0" min="0" max="5" class="passenger-input">
                                                        </div>
                                                        <div class="age-range">0-2 Year Olds</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="col-md-2">
                                        <button type="submit" class="search-button" onclick="validateDates()">Search Flights</button>
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <%@include file="footer.jsp" %> 

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
                    errorMessageElement.textContent = "Duplicate departure and destination";
                    errorMessageElement.style.color = "red";

                    return false; // Prevent the form from submitting
                }

                // Clear the error message if validation passes
                errorMessageElement.textContent = "";
                return true; // Allow form submission if locations are different
            }
            function toggleReturnDate() {
                const returnDateField = document.getElementById("returnDateField");
                const returnDateInput = document.getElementById("returnDate");
                const flightType = document.querySelector('input[name="flightType"]:checked').value; // Get the value of the selected trip type
                const passengerField = document.getElementById("passengerField");

                // If "Khứ hồi" is selected, display the "Ngày về" field
                if (flightType === "roundTrip") {
                    returnDateField.style.display = "block";
                    passengerField.className = "col-md-2"; // Set passengers field to col-md-2
                    returnDateInput.setAttribute("required", "required");
                } else if (flightType === "oneWay") {
                    returnDateField.style.display = "none";
                    passengerField.className = "col-md-4"; // Set passengers field to col-md-4
                    returnDateInput.removeAttribute("required");
                }
            }
            // Assuming you have jQuery and Bootstrap Datepicker included
            $(document).ready(function () {
                // Initialize datepicker for departureDate
                $('#departureDate').datepicker({
                    format: 'yyyy-mm-dd', // Custom date format
                    autoclose: true, // Automatically close the calendar after picking a date
                    todayHighlight: true, // Highlight today's date
                    orientation: 'bottom auto', // Ensure the calendar pops up below the input
                    startDate: '2024-10-01' // Minimum date is 01/10/2024
                }).on('changeDate', function (selected) {
                    // Get the selected departure date
                    var minReturnDate = new Date(selected.date.valueOf());
                    minReturnDate.setDate(minReturnDate.getDate()); // Set the return date to be at least one day after the departure

                    // Set the minimum date for returnDate
                    $('#returnDate').datepicker('setStartDate', minReturnDate);
                    // If return date is before the new minimum, clear it
                    if ($('#returnDate').datepicker('getDate') && $('#returnDate').datepicker('getDate') < minReturnDate) {
                        $('#returnDate').datepicker('clearDates');
                    }
                });

                // Initialize datepicker for returnDate
                $('#returnDate').datepicker({
                    format: 'yyyy-mm-dd', // Custom date format
                    autoclose: true, // Automatically close the calendar after picking a date
                    todayHighlight: true, // Highlight today's date
                    orientation: 'bottom auto', // Ensure the calendar pops up below the input
                    startDate: '2024-10-01' // Default minimum date for return (will change based on departure)
                });
            });

            // Call toggleReturnDate on page load to handle default states
            document.addEventListener('DOMContentLoaded', toggleReturnDate);

            // Ensure to bind the toggleReturnDate to the radio buttons' change event
            document.getElementById("oneWay").addEventListener('change', toggleReturnDate);
            document.getElementById("roundTrip").addEventListener('change', toggleReturnDate);
            function validateDates() {
                const departureDate = document.getElementById('departureDate').value;
                const returnDate = document.getElementById('returnDate').value;

                // Proceed only if both dates are provided
                if (departureDate && returnDate) {
                    const depDate = new Date(departureDate);
                    const retDate = new Date(returnDate);

                    // Check if the departure date is after the return date
                    if (depDate > retDate) {
                        event.preventDefault();
                        alert("Ngày đi phải trước ngày về.");
                        return false; // Prevent form submission
                    }
                }

                // Allow form submission if validation passes
                return true;
            }

            // Optional: Toggle the return date field based on departure date selection
            document.getElementById('departureDate').addEventListener('change', function () {
                const returnDateField = document.getElementById('returnDateField');
                returnDateField.style.display = this.value ? 'block' : 'none';
            });


        </script>


        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

        <!-- Bootstrap Datepicker JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    </body>
</html>




