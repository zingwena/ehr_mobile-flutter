package com.example.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;
import com.example.ehr_mobile.model.Patient;

import java.util.List;

@Dao
public interface PatientDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long createPatient(Patient patient);

    @Query("DELETE from Patient")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM Patient WHERE id =:id")
    int getNumberOfRows(int id);

    @Update
    int updatePatient(Patient patient);

    @Query("SELECT * FROM Patient ORDER BY firstName Asc")
    List<Patient> listPatients();

    @Query("SELECT * FROM Patient WHERE id =:id")
    Patient findPatientById(int id);

    @Query("DELETE FROM Patient where id = :id")
    void deleteById(Long id);

    @RawQuery
    List<Patient> searchPatient(SimpleSQLiteQuery query);

    @Query("SELECT * FROM Patient WHERE identifier = :identifier AND number = :number")
    Patient findPatientByIdentifierAndNumber(String identifier, String number);


}
