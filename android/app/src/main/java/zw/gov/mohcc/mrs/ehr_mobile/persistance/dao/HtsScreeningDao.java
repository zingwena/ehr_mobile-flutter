package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.HtsScreening;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArtInitiation;


@Dao
public interface HtsScreeningDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(HtsScreening htsScreening);

    @Query("DELETE from HtsScreening")
    void deleteAll();

    @Update
    void update(HtsScreening htsScreening);

    @Query("SELECT * FROM HtsScreening")
    List<ArtInitiation> findAll();

    @Query("SELECT * FROM HtsScreening WHERE id =:id")
    HtsScreening findOne(String id);

    @Query("DELETE FROM HtsScreening where id =:id")
    void deleteById(String id);

    @Query("SELECT * FROM HtsScreening WHERE visitId =:visitId")
    HtsScreening findByVisitId(String visitId);
}
