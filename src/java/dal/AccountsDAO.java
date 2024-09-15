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
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"));
                ls.add(a);
            }
            return ls;

        } catch (Exception e) {
        }
        return null;
    }

    public int getIdByEmailOrPhoneNumber(String emailOrPhoneNumber) {
        String sql = "SELECT id FROM Accounts WHERE email = ? OR phoneNumber = ?";
        int userId = -1; 

        try (PreparedStatement st = conn.prepareStatement(sql)) {

            st.setString(1, emailOrPhoneNumber); 
            st.setString(2, emailOrPhoneNumber); 

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id"); 
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }

        return userId; 
    }
    
    public Accounts getAccountsById(int id) {
        String sql = "SELECT * FROM Accounts WHERE id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        AccountsDAO a = new AccountsDAO();
        System.out.println(a.getIdByEmailOrPhoneNumber("0862521226"));
    }
}
