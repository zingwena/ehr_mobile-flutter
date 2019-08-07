package com.example.ehr_mobile;

import android.os.Bundle;
import android.util.Log;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import com.example.ehr_mobile.configuration.DataService;
import com.example.ehr_mobile.configuration.RetrofitClientInstance;
import com.example.ehr_mobile.model.Authorities;
import com.example.ehr_mobile.model.Country;
import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.MaritalState;
import com.example.ehr_mobile.model.Nationality;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.model.User;
import com.example.ehr_mobile.persistance.database.EhrMobileDatabase;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;


import java.util.ArrayList;
import java.util.List;

import com.example.ehr_mobile.configuration.RetrofitClient;

import com.example.ehr_mobile.service.DataSyncService;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import retrofit2.Retrofit;

public class MainActivity extends FlutterActivity {


  public List<User> userList;
  final static  String CHANNEL="Authentication";


  public Token token;
     EhrMobileDatabase ehrMobileDatabase;
  public String url,username,password;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if(methodCall.method.equals("DataSync")){

    ArrayList args= methodCall.arguments();
     url=args.get(0).toString();
     username=args.get(1).toString();
     password= args.get(2).toString();
            Login login= new Login(username,password);

     Retrofit retrofitInstance= RetrofitClient.getRetrofitInstance(url+"/api/");


     DataSyncService dataSyncService = retrofitInstance.create(DataSyncService.class);
           Call <Token> call = dataSyncService.dataSync(login);


           call.enqueue(new Callback<Token>() {
               @Override
               public void onResponse(Call<Token> call, Response<Token> response) {

                   Token token= response.body();
                    getUsers(token,url+"/api/");
                    getMaritalStates(token,url+"/api/");
                    getNationalities(token,url+"/api/");
                    getCountries(token,url+"/api/");
                   System.out.println("%%%%%%%%%%%%%"+token);
               }

               @Override
               public void onFailure(Call<Token> call, Throwable t) {
                   System.out.println("----------------------------------------------"+t.getMessage());
               }
           });


        }
      }
    });
  }


    //tino 2

//mine
    public void getMaritalStates(Token token, String baseUrl){

        DataSyncService service= RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<JsonObject> call= service.getMaritalStates("Bearer "+ token.getId_token());

        call.enqueue(new Callback<JsonObject>() {
            @Override
            public void onResponse(Call<JsonObject> call, Response<JsonObject> response) {
                if(response.isSuccessful()){
                    JsonArray maritalStatesJson = response.body().getAsJsonArray("content");

                    List<MaritalState> maritalStates = new ArrayList<>();

                    maritalStatesJson.forEach(maritalState ->
                            maritalStates.add(new MaritalState(maritalState.getAsJsonObject().get("code").toString(),maritalState.getAsJsonObject().get("name").toString()))
                    );

                    saveMaritalStatesToDB(maritalStates);

                    System.out.println("Maritaaaaaaaaaaaal Staaates"+maritalStates);

                }
                else{
                    Log.d("onResponseFailed", response.errorBody().toString());
                }

            }

            @Override
            public void onFailure(Call<JsonObject> call, Throwable t) {
                Log.d("onFailed", t.fillInStackTrace().toString());

            }
        });
    }

    public void getUsers(Token token, String baseUrl){
        DataSyncService service= RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<List<User>> call= service.getAllUsers("Bearer "+ token.getId_token());

        call.enqueue(new Callback<List<User>>() {
            @Override
            public void onResponse(Call<List<User>> call, Response<List<User>> response) {

                userList=response.body();

                System.out.println("user instance&&&&&&&&&&&&&&&&&&"+userList);

                //saveUsersToDB(userList);

            }

            @Override
            public void onFailure(Call<List<User>> call, Throwable t) {
                System.out.println("-------------------"+ t.getMessage());
            }
        });
    }



//tino
    public void getNationalities(Token token, String baseUrl) {

        DataSyncService service= RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<JsonObject> call= service.getNationalities("Bearer "+ token.getId_token());
        call.enqueue(new Callback<JsonObject>() {
            @Override
            public void onResponse(Call<JsonObject> call, Response<JsonObject> response) {

            }

            @Override
            public void onFailure(Call<JsonObject> call, Throwable t) {

            }
        });
    }


    public void getCountries(Token token, String baseUrl){
        System.out.println("[[[[[[[[[[[[[[[[[[[[running first");


        DataSyncService service= RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<JsonObject> call = service.getCountries("Bearer "+token.getId_token());

        call.enqueue(new Callback<JsonObject>() {
            @Override
            public void onResponse(Call<JsonObject> call, Response<JsonObject> response) {
                if(response.isSuccessful()){

                    JsonArray jsonCountries = response.body().getAsJsonArray("content");

                    List<Country> countries = new ArrayList<>();

                    jsonCountries.forEach(country-> {

                        countries.add(new Country(country.getAsJsonObject().get("code").toString(),country.getAsJsonObject().get("name").toString()));
                    });

                    saveCountriesToDB(countries);

                    System.out.println(countries.toString());

                }
                else {
                    response.message();
                    System.out.println("something went wrong");

                }
            }

            @Override
            public void onFailure(Call<JsonObject> call, Throwable t) {
                Log.d("onFailure", t.toString());

            }
        });

    }

    void saveUsersToDB(List<User> userListInstance){

        ehrMobileDatabase.userDao().insertUsers(userListInstance);
        List<User> usersFromDB = ehrMobileDatabase.userDao().selectAllUsers();
        System.out.println("froooooooooooooooom DB"+usersFromDB);
        saveAuthorities(usersFromDB);
        System.out.println("user by iiiiiidd%%%%%%%%%%%%%%%%%%"+ehrMobileDatabase.userDao().findUserByid(1));

    }

    void saveAuthorities(List<User> usersFromDB){
        List<Authorities> authorities = new ArrayList<>();

        usersFromDB.forEach(user ->

                userList.forEach(user1 ->
                        user1.getAuthorities().forEach(authority ->
                                authorities.add(new Authorities(user.getUserId(),authority)))
                )

        );
        ehrMobileDatabase.authoritiesDao().insertAuthorities(authorities);

        System.out.println("froooooooooooooom DB================="+ehrMobileDatabase.authoritiesDao().getAllAuthorities());
        //ehrMobileDatabase.permissionsDao().insertPermissions();
        testById(1);


    }

    void testById(int id){
        System.out.println("get by id --------------"+ehrMobileDatabase.authoritiesDao().findAuthoritiesByUserId(1));
    }


    /** Save to DB methods */

    void saveCountriesToDB(List<Country> countries){
        ehrMobileDatabase.countryDao().insertCountries(countries);

        System.out.println("countries from DBBBBBBBBBBBBBB"+ehrMobileDatabase.countryDao().getAllCountries());
    }

    void saveMaritalStatesToDB(List<MaritalState> maritalStates){

        ehrMobileDatabase.maritalStateDao().insertMaritalStates(maritalStates);

        System.out.println("marital states from DB #################"+ehrMobileDatabase.maritalStateDao().getAllMaritalStates());
    }

}
