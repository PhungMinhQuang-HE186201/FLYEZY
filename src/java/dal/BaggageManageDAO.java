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
                + "where airlineid= " + airlineId;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                float weight = resultSet.getFloat("weight");
                int price = resultSet.getInt("price");
                airlineId = resultSet.getInt("airlineId");
                list.add(new Baggages(id, weight, price, airlineId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public void createBaggages(Baggages baggage) {
        String sql = "INSERT INTO `flyezy`.`Baggages` (`id`, `weight`, `price`, `Airlineid`)\n"
                + "VALUES (?, ?, ?, ?)";
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, baggage.getId());  // airline id
            pre.setFloat(2, baggage.getWeight());  // airline name
            pre.setInt(3, baggage.getPrice());  // airline image
            pre.setInt(4, baggage.getAirlineId());
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteBaggage(int id) {
        String sql = "DELETE FROM `flyezy`.`Baggages`\n"
                + "WHERE id = " + id;
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteAllBaggageByAirline(int airlineId) {
        String sql = "DELETE FROM `flyezy`.`Baggages`\n"
                + "WHERE airlineid = " + airlineId;
        try {

            PreparedStatement pre = conn.prepareStatement(sql);
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

//        dao.deleteAllBaggageByAirline(1);
        for (Baggages baggage : dao.getAllBaggagesByAirline(3)) {
            System.out.println(baggage);
        }
    }
}
