package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

@Entity
public class LaboratoryInvestigation {

    private int id;


    private int facilityId;

    private String personInvestigationId;

    @TypeConverters(Date.class)
    private Date resultDate;

    public LaboratoryInvestigation(int id, int facilityId, String personInvestigationId, Date resultDate) {
        this.id = id;
        this.facilityId = facilityId;
        this.personInvestigationId = personInvestigationId;
        this.resultDate = resultDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFacilityId() {
        return facilityId;
    }

    public void setFacilityId(int facilityId) {
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
}
