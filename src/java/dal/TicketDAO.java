/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import model.Ticket;

/**
 *
 * @author Fantasy
 */
public class TicketDAO extends DBConnect {

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
        String sql = "select t.id,t.Seat_Categoryid,t.Passenger_Typesid,t.code,t.pName,t.pSex,t.pPhoneNumber,t.pDob,t.Baggagesid,t.Order_id,t.Statusid,o.Flight_Detail_id,t.Flight_Type_id from Ticket t \n"
                + "join `flyezy`.`Order` o On t.Order_id=o.id\n"
                + "where Flight_Detail_id= " + flightDetailID + " and Statusid!=9";
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

    public Ticket getTicketById(int id) {
        String sql = "Select * from ticket where id =" + id + " and Statusid!=9";
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

    public List<Ticket> searchTickets(String passengerType, String statusTicket, String name, String phoneNumber, int Flight_Detailid, String Flight_Type_id, int order_Id) {
        List<Ticket> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("select t.* from Ticket t \n"
                + "join `flyezy`.`Order` o On t.Order_id=o.id\n"
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
        if (order_Id != -1) {
            sql.append(" AND Order_Id = ?");
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
            if (order_Id != -1) {
                ps.setInt(i++, order_Id);
            }

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
                        rs.getInt("Order_id"),
                        rs.getInt("Statusid"),
                        rs.getInt("Flight_Type_id"));
                ls.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }

    public int createTicketWhenChangeStatus(int id, Ticket ticket) {
        int n = 0;
        String sql = "INSERT INTO `flyezy`.`Ticket` \n"
                + "(`id`, `Seat_Categoryid`, `code`, `Statusid`,`Flight_Type_id`) \n"
                + "VALUES(?,?,?,?,?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, ticket.getSeat_Categoryid());
            ps.setString(3, ticket.getCode());
            ps.setInt(4, 9);
            ps.setInt(5, ticket.getFlight_Type_id());
            // Set các giá trị vào PreparedStatement
            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public int createTicket(int seatCategoryId, int passengerTypeId, String pName, int pSex, String pPhoneNumber, Date pDob, int baggageId, int orderId, int flightTypeId) {
        int n = 0;
        String sql = "INSERT INTO `flyezy`.`Ticket` \n"
                + "(`Seat_Categoryid`, `Passenger_Typesid`, `code`,`pName`,`pSex`,`pPhoneNumber`,`pDob`,`Baggagesid`,`Order_id`, `Statusid`,`Flight_Type_id`) \n"
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, seatCategoryId);
            ps.setInt(2, passengerTypeId);
            ps.setString(3, generateUniqueCode());
            ps.setString(4, pName);
            ps.setInt(5, pSex);
            ps.setString(6, pPhoneNumber);
            ps.setDate(7, pDob);
            ps.setInt(8, baggageId);
            ps.setInt(9, orderId);
            ps.setInt(10, 12);
            ps.setInt(11, flightTypeId);

            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public String generateUniqueCode() {
        String code;
        List<String> existingCodes = getAllTicketCodes();
        Random random = new Random();
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        do {
            StringBuilder sb = new StringBuilder(9);
            for (int i = 0; i < 9; i++) {
                sb.append(characters.charAt(random.nextInt(characters.length())));
            }
            code = sb.toString();
        } while (existingCodes.contains(code));
        return code;
    }

    public List<String> getAllTicketCodes() {
        List<String> codes = new ArrayList<>();
        String sql = "SELECT code FROM flyezy.Ticket";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                codes.add(rs.getString("code"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return codes;
    }

    public static void main(String[] args) {
        TicketDAO tcd = new TicketDAO();
        //tcd.createTicket(7, 1, "Sasuke", 1, "0123", Date.valueOf("2024-10-16"), 4, 1, 1);
        System.out.println(tcd.searchTickets("1", "10", "P", "091", 1, "1", 1));
    }
}
