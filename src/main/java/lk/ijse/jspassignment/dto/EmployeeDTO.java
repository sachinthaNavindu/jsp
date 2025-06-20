package lk.ijse.jspassignment.dto;

public class EmployeeDTO {
    private String nic;
    private String name;
    private String address;
    private String contact;
    private String jobRole;

    public EmployeeDTO() {
    }

    public EmployeeDTO(String nic, String name, String address, String contact, String jobRole) {
        this.nic = nic;
        this.name = name;
        this.address = address;
        this.contact = contact;
        this.jobRole = jobRole;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getJobRole() {
        return jobRole;
    }

    public void setJobRole(String jobRole) {
        this.jobRole = jobRole;
    }

    @Override
    public String toString() {
        return "EmployeeDTO{" +
                "nic='" + nic + '\'' +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", contact='" + contact + '\'' +
                ", jobRole='" + jobRole + '\'' +
                '}';
    }
}
