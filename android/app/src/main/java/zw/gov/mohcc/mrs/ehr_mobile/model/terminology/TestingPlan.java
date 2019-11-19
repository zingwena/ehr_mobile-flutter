package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class TestingPlan extends NameIdModel {

    public TestingPlan() {
    }

    @Ignore
    public TestingPlan(String id, String name) {
        super(id, name);
    }
}
