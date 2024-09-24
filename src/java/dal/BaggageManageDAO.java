/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Baggages;

/**
 *
 * @author PMQUANG
 */
public class BaggageManageDAO extends DBConnect {

    public List<Baggages> getAllBaggages() {
        List<Baggages> list = new ArrayList<>();
        String sql = "select * from Baggages";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                float weight = resultSet.getFloat("weight");
                int price = resultSet.getInt("price");
                int airlineId = resultSet.getInt("airlineId");
                list.add(new Baggages(id, weight, price, airlineId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public List<Baggages> getAllBaggagesByAirline(int airlineId) {
        List<Baggages> list = new ArrayList<>();
        String sql = "select * from Baggages\n"
                + "where airlineid= ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, airlineId);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                float weight = resultSet.getFloat("weight");
                int price = resultSet.getInt("price");
                int airlineIdFound = resultSet.getInt("airlineId");
                list.add(new Baggages(id, weight, price, airlineIdFound));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public int createBaggages(Baggages baggage) {
        String sql = "INSERT INTO `flyezy`.`Baggages` (`weight`, `price`, `Airlineid`)\n"
                + "VALUES (?, ?, ?)";
        int generatedId = -1;  // Giá trị mặc định cho trường hợp không thể lấy được ID
        try (PreparedStatement pre = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pre.setFloat(1, baggage.getWeight());  // airline name
            pre.setInt(2, baggage.getPrice());  // airline image
            pre.setInt(3, baggage.getAirlineId());
            pre.executeUpdate();

            // Lấy baggageId vừa được tạo
            ResultSet generatedKeys = pre.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1);  // Trả về airlineId
            } else {
                System.err.println("Creating airline failed, no ID obtained.");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return generatedId;  // Trả về ID hoặc giá trị mặc định -1 nếu có lỗi
    }

    public void deleteBaggage(int id) {
        String sql = "DELETE FROM `flyezy`.`Baggages`\n"
                + "WHERE id = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteAllBaggageByAirline(int airlineId) {
        String sql = "DELETE FROM `flyezy`.`Baggages`\n"
                + "WHERE airlineid = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, airlineId);
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateBaggage(Baggages baggage) {
        String sql = "UPDATE `flyezy`.`Baggages`\n"
                + "SET\n"
                + "`weight` =?,\n"
                + "`price` = ?\n"
                + "WHERE `id` = ?";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);

            pre.setFloat(1, baggage.getWeight());  // airline name
            pre.setInt(2, baggage.getPrice());  // airline image
            pre.setInt(3, baggage.getId());  // airline image
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        BaggageManageDAO dao = new BaggageManageDAO();

////        dao.deleteAllBaggageByAirline(1);
//        float weight = 3;
//        int price = 4;
//        int airlineId = 5;
//        dao.createBaggages(new Baggages(weight, airlineId, airlineId));
////        System.out.println("n= " + n);
//        for (Baggages baggage : dao.getAllBaggages()) {
//            System.out.println(baggage);
//        }
        for (Baggages baggages : dao.getAllBaggagesByAirline(2)) {
            System.out.println(baggages);
        }
    }
}
