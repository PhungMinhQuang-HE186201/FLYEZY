/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountsDAO;
import dal.OrderDAO;
import dal.PassengerTypeDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import model.Accounts;
import model.Order;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookingFlightTicketsServlet", urlPatterns = {"/bookingFlightTickets"})
public class BookingFlightTicketsServlet extends HttpServlet {

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
            out.println("<title>Servlet BookingFlightTicketsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingFlightTicketsServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        Integer idd = (Integer) session.getAttribute("id");
        if (idd != null) {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
        }
        request.getRequestDispatcher("view/bookingFlightTickets.jsp").forward(request, response);

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
        OrderDAO od = new OrderDAO();
        TicketDAO td = new TicketDAO();
        PassengerTypeDAO ptd = new PassengerTypeDAO();
        AccountsDAO ad = new AccountsDAO();
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        try {
            String pContactName = request.getParameter("pContactName");
            String pContactPhoneNumber = request.getParameter("pContactPhoneNumber");
            String pContactEmail = request.getParameter("pContactEmail");

            int flightDetailId = Integer.parseInt(request.getParameter("flightDetailId"));
            int seatCategoryId = Integer.parseInt(request.getParameter("seatCategoryId2"));
            String flightDetailId2Str = request.getParameter("flightDetailId2");
            int flightDetailId2 = 0;
            int seatCategoryId2 = 0;
            if (flightDetailId2Str != null) {
                flightDetailId2 = Integer.parseInt(flightDetailId2Str);
                seatCategoryId2 = Integer.parseInt(request.getParameter("seatCategoryId"));
            }
            int adultTicket = Integer.parseInt(request.getParameter("adultTicket"));
            int childTicket = Integer.parseInt(request.getParameter("childTicket"));
            int infantTicket = Integer.parseInt(request.getParameter("infantTicket"));
            int totalPassengers = adultTicket + childTicket + infantTicket;
            float commonPriceFloat = Float.parseFloat(request.getParameter("commonPrice"));
            int commonPrice = (int) Math.round(commonPriceFloat);

            float totalPriceFloat = Float.parseFloat(request.getParameter("totalPrice"));
            int totalPrice = (int) Math.round(totalPriceFloat);

            String orderCode = od.createOrder(flightDetailId, pContactName, pContactPhoneNumber, pContactEmail, totalPrice, id);
            Order o = od.getOrderByCode(orderCode);

            for (int i = 1; i <= adultTicket; i++) {
                int pSex = Integer.parseInt(request.getParameter("pSex" + i));
                String pName = request.getParameter("pName" + i);
                Date pDob = Date.valueOf(request.getParameter("pDob" + i));
                String pPhoneNumber = request.getParameter("pPhoneNumber" + i);
                String code = request.getParameter("code" + i);

                if (td.getTicketByCode(code, flightDetailId, seatCategoryId) != null) {
                    od.deleteOrderByCode(o.getCode());
                    request.getRequestDispatcher("view/failedBooking.jsp").forward(request, response);
                    return;
                }

                Integer pBaggages = request.getParameter("pBaggages" + i).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + i));

                if (flightDetailId2Str != null) {
                    float commonPriceFloat2 = Float.parseFloat(request.getParameter("commonPrice2"));
                    int commonPrice2 = (int) Math.round(commonPriceFloat2);
                    String code2 = request.getParameter("code" + (totalPassengers + i));

                    if (td.getTicketByCode(code2, flightDetailId2, seatCategoryId2) != null) {
                        od.deleteOrderByCode(o.getCode());
                        request.getRequestDispatcher("view/failedBooking.jsp").forward(request, response);
                        return;
                    }

                    Integer pBaggages2 = request.getParameter("pBaggages" + (totalPassengers + i)).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + (totalPassengers + i)));

                    td.createTicket(code, seatCategoryId, 1, pName, pSex, pPhoneNumber, pDob, pBaggages, (int) (commonPrice * ptd.getPassengerTypePriceNameById(1)), o.getId(), 2);
                    td.createTicket(code2, seatCategoryId2, 1, pName, pSex, pPhoneNumber, pDob, pBaggages2, (int) (commonPrice2 * ptd.getPassengerTypePriceNameById(1)), o.getId(), 3);
                } else {
                    td.createTicket(code, seatCategoryId, 1, pName, pSex, pPhoneNumber, pDob, pBaggages, (int) (commonPrice * ptd.getPassengerTypePriceNameById(1)), o.getId(), 1);
                }
            }

            for (int i = adultTicket + 1; i <= adultTicket + childTicket; i++) {
                int pSex = Integer.parseInt(request.getParameter("pSex" + i));
                String pName = request.getParameter("pName" + i);
                Date pDob = Date.valueOf(request.getParameter("pDob" + i));
                String code = request.getParameter("code" + i);
                if (td.getTicketByCode(code, flightDetailId, seatCategoryId) != null) {
                    od.deleteOrderByCode(o.getCode());
                    request.getRequestDispatcher("view/failedBooking.jsp").forward(request, response);
                    return;
                }
                td.createTicket(code, seatCategoryId, 2, pName, pSex, "000", pDob, null, (int) (commonPrice * ptd.getPassengerTypePriceNameById(2)), o.getId(), 1);
            }
            for (int i = adultTicket + childTicket + 1; i <= totalPassengers; i++) {
                int pSex = Integer.parseInt(request.getParameter("pSex" + i));
                String pName = request.getParameter("pName" + i);
                Date pDob = Date.valueOf(request.getParameter("pDob" + i));
                String code = request.getParameter("code" + i);
                if (td.getTicketByCode(code, flightDetailId, seatCategoryId) != null) {
                    od.deleteOrderByCode(o.getCode());
                    request.getRequestDispatcher("view/failedBooking.jsp").forward(request, response);
                    return;
                }
                td.createTicket(code, seatCategoryId, 3, pName, pSex, "000", pDob, null, (int) (commonPrice * ptd.getPassengerTypePriceNameById(3)), o.getId(), 1);
            }
            if (id != null) {
                Accounts acc = ad.getAccountsById(id);
                request.setAttribute("account", acc);
            }
            request.getRequestDispatcher("view/successfulBooking.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("view/error.jsp").forward(request, response);
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
