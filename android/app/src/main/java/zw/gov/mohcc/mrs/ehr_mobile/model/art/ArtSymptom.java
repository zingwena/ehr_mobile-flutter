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
public class ArtSymptom extends BaseEntity {

    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @NonNull
    private String artId;
    @Embedded
    private NameCode symptom;

    public ArtSymptom() {
    }

    @Ignore
    public ArtSymptom(@NonNull String id, @NonNull Date date, @NonNull String artId, NameCode symptom) {
        super(id);
        this.date = date;
        this.artId = artId;
        this.symptom = symptom;
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

    public NameCode getSymptom() {
        return symptom;
    }

    public void setSymptom(NameCode symptom) {
        this.symptom = symptom;
    }

    @Override
    public String toString() {
        return "ArtSymptom{" +
                "date=" + date +
                ", artId='" + artId + '\'' +
                ", symptom=" + symptom +
                '}';
    }
}
