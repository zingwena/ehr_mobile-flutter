package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;


import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity(indices = {@Index(value = "code", unique = true)})
public class Occupation extends BaseNameModel {

    public Occupation() {
    }

    @Ignore
    public Occupation(String code, String name) {
        super(code, name);
    }
}
