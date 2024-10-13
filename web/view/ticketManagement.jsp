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
<%@page import="model.Ticket"%>
<%@page import="model.Airline"%>
<%@page import="model.Status"%>
<%@page import="model.Airport"%>
<%@page import="model.Country"%>
<%@page import="static controller.EncodeController.SECRET_KEY" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Accounts"%>
<%@page import="model.Status"%>
<%@page import="model.Flights"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.FlightDetails"%>
<%@page import="model.Location"%>
<%@page import="model.SeatCategory"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="dal.TicketDAO"%>
<%@page import="dal.AirportDAO"%>
<%@page import="dal.BaggageManageDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="dal.AccountsDAO"%>
<%@page import="dal.PassengerTypeDAO"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.PaymentTypeDAO"%>
<%@page import="dal.SeatCategoryDAO"%>
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
                <form action="TicketController" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="search">
                    

                    <strong class="filterElm">Passenger Type</strong>
                    <select class="filterElm" name="passengerType">
                        <option value="" ${param.passengerType == null ? 'selected' : ''}>All</option>
                        <c:forEach items="${passengerTypeList}" var="type">
                            <option value="${type.id}" ${param.passengerType != null && (param.passengerType==type.id) ? 'selected' : ''}>${type.name}</option>
                        </c:forEach>
                    </select>

                    <strong class="filterElm">Status</strong>
                    <select class="filterElm" name="statusTicket">
                        <option value="" ${param.statusTicket == null ? 'selected' : ''}>All</option>
                        <c:forEach items="${statusTicketList}" var="status">
                            <option value="${status.id}" ${param.statusTicket != null && (param.statusTicket==status.id) ? 'selected' : ''}>${status.name}</option>
                        </c:forEach>
                    </select>
                    <strong>Passenger Name: </strong>
                    <input class="filterElm" type="text" name="fName" value="${param.fName}" placeholder="Enter name">
                    <strong>Phone number: </strong>
                    <input class="filterElm" type="number" name="fPhoneNumber" value="${param.fPhoneNumber}" placeholder="Enter phone number">
                    <button class="btn btn-info" type="submit">
                        Search
                    </button>
                    <a class="btn btn-danger" href="TicketController">Cancle</a>
                </form>


            </div>
                    
            <div>
                <%
                  Flights flight = (Flights)request.getAttribute("flight");
                  Airport airportDep =(Airport)request.getAttribute("airportDep");
                  Airport airportDes =(Airport)request.getAttribute("airportDes");
                  FlightDetails flightDetail = (FlightDetails)request.getAttribute("flightDetail");
                  Location locationDep = (Location)request.getAttribute("locationDep");
                  Location locationDes = (Location)request.getAttribute("locationDes");
                  Country countryDep = (Country)request.getAttribute("countryDep");
                  Country countryDes = (Country)request.getAttribute("countryDes");
                  PlaneCategory planeCatrgory = (PlaneCategory)request.getAttribute("planeCatrgory");
                %>

                <p><%=airportDep.getName()%></p>
                <p><%=airportDes.getName()%></p>
                <p><%=locationDep.getName()%></p>
                <p><%=locationDes.getName()%></p>
                <p><%=countryDep.getName()%></p>
                <p><%=countryDes.getName()%></p>
                <p><%=planeCatrgory.getName()%></p>
                <p><%=flightDetail.getDate()%></p>  
                <p><%=flightDetail.getTime()%></p>
                <p><%=flightDetail.getPrice()%></p>
                <p><%=flight.getMinutes()%></p>
                
            </div>
            <!-- Update Modal -->   
            <%
                List<SeatCategory> seatList = (List<SeatCategory>) request.getAttribute("seatList");
                    for (SeatCategory list : seatList) {%>
                        <p><%=list.getName()%> :<%=list.getNumberOfSeat()-list.getCountSeat()%>  /<%=list.getNumberOfSeat()%><p>
                <%}%>
            <table class="entity" >
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Seat Category</th>
                        <th>Passenger type </th>
                        <th>Passenger Name</th>
                        <th>Passenger Sex</th>
                        <th>Phone number</th>
                        <th>Date of birth</th>
                        <th>Baggage weight</th>
                        <th>Order ID</th>
                        <th>Status</th>
                        <th style="padding: 0 55px; min-width: 156px">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <%
                    List<Ticket> ticketList = (List<Ticket>) request.getAttribute("ticketList");
                    AirportDAO ad = new AirportDAO();
                    BaggageManageDAO bmd = new BaggageManageDAO();
                    AccountsDAO acd = new AccountsDAO();
                    FlightTypeDAO ftd = new FlightTypeDAO();
                    PassengerTypeDAO ptd = new PassengerTypeDAO();
                    PaymentTypeDAO PTD = new PaymentTypeDAO();
                    SeatCategoryDAO scd = new SeatCategoryDAO();
                    StatusDAO sd = new StatusDAO();
                    
                    for (Ticket list : ticketList   ) {
                    %>
                    <tr>
                        <td><%= list.getCode() %></td>
                        <td><%= scd.getSeatCategoryNameById(list.getSeat_Categoryid()) %></td>
                        <td><%= ptd.getPassengerTypeNameById(list.getPassenger_Typesid()) %></td>
                        <td><%= list.getpName() %></td>
                        <td><%= list.getpSex()==1?"Male":"Female" %></td>
                        <td><%= list.getpPhoneNumber() %></td>
                        <td><%= list.getpDob() %></td>
                        <td><%= bmd.getWeight(list.getBaggagesid()) %></td>
                        <td><%= list.getOrder_id() %></td>
                        <td><%= sd.getStatusNameById(list.getStatusid()) %></td>
                        <td>
                            <a class="btn btn-info" style="text-decoration: none" id="myBtn<%= list.getId() %>" onclick="openModal(<%= list.getId() %>)">Change status</a>
                            <div class="modal fade" id="myModal<%= list.getId() %>" role="dialog">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header" style="padding:5px 5px;">
                                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                                            <h4 style="margin-left: 12px">Change status</h4>
                                        </div>
                                        <div class="modal-body" style="padding:40px 50px;">
                                            <form role="form" action="TicketController" method="post">
                                                <input type="hidden" name="action" value="changeStatus"/>
                                                <input type="hidden" name="createdAt" value=""/>
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <label for="usrname"><span class="glyphicon glyphicon-globe"></span>ID:</label>
                                                        <input type="text" class="form-control" id="usrname" name="id" value="<%= list.getId() %>" readonly="">
                                                    </div>
                                                    <div class="form-group col-md-8">
                                                        <div><label for="usrname"><span class="glyphicon glyphicon-knight"></span>Status:</label></div>
                                                        <select name="statusID" value="" style="height:  34px">
                                                            <%List<Status> statusList = (List<Status>)request.getAttribute("statusTicketList");
                                                            for(Status status : statusList){%>
                                                               <option value="<%=status.getId()%>" <%=(list.getStatusid() == status.getId())?"selected":""%>><%=status.getName()%></option>"
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
        </script>

    </body>
</html>