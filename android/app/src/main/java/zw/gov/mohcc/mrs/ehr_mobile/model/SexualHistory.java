package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class SexualHistory extends BaseEntity {

    @NonNull
    private String personId;

    private boolean sexuallyActive;

    @TypeConverters(DateConverter.class)
    private Date sexWithMaleDate;

    @TypeConverters(DateConverter.class)
    private Date sexWithFemaleDate;

    @TypeConverters(DateConverter.class)
    private Date date;

    private Integer numberOfSexualPartners;

    private Integer numberOfSexualPartnersLastTwelveMonths;

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    public boolean isSexuallyActive() {
        return sexuallyActive;
    }

    public void setSexuallyActive(boolean sexuallyActive) {
        this.sexuallyActive = sexuallyActive;
    }

    public Date getSexWithMaleDate() {
        return sexWithMaleDate;
    }

    public void setSexWithMaleDate(Date sexWithMaleDate) {
        this.sexWithMaleDate = sexWithMaleDate;
    }

    public Date getSexWithFemaleDate() {
        return sexWithFemaleDate;
    }

    public void setSexWithFemaleDate(Date sexWithFemaleDate) {
        this.sexWithFemaleDate = sexWithFemaleDate;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getNumberOfSexualPartners() {
        return numberOfSexualPartners;
    }

    public void setNumberOfSexualPartners(Integer numberOfSexualPartners) {
        this.numberOfSexualPartners = numberOfSexualPartners;
    }

    public Integer getNumberOfSexualPartnersLastTwelveMonths() {
        return numberOfSexualPartnersLastTwelveMonths;
    }

    public void setNumberOfSexualPartnersLastTwelveMonths(Integer numberOfSexualPartnersLastTwelveMonths) {
        this.numberOfSexualPartnersLastTwelveMonths = numberOfSexualPartnersLastTwelveMonths;
    }

    @Override
    public String toString() {
        return super.toString().concat("SexualHistory{" +
                "personId='" + personId + '\'' +
                ", sexuallyActive=" + sexuallyActive +
                ", sexWithMaleDate=" + sexWithMaleDate +
                ", sexWithFemaleDate=" + sexWithFemaleDate +
                ", date=" + date +
                ", numberOfSexualPartners=" + numberOfSexualPartners +
                ", numberOfSexualPartnersLastTwelveMonths=" + numberOfSexualPartnersLastTwelveMonths +
                '}');
    }
}
