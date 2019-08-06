package com.example.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.Query;

import com.example.ehr_mobile.model.Authorities;
import com.example.ehr_mobile.model.User;


import java.util.List;

@Dao
public interface AuthoritiesDao {
    @Insert
    void insertAuthority(Authorities authority);

    @Insert
    void insertAuthorities(List<Authorities> authorities);

    @Delete
    void delete(Authorities authority);

    @Query("SELECT * FROM authorities")
    List<Authorities> getAllAuthorities();

    @Query("SELECT * FROM Authorities WHERE userId=:userId")
    List<Authorities> findAuthoritiesByUserId(final int userId);
}
