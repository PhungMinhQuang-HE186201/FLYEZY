/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FlightManageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

/**
 *
 * @author user
 */
public class FlightManagementServlet extends HttpServlet {

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
            out.println("<title>Servlet FlightManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FlightManagementServlet at " + request.getContextPath() + "</h1>");
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
        FlightManageDAO fmd = new FlightManageDAO();
        
        String sql = "select f.id,f.minutes,a1.name as departureAirport,l1.name as departureLocation,c1.name as departureCountry,\n"
                + "a2.name as destinationAirport,l2.name as destinationLocation, c2.name as destinationCountry from flyezy.flight as f\n"
                + "inner join flyezy.airport as a1 on a1.id = f.departureAirportid\n"
                + "inner join flyezy.airport as a2 on a2.id = f.destinationAirportid\n"
                + "inner join location as l1 on l1.id = a1.locationid\n"
                + "inner join country as c1 on c1.id = l1.country_id\n"
                + "inner join location as l2 on l2.id = a2.locationid\n"
                + "inner join country as c2 on c2.id = l2.country_id;";
        ResultSet rsFlightManage = fmd.getData(sql);
        request.setAttribute("rsFlightManage", rsFlightManage);
        request.getRequestDispatcher("flightManagement.jsp").forward(request, response);

           
    }

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
