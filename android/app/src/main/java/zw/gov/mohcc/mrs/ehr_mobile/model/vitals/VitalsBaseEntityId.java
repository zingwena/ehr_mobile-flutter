package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.room.PrimaryKey;
import androidx.room.TypeConverter;
import androidx.room.TypeConverters;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

public class VitalsBaseEntityId {
    @PrimaryKey(autoGenerate = true)
    private long id;
    private long visitId;
    @TypeConverters(DateConverter.class)
    private Date dateTime = new Date();


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getVisitId() {
        return visitId;
    }

    public void setVisitId(long visitId) {
        this.visitId = visitId;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    @Override
    public String toString() {
        return "VitalsBaseEntityId{" +
                "id=" + id +
                ", visitId=" + visitId +
                ", dateTime=" + dateTime +
                '}';
    }
}
