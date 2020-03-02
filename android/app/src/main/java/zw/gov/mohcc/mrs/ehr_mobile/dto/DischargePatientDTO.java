package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.io.Serializable;
import java.util.Date;

public class DischargePatientDTO implements Serializable {

    @NonNull
    private String visitId;
    @NonNull
    private Date dischargeDate;

    @NonNull
    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(@NonNull String visitId) {
        this.visitId = visitId;
    }

    @NonNull
    public Date getDischargeDate() {
        return dischargeDate;
    }

    public void setDischargeDate(@NonNull Date dischargeDate) {
        this.dischargeDate = dischargeDate;
    }
}
