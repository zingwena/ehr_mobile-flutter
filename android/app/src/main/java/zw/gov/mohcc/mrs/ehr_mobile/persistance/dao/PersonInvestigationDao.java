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

    @Query("DELETE FROM PersonInvestigation")
    void deleteAll();

    @Insert
    void save(PersonInvestigation PersonInvestigation);

    @Update
    void update(PersonInvestigation PersonInvestigation);

    @Query("SELECT * FROM PersonInvestigation ")
    List<PersonInvestigation> findAll();

    @Query("SELECT * FROM PersonInvestigation WHERE id=:id")
    PersonInvestigation findById(String id);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId AND (:dateOfHivTest Between date and :endOfDay)")
    PersonInvestigation findByPersonIdAndDate(String personId, long dateOfHivTest, long endOfDay);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId")
    PersonInvestigation findByPersonId(String personId);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId and investigationId=:investigationId and result=:resultId")
    PersonInvestigation findByPersonIdAndInvestigationIdAndResultId(String personId, String investigationId, String resultId);

    @Query("SELECT count(*) FROM PersonInvestigation WHERE personId=:personId and investigationId in(:investigationIds) and result=:resultId")
    int existsByPersonIdAndInvestigationIdAndResultId(String personId, String [] investigationIds, String resultId);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId and result=:hivResult and investigationId in (:hivTests) order by date Desc limit 1")
    PersonInvestigation findTopByPersonIdAndResultNameAndInvestigationIdInOrderByDateDesc(
            String personId, String hivResult, Set<String> hivTests);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId and investigationId in (:investigations) order by date Desc limit 1")
    PersonInvestigation findTopByPersonIdAndInvestigationIdInOrderByDateDesc(
            String personId, Set<String> investigations);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId and investigationId in (:investigations)")
    int existsbyPersonIdAndInvestigationIdIn(
            String personId, Set<String> investigations);

    @Query("SELECT * FROM PersonInvestigation WHERE personId=:personId order by date Desc limit 3")
    List<PersonInvestigation> findLatestThreeTestsByPersonId(String personId);
}
