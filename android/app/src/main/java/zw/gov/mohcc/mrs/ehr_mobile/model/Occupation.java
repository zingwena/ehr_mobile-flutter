package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Occupation extends BaseNameModel {

    @PrimaryKey(autoGenerate = true)
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Occupation(String code, String name) {
        super(code, name);
    }
}