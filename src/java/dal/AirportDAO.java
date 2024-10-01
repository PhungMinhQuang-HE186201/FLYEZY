/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Airport;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author user
 */
public class AirportDAO extends DBConnect {
    
    public List<Airport> getAllAirport() {
        List<Airport> list = new ArrayList<>();
        String sql = "select * from Airport";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                int locationId = resultSet.getInt("Locationid");
                
                list.add(new Airport(id, name, locationId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }
    
    public List<Airport> getAirportsByLocationId(int lid) {
        List<Airport> list = new ArrayList<>();
        String sql = "select * from Airport WHERE Locationid = ?";
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, lid);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                int locationId = resultSet.getInt("Locationid");
                
                list.add(new Airport(id, name, locationId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }
}
