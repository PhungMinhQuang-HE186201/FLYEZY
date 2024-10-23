/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.AirportDAO;
import dal.CountryDAO;
import dal.FlightDetailDAO;
import dal.LocationDAO;
import dal.OrderDAO;
import dal.PlaneCategoryDAO;
import dal.StatusDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;
import model.Airport;
import model.Country;
import model.FlightDetails;
import model.Flights;
import model.Location;
import model.Order;
import model.PlaneCategory;
import model.Status;

/**
 *
 * @author PMQUANG
 */
public class OrderManagementServlet extends HttpServlet {

    FlightDetailDAO fdd = new FlightDetailDAO();
    OrderDAO od = new OrderDAO();
    AccountsDAO ad = new AccountsDAO();
    AirportDAO aid = new AirportDAO();
    LocationDAO ld = new LocationDAO();
    CountryDAO cd = new CountryDAO();
    PlaneCategoryDAO pcd = new PlaneCategoryDAO();
    StatusDAO statusDao = new StatusDAO();
    TicketDAO td = new TicketDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        if (idd == null) {
            response.sendRedirect("login");
            return;
        } else {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
        }
        String flightDetailIdStr = request.getParameter("flightDetailID");
        int flightDetailId = Integer.parseInt(flightDetailIdStr);
        if (request.getAttribute("flightDetailID") == null) {
            int flightDetailID = Integer.parseInt(request.getParameter("flightDetailID"));
            request.setAttribute("flightDetailID", flightDetailID);
        }
        int flightDetailID = (int) request.getAttribute("flightDetailID");

        int airlineId = fdd.getAirlineIdByFlightDetailId(flightDetailId);
        Flights flight = fdd.getFlightByFlightDetailId(flightDetailId);

        Airport airportDep = aid.getAirportById(flight.getDepartureAirportId());
        request.setAttribute("airportDep", airportDep);
        Location locationDep = ld.getLocationById(airportDep.getId());
        request.setAttribute("locationDep", locationDep);
        Country countryDep = cd.getCountryById(locationDep.getCountryId());
        request.setAttribute("countryDep", countryDep);

        Airport airportDes = aid.getAirportById(flight.getDestinationAirportId());
        request.setAttribute("airportDes", airportDes);
        Location locationDes = ld.getLocationById(airportDes.getId());
        request.setAttribute("locationDes", locationDes);
        Country countryDes = cd.getCountryById(locationDes.getCountryId());
        request.setAttribute("countryDes", countryDes);

        FlightDetails flightDetail = fdd.getFlightDetailsByID(flightDetailId);
        request.setAttribute("flightDetail", flightDetail);
        PlaneCategory planeCatrgory = pcd.getPlaneCategoryById(flightDetail.getPlaneCategoryId());
        request.setAttribute("planeCatrgory", planeCatrgory);
        
        OrderDAO od = new OrderDAO();

        int numberOfItem = od.getNumberOfOrdersByFlightDetail(flightDetailId);
            int numOfPage = (int) Math.ceil((double) numberOfItem / 5);
            String idx = request.getParameter("index");
            int index =1;
            if(idx!=null){
                index = Integer.parseInt(idx);
            }
            request.setAttribute("index", index);
            request.setAttribute("numOfPage", numOfPage);
            
        List<Order> listOrder = od.getAllOrdersByFlightDetailWithPaging(flightDetailId,index);
        String submit = request.getParameter("submit");
        if (submit == null) {
            listOrder = od.getAllOrdersByFlightDetail(flightDetailID);
            listOrder = od.getAllOrdersByFlightDetailWithPaging(flightDetailId,index);
        } else {
            // Search for airlines based on keyword and status
            String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : null;
            String code = request.getParameter("code") != null ? request.getParameter("code").trim() : null;
            String statusParam = request.getParameter("status");
            int statusId = -1;

            // Ensure status is a valid integer
            if (statusParam != null && !statusParam.isEmpty()) {
                try {
                    statusId = Integer.parseInt(statusParam);
                } catch (NumberFormatException e) {
                    // Log the error and handle it accordingly (e.g., set statusId to null or default)
                    System.out.println("Invalid status ID format: " + e.getMessage());
                }
            }


            listOrder = od.searchOrder(statusId, code, keyword, flightDetailId,index);
        }
        List<Status> listStatus = statusDao.getStatusOfOrder();
        request.setAttribute("airlineId", airlineId);
        request.setAttribute("flight", flight);
        request.setAttribute("listOrder", listOrder);
        request.setAttribute("flightDetailId", flightDetailId);
        request.setAttribute("listStatus", listStatus);
        request.getRequestDispatcher("view/orderManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("changeStatus".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int flightDetailId = Integer.parseInt(request.getParameter("flightDetailId"));
            int statusId = Integer.parseInt(request.getParameter("statusId"));

            // Update status logic
            od.updateOrderStatus(orderId, statusId);
            if (statusId == 10) {
                td.confirmSuccessAllTicketsByOrderId(orderId);
            }
            // Redirect to the order page after update
            response.sendRedirect("OrderController?flightDetailID=" + flightDetailId);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
