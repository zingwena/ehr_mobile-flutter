package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsType;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;

public class HtsRegDTO {

    private int id;

    @TypeConverters(GenderConverter.class)
    private HtsType htsType;
    @TypeConverters(DateConverter.class)
    Date registrationDate;
    private Hts hts;

    public HtsRegDTO(int id, HtsType htsType, Date registrationDate, Hts hts) {
        this.id = id;
        this.htsType = htsType;
        this.registrationDate = registrationDate;
        this.hts = hts;
    }

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

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
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
                ", registrationDate=" + registrationDate +
                ", hts=" + hts +
                '}';
    }
}
