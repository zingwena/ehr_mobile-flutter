package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.ColumnInfo;
import androidx.room.Entity;

@Entity
public class PersonInvestigation extends BaseEntity {

    @ColumnInfo(name = "personId")
    private String personId;
    @ColumnInfo(name = "investigationId")
    private String investigationId;
    @ColumnInfo(name = "date")
    private String date;
    @ColumnInfo(name = "resultId")
    private String resultId;

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
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

    @Override
    public String toString() {
        return "PersonInvestigation{" +
                "personInvestigationId=" + getId() +
                ", patientId='" + personId + '\'' +
                ", investigationId='" + investigationId + '\'' +
                ", date='" + date + '\'' +
                ", resultId='" + resultId + '\'' +
                '}';
    }
}
