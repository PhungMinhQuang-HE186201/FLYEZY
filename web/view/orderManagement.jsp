<%-- 
    Document   : orderManagement
    Created on : Oct 12, 2024, 11:08:48 AM
    Author     : PMQUANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.FlightDetails"%>
<%@page import="dal.OrderDAO"%>
<%@page import="dal.FlightDetailDAO"%>
<%@page import="dal.AccountsDAO"%>
<%@page import="dal.PaymentTypeDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="dal.StatusDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Flights"%>
<%@page import="model.Order"%>
<%@page import="model.Accounts"%>
<%@page import="model.PaymentType"%>
<%@page import="model.FlightType"%>
<%@page import="model.Status"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="../css/styleAdminController.css"/>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleFlightManagement.css">
        <link rel="stylesheet" href="css/styleToastNotification.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div id="back" style="margin-left: 210px;margin-top: 60px;margin-bottom: -100px " /> 
        <a href="flightDetailManagement?flightId=${requestScope.flight.getId()}&airlineId=${requestScope.airlineId}" class="btn btn-warning" >Back</a>
        <input type="hidden" name="flightDetailID">
        <div class="filterController col-md-12" style="width: 100%">
            <form action="OrderController" method="get" style="margin-bottom: 20px;">

                <input type="hidden" name="action" value="search">
                <input type="hidden" name="flightDetailID" value="${param.flightDetailID}">

                <strong class="filterElm">Status:</strong>
                <select class="filterElm" name="status">
                    <option value="" ${param.status == null ? 'selected' : ''}>All</option>
                    <c:set var="counter" value="0" />
                    <c:forEach items="${requestScope.listStatus}" var="status">
                        <c:if test="${counter < 3}">
                            <option value="${status.id}" ${param.status != null && (param.status == status.id) ? 'selected' : ''}>${status.name}</option>
                            <c:set var="counter" value="${counter + 1}" />
                        </c:if>
                    </c:forEach>
                </select>
                <strong>Code: </strong>
                <input class="filterElm" value="${param.keyword}" type="text" pattern="^[\p{L}\s]+$" placeholder="Code ..." name="code" style="margin-left:5px"/>
                <strong>Contact: </strong>
                <input class="filterElm" value="${param.keyword}" type="text" pattern="^[\p{L}\s]+$" placeholder="Contact ..." name="keyword" style="margin-left:5px"/>
                <input type="submit" class="btn btn-info" name="submit" value="Search" style="margin-right: 5px">

                <a class="btn btn-danger" href="OrderController?flightDetailID=${param.flightDetailID}">Cancel</a>
            </form>


        </div>
        <table class="entity" style="margin-left: 1%;" >
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Contact Name</th>
                    <th>Contact Phone</th>
                    <th>Contact Mail</th>
                    <th>Total Price</th>
                    <th>Account</th>
                    <th>Payment Type</th>
                    <th>Status</th>
                    <th style="width: 25%">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                        
                    OrderDAO od = new OrderDAO();
                    AccountsDAO ad = new AccountsDAO();
                    PaymentTypeDAO ptd = new PaymentTypeDAO();
                    FlightTypeDAO ftd = new FlightTypeDAO();
                    StatusDAO sd = new StatusDAO();
                    List<Order> listOrder = (List<Order>)request.getAttribute("listOrder");
                    List<Accounts> listAcc = ad.getAllAccounts();
                        
                    if(listOrder != null){
                        for(Order o : listOrder){
                            
                        
                %>
                <tr>
                    <td><%=o.getCode()%></td>
                    <td><%=o.getContactName()%></td>
                    <td><%=o.getContactPhone()%></td>
                    <td><%=o.getContactEmail()%></td>
                    <td><%=o.getTotalPrice()%></td>
                    <% 
                        boolean found = false; 
                        for (Accounts acc : listAcc) {
                            if (acc.getId() == o.getAccountsId()) { 
                                found = true; 
                    %>
                    <td><%= (acc.getName() != null) ? acc.getName() : "null" %></td>
                    <%
                                break;
                            }
                        }
                        if (!found) {
                    %>
                    <td>null</td>
                    <% 
                        }
                    %>
                    <%String paymentName = ptd.getPaymentTypeNameById(o.getPaymentTypesId());%>
                    <td><%=paymentName%></td>

                    <td>
                        <%= sd.getStatusNameById(o.getStatus_id()) %>
                    </td>
                    <td>
                        <a class="btn btn-info" style="text-decoration: none" id="myBtn<%= o.getId() %>" onclick="openModal(<%= o.getId() %>)">Change status</a>
                        <div class="modal fade" id="myModal<%= o.getId() %>" role="dialog">
                            <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header" style="padding:5px 5px;">
                                        <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                        <h4 style="margin-left: 12px">Change status</h4>
                                    </div>
                                    <div class="modal-body" style="padding:40px 50px;">
                                        <form role="form" action="OrderController" method="post">
                                            <input type="hidden" name="action" value="changeStatus"/>
                                            <input type="hidden" name="orderId" value="<%=o.getId()%>"/>
                                            <input type="hidden" name="flightDetailId" value="<%=o.getFlightDetailId()%>"/>
                                            <input type="hidden" name="createdAt" value=""/>
                                            <div class="row">
                                                <div class="form-group col-md-4">
                                                    <label for="usrname"><span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                    <input type="text" class="form-control" id="usrname" name="id" value="<%= o.getId() %>" readonly="">
                                                </div>
                                                <div class="form-group col-md-8">
                                                    <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Status:</label></div>
                                                    <select name="statusId" value="" style="height:  34px">
                                                        <%List<Status> statusList = sd.getStatusOfOrder();
                                                            for(Status status : statusList){%>
                                                        <option value="<%=status.getId()%>" <%=(o.getStatus_id() == status.getId())?"selected":""%>><%=status.getName()%></option>"
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
                        <a href="TicketController?action=search&flightDetailID=${param.flightDetailID}&flightType=&passengerType=&statusTicket=&fName=&fPhoneNumber=&orderId=<%=o.getId()%>" class="btn btn-primary" style="margin-left: 10px;">
                            Ticket Detail
                        </a>
                    </td>
                </tr>
                <!--confirm modal btn3-->
            <div class="modal" id="confirmModal-<%= o.getId() %>">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Confirm Change</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to change the flight status?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary confirmChange" data-modal-id="<%= o.getId() %>">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            }
            %>
        </tbody>
    </table>
    <script>
        function openModal(id) {
            $("#myModal" + id).modal('show');
        }
    </script>
</body>
</html>
