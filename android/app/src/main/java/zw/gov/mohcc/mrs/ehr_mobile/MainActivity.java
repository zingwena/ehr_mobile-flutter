package zw.gov.mohcc.mrs.ehr_mobile;

import android.os.Bundle;

import androidx.sqlite.db.SimpleSQLiteQuery;

import com.google.gson.Gson;

import java.io.IOException;
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
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.apolloClient.PatientsApolloClient;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientDto;

import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;
import zw.gov.mohcc.mrs.ehr_mobile.model.ReasonForNotIssuingResult;

import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;

import zw.gov.mohcc.mrs.ehr_mobile.model.Purpose_Of_Tests;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw.PatientQuery;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;
import zw.gov.mohcc.mrs.ehr_mobile.util.LoginValidator;

import zw.gov.mohcc.mrs.ehr_mobile.vitals.VitalsEntity;

public class MainActivity extends FlutterActivity {

    final static String CHANNEL = "Authentication";
    final static String DATACHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/dataChannel";

    final static  String PATIENTCHANNEL= "zw.gov.mohcc.mrs.ehr_mobile/addPatient";



    private final static String PATIENT_CHANNEL = "ehr_mobile.channel/patient";

    public Token token;
    public String url, username, password;
    EhrMobileDatabase ehrMobileDatabase;
    int statusCode;
    List<User> userList;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        ehrMobileDatabase = EhrMobileDatabase.getDatabaseInstance(getApplication());

