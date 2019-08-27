package zw.gov.mohcc.mrs.ehr_mobile.model;

<<<<<<< HEAD
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
=======
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
>>>>>>> 682202a232190cb7c558de39fce3cfa5e2122e46
    }

    public String getSample() {
        return sample;
    }

    public void setSample(String sample) {
        this.sample = sample;
    }

<<<<<<< HEAD
    public String getLabTest() {
        return labTest;
    }

    public void setLabTest(String labTest) {
        this.labTest = labTest;
=======
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
>>>>>>> 682202a232190cb7c558de39fce3cfa5e2122e46
    }
}
