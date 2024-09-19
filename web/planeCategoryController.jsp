<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.SeatCategory"%>
<%@page import="dal.SeatCategoryDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý loại máy bay</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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
        <div id="main-content" style="padding: 15vh 16vw; margin: 0">
            <!-- DuongNT: Filter category of plane -->
            <div class="filterController" style="display: flex; width: 100%">
                <form action="planeCategoryController" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="search">
                    <strong>Name: </strong>
                    <input class="filterElm" type="text" name="fName" value="${param.fName}" placeholder="Enter name">
                    <button class="btn btn-info" type="submit" style="width: 60px" >
                        <i class="ti-search"></i>
                        Lọc
                    </button>
                    <a class="btn btn-danger" href="planeCategoryController">Huỷ</a>
                </form>
            </div>

            <div>
                <a class="btn btn-success" style="text-decoration: none; margin-bottom: 20px" onclick="openModal(0)">Add new plane category</a>
            </div>
            <!-- Modal for inserting new plane category -->
            <div class="modal fade" id="myModal0" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header" style="padding:5px 5px;">
                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                            <h4 style="margin-left: 12px">Add New Plane Category</h4>
                        </div>
                        <div class="modal-body" style="padding:40px 50px;">
                            <form role="form" action="planeCategoryController" method="post">
                                <div class="row">
                                    <input type="hidden" value="${account.getAirlineId()}" name="airlineId"/>
                                    <div class="form-group col-md-6">
                                        <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                        <input type="file" class="form-control" name="image">
                                    </div>
                                    <!--                                    <div class="col-md-2"></div>
                                                                        <div class="form-group col-md-4">
                                                                            <img src="" alt="Avatar" class="img-thumbnail" style="width: 100px; height: 100px; float: right;">
                                                                        </div>-->
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                    <input type="text" class="form-control" name="name">
                                </div>
                                <button type="submit" class="btn btn-success btn-block">
                                    Confirm
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- DuongNT: Plane category dashboard -->
            <table class="entity" >
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Image</th>
                        <th style="padding: 0 55px; min-width: 156px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    SeatCategoryDAO scd = new SeatCategoryDAO();
                    List<PlaneCategory> planeCategoryList = (List<PlaneCategory>) request.getAttribute("planeCategoryList");
                    for (PlaneCategory pc : planeCategoryList) {
                    %>
                    <tr>
                        <td><%= pc.getName() %></td>
                        <td><img src="<%= pc.getImage() %>" alt="<%= pc.getName() %>"></td>
                        <td>
                            <a class="btn btn-info" style="text-decoration: none" onclick="openModal(<%= pc.getId() %>)">Update</a>
                            <a class="btn btn-danger" style="text-decoration: none" onclick="doDelete('<%= pc.getId() %>', '<%= pc.getName() %>')">Delete</a>
                            <a class="btn btn-warning" style="text-decoration: none" onclick="openSeatCategoryDashboard(<%= pc.getId() %>)" >Seat Category Setting
                                <span id="arrow<%= pc.getId() %>" style="margin-left: 8px" class="glyphicon glyphicon-menu-down"></span>
                            </a>
                        </td>
                    </tr>
                    <!-- For seat category -->
                    <tr id="seatCategoryDashboard<%= pc.getId() %>" style="display: none">
                        <td colspan="4">
                            <div style="float: right; margin-left: 20px">
                                <a class="btn btn-success" style="text-decoration: none; margin-bottom: 20px" onclick="openModalInsertSeatCategory(<%= pc.getId() %>)">Add new seat category</a>
                            </div>
                            <!-- Modal for inserting seat category -->
                            <div class="modal fade" id="myModalInsertSeatCategory<%= pc.getId() %>" role="dialog">
                                <div class="modal-dialog" >
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header" style="padding:5px 5px;">
                                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                            <h4 style="margin-left: 12px">Add</h4>
                                        </div>
                                        <div class="modal-body" style="padding:40px 50px;">
                                            <form role="form" action="seatCategoryController" method="post">
                                                <div class="row">
                                                    <input type="hidden" value="<%= pc.getId() %>" name="planeCategoryId"/>
                                                    <h1><%= pc.getId() %></h1>
                                                    <div class="form-group col-md-2">
                                                        <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                        <input type="text" class="form-control" name="id" readonly>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                                        <input type="file" class="form-control" name="image">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                                    <input type="text" class="form-control" name="name" %>
                                                </div>
                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-picture"></span>Number of seat:</label>
                                                    <input type="number" class="form-control" name="numberOfSeat">
                                                </div>
                                                <button type="submit" class="btn btn-success btn-block">
                                                    Confirm
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- DuongNT: Seat category dashboard -->
                            <table class="entity">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Image</th>
                                        <th>Number Of Seat</th>
                                        <th style="padding: 0 55px; min-width: 156px">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    List<SeatCategory> seatCategoryList = scd.getAllSeatCategoryByPlaneCategoryId(pc.getId());
                                    for (SeatCategory sc : seatCategoryList) {
                                    %>
                                    <tr>
                                        <td><%= sc.getName() %></td>
                                        <td><img src="<%= sc.getImage() %>" alt="<%= sc.getName() %>"></td>
                                        <td><%= sc.getNumberOfSeat() %></td>
                                        <td>
                                            <a class="btn btn-info" style="text-decoration: none" onclick="openModalSeatCategory(<%= sc.getId() %>)">Update</a>
                                            <a class="btn btn-danger" style="text-decoration: none" onclick="doDeleteSeatCategory('<%= sc.getId() %>', '<%= sc.getName() %>')">Delete</a>
                                        </td>
                                    </tr>
                                    <!-- Modal for updating seat category -->
                                    <div class="modal fade" id="myModalSeatCategory<%= sc.getId() %>" role="dialog">
                                        <div class="modal-dialog" >
                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header" style="padding:5px 5px;">
                                                    <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                                    <h4 style="margin-left: 12px">Update</h4>
                                                </div>
                                                <div class="modal-body" style="padding:40px 50px;">
                                                    <form role="form" action="seatCategoryController" method="post">
                                                        <div class="row">
                                                            <input type="hidden" value="<%= sc.getPlane_Categoryid() %>" name="planeCategoryId"/>
                                                            <div class="form-group col-md-2">
                                                                <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                                <input type="text" class="form-control" name="id" value="<%= sc.getId() %>" readonly>
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                                                <input type="file" class="form-control" name="image">
                                                            </div>
                                                            <div class="form-group col-md-4">
                                                                <img src="<%= sc.getImage() %>" alt="Image" class="img-thumbnail" style="width: 100px; height: 100px; float: right;">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                                            <input type="text" class="form-control" name="name" value="<%= sc.getName() %>">
                                                        </div>
                                                        <div class="form-group">
                                                            <label><span class="glyphicon glyphicon-picture"></span>Number of seat:</label>
                                                            <input type="text" class="form-control" name="numberOfSeat" value="<%= sc.getNumberOfSeat() %>">
                                                        </div>
                                                        <button type="submit" class="btn btn-success btn-block">
                                                            Confirm
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <!-- Modal for updating plane category -->
                    <div class="modal fade" id="myModal<%= pc.getId() %>" role="dialog">
                        <div class="modal-dialog">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header" style="padding:5px 5px;">
                                    <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                    <h4 style="margin-left: 12px">Update</h4>
                                </div>
                                <div class="modal-body" style="padding:40px 50px;">
                                    <form role="form" action="planeCategoryController" method="post">
                                        <div class="row">
                                            <input type="hidden" value="<%= pc.getAirlineid() %>" name="airlineId"/>
                                            <div class="form-group col-md-2">
                                                <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                <input type="text" class="form-control" name="id" value="<%= pc.getId() %>" readonly>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                                <input type="file" class="form-control" name="image">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <img src="<%= pc.getImage() %>" alt="Avatar" class="img-thumbnail" style="width: 100px; height: 100px; float: right;">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label><span class="glyphicon glyphicon-picture"></span>Name:</label>
                                            <input type="text" class="form-control" name="name" value="<%= pc.getName() %>">
                                        </div>
                                        <button type="submit" class="btn btn-success btn-block">
                                            Confirm
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>

        <script>
            function openModal(id) {
                $("#myModal" + id).modal('show');
            }
            function openModalSeatCategory(id) {
                $("#myModalSeatCategory" + id).modal('show');
            }
            function openModalInsertSeatCategory(id) {
                $("#myModalInsertSeatCategory" + id).modal('show');
            }
            function openSeatCategoryDashboard(id){
                var dashboard = document.getElementById("seatCategoryDashboard" + id);
                var arrow = document.getElementById("arrow" + id);
                if (dashboard.style.display === 'none') {
                    dashboard.style.display = 'table-row';
                    arrow.classList.remove("glyphicon-menu-down");
                    arrow.classList.add("glyphicon-menu-up");
                } else {
                    dashboard.style.display = 'none';
                    arrow.classList.remove("glyphicon-menu-up");
                    arrow.classList.add("glyphicon-menu-down");

                }
            }
            function doDelete(id, name) {
                if (confirm("Bạn có muốn xoá loại máy bay với tên là " + name)) {
                    window.location = "planeCategoryController?action=remove&id=" + id;
                }
            }
            function doDeleteSeatCategory(id, name) {
                if (confirm("Bạn có muốn xoá loại ghế với tên là " + name)) {
                    window.location = "seatCategoryController?action=remove&id=" + id;
                }
            }
        </script>
    </body>
</html>