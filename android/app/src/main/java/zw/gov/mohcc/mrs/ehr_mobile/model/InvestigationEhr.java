package zw.gov.mohcc.mrs.ehr_mobile.model;

public class InvestigationEhr {

    String InvestigationId;
    String sample;
    String test;

    public InvestigationEhr(String investigationId, String sample, String test) {
        InvestigationId = investigationId;
        this.sample = sample;
        this.test = test;
    }

    public String getInvestigationId() {
        return InvestigationId;
    }

    public void setInvestigationId(String investigationId) {
        InvestigationId = investigationId;
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

    @Override
    public String toString() {
        return "InvestigationEhr{" +
                "InvestigationId='" + InvestigationId + '\'' +
                ", sample='" + sample + '\'' +
                ", test='" + test + '\'' +
                '}';
    }
}
