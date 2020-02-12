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
    private String id;
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

    public ArtFollowUpDTO(@NonNull String id, @NonNull String artAppointmentId, @NonNull String outcome, @NonNull PastDate date, @NonNull FollowUpType followUpType) {
        this.id = id;
        this.artAppointmentId = artAppointmentId;
        this.outcome = outcome;
        this.date = date;
        this.followUpType = followUpType;
    }

    public static ArtFollowUp getInstance(ArtFollowUpDTO artFollowUpDTO, FollowUpType followUpType, FollowUpReason followUpReason) {

        return new ArtFollowUp(UUID.randomUUID().toString(), artFollowUpDTO.getArtAppointmentId(),
                new NameCode(followUpReason.getCode(), followUpReason.getName()), artFollowUpDTO.getDate(), followUpType);
    }

    public static ArtFollowUpDTO get(ArtFollowUp artFollowUp) {

        return new ArtFollowUpDTO(artFollowUp.getId(), artFollowUp.getArtAppointmentId(), artFollowUp.getOutcome().getName(),
                new PastDate(artFollowUp.getDate()), artFollowUp.getFollowUpType());
    }

    @NonNull
    public String getId() {
        return id;
    }

    public void setId(@NonNull String id) {
        this.id = id;
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
                "id='" + id + '\'' +
                ", artAppointmentId='" + artAppointmentId + '\'' +
                ", outcome='" + outcome + '\'' +
                ", date=" + date +
                ", followUpType=" + followUpType +
                '}';
    }
}
