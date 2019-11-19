package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Country;

@Dao
public interface CountryDao {

    @Insert
    void insertCountry(Country country);

    @Query("DELETE FROM country")
    void deleteCountries();

    @Insert
    void insertCountries(List<Country> countries);

    @Query("SELECT * FROM country ORDER BY name DESC")
    List<Country> getAllCountries();
}
