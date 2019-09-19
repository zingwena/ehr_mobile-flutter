package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class PersonInvestigation extends BaseEntity {

    @ColumnInfo(name = "personId")
    private String personId;
    @ColumnInfo(name = "investigationId")
    private String investigationId;
    @ColumnInfo(name = "date")
    @TypeConverters(DateConverter.class)
    private Date date;
    @ColumnInfo(name = "resultId")
    private String resultId;

    public PersonInvestigation() {
    }

    @Ignore
    public PersonInvestigation(@NonNull String id, String personId, String investigationId, Date date) {
        super(id);
        this.personId = personId;
        this.investigationId = investigationId;
        this.date = date;
    }

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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
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
        return super.toString().concat("PersonInvestigation{" +
                "personInvestigationId=" + getId() +
                ", patientId='" + personId + '\'' +
                ", investigationId='" + investigationId + '\'' +
                ", date='" + date + '\'' +
                ", resultId='" + resultId + '\'' +
                '}');
    }
}
