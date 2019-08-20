package zw.gov.mohcc.mrs.ehr_mobile.vitals;

import androidx.room.PrimaryKey;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class VitalsBaseEntityId {
    @PrimaryKey(autoGenerate = true)
    private int id;
    private int visitId;
    private LocalDateTime dateTime = LocalDateTime.now();


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVisitId() {
        return visitId;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
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
