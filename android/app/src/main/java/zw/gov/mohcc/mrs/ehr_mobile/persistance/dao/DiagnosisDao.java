package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Diagnosis;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.HtsModel;


@Dao
public interface DiagnosisDao {

    @Insert
    void saveAll(List<Diagnosis> diagnoses);

    @Query("DELETE FROM Diagnosis")
    void deleteAll();

    @Insert
    void saveOne(Diagnosis diagnosis);

    @Query("SELECT * FROM Diagnosis ORDER BY name ASC")
    List<Diagnosis> findAll();

    @Query("SELECT * FROM Diagnosis WHERE code=:code")
    HtsModel findByid(String code);

    @Query("SELECT * FROM Diagnosis where name=:name")
    HtsModel findByName(String name);

}
