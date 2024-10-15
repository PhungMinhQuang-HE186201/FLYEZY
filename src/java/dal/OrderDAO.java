/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Order;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

/**
 *
 * @author PMQUANG
 */
public class OrderDAO extends DBConnect {

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("id"),
                        rs.getInt("Flight_Detail_id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getInt("Flight_Type_id"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Order> getOrdersByCriteria(Integer statusId, String keyword, Integer flightDetailId) {
        List<Order> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM flyezy.Order WHERE 1=1 AND Flight_Detail_id = ?");

        // Append conditions based on whether statusId, keyword, or flightDetailId are provided
        if (statusId != -1) {
            sql.append(" AND Status_id = ?");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (code LIKE ? OR contactName LIKE ? OR contactPhone LIKE ? OR contactEmail LIKE ?)");
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            int paramIndex = 1;

            // Set the statusId if it's provided
            if (statusId != null) {
                ps.setInt(paramIndex++, statusId);
            }

            // Set the keyword if it's provided
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                ps.setString(paramIndex++, searchPattern); // For `code`
                ps.setString(paramIndex++, searchPattern); // For `contactName`
                ps.setString(paramIndex++, searchPattern); // For `contactPhone`
                ps.setString(paramIndex++, searchPattern); // For `contactEmail`
            }

            ps.setInt(paramIndex++, flightDetailId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("id"),
                        rs.getInt("Flight_Detail_id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getInt("Flight_Type_id"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> getAllOrdersByFlightDetail(int flightDetailId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order where flyezy.Order.Flight_Detail_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("id"),
                        rs.getInt("Flight_Detail_id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getInt("Flight_Type_id"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public boolean updateOrderStatus(int orderId, int newStatusId) {
        String sql = "UPDATE flyezy.Order SET Status_id = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newStatusId);
            ps.setInt(2, orderId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public String createOrder(int flightDetailId, String contactName, String contactPhone, String contactEmail, int totalPrice, int accountId, int flightTypeId) {
        String sql = "INSERT INTO `Order` (Flight_Detail_id, code, contactName, contactPhone, contactEmail, totalPrice, Accounts_id, Flight_Type_id, Status_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String code = generateUniqueCode();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ps.setString(2, code);
            ps.setString(3, contactName);
            ps.setString(4, contactPhone);
            ps.setString(5, contactEmail);
            ps.setInt(6, totalPrice);
            ps.setInt(7, accountId);
            ps.setInt(8, flightTypeId);
            ps.setInt(9, 12); //is pending
            ps.executeUpdate();
            return code;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public String generateUniqueCode() {
        String code;
        List<String> existingCodes = getAllOrderCodes();
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

    public List<String> getAllOrderCodes() {
        List<String> codes = new ArrayList<>();
        String sql = "SELECT code FROM flyezy.Order";
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

    public Order getOrderByCode(String code) {
        String sql = "SELECT * FROM flyezy.Order WHERE code = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order(
                        rs.getInt("id"),
                        rs.getInt("Flight_Detail_id"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getInt("Accounts_id"),
                        rs.getInt("Payment_Types_id"),
                        rs.getTimestamp("paymentTime"),
                        rs.getInt("Flight_Type_id"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no order is found
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        dao.createOrder(1, "Naruto", "0123", "hello@gmail.com", 10000, 1, 1);
    }
}
