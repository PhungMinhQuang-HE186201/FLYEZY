<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.Country"%>
<%@page import="model.Airport"%>
<%@page import="model.Flights"%>
<%@page import="model.Location"%>
<%@page import="model.Status"%>
<%@page import="model.Airline"%>
<%@page import="java.util.List"%>
<%@page import="dal.AirportDAO"%>
<%@page import="dal.CountryDAO"%>
<%@page import="dal.FlightManageDAO"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.LocationDAO"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý loại máy bay</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleFlightManagement.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">

        <style>
            .modal-body{
                text-align: left
            }
            .modal-body span{
                margin-right: 5px
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>

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
                        <c:if test="${not empty error}">
                            <p id="error" class="text-danger"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
                        </c:if>

                        <form id="addProductForm" action="flightManagement" method="POST">
                            <input type="hidden" name="action" value="create">     
                            <!-- Name -->
                            <div class="form-group">
                                <label for="minutesInput"><span class="glyphicon glyphicon-plane"></span> Minutes:</label>
                                <input type="text" class="form-control" id="minutesInput" name="minutes" required>
                            </div>

                            <div class="row">
                                <div class="form-group col-md-6">
                                    <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Departure Airport: </label></div>
                                    <select name="departureAirport" value="" style="height:  34px">
                                        <%List<Airport> listA = (List<Airport>)request.getAttribute("listA");
                                                  for(Airport airport : listA){%>
                                        <option value="<%=airport.getId()%>"><%=airport.getName()%></option>"
                                        <%}%>
                                    </select>
                                </div>

                                <div class="form-group col-md-6">
                                    <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Destination Airport: </label></div>
                                    <select name="destinationAirport" value="" style="height:  34px">
                                        <%  for(Airport airport2 : listA){%>      
                                        <option value="<%=airport2.getId()%>"> <%=airport2.getName()%></option>"
                                        <%}%>  
                                    </select>
                                </div>
                            </div>       
                            <input type="hidden" class="form-control" name="airlineId" value="${requestScope.account.getAirlineId()}" readonly="">



                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary" form="addProductForm">Add</button>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <div id="main-content">
            <div>
                <!-- Trigger the modal with a button -->
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addAirline"  style="margin-top: 20px;flex-shrink: 0;">
                    Add New Airline
                </button>
            </div>

            <div class="row" style="margin: 0">
                <div class="col-md-9" id="left-column" style="padding: 0; margin-top: 10px">
                    <table class="entity">
                        <thead>     
                            <tr>
                                <th>DEP Country</th>
                                <th>DEP Location</th>
                                <th>DEP Airport</th>
                                <th>DES Country</th>
                                <th>DES Location</th>
                                <th>DES Airport</th>      
                                <th>Minutes</th>
                                <th>Status</th>
                                <th style="padding: 0 55px; min-width: 156px">Actions</th>
                            </tr>
                        </thead> 
                        <tbody>
                            <%
                            ResultSet rsFlightManage;
                            if (request.getAttribute("rsFlightManage") != null) {
                                rsFlightManage = (ResultSet) request.getAttribute("rsFlightManage");
                            } else {
                                rsFlightManage = null;
                            }
                            while(rsFlightManage != null && rsFlightManage.next()) {%>
                            <tr>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(5)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(4)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>" ><%=rsFlightManage.getString(3)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(8)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(7)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getString(6)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>"><%=rsFlightManage.getInt(2)%></td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>">
                                    <%if (rsFlightManage.getInt(12) == 1){ %>
                                    <button class="btn btn-success" data-toggle="modal" data-target="#changeActive-airline-<%=rsFlightManage.getInt(1) %>">Activated</button>
                                    <%}%>
                                    <%if (rsFlightManage.getInt(12) == 2){ %>
                                    <button class="btn btn-danger" data-toggle="modal" data-target="#changeActive-airline-<%=rsFlightManage.getInt(1) %>">Deactivated</button>
                                    <%}%>

                                    <!-- Change active -->
                                    <div class="modal fade" id="changeActive-airline-<%=rsFlightManage.getInt(1) %>" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="delete-modal-label">Change Status</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <%if (rsFlightManage.getInt(12) == 2){ %>
                                                <div class="modal-body">
                                                    <p>Do you want to reactivate this airline?</p>
                                                </div>
                                                <%}%>
                                                <%if (rsFlightManage.getInt(12) == 1){ %>
                                                <div class="modal-body">
                                                    <p>Do you want to deactivate this airline?</p>
                                                </div>
                                                <%}%>
                                                <div class="modal-footer">
                                                    <form action="flightManagement" method="post">
                                                        <input type="hidden" name="action" value="changeStatus">
                                                        <div class="form-group" style="display: none">
                                                            <input type="text" class="form-control" id="idDeleteInput" name="flightId" value="<%=rsFlightManage.getInt(1) %>">
                                                        </div>
                                                        <div class="form-group" style="display: none">
                                                            <input type="text" class="form-control" id="idDeleteInput" name="flightStatus" value="<%=rsFlightManage.getInt(12) %>">
                                                        </div>

                                                        <%if (rsFlightManage.getInt(12) == 2){ %>
                                                        <button type="submit" class="btn btn-danger">Yes</button>
                                                        <%}%>
                                                        <%if (rsFlightManage.getInt(12) == 1){ %>
                                                        <button type="submit" class="btn btn-success">Yes</button>
                                                        <%}%>
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td style="background-color:  <%= (rsFlightManage.getInt(12) == 1) ? "" : "#ccc" %>">  
                                    <button class="btn btn-info" data-toggle="modal" data-target="#update-flight-<%=rsFlightManage.getInt(1) %>">Update</button>
                                    <!--update-->
                                    <div class="modal fade" id="update-flight-<%=rsFlightManage.getInt(1) %>" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" style="text-align: left;">Update Airline</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">

                                                    <c:if test="${not empty errorUpdate}">
                                                        <p id="update-<%=rsFlightManage.getInt(1) %>" class="text-danger"> </p>                                             
                                                    </c:if>
                                                    <form  action="flightManagement" method="post"> 
                                                        <input type="hidden" name="action" value="update"/>
                                                        <input type="hidden" name="airlineId" value="${requestScope.account.getAirlineId()}"/>
                                                        <label for="usrname"><span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                        <input type="text" class="form-control" id="usrname" name="id" value="<%=rsFlightManage.getInt(1) %>" readonly="">

                                                        <!-- Minutes -->
                                                        <div class="form-group">
                                                            <label for="nameInput" style="text-align: left; display: block;"><span class="glyphicon glyphicon-plane"></span> Minutes:</label>
                                                            <input type="number" class="form-control" id="nameInput" name="minutes" value="<%=rsFlightManage.getInt(2)%>" required/>
                                                        </div>

                                                        <div class="row">
                                                            <div class="form-group col-md-6">
                                                                <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Departure Airport: </label></div>
                                                                <select name="departureAirport" value="<%=rsFlightManage.getInt(10)%>" style="height:  34px">
                                                                    <% for(Airport airport : listA){%>
                                                                    <option value="<%=airport.getId()%>" <%= (rsFlightManage.getInt(10) == airport.getId()) ? "selected" : "" %>><%=airport.getName()%></option>"
                                                                    <%}%>
                                                                </select>
                                                            </div>

                                                            <div class="form-group col-md-6">
                                                                <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Destination Airport: </label></div>
                                                                <select name="destinationAirport" value="<%=rsFlightManage.getInt(11)%>" style="height:  34px">
                                                                    <% for(Airport airport2 : listA){%>
                                                                    <option value="<%=airport2.getId()%>" <%= (rsFlightManage.getInt(11) == airport2.getId()) ? "selected" : "" %>><%=airport2.getName()%></option>"
                                                                    <%}%>
                                                                </select>
                                                            </div>


                                                        </div>
                                                        <div style="text-align: right;">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary" >Update</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
                <!-- Search bar -->
                <div class="col-md-3">
                    <form class="flight-form" action="flightManagement" method="GET" style="display: flex; width: 78%; align-items: center;">
                        <input type="hidden" name="action" value="search"/>
                        <%
                        CountryDAO cd = new CountryDAO();
                        LocationDAO ld = new LocationDAO();
                        AirportDAO aird = new AirportDAO();
                        %>

                        <div class="flight-form-group">
                            <strong>DEP Country:</strong>
                            <select class="flight-select" name="departureCountry" id="departureCountry">
                                <option value="">Select Country</option>
                                <% for (Country c : (List<Country>) request.getAttribute("listC")) { %>
                                <option value="<%= c.getName() %>" <%= (c.getName().equals(request.getParameter("departureCountry")) ? "selected" : "") %>><%= c.getName() %></option>
                                <% } %>
                            </select>

                            <strong>DEP Location:</strong>
                            <select class="flight-select" name="departureLocation" id="departureLocation">
                                <option value="">Select Location</option>
                                <% for (Location l : (List<Location>) ld.getLocationsByCountryId(cd.getIdByCountryName(request.getParameter("departureCountry")))) { %>
                                <option value="<%= l.getName() %>" <%= (l.getName().equals(request.getParameter("departureLocation")) ? "selected" : "") %>><%= l.getName() %></option>
                                <% } %>
                            </select>

                            <strong>DEP Airport:</strong>
                            <select class="flight-select" name="departureAirport" id="departureAirport">
                                <option value="">Select Airport</option>
                                <% for (Airport ap : (List<Airport>) aird.getAirportsByLocationId(ld.getIdByLocationName(request.getParameter("departureLocation")))) { %>
                                <option value="<%= ap.getName() %>" <%= (ap.getName().equals(request.getParameter("departureAirport")) ? "selected" : "") %>><%= ap.getName() %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="flight-form-group">
                            <strong>DES Country:</strong>
                            <select class="flight-select" name="destinationCountry" id="destinationCountry">
                                <option value="">Select Country</option>
                                <% for (Country c : (List<Country>) request.getAttribute("listC")) { %>
                                <option value="<%= c.getName() %>" <%= (c.getName().equals(request.getParameter("destinationCountry")) ? "selected" : "") %>><%= c.getName() %></option>
                                <% } %>
                            </select>

                            <strong>DES Location:</strong>
                            <select class="flight-select" name="destinationLocation" id="destinationLocation">
                                <option value="">Select Location</option>
                                <% for (Location l : (List<Location>) ld.getLocationsByCountryId(cd.getIdByCountryName(request.getParameter("destinationCountry")))) { %>
                                <option value="<%= l.getName() %>" <%= (l.getName().equals(request.getParameter("destinationLocation")) ? "selected" : "") %>><%= l.getName() %></option>
                                <% } %>
                            </select>


                            <strong>DES Airport:</strong>
                            <select class="flight-select" name="destinationAirport" id="destinationAirport">
                                <option value="">Select Airport</option>
                                <% for (Airport ap : (List<Airport>) aird.getAirportsByLocationId(ld.getIdByLocationName(request.getParameter("destinationLocation")))) { %>
                                <option value="<%= ap.getName() %>" <%= (ap.getName().equals(request.getParameter("destinationAirport")) ? "selected" : "") %>><%= ap.getName() %></option>
                                <% } %>
                            </select>
                        </div>

                        <div>
                            <button class="btn btn-info" type="submit">Search</button>
                            <a class="btn btn-danger" href="flightManagement">Cancel</a>
                        </div>
                    </form>

                </div>
            </div>
        </div>



        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>



        <div class="ck-body-wrapper"><div class="ck ck-reset_all ck-body ck-rounded-corners" dir="ltr" role="application"><div class="ck ck-clipboard-drop-target-line ck-hidden"></div><div class="ck ck-aria-live-announcer"><div aria-live="polite" aria-relevant="additions"><ul class="ck ck-aria-live-region-list"></ul></div><div aria-live="assertive" aria-relevant="additions"><ul class="ck ck-aria-live-region-list"></ul></div></div></div></div></body>


    <script type="importmap">
        {
        "imports": {
        "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.js",
        "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.1.0/"
        }
        }
    </script>

    <script>
        $(document).ready(function () {

            // Create an empty countries object
            var countries = {};
        <%
                    LocationDAO ld2 = new LocationDAO();
                    AirportDAO aird2 = new AirportDAO();
                    List<Country> listCountry = (List<Country>) request.getAttribute("listC");
                
            
        %>
            countries = {
                "All": {
                    locations: ["All"],
                    airports: {"All": ["All"]}
                }
            };
        <%

                    for (Country c : listCountry) { 
                        List<Location> listLocation = ld2.getLocationsByCountryId(c.getId());
        %>
            countries["<%= c.getName() %>"] = {
            locations: [
        <% 
                        for (Location l : listLocation) { 
        %>
            "<%= l.getName() %>",
        <% } %>
            ],
                    airports: {
        <% 
                        for (Location l : listLocation) { 
                            List<Airport> listAirport = aird2.getAirportsByLocationId(l.getId());
        %>
                    "<%= l.getName() %>": [
        <% 
                                for (int i = 0; i < listAirport.size(); i++) {
                                    Airport airport = listAirport.get(i);
                                    out.print("\"" + airport.getName() + "\"");
                                    if (i < listAirport.size() - 1) {
                                        out.print(", ");
                                    }
                                }
        %>
                    ],
        <% } %>
                    }
            };
        <% } %>

            $("#departureCountry").change(function () {
                var selectedCountry = $(this).val();
                console.log(selectedCountry);
                var locationOptions = "<option value=''>Select Location</option>";
                if (selectedCountry && countries[selectedCountry]) {
                    var locations = countries[selectedCountry]["locations"];
                    locations.forEach(function (location) {
                        locationOptions += "<option value='" + location + "'" + ">" + location + "</option>";
                    });
                    $("#departureLocation").html(locationOptions);
                } else {
                    $("#departureLocation").empty();
                    $("#departureAirport").empty();
                }
            });
            $("#departureLocation").change(function () {
                var selectedCountry = $("#departureCountry").val();
                var selectedLocation = $(this).val();
                var airportOptions = "<option value=''>Select Airport</option>";
                if (selectedLocation && countries[selectedCountry]) {
                    var airports = countries[selectedCountry]["airports"][selectedLocation];
                    airports.forEach(function (airport) {
                        airportOptions += "<option value='" + airport + "'" + ">" + airport + "</option>";
                    });
                    $("#departureAirport").html(airportOptions);
                } else {
                    $("#departureAirport").empty();
                }
            });
            $("#destinationCountry").change(function () {
                var selectedCountry = $(this).val();
                console.log(selectedCountry);
                var locationOptions = "<option value=''>Select Location</option>";
                if (selectedCountry && countries[selectedCountry]) {
                    var locations = countries[selectedCountry]["locations"];
                    locations.forEach(function (location) {
                        locationOptions += "<option value='" + location + "'" + ">" + location + "</option>";
                    });
                    $("#destinationLocation").html(locationOptions);
                } else {
                    $("#destinationLocation").empty();
                    $("#destinationAirport").empty();
                }
            });
            $("#destinationLocation").change(function () {
                var selectedCountry = $("#destinationCountry").val();
                var selectedLocation = $(this).val();
                var airportOptions = "<option value=''>Select Airport</option>";
                if (selectedLocation && countries[selectedCountry]) {
                    var airports = countries[selectedCountry]["airports"][selectedLocation];
                    airports.forEach(function (airport) {
                        airportOptions += "<option value='" + airport + "'" + ">" + airport + "</option>";
                    });
                    $("#destinationAirport").html(airportOptions);
                } else {
                    $("#destinationAirport").empty();
                }
            });

        <c:if test="${not empty error}">
            $('#addAirline').modal('show'); // Show the 'Add Airline' modal
        </c:if>
            $('#addAirline').on('hidden.bs.modal', function () {
                $('#error').text(''); // Clear the error text
            });

        });

    </script>   

    <c:if test="${not empty errorUpdate}">
        <script>
            $(document).ready(function () {
                // Mở modal khi có lỗi
                $('#update-flight-<%= request.getAttribute("id") %>').modal('show');

                // Hiển thị thông báo lỗi
                $('#update-<%= request.getAttribute("id") %>').text('<c:out value="${errorUpdate}"/>'); // Hiển thị lỗi
            });
        </script>
    </c:if>

    <!-- Sự kiện đóng modal để xóa thông báo lỗi -->
    <script>
        $(document).ready(function () {
            $('#update-flight-<%= request.getAttribute("id") %>').on('hidden.bs.modal', function () {
                // Xóa nội dung của phần tử thông báo lỗi
                $('#update-<%= request.getAttribute("id") %>').text('');
            });
        });
    </script>



</body>
</html>