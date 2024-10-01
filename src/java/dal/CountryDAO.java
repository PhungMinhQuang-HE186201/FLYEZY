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
import model.Country;

/**
 *
 * @author user
 */
public class CountryDAO extends DBConnect {

    public List<Country> getAllCountry() {
        List<Country> list = new ArrayList<>();
        String sql = "select * from Country";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                list.add(new Country(id, name));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public int getIdByCountryName(String name) {
        String sql = "Select * from Country where name = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setString(1, name);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("id");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }

    public static void main(String[] args) {
        CountryDAO cd = new CountryDAO();
        System.out.println(cd.getAllCountry());
    }
}
