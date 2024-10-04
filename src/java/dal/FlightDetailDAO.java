package dal;

import java.sql.Date;
import java.util.List;
import model.FlightDetails;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import model.Flights;
import model.PlaneCategory;

/**
 *
 * @author Admin
 */
public class FlightDetailDAO extends DBConnect {
        public List<FlightDetails> getByDate(Date date) {
        List<FlightDetails> list = new ArrayList<>();
        String sql = "select * from flyezy.flight_detail where flight_detail.date =?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setDate(1, date);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                date = resultSet.getDate("date");
                Time time = resultSet.getTime("time");
                int price = resultSet.getInt("price");
                int flightId = resultSet.getInt("Flightid");
                int planeCategoryId = resultSet.getInt("Plane_Categoryid");
                int statusId = resultSet.getInt("Status_id");
                list.add(new FlightDetails(id, date, time, price, flightId, planeCategoryId, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return list;
    }
    public List<FlightDetails> getFlightDetailsByAirportAndDDate(int depAirportId, int desAirportId, Date date) {
        List<FlightDetails> ls = new ArrayList<>();
        String sql = "SELECT fd.* FROM Flight_Detail fd "
                + "JOIN Flight f ON fd.flightId = f.id "
                + "WHERE fd.date = ? AND f.departureAirportId = ? AND f.destinationAirportId = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDate(1, date);
            ps.setInt(2, depAirportId);
            ps.setInt(3, desAirportId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ls.add(new FlightDetails(rs.getInt("id"), rs.getDate("date"),
                        rs.getTime("time"), rs.getInt("price"),
                        rs.getInt("Flightid"), rs.getInt("Plane_Categoryid"),
                        rs.getInt("Status_id")));
            }
            return ls;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public Flights getFlightByFlightDetailId(int id){
        String sql = "SELECT f.* FROM Flight f  "
                + "JOIN Flight_Detail fd ON f.id = fd.Flightid "
                + "WHERE fd.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Flights(rs.getInt("id"), rs.getInt("minutes"),
                        rs.getInt("departureAirportid"), 
                        rs.getInt("destinationAirportid"), 
                        rs.getInt("Status_id"), rs.getInt("Airline_id"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public PlaneCategory getPlaneCategoryByFlightDetailId(int id){
        String sql = "SELECT pc.* FROM Plane_Category pc  "
                + "JOIN Flight_Detail fd ON pc.id = fd.Plane_Categoryid "
                + "WHERE fd.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new PlaneCategory(rs.getInt("id"), rs.getString("name"), 
                        rs.getString("image"), rs.getString("info"), 
                        rs.getInt("Airlineid"), rs.getInt("Status_id"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public int getAirlineIdByFlightDetailId(int id){
        String sql = "SELECT f.* FROM Flight_Detail fd "
                + "JOIN Flight f ON fd.Flightid = f.id "
                + "WHERE fd.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Airline_id");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;
    }
    
    
    
    public static void main(String[] args) {
        FlightDetailDAO fdd = new FlightDetailDAO();
        System.out.println(fdd.getPlaneCategoryByFlightDetailId(1));
    }
}
