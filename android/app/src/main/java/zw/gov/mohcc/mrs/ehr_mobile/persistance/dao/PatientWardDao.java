package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientWard;

@Dao
public interface PatientWardDao {
    @Insert
    void saveAll(List<PatientWard> patientWards);

    @Insert
    void saveOne(PatientWard patientWard);

    @Insert
    void update(PatientWard patientWard);

    @Query("SELECT * FROM PatientWard")
    List<PatientWard> findAll();

    @Query("DELETE FROM PatientWard")
    void deleteAll();

    @Query("SELECT * FROM PatientWard WHERE id=:id")
    PatientWard findById(String id);

    @Query("DELETE FROM PatientWard Where visitId=:visitId")
    void deleteByVisitid(String visitId);

    @Query("SELECT count(*) FROM PatientWard WHERE visitId=:visitId")
    int existsByVisitId(String visitId);

    @Query("SELECT * FROM PatientWard WHERE visitId=:visitId")
    PatientWard findByVisitId(String visitId);
}
