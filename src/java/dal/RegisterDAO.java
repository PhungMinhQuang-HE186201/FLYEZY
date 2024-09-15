/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import model.Accounts;

/**
 *
 * @author Admin
 */
public class RegisterDAO extends DBConnect {

    public boolean checkPhoneNumberExisted(String phoneNumber) {
        String sql = "select * from Accounts where phoneNumber=?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, phoneNumber);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean checkEmailExisted(String email) {
        String sql = "select * from Accounts where email=?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public void addNew(Accounts a) {
        String sql = "INSERT INTO accounts (name, password, email, phoneNumber, address, Image, dob, rolesid, Airlineid)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, 2, NULL);";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, a.getName()); // UserName
            st.setString(2, a.getPassword()); // Password
            st.setString(3, a.getEmail()); // Email
            st.setString(4, a.getPhoneNumber()); // Phone_Number
            st.setString(5, a.getAddress()); // Address
            st.setString(6, a.getImage()); // Image
            st.setDate(7, a.getDob()); // Date_Of_Birth
            st.executeUpdate(); // Sử dụng executeUpdate để thực hiện các câu lệnh thay đổi dữ liệu
        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi để dễ dàng gỡ lỗi
        }
    }

  public static void main(String[] args) {
        // Tạo đối tượng của lớp AccountDAO
        RegisterDAO dao = new RegisterDAO();
        
        // Số điện thoại để kiểm tra
        String phoneNumberToCheck = "0966486473"; // Thay đổi theo số điện thoại bạn muốn kiểm tra
        
        // Kiểm tra số điện thoại có tồn tại không
        boolean exists = dao.checkPhoneNumberExisted(phoneNumberToCheck);
        
        // Hiển thị kết quả
        if (exists) {
            System.out.println("Số điện thoại đã tồn tại trong cơ sở dữ liệu.");
        } else {
            System.out.println("Số điện thoại không tồn tại trong cơ sở dữ liệu.");
        }
    }
}
