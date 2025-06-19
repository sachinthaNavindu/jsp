package lk.ijse.jspassignment.dao;

import lk.ijse.jspassignment.dto.ComplainDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

    public List<ComplainDTO> getLogedInUserComplaints(String nic) {
        List<ComplainDTO> list = new ArrayList<>();
        try{
            String sql = "select * from complains where NIC =?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1,nic);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ComplainDTO complainDTO = new ComplainDTO();
                complainDTO.setComplainId(rs.getString("compl_id"));
                complainDTO.setNic(rs.getString("NIC"));
                complainDTO.setDate(rs.getString("date"));
                complainDTO.setTime(rs.getString("time"));
                complainDTO.setContext(rs.getString("description"));
                complainDTO.setStatus(rs.getString("status"));
                complainDTO.setCategory(rs.getString("complaint_category"));

                list.add(complainDTO);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public ComplainDTO getComplainById(String complaintId) {
        try{

            String sql = "select * from complains where compl_id =?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1,complaintId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ComplainDTO complainDTO = new ComplainDTO();
                complainDTO.setComplainId(rs.getString("compl_id"));
                complainDTO.setNic(rs.getString("NIC"));
                complainDTO.setDate(rs.getString("date"));
                complainDTO.setTime(rs.getString("time"));
                complainDTO.setContext(rs.getString("description"));
                complainDTO.setCategory(rs.getString("complaint_category"));
                complainDTO.setStatus(rs.getString("status"));
                return complainDTO;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public boolean updateComplain(ComplainDTO complainDTO) {
        try{
            String sql = "Update complains set description=?, complaint_category=? where compl_id=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1,complainDTO.getContext());
            ps.setString(2,complainDTO.getCategory());
            ps.setString(3,complainDTO.getComplainId());

            int effect = ps.executeUpdate();
            return effect > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteComplain(String complaintId) {
        try{
            String sql = "delete from complains where compl_id=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1,complaintId);
            int effect = ps.executeUpdate();
            return effect > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<ComplainDTO> getAllComplaints(String status) {
        try{
            String sql = "select * from complains where status =?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1,status);
            ResultSet rs = ps.executeQuery();
            List<ComplainDTO> list = new ArrayList<>();
            while (rs.next()) {
                ComplainDTO complainDTO = new ComplainDTO();
                complainDTO.setComplainId(rs.getString("compl_id"));
                complainDTO.setNic(rs.getString("NIC"));
                complainDTO.setDate(rs.getString("date"));
                complainDTO.setContext(rs.getString("description"));
                complainDTO.setStatus(rs.getString("status"));
                list.add(complainDTO);
            }
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public int getPendingComplainCount(String status) {
        try{
            String sql = "select count(*) from complains where status=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1,status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }catch (Exception e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public boolean updateStatus(String status, String complaintId) {
        try{
            String sql = "update complains set status=? where compl_id=?";
            PreparedStatement ps = ds.getConnection().prepareStatement(sql);
            ps.setString(1,status);
            ps.setString(2,complaintId);
            int effect = ps.executeUpdate();
            return effect > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
