package zw.gov.mohcc.mrs.ehr_mobile;

import org.junit.Test;

import java.io.IOException;

import retrofit2.Call;
import retrofit2.Retrofit;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;

public class MainActivityTest {

    @Test
    public void onCreate() throws IOException {
        Login login = new Login("admin", "admin");

//        LoginValidator.isValid(login);


        Retrofit retrofitInstance = RetrofitClient.getRetrofitInstance("http://10.20.100.178:8080" + "/api/");
        DataSyncService dataSyncService = retrofitInstance.create(DataSyncService.class);
        Call<Token> call = dataSyncService.dataSync(login);
        int statusCode = call.execute().code();


        String username=login.getUsername();
        String password=login.getPassword();

//        LoginValidator.isUserValid(ehrMobileDatabase,username,password);
//        assertTrue(LoginValidator.isValid(statusCode));
//        assertTrue( !isValid(statusCode));
        System.out.println("password = " + password);

    }

    private Boolean isValid(int statusCode) {
        return statusCode == 200;
    }


    private String returnErrorMessage(String username) {
        return "Invalid username or password " + username;
    }

    private String loadHomeScreen(String username) {
        return "Welcome To EHR Mobile  " + username;
    }
}