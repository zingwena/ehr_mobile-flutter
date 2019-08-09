package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity()
public class Religion {
    private String religionName;
    private String religionCode;
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "religion_Id")
    private int id;

    public Religion(String religionName, String religionCode) {
        this.religionName = religionName;
        this.religionCode = religionCode;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getReligionName() {
        return religionName;
    }

    public void setReligionName(String religionName) {
        this.religionName = religionName;
    }

    public String getReligionCode() {
        return religionCode;
    }

    public void setReligionCode(String religionCode) {
        this.religionCode = religionCode;
    }

    @Override
    public String toString() {
        return "Religion{" +
                "religionName='" + religionName + '\'' +
                ", religionCode='" + religionCode + '\'' +
                ", id=" + id +
                '}';
    }
}
