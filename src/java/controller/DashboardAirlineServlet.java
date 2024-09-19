/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AirlineManageDAO;
import dal.BaggageManageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Airline;
import model.Baggages;

/**
 *
 * @author PMQUANG
 */
public class DashboardAirlineServlet extends HttpServlet {

    AirlineManageDAO airlineManageDao = new AirlineManageDAO();
    BaggageManageDAO baggageManageDao = new BaggageManageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //list airline
        List<Airline> listAirline;
        //list baggage
        List<Baggages> listBaggage = baggageManageDao.getAllBaggages();
        String submit = request.getParameter("submit");
        if (submit == null) {
            listAirline = airlineManageDao.getAllAirline();
        } else {
            String keyword = request.getParameter("keyword");
            listAirline = airlineManageDao.getAirlineByName(keyword);
        }

        HttpSession session = request.getSession();
        session.setAttribute("listAirline", listAirline);
        session.setAttribute("listBaggage", listBaggage);

        request.getRequestDispatcher("airlineManage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
