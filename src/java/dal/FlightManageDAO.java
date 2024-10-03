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
    
    public Flights getFlightById(int id) {
    String sql = "SELECT * FROM Flight WHERE id = ?";
    try {
        PreparedStatement prepare = conn.prepareStatement(sql);
        prepare.setInt(1, id);
        ResultSet resultSet = prepare.executeQuery();

        if (resultSet.next()) {
            int flightId = resultSet.getInt("id");
            int minutes = resultSet.getInt("minutes");
            int departureAirportId = resultSet.getInt("departureAirportId");
            int destinationAirportId = resultSet.getInt("destinationAirportId");
            int statusId = resultSet.getInt("Status_id");

            return new Flights(flightId, minutes, departureAirportId, destinationAirportId, statusId);
        }
    } catch (Exception e) {
    }

    return null; 
}


    public int createFlight(Flights flight) {
        int n = 0;
        String sql = "INSERT INTO `flyezy`.`Flight`\n"
                + "(\n"
                + "`minutes`,\n"
                + "`departureAirportid`,\n"
                + "`destinationAirportid`,\n"
                + "`Status_id`,\n"
                + "`Airline_id`)\n"
                + "VALUES\n"
                + "(?,?,?,1,?);";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            // Set các giá trị vào PreparedStatement
//            ps.setInt(1, flight.getId());
            ps.setInt(1, flight.getMinutes());
            ps.setInt(2, flight.getDepartureAirportId());
            ps.setInt(3, flight.getDestinationAirportId());
            ps.setInt(4, flight.getAirlineId());
            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public void updateFlight(Flights flight) {
        String sql = "UPDATE `flyezy`.`Flight`\n"
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
        String sqlupdate = "UPDATE Flight\n"
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
       Flights f = new Flights(23, 2, 1, 3);
       int n = dao.createFlight(f);
       
    }

}
