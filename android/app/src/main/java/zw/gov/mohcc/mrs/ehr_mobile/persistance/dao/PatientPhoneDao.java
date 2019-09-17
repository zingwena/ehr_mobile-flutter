package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.PatientPhoneNumber;
import zw.gov.mohcc.mrs.ehr_mobile.model.Result;

@Dao
public interface PatientPhoneDao {

    @Insert
    void insertpatientphonenumbers(List<PatientPhoneNumber> patientPhoneNumbers);

    @Query("DELETE FROM patientphonenumber")
    void deletepatientphonenumber();


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long insertpatientphonenumber(PatientPhoneNumber patientPhoneNumber);


    @Query("SELECT * FROM PatientPhoneNumber ORDER BY  phonenumber_1 ASC")
    List<PatientPhoneNumber> getAllPhonenumbers();

    @Query("SELECT * FROM PatientPhoneNumber WHERE patientId=:id")
    PatientPhoneNumber findByPatientId(int id);


    @Query("SELECT * FROM PatientPhoneNumber WHERE id=:id")
    PatientPhoneNumber findById(int id);

    @Query("SELECT * FROM PatientPhoneNumber WHERE id=:id")
    PatientPhoneNumber findByPersonId(String id);



}
