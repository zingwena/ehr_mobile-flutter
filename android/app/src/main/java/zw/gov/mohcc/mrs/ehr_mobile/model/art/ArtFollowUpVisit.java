package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class ArtFollowUpVisit extends BaseEntity {

    @NonNull
    private String artAppointmentId;
    @Embedded
    private NameCode outcome;
    private Date date;

    public ArtFollowUpVisit() {
    }

    public ArtFollowUpVisit(@NonNull String id, @NonNull String artAppointmentId) {
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

    @Override
    public String toString() {
        return "ArtFollowUpVisit{" +
                "artAppointmentId='" + artAppointmentId + '\'' +
                ", outcome=" + outcome +
                ", date=" + date +
                '}';
    }
}
