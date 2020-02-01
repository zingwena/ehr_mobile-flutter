package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class ArtFollowupCall extends BaseEntity {

    @NonNull
    private String artAppointmentId;
    @Embedded
    private NameCode outcome;
    private Date date;

    public ArtFollowupCall() {
    }

    @Ignore
    public ArtFollowupCall(@NonNull String id, @NonNull String artAppointmentId) {
        super(id);
        this.artAppointmentId = artAppointmentId;
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

    public void setDate(Date date) {
        this.date = date;
    }
}
