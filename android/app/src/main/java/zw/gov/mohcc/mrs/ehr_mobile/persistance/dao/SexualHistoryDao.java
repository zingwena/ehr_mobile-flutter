package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.hts.SexualHistory;


@Dao
public interface SexualHistoryDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(SexualHistory sexualHistory);

    @Query("DELETE from SexualHistory")
    void deleteAll();

    @Update
    void update(SexualHistory sexualHistory);

    @Query("SELECT * FROM SexualHistory")
    List<SexualHistory> findAll();

    @Query("SELECT * FROM SexualHistory WHERE id =:id")
    SexualHistory findOne(String id);

    @Query("DELETE FROM SexualHistory where id =:id")
    void deleteById(String id);

    @Query("SELECT * FROM SexualHistory WHERE personId =:personId")
    SexualHistory findByPersonId(String personId);
}
