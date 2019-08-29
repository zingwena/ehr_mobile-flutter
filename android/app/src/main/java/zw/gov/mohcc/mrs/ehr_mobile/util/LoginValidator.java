package zw.gov.mohcc.mrs.ehr_mobile.util;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import static java.lang.System.out;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

/**
 * @author kombo on 8/21/19
 */


public class LoginValidator {


    public static Boolean isUserValid(EhrMobileDatabase database, String username, String password) {

        User user = database.userDao().findUserbyUsername(username);
        return user != null && password.equals("password");
    }
}

