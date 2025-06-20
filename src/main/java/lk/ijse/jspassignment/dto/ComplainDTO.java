package lk.ijse.jspassignment.dto;

public class ComplainDTO {
    private String complainId;
    private String nic;
    private String date;
    private String time;
    private String context;
    private String status;
    private String category;

    public ComplainDTO() {
    }

    public ComplainDTO(String complainId, String nic, String date, String time, String context, String status, String category) {
        this.complainId = complainId;
        this.nic = nic;
        this.date = date;
        this.time = time;
        this.context = context;
        this.status = status;
        this.category = category;
    }

    public String getComplainId() {
        return complainId;
    }

    public void setComplainId(String complainId) {
        this.complainId = complainId;
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

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "ComplainDTO{" +
                "complainId='" + complainId + '\'' +
                ", nic='" + nic + '\'' +
                ", date='" + date + '\'' +
                ", time='" + time + '\'' +
                ", context='" + context + '\'' +
                ", status='" + status + '\'' +
                ", category='" + category + '\'' +
                '}';
    }
}
