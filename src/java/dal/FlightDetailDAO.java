package dal;

import com.mysql.cj.jdbc.PreparedStatementWrapper;
import dal.DBConnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.FlightDetails;
import java.sql.Time;
import java.sql.Date;
import model.Flights;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Admin
 */
public class FlightDetailDAO extends DBConnect {

    public List<FlightDetails> getAll() {
        List<FlightDetails> ls = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.flight_detail";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FlightDetails flightDetail = new FlightDetails();
                flightDetail.setId(rs.getInt("id"));
                flightDetail.setDate(rs.getDate("date"));
                flightDetail.setTime(rs.getTime("time"));  // Chuyển đổi từ SQL Time sang LocalTime
                flightDetail.setPrice(rs.getInt("price"));
                flightDetail.setFlightId(rs.getInt("Flightid"));
                flightDetail.setPlaneCategoryId(rs.getInt("Plane_Categoryid"));
                flightDetail.setStatusId(rs.getInt("Status_id"));
                ls.add(flightDetail);
            }

        } catch (SQLException e) {
            e.getMessage();
        }
        return ls;
    }

    public void addnew(FlightDetails flightDetail) {
        String sql = "INSERT INTO flight_detail (date, time, price, flightid, Plane_Categoryid, Status_id) VALUES (?, ?, ?, ?, ?, 3)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setDate(1, flightDetail.getDate());
            ps.setTime(2, flightDetail.getTime());
            ps.setInt(3, flightDetail.getPrice());
            ps.setInt(4, flightDetail.getFlightId());
            ps.setInt(5, flightDetail.getPlaneCategoryId());
            // Thực hiện thao tác chèn
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Chèn thành công.");
            } else {
                System.out.println("Chèn thất bại.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateFlightDetail(FlightDetails flightDetail, int id) {
        String sql = "UPDATE flight_detail SET date = ?, time = ?, price = ?, flightid = ?, plane_categoryid = ? WHERE id = ? ";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, flightDetail.getDate());
            ps.setTime(2, flightDetail.getTime());
            ps.setInt(3, flightDetail.getPrice());
            ps.setInt(4, flightDetail.getFlightId());
            ps.setInt(5, flightDetail.getPlaneCategoryId());
            ps.setInt(6, id);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.getMessage();
        }
        return false;
    }
    public void updateFlightStatus(int Id, int status) {
        String sql = "UPDATE flight_detail SET Status_id = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, Id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void main(String[] args) {
        FlightDetailDAO dao = new FlightDetailDAO();
        List<FlightDetails> ls = dao.getAll();
        for(FlightDetails i : ls){
            System.out.println(i.getPlaneCategoryId());
        }
    }
}
