package com.example.ehr_mobile;

import android.os.Bundle;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import com.example.ehr_mobile.configuration.DataService;
import com.example.ehr_mobile.configuration.RetrofitClientInstance;
import com.example.ehr_mobile.configuration.apolloClient.PatientsApolloClient;
import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.MaritalStates;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.model.User;
import com.example.ehr_mobile.persistance.database.EhrMobileDatabase;

import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    public List<User> userList;

    public Token token;
    EhrMobileDatabase ehrMobileDatabase;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        Login login = new Login("admin", "admin");

        PatientsApolloClient.getPatientsFromEhr();
        authenticate(login);

        ehrMobileDatabase = EhrMobileDatabase.getInstance(getApplication());


    }


    public Token authenticate(Login login) {

        DataService service = RetrofitClientInstance.getRetrofit().create(DataService.class);
        Call<Token> call = service.getToken(login);

        call.enqueue(new Callback<Token>() {
            @Override
            public void onResponse(Call<Token> call, Response<Token> response) {

                if (response.isSuccessful()) {
                    token = response.body();
                    getUsers(token);
                    getMatitalStates(token);
                }

            }

            @Override
            public void onFailure(Call<Token> call, Throwable t) {

            }
        });

        return token;
    }


    public void getUsers(Token token) {
        DataService service = RetrofitClientInstance.getRetrofit().create(DataService.class);
        Call<List<User>> call = service.getAllUsers("Bearer " + token.getId_token());

        call.enqueue(new Callback<List<User>>() {
            @Override
            public void onResponse(Call<List<User>> call, Response<List<User>> response) {

        userList=response.body();
        User user= new User();

        System.out.println("****************"+ response.body());
      }

            @Override
            public void onFailure(Call<List<User>> call, Throwable t) {
                System.out.println("-------------------" + t.getMessage());
            }
        });
    }

    public void getMatitalStates(Token token) {

        DataService service = RetrofitClientInstance.getRetrofit().create(DataService.class);
        Call<MaritalStates> call = service.getMaritalStates("Bearer " + token.getId_token());
        call.enqueue(new Callback<MaritalStates>() {
            @Override
            public void onResponse(Call<MaritalStates> call, Response<MaritalStates> response) {
                System.out.println("Marital states     " + response.body());
            }

            @Override
            public void onFailure(Call<MaritalStates> call, Throwable t) {
                System.out.println("tttttttttttttttttttttttt" + t);
            }
        });
    }

}
