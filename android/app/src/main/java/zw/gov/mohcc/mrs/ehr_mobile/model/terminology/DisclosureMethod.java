package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

@Entity(indices = {@Index(value = "id", unique = true)})
public class DisclosureMethod extends NameIdModel {

    public DisclosureMethod() {
    }

    @Ignore
    public DisclosureMethod(String id, String name) {
        super(id, name);
    }
}
