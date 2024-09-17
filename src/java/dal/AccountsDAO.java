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

//    public List<Accounts> getAccountByName(String name, String phone) {
//        String sql = "";
//        if (name != null && !name.isEmpty()) {
//            sql += "select * from Accounts where name Like '%" + name + "%'";
//            if (phone != null && !phone.isEmpty()) {
//                sql += "And phoneNumber = '" + phone + "'";
//            }
//        } else {
//            sql += "select * from Accounts where phoneNumber = '" + phone + "'";
//        }
//        List<Accounts> la = new ArrayList<>();
//        Accounts account = null;
//        try {
//            PreparedStatement st = conn.prepareStatement(sql);
//            ResultSet rs = st.executeQuery(sql);
//
//            while (rs.next()) {
//                String name1 = rs.getString(2);
//                String email = rs.getString(3);
//                String password = rs.getString(4);
//                String phoneNumber = rs.getString(5);
//                String address = rs.getString(6);
//                account = new Accounts(name1, email, password, phoneNumber, address, email);
//                la.add(account);
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//        return la;
//    }
    public void updateAccount(Accounts account) {
        String sql = "UPDATE Accounts\n"
                + "   SET name = ?\n"
                + "      ,email = ?\n"
                + "      ,password = ?\n"
                + "      ,phoneNumber = ?\n"
                + "      ,address = ?\n"
                + "      ,Rolesid = ?\n"
                + "      ,Airlineid = ?\n"
                + "      ,image = ?\n"
                + "      ,dob = ?\n"
                + " WHERE id=?";

        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, account.getName());
            pre.setString(2, account.getEmail());
            pre.setString(3, account.getPassword());
            pre.setString(4, account.getPhoneNumber());
            pre.setString(5, account.getAddress());
            pre.setInt(6, account.getRoleId());
            pre.setInt(7, account.getAirlineId());
            pre.setString(8, account.getImage());
            pre.setDate(9, account.getDob());
            pre.setInt(10, account.getId());
            pre.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    public void removeAccount(int id) {
        String sql = "delete from Accounts where id = " + id;

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.executeUpdate(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<Accounts> searchAccounts(String role, String name, String phoneNumber) {
        List<Accounts> ls = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Accounts WHERE 1=1");

        if (role != null && !role.isEmpty()) {
            sql.append(" AND Rolesid = ?");
        }
        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (phoneNumber != null && !phoneNumber.isEmpty()) {
            sql.append(" AND phoneNumber LIKE ?");
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int i = 1;
            if (role != null && !role.isEmpty()) {
                ps.setString(i++, role);
            }
            if (name != null && !name.isEmpty()) {
                ps.setString(i++, "%" + name + "%");
            }
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                String vp = phoneNumber;
                if (vp.startsWith("0")) {
                    vp = vp.substring(1);
                }
                ps.setString(i++, "%" + vp + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Accounts a = new Accounts(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("phoneNumber"),
                        rs.getString("address"), rs.getString("image"), rs.getDate("dob"), rs.getInt("Rolesid"), rs.getInt("Airlineid"));
                ls.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }

    public static void main(String[] args) {
        AccountsDAO a = new AccountsDAO();
        //a.updateAccount(new Accounts(1, "Ngo 123", "duongnthe186310@fpt.edu.vn", "1", "0862521226", null, "img/flyezy-logo.png", null, 2, 1));
        System.out.println(a.searchAccounts("1", "Qua", "0123"));
    }
}
