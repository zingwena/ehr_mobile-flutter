package com.example.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Entity;
import androidx.room.Insert;
import androidx.room.Query;

import com.example.ehr_mobile.model.Country;

import java.util.List;

import static android.icu.text.MessagePattern.ArgType.SELECT;
import static com.google.common.net.HttpHeaders.FROM;

@Dao
public interface CountryDao {

    @Insert
    void insertCountry(Country country);

    @Insert
    void insertCountries(List<Country> countries);

    @Query("SELECT * FROM country")
    List<Country> getAllCountries();
}
