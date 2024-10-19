<%-- 
    Document   : buyingHistory
    Created on : Oct 17, 2024, 5:20:41 PM
    Author     : PMQUANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.StatusDAO"%>
<%@page import="dal.AirlineManageDAO"%>
<%@page import="dal.FlightDetailDAO"%>
<%@page import="dal.FlightManageDAO"%>
<%@page import="dal.OrderDAO"%>
<%@page import="dal.TicketDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="dal.PassengerTypeDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Status"%>
<%@page import="model.Order"%>
<%@page import="model.Flights"%>
<%@page import="model.FlightDetails"%>
<%@page import="model.Ticket"%>
<%@page import="model.Airline"%>
<%@page import="model.FlightType"%>
<%@page import="model.PassengerType"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%-- Import Bootstrap CSS --%>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <title>JSP Page</title>
        <style>
            .buying-history {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .order-card {
                border: 1px solid #ddd;
                padding: 15px;
                border-radius: 8px;
                background-color: #f9f9f9;
            }

            .order-header {
                display: flex;
                justify-content: space-between;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
                margin-bottom: 10px;
            }

            .ticket-details {
                display: flex;
                align-items: center;
                padding: 10px 0;
                border-bottom: 1px dashed #ddd;
            }

            .airline-image {
                width: 100px;
                margin-right: 15px;
            }

            .flight-info {
                flex-grow: 1;
            }

            .ticket-actions {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            StatusDAO sd = new StatusDAO();
            List<Status> listStatusOrder = sd.getStatusOfOrder();
            AirlineManageDAO ad = new AirlineManageDAO();
            OrderDAO od = new OrderDAO();
            FlightDetailDAO fdd = new FlightDetailDAO();
            FlightManageDAO fd = new FlightManageDAO();
            TicketDAO td = new TicketDAO();
            FlightTypeDAO ftd = new FlightTypeDAO();
            PassengerTypeDAO ptd = new PassengerTypeDAO();
            
            List<Order> listOrder = (List<Order>)request.getAttribute("listOrder");
            List<FlightDetails> listFlightDetails = (List<FlightDetails>)request.getAttribute("listFlightDetails");
        %>

        <!-- Container for the order details -->
        <div class="container mt-5" style="transform: translateY(45px)">
            <!-- Status Tabs Section -->
            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link <%= request.getParameter("statusId") == null ? "active" : "" %>" href="buyingHistory">All</a>
                        </li>
                        <% for (Status st : listStatusOrder) { %>
                        <li class="nav-item">
                            <a class="nav-link <%= request.getParameter("statusId") != null && request.getParameter("statusId").equals(String.valueOf(st.getId())) ? "active" : "" %>" 
                               href="buyingHistory?statusId=<%=st.getId()%>">
                                <%=st.getName()%>
                            </a>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>

            <!-- Search Bar Section -->
            <% if (request.getParameter("statusId") == null) { %> 
            <div class="row mt-3 mb-3">
                <div class="col-md-12">
                    <form action="buyingHistory" method="get" class="form-inline justify-content-center">
                        <input type="text" class="form-control" name="code" placeholder="Enter code here to search..." aria-label="Search" style="width: 30%">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="fa fa-search"></i> <!-- Search icon -->
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <% } %>

            <div class="buying-history">
                <% for(Order o : listOrder) { 
                    List<Ticket> listTicketInOrder = td.getAllTicketsByOrderId(o.getId());
                    if (!listTicketInOrder.isEmpty()) { %>

                <div class="order-card">
                    <div class="order-header">
                        <%for(FlightDetails detail : fdd.getAll()){
                        if(detail.getId() == o.getFlightDetailId()){
                        %>
                        <div class="order-id">From <%= fd.getDepartureByFlight(od.getFlightIdByOrder(o.getId())) %> To <%= fd.getDestinationByFlight(od.getFlightIdByOrder(o.getId())) %> <br> 
                        <%=detail.getDate()%> <%=detail.getTime()%>
                        </div>
                        <%}}%>

                        <div class="order-total">Total: <span class="text-danger"><%=o.getTotalPrice()%></span></div>
                    </div>

                    <% for(Ticket t : listTicketInOrder) { %>
                    <div class="ticket-details">
                        <% for(Airline a : ad.getAllAirline()) {
                    if(a.getId() == od.getAirlineIdByOrder(o.getId())) { %>
                        <div class="airline-image">
                            <img src="<%=a.getImage()%>" alt="Airline Logo" class="img-fluid">
                        </div>
                        <% } } %>

                        <div class="flight-info">
                            <% for(FlightType ft : ftd.getAllFlightType()) {
                        if(ft.getId() == t.getFlight_Type_id()) { %>
                            <div>Flight Type: <%=ft.getName()%></div>
                            
                            <% } } %>
                            <%for(PassengerType pt : ptd.getAllPassengerType()){
                            if(pt.getId() == t.getPassenger_Typesid()){
                            %>
                            <div>Passenger Type: <%=pt.getName()%></div>
                            <%}}%>
                        </div>

                        <div class="ticket-actions">
                            <button class="btn btn-danger">Cancel ticket request</button>
                            <button class="btn btn-outline-secondary">Feedback</button>
                        </div>
                    </div>
                    <% } %> <!-- End of tickets loop -->
                </div>
                <% } } %> <!-- End of order loop -->
            </div>



        </div>

    </body>
</html>
