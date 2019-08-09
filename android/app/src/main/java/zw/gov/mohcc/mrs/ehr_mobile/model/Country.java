package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity
public class Country extends BaseNameModel {

    public Country() {
    }

    @PrimaryKey(autoGenerate = true)
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Ignore
    public Country(String code, String name) {
        super(code, name);
    }
}
