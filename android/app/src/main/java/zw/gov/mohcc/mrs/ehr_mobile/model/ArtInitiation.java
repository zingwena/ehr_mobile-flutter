package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class ArtInitiation extends BaseEntity{

    @ColumnInfo(name = "personId")
    private String personId;

    @TypeConverters(DateConverter.class)
    private Date dateOfEnrolmentIntoCare;

    @TypeConverters(DateConverter.class)
    private Date dateInitiatedOnArt;

    private String clientType;
    private String clientEligibility;
    private String line;
    private String artRegimenId;
    private String artReasonId;
    private String artStatusId;

    public ArtInitiation() {
    }

    public ArtInitiation(String personId, Date dateOfEnrolmentIntoCare, Date dateInitiatedOnArt, String clientType, String clientEligibility, String line, String artRegimenId, String artReasonId, String artStatusId) {
        this.personId = personId;
        this.dateOfEnrolmentIntoCare = dateOfEnrolmentIntoCare;
        this.dateInitiatedOnArt = dateInitiatedOnArt;
        this.clientType = clientType;
        this.clientEligibility = clientEligibility;
        this.line = line;
        this.artRegimenId = artRegimenId;
        this.artReasonId = artReasonId;
        this.artStatusId = artStatusId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public Date getDateOfEnrolmentIntoCare() {
        return dateOfEnrolmentIntoCare;
    }

    public void setDateOfEnrolmentIntoCare(Date dateOfEnrolmentIntoCare) {
        this.dateOfEnrolmentIntoCare = dateOfEnrolmentIntoCare;
    }

    public Date getDateInitiatedOnArt() {
        return dateInitiatedOnArt;
    }

    public void setDateInitiatedOnArt(Date dateInitiatedOnArt) {
        this.dateInitiatedOnArt = dateInitiatedOnArt;
    }

    public String getClientType() {
        return clientType;
    }

    public void setClientType(String clientType) {
        this.clientType = clientType;
    }

    public String getClientEligibility() {
        return clientEligibility;
    }

    public void setClientEligibility(String clientEligibility) {
        this.clientEligibility = clientEligibility;
    }

    public String getLine() {
        return line;
    }

    public void setLine(String line) {
        this.line = line;
    }

    public String getArtRegimenId() {
        return artRegimenId;
    }

    public void setArtRegimenId(String artRegimenId) {
        this.artRegimenId = artRegimenId;
    }

    public String getArtReasonId() {
        return artReasonId;
    }

    public void setArtReasonId(String artReasonId) {
        this.artReasonId = artReasonId;
    }

    public String getArtStatusId() {
        return artStatusId;
    }

    public void setArtStatusId(String artStatusId) {
        this.artStatusId = artStatusId;
    }

    @Override
    public String toString() {
        return "ArtInitiation{" +
                "personId='" + personId + '\'' +
                ", dateOfEnrolmentIntoCare=" + dateOfEnrolmentIntoCare +
                ", dateInitiatedOnArt=" + dateInitiatedOnArt +
                ", clientType='" + clientType + '\'' +
                ", clientEligibility='" + clientEligibility + '\'' +
                ", line='" + line + '\'' +
                ", artRegimenId='" + artRegimenId + '\'' +
                ", artReasonId='" + artReasonId + '\'' +
                ", artStatusId='" + artStatusId + '\'' +
                '}';
    }
}
