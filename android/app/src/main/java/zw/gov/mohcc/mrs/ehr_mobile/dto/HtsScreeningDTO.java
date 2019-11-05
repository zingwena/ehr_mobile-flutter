package zw.gov.mohcc.mrs.ehr_mobile.dto;
import java.util.Date;
import zw.gov.mohcc.mrs.ehr_mobile.model.ActivityStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.PrepOption;

public class HtsScreeningDTO {

    private boolean testedBefore;

    private Boolean art;

    private String result;

    private Date dateLastTested;

    private String artNumber;

    private Date dateLastNegative;

    private Integer viralLoad;

    private Date viralLoadDate;

    private Integer cd4Count;

    private Date cd4CountDate;

    private Date dateEnrolled;

    private boolean beenOnPrep;

    private PrepOption prepOption;

    private ActivityStatus viralLoadDone;

    private ActivityStatus cd4Done;

    private Date prophylaxisMedicationStartDate;

    private Date prophylaxisMedicationEndDate;

    private String medicationId;

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

    public Date getDateLastNegative() {
        return dateLastNegative;
    }

    public void setDateLastNegative(Date dateLastNegative) {
        this.dateLastNegative = dateLastNegative;
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

    public void setViralLoadDate(Date viralLoadDate) {
        this.viralLoadDate = viralLoadDate;
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

    public void setCd4CountDate(Date cd4CountDate) {
        this.cd4CountDate = cd4CountDate;
    }

    public Date getDateEnrolled() {
        return dateEnrolled;
    }

    public void setDateEnrolled(Date dateEnrolled) {
        this.dateEnrolled = dateEnrolled;
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

    public Date getProphylaxisMedicationStartDate() {
        return prophylaxisMedicationStartDate;
    }

    public void setProphylaxisMedicationStartDate(Date prophylaxisMedicationStartDate) {
        this.prophylaxisMedicationStartDate = prophylaxisMedicationStartDate;
    }

    public Date getProphylaxisMedicationEndDate() {
        return prophylaxisMedicationEndDate;
    }

    public void setProphylaxisMedicationEndDate(Date prophylaxisMedicationEndDate) {
        this.prophylaxisMedicationEndDate = prophylaxisMedicationEndDate;
    }

    public String getMedicationId() {
        return medicationId;
    }

    public void setMedicationId(String medicationId) {
        this.medicationId = medicationId;
    }
}
