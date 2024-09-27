/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.SeatCategory;

/**
 *
 * @author Admin
 */
public class SeatCategoryDAO extends DBConnect {

    public List<SeatCategory> getAllSeatCategoryByPlaneCategoryId(int id) {
        List<SeatCategory> ls = new ArrayList<>();
        String sql = "SELECT * FROM Seat_Category WHERE Plane_Categoryid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SeatCategory sc = new SeatCategory(rs.getInt("id"),
                        rs.getString("name"), rs.getInt("numberOfSeat"),
                        rs.getString("image"), rs.getString("info"),
                        rs.getFloat("surcharge"), rs.getInt("Plane_Categoryid"),
                        rs.getInt("Status_id"));
                ls.add(sc);
            }
            return ls;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public SeatCategory getSeatCategoryById(int id) {
        List<SeatCategory> ls = new ArrayList<>();
        String sql = "SELECT * FROM Seat_Category WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                SeatCategory sc = new SeatCategory(rs.getInt("id"),
                        rs.getString("name"), rs.getInt("numberOfSeat"),
                        rs.getString("image"), rs.getString("info"),
                        rs.getFloat("surcharge"), rs.getInt("Plane_Categoryid"),
                        rs.getInt("Status_id"));
                return sc;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addSeatCategory(SeatCategory sc) {
        String sql = "INSERT INTO Seat_Category (name, numberOfSeat, image, info, surcharge, Plane_Categoryid, Status_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sc.getName());
            ps.setInt(2, sc.getNumberOfSeat());
            ps.setString(3, sc.getImage());
            ps.setString(4, sc.getInfo());
            ps.setFloat(5, sc.getSurcharge());
            ps.setInt(6, sc.getPlane_Categoryid());
            ps.setInt(7, sc.getStatusId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateSeatCategory(SeatCategory sc) {
        String sql = "UPDATE Seat_Category SET name = ?, numberOfSeat = ?, image = ?, info = ?, surcharge = ?, Plane_Categoryid = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sc.getName());
            ps.setInt(2, sc.getNumberOfSeat());
            ps.setString(3, sc.getImage());
            ps.setString(4, sc.getInfo());
            ps.setFloat(5, sc.getSurcharge());
            ps.setInt(6, sc.getPlane_Categoryid());
            ps.setInt(7, sc.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean activateSeatCategoryById(int id) {
        String sql = "UPDATE Seat_Category SET Status_id = 1 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deactivateSeatCategoryById(int id) {
        String sql = "UPDATE Seat_Category SET Status_id = 2 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean activateAllSeatCategoryByPlaneCategoryId(int id) {
        String sql = "UPDATE Seat_Category SET Status_id = 1 WHERE Plane_Categoryid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deactivateAllSeatCategoryByPlaneCategoryId(int id) {
        String sql = "UPDATE Seat_Category SET Status_id = 2 WHERE Plane_Categoryid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        SeatCategoryDAO scd = new SeatCategoryDAO();
        System.out.println(scd.getSeatCategoryById(7).getStatusId());
    }
}
