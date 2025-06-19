package lk.ijse.jspassignment.dao;

import lk.ijse.jspassignment.dto.EmployeeDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

    public List<EmployeeDTO> getAllEmployee() {
        try{
            String sql = "select * from employee";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            List<EmployeeDTO> list = new ArrayList<>();
            while (rs.next()) {
                EmployeeDTO dto = new EmployeeDTO();
                dto.setNic(rs.getString("NIC"));
                dto.setName(rs.getString("name"));
                dto.setAddress(rs.getString("adrs"));
                dto.setContact(rs.getString("contactNo"));
                dto.setJobRole(rs.getString("jobrole"));
                list.add(dto);
            }
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean saveEmployee(EmployeeDTO employeeDTO) {
        try{
            String sql = "insert into employee values(?,?,?,?,?)";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, employeeDTO.getNic());
            ps.setString(2, employeeDTO.getName());
            ps.setString(3, employeeDTO.getAddress());
            ps.setString(4, employeeDTO.getContact());
            ps.setString(5, employeeDTO.getJobRole());

            int rs = ps.executeUpdate();

            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean update(EmployeeDTO employeeDTO) {
        try{
            String sql = "update employee set name=?, adrs=?, contactNo=?, jobrole=? where NIC=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, employeeDTO.getName());
            ps.setString(2, employeeDTO.getAddress());
            ps.setString(3, employeeDTO.getContact());
            ps.setString(4, employeeDTO.getJobRole());
            ps.setString(5, employeeDTO.getNic());
            int rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean delete(String deleteNic) {
        try{
            String sql = "delete from employee where NIC=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, deleteNic);
            int rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }
}
