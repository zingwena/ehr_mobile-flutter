package zw.gov.mohcc.mrs.ehr_mobile.util;

public class LoginValidator {
    public static Boolean isValid(int statusCode) {
        return statusCode == 200;
    }
}
