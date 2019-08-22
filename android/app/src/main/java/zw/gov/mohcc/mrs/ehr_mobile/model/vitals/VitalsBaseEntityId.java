package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.room.PrimaryKey;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

public class VitalsBaseEntityId {
    @PrimaryKey(autoGenerate = true)
    private long id;
    private long visitId;
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
