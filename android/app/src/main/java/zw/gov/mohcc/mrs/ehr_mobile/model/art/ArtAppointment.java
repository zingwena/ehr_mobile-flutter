package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity(indices = {@Index(value = "artId")},
        foreignKeys = {@ForeignKey(entity = Art.class, onDelete = ForeignKey.CASCADE,
                parentColumns = "id",
                childColumns = "artId"),
                @ForeignKey(entity = FollowUpReason.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "followUpReason_code"),
                @ForeignKey(entity = FollowUpReason.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "appointmentOutcome_code")})
public class ArtAppointment extends BaseEntity {

    @NonNull
    private String artId;
    @Embedded(prefix = "reason_")
    private NameCode reason;
    @TypeConverters(DateConverter.class)
    @NonNull
    private Date date;
    @Embedded(prefix = "followUpReason_")
    private NameCode followUpReason;
    @TypeConverters(DateConverter.class)
    private Date followupDate;
    @TypeConverters(DateConverter.class)
    private Date appointmentOutcomeDate;
    @Embedded(prefix = "appointmentOutcome_")
    private NameCode appointmentOutcome;

    public ArtAppointment() {
    }

    @Ignore
    public ArtAppointment(@NonNull String id, @NonNull String artId) {
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

    public NameCode getReason() {
        return reason;
    }

    public void setReason(NameCode reason) {
        this.reason = reason;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public NameCode getFollowUpReason() {
        return followUpReason;
    }

    public void setFollowUpReason(NameCode followUpReason) {
        this.followUpReason = followUpReason;
    }

    public Date getFollowupDate() {
        return followupDate;
    }

    public void setFollowupDate(Date followupDate) {
        this.followupDate = followupDate;
    }

    public Date getAppointmentOutcomeDate() {
        return appointmentOutcomeDate;
    }

    public void setAppointmentOutcomeDate(Date appointmentOutcomeDate) {
        this.appointmentOutcomeDate = appointmentOutcomeDate;
    }

    public NameCode getAppointmentOutcome() {
        return appointmentOutcome;
    }

    public void setAppointmentOutcome(NameCode appointmentOutcome) {
        this.appointmentOutcome = appointmentOutcome;
    }

    @Override
    public String toString() {
        return "ArtAppointment{" +
                "artId='" + artId + '\'' +
                ", reason=" + reason +
                ", date=" + date +
                ", followUpReason=" + followUpReason +
                ", followupDate=" + followupDate +
                ", appointmentOutcomeDate=" + appointmentOutcomeDate +
                ", appointmentOutcome=" + appointmentOutcome +
                '}';
    }
}
