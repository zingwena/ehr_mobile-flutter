package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class PurposeOfTest extends BaseNameModel {

    public PurposeOfTest() {
    }

    @Ignore
    public PurposeOfTest(String code, String name) {
        super(code, name);
    }
}
