package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

@Entity(indices = {@Index(value = "code", unique = true)})
public class Nationality extends BaseNameModel {

    public Nationality() {
    }

    @Ignore
    public Nationality(String code, String name) {
        super(code, name);
    }
}
