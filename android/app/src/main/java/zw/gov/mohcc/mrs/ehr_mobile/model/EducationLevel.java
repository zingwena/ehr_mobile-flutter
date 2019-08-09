package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity()
public class EducationLevel  {

    @PrimaryKey(autoGenerate = true)
   @ColumnInfo(name = "educationLevel_Id")
    private int id;

    public EducationLevel(String educationLevelName, String educationLevelCode) {
        this.educationLevelName = educationLevelName;
        this.educationLevelCode = educationLevelCode;
    }

    //    @Ignore
//    public EducationLevel(String code, String name) {
//        super(code, name);
//    }
private String educationLevelName;
    private String educationLevelCode;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEducationLevelName() {
        return educationLevelName;
    }

    public void setEducationLevelName(String educationLevelName) {
        this.educationLevelName = educationLevelName;
    }

    public String getEducationLevelCode() {
        return educationLevelCode;
    }

    public void setEducationLevelCode(String educationLevelCode) {
        this.educationLevelCode = educationLevelCode;
    }

    @Override
    public String toString() {
        return "EducationLevel{" +
                "id=" + id +
                ", educationLevelName='" + educationLevelName + '\'' +
                ", educationLevelCode='" + educationLevelCode + '\'' +
                '}';
    }
}
