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
import dal.RolesDAO;
import dal.AirlineManageDAO;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import model.Accounts;
import model.Roles;
import model.Airline;
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
        AccountsDAO ad = new AccountsDAO();
        RolesDAO rd = new RolesDAO();
        AirlineManageDAO amd = new AirlineManageDAO();
        HttpSession session = request.getSession();

        Integer idd = (Integer) session.getAttribute("id");
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);

        List<Roles> rolesList = rd.getAllRoles();
        request.setAttribute("rolesList", rolesList);
        
        List<Airline> airlineList = amd.getAllAirline();
        request.setAttribute("airlineList", airlineList);

        String action = request.getParameter("action");
        if (action == null) {
            List<Accounts> accountList = ad.getAllAccounts();
            request.setAttribute("accountList", accountList);
            request.getRequestDispatcher("accountController.jsp").forward(request, response);
        } else if (action.equals("remove")) { //ok
            int id = Integer.parseInt(request.getParameter("idAcc"));
            ad.removeAccount(id);
            response.sendRedirect("accountController");
        } else if (action.equals("search")) {
            String fRole = request.getParameter("fRole");
            String fName = request.getParameter("fName");
            String fPhoneNumber = request.getParameter("fPhoneNumber");
            List<Accounts> accountList = ad.searchAccounts(fRole, fName, fPhoneNumber);
            request.setAttribute("accountList", accountList);
            request.getRequestDispatcher("accountController.jsp").forward(request, response);
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
        AccountsDAO ad = new AccountsDAO();
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String roleIdStr = request.getParameter("roleId");
        String airlineIDStr = request.getParameter("airlineID");
        String dobStr = request.getParameter("dob");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String image = "img/" + request.getParameter("image");
        String create_at = request.getParameter("createdAt");
        //insert
        try {
            if (action.equals("update")) {
                
                int id = Integer.parseInt(idStr);
                int roleId = Integer.parseInt(roleIdStr);
                int airlineID = Integer.parseInt(airlineIDStr);
                Date dob = Date.valueOf(dobStr);
                Timestamp ca = Timestamp.valueOf(create_at);
                
                if (image.equals("img/")) {
                    image = ad.getAccountsById(id).getImage();
                }
                
                Accounts newAcc = new Accounts(id, name, email, password, phoneNumber, address, image, dob, roleId, airlineID,ca,new Timestamp(System.currentTimeMillis()));
                
                ad.updateAccount(newAcc);
                response.sendRedirect("accountController");
            } else if (action.equals("create")) {
                int roleId = Integer.parseInt(roleIdStr);
                int airlineID = Integer.parseInt(airlineIDStr);
                Date dob = Date.valueOf(dobStr);
                //Integer.parseInt(request.getParameter("airlineId"));

                Accounts newAcc = new Accounts(name, email, password, phoneNumber, address, image, dob, roleId, airlineID,new Timestamp(System.currentTimeMillis()));
                boolean check = ad.checkAccount(newAcc);
                if (check==true) {
                    int n = ad.createAccount(newAcc);
                    response.sendRedirect("accountController");
                } else {
                    String message = "Account already exists";
                    List<Accounts> accountList = ad.getAllAccounts();
                    request.setAttribute("accountList", accountList);
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("accountController.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {

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
