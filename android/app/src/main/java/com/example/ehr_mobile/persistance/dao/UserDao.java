package com.example.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import com.example.ehr_mobile.model.User;

import java.util.List;

/**
 * Created by Tinotenda Ruzane
 *
 * This is the Room Data Accessing interface for the users table in the local cache
 */
@Dao
public interface UserDao {

    @Insert
    void insertUsers(List<User> users);

    @Query("SELECT * From user")
    List<User> selectAllUsers();

<<<<<<< HEAD
    @Query("SELECT * FROM user WHERE userId=:id ")
    User findUserByid(int id);

=======
    @Insert
    void insertAllUsers(List<User> users);

    @Insert
    void createUser(User user);
>>>>>>> 31e970dfb1d834742af8c642097ad8999ddb9f7a
}
