package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
public class LaboratoryInvestigationTest {

    private int id;
    private String laboratoryInvestigationId;
    private Date startTime;
    private Date endTime;
    private String resultId;

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

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getResultId() {
        return resultId;
    }

    public void setResultId(String resultId) {
        this.resultId = resultId;
    }
}
