/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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

    public void changePassword(String idAccount, String newPassword) {
        String sqlupdate = "UPDATE `flyezy`.`accounts`\n"
                + "SET\n"
                + "`password` = ?\n"
                + "WHERE `id` = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sqlupdate);
            pre.setString(1, newPassword);
            pre.setString(2, idAccount);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void infoUpdate(Accounts account) {
        String sqlUpdate = "UPDATE `flyezy`.`accounts`\n"
                + "SET\n"
                + "`name` = ?,\n"
                + "`dob` = ?,\n"
                + "`email` = ?,\n"
                + "`phoneNumber` = ?,\n"
                + "`address` = ?,\n"
                + "`image` = ?\n"
                + "WHERE `id` = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sqlUpdate);
            pre.setString(1, account.getName());
            pre.setDate(2, account.getDob());
            pre.setString(3, account.getEmail());
            pre.setString(4, account.getPhoneNumber());
            pre.setString(5, account.getAddress());
            pre.setString(6, account.getImage());
            pre.setInt(7,account.getId());
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        AccountsDAO a = new AccountsDAO();
//        //a.updateAccount(new Accounts(1, "Ngo 123", "duongnthe186310@fpt.edu.vn", "1", "0862521226", null, "img/flyezy-logo.png", null, 2, 1));
//        String dateString = "1/1/1";
//        SimpleDateFormat sdf = new SimpleDateFormat("d/M/yy"); 
//        Accounts account = new Accounts(1,"khoapv" , "khoapvhe182378@gmail.com", "123", "bac ninh", "", "dateString");
//        System.out.println(a.infoUpdate(account));
    }
}
