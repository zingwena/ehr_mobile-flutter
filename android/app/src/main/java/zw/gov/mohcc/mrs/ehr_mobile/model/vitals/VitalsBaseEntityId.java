package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

public class VitalsBaseEntityId extends BaseEntity {

    private String visitId;
    private  transient String personId;
    @TypeConverters(DateConverter.class)
    private Date dateTime = new Date();


    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    @Override
    public String toString() {
        return super.toString() + "VitalsBaseEntityId{" +
                ", visitId=" + visitId +
                ", dateTime=" + dateTime +
                '}';
    }
}
