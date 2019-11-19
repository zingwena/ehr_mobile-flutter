package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.hts.SexualHistory;

public class SexualHistoryDTO {

    @NonNull
    private String personId;

    private boolean sexuallyActive;

    private Date sexWithMaleDate;

    private Date sexWithFemaleDate;

    private Integer numberOfSexualPartners;

    private Integer numberOfSexualPartnersLastTwelveMonths;

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
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

    public SexualHistory getInstance(SexualHistoryDTO dto) {
        SexualHistory item = new SexualHistory();
        item.setDate(new Date());
        item.setNumberOfSexualPartners(dto.getNumberOfSexualPartners());
        item.setNumberOfSexualPartnersLastTwelveMonths(dto.getNumberOfSexualPartnersLastTwelveMonths());
        item.setPersonId(dto.getPersonId());
        item.setSexuallyActive(dto.isSexuallyActive());
        item.setSexWithFemaleDate(dto.getSexWithFemaleDate());
        item.setSexWithMaleDate(dto.getSexWithMaleDate());
        item.setId(UUID.randomUUID().toString());
        return item;
    }

    @Override
    public String toString() {
        return "SexualHistoryDTO{" +
                "personId='" + personId + '\'' +
                ", sexuallyActive=" + sexuallyActive +
                ", sexWithMaleDate=" + sexWithMaleDate +
                ", sexWithFemaleDate=" + sexWithFemaleDate +
                ", numberOfSexualPartners=" + numberOfSexualPartners +
                ", numberOfSexualPartnersLastTwelveMonths=" + numberOfSexualPartnersLastTwelveMonths +
                '}';
    }
}
