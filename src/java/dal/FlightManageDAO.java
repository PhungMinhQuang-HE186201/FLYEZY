/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Flights;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author user
 */
public class FlightManageDAO extends DBConnect {

    public List<Flights> getAllFlights() {
        List<Flights> list = new ArrayList<>();
        String sql = "select * from Flight";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int minutes = resultSet.getInt("minutes");
                int departureAirportId = resultSet.getInt("departureAirportId");
                int destinationAirportId = resultSet.getInt("destinationAirportId");
                int statusId = resultSet.getInt("Status_id");

                list.add(new Flights(id, minutes, departureAirportId, destinationAirportId, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return list;
    }

    public int createFlight(Flights flight) {
        int n = 0;
        String sql = """
                 INSERT INTO `flyezy`.`flight`
                 (
                 `minutes`,
                 `departureAirportid`,
                 `destinationAirportid`,
                 `Status_id`)
                 VALUES (?,?,?,1)""";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            // Set các giá trị vào PreparedStatement
//            ps.setInt(1, flight.getId());
            ps.setInt(1, flight.getMinutes());
            ps.setInt(2, flight.getDepartureAirportId());
            ps.setInt(3, flight.getDestinationAirportId());

            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public void updateFlight(Flights flight) {
        String sql = "UPDATE `flyezy`.`flight`\n"
                + "SET\n"
                + "`minutes` = ?,\n"
                + "`departureAirportid` = ?,\n"
                + "`destinationAirportid` = ?\n"
                + "WHERE `id` = ?;";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, flight.getMinutes());
            pre.setInt(2, flight.getDepartureAirportId());
            pre.setInt(3, flight.getDestinationAirportId());
            pre.setInt(4, flight.getId());
            pre.executeUpdate();
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public void changeStatus(int id, int newStatus) {
        String sqlupdate = "UPDATE flight\n"
                + "                SET\n"
                + "                Status_id = ?\n"
                + "                WHERE id =?";
        try {
            PreparedStatement pre = conn.prepareStatement(sqlupdate);
            pre.setInt(2, id);
            pre.setInt(1, newStatus);
            pre.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        FlightManageDAO dao = new FlightManageDAO();
        int n = dao.createFlight(new Flights(30, 1, 2));
    }

}
