package lk.ijse.jspassignment.dto;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ComplainDTO {
    private String complainId;
    private String nic;
    private String date;
    private String time;
    private String context;
    private String status;
    private String category;
}
