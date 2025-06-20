package lk.ijse.jspassignment.dto;

public class CredentialDTO {
    private String username;
    private String nic;
    private String gmail;
    private String password;
    private String jobRole;

    public CredentialDTO() {
    }

    public CredentialDTO(String username, String nic, String gmail, String password, String jobRole) {
        this.username = username;
        this.nic = nic;
        this.gmail = gmail;
        this.password = password;
        this.jobRole = jobRole;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getGmail() {
        return gmail;
    }

    public void setGmail(String gmail) {
        this.gmail = gmail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getJobRole() {
        return jobRole;
    }

    public void setJobRole(String jobRole) {
        this.jobRole = jobRole;
    }

    @Override
    public String toString() {
        return "CredentialDTO{" +
                "username='" + username + '\'' +
                ", nic='" + nic + '\'' +
                ", gmail='" + gmail + '\'' +
                ", password='" + password + '\'' +
                ", jobRole='" + jobRole + '\'' +
                '}';
    }
}
