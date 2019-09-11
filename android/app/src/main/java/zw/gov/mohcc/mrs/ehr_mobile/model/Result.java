package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;

@Entity
public class Result extends BaseNameModel {

    public Result() {

    }

    public Result(String code, String name) {
        super(code, name);
    }
}
