<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.Country"%>
<%@page import="model.Airport"%>
<%@page import="model.Flights"%>
<%@page import="model.Location"%>
<%@page import="model.FlightType"%>
<%@page import="java.util.List"%>
<%@page import="dal.AirportDAO"%>
<%@page import="dal.CountryDAO"%>
<%@page import="dal.FlightManageDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="dal.LocationDAO"%>
<%@page import="java.sql.ResultSet" %>
<!DOCTYPE html>

<html>
    <%
        ResultSet rsFlightManage = (ResultSet) request.getAttribute("rsFlightManage");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý loại máy bay</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
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
                        <form id="addProductForm" action="airlineManagement" method="POST">
                            <input type="hidden" name="action" value="add">
                            <!-- Name -->
                            <div class="form-group">
                                <label for="minutesInput"><span class="glyphicon glyphicon-plane"></span> Minutes:</label>
                                <input type="text" class="form-control" id="minutesInput" name="minutes" required>
                                <div id="nameError" class="error"></div>
                            </div>

                            <div class="row">
                                <div class="form-group col-md-6">
                                    <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Departure Airport: </label></div>
                                    <select name="departureAirport" value="" style="height:  34px">
                                     
                                      
                                    </select>
                                </div>

                                <!-- Information -->
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-info-sign"></span> Information:</label>
                                    <div class="editor-container">
                                        <textarea class="editor" name="airlineInfo"></textarea>
                                    </div>
                                </div>  


                                <!-- Baggage Inputs -->
                                <input type="hidden" name="airlineId" value="">

                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary" form="addProductForm">Add</button>
                            </div>
                    </div>
                </div>
            </div>
            </div>
            <div id="main-content">
                <div>
                    <!-- Search bar -->
                    <div style="max-width: 60%;">
                        <form action="airlineController" method="GET" style="display: flex; width: 50%; align-items: center;">
                            <input type="hidden" name="search" value="searchByName">
                            <strong>Name: </strong>
                            <input class="filterElm" type="text" placeholder="Airline Name ..." name="keyword" style="margin-left:5px">
                            <input type="submit" class="btn btn-info" name="submit" value="Search" style="margin-right: 5px">
                            <input type="reset" class="btn btn-danger" value="Cancle">
                            <input type="hidden" name="service" value="listStaff">
                        </form>
                    </div>

                    <!-- Trigger the modal with a button -->
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addAirline"  style="margin-top: 20px;flex-shrink: 0;">
                        Add New Airline
                    </button>






                </div>
                <div class="row" style="margin: 0">
                    <div class="col-md-10" id="left-column" style="padding: 0; margin-top: 10px">
                        <table class="entity">
                            <thead>
                                <%rsFlightManage.next();%>
                                <tr>
                                    <th>ID</th>
                                    <th>Minutes</th>
                                    <th>DepartureAirport</th>
                                    <th>DepartureLocation</th>
                                    <th>DepartureCountry</th>
                                    <th>DestinationAirport</th>
                                    <th>DestinationLocation</th>
                                    <th>DestinationCountry</th>
                                    
                                    <th style="min-width: 156px">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%do{%>
                                <tr>
                                    <td><%=rsFlightManage.getInt(1)%></td>
                                    <td><%=rsFlightManage.getInt(2)%></td>
                                    <td><%=rsFlightManage.getString(3)%></td>
                                    <td><%=rsFlightManage.getString(4)%></td>
                                    <td><%=rsFlightManage.getString(5)%></td>
                                    <td><%=rsFlightManage.getString(6)%></td>
                                    <td><%=rsFlightManage.getString(7)%></td>
                                    <td><%=rsFlightManage.getString(8)%></td>
                                  
                                </tr>
                                <%}while(rsFlightManage.next());%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <script type="importmap">
                {
                "imports": {
                "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.js",
                "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.1.0/"
                }
                }
            </script>
            <script type="module">

            </script>

            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>



            <div class="ck-body-wrapper"><div class="ck ck-reset_all ck-body ck-rounded-corners" dir="ltr" role="application"><div class="ck ck-clipboard-drop-target-line ck-hidden"></div><div class="ck ck-aria-live-announcer"><div aria-live="polite" aria-relevant="additions"><ul class="ck ck-aria-live-region-list"></ul></div><div aria-live="assertive" aria-relevant="additions"><ul class="ck ck-aria-live-region-list"></ul></div></div></div></div></body>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="importmap">
        {
        "imports": {
        "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.js",
        "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.1.0/"
        }
        }
    </script>

</body>
</html>