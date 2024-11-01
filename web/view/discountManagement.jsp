<%-- 
    Document   : discountManagement
    Created on : Oct 19, 2024, 3:43:59 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Discount"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/styleAdminController.css"/>
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/styleAdminController.css"/>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleFlightManagement.css">
        <link rel="stylesheet" href="css/styleToastNotification.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="js/toastrNotification.js"></script>
        <style>
            :root {
                --flyezyMainColor: rgb(60, 110, 87);
            }

            table.entity {
                border-collapse: collapse;
                border: 1px solid #ddd;
                font-family: Arial, sans-serif;
            }

            table.entity thead {
                background-color: #f2f2f2;
            }

            table.entity th,
            table.entity td {
                border: 1px solid #ddd;
                padding: 6px;
                text-align: center;
                padding-top: 10px;
                padding-bottom: 10px;
                word-wrap: break-word;
                font-size: 14px;
            }

            table.entity th {
                background-color: var(--flyezyMainColor);
                color: white;
            }

            table.entity td img {
                height: 80px;
                width: 80px;
                object-fit: cover;
            }

            table.entity td a {
                text-decoration: none;
                margin-right: 10px;
            }

            table.entity td a:hover {
                text-decoration: underline;
            }


            .filterController{
                font-size: 14px;
                float:left
            }

            .filterController button{
                padding: 6px;
            }

            .filterElm{
                margin-right: 15px;
                padding: 0.3%;
            }

            .box {
                margin: 100px auto;
                box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.1), 0 0 1px 0 rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                padding: 35px !important;
                font-size: 16px;
                width: max-content;
            }

            .editor{
                padding-left: 20px;
            }



        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div class="container">
            <div style="display: flex; margin-top: 100px">
                <button type="button" style="position: relative; left: 210px; top: 15px; transition: none; cursor: default;" class="btn btn-success" data-toggle="modal" data-target="#add-<%=request.getAttribute("did")%>" >Add New Discount</button>
            </div>
        </div>
        <div class="container">
            <table class="entity" style="margin-left: 210px; margin-top: 100px" border="1" >

                <thead>
                    <tr>
                        <th style="width: 40px;">ID</th>
                        <th style="width: 147.484px;">percentage</th>
                        <th style="width: 331.562px;">Status</th>
                        <th style="width: 337.344px; transform: translate(0px, 0px);">Action</th>
                    </tr>
                </thead>
                <%
            List<Discount> ls = (List<Discount>) request.getAttribute("discountlist");
            for(Discount discount : ls){
                %>
                <tbody>
                    <tr>

                        <td><%= discount.getId()%></td>
                        <td><%= discount.getPercentage() %></td>
                        <td>Activated</td>
                        <td>
                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#update-<%=discount.getId()%>" >
                                Update
                            </button>
                        </td>
                    </tr>
                </tbody>
                <!-- Modal update flight details -->
                <div class="modal fade" id="update-<%=discount.getId()%>" tabindex="-1" aria-labelledby="updateDiscountModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content" >
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateFlightModalLabel">Update Discount</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="updateDiscountForm" method="POST" action="discountManagement?action=update">
                                    <div class="col-md-6">
                                        <label for="id" class="form-label">ID: </label>
                                        <input type="number" id="id" name="id" value="<%=discount.getId()%>"><br/>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="Percentages" class="form-label">Percentages: </label>
                                        <input type="number" id="Percentages" name="Percentages" value="<%=discount.getPercentage()%>"><br/>
                                    </div>
                            </div>
                            <div class="modal-footer" style="height: 71px; transform: translate(0px, 60px); transition: none; cursor: move;">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button id="submitbtn-<%=discount.getId()%>" type="submit" class="btn btn-primary">Update Flight</button>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
                <%}%>
                <!-- Modal to Add Flight Detail -->
                <div class="modal fade" id="add-<%=request.getAttribute("did")%>" tabindex="-1" role="dialog" aria-labelledby="addDiscountModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="height: 146px; transition: none; cursor: move;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addDiscountModalLabel">Add New Discount</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                </button>
                            </div>
                            <form action="Discount" method="POST">
                                <div class="modal-body">
                                    <form id="addDiscountForm" method="post" action="discountManagement?action=update">
                                        <div class="col-md-6">
                                            <label for="id" class="form-label">ID: </label>
                                            <input type="number" id="id" name="id"><br/>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="Percentages" class="form-label">Percentages: </label>
                                            <input type="number" id="Percentages" name="Percentages"><br/>
                                        </div>
                                </div>
                                <div class="modal-footer" style="height: 71px; transform: translate(0px, 60px); transition: none; cursor: move;">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" id="submitbtn" name="action" value="add" class="btn btn-primary">Add Flight Detail</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                </body>
            </table>
        </div>

</html>
