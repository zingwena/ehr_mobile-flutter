package zw.gov.mohcc.mrs.ehr_mobile.model.tb;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.Visit;

@Entity(indices = {@Index("visitId")},
        foreignKeys = {
                @ForeignKey(entity = Visit.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "id",
                        childColumns = "visitId")})
public class TbScreening extends BaseEntity {

    @NonNull
    private String visitId;
    private boolean presumptive;
    private String note;
    @TypeConverters(DateConverter.class)
    @NonNull
    private Date time;
    @NonNull
    private Boolean fever;
    @NonNull
    private Boolean coughing;
    @NonNull
    private Boolean weightLoss;
    @NonNull
    private Boolean nightSweats;
    @NonNull
    private Boolean bmiUnderSeventeen;

    public TbScreening() {
    }

    @Ignore
    public TbScreening(@NonNull String id, @NonNull String visitId) {
        super(id);
        this.visitId = visitId;
    }

    @NonNull
    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(@NonNull String visitId) {
        this.visitId = visitId;
    }

    public boolean isPresumptive() {
        return presumptive;
    }

    public void setPresumptive(boolean presumptive) {
        this.presumptive = presumptive;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @NonNull
    public Date getTime() {
        return time;
    }

    public void setTime(@NonNull Date time) {
        this.time = time;
    }

    @NonNull
    public Boolean getFever() {
        return fever;
    }

    public void setFever(@NonNull Boolean fever) {
        this.fever = fever;
    }

    @NonNull
    public Boolean getCoughing() {
        return coughing;
    }

    public void setCoughing(@NonNull Boolean coughing) {
        this.coughing = coughing;
    }

    @NonNull
    public Boolean getWeightLoss() {
        return weightLoss;
    }

    public void setWeightLoss(@NonNull Boolean weightLoss) {
        this.weightLoss = weightLoss;
    }

    @NonNull
    public Boolean getNightSweats() {
        return nightSweats;
    }

    public void setNightSweats(@NonNull Boolean nightSweats) {
        this.nightSweats = nightSweats;
    }

    @NonNull
    public Boolean getBmiUnderSeventeen() {
        return bmiUnderSeventeen;
    }

    public void setBmiUnderSeventeen(@NonNull Boolean bmiUnderSeventeen) {
        this.bmiUnderSeventeen = bmiUnderSeventeen;
    }

    @Override
    public String toString() {
        return "TbScreening{" +
                "visitId='" + visitId + '\'' +
                ", presumptive=" + presumptive +
                ", note='" + note + '\'' +
                ", time=" + time +
                ", fever=" + fever +
                ", coughing=" + coughing +
                ", weightLoss=" + weightLoss +
                ", nightSweats=" + nightSweats +
                ", bmiUnderSeventeen=" + bmiUnderSeventeen +
                '}';
    }
}
