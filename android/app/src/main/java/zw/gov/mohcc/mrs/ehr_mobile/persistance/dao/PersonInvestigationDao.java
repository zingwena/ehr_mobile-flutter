package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;


@Dao
public interface PersonInvestigationDao {
    @Insert
    void insertPersonInvestigation(List<PersonInvestigation> personInvestigations);

    @Query("DELETE FROM PersonInvestigation")
    void deletePersonInvestigations();


    @Insert
    void insertPersonInvestigation(PersonInvestigation PersonInvestigation);

    @Update
    void update(PersonInvestigation PersonInvestigation);

    @Query("SELECT * FROM PersonInvestigation ")
    List<PersonInvestigation> getAllPersonInvestigations();

    @Query("SELECT * FROM PersonInvestigation WHERE id=:id")
    PersonInvestigation findPersonInvestigationById(String id);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId and date =:dateOfHivTest")
    PersonInvestigation findByPersonIdAndDate(String personId, long dateOfHivTest);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId")
    PersonInvestigation findByPersonId(String personId);
}
