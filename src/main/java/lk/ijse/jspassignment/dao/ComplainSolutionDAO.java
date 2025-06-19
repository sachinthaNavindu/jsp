package lk.ijse.jspassignment.dao;

import lk.ijse.jspassignment.dto.ComplainSolutionDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ComplainSolutionDAO {

    private BasicDataSource ds;

    public ComplainSolutionDAO(BasicDataSource ds) {
        this.ds = ds;
    }

    public boolean saveAdminComment(ComplainSolutionDTO complaintSolutionDTO) {
        try{
            String sql = "INSERT INTO complaint_solution (compl_id, solution) VALUES (?, ?)";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, complaintSolutionDTO.getComplaintId());
            ps.setString(2,complaintSolutionDTO.getSolution());
            int rs = ps.executeUpdate();
            return rs > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<ComplainSolutionDTO> getAllSolutions() {
        try{
            String sql = "SELECT * FROM complaint_solution";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            List<ComplainSolutionDTO> complaintSolutionDTOS = new ArrayList<>();
            while (rs.next()) {
                ComplainSolutionDTO complaintSolutionDTO = new ComplainSolutionDTO();
                complaintSolutionDTO.setComplaintId(rs.getString("compl_id"));
                complaintSolutionDTO.setSolution(rs.getString("solution"));
                complaintSolutionDTOS.add(complaintSolutionDTO);
            }
            return complaintSolutionDTOS;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean checkForCommentById(String complaintId) {
        try{
            String sql = "SELECT * FROM complaint_solution WHERE compl_id=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, complaintId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        }catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public boolean updateAdminComment(String complaintId, String adminComments) {
        try{
            String sql = "UPDATE complaint_solution SET solution=? WHERE compl_id=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, adminComments);
            ps.setString(2, complaintId);
            int rs = ps.executeUpdate();
            return rs > 0;
        }catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean delete(String id) {
        try{
            String sql = "DELETE FROM complaint_solution WHERE compl_id=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1, id);
            int rs = ps.executeUpdate();
            return rs > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
