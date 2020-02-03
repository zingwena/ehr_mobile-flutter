package zw.gov.mohcc.mrs.ehr_mobile.model.tb;

import androidx.annotation.NonNull;
import androidx.room.Entity;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;

@Entity
public class TbScreening extends BaseEntity {

    private String visitId;

    private boolean presumptive;

    private String note;

    private Date time;

    private Boolean fever;

    private Boolean coughing;

    private Boolean weightLoss;

    private Boolean nightSweats;

    private Boolean bmiUnderSeventeen;

    public TbScreening() {
    }

    public TbScreening(@NonNull String id, String visitId) {
        super(id);
        this.visitId = visitId;
    }

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
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

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Boolean getFever() {
        return fever;
    }

    public void setFever(Boolean fever) {
        this.fever = fever;
    }

    public Boolean getCoughing() {
        return coughing;
    }

    public void setCoughing(Boolean coughing) {
        this.coughing = coughing;
    }

    public Boolean getWeightLoss() {
        return weightLoss;
    }

    public void setWeightLoss(Boolean weightLoss) {
        this.weightLoss = weightLoss;
    }

    public Boolean getNightSweats() {
        return nightSweats;
    }

    public void setNightSweats(Boolean nightSweats) {
        this.nightSweats = nightSweats;
    }

    public Boolean getBmiUnderSeventeen() {
        return bmiUnderSeventeen;
    }

    public void setBmiUnderSeventeen(Boolean bmiUnderSeventeen) {
        this.bmiUnderSeventeen = bmiUnderSeventeen;
    }
}
