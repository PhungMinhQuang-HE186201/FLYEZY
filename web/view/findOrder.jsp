<%-- 
    Document   : findOrder
    Created on : Oct 30, 2024, 8:20:07 AM
    Author     : phung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <title>Ticket Buying History</title>
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
                margin-bottom: 25px;
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
                padding: 15px 20px;
                border-bottom: 1px solid #ddd;
                background-color: white;
                margin-bottom: 10px;
                border-radius: 10px;
            }
            .list-price{
                border-bottom: 1px solid #ddd;
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
            .ticket-details i {
                color: #666;
                margin-right: 5px;
                font-size: 0.9em;
                vertical-align: middle;
            }

            .flight-info div {
                line-height: 1.5;
                color: #333;
            }

            .status-label {
                padding: 5px 10px;
                font-size: 15px;
                color: white;
                font-weight: bold;
                display: inline-block;
                text-align: center;
                white-space: nowrap;
                color: white;
                border-radius: 12px;
                text-align: center;
                width: 165px;
                margin: 10px
            }

            .status-label.completed {
                background-color: black;
            }

            .status-label.pending {
                background-color: #ffc107;
            }

            .status-label.successful {
                background-color: #28a745;
            }
            .status-label.request {
                background-color: #ffc107;
            }
            .status-label.canceled {
                background-color: #28a745;
            }
            .status-label.refund {
                background-color: #28a745;
            }
            .status-label.rejection {
                background-color: #dc3545;
            }
            .status-label.request {
                background-color: #ffc107;
            }
            .status-label.canceled {
                background-color: #28a745;
            }
            .status-label.refund {
                background-color: #28a745;
            }
            .status-label.rejection {
                background-color: #dc3545;
            }


        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm dd-MM-yyyy");
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
            
            Order o = (Order)request.getAttribute("order");
            List<FlightDetails> listFlightDetails = (List<FlightDetails>)request.getAttribute("listFlightDetails");
        %>

        <!-- Container for the order details -->

        <div class="container mt-5 order-container" style="transform: translateY(45px)">
            <!-- Search Bar Section -->
            <div class="row mt-3 mb-3">
                <div class="col-md-12">
                    <form action="findOrder" method="get" class="form-inline justify-content-center">
                        <input type="text" value="${param.code}" class="form-control" name="code" placeholder="Enter code here to search ..." aria-label="Search" style="width: 30%; font-size: 1.2em">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="fa fa-search"></i> 
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Buying History Section -->
            <div class="buying-history">
                <%int id = 0;%>
                <% if(o!=null){             
                    List<Ticket> listTicketInOrder = td.getAllTicketsByOrderId(o.getId());
                    if (!listTicketInOrder.isEmpty()) { %>

                <% Boolean isVerified = (Boolean) request.getAttribute("isVerified"); %>
                <% if (isVerified != null && isVerified) { %>
                <div class="order-card">
                    <div class="order-header">

                        <div class="order-id" >
                            <strong style="font-size: 28px;"><%=o.getCode()%></strong>
                            <span style="margin-left: 4px; font-size: 12px; color: #aaa;"><%=sdf.format(o.getCreated_at())%></span><br>
                            <div class="contact-info" style="color: #9a9999;
                                 margin-top: 5px;">
                                Contact: <i class="fas fa-user"></i> <%= o.getContactName() %> | 
                                <i class="fas fa-phone"></i> <%= o.getContactPhone() %> | 
                                <i class="fas fa-envelope"></i> <%= o.getContactEmail() %>
                            </div>

                        </div>


                        <div class="order-details">
                            <span class="status-label <%= sd.getStatusNameById(o.getStatus_id()).toLowerCase() %>">
                                <%= sd.getStatusNameById(o.getStatus_id()) %>
                            </span>
                        </div>
                    </div>

                    <% int ticketOfBaggage = 0; int count = 1; int total = 0;%>
                    <% for(Ticket t : listTicketInOrder) { %>
                    <% ticketOfBaggage = bmd.getPriceBaggagesById(t.getId()); %>
                    <% id = t.getId(); %>
                    <div class="ticket-details">
                        <div class="flight-info" style="display: flex; flex-direction: column; gap: 5px;">
                            <div style="display: flex; align-items: center; gap: 10px;margin-bottom: 20px">
                                <div class="airline-image">
                                    <img src="<%=ad.getImageById(td.getAirlineByTicket(t.getId()))%>" alt="Airline Logo" class="img-fluid">
                                </div>
                                <div>
                                    <div>Ticket <%= count %></div>
                                    <div><%= t.getpSex() == 1 ? "Mr." : "Mrs." %> <%= t.getpName() %></div>
                                    <div><%= scd.getSeatCategoryById(t.getSeat_Categoryid()).getName() %> - <%= t.getCode() %></div>
                                </div>
                            </div>
                            <% for(FlightDetails detail : fdd.getAll()) {
                if(detail.getId() == t.getFlightDetailId()) { %>

                            <!-- Flight route icon -->
                            <div><i class="fas fa-plane"></i> <%= fd.getDepartureByFlight(od.getFlightIdByOrder(o.getId())) %> to <%= fd.getDestinationByFlight(od.getFlightIdByOrder(o.getId())) %></div>

                            <!-- Date and Time with icons -->
                            <div>
                                <i class="far fa-calendar-alt"></i>
                                <%= detail.getDate() %>
                                <span class="time-separator" style="margin-left: 10px;">
                                    <i class="far fa-clock"></i>
                                    <%= detail.getTime()%> - <%=fd.getFlightById(detail.getFlightId()).getMinutes() %> minutes
                                </span>
                            </div>


                            <!-- Plane category and flight duration with icons -->
                            <div><i class="fas fa-plane-departure"></i> <%= pcd.getPlaneCategoryById(detail.getPlaneCategoryId()).getName() %> </div>

                            <% }} %>

                            <!-- Extra baggage with icon -->
                            <% for(Baggages b : bmd.getAllBaggages()) {
                if(b.getId() == t.getBaggagesid()) { %>
                            <div><i class="fas fa-suitcase"></i> Extra baggage: <%= b.getWeight() %>kg</div>
                            <% } } %>
                        </div>

                        <div class="ticket-actions" style="margin-top: 10px;">
                            <div><strong><%= t.getTotalPrice() %></strong></div>
                            <div class="status-label <%= sd.getStatusNameById(t.getStatusid()).toLowerCase() %>">
                                <%= sd.getStatusNameById(t.getStatusid()) %>
                            </div>

                            <% if(t.getStatusid() == 10 || t.getStatusid() == 12) { %>
                            <a class="btn btn-danger" style="text-decoration: none; margin-top: 5px;" onclick="openModalTicket(<%= t.getId() %>,<%= o.getId() %>)">Cancel ticket</a>
                            <% } %>
                        </div>
                    </div>
                    <% count++; %>
                    <% } %>




                    <div class="list-price" style="text-align: right; font-size: 1.2em;">
                        <div class="order-discount">Discount: 0%</div>
                        <div class="order-total"><strong>Total: <%= o.getTotalPrice() + ticketOfBaggage %></strong></div>
                    </div>


                    <div class="order-total-section" style="font-size: 1.2em;">
                        <div class="order-actions" style="margin-top: 10px;text-align: right">
                            <% if (td.countNumberTicketNotCancel(o.getId()) == 0) { %>
                            <a class="btn btn-danger" style="text-decoration: none; display: none;" onclick="openModalOrder(<%= o.getId() %>)">Cancel Order</a>
                            <% } else { %>
                            <a class="btn btn-danger" style="text-decoration: none;" onclick="openModalOrder(<%= o.getId() %>)">Cancel Order</a>
                            <% } %>
                        </div>
                    </div>

                </div>
                <br>
            </div>
            <% }else{ %>
            <div class="contact-verification mt-3">
                <form action="findOrder" method="get">
                    <input type="hidden" name="code" value="<%= o.getCode() %>">
                    <label for="contactInfo">Please verify your contact information:</label>
                    <input type="text" id="contactInfo" name="contactInfo" class="form-control" placeholder="Enter your contact mail/phone/name">
                    <button type="submit" class="btn btn-primary mt-2">Verify</button>
                </form>
            </div>
            <%}%>
            <%}%>
            <%}%>


            <!--        Cancel ticket modal-->
            <div id="cancelTicketModal" class="modal" role="dialog" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
                <div class="modal-dialog" style="margin: 15% auto; width: 30%; position: relative;">
                    <div class="modal-content" style="background-color: #fff; padding: 20px; border: 1px solid #888;">
                        <form action="cancelTicket" method="post">
                            <input type="hidden" id="modalTicketId" name="ticketId" value="">
                            <input type="hidden" id="modalOrderId" name="orderId" value="">
                            <h2>Cancel Ticket</h2>
                            <p>Are you sure you want to cancel this ticket?</p>
                            <!-- Container for buttons with flex display -->
                            <div style="display: flex; justify-content: space-between;">
                                <button type="submit" id="confirmCancel" class="btn btn-danger" style="flex: 1; margin-right: 10px;">Yes</button>
                                <button type="button" id="closeModal" class="btn btn-secondary" style="flex: 1;" onclick="closeModal()">No</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div id="cancelOrderModal" class="modal" role="dialog" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
                <div class="modal-dialog" style="margin: 15% auto; width: 30%; position: relative;">
                    <div class="modal-content" style="background-color: #fff; padding: 20px; border: 1px solid #888;">
                        <form action="cancelOrder" method="post">
                            <input type="hidden" id="modalOrderId2" name="orderId" value="">
                            <h2>Cancel Order</h2>
                            <p>Are you sure you want to cancel this order?</p>
                            <!-- Container for buttons with flex display -->
                            <div style="display: flex; justify-content: space-between;">
                                <button type="submit" id="confirmCancelOrder" class="btn btn-danger" style="flex: 1; margin-right: 10px;">Yes</button>
                                <button type="button" id="closeOrderModal" class="btn btn-secondary" style="flex: 1;" onclick="closeOrderModal()">No</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


        </div>


        <script>


            function openModalTicket(ticketId, orderId) {
                // Set the ticket ID in the hidden input field
                document.getElementById("modalTicketId").value = ticketId;
                document.getElementById("modalOrderId").value = orderId;
                // Display the modal
                document.getElementById("cancelTicketModal").style.display = "block";
            }

            function closeModal() {
                // Hide the modal
                document.getElementById("cancelTicketModal").style.display = "none";
            }
            document.getElementById("closeModal").onclick = function () {
                document.getElementById("cancelTicketModal").style.display = "none";
            };
            // Close modal if user clicks outside of it
            window.onclick = function (event) {
                const modal = document.getElementById("cancelTicketModal");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };


            function openModalOrder(orderId) {
                // Set the order ID in the hidden input field
                document.getElementById('modalOrderId2').value = orderId;

                // Display the modal
                document.getElementById('cancelOrderModal').style.display = 'block';
            }
            function closeOrderModal() {
                // Hide the modal
                document.getElementById('cancelOrderModal').style.display = 'none';
            }
            document.getElementById("closeOrderModal").onclick = function () {
                document.getElementById("cancelOrderModal").style.display = "none";
            };
            // Close modal if user clicks outside of it
            window.onclick = function (event) {
                const modal = document.getElementById("cancelOrderModal");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </body>
</html>
