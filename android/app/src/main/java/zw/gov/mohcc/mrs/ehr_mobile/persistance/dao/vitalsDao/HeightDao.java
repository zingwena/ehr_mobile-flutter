package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Height;

@Dao
public interface HeightDao {
    @Insert
    void insert(Height height);

    @Query("SELECT * From Height")
    List<Height> getAll();

    @Query("Delete From Height")
    void deleteAll();

    @Query("SELECT * From Height Where personId=:personId Order By dateTime DESC limit 1")
    Height findLatestRecordByPersonId(String personId);
}
