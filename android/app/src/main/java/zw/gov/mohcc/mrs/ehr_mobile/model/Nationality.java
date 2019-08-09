package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity()
public class Nationality {

    public Nationality(String nationalityName, String nationalityCode) {
        this.nationalityName = nationalityName;
        this.nationalityCode = nationalityCode;
    }

    private String nationalityName;
    private String nationalityCode;

    @PrimaryKey(autoGenerate = true)
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNationalityName() {
        return nationalityName;
    }

    public void setNationalityName(String nationalityName) {
        this.nationalityName = nationalityName;
    }

    public String getNationalityCode() {
        return nationalityCode;
    }

    public void setNationalityCode(String nationalityCode) {
        this.nationalityCode = nationalityCode;
    }
}
