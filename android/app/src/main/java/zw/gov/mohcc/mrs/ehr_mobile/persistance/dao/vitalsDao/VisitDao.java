package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;

@Dao
public interface VisitDao {
    @Insert
    void insert(Visit visit);

    @Query("SELECT * FROM Visit WHERE patientId = :patientId AND startTime = :startTime")
    Visit findByPatientIdAndStartTime(long patientId, Date startTime);

    @Query("SELECT * FROM Visit")
    List<Visit> getAll();
}
