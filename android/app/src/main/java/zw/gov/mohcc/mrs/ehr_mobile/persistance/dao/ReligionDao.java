package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;

@Dao
public interface ReligionDao {

    @Insert
    void insertReligions(List<Religion> religions);

    @Query("DELETE FROM religion")
    void deleteReligions();


    @Insert
    void insertReligion(Religion religion);

    @Query("SELECT * FROM Religion")
    List<Religion> getAllReligions();

    @Query("SELECT * FROM Religion WHERE id=:id")
    Religion findReligionById(int id);
}
