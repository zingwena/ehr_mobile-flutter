package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import zw.gov.mohcc.mrs.ehr_mobile.model.Country;

import java.util.List;

@Dao
public interface CountryDao {

    @Insert
    void insertCountry(Country country);

    @Insert
    void insertCountries(List<Country> countries);

    @Query("SELECT * FROM country")
    List<Country> getAllCountries();
}
