package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Country;

@Dao
public interface CountryDao {

    @Insert
    void saveOne(Country country);

    @Query("DELETE FROM country")
    void deleteAll();

    @Insert
    void saveAll(List<Country> countries);

    @Query("SELECT * FROM country ORDER BY name DESC")
    List<Country> findAll();
}
