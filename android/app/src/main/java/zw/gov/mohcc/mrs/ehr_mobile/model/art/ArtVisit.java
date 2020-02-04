package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class ArtVisit extends BaseEntity {

    @NonNull
    private String artId;
    @NonNull
    private String visitId;
    @Embedded(prefix = "visitType_")
    private NameCode visitType;
    @Embedded(prefix = "functionalStatus_")
    private NameCode functionalStatus;
    @Embedded(prefix = "visitStatus_")
    private NameCode visitStatus;
    @TypeConverters(DateConverter.class)
    private Date ancFirstBookingDate;
    @Embedded(prefix = "lactatingStatus_")
    private NameCode lactatingStatus;
    @Embedded(prefix = "familyPlanningStatus_")
    private NameCode familyPlanningStatus;
    @Embedded(prefix = "tbStatus_")
    private NameCode tbStatus;

    public ArtVisit() {
    }

    @Ignore
    public ArtVisit(@NonNull String id, @NonNull String artId, String visitId) {
        super(id);
        this.artId = artId;
        this.visitId = visitId;
    }

    @NonNull
    public String getArtId() {
        return artId;
    }

    public void setArtId(@NonNull String artId) {
        this.artId = artId;
    }

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
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

    public Date getAncFirstBookingDate() {
        return ancFirstBookingDate;
    }

    public void setAncFirstBookingDate(Date ancFirstBookingDate) {
        this.ancFirstBookingDate = ancFirstBookingDate;
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

    public NameCode getTbStatus() {
        return tbStatus;
    }

    public void setTbStatus(NameCode tbStatus) {
        this.tbStatus = tbStatus;
    }

    @Override
    public String toString() {
        return "ArtVisit{" +
                "artId='" + artId + '\'' +
                ", visitId='" + visitId + '\'' +
                ", visitType=" + visitType +
                ", functionalStatus=" + functionalStatus +
                ", visitStatus=" + visitStatus +
                ", ancFirstBookingDate=" + ancFirstBookingDate +
                ", lactatingStatus=" + lactatingStatus +
                ", familyPlanningStatus=" + familyPlanningStatus +
                ", tbStatus=" + tbStatus +
                '}';
    }
}
