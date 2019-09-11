package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;


import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;

@Dao
public interface NationalityDao {

    @Insert
    void insertNationalities(List<Nationality> nationalityList);

    @Query("DELETE FROM nationality")
    void deleteNationalities();

    @Insert
    void insertNationality(Nationality nationality);

    @Query("SELECT * FROM nationality ORDER BY name ASC")
    List<Nationality> selectAllNationalities();

    @Query("SELECT name FROM nationality WHERE code=:id")
    String selectNationality(String id);
}
