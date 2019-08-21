package zw.gov.mohcc.mrs.ehr_mobile.vitals;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
public class Visit {


    @PrimaryKey(autoGenerate = true)
    private int visitId;
    private int patientId;
    private LocalDateTime startTime = LocalDateTime.now();




    public int getVisitId() {
        return visitId;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }


}
