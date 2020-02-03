package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;
import androidx.room.TypeConverters;

import java.io.Serializable;
import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.HivTestUsed;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.LinkageFrom;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Normality;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ReasonOfNotDisclosing;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RelationshipType;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtLinkageFrom;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class ArtDTO implements Serializable {

    @NonNull
    private String personId;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @NonNull
    private String artNumber;
    private Boolean enlargedLymphNode;
    private Boolean pallor;
    private Boolean jaundice;
    private Boolean cyanosis;
    private Normality mentalStatus;
    private Normality centralNervousSystem;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date dateOfHivTest;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date dateEnrolled;
    private Boolean tracing;
    private Boolean followUp;
    private Boolean hivStatus;
    private RelationshipType relation;
    @TypeConverters(DateConverter.class)
    private Date dateOfDisclosure;
    private ReasonOfNotDisclosing reason;
    // fields for linkages
    @NonNull
    private LinkageFrom linkageFrom;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date dateHivConfirmed;
    private String linkageNumber;
    private HivTestUsed hivTestUsed;
    private String otherInstitution;
    private NameCode testReason;
    private Boolean reTested;
    @TypeConverters(DateConverter.class)
    private Date dateRetested;
    private NameCode facility;

    public static Art getArt(ArtDTO dto) {

        Art art = new Art(UUID.randomUUID().toString(), dto.getPersonId());
        art.setArtNumber(dto.getArtNumber());
        art.setDateEnrolled(dto.getDateEnrolled());
        art.setDate(dto.getDate());
        art.setCentralNervousSystem(dto.getCentralNervousSystem());
        art.setCyanosis(dto.getCyanosis());
        art.setDateOfDisclosure(dto.getDateOfDisclosure());
        art.setDateOfHivTest(dto.getDateOfHivTest());
        art.setEnlargedLymphNode(dto.getEnlargedLymphNode());
        art.setFollowUp(dto.getFollowUp());
        art.setHivStatus(dto.getHivStatus());
        art.setJaundice(dto.getJaundice());
        art.setMentalStatus(dto.getMentalStatus());
        art.setPallor(dto.getPallor());
        art.setReason(dto.getReason());
        art.setRelation(dto.getRelation());
        art.setTracing(dto.getTracing());
        return art;
    }

    public static ArtLinkageFrom getArtLinkage(ArtDTO dto, String artId) {

        ArtLinkageFrom linkage = new ArtLinkageFrom();
        linkage.setArtId(artId);
        linkage.setDateHivConfirmed(dto.getDateHivConfirmed());
        linkage.setDateRetested(dto.getDateRetested());
        linkage.setDateHivConfirmed(dto.getDateHivConfirmed());
        linkage.setFacility(dto.getFacility());
        linkage.setHivTestUsed(dto.getHivTestUsed());
        linkage.setLinkageFrom(dto.getLinkageFrom());
        linkage.setLinkageNumber(dto.getLinkageNumber());
        linkage.setOtherInstitution(dto.getOtherInstitution());
        linkage.setReTested(dto.getReTested());
        linkage.setTestReason(dto.getTestReason());
        linkage.setId(UUID.randomUUID().toString());
        return linkage;
    }

    public static ArtDTO get(Art art, ArtLinkageFrom linkage) {

        ArtDTO dto = new ArtDTO();
        dto.setArtNumber(art.getArtNumber());
        dto.setCentralNervousSystem(art.getCentralNervousSystem());;
        dto.setCyanosis(art.getCyanosis());
        dto.setDate(art.getDate());
        dto.setDateEnrolled(art.getDateEnrolled());
        dto.setDateHivConfirmed(linkage.getDateHivConfirmed());
        dto.setDateOfHivTest(art.getDateOfHivTest());
        dto.setDateEnrolled(art.getDateEnrolled());
        dto.setDateOfDisclosure(art.getDateOfDisclosure());
        dto.setDateRetested(linkage.getDateRetested());
        dto.setEnlargedLymphNode(art.getEnlargedLymphNode());
        dto.setFacility(linkage.getFacility());
        dto.setFollowUp(art.getFollowUp());
        dto.setHivStatus(art.getHivStatus());
        dto.setJaundice(art.getJaundice());
        dto.setHivTestUsed(linkage.getHivTestUsed());
        dto.setLinkageFrom(linkage.getLinkageFrom());
        dto.setLinkageNumber(linkage.getLinkageNumber());
        dto.setMentalStatus(art.getMentalStatus());
        dto.setOtherInstitution(linkage.getOtherInstitution());
        dto.setPallor(art.getPallor());
        dto.setPersonId(art.getPersonId());
        dto.setReason(art.getReason());
        dto.setRelation(art.getRelation());
        dto.setReTested(linkage.getReTested());
        dto.setTestReason(linkage.getTestReason());
        dto.setTracing(art.getTracing());
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

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    @NonNull
    public String getArtNumber() {
        return artNumber;
    }

    public void setArtNumber(@NonNull String artNumber) {
        this.artNumber = artNumber;
    }

    public Boolean getEnlargedLymphNode() {
        return enlargedLymphNode;
    }

    public void setEnlargedLymphNode(Boolean enlargedLymphNode) {
        this.enlargedLymphNode = enlargedLymphNode;
    }

    public Boolean getPallor() {
        return pallor;
    }

    public void setPallor(Boolean pallor) {
        this.pallor = pallor;
    }

    public Boolean getJaundice() {
        return jaundice;
    }

    public void setJaundice(Boolean jaundice) {
        this.jaundice = jaundice;
    }

    public Boolean getCyanosis() {
        return cyanosis;
    }

    public void setCyanosis(Boolean cyanosis) {
        this.cyanosis = cyanosis;
    }

    public Normality getMentalStatus() {
        return mentalStatus;
    }

    public void setMentalStatus(Normality mentalStatus) {
        this.mentalStatus = mentalStatus;
    }

    public Normality getCentralNervousSystem() {
        return centralNervousSystem;
    }

    public void setCentralNervousSystem(Normality centralNervousSystem) {
        this.centralNervousSystem = centralNervousSystem;
    }

    @NonNull
    public Date getDateOfHivTest() {
        return dateOfHivTest;
    }

    public void setDateOfHivTest(@NonNull Date dateOfHivTest) {
        this.dateOfHivTest = dateOfHivTest;
    }

    @NonNull
    public Date getDateEnrolled() {
        return dateEnrolled;
    }

    public void setDateEnrolled(@NonNull Date dateEnrolled) {
        this.dateEnrolled = dateEnrolled;
    }

    public Boolean getTracing() {
        return tracing;
    }

    public void setTracing(Boolean tracing) {
        this.tracing = tracing;
    }

    public Boolean getFollowUp() {
        return followUp;
    }

    public void setFollowUp(Boolean followUp) {
        this.followUp = followUp;
    }

    public Boolean getHivStatus() {
        return hivStatus;
    }

    public void setHivStatus(Boolean hivStatus) {
        this.hivStatus = hivStatus;
    }

    public RelationshipType getRelation() {
        return relation;
    }

    public void setRelation(RelationshipType relation) {
        this.relation = relation;
    }

    public Date getDateOfDisclosure() {
        return dateOfDisclosure;
    }

    public void setDateOfDisclosure(Date dateOfDisclosure) {
        this.dateOfDisclosure = dateOfDisclosure;
    }

    public ReasonOfNotDisclosing getReason() {
        return reason;
    }

    public void setReason(ReasonOfNotDisclosing reason) {
        this.reason = reason;
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

    public void setDateHivConfirmed(@NonNull Date dateHivConfirmed) {
        this.dateHivConfirmed = dateHivConfirmed;
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

    @Override
    public String toString() {
        return "ArtDTO{" +
                "personId='" + personId + '\'' +
                ", date=" + date +
                ", artNumber='" + artNumber + '\'' +
                ", enlargedLymphNode=" + enlargedLymphNode +
                ", pallor=" + pallor +
                ", jaundice=" + jaundice +
                ", cyanosis=" + cyanosis +
                ", mentalStatus=" + mentalStatus +
                ", centralNervousSystem=" + centralNervousSystem +
                ", dateOfHivTest=" + dateOfHivTest +
                ", dateEnrolled=" + dateEnrolled +
                ", tracing=" + tracing +
                ", followUp=" + followUp +
                ", hivStatus=" + hivStatus +
                ", relation=" + relation +
                ", dateOfDisclosure=" + dateOfDisclosure +
                ", reason=" + reason +
                ", linkageFrom=" + linkageFrom +
                ", dateHivConfirmed=" + dateHivConfirmed +
                ", linkageNumber='" + linkageNumber + '\'' +
                ", hivTestUsed=" + hivTestUsed +
                ", otherInstitution='" + otherInstitution + '\'' +
                ", testReason=" + testReason +
                ", reTested=" + reTested +
                ", dateRetested=" + dateRetested +
                ", facility=" + facility +
                '}';
    }
}
