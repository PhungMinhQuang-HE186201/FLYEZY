<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.SeatCategory"%>
<%@page import="dal.SeatCategoryDAO"%>
<%@page import="dal.StatusDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý loại máy bay</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
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
        <div id="main-content">
            <!-- DuongNT: Filter category of plane -->
            <div class="filterController" style="width: 100%">
                <form action="planeCategoryController" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="search">
                    <strong class="filterElm">Status:</strong>
                    <select class="filterElm" name="fStatus">
                        <option value="" ${param.fStatus == null ? 'selected' : ''}>All</option>
                        <option value="1" ${param.fStatus != null && (param.fStatus==1) ? 'selected' : ''}>Activated</option>
                        <option value="2" ${param.fStatus != null && (param.fStatus==2) ? 'selected' : ''}>Deactivated</option>
                    </select>
                    <strong>Name: </strong>
                    <input class="filterElm" type="text" name="fName" value="${param.fName}" placeholder="Enter name">
                    <button class="btn btn-info" type="submit" >
                        Search
                    </button>
                    <a class="btn btn-danger" href="planeCategoryController">Cancle</a>
                </form>
            </div>

            <div>
                <a class="btn btn-success" style="text-decoration: none; margin-bottom: 20px" onclick="openModal(0)">Add New Plane Category</a>
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
                                    <input type="hidden" class="form-control" name="status" value="1"/>
                                    <div class="form-group col-md-6">
                                        <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                        <input type="file" class="form-control" name="image" onchange="displayImage(this)">
                                    </div>
                                    <div class="col-md-6">
                                        <img  id="previewImage" src="#" alt="Preview"
                                              style="display: none;  width: 100%; height: 100%; float: right;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                    <input type="text" class="form-control" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label><span class="glyphicon glyphicon-info-sign"></span>Info:</label>
                                    <div class="editor-container">
                                        <textarea class="editor" name="info"></textarea>
                                    </div>
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
                        <th>Information</th>
                        <th>Status</th>
                        <th style="padding: 0 55px; min-width: 380px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    SeatCategoryDAO scd = new SeatCategoryDAO();
                    StatusDAO sd = new StatusDAO();
                    List<PlaneCategory> planeCategoryList = (List<PlaneCategory>) request.getAttribute("planeCategoryList");
                    for (PlaneCategory pc : planeCategoryList) {
                    %>
                    <tr>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>"><%= pc.getName() %></td>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>"><img style="width: 100%" src="<%= pc.getImage() %>" alt="<%= pc.getName() %>"></td>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>"><div style="max-height:  100px; text-align: left;padding-left: 20px; overflow-y: scroll;"><%= pc.getInfo() %></div></td>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>">
                            <a class="btn <%= (pc.getStatusId() == 1) ? "btn-success" : "btn-danger" %>" style="text-decoration: none; width: 100px;margin: 0" 
                               onclick="changePlaneCategoryStatus('<%= pc.getId() %>', '<%= pc.getName() %>', '<%= pc.getStatusId() %>')">
                                <%= (pc.getStatusId() == 1) ? "Activated" : "Deactivated" %>
                            </a>
                        </td>
                        <td style="background-color:  <%= (pc.getStatusId() == 1) ? "" : "#ccc" %>">
                            <a class="btn btn-info" style="text-decoration: none" onclick="openModal(<%= pc.getId() %>)">Update</a>

                            <a class="btn btn-warning" style="text-decoration: none" onclick="openSeatCategoryDashboard(<%= pc.getId() %>)" >Seat Category Setting
                                <span id="arrow<%= pc.getId() %>" style="margin-left: 8px" class="glyphicon glyphicon-menu-down"></span>
                            </a>
                        </td>
                    </tr>
                    <!-- For seat category -->
                    <tr id="seatCategoryDashboard<%= pc.getId() %>" style="display: none">
                        <td colspan="5">
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
                                            <h4 style="float:left;margin-left: 12px">Add New Seat Category</h4>
                                        </div>
                                        <div class="modal-body" style="padding:40px 50px;">
                                            <form role="form" action="seatCategoryController" method="post">
                                                <div class="row">
                                                    <input type="hidden" value="<%= pc.getId() %>" name="planeCategoryId"/>
                                                    <input type="hidden" value="1" name="status"/>
                                                    <div class="form-group col-md-2">
                                                        <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                        <input type="text" class="form-control" name="id" readonly>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                                        <input type="file" class="form-control" name="image" onchange="displayImage1(this)">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <img  id="previewImage1" src="#" alt="Preview"
                                                              style="display: none; height: 100%; float: right;">

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                                    <input type="text" class="form-control" name="name" required/>
                                                </div>
                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-picture"></span>Number of seat:</label>
                                                    <input type="number" class="form-control" name="numberOfSeat" required>
                                                </div>
                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-picture"></span>Surcharge:</label>
                                                    <input step="0.01" type="number" class="form-control" name="surcharge" required>
                                                </div>
                                                <div class="form-group">
                                                    <label><span class="glyphicon glyphicon-info-sign"></span>Info:</label>
                                                    <div class="editor-container">
                                                        <textarea class="editor" name="info"></textarea>
                                                    </div>
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
                                        <th>Surcharge</th>
                                        <th>Info</th>
                                        <th>Status</th>
                                        <th style="padding: 0 55px; min-width: 156px">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    StatusDAO sdao = new StatusDAO();
                                    List<SeatCategory> seatCategoryList = scd.getAllSeatCategoryByPlaneCategoryId(pc.getId());
                                    for (SeatCategory sc : seatCategoryList) {
                                    %>
                                    <tr>
                                        <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><%= sc.getName() %></td>
                                        <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><img src="<%= sc.getImage() %>" alt="<%= sc.getName() %>"></td>
                                        <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><%= sc.getNumberOfSeat() %></td>
                                        <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><%= sc.getSurcharge() %></td>
                                        <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>"><div style="max-height:  100px; text-align: left; overflow-y: scroll; padding-left: 20px;"><%= sc.getInfo() %></div></td>
                                        <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>">
                                            <a class="btn <%=(sc.getStatusId() == 1) ? "btn-success" : "btn-danger"%>" 
                                               style="text-decoration: none; width: 100px; margin: 0" 
                                               <% if (pc.getStatusId() == 1) { %> 
                                               onclick="changeSeatCategoryStatus('<%= sc.getId() %>', '<%= sc.getName() %>', '<%= sc.getStatusId() %>')" 
                                               <% } %>
                                                >
                                                <%= (sc.getStatusId() == 1) ? "Activated" : "Deactivated" %>
                                            </a>
                                        </td>
                                        <td style="background-color:  <%= (sc.getStatusId() == 1) ? "" : "#ccc" %>">
                                            <a class="btn btn-info" style="text-decoration: none" onclick="openModalSeatCategory('<%= sc.getId() %>')">Update</a>



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
                                                        <input type="hidden" value="<%= sc.getStatusId() %>" name="status"/>

                                                        <div class="form-group col-md-2">
                                                            <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                            <input type="text" class="form-control" name="id" value="<%= sc.getId() %>" readonly>
                                                        </div>
                                                        <div class="form-group col-md-4">
                                                            <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                                            <input type="file" class="form-control" name="image" onchange="displayImage3(this,<%= sc.getId() %>)">
                                                        </div>
                                                        <div class="form-group col-md-4">
                                                            <img id="hideImage1<%= sc.getId() %>" src="<%= sc.getImage() %>" alt="Image" class="img-thumbnail" style="width: 100px; height: 100px; float: right;">
                                                            <img id="preImage3<%= sc.getId() %>" src="#" alt="Preview" style="display: none; width: 100px; height: 100px; float: right;">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label><span class="glyphicon glyphicon-user"></span>Name:</label>
                                                        <input type="text" class="form-control" name="name" value="<%= sc.getName() %>" required/>
                                                    </div>
                                                    <div class="form-group">
                                                        <label><span class="glyphicon glyphicon-picture"></span>Number of seat:</label>
                                                        <input type="text" class="form-control" name="numberOfSeat" value="<%= sc.getNumberOfSeat() %>" required/>
                                                    </div>
                                                    <div class="form-group">
                                                        <label><span class="glyphicon glyphicon-picture"></span>Surcharge:</label>
                                                        <input type="number" step="0.01" class="form-control" name="surcharge" value="<%= sc.getSurcharge() %>" required/>
                                                    </div>
                                                    <div class="form-group">
                                                        <label><span class="glyphicon glyphicon-info-sign"></span>Info:</label>
                                                        <div class="editor-container">
                                                            <textarea type="text" class="editor" name="info" ><%= sc.getInfo() %></textarea>
                                                        </div>
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
                            <input type="hidden" class="form-control" name="status" value="<%= pc.getStatusId() %>"/>
                            <div class="form-group col-md-2">
                                <label> <span class="glyphicon glyphicon-globe"></span>ID:</label>
                                <input type="text" class="form-control" name="id" value="<%= pc.getId() %>" readonly>
                            </div>
                            <div class="form-group col-md-7">
                                <label><span class="glyphicon glyphicon-picture"></span>Image:</label>
                                <input type="file" class="form-control" name="image" onchange="displayImage2(this,<%= pc.getId() %>)">
                            </div>
                        </div>
                        <div class="form-group">
                            <img id="hideImage<%= pc.getId() %>" src="<%= pc.getImage() %>" alt="Avatar" class="img-thumbnail" style="height: 100%; float: right;">
                            <img id="preImage2<%= pc.getId() %>" src="#" alt="Preview" style="display: none; width: 100%">
                        </div>
                        <div class="form-group">
                            <label><span class="glyphicon glyphicon-picture"></span>Name:</label>
                            <input type="text" class="form-control" name="name" value="<%= pc.getName() %>" required/>
                        </div>
                        <div class="form-group">
                            <label><span class="glyphicon glyphicon-info-sign"></span>Info:</label>
                            <div class="editor-container">
                                <textarea type="text" class="editor" name="info"><%= pc.getInfo() %></textarea>
                            </div>

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
<!-- Modal change status plane category -->
<div class="modal fade" id="changePlaneCategoryStatusModal" tabindex="-1" aria-labelledby="changePlaneCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePlaneCategoryModalLabel">Confirm <span id="status1"></span> plane category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Do you want to <span style="font-weight: bold" id="status2"></span><span id="planeCategoryName"></span>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="confirmChangeStatusPlaneCategory">Confirm</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal change status seat category -->

<div class="modal fade" id="changeSeatCategoryStatusModal" tabindex="-1" aria-labelledby="deleteSeatCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteSeatCategoryModalLabel">Confirm <span id="status3"></span> seat category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Do you want to <span style="font-weight: bold" id="status4"></span><span id="seatCategoryName"></span>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="confirmChangeSeatCategoryStatus">Confirm</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancle</button>
            </div>
        </div>
    </div>
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
    function openSeatCategoryDashboard(id) {
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

    //func change plane category status
    let changePlaneCategoryStatusUrl = "";
    function changePlaneCategoryStatus(id, name, status) {
        // Cập nhật tên loại máy bay trong modal
        document.getElementById('planeCategoryName').textContent = name;
        let statusText = (status === "1") ? "deactivate" : "activate";
        document.getElementById('status1').textContent = statusText;
        document.getElementById('status2').textContent = statusText;

        changePlaneCategoryStatusUrl = "planeCategoryController?action=changeStatus&id=" + id;

        $('#changePlaneCategoryStatusModal').modal('show');
    }
    document.getElementById('confirmChangeStatusPlaneCategory').onclick = function () {
        window.location = changePlaneCategoryStatusUrl;
    };


    // func change seat category status
    let changeSeatCategoryStatusUrl = "";
    function changeSeatCategoryStatus(id, name, status) {
        document.getElementById('seatCategoryName').textContent = name;
        let statusText = (status === "1") ? "deactivate" : "activate";
        console.log(statusText);
        document.getElementById('status3').textContent = statusText;
        document.getElementById('status4').textContent = statusText;

        changeSeatCategoryStatusUrl = "seatCategoryController?action=changeStatus&id=" + id;

        $('#changeSeatCategoryStatusModal').modal('show');
    }

    document.getElementById('confirmChangeSeatCategoryStatus').onclick = function () {
        window.location = changeSeatCategoryStatusUrl;
    };


    window.onload = function () {
        if (window.location.protocol === 'file:') {
            alert('This sample requires an HTTP server. Please serve this file with a web server.');
        }
    };
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
    function displayImage1(input) {
        var previewImage = document.getElementById("previewImage1");
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
    function displayImage3(input, id) {
        var i = id;
        var hideImage = document.getElementById(`hideImage1` + i);
        var previewImage2 = document.getElementById(`preImage3` + i);
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

<script type="importmap">
    {
    "imports": {
    "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.js",
    "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.1.0/"
    }
    }
</script>
<script type="module">
    import {
    ClassicEditor,
            Essentials,
            Paragraph,
            Bold,
            Italic,
            Font,
            List
    } from 'ckeditor5';
    document.querySelectorAll('.editor').forEach((editorElement) => {
        ClassicEditor
                .create(editorElement, {
                    plugins: [Essentials, Paragraph, Bold, Italic, Font, List],
                    toolbar: [
                        'undo', 'redo', '|', 'bold', 'italic', '|',
                        'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor',
                        '|', 'bulletedList', 'numberedList'
                    ]
                })
                .then(editor => {
                    console.log('Editor initialized:', editor);
                })
                .catch(error => {
                    console.error(error);
                });
    });
</script>
</body>
</html>