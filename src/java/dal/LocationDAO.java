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
import model.Location;

/**
 *
 * @author user
 */
public class LocationDAO extends DBConnect{
    public List<Location> getAllLocation() {
        List<Location> list = new ArrayList<>();
        String sql = "select * from Location";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                int Country_id = resultSet.getInt("Country_id");
                list.add(new Location(id, name, Country_id));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }
}
