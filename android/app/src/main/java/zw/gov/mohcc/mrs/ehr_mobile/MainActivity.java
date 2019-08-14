package zw.gov.mohcc.mrs.ehr_mobile;

import android.os.Bundle;
import android.util.Log;

import androidx.sqlite.db.SimpleSQLiteQuery;


import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.Education;
import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;

import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;

import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;

import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.Login;

import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw.PatientQuery;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;

import com.google.gson.Gson;

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
    private final static String PATIENT_CHANNEL = "ehr_mobile.channel.patient";

    final static String DATACHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/dataChannel";


    public Token token;
    public String url, username, password;
    EhrMobileDatabase ehrMobileDatabase;
    List<User> userList;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        ehrMobileDatabase = EhrMobileDatabase.getDatabaseInstance(getApplication());





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
                            getFacilities(token, url + "/api/");
                            getCountries(token, url + "/api/");
                            getOccupation(token, url + "/api/");


                            getMaritalStates(token, url + "/api/");
                            getEducationLevels(token,url+"/api/");



                           /* getUsers(token, url + "/api/");
                            getCountries(token, url + "/api/");
                            getOccupation(token, url + "/api/");*/
                           getReligion(token, url + "/api/");
                       /*     System.out.println("%%%%%%%%%%%%%" + token);*/

                        }

                        @Override
                        public void onFailure(Call<Token> call, Throwable t) {
                            System.out.println("Error=============== " + t);
                        }
                    });
                }
            }
        });

        new MethodChannel(getFlutterView(), DATACHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        Gson gson = new Gson();
                        if(methodCall.method.equals("religionOptions")){
                            try {
                                List<Religion> religions = ehrMobileDatabase.religionDao().getAllReligions();

                                String religionList = gson.toJson(religions);
                                result.success(religionList);
                            }catch(Exception e){
                                System.out.println("something went wrong "+ e.getMessage());
                            }
                        }
                        if(methodCall.method.equals("countryOptions")){
                            try {
                                List<Country> countries = ehrMobileDatabase.countryDao().getAllCountries();
                                System.out.println("*************************** native"+ countries);
                                String countryList = gson.toJson(countries);
                                result.success(countryList);
                            }catch (Exception e){
                                System.out.println("something went wrong "+ e.getMessage());
                            }
                        }
                        if(methodCall.method.equals("occupationOptions")){
                            try {
                                List<Occupation> occupations = ehrMobileDatabase.occupationDao().getAllOccupations();
                                String occupationList = gson.toJson(occupations);
                                result.success(occupationList);
                            }catch (Exception e){
                                System.out.println("something went wrong "+ e.getMessage());
                            }
                        }

                        if(methodCall.method.equals("educationLevelOptions")){
                          try{
                              List<EducationLevel> educationLevels= ehrMobileDatabase.educationLevelDao().getEducationLevels();
                              String educationLevelList= gson.toJson(educationLevels);
                              result.success(educationLevelList);

                          }catch (Exception e){
                              System.out.println("something went wrong "+ e.getMessage());

                          }
                        }

                        if(methodCall.method.equals("nationalityOptions")){
                          try{
                            List<Nationality> nationalities=ehrMobileDatabase.nationalityDao().selectAllNationalities();
                            String nationalityList=gson.toJson(nationalities);
                            result.success(nationalityList);
                          }catch(Exception e){
                              System.out.println("something went wrong "+ e.getMessage());

                          }
                        }

                        if(methodCall.method.equals("maritalStatusOptions")){
                         try{
                             List<MaritalStatus> maritalStatuses= ehrMobileDatabase.maritalStateDao().getAllMaritalStates();
                             String maritalStatusList= gson.toJson(maritalStatuses);
                             result.success(maritalStatusList);

                         }catch(Exception e){
                             System.out.println("something went wrong "+ e.getMessage());

                         }
                        }
                    }
                }
        );


        new MethodChannel(getFlutterView(),PATIENT_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                final String arguments = methodCall.arguments();
                if (methodCall.method.equals("searchPatient")) {
                    List<Patient> _list;

                    String searchItem = arguments;

                    PatientQuery patientQuery = new PatientQuery();
                    SimpleSQLiteQuery sqLiteQuery = patientQuery.searchPatient(searchItem);
                    _list = ehrMobileDatabase.patientDao().searchPatient(sqLiteQuery);
                    Gson gson = new Gson();



                    result.success(gson.toJson(_list));

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
        Call<TerminologyModel> call = service.getFacilities("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Facility> facilityList = new ArrayList<>();
                for (BaseNameModel item : response.body().getContent()) {
                    facilityList.add(new Facility(item.getCode(), item.getName()));
                }
                if (facilityList != null && !facilityList.isEmpty()) {

                    saveFacilityToDB(facilityList);
                }


            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("facility tttttttttttttttttttttttt" + t);

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
        System.out.println("[[[[[[[[[[[[[[[[[[[[running first");


        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
       Call<TerminologyModel> call = service.getCountries("Bearer " + token.getId_token());
       call.enqueue(new Callback<TerminologyModel>() {
           @Override
           public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
               List<Country> countries= new ArrayList<>();
               if(response.isSuccessful()){
                   for(BaseNameModel item: response.body().getContent()){
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

    //Phineas
    public void getEducationLevels(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getEducationLevels("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<EducationLevel> educationLevels = new ArrayList<>();

                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        educationLevels.add(new EducationLevel(item.getCode(), item.getName()));
                    }

                    if (educationLevels != null && !educationLevels.isEmpty()) {
                        saveEducationLevelToDB(educationLevels);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }


 /*   public void getEducationList(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getEducationList("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Education> educationList = new ArrayList<>();

                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        educationList.add(new Education(item.getCode(), item.getName()));
                    }

                    if (educationList != null && !educationList.isEmpty()) {
                        saveEducationToDB(educationList);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }*/



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

        ehrMobileDatabase.countryDao().deleteCountries();

        ehrMobileDatabase.countryDao().insertCountries(countries);


        System.out.println("countries from DBBBBBBBBBBBBBB" + ehrMobileDatabase.countryDao().getAllCountries());
    }

    void saveMaritalStatesToDB(List<MaritalStatus> maritalStatuses) {


        ehrMobileDatabase.maritalStateDao().deleteMaritalStatuses();
        ehrMobileDatabase.maritalStateDao().insertMaritalStates(maritalStatuses);

        System.out.println("marital states from DB #################" + ehrMobileDatabase.maritalStateDao().getAllMaritalStates());
    }
    void saveFacilityToDB(List<Facility> facilities) {

        ehrMobileDatabase.facilityDao().insertFacilities(facilities);

        System.out.println("facilities from DB #################" + ehrMobileDatabase.facilityDao().getAllFacilities());
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


        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    " + ehrMobileDatabase);
        ehrMobileDatabase.religionDao().deleteReligions();
        ehrMobileDatabase.religionDao().insertReligions(religions);

        System.out.println("marital states from DB #################" + ehrMobileDatabase.religionDao().getAllReligions());
    }


    void saveOccupationsToDB(List<Occupation> occupations) {
        for (Occupation occupation : occupations) {
            System.out.println("occupation = " + occupation);
        }


        System.out.println("*****************   " + ehrMobileDatabase);
        ehrMobileDatabase.occupationDao().deleteOccupations();
        ehrMobileDatabase.occupationDao().insertOccupations(occupations);
        System.out.println("occupations from DB *****" + ehrMobileDatabase.occupationDao().getAllOccupations());

    }
    void saveNationalityToDB(List<Nationality> nationalityList) {



        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    " + ehrMobileDatabase);
         ehrMobileDatabase.nationalityDao().deleteNationalities();
        ehrMobileDatabase.nationalityDao().insertNationalities(nationalityList);

        System.out.println("nationality from DB #################" + ehrMobileDatabase.nationalityDao().selectAllNationalities());


    }

    void saveEducationLevelToDB(List<EducationLevel> educationLevels) {



        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    " + ehrMobileDatabase);
         ehrMobileDatabase.educationLevelDao().deleteEducationLevels();
        ehrMobileDatabase.educationLevelDao().insertEducationLevels(educationLevels);

        System.out.println("education Level from DB #################" + ehrMobileDatabase.educationLevelDao().getEducationLevels());


    }


//    void saveEducationToDB(List<Education> educationList) {
//
//
//
//        System.out.println("?????????????????    " + ehrMobileDatabase);
//
//        ehrMobileDatabase.educationDao().insertEducationList(educationList);
//
//        System.out.println("education from DB +++++++++++++++++ :" + ehrMobileDatabase.educationDao().getEducationList());
//
//
//    }



}