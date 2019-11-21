package zw.gov.mohcc.mrs.ehr_mobile.converter;

import android.util.Log;

import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

/**
 * @author kombo on 8/21/19
 */


public class LoginValidator {


    public static Boolean isUserValid(EhrMobileDatabase database, String username, String password) {

        User user = database.userDao().findUserbyUsername(username);
        Log.d("Login Validator", "User details here : " + user);
        return  true/*user != null && password.equals("password")*/;
    }
}

