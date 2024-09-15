/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Accounts;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class LoginDAO extends DBConnect {

    public boolean checkUsername(String emailOrPhoneNumber) {
        // Câu lệnh SQL kiểm tra tồn tại tài khoản với email hoặc số điện thoại
        String sql = "SELECT * FROM Accounts WHERE email = ? OR phoneNumber = ?";

        try (PreparedStatement st = conn.prepareStatement(sql) // Đảm bảo phương thức getConnection() trả về kết nối hợp lệ
                ) {

            st.setString(1, emailOrPhoneNumber); // Đặt giá trị cho email
            st.setString(2, emailOrPhoneNumber); // Đặt giá trị cho phoneNumber

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return true; // Tài khoản tồn tại
            } else {
                return false; // Tài khoản không tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi nếu có
        }

        return false; // Trả về false nếu có lỗi xảy ra
    }

    public Accounts checkPassword(String emailOrPhoneNumber, String password) {
        String sql = "SELECT * FROM accounts WHERE (email=? OR phoneNumber=?) AND password=?";

        try {
            PreparedStatement st = conn.prepareStatement(sql); // 'conn' should be 'connection'
            st.setString(1, emailOrPhoneNumber); // Đặt giá trị cho email
            st.setString(2, emailOrPhoneNumber); // Đặt giá trị cho phoneNumber
            st.setString(3, password); // Đặt giá trị cho password

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts a = new Accounts(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phoneNumber"), // Use getString for phoneNumber
                        rs.getString("address"),
                        rs.getString("image"),
                        rs.getDate("dob")
                );
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        // Tạo đối tượng AccountDAO
        LoginDAO a = new LoginDAO();

        // Thay thế emailOrPhoneNumber bằng email hoặc số điện thoại bạn muốn kiểm tra
        String emailOrPhoneNumber = "duongnthe186310@fpt.edu.vn"; // Hoặc "1234567890"

        // Kiểm tra tài khoản tồn tại
        boolean exists = a.checkUsername(emailOrPhoneNumber);

        // In kết quả ra console
        if (exists) {
            System.out.println("Tài khoản tồn tại với email hoặc số điện thoại: " + emailOrPhoneNumber);
        } else {
            System.out.println("Tài khoản không tồn tại với email hoặc số điện thoại: " + emailOrPhoneNumber);
        }
    }

}
