package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.io.Serializable;
import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WhoStage;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtVisit;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtWhoStage;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class ArtVisitDTO implements Serializable {

    @NonNull
    private String artId;
    @NonNull
    private String visitId;
    private NameCode visitType;
    private NameCode functionalStatus;
    private NameCode visitStatus;
    private NameCode lactatingStatus;
    private NameCode familyPlanningStatus;
    @NonNull
    private WhoStage stage;
    private NameCode followUpStatus;

    @NonNull
    public String getArtId() {
        return artId;
    }

    public void setArtId(@NonNull String artId) {
        this.artId = artId;
    }

    @NonNull
    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(@NonNull String visitId) {
        this.visitId = visitId;
    }

    public NameCode getVisitType() {
        return visitType;
    }

    public void setVisitType(NameCode visitType) {
        this.visitType = visitType;
    }

    public NameCode getFunctionalStatus() {
        return functionalStatus;
    }

    public void setFunctionalStatus(NameCode functionalStatus) {
        this.functionalStatus = functionalStatus;
    }

    public NameCode getVisitStatus() {
        return visitStatus;
    }

    public void setVisitStatus(NameCode visitStatus) {
        this.visitStatus = visitStatus;
    }

    public NameCode getLactatingStatus() {
        return lactatingStatus;
    }

    public void setLactatingStatus(NameCode lactatingStatus) {
        this.lactatingStatus = lactatingStatus;
    }

    public NameCode getFamilyPlanningStatus() {
        return familyPlanningStatus;
    }

    public void setFamilyPlanningStatus(NameCode familyPlanningStatus) {
        this.familyPlanningStatus = familyPlanningStatus;
    }

    @NonNull
    public WhoStage getStage() {
        return stage;
    }

    public void setStage(@NonNull WhoStage stage) {
        this.stage = stage;
    }

    public NameCode getFollowUpStatus() {
        return followUpStatus;
    }

    public void setFollowUpStatus(NameCode followUpStatus) {
        this.followUpStatus = followUpStatus;
    }

    public ArtVisit getArtVisitInstance(ArtVisitDTO dto) {

        ArtVisit artVisit = new ArtVisit(UUID.randomUUID().toString(), dto.getArtId(), dto.getVisitId());
        artVisit.setFamilyPlanningStatus(dto.getFamilyPlanningStatus());
        artVisit.setFunctionalStatus(dto.getFunctionalStatus());
        artVisit.setLactatingStatus(dto.getLactatingStatus());
        artVisit.setVisitType(dto.getVisitType());
        artVisit.setVisitStatus(dto.getVisitStatus());
        return artVisit;
    }

    public ArtWhoStage getArtWhoStageInstance(ArtVisitDTO dto) {

        return new ArtWhoStage(UUID.randomUUID().toString(), dto.getVisitId(), dto.getArtId(),
                dto.getStage(), dto.getFollowUpStatus());
    }

    @Override
    public String toString() {
        return "ArtVisitDTO{" +
                "artId='" + artId + '\'' +
                ", visitId='" + visitId + '\'' +
                ", visitType=" + visitType +
                ", functionalStatus=" + functionalStatus +
                ", visitStatus=" + visitStatus +
                ", lactatingStatus=" + lactatingStatus +
                ", familyPlanningStatus=" + familyPlanningStatus +
                ", stage=" + stage +
                ", followUpStatus=" + followUpStatus +
                '}';
    }
}
