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
import java.sql.Timestamp;
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
                Order o = new Order(
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
                        rs.getTimestamp("created_at"),
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

    public int getAirlineIdByOrder(int id) {
        String sql = "select o.id,f.airline_id from flyezy.order o\n"
                + "join flyezy.flight_detail fd on fd.id = o.flight_detail_id\n"
                + "join flyezy.flight f on f.id = fd.flightid\n"
                + "where o.id = ?";
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

    public int getFlightIdByOrder(int id) {
        String sql = "select o.id,fd.flightid from flyezy.order o\n"
                + "join flyezy.flight_detail fd on fd.id = o.flight_detail_id\n"
                + "where o.id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("flightid");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return -1;
    }

    public List<Order> searchOrder(int statusId, String code, String keyword, int flightDetailId,int index) {
        List<Order> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM flyezy.Order WHERE 1=1 ");
        // Use a list to hold parameter values
        List<Object> parameters = new ArrayList<>();

        // Append condition for flightDetailId (ensure space after 1=1)
        sql.append("AND Flight_Detail_id = ? ");
        parameters.add(flightDetailId);

        // Append condition for code if provided
        if (code != null && !code.trim().isEmpty()) {
            sql.append("AND code LIKE ? ");
            parameters.add("%" + code + "%");
        }

        // Append condition for statusId if provided
        if (statusId != -1) {
            sql.append("AND Status_id = ? ");
            parameters.add(statusId);
        }

        // Append condition for keyword if provided
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (contactName LIKE ? OR contactPhone LIKE ? OR contactEmail LIKE ?) ");
            String keywordPattern = "%" + keyword + "%";
            parameters.add(keywordPattern);
            parameters.add(keywordPattern);
            parameters.add(keywordPattern);
        }
        sql.append("LIMIT 3 OFFSET "+ " "+(index-1)*5);
        try {
            // Prepare the SQL statement
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            // Set the parameters in the prepared statement
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i)); // Use setObject for dynamic types
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
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
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(o);
            }
            return list;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return !list.isEmpty() ? list : null;
    }

    public List<Order> getAllOrdersByFlightDetail(int flightDetailId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order where flyezy.Order.Flight_Detail_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
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
                        rs.getTimestamp("created_at"),
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

    public List<Order> getAllOrdersByFlightDetailWithPaging(int flightDetailId,int index) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.Order where flyezy.Order.Flight_Detail_id = ? LIMIT 5 OFFSET ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ps.setInt(2, (index-1)*5);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(
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
                        rs.getTimestamp("created_at"),
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
    public int getNumberOfOrdersByFlightDetail(int flightDetailId) {
        String sql = "select Count(*) from flyezy.Order where flyezy.Order.Flight_Detail_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, flightDetailId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
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

    public String createOrder(int flightDetailId, String contactName, String contactPhone, String contactEmail, int totalPrice, Integer accountId) {
        String sql = "INSERT INTO `Order` (Flight_Detail_id, code, contactName, contactPhone, contactEmail, totalPrice, Accounts_id,Status_id, created_at) "
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
            if (accountId != null) {
                ps.setInt(7, accountId);
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }
            ps.setInt(8, 12); //is pending
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
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
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Order WHERE code= ?";
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
                        rs.getTimestamp("created_at"),
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

    public void deleteOrderByCode(String code) {
        String sql = "DELETE FROM flyezy.Order WHERE code = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Order> getListOrderByCode(String code) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.Order WHERE code= ?";
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
                        rs.getTimestamp("created_at"),
                        rs.getInt("Discount_id"),
                        rs.getInt("Status_id")
                );
                list.add(order);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no order is found
    }

    public List<Order> getOrdersByStatus(int statusId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from flyezy.order\n"
                + "where flyezy.order.Status_id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, statusId);
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
                        rs.getTimestamp("created_at"),
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

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        //dao.createOrder(1, "Naruto", "0123", "hello@gmail.com", 10000, null);
        System.out.println(dao.getOrderByCode("f"));
    }

}
