package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class Result extends BaseNameModel {

    public Result() {

    }

    @Ignore
    public Result(String code, String name) {
        super(code, name);
    }
}
