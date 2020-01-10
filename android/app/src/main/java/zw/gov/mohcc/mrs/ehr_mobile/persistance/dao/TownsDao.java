package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;


import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Town;

@Dao
public interface TownsDao {

    @Insert
    void saveAll(List<Town> towns);

    @Query("SELECT * FROM town order by name asc")
    List<Town> findAll();

    @Query("DELETE FROM town")
    void deleteAll();
}
