/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Order;

/**
 *
 * @author phung
 */
@WebServlet(name = "FindOrderServlet", urlPatterns = {"/findOrder"})
public class FindOrderServlet extends HttpServlet {

    OrderDAO od = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        String contactInfo = request.getParameter("contactInfo");
        if (code != null) {
            code = code.trim();
        }
        if(contactInfo != null){
            contactInfo = contactInfo.trim();
        }
        Order order = od.getOrderByCode(code);
        if (order != null) {
            request.setAttribute("order", order);
            if(contactInfo != null && (contactInfo.equals(order.getContactEmail()) 
                    || contactInfo.equals(order.getContactPhone()))){
                 request.setAttribute("isVerified", true);
            }else{
                request.setAttribute("isVerified", false);
            }
        }
        request.getRequestDispatcher("view/findOrder.jsp").forward(request, response);
    }

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
