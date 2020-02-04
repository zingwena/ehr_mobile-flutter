package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.hts.HtsScreening;

@Dao
public interface HtsScreeningDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(HtsScreening htsScreening);

    @Query("DELETE from HtsScreening")
    void deleteAll();

    @Update
    void update(HtsScreening htsScreening);

    @Query("SELECT * FROM HtsScreening")
    List<HtsScreening> findAll();

    @Query("SELECT * FROM HtsScreening WHERE id =:id")
    HtsScreening findOne(String id);

    @Query("DELETE FROM HtsScreening where id =:id")
    void deleteById(String id);

    @Query("SELECT * FROM HtsScreening WHERE visitId =:visitId")
    HtsScreening findByVisitId(String visitId);

    @Query("SELECT s.* FROM HtsScreening s,Visit v WHERE s.visitId == v.id AND v.personId=:personId")
    List<HtsScreening> findByPersonId(String personId);

}
