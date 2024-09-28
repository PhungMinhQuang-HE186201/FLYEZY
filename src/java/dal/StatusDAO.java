/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    public static void main(String[] args) {
        StatusDAO dao = new StatusDAO();
//        System.out.println(dao.getAllStatus());
        System.out.println(dao.getStatusNameById(0));
    } 
}
