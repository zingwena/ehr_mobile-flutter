package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class ArtStatus extends BaseNameModel {

    public ArtStatus() {
    }

    @Ignore
    public ArtStatus(String code, String name) {
        super(code, name);
    }
}
