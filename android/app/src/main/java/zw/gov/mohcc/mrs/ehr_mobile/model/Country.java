package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.PrimaryKey;

@Entity(indices = {@Index(value = "code", unique = true)})
public class Country extends BaseNameModel {

    @PrimaryKey(autoGenerate = true)
    private int id;

    public Country() {
    }

    @Ignore
    public Country(String code, String name) {
        super(code, name);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
