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

    @Query("DELETE FROM Result")
    void deleteResults();


    @Insert
    void insertReligion(Result result);

    @Query("SELECT * FROM Result ")
    List<Result> getAllReligions();
