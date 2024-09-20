/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.SeatCategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.SeatCategory;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SeatCategoryControllerServlet", urlPatterns = {"/seatCategoryController"})
public class SeatCategoryControllerServlet extends HttpServlet {

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
            out.println("<title>Servlet SeatCategoryControllerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SeatCategoryControllerServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        SeatCategoryDAO scd = new SeatCategoryDAO();
        if (action.equals("remove")) { //ok
            int id = Integer.parseInt(request.getParameter("id"));
            scd.deleteSeatCategory(id);
            response.sendRedirect("planeCategoryController");
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
        SeatCategoryDAO scd = new SeatCategoryDAO();

        String idStr = request.getParameter("id");
        String image = "img/" + request.getParameter("image");
        String name = request.getParameter("name");
        String numberOfSeatStr = request.getParameter("numberOfSeat");
        String info = request.getParameter("info");
        String planeCategoryIdStr = request.getParameter("planeCategoryId");
        int numberOfSeat = 0;
        int planeCategoryId = 0;
        try {
            numberOfSeat = Integer.parseInt(numberOfSeatStr);
            planeCategoryId = Integer.parseInt(planeCategoryIdStr);
        } catch (Exception e) {
        }

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                if (image.equals("img/")) {
                    image = scd.getSeatCategoryById(id).getImage();
                }
                scd.updateSeatCategory(new SeatCategory(id, name, numberOfSeat, image, info, planeCategoryId));
                response.sendRedirect("planeCategoryController");
            } catch (Exception e) {
            }
        } else {
            scd.addSeatCategory(new SeatCategory(name, numberOfSeat, image, info, planeCategoryId));
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
