package lk.ijse.jspassignment.dao;

import lk.ijse.jspassignment.dto.ComplainDTO;
import lk.ijse.jspassignment.dto.CustomeDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QueryDAO {
    private BasicDataSource ds;

    public QueryDAO(BasicDataSource ds) {
        this.ds = ds;
    }


    public List<CustomeDTO> getAll() {
        List<CustomeDTO> list = new ArrayList<>();
        try{
            String sql = "SELECT c.compl_id,c.NIC,c.date,c.time,c.description,c.status,c.complaint_category,cs.solution_id,cs.solution FROM complains c LEFT JOIN complaint_solution cs ON c.compl_id = cs.compl_id where status='Resolved'";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CustomeDTO dto = new CustomeDTO();
                dto.setComplaintId(rs.getString("compl_id"));
                dto.setNic(rs.getString("NIC"));
                dto.setDate(rs.getString("date"));
                dto.setTime(rs.getString("time"));
                dto.setDescription(rs.getString("description"));
                dto.setStatus(rs.getString("status"));
                dto.setComplaintCategory(rs.getString("complaint_category"));
                dto.setSolutionId(rs.getString("solution_id"));
                dto.setSolution(rs.getString("solution"));

                list.add(dto);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}
