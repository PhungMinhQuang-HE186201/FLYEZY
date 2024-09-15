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
        String sql = "SELECT * FROM Accounts WHERE email = ? OR phoneNumber = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, emailOrPhoneNumber); 
            st.setString(2, emailOrPhoneNumber); 
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return true; 
            } else {
                return false; 
            }
        } catch (SQLException e) {
        }

        return false; 
    }

    public boolean checkPassword(String emailOrPhoneNumber, String password) {
        String sql = "SELECT * FROM accounts WHERE (email=? OR phoneNumber=?) AND password=?";

        try {
            PreparedStatement st = conn.prepareStatement(sql); 
            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber); 
            st.setString(3, password); 
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true; 
            } else {
                return false; 
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {
        LoginDAO a = new LoginDAO();

        String emailOrPhoneNumber = "duongnthe186310@fpt.edu.vn"; 

        boolean exists = a.checkPassword(emailOrPhoneNumber,"1");

        if (exists) {
            System.out.println("Tài khoản tồn tại với email hoặc số điện thoại: " + emailOrPhoneNumber);
        } else {
            System.out.println("Tài khoản không tồn tại với email hoặc số điện thoại: " + emailOrPhoneNumber);
        }
    }

}
