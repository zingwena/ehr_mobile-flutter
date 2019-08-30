package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;


@Entity
public class PostTest {
    @PrimaryKey(autoGenerate = true)
    private int id;

    @TypeConverters(DateConverter.class)
    private Date dateOfPostTestCounsel;

    private String resultReceived;

    private String finalResult;

    private String postTestCounselled;


    private String ReasonForNotIssuingResult_id;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getPostTestCounselled() {
        return postTestCounselled;
    }

    public void setPostTestCounselled(String postTestCounselled) {
        this.postTestCounselled = postTestCounselled;
    }

    public String getFinalResult() {
        return finalResult;
    }

    public void setFinalResult(String finalResult) {
        this.finalResult = finalResult;
    }

    public String getReasonForNotIssuingResult_id() {
        return ReasonForNotIssuingResult_id;
    }

    public void setReasonForNotIssuingResult_id(String reasonForNotIssuingResult_id) {
        ReasonForNotIssuingResult_id = reasonForNotIssuingResult_id;
    }
}


