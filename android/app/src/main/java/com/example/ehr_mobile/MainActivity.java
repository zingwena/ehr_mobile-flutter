package com.example.ehr_mobile;

import android.os.Bundle;
import android.util.Log;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import com.example.ehr_mobile.configuration.DataService;
import com.example.ehr_mobile.configuration.RetrofitClientInstance;
import com.example.ehr_mobile.configuration.apolloClient.PatientsApolloClient;
import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.MaritalStates;
import com.example.ehr_mobile.model.Nationality;
import com.example.ehr_mobile.model.Occupation;
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

        authenticate(login);

        ehrMobileDatabase = EhrMobileDatabase.getInstance(getApplication());

        System.out.println("***************** Users" + ehrMobileDatabase.userDao().selectAllUsers());

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
                    getOcccupations(token);

                    // get patients
                    PatientsApolloClient.getPatientsFromEhr(ehrMobileDatabase);
                    int numberOfPatients=ehrMobileDatabase.patientDao().listPatients().size();
                    Log.d("Number of Patients",String.valueOf(numberOfPatients));
                    getNationalities(token);

                }

            }

            @Override
            public void onFailure(Call<Token> call, Throwable t) {

            }
        });

        return token;
    }


    private void getOcccupations(Token token) {

        System.out.println("In Get Occupations: "+token.getId_token());
        DataService service= RetrofitClientInstance.getRetrofit().create(DataService.class);
        Call<Occupation> call = service.getAllOccupations("Bearer " + token.getId_token());

        call.enqueue(new Callback<Occupation>() {
            @Override
            public void onResponse(Call<Occupation> call, Response<Occupation> response) {
                System.out.println("************"+ response.body());
            }

            @Override
            public void onFailure(Call<Occupation> call, Throwable t) {
                System.out.println("##############" + t.getMessage());

            }
        });
    }


    public void getUsers(Token token) {
        DataService service = RetrofitClientInstance.getRetrofit().create(DataService.class);
        Call<List<User>> call = service.getAllUsers("Bearer " + token.getId_token());

        call.enqueue(new Callback<List<User>>() {
            @Override
            public void onResponse(Call<List<User>> call, Response<List<User>> response) {

                userList = response.body();
                User user = new User();
                for (int i = 0; i < userList.size(); i++) {
                    System.out.println(user.convertArrayToList(userList.get(i).getAuthorities()));
                }
                System.out.println("****************" + response.body());
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

    public void getNationalities(Token token) {

        DataService service = RetrofitClientInstance.getRetrofit().create(DataService.class);
        Call<Nationality> call = service.getNationality("Bearer " + token.getId_token());
        call.enqueue(new Callback<Nationality>() {
            @Override
            public void onResponse(Call<Nationality> call, Response<Nationality> response) {
                System.out.println("Nationalities     " + response.body());
            }

            @Override
            public void onFailure(Call<Nationality> call, Throwable t) {
                System.out.println("ERRRRRRORRRRRRRRRRRRRt" + t);
            }
        });
    }

}
