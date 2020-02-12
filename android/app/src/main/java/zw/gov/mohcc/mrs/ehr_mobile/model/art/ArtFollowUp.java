package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.FollowUpTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.FollowUpType;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class ArtFollowUp extends BaseEntity {

    @NonNull
    private String artAppointmentId;
    @Embedded
    private NameCode outcome;
    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @TypeConverters(FollowUpTypeConverter.class)
    @NonNull
    private FollowUpType followUpType;

    public ArtFollowUp() {
    }

    @Ignore
    public ArtFollowUp(@NonNull String id, @NonNull String artAppointmentId, NameCode outcome, @NonNull Date date, @NonNull FollowUpType followUpType) {
        super(id);
        this.artAppointmentId = artAppointmentId;
        this.outcome = outcome;
        this.date = date;
        this.followUpType = followUpType;
    }

    @NonNull
    public String getArtAppointmentId() {
        return artAppointmentId;
    }

    public void setArtAppointmentId(@NonNull String artAppointmentId) {
        this.artAppointmentId = artAppointmentId;
    }

    public NameCode getOutcome() {
        return outcome;
    }

    public void setOutcome(NameCode outcome) {
        this.outcome = outcome;
    }

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
        return "ArtFollowUp{" +
                "artAppointmentId='" + artAppointmentId + '\'' +
                ", outcome=" + outcome +
                ", date=" + date +
                ", followUpType=" + followUpType +
                '}';
    }
}
