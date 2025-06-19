package lk.ijse.jspassignment.dto;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class EmployeeDTO {
    private String nic;
    private String name;
    private String address;
    private String contact;
    private String jobRole;
}