        new MethodChannel(getFlutterView(), PATIENTCHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {

            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                Gson gson = new Gson();
                if(methodCall.method.equals("registerPatient")){
                    String args = methodCall.arguments();

                    System.out.println(args);
                    PatientDto patientDto = gson.fromJson(args,PatientDto.class);

                    Patient patient= new Patient(patientDto.getFirstName(),patientDto.getLastName(),patientDto.getNationalId());
                    ehrMobileDatabase.patientDao().createPatient(patient);
                    System.out.println("==================-=-=-=-=-fromDB "+ehrMobileDatabase.patientDao().listPatients());
                }
            }
        });

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, final MethodChannel.Result result) {
                if (methodCall.method.equals("DataSync")) {

                    ArrayList args = methodCall.arguments();
                    url = args.get(0).toString();
                    username = args.get(1).toString();
                    password = args.get(2).toString();
                    final Login login = new Login(username, password);

                    Retrofit retrofitInstance = RetrofitClient.getRetrofitInstance(url + "/api/");


                    DataSyncService dataSyncService = retrofitInstance.create(DataSyncService.class);

                    Call<Token> call = dataSyncService.dataSync(login);
//                    try {
//                        statusCode=call.execute().code();
//                       Boolean isValid= LoginValidator.isValid(statusCode);
//                    } catch (IOException e) {
//                        e.printStackTrace();
//                    }

                    call.enqueue(new Callback<Token>() {
                        @Override
                        public void onResponse(Call<Token> call, Response<Token> response) {

                            if (response.isSuccessful()) {
                                Token token = response.body();
                                getNationalities(token, url + "/api/");
                                getFacilities(token, url + "/api/");
                                getCountries(token, url + "/api/");
                                getOccupation(token, url + "/api/");
                                getCountries(token, url + "/api/");
                                getMaritalStates(token, url + "/api/");
                                getEducationLevels(token, url + "/api/");
                                getReligion(token, url + "/api/");
                                getPatients(url);
                                getEntryPoints(token, url + "/api/");
                                getHtsModels(token, url + "/api/");
                                geReasonForNotIssuingResults(token, url + "/api/");
                                getReligion(token, url + "/api/");
                                System.out.println("==========-=-=-=-=-PATIENTS=-=-=-=-===============" + ehrMobileDatabase.patientDao().listPatients().toString());
                                result.success("Welcome "+login.getUsername());

                            } else {
                                statusCode = response.code();
                                result.success("Username or password are invalid.");
                                System.out.println("statussssssssssssssss" + statusCode);


                            }


                        }

                        @Override
                        public void onFailure(Call<Token> call, Throwable t) {
                            result.success("Network Error. Either invalid Server Ip address or you are of of range.");

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
                        if (methodCall.method.equals("religionOptions")) {
                            try {
                                List<Religion> religions = ehrMobileDatabase.religionDao().getAllReligions();

                                String religionList = gson.toJson(religions);
                                result.success(religionList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("countryOptions")) {
                            try {
                                List<Country> countries = ehrMobileDatabase.countryDao().getAllCountries();
                                System.out.println("*************************** native" + countries);
                                String countryList = gson.toJson(countries);
                                result.success(countryList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("occupationOptions")) {
                            try {
                                List<Occupation> occupations = ehrMobileDatabase.occupationDao().getAllOccupations();
                                String occupationList = gson.toJson(occupations);
                                result.success(occupationList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("educationLevelOptions")) {
                            try {
                                List<EducationLevel> educationLevels = ehrMobileDatabase.educationLevelDao().getEducationLevels();
                                String educationLevelList = gson.toJson(educationLevels);
                                result.success(educationLevelList);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall.method.equals("nationalityOptions")) {
                            try {
                                List<Nationality> nationalities = ehrMobileDatabase.nationalityDao().selectAllNationalities();
                                String nationalityList = gson.toJson(nationalities);
                                result.success(nationalityList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall.method.equals("maritalStatusOptions")) {
                            try {
                                List<MaritalStatus> maritalStatuses = ehrMobileDatabase.maritalStateDao().getAllMaritalStates();
                                String maritalStatusList = gson.toJson(maritalStatuses);
                                result.success(maritalStatusList);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }
                    }
                }
        );


        new MethodChannel(getFlutterView(), PATIENT_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
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

    // pull patients from EHR

    private void getPatients(String baseUrl) {
        ehrMobileDatabase.patientDao().deleteAll();
        PatientsApolloClient.getPatientsFromEhr(ehrMobileDatabase, baseUrl);

    }

    public void getMaritalStates(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getMaritalStates("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<MaritalStatus> maritalStatusList = new ArrayList<MaritalStatus>();
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
                List<Occupation> occupationList = new ArrayList<Occupation>();
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
                List<Facility> facilityList = new ArrayList<Facility>();
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
                List<Nationality> nationalities = new ArrayList<Nationality>();

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

        Call<TerminologyModel> call = service.getCountries("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Country> countries = new ArrayList<Country>();
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

    //Phineas
    public void getEducationLevels(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getEducationLevels("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<EducationLevel> educationLevels = new ArrayList<EducationLevel>();

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


    public void getEntryPoints(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getEntryPoints("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<EntryPoint> entryPointList = new ArrayList<EntryPoint>();
                for (BaseNameModel item : response.body().getContent()) {
                    entryPointList.add(new EntryPoint(item.getCode(), item.getName()));
                }
                if (entryPointList != null && !entryPointList.isEmpty()) {

                    saveEntryPointsToDB(entryPointList);
                }


            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }

    public void getHtsModels(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getHtsModels("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<HtsModel> htsModelList = new ArrayList<HtsModel>();
                for (BaseNameModel item : response.body().getContent()) {
                    htsModelList.add(new HtsModel(item.getCode(), item.getName()));
                }
                if (htsModelList != null && !htsModelList.isEmpty()) {

                    saveHtsModelToDB(htsModelList);
                }


            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }


    public void getPurpose_Of_Tests(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getHtsModels("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Purpose_Of_Tests> purpose_of_testsList = new ArrayList<Purpose_Of_Tests>();
                for (BaseNameModel item : response.body().getContent()) {
                    purpose_of_testsList.add(new Purpose_Of_Tests(item.getCode(), item.getName()));
                }
                if (purpose_of_testsList != null && !purpose_of_testsList.isEmpty()) {

                    savePurpose_Of_TestsToDB(purpose_of_testsList);
                }


            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }

    public void geReasonForNotIssuingResults(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.geReasonForNotIssuingResults("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<ReasonForNotIssuingResult> reasonForNotIssuingResultList = new ArrayList<ReasonForNotIssuingResult>();
                for (BaseNameModel item : response.body().getContent()) {
                    reasonForNotIssuingResultList.add(new ReasonForNotIssuingResult(item.getCode(), item.getName()));
                }
                if (reasonForNotIssuingResultList != null && !reasonForNotIssuingResultList.isEmpty()) {

                    saveReasonForNotIssuingResultToDB(reasonForNotIssuingResultList);
                }


            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

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
        List<Authorities> authorities = new ArrayList<Authorities>();

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
//        ehrMobileDatabase.permissionsDao().insertPermissions();
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
        ehrMobileDatabase.facilityDao().deleteAllFacilities();
        ehrMobileDatabase.facilityDao().insertFacilities(facilities);

        System.out.println("facilities from DB #################" + ehrMobileDatabase.facilityDao().getAllFacilities());
    }


    public void getReligion(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getReligion("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Religion> religionList = new ArrayList<Religion>();
                for (BaseNameModel item : response.body().getContent()) {
                    religionList.add(new Religion(String.valueOf(item.getCode()), item.getName()));
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

    void saveEntryPointsToDB(List<EntryPoint> entryPoints) {


        System.out.println("*****************   " + ehrMobileDatabase);
        ehrMobileDatabase.entryPointDao().deleteEntryPoints();
        ehrMobileDatabase.entryPointDao().insertEntryPoints(entryPoints);
        System.out.println("EntryPoint from DB *****" + ehrMobileDatabase.entryPointDao().getAllEntryPoints());

    }

    void saveHtsModelToDB(List<HtsModel> htsModels) {


        System.out.println("*****************   " + ehrMobileDatabase);
        ehrMobileDatabase.htsModelDao().deleteHtsModels();
        ehrMobileDatabase.htsModelDao().insertHtsModels(htsModels);
        System.out.println("HtsModels from DB *****" + ehrMobileDatabase.htsModelDao().getAllHtsModels());

    }

    void savePurpose_Of_TestsToDB(List<Purpose_Of_Tests> purpose_of_tests) {


        System.out.println("*****************   " + ehrMobileDatabase);
        ehrMobileDatabase.purpose_of_testsDao().deletePurpose_Of_Tests();
        ehrMobileDatabase.purpose_of_testsDao().insertPurpose_Of_Tests(purpose_of_tests);
        System.out.println("Purpose of tests from DB *****" + ehrMobileDatabase.purpose_of_testsDao().getAllPurpose_Of_Tests());

    }

    void saveReasonForNotIssuingResultToDB(List<ReasonForNotIssuingResult> reasonForNotIssuingResults) {


        System.out.println("*****************   " + ehrMobileDatabase);
        ehrMobileDatabase.reasonForNotIssuingResultDao().deleteReasonForNotIssuingResults();
        ehrMobileDatabase.reasonForNotIssuingResultDao().insertReasonForNotIssuingResults(reasonForNotIssuingResults);
        System.out.println("ReasonForNotIssuingResults from DB *****" + ehrMobileDatabase.reasonForNotIssuingResultDao().getAllReasonForNotIssuingResults());

    }
}

