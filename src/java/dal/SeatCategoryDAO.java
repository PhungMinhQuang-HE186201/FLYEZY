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
                SeatCategory sc = new SeatCategory(rs.getInt("id"), rs.getString("name"), rs.getInt("numberOfSeat"),
                        rs.getString("image"), rs.getString("info"), rs.getInt("Plane_Categoryid"));
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
                SeatCategory sc = new SeatCategory(rs.getInt("id"), rs.getString("name"), rs.getInt("numberOfSeat"),
                        rs.getString("image"), rs.getString("info"), rs.getInt("Plane_Categoryid"));
                return sc;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addSeatCategory(SeatCategory sc) {
        String sql = "INSERT INTO Seat_Category (name, numberOfSeat, image, info, Plane_Categoryid) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sc.getName());
            ps.setInt(2, sc.getNumberOfSeat());
            ps.setString(3, sc.getImage());
            ps.setString(4, sc.getInfo());
            ps.setInt(5, sc.getPlane_Categoryid());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateSeatCategory(SeatCategory sc) {
        String sql = "UPDATE Seat_Category SET name = ?, numberOfSeat = ?, image = ?, info = ?, Plane_Categoryid = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, sc.getName());
            ps.setInt(2, sc.getNumberOfSeat());
            ps.setString(3, sc.getImage());
            ps.setString(4, sc.getInfo());
            ps.setInt(5, sc.getPlane_Categoryid());
            ps.setInt(6, sc.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteSeatCategory(int id) {
        String sql = "DELETE FROM Seat_Category WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteAllSeatCategoryByPlaneCategoryId(int id) {
        String sql = "DELETE FROM Seat_Category WHERE Plane_Categoryid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteAllSeatCategoryByAirline(int airlineId) {
        String sql = """
                     DELETE sc
                     FROM Seat_Category sc
                     JOIN Plane_Category pc ON sc.Plane_Categoryid = pc.id
                     WHERE pc.Airlineid = ?""";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, airlineId);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        SeatCategoryDAO scd = new SeatCategoryDAO();
    }
}
