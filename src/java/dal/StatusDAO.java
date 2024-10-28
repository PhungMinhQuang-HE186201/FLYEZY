/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import model.Status;

/**
 *
 * @author PMQUANG
 */
public class StatusDAO extends DBConnect {

    public List<Status> getAllStatus() {
        List<Status> list = new ArrayList<>();
        String sql = "select * from Status";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                list.add(new Status(id, name));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public String getStatusNameById(int id) {
        String sql = "SELECT name FROM Status WHERE id = ?";
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

    public List<Status> getStatusOfFlight() {
        List<Status> list = new ArrayList<>();
        String sql = "select * from Status where id = 1 or id = 2 ";

        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            prepare = conn.prepareStatement(sql);
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                list.add(new Status(id, name));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Status> getStatusOfOrder() {
        List<Status> list = new ArrayList<>();
        String sql = "select * from Status where id = 8 or id = 10 or id = 12 ";

        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            prepare = conn.prepareStatement(sql);
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                list.add(new Status(id, name));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public List<Status> getStatusOfFeedback() {
        List<Status> list = new ArrayList<>();
        String sql = "select * from Status where id = 14 or id = 15 or id = 13 ";

        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            prepare = conn.prepareStatement(sql);
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                list.add(new Status(id, name));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    public List<Status> getStatusOfTicket() {
        List<Status> list = new ArrayList<>();
        String sql = "SELECT * \n"
                + "FROM Status\n"
                + "ORDER BY id DESC\n"
                + "LIMIT 6;";

        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            prepare = conn.prepareStatement(sql);
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                list.add(new Status(id, name));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void changeStatusTicket(int id, int status) {
        String sql = "UPDATE Ticket\n"
                + "   SET Statusid=?"
                + " WHERE id=?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, id);

            pre.executeUpdate();

        } catch (Exception ex) {
            System.out.println(ex);
        }
    }
    public void changeStatusFeedback(int id, int status) {
        String sql = "UPDATE Feedbacks\n"
                + "   SET Statusid=?"
                + " WHERE id=?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, id);

            pre.executeUpdate();

        } catch (Exception ex) {
            System.out.println(ex);
        }
    }
    public List<Status> getStatusOfFlightDetaisl() {
        List<Status> ls = new ArrayList<>();
        try {
            String sql = "SELECT * FROM flyezy.status WHERE id = 3 OR id = 4 OR id = 5";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                ls.add(new Status(id, name));
            }
        } catch (SQLException e) {

        }
        return ls;
    }

    public static void main(String[] args) {
//        System.out.println(dao.getAllStatus());
        StatusDAO sd = new StatusDAO();
        List<Status> statuses = (List<Status>) sd.getStatusOfFlightDetaisl();
        for (Status status : statuses) {
            System.out.println(status.getId());
        }
    }
}
