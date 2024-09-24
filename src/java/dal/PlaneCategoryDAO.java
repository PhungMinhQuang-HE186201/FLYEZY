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
import model.PlaneCategory;

/**
 *
 * @author Admin
 */
public class PlaneCategoryDAO extends DBConnect {

    // DuongNT: to get all of plane categories of corresponding airline - OK
    public List<PlaneCategory> getAllPlaneCategoryByAirlineId(int id) {
        List<PlaneCategory> ls = new ArrayList<>();
        String sql = "SELECT * FROM Plane_Category WHERE Airlineid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PlaneCategory pc = new PlaneCategory(rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getString("info"), id);
                ls.add(pc);
            }
            return ls;
        } catch (Exception e) {
        }
        return null;
    }

    // DuongNT: to get a plane categories of corresponding airline with its id- OK
    public PlaneCategory getPlaneCategoryById(int planeCategoryId) {
        String sql = "SELECT * FROM Plane_Category WHERE id =?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, planeCategoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PlaneCategory pc = new PlaneCategory(rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getString("info"), rs.getInt("Airlineid"));
                return pc;
            }
        } catch (Exception e) {
        }
        return null;
    }

    // DuongNT: add a plane category for an airline - OK
    public boolean addPlaneCategory(PlaneCategory pc) {
        String sql = "INSERT INTO Plane_Category (name, image, info, Airlineid) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, pc.getName());
            ps.setString(2, pc.getImage());
            ps.setString(3, pc.getInfo());
            ps.setInt(4, pc.getAirlineid());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // DuongNT: delete a plane category by id - OK
    public boolean deletePlaneCategoryById(int id) {
        String sql = "DELETE FROM Plane_Category WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteAllPlaneCategoryByAirline(int airlineId) {
        String sql = "DELETE FROM Plane_Category WHERE airlineid = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, airlineId);  // Thay thế ? bằng airlineId
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // DuongNT: update a plane category by id - OK
    public boolean updatePlaneCategoryById(PlaneCategory pc) {
        String sql = "UPDATE Plane_Category SET name = ?, image = ?, info = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, pc.getName());
            ps.setString(2, pc.getImage());
            ps.setString(3, pc.getInfo());
            ps.setInt(4, pc.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // DuongNT: search plane category by name
    public List<PlaneCategory> searchPlaneCategory(String name, int airlineId) {
        List<PlaneCategory> ls = new ArrayList<>();
        String sql = "SELECT * FROM Plane_Category WHERE Airlineid = ? AND name LIKE ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, airlineId);
            ps.setString(2, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PlaneCategory pc = new PlaneCategory(rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getString("info"), rs.getInt("Airlineid"));
                ls.add(pc);
            }
            return ls;
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        PlaneCategoryDAO pd = new PlaneCategoryDAO();
        System.out.println(pd.searchPlaneCategory("A320",3));

    }

}
