package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Embedded;
import androidx.room.Entity;

import org.stringtemplate.v4.ST;

import java.time.LocalDate;

@Entity
public class LaboratoryInvestigation {

    private int id;

    @Embedded
    private int facilityId;

    private String personInvestigationId;

    private LocalDate resultDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BaseNameModel getFacilityId() {
        return facilityId;
    }

    public void setFacilityId(BaseNameModel facilityId) {
        this.facilityId = facilityId;
    }

    public String getPersonInvestigationId() {
        return personInvestigationId;
    }

    public void setPersonInvestigationId(String personInvestigationId) {
        this.personInvestigationId = personInvestigationId;
    }

    public LocalDate getResultDate() {
        return resultDate;
    }

    public void setResultDate(LocalDate resultDate) {
        this.resultDate = resultDate;
    }
}
