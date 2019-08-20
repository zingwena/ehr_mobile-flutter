//package zw.gov.mohcc.mrs.ehr_mobile.util;
//
//import android.content.Context;
//
//import androidx.room.Room;
//
//import org.junit.After;
//import org.junit.Assert;
//import org.junit.Before;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.junit.runners.JUnit4;
//
//import java.io.IOException;
//
//import zw.gov.mohcc.mrs.ehr_mobile.model.User;
//import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.UserDao;
//import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
//
//@RunWith(JUnit4.class)
//public class LoginValidatorTest {    private UserDao userDao;
//    private EhrMobileDatabase db;
//
//    @Before
//    public void createDb() {
//        Context context = ApplicationProvider.getApplicationContext();
//        db = Room.inMemoryDatabaseBuilder(context, EhrMobileDatabase.class).build();
//        userDao = db.userDao();
//    }
//
//
//
//    @After
//    public void closeDb() throws IOException {
//        db.close();
//    }
//
//
//    @Test
//    public void isUserValid() {
//
//
//      User user=  userDao.findUserbyUsername("admin");
//
//
//        Assert.assertEquals("admin",user.getLogin());
//
//    }
//}