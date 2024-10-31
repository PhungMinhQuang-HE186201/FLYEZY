<%-- 
    Document   : admin
    Created on : May 14, 2024, 9:11:02 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="dal.AccountsDAO"%>
<%@page import="static controller.EncodeController.SECRET_KEY" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Accounts"%>
<%@page import="model.Feedbacks"%>
<%@page import="model.Status"%>
<%@page import="model.Refund"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.RefundDAO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Management</title>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <link rel="stylesheet" href="css/styleToastNotification.css">
        <script src="js/validation.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="js/toastrNotification.js"></script>

        <style>
            .modal-body{
                text-align: left
            }
            .modal-body span{
                margin-right: 5px
            }
            #myBtn{
                display: flex;
            }
        </style>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div id="main-content" style="padding:15vh 0vw 15vh 16vw; margin: 0">
            <div class="filterController col-md-12" style="width: 100%">
                <form action="RefundController" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="search">
                    <input type="hidden" name="orderId" value="${orderId}">
                    <strong class="filterElm">Status:</strong>
                    <select class="filterElm" name="fStaus">
                        <option value="" ${param.fStaus == null ? 'selected' : ''}>All</option>
                        <c:forEach items="${statusList}" var="status">
                            <option value="${status.id}" ${param.fStaus != null && (param.fStaus==status.id) ? 'selected' : ''}>${status.name}</option>
                        </c:forEach>
                    </select>
                    <strong>Request Date from :</strong>
                    <input class="filterElm" type="date" name="fDateFrom" value="${param.fDateFrom}" placeholder="Enter Email">
                    <strong>Request Date to :</strong>
                    <input class="filterElm" type="date" name="fDateTo" value="${param.fDateTo}" placeholder="Enter Email">
                    <strong>Refund Date from :</strong>
                    <input class="filterElm" type="date" name="fDateFrom1" value="${param.fDateFrom1}" placeholder="Enter Email">
                    <strong>Refund Date to :</strong>
                    <input class="filterElm" type="date" name="fDateTo1" value="${param.fDateTo1}" placeholder="Enter Email">
                    <button class="btn btn-info" type="submit">
                        Search
                    </button>
                    <a class="btn btn-danger" href="RefundController">Cancel</a>
                </form>


            </div>
            <h4 style="color : red">${message}</h4>
            <table class="entity" >
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Bank Name</th>
                        <th>Bank Account</th>
                        <th>Request Date</th>
                        <th>Refund Date</th>
                        <th>Ticket ID</th>
                        <th>Status</th>
                        <th style="padding: 0 55px; min-width: 156px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                      StatusDAO sd = new StatusDAO();
                      RefundDAO rd = new RefundDAO();
                      List<Refund> list = (List<Refund>)request.getAttribute("refundList");
                      for(Refund r : list){
                    %>
                    <tr>
                        <td><%=r.getId()%></td>
                        <td><%=r.getBank()%></td>
                        <td><%=r.getBankAccount()%></td>
                        <td><%=r.getRequestDate()%></td>
                        <td><%=r.getRefundDate()%></td>
                        <td><%=r.getTicketid()%></td>
                        <td><%=sd.getStatusNameById(r.getStatusid())%></td>
                        <td>
                            <a class="btn btn-info" style="text-decoration: none" id="myBtn<%= r.getId() %>" onclick="openModal(<%= r.getId() %>)">Change status</a>
                            <div class="modal fade" id="myModal<%= r.getId() %>" role="dialog">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header" style="padding:5px 5px;">
                                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                            <h4 style="margin-left: 12px">Change status</h4>
                                        </div>
                                        <div class="modal-body" style="padding:40px 50px;">
                                            <form role="form" action="RefundController" method="post">
                                                <input type="hidden" name="action" value="changeStatus"/>
                                                <input type="hidden" name="refundId" value="<%=r.getId()%>">
                                                <input type="hidden" name="createdAt" value=""/>
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <label for="usrname"><span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                        <input type="text" class="form-control" id="usrname" name="id" value="<%= r.getId() %>" readonly="">
                                                    </div>
                                                    <div class="form-group col-md-8">
                                                        <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Status:</label></div>
                                                        <select name="statusID" value="" style="height:  34px">
                                                            <%List<Status> statusList = (List<Status>)request.getAttribute("statusList");
                                                            for(Status status : statusList){%>
                                                            <option value="<%=status.getId()%>" <%=(r.getStatusid() == status.getId())?"selected":""%>><%=status.getName()%></option>"
                                                            <%}%>
                                                        </select>
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
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
            <div style="">
                <nav aria-label="...">
                    <ul class="pagination">
                        <c:if test="${index != 1}">    
                            <li class="page-item">
                                <a class="page-link" href="accountController?index=${index -1}">Previous</a>
                            </li>
                        </c:if>    
                        <c:forEach begin="1" end ="${numOfPage}" var="i">
                            <c:if test="${index == i}">
                                <li class="page-item active">
                                    <a class="page-link" href="accountController?index=${i}">${i}</a>
                                </li>
                            </c:if>

                            <c:if test="${index != i}">
                                <li class="page-item">
                                    <a class="page-link" href="accountController?index=${i}">${i}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${index != numOfPage}">    
                            <li class="page-item">
                                <a class="page-link" href="accountController?index=${index +1}">Next</a>
                            </li>
                        </c:if> 
                    </ul>
                </nav>
            </div>
        </div>

        <!-- change status Modal -->
        <div id="statusModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm account status change account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="modalMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="confirmChangeStatusBtn">Confirm</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>


        <script>
            function openModal(id) {
                $("#myModal" + id).modal('show');
            }
            function doActivateDeactivate(id, name, action) {
                document.getElementById('modalMessage').innerHTML = "Are you sure you want to " + action + " the account <strong>" + name + "</strong>?";

                const confirmChangeStatusBtn = document.getElementById('confirmChangeStatusBtn');
                confirmChangeStatusBtn.onclick = function () {
                    window.location = "accountController?action=changeStatus&idAcc=" + id;
                };
                $('#statusModal').modal('show');
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

            $(document).ready(function () {
            <% if (request.getAttribute("result") != null) { %>
                successful("<%= request.getAttribute("result").toString()%>");
            <% } %>

            });
        </script>

    </body>
</html>