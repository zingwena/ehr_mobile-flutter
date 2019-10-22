package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;

@Entity
public class Visit extends BaseEntity {

    private String personId;
    @TypeConverters(DateConverter.class)
    private Date visitStartDate = new Date();
    @TypeConverters(DateConverter.class)
    private Date visitEndDate = DateUtil.getEndOfDay(new Date());

    public Visit() {
    }

    @Ignore
    public Visit(@NonNull String id, String personId, Date visitStartDate, Date visitEndDate) {
        super(id);
        this.personId = personId;
        this.visitStartDate = visitStartDate;
        this.visitEndDate = visitEndDate;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public Date getVisitStartDate() {
        return visitStartDate;
    }

    public void setVisitStartDate(Date visitStartDate) {
        this.visitStartDate = visitStartDate;
    }

    public Date getVisitEndDate() {
        return visitEndDate;
    }

    public void setVisitEndDate(Date visitEndDate) {
        this.visitEndDate = visitEndDate;
    }

    @Override
    public String toString() {
        return super.toString().concat("Visit{" +
                "personId='" + personId + '\'' +
                ", visitStartDate=" + visitStartDate +
                ", visitEndDate=" + visitEndDate +
                '}');
    }
}
