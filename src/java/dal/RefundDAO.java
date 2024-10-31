/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Refund;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Fantasy
 */
public class RefundDAO extends DBConnect {

    public List<Refund> getAllRefund() {
        List<Refund> ls = new ArrayList<>();
        String sql = "Select * from Refund";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Refund refund = new Refund(rs.getInt("id"), rs.getString("bank"), rs.getString("bankAccount"),
                        rs.getTimestamp("requestDate"), rs.getTimestamp("refundDate"), rs.getInt("Ticketid"),
                        rs.getInt("Statusid"));
                ls.add(refund);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Refund> searchRefund(String Status, String requestDateFrom, String requestDateTo,String refundDateFrom,String refundDateTo) {
        List<Refund> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("Select * from Refund where 1=1");

        if (Status != null && !Status.isEmpty()) {
            sql.append(" AND Statusid = ?");
        }
        if (requestDateFrom != null && !requestDateFrom.isEmpty()) {
            sql.append(" AND Date(requestDate) >= ?");
        }
        if (requestDateTo != null && !requestDateTo.isEmpty()) {
            sql.append(" AND Date(requestDate) <= ?");
        }
        if (refundDateFrom != null && !refundDateFrom.isEmpty()) {
            sql.append(" AND Date(refundDate) >= ?");
        }
        if (refundDateTo != null && !refundDateTo.isEmpty()) {
            sql.append(" AND Date(refundDate) <= ?");
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int i = 1;
            if (Status != null && !Status.isEmpty()) {
                int status = Integer.parseInt(Status);
                ps.setInt(i++, status);
            }
            if (requestDateFrom != null && !requestDateFrom.isEmpty()) {
                ps.setString(i++, requestDateFrom);
            }
            if (requestDateTo != null && !requestDateTo.isEmpty()) {
                ps.setString(i++, requestDateTo);
            }
            if (refundDateFrom != null && !refundDateFrom.isEmpty()) {
                ps.setString(i++, refundDateFrom);
            }
            if (refundDateTo != null && !refundDateTo.isEmpty()) {
                ps.setString(i++, refundDateTo);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Refund refund = new Refund(rs.getInt("id"), rs.getString("bank"), rs.getString("bankAccount"),
                        rs.getTimestamp("requestDate"), rs.getTimestamp("refundDate"), rs.getInt("Ticketid"),
                        rs.getInt("Statusid"));
                ls.add(refund);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }
}
