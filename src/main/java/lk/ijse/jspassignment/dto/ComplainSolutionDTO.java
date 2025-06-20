package lk.ijse.jspassignment.dto;

public class ComplainSolutionDTO {
    private String complaintId;
    private String solution;

    public ComplainSolutionDTO() {
    }

    public ComplainSolutionDTO(String complaintId, String solution) {
        this.complaintId = complaintId;
        this.solution = solution;
    }

    public String getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(String complaintId) {
        this.complaintId = complaintId;
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String solution) {
        this.solution = solution;
    }

    @Override
    public String toString() {
        return "ComplainSolutionDTO{" +
                "complaintId='" + complaintId + '\'' +
                ", solution='" + solution + '\'' +
                '}';
    }
}
