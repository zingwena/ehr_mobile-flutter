package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;
import androidx.room.TypeConverters;

import java.io.Serializable;
import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.HivTestUsed;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.LinkageFrom;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtLinkageFrom;

public class ArtDTO implements Serializable {

    @NonNull
    private String personId;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @NonNull
    private String artNumber;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date dateOfHivTest;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date dateEnrolled;
    // fields for linkages
    @NonNull
    private LinkageFrom linkageFrom;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date dateHivConfirmed;
    private String linkageNumber;
    private HivTestUsed hivTestUsed;
    private String otherInstitution;
    private String testReason;
    private Boolean reTested;
    @TypeConverters(DateConverter.class)
    private Date dateRetested;
    private String facility;

    public static Art getArt(ArtDTO dto) {

        Art art = new Art(UUID.randomUUID().toString(), dto.getPersonId());
        art.setArtNumber(dto.getArtNumber());
        art.setDateEnrolled(dto.getDateEnrolled());
        art.setDate(dto.getDate());
        art.setDateOfHivTest(dto.getDateOfHivTest());
        return art;
    }

    public static ArtLinkageFrom getArtLinkage(ArtDTO dto, String artId) {

        ArtLinkageFrom linkage = new ArtLinkageFrom();
        linkage.setArtId(artId);
        linkage.setDateHivConfirmed(dto.getDateHivConfirmed());
        linkage.setDateRetested(dto.getDateRetested());
        linkage.setDateHivConfirmed(dto.getDateHivConfirmed());
        linkage.setHivTestUsed(dto.getHivTestUsed());
        linkage.setLinkageFrom(dto.getLinkageFrom());
        linkage.setLinkageNumber(dto.getLinkageNumber());
        linkage.setOtherInstitution(dto.getOtherInstitution());
        linkage.setReTested(dto.getReTested());
        linkage.setId(UUID.randomUUID().toString());
        return linkage;
    }

    public static ArtDTO get(Art art, ArtLinkageFrom linkage) {

        ArtDTO dto = new ArtDTO();
        dto.setArtNumber(art.getArtNumber());
        dto.setDate(art.getDate() != null ? new PastDate(art.getDate()) : null);
        dto.setDateEnrolled(art.getDateEnrolled());
        dto.setDateOfHivTest(art.getDateOfHivTest() != null ? new PastDate(art.getDateOfHivTest()) : null);
        dto.setDateOfHivTest(new PastDate(art.getDateOfHivTest()));
        dto.setDateEnrolled(art.getDateEnrolled());
        dto.setPersonId(art.getPersonId());

        if (linkage != null) {
            dto.setReTested(linkage.getReTested());
            dto.setHivTestUsed(linkage.getHivTestUsed());
            dto.setLinkageFrom(linkage.getLinkageFrom());
            dto.setLinkageNumber(linkage.getLinkageNumber());
            dto.setDateHivConfirmed(new PastDate(linkage.getDateHivConfirmed()));
            dto.setDateRetested(linkage.getDateRetested() != null ? new PastDate(linkage.getDateRetested()) : null);
            dto.setOtherInstitution(linkage.getOtherInstitution());
            dto.setFacility(linkage.getFacility() != null ? linkage.getFacility().getName() : "");
            dto.setTestReason(linkage.getTestReason() != null ? linkage.getTestReason().getName() : "");
        }

        return dto;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public void setDate(@NonNull PastDate date) {
        this.date = date != null ? date.getPastDate() : null;
    }

    @NonNull
    public String getArtNumber() {
        return artNumber;
    }

    public void setArtNumber(@NonNull String artNumber) {
        this.artNumber = artNumber;
    }

    @NonNull
    public Date getDateOfHivTest() {
        return dateOfHivTest;
    }

    public void setDateOfHivTest(@NonNull PastDate dateOfHivTest) {
        this.dateOfHivTest = dateOfHivTest.getPastDate();
    }

    @NonNull
    public Date getDateEnrolled() {
        return dateEnrolled;
    }

    public void setDateEnrolled(@NonNull Date dateEnrolled) {
        this.dateEnrolled = dateEnrolled;
    }

    @NonNull
    public LinkageFrom getLinkageFrom() {
        return linkageFrom;
    }

    public void setLinkageFrom(@NonNull LinkageFrom linkageFrom) {
        this.linkageFrom = linkageFrom;
    }

    @NonNull
    public Date getDateHivConfirmed() {
        return dateHivConfirmed;
    }

    public void setDateHivConfirmed(@NonNull PastDate dateHivConfirmed) {
        this.dateHivConfirmed = dateHivConfirmed != null ? dateHivConfirmed.getPastDate() : null;
    }

    public String getLinkageNumber() {
        return linkageNumber;
    }

    public void setLinkageNumber(String linkageNumber) {
        this.linkageNumber = linkageNumber;
    }

    public HivTestUsed getHivTestUsed() {
        return hivTestUsed;
    }

    public void setHivTestUsed(HivTestUsed hivTestUsed) {
        this.hivTestUsed = hivTestUsed;
    }

    public String getOtherInstitution() {
        return otherInstitution;
    }

    public void setOtherInstitution(String otherInstitution) {
        this.otherInstitution = otherInstitution;
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

    public void setDateRetested(PastDate dateRetested) {
        this.dateRetested = dateRetested != null ? dateRetested.getPastDate() : null;
    }

    public String getTestReason() {
        return testReason;
    }

    public void setTestReason(String testReason) {
        this.testReason = testReason;
    }

    public String getFacility() {
        return facility;
    }

    public void setFacility(String facility) {
        this.facility = facility;
    }

    @Override
    public String toString() {

        return "ArtDTO{" +
                "personId='" + personId + '\'' +
                ", date=" + date +
                ", artNumber='" + artNumber + '\'' +
                ", dateOfHivTest=" + dateOfHivTest +
                ", dateEnrolled=" + dateEnrolled +
                ", linkageFrom=" + linkageFrom +
                ", dateHivConfirmed=" + dateHivConfirmed +
                ", linkageNumber='" + linkageNumber + '\'' +
                ", hivTestUsed=" + hivTestUsed +
                ", otherInstitution='" + otherInstitution + '\'' +
                ", testReason='" + testReason + '\'' +
                ", reTested=" + reTested +
                ", dateRetested=" + dateRetested +
                ", facility='" + facility + '\'' +
                '}';
    }
}
