package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.Date;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.PatientType;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;

@Dao
public interface VisitDao {
    @Insert
    void insert(Visit visit);

    @Update
    void update(Visit visit);

    @Query("DELETE from Visit")
    void deleteAll();

    @Query("SELECT * FROM Visit WHERE personId = :personId AND patientType=:patientType And discharged is null")
    Visit findByPersonIdAndTypeAndDischargedIsNull(String personId, PatientType patientType);

    @Query("SELECT * FROM Visit")
    List<Visit> getAll();

    @Query("SELECT * FROM Visit WHERE id = :id")
    Visit findById(String id);
}
