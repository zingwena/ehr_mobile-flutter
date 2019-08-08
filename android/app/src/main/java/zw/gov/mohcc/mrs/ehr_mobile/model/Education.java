package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Ignore;
import androidx.room.PrimaryKey;

public class Education extends BaseNameModel {

    @PrimaryKey(autoGenerate = true)
    private int id;

    public Education() {
    }

    @Ignore
    public Education(String code, String name) {
        super(code, name);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
