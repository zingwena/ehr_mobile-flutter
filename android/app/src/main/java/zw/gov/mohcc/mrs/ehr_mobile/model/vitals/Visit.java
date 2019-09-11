package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class Visit {

    @PrimaryKey
    private String visitId;
    private String personId;
    @TypeConverters(DateConverter.class)
    private Date visitDate;

    public Visit() {
    }

    @Ignore
    public Visit(String visitId, String personId, Date visitDate) {
        this.visitId = visitId;
        this.personId = personId;
        this.visitDate = visitDate;
    }

    @Ignore
    public Visit(String personId) {
        this.personId = personId;
    }

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public Date getVisitDate() {
        return visitDate;
    }

    public void setVisitDate(Date visitDate) {
        this.visitDate = visitDate;
    }
}
