package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;

@Dao
public interface PatientQueueDao {
    @Insert
    void saveAll(List<PatientQueue> patientQueues);

    @Insert
    void saveOne(PatientQueue patientQueue);

    @Update
    void update(PatientQueue patientQueue);

    @Query("SELECT * FROM PatientQueue")
    List<PatientQueue> findAll();

    @Query("DELETE FROM PatientQueue")
    void deleteAll();

    @Query("DELETE FROM PatientQueue Where visitId=:visitId")
    void deleteByVisitid(String visitId);

    @Query("SELECT * FROM PatientQueue WHERE id=:id")
    PatientQueue findById(String id);

    @Query("SELECT count(*) FROM PatientQueue WHERE visitId=:visitId")
    int existsByVisitId(String visitId);

    @Query("SELECT * FROM PatientQueue WHERE visitId=:visitId")
    PatientQueue findByVisitId(String visitId);
}
