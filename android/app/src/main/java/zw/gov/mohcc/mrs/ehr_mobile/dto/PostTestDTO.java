package zw.gov.mohcc.mrs.ehr_mobile.dto;

import android.util.Log;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;

public class PostTestDTO {

    private final String TAG = "Purpose of test DTO";
    private String htsId;
    private Date datePostTestCounselled;
    private boolean resultReceived;
    private String reasonForNotIssuingResultId;
    private boolean consentToIndexTesting;
    private boolean postTestCounselled;

    public PostTestDTO() {
    }

    public PostTestDTO(String htsId, PastDate datePostTestCounselled, boolean resultReceived, String reasonForNotIssuingResultId, boolean consentToIndexTesting, boolean postTestCounselled) {
        this.htsId = htsId;
        this.datePostTestCounselled = datePostTestCounselled;
        this.resultReceived = resultReceived;
        this.reasonForNotIssuingResultId = reasonForNotIssuingResultId;
        this.consentToIndexTesting = consentToIndexTesting;
        this.postTestCounselled = postTestCounselled;
    }

    public String getHtsId() {
        return htsId;
    }

    public void setHtsId(String htsId) {
        this.htsId = htsId;
    }

    public Date getDatePostTestCounselled() {
        return datePostTestCounselled;
    }

    public void setDatePostTestCounselled(PastDate datePostTestCounselled) {
        this.datePostTestCounselled = datePostTestCounselled;
    }

    public boolean isResultReceived() {
        return resultReceived;
    }

    public void setResultReceived(boolean resultReceived) {
        this.resultReceived = resultReceived;
    }

    public String getReasonForNotIssuingResultId() {
        return reasonForNotIssuingResultId;
    }

    public void setReasonForNotIssuingResultId(String reasonForNotIssuingResultId) {
        this.reasonForNotIssuingResultId = reasonForNotIssuingResultId;
    }

    public boolean isConsentToIndexTesting() {
        return consentToIndexTesting;
    }

    public void setConsentToIndexTesting(boolean consentToIndexTesting) {
        this.consentToIndexTesting = consentToIndexTesting;
    }

    public boolean isPostTestCounselled() {
        return postTestCounselled;
    }

    public void setPostTestCounselled(boolean postTestCounselled) {
        this.postTestCounselled = postTestCounselled;
    }

    public Hts getInstance(PostTestDTO dto, Hts hts) {

        Log.d(TAG, "State of PostTest DTO : " + dto);

        hts.setDatePostTestCounselled(dto.getDatePostTestCounselled());
        hts.setResultReceived(dto.isResultReceived());
        hts.setReasonForNotIssuingResultId(dto.getReasonForNotIssuingResultId());
        hts.setConsentToIndexTesting(dto.isConsentToIndexTesting());
        hts.setDatePostTestCounselled(dto.getDatePostTestCounselled());
        Log.d(TAG, "State of HTS after updating posttest fields : " + hts);
        return hts;
    }


}
