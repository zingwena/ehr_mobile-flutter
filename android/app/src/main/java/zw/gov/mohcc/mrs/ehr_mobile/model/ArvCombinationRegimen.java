package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class ArvCombinationRegimen extends BaseNameModel {

    public ArvCombinationRegimen() {
    }

    @Ignore
    public ArvCombinationRegimen(String code, String name) {
        super(code, name);
    }
}
