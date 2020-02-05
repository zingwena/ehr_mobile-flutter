package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.io.Serializable;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WhoStage;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtVisit;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtWhoStage;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitType;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FamilyPlanningStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FunctionalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LactatingStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class ArtVisitDTO implements Serializable {

    @NonNull
    private String artId;
    @NonNull
    private String visitId;
    private String visitType;
    private String functionalStatus;
    private String visitStatus;
    private String lactatingStatus;
    private String familyPlanningStatus;
    @NonNull
    private WhoStage stage;
    private String followUpStatus;

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

    public String getVisitType() {
        return visitType;
    }

    public void setVisitType(String visitType) {
        this.visitType = visitType;
    }

    public String getFunctionalStatus() {
        return functionalStatus;
    }

    public void setFunctionalStatus(String functionalStatus) {
        this.functionalStatus = functionalStatus;
    }

    public String getVisitStatus() {
        return visitStatus;
    }

    public void setVisitStatus(String visitStatus) {
        this.visitStatus = visitStatus;
    }

    public String getLactatingStatus() {
        return lactatingStatus;
    }

    public void setLactatingStatus(String lactatingStatus) {
        this.lactatingStatus = lactatingStatus;
    }

    public String getFamilyPlanningStatus() {
        return familyPlanningStatus;
    }

    public void setFamilyPlanningStatus(String familyPlanningStatus) {
        this.familyPlanningStatus = familyPlanningStatus;
    }

    @NonNull
    public WhoStage getStage() {
        return stage;
    }

    public void setStage(@NonNull WhoStage stage) {
        this.stage = stage;
    }

    public String getFollowUpStatus() {
        return followUpStatus;
    }

    public void setFollowUpStatus(String followUpStatus) {
        this.followUpStatus = followUpStatus;
    }

    public ArtVisit getArtVisitInstance(ArtVisitDTO dto, FamilyPlanningStatus familyPlanningStatus, FunctionalStatus functionalStatus,
                                        LactatingStatus lactatingStatus, ArtVisitType artVisitType, ArtVisitStatus artVisitStatus) {

        ArtVisit artVisit = new ArtVisit(dto.getVisitId(), dto.getArtId(), dto.getVisitId());
        artVisit.setFamilyPlanningStatus(familyPlanningStatus != null ? new NameCode(familyPlanningStatus.getCode(), familyPlanningStatus.getName()) : null);
        artVisit.setFunctionalStatus(functionalStatus != null ? new NameCode(functionalStatus.getCode(), functionalStatus.getName()) : null);
        artVisit.setLactatingStatus(lactatingStatus != null ? new NameCode(lactatingStatus.getCode(), lactatingStatus.getName()) : null);
        artVisit.setVisitType(artVisitType != null ? new NameCode(artVisitType.getCode(), artVisitType.getName()) : null);
        artVisit.setVisitStatus(artVisitStatus != null ? new NameCode(artVisitStatus.getCode(), artVisitStatus.getName()) : null);
        return artVisit;
    }

    public ArtWhoStage getArtWhoStageInstance(ArtVisitDTO dto, FollowUpStatus followUpStatus) {

        return new ArtWhoStage(dto.getVisitId(), dto.getVisitId(), dto.getArtId(),
                dto.getStage(), followUpStatus != null ? new NameCode(followUpStatus.getCode(), followUpStatus.getName()) : null);
    }

    public static ArtVisitDTO get(ArtVisit artVisit, ArtWhoStage artWhoStage) {

        ArtVisitDTO dto = new ArtVisitDTO();
        dto.setArtId(artVisit.getArtId());
        dto.setFamilyPlanningStatus(artVisit.getFamilyPlanningStatus() != null ?
                artVisit.getFamilyPlanningStatus().getName() : null);
        if(artWhoStage != null) {
            dto.setFollowUpStatus(artWhoStage.getFollowUpStatus() != null ? artWhoStage.getFollowUpStatus().getName() : null);
            dto.setStage(artWhoStage.getStage());
        }
        dto.setLactatingStatus(artVisit.getLactatingStatus() != null ? artVisit.getLactatingStatus().getName() : null);
        dto.setFunctionalStatus(artVisit.getFunctionalStatus() != null ? artVisit.getFunctionalStatus().getName() : null);
        dto.setVisitStatus(artVisit.getVisitStatus() != null ? artVisit.getVisitStatus().getName() : null);
        dto.setVisitId(artVisit.getVisitId());
        dto.setVisitType(artVisit.getVisitType() != null ? artVisit.getVisitType().getName() : null);
        return dto;
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
