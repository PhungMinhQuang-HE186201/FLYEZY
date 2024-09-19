<%-- 
    Document   : AirlineManage
    Created on : Sep 15, 2024, 9:45:43 PM
    Author     : PMQUANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Airline"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>  
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Phương tiện</title>
        <link rel="shortcut icon" type="image/jpg" href="image/logo-icon.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    </head>
    <body>

        <div class="container" style="display: flex; justify-content: space-between; align-items: center; margin-top: 2%;">
            <!-- Search bar -->
            <div style="flex: 1; max-width: 60%; display: flex; align-items: center; margin-right: 5%;">
                <form action="airlineController" method="GET" style="display: flex; width: 50%; align-items: center;">
                    <input type="hidden" name="search" value="searchByName">
                    <input type="text" placeholder="Airline Name..." name="keyword" style="flex: 1; padding: 2%; border-radius: 0.5%; border: 0.1% solid #ddd;"/>
                    <input type="submit" name="submit" value="Search">
                    <input type="reset" value="Clear">
                    <input type="hidden" name="service" value="listStaff">
                </form>
            </div>

            <!-- Trigger the modal with a button -->
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addAirline" style="flex-shrink: 0;">
                Add Airline
            </button>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="addAirline" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addBookModalLabel">Add Airline</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addProductForm" action="airlineManagement" method="POST">
                            <input type="hidden" name="action" value="add">
                            <!-- Name -->
                            <div class="form-group">
                                <label for="nameInput">Airline Name:</label>
                                <input type="text" class="form-control" id="nameInput" name="airlineName" required>
                                <div id="nameError" class="error"></div>
                            </div>

                            <!-- Image -->
                            <div class="form-group">
                                <label for="imageInput">Image URL:</label>
                                <input type="file" class="form-control-file" id="image" name="airlineImage" onchange="displayImage(this)" required>
                                <div id="imageError" class="error"></div>
                            </div>
                            <img id="previewImage" src="#" alt="Preview"
                                 style="display: none; max-width: 300px; max-height: 300px;">

                            <!-- Baggage Checkbox -->
                            <div class="form-group">
                                <label>
                                    <input type="checkbox" id="hasBaggageCheckbox" name="hasBaggage" onchange="toggleBaggageInputs()"> Do you want to add baggages?
                                </label>
                            </div>

                            <!-- Baggage Inputs -->
                            <input type="hidden" name="airlineId" value="${maxAirlineId}">
                            <div id="baggageInputs" style="display: none;">
                                <!-- Container for dynamic baggage inputs -->
                                <div id="baggageContainer"></div>

                                <!-- Button to add baggage -->
                                <button type="button" class="btn btn-secondary" onclick="addBaggageInput()">Add Baggage</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" form="addProductForm">Add</button>
                    </div>

                </div>
            </div>
        </div>

        <div id="main-content">
            <div class="row" style="padding: 50px 0; margin: 0">

                <div class="col-md-10" id="left-column">
                    <table class="entity">
                        <thead>
                            <tr>
                                <th>Airline Id</th>
                                <th>Name</th>
                                <th>Image</th>
                                <th style="min-width: 156px">Actions</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach items="${sessionScope.listAirline}" var="airline">
                                <tr>
                                    <td name="airlineId">${airline.getId()}</td>
                                    <td name="name">${airline.getName()}</td>
                                    <td name="image">
                                        <img src="${airline.getImage()}" width="100" height="100" alt="airline" class="primary" />                                      
                                    </td>
                                    <td>
                                        <button class="btn btn-success" data-toggle="modal" data-target="#update-airline-${airline.getId()}">Update</button>
                                        <button class="btn btn-danger" data-toggle="modal" data-target="#delete-airline-${airline.getId()}">Delete</button>
                                        <button class="btn btn-warning" onclick="toggleBaggageDetails(${airline.id})">Detail</button>
                                    </td>
                                </tr>
                                <!--delete airline modal-->
                            <div class="modal fade" id="delete-airline-${airline.getId()}" tabindex="-1" role="dialog" aria-labelledby="delete-modal-label" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="delete-modal-label">Delete</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Are you sure to delete this airline(All the baggages of this airline will remove too)?</p>
                                        </div>
                                        <div class="modal-footer">
                                            <form action="airlineManagement" method="POST">
                                                <input type="hidden" name="action" value="delete">
                                                <div class="form-group" style="display: none">
                                                    <input type="text" class="form-control" id="idDeleteInput" name="airlineId" value="${airline.getId()}">
                                                </div>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                                <button type="submit" class="btn btn-danger">Yes</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--update airline modal-->
                            <div class="modal fade" id="update-airline-${airline.getId()}" tabindex="-1" role="dialog" aria-labelledby="updateAirlineModal" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" style="text-align: left;">Update Airline</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="airlineManagement" method="POST">
                                                <input type="hidden" name="action" value="update"/>
                                                <!-- Name -->
                                                <div class="form-group">
                                                    <label for="nameInput" style="text-align: left; display: block;">Airline Name:</label>
                                                    <input type="text" class="form-control" id="nameInput" name="airlineName" value="${airline.getName()}" required>
                                                    <div id="nameError" class="error"></div>
                                                </div>

                                                <!-- Image Input -->
                                                <div class="form-group">
                                                    <label for="imageInput" style="text-align: left; display: block;">Image URL:</label>
                                                    <input type="file" class="form-control-file" id="image" name="airlineImage" value=${airline.getImage()} onchange="displayImage2(this)">
                                                    <div id="imageError" class="error"></div>
                                                </div>

                                                <!-- Preview Image -->
                                                <img id="hideImage" src="${airline.getImage()}" alt="Preview" style="display: block; max-width: 300px; max-height: 300px;">
                                                <img id="preImage2" src="#" alt="Preview" style="display: none; max-width: 300px; max-height: 300px;">



                                                <input type="hidden" value="${airline.getId()}" name="airlineId">
                                                <h1>${airline.getId()}</h1>
                                                <div style="text-align: right;">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                    <button type="submit" class="btn btn-primary" >Update</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Hidden row for baggage details -->
                            <tr id="baggage-details-${airline.id}" style="display: none;">

                                <td colspan="4">
                                    <div id="baggage-content-${airline.id}">
                                        <!-- This is where the baggage details will be loaded -->
                                        <!-- Trigger the modal with a button -->
                                        <div style="display: flex; justify-content: start; margin-bottom: 2%;margin-left: 13%">
                                            <button type="button" class="btn btn-info btn-lg" 
                                                    data-toggle="modal" 
                                                    data-target="#addBaggages-${airline.id}">
                                                Add Another Baggage
                                            </button>
                                        </div>
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Baggage Id</th>
                                                    <th>Weight</th>
                                                    <th>Price</th>
                                                    <th style="min-width: 156px">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${sessionScope.listBaggage}" var="baggage">

                                                    <c:if test="${baggage.airlineId == airline.id}">

                                                        <tr>
                                                            <td>${baggage.getId()}</td>
                                                            <td>${baggage.getWeight()}</td>
                                                            <td>${baggage.getPrice()}</td>
                                                            <td>
                                                                <button 
                                                                    class="btn btn-success"
                                                                    data-toggle="modal" data-target="#update-baggage-${baggage.id}">Update</button>
                                                                <button 
                                                                    class="btn btn-danger"
                                                                    data-toggle="modal" data-target="#delete-baggage-${baggage.id}">Delete</button>
                                                            </td>
                                                        </tr>
                                                        <!--delete baggage modal-->
                                                    <div class="modal fade" id="delete-baggage-${baggage.id}" tabindex="-1" role="dialog" aria-labelledby="delete-modal-label" aria-hidden="true">
                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="delete-modal-label">Delete</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <p>Are you sure to delete this baggage?</p>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <form action="baggageManagement" method="POST">
                                                                        <input type="hidden" name="action" value="delete">
                                                                        <div class="form-group" style="display: none">
                                                                            <input type="text" class="form-control" id="idDeleteInput" name="baggageId" value="${baggage.id}">
                                                                        </div>
                                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                                                        <button type="submit" class="btn btn-danger">Yes</button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!--update baggage modal-->
                                                    <div class="modal fade" id="update-baggage-${baggage.id}" tabindex="-1" role="dialog" aria-labelledby="updateBaggageModal" aria-hidden="true">
                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" style="text-align: left;">Update Baggage</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <form action="baggageManagement" method="POST">
                                                                        <input type="hidden" name="action" value="update"/>
                                                                        <div class="form-group">
                                                                            <label for="nameInput-${baggage.id}" style="text-align: left; display: block;">Weight:</label>
                                                                            <input type="text" class="form-control" id="nameInput-${baggage.id}" name="baggageWeight" value="${baggage.weight}" required>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="imageInput-${baggage.id}" style="text-align: left; display: block;">Price:</label>
                                                                            <input type="text" class="form-control" id="imageInput-${baggage.id}" name="baggagePrice" value="${baggage.price}" required>
                                                                        </div>
                                                                        <input type="hidden" name="baggageId" value="${baggage.id}">
                                                                        <div style="text-align: right;">
                                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                                            <button type="submit" class="btn btn-primary" >Update</button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                                <!-- add baggage Modal -->
                            <div class="modal fade" id="addBaggages-${airline.id}" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addBookModalLabel" style="text-align: left;">Add Another Baggage</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form id="addBaggage-${airline.id}" action="baggageManagement" method="POST">
                                                <input type="hidden" name="action" value="add"/> 
                                                <!-- Weight -->
                                                <div class="form-group">
                                                    <label for="nameInput" style="display: flex; justify-content: start;">Weight:</label>
                                                    <input type="text" class="form-control" id="nameInput" name="baggageWeight" required>
                                                    <div id="nameError" class="error"></div>
                                                </div>
                                                <!-- Price -->
                                                <div class="form-group">
                                                    <label for="imageInput" style="display: flex; justify-content: start;">Price:</label>
                                                    <input type="text" class="form-control" id="imageInput" name="baggagePrice" required>
                                                    <div id="imageError" class="error"></div>
                                                </div>
                                                <input type="hidden" name="airlineIdBaggage" value="${airline.id}">
                                                <h1>${airline.id}</h1>
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-primary" form="addBaggage-${airline.id}">Add</button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            function toggleBaggageDetails(airlineId) {

                var detailsRow = document.getElementById('baggage-details-' + airlineId);


                if (detailsRow.style.display === 'table-row') {
                    detailsRow.style.display = 'none';
                } else {

                    detailsRow.style.display = 'table-row';


                    fetch('baggageDetails?airlineId=' + airlineId)
                            .then(response => response.json())
                            .then(data => {
                                var baggageContent = document.getElementById('baggage-content-' + airlineId);
                                baggageContent.innerHTML = '';

                                if (data.length > 0) {

                                    var table = '<table class="table table-bordered"><thead><tr><th>Baggage ID</th><th>Weight (kg)</th><th>Price ($)</th></tr></thead><tbody>';
                                    data.forEach(function (baggage) {
                                        table += '<tr><td>' + baggage.baggageId + '</td><td>' + baggage.weight + '</td><td>' + baggage.price + '</td></tr>';
                                    });
                                    table += '</tbody></table>';
                                    baggageContent.innerHTML = table;
                                } else {
                                    baggageContent.innerHTML = '<p>No baggages available for this airline.</p>';
                                }
                            })
                            .catch(error => {
                                console.error('Error fetching baggage details:', error);
                                baggageContent.innerHTML = '<p>Error loading baggages.</p>';
                            });
                }
            }
            function toggleBaggageInputs() {
                var baggageInputs = document.getElementById('baggageInputs');
                baggageInputs.style.display = baggageInputs.style.display === 'none' ? 'block' : 'none';
            }

            function addBaggageInput() {
                var container = document.getElementById("baggageContainer");

                // Tìm số lượng phần tử hiện tại trong container
                var baggageIndex = container.querySelectorAll('.baggage-section').length + 1;



                var baggageHtml =
                        '<div class="baggage-section">' +
                        '<h5>Baggage ' + baggageIndex + '</h5>' + // Hiển thị chỉ số hành lý
                        '<div class="form-group">' +
                        '<label for="weightInput' + baggageIndex + '">Baggage Weight ' + baggageIndex + ':</label>' +
                        '<input type="text" class="form-control" id="weightInput' + baggageIndex + '" name="baggageWeight" step="0.1">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="priceInput' + baggageIndex + '">Baggage Price ' + baggageIndex + ':</label>' +
                        '<input type="text" class="form-control" id="priceInput' + baggageIndex + '" name="baggagePrice" step="0.01">' +
                        '</div>' +
                        '</div>';

                container.insertAdjacentHTML("beforeend", baggageHtml);
            }
            function displayImage(input) {
                var previewImage = document.getElementById("previewImage");
                var file = input.files[0];
                var reader = new FileReader();

                reader.onload = function (e) {
                    previewImage.src = e.target.result;
                    previewImage.style.display = "block";
                };

                reader.readAsDataURL(file);
            }
            function displayImage2(input) {
                var hideImage = document.getElementById("hideImage");
                var previewImage2 = document.getElementById("preImage2");
                var file = input.files[0];
                var reader = new FileReader();

                reader.onload = function (e) {
                    hideImage.style.display = "none";
                    previewImage2.src = e.target.result;
                    previewImage2.style.display = "block";
                }

                reader.readAsDataURL(file);
            }

        </script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </body>
</html>

