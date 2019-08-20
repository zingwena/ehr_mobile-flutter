package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Purpose_Of_Tests extends BaseNameModel {

    @PrimaryKey(autoGenerate = true)
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Purpose_Of_Tests(String code, String name) {
        super(code, name);
    }
}
