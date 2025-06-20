package lk.ijse.jspassignment.dto;

public class CustomeDTO {
    private String complaintId;
    private String nic;
    private String date;
    private String time;
    private String description;
    private String status;
    private String complaintCategory;
    private String solutionId;
    private String solution;

    public CustomeDTO() {
    }

    public CustomeDTO(String complaintId, String nic, String date, String time, String description, String status, String complaintCategory, String solutionId, String solution) {
        this.complaintId = complaintId;
        this.nic = nic;
        this.date = date;
        this.time = time;
        this.description = description;
        this.status = status;
        this.complaintCategory = complaintCategory;
        this.solutionId = solutionId;
        this.solution = solution;
    }

    public String getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(String complaintId) {
        this.complaintId = complaintId;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getComplaintCategory() {
        return complaintCategory;
    }

    public void setComplaintCategory(String complaintCategory) {
        this.complaintCategory = complaintCategory;
    }

    public String getSolutionId() {
        return solutionId;
    }

    public void setSolutionId(String solutionId) {
        this.solutionId = solutionId;
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String solution) {
        this.solution = solution;
    }

    @Override
    public String toString() {
        return "CustomeDTO{" +
                "complaintId='" + complaintId + '\'' +
                ", nic='" + nic + '\'' +
                ", date='" + date + '\'' +
                ", time='" + time + '\'' +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                ", complaintCategory='" + complaintCategory + '\'' +
                ", solutionId='" + solutionId + '\'' +
                ", solution='" + solution + '\'' +
                '}';
    }
}
