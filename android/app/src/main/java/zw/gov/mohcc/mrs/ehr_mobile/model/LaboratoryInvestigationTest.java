package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;



import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
public class LaboratoryInvestigationTest {

    private int id;
    private String laboratoryInvestigationId;
    private LocalDateTime time;
    private BaseNameModel result;


}