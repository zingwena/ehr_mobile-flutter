package zw.gov.mohcc.mrs.ehr_mobile.model;

/**
 * @author kombo on 8/27/19
 */
public class InvestigationEhr {
    private String investigationId;
    private String sample;
    private String labTest;

    public InvestigationEhr(String investigationId, String sample, String labTest) {
        this.investigationId = investigationId;
        this.sample = sample;
        this.labTest = labTest;
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }

    public String getSample() {
        return sample;
    }

    public void setSample(String sample) {
        this.sample = sample;
    }

    public String getLabTest() {
        return labTest;
    }

    public void setLabTest(String labTest) {
        this.labTest = labTest;
    }
}
