package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;


public class InvestigationTestkitEhr {

    private String investigationTestkitId;
    private String investigationId;
    private String testKitId;

    public InvestigationTestkitEhr(String investigationTestkitId, String investigationId, String testKitId) {
        this.investigationTestkitId = investigationTestkitId;
        this.investigationId = investigationId;
        this.testKitId = testKitId;
    }

    public String getInvestigationTestkitId() {
        return investigationTestkitId;
    }

    public void setInvestigationTestkitId(String investigationTestkitId) {
        this.investigationTestkitId = investigationTestkitId;
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }

    public String getTestKitId() {
        return testKitId;
    }

    public void setTestKitId(String testKitId) {
        this.testKitId = testKitId;
    }
}
