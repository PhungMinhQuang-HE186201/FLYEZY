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
import java.sql.Statement;
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

    public List<Refund> searchRefund(String Status, String requestDateFrom, String requestDateTo, String refundDateFrom, String refundDateTo) {
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

    public int createRefund(Refund refund) {
        String sql = "INSERT INTO `flyezy`.`Refund`\n"
                + "(`bank`,`bankAccount`,`requestDate`,`refundDate`,`refundPrice`,`Ticketid`,`Statusid`)\n"
                + "VALUES (?,?,?,?,?,?,3)";
        int generatedId = -1;  // Giá trị mặc định cho trường hợp không thể lấy được ID
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, refund.getBank());
            preparedStatement.setString(2, refund.getBankAccount());
            preparedStatement.setTimestamp(3, refund.getRequestDate());
            preparedStatement.setTimestamp(4, refund.getRefundDate());
            preparedStatement.setInt(5, refund.getRefundPrice());
            preparedStatement.setInt(6, refund.getTicketid());
            preparedStatement.executeUpdate();

            // Lấy airlineId vừa được tạo
            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1);  // Trả về airlineId
            } else {
                System.err.println("Creating refund failed, no ID obtained.");
            }
        } catch (SQLException e) {
            // Xử lý lỗi SQL tại đây
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return generatedId;  // Trả về ID hoặc giá trị mặc định -1 nếu có lỗi
    }
}
