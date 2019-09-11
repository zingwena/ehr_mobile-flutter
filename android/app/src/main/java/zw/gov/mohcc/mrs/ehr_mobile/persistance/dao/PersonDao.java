package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Person;

@Dao
public interface PersonDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long createPatient(Person person);

    @Query("DELETE from Person")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM Person WHERE id =:id")
    int getNumberOfRows(int id);

    @Update
    int updatePatient(Person person);

    @Query("SELECT * FROM Person ORDER BY firstName Asc")
    List<Person> listPatients();

    @Query("SELECT * FROM Person WHERE id =:id")
    Person findPatientById(int id);

    @Query("DELETE FROM Person where id = :id")
    void deleteById(Long id);

    @RawQuery
    List<Person> searchPatient(SimpleSQLiteQuery query);

//

    @Query("SELECT * FROM Person WHERE nationalId=:number ")
    Person findPatientByNationalId(String number);

    @Query("SELECT * FROM Person WHERE firstName=:firstName AND lastName=:lastName")
    Person findPatientByName (String firstName, String lastName);
}
