package lk.ijse.jspassignment.dao;

import lk.ijse.jspassignment.dto.CredentialDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CredentialDAO {
    private BasicDataSource ds;

    public CredentialDAO(BasicDataSource ds) {
        this.ds = ds;
    }

    public List<String> getAvailableNic() {

        List<String>nicList = new ArrayList<>();

        String sql = "select NIC from employee";

        try(Connection connection = ds.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while (rs.next()) {
                nicList.add(rs.getString("NIC"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nicList;
    }

    public boolean checkPassword(CredentialDTO credentialDto) {
        try{
            String sql = "select pw from credentials where gmail = ? and pw = ?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, credentialDto.getGmail());
            ps.setString(2, credentialDto.getPassword());
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                return true;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public boolean saveNewUser(CredentialDTO credentialDTO) {

        try {
            String sql = "insert into credentials (userName,NIC,gmail,pw) values (?,?,?,?)";

            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, credentialDTO.getUsername());
            ps.setString(2, credentialDTO.getNic());
            ps.setString(3, credentialDTO.getGmail());
            ps.setString(4, credentialDTO.getPassword());

            int rs = ps.executeUpdate();
            return rs > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public CredentialDTO findByEmail(String emailInput) {
        try {
            String sql = "select * from credentials where gmail = ?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, emailInput);
            ResultSet rs = ps.executeQuery();
            CredentialDTO credentialDTO = new CredentialDTO();
            while (rs.next()) {
                credentialDTO.setGmail(rs.getString("gmail"));
                credentialDTO.setPassword(rs.getString("pw"));
                credentialDTO.setNic(rs.getString("NIC"));
                credentialDTO.setUsername(rs.getString("userName"));
            }
            return credentialDTO;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
