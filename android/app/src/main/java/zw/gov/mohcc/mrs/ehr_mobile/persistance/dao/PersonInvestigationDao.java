package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;


@Dao
public interface PersonInvestigationDao {
    @Insert
    void insertPersonInvestigation(List<PersonInvestigation> PersonInvestigations);

    @Query("DELETE FROM PersonInvestigation")
    void deletePersonInvestigations();


    @Insert
    void insertPersonInvestigation(PersonInvestigation PersonInvestigation);

    @Query("SELECT * FROM PersonInvestigation ")
    List<PersonInvestigation> getAllPersonInvestigations();

    @Query("SELECT * FROM PersonInvestigation WHERE id=:id")
    PersonInvestigation findPersonInvestigationById(String id);
}
