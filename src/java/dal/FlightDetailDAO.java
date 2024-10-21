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
        String sql = "select * from flyezy.Flight_Detail where Flight_Detail.date =?";
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
    public List<FlightDetails> getFlightDetailWithPaging(int flightId,int index) {
        List<FlightDetails> list = new ArrayList<>();
        String sql = "select * from flyezy.Flight_Detail where Flightid  =?"
                + " LIMIT 5 OFFSET ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, flightId);
            prepare.setInt(2, (index-1)*5);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                Date date = resultSet.getDate("date");
                Time time = resultSet.getTime("time");
                int price = resultSet.getInt("price");
                int flightId1 = resultSet.getInt("Flightid");
                int planeCategoryId = resultSet.getInt("Plane_Categoryid");
                int statusId = resultSet.getInt("Status_id");
                list.add(new FlightDetails(id, date, time, price, flightId, planeCategoryId, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return list;
    }
    public int getNumberOfFlightDetail(int flightId) {
        String sql = "select Count(*) from flyezy.Flight_Detail where Flightid  =?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, flightId);
            ResultSet resultSet = prepare.executeQuery();
            if(resultSet.next()){
                return resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return 0;
    }
    public FlightDetails getFlightDetailById(int idd) {
        String sql = "select * from flyezy.Flight_Detail where id =?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, idd);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                Date date = resultSet.getDate("date");
                Time time = resultSet.getTime("time");
                int price = resultSet.getInt("price");
                int flightId = resultSet.getInt("Flightid");
                int planeCategoryId = resultSet.getInt("Plane_Categoryid");
                int statusId = resultSet.getInt("Status_id");
                return (new FlightDetails(id, date, time, price, flightId, planeCategoryId, statusId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return null;
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

    public Flights getFlightByFlightDetailId(int id) {
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

    public PlaneCategory getPlaneCategoryByFlightDetailId(int id) {
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

    public int getAirlineIdByFlightDetailId(int id) {
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

    public List<FlightDetails> getAllDetailByFlightId(int flightid,int index) {
        List<FlightDetails> ls = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Flight_Detail WHERE flightid = ? "
                + " LIMIT 5 OFFSET ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightid);
            ps.setInt(2,(index-1)*5);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FlightDetails flightDetail = new FlightDetails();
                flightDetail.setId(rs.getInt("id"));
                flightDetail.setDate(rs.getDate("date"));
                flightDetail.setTime(rs.getTime("time"));  // Chuyển đổi từ SQL Time sang LocalTime
                flightDetail.setPrice(rs.getInt("price"));
                flightDetail.setFlightId(rs.getInt("Flightid"));
                flightDetail.setPlaneCategoryId(rs.getInt("Plane_Categoryid"));
                flightDetail.setStatusId(rs.getInt("Status_id"));
                ls.add(flightDetail);
            }
        } catch (Exception e) {
        }
        return ls;
    }

    public List<FlightDetails> getAll() {
        List<FlightDetails> ls = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Flight_Detail";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FlightDetails flightDetail = new FlightDetails();
                flightDetail.setId(rs.getInt("id"));
                flightDetail.setDate(rs.getDate("date"));
                flightDetail.setTime(rs.getTime("time"));  // Chuyển đổi từ SQL Time sang LocalTime
                flightDetail.setPrice(rs.getInt("price"));
                flightDetail.setFlightId(rs.getInt("Flightid"));
                flightDetail.setPlaneCategoryId(rs.getInt("Plane_Categoryid"));
                flightDetail.setStatusId(rs.getInt("Status_id"));
                ls.add(flightDetail);
            }

        } catch (SQLException e) {
            e.getMessage();
        }
        return ls;
    }

    public FlightDetails getFlightDetailsByID(int id) {
        List<FlightDetails> ls = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Flight_Detail where id = " + id;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FlightDetails flightDetail = new FlightDetails();
                flightDetail.setId(rs.getInt("id"));
                flightDetail.setDate(rs.getDate("date"));
                flightDetail.setTime(rs.getTime("time"));  // Chuyển đổi từ SQL Time sang LocalTime
                flightDetail.setPrice(rs.getInt("price"));
                flightDetail.setFlightId(rs.getInt("Flightid"));
                flightDetail.setPlaneCategoryId(rs.getInt("Plane_Categoryid"));
                flightDetail.setStatusId(rs.getInt("Status_id"));
                return flightDetail;
            }

        } catch (SQLException e) {
            e.getMessage();
        }
        return null;
    }

    public void addnew(FlightDetails flightDetail) {
        String sql = "INSERT INTO Flight_Detail (date, time, price, flightid, Plane_Categoryid, Status_id) VALUES (?, ?, ?, ?, ?, 3)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setDate(1, flightDetail.getDate());
            ps.setTime(2, flightDetail.getTime());
            ps.setInt(3, flightDetail.getPrice());
            ps.setInt(4, flightDetail.getFlightId());
            ps.setInt(5, flightDetail.getPlaneCategoryId());
            // Thực hiện thao tác chèn
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Chèn thành công.");
            } else {
                System.out.println("Chèn thất bại.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateFlightDetail(FlightDetails flightDetail, int id) {
        String sql = "UPDATE Flight_Detail SET date = ?, time = ?, price = ?, flightid = ?, plane_categoryid = ? WHERE id = ? ";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, flightDetail.getDate());
            ps.setTime(2, flightDetail.getTime());
            ps.setInt(3, flightDetail.getPrice());
            ps.setInt(4, flightDetail.getFlightId());
            ps.setInt(5, flightDetail.getPlaneCategoryId());
            ps.setInt(6, id);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.getMessage();
        }
        return false;
    }


    public void updateFlightStatus(int Id, int status) {
        String sql = "UPDATE Flight_Detail SET Status_id = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, Id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public List<FlightDetails> searchByStatus(int statusId, int flightId,int index) {
        List<FlightDetails> flightDetails = new ArrayList<>();
        String query = "SELECT * FROM flight_detail WHERE status_id = ? AND flightid = ?"
                + " LIMIT 5 OFFSET 0";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, statusId);
            ps.setInt(2, flightId);
            ps.setInt(3, (index-1)*5);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                FlightDetails flight = new FlightDetails();
                // Map result set data to FlightDetail object
                flight.setId(rs.getInt("id"));
                flight.setDate(rs.getDate("date"));
                flight.setTime(rs.getTime("time"));
                flight.setPrice(rs.getInt("price"));
                flight.setFlightId(rs.getInt("flightid"));
                flight.setPlaneCategoryId(rs.getInt("plane_categoryid"));
                flight.setStatusId(rs.getInt("status_id"));
                flightDetails.add(flight);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flightDetails;
    }

    public List<FlightDetails> searchByDate(Date date, int flightId,int index) {
        List<FlightDetails> flightDetails = new ArrayList<>();
        String query = "SELECT * FROM flight_detail WHERE date = ? AND flightid = ?"
                + " LIMIT 5 OFFSET 0";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setDate(1, date);
            ps.setInt(2, flightId);
            ps.setInt(3, (index-1)*5);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                FlightDetails flight = new FlightDetails();
                flight.setId(rs.getInt("id"));
                flight.setDate(rs.getDate("date"));
                flight.setTime(rs.getTime("time"));
                flight.setPrice(rs.getInt("price"));
                flight.setFlightId(rs.getInt("flightid"));
                flight.setPlaneCategoryId(rs.getInt("plane_categoryid"));
                flight.setStatusId(rs.getInt("status_id"));
                flightDetails.add(flight);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flightDetails;
    }

    public List<FlightDetails> searchByTimeRange(Time fromTime, Time toTime, int flightId,int index) {
        List<FlightDetails> flightDetails = new ArrayList<>();
        String query = "SELECT * FROM flight_detail WHERE time BETWEEN ? AND ? AND flightid = ?"
                + " LIMIT 5 OFFSET ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setTime(1, fromTime);
            ps.setTime(2, toTime);
            ps.setInt(3, flightId);
            ps.setInt(4,(index-1)*5);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                FlightDetails flight = new FlightDetails();
                flight.setId(rs.getInt("id"));
                flight.setDate(rs.getDate("date"));
                flight.setTime(rs.getTime("time"));
                flight.setPrice(rs.getInt("price"));
                flight.setFlightId(rs.getInt("flightid"));
                flight.setPlaneCategoryId(rs.getInt("plane_categoryid"));
                flight.setStatusId(rs.getInt("status_id"));
                flightDetails.add(flight);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flightDetails;
    }
    public int getPlaneCategoryIdFromFlightDetail(int id) {
        String sql = "Select Plane_Categoryid from Flight_Detail where id ="+id;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int Plane_Categoryid = rs.getInt("Plane_Categoryid");
                return Plane_Categoryid;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public static void main(String[] args) {
        

    }
}
