package com.example.ehr_mobile;

import android.os.Bundle;
import android.util.Log;

import com.example.ehr_mobile.configuration.DataService;
import com.example.ehr_mobile.configuration.RetrofitClientInstance;
import com.example.ehr_mobile.model.Authorities;
import com.example.ehr_mobile.model.Country;
import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.MaritalState;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.model.User;
import com.example.ehr_mobile.persistance.database.EhrMobileDatabase;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;


import java.util.ArrayList;
import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainActivity extends FlutterActivity {

  public List<User> userList;


  public Token token;
     EhrMobileDatabase ehrMobileDatabase;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Login login= new Login("admin", "admin");

    authenticate(login);

    ehrMobileDatabase= EhrMobileDatabase.getInstance(getApplication());

     // System.out.println("***************** Users"+ ehrMobileDatabase.userDao().selectAllUsers());

  }


  public  Token authenticate(Login login){
    System.out.println("/////////////in authenticate");

    DataService service= RetrofitClientInstance.getRetrofit().create(DataService.class);
    Call<Token> call= service.getToken(login);

    call.enqueue(new Callback<Token>() {
      @Override
      public void onResponse(Call<Token> call, Response<Token> response) {

        if (response.isSuccessful()) {
          token=response.body();
          System.out.println("ttttttttttttttttttokkkkken=============="+token);
          getUsers(token);
          getMatitalStates(token);
          getCountries(token);
        }

      }
      @Override
      public void onFailure(Call<Token> call, Throwable t) {

      }
    });

    return token;
  }

  public void getUsers(Token token){
    DataService service= RetrofitClientInstance.getRetrofit().create(DataService.class);
    Call<List<User>> call= service.getAllUsers("Bearer "+ token.getId_token() );

    call.enqueue(new Callback<List<User>>() {
      @Override
      public void onResponse(Call<List<User>> call, Response<List<User>> response) {

        userList=response.body();

        System.out.println("user instance&&&&&&&&&&&&&&&&&&"+userList);

        saveUsersToDB(userList);

      }

      @Override
      public void onFailure(Call<List<User>> call, Throwable t) {
        System.out.println("-------------------"+ t.getMessage());
      }
    });
  }

  public void getMatitalStates(Token token){

    DataService service= RetrofitClientInstance.getRetrofit().create(DataService.class);
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

  void saveUsersToDB(List<User> userList){

    ehrMobileDatabase.userDao().insertUsers(userList);
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

  public void getCountries(Token token){
    System.out.println("[[[[[[[[[[[[[[[[[[[[running first");

    DataService service= RetrofitClientInstance.getRetrofit().create(DataService.class);
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

  void saveCountriesToDB(List<Country> countries){
    ehrMobileDatabase.countryDao().insertCountries(countries);

    System.out.println("countries from DBBBBBBBBBBBBBB"+ehrMobileDatabase.countryDao().getAllCountries());
  }

  void saveMaritalStatesToDB(List<MaritalState> maritalStates){

    ehrMobileDatabase.maritalStateDao().insertMaritalStates(maritalStates);

    System.out.println("marital states from DB #################"+ehrMobileDatabase.maritalStateDao().getAllMaritalStates());
  }
}
