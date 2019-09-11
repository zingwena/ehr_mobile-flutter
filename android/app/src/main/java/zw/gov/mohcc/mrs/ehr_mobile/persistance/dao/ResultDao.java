package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Result;

@Dao
public interface ResultDao {

    @Insert
    void insertResult(List<Result> results);

    @Query("DELETE FROM result")
    void deleteResults();


    @Insert
    void insertResults(Result result);

    @Query("SELECT * FROM Result ORDER BY  name ASC")
    List<Result> getAllResults();

    @Query("SELECT * FROM Result WHERE code=:id")
    Result findByResultId(String id);
}

