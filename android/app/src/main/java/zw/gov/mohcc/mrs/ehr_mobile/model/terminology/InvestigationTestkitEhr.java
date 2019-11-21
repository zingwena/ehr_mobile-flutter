package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;


public class InvestigationTestkitEhr {

    private String investigationTestKitId;
    private String investigationId;
    private String testKitId;

    public InvestigationTestkitEhr(String investigationTestKitId, String investigationId, String testKitId) {
        this.investigationTestKitId = investigationTestKitId;
        this.investigationId = investigationId;
        this.testKitId = testKitId;
    }

    public String getInvestigationTestKitId() {
        return investigationTestKitId;
    }

    public void setInvestigationTestKitId(String investigationTestKitId) {
        this.investigationTestKitId = investigationTestKitId;
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

    @Override
    public String toString() {
        return "InvestigationTestkitEhr{" +
                "investigationTestKitId='" + investigationTestKitId + '\'' +
                ", investigationId='" + investigationId + '\'' +
                ", testKitId='" + testKitId + '\'' +
                '}';
    }
}
