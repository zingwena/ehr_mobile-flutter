package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class LaboratoryInvestigationTest extends BaseEntity {

    private String laboratoryInvestigationId;
    @TypeConverters(DateConverter.class)
    private Date startTime;
    @TypeConverters(DateConverter.class)
    private Date endTime;
    private String visitId;
    @Embedded
    private Result result;
    private String testkitId;

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }

    public String getLaboratoryInvestigationId() {
        return laboratoryInvestigationId;
    }

    public void setLaboratoryInvestigationId(String laboratoryInvestigationId) {
        this.laboratoryInvestigationId = laboratoryInvestigationId;
    }

    public Result getResult() {
        return result;
    }

    public void setResult(Result result) {
        this.result = result;
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

    public String getTestkitId() {
        return testkitId;
    }

    public void setTestkitId(String testkitId) {
        this.testkitId = testkitId;
    }

    @Override
    public String toString() {
        return "LaboratoryInvestigationTest{" +
                "laboratoryInvestigationId='" + laboratoryInvestigationId + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", visitId='" + visitId + '\'' +
                ", result='" + result.toString() + '\'' +
                ", testkitId='" + testkitId + '\'' +
                '}';
    }
}
