<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="model.PlaneCategory"%>
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
                                    <label><span class="glyphicon glyphicon-picture"></span>Name:</label>
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
                        <th>ID</th>
                        <th>Name</th>
                        <th>Image</th>
                        <th style="padding: 0 55px; min-width: 156px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    List<PlaneCategory> planeCategoryList = (List<PlaneCategory>) request.getAttribute("planeCategoryList");
                    for (PlaneCategory pc : planeCategoryList) {
                    %>
                    <tr>
                        <td><%= pc.getId() %></td>
                        <td><%= pc.getName() %></td>
                        <td><img src="<%= pc.getImage() %>" alt="<%= pc.getName() %>"></td>
                        <td>
                            <a class="btn btn-info" style="text-decoration: none" id="myBtn<%= pc.getId() %>" onclick="openModal(<%= pc.getId() %>)">Update</a>
                            <a class="btn btn-danger" style="text-decoration: none" onclick="doDelete('<%= pc.getId() %>', '<%= pc.getName() %>')">Delete</a>
                            <a class="btn btn-warning" style="text-decoration: none" >Seat Category Setting</a>
                        </td>
                    </tr>
                        <!-- For seat category -->
                    <tr>
                        <td colspan="4">Hello</td>
                    </tr>
                    <!-- Modal for updating -->
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
            function doDelete(id, name) {
                if (confirm("Bạn có muốn xoá loại máy bay với tên là " + name)) {
                    window.location = "planeCategoryController?action=remove&id=" + id;
                }
            }
        </script>
    </body>
</html>