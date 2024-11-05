<%-- 
    Document   : discountManagement
    Created on : Oct 19, 2024, 3:43:59 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Discount"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="model.Status"%>
<%@page import="model.Airline"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.DiscountDAO"%>
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
        <%
             int id = (int)request.getAttribute("did");
        %>
        <div class="container">
            <div style="display: flex; margin-top: 100px">
                <button type="button" style="position: relative; left: 210px; top: 15px; transition: none; cursor: default;" class="btn btn-success" data-toggle="modal" data-target="#add-<%=id%>" >Add New Discount</button>
            </div>
        </div>
        <div class="container">
            <table class="entity" style="margin-left: 210px; margin-top: 50px" border="1" >

                <thead>
                    <tr>
                        <th style="width: 147.484px;">Code</th>
                        <th style="width: 147.484px;">Percentage</th>
                        <th style="width: 337.344px; transform: translate(0px, 0px);">Minimum order</th>
                        <th style="width: 337.344px; transform: translate(0px, 0px);">Date</th>
                        <th style="width: 337.344px; transform: translate(0px, 0px);">Until</th>
                        <th style="width: 337.344px; transform: translate(0px, 0px);">Airline</th>
                        <th style="width: 337.344px; transform: translate(0px, 0px);">Status</th>
                        <th style="width: 337.344px; transform: translate(0px, 0px);">Action</th>
                    </tr>
                </thead>
                <%
                    DiscountDAO dd = new DiscountDAO();
            List<Discount> ls = (List<Discount>) request.getAttribute("discountlist");
            for(Discount discount : ls){
                %>
                <tbody>
                    <tr>
                        <td><%= discount.getCode()%></td>
                        <td><%= discount.getPercentage() %>%</td>
                        <td><%= discount.getMin_order() %></td>
                        <td><%= discount.getDate_created() %></td>
                        <td><%= discount.getValid_until() %></td>
                        <td><%= dd.getAirlineNameById(discount.getAirline_id()) %></td>
                        <td>
                            <%
                                if (discount.getStatus_id() == 1) {
                            %>
                            <a class="btn btn-success" style="text-decoration: none;" onclick="doActivateDeactivate('<%= discount.getId() %>', '<%= discount.getCode() %>', 'Deactivate')">Activated</a>
                            <%
                                } else {
                            %>
                            <a class="btn btn-danger" style="text-decoration: none;" onclick="doActivateDeactivate('<%= discount.getId() %>', '<%= discount.getCode() %>', 'Activate')">Deactivated</a>
                            <%
                                }
                            %>
                        </td>
                        <td>
                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#update-<%=discount.getId()%>" >
                                Update
                            </button>
                        </td>
                    </tr>
                </tbody>
                <!-- Modal update discount details -->
                <div class="modal fade" id="update-<%=discount.getId()%>" tabindex="-1" aria-labelledby="updateDiscountModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateDiscountModalLabel">Update Discount</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="updateDiscountForm" method="POST" action="discountManagement?action=update">
                                    <div class="mb-3">
                                        <input type="hidden" id="id" name="uid" class="form-control" value="<%=discount.getId()%>" readonly>
                                        <label for="percentages" class="form-label">Code:</label>
                                        <input type="text" id="code" name="ucode" class="form-control" value="<%=discount.getCode()%>" >
                                    </div>
                                    <div class="mb-3">
                                        <label for="percentages" class="form-label">Percentage:</label>
                                        <input type="number" id="percentages1-<%=discount.getId()%>" name="percentages" class="form-control"  oninput="validatePercentage_update(<%=discount.getId()%>)" value="<%=discount.getPercentage()%>">
                                        <span id="percentageError1-<%=discount.getId()%>" style="color: red; display: none;">Percentage cannot exceed 100%</span>
                                    </div>
                                    <div class="mb-3">
                                        <label for="min_order" class="form-label">Minimum Order:</label>
                                        <input type="number" id="min_order" name="min_order" class="form-control" value="<%=discount.getMin_order()%>">
                                    </div>
                                    <div class="mb-3">
                                        <label for="date_created" class="form-label">Date Created:</label>
                                        <input type="date" id="date1-<%=discount.getId()%>" name="date_created" class="form-control" value="<%=discount.getDate_created()%>" oninput="validateDates_update(<%=discount.getId()%>)">
                                    </div>
                                    <div class="mb-3">
                                        <label for="valid_until" class="form-label">Valid Until:</label>
                                        <input type="date" id="date2-<%=discount.getId()%>" name="valid_until" class="form-control" value="<%=discount.getValid_until()%>" oninput="validateDates_update(<%=discount.getId()%>)">
                                        <div id="dateError-<%=discount.getId()%>" class="text-danger mt-1" style="display: none;">"Date Created" must be earlier than "Valid Until".</div>
                                    </div>
                                    <div class="mb-3">
                                        <input type="hidden" name="airline_id" value="<%=request.getAttribute("airlineid")%>">
                                    </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button id="submitbtn-<%=discount.getId()%>" type="submit" class="btn btn-primary">Update Discount</button>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
                <%}%>
                <!-- Modal to Add Discount -->
                <div class="modal fade" id="add-<%=id%>" tabindex="-1" role="dialog" aria-labelledby="addDiscountModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addDiscountModalLabel">Add New Discount</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form id="addDiscountForm" method="POST" action="discountManagement?action=add">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="percentages" class="form-label">Percentage:</label>
                                        <input type="number" id="percentages2-<%=id%>" name="percentages" class="form-control" oninput="validatePercentage_add(<%=id%>)" required>
                                        <span id="percentageError2-<%=id%>" style="color: red; display: none;">Percentage cannot exceed 100%</span>
                                    </div>
                                    <div class="form-group">
                                        <label for="min_order" class="form-label">Minimum Order:</label>
                                        <input type="number" id="min_order" name="min_order" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="date_created" class="form-label">Date Created:</label>
                                        <input type="date" id="date3-<%=id%>" name="date_created" class="form-control" oninput="validateDates_add(<%=id%>)">
                                    </div>
                                    <div class="mb-3">
                                        <label for="valid_until" class="form-label">Valid Until:</label>
                                        <input type="date" id="date4-<%=id%>" name="valid_until" class="form-control"  oninput="validateDates_add(<%=id%>)">
                                        <div id="Error-<%=id%>" class="text-danger mt-1" style="display: none;">"Date Created" must be earlier than "Valid Until".</div>
                                    </div>
                                    <div class="form-group">
                                        <input type="hidden" name="airline_id" value="<%=request.getAttribute("airlineid")%>">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" id="submitbtun-<%=id%>" name="action" value="add" class="btn btn-primary">Add Discount</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <script>
                    function doActivateDeactivate(id, name, action) {
                        if (confirm("Are you sure you want to " + action + " " + name + "?")) {
                            // Gửi yêu cầu đến servlet để thay đổi trạng thái
                            window.location.href = "discountManagement?action=" + action + "&id=" + id;
                        }
                    }
                </script>
                <script>
                    function validateDates_update(id) {
                        const date1 = new Date(document.getElementById('date1-' + id).value);
                        const date2 = new Date(document.getElementById('date2-' + id).value);
                        const errorMessage = document.getElementById('dateError-' + id);
                        const submitButton = document.getElementById('submitbtn-' + id);

                        if (date1 && date2 && date1 >= date2) {
                            errorMessage.style.display = 'block';
                            submitButton.disabled = true;
                        } else {
                            errorMessage.style.display = 'none';
                            submitButton.disabled = false;
                        }
                    }
                    function validateDates_add(id) {
                        const date3 = new Date(document.getElementById('date3-' + id).value);
                        const date4 = new Date(document.getElementById('date4-' + id).value);
                        const errorMessage = document.getElementById('Error-' + id);
                        const submitButton = document.getElementById('submitbtun-' + id);

                        if (date3 && date4 && date3 >= date4) {
                            errorMessage.style.display = 'block';
                            submitButton.disabled = true;
                        } else {
                            errorMessage.style.display = 'none';
                            submitButton.disabled = false;
                        }
                    }
                    function validatePercentage_add(id) {
                        const input = document.getElementById('percentages2-' + id);
                        const errorSpan = document.getElementById('percentageError2-' + id);
                        const submitBtn = document.getElementById('submitbtun-' + id);

                        if (input.value > 100 || input.value < 1) {
                            errorSpan.style.display = 'inline';
                            submitBtn.disabled = true;
                        } else {
                            errorSpan.style.display = 'none';
                            submitBtn.disabled = false;
                        }
                    }
                    function validatePercentage_update(id) {
                        const input = document.getElementById('percentages1-' + id);
                        const errorSpan = document.getElementById('percentageError1-' + id);
                        const submitBtn = document.getElementById('submitbtn-' + id);

                        if (input.value > 100 || input.value < 1) {
                            errorSpan.style.display = 'inline';
                            submitBtn.disabled = true;
                        } else {
                            errorSpan.style.display = 'none';
                            submitBtn.disabled = false;
                        }
                    }
                </script>

                </body>
            </table>
        </div>

</html>
