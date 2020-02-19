package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.util.Date;

public class LaboratoryInvestigationDTO {

    private int facilityId;
    private Date resultDate;

    public LaboratoryInvestigationDTO(int facilityId, PastDate resultDate) {
        this.facilityId = facilityId;
        this.resultDate = resultDate != null ? resultDate.getPastDate() : null;
    }

    public int getFacilityId() {
        return facilityId;
    }

    public void setFacilityId(int facilityId) {
        this.facilityId = facilityId;
    }


    public Date getResultDate() {
        return resultDate;
    }

    public void setResultDate(PastDate resultDate) {
        this.resultDate = resultDate != null ? resultDate.getPastDate() : null;
    }

    @Override
    public String toString() {
        return "LaboratoryInvestigationDTO{" +
                "facilityId=" + facilityId +
                ", resultDate=" + resultDate +
                '}';
    }
}
