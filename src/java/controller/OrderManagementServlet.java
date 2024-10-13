/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.FlightDetailDAO;
import dal.OrderDAO;
import dal.StatusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;
import model.Flights;
import model.Order;
import model.Status;

/**
 *
 * @author PMQUANG
 */
public class OrderManagementServlet extends HttpServlet {

    FlightDetailDAO fdd = new FlightDetailDAO();
    OrderDAO od = new OrderDAO();
    AccountsDAO ad = new AccountsDAO();
    StatusDAO statusDao = new StatusDAO();

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
        int airlineId = fdd.getAirlineIdByFlightDetailId(flightDetailId);
        Flights flight = fdd.getFlightByFlightDetailId(flightDetailId);
        List<Order> listOrder = od.getAllOrdersByFlightDetail(flightDetailId);
        String submit = request.getParameter("submit");
        if (submit == null) {
            listOrder = od.getAllOrdersByFlightDetail(flightDetailId);
        } else {
            // Search for airlines based on keyword and status
            String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : null;
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

            // Fetch the airlines based on search criteria
            listOrder = od.getOrdersByCriteria(statusId, keyword,flightDetailId);
        }
        List<Status> listStatus = statusDao.getAllStatus();
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

        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int flightDetailId = Integer.parseInt(request.getParameter("flightDetailId"));
            int statusId = Integer.parseInt(request.getParameter("statusId"));

            // Update status logic
            od.updateOrderStatus(orderId, statusId);

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
