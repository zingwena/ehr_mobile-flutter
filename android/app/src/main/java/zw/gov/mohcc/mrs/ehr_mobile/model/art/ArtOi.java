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
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Question;

@Entity(indices = {@Index(value = "artId")},
        foreignKeys = {@ForeignKey(entity = Art.class, onDelete = ForeignKey.CASCADE,
                parentColumns = "id",
                childColumns = "artId"),
                @ForeignKey(entity = Question.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "code")})
public class ArtOi extends BaseEntity {

    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @NonNull
    private String artId;

    @Embedded
    private NameCode oi;

    public ArtOi() {
    }

    @Ignore
    public ArtOi(@NonNull String id, @NonNull Date date, @NonNull String artId, NameCode oi) {
        super(id);
        this.date = date;
        this.artId = artId;
        this.oi = oi;
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

    public NameCode getOi() {
        return oi;
    }

    public void setOi(NameCode oi) {
        this.oi = oi;
    }

    @Override
    public String toString() {
        return "ArtOi{" +
                "date=" + date +
                ", artId='" + artId + '\'' +
                ", oi=" + oi +
                '}';
    }
}
