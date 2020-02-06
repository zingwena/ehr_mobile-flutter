package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity(indices = {@Index(value = "artId"), @Index(value = "visitId", unique = true)},
        foreignKeys = {@ForeignKey(entity = Art.class, onDelete = ForeignKey.CASCADE,
                parentColumns = "id",
                childColumns = "artId"),
                @ForeignKey(entity = Visit.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "id",
                        childColumns = "visitId"),
                @ForeignKey(entity = IptStatus.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "status_code"),
                @ForeignKey(entity = IptReason.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "reason_code")})
public class ArtIpt extends BaseEntity {

    @NonNull
    private String artId;
    @NonNull
    private String visitId;
    @Embedded(prefix = "status_")
    private NameCode iptStatus;
    @Embedded(prefix = "reason_")
    private NameCode reason;

    public ArtIpt() {
    }

    @Ignore
    public ArtIpt(@NonNull String id, @NonNull String artId, @NonNull String visitId, NameCode iptStatus, NameCode reason) {
        super(id);
        this.artId = artId;
        this.visitId = visitId;
        this.iptStatus = iptStatus;
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
    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(@NonNull String visitId) {
        this.visitId = visitId;
    }

    public NameCode getIptStatus() {
        return iptStatus;
    }

    public void setIptStatus(NameCode iptStatus) {
        this.iptStatus = iptStatus;
    }

    public NameCode getReason() {
        return reason;
    }

    public void setReason(NameCode reason) {
        this.reason = reason;
    }

    @Override
    public String toString() {
        return "ArtIpt{" +
                "artId='" + artId + '\'' +
                ", visitId=" + visitId +
                ", iptStatus=" + iptStatus +
                ", reason=" + reason +
                '}';
    }
}
