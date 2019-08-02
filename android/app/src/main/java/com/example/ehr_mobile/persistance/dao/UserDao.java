package com.example.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import com.example.ehr_mobile.persistance.model.User;

import java.util.List;

/**
 * Created by Tinotenda Ruzane
 *
 * This is the Room Data Accessing interface for the users table in the local cache
 */

@Dao
public interface UserDao {

    @Query("SELECT * From user")
    List<User> selectAllUsers();

    @Insert
    void insertUsers(List<User> users);
}
