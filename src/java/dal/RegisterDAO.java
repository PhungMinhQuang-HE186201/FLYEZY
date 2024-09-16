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

    public void addNewAccount(Accounts a) {
        String sql = "INSERT INTO Accounts (name, password, email, phoneNumber, address, image, dob, Rolesid, Airlineid)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NULL);";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, a.getName());
            st.setString(2, a.getPassword());
            st.setString(3, a.getEmail()); 
            st.setString(4, a.getPhoneNumber()); 
            st.setString(5, a.getAddress()); 
            st.setString(6, a.getImage()); 
            st.setDate(7, a.getDob());
            st.setInt(8, a.getRoleId()); 
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

  public static void main(String[] args) {
       RegisterDAO rd = new RegisterDAO();
       rd.addNewAccount(new Accounts("Quaan", "123@gmail.com", "1", "0123", 2));
    }
}
