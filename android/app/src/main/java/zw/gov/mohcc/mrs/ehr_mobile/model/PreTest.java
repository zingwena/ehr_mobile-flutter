package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;
@Entity
public class PreTest {
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name="pretest_id")
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
    @Embedded
    private HtsModel htsModel;
    @Embedded
    private Purpose_Of_Tests purpose_of_tests;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public HtsModel getHtsModel() {
        return htsModel;
    }

    public void setHtsModel(HtsModel htsModel) {
        this.htsModel = htsModel;
    }
    public Purpose_Of_Tests getPurpose_of_tests() {
        return purpose_of_tests;
    }

    public void setPurpose_of_tests(Purpose_Of_Tests purpose_of_tests) {
        this.purpose_of_tests = purpose_of_tests;
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
}
