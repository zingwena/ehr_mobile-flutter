package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity(indices = {@Index(value = "artId", unique = true)})
public class ArtIpt extends BaseEntity {

    @NonNull
    private String artId;
    @NonNull
    private Date date;
    @Embedded(prefix = "status_")
    private NameCode status;
    @Embedded(prefix = "reason_")
    private NameCode reason;

    public ArtIpt() {
    }

    @Ignore
    public ArtIpt(@NonNull String id, @NonNull String artId, @NonNull Date date, NameCode status, NameCode reason) {
        super(id);
        this.artId = artId;
        this.date = date;
        this.status = status;
        this.reason = reason;
    }

    @NonNull
    public String getArtId() {
        return artId;
    }

    public void setArtId(@NonNull String artId) {
        this.artId = artId;
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    public NameCode getStatus() {
        return status;
    }

    public void setStatus(NameCode status) {
        this.status = status;
    }

    public NameCode getReason() {
        return reason;
    }

    public void setReason(NameCode reason) {
        this.reason = reason;
    }
}
