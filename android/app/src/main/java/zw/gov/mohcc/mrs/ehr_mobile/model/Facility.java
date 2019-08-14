package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Facility{

    private String facilityCode;
    private String  facilityName;
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "facility_id")
    private int id;

    public Facility(String facilityCode, String facilityName) {
        this.facilityCode = facilityCode;
        this.facilityName = facilityName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFacilityName() {
        return facilityName;
    }

    public void setFacilityName(String facilityName) {
        this.facilityName = facilityName;
    }

    public String getFacilityCode() {
        return facilityCode;
    }

    public void setFacilityCode(String facilityCode) {
        this.facilityCode = facilityCode;
    }
}
