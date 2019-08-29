package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.ColumnInfo;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsApproach;
import zw.gov.mohcc.mrs.ehr_mobile.model.NewTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.NewTestPregLact;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;

public class PreTestDTO {

    private int id;
    Hts hts;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_htsApproach")
    public HtsApproach htsApproach;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_newtest")
    public NewTest newTest;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_pregLact")
    public NewTestPregLact newTestPregLact;

    String coupleCounselling;
    String optOutOfTest;
    String preTestInfoGiven;
    String HtsModel_id;
    String  purpose_of_test_id;

    public PreTestDTO(int id, Hts hts, HtsApproach htsApproach,
                      NewTest newTest, NewTestPregLact newTestPregLact,
                      String coupleCounselling, String optOutOfTest,
                      String preTestInfoGiven, String htsModel_id,
                      String purpose_of_test_id)
    {
        this.id = id;
        this.hts = hts;
        this.htsApproach = htsApproach;
        this.newTest = newTest;
        this.newTestPregLact = newTestPregLact;
        this.coupleCounselling = coupleCounselling;
        this.optOutOfTest = optOutOfTest;
        this.preTestInfoGiven = preTestInfoGiven;
        HtsModel_id = htsModel_id;
        this.purpose_of_test_id = purpose_of_test_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Hts getHts() {
        return hts;
    }

    public void setHts(Hts hts) {
        this.hts = hts;
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

    public NewTestPregLact getNewTestPregLact() {
        return newTestPregLact;
    }

    public void setNewTestPregLact(NewTestPregLact newTestPregLact) {
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
