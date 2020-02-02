package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.WhoStageConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WhoStage;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class ArtWhoStage extends BaseEntity {

    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @NonNull
    private String artId;
    @NonNull
    @TypeConverters(WhoStageConverter.class)
    private WhoStage stage;
    @Embedded
    private NameCode followUpStatus;

    public ArtWhoStage() {
    }

    public ArtWhoStage(@NonNull String id, @NonNull Date date, @NonNull String artId, @NonNull WhoStage stage, NameCode followUpStatus) {
        super(id);
        this.date = date;
        this.artId = artId;
        this.stage = stage;
        this.followUpStatus = followUpStatus;
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

    @NonNull
    public WhoStage getStage() {
        return stage;
    }

    public void setStage(@NonNull WhoStage stage) {
        this.stage = stage;
    }

    public NameCode getFollowUpStatus() {
        return followUpStatus;
    }

    public void setFollowUpStatus(NameCode followUpStatus) {
        this.followUpStatus = followUpStatus;
    }

    @Override
    public String toString() {
        return "ArtWhoStage{" +
                "date=" + date +
                ", artId='" + artId + '\'' +
                ", stage=" + stage +
                ", followUpStatus=" + followUpStatus +
                '}';
    }
}
