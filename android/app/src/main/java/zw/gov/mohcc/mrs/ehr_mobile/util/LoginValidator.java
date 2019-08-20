package zw.gov.mohcc.mrs.ehr_mobile.util;

import org.jetbrains.annotations.NotNull;

import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class LoginValidator {


    public static Boolean isValid(int statusCode) {
        return statusCode == 200;
    }




}

