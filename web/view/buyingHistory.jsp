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
<%@page import="dal.PlaneCategoryDAO"%>
<%@page import="dal.SeatCategoryDAO"%>
<%@page import="dal.BaggageManageDAO"%>
<%@page import="dal.FeedbackDao"%>
<%@page import="java.util.List"%>
<%@page import="model.Status"%>
<%@page import="model.Order"%>
<%@page import="model.Flights"%>
<%@page import="model.FlightDetails"%>
<%@page import="model.Ticket"%>
<%@page import="model.Airline"%>
<%@page import="model.FlightType"%>
<%@page import="model.PassengerType"%>
<%@page import="model.PlaneCategory"%>
<%@page import="model.SeatCategory"%>
<%@page import="model.Baggages"%>
<%@page import="model.Feedbacks"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
            .list-price{
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
            .order-total{
                text-align: right;
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
            PlaneCategoryDAO pcd = new PlaneCategoryDAO();
            SeatCategoryDAO scd = new SeatCategoryDAO();
            BaggageManageDAO bmd = new BaggageManageDAO();
            
            List<Order> listOrder = (List<Order>)request.getAttribute("listOrder");
            List<FlightDetails> listFlightDetails = (List<FlightDetails>)request.getAttribute("listFlightDetails");
        %>

        <!-- Container for the order details -->

        <div class="container mt-5 order-container" style="transform: translateY(45px)">
            <!-- Status Tabs Section -->
            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link <%= request.getParameter("statusId") == null ? "active" : "" %>" href="buyingHistory">All</a>
                        </li>
                        <% for (Status st : listStatusOrder) { %>
                        <li class="nav-item">
                            <a class="nav-link <%= request.getParameter("statusId") != null && request.getParameter("statusId").equals(String.valueOf(st.getId())) ? "active" : "" %>" href="buyingHistory?statusId=<%=st.getId()%>">
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
                        <input type="text" class="form-control" name="code" placeholder="Enter code here to search..." aria-label="Search" style="width: 30%; font-size: 1.2em">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="fa fa-search"></i> 
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <% } %>

            <!-- Buying History Section -->
            <div class="buying-history">
                <% for(Order o : listOrder) { 
                    List<Ticket> listTicketInOrder = td.getAllTicketsByOrderId(o.getId());
                    if (!listTicketInOrder.isEmpty()) { %>

                <div class="order-card">
                    <div class="order-header">
                        <%for(FlightDetails detail : fdd.getAll()){
                if(detail.getId() == o.getFlightDetailId()){ %>
                        <div class="order-id">
                            <%=o.getCode()%><br>
                            From: <%= fd.getDepartureByFlight(od.getFlightIdByOrder(o.getId())) %> to <%= fd.getDestinationByFlight(od.getFlightIdByOrder(o.getId())) %>
                            in <%=detail.getDate()%> at <%=detail.getTime()%><br>
                            <%=pcd.getPlaneCategoryById(detail.getPlaneCategoryId()).getName()%> - <%=fd.getFlightById(detail.getFlightId()).getMinutes()%> minutes<br>
                            Contact name: <%=o.getContactName()%><br>
                            Contact phone: <%=o.getContactPhone()%>
                        </div>
                        <%}}%>

                        <div class="order-details">
                            Created at: <%=o.getCreated_at()%>
                            <% for(Airline a : ad.getAllAirline()) {
                        if(a.getId() == od.getAirlineIdByOrder(o.getId())) { %>
                            <div class="airline-image">
                                <img src="<%=a.getImage()%>" alt="Airline Logo" class="img-fluid">
                            </div>
                            <% } } %>
                        </div>
                    </div>

                    <% int ticketOfBaggage = 0; int count = 1; %>
                    <% for(Ticket t : listTicketInOrder) { %>
                    <% ticketOfBaggage = bmd.getPriceBaggagesById(t.getId()); %>
                    <div class="ticket-details">
                        <div class="flight-info">
                            Ticket <%= count %><br>
                            Passenger: <%= t.getpSex() == 1 ? "Mr." : "Mrs." %><%= t.getpName() %><br>
                            <%= scd.getSeatCategoryById(t.getSeat_Categoryid()).getName() %> - <%= t.getCode() %><br>
                            <% for(Baggages b : bmd.getAllBaggages()) {
                        if(b.getId() == t.getBaggagesid()) { %>
                            Extra checked baggages bought: <%=b.getWeight()%>
                            <% } } %>
                        </div>

                        <div class="ticket-actions">
                            Ticket price: <%= t.getTotalPrice() %><br>
                            Ticket status: <%= sd.getStatusNameById(t.getStatusid()) %><br>
                            <button class="btn btn-danger">Cancel ticket</button>
                        </div>
                    </div>
                    <% count++; %>
                    <% } %>

                    <div class="list-price" style="text-align: right; font-size: 1.2em;">
                        <% for(PassengerType pt : ptd.getAllPassengerTypeByOrder(o.getId())) { %>
                        <%= pt.getName() %> ticket x <%= pt.getNumberOfType() %>: <%= td.getTicketPriceByOrderAndPassenger(o.getId(), pt.getId()) * pt.getPrice() %><br>
                        <% } %>
                        <% if(ticketOfBaggage != 0){ %>
                        Price of baggage: <%= ticketOfBaggage %>
                        <% } %>
                    </div>

                    <div class="order-total-section" style="text-align: right; font-size: 1.2em;">
                        <div class="order-discount">Discount: 0%</div>
                        <div class="order-total">Total: <span class="text-danger"><%= o.getTotalPrice() + ticketOfBaggage %></span></div>
                        <div class="order-actions">
                            <button class="btn btn-danger">Cancel Order</button>
                            <%FeedbackDao fd1 = new FeedbackDao();
                             Integer id = (Integer) session.getAttribute("id");
                              Feedbacks f = fd1.getFeedbakByOrderId(o.getId(),id);
                              if(f==null){%>
                                <a href="evaluateController?orderId=<%=o.getId()%>"><button class="btn btn-outline-secondary">Feedback</button></a>
                            <%}else{%>
                                <a href="evaluateController?action=viewUpdate&orderId=<%=o.getId()%>"><button class="btn btn-outline-secondary">Update Feedback</button></a>
                            <%}%>
                        </div>
                    </div>
                </div>
                <% } } %>
            </div>
        </div>


    </body>
</html>
