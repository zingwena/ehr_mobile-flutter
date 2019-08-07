package com.example.ehr_mobile;

import android.os.Bundle;

import com.example.ehr_mobile.configuration.RetrofitClient;
import com.example.ehr_mobile.configuration.apolloClient.PatientsApolloClient;
import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.MaritalStates;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.persistance.database.EhrMobileDatabase;
import com.example.ehr_mobile.service.DataSyncService;

import java.util.ArrayList;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class MainActivity extends FlutterActivity {

    final static String CHANNEL = "Authentication";
    private EhrMobileDatabase database;
    public String url, username, password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        database=EhrMobileDatabase.getInstance(getApplicationContext());
        PatientsApolloClient.getPatientsFromEhr(database);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler((methodCall, result) -> {
            if (methodCall.method.equals("DataSync")) {

                ArrayList args = methodCall.arguments();
                url = args.get(0).toString();
                username = args.get(1).toString();
                password = args.get(2).toString();
                Login login = new Login(username, password);

                Retrofit retrofitInstance = RetrofitClient.getRetrofitInstance(url + "/api/");


                DataSyncService dataSyncService = retrofitInstance.create(DataSyncService.class);
                Call<Token> call = dataSyncService.dataSync(login);


                call.enqueue(new Callback<Token>() {
                    @Override
                    public void onResponse(Call<Token> call, Response<Token> response) {

                        Token token = response.body();
                        getMaritalStates(token, url + "/api/");
                        System.out.println("%%%%%%%%%%%%%" + token);
                        PatientsApolloClient.getPatientsFromEhr(database);

                    }

                    @Override
                    public void onFailure(Call<Token> call, Throwable t) {
                        System.out.println("----------------------------------------------" + t.getMessage());
                    }
                });


            }
        });
    }

    public void getMaritalStates(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
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