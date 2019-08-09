package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity()
public class Occupation  {
    @Override
    public String toString() {
        return "Occupation{" +
                "occupationName='" + occupationName + '\'' +
                ", occupationCode='" + occupationCode + '\'' +
                ", id=" + id +
                '}';
    }

    private String occupationName;
    private String occupationCode;
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "occupation_Id")
    private int id;

    public Occupation( String occupationCode,String occupationName) {
        this.occupationName = occupationName;
        this.occupationCode = occupationCode;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

//    public Occupation(String code, String name) {
//        super(code, name);
//    }

    public String getOccupationName() {
        return occupationName;
    }

    public void setOccupationName(String occupationName) {
        this.occupationName = occupationName;
    }

    public String getOccupationCode() {
        return occupationCode;
    }

    public void setOccupationCode(String occupationCode) {
        this.occupationCode = occupationCode;
    }
}
