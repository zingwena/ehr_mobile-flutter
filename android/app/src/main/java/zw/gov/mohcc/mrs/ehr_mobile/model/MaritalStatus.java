package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import java.util.ArrayList;

@Entity
public class MaritalStatus {

    public MaritalStatus() {
    }
    private String maritalStatusName;
    private String maritalStatusCode;

    public MaritalStatus(String maritalStatusName, String maritalStatusCode) {
        this.maritalStatusName = maritalStatusName;
        this.maritalStatusCode = maritalStatusCode;
    }

    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "marital_status_id")
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMaritalStatusName() {
        return maritalStatusName;
    }

    public void setMaritalStatusName(String maritalStatusName) {
        this.maritalStatusName = maritalStatusName;
    }

    public String getMaritalStatusCode() {
        return maritalStatusCode;
    }

    public void setMaritalStatusCode(String maritalStatusCode) {
        this.maritalStatusCode = maritalStatusCode;
    }
}
