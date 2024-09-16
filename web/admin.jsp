<%-- 
    Document   : admin
    Created on : May 14, 2024, 9:11:02 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tài khoản</title>
        <link rel="shortcut icon" type="image/jpg" href="image/logo-icon.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


    </head>
    <body>

        <div id="main-content">
            <div class="row" style="padding: 50px 0; margin: 0">
                <div class="col-md-10" id="left-column">
                    <div class="filterController">
                        <form action="accountController" method="get" style="margin-bottom: 20px;">
                            <input type="hidden" name="action" value="search">
                            <strong class="filterElm">Role:</strong>
                            <select class="filterElm" name="fRole">
                                <option value="" ${param.fRole == null ? 'selected' : ''}>All</option>
                                <option value="admin" ${param.fRole != null && param.fRole.equals("admin") ? 'selected' : ''}>Admin</option>
                                <option value="user" ${param.fRole != null && param.fRole.equals("user") ? 'selected' : ''}>User</option>
                            </select>

                            <strong>Name: </strong>
                            <input class="filterElm" type="text" name="fName" value="${fName}" placeholder="Enter name">
                            <strong>Phone number: </strong>
                            <input class="filterElm" type="number" name="fPhoneNumber" value="${fPhoneNumber}" placeholder="Enter phone number">
                            <button class="entity-update" type="submit" style="width: 60px" >
                                <i class="ti-search"></i>
                                <a href="accountController?action=search">Lọc</a>
                            </button>
                            <a class="entity-delete" href="accountController">Huỷ</a>
                        </form>
                    </div>
                    <div class="vehicleCatChart">
                        <canvas id="myChart" style="width:100%;max-width:700px;margin:0 auto"></canvas>
                    </div>

                    <table class="entity" >
                        <thead>
                            <tr>
                                <th>Uname</th>
                                <th>Pass</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Image</th>
                                <th style="padding: 0 55px; min-width: 156px">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${accountList}" var="list">
                                <tr>
                                    <td>${list.name}</td>
                                    <td>${list.password}</td>
                                    <td>${list.phoneNumber}</td>
                                    <td>${list.address}</td>
                                    <td><img src="${list.image}" alt="${list.name}"></td>

                                    <td>
                                        <!-- Trigger the modal with a button -->
                                        <a class="btn btn-info" id="myBtn${list.id}" onclick="openModal(${list.id})">Update</a>
                                        <a class="btn btn-danger" href="accountController?action=remove&idAcc=${list.id}">Delete</a>
                                        <!-- Modal -->
                                        <div class="modal fade" id="myModal${list.id}" role="dialog">
                                            <div class="modal-dialog">

                                                <!-- Modal content-->
                                                <div class="modal-content">
                                                    <div class="modal-header" style="padding:5px 5px;">
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                        <h4><span class=""></span> Update</h4>
                                                    </div>
                                                    <div class="modal-body" style="padding:40px 50px;">
                                                        <form role="form">

                                                            <div class="form-group">
                                                                <label for="usrname"><span class="glyphicon glyphicon-user"></span>ID</label>
                                                                <input type="text" class="form-control" id="usrname" name="id" value="${list.id}" readonly="">
                                                            </div>
                                                            <div class="form-group">
                                                                <div><label for="usrname"><span class="glyphicon glyphicon-user"></span>Role</label></div>
                                                                <select class="filterElm" name="roleId" value="">
                                                                    <option value="1" ${roleId == 1 ? 'selected' : ''}>Admin</option>
                                                                    <option value="2" ${roleId == 2 ? 'selected' : ''}>Member</option>
                                                                    <option value="3" ${roleId == 3 ? 'selected' : ''}>Airline staff</option>
                                                                    <option value="4" ${roleId == 4 ? 'selected' : ''}>Service staff</option>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="name${list.id}"><span class="glyphicon glyphicon-user"></span>Name</label>
                                                                <input type="text" class="form-control" id="name${list.id}" name="name" value="${list.name}">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="email${list.id}"><span class="glyphicon glyphicon-envelope"></span>Email</label>
                                                                <input type="email" class="form-control" id="email${list.id}" name="email" value="${list.email}">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="password${list.id}"><span class="glyphicon glyphicon-eye-open"></span>Password</label>
                                                                <input type="password" class="form-control" id="password${list.id}" name="password" value="${list.password}">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="phoneNumber${list.id}"><span class="glyphicon glyphicon-earphone"></span>Phone number</label>
                                                                <input type="text" class="form-control" id="phoneNumber${list.id}" name="phoneNumber" value="${list.phoneNumber}">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="address${list.id}"><span class="glyphicon glyphicon-home"></span>Address</label>
                                                                <input type="text" class="form-control" id="address${list.id}" name="address" value="${list.address}">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="dob${list.id}"><span class="glyphicon glyphicon-calendar"></span>Date of birth</label>
                                                                <input type="date" class="form-control" id="dob${list.id}" name="dob" value="${list.dob}">
                                                            </div>
                                                            <button type="submit" class="btn btn-success btn-block"><span class=""></span><a href="accountController?action=update">Confirm</a></button>
                                                            <input type="hidden" name="action" value="change">
                                                        </form>
                                                    </div>
                                                </div>

                                            </div>
                                        </div> 
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                </div>

            </div>
        </div>



        <script>
            function openModal(id) {
                $("#myModal" + id).modal('show');
            }
        </script>
    </body>
</html>