package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.HivTestUsedConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.LinkageFromConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.HivTestUsed;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.LinkageFrom;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class ArtLinkageFrom extends BaseEntity {

    @NonNull
    private String artId;
    @TypeConverters(LinkageFromConverter.class)
    @NonNull
    private LinkageFrom linkageFrom;
    private String linkageNumber;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date dateHivConfirmed;
    private String otherInstitution;
    @NonNull
    @TypeConverters(HivTestUsedConverter.class)
    private HivTestUsed hivTestUsed;
    @Embedded(prefix = "testReason_")
    private NameCode testReason;
    private Boolean reTested;
    @TypeConverters(DateConverter.class)
    private Date dateRetested;
    @Embedded(prefix = "facility_")
    private NameCode facility;

    public ArtLinkageFrom() {
    }

    @Ignore
    public ArtLinkageFrom(@NonNull String id, @NonNull String artId) {
        super(id);
        this.artId = artId;
    }

    @NonNull
    public String getArtId() {
        return artId;
    }

    public void setArtId(@NonNull String artId) {
        this.artId = artId;
    }

    @NonNull
    public LinkageFrom getLinkageFrom() {
        return linkageFrom;
    }

    public void setLinkageFrom(@NonNull LinkageFrom linkageFrom) {
        this.linkageFrom = linkageFrom;
    }

    public String getLinkageNumber() {
        return linkageNumber;
    }

    public void setLinkageNumber(String linkageNumber) {
        this.linkageNumber = linkageNumber;
    }

    @NonNull
    public Date getDateHivConfirmed() {
        return dateHivConfirmed;
    }

    public void setDateHivConfirmed(@NonNull Date dateHivConfirmed) {
        this.dateHivConfirmed = dateHivConfirmed;
    }

    public String getOtherInstitution() {
        return otherInstitution;
    }

    public void setOtherInstitution(String otherInstitution) {
        this.otherInstitution = otherInstitution;
    }

    @NonNull
    public HivTestUsed getHivTestUsed() {
        return hivTestUsed;
    }

    public void setHivTestUsed(@NonNull HivTestUsed hivTestUsed) {
        this.hivTestUsed = hivTestUsed;
    }

    public NameCode getTestReason() {
        return testReason;
    }

    public void setTestReason(NameCode testReason) {
        this.testReason = testReason;
    }

    public Boolean getReTested() {
        return reTested;
    }

    public void setReTested(Boolean reTested) {
        this.reTested = reTested;
    }

    public Date getDateRetested() {
        return dateRetested;
    }

    public void setDateRetested(Date dateRetested) {
        this.dateRetested = dateRetested;
    }

    public NameCode getFacility() {
        return facility;
    }

    public void setFacility(NameCode facility) {
        this.facility = facility;
    }
}
