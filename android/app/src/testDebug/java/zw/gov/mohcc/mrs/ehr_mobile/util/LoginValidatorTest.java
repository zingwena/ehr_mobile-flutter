package zw.gov.mohcc.mrs.ehr_mobile.util;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;

import androidx.room.Room;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import java.io.IOException;

import io.flutter.app.FlutterActivity;
import retrofit2.Call;
import retrofit2.Retrofit;
import zw.gov.mohcc.mrs.ehr_mobile.MainActivity;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.UserDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;


import static org.junit.Assert.*;

@RunWith(
        JUnit4.class)
public class LoginValidatorTest {
    private UserDao userDao;
//    private EhrMobileDatabase db=         EhrMobileDatabase.getDatabaseInstance(getApplication());




    @Test
    public void validateUser() throws IOException {

        Retrofit retrofitInstance = RetrofitClient.getRetrofitInstance("http://10.20.100.178:8080" + "/api/");
        DataSyncService dataSyncService = retrofitInstance.create(DataSyncService.class);
        Login login = new Login("system", "system");
        String username = login.getUsername();
        String password = login.getPassword();
        Call<Token> call = dataSyncService.dataSync(login);
        int statusCode = call.execute().code();


      Boolean valid=LoginValidator.validateUser(username,password);


        assertTrue(valid);
//        assertTrue( !isValid(statusCode));
    }
}