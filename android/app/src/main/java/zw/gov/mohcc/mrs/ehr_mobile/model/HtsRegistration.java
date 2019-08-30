package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.HtsTypeConverter;

@Entity
public class HtsRegistration {
    @PrimaryKey(autoGenerate = true)
    private int id;

    private String htsType;
    @TypeConverters(DateConverter.class)
    private Date dateOfHivTest;
    private String entryPointId;
    @NonNull
    private int visitId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHtsType() {
        return htsType;
    }

    public void setHtsType(String htsType) {
        this.htsType = htsType;
    }

    public Date getDateOfHivTest() {
        return dateOfHivTest;
    }

    public void setDateOfHivTest(Date dateOfHivTest) {
        this.dateOfHivTest = dateOfHivTest;
    }

    public String getEntryPointId() {
        return entryPointId;
    }

    public void setEntryPointId(String entryPointId) {
        this.entryPointId = entryPointId;
    }

    public int getVisitId() {
        return visitId;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }
}
