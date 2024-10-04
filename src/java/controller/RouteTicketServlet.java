/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AirportDAO;
import dal.CountryDAO;
import dal.FlightDetailDAO;
import dal.FlightManageDAO;
import dal.FlightTypeDAO;
import dal.LocationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;
import model.Airport;
import model.FlightDetails;
import model.Flights;
import model.Location;

/**
 *
 * @author PMQUANG
 */
public class RouteTicketServlet extends HttpServlet {

    FlightManageDAO flightManageDao = new FlightManageDAO();
    FlightDetailDAO flightDetailsDao = new FlightDetailDAO();
    FlightTypeDAO flightTypeDao = new FlightTypeDAO();
    CountryDAO countryDao = new CountryDAO();
    LocationDAO locationDao = new LocationDAO();
    AirportDAO airportDao = new AirportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String departure = request.getParameter("departure");
        String destination = request.getParameter("destination");
        String departureDate = request.getParameter("departureDate");
        String adult = request.getParameter("adult");
        String child = request.getParameter("child");
        String infant = request.getParameter("infant");
        try {
            int departureId = Integer.parseInt(departure);
            int destinationId = Integer.parseInt(destination);
            Date departDate = Date.valueOf(departureDate);
            int numAdult = Integer.parseInt(adult);
            int numChild = Integer.parseInt(child);
            int numInfant = Integer.parseInt(infant);

            request.setAttribute("departureId", departureId);
            request.setAttribute("destinationId", destinationId);
            request.setAttribute("departDate", departDate);
            request.setAttribute("numAdult", numAdult);
            request.setAttribute("numChild", numChild);
            request.setAttribute("numInfant", numInfant);

        } catch (Exception e) {
        }
        request.getRequestDispatcher("view/routeTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
