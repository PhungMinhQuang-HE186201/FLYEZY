/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.AccountsDAO;
import java.util.List;
import model.Accounts;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AccountControllerServlet", urlPatterns = {"/accountController"})
public class AccountControllerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        AccountsDAO AccountsDAO = new AccountsDAO();
        if (action == null) {
            List<Accounts> accountList = AccountsDAO.getAllAccounts();
            request.setAttribute("accountList", accountList);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } else {
            if (action.equals("change")) {
                int id = Integer.parseInt(request.getParameter("id"));
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String phoneNumber = request.getParameter("phoneNumber");
                String address = request.getParameter("address");
                request.setAttribute("roleId", roleId);
                Accounts newAcc = new Accounts(id, name, email, password, phoneNumber, address, email, roleId);
                AccountsDAO.updateAccount(newAcc);
                List<Accounts> accountList = AccountsDAO.getAllAccounts();
                request.setAttribute("accountList", accountList);
                request.getRequestDispatcher("admin.jsp").forward(request, response);
            } else if (action.equals("remove")) {
                int id = Integer.parseInt(request.getParameter("idAcc"));
                int n = AccountsDAO.removeAccount(id);
                response.sendRedirect("accountController");
            } else if (action.equals("search")) {
                String fName = request.getParameter("fName");
                String fPhoneNumber = request.getParameter("fPhoneNumber");
                List<Accounts> accountList = AccountsDAO.getAccountByName(fName, fPhoneNumber);
                request.setAttribute("accountList", accountList);
                request.setAttribute("fName", fName);
                request.setAttribute("fPhoneNumber", fPhoneNumber);
                request.getRequestDispatcher("admin.jsp").forward(request, response);
            }
        }
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
        processRequest(request, response);
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
