package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.person.PersonPhone;

@Dao
public interface PersonPhoneDao {

    @Insert
    void saveAll(List<PersonPhone> personPhones);

    @Query("DELETE FROM PersonPhone")
    void deleteAll();


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long saveOne(PersonPhone personPhone);


    @Query("SELECT * FROM PersonPhone WHERE id=:id")
    PersonPhone findById(String id);

    @Query("SELECT * FROM PersonPhone WHERE personId=:id")
    PersonPhone findByPersonId(String id);
}
