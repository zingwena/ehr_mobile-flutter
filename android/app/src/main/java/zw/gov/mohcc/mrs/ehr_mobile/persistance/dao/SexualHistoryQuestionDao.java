package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.hts.SexualHistory;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.SexualHistoryQuestion;


@Dao
public interface SexualHistoryQuestionDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(SexualHistoryQuestion sexualHistoryQuestion);

    @Query("DELETE from SexualHistoryQuestion")
    void deleteAll();

    @Update
    void update(SexualHistoryQuestion sexualHistoryQuestion);

    @Query("SELECT * FROM SexualHistoryQuestion")
    List<SexualHistoryQuestion> findAll();

    @Query("SELECT * FROM SexualHistoryQuestion WHERE id =:id")
    SexualHistoryQuestion findOne(String id);

    @Query("DELETE FROM SexualHistoryQuestion where id =:id")
    void deleteById(String id);

    @Query("SELECT * FROM SexualHistoryQuestion WHERE sexualHistoryId =:sexualHistoryId")
    SexualHistoryQuestion findBySexualHistoryId(String sexualHistoryId);
}
