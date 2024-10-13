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
                        rs.getInt("Flight_Detail_id"));
                ls.add(t);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }
    public List<Ticket> getAllTicketsById(int flightDetailID) {
        List<Ticket> ls = new ArrayList<>();
        String sql = "select * from Ticket where Flight_Detail_id= "+flightDetailID;
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
                        rs.getInt("Flight_Detail_id"));
                ls.add(t);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public Ticket getTicketById(int id) {
        String sql = "SELECT * FROM Ticket WHERE id = ?";
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
                        rs.getInt("Flight_Detail_id"));
                return t;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Ticket> searchTickets(String flightType, String passengerType, String statusTicket, String name, String phoneNumber,int Flight_Detailid) {
        List<Ticket> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Ticket WHERE Flight_Detail_id ="+Flight_Detailid);

        
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
            if (flightType != null && !flightType.isEmpty()) {
                ps.setString(i++, flightType);
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
                        rs.getInt("Flight_Detail_id"));
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
                + "(`id`, `Flight_Detailid`, `Seat_Categoryid`, `code`, `Statusid`) \n"
                + "VALUES(?,?,?,?,?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1,id);
            ps.setInt(2,ticket.getFlight_Detailid());
            ps.setInt(3,ticket.getSeat_Categoryid());
            ps.setString(4,ticket.getCode());
            ps.setInt(5,9);
            // Set các giá trị vào PreparedStatement
            n = ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return n;
    }
}
