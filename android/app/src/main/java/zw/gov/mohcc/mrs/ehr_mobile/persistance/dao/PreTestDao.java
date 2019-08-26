package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;
import zw.gov.mohcc.mrs.ehr_mobile.model.PreTest;

@Dao
public interface PreTestDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long createPreTest(PreTest preTest);

    @Query("DELETE from PreTest")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM PreTest WHERE id =:id")
    int getNumberOfRows(int id);

    @Update
    int updatePreTest(PreTest preTest);

    @Query("SELECT * FROM PreTest ORDER BY id Asc")
    List<PreTest> listPreTests();

    @Query("SELECT * FROM PreTest WHERE id =:id")
    PreTest findPreTestById(int id);

    @Query("DELETE FROM PreTest where id = :id")
    void deleteById(Long id);

    @RawQuery
    List<PreTest> searchPreTest(SimpleSQLiteQuery query);

//

}
