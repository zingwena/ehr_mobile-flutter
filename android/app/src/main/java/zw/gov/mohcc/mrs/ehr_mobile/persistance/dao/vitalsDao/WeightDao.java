package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Weight;

@Dao
public interface WeightDao {
    @Insert
    void insert(Weight weight);

    @Query("SELECT * From Weight")
    List<Weight> getAll();

    @Query("Delete From Weight")
    void deleteAll();

    @Query("SELECT * From Weight Where personId=:personId")
    List<Weight> findByPersonId(String personId);

    @Query("SELECT * From Weight Where personId=:personId Order By dateTime DESC limit 1")
    Weight findLatestRecordByPersonId(String personId);
}
