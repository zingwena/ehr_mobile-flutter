package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class Visit {


    @PrimaryKey(autoGenerate = true)
    private long visitId;
    private long patientId;
    @TypeConverters(DateConverter.class)
    private Date startTime = new Date();
    @TypeConverters(DateConverter.class)
    private Date endDate = new Date(System.currentTimeMillis() + (24 * 3600 * 10^3));



    public Visit() {
    }

    @Ignore
    public Visit(long patientId) {
        this.patientId = patientId;
    }


    public long getVisitId() {
        return visitId;
    }

    public void setVisitId(long visitId) {
        this.visitId = visitId;
    }

    public long getPatientId() {
        return patientId;
    }

    public void setPatientId(long patientId) {
        this.patientId = patientId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "Visit{" +
                "visitId=" + visitId +
                ", patientId=" + patientId +
                ", startTime=" + startTime +
                ", endDate=" + endDate +
                '}';
    }
}
