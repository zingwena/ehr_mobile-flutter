package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.Ignore;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity
public class ArtVisitType extends BaseNameModel {

    public ArtVisitType() {
    }

    @Ignore
    public ArtVisitType(String code, String name) {
        super(code, name);
    }
}
