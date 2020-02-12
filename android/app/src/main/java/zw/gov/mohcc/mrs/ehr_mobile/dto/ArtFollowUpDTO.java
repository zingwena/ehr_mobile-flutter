package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;
import androidx.room.TypeConverters;

import java.io.Serializable;
import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.FollowUpTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.FollowUpType;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtFollowUp;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class ArtFollowUpDTO implements Serializable {

    @NonNull
    private String artAppointmentId;
    @NonNull
    private String outcome;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @TypeConverters(FollowUpTypeConverter.class)
    @NonNull
    private FollowUpType followUpType;

    public ArtFollowUpDTO(@NonNull String artAppointmentId, @NonNull String outcome, @NonNull Date date, @NonNull FollowUpType followUpType) {
        this.artAppointmentId = artAppointmentId;
        this.outcome = outcome;
        this.date = date;
        this.followUpType = followUpType;
    }

    public static ArtFollowUpDTO get(ArtFollowUp artFollowUp) {

        return new ArtFollowUpDTO(artFollowUp.getArtAppointmentId(), artFollowUp.getOutcome() != null ?
                artFollowUp.getOutcome().getName() : null, artFollowUp.getDate(), artFollowUp.getFollowUpType());
    }

    public static ArtFollowUp getInstance(ArtFollowUpDTO artFollowUpDTO, FollowUpReason outcome) {

        NameCode followUpReason = outcome != null ? new NameCode(outcome.getCode(), outcome.getName()) : null;

        return new ArtFollowUp(UUID.randomUUID().toString(), artFollowUpDTO.getArtAppointmentId(), followUpReason,
                artFollowUpDTO.getDate(), artFollowUpDTO.getFollowUpType());
    }

    @NonNull
    public String getArtAppointmentId() {
        return artAppointmentId;
    }

    public void setArtAppointmentId(@NonNull String artAppointmentId) {
        this.artAppointmentId = artAppointmentId;
    }

    @NonNull
    public String getOutcome() {
        return outcome;
    }

    public void setOutcome(@NonNull String outcome) {
        this.outcome = outcome;
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    @NonNull
    public FollowUpType getFollowUpType() {
        return followUpType;
    }

    public void setFollowUpType(@NonNull FollowUpType followUpType) {
        this.followUpType = followUpType;
    }

    @Override
    public String toString() {
        return "ArtFollowUpDTO{" +
                "artAppointmentId='" + artAppointmentId + '\'' +
                ", outcome='" + outcome + '\'' +
                ", date=" + date +
                ", followUpType=" + followUpType +
                '}';
    }
}
