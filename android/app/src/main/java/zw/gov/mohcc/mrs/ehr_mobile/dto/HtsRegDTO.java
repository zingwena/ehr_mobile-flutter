package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsType;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.HtsTypeConverter;

public class HtsRegDTO {

    private int visitId;

    private String htsType;
   private Date dateOfHivTest;

    private Hts hts;
   private String entryPointId;


    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public int getVisitId() {
        return visitId;
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

    public Hts getHts() {
        return hts;
    }

    public void setHts(Hts hts) {
        this.hts = hts;
    }

    @Override
    public String toString() {
        return "HtsRegDTO{" +
                "id=" + visitId +
                ", htsType=" + htsType +
                ", dateOfHivTest=" + dateOfHivTest +
                ", hts=" + hts +
                ", entryPointId='" + entryPointId + '\'' +
                '}';
    }


}
