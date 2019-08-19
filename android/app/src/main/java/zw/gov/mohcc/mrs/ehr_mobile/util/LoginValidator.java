package zw.gov.mohcc.mrs.ehr_mobile.util;

import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class LoginValidator {

    private String username, password;
    private EhrMobileDatabase ehrMobileDatabase;

    public LoginValidator(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public static Boolean isValid(int statusCode) {
        return statusCode == 200;
    }



    public static Boolean validateUser(String username, String password) {
        System.out.println("username = " + username);
        System.out.println("password = " + password);
        System.out.println("ehrMobileDatabase = " + ehrMobileDatabase);
        User user = ehrMobileDatabase.userDao().findUserbyUsername(username);
        if (user != null) {
            System.out.println("User found " + user.toString());
            return true;
        }
        return false;
    }


}

