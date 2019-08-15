package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import java.util.ArrayList;

@Entity
public class MaritalStatus extends BaseNameModel {

    @PrimaryKey(autoGenerate = true)
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public MaritalStatus() {
    }
    @Ignore
    public MaritalStatus(String code, String name) {
        super(code, name);
    }
}
