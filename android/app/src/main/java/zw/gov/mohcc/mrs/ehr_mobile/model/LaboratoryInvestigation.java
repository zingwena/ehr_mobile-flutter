package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;


@Entity
public class LaboratoryInvestigation extends BaseEntity {

    @NonNull
    private String facilityId;
    @NonNull
    private String personInvestigationId;
    @TypeConverters(DateConverter.class)
    private Date resultDate;

    public LaboratoryInvestigation() {
    }

    @Ignore
    public LaboratoryInvestigation(@NonNull String id, String facilityId, String personInvestigationId) {
        super(id);
        this.facilityId = facilityId;
        this.personInvestigationId = personInvestigationId;
    }

    public String getFacilityId() {
        return facilityId;
    }

    public void setFacilityId(String facilityId) {
        this.facilityId = facilityId;
    }

    public String getPersonInvestigationId() {
        return personInvestigationId;
    }

    public void setPersonInvestigationId(String personInvestigationId) {
        this.personInvestigationId = personInvestigationId;
    }

    public Date getResultDate() {
        return resultDate;
    }

    public void setResultDate(Date resultDate) {
        this.resultDate = resultDate;
    }

    @Override
    public String toString() {
        return "LaboratoryInvestigation{" +
                "id='" + getId() + '\'' +
                "facilityId='" + facilityId + '\'' +
                ", personInvestigationId='" + personInvestigationId + '\'' +
                ", resultDate=" + resultDate +
                '}';
    }
}
