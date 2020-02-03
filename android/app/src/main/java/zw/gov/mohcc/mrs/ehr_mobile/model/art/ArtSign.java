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
public class ArtSign extends BaseEntity {

    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    private String artId;
    @Embedded
    private NameCode sign;

    public ArtSign() {
    }

    @Ignore
    public ArtSign(@NonNull String id, @NonNull Date date, String artId, NameCode sign) {
        super(id);
        this.date = date;
        this.artId = artId;
        this.sign = sign;
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    public String getArtId() {
        return artId;
    }

    public void setArtId(String artId) {
        this.artId = artId;
    }

    public NameCode getSign() {
        return sign;
    }

    public void setSign(NameCode sign) {
        this.sign = sign;
    }

    @Override
    public String toString() {
        return "ArtSign{" +
                "date=" + date +
                ", artId='" + artId + '\'' +
                ", sign=" + sign +
                '}';
    }
}
