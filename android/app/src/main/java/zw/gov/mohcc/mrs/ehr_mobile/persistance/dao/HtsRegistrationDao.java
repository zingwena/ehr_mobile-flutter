package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.HtsRegistration;

@Dao
public interface HtsRegistrationDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long createHtsRegistration(HtsRegistration htsRegistration);

    @Query("DELETE from HtsRegistration")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM PreTest WHERE id =:id")
    int getNumberOfRows(int id);

    @Update
    int updateHtsRegistration(HtsRegistration htsRegistration);

    @Query("SELECT * FROM HtsRegistration ORDER BY id Asc")
    List<HtsRegistration> listHtsRegistration();

    @Query("SELECT * FROM HtsRegistration WHERE id =:id")
    PreTest findHtsRegistrationById(int id);

    @Query("DELETE FROM HtsRegistration where id = :id")
    void deleteById(Long id);

    @RawQuery
    List<HtsRegistration> searchHtsRegistration(SimpleSQLiteQuery query);

//

}
