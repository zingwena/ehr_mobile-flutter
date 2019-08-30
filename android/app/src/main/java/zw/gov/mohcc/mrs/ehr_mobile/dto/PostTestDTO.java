package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

public class PostTestDTO {

    private int id;

    Hts hts;

    @TypeConverters(DateConverter.class)
    private Date dateOfPostTestCounsel;

    private String resultReceived;

    private String finalResult;

    private String postTestCounselled;

    private String ReasonForNotIssuingResult_id;

    public PostTestDTO(int id, Hts hts, Date dateOfPostTestCounsel, String resultReceived, String finalResult, String postTestCounselled, String reasonForNotIssuingResult_id) {
        this.id = id;
        this.hts = hts;
        this.dateOfPostTestCounsel = dateOfPostTestCounsel;
        this.resultReceived = resultReceived;
        this.finalResult = finalResult;
        this.postTestCounselled = postTestCounselled;
        ReasonForNotIssuingResult_id = reasonForNotIssuingResult_id;
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

    public Date getDateOfPostTestCounsel() {
        return dateOfPostTestCounsel;
    }

    public void setDateOfPostTestCounsel(Date dateOfPostTestCounsel) {
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

    @Override
    public String toString() {
        return "PostTestDTO{" +
                "id=" + id +
                ", hts=" + hts +
                ", dateOfPostTestCounsel=" + dateOfPostTestCounsel +
                ", resultReceived='" + resultReceived + '\'' +
                ", finalResult='" + finalResult + '\'' +
                ", postTestCounselled='" + postTestCounselled + '\'' +
                ", ReasonForNotIssuingResult_id='" + ReasonForNotIssuingResult_id + '\'' +
                '}';
    }
}
