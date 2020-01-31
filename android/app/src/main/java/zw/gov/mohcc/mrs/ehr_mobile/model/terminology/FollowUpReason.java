package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.Ignore;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity
public class FollowUpReason extends BaseNameModel {

    public FollowUpReason() {
    }

    @Ignore
    public FollowUpReason(String code, String name) {
        super(code, name);
    }
}
