package zw.gov.mohcc.mrs.ehr_mobile.model.hts;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.ActivityStatusConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ActivityStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.Visit;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index(value = "visitId", unique = true)},
        foreignKeys = {@ForeignKey(entity = Visit.class, onDelete = CASCADE,
                parentColumns = "id",
                childColumns = "visitId")})
public class HtsScreening extends BaseEntity {

    @NonNull
    private String visitId;
    private boolean testedBefore;
    private Boolean art;
    private String result;
    @TypeConverters(DateConverter.class)
    private Date dateLastTested;
    @TypeConverters(DateConverter.class)
    private Date dateLastNegative;
    private String artNumber;

    @TypeConverters(ActivityStatusConverter.class)
    private ActivityStatus viralLoadDone;

    @TypeConverters(ActivityStatusConverter.class)
    private ActivityStatus cd4Done;

    public HtsScreening(@NonNull String visitId) {
        this.visitId = visitId;
    }

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

    public Date getDateLastNegative() {
        return dateLastNegative;
    }

    public void setDateLastNegative(Date dateLastNegative) {
        this.dateLastNegative = dateLastNegative;
    }

    @Override
    public String toString() {
        return super.toString().concat("HtsScreening{" +
                "visitId='" + visitId + '\'' +
                ", testedBefore=" + testedBefore +
                ", art=" + art +
                ", result='" + result + '\'' +
                ", dateLastTested=" + dateLastTested +
                ", artNumber='" + artNumber + '\'' +
                ", viralLoadDone=" + viralLoadDone +
                ", cd4Done=" + cd4Done +
                '}');
    }
}
