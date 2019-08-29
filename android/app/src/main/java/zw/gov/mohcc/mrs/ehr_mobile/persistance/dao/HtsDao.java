package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsRegistration;
import zw.gov.mohcc.mrs.ehr_mobile.model.PreTest;

@Dao
public interface HtsDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long createHts(Hts hts);

    @Query("DELETE from Hts")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM Hts WHERE id =:id")
    int getNumberOfRows(int id);

    @Update
    int updateHts(Hts hts);

    @Query("SELECT * FROM Hts ORDER BY id Asc")
    List<Hts> listHts();

    @Query("SELECT * FROM Hts WHERE id =:id")
    Hts findHtsById(int id);

    @Query("DELETE FROM Hts where id = :id")
    void deleteById(Long id);

    @RawQuery
    List<Hts> searchHts(SimpleSQLiteQuery query);




}
