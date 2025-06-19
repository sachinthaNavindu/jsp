package lk.ijse.jspassignment.dto;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
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
}