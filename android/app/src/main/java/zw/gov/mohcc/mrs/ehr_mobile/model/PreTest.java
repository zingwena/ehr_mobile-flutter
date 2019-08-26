package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Index;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;
@Entity
public class PreTest {
    @PrimaryKey(autoGenerate = true)
    /*@ColumnInfo(name="pretest_id")*/
    private int id;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_htsApproach")
    public HtsApproach htsApproach;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_newtest")
    public NewTest newTest;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_counselling")
    public CoupleCounselling coupleCounselling;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_testinfo")
    public PreTestInfoGiven preTestInfoGiven;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_optout")
    public OptOutOfTest optOutOfTest;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_pregLact")
    public NewTestPregLact newTestPregLact;

    String HtsModel_id;

    String  purpose_of_test_id;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
    public PreTestInfoGiven getPreTestInfoGiven() {
        return preTestInfoGiven;
    }

    public void setPreTestInfoGiven(PreTestInfoGiven preTestInfoGiven) {
        this.preTestInfoGiven = preTestInfoGiven;
    }
    public OptOutOfTest getOptOutOfTest() {
        return optOutOfTest;
    }

    public void setOptOutOfTest(OptOutOfTest optOutOfTest) {
        this.optOutOfTest = optOutOfTest;
    }
    public CoupleCounselling getCoupleCounselling() {
        return coupleCounselling;
    }

    public void setCoupleCounselling(CoupleCounselling coupleCounselling) {
        this.coupleCounselling = coupleCounselling;
    }

    public HtsApproach getHtsApproach() {
        return htsApproach;
    }

    public void setHtsApproach(HtsApproach htsApproach) {
        this.htsApproach = htsApproach;
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
