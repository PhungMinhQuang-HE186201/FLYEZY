<%-- 
    Document   : admin
    Created on : May 14, 2024, 9:11:02 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="dal.RolesDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Accounts"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý tài khoản</title>
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
            #myBtn{
                display: flex;
                flex:left
            }
            #main-content{
                
            }
        </style>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div id="main-content" style="padding: 15vh 16vw; margin: 0">
            <div class="filterController col-md-12" style="display: flex">
                <form action="accountController" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="search">
                    <strong class="filterElm">Role:</strong>
                    <select class="filterElm" name="fRole">
                        <option value="" ${param.fRole == null ? 'selected' : ''}>All</option>
                        <c:forEach items="${rolesList}" var="role">
                            <option value="${role.id}" ${param.fRole != null && (param.fRole==role.id) ? 'selected' : ''}>${role.name}</option>
                        </c:forEach>
                    </select>
                    <strong>Name: </strong>
                    <input class="filterElm" type="text" name="fName" value="${param.fName}" placeholder="Enter name">
                    <strong>Phone number: </strong>
                    <input class="filterElm" type="number" name="fPhoneNumber" value="${param.fPhoneNumber}" placeholder="Enter phone number">
                    <button class="btn btn-info" type="submit" style="width: 60px" >
                        <i class="ti-search"></i>
                        Lọc
                    </button>
                    <a class="btn btn-danger" href="accountController">Huỷ</a>
                </form>


            </div>
              
            <button type="button" class="btn btn-success" id="myBtn">Add new User</button>
            <!-- Update Modal -->
            <div class="container">
                <!-- Modal -->
                <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header" style="padding:5px 5px;">
                                <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                <h4 style="margin-left: 12px">Create</h4>
                            </div>
                            <div class="modal-body" style="padding:40px 50px;">
                                <form role="form" action="accountController" method="Post">
                                    <input type="hidden" name="action" value="create"/>

                                    <div class="row">

                                        <div class="form-group col-md-6">
                                            <label for="image"><span class="glyphicon glyphicon-picture"></span>Avatar:</label>
                                            <input type="file" class="form-control" name="image">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-3">
                                            <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Role:</label></div>
                                            <select name="roleId" value="" style="height:  34px">
                                                <option value="1">Admin</option>
                                                <option value="2">Member</option>
                                                <option value="3">Airline staff</option>
                                                <option value="4">Service staff</option>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-9">
                                            <label for="name"><span class="glyphicon glyphicon-user"></span>Name:</label>
                                            <input type="text" class="form-control" name="name" value="">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label for="dob"><span class="glyphicon glyphicon-calendar"></span>Date of birth:</label>
                                            <input type="date" class="form-control" name="dob" required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="phoneNumber"><span class="glyphicon glyphicon-earphone"></span>Phone number:</label>
                                            <input type="text" class="form-control" name="phoneNumber" value="">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="email"><span class="glyphicon glyphicon-envelope"></span>Email:</label>
                                        <input type="email" class="form-control" name="email" value="">
                                    </div>
                                    <div class="form-group">
                                        <label for="password"><span class="glyphicon glyphicon-eye-open"></span>Password:</label>
                                        <input type="password" class="form-control" name="password" value="">
                                    </div>

                                    <div class="form-group">
                                        <label for="address"><span class="glyphicon glyphicon-home"></span>Address:</label>
                                        <input type="text" class="form-control" name="address" value="">
                                    </div>
                                    <button type="submit" class="btn btn-success btn-block">
                                        Confirm
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
            <h4 style="color : red">${message}</h4>
            <table class="entity" >
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Date of birth</th>
                        <th>Phone</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Image</th>
                        <th>Role</th>
                        <th>Airline</th>
                        <th style="padding: 0 55px; min-width: 156px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    List<Accounts> accountList = (List<Accounts>) request.getAttribute("accountList");
                    RolesDAO rd = new RolesDAO();
                    for (Accounts list : accountList) {
                    %>
                    <tr>
                        <td><%= list.getName() %></td>
                        <td><%= list.getDob() %></td>
                        <td><%= list.getPhoneNumber() %></td>
                        <td><%= list.getEmail() %></td>
                        <td><%= list.getAddress() %></td>
                        <td><img src="<%= list.getImage() %>" alt="<%= list.getName() %>"></td>
                        <td><%= rd.getNameById(list.getRoleId()) %></td>
                        <td><%= list.getAirlineId() %></td>
                        <td>
                            <a class="btn btn-info" style="text-decoration: none" id="myBtn<%= list.getId() %>" onclick="openModal(<%= list.getId() %>)">Update</a>
                            <a class="btn btn-danger" style="text-decoration: none" onclick="doDelete('<%= list.getId() %>', '<%= list.getName() %>')">Delete</a>
                            <!-- Modal -->
                            <div class="modal fade" id="myModal<%= list.getId() %>" role="dialog">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header" style="padding:5px 5px;">
                                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                            <h4 style="margin-left: 12px">Update</h4>
                                        </div>
                                        <div class="modal-body" style="padding:40px 50px;">
                                            <form role="form" action="accountController" method="post">
                                                <input type="hidden" name="action" value="update"/>

                                                <div class="row">
                                                    <div class="form-group col-md-2">
                                                        <label for="usrname"><span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                        <input type="text" class="form-control" id="usrname" name="id" value="<%= list.getId() %>" readonly="">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="image<%= list.getId() %>"><span class="glyphicon glyphicon-picture"></span>Avatar:</label>
                                                        <input type="file" class="form-control" name="image">
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <img src="<%= list.getImage() %>" alt="Avatar" class="img-thumbnail" style="width: 100px; height: 100px; float: right;">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-3">
                                                        <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Role:</label></div>
                                                        <select name="roleId" value="<%= list.getRoleId() %>" style="height:  34px">
                                                            <option value="1" <%= (list.getRoleId() == 1) ? "selected" : "" %>>Admin</option>
                                                            <option value="2" <%= (list.getRoleId() == 2) ? "selected" : "" %>>Member</option>
                                                            <option value="3" <%= (list.getRoleId() == 3) ? "selected" : "" %>>Airline staff</option>
                                                            <option value="4" <%= (list.getRoleId() == 4) ? "selected" : "" %>>Service staff</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group col-md-9">
                                                        <label for="name<%= list.getId() %>"><span class="glyphicon glyphicon-user"></span>Name:</label>
                                                        <input type="text" class="form-control" name="name" value="<%= list.getName() %>">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label for="dob<%= list.getId() %>"><span class="glyphicon glyphicon-calendar"></span>Date of birth:</label>
                                                        <input type="date" class="form-control" name="dob" value="<%= list.getDob() %>" required>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="phoneNumber<%= list.getId() %>"><span class="glyphicon glyphicon-earphone"></span>Phone number:</label>
                                                        <input type="text" class="form-control" name="phoneNumber" value="<%= list.getPhoneNumber() %>">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="email<%= list.getId() %>"><span class="glyphicon glyphicon-envelope"></span>Email:</label>
                                                    <input type="email" class="form-control" name="email" value="<%= list.getEmail() %>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="password<%= list.getId() %>"><span class="glyphicon glyphicon-eye-open"></span>Password:</label>
                                                    <input type="password" class="form-control" name="password" value="<%= list.getPassword() %>">
                                                </div>

                                                <div class="form-group">
                                                    <label for="address<%= list.getId() %>"><span class="glyphicon glyphicon-home"></span>Address:</label>
                                                    <input type="text" class="form-control" name="address" value="<%= list.getAddress() %>">
                                                </div>
                                                <button type="submit" class="btn btn-success btn-block">
                                                    Confirm
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
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
                if (confirm("Bạn có muốn xoá tài khoản với tên là " + name)) {
                    window.location = "accountController?action=remove&idAcc=" + id;
                }
            }
            $(document).ready(function () {
                $("#myBtn").click(function () {
                    $("#myModal").modal();
                });
            });
        </script>
    </body>
</html>