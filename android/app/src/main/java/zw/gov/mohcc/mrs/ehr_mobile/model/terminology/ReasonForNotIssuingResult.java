package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.Ignore;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity
public class ReasonForNotIssuingResult extends BaseNameModel {

    public ReasonForNotIssuingResult() {
    }

    @Ignore
    public ReasonForNotIssuingResult(String code, String name) {
        super(code, name);
    }
}
