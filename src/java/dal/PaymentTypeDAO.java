/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.PaymentType;

public class PaymentTypeDAO extends DBConnect{
    public String getPaymentTypeNameById(int id) {
        String sql = "SELECT name FROM Payment_types WHERE id = ?";
        String name = null;
        try {
            PreparedStatement prepare = conn.prepareStatement(sql);
            prepare.setInt(1, id);  // Đặt giá trị id vào câu lệnh SQL
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                name = resultSet.getString("name");  // Lấy tên từ kết quả truy vấn
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return name;  // Trả về tên, nếu không có giá trị sẽ trả về null
    }
}
