<%-- 
    Document   : bookingFlightTickets
    Created on : Oct 7, 2024, 10:49:03 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@page import="java.text.NumberFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="model.FlightDetails" %>
<%@page import="model.Flights" %>
<%@page import="model.Baggages" %>
<%@page import="model.Airport" %>
<%@page import="model.Accounts" %>
<%@page import="model.Airline" %>
<%@page import="model.Location" %>
<%@page import="model.Country" %>
<%@page import="model.PlaneCategory" %>
<%@page import="model.SeatCategory" %>
<%@page import="model.Ticket" %>
<%@page import="java.util.List" %>
<%@page import="dal.AirlineManageDAO" %>
<%@page import="dal.FlightDetailDAO" %>
<%@page import="dal.PlaneCategoryDAO" %>
<%@page import="dal.SeatCategoryDAO" %>
<%@page import="dal.AirportDAO" %>
<%@page import="dal.LocationDAO" %>
<%@page import="dal.CountryDAO" %>
<%@page import="dal.TicketDAO" %>
<%@page import="dal.BaggageManageDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Flight Tickets</title>
        <link rel="stylesheet" href="css/styleGeneral.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
        <script src="js/validation.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            body {
                background-color: #f7f7f7;
                color: #333;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .main-container {
                border: 1px solid #ddd;
                margin-bottom: 20px;
                border-radius: 10px;
                background-color: #fff;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }
            .main-container2 {
                border: 1px solid #ddd;
                margin-bottom: 20px;
                border-radius: 10px;
                background-color: #fff;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }
            .main-container img {
                width: 150px;
                height: auto;
                border-radius: 5px;
            }
            .details {
                margin-left: 20px;
            }
            .details h3 {
                margin: 10px 0;
                font-size: 18px;
                color: #3C6E57;
            }
            .details p {
                margin: 10px 0;
                font-size: 16px;
            }
            .details span {
                font-weight: bold;
            }

            .passenger-info {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
            }

            .passenger-info-input {
                padding: 15px;
                margin-bottom: 30px;
                border-radius: 8px;
                border: 5px solid #9DC567;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .passenger-info-input-box{
                display: flex;
                margin-bottom: 15px
            }

            .passenger-info-input-box input{
                width: 100%;
            }

            .passenger-info-input-title{
                margin: 0;
                width: 150px;
                align-items: center;
                display: flex;
            }

            .main-container2 .inform label {
                font-size: 14px;
                color: #666;
                margin-bottom: 5px;
            }

            .main-container2 .inform input[type="text"],
            .main-container2 .inform input[type="date"],
            .main-container2 .inform input[type="email"],
            .main-container2 .inform input[type="number"],
            .main-container2 .inform select {
                padding: 5px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                transition: border-color 0.3s ease;
            }

            .main-container2 .inform input[type="text"]:focus,
            .main-container2 .inform input[type="date"]:focus,
            .main-container2 .inform input[type="number"]:focus,
            .main-container2 .inform input[type="email"]:focus,
            .main-container2 .inform select:focus {
                border-color: #9DC567;
                outline: none;
            }

            .ticket-pricing {
                font-family: Arial, sans-serif;
                max-width: 400px;
                margin: 20px auto;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
            }

            .ticket-item, .ticket-total {
                display: flex;
                justify-content: space-between;
                padding: 5px 0;
            }

            .ticket-item span, .ticket-total span {
                font-size: 16px;
            }

            .ticket-total {
                color: #3C6E57;
                font-weight: bold;
                border-top: 1px solid #ddd;
                margin-top: 10px;
                padding-top: 10px;
            }

            .ticket-item span:last-child, .ticket-total span:last-child {
                color: #333;
            }


        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            SimpleDateFormat timeFmt = new SimpleDateFormat("HH:mm");
            SimpleDateFormat dateFmt = new SimpleDateFormat("dd/MM/yyyy");
            AirlineManageDAO amd = new AirlineManageDAO();
            FlightDetailDAO fdd = new FlightDetailDAO();
            PlaneCategoryDAO pcd = new PlaneCategoryDAO();
            SeatCategoryDAO scd = new SeatCategoryDAO();
            AirportDAO ad = new AirportDAO();
            LocationDAO ld = new LocationDAO();
            CountryDAO cd = new CountryDAO();
            BaggageManageDAO bmd = new BaggageManageDAO();
            
            SeatCategory sc = scd.getSeatCategoryById(Integer.parseInt(request.getParameter("seatCategory")));
            
            int adultTicket = Integer.parseInt(request.getParameter("adult"));
            int childTicket = Integer.parseInt(request.getParameter("child")==null?"0":request.getParameter("child"));
            int infantTicket = Integer.parseInt(request.getParameter("infant"));
            
            int flightDetailId = Integer.parseInt(request.getParameter("flightDetailId"));
            FlightDetails fd = (FlightDetails)fdd.getFlightDetailById(flightDetailId);
            PlaneCategory planeCategory = pcd.getPlaneCategoryById(fd.getPlaneCategoryId());
            Flights f = fdd.getFlightByFlightDetailId(fd.getId());
            int airlineId = f.getAirlineId();
            Airline a = amd.getAirlineById(airlineId);
            int departureAirportId = f.getDepartureAirportId();
            Airport dpa = ad.getAirportById(departureAirportId);
            Location dpl = ld.getLocationById(dpa.getLocationId());
            Country dpc = cd.getCountryById(dpl.getCountryId());
            int destinationAirportId = f.getDestinationAirportId();
            Airport dsa = ad.getAirportById(destinationAirportId);
            Location dsl = ld.getLocationById(dsa.getLocationId());
            Country dsc = cd.getCountryById(dsl.getCountryId());
        %>

        <div class="container" style="margin-top: 50px;">
            <div class="main-container">
                <img src="<%=a.getImage()%>" alt="Airline Logo"/>

                <div class="details">
                    <h3>Additional Details: </h3>
                    <p>- Passengers: <span><%=adultTicket%> adult, 
                            <%=childTicket%> children, 
                            <%=infantTicket%> infant</span></p>
                    <p>- Airline: <span><%=a.getName()%></span></p>
                    <p>- Plane Category: <span><%=planeCategory.getName()%></span></p>
                    <p>- Ticket Type: <span><%=sc.getName()%></span></p>
                </div>
                <div class="details">
                    <h3>Flight Information: </h3>
                    <% 
                        Calendar departureCal = Calendar.getInstance();
                        departureCal.setTime(fd.getDate()); 

                        Calendar timeCal = Calendar.getInstance();
                        timeCal.setTime(fd.getTime());
                        
                        departureCal.set(Calendar.HOUR_OF_DAY, timeCal.get(Calendar.HOUR_OF_DAY));
                        departureCal.set(Calendar.MINUTE, timeCal.get(Calendar.MINUTE));

                        SimpleDateFormat dateTimeFmt = new SimpleDateFormat("HH:mm dd/MM/yyyy");
                    %>

                    <p>- Departure Time: <span><%=dateTimeFmt.format(departureCal.getTime())%></span></p>
                    <p>- Departure: <span><%=dpa.getName()%>, <%=dpl.getName()%>, <%=dpc.getName()%></span></p>

                    <% 
                        Calendar destinationCal = (Calendar) departureCal.clone();
                        destinationCal.add(Calendar.MINUTE, f.getMinutes()); 
                    %>

                    <p>- Destination Time: <span><%=dateTimeFmt.format(destinationCal.getTime())%></span></p>
                    <p>- Destination: <span><%=dsa.getName()%>, <%=dsl.getName()%>, <%=dsc.getName()%></span></p>

                </div>
            </div>

            <%
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            Accounts currentAcc = null;
            if(request.getAttribute("account") != null){
                currentAcc = (Accounts) request.getAttribute("account");
            }   
            %>

            <div style="display: flex; justify-content: space-between">
                <div style="width: 68%; display: block">
                    <form style="width: 100%" id="passengerForm" action="bookingFlightTickets" method="post">
                        <input type="hidden" name="flightDetailId" value="<%=flightDetailId%>"/>
                        <input type="hidden" name="seatCategoryId" value="<%=sc.getId()%>"/>
                        <input type="hidden" name="adultTicket" value="<%=adultTicket%>"/>
                        <input type="hidden" name="childTicket" value="<%=childTicket%>"/>
                        <input type="hidden" name="infantTicket" value="<%=infantTicket%>"/>
                        <input type="hidden" name="commonPrice" value="<%= fd.getPrice() * (sc.getSurcharge()+1) %>"/>
                        <input type="hidden" name="totalPrice" value="<%= fd.getPrice() * (sc.getSurcharge()+1) * (adultTicket + childTicket + infantTicket) %>"/>
                        <div class="main-container2 passenger-info" >
                            <div style="width: 100%; text-align: center;
                                 font-size: 20px;
                                 color: #333;
                                 margin-bottom: 20px;
                                 color: #3C6E57;
                                 letter-spacing: 1px;"><p>PASSENGER CONTACT</p></div>
                            <div style="width: 100%" class="inform">
                                <div class="passenger-info-input" style="position: relative">
                                    <div style="padding: 15px">
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Full Name:</div> 
                                            <input type="text" pattern="^[\p{L}\s]+$" name="pContactName" value="<%=(currentAcc!=null)?currentAcc.getName():""%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Phone number:</div>
                                            <input type="text" oninput="validatePhone(this)" name="pContactPhoneNumber" value="<%=(currentAcc!=null)?currentAcc.getPhoneNumber():""%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Email:</div>
                                            <input type="email" name="pContactEmail" value="<%=(currentAcc!=null)?currentAcc.getEmail():""%>" required/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="main-container2 passenger-info" >
                            <div style="width: 100%; text-align: center;
                                 font-size: 20px;
                                 color: #333;
                                 margin-bottom: 20px;
                                 color: #3C6E57;
                                 letter-spacing: 1px;"><p>PASSENGER INFORMATION</p></div>
                            <div style="width: 100%" class="inform">
                                <% for(int i = 1; i<=adultTicket; i++){
                                %>
                                <div class="passenger-info-input" style="position: relative">
                                    <div style="position: absolute;
                                         top: -14px;
                                         font-size: 16px;
                                         background-color: white;
                                         color: #3C6E57;
                                         padding: 0 10px;">PASSENGER ADULT <%=i%> </div>
                                    <div style="padding: 15px">
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title" style="width: 168px">Full Name:</div> 
                                            <select name="pSex<%=i%>" style="margin-right: 5px">
                                                <option value="1">Mr</option>
                                                <option value="0">Mrs</option>
                                            </select>
                                            <input type="text" pattern="^[\p{L}\s]+$" name="pName<%=i%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Date of birth:</div>
                                            <input type="date" name="pDob<%=i%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Phone number:</div>
                                            <input type="text" oninput="validatePhone(this)" name="pPhoneNumber<%=i%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box"  >
                                            <div class="passenger-info-input-title" style="width: 121px">Baggage:</div>
                                            <select name="pBaggages<%=i%>" id="baggage<%=i%>" onchange="updateTotalBaggage()">
                                                <option value="0">Buy 0kg extra checked baggage - <%=currencyFormatter.format(0)%></option>
                                                <% for(Baggages b : bmd.getAllBaggagesByAirline(airlineId)){
                                                %>
                                                <option value="<%=b.getId()%>">Buy <%=b.getWeight()%>kg extra checked baggage - <%=currencyFormatter.format(b.getPrice())%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Select seat:</div>
                                            <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                                <span style=""><%=sc.getName()%> - <span id="seatCodeForDisplaying<%=i%>">Not Selected</span></span>
                                            </div>
                                            <a class="btn btn-info" style="text-decoration: none" onclick="openSeatModal(<%=i%>)">Choose</a>

                                            <input type="hidden" name="code<%=i%>" id="seatCode<%=i%>"/>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                <% for(int i = adultTicket+1; i<=adultTicket+childTicket; i++){
                                %>
                                <div class="passenger-info-input" style="position: relative">
                                    <div style="position: absolute;
                                         top: -14px;
                                         font-size: 16px;
                                         background-color: white;
                                         color: #3C6E57;
                                         padding: 0 10px;">PASSENGER CHILDREN <%=i-adultTicket%> </div>
                                    <div style="padding: 15px">
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title" style="width: 168px">Full Name:</div> 
                                            <select name="pSex<%=i%>" style="margin-right: 5px">
                                                <option value="1">Boy</option>
                                                <option value="0">Girl</option>
                                            </select>
                                            <input type="text" pattern="^[\p{L}\s]+$" name="pName<%=i%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Date of birth:</div>
                                            <input type="date" name="pDob<%=i%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Select seat:</div>
                                            <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                                <span style=""><%=sc.getName()%> - <span id="seatCodeForDisplaying<%=i%>">Not Selected</span></span>
                                            </div>
                                            <a class="btn btn-info" style="text-decoration: none" onclick="openSeatModal(<%=i%>)">Choose</a>

                                            <input type="hidden" name="code<%=i%>" id="seatCode<%=i%>"/>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                <% for(int i = adultTicket+childTicket+1; i<=infantTicket+adultTicket+childTicket; i++){
                                %>
                                <div class="passenger-info-input" style="position: relative">
                                    <div style="position: absolute;
                                         top: -14px;
                                         font-size: 16px;
                                         background-color: white;
                                         color: #3C6E57;
                                         padding: 0 10px;">PASSENGER INFANT <%=i-(adultTicket+childTicket)%> </div>
                                    <div style="padding: 15px">
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title" style="width: 168px">Full Name:</div> 
                                            <select name="pSex<%=i%>" style="margin-right: 5px">
                                                <option value="1">Boy</option>
                                                <option value="0">Girl</option>
                                            </select>
                                            <input type="text" pattern="^[\p{L}\s]+$" name="pName<%=i%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Date of birth:</div>
                                            <input type="date" name="pDob<%=i%>" required/>
                                        </div>
                                        <div class="passenger-info-input-box">
                                            <div class="passenger-info-input-title">Select seat:</div>
                                            <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                                <span style=""><%=sc.getName()%> - <span id="seatCodeForDisplaying<%=i%>">Not Selected</span></span>
                                            </div>
                                            <a class="btn btn-info" style="text-decoration: none" onclick="openSeatModal(<%=i%>)">Choose</a>

                                            <input type="hidden" name="code<%=i%>" id="seatCode<%=i%>"/>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>

                    </form>

                </div>


                <div class="main-container2 passenger-info" style="width: 30%; height: fit-content">
                    <div style="width: 100%; text-align: center;
                         font-size: 20px;
                         color: #333;
                         margin-bottom: 20px;
                         color: #3C6E57;
                         letter-spacing: 1px;"><p>INVOICE</p></div>
                    <div class="ticket-pricing">
                        <div class="ticket-item">
                            <span>Adult Ticket x <%= adultTicket %></span>
                            <span>= <%= currencyFormatter.format(fd.getPrice() * (sc.getSurcharge()+1) * adultTicket) %></span>
                        </div>
                        <div class="ticket-item">
                            <span>Children Ticket x <%= childTicket %></span>
                            <span>= <%= currencyFormatter.format(fd.getPrice() * (sc.getSurcharge()+1) * childTicket) %></span>
                        </div>
                        <div class="ticket-item">
                            <span>Infant Ticket x <%= infantTicket %></span>
                            <span>= <%= currencyFormatter.format(fd.getPrice() * (sc.getSurcharge()+1) * infantTicket) %></span>
                        </div>
                        <div class="ticket-item">
                            <span>Baggage</span>
                            <span id="totalBaggage">= 0 ₫</span> 
                        </div>
                        <div class="ticket-total">
                            <span>Total Price:</span>
                            <span id="totalPrice"><%= currencyFormatter.format(fd.getPrice() * (sc.getSurcharge()+1) * (adultTicket + childTicket + infantTicket)) %></span>
                        </div>
                    </div>
                    <div style="width: 100%">
                        <button style="width: 100%; background-color:  #9DC567; padding: 10px 30px; border: none; border-radius: 8px; color: white"
                                onclick="submitPassengerForm()"
                                >SUBMIT</button>
                    </div>

                </div>
            </div>

            <% for(int j = 1; j<=infantTicket+adultTicket+childTicket;j++){ %>
            <div class="modal fade " id="seatModal<%=j%>"  tabindex="-1" aria-labelledby="seatModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="min-width: 45%">
                    <div class="modal-content">
                        <div class="modal-header" style="padding:5px 5px;">
                            <button type="button" class="close" style="font-size: 30px; margin-right: 12px;" data-dismiss="modal">&times;</button>
                            <h4 style="margin-left: 12px">Choose seat</h4>
                        </div>
                        <div style="display: flex;padding: 30px; justify-content: space-around">
                            <div>
                                <table>
                                    <%
                                        int seatEachRow = sc.getSeatEachRow();
                                        int rowNumber = 1;
                                        String[] seatLetters = {"A", "B", "C", "D", "E", "F"}; 
                                        int seatIndex = 0;

                                        TicketDAO td = new TicketDAO();
                                        List<String> bookedSeats = td.getAllTicketCodesById(flightDetailId, sc.getId());
                                    %>
                                    <thead>
                                        <tr>
                                            <% for (int i = 0; i < seatEachRow; i++) { %>
                                            <th style="padding-left: 15px;"><%= seatLetters[i] %></th>
                                                <% if (i == seatEachRow / 2 - 1) { %>
                                            <th style="padding-left: 15px; width: 40px"></th>
                                                <% }
                                            } %>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (int i = 0; i < sc.getNumberOfSeat(); i++) {
                                                if (i % seatEachRow == 0) { %>
                                        <tr>
                                            <% } 
                                            String seatCode = seatLetters[i % seatEachRow] + rowNumber; 
                                            String seatColor = bookedSeats.contains(seatCode) ? "rgb(255, 177, 177)" : "#FFF"; 
                                            String strokeColor = bookedSeats.contains(seatCode) ? "red" : "#B8B8B8"; 
                                            Ticket thisTicket = td.getTicketByCode(seatCode, flightDetailId, sc.getId());
                                            if (thisTicket != null && thisTicket.getStatusid() == 12) {
                                                seatColor = "#FFE878";
                                                strokeColor = "#FFBF00";
                                            }
                                            %>
                                            <td class="seat<%=j%>" data-seat-code="<%= seatCode %>">
                                                <div onclick="handleSeatClick(this, '<%= seatColor %>', <%= j %>)" 
                                                     data-disabled="false" style="padding-right: 10px" data-color="#B8B8B8">
                                                    <div class="seat-container">
                                                        <svg width="40" height="32" viewBox="0 0 40 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25" fill="<%= seatColor %>" stroke="<%= strokeColor %>" stroke-width="1.5" stroke-linejoin="round"></rect>
                                                        <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25" transform="rotate(90 10.25 11.75)" fill="<%= seatColor %>" stroke="<%= strokeColor %>" stroke-width="1.5" stroke-linejoin="round"></rect>
                                                        <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25" transform="rotate(90 35.25 11.75)" fill="<%= seatColor %>" stroke="<%= strokeColor %>" stroke-width="1.5" stroke-linejoin="round"></rect>
                                                        <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25" fill="<%= seatColor %>" stroke="<%= strokeColor %>" stroke-width="1.5" stroke-linejoin="round"></rect>
                                                        <path class="icon-selected" d="M20 6.333A6.67 6.67 0 0 0 13.334 13 6.67 6.67 0 0 0 20 19.667 6.67 6.67 0 0 0 26.667 13 6.669 6.669 0 0 0 20 6.333zm-1.333 10L15.333 13l.94-.94 2.394 2.387 5.06-5.06.94.946-6 6z" fill="transparent"></path>
                                                        </svg>
                                                        <input type="hidden" class="seatName" value="<%= seatCode %>" />
                                                    </div>
                                                </div>
                                            </td>
                                            <% if ( (i + 1) % (seatEachRow / 2) == 0 && (i + 1) % seatEachRow != 0) { %>
                                            <td style="text-align: center"><strong style="padding-right: 10px"><%= rowNumber %></strong></td>
                                                <% } 
                                                if ((i + 1) % seatEachRow == 0) { 
                                                    rowNumber++; %>
                                        </tr>
                                        <% } } %>
                                    </tbody>
                                </table>
                            </div>
                            <div>
                                <div style="padding-top: 20px">
                                    <div style="margin-bottom: 10px">
                                        <svg width="40" height="32" viewBox="0 0 40 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25" fill="#FFF" stroke="#B8B8B8" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25" transform="rotate(90 10.25 11.75)" fill="#FFF" stroke="#B8B8B8" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25" transform="rotate(90 35.25 11.75)" fill="#FFF" stroke="#B8B8B8" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25" fill="#FFF" stroke="#B8B8B8" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        </svg>
                                        Empty Seat
                                    </div> 
                                    <div style="margin-bottom: 10px">
                                        <svg width="40" height="32" viewBox="0 0 40 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25" fill="rgb(139, 229, 176)" stroke="green" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25" transform="rotate(90 10.25 11.75)" fill="rgb(139, 229, 176)" stroke="green" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25" transform="rotate(90 35.25 11.75)" fill="rgb(139, 229, 176)" stroke="green" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25" fill="rgb(139, 229, 176)" stroke="green" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        </svg>
                                        Selected Seat
                                    </div>
                                    <div style="margin-bottom: 10px">
                                        <svg width="40" height="32" viewBox="0 0 40 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25" fill="rgb(255, 177, 177)" stroke="red" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25" transform="rotate(90 10.25 11.75)" fill="rgb(255, 177, 177)" stroke="red" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25" transform="rotate(90 35.25 11.75)" fill="rgb(255, 177, 177)" stroke="red" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25" fill="rgb(255, 177, 177)" stroke="red" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        </svg>
                                        Booked Seat
                                    </div>
                                    <div style="margin-right: auto; font-size: 15px; font-weight: bold; color: green;">
                                        Choosing Seat:</br> <%=sc.getName()%> - <span id="selectedSeatCode<%=j%>">None</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" onclick="confirmSeatSelection('<%=j%>')">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>



        <script>
            function handleSeatClick(seat, seatColor, i) {
                if (seatColor === '#FFF') {
                    selectSeat(seat, i);
                } else {
                    alert('This seat cannot be selected.');
                }
            }
            let currentChoosingSeat = [];
            let selectedSeats = [];

            function selectSeat(seat, i) {
                const seatContainer = seat.querySelector(`.seat-container`);
                const selectedSeatCodeElement = document.getElementById('selectedSeatCode' + i);
                const confirmedSeat = document.getElementById("seatCode" + i);
                const confirmedSeatForDisplaying = document.getElementById("seatCodeForDisplaying" + i);

                const seatCode = seat.querySelector('.seatName').value;
                if (selectedSeats.includes(seatCode) && currentChoosingSeat[i] !== seat) {
                    alert('This seat is already selected by another passenger.');
                    return;
                }
                console.log(selectedSeats);

                if (currentChoosingSeat[i] && currentChoosingSeat[i] !== seat) {//chuyển ghế chọn trước thành empty
                    const preSeat = currentChoosingSeat[i].querySelector('.seat-container');
                    const preRects = preSeat.querySelectorAll('svg rect');
                    preRects.forEach(rect => {
                        rect.setAttribute("fill", "#FFF");
                        rect.setAttribute("stroke", "#B8B8B8");
                    });
                    const prePaths = preSeat.querySelectorAll('path');
                    prePaths.forEach(path => {
                        path.setAttribute("d", "");
                    });
                    //xoá ghế chọn trước đó khỏi selectedSeat
                    const index = selectedSeats.indexOf(currentChoosingSeat[i].querySelector('.seatName').value);
                    if (index > -1) {
                        selectedSeats.splice(index, 1);
                    }
                }
                if (currentChoosingSeat[i] !== seat) {// nhấn sang ghế khác
                    const seatRects = seatContainer.querySelectorAll('svg rect');
                    seatRects.forEach(rect => {
                        rect.setAttribute("fill", "rgb(139, 229, 176)");
                        rect.setAttribute("stroke", "green");
                    });
                    const seatPaths = seatContainer.querySelectorAll('path');
                    seatPaths.forEach(path => {
                        path.setAttribute("d", "M20 6.333A6.67 6.67 0 0 0 13.334 13 6.67 6.67 0 0 0 20 19.667 6.67 6.67 0 0 0 26.667 13 6.669 6.669 0 0 0 20 6.333zm-1.333 10L15.333 13l.94-.94 2.394 2.387 5.06-5.06.94.946-6 6z");
                        path.setAttribute("fill", "green");
                    });

                    currentChoosingSeat[i] = seat;
                    selectedSeats.push(seatCode);//thêm ghế vừa chọn vào danh sách ghế được chọn

                    let tmp = currentChoosingSeat[i].querySelector('.seatName').value;
                    //phần hiển thị ở modal
                    selectedSeatCodeElement.textContent = tmp;
                    //phần input và hiển thị ở form
                    confirmedSeat.value = tmp;
                    confirmedSeatForDisplaying.textContent = tmp;
                } else { // nhấn thêm lần nữa vào ghế đang chọn để huỷ chọn
                    const seatRects = seatContainer.querySelectorAll('svg rect');
                    seatRects.forEach(rect => {
                        rect.setAttribute("fill", "#FFF");
                        rect.setAttribute("stroke", "#B8B8B8");
                    });
                    const seatPaths = seatContainer.querySelectorAll('path');
                    seatPaths.forEach(path => {
                        path.setAttribute("d", " ");
                    });

                    const index = selectedSeats.indexOf(seatCode);
                    if (index > -1) {
                        selectedSeats.splice(index, 1);
                    }
                    currentChoosingSeat[i] = null;
                    selectedSeatCodeElement.textContent = 'None';
                    confirmedSeatForDisplaying.textContent = 'Not Selected';
                    confirmedSeat.value = null;
                }
            }
            function openSeatModal(i) {

                $("#seatModal" + i).modal('show');
            }
            ;
            function validateSelectTicket() {
                const seatInputs = document.querySelectorAll("input[type='hidden'][name^='code']");

                for (let input of seatInputs) {
                    if (!input.value) {
                        alert("Please select a seat for all tickets before submitting.");
                        return false;
                    }
                }
                return true;
            }

            function submitPassengerForm() {
                const form = document.getElementById("passengerForm");
                if (form.checkValidity() && validateSelectTicket()) {
                    form.submit();
                } else {
                    form.reportValidity();
                }

            }

            function updateTotalBaggage() {
                var totalBaggage = 0;
            <% for(int i = 0; i < adultTicket; i++) { %>
                var baggagePrice = parseFloat(document.getElementById("baggage<%=i%>").value);
                totalBaggage += isNaN(baggagePrice) ? 0 : baggagePrice;
            <% } %>
                document.getElementById("totalBaggage").innerText = "= " + new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(totalBaggage);
                updateTotalPrice(totalBaggage);
            }

            function updateTotalPrice(totalBaggage) {
                var a = <%= fd.getPrice() * (sc.getSurcharge()+1) * (adultTicket + childTicket + infantTicket) %>;
                var total = a + totalBaggage;
                document.getElementById("totalPrice").innerText = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(total);
                ;
            }

        </script>
    </body>
</html>
