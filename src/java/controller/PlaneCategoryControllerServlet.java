/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.PlaneCategoryDAO;
import dal.SeatCategoryDAO;
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
import model.PlaneCategory;

/**
 *
 * @author Admin
 */
@WebServlet(name = "PlaneCategoryControllerServlet", urlPatterns = {"/planeCategoryController"})
public class PlaneCategoryControllerServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PlaneCategoryControllerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PlaneCategoryControllerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        PlaneCategoryDAO pcd = new PlaneCategoryDAO();
        SeatCategoryDAO scd = new SeatCategoryDAO();
        HttpSession session = request.getSession();

        // DuongNT: Retrieve the account information of the currently logged-in user using session
        Integer idd = (Integer) session.getAttribute("id");
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);

        String action = request.getParameter("action");
        if (action == null) {
            List<PlaneCategory> planeCategoryList = pcd.getAllPlaneCategoryByAirlineId(acc.getAirlineId());
            request.setAttribute("planeCategoryList", planeCategoryList);
            request.getRequestDispatcher("planeCategoryController.jsp").forward(request, response);
        } else if (action.equals("remove")) { //ok
            int id = Integer.parseInt(request.getParameter("id"));
            scd.deleteAllSeatCategoryByPlaneCategoryId(id);
            pcd.deletePlaneCategoryById(id);
            response.sendRedirect("planeCategoryController");
        } else if (action.equals("search")) {
            String fName = request.getParameter("fName").trim();
            List<PlaneCategory> accountList = pcd.searchPlaneCategory(fName,acc.getAirlineId());
            request.setAttribute("planeCategoryList", accountList);
            request.getRequestDispatcher("planeCategoryController.jsp").forward(request, response);
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
        PlaneCategoryDAO pcd = new PlaneCategoryDAO();
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String image = "img/" + request.getParameter("image");
        String info = request.getParameter("info");
        String airlineIdStr = request.getParameter("airlineId");
        int airlineId = 0;
        try {
            airlineId = Integer.parseInt(airlineIdStr);
        } catch (Exception e) {
        }
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                if (image.equals("img/")) {
                    image = pcd.getPlaneCategoryById(id).getImage();
                }
                PlaneCategory pc = new PlaneCategory(id, name, image, info, airlineId);
                pcd.updatePlaneCategoryById(pc);
                response.sendRedirect("planeCategoryController");
            } catch (Exception e) {
                response.sendRedirect("home");
            }
        } else {
            PlaneCategory pc = new PlaneCategory(name, image, info, airlineId);
            pcd.addPlaneCategory(pc);
            response.sendRedirect("planeCategoryController");
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
