package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Religion;

@Dao
public interface ReligionDao {

    @Insert
    void saveAll(List<Religion> religions);

    @Query("DELETE FROM religion")
    void deleteAll();

    @Insert
    void saveOne(Religion religion);

    @Query("SELECT * FROM Religion ORDER BY name ASC")
    List<Religion> getAllReligions();

    @Query("SELECT * FROM Religion WHERE code=:id")
    Religion findById(String id);
}
