package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index("laboratoryInvestigationId"), @Index("visitId"), @Index("testkitId")},
        foreignKeys = {@ForeignKey(entity = LaboratoryInvestigation.class, parentColumns = "id", childColumns = "laboratoryInvestigationId", onDelete = CASCADE),
                @ForeignKey(entity = Visit.class, parentColumns = "id", childColumns = "visitId", onDelete = CASCADE),
                @ForeignKey(entity = TestKit.class, parentColumns = "code", childColumns = "testkitId", onDelete = CASCADE)})
public class LaboratoryInvestigationTest extends BaseEntity {

    @NonNull
    private String laboratoryInvestigationId;
    @TypeConverters(DateConverter.class)
    @NonNull
    private Date startTime;
    @TypeConverters(DateConverter.class)
    private Date endTime;
    @NonNull
    private String visitId;
    @Embedded(prefix = "result_")
    @NonNull
    private NameCode result;
    @Embedded(prefix = "testkit_")
    @NonNull
    private NameCode testkit;

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

    public NameCode getResult() {
        return result;
    }

    public void setResult(NameCode result) {
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

    public NameCode getTestkit() {
        return testkit;
    }

    public void setTestkit(NameCode testkit) {
        this.testkit = testkit;
    }

    @Override
    public String toString() {
        return "LaboratoryInvestigationTest{" +
                "laboratoryInvestigationId='" + laboratoryInvestigationId + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", visitId='" + visitId + '\'' +
                ", result='" + result.toString() + '\'' +
                ", testkitId='" + testkit + '\'' +
                '}';
    }
}
