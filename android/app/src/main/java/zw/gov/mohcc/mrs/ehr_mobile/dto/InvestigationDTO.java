package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.util.Date;

public class InvestigationDTO {

    private String personId;
    private Date dateOfTest;
    private String visitId;
    private String investigationId;
    private String result;

    public InvestigationDTO(String personId, PastDate dateOfTest, String visitId, String investigationId, String result) {
        this.personId = personId;
        this.dateOfTest = dateOfTest;
        this.visitId = visitId;
        this.investigationId = investigationId;
        this.result = result;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public Date getDateOfTest() {
        return dateOfTest;
    }

    public void setDateOfTest(PastDate dateOfTest) {
        this.dateOfTest = dateOfTest;
    }

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return "InvestigationDTO{" +
                "personId='" + personId + '\'' +
                ", dateOfTest=" + dateOfTest +
                ", visitId='" + visitId + '\'' +
                ", investigationId='" + investigationId + '\'' +
                ", result='" + result + '\'' +
                '}';
    }
}
