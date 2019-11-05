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
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;

@Dao
public interface HtsscreeningDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void createHtsscreening(HtsScreening htsScreening);

    @Query("DELETE from Hts")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM Hts WHERE id =:htsId")
    int getNumberOfRows(String htsId);

    @Update
    void updateHts(Hts hts);

    @Query("SELECT * FROM Hts")
    List<Hts> listHts();

    @Query("SELECT * FROM Hts WHERE id =:htsId")
    Hts findHtsById(String htsId);

    @Query("SELECT * FROM Hts WHERE personId =:personId")
    Hts findHtsByPersonId(String personId);

    @Query("DELETE FROM Hts where id = :id")
    void deleteById(String id);

    @RawQuery
    List<Hts> searchHts(SimpleSQLiteQuery query);

    @Query("SELECT * FROM Hts WHERE visitId =:visitId")
    Hts findCurrentHts(String visitId);

}
