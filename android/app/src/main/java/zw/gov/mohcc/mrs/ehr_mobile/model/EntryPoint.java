package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class EntryPoint extends BaseNameModel {

    public EntryPoint() {
    }

    @Ignore
    public EntryPoint(String code, String name) {
        super(code, name);
    }
}
