package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.util.Date;

public class LaboratoryInvestigationDTO {

    private int facilityId;
    private Date resultDate;

    public LaboratoryInvestigationDTO(int facilityId, Date resultDate) {
        this.facilityId = facilityId;
        this.resultDate = resultDate;
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

    public void setResultDate(Date resultDate) {
        this.resultDate = resultDate;
    }

    @Override
    public String toString() {
        return "LaboratoryInvestigationDTO{" +
                "facilityId=" + facilityId +
                ", resultDate=" + resultDate +
                '}';
    }
}
