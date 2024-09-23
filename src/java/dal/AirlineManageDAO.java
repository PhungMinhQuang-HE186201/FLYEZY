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
import model.Airline;
import model.Baggages;

/**
 *
 * @author PMQUANG
 */
public class AirlineManageDAO extends DBConnect {

    public List<Airline> getAllAirline() {
        List<Airline> list = new ArrayList<>();
        String sql = "select * from Airline";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String image = resultSet.getString("image");
                String info = resultSet.getString("info");
                list.add(new Airline(id, name, image,info));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }
    public String getNameById(int id){
        String sql = "select * from Airline where id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getString("name");
            }
        } catch (Exception e) {
        }
        return null;
    }
    public Airline getAirlineById(int id) {
        List<Airline> list = new ArrayList<>();
        String sql = "select * from Airline where id = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String image = resultSet.getString("image");
                String info = resultSet.getString("info");
                list.add(new Airline(id, name, image,info));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list.get(0);
    }

    public List<Airline> getAirlineByName(String name) {
        List<Airline> list = new ArrayList<>();
        String sql = "SELECT * FROM Airline WHERE name LIKE ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            // Sử dụng ? để chèn tham số an toàn
            prepare.setString(1, "%" + name + "%");
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String airlineName = resultSet.getString("name");
                String image = resultSet.getString("image");
                String info = resultSet.getString("info");
                list.add(new Airline(id, airlineName, image,info));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        // Kiểm tra danh sách không rỗng trước khi truy cập phần tử
        if (!list.isEmpty()) {
            return list;
        } else {
            // Xử lý trường hợp không tìm thấy
            return null; // Hoặc ném exception tùy thuộc vào yêu cầu
        }
    }

    public List<Baggages> getAirlineBaggages(int airlineId) {
        List<Baggages> list = new ArrayList<>();
        String sql = "select id,weight,price from Baggages\n"
                + "where airlineid = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, airlineId);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                float weight = resultSet.getFloat("weight");
                int price = resultSet.getInt("price");
                list.add(new Baggages(id, weight, price));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public int getMaxAirlineId() {

        String sql = "select max(id) as maxId from Airline";
        int id = 0;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                id = resultSet.getInt("maxId");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return id;
    }

    public int createAirline(Airline airline) {
        String sql = "INSERT INTO Airline (name, image,info) VALUES (?, ?, ?)";
        int generatedId = -1;  // Giá trị mặc định cho trường hợp không thể lấy được ID
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, airline.getName());
            preparedStatement.setString(2, airline.getImage());
            preparedStatement.setString(3, airline.getInfo());
            preparedStatement.executeUpdate();

            // Lấy airlineId vừa được tạo
            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1);  // Trả về airlineId
            } else {
                System.err.println("Creating airline failed, no ID obtained.");
            }
        } catch (SQLException e) {
            // Xử lý lỗi SQL tại đây
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return generatedId;  // Trả về ID hoặc giá trị mặc định -1 nếu có lỗi
    }

    public void deleteAirline(int id) {
        String sql = "DELETE FROM `flyezy`.`Airline`\n"
                + "WHERE id = " + id;
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateAirline(Airline airline) {
        String sql = "UPDATE `flyezy`.`Airline`\n"
                + "SET\n"
                + "`name` =?,\n"
                + "`image` = ?,\n"
                + "`info` = ?\n"
                + "WHERE `id` = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, airline.getName());
            pre.setString(2, airline.getImage());
             pre.setString(3, airline.getInfo());
            pre.setInt(4, airline.getId());
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        AirlineManageDAO dao = new AirlineManageDAO();

//        // Create Airline and Baggage objects
//        Airline airline = new Airline(5, "ab", "ab.jpg","abc");
//        int n = dao.createAirline(airline);
//        System.out.println("n= " + n);
//        dao.deleteAirline(228);
        dao.updateAirline(new Airline(5, "abccc", "ab.jpg","abcccccc"));
        for (Airline airline1 : dao.getAllAirline()) {
            System.out.println(airline1);
        }
//        System.out.println(dao.getAirlineById(3));
//        System.out.println(dao.getAirlineBaggages(3));

        //System.out.println(dao.getMaxAirlineId() + 1);
    }
}
