package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.time.LocalDate;
import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PostTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PreTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.util.DataConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;

@Entity
public class Hts {

    @PrimaryKey(autoGenerate = true)
    private int id;

    //Hts registration fields
    @TypeConverters(GenderConverter.class)
    public HtsType htsType;
    @TypeConverters(DateConverter.class)

    Date patientDate;
    //Hts registration fields


    //Pre-test fields
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_htsApproach")
    public HtsApproach htsApproach;
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_newtest")
    public NewTest newTest;
    /* @TypeConverters(GenderConverter.class)
     @ColumnInfo(name="pretest_counselling")
     public CoupleCounselling coupleCounselling;*/
    /*@TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_testinfo")
    public PreTestInfoGiven preTestInfoGiven;*/
    /*@TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_optout")
    public OptOutOfTest optOutOfTest;*/
    @TypeConverters(GenderConverter.class)
    @ColumnInfo(name="pretest_pregLact")
    public NewTestPregLact newTestPregLact;
    String coupleCounselling;
    String optOutOfTest;
    String preTestInfoGiven;
    String HtsModel_id;
    String  purpose_of_test_id;
    //Pre-test fields

    //Post test fields
    @TypeConverters(DataConverter.class)
    private LocalDate dateOfPostTestCounsel;
    private String resultReceived;
    private String finalResult;
    private String postTestCounselled;
    private String ReasonForNotIssuingResult_id;
    //Post test fields


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public HtsType getHtsType() {
        return htsType;
    }

    public void setHtsType(HtsType htsType) {
        this.htsType = htsType;
    }

    public Date getPatientDate() {
        return patientDate;
    }

    public void setPatientDate(Date patientDate) {
        this.patientDate = patientDate;
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

    public LocalDate getDateOfPostTestCounsel() {
        return dateOfPostTestCounsel;
    }

    public void setDateOfPostTestCounsel(LocalDate dateOfPostTestCounsel) {
        this.dateOfPostTestCounsel = dateOfPostTestCounsel;
    }

    public String getResultReceived() {
        return resultReceived;
    }

    public void setResultReceived(String resultReceived) {
        this.resultReceived = resultReceived;
    }

    public String getFinalResult() {
        return finalResult;
    }

    public void setFinalResult(String finalResult) {
        this.finalResult = finalResult;
    }

    public String getPostTestCounselled() {
        return postTestCounselled;
    }

    public void setPostTestCounselled(String postTestCounselled) {
        this.postTestCounselled = postTestCounselled;
    }

    public String getReasonForNotIssuingResult_id() {
        return ReasonForNotIssuingResult_id;
    }

    public void setReasonForNotIssuingResult_id(String reasonForNotIssuingResult_id) {
        ReasonForNotIssuingResult_id = reasonForNotIssuingResult_id;
    }

    public static Hts getHtsRegInstance (HtsRegDTO htsRegDTO) {
        Hts hts = htsRegDTO.getHts();
        hts.setHtsType(htsRegDTO.getHtsType());
        hts.setPatientDate(htsRegDTO.getRegistrationDate());

        return hts;
    }

    public static Hts getPreTestCounsellingInstance(PreTestDTO preTestDTO){
        Hts hts = preTestDTO.getHts();

        hts.setHtsApproach(preTestDTO.getHtsApproach());
        hts.setNewTest(preTestDTO.getNewTest());
        hts.setNewTestPregLact(preTestDTO.getNewTestPregLact());
        hts.setCoupleCounselling(preTestDTO.getCoupleCounselling());
        hts.setOptOutOfTest(preTestDTO.getOptOutOfTest());
        hts.setPreTestInfoGiven(preTestDTO.getPreTestInfoGiven());
        hts.setHtsModel_id(preTestDTO.getHtsModel_id());
        hts.setPurpose_of_test_id(preTestDTO.getPurpose_of_test_id());

        return hts;
    }

    public static Hts getPostTestCounsellingInstance(PostTestDTO postTestDTO){

        Hts hts = postTestDTO.getHts();

        hts.setDateOfPostTestCounsel(postTestDTO.getDateOfPostTestCounsel());
        hts.setResultReceived(postTestDTO.getResultReceived());
        hts.setFinalResult(postTestDTO.getFinalResult());
        hts.setPostTestCounselled(postTestDTO.getPostTestCounselled());
        hts.setReasonForNotIssuingResult_id(postTestDTO.getReasonForNotIssuingResult_id());

        return hts;
    }


}
