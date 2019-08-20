package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity
public class EntryPoint extends BaseNameModel{

    @PrimaryKey(autoGenerate = true)
    private int id;

    public EntryPoint() {
    }

    @Ignore
    public EntryPoint(String code, String name) {
        super(code, name);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
