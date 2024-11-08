/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Ticket;

/**
 *
 * @author Fantasy
 */
public class TicketDAO extends DBConnect {

    public List<Ticket> getAllTicketsByOrderId(int orderId) {
        List<Ticket> ls = new ArrayList<>();
        String sql = "select * from Ticket where Order_id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket(rs.getInt("id"),
                        rs.getInt("Flight_Detail_id"),
                        rs.getInt("Seat_Categoryid"),
                        rs.getInt("Passenger_Typesid"),
                        rs.getString("code"),
                        rs.getString("pName"),
                        rs.getInt("pSex"),
                        rs.getString("pPhoneNumber"),
                        rs.getDate("pDob"),
                        rs.getInt("Baggagesid"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Order_id"),
                        rs.getInt("Statusid"),
                        rs.getInt("Flight_Type_id"),
                        rs.getTimestamp("cancelled_at"));
                ls.add(t);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Ticket> getAllTicketSuccessfulPaymentByOrderId(int orderId) {
        List<Ticket> ls = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.ticket where Order_id = ? and Statusid = 10;";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, orderId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket(rs.getInt("id"),
                        rs.getInt("Flight_Detail_id"),
                        rs.getInt("Seat_Categoryid"),
                        rs.getInt("Passenger_Typesid"),
                        rs.getString("code"),
                        rs.getString("pName"),
                        rs.getInt("pSex"),
                        rs.getString("pPhoneNumber"),
                        rs.getDate("pDob"),
                        rs.getInt("Baggagesid"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Order_id"),
                        rs.getInt("Statusid"),
                        rs.getInt("Flight_Type_id"),
                        rs.getTimestamp("cancelled_at"));
                ls.add(t);
            }
            return ls;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public String getContactPhone(int id) {
        int n = 0;
        String sql = "Select contactPhone \n"
                + "from Feedbacks f Join flyezy.`Order` o On f.Order_id = o.id\n"
                + "Where o.id = ?";
        List<String> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void confirmSuccessAllTicketsByOrderId(int orderId) {

        String sql = "UPDATE Ticket SET Statusid = 10 where Order_id=? and Statusid = 12";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public int getAirlineByTicket(int id) {
        String sql = "select f.Airline_id from Ticket t \n"
                + "join Flight_Detail fd on fd.id = t.Flight_Detail_id\n"
                + "join Flight f on f.id = fd.Flightid\n"
                + "where t.id = ?";
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

    public int countNumberTicketNotCancel(int orderId) {
        String sql = "SELECT COUNT(*) AS ticket_count FROM Ticket WHERE Order_id = ? AND (Statusid = 10 or Statusid=12)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("ticket_count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void cancelAllTicketsByOrderId(int orderId) {
        String sql = "UPDATE Ticket SET Statusid = 7, cancelled_at = ? WHERE Order_id = ? and (Statusid = 10 or Statusid = 12)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void cancelTicketById(int id) {
        String sql = "UPDATE Ticket SET Statusid = 7, cancelled_at = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void completeTicketRefundById(int refundID) {
        String sql = "UPDATE Ticket SET Statusid = 8 WHERE id = (SELECT ticketID FROM Refund WHERE id = ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, refundID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void rejectTicketRefundById(int refundID) {
        String sql = "UPDATE Ticket SET Statusid = 14 WHERE id = (SELECT ticketID FROM Refund WHERE id = ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, refundID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void refundWaitingTicketById(int id) {
        String sql = "UPDATE Ticket SET Statusid = 3 WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Ticket> getAllTickets() {
        List<Ticket> ls = new ArrayList<>();
        String sql = "select * from Ticket";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket(rs.getInt("id"),
                        rs.getInt("Seat_Categoryid"),
                        rs.getInt("Passenger_Typesid"),
                        rs.getString("code"),
                        rs.getString("pName"),
                        rs.getInt("pSex"),
                        rs.getString("pPhoneNumber"),
                        rs.getDate("pDob"),
                        rs.getInt("Baggagesid"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Order_id"),
                        rs.getInt("Statusid"),
                        rs.getInt("Flight_Type_id"));
                ls.add(t);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Ticket> getAllTicketsById(int flightDetailID) {
        List<Ticket> ls = new ArrayList<>();
        String sql = "select * from Ticket t \n"
                + "where Flight_Detail_id= " + flightDetailID + " and Statusid!=9";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket(rs.getInt("id"),
                        rs.getInt("Flight_Detail_id"),
                        rs.getInt("Seat_Categoryid"),
                        rs.getInt("Passenger_Typesid"),
                        rs.getString("code"),
                        rs.getString("pName"),
                        rs.getInt("pSex"),
                        rs.getString("pPhoneNumber"),
                        rs.getDate("pDob"),
                        rs.getInt("Baggagesid"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Order_id"),
                        rs.getInt("Statusid"),
                        rs.getInt("Flight_Type_id"),
                        rs.getTimestamp("cancelled_at"));

                ls.add(t);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public List<String> getAllTicketCodesById(int flightDetailID, int seatCategoryId) {
        List<String> ls = new ArrayList<>();
        String sql = "SELECT t.code FROM Ticket t "
                + "JOIN `flyezy`.`Order` o ON t.Order_id = o.id "
                + "WHERE Flight_Detail_id = ? AND (Statusid = 12 OR Statusid = 10) AND Seat_Categoryid = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, flightDetailID);
            ps.setInt(2, seatCategoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    if (rs.getString("code") != null) {
                        ls.add(rs.getString("code"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }

    public List<String> getAllTicketCodesAndSeatByFlightDetail(int flightDetailID, int seatCategoryId) {
        List<String> ls = new ArrayList<>();
        String sql = "SELECT t.code,t.Seat_Categoryid FROM Ticket t "
                + "WHERE Flight_Detail_id = ? AND (Statusid = 12 OR Statusid = 10) AND Seat_Categoryid = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, flightDetailID);
            ps.setInt(2, seatCategoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    if (rs.getString("code") != null) {
                        ls.add(rs.getString("code"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }

    public Ticket getTicketByCode(String code, int flightDetailID, int seatCategoryId) {
        String sql = "SELECT * FROM Ticket t "
                + "WHERE code = ? AND Flight_Detail_id = ? "
                + "AND (Statusid = 10 OR Statusid = 12) AND Seat_Categoryid = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            ps.setInt(2, flightDetailID);
            ps.setInt(3, seatCategoryId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Ticket t = new Ticket(rs.getInt("id"),
                        rs.getInt("Seat_Categoryid"),
                        rs.getInt("Passenger_Typesid"),
                        rs.getString("code"),
                        rs.getString("pName"),
                        rs.getInt("pSex"),
                        rs.getString("pPhoneNumber"),
                        rs.getDate("pDob"),
                        rs.getInt("Baggagesid"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Order_id"),
                        rs.getInt("Statusid"),
                        rs.getInt("Flight_Type_id"));
                return t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Ticket getTicketById(int id) {
        String sql = "Select * from Ticket where id =" + id + " and Statusid!=9";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Ticket t = new Ticket(rs.getInt("id"),
                        rs.getInt("Seat_Categoryid"),
                        rs.getInt("Passenger_Typesid"),
                        rs.getString("code"),
                        rs.getString("pName"),
                        rs.getInt("pSex"),
                        rs.getString("pPhoneNumber"),
                        rs.getDate("pDob"),
                        rs.getInt("Baggagesid"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Order_id"),
                        rs.getInt("Statusid"),
                        rs.getInt("Flight_Type_id"));
                return t;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getTicketPriceByOrderAndPassenger(int orderId, int passengerTypeId) {
        String sql = "select sum(t.totalPrice) totalPriceType from Ticket t\n"
                + "join flyezy.Order o on o.id = t.Order_id\n"
                + "where o.id = ? and t.Passenger_Typesid = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, orderId);
            st.setInt(2, passengerTypeId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int price = rs.getInt("totalPriceType");
                return price;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public List<Ticket> searchTickets(String passengerType, String statusTicket, String name, String phoneNumber, int Flight_Detailid, String Flight_Type_id, String orderCode) {
        List<Ticket> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("select t.* from Ticket t \n"
                + "join flyezy.Order o on o.id = t.Order_id\n"
                + "where Flight_Detail_id=" + Flight_Detailid + " and Statusid!=9");
        if ((Flight_Type_id + "") != null && !(Flight_Type_id + "").isEmpty()) {
            sql.append(" AND Flight_Type_id = ?");
        }
        if (passengerType != null && !passengerType.isEmpty()) {
            sql.append(" AND Passenger_Typesid = ?");
        }
        if (statusTicket != null && !statusTicket.isEmpty()) {
            sql.append(" AND Statusid = ?");
        }
        if (name != null && !name.isEmpty()) {
            sql.append(" AND pName LIKE ?");
        }
        if (phoneNumber != null && !phoneNumber.isEmpty()) {
            sql.append(" AND pPhoneNumber LIKE ?");
        }
        if (orderCode != null && !orderCode.isEmpty()) {
            sql.append(" AND o.code LIKE ?");
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int i = 1;
            if ((Flight_Type_id + "") != null && !(Flight_Type_id + "").isEmpty()) {
                int flightType = Integer.parseInt(Flight_Type_id);
                ps.setInt(i++, flightType);
            }
            if (passengerType != null && !passengerType.isEmpty()) {
                ps.setString(i++, passengerType);
            }
            if (statusTicket != null && !statusTicket.isEmpty()) {
                ps.setString(i++, statusTicket);
            }
            if (name != null && !name.isEmpty()) {
                ps.setString(i++, "%" + name + "%");
            }
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                String vp = phoneNumber;
                if (vp.startsWith("0")) {
                    vp = vp.substring(1);
                }
                ps.setString(i++, "%" + vp + "%");
            }
            if (orderCode != null && !orderCode.isEmpty()) {
                ps.setString(i++, "%" + orderCode + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket(rs.getInt("id"),
                        rs.getInt("Flight_Detail_id"),
                        rs.getInt("Seat_Categoryid"),
                        rs.getInt("Passenger_Typesid"),
                        rs.getString("code"),
                        rs.getString("pName"),
                        rs.getInt("pSex"),
                        rs.getString("pPhoneNumber"),
                        rs.getDate("pDob"),
                        rs.getInt("Baggagesid"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Order_id"),
                        rs.getInt("Statusid"),
                        rs.getInt("Flight_Type_id"),
                        rs.getTimestamp("cancelled_at"));
                ls.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }

    public int createTicket(String code, int flightDetailId, int seatCategoryId, int passengerTypeId, String pName, int pSex, String pPhoneNumber, Date pDob, Integer baggageId, int totalPrice, int orderId, int flightTypeId) {
        int n = 0;
        String sql = "INSERT INTO `flyezy`.`Ticket` \n"
                + "(`Flight_Detail_id`,`Seat_Categoryid`, `Passenger_Typesid`, `code`,`pName`,`pSex`,`pPhoneNumber`,`pDob`,`Baggagesid`,`totalPrice`,`Order_id`, `Statusid`,`Flight_Type_id`) \n"
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ps.setInt(2, seatCategoryId);
            ps.setInt(3, passengerTypeId);
            ps.setString(4, code);
            ps.setString(5, pName);
            ps.setInt(6, pSex);
            ps.setString(7, pPhoneNumber);
            ps.setDate(8, pDob);
            if (baggageId == null) {
                ps.setNull(9, java.sql.Types.INTEGER);
            } else {
                ps.setInt(9, baggageId);
            }
            ps.setInt(10, totalPrice);
            ps.setInt(11, orderId);
            ps.setInt(12, 12);
            ps.setInt(13, flightTypeId);

            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int getPriceById(int ticketId) {
        String sql = "select t.totalprice from Ticket t where Id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ticketId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalprice");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }

    public int createMaintenanceSeat(String code, int flightDetailId, Integer seatCategoryId) {
        int n = 0;
        String sql = "INSERT INTO `flyezy`.`Ticket` \n"
                + "(`Flight_Detail_id`, `Seat_Categoryid`, `Passenger_Typesid`, `code`, `pName`, `pSex`, `pPhoneNumber`, `pDob`, `Baggagesid`, `totalPrice`, `Order_id`, `Statusid`, `Flight_Type_id`) \n"
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, flightDetailId);

            if (seatCategoryId == null) {
                ps.setNull(2, java.sql.Types.INTEGER);
            } else {
                ps.setInt(2, seatCategoryId);
            }

            ps.setNull(3, java.sql.Types.INTEGER);
            ps.setString(4, code);
            ps.setNull(5, java.sql.Types.VARCHAR);
            ps.setNull(6, java.sql.Types.INTEGER);
            ps.setNull(7, java.sql.Types.VARCHAR);
            ps.setNull(8, java.sql.Types.DATE);
            ps.setNull(9, java.sql.Types.INTEGER);
            ps.setNull(10, java.sql.Types.DOUBLE);
            ps.setInt(11, 2);
            ps.setInt(12, 12);
            ps.setNull(13, java.sql.Types.INTEGER);

            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return n;
    }

    public static void main(String[] args) {
        TicketDAO td = new TicketDAO();
        AirlineManageDAO ad = new AirlineManageDAO();
        //tcd.confirmSuccessAllTicketsByOrderId(1);
        //System.out.println(td.createTicket("C9", 1, 7, 2, "HIHI", 0, null, Date.valueOf("2000-10-10"), null, 0, 1, 1));
        //System.out.println(td.getAllTicketCodesById(4, 1));
//        System.out.println(tcd.getTicketByCode("B1", 4, 8));
//        System.out.println(td.searchTickets("", "", "", "", 1, "", "FJA84IUTJ"));
        td.createMaintenanceSeat("A9", 15, 1);
    }

}
