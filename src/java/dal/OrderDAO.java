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

/**
 *
 * @author PMQUANG
 */
public class OrderDAO extends DBConnect {

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.order";
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
        StringBuilder sql = new StringBuilder("SELECT * FROM flyezy.order WHERE 1=1 AND Flight_Detail_id = ?");

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
        String sql = "select * from flyezy.order where flyezy.order.Flight_Detail_id = ?";
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
        String sql = "UPDATE flyezy.order SET Status_id = ? WHERE id = ?";
        try {
            // Prepare the statement with the SQL query
            PreparedStatement ps = conn.prepareStatement(sql);

            // Set the new status and order ID in the prepared statement
            ps.setInt(1, newStatusId); // new status ID
            ps.setInt(2, orderId);      // order ID

            // Execute the update query
            int rowsUpdated = ps.executeUpdate();

            // If the update affected at least one row, return true
            return rowsUpdated > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
//        for (Order order : dao.getAllOrders()) {
//            System.out.println(order);
//        }
        System.out.println(dao.getAllOrdersByFlightDetail(1));
    }
}
