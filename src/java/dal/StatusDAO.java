/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/**
 *
 * @author Admin
 */
public class StatusDAO extends DBConnect{
    public String getStatusById(int id){
        String sql = "SELECT name FROM Status WHERE id = ?";
        
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getString("name");
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public static void main(String[] args) {
        StatusDAO sd = new StatusDAO();
        System.out.println(sd.getStatusById(1));
    }
}
