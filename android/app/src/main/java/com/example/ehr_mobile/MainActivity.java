package com.example.ehr_mobile;

import android.os.Bundle;

import com.example.ehr_mobile.configuration.RetrofitClient;
import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.MaritalStates;
import com.example.ehr_mobile.model.Occupation;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.service.DataSyncService;

import java.util.ArrayList;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;

public class MainActivity extends FlutterActivity {

    final static String CHANNEL = "Authentication";

    public String url, username, password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
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
                            getOccupation(token, url + "/api/");
                            System.out.println("%%%%%%%%%%%%%" + token);

                        }

                        @Override
                        public void onFailure(Call<Token> call, Throwable t) {
                            System.out.println("Error=============== " + t);
                        }
                    });
                }
            }
        });
    }

    public void getMaritalStates(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
    Call<MaritalStates> call= service.getMaritalStates("Bearer "+token.getId_token());

    call.enqueue(new Callback<MaritalStates>() {
        @Override
        public void onResponse(Call<MaritalStates> call, Response<MaritalStates> response) {
            System.out.println("--------------------------"+ response.body());
        }

        @Override
        public void onFailure(Call<MaritalStates> call, Throwable t) {
            System.out.println("getMaritalStaes throws  "+ t.getMessage());
        }
    });
    }

    public void getOccupation(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<Occupation> call = service.getOccupation("Bearer " + token.getId_token());
        call.enqueue(new Callback<Occupation>() {
            @Override
            public void onResponse(Call<Occupation> call, Response<Occupation> response) {
                System.out.println("*************************** " + response.body());
            }

            @Override
            public void onFailure(Call<Occupation> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);
            }
        });
    }

    /*
    TODO refactor this method to follow getMaritalStates
    public void getUsers(Token token, String baseUrl) {
        DataSyncService service= RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<List<User>> call = service.getAllUsers("Bearer "+ token.getId_token());

        call.enqueue(new Callback<List<User>>() {
            @Override
            public void onResponse(Call<List<User>> call, Response<List<User>> response) {

                List<User> userList = response.body();
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
    }*/

}
