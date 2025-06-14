package lk.ijse.jspassignment.dao;

import jakarta.servlet.ServletContext;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SignupDAO {
    private BasicDataSource ds;

    public SignupDAO(BasicDataSource ds) {
        this.ds = ds;
    }
    public List<String> getAvailableNic() {
        System.out.println("get aval wada");
        List<String>nicList = new ArrayList<>();

        String sql = "select NIC from employee";

        try(Connection connection = ds.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while (rs.next()) {
                nicList.add(rs.getString("NIC"));
            }
            System.out.println("nic list" + nicList);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return nicList;
    }
}
