package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
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

    public ArtFollowUp() {
    }

    @Ignore
    public ArtFollowUp(@NonNull String id, @NonNull String artAppointmentId) {
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

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "ArtFollowUp{" +
                "artAppointmentId='" + artAppointmentId + '\'' +
                ", outcome=" + outcome +
                ", date=" + date +
                '}';
    }
}
