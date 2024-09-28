/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AirlineManageDAO;
import dal.BaggageManageDAO;
import dal.AccountsDAO;
import dal.PlaneCategoryDAO;
import dal.SeatCategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airline;
import model.Baggages;

/**
 *
 * @author PMQUANG
 */
public class AirlineManagementServlet extends HttpServlet {

    AirlineManageDAO airlineManageDao = new AirlineManageDAO();
    BaggageManageDAO baggageManageDao = new BaggageManageDAO();
    AccountsDAO accountsDao = new AccountsDAO();
    PlaneCategoryDAO planeCategoryDao = new PlaneCategoryDAO();
    SeatCategoryDAO seatCategoryDao = new SeatCategoryDAO();

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
        //action
        String action = request.getParameter("action") == null
                ? action = "" : request.getParameter("action");
        switch (action) {
            case "add":
                addAirline(request);
                break;
            case "changeStatus":
                ChangeStatusAirline(request);
                break;
            case "update":
                updateAirline(request);
                break;
            default:

        }
        response.sendRedirect("airlineController");
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

    private void addAirline(HttpServletRequest request) {
        try {
            // Lấy thông tin từ request
            String airlineName = request.getParameter("airlineName");
            //get image path
            String airlineImage = "img/" + request.getParameter("airlineImage");
            //get info
            String airlineInfo = request.getParameter("airlineInfo");

            Airline airline = new Airline(airlineName, airlineImage,airlineInfo);

            // Thêm airline vào cơ sở dữ liệu
            // Lấy airlineId
            int airlineId = airlineManageDao.createAirline(airline);

            // Lấy danh sách baggage
            String[] baggageWeights = request.getParameterValues("baggageWeight");
            String[] baggagePrices = request.getParameterValues("baggagePrice");

            // Kiểm tra và thêm baggage vào cơ sở dữ liệu
            if (baggageWeights != null && baggagePrices != null) {
                for (int i = 0; i < baggageWeights.length; i++) {
                    // Phân tích và thêm baggage vào cơ sở dữ liệu
                    float weight = Float.parseFloat(baggageWeights[i]);
                    int price = Integer.parseInt(baggagePrices[i]);

                    // Thêm baggage vào cơ sở dữ liệu với airlineId
                    baggageManageDao.createBaggages(new Baggages(weight, price, airlineId));
                }
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi chuyển đổi số
            e.printStackTrace();
        } catch (Exception e) {
            // Xử lý lỗi khác
            e.printStackTrace();
        }

    }

    private void ChangeStatusAirline(HttpServletRequest request) {
        try {
            int airlineId = Integer.parseInt(request.getParameter("airlineId"));
            int statusId = Integer.parseInt(request.getParameter("airlineStatus"));
            int newStatusId = 1;
            if(statusId == 1){
                baggageManageDao.DeactiveAllByAirline(airlineId);
                planeCategoryDao.deactivatePlaneCategoryByAirline(airlineId);
                seatCategoryDao.deactivateAllSeatCategoryByAirline(airlineId);
                newStatusId = 2;
            }else if(statusId == 2){
                baggageManageDao.ReactiveAllByAirline(airlineId);
                planeCategoryDao.activatePlaneCategoryByAirline(airlineId);
                seatCategoryDao.activateAllSeatCategoryByAirline(airlineId);
                newStatusId = 1;
            }
            airlineManageDao.changeStatus(airlineId, newStatusId);
        } catch (Exception e) {
            // Xử lý lỗi khác
            e.printStackTrace();
        }
    }

    private void updateAirline(HttpServletRequest request) {
        try {
            int airlineId = Integer.parseInt(request.getParameter("airlineId"));
            String airlineName = request.getParameter("airlineName");
            String airlineImage = "img/" + request.getParameter("airlineImage");
            String airlineInfo = request.getParameter("airlineInfo");
            if (airlineImage.equals("img/")) {
                airlineImage = airlineManageDao.getAirlineById(airlineId).getImage();
            }

            Airline airline = new Airline(airlineId, airlineName, airlineImage,airlineInfo);
            airlineManageDao.updateAirline(airline);
        } catch (Exception e) {
            // Xử lý lỗi khác
            e.printStackTrace();
        }
    }
}
