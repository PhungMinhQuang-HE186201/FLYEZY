/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.jdbc.PreparedStatementWrapper;
import dal.DBConnect;
import model.Discount;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class DiscountDAO extends DBConnect {

    public List<Discount> getAll() {
        List<Discount> ls = new ArrayList<>();
        String sql = "SELECT * FROM flyezy.discount;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                Double percentage = rs.getDouble("percentage");
                ls.add(new Discount(id, percentage));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return ls;
    }

    public static void main(String[] args) {
        DiscountDAO dal = new DiscountDAO();
        List<Discount> d = dal.getAll();
       
        for (Discount ls : d) {
            System.out.println(ls.getId());
            System.out.println(ls.getPercentage());
        }
    }
}
