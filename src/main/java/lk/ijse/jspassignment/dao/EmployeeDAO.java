package lk.ijse.jspassignment.dao;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EmployeeDAO {

    private BasicDataSource ds;

    public EmployeeDAO(BasicDataSource ds) {
        this.ds = ds;
    }

    public String getJobRole(String nic) {
        try{
            String sql = "select jobrole from employee where nic=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, nic);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("jobrole");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
