package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;
import java.util.Set;

import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;


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

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId AND (:dateOfHivTest Between date and :endOfDay)")
    PersonInvestigation findByPersonIdAndDate(String personId, long dateOfHivTest, long endOfDay);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId")
    PersonInvestigation findByPersonId(String personId);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId and investigationId=:investigationId and resultId=:resultId")
    PersonInvestigation findByPersonIdAndInvestigationIdAndResultId(String personId, String investigationId, String resultId);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId and resultId=:negativeHivResult and investigationId in (:hivTests) order by date Desc limit 1,0")
    PersonInvestigation findTopByPersonIdAndResultNameAndInvestigationIdInOrderByDateDesc(
            String personId, String negativeHivResult, Set<String> hivTests);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId and investigationId in (:investigations) order by date Desc limit 1")
    PersonInvestigation findTopByPersonIdAndInvestigationIdInOrderByDateDesc(
            String personId, Set<String> investigations);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId order by date Desc limit 3")
    List<PersonInvestigation> findLatestThreeTestsByPersonId(String personId);
}
