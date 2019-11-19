package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.PrimaryKey;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity(indices = {@Index(value = "code", unique = true)})
public class LaboratoryTest extends BaseNameModel {

    public LaboratoryTest() {
    }

    @Ignore
    public LaboratoryTest(String code, String name) {
        super(code, name);
    }
}

