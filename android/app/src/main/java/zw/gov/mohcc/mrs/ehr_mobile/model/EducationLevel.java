package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity()
public class EducationLevel extends BaseNameModel  {
    @Ignore
    public EducationLevel(String code, String name) {
        super(code, name);
    }

    public EducationLevel() {
    }

    @PrimaryKey(autoGenerate = true)
    private int id;

    public int getId() {
        return id;
    }





    public void setId(int id) {
        this.id = id;
    }
}
