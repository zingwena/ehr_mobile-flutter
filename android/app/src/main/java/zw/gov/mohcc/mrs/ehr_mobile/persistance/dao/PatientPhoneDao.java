package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.person.PatientPhoneNumber;

@Dao
public interface PatientPhoneDao {

    @Insert
    void saveAll(List<PatientPhoneNumber> patientPhoneNumbers);

    @Query("DELETE FROM patientphonenumber")
    void deleteAll();


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long saveOne(PatientPhoneNumber patientPhoneNumber);


    @Query("SELECT * FROM PatientPhoneNumber WHERE id=:id")
    PatientPhoneNumber findById(String id);

    @Query("SELECT * FROM PatientPhoneNumber WHERE personId=:id")
    PatientPhoneNumber findByPersonId(String id);



}
