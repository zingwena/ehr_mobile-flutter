package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;


import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class LaboratoryInvestigation {
    @PrimaryKey(autoGenerate = true)
    private int id;

    private int facilityId;

    private int personInvestigationId;
   @TypeConverters(DateConverter.class)
    private Date resultDate;

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

    public int getPersonInvestigationId() {
        return personInvestigationId;
    }

    public void setPersonInvestigationId(int personInvestigationId) {
        this.personInvestigationId = personInvestigationId;
    }

    public Date getResultDate() {
        return resultDate;
    }

    public void setResultDate(Date resultDate) {
        this.resultDate = resultDate;
    }
}
