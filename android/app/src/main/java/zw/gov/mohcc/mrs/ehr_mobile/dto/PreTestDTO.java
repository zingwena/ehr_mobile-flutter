package zw.gov.mohcc.mrs.ehr_mobile.dto;

import android.util.Log;

import androidx.annotation.NonNull;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.GenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;

public class PreTestDTO {

    private final String TAG = "Purpose of test DTO";
    @NonNull
    private String htsId;
    @NonNull
    private String htsApproach;
    private boolean newTest;
    @TypeConverters(GenderConverter.class)
    private Boolean newTestPregLact;
    private boolean coupleCounselling;
    private boolean optOutOfTest;
    private boolean preTestInformationGiven;
    @NonNull
    private String htsModelId;
    @NonNull
    private String reasonForHivTestingId;

    public PreTestDTO() {
    }

    public PreTestDTO(String htsId, String htsApproach, boolean newTest, Boolean newTestPregLact, boolean coupleCounselling, boolean optOutOfTest, boolean preTestInformationGiven, String htsModelId, String reasonForHivTestingId) {
        this.htsId = htsId;
        this.htsApproach = htsApproach;
        this.newTest = newTest;
        this.newTestPregLact = newTestPregLact;
        this.coupleCounselling = coupleCounselling;
        this.optOutOfTest = optOutOfTest;
        this.preTestInformationGiven = preTestInformationGiven;
        this.htsModelId = htsModelId;
        this.reasonForHivTestingId = reasonForHivTestingId;
    }

    @NonNull
    public String getHtsId() {
        return htsId;
    }

    public void setHtsId(@NonNull String htsId) {
        this.htsId = htsId;
    }

    @NonNull
    public String getHtsApproach() {
        return htsApproach;
    }

    public void setHtsApproach(@NonNull String htsApproach) {
        this.htsApproach = htsApproach;
    }

    public boolean isNewTest() {
        return newTest;
    }

    public void setNewTest(boolean newTest) {
        this.newTest = newTest;
    }

    public Boolean getNewTestPregLact() {
        return newTestPregLact;
    }

    public void setNewTestPregLact(Boolean newTestPregLact) {
        this.newTestPregLact = newTestPregLact;
    }

    public boolean isCoupleCounselling() {
        return coupleCounselling;
    }

    public void setCoupleCounselling(boolean coupleCounselling) {
        this.coupleCounselling = coupleCounselling;
    }

    public boolean isOptOutOfTest() {
        return optOutOfTest;
    }

    public void setOptOutOfTest(boolean optOutOfTest) {
        this.optOutOfTest = optOutOfTest;
    }

    public boolean isPreTestInformationGiven() {
        return preTestInformationGiven;
    }

    public void setPreTestInformationGiven(boolean preTestInformationGiven) {
        this.preTestInformationGiven = preTestInformationGiven;
    }

    @NonNull
    public String getHtsModelId() {
        return htsModelId;
    }

    public void setHtsModelId(@NonNull String htsModelId) {
        this.htsModelId = htsModelId;
    }

    @NonNull
    public String getReasonForHivTestingId() {
        return reasonForHivTestingId;
    }

    public void setReasonForHivTestingId(@NonNull String reasonForHivTestingId) {
        this.reasonForHivTestingId = reasonForHivTestingId;
    }

    public Hts getInstance(PreTestDTO dto, Hts hts) {

        Log.d(TAG, "State of PreTest DTO : " + dto);
        hts.setHtsApproach(dto.getHtsApproach());
        hts.setNewTestInClientLife(dto.isNewTest());
        hts.setNewTestPregLact(dto.getNewTestPregLact());
        hts.setCoupleCounselling(dto.isCoupleCounselling());
        hts.setOptOutOfTest(dto.isOptOutOfTest());
        hts.setPreTestInformationGiven(dto.isPreTestInformationGiven());
        hts.setHtsModelId(dto.getHtsModelId());
        hts.setReasonForHivTestingId(dto.getReasonForHivTestingId());

        Log.d(TAG, "State of HTS after updating pretest fields : " + hts);
        return hts;
    }

    @Override
    public String toString() {
        return "PreTestDTO{" +
                "htsId='" + htsId + '\'' +
                ", htsApproach='" + htsApproach + '\'' +
                ", newTest=" + newTest +
                ", newTestPregLact=" + newTestPregLact +
                ", coupleCounselling=" + coupleCounselling +
                ", optOutOfTest=" + optOutOfTest +
                ", preTestInformationGiven=" + preTestInformationGiven +
                ", htsModelId='" + htsModelId + '\'' +
                ", reasonForHivTestingId='" + reasonForHivTestingId + '\'' +
                '}';
    }
}
