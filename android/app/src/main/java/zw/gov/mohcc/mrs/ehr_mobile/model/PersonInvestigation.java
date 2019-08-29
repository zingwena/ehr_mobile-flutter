package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class PersonInvestigation {
    @PrimaryKey(autoGenerate = true)
    private int personInvestigationId;

    @ColumnInfo(name = "patientId")
    private String patientId;

    @ColumnInfo(name = "investigationId")
    private String investigationId;

    @ColumnInfo(name = "date")
    private String date;

    @ColumnInfo(name = "resultId")
    private String resultId;

    public int getPersonInvestigationId() {
        return personInvestigationId;
    }

    public void setPersonInvestigationId(int personInvestigationId) {
        this.personInvestigationId = personInvestigationId;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getResultId() {
        return resultId;
    }

    public void setResultId(String resultId) {
        this.resultId = resultId;
    }
}
