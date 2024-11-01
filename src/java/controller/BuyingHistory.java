/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.FlightDetailDAO;
import dal.OrderDAO;
import dal.StatusDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;
import model.FlightDetails;
import model.Order;
import model.Status;
import model.Ticket;

/**
 *
 * @author PMQUANG
 */
@WebServlet(name = "BuyingHistory", urlPatterns = {"/buyingHistory"})
public class BuyingHistory extends HttpServlet {

    StatusDAO statusDao = new StatusDAO();
    AccountsDAO ad = new AccountsDAO();
    OrderDAO od = new OrderDAO();
    FlightDetailDAO fdd = new FlightDetailDAO();
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
        String statusIdParam = request.getParameter("statusId");

        List<Order> listOrder;
        if (statusIdParam != null && !statusIdParam.isEmpty()) {
            int statusId = Integer.parseInt(statusIdParam);
            listOrder = od.getOrdersByStatusAndAccountId(statusId, idd);
        } else {
            String code = request.getParameter("code");
            if (code != null && !code.isEmpty()) {
                listOrder = od.getListOrderByCodeAndAccountId(code.trim(), idd);
            } else {
                listOrder = od.getAllOrdersByAccountId(idd);
            }
        }
        request.setAttribute("listOrder", listOrder);

        List<FlightDetails> listFlightDetails = fdd.getAll();
        request.setAttribute("listFlightDetails", listFlightDetails);
        request.getRequestDispatcher("view/buyingHistory.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
