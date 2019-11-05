package zw.gov.mohcc.mrs.ehr_mobile;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.ActivityStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.PrepOption;
import zw.gov.mohcc.mrs.ehr_mobile.util.ActivityStatusConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.PrepOptionConverter;

@Entity
public class HtsScreening extends BaseEntity {

    @NonNull
    private String visitId;

    private boolean testedBefore;

    private Boolean art;

    private String result;

    @TypeConverters(DateConverter.class)
    private Date dateLastTested;

    private String artNumber;

    private boolean beenOnPrep;

    @TypeConverters(PrepOptionConverter.class)
    private PrepOption prepOption;

    @TypeConverters(ActivityStatusConverter.class)
    private ActivityStatus viralLoadDone;

    @TypeConverters(ActivityStatusConverter.class)
    private ActivityStatus cd4Done;

    @NonNull
    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(@NonNull String visitId) {
        this.visitId = visitId;
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

    public void setDateLastTested(Date dateLastTested) {
        this.dateLastTested = dateLastTested;
    }

    public String getArtNumber() {
        return artNumber;
    }

    public void setArtNumber(String artNumber) {
        this.artNumber = artNumber;
    }

    public boolean isBeenOnPrep() {
        return beenOnPrep;
    }

    public void setBeenOnPrep(boolean beenOnPrep) {
        this.beenOnPrep = beenOnPrep;
    }

    public PrepOption getPrepOption() {
        return prepOption;
    }

    public void setPrepOption(PrepOption prepOption) {
        this.prepOption = prepOption;
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
}
