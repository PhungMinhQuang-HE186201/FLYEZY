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

    public void activateAllSeatCategoryByAirline(int airlineId) {
        String sql = "UPDATE Seat_Category sc "
                + "SET sc.Status_id = ? "
                + "WHERE sc.Plane_Categoryid IN ( "
                + "   SELECT pc.id FROM Plane_Category pc "
                + "   WHERE pc.airlineId = ? "
                + ")";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 1);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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

    public void deactivateAllSeatCategoryByAirline(int airlineId) {
        String sql = "UPDATE Seat_Category sc "
                + "SET sc.Status_id = ? "
                + "WHERE sc.Plane_Categoryid IN ( "
                + "   SELECT pc.id FROM Plane_Category pc "
                + "   WHERE pc.airlineId = ? "
                + ")";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, 2);
            ps.setInt(2, airlineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getSeatCategoryNameById(int id) {
        String sql = "SELECT name FROM seat_category WHERE id = ?";
        String name = null;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);  // Đặt giá trị id vào câu lệnh SQL
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                name = resultSet.getString("name");  // Lấy tên từ kết quả truy vấn
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return name;  // Trả về tên, nếu không có giá trị sẽ trả về null
    }

    public List<SeatCategory> getNameAndNumberOfSeat(int id) {
        String sql = "Select  s.name,numberOfSeat ,count(Seat_Categoryid) as countSeat \n"
                + "                             From Ticket t join `flyezy`.`Order` o On t.Order_id=o.id\n"
                + "                             Join Seat_category s On t.Seat_Categoryid=s.id \n"
                + "                             where o.Flight_Detail_id = ?\n"
                + "                             group by s.name,numberOfSeat";
        List<SeatCategory> ls = new ArrayList<>();
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);  // Đặt giá trị id vào câu lệnh SQL
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                int numberOfSeat = resultSet.getInt("numberOfSeat");
                int countSeat = resultSet.getInt("countSeat");
                ls.add(new SeatCategory(name, numberOfSeat, countSeat));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return ls;
    }

    public static void main(String[] args) {
        SeatCategoryDAO scd = new SeatCategoryDAO();
        System.out.println(scd.getSeatCategoryById(7).getStatusId());
    }
}
