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
<%@page import="model.Airline" %>
<%@page import="model.Location" %>
<%@page import="model.Country" %>
<%@page import="model.PlaneCategory" %>
<%@page import="model.SeatCategory" %>
<%@page import="java.util.List" %>
<%@page import="dal.AirlineManageDAO" %>
<%@page import="dal.FlightDetailDAO" %>
<%@page import="dal.PlaneCategoryDAO" %>
<%@page import="dal.SeatCategoryDAO" %>
<%@page import="dal.AirportDAO" %>
<%@page import="dal.LocationDAO" %>
<%@page import="dal.CountryDAO" %>
<%@page import="dal.BaggageManageDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Flight Tickets</title>
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

            .main-container2 form label {
                font-size: 14px;
                color: #666;
                margin-bottom: 5px;
            }

            .main-container2 form input[type="text"],
            .main-container2 form input[type="date"],
            .main-container2 form input[type="number"],
            .main-container2 form select {
                padding: 5px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                transition: border-color 0.3s ease;
            }

            .main-container2 form input[type="text"]:focus,
            .main-container2 form input[type="date"]:focus,
            .main-container2 form input[type="number"]:focus,
            .main-container2 form select:focus {
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
            %>

            <div style="display: flex; justify-content: space-between">
                <div class="main-container2 passenger-info" style="width: 68%">
                    <div style="width: 100%; text-align: center;
                         font-size: 20px;
                         color: #333;
                         margin-bottom: 20px;
                         color: #3C6E57;
                         letter-spacing: 1px;"><p>PASSENGER INFORMATION</p></div>
                    <div style="width: 100%">
                        <form style="width: 100%" id="passengerForm" action="bookingFlightTickets" method="post">
                            <input type="hidden" name="flightDetailId" value="<%=flightDetailId%>"/>
                            <input type="hidden" name="seatCategoryId" value="<%=sc.getId()%>"/>
                            <input type="hidden" name="adultTicket" value="<%=adultTicket%>"/>
                            <input type="hidden" name="childTicket" value="<%=childTicket%>"/>
                            <input type="hidden" name="infantTicket" value="<%=infantTicket%>"/>      
                            <% for(int i = 0; i<adultTicket; i++){
                            %>
                            <div class="passenger-info-input" style="position: relative">
                                <div style="position: absolute;
                                     top: -14px;
                                     font-size: 16px;
                                     background-color: white;
                                     color: #3C6E57;
                                     padding: 0 10px;">PASSENGER ADULT <%=i+1%> </div>
                                <div style="padding: 15px">
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 168px">Full Name:</div> 
                                        <select name="pSex" style="margin-right: 5px">
                                            <option value="1">Mr</option>
                                            <option value="0">Mrs</option>
                                        </select>
                                        <input type="text" name="pName<%=i%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Date of birth:</div>
                                        <input type="date" name="pDob" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Phone number:</div>
                                        <input type="number" name="pPhoneNumber" required/>
                                    </div>
                                    <div class="passenger-info-input-box"  >
                                        <div class="passenger-info-input-title" style="width: 121px">Baggage:</div>
                                        <select name="pBaggages" id="baggage<%=i%>" onchange="updateTotalBaggage()">
                                            <option value="0">Buy 0kg extra checked baggage - <%=currencyFormatter.format(0)%></option>
                                            <% for(Baggages b : bmd.getAllBaggagesByAirline(airlineId)){
                                            %>
                                            <option value="<%=b.getId()%>">Buy <%=b.getWeight()%>kg extra checked baggage - <%=currencyFormatter.format(b.getPrice())%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                            <% for(int i = 0; i<childTicket; i++){
                            %>
                            <div class="passenger-info-input" style="position: relative">
                                <div style="position: absolute;
                                     top: -14px;
                                     font-size: 16px;
                                     background-color: white;
                                     color: #3C6E57;
                                     padding: 0 10px;">PASSENGER CHILDREN <%=i+1%> </div>
                                <div style="padding: 15px">
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 168px">Full Name:</div> 
                                        <select name="pSex" style="margin-right: 5px">
                                            <option value="1">Boy</option>
                                            <option value="0">Girl</option>
                                        </select>
                                        <input type="text" name="pName<%=i%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Date of birth:</div>
                                        <input type="date" name="pDob" required/>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                            <% for(int i = 0; i<infantTicket; i++){
                            %>
                            <div class="passenger-info-input" style="position: relative">
                                <div style="position: absolute;
                                     top: -14px;
                                     font-size: 16px;
                                     background-color: white;
                                     color: #3C6E57;
                                     padding: 0 10px;">PASSENGER INFANT <%=i+1%> </div>
                                <div style="padding: 15px">
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 168px">Full Name:</div> 
                                        <select name="pSex" style="margin-right: 5px">
                                            <option value="1">Boy</option>
                                            <option value="0">Girl</option>
                                        </select>
                                        <input type="text" name="pName<%=i%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Date of birth:</div>
                                        <input type="date" name="pDob" required/>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>

                        </form>
                    </div>
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
                    <div class="ticket-payment">
                        <strong>Select payment type:</strong>
                        <input type="radio" name="byQR" value=""/>
                        <input type="radio" name="byVNPay" value=""/>
                    </div>
                    <div style="width: 100%">
                        <button style="width: 100%; background-color:  #9DC567; padding: 10px 30px; border: none; border-radius: 8px; color: white"
                                onclick="submitPassengerForm()"
                                >SUBMIT</button>
                    </div>

                </div>
            </div>
        </div>
        <script>
            function submitPassengerForm() {
                const form = document.getElementById("passengerForm");

                if (form.checkValidity()) {
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
