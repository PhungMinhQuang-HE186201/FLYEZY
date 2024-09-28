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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Flights;
import model.Status;

/**
 *
 * @author user
 */
public class StatusDAO extends DBConnect {

    public String getStatusById(int id) {
        String sql = "SELECT name FROM Status WHERE id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<Status> getStatusOfFlight() {
        List<Status> list = new ArrayList<>();
        String sql = "select * from Status where id = 1 or id = 2 ";

        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            ResultSet resultSet = prepare.executeQuery();
            prepare = conn.prepareStatement(sql);
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                list.add(new Status(id, name));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;    
    }
    
}
    
