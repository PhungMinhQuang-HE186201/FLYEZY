/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Accounts;

/**
 *
 * @author Admin
 */
public class AccountsDAO extends DBConnect {

    public List<Accounts> getAllAccounts() {
        List<Accounts> ls = new ArrayList<>();
        String sql = "Select * from Accounts";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"));
                ls.add(a);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public int getIdByUsername(String username) {
        String sql = "SELECT id FROM accounts WHERE email = ?";
        int userId = -1; // Giá trị mặc định nếu không tìm thấy

        try (PreparedStatement st = conn.prepareStatement(sql)) {

            st.setString(1, username); // Đặt giá trị cho tên người dùng

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id"); // Lấy ID từ kết quả
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi nếu có
        }

        return userId; // Trả về ID, hoặc -1 nếu không tìm thấy
    }

    public static void main(String[] args) {
        AccountsDAO a = new AccountsDAO();
        System.out.println(a.getIdByUsername("Ngo Tung Duong"));
    }
}
