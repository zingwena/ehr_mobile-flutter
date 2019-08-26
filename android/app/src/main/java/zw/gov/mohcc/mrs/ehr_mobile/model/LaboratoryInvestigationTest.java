package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
public class LaboratoryInvestigationTest {

    private int id;
    private String laboratoryInvestigationId;
    private LocalDateTime time;
    private Result result;
    private String visitId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLaboratoryInvestigationId() {
        return laboratoryInvestigationId;
    }

    public void setLaboratoryInvestigationId(String laboratoryInvestigationId) {
        this.laboratoryInvestigationId = laboratoryInvestigationId;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public Result getResult() {
        return result;
    }

    public void setResult(Result result) {
        this.result = result;
    }

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }
}
