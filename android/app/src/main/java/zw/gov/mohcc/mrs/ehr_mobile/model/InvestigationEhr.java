package zw.gov.mohcc.mrs.ehr_mobile.model;


public class InvestigationEhr {

    String investigationId;
    String sample;
    String test;

    public InvestigationEhr(String investigationId, String sample, String test) {
        this.investigationId = investigationId;
        this.sample = sample;
        this.test = test;
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


    public String getTest() {
        return test;
    }

    public void setTest(String test) {
        this.test = test;
    }
}
