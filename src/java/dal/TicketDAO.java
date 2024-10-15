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

    public List<Ticket> searchTickets(String passengerType, String statusTicket, String name, String phoneNumber, int Flight_Detailid, String Flight_Type_id) {
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

    public static void main(String[] args) {
        TicketDAO tcd = new TicketDAO();
        System.out.println(tcd.getAllTicketsById(1));
    }
}
