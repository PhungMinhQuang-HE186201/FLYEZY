/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
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
import model.Accounts;

/**
 *
 * @author PMQUANG
 */
@WebServlet(name = "CancelTicketRequestServlet", urlPatterns = {"/cancelTicket"})
public class CancelTicketRequestServlet extends HttpServlet {

    StatusDAO sd = new StatusDAO();
    TicketDAO td = new TicketDAO();
    OrderDAO od = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountsDAO ad = new AccountsDAO();

        HttpSession session = request.getSession();

        Integer idd = (Integer) session.getAttribute("id");
        if (idd != null) {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
        }

        request.getRequestDispatcher("view/cancelTicketRequest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ticketIdStr = request.getParameter("ticketId");
        String orderIdStr = request.getParameter("orderId");
        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            int orderId = Integer.parseInt(orderIdStr);
            request.setAttribute("orderId", orderId);
            td.cancelTicketById(ticketId);
            
            if(td.countNumberTicketNotCancel(orderId) == 0){
                od.updateOrderStatus(orderId, 12); 
            }
        } catch (Exception e) {

        }
        response.sendRedirect("cancelTicket");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
