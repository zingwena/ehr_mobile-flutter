package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.ArvStatusConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.RegimenTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ArvStatus;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity(indices = {@Index(value = "artId")},
        foreignKeys = {@ForeignKey(entity = Art.class, onDelete = ForeignKey.CASCADE,
                parentColumns = "id",
                childColumns = "artId"),
                @ForeignKey(entity = ArvCombinationRegimen.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "regimen_code"),
                @ForeignKey(entity = ArtReason.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "reason_code")})
public class ArtCurrentStatus extends BaseEntity {

    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @NonNull
    private String artId;
    @TypeConverters(ArvStatusConverter.class)
    @NonNull
    private ArvStatus state;
    @Embedded(prefix = "regimen_")
    @NonNull
    private NameCode regimen;
    @Embedded(prefix = "reason_")
    private NameCode reason;
    @TypeConverters(RegimenTypeConverter.class)
    private RegimenType regimenType;
    @Embedded(prefix = "adverseEventStatus_")
    private NameCode adverseEventStatus;

    public ArtCurrentStatus() {
    }

    @Ignore
    public ArtCurrentStatus(@NonNull String id, @NonNull String artId) {
        super(id);
        this.artId = artId;
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    @NonNull
    public String getArtId() {
        return artId;
    }

    public void setArtId(@NonNull String artId) {
        this.artId = artId;
    }

    public ArvStatus getState() {
        return state;
    }

    public void setState(ArvStatus state) {
        this.state = state;
    }

    public NameCode getRegimen() {
        return regimen;
    }

    public void setRegimen(NameCode regimen) {
        this.regimen = regimen;
    }

    public NameCode getReason() {
        return reason;
    }

    public void setReason(NameCode reason) {
        this.reason = reason;
    }

    public RegimenType getRegimenType() {
        return regimenType;
    }

    public void setRegimenType(RegimenType regimenType) {
        this.regimenType = regimenType;
    }

    public NameCode getAdverseEventStatus() {
        return adverseEventStatus;
    }

    public void setAdverseEventStatus(NameCode adverseEventStatus) {
        this.adverseEventStatus = adverseEventStatus;
    }

    @Override
    public String toString() {
        return "ArtCurrentStatus{" +
                "date=" + date +
                ", artId='" + artId + '\'' +
                ", state=" + state +
                ", regimen=" + regimen +
                ", reason=" + reason +
                ", regimenType=" + regimenType +
                ", adverseEventStatus=" + adverseEventStatus +
                '}';
    }
}
