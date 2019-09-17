package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class ReasonForNotIssuingResult extends BaseNameModel {

    public ReasonForNotIssuingResult() {
    }

    @Ignore
    public ReasonForNotIssuingResult(String code, String name) {
        super(code, name);
    }
}
