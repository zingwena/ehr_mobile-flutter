package zw.gov.mohcc.mrs.ehr_mobile;

import android.os.Bundle;
import android.util.Log;


import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;

import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;

import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;

import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.util.ArrayList;
import java.util.List;

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


    public Token token;
    public String url, username, password;
    EhrMobileDatabase ehrMobileDatabase;
    List<User> userList;

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
                            getNationalities(token, url + "/api/");

                            getCountries(token, url + "/api/");
                            getOccupation(token, url + "/api/");

                            getCountries(token, url + "/api/");
                            getMaritalStates(token, url + "/api/");
                           /* getUsers(token, url + "/api/");
                             getFacilities(token, url + "/api/");
                            getOccupation(token, url + "/api/");*/

                            getReligion(token, url + "/api/");
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
        Call<TerminologyModel> call = service.getMaritalStates("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<MaritalStatus> maritalStatusList = new ArrayList<>();
                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        maritalStatusList.add(new MaritalStatus(item.getCode(), item.getName()));
                    }
                    if (maritalStatusList != null && !maritalStatusList.isEmpty()) {
                        saveMaritalStatesToDB(maritalStatusList);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });

                    /*
                    TODO brian refactor this part
                    maritalStatesJson.forEach(maritalState ->
                            maritalStates.add(new MaritalStatus(maritalState.getAsJsonObject().get("code").toString(), maritalState.getAsJsonObject().get("name").toString()))
                    );

                    saveMaritalStatesToDB(maritalStates);*/


    }

    public void getOccupation(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getOccupation("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Occupation> occupationList = new ArrayList<>();
                for (BaseNameModel item : response.body().getContent()) {
                    occupationList.add(new Occupation(item.getCode(), item.getName()));
                }
                if (occupationList != null && !occupationList.isEmpty()) {

                    saveOccupationsToDB(occupationList);
                }


            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }


    public void getUsers(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<List<User>> call = service.getAllUsers("Bearer " + token.getId_token());

        call.enqueue(new Callback<List<User>>() {
            @Override
            public void onResponse(Call<List<User>> call, Response<List<User>> response) {


                userList = response.body();

                System.out.println("user instance&&&&&&&&&&&&&&&&&&" + userList);

                saveUsersToDB(userList);


            }

            @Override
            public void onFailure(Call<List<User>> call, Throwable t) {
                System.out.println("-------------------" + t.getMessage());
            }
        });
    }

    //liberty
    public void getFacilities(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
     Call<TerminologyModel> call = service.getFacilities("Bearer" + token.getId_token());
     call.enqueue(new Callback<TerminologyModel>() {
         @Override
         public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
             List<Facility> facilities = new ArrayList<>();
             if(response.isSuccessful()){
                 for(BaseNameModel item : response.body().getContent()){
                     facilities.add(new Facility(item.getCode(), item.getName()));
                 }
                 if (facilities != null && !facilities.isEmpty()) {

                 }

             }
         }

         @Override
         public void onFailure(Call<TerminologyModel> call, Throwable t) {

         }
     });
    }


    //tino
    public void getNationalities(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getNationalities("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Nationality> nationalities = new ArrayList<>();

                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        nationalities.add(new Nationality(item.getCode(), item.getName()));
                    }

                    if (nationalities != null && !nationalities.isEmpty()) {
                        saveNationalityToDB(nationalities);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }


    public void getCountries(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getNationalities("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Country> countries = new ArrayList<>();

                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        countries.add(new Country(item.getCode(), item.getName()));
                    }

                    if (countries != null && !countries.isEmpty()) {
                        saveCountriesToDB(countries);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });

    }

    void saveUsersToDB(List<User> userListInstance) {

        /*ehrMobileDatabase.userDao().insertUsers(userListInstance);
        List<User> usersFromDB = ehrMobileDatabase.userDao().selectAllUsers();
        System.out.println("froooooooooooooooom DB" + usersFromDB);
        saveAuthorities(usersFromDB);
        System.out.println("user by iiiiiidd%%%%%%%%%%%%%%%%%%" + ehrMobileDatabase.userDao().findUserByid(1));*/

    }

    void saveAuthorities(List<User> usersFromDB) {
        List<Authorities> authorities = new ArrayList<>();

        /*
        TODO brian refactor this part
        usersFromDB.forEach(user ->

                userList.forEach(user1 ->
                        user1.getAuthorities().forEach(authority ->
                                authorities.add(new Authorities(user.getUserId(), authority)))
                )

        );
        ehrMobileDatabase.authoritiesDao().insertAuthorities(authorities);
*/
        System.out.println("froooooooooooooom DB=================" + ehrMobileDatabase.authoritiesDao().getAllAuthorities());
        //ehrMobileDatabase.permissionsDao().insertPermissions();
        testById(1);


    }

    void testById(int id) {
        System.out.println("get by id --------------" + ehrMobileDatabase.authoritiesDao().findAuthoritiesByUserId(1));
    }


    /**
     * Save to DB methods
     */

    void saveCountriesToDB(List<Country> countries) {
        ehrMobileDatabase = EhrMobileDatabase.getInstance(getApplication());
        ehrMobileDatabase.countryDao().insertCountries(countries);

        System.out.println("countries from DBBBBBBBBBBBBBB" + ehrMobileDatabase.countryDao().getAllCountries());
    }

    void saveMaritalStatesToDB(List<MaritalStatus> maritalStatuses) {
        ehrMobileDatabase = EhrMobileDatabase.getInstance(getApplication());
        ehrMobileDatabase.maritalStateDao().insertMaritalStates(maritalStatuses);

        System.out.println("marital states from DB #################" + ehrMobileDatabase.maritalStateDao().getAllMaritalStates());
    }


    public void getReligion(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getReligion("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Religion> religionList = new ArrayList<>();
                for (BaseNameModel item : response.body().getContent()) {
                    religionList.add(new Religion(item.getCode(), item.getName()));
                }
                if (religionList != null && !religionList.isEmpty()) {
                    saveReligionToDB(religionList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);
            }
        });
    }

    void saveReligionToDB(List<Religion> religions) {

        ehrMobileDatabase = EhrMobileDatabase.getInstance(getApplication());

        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    " + ehrMobileDatabase);

        ehrMobileDatabase.religionDao().insertReligions(religions);

        System.out.println("marital states from DB #################" + ehrMobileDatabase.religionDao().getAllReligions());
    }


    void saveOccupationsToDB(List<Occupation> occupations) {


        ehrMobileDatabase = EhrMobileDatabase.getInstance(getApplication());
        System.out.println("*****************   " + ehrMobileDatabase);
        ehrMobileDatabase.occupationDao().insertOccupations(occupations);
        System.out.println("occupations from DB *****" + ehrMobileDatabase.occupationDao().getAllOccupations());

    }
    void saveNationalityToDB(List<Nationality> nationalityList) {

        ehrMobileDatabase = EhrMobileDatabase.getInstance(getApplication());

        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    " + ehrMobileDatabase);

        ehrMobileDatabase.nationalityDao().insertNationalities(nationalityList);

        System.out.println("nationality from DB #################" + ehrMobileDatabase.nationalityDao().selectAllNationalities());


    }



}