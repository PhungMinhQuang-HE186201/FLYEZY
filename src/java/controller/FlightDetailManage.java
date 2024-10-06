/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FlightDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import java.sql.Time;
import model.FlightDetails;

/**
 *
 * @author Admin
 */
@WebServlet(name = "FlightDetailManage", urlPatterns = {"/FlightDetailManage"})
public class FlightDetailManage extends HttpServlet {

    FlightDetailDAO dao = new FlightDetailDAO();

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
            out.println("<title>Servlet FlightDetailManage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FlightDetailManage at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                handleAddFlightDetail(request, response);
                break;
            case "update":
                handleUpdateFlightDetail(request, response);
                break;
            case "updstatus":
                handleUpdateFlightStatus(request, response);
                break;
            case "changeDetail":
                changeToTicket(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
        }
    }

    private void changeToTicket(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        int flightDetailID = Integer.parseInt(request.getParameter("flightDetailID"));
        session.setAttribute("flightDetailID", flightDetailID);
        response.sendRedirect("TicketController?flightDetailID=" + flightDetailID);
    }

    private void handleAddFlightDetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        FlightDetails newFlightDetail = createFlightDetailFromRequest(request);
        dao.addnew(newFlightDetail);
        response.sendRedirect("flightManagement");
    }

    private void handleUpdateFlightDetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        FlightDetails updatedFlightDetail = createFlightDetailFromRequest(request);
        dao.updateFlightDetail(updatedFlightDetail, id);
        response.sendRedirect("flightManagement");
    }

    private void handleUpdateFlightStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int status_id = Integer.parseInt(request.getParameter("status"));
        dao.updateFlightStatus(id, status_id);
        response.sendRedirect("flightManagement");
    }

    private FlightDetails createFlightDetailFromRequest(HttpServletRequest request) {
        String dateString = request.getParameter("date");
        String timeString = request.getParameter("time");
        String priceString = request.getParameter("price");
        String flightIdString = request.getParameter("flightId");
        String planeCategoryIdString = request.getParameter("planeCategoryId");

        Date date = Date.valueOf(dateString);
        Time time = Time.valueOf(timeString);
        int price = Integer.parseInt(priceString);
        int flightId = Integer.parseInt(flightIdString);
        int planeCategoryId = Integer.parseInt(planeCategoryIdString);

        FlightDetails flightDetail = new FlightDetails();
        flightDetail.setDate(date);
        flightDetail.setTime(time);
        flightDetail.setPrice(price);
        flightDetail.setFlightId(flightId);
        flightDetail.setPlaneCategoryId(planeCategoryId);

        return flightDetail;
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
