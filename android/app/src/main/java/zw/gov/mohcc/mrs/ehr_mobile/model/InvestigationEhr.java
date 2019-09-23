package zw.gov.mohcc.mrs.ehr_mobile.model;


public class InvestigationEhr {

    private String investigationId;
    private String sampleId;
    private String laboratoryTestId;

    public InvestigationEhr(String investigationId, String sampleId, String laboratoryTestId) {
        this.investigationId = investigationId;
        this.sampleId = sampleId;
        this.laboratoryTestId = laboratoryTestId;
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }

    public String getSampleId() {
        return sampleId;
    }

    public void setSampleId(String sampleId) {
        this.sampleId = sampleId;
    }

    public String getLaboratoryTestId() {
        return laboratoryTestId;
    }

    public void setLaboratoryTestId(String laboratoryTestId) {
        this.laboratoryTestId = laboratoryTestId;
    }
}
