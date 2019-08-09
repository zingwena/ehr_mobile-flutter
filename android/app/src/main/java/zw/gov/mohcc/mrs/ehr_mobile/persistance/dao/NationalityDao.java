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

    @Insert
    void insertNationality(Nationality nationality);

    @Query("SELECT * FROM nationality")
    List<Nationality> selectAllNationalities();

    @Query("SELECT * FROM nationality WHERE id=:id")
    Nationality selectNationality(int id);
}
