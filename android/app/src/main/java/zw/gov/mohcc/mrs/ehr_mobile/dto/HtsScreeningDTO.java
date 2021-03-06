package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;
import androidx.room.TypeConverters;

import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ActivityStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.HtsScreening;

public class HtsScreeningDTO {

    @NonNull
    private String personId;
    private boolean testedBefore;
    private Boolean art;
    private String result;
    @TypeConverters(DateConverter.class)
    private Date dateLastTested;
    private String artNumber;
    @TypeConverters(DateConverter.class)
    private Date dateLastNegative;
    private Integer viralLoad;
    @TypeConverters(DateConverter.class)
    private Date viralLoadDate;
    private Integer cd4Count;
    @TypeConverters(DateConverter.class)
    private Date cd4CountDate;
    @TypeConverters(DateConverter.class)
    private Date dateEnrolled;
    private ActivityStatus viralLoadDone;
    private ActivityStatus cd4Done;

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    public boolean isTestedBefore() {
        return testedBefore;
    }

    public void setTestedBefore(boolean testedBefore) {
        this.testedBefore = testedBefore;
    }

    public Boolean getArt() {
        return art;
    }

    public void setArt(Boolean art) {
        this.art = art;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Date getDateLastTested() {
        return dateLastTested;
    }

    public void setDateLastTested(PastDate dateLastTested) {
        this.dateLastTested = dateLastTested != null ? dateLastTested.getPastDate() : null;
    }

    public String getArtNumber() {
        return artNumber;
    }

    public void setArtNumber(String artNumber) {
        this.artNumber = artNumber;
    }

    public Date getDateLastNegative() {
        return dateLastNegative;
    }

    public void setDateLastNegative(PastDate dateLastNegative) {
        this.dateLastNegative = dateLastNegative != null ? dateLastNegative.getPastDate() : null;
    }

    public Integer getViralLoad() {
        return viralLoad;
    }

    public void setViralLoad(Integer viralLoad) {
        this.viralLoad = viralLoad;
    }

    public Date getViralLoadDate() {
        return viralLoadDate;
    }

    public void setViralLoadDate(PastDate viralLoadDate) {
        this.viralLoadDate = viralLoadDate != null ? viralLoadDate.getPastDate() : null;
    }

    public Integer getCd4Count() {
        return cd4Count;
    }

    public void setCd4Count(Integer cd4Count) {
        this.cd4Count = cd4Count;
    }

    public Date getCd4CountDate() {
        return cd4CountDate;
    }

    public void setCd4CountDate(PastDate cd4CountDate) {
        this.cd4CountDate = cd4CountDate != null ? cd4CountDate.getPastDate() : null;
    }

    public Date getDateEnrolled() {
        return dateEnrolled;
    }

    public void setDateEnrolled(PastDate dateEnrolled) {
        this.dateEnrolled = dateEnrolled != null ? dateEnrolled.getPastDate() : null;
    }

    public ActivityStatus getViralLoadDone() {
        return viralLoadDone;
    }

    public void setViralLoadDone(ActivityStatus viralLoadDone) {
        this.viralLoadDone = viralLoadDone;
    }

    public ActivityStatus getCd4Done() {
        return cd4Done;
    }

    public void setCd4Done(ActivityStatus cd4Done) {
        this.cd4Done = cd4Done;
    }

    public HtsScreening getHtsScreeningInstance(HtsScreeningDTO dto, String visitId) {
        HtsScreening item = new HtsScreening(visitId);
        item.setArt(dto.getArt());
        item.setArtNumber(dto.getArtNumber());
        item.setCd4Done(dto.getCd4Done());
        item.setDateLastTested(dto.getDateLastTested());
        item.setResult(dto.getResult());
        item.setTestedBefore(dto.isTestedBefore());
        item.setViralLoadDone(dto.getViralLoadDone());
        item.setVisitId(visitId);
        item.setDateLastNegative(dto.getDateLastNegative());
        item.setId(UUID.randomUUID().toString());
        return item;
    }

    public Art getArtInstance(HtsScreeningDTO dto, String personId) {
        Art art = new Art();
        art.setDateEnrolled(dto.getDateEnrolled());
        art.setDateOfHivTest(dto.getDateLastTested());
        art.setArtNumber(dto.getArtNumber());
        art.setPersonId(personId);
        art.setId(UUID.randomUUID().toString());
        return art;
    }

    @Override
    public String toString() {
        return "HtsScreeningDTO{" +
                "personId='" + personId + '\'' +
                ", testedBefore=" + testedBefore +
                ", art=" + art +
                ", result='" + result + '\'' +
                ", dateLastTested=" + dateLastTested +
                ", artNumber='" + artNumber + '\'' +
                ", dateLastNegative=" + dateLastNegative +
                ", viralLoad=" + viralLoad +
                ", viralLoadDate=" + viralLoadDate +
                ", cd4Count=" + cd4Count +
                ", cd4CountDate=" + cd4CountDate +
                ", dateEnrolled=" + dateEnrolled +
                ", viralLoadDone=" + viralLoadDone +
                ", cd4Done=" + cd4Done +
                '}';
    }
}
