package lk.ijse.jspassignment.dao;

import lk.ijse.jspassignment.dto.ComplainDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ComplainDAO {
    private BasicDataSource ds;
    public ComplainDAO(BasicDataSource ds) {
        this.ds = ds;
    }

    public boolean saveComplaint(ComplainDTO complainDTO) {
        try{
            String sql = "insert into complains values(?,?,?,?,?,?,?)";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1,complainDTO.getComplainId());
            ps.setString(2,complainDTO.getNic());
            ps.setString(3,complainDTO.getDate());
            ps.setString(4,complainDTO.getTime());
            ps.setString(5,complainDTO.getContext());
            ps.setString(6,complainDTO.getStatus());
            ps.setString(7,complainDTO.getCategory());

            int rs = ps.executeUpdate();
            return rs > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String getNextComplainId() {
        try {
            String sql = "SELECT compl_id FROM complains ORDER BY compl_id DESC LIMIT 1";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            int nextId = 1;

            if (rs.next()) {
                String lastId = rs.getString("compl_id");
                if (lastId != null) {
                    String numPart = lastId.substring(5);
                    try {
                        int lastNum = Integer.parseInt(numPart);
                        nextId = lastNum + 1;
                    } catch (NumberFormatException e) {
                        nextId = 1;
                    }
                }
            }
            return "comp-" + nextId;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
