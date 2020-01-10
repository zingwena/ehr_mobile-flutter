package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Result;

@Dao
public interface ResultDao {

    @Insert
    void saveAll(List<Result> results);

    @Query("DELETE FROM Result")
    void deleteAll();

    @Insert
    void saveOne(Result result);

    @Query("SELECT * FROM Result ORDER BY name ASC")
    List<Result> findAll();

    @Query("SELECT * FROM Result WHERE code=:id")
    Result findById(String id);

    @Query("SELECT * FROM Result WHERE code in (:resultIds)")
    List<Result> findByIdsIn(List<String> resultIds);
}

