package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;

@Entity
public class HtsRegistration {
    @PrimaryKey(autoGenerate = true)
    private int id;
    @TypeConverters(GenderConverter.class)
    public HtsType htsType;
    @TypeConverters(DateConverter.class)
    Date patientDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public Date getPatientDate() {
        return patientDate;
    }

    public void setPatientDate(Date patientDate) {
        this.patientDate = patientDate;
    }

}
