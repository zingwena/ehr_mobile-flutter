package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import zw.gov.mohcc.mrs.ehr_mobile.model.User;

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

    @Query("SELECT * FROM user WHERE userId=:id ")
    User findUserByid(int id);

    @Query("DELETE FROM user")
    void deleteUsers();

    @Insert
    void insertAllUsers(List<User> users);

    @Insert
    void createUser(User user);

    @Query("SELECT * FROM user where login=:username")
    User findUserbyUsername(String username);
}
