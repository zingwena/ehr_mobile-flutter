package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;


import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity(indices = {@Index(value = "code", unique = true)})
public class PurposeOfTest extends BaseNameModel {

    public PurposeOfTest() {
    }

    @Ignore
    public PurposeOfTest(String code, String name) {
        super(code, name);
    }
}
