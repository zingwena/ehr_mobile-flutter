package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.model.HtsApproach;
import zw.gov.mohcc.mrs.ehr_mobile.model.NewTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.TestForPregnantLactatingMother;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;

public class PreTestDTO {

    public String hts_id;
    public String htsApproach;
    public boolean newTest;
    @TypeConverters(GenderConverter.class)
    public boolean newTestPregLact;

    boolean coupleCounselling;
    boolean optOutOfTest;
    boolean preTestInfoGiven;
    String HtsModel_id;
    String purpose_of_test_id;

    public PreTestDTO(String hts_id, String htsApproach,
                      boolean newTest, boolean newTestPregLact,
                      boolean coupleCounselling, boolean optOutOfTest,
                      boolean preTestInfoGiven, String htsModel_id,
                      String purpose_of_test_id) {
        this.hts_id = hts_id;
        this.htsApproach = htsApproach;
        this.newTest = newTest;
        this.newTestPregLact = newTestPregLact;
        this.coupleCounselling = coupleCounselling;
        this.optOutOfTest = optOutOfTest;
        this.preTestInfoGiven = preTestInfoGiven;
        HtsModel_id = htsModel_id;
        this.purpose_of_test_id = purpose_of_test_id;
    }

    public String getHtsApproach() {
        return htsApproach;
    }

    public void setHtsApproach(String htsApproach) {
        this.htsApproach = htsApproach;
    }

    public boolean getNewTest() {
        return newTest;
    }

    public void setNewTest(boolean newTest) {
        this.newTest = newTest;
    }

    public boolean getNewTestPregLact() {
        return newTestPregLact;
    }

    public void setNewTestPregLact(boolean newTestPregLact) {
        this.newTestPregLact = newTestPregLact;
    }

    public boolean getCoupleCounselling() {
        return coupleCounselling;
    }

    public void setCoupleCounselling(boolean coupleCounselling) {
        this.coupleCounselling = coupleCounselling;
    }

    public boolean getOptOutOfTest() {
        return optOutOfTest;
    }

    public void setOptOutOfTest(boolean optOutOfTest) {
        this.optOutOfTest = optOutOfTest;
    }

    public boolean getPreTestInfoGiven() {
        return preTestInfoGiven;
    }

    public void setPreTestInfoGiven(boolean preTestInfoGiven) {
        this.preTestInfoGiven = preTestInfoGiven;
    }

    public String getHtsModel_id() {
        return HtsModel_id;
    }

    public void setHtsModel_id(String htsModel_id) {
        HtsModel_id = htsModel_id;
    }

    public String getPurpose_of_test_id() {
        return purpose_of_test_id;
    }

    public void setPurpose_of_test_id(String purpose_of_test_id) {
        this.purpose_of_test_id = purpose_of_test_id;
    }

    public String getHts_id() {
        return hts_id;
    }

    public void setHts_id(String hts_id) {
        this.hts_id = hts_id;
    }

    public boolean isNewTest() {
        return newTest;
    }

    public boolean isNewTestPregLact() {
        return newTestPregLact;
    }
}
