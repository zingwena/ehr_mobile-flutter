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
    public ArtOi(@NonNull String id, @NonNull String artId) {
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

    public NameCode getOi() {
        return oi;
    }

    public void setOi(NameCode oi) {
        this.oi = oi;
    }
}
