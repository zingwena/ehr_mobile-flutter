package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;


import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Nationality;

@Dao
public interface NationalityDao {

    @Insert
    void saveAll(List<Nationality> nationalityList);

    @Query("DELETE FROM nationality")
    void deleteAll();

    @Insert
    void saveOne(Nationality nationality);

    @Query("SELECT * FROM nationality ORDER BY name DESC")
    List<Nationality> findAll();


    @Query("SELECT * FROM nationality WHERE code=:id")
    Nationality findById(String id);
}
