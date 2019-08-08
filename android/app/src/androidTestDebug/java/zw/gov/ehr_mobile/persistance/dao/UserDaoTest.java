package zw.gov.ehr_mobile.persistance.dao;

import android.content.Context;
import android.support.test.InstrumentationRegistry;
import android.support.test.runner.AndroidJUnit4;

import androidx.room.Room;

import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.UserDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import com.example.ehr_mobile.persistance.model.User;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(AndroidJUnit4.class)
public class UserDaoTest  {
  private   EhrMobileDatabase ehrMobileDatabase;
  private UserDao userDao;
    public  List<User> users=new ArrayList<>();

  @Before
    public void createDb() {

  Context context= InstrumentationRegistry.getTargetContext();
  ehrMobileDatabase= Room.inMemoryDatabaseBuilder(context,EhrMobileDatabase.class).build();
  userDao=ehrMobileDatabase.userDao();
  }

  @After
    public void close() throws IOException {
      ehrMobileDatabase.close();
  }

  @Test
    public void testRetriveUser() throws Exception{


       User user= new User(1,"tino","tino",
               "tino","tinoruzane@gmail.com",
               "","no","jjj",
               "lillian","20-03-2015",
               "","","USER");
         userDao.createUser(user);
         users.add(user);
         userDao.insertAllUsers(users);
      List<User> result= userDao.selectAllUsers();
      int expected=2;
      assertEquals(result.size(),expected);
  }
}