package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsType;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.HtsTypeConverter;

public class HtsRegDTO {

    private int id;

    @TypeConverters(HtsTypeConverter.class)
    private HtsType htsType;
    @TypeConverters(DateConverter.class)
    Date dateOfHivTest;

    private Hts hts;
    String entryPointId;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public HtsType getHtsType() {
        return htsType;
    }

    public void setHtsType(HtsType htsType) {
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

    public Hts getHts() {
        return hts;
    }

    public void setHts(Hts hts) {
        this.hts = hts;
    }

    @Override
    public String toString() {
        return "HtsRegDTO{" +
                "id=" + id +
                ", htsType=" + htsType +
                ", dateOfHivTest=" + dateOfHivTest +
                ", hts=" + hts +
                ", entryPointId='" + entryPointId + '\'' +
                '}';
    }
}
