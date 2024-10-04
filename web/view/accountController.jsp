<%-- 
    Document   : admin
    Created on : May 14, 2024, 9:11:02 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="dal.RolesDAO"%>
<%@page import="model.Roles"%>
<%@page import="model.Status"%>
<%@page import="model.Airline"%>
<%@page import="static controller.EncodeController.SECRET_KEY" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Accounts"%>
<%@page import="dal.AirlineManageDAO"%>
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
        <div id="main-content" style="padding:15vh 0vw 15vh 16vw; margin: 0">
            <div class="filterController col-md-12" style="width: 100%">
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
                    <button class="btn btn-info" type="submit">
                        Search
                    </button>
                    <a class="btn btn-danger" href="accountController">Cancle</a>
                </form>


            </div>

            <button type="button" class="btn btn-success" id="myBtn">Add New Account</button>
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
                                            <input type="file" class="form-control" name="image" onchange="displayImage(this)">
                                        </div>
                                        <div class="col-md-6">
                                            <img  id="previewImage" src="#" alt="Preview"
                                                  style="display: none; max-width: 130px; float: left">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Role:</label></div>
                                            <select name="roleId" value="" style="height:  34px">
                                                <%List<Roles> rolesList = (List<Roles>)request.getAttribute("rolesList");
                                                  for(Roles role : rolesList){%>
                                                <option value="<%=role.getId()%>"><%=role.getName()%></option>"
                                                <%}%>

                                            </select>
                                        </div>
                                       
                                        <div class="form-group col-md-6">
                                            <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Airline:</label></div>
                                            <select name="airlineID" value="" style="height:  34px">
                                                <%List<Airline> airlineList = (List<Airline>)request.getAttribute("airlineList");
                                                  for(Airline airline : airlineList){%>
                                                <option value="<%=airline.getId()%>"><%=airline.getName()%></option>"
                                                <%}%>
                                            </select>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label for="name"><span class="glyphicon glyphicon-user"></span>Name:</label>
                                        <input type="text" class="form-control" name="name" value="">
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
                                    <p style="color: red; font-size: 20px">${message}</p>
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
                        <th>Create at</th>
                        <th>Update at</th>
                        <th style="padding: 0 55px; min-width: 156px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    List<Accounts> accountList = (List<Accounts>) request.getAttribute("accountList");
                    RolesDAO rd = new RolesDAO();
                    SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm dd-MM-yyyy");
                    AirlineManageDAO amd = new AirlineManageDAO();
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
                        <td><%= amd.getNameById(list.getAirlineId()) %></td>
                        <td><%= list.getCreated_at() != null ? sdf.format(list.getCreated_at()) : "" %></td>
                        <td><%= list.getUpdated_at() != null ? sdf.format(list.getUpdated_at()) : "" %></td>

                        <td>
                            <a class="btn btn-info" style="text-decoration: none" id="myBtn<%= list.getId() %>" onclick="openModal(<%= list.getId() %>)">Update</a>
                            <%if(list.getStatus_id()== 1 ){%>
                            <a class="btn btn-danger" style="text-decoration: none; background-color: green;" onclick="doActivateDeactivate('<%= list.getId() %>', '<%= list.getName() %>','Deactivate')">Activated</a>
                            <%}else{%>
                            <a class="btn btn-danger" style="text-decoration: none" onclick="doActivateDeactivate('<%= list.getId() %>', '<%= list.getName() %>','Activate')">Deactivated</a>
                            <%}%>
                            <!-- Modal: Update account -->
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
                                                <input type="hidden" name="createdAt" value="<%= list.getCreated_at() %>"/>
                                                <div class="row">
                                                    <div class="form-group col-md-2">
                                                        <label for="usrname"><span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                        <input type="text" class="form-control" id="usrname" name="id" value="<%= list.getId() %>" readonly="">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="image<%= list.getId() %>"><span class="glyphicon glyphicon-picture"></span>Avatar:</label>
                                                        <input type="file" class="form-control" name="image" onchange="displayImage2(this,<%= list.getId() %>)" >
                                                    </div>                      
                                                    <div class="form-group col-md-4">
                                                        <img id="hideImage<%= list.getId() %>" src="<%= list.getImage() %>"  alt="Avatar" class="img-thumbnail" style="width: 100px; height: 100px; float: right;">
                                                        <img id="preImage2<%= list.getId() %>" src="#" alt="Preview" style="display: none; width: 100px; height: 100px; float: right;">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Role:</label></div>
                                                        <select name="roleId" value="<%= list.getRoleId() %>" style="height:  34px">
                                                            <%
                                                            for(Roles role : rolesList){%>
                                                            <option value="<%=role.getId()%>" <%= (list.getRoleId() == role.getId()) ? "selected" : "" %>><%=role.getName()%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Role:</label></div>
                                                        <select name="airlineID" value="<%= list.getAirlineId()%>" style="height:  34px">
                                                            <%
                                                            for(Airline airline : airlineList){%>
                                                            <option value="<%=airline.getId()%>" <%= (list.getAirlineId() == airline.getId()) ? "selected" : "" %>><%=airline.getName()%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name<%= list.getId() %>"><span class="glyphicon glyphicon-user"></span>Name:</label>
                                                    <input type="text" class="form-control" name="name" value="<%= list.getName() %>">
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-6">
                                                        <label><span class="glyphicon glyphicon-calendar"></span>Date of birth:</label>
                                                        <input type="date" class="form-control" name="dob" value="<%= list.getDob() %>" required>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label><span class="glyphicon glyphicon-earphone"></span>Phone number:</label>
                                                        <input type="text" class="form-control" name="phoneNumber" value="<%= list.getPhoneNumber() %>" readonly>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-envelope"></span>Email:</label>
                                                    <input type="email" class="form-control" name="email" value="<%= list.getEmail() %>" readonly>
                                                </div>
                                                <div class="form-group">
                                                    <!--                                                    <label><span class="glyphicon glyphicon-eye-open"></span>Password:</label>-->
                                                    <input type="hidden" class="form-control" name="password" value="<%= rd.decryptAES(list.getPassword(),SECRET_KEY) %>">
                                                </div>

                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-home"></span>Address:</label>
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

        <!-- delete Modal -->
        <div id="deleteModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Xác nhận chuyển trạng thái tài khoản tài khoản</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="modalMessage">Bạn có chắc chắn muốn xóa tài khoản <strong></strong>?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Xác nhận</button>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function openModal(id) {
                $("#myModal" + id).modal('show');
            }
            function doDelete(id, name) {
                // Hiển thị thông tin tài khoản cần xoá trong modal
                document.getElementById('modalMessage').innerHTML = "Bạn có chắc chắn muốn xóa tài khoản <strong>" + name + "</strong>?";

                // Lưu ID của tài khoản để sử dụng sau khi xác nhận xóa
                const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
                confirmDeleteBtn.onclick = function () {
                    // Chuyển hướng tới trang xử lý xoá tài khoản
                    window.location = "accountController?action=remove&idAcc=" + id;
                };

                // Hiển thị modal
                $('#deleteModal').modal('show');
            }
            function doActivateDeactivate(id, name,action) {
                // Hiển thị thông tin tài khoản cần xoá trong modal
                document.getElementById('modalMessage').innerHTML = "Bạn có chắc chắn muốn "+ action +" tài khoản <strong>" + name + "</strong>?";

                // Lưu ID của tài khoản để sử dụng sau khi xác nhận xóa
                const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
                confirmDeleteBtn.onclick = function () {
                    // Chuyển hướng tới trang xử lý xoá tài khoản
                    window.location = "accountController?action=changeStatus&idAcc=" + id;
                };

                // Hiển thị modal
                $('#deleteModal').modal('show');
            }
            $(document).ready(function () {
                $("#myBtn").click(function () {
                    $("#myModal").modal();
                });
            });
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
            function displayImage2(input, id) {
                var i = id;
                var hideImage = document.getElementById(`hideImage` + i);
                var previewImage2 = document.getElementById(`preImage2` + i);
                var file = input.files[0];
                var reader = new FileReader();

                console.log(hideImage, previewImage2);

                reader.onload = function (e) {
                    hideImage.style.display = "none";
                    previewImage2.src = e.target.result;
                    previewImage2.style.display = "block";
                };

                reader.readAsDataURL(file);
            }
        </script>

    </body>
</html>