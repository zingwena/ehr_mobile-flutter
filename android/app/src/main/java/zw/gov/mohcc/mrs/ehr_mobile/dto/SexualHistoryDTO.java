package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.util.Date;

public class SexualHistoryDTO {

    private boolean sexuallyActive;

    private Date sexWithMaleDate;

    private Date sexWithFemaleDate;

    private Integer numberOfSexualPartners;

    private Integer numberOfSexualPartnersLastTwelveMonths;

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
}
