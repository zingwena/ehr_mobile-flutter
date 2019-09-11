package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.model.HtsApproach;
import zw.gov.mohcc.mrs.ehr_mobile.model.NewTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.TestForPregnantLactatingMother;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;

public class PreTestDTO {

    @TypeConverters(GenderConverter.class)
    public HtsApproach htsApproach;
    @TypeConverters(GenderConverter.class)
    public NewTest newTest;
    @TypeConverters(GenderConverter.class)
    public TestForPregnantLactatingMother newTestPregLact;

    String coupleCounselling;
    String optOutOfTest;
    String preTestInfoGiven;
    String HtsModel_id;
    String purpose_of_test_id;

    public PreTestDTO(HtsApproach htsApproach,
                      NewTest newTest, TestForPregnantLactatingMother newTestPregLact,
                      String coupleCounselling, String optOutOfTest,
                      String preTestInfoGiven, String htsModel_id,
                      String purpose_of_test_id) {
        this.htsApproach = htsApproach;
        this.newTest = newTest;
        this.newTestPregLact = newTestPregLact;
        this.coupleCounselling = coupleCounselling;
        this.optOutOfTest = optOutOfTest;
        this.preTestInfoGiven = preTestInfoGiven;
        HtsModel_id = htsModel_id;
        this.purpose_of_test_id = purpose_of_test_id;
    }

    public HtsApproach getHtsApproach() {
        return htsApproach;
    }

    public void setHtsApproach(HtsApproach htsApproach) {
        this.htsApproach = htsApproach;
    }

    public NewTest getNewTest() {
        return newTest;
    }

    public void setNewTest(NewTest newTest) {
        this.newTest = newTest;
    }

    public TestForPregnantLactatingMother getNewTestPregLact() {
        return newTestPregLact;
    }

    public void setNewTestPregLact(TestForPregnantLactatingMother newTestPregLact) {
        this.newTestPregLact = newTestPregLact;
    }

    public String getCoupleCounselling() {
        return coupleCounselling;
    }

    public void setCoupleCounselling(String coupleCounselling) {
        this.coupleCounselling = coupleCounselling;
    }

    public String getOptOutOfTest() {
        return optOutOfTest;
    }

    public void setOptOutOfTest(String optOutOfTest) {
        this.optOutOfTest = optOutOfTest;
    }

    public String getPreTestInfoGiven() {
        return preTestInfoGiven;
    }

    public void setPreTestInfoGiven(String preTestInfoGiven) {
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
}
